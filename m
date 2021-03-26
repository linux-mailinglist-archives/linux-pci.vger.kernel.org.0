Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABAD34AF3A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCZTTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhCZTTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:19:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F4EC0613AA;
        Fri, 26 Mar 2021 12:19:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id bf3so7524732edb.6;
        Fri, 26 Mar 2021 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ml2lWLGpOaR2MEq6nedJpA3igERFdLP4LEElGLKkZws=;
        b=cK8RSpvdKDjYYJfpCu2ltYA9ueBdewUw857Bv0ho2ruAvtG17DBnqm4SdJYlCHuCqS
         pkRvF2F1vJQ7F0/d6AimMoKDaJaRT5gBe8xNWjh6iLHOA/pnfenJd0EPm4yovbCm8W5s
         wWMUIG9GBhD+fUB5Xi4ZiMPoZs/4PrriOTHmkMhhGx+IqpnWgvpIFQZnvCKaS1zogxP8
         H8XLh27ZWl+LWdNxIwffLSYc1guHW7McbVlaE53rIvGJSnUTdRy+fkZSo5gzWx0PsKzE
         fscT6tG8dJ5N2Eh+moldHJapqj4aNrFsyDltJEy8TsfY5KfB2WdYiETICqEuAYy2ML6d
         zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ml2lWLGpOaR2MEq6nedJpA3igERFdLP4LEElGLKkZws=;
        b=LambhKsnV1InDIt7uRtvGpDRgWvfPaCqTrqUHcp3YwhC7nOLM63bzlEiJ5a8zOG1X1
         Jep9w0hEVI+bbkjbGvbpyxyn6rWPrGTh6TB9RvHnRCTL+nIQnZvxZXRKATh2Z8htO2+W
         7dBB3NXCTg/8WXFlH1YwAFhD0OB4Hegg1DyaqlqY/MziUTh40PLJmlX2Cv32MSouWL7g
         mHASx97ehPekJ2zEjEF+MDml/fWdycsMvEUaFdHjc+LjKvNkXWb/VC/nWWhvHGOZZZEc
         Q94iOGsUNIZuHBTq+71OSD0ptDemOVpuwNlsYJJNd/MBQutGL3hkRP8fOiFB2WChB2pE
         nEWg==
X-Gm-Message-State: AOAM533Qryc2N3GKyAG5YdXp7iPCnvj/U/Cg89o7HGFcNTwILgVpWmoW
        0YCnSeDY8HHpWS+8+baqBCn724WzuXg=
X-Google-Smtp-Source: ABdhPJwzVR1KR1vKMODpCAinj0MQcXxrRz7RUrG5Wj0zhIHZbOzKFSTuIKUO2BCFD8yUJ2HdtOqo2A==
X-Received: by 2002:a05:6402:1613:: with SMTP id f19mr17182438edv.222.1616786361397;
        Fri, 26 Mar 2021 12:19:21 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c19sm4739373edu.20.2021.03.26.12.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:19:20 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/6] PCI: brcmstb: Give 7216 SOCs their own config type
Date:   Fri, 26 Mar 2021 15:19:02 -0400
Message-Id: <20210326191906.43567-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326191906.43567-1-jim2101024@gmail.com>
References: <20210326191906.43567-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This distinction is required for an imminent commit.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 89745bb6ada6..9c8b922a9c19 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -260,6 +260,13 @@ static const struct pcie_cfg_data bcm2711_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm7216_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+};
+
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -1336,7 +1343,7 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
-	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
+	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
 	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
 	{},
 };
-- 
2.17.1

