Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBF53483E
	for <lists+linux-pci@lfdr.de>; Thu, 26 May 2022 03:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiEZBlQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 21:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEZBlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 21:41:16 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C7168FB0;
        Wed, 25 May 2022 18:41:15 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id r68so599374oie.12;
        Wed, 25 May 2022 18:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A02iGMaf27yGbMZhMqSFpeR8OkXTiFFVWFYk5yTUzJA=;
        b=oSDHxBkihsP4lcYvoiuz8eEDsAgR3uO+aRJZbVqzDt0TjwjWvs6KEDM+WCx4skSBhW
         RGHtwk4IgSB2aJtouYUq9AvgvZVnc1bfK+uc4qqrv14enGdYovMQdCo2Wk1Erdy+L+LY
         7bOIRNCC9WamlbIiegoI6YtjEQXs8MBpBqxpCsD+OPcmTfbw7YLaHcmbCzrsQjQZxYUs
         es0HZJC848+Iidc+nl+6dFvt5kWwISxWm/shMBGG25LJXGxQEjvTRdlQUgNccRAl25Mo
         qf+JvQTn2x1mSjtXbNY+VK6WUXQzs7HEI3jJSM8I8jP4CMKiD5ME4vWi8CRa2lt4R3rj
         /grQ==
X-Gm-Message-State: AOAM5332jJTPRK3MW9a5h0oWxuthnIw6ulCw7GjnEMdQlIgH/cNBWswj
        kj9sb4oPejoCWaYDfHIguvSP+VSgEQ==
X-Google-Smtp-Source: ABdhPJwqP0nSidJzNOEimbuuMwlo1M2iEBuCWIWNKu0fH2zvvzUhieBuLGEupohAwEL96Kqe5qbOUw==
X-Received: by 2002:a05:6808:10d6:b0:326:d4b2:83b with SMTP id s22-20020a05680810d600b00326d4b2083bmr11901ois.92.1653529274647;
        Wed, 25 May 2022 18:41:14 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id f21-20020a0568301c3500b0060adcc87e37sm96312ote.74.2022.05.25.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:41:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: apple: Add missing 'power-domains' property
Date:   Wed, 25 May 2022 20:41:07 -0500
Message-Id: <20220526014107.2871787-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 'unevaluatedProperties' schema checks is not fully working and doesn't
catch some cases where there's a $ref to another schema. A fix is pending,
but results in new warnings in examples.

The Apple PCIe host has 3 power domains at least according to the example.
Add the 'power-domains' property to the schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Ideally, we'd define what each power domain is, but I don't know what
they are.
---
 Documentation/devicetree/bindings/pci/apple,pcie.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
index daf602ac0d0f..2cf6b4586071 100644
--- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
@@ -68,6 +68,9 @@ properties:
   iommu-map: true
   iommu-map-mask: true
 
+  power-domains:
+    maxItems: 3
+
 required:
   - compatible
   - reg
-- 
2.34.1

