Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAED6A1ADA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjBXLAn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjBXLAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 06:00:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8C4C6F5
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:34 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id qi12-20020a17090b274c00b002341621377cso2500458pjb.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VslRr6K7dtSVjJZa6fQapZMGTntHaQJdO/Shpvvg0kE=;
        b=MGOUmbwJgUA1fRVJZwgB9pWpXSaFDZdqmuK/QbXECACx5ema5PaJeJLtueCdGflZWD
         +iVRSxClMuj4nGtJLHvDdO6Q9QcpOyBQab03jB0Fi5EH6oBo+cTRex1svC3RQpI+FRtV
         BwH7n/u/g0zlgDqs4+hnb1sz43b7+alo7Vf5gHBXbYBFt16snBeALQccZPXSGxIN3P57
         skmZO/QNwavAugcQZXxwYqr5tLJYtgeN6XJ+z9GhF8WX+UQlzPkAUzLzaXLM9qk3nTRx
         WeXHm0rRlwL93rLX51fJGDc1bj26EJS8vetwl82uGpYQh17dTbTGfQr59idAdiPKpg+d
         Jzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VslRr6K7dtSVjJZa6fQapZMGTntHaQJdO/Shpvvg0kE=;
        b=vkJ/O9glscTpkMmESKgHEt+QKIbMV3RWbukw+xpDhIOXrK24YPPLboAbKe7FM1GVtT
         iKV5f3o4rEMcACGXqGPTSEILVFhQmumKWxWxQcoGoRT39LCz2sPXEM0T7F6l2BS49J/2
         HfGZiebpyXfr9yiv8xYbPhn0GOGwagLhGBVyAT7oBkhOfClWi9zI1y0SDFBUMVSPNSQW
         BdqCPo7V0YxjBei7J++RAmOUjvJYWFaRapqOdq/zxtOHyhYDfqlH7+dGwVJVBcpMimMu
         DH/isN4oLd0I+midYoiAdQum8YRyX0WEvf71/AP5kyFE57gxDBjraUgE2LrdOo/coCDh
         m82A==
X-Gm-Message-State: AO0yUKXdnO9nTxwwBWKFSfBhfyBjC6gdfu3xXiHyyZpr81wrekBwsmQT
        44K1aowm2g0fWKzWwd1sCX5l
X-Google-Smtp-Source: AK7set+r4n315Ty6V+j5fxdDXOFOvEcth9W92yPHLkj3kMcik/XkG7t/jrX6t5of1AEnZduZqIlfgA==
X-Received: by 2002:a17:90a:57:b0:237:161d:f5ac with SMTP id 23-20020a17090a005700b00237161df5acmr13869044pjb.36.1677236374349;
        Fri, 24 Feb 2023 02:59:34 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/13] dt-bindings: PCI: qcom-ep: Fix the unit address used in example
Date:   Fri, 24 Feb 2023 16:28:57 +0530
Message-Id: <20230224105906.16540-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unit address of PCIe EP node should be 0x1c00000 as it has to match the
first address specified in the reg property.

Fixes: 31c9ef002580 ("dt-bindings: PCI: Add Qualcomm PCIe Endpoint controller")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 8d7eb51edcb4..c1800e44f3da 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -164,7 +164,7 @@ examples:
     #include <dt-bindings/clock/qcom,gcc-sdx55.h>
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    pcie_ep: pcie-ep@40000000 {
+    pcie_ep: pcie-ep@1c00000 {
         compatible = "qcom,sdx55-pcie-ep";
         reg = <0x01c00000 0x3000>,
               <0x40000000 0xf1d>,
-- 
2.25.1

