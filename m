Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEF61953E9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgC0J1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 05:27:09 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:56565 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbgC0J1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 05:27:09 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 05:27:07 EDT
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:56 +0800
Received: from raymond-pc.zhaoxin.com (10.29.28.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:55 +0800
From:   Raymond Pang <RaymondPang-oc@zhaoxin.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <TonyWWang-oc@zhaoxin.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add ACS quirk for Zhaoxin
Date:   Fri, 27 Mar 2020 17:11:45 +0800
Message-ID: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.28.62]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lots of Zhaoxin PCIe components have no ACS Capability Structure,
but do have ACS-like capability which ensures DMA isolation.
This patch makes isolated devices could be directly assigned to
different VMs through IOMMU.

Raymond Pang (3):
  PCI: Add Zhaoxin Vendor ID
  PCI: Add ACS quirk for Zhaoxin's multi-function devices
  PCI: Add ACS quirk for Root/Downstream Ports

 drivers/pci/quirks.c    | 30 ++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 32 insertions(+)

-- 
2.26.0

