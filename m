Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6754632295
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiKUMoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKUMoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:44:12 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AEF3BF838;
        Mon, 21 Nov 2022 04:44:11 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,181,1665414000"; 
   d="scan'208";a="140756684"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2022 21:44:09 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 56F4349236FB;
        Mon, 21 Nov 2022 21:44:09 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 3/9] PCI: Add PCI_EXP_LNKCAP_MLW macros
Date:   Mon, 21 Nov 2022 21:43:54 +0900
Message-Id: <20221121124400.1282768-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add macros defining Maximum Link Width bits in Link Capabilities
Register.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/pci_regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 1c3591c8e09e..31216c6a07ad 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -538,6 +538,12 @@
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
+#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
+#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
+#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
+#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
+#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 */
+#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
-- 
2.25.1

