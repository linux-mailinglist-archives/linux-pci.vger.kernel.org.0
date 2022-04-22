Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7F50B6EF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447389AbiDVMMV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447358AbiDVMMM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:12:12 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB95674E;
        Fri, 22 Apr 2022 05:09:12 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B2EB0240015;
        Fri, 22 Apr 2022 12:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650629348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JCl/WOp3nIX69HO4grk06/2o7m8C+sekXdS2QhS91s=;
        b=bfVfx53VzN8+R2bv6WVm1Q2Ady2/V/QkJ6sMWnCvQcaDoX13LCHE9PnCDwA3/nm22jpqkM
        v9M3KXxPxP0Lj48UCtf6iHn5QfjAN6qoPPFJrDdou6beWcITHPg5FJbXHEoebIjbiPs3Ke
        yJlI5SU6GldG3rIhmH7F0iWIbxvZ39z3ooFiDEBF7zB7hls22zUfoWoL/6lHVUzpr701uD
        yLijxkEoua28Nf9EopJFT9//VUCIUpel2QKJlWymz1e/Narm0ENPFXyYQZPWvXiBxlYYJO
        Q3AwHn4y0mY1m+IeoM1lv0pwmyPyiE7WDR7Gp1h73wHvTcEsxcgf6ypgY4/C5Q==
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
Subject: [PATCH v3 4/8] soc: renesas: rzn1: Select PM and PM_GENERIC_DOMAINS configs
Date:   Fri, 22 Apr 2022 14:08:46 +0200
Message-Id: <20220422120850.769480-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422120850.769480-1-herve.codina@bootlin.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PM and PM_GENERIC_DOMAINS configs are required for RZ/N1 SOCs.
Without these configs, the clocks used by the PCI bridge are not
enabled and so accessing the devices leads to a kernel crash:
  [    0.832958] Unhandled fault: external abort on non-linefetch (0x1008) at 0x90b5f848

Select PM and PM_GENERIC_DOMAINS for ARCH_RZN1

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/renesas/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index fdc99a05a7e0..15fff5632167 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -47,6 +47,8 @@ config ARCH_RZG2L
 
 config ARCH_RZN1
 	bool
+	select PM
+	select PM_GENERIC_DOMAINS
 	select ARM_AMBA
 
 if ARM && ARCH_RENESAS
-- 
2.35.1

