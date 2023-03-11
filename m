Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1F56B5C43
	for <lists+linux-pci@lfdr.de>; Sat, 11 Mar 2023 14:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCKNfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Mar 2023 08:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCKNfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Mar 2023 08:35:01 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3224C9C;
        Sat, 11 Mar 2023 05:34:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 97A4D5C0094;
        Sat, 11 Mar 2023 08:34:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 11 Mar 2023 08:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678541697; x=1678628097; bh=2h
        vieJeB5EfrLKwyYNa5R+FhNCK+/9JjDOLjM1Jf+jc=; b=jNbGj02MZz+gNFDRwa
        3JFdV7276641BpyfI0YnEmEh1TEUCWUedMCL0ZfCAdlkdisCYYsb7L3Qu2hzQOeB
        vaIwrlfoDe/MNrE10KO2cEmp5RWfaJNBSjtR09+VsD2jhgBCcSxyfeTCXkOqGD+e
        3p3E44EOdVudfmtGe4j7nsYF/wIcMx1JxTGalkAuvoPbCOKFwhXcqppPc6630FM9
        jF/Y/Q5qVpAoIPSStV1nWD183MtbfYWRmHMt3Zu+4hEcJCT8KtmX5kPp4I19F/YT
        yaQdxQrHlm2xWwEd9mZqpClUvFvfT/4IweezBRtHX3hUB/dmOaCUF0ntrWtby9xF
        B3nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678541697; x=1678628097; bh=2hvieJeB5EfrL
        KwyYNa5R+FhNCK+/9JjDOLjM1Jf+jc=; b=j5m8CZ8WRBnzRbJI5gekVQxXj1Uk9
        1F/3xRBWpNSO6/IKPyDo01AdD7y4hZk9fz1hHM4pxKmnZq8rpwHe11Wxz5kD1wPU
        Bcu/+IFu39YHPWiqD9NkqukWzc8vdV7whWQbH4D+FZ/QOOp0ZlyiREUEGMgG6+xB
        ABNVlgjrSrqP+wrVdv1ksFOMT9q4ATmJFqBB15ezsF+51HF/+wwr4kksjHMR7tzo
        pLuzwKJNlUrjYWgU637wnrRtxGpMm0jengxg9X4tIYVoS78xJjptYFF+ywvwG6/t
        awANKpoSt2fYMcU4OypWmF14eqHHBCRabnJkYF2nRWQF0zYN6AGaMznYw==
X-ME-Sender: <xms:gYMMZOqsH3u7ODpbMIDAEECdJPvaMwE-SULqQdKcqPC-wQKIqGn-Ow>
    <xme:gYMMZMr3hH1dyZhmj0D7Cn4ugTEtUULe3g5LbDjgrH7-cizIadnF0x9lGwnXO5ZFa
    MeBN3Zawrs5VKSfLcs>
X-ME-Received: <xmr:gYMMZDNV1XmwNHlIjRbm1X9jMBRhWf7sCtxx9BwMCDsiUX1zxc2IWGnSq4gVBw7U88ijL-uWl4SXL-SHmf4JYiWG_r7jtHEiqZLzk3AtS6GhyQrAUA4-b4dQzmODCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:gYMMZN6ESJQE5LsFat-67GEvkiso29BATp1f3UOsZ1q7mUrFVQnZUA>
    <xmx:gYMMZN7KK4e3m-4zTkOpRk00g3ijIEVw_0IMjn3W1la9kAlq5uyThg>
    <xmx:gYMMZNhwd-8c9u8RHDRoY3jxqgzVH2GfYFiJGwLOD5taCbzgTdHVdg>
    <xmx:gYMMZHvwn4zmABBadrwGZ1J3VpWWA9pbrX17YlSJa0ekiKgwatZ0Dg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Mar 2023 08:34:55 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Marc Zyngier <maz@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: apple: Initialize pcie->nvecs before using it
Date:   Sat, 11 Mar 2023 14:34:53 +0100
Message-Id: <20230311133453.63246-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

apple_pcie_setup_port computes ilog2(pcie->nvecs) to setup the number of
MSIs available for each port. It is however called before apple_msi_init
which actually initializes pcie->nvecs.
Luckily, pcie->nvecs is part of kzalloc-ed structure and thus
initialized as zero. ilog2(0) happens to be 0xffffffff which then just
configures more MSIs in hardware than we actually have. This doesn't
break anything because we never hand out those vectors.
Let's swap the order of the two calls so that we use the correctly
initialized value.

Fixes: 476c41ed4597 ("PCI: apple: Implement MSI support")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/pci/controller/pcie-apple.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 66f37e403a09..8b7b084cf287 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -783,6 +783,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	cfg->priv = pcie;
 	INIT_LIST_HEAD(&pcie->ports);
 
+	ret = apple_msi_init(pcie);
+	if (ret)
+		return ret;
+
 	for_each_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
@@ -792,7 +796,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 		}
 	}
 
-	return apple_msi_init(pcie);
+	return 0;
 }
 
 static int apple_pcie_probe(struct platform_device *pdev)
-- 
2.25.1

