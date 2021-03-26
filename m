Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0115034AF35
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCZTTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZTTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:19:15 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2DC0613AA;
        Fri, 26 Mar 2021 12:19:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx7so7494312edb.12;
        Fri, 26 Mar 2021 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+IPVj252zmGnilvXPoux9mM7JML4v4YjgYWvZk+Qg4U=;
        b=M65o9wpZ7SLprYx/zb2EPO7FAOIQ/Ty797VhdcmceWkngcB+7pSHLzISYrf3KdX2EJ
         b1WgI02uIFpufwzhj9kNHii/rU+v5v5Uk5tZjx6JPr9Fiq3pN9PpLn+m4vNnpm5OxxuU
         xHBzZFYOKyFBldoS+9PRcjknxEhEZNu9Zdzf76CbZJKIqoefGiE7HZTc6QDwG9jDqcyj
         24o/euWDynZckw56Wg+ay04JD0waBBOpkjVpV/GLf8KgY+e8gS79+D/wt+SJwNNubbTr
         32lfhaXGL6OEmvQ3d16pis2y3VPDfXhqS7bz5e7Ko1JzcVE9sfVV/0Ru3tHDJggRU2h3
         aPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+IPVj252zmGnilvXPoux9mM7JML4v4YjgYWvZk+Qg4U=;
        b=abhE9fK1blhrdRpYBcYaSfNpeuqcvouXzPI0gRDQiraYvtgO5sE2ajqqRZQBJhiDhi
         m854HPUS+d1eQ+6kwAnT0bKVWb48HVuoXvMyVbImjxafPBaYLM6iZ5nzgf5DOrulxJYr
         IQaBwhdEyamPsZDGtKeGSkOwJ/HDUqwatzKg+UYE4+q++6xI+l3GeT6js8NPpT8067vs
         i22DCYrsghca2o1T9wTeq5A6j4j5RXcD3qJRIOVuIygEkn5XiInCJIZXjqSQc6xQeFsW
         A2xVceX/XGisfmax91MRSVmSBo35BAkPYqR6lmY92si0PMV7zQBCLmH/0BmI+5J0yc/i
         nsWg==
X-Gm-Message-State: AOAM533Hkwmv1spM9O6xGuV3kfDc0iOv0rmjDMPD29R2ofV3OIa5YYHv
        UwCAIvL0f/QzIS9RszreHmEjJYLttWs=
X-Google-Smtp-Source: ABdhPJyvLnIpJVd3BHSpVbYfUnsyrfxd4BC0VTfFm56gk4m+fLdCqZ59Z2z/T/FPInS7MN7t71wVkg==
X-Received: by 2002:aa7:cd54:: with SMTP id v20mr16928005edw.80.1616786353794;
        Fri, 26 Mar 2021 12:19:13 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c19sm4739373edu.20.2021.03.26.12.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:19:13 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Fri, 26 Mar 2021 15:18:59 -0400
Message-Id: <20210326191906.43567-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326191906.43567-1-jim2101024@gmail.com>
References: <20210326191906.43567-1-jim2101024@gmail.com>
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
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index f90557f6deb8..ea3e6f55e365 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -156,5 +156,11 @@ examples:
                                  <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
                     brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+
+                    pcie-ep@0,0 {
+                            reg = <0x0 0x0 0x0 0x0 0x0>;
+                            compatible = "pci14e4,1688";
+                            vpcie12v-supply: <&vreg12>;
+                    };
             };
     };
-- 
2.17.1

