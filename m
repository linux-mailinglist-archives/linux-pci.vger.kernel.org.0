Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABD8536EBE
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 00:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiE1Wof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 May 2022 18:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiE1Woe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 28 May 2022 18:44:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F057B36D6;
        Sat, 28 May 2022 15:44:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b135so7371605pfb.12;
        Sat, 28 May 2022 15:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKLY2zuvZewS/BwLmJvq6qxpOINA6m+jHazoY1CR+1E=;
        b=eYyugB7SlJeyfJ8Meaw2RV0Z7j7t43v2JfETGz+J9TpkrtImv7fWN8BqZ65UN2n5Zu
         Jm/w/rDTsmvrhSXQ5P/7kg3WeCP1JCNi4oSl/3Nf/rWoaqS45qHu1AwPQHbwwpljEjt0
         hly0K3X5y0Id0Nd4VeILDg2lX4Pw+kj1BtjvH69YZfhhWdO7Z2HCKe1fZ/n9A7BgsZ9h
         fB2RXRIPO3hunYRrjBQQM+oKYmNatsSmqDsDEiCCo9MD3iLT7K4IJ+OJJgY6pZq64pDn
         q1yQyURG7ThiNQee3MJw1lKuh+7XCXqs3xdthpzO2/ZmmKUT11yZwQZDylr/axzEAQTu
         WFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKLY2zuvZewS/BwLmJvq6qxpOINA6m+jHazoY1CR+1E=;
        b=wyXC34GFvdqX79jP3wRUPT2LX969qkpY0wCdnYG3KDVjx/3wjslZuGmHCl/NLcmAAf
         xlcn7F8tURXDYJAsj9WuJCGcEQc0Iz0UeRIiUanX2Sw4bZuKwXNDUPx2xlr758XaMi+f
         T+L5SW4gzhUbHlerUIMJBnIMiT/wMuBxbrNKC1cO3C8mA0m0vstTnAHHMrhKGqYaPqKI
         9gK7JVxkxTBnJdIPs9i152gmviASyyx2upZpV3WnTNsL+AxcvazLFosjziSdxkBs4VC7
         SVZJ3zaF4ktwoetvcru7MVp0Bw1K4lPXhdOS8S8RpR1t8QmkIkEHm2XneN49j2SQYeqR
         u0Ig==
X-Gm-Message-State: AOAM532G9cPLfYa0UMEHbiL+fUy8WKaGNaw2PC9RDGQQa2TcWMefNYcm
        HL4n8Rtqz4dNA08mjJ3aT3tgoqtGFZsS5Q==
X-Google-Smtp-Source: ABdhPJyA/BKlk4Roppn6E2jXmyTWjXLBOuYK4p6OT1DEZxmNyaYvzQPTIaEJqaWY8mTvJ3QnALuFhA==
X-Received: by 2002:a63:5a23:0:b0:3f2:678b:8de8 with SMTP id o35-20020a635a23000000b003f2678b8de8mr42486377pgb.226.1653777871733;
        Sat, 28 May 2022 15:44:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902b41600b001635a8f9dfdsm6159514plr.26.2022.05.28.15.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 15:44:31 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, james.dutton@gmail.com,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
Date:   Sat, 28 May 2022 18:44:23 -0400
Message-Id: <20220528224423.7017-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220528224423.7017-1-jim2101024@gmail.com>
References: <20220528224423.7017-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

commit 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")

introduced a regression on the PCIe RPi4 Compute Module.  If the PCIe
root port DT node described in [2] was missing, no linkup would be attempted,
and subsequent accesses would cause a panic because this particular PCIe HW
causes a CPU abort on illegal accesses (instead of returning 0xffffffff).

We fix this by allowing the DT root port node to be missing, as it behaved
before the original patchset messed things up.

In addition, two small changes are made:

  1. Having pci_subdev_regulators_remove_bus() call
     regulator_bulk_free() in addtion to regulator_bulk_disable().
  2. Having brcm_pcie_add_bus() return 0 if there is an
     error in calling pci_subdev_regulators_add_bus().
     Instead, we dev_err() and turn on our refusal mode instead.

It would be best if this commit were tested by someone with a Rpi CM4
platform, as that is how the regression was found.  I have only emulated
the problem and fix on different platform.

Note that a bisection identified

commit 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")

as the first failing commit.  This commit is a regression, but is unrelated
and was fixed by a subsequent commit in the original patchset.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=215925
[2] Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml

Fixes: 93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
Fixes: 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215925
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 43 +++++++++++++++++++--------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ba5c120816b2..0839325f79ab 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -540,29 +540,42 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 
 static int brcm_pcie_add_bus(struct pci_bus *bus)
 {
-	struct device *dev = &bus->dev;
-	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
+	struct brcm_pcie *pcie;
 	int ret;
 
-	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
+	/*
+	 * Right now we only alloc/enable regulators and initiate pcie link
+	 * when under the root port bus of the current domain.  In the
+	 * future we may want to alloc/enable regulators under any port
+	 * device (e.g. a switch).
+	 */
+	if (!bus->parent || !pci_is_root_bus(bus->parent))
 		return 0;
 
 	ret = pci_subdev_regulators_add_bus(bus);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_err(pcie->dev, "failed to alloc/enable regulators\n");
+		goto err;
+	}
 
-	/* Grab the regulators for suspend/resume */
+	/* Save the regulators for RC suspend/resume */
+	pcie = (struct brcm_pcie *) bus->sysdata;
 	pcie->sr = bus->dev.driver_data;
 
+	/* Attempt PCIe link-up */
+	if (brcm_pcie_linkup(pcie) == 0)
+		return 0;
+err:
 	/*
-	 * If we have failed linkup there is no point to return an error as
-	 * currently it will cause a WARNING() from pci_alloc_child_bus().
-	 * We return 0 and turn on the "refusal_mode" so that any further
-	 * accesses to the pci_dev just get 0xffffffff
+	 * If we have failed linkup or have an error when turning on
+	 * regulators, there is no point to return an error value to the
+	 * caller (pci_alloc_child_bus()) as it will summarily execute a
+	 * WARNING().  Instead, we turn on our "refusal_mode" and return 0
+	 * so that any further PCIe accesses succeed but do nothing (reads
+	 * return 0xffffffff).  If we do not turn on refusal mode, our
+	 * unforgiving PCIe HW will signal a CPU abort.
 	 */
-	if (brcm_pcie_linkup(pcie) != 0)
-		pcie->refusal_mode = true;
-
+	pcie->refusal_mode = true;
 	return 0;
 }
 
@@ -570,13 +583,17 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
 {
 	struct device *dev = &bus->dev;
 	struct subdev_regulators *sr = dev->driver_data;
+	struct brcm_pcie *pcie;
 
 	if (!sr || !bus->parent || !pci_is_root_bus(bus->parent))
 		return;
 
 	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
 		dev_err(dev, "failed to disable regulators for downstream device\n");
+	regulator_bulk_free(sr->num_supplies, sr->supplies);
 	dev->driver_data = NULL;
+	pcie = (struct brcm_pcie *) bus->sysdata;
+	pcie->sr = NULL;
 }
 
 /* Limits operation to a specific generation (1, 2, or 3) */
-- 
2.17.1

