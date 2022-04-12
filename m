Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E92D4FDD4B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 13:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242628AbiDLLC2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiDLLAV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 07:00:21 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70A90CFE;
        Tue, 12 Apr 2022 02:50:57 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id A0498CE2A8;
        Tue, 12 Apr 2022 09:41:07 +0000 (UTC)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 2E7B44001B;
        Tue, 12 Apr 2022 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649756460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=72EU7fqyLNwo7dQx4SfOnbogRdsZnfhW6yqgprEWLGg=;
        b=Q06giUglgqEzDNBY0DNHDOs++180sMNPSvECIwcUmDqN8fpohNonBEyKYr9TPgSDHIoLAt
        1+kW0ENLCOpGDQ9e+ioDoWnwz0WIM+e1KAbNEd7TupgUddA0fwwbbTyioQe8ugQ03kY2RY
        TJdj+q+NWinL+SQCWFZyEiIxT8vUnufxePY/SSXEh960KotZEEtD7v/bxKv4FjPf5olLFI
        T8gX/bM66YzLkCZ0WZa57gnAJ2E8WRssq3uvyzHrnaeGINyqPW3bffzlt80M2CqSa4satC
        NtYZlBGlZezOyYX5SeT09ZLZDOuVOdS+2rH5eKUbaTUK1FEcKkr4vcgB4/RS+A==
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
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 3/6] PCI: rcar-gen2: Add R9A06G032 support
Date:   Tue, 12 Apr 2022 11:40:26 +0200
Message-Id: <20220412094029.287562-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412094029.287562-1-herve.codina@bootlin.com>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/controller/pci-rcar-gen2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index 528bc3780e01..586e4785a57f 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -352,6 +352,8 @@ static const struct of_device_id rcar_pci_of_match[] = {
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
 	{ .compatible = "renesas,pci-rcar-gen2", },
+	{ .compatible = "renesas,pci-r9a06g032", },
+	{ .compatible = "renesas,pci-rzn1", },
 	{ },
 };
 
-- 
2.35.1

