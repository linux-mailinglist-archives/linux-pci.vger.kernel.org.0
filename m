Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F95584547
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiG1Rvw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 13:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiG1Rvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 13:51:47 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D8974CDA;
        Thu, 28 Jul 2022 10:51:46 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id o2so1919271iof.8;
        Thu, 28 Jul 2022 10:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=pzdOsIQ1Y26ZpedDpUj1LMMDG9wHQ8yPKUPV4/zQYvU=;
        b=zEoB9EkBX2xu7n1QjSjBWhYNeC/K+rCgx1C20ljOXK+iutaHE90Sxj/XE3WHEXYnCe
         TPq/Bie8FWUKZBxO0gWeV3XJ4tu2yRl/30PE+dwfqqIqratRpvB2uoDcmSZG+x2OucQq
         Yjq6id5eQjcJCQwZbJiXLoVA8rS9y6wkt3gazD2FMDWqUO20QGDcAYDNtObbY90vvrYY
         b4D5DEgTr5w7uolFktSgcm45WBslieROKqo+9p7/x8JFMOr1MzxkFxhwhJGeD/ITDEID
         MLkYghpXtr6mwRobdil/TvigJe1/Ay2/cD4HNGIvVo7wtMVkjbEPzb5Ly9JAcY5sxXW3
         /kxQ==
X-Gm-Message-State: AJIora/UF0yTUsPSUOkc++bzofuM2eWqmfQzPF6MpkojL0WzbTp0HCOo
        t+kbkTXmIHv9LcBdSzQYZw==
X-Google-Smtp-Source: AGRyM1uE8Gpxa1EzQyPI5qU5/FxUiJRmY+OBx4u+FL1d203xvf+27hN3L3hFcxlM8veTQxXRGTHXvg==
X-Received: by 2002:a05:6638:d93:b0:341:5cab:4d9 with SMTP id l19-20020a0566380d9300b003415cab04d9mr11578144jaj.146.1659030704990;
        Thu, 28 Jul 2022 10:51:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id y31-20020a029522000000b0033f3782eccfsm618069jah.89.2022.07.28.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: host-generic-pci: Allow IOMMU and MSI properties
Date:   Thu, 28 Jul 2022 11:51:37 -0600
Message-Id: <20220728175137.1172841-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Allow 'iommu-map', 'iommu-map-mask', and 'msi-parent' properties for
generic host. This fixes unevaluated property warnings on Arm Juno, AMD
Seattle, and FSL LS1028a.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 6bcaa8f2c3cf..d25423aa7167 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -106,6 +106,9 @@ properties:
     maxItems: 3
 
   dma-coherent: true
+  iommu-map: true
+  iommu-map-mask: true
+  msi-parent: true
 
 required:
   - compatible
-- 
2.34.1

