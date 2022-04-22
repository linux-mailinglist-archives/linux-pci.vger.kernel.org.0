Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6028C50B6F3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447329AbiDVMMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447326AbiDVML7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:11:59 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75865643D;
        Fri, 22 Apr 2022 05:09:05 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 29077240014;
        Fri, 22 Apr 2022 12:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5f4gitdZV7v8TIbtsjM1+5Zo5E5OdOGvoQrJNk5lar8=;
        b=ez9PhxpzoYb9gMqjbv3JYJJfrChDnmtW0uP8grJLae6B/QGPcRdfCs94Pzq+MahmC32mr2
        se/MqiDq5h53CZGTFJ2g58J+nwZarK4ZCI08Bo3ec8hqRQ+Dg7lzKpuf/4Hz8JxBIE2pjl
        X3NIzUtH5TXCQWE6JabgfvXLyTKutbSsojJvkTD7eL1uCbNInkqfIo5hjznZPVSp0P3JPa
        HyanqPxqbixPfQNcgfGi3PaWPFDEkTnIS1za1wvmdPW2PsJ+bPo7wtbPmH6Ql6qLrsapRK
        jBOnfIP7JS/QGPVwJFbHM2EO9lUp1lcBe5shGW/jNfFDWP2wtmiFBJG6xfF59A==
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
Subject: [PATCH v3 3/8] PCI: rcar-gen2: Add RZ/N1 SOCs support
Date:   Fri, 22 Apr 2022 14:08:45 +0200
Message-Id: <20220422120850.769480-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120850.769480-1-herve.codina@bootlin.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Renesas RZ/N1 SOCs family support to the Renesas R-Car
gen2 PCI bridge driver.
The Renesas RZ/N1 SOCs internal PCI bridge is comptible with
the one available in the R-Car Gen2 family.
Tested with the RZ/N1D (R9A06G032) SOC.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/pci/controller/pci-rcar-gen2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 35804ea394fd..839695791757 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -328,6 +328,7 @@ static const struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
 	{ .compatible = "renesas,pci-rcar-gen2", },
+	{ .compatible = "renesas,pci-rzn1", },
 	{ },
 };
 
-- 
2.35.1

