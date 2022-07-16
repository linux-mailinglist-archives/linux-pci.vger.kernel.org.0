Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2238B5771DB
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiGPWZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiGPWZL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA381C91D;
        Sat, 16 Jul 2022 15:25:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so694786pjl.5;
        Sat, 16 Jul 2022 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VkZuzjpphc3hRwU3DZRuPBK7JhfYOuym3N4nWR7ADgs=;
        b=it06odQYV4an9HwynsjEosZr1HZe64JDlVydFVDU22TVm6YybuB9qumKvbS1IE61sH
         /qdHnF/gAMWv41oujk5+WDfNAPoGSX7tV8/P9Mjj/0+U4Hd+AwF54szjML7idRvL5Ibn
         BsJEENppGe14IxeP/9dVDToaaqbhQJbsVP1VW0sB7qdyMHxWw0S8VBwX+Hi/D3zStlUO
         sr2xDe1rUbuW99covL0cNzRbxYyUr4Y/xiyq1oDhtkHkg9Tmm831OqTLZl7KZtdTuswM
         PaNcp0EiXVLeTbwG43tZOu6M3Jh16SgaUOJT632efQqyadXde+RXejsbwXYSwJSVFcGf
         WKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VkZuzjpphc3hRwU3DZRuPBK7JhfYOuym3N4nWR7ADgs=;
        b=yAX36/MMinVHTBy2eVEzz+viaRSek6W3Lkfev0VJ9L6jd70dfCEfnlTM+q+Co5/S0j
         d/yNLmZDxRp9EpopFr5Z2Vf6A6icDJT7SF9ngiVkcducYONt2vwObfbvXH35TkqcTxF2
         a7uV/MiQcZ8eSwYpzGGomn770CcIyZzkAgDSDlzFhrrYgtFeYaIQN0CXiGMEcaVpxsJu
         o4Aejjj8QtyIyhM/7vvEMIrv56ymuGf1xLNeH9jlKP8YdUyj30IPJPhFDayhC91gpmJf
         JmghQLeFJ+MMgfkWV61sLiAaKquJWhaP5G6GtqYPbCwLjpbfsyPicuQVGRuUjmS+Ly9g
         NPBA==
X-Gm-Message-State: AJIora8+cs7cdEecTe+v6GBVmfqxDh5VxF1SKYVkgVbxBREQUlPCO7xO
        yHxLPyRB4+m7gPXjqyh9FnA0IB1G6tI=
X-Google-Smtp-Source: AGRyM1u0b1AVxEG8PTsHKsFb7AKI7+0nqm3Lcti6d1dONMD5vgZfHb0Ct1AJCWvrKGIc/xnENm9gpg==
X-Received: by 2002:a17:902:f64f:b0:16c:23c2:e2dd with SMTP id m15-20020a170902f64f00b0016c23c2e2ddmr20547647plg.3.1658010308459;
        Sat, 16 Jul 2022 15:25:08 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:08 -0700 (PDT)
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
Subject: [PATCH v2 3/6] PCI: brcmstb: Add "refusal mode" to preclude PCIe-induced CPU aborts
Date:   Sat, 16 Jul 2022 18:24:50 -0400
Message-Id: <20220716222454.29914-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220716222454.29914-1-jim2101024@gmail.com>
References: <20220716222454.29914-1-jim2101024@gmail.com>
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
access causes a CPU abort.  This commit sets a "refusal mode" if the PCIe
link-up fails, and this has our pci_ops map_bus function returning a NULL
address, which in turn precludes the access from happening.

Right now, "refusal mode" is window dressing.  It will become relevant
in a future commit when brcm_pcie_start_link() is invoked during
enumeration instead of before it.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c026446d5830..72219a4f3964 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -255,6 +255,7 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool			refusal_mode;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -687,6 +688,19 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	if (pci_is_root_bus(bus))
 		return PCI_SLOT(devfn) ? NULL : base + where;
 
+	if (pcie->refusal_mode) {
+		/*
+		 * At this point we do not have PCIe link-up.  If there is
+		 * a config read or write access besides those targeting
+		 * the host bridge, our PCIe HW throws a CPU abort.  To
+		 * prevent this we return the NULL address.  The calling
+		 * functions -- pci_generic_config_*() -- will notice this
+		 * and not perform the access, and if it is a read access,
+		 * 0xffffffff is returned.
+		 */
+		return NULL;
+	}
+
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
 	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
@@ -704,6 +718,11 @@ static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devf
 	if (pci_is_root_bus(bus))
 		return PCI_SLOT(devfn) ? NULL : base + (where & ~0x3);
 
+	if (pcie->refusal_mode) {
+		/* See note above in brcm_pcie_map_conf() */
+		return NULL;
+	}
+
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, (where & ~3));
 	writel(idx, base + IDX_ADDR(pcie));
@@ -989,6 +1008,7 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		dev_err(dev, "link down\n");
 		return -ENODEV;
 	}
+	pcie->refusal_mode = false;
 
 	if (!brcm_pcie_rc_mode(pcie)) {
 		dev_err(dev, "PCIe misconfigured; is in EP mode\n");
@@ -1134,6 +1154,8 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	void __iomem *base = pcie->base;
 	int tmp;
 
+	pcie->refusal_mode = true;
+
 	if (brcm_pcie_link_up(pcie))
 		brcm_pcie_enter_l23(pcie);
 	/* Assert fundamental reset */
@@ -1185,6 +1207,7 @@ static int brcm_pcie_resume(struct device *dev)
 	u32 tmp;
 	int ret;
 
+	pcie->refusal_mode = true;
 	base = pcie->base;
 	ret = clk_prepare_enable(pcie->clk);
 	if (ret)
@@ -1361,6 +1384,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	pcie->type = data->type;
 	pcie->perst_set = data->perst_set;
 	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
+	pcie->refusal_mode = true;
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
-- 
2.17.1

