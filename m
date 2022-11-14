Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8761627653
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 08:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiKNHXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 02:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiKNHXe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 02:23:34 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067521B0;
        Sun, 13 Nov 2022 23:23:31 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6A29232007E8;
        Mon, 14 Nov 2022 02:23:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 14 Nov 2022 02:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668410608; x=
        1668497008; bh=acFlUqy1r7UweKUoyspc24X/PZGFahiBEvTlWYrEsLU=; b=1
        q79ZMFODftvgktjeiPSdqZX97o1DEOZToYjhiPVli2bYU0kZWvVyMLsqnhqdXCvz
        ETNdJoy0gcxvaOefLdIPt4h4ObWA3JZ3SIdnxm+0svw9gfXbZxf+tjqZLO/rj+US
        BvPTHJBxe2tXj8X+O0cD0mhjUVUOQkvdwy1g2DKsc7YOuCrq18NRb0UvG5DpL8Oz
        2dWSC0MquBfbVPgW8cTF73OgYq/2E4wpltvi+U18DurU4UfPolyQX+BraBlF1C+o
        YCaH8WzCl3Dp/v35PZ5oaxm3zesalNOWC2scNXEqu7gmb8lNYuoZhsbkte0ypt//
        TcxjnkLexkjOrWcQ9Giyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668410608; x=1668497008; bh=acFlUqy1r7Uwe
        KUoyspc24X/PZGFahiBEvTlWYrEsLU=; b=Py6mVop4VcvrNQsZtyEfRYZYQTA5I
        NA0jfj/X3jZ20IT6ZikYqwvwihey+XAfLCBXS4KoxzTDF1E3MHeyUHA1wdM43Sfm
        TPmHxuPjIxr6Zoi6jV7IJPB9aEcGfjwjmpKSbWve51Fa3YEpa5jqjQS7nW745YlV
        suxjHWFZc9LlfrWdgMnu2bjYJQgysHNlmtsQNLTL1igyHneUt8799n13NJt3m9uS
        l5Qg+fFFIHbCrIthz2NEwVbHfmPdShZL1tC/pIQdDZwc2yVekMxXj0q5QjzVDpGJ
        6J14duftNOj2L1fs0+8jamWcy32w2jgStGoMhYYPcEO38ldKQkeIiJfTA==
X-ME-Sender: <xms:7-xxY_xD5QoCT-FJIZ8XxCnVIppSCg88paYck46Qtv3SH2rMU6nNsA>
    <xme:7-xxY3R2-BrzRi_Eo5BWcaDboeocq7S250TCP2jRtGMsUANPVZLorCy4lPQeZTPhV
    s_XaXg-CaLZsNg_OTE>
X-ME-Received: <xmr:7-xxY5X_hnjw_W2MBl80Ai2Ah2GO66exaLnkrI5oxNlKe74gxJsw-xrTTsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugfgsehtkeertddttdejnecuhfhrohhmpeflohhshhcu
    vfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecugg
    ftrfgrthhtvghrnhepuddvgfeliedvvdekffehhfevjeefhedtjeduveekieetvdefheel
    udettedtudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:7-xxY5gcWrPc5o4DljbUrmmXjmh9onLW-HoDA3alha9xkDU-nzHq8Q>
    <xmx:7-xxYxCBcruPMqpCQ_iuXO-3tk6MpPMqfvJ94FJQAYnKwKaME8lCsg>
    <xmx:7-xxYyLwWwtlfO2VNxCm_mb8Cd0dTAlkR3-q2X7Phwz5a9KF7V36Fg>
    <xmx:8OxxY89qGhp4jp1w4oEy9cVYBsbgxZZBDF4ibl6uWEmIL-NnbO9SFw>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 02:23:27 -0500 (EST)
Date:   Sun, 13 Nov 2022 23:23:26 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: kirin: select REGMAP and REGMAP_MMIO
Message-ID: <04636141da1d6d592174eefb56760511468d035d.1668410580.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie-kirin uses regmaps, and needs to pull them in; otherwise, with
CONFIG_PCIE_KIRIN=y and without CONFIG_REGMAP:

drivers/pci/controller/dwc/pcie-kirin.c:359:21: error: variable ‘pcie_kirin_regmap_conf’ has initializer but incomplete type
  359 | static const struct regmap_config pcie_kirin_regmap_conf = {

Similarly, without CONFIG_REGMAP_MMIO, pcie-kirin produces a linker
failure looking for __devm_regmap_init_mmio_clk.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/pci/controller/dwc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..5412938c2cef 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -277,6 +277,8 @@ config PCIE_KIRIN
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select REGMAP
+	select REGMAP_MMIO
 	help
 	  Say Y here if you want PCIe controller support
 	  on HiSilicon Kirin series SoCs.
-- 
2.38.1

