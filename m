Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF7C154287
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 12:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBFLDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 06:03:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726925AbgBFLDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 06:03:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A87253EF854C263B2C13;
        Thu,  6 Feb 2020 19:03:22 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 19:03:15 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v2 2/6] PCI: Add comments for link speed info arrays
Date:   Thu, 6 Feb 2020 18:59:16 +0800
Message-ID: <1580986760-10182-3-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
References: <1580986760-10182-1-git-send-email-yangyicong@hisilicon.com>
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
index 6ce47d8..84b012f 100644
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

