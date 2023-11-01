Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13247DE3C8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjKAP1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjKAP1I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 11:27:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47310D;
        Wed,  1 Nov 2023 08:27:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DF8435C0040;
        Wed,  1 Nov 2023 11:26:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1698852419; x=1698938819; bh=xCnRAnA710
        25ehVLm6DUJDLfmLjVFEx/xgBZes9V/dA=; b=kBENrH7S2umwB4PdiCaqfVEjkL
        nKBfOC5EqCyFigYEptqPEReGYTl6QVrhbwN7N4nQ0FS68gLl0IGSLqkoNDRTeDGm
        OlR8XKMLtVaWrAjM+kk6cPLZ1IodS/5g3HmrSykvvjxquyNDT603gs38c39vbv8c
        yACp+PJYnj5SL4OunYZ5E1j2PUQ8RPOhVKamQ789cRSls4Q84ba4frpClW8e70p/
        Ho+tEfb+OkuCNcpcrPPSxcuJ4tC+9HCmgljukPErtwLtK5lWyxp/qZdP6aQVWCd+
        my2XJFO95SrOVIb07jZKTNY34Tioe7IjYkzXgHhzb46bos/1CWG3FtMmJB6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698852419; x=1698938819; bh=xCnRAnA71025e
        hVLm6DUJDLfmLjVFEx/xgBZes9V/dA=; b=qjaQR+W3EXidVbIK1IqFsd28zCbLA
        WfE1ybQfLajdBbdRTWXML5E6SWNJRWFja6UKc8fMV7wbrZnJC/0JtAY0fitf1OfM
        AzbGcGDvxzpEjtQymolYdRq+w5iD7kEgjHFm1iEqp55j0aUUpIT1Us1FIyXQ1COw
        fNltEfnwdh2BHJQXo4x3mko65nzlCurLM3FqG41v2cNVdQwE2X6k5rtVZlZyhlLE
        Dnu8v2y6RhbXqVsq7ZMd1lCi8SYr/LTNZFUS/o1XUN0JV4mBOvnJ/ruJydfzT20S
        tyd5M8S/RAzFltWY7a8pX508NGomgC7tnojNRonTxWoZC8hl6/d/Qijow==
X-ME-Sender: <xms:Q25CZTcB8cq7Ca3JwoQUOnRCSVH5ElZ0579_QXhlVlUrhlHP6uWvlw>
    <xme:Q25CZZMKXwjkVQBGfvBPY06XCN692VyocaSdhU27Cp0Idar4O_ypIOcaAxYpqjQzW
    I14h_fW7PQ3mRDoZQs>
X-ME-Received: <xmr:Q25CZcjq2yThEZRgNkCYcaQD48B3uw4AwuYYR-olxgOADBtXVM_NGLKZpAVDN_8djG66ptRoLLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuteekleeuudfgueethe
    dtuddthfdtleffgefhieehfeeigedvtdeuveetiedunecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Q25CZU8T1mtLcXLfWLaB5TSydqIBkD_InmISZ4tvbIgnfNGvQ4EXPA>
    <xmx:Q25CZfv2lspI0jHApafI2BC8fYnknvf8b6ZiwP8XDzFdnZrfk-X1lw>
    <xmx:Q25CZTFHd767d3dxo8orDSA51nhTu6RlqGaAiR3xzZSalIgYMcD5gA>
    <xmx:Q25CZTgijUFXCu_0tKGEYzOdBDkjlAIMcsZR096XwjvM4Trf8MV_Vw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 11:26:58 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: [PATCH fixes v4] pci: loongson: Workaround MIPS firmware MRRS settings
Date:   Wed,  1 Nov 2023 11:49:56 +0000
Message-Id: <20231101114957.309902-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
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

