Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2468500741
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 09:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240556AbiDNHnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbiDNHnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 03:43:09 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CFD53B5E;
        Thu, 14 Apr 2022 00:40:44 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id F34A11C000C;
        Thu, 14 Apr 2022 07:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649922043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t9Y3nUWyGqzo/x4OaK0UMD7gckY0DOyVPjDybhf/czQ=;
        b=UvlTxMpR4wC7pbQaSP01ZZ3PoQWndajje7G+qxZwmnKH7rNYQDCmLbEyw9AtPkFWrZ0kIS
        9M7g4VBdy5GB0r1dWY/luIi8GWOXdZIaJonzPaRDyheHhks82Q6P+dBbmTaGAdnenrQDa4
        ql1hVMjAPxUvbK7XHjb9wyvKQq3HOfmwY81eNKAYWMAg20/fKuWXcqalO8RoMT5qowZDqP
        LQ/Ino/3MXt7Xfs5l10WnHfosawGba4y78vcc/JslfPxzSysWeh3MjX/TiNfbevmr3g+qA
        BWUcfleeXUceovXEs4FKbk1QZAS2MaXlRVZTSKXsHJjyRVNG4r/SMBGvlz5isA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 5/8] PCI: rcar-gen2: Add R9A06G032 support
Date:   Thu, 14 Apr 2022 09:40:08 +0200
Message-Id: <20220414074011.500533-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414074011.500533-1-herve.codina@bootlin.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Renesas R9A06G032 SoC support to the Renesas R-Car gen2 PCI
bridge driver.
The Renesas RZ/N1D (R9A06G032) internal PCI bridge is compatible
with the one available in the R-Car Gen2 family.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/controller/pci-rcar-gen2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 528bc3780e01..c190d1a030e4 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -352,6 +352,7 @@ static const struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
 	{ .compatible = "renesas,pci-rcar-gen2", },
+	{ .compatible = "renesas,pci-rzn1", },
 	{ },
 };
 
-- 
2.35.1

