Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD4643600
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 21:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLEUrE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiLEUq5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 15:46:57 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B8E64F4;
        Mon,  5 Dec 2022 12:46:55 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AAF6432008FE;
        Mon,  5 Dec 2022 15:46:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 05 Dec 2022 15:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670273213; x=1670359613; bh=7IbHA0q9Sy
        B9xAY8ext/vxebsnnn666wa3ww7cnpJWY=; b=vqpsHGzctaqEQqY4ZX5YGZ/lou
        muHwalgg6de0haJbOLb1ig7zc6zRWe31lsSgm87HAyjoqAmSBC2xkHmzUpHDETtU
        ZqPe4HYf9Jvtjn1WGDkTDvcAkc/M1qjx3pLV8CNA2HLHQxaoY3cjbXy/cKPLg66U
        bCca7pOUfRNQtHD3n5xT0K59vzc813d3wovImHISho9KsO0GlGFFMv8tFjxqYGLy
        T9oWayym8oyyjAIcXHbvL+PVXSXH+fx0H9ssZ5iKq+s4E76LHq/LtTLCE3q+hahL
        yKw4pcOtX+ZolEpWr8pa5hNozBXQ3rClfJZAyKfc46NPPApJWOERKRm6WDqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1670273213; x=1670359613; bh=7IbHA0q9SyB9xAY8ext/vxebsnnn666wa3w
        w7cnpJWY=; b=iSZ/7b993zqUXoF49JIkCjdryJ9sG1PvXysTtpQyprn/Cgmmraz
        U0D+Iqv1QGQMa72naOcCq/00Vo4CJgK3gSjcXNK9MCfhzzoVTsbnGcyeZ90luVGM
        LDAJ1/hstAsbFCrKzMOPKcdob4DusWk2g1Z9ZB5hmcDFOeqecyUTqucAl9wjCDIQ
        NbZav2ll+qHo8kWKdanAq5lg2DaNGA455KxeshkTFO6xjgPAIaubZw/JRgw/N21H
        yTF8lyUtDshEA0EboUAtpOkbxQlSKFZt/m5dRVFdvcgqnMbgv/qH3kG2ewk7qji7
        ny41WaRtYknHYNzJJ2D0dNVkIOkvSN3PHRQ==
X-ME-Sender: <xms:vFiOY12fYo3dpSdLEGotHuO81uCLs2dokiYjKUkD-I_kSnNcocIz1g>
    <xme:vFiOY8GE3aUB1Ww3HKRYEu4vc3EhEG4Xl91eoH-t1FN0-5dM2m7TiHjakgaFbDipo
    oU_m2Y7tlbWS7DgpQ>
X-ME-Received: <xmr:vFiOY15E41um7gfhCoLVvg7QtanNZtqObfcxLzZR1KIl2r6Vqfb4q8zdIgKdsggSAzNJlstpBZMCwRPHgcoxYuIRgIOuxQuD49TbK--O1ZpVwpsnQzuTt68MwG_aQoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeggddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhohhhnucfv
    hhhomhhsohhnuceoghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrdgtoh
    hmrdgruheqnecuggftrfgrthhtvghrnhepfedvkeevgefgkeeghedvleetieffhefgiefh
    lefgvdekfedvteekueeuveelheevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsehj
    ohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:vViOYy38ux65QuJMEGKmS3AzfeWWI5W2lQCiZpfkNCpJUBh2U2t5GA>
    <xmx:vViOY4GRWrbWk1v5cxcRv2Vkpl93O_i7dFaAue_4CpJQMJvCs3cETQ>
    <xmx:vViOYz92HIWaHdnsVIDn9Scf-UwF3aMjVi-3lm_z1yiQdPl1C6X2xQ>
    <xmx:vViOYz3BJVJzrOcnfA3Bk29RrVtKgu8h0h8DaG9uWAKZHPT9CJPDUQ>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Dec 2022 15:46:49 -0500 (EST)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH v3] PCI: mt7621: Add sentinel to quirks table
Date:   Tue,  6 Dec 2022 06:46:45 +1000
Message-Id: <20221205204645.301301-1-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This driver was missing a sentinel in the struct soc_device_attribute
array, which caused an oops when assessed by
soc_device_match(mt7621_pcie_quirks_match)
This was only exposed once the CONFIG_SOC_MT7621 mt7621 soc_dev_attr
was fixed to register the soc as a device, in commit 7c18b64bba3b ("mips:
ralink: mt7621: do not use kzalloc too early")

This quirk test was introduced in the staging driver in
commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
using 'soc_device_attribute'"), and the staging driver was moved in
commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
controller driver") for the 5.16 kernel

Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision using 'soc_device_attribute'")
Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
v2: no newline in middle of Fixes tag
v3: commit message changes
---
 drivers/pci/controller/pcie-mt7621.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 4bd1abf26008..ee7aad09d627 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -466,7 +466,8 @@ static int mt7621_pcie_register_host(struct pci_host_bridge *host)
 }
 
 static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
-	{ .soc_id = "mt7621", .revision = "E2" }
+	{ .soc_id = "mt7621", .revision = "E2" },
+	{ /* sentinel */ }
 };
 
 static int mt7621_pcie_probe(struct platform_device *pdev)
-- 
2.38.1

