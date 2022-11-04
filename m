Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2D61A2C7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Nov 2022 21:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiKDUyl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Nov 2022 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKDUyd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Nov 2022 16:54:33 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A349B51;
        Fri,  4 Nov 2022 13:54:32 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 218235C0084;
        Fri,  4 Nov 2022 16:54:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 04 Nov 2022 16:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1667595272; x=
        1667681672; bh=0tAgYqAZ0GRyXkSILb2k0x36R1r8N/5tLN/RnkJr5rU=; b=L
        2f4gb2oC4O/VvGuAYuuOHLmH8l28Hn9R97GVgq+71qIr6yM0Px5S7kAJZxnc8Gg7
        yLLio6qc+UQqme0nRewruSuSR4/DJiEsgVMy0AlCEmmbvK3sKJRmCP8p0HYwpmZ4
        iEpEW2M7vLrD0l9f6HxvwkHICGYRk/jhOpgplm0U0FvXlaWONjuKQ4VayLg5tiTl
        N/YliTqxVnOCGUF+ucP0S6Z7h75WfNiz9Xu4tDzI8XILWsVs5LQZsscbnV9tx1o9
        UUFGONw9MvXrncYo6fXaI2sDgT8Evg1FkDvRWPcnhCUOf3+jF3NxniPFrNh6w0Wl
        yJ0tHDSYH+Zg8xELaWp2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1667595272; x=1667681672; bh=0tAgYqAZ0GRyX
        kSILb2k0x36R1r8N/5tLN/RnkJr5rU=; b=WNmqNv+arquC2jp0bIIQ+4kgvLkJ6
        oQv2fpGoF4uG53d4zgQFUkKnDjmCUuFdpkEc4pZTqziBRHKDx65zSarlqNzHetr0
        9jCcQi1FN1vuM0L5fZO2dxJUotqsvqKwW29e+/b6+cim1xN8B4QgfW5zEDgKEP2Y
        oALaijUyLsu4DsNhelL3ohRNoPC8yFvN/ZFhJq0rxay6qox07D37qV1pNo1m8i4s
        9Z0NHEtePc4IxvAqWMB8iJsqmrKnF8lC2ZgHMMDMXivllnB39lDFhETVAItlpVru
        06Pdtpls67h/ffHwMpH0qip2JZ9DisHTTf7mCqgLeOeSHxigwQd8Y79Uw==
X-ME-Sender: <xms:CHxlY3b8s6PQFp4siKdn1dkSKjL95a-QRUO5fBu8uUgNkOrnFli9jA>
    <xme:CHxlY2aeMsEJrctBdbR2AWBuH3wjWSobVvYb7lPH1pkuhgpvaC7unlgLS7OjDGBsx
    Cbu0vZEcfaB3Qd5Fw>
X-ME-Received: <xmr:CHxlY59tRS5WqWsuiFgfm8MQ9ffeBDfzLPdL0HH0_r7VXFENRevnxRgB9Obad4g7XCG498AQVz9UjFObDgUJVwekHNG9jVuVCeOx4qvQ_CG0FVLxVIAlqZkpnZCv8PVr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvddugddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhohhhn
    ucfvhhhomhhsohhnuceoghhithesjhhohhhnthhhohhmshhonhdrfhgrshhtmhgrihhlrd
    gtohhmrdgruheqnecuggftrfgrthhtvghrnhepffetgedttdefvddvhfeifedvvdeuveeg
    hedvieffudegudduudehudfhjeekhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    sehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:CHxlY9ryg0nQRcqV1AQtoILqcP48LGgxmXw31FBdR0rdpMasbzVJTA>
    <xmx:CHxlYyoHmgInzVXcM16Ldv1EFTi4pqxsw8ha0IUKo3Io9XvZmf0aww>
    <xmx:CHxlYzRlowXtozeIfieFIrgWKY0JHU2fA5G734NrsOHiPZz9EG446w>
    <xmx:CHxlY_QsbU9xoZ_g-49qsA4eF3TVFhbt9sWGIPzmcyf6qx6MGzf_Fg>
Feedback-ID: ic081425d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Nov 2022 16:54:27 -0400 (EDT)
From:   John Thomson <git@johnthomson.fastmail.com.au>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Thomson <git@johnthomson.fastmail.com.au>
Subject: [PATCH 2/2] PCI: mt7621: add sentinel to quirks table
Date:   Sat,  5 Nov 2022 06:52:42 +1000
Message-Id: <20221104205242.3440388-3-git@johnthomson.fastmail.com.au>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
References: <20221104205242.3440388-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With mt7621 soc_dev_attr fixed to register the soc as a device,
kernel will experience an oops in soc_device_match_attr

This quirk test was introduced in the staging driver in
commit b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
using 'soc_device_attribute'"), and the staging driver was moved in
commit 2bdd5238e756 ("PCI: mt7621: Add MediaTek MT7621 PCIe host
controller driver") for the 5.16 kernel

Link: https://lore.kernel.org/lkml/26ebbed1-0fe9-4af9-8466-65f841d0b382@app.fastmail.com
Fixes: b483b4e4d3f6 ("staging: mt7621-pci: add quirks for 'E2' revision
using 'soc_device_attribute'")
Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
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
2.37.2

