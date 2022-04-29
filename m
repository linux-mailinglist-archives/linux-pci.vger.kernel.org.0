Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BE6514AD2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 15:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376316AbiD2Np0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 09:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376366AbiD2NpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 09:45:25 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F9ACC538;
        Fri, 29 Apr 2022 06:42:04 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 36F8B1BF20D;
        Fri, 29 Apr 2022 13:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651239723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAMsDVvTiaLCVhxn/JVH0pxqslPhba8QbfwBEnkBzCU=;
        b=mm8zVs6fozVCDteJG9lIAHWzwa/IUBMr+6Ujl9DfDbHOxAfwJzsvJeF+WciKYmvUldh5Sz
        rCzOSi279kgfcnK52zFSLUWW1JHzIF5NLaFuk2c3A3X94lTjr/agFMNS3mEMgg6yzpHzUW
        TJa95WCaQnmewjKemtyBSiuwBe85+cYIVtkciPQ7TJmLtpdDJY7xeq0DyzgDHzXT7dXkEE
        ytiaXQW1qLpjWL39ymZtqEZsSkEP6aq/BZjo+AJM6g0pbomOQR8c6y8sRHO/bAvbOFgSBh
        dUwZx/6FHwB7xB4B1MJB0M+JLFwHawqWbqRz7+g0h3sBneVWW2+bJMaaklvwtg==
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
Subject: [PATCH v5 3/6] PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
Date:   Fri, 29 Apr 2022 15:41:40 +0200
Message-Id: <20220429134143.628428-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429134143.628428-1-herve.codina@bootlin.com>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
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

Add the Renesas RZ/N1 SOCs family support to the Renesas R-Car Gen2
PCI bridge driver.

The Renesas RZ/N1 SOCs internal PCI bridge is compatible with the one
available in the R-Car Gen2 family.

Tested with the RZ/N1D (R9A06G032) SOC.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

