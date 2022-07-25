Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5224D580185
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiGYPRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235910AbiGYPQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F0D1B78A;
        Mon, 25 Jul 2022 08:13:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so10566982pjf.2;
        Mon, 25 Jul 2022 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XRISqH0YEt9x37mOvZB1aRfZZEl6+ks0JDgNi4Ug7Zk=;
        b=o5neeh4ryOoBCB8aglOKL52nvvcBgFyio+39f1GPtB2O/slaQJdSCAr4qATZhCQmF7
         1zjFyzWkusGEbaJI6oYjegXXuPo5ICsGd2dXIQ3WCRyjOMFl1YGlKEM/kFKKyzPx72An
         8bKV15YiEXk1Ungcvs+IogfaUTguat61aZa9aDVmg4Q/qvSsp4AhG19nCC+xfY3ti/Fx
         geXalA7hGJGtLujyQ4lCHfgFo1jn7cZ3B0VK+qwRSVNqXAysraPUQa2by2+4YDAEhftO
         xpAiofVS6Qh3GnK8oRRIe2TiGXoHU+WOyIcastiLhcc/h49+tTNlSpugOwWQo1fONNrV
         N0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XRISqH0YEt9x37mOvZB1aRfZZEl6+ks0JDgNi4Ug7Zk=;
        b=EN2HqiH/endOWYT8s6zHVsmLnThfi/DGEAV5SudbZU+2q+8H/sCpFO0lhF8dgRVH4F
         ZN/nRlLrBsMd63yWTnHA5MMRelkQI17Rq1upT72m9fOeobP5QKzL/4j6MUKaQ9BUTrCH
         kwizF+8DGeFsuHr14FViIo+b2Az+1+sT/rUebb4/DxzrtmdN9njXftoeGcnWl1EFlq4Z
         p6QayWV5AZsVad+7ElnSQx6fpXiv6MorsPBOIYfusNWj0zo+9hAEpNhVAFmUcJc1wqBC
         doblPzGHV6eplpFv+qxOsxPBrDiLS+Tbmdqlf4tp77FR49R5zzrkmPGzzpfXVZtAgABW
         QvmQ==
X-Gm-Message-State: AJIora+MA9gZ4r/6FYdJXkTwKniYxQjAi3g1e6WGr5VsGLlZRIVPrdER
        Ao0lyxyN/I4zQApOh2ZdeowG8LFr0ec=
X-Google-Smtp-Source: AGRyM1uCEX3dmY0dBa+CpILOTqJu48Q9xyKEqm4oI4EyeWgqGjO1n1uVJmCPP5x3Ng2Y3fble129qw==
X-Received: by 2002:a17:902:c40a:b0:16d:2dbd:35cd with SMTP id k10-20020a170902c40a00b0016d2dbd35cdmr12397728plk.65.1658762022801;
        Mon, 25 Jul 2022 08:13:42 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:42 -0700 (PDT)
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
Subject: [PATCH v3 7/7] PCI: brcmstb: Have .map_bus function names end with 'map_bus'
Date:   Mon, 25 Jul 2022 11:12:56 -0400
Message-Id: <20220725151258.42574-8-jim2101024@gmail.com>
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

Conform with other drivers' map_bus functions.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index fc1d36f6094e..b40733dd253c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -685,7 +685,7 @@ static bool brcm_pcie_link_up(struct brcm_pcie *pcie)
 	return dla && plu;
 }
 
-static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
+static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
 					int where)
 {
 	struct brcm_pcie *pcie = bus->sysdata;
@@ -706,7 +706,7 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	return base + PCIE_EXT_CFG_DATA + (where & 0xfff);
 }
 
-static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devfn,
+static void __iomem *brcm_pcie_map_bus32(struct pci_bus *bus, unsigned int devfn,
 					 int where)
 {
 	struct brcm_pcie *pcie = bus->sysdata;
@@ -1509,7 +1509,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 };
 
 static struct pci_ops brcm_pcie_ops = {
-	.map_bus = brcm_pcie_map_conf,
+	.map_bus = brcm_pcie_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
 	.add_bus = brcm_pcie_add_bus,
@@ -1517,7 +1517,7 @@ static struct pci_ops brcm_pcie_ops = {
 };
 
 static struct pci_ops brcm_pcie_ops32 = {
-	.map_bus = brcm_pcie_map_conf32,
+	.map_bus = brcm_pcie_map_bus32,
 	.read = pci_generic_config_read32,
 	.write = pci_generic_config_write32,
 	.add_bus = brcm_pcie_add_bus,
-- 
2.17.1

