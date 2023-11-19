Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456AB7F093A
	for <lists+linux-pci@lfdr.de>; Sun, 19 Nov 2023 22:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjKSV4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Nov 2023 16:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSV4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Nov 2023 16:56:55 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E6103;
        Sun, 19 Nov 2023 13:56:51 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D6EC73200940;
        Sun, 19 Nov 2023 16:56:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 19 Nov 2023 16:56:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1700431007; x=1700517407; bh=I6ORYYzfuW
        W2rQ1PX1xONWpW3UYd6FA/6Xvzv6YYs0I=; b=cw0WC3uJCbbRW0+RMozIMgoH4B
        WdTYjHoq4KTukIPpDkM296SSyA7LWR1ngEPeZZ0yJ9/r3bqCoiJck6ltssdVc3BA
        pTQACoOLnEwfInuDS1jkvzc0nm7V5TWm+E9wouExerLDOxj72mlQx+uBfXzVu44J
        NYc0Rh10h/W1huO1+ZXSC1ql3YnHqiUjlSwnOLeqyZznBNJcb5fej8Vqh/iWMGok
        A85SigPR42C8Xpc2d5MPNMBnDCfc64Wv6AKoMA8PqYABberBhhAbEpBPU70jqpTd
        FcjOe1lI0D1lG2h7lqw108/4ybVHAoBp69LTz1+XpI0UnhjCZGlTZBf7g9Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700431007; x=1700517407; bh=I6ORYYzfuWW2r
        Q1PX1xONWpW3UYd6FA/6Xvzv6YYs0I=; b=Wv2u4kIN2/jcv5vbpf6suOiyCwshJ
        ye1KKb149PYHrx7Y96lggIA599snmvUeERFlGn+clTw4GXU8YhuWO8E/KCPidfuE
        FDePRHaBqbnHt5w6rtR3lfdofF2rB2SebBlmC1yoYVH5vpteUArj6fNTepAevocZ
        phI6ErOZHzDeuGJR+Ruwg3xEwA3zU1v62ubbg2+rbLgVS8Rw1WAMfIf+dv1MiPHK
        lgmRI59siw2AVQOh2d1/NIBtOZQr1e9NiN0AduIwxbnX8atFFbushUB6x3A3c/CE
        61FiTtHUPFaP5zJ/OGlOI4mRhXuQTBqYX1A49JK9kqtKSMEG07jjz+eMA==
X-ME-Sender: <xms:n4RaZc3s9jW-bJfJQsQJndBGetvTQIrLDY4T613yHqQVNH75gy0KgQ>
    <xme:n4RaZXEd1S2CNTP9NVcQFnhgP_cxCGfUXG80NZXJmDKmWydyjYoJmFWix6pFfZERb
    NQxtXgvgGjdzFL6cSA>
X-ME-Received: <xmr:n4RaZU5nvRUVA4Q65blkLDpFxWKqUyNcfNWqA-7Huvm9C99fjOzl7XUoLdGQM3QPmWQZnUVhSXc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeggedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvueetkeeluedugfeute
    ehtddutdfhtdelffeghfeiheefieegvddtueevteeiudenucffohhmrghinhepkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:n4RaZV18QJETdM6_YWjyNr3otjaanE2Yk6yCQLufhgm5Alm_-GUj8A>
    <xmx:n4RaZfFFMFBZ7OdrxpSE8f8xJxFj5sdIi2isYHXxt1CDJSP18bOjkw>
    <xmx:n4RaZe_pdnwCaKs84NLWVIHCPB9NeYq1pDx29QL4SmQqPbmzIkuJGw>
    <xmx:n4RaZU4f3XlnhzEuiavS-ohLrxO6S3ma1WSP0B4DmN2_sDVM1AtOtA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Nov 2023 16:56:46 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: [PATCH v5] pci: loongson: Workaround MIPS firmware MRRS settings
Date:   Sun, 19 Nov 2023 21:56:35 +0000
Message-Id: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

It must be done at device enablement stage because MRRS setting
may get lost if the parent bridge lost PCI_COMMAND_MASTER, and
we are only sure parent bridge is enabled at this point.

Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217680
Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v4: Improve commit message
v5:
	- Improve commit message and comments.
	- Style fix from Huacai's off-list input.
---
 drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index d45e7b8dc530..128cc95b236f 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -80,13 +80,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_LS7A_LPC, system_bus_quirk);
 
+/*
+ * Some Loongson PCIe ports have h/w limitations of maximum read
+ * request size. They can't handle anything larger than this.
+ * Sane firmware will set proper MRRS at boot, so we only need
+ * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
+ * won't set MRRS properly, and we have to enforce maximum safe
+ * MRRS, which is 256 bytes.
+ */
+#ifdef CONFIG_MIPS
+static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
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
+
+		if (pci_match_id(bridge_devids, bridge)) {
+			if (pcie_get_readrq(pdev) > 256) {
+				pci_info(pdev, "limiting MRRS to 256\n");
+				pcie_set_readrq(pdev, 256);
+			}
+			break;
+		}
+	}
+}
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk_old);
+#endif
+
 static void loongson_mrrs_quirk(struct pci_dev *pdev)
 {
-	/*
-	 * Some Loongson PCIe ports have h/w limitations of maximum read
-	 * request size. They can't handle anything larger than this. So
-	 * force this limit on any devices attached under these ports.
-	 */
 	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 
 	bridge->no_inc_mrrs = 1;
-- 
2.34.1

