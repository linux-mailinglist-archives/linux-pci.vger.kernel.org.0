Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A449051D965
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 15:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441837AbiEFNob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349657AbiEFNo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 09:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65F62709;
        Fri,  6 May 2022 06:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F033B831C5;
        Fri,  6 May 2022 13:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A23C385AA;
        Fri,  6 May 2022 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651844442;
        bh=BcPBeM8K8k7DoVQJlpk7FQyNGP2EPhIvqXciXnoQMFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oTGEPTrhUkuVAOPzIFZayAfVu81c6KkvYSNThqiGPWaRzML/+Ef/0WkGWwuN2EupR
         4a4LpMG5+11YJsAYc/h0gMHOfXXAMbZv0M+phbEsU4B8+khLj075UL4mA7WMm9yEqL
         84EmwJtmt0aMYytZZf1boBMDhkeDYOVJKE97ojmovYNY22TOLn7pALAint0HUpIN7L
         0Je2zatXahW/UjjWTPGtOmp9VsfdZycrmSLzP/t9HW1/q3EeJEu7mHYAIWimSvScyu
         Kav4joF9KkZXKv64SdBo0Zbv1S4yX2t4mEgQlFIGQbLrLErkBKng7mF4HQ2YmicGH6
         2BMtpCSqljW7Q==
Received: by pali.im (Postfix)
        id D6B9E11FA; Fri,  6 May 2022 15:40:39 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: irqchip: armada-370-xp: Update information about MPIC SoC Error
Date:   Fri,  6 May 2022 15:40:24 +0200
Message-Id: <20220506134029.21470-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506134029.21470-1-pali@kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../interrupt-controller/marvell,armada-370-xp-mpic.txt  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
index 5fc03134a999..8cddbc16ddbd 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
@@ -24,6 +24,11 @@ Optional properties:
   connected as a slave to the Cortex-A9 GIC. The provided interrupt
   indicate to which GIC interrupt the MPIC output is connected.
 
+Optional subnodes:
+
+- interrupt-controller@20 with interrupt-controller property for
+  MPIC SoC Error IRQ controller
+
 Example:
 
         mpic: interrupt-controller@d0020000 {
@@ -35,4 +40,8 @@ Example:
               msi-controller;
               reg = <0xd0020a00 0x1d0>,
                     <0xd0021070 0x58>;
+              soc_err: interrupt-controller@20 {
+                    interrupt-controller;
+                    #interrupt-cells = <1>;
+              };
         };
-- 
2.20.1

