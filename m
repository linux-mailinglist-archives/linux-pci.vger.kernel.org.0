Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F0444892
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhKCSw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhKCSwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C82C061205;
        Wed,  3 Nov 2021 11:49:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p18so3050487plf.13;
        Wed, 03 Nov 2021 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fkZ8oSbM149H4kVEdywu4YO/VDBT9raRSHF6PBOWSzY=;
        b=QPcXBNaGfBEelci/AS0Wcr0RcxzQXFao6D7dU4xdP8ITMYC6PES+VET4jqDflNtCYB
         hCKgbQnPc0929uMMXzwdO2+7lJV1Kq9bp0kjmQDNxhQ+0BYsEPjdEydMRAivLO5BD+Ag
         DlraZc6+N664tQKk502lx/7cNWjrhz75imYhNdgtDwr2nFlGxdflXUtOedOaUsczWGoq
         vKdR5HP0Ho6N2OZy1sIHBRwvyma9apE+u1D6H2r1Wj2mTDY4lvFh+RitaXqZZ8Q8lKXN
         4ZMp7q0u7tI7CfD1U0bS8OkwlR9aSyeGxXBfjszTUNxaWyAwiK4eQp4lI1XvdxV5UZbd
         p3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fkZ8oSbM149H4kVEdywu4YO/VDBT9raRSHF6PBOWSzY=;
        b=dkO5q6d/7NjWB46a+iW+lHqnqlhoPmRIYM9OhU/xM2Rn3LyoSvvyN0K1+r9bN0n4Vn
         MENUzthHRfM31s1SK64WZHmWLkZ8r4g3E+RDPJriXh3dyj2VUi/In3mnflKP5YsUzaz4
         1LcQ4QbpUlnYn1hbWUkKoMVR7RBZUcA3WJE0mk3PN/IyLLShbEzHciEiQnZQN6GHLSZM
         AajAk2jlmGrPDXr3Rd4CksQNPEWb5BwCEmiPlPs/3NNSRMshRax+yAhz9fUpI6hLdS6S
         MGKM4hn7n2w0l9hH267aGGmINrPXuHEcaaBQQPWf2i5pCPnhSp9FhfzwcnpoY8r1aL4f
         4pmw==
X-Gm-Message-State: AOAM533hVkP6QZjabsbzVcs3m26Dzbc/+tijzlD9BLH2v3o5FUKz9+Og
        PEV7DuANisrowFH6kQcnNnvVNLcbZB/0Zg==
X-Google-Smtp-Source: ABdhPJxcijKpuPZtOgucEvRV6NRFccIYE07lEYWuGVuVxbWcFnVaelAhB7GpMip/bz0eb+SsA1xcXw==
X-Received: by 2002:a17:902:e849:b0:142:c85:4d3d with SMTP id t9-20020a170902e84900b001420c854d3dmr11979537plg.75.1635965388447;
        Wed, 03 Nov 2021 11:49:48 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:47 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 1/7] dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
Date:   Wed,  3 Nov 2021 14:49:31 -0400
Message-Id: <20211103184939.45263-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
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

