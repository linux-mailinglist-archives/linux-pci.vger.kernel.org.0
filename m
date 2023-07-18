Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE1757DAE
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 15:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGRNdT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGRNdS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 09:33:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CBCE0;
        Tue, 18 Jul 2023 06:33:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E43255C00DF;
        Tue, 18 Jul 2023 09:33:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 18 Jul 2023 09:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1689687196; x=1689773596; bh=1gtdEoHMt5
        Hv/pJPOtqHeKTEM1uAknm8OKHB/ZBgR4Y=; b=vVF8cyEqrHZNJ56c2cL4uIoVS/
        ip53/AMKitAvrz+Z5aAS+CjOtfD4t9ySMwkLJXwwYZi/8IOq+2uYIxr9yQ/z0Df5
        fpNgtWquAo+SAGFdBoPiWlBQ1CGBDOMj78tlgHSEXUWUynTSqWciv7+5JHM/iYBy
        7QJCd3ShAbqCUKCG9iCzFKpn+zz//YnGfaPnjtpKx894qYRh6XgncR4FnMdWflEA
        Ll2tZTm3NpIlK15+8WGdT828DrwjkptzoamPCL92USo+M6u6/S0EYXQvhxreBE3u
        Za1hNrD/L8Yuk9Lh/k27IFgUmgsSXvxBqwnJLPRXy4Wj5fvbegpK5gS9LjKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689687196; x=1689773596; bh=1gtdEoHMt5Hv/
        pJPOtqHeKTEM1uAknm8OKHB/ZBgR4Y=; b=0WYOFvZ6yKr0iQ9pHQBVzd/I1BHmJ
        8ZRsbzMg2DGoi6GOCk5xyb+S1M582R7VloCWf1lkl7i95BeNln7ECSRmtFU+AiGo
        3b9o9hkWACoB8cLfd42XOZjhaEvBT+i5nyidK1h4WEu7l2+AcZWxlsyYYnVwbvjr
        5e8yO1ZeTxe70IZwGRKtGsCYVPRAcd1Q7eAxCyuoUsXYr7wmO9urTwpTThXkakzD
        FFndFxNeqOp4zCON2ff5HX3D8KOvBaAw2huCaaF8qiUhdgJoSNpJrBoAdn/d2N+i
        5zJXBndS7K4doe9MJGsIYzc3FmWVVT2stswgNqs28XvVAuhrzwbEGjz+A==
X-ME-Sender: <xms:nJS2ZEPEaugkyacBeULvQ37Evnw-Zzz48N9HDPBwpRmnNCSbBOUnlg>
    <xme:nJS2ZK_egzHzCWgBdbJNVZBdnFSecW38NqDJvwXUfP1CTUmZegAXJ4ZI4Are9OC7z
    SrqXtkGpWu_u06_Su4>
X-ME-Received: <xmr:nJS2ZLRi65EGSv_hBMSEfgrRInZXP5Q3HHaQH5TTFcgK9j9p9kGjTXxvMegEH8wG-ZkTUR1HrfspaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvueetkeeluedugfeuteehtd
    dutdfhtdelffeghfeiheefieegvddtueevteeiudenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:nJS2ZMsquvbiMFM5VCGdQnwyIgsaFvJ97GpsVhd4LZ3zyHpK5WPvhA>
    <xmx:nJS2ZMdeHgn8-irNMWE-3gXUiiRYEm6_yq2Aiid5vKQ_6Vli_ZCdow>
    <xmx:nJS2ZA3Bb50vK27D85PVUWN9b7NjgE_MTQa9pzOms4fC25X_SPyg8w>
    <xmx:nJS2ZBGSZjqGGusnlCkOrlwJqUWXHIZov817LqH9wlgqUI8sAXF5aQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 09:33:13 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] pci: loongson: Workaround MIPS firmware MRRS settings
Date:   Tue, 18 Jul 2023 21:32:59 +0800
Message-Id: <20230718133259.2867432-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/controller/pci-loongson.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index fe0f732f6e43..1cc3a5535dac 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -108,6 +108,44 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
 
+#ifdef CONFIG_MIPS
+static void loongson_firmware_mrrs_quirk(struct pci_dev *pdev)
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
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_firmware_mrrs_quirk);
+#endif
+
 static void loongson_pci_pin_quirk(struct pci_dev *pdev)
 {
 	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
-- 
2.39.2

