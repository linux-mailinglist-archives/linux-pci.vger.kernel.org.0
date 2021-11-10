Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFC944CC62
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhKJWUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhKJWUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:25 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D884C0797B9;
        Wed, 10 Nov 2021 14:15:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u17so4141789plg.9;
        Wed, 10 Nov 2021 14:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkZ8oSbM149H4kVEdywu4YO/VDBT9raRSHF6PBOWSzY=;
        b=MX8Wb8jHc8CNttwYxXJDGsm6mgUi5AQdnGJACRhVrpkcDwkMc4QDp6ZbdanwMk2qfG
         lU6Z/wWeA474bpBesh1JR3Qktd70hhrhregM08IErKc/xSvqBYuYUJiPW37SSp9iGfFM
         29pBHFgg5Y4/jxVAxD/hM6Ut0h117R7Z35JLcxyNK7e3ko/NTw5nz5qmhYbHEDq5P64F
         BxyS23qDAc3khi/qcs2HSlXLSvzczixbJzl3ywhw1XmYnlhhANFkWQEyJbvG00e7kCRq
         3dUb84z/ECZE6j4g50rCQEj2oyUgyFtnyt5yuCLTgqew7GlYtNwD4j2s8zHfFR4eEWvW
         +qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fkZ8oSbM149H4kVEdywu4YO/VDBT9raRSHF6PBOWSzY=;
        b=EyBwyW0TzfkjuSyB5UnJ7e+B+bbWtevNxp4ZztifeIC5Qgeu8b0E4YsK3WFhVjhdO/
         OhDC7dMOqFLdkVzftj256wY7bjtcvqCo860jkq9JlmTen06k6g7cgxI67RnrDzp1s2qY
         9IYCfGK0G58jlTFrcupm5F1n8qtT4+3hc96cWz9q4IN5F8R91Ge/z4T90D7zjz97rjUp
         7rOh5SnvJi/fzp3czZAPEi71BGrCKZI99fMdB9SeSZ3R4OXIqwT7pZAEw5p4Qw9LFAEo
         l0zDOO3TE4i06zrtuM7xlHU05FfSs7VwYQQBBFU34JNAQ6ERrGrYf8ojgEsoMhL/R7eG
         SQxQ==
X-Gm-Message-State: AOAM530oGgM6S8nTjfmblPHqWUZMFfA61WkYJn/2b0aIr+HcjMwdAlA8
        zZG+AHrvrS24PoMpo9VJPqXHpm4kxC1B6w==
X-Google-Smtp-Source: ABdhPJy9hiMvnGtT6AbFDLiDYRtbR/3Df4gjY8OhUycTTE12MmhzG80OFpZCq+MU8r59kRpaStmwMw==
X-Received: by 2002:a17:903:32c2:b0:141:eed4:ec1c with SMTP id i2-20020a17090332c200b00141eed4ec1cmr2604938plr.33.1636582507575;
        Wed, 10 Nov 2021 14:15:07 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:07 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 2/8] dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
Date:   Wed, 10 Nov 2021 17:14:42 -0500
Message-Id: <20211110221456.11977-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "pcie" and "msi" interrupts were given the same interrupt when they are
actually different.  Interrupt-map only had the INTA entry; the INTB, INTC,
and INTD entries are added.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index b9589a0daa5c..508e5dce1282 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -142,11 +142,15 @@ examples:
                     #address-cells = <3>;
                     #size-cells = <2>;
                     #interrupt-cells = <1>;
-                    interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                    interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
                                  <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
                     interrupt-names = "pcie", "msi";
                     interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH
+                                     0 0 0 2 &gicv2 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH
+                                     0 0 0 3 &gicv2 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH
+                                     0 0 0 4 &gicv2 GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+
                     msi-parent = <&pcie0>;
                     msi-controller;
                     ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
-- 
2.17.1

