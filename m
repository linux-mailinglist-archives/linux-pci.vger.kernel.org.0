Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C70815BDDB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 12:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgBMLkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Feb 2020 06:40:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729544AbgBMLkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Feb 2020 06:40:40 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6558DA1FB160B780FFFE;
        Thu, 13 Feb 2020 19:40:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 13 Feb 2020 19:40:31 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH v3 1/9] PCI: add 32 GT/s decoding in some macros
Date:   Thu, 13 Feb 2020 19:36:25 +0800
Message-ID: <1581593793-23589-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
References: <1581593793-23589-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Link speed 32.0 GT/s is supported in PCIe r5.0. Add in macro
PCIE_SPEED2STR and PCIE_SPEED2MBS_ENC to correctly decode.
This patch is a complementary to
commit de76cda215d5 ("PCI: Decode PCIe 32 GT/s link speed").

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/pci/pci.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6394e77..f65912e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -294,7 +294,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information */
 #define PCIE_SPEED2STR(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
+	((speed) == PCIE_SPEED_32_0GT ? "32 GT/s" : \
+	 (speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
 	 (speed) == PCIE_SPEED_8_0GT ? "8 GT/s" : \
 	 (speed) == PCIE_SPEED_5_0GT ? "5 GT/s" : \
 	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
@@ -302,7 +303,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe speed to Mb/s reduced by encoding overhead */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
+	((speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
+	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
 	 (speed) == PCIE_SPEED_5_0GT  ?  5000*8/10 : \
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
-- 
2.8.1

