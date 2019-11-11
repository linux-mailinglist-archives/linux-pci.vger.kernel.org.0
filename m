Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC960F792E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 17:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKKQxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 11:53:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:29003 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfKKQxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 11:53:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="193989221"
Received: from jderrick-mobl.amr.corp.intel.com ([10.232.115.143])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2019 08:53:09 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 0/2] VMD support for 8086:9A0B
Date:   Mon, 11 Nov 2019 09:53:00 -0700
Message-Id: <20191111165302.29636-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This set adds VMD support for device 8086:9A0B. The first patch adds
another bus range restriction and the second adds the device id.

Jon Derrick (2):
  PCI: vmd: Add bus 224-255 restriction decode
  PCI: vmd: Add device id for VMD device 8086:9A0B

 drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++--------
 include/linux/pci_ids.h      |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

-- 
1.8.3.1

