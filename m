Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E8A580177
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiGYPQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiGYPQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:05 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4291ADB1;
        Mon, 25 Jul 2022 08:13:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 6so10603909pgb.13;
        Mon, 25 Jul 2022 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xI+CaZm7AHUscnYqQYFqdG4FTtSq1DoKhCMhOBlS3fE=;
        b=OnY0rVF2m4WIM7h85TZx9pPO4Ehy+e7cElKMLbhxoh4Zh+DI9SuU0o4MYVdIyG4pZA
         RhzWlN3yZVHjFgM+aV1Y2PbYEqlyRrlP1QXUbzGV5ZrrFibslr6UxAameeDC+DdZm1A1
         KPhHw2JNlf2UwhjE6CsMI0NgdFbsJGxWJpkGo/qVJMRqw0vuqBWNlesw7T4ZqdTl5VH4
         akvrzqLP6ZiY3wCVP5IKao6HfOJ8cJipDWTkOSams7ApAFBPjrMjPZ/HJBWQW2QXjs7C
         SWPwWT/vHciN6c/qVrYUZuana8iJltVeCPgkn3FaUGlOJiboBq3Ryk/faQhgu2PN9XMb
         9VJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xI+CaZm7AHUscnYqQYFqdG4FTtSq1DoKhCMhOBlS3fE=;
        b=LA7q8s5ugHlUcAs7eUzV4QEIE1fnZ9Fs9tegFcKcyC18Np6BJpu+dsrK5c4XadfztI
         Q9zVNGvySL6YYyGOh7RA0mJ8UVrsqYvGjbsJoP81+/XxAVgDkQrEBtmR8wN6ake6zWlL
         FfUbcLT5UsxVb9eOBYUqiwH0ofXjAtusvhGQqKd4LOAVjcnECqgvoOOftyuSLV+UbGCo
         XbSGnkcOf2gmyuxBh4WU0obcy78mR6Q82x+iOeTRa3ioJXG4MqCBMGyffxJjfdaqm8vt
         J6pG4p4TKAnj2o/UTiaa8NDTf3zau3N+W3ptq+HBk7Gj0YDaI9lv+Cao/7NMIAKv1PEE
         IGqg==
X-Gm-Message-State: AJIora/TiQ2Pgeb6a7RsDr5SXD6o5WcbB38368gIdU1sPkV75FyPUpKF
        26q2La66RBGG5rfCwXjkOymR8UZeGQo=
X-Google-Smtp-Source: AGRyM1vsa4Y8EuFQldpA75OhwPbn8kQCUj/eHUetPEinSfboGW+WPPmgHmfunyGl0wLyXyWb2gr+bg==
X-Received: by 2002:aa7:888a:0:b0:52b:17e8:fd1 with SMTP id z10-20020aa7888a000000b0052b17e80fd1mr13249304pfe.46.1658762011028;
        Mon, 25 Jul 2022 08:13:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:30 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/7] PCI: brcmstb: Gate config space access on link status
Date:   Mon, 25 Jul 2022 11:12:52 -0400
Message-Id: <20220725151258.42574-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
References: <20220725151258.42574-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our PCIe RC HW has an atypical behavior: if it does not have PCIe link
established between itself and downstream, any subsequent config space
access for a downstream device causes a CPU abort.  This commit allows a
config space access for dowwnstream devices only if the PCIe link is up.

Note that config space accesses to the root port are diverted to the RC
registers and are honored regardless of link status.

Some other minor changes are also made: (1) limit the "where" offset to
4K and (2) reject RC accesses if devfn != 0.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 15e47e8c94eb..3443206d2a95 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -683,14 +683,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *base = pcie->base;
 	int idx;
 
-	/* Accesses to the RC go right to the RC registers if slot==0 */
+	/* Accesses to the RC go right to the RC registers if !devfn */
 	if (pci_is_root_bus(bus))
-		return PCI_SLOT(devfn) ? NULL : base + where;
+		return devfn ? NULL : base + (where & 0xfff);
+
+	/* An access to our HW w/o link-up will cause a CPU Abort */
+	if (!brcm_pcie_link_up(pcie))
+		return NULL;
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
 	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
-	return base + PCIE_EXT_CFG_DATA + where;
+	return base + PCIE_EXT_CFG_DATA + (where & 0xfff);
 }
 
 static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devfn,
@@ -700,12 +704,16 @@ static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devf
 	void __iomem *base = pcie->base;
 	int idx;
 
-	/* Accesses to the RC go right to the RC registers if slot==0 */
+	/* Accesses to the RC go right to the RC registers if !devfn */
 	if (pci_is_root_bus(bus))
-		return PCI_SLOT(devfn) ? NULL : base + (where & ~0x3);
+		return devfn ? NULL : base + (where & 0xffc);
+
+	/* An access to our HW w/o link-up will cause a CPU Abort */
+	if (!brcm_pcie_link_up(pcie))
+		return NULL;
 
 	/* For devices, write to the config space index register */
-	idx = PCIE_ECAM_OFFSET(bus->number, devfn, (where & ~3));
+	idx = PCIE_ECAM_OFFSET(bus->number, devfn, (where & 0xffc));
 	writel(idx, base + IDX_ADDR(pcie));
 	return base + DATA_ADDR(pcie);
 }
-- 
2.17.1

