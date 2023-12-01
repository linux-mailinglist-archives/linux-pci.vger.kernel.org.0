Return-Path: <linux-pci+bounces-327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5728800A16
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 12:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EC91C20A79
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935641D680;
	Fri,  1 Dec 2023 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="e8G17xEo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgqH76Jo"
X-Original-To: linux-pci@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E3D1704;
	Fri,  1 Dec 2023 03:50:40 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 9013F3200AAB;
	Fri,  1 Dec 2023 06:50:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 01 Dec 2023 06:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1701431437; x=1701517837; bh=jXjXrL2mgt
	AhGYKgcBP0Wx2CKz797XazsgwROZ/jzWY=; b=e8G17xEobyMa27KHIIvZPT+i3q
	ooQo9Ob5ml8IvuHuMaiOjmdZJWtDpLoObh/z4XeAUuX4QpekUR4PdEhdzOH1lgA+
	d7rv5c12frW4M4qC4C9Xae2n70cwYrOhWJ/ISev2px5xINy6nxJxzxqVE1kU5H0s
	RN+FB4CmaubnOxE4NGUiY1ZgliXRhdYC8C8aVGD6jBMZ3Tmpdjr9pQsbtbKt1jsn
	+6G9LHN1E4MPCFIo7pfqtnAQktEsue+vn3DGKaLU1r0tVZYtoNPIk3Gp/jAMD3+V
	i9FpFAgsfkcm33Mu89tOfcf1LtoBl6rYQ2lhzr7bedzT9+wF7mO0+ss5hloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701431437; x=1701517837; bh=jXjXrL2mgtAhG
	YKgcBP0Wx2CKz797XazsgwROZ/jzWY=; b=jgqH76Jo0tfYlS3yw0FTrrlf+LqiO
	wvQVWEUDB6YAP2RA+PrxAyxt7rTB4jjEzERSkAeJdeuWjDviPwB+BpTxjjKYJyOV
	efjfNmqT4Fudi9n/dyBNE5W+7ADEUFHWxpIgG8xHhyppGjItCdwLw16m1NXshg6H
	QEzDjoMetGdzdTtn7wYNdPIRQp85q9AZTaDRqE2Zk8xws4Hxv8NcfbYOwvywY+7g
	OGBQ8kaytY7dOj64y1WJ5au/2D4KdkrFpPt5vHNCLjd/h4UxtQWgDlR64tMhZSPi
	5hAlpuDL0z20lSNA7x4wiw5nBSyTD75ZziW/X9ohbw7E/EvIxc7BhjPBQ==
X-ME-Sender: <xms:jMhpZRo6CywO-zJzOOLGSnuwZ1bepIM6WQwj8q0FErQikwbeFGX5Rw>
    <xme:jMhpZTo16Tq_bcuQHV0zCaHhp_wm_fBoGqlXp_6SoqaykxmVuqads7JdefdLkvDYh
    zqCy6IVXdnW2WU2los>
X-ME-Received: <xmr:jMhpZeMd9u_EsIy0-zhH0aNB8XrHIexnUR3ctnlkryCqRbvmJp4CObVMB7HQQijGOBosMAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuteekleeuudfgueethe
    dtuddthfdtleffgefhieehfeeigedvtdeuveetiedunecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:jMhpZc4XzPZHTj1NrBmhw5RfXgFRzzSv3Wl99-W5GHplQryTmZOLIw>
    <xmx:jMhpZQ77dESwpSM0tgvTFpzrmQIUTm-MT3cU9ZdDHenOBv1FH5_kOw>
    <xmx:jMhpZUgVLFUaJSiJQC2A0ZLrqfQ-0VFAUtUvvczTKIdvdi3T63JHpA>
    <xmx:jchpZdtZgwR_huc0n7GixtSvYpkABpKRFaAOI08zKIEqA5CktXusuw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 06:50:35 -0500 (EST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: linux-pci@vger.kernel.org
Cc: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	linux-kernel@vger.kernel.org,
	chenhuacai@kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org
Subject: [PATCH v6] pci: loongson: Workaround MIPS firmware MRRS settings
Date: Fri,  1 Dec 2023 11:50:28 +0000
Message-Id: <20231201115028.84351-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v6: Fix a typo
---
 drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index d45e7b8dc530..e181d99decf1 100644
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
+DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_set_min_mrrs_quirk);
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


