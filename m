Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08715137FE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 17:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348955AbiD1PUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348985AbiD1PUB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 11:20:01 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B3AFAE8;
        Thu, 28 Apr 2022 08:16:46 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B4B30E0015;
        Thu, 28 Apr 2022 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651159005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjMeOqT8ckJ1eXw+bfbfwC2c+Yq4ThpPuZa9Zo7yK8U=;
        b=je9uKP3oAuzqhXRoB8bOqzQe6pF/53qYe0Mtpx6xOwZhStOWNNGMHw/SMCy0jyw0kcKoV2
        AZioG16T8tuF8gU9utfETbOceeltBIs4V2hXo8gRH8pig5v07jwf1cxI07XqOLejbX+OR+
        mOnL7RDcDDOmno+twpmMCG4foNVDNVwn8FE2v8rkKkt7aoEVD4Z3ZTUHStfxZs7wt/zZxJ
        uzD6/Xvj7bF+dWmr9pIxLnnVCCKvVcRoHi0/L9pdB5jV2Iwh7MnKvAg5yXZ3t8ENYoVlyD
        qe52C8xfS0bjJQV7vJdqOggk5LnzxNXcBUTIlAXeLM1QboB/UC8ukCn7rtTXGA==
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
Subject: [PATCH v4 3/6] PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
Date:   Thu, 28 Apr 2022 17:16:27 +0200
Message-Id: <20220428151630.586009-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428151630.586009-1-herve.codina@bootlin.com>
References: <20220428151630.586009-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the Renesas RZ/N1 SOCs family support to the Renesas R-Car Gen2
PCI bridge driver.

The Renesas RZ/N1 SOCs internal PCI bridge is compatible with the one
available in the R-Car Gen2 family.

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

