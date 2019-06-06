Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857D636D07
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 09:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfFFHJu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 03:09:50 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:25138 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFHJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 03:09:50 -0400
Received-SPF: SoftFail (esa6.microchip.iphmx.com: domain of
  kelvin.cao@microchip.com is inclined to not designate
  208.19.100.22 as permitted sender) identity=mailfrom;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="kelvin.cao@microchip.com";
  x-sender="kelvin.cao@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@smtp.microsemi.com) identity=helo;
  client-ip=208.19.100.22; receiver=esa6.microchip.iphmx.com;
  envelope-from="kelvin.cao@microchip.com";
  x-sender="postmaster@smtp.microsemi.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=kelvin.cao@microchip.com; spf=None smtp.helo=postmaster@smtp.microsemi.com; dmarc=fail (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,558,1557212400"; 
   d="scan'208";a="33318213"
Received: from unknown (HELO smtp.microsemi.com) ([208.19.100.22])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 00:09:49 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX2.microsemi.net
 (10.100.34.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:48 -0700
Received: from AVMBX3.microsemi.net (10.100.34.33) by AVMBX3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Jun 2019
 00:09:48 -0700
Received: from NTB-Peer.microsemi.net (10.188.116.183) by avmbx3.microsemi.net
 (10.100.34.33) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Jun 2019 00:09:45 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <kurt.schwemmer@microsemi.com>, <logang@deltatee.com>,
        <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-ntb@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <kelvincao@outlook.com>
Subject: [PATCH 0/3] Redundant steps removal and bug fix of ntb_hw_switchtec
Date:   Thu, 6 Jun 2019 15:09:41 +0800
Message-ID: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Everyone,

This patch series remove redundant steps and fix one bug of the 
ntb_hw_switchtec module.

When a re-initialization is caused by a link event, the driver will
re-setup the shared memory windows. But at that time, the shared memory
is still valid, and it's unnecessary to free, reallocate and then
initialize it again. Remove these redundant steps.

In case of NTB crosslink topology, the setting of shared memory window
in the virtual partition doesn't reset on peer's reboot. So skip the
re-setup of shared memory window for that case.

Switchtec does not support setting multiple MWs simultaneously. However,
there's a race condition when a re-initialization is caused by a link 
event, the driver will re-setup the shared memory window asynchronously
and this races with the client setting up its memory windows on the 
link up event. Fix this by ensure do the entire initialization in a work
queue and signal the client once it's done. 

Regard,
Kelvin

--

Changed since v1:
  - It's a second resend of v1

--

Joey Zhang (2):
  ntb_hw_switchtec: Remove redundant steps of
    switchtec_ntb_reinit_peer() function
  ntb_hw_switchtec: Fix setup MW with failure bug

Wesley Sheng (1):
  ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
    for crosslink case

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 80 +++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 31 deletions(-)

-- 
2.7.4

