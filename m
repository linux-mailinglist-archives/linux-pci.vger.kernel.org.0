Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31E13BBFF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAOJIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 04:08:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729336AbgAOJIW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:22 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4CE86FD879E39616E77B;
        Wed, 15 Jan 2020 17:08:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:08:10 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>
Subject: [PATCH 3/6] PCI: Add comments for link speed info arrays
Date:   Wed, 15 Jan 2020 17:04:20 +0800
Message-ID: <1579079063-5668-4-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
References: <1579079063-5668-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add comments for pcix_bus_speed[] and pcie_link_speed[] arrays.
Indicating the capabilities which the information from.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/probe.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3c70b87..27e5e1e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -640,6 +640,10 @@ void pci_free_host_bridge(struct pci_host_bridge *bridge)
 }
 EXPORT_SYMBOL(pci_free_host_bridge);
 
+/**
+ * these indices represent secondary bus mode and
+ * frequency from  PCI_X_SSTATUS_FREQ
+ **/
 static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCI_SPEED_66MHz_PCIX,		/* 1 */
@@ -659,6 +663,10 @@ static const unsigned char pcix_bus_speed[] = {
 	PCI_SPEED_133MHz_PCIX_533	/* F */
 };
 
+/**
+ * these indices represent PCIe link speed from
+ * PCI_EXP_LNKCAP, PCI_EXP_LNKSTA, PCI_EXP_LNKCAP2
+ **/
 const unsigned char pcie_link_speed[] = {
 	PCI_SPEED_UNKNOWN,		/* 0 */
 	PCIE_SPEED_2_5GT,		/* 1 */
-- 
2.8.1

