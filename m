Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B977A352199
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhDAVWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhDAVWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:22:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90308C06178A;
        Thu,  1 Apr 2021 14:22:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g15so2354319pfq.3;
        Thu, 01 Apr 2021 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSGfeqiI16h1xdk+kDjbKZZ2Zy2FnQRhOpc1dRiQ3Hc=;
        b=TyACpHVWPpmn4rVcyPdd2oD+YnXPljjxNqIQMypgJj1OzC2p1DEKTcULKOs8oO7d5j
         3Zl7zcTZwdQkdVDKuhV0OqsolRYB983JEXRhlyaWPIP9e1uW81Vl8yv9nHO6SBiDDrGp
         8fjhQ0G6TED/SftetqoBCQ/Wnt9WuC/bVamjwvpKUVpyWMbD56Ue6IBYLX1tRVnyhmCU
         kegFFPShHoTCNIXHeFkIjyyQYLeP2dx02DYvA7iYJr/NC1q5qV7c1IPPbVsklEjZTEb9
         V9x08uQsyJWH/ZUPtd25IeMALZ8/GHoT+08WEfqu+isMVCZN0vzNRyGfug4LonsXvZJv
         2rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSGfeqiI16h1xdk+kDjbKZZ2Zy2FnQRhOpc1dRiQ3Hc=;
        b=OqT+m7MqxNHI4T+rbelNDaUQExzzULF9sVZzwggh7+yc3lyspDgOxtKW+vBl/FAIuE
         QD4RktDoHpH0rFB+z1Xau+iHpje2sari2rsaMU0bxpfNyBJAdHwZZzwMbpYxedmEZzks
         mMxLouKvH8FVrmRFZmoDNSnMJx4AgdBh1cEFjUOKIPgrOsMxqIfEt73jGeEL5jsaOEx2
         GEjr3U4UcvuMhzP2leNGvEN8sWmB+aMTM/66yzrzxVvEUCFIHdKzf6TgPIPuGnwuqLtc
         kDHe6rVpdSXgp8iHHtp8gWZJdEL0p0pjzwgwfybNR56yP2SBnCaiXVhUv0Dc6dC+Wnh6
         bNaQ==
X-Gm-Message-State: AOAM532UJT3kgCa7Y/2CiIVVNfYKk/O8wDBEzQgvRiEi38gv5ZKtfEDh
        HI51B8w/s/hZoL2+b1b8VCpqjZh9GYg=
X-Google-Smtp-Source: ABdhPJzZR0MBN1IIOC3WlT4nfpVaoCry/gQUJ5AcabN0UPPKheKks8+k5P9sS4p57f3qyjkkVffmVA==
X-Received: by 2002:aa7:8d4c:0:b029:21c:104b:f6cb with SMTP id s12-20020aa78d4c0000b029021c104bf6cbmr9063700pfe.26.1617312124937;
        Thu, 01 Apr 2021 14:22:04 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:22:04 -0700 (PDT)
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
Subject: [PATCH v4 5/6] PCI: brcmstb: Give 7216 SOCs their own config type
Date:   Thu,  1 Apr 2021 17:21:45 -0400
Message-Id: <20210401212148.47033-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401212148.47033-1-jim2101024@gmail.com>
References: <20210401212148.47033-1-jim2101024@gmail.com>
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
index 4c79aff66de7..44128df33785 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -265,6 +265,13 @@ static const struct pcie_cfg_data bcm2711_cfg = {
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
@@ -1325,7 +1332,7 @@ static const struct of_device_id brcm_pcie_match[] = {
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

