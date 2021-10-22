Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65C34378B0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhJVOJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhJVOJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311D3C061764;
        Fri, 22 Oct 2021 07:07:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so3188462pjb.0;
        Fri, 22 Oct 2021 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bsq6iuwj06pXXhljM7U8duGAiebZpibGfx/z6iMK0J4=;
        b=C3oxmrJLdQJyvbXE2u/UmMh56GtIKnVFUbbbek+adMcBUXo2Jsx5Bp0OK86COwfYjl
         6oNXF6MQkJdRLBop4PBpT74JWoeLF6CvL77w1AqwE/EqQGfbzF8AV1ER1KQhE7e4e8E4
         9HQYVZiaFnsb9tiT/nFRte1xEudbuvXxGc1c/kp9PZhRParOR8Dm/H8kAIUZjNJtuqew
         wdnEvZHd7XGsJnPIwIBEV8huYFWG37tomRsnZaK3ZxLT0kSZ4UNa2xoAXUPh6JhGDWng
         B+KYfUxxO3eVcyrSQ7blsSqSMF+/YPpT5qZT7FQJDHcGEFi6m4Gr2jXvDiqkoRMQZ3C9
         zrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bsq6iuwj06pXXhljM7U8duGAiebZpibGfx/z6iMK0J4=;
        b=zM3IYlaXKeoduGevCkqzIj1fJtzsKpEPHFVq3L50rkoHvjslqWVpiV+94UvTNEjjtF
         MxPJ5I6oaSe43uc750mtwS32PHU8bXkmT23V4AtVLPqgxRIvLkn487shz3O/k/v2Otoe
         h2k4C4w5hEI6+ZEXDJQPqdPszDqNGE1rZYnt7jEaa1SI6/g6NANmlxvAOPPIl5cxrcB0
         AIDN9yXq9ZovPBffGL1TDL0X7K6EkWewmq3lJeD5YjTG9gEYhEwMA6SQY7fIlxoVZlzu
         tN7iQCJAlKioyeGm8Lo5oVYXeeJXkzNAE+/X1cPvdSnnyQHv1UmjFOpwr/0urnWhMlWG
         B3+w==
X-Gm-Message-State: AOAM530tW0R4RBwvtA3w110Dt92j8HF/fHU7JZtQnoQfBQVirOZIzkIV
        nU6SecwwqtbZP+9yCXEctcSW6VapTKswPQ==
X-Google-Smtp-Source: ABdhPJxdUhmGq4ZRKzaK21X94AipnqDq19/Ap75RlGsTHAeeHI/6xlZ2h4zOKCpYrE7eNmTk8pBTBw==
X-Received: by 2002:a17:902:7616:b0:13f:354a:114f with SMTP id k22-20020a170902761600b0013f354a114fmr52600pll.8.1634911642661;
        Fri, 22 Oct 2021 07:07:22 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:22 -0700 (PDT)
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
Subject: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Fri, 22 Oct 2021 10:06:54 -0400
Message-Id: <20211022140714.28767-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022140714.28767-1-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
allows optional regulators to be attached and controlled by the PCIe RC
driver.  That being said, this driver searches in the DT subnode (the EP
node, eg pci@0,0) for the regulator property.

The use of a regulator property in the pcie EP subnode such as
"vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
file at

https://github.com/devicetree-org/dt-schema/pull/54

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index b9589a0daa5c..fec13e4f6eda 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -154,5 +154,28 @@ examples:
                                  <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
                     brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+
+                    /* PCIe bridge */
+                    pci@0,0 {
+                            #address-cells = <3>;
+                            #size-cells = <2>;
+                            reg = <0x0 0x0 0x0 0x0 0x0>;
+                            device_type = "pci";
+                            ranges;
+
+                            /* PCIe endpoint */
+                            pci@0,0 {
+                                    device_type = "pci";
+                                    assigned-addresses = <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
+                                    reg = <0x0 0x0 0x0 0x0 0x0>;
+                                    compatible = "pci14e4,1688";
+                                    vpcie3v3-supply = <&vreg7>;
+
+                                    #address-cells = <3>;
+                                    #size-cells = <2>;
+
+                                    ranges;
+                            };
+                    };
             };
     };
-- 
2.17.1

