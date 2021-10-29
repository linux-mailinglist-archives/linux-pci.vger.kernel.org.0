Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF814403B3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhJ2UGA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhJ2UF4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:05:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42002C061570;
        Fri, 29 Oct 2021 13:03:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so7948161pjh.0;
        Fri, 29 Oct 2021 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bTzdKFlLFxjEYXsTCiwTs/u3WhqgR0accwfx+BQVxCI=;
        b=WXLrJc4CiRZzhTY/aUKgXzjL/YRIDCpia8+QRg5wgkZ+erdxhdGaP+zvm/9sIIZCAq
         WJbfnkFPMqvqYNWJe+RvA6SR1CvAWIsgYt1/0zIppVDUqIRfXfcpL5LRQzyWX3eEwIqT
         3jVjGidOjJ3cg8vLd2OZwvg8Dy2vZ2zTiDLcQsQ68yikhhp3zU2ZGxEkAYYesyXloqBH
         CqooGtajNNxvdN+4urd9szc0hKrSQDOiExMtVc2as9pAaFKmh4OHsxwM5PsxZLxJLcrj
         +3/WP/G4xvESLKeyx4e7o50gJVB1LvbSTLW9kxfA/kL9JEIVUd97M0Hh1+tA3VAGBrVh
         xO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bTzdKFlLFxjEYXsTCiwTs/u3WhqgR0accwfx+BQVxCI=;
        b=lHjIxh6+ZH25MV2DBkaU+x97vAgA/8Iyx1NAvnLL2HALmLIUSxsDdbeUQLAQX4xVnf
         c31Deev5Z9yn0ryEzYoRnyUf8KOsrBIdpHOTnZxOpX8jHoGTsC2II/yFD4646KypnCtM
         rILEs+M93209x4i7Z5wHYG9hWMYJQFFkvA11tGmPDteBxQiaEki6hntc1Q8IVzPbP+sm
         7bFrlU84gPFdavg15TCPnusXb1iINV+U9IOYIoYneqlaYdA9GIFXs4qkFVTJ9gpIHwcd
         YIAGKRX3HjDbQMfH9WBpp8ZrV2LcPcmtaOHq+Z5cdP9ul4G9crhdMAFlDCX4Z/8mzZor
         dX3w==
X-Gm-Message-State: AOAM533k/dIlHB0jwtRX1TbYQ/xyiM6XRI9EmeQg9QtJvJ1PuQnHnnjD
        MQTtqSTwjEjCoNw+vgDTIIGJ61a2RQ1uJw==
X-Google-Smtp-Source: ABdhPJxwNDSSmjNeJqV62003+UnO4NwEwDL1ymH1lO6taFm2VcGBtdhV0XI4gNiUZKyjtwz7IDhV0g==
X-Received: by 2002:a17:902:6b83:b0:141:6368:3562 with SMTP id p3-20020a1709026b8300b0014163683562mr11401897plk.42.1635537806508;
        Fri, 29 Oct 2021 13:03:26 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:26 -0700 (PDT)
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
Subject: [PATCH v6 1/9] dt-bindings: PCI: correct brcmstb interrupts, interrupt-map.
Date:   Fri, 29 Oct 2021 16:03:09 -0400
Message-Id: <20211029200319.23475-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "pcie" and "msi" interrupts were given the same interrupt when they are
actually different.  Interrupt-map only had the INTA entry; the INTB, INTC,
and INTD entries are added.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
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

