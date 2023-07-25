Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60ED760A0F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 08:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGYGKU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 02:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGYGKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 02:10:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF810D8;
        Mon, 24 Jul 2023 23:10:18 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C8C8C5C01BF;
        Tue, 25 Jul 2023 02:10:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 25 Jul 2023 02:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1690265417; x=1690351817; bh=XVe/S4d4l3
        ZrFD0RY++RohN/09M8z554Ik3uc6521IE=; b=bny2bd76+HC/dto8+hLYrZ+EVS
        51cXY+UJs2G5hq7+Jn9IG1837wpC0N6cpHD5BqLWalOtJFsAy7frR1uKaw5rw+pU
        9bufiyxrJ88g+JBgdIagMXaglvdw0N6pA9pe7FfBgiTSnOSrwYeXcSaHJNkh3yZ4
        T7SvOsBSbj5skB0zDSRT4tXb10PtpIfLMx+22YUR0ytq+OmdDIqOpHlFUjhXeDwZ
        61uqUsRLNddPsSgSOYm5N/tFc0mz6TsF6F9QSa+5FMtG7DSIztAtvCrYgyYEVYhj
        goKN3A6ladhBU/o0Fay6zehHVpoaURCvvUqlLlCL5WD9cIdHPc5n0Bjc28aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690265417; x=1690351817; bh=XVe/S4d4l3ZrF
        D0RY++RohN/09M8z554Ik3uc6521IE=; b=u7LhiSjArJDucsYBA23kV7V22xuTW
        DeuiX4nhPVCLkF1SSYc5RkDQEM0HOBt/vU1IQKAsly0b/RFnx+Ju4Keq4+hua2/O
        xNQ2NV3jWjBc48BT2+55J/Ugpagmli0vzDoBzWPZWQR9JCsaGlqitL+nuVlB/teD
        AQe6UAjgJsPWfGsR6fLkyqBjz+X1VUU3PK7cJhprsYs78I9m6OHrJn7jfrfik9rD
        qlIZ+6C/6pvao8KXpjZOUlzXpUdUyUdSVORPkB27h1vSTuIcc72JrBZM+yqhtX9/
        0Fez/dbJ9RdXvNRmQk6QRPtaOxGyv8Yj23QmGQ4Uh8DEbbHxB0I+oQGfA==
X-ME-Sender: <xms:SWe_ZO8_lujzLeRImrgWjDtIAPctHL3E7knIPjvwSw_7p6JFP_BPpA>
    <xme:SWe_ZOsOtH91qrxz4AdgOKs738W6DKhfJ2maiMiDdC2ugljrTxN2Ldc5FwCHFcXj4
    zV4LC3yI9F1hrPNz3s>
X-ME-Received: <xmr:SWe_ZEDUFafT_l9BbGioU3vXiO3GtADkPJd1fh2y3pwFDSD_OdI7LsvR3UOVir94KmpUnvyfFaVU8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheelgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuteekleeuudfgueethe
    dtuddthfdtleffgefhieehfeeigedvtdeuveetiedunecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:SWe_ZGdL4DC3IHfE8jzKSTKTLebzNJd0ExLN7s0V1YB8sGnAIlPTBw>
    <xmx:SWe_ZDNpdmRMLdLfzsvkzTnBK_e0NGsYr8a1Ywqt6oCxFfqmsGt7dw>
    <xmx:SWe_ZAk52d5sShrCmEnQncoguL5Xtoq3r6V9YW7g134xf3SPIm2mOQ>
    <xmx:SWe_ZPB-X358Vkd10_j41ghX-bE8CW94ilmn6CLNtzcT56YnfsOdYQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 02:10:14 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: [PATCH v2] pci: loongson: Workaround MIPS firmware MRRS settings
Date:   Tue, 25 Jul 2023 14:10:08 +0800
Message-Id: <20230725061008.1504292-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a partial revert of commit 8b3517f88ff2 ("PCI:
loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.

There are many MIPS based Loongson systems in wild that
shipped with firmware which does not set maximum MRRS properly.

Limiting MRRS to 256 for all as MIPS Loongson comes with higher
MRRS support is considered rare.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Rename quirk name to: loongson_old_mrrs_quirk
---
 drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index fe0f732f6e43..d0f68b102d10 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
 
+#ifdef CONFIG_MIPS
+static void loongson_old_mrrs_quirk(struct pci_dev *pdev)
+{
+	struct pci_bus *bus = pdev->bus;
+	struct pci_dev *bridge;
+	static const struct pci_device_id bridge_devids[] = {
+		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
+		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
+		{ 0, },
+	};
+
+	/* look for the matching bridge */
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		bus = bus->parent;
+		/*
+		 * There are still some wild MIPS Loongson firmware won't
+		 * set MRRS properly. Limiting MRRS to 256 as MIPS Loongson
+		 * comes with higher MRRS support is considered rare.
+		 */
+		if (pci_match_id(bridge_devids, bridge)) {
+			if (pcie_get_readrq(pdev) > 256) {
+				pci_info(pdev, "limiting MRRS to 256\n");
+				pcie_set_readrq(pdev, 256);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_old_mrrs_quirk);
+#endif
+
 static void loongson_pci_pin_quirk(struct pci_dev *pdev)
 {
 	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
-- 
2.39.2

