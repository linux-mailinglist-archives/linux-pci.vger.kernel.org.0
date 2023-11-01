Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25D27DE366
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjKAP1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 11:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjKAP1J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 11:27:09 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6806119;
        Wed,  1 Nov 2023 08:27:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B25295C0415;
        Wed,  1 Nov 2023 11:27:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 01 Nov 2023 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698852421; x=
        1698938821; bh=xCnRAnA71025ehVLm6DUJDLfmLjVFEx/xgBZes9V/dA=; b=n
        Vmew0Pl0rKX5yfy7egRF0hT44hcafrFsk0zg2FnH7xU/MYGzcdOqEj69v29jhVZ4
        ZU9D+d2iNynRdwOLi68s5eHK/HagLsxL7xgkXLIb5hZ9acJeVzBcI1LkOz9CJXBf
        Q7f9Yv0y3Dgdyqx2kj1qYoaZgu5YEothGmcpmiPo4TrKtadOINbUW1n7AvHE8CJT
        wPekbFMPHn38xz8e15nGjsAN02YhCcxtuFP6IYFqT9dB7/1x0dMrGMlfqxYbGMpf
        x1xh8e0iMvrsomqTNNG63XI9G1ZrGwRsczm/6zdWnDKw0F0NDKDSnfKLiy03HO3S
        npNgf6QFxIRgpMOKGcJXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698852421; x=
        1698938821; bh=xCnRAnA71025ehVLm6DUJDLfmLjVFEx/xgBZes9V/dA=; b=e
        qMDTiss8SbmK/ooT81K7oc4vE2p3T/MC4YIgy6yoPQplO2w9/iqUA2AVP5Ka/TNV
        jN6jv/Sj9OtYictwjvImnedGD3eYa6hcWjUMZzhdomoSLne06ljXHWfiNUYgDui4
        SakSxT5k4Zw54dKcjau4uHMZNNJFBgfjbP+Yexs2Fm0B5km/FbBG62vyuJmTE1ss
        anC+aeZNqZH7jhxThBjGf4f8EB8L0fmgzVH3bKwU+l6JaoyALflg+h1ct7tOZ71i
        8P8zpjh/9EVvz9dZq1Ag9sXBC7+zyUcd77KiIPwFwy2QHqQgAQsMZ7Z2mJXiOjDY
        NouzkjbV4Eqi5T70srFoQ==
X-ME-Sender: <xms:RW5CZUJZ17ePgnSNKrzCGaIGRpAUZO_N5mvzhiUjwDMBEz9rlEoEOQ>
    <xme:RW5CZUJpsI2sOZ_gHfM56s6f-MI9AmicPmE7fi4-NlgOX4HPg5GmLUoy5P0KSz4rT
    V-mNl4-Nhqj8UnmCdg>
X-ME-Received: <xmr:RW5CZUt15g7XRXMGNySlzmVMgp8l-jW4ArDZeE5Vzlb3ewESRHEwRblEzOWo2p8hPhT-7AptnmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepkeetuefhiefgleegie
    duveefffefteeltddtffeikedtgfevgfduueehfffhgeffnecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:RW5CZRa_iNVSQfQPtZIzHGe8WIoDgDrUaHKddZ6Ieij5gWarsJjD7w>
    <xmx:RW5CZbbkcj-u4nU4Ub3ujXkna-rCEC-JMRElOtrVmvRmwIgxPQNunw>
    <xmx:RW5CZdCBFWpos3PEYPRanOy1_vvW7hC7dL82s8yhPYDk_HKxpPTNjQ>
    <xmx:RW5CZQOTtTntZX6foFxN1rxu1g4Hk1ODoOjO5vYsC2FuwJf_Our7rQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 11:27:00 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: [PATCH fixes v4] pci: loongson: Workaround MIPS firmware MRRS settings
Date:   Wed,  1 Nov 2023 11:49:57 +0000
Message-Id: <20231101114957.309902-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101114957.309902-1-jiaxun.yang@flygoat.com>
References: <20231101114957.309902-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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

It must be done at device enablement stage because hardware will
reset MRRS to inavlid value if a device got disabled.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v4: Improve commit message

This is a partial revert of the origin quirk so there shouldn't
be any drama.
---
 drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index d45e7b8dc530..d184d7b97e54 100644
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
2.34.1

