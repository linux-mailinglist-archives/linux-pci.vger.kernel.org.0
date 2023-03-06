Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9292A6AC554
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCFPeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjCFPeT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A26269E
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so9169903pjp.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOXj9qXaJS4g+fALdy49YGqe1mwntIry9f6pr0EizBs=;
        b=O5bjJSoiFmcJzY9G0N/Mt3gXgh6Gp8IMpLyQOrBxHgq5nzAPNZYW/y9HHvHxjcr2Gr
         Sx+ZNkwM11QaoSe2KDWc24V+acgw0X/hJTcOYWMW5KwitR59DIR0qGDU1GTAAXL/xwUr
         rEVYcwUV1RiMLy/dBgdugHpDm/QGmA7TONkMIFsytsqaCOdHOde9KI0qkWZDHR58+tUT
         GEudD6rIbUqX1rQqJA7DtGnPDZe6XJQczXpbbcIyEe+C6dmnxXaRF6IzINzsXJbEvm7o
         C5/We/I/sPE5B0lIAqFCuqLORl9Za9zm5/BANRCfVFlCMXsdKto3GrcJ01bF6C3cyNPI
         v51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOXj9qXaJS4g+fALdy49YGqe1mwntIry9f6pr0EizBs=;
        b=dJveiPxBIfruejmiy6NZE0+ehfyTsWp5p2Qhj3ZsSAgyxDE07FthiBrvkEJq63QSyH
         EvcVbb0LEjoCV+bOe+BMGxi4jn4xN/PJduWdomf9BO0NPqblEt/N4gC0cprpgnq7XsT3
         qi3jZFU4FuyYw2FIdc4vo46by+n7DAqIgUxi4w8FuMwhpUnOjpYjaUZIEWRV642mz2Xw
         EjAWQOO4MVDaAXkDq6x5YJVyurZanvXTPn/puQBBEOh4w569oRSFK3SJIIsmSesGNp1P
         FyLk/RaMgNDgtf4rjUEMz4vEEgycN70YkGCszFBjUWiddjfE9Pudciw5uEg1YPY5b7ME
         /Ytg==
X-Gm-Message-State: AO0yUKV7+DPsJUvO9129qt39rdhPP3yCE6JkORAWhIFMtEgH+3RvOkeG
        B0Zwfy1kbBQKpGhmICq5rdB6
X-Google-Smtp-Source: AK7set/D9pgUx7exlNXxw7fqopGeYzin7aYL14Kdu8M4ifco6YGKADfFyG9jbcTPFAYKVjxbPzGvuw==
X-Received: by 2002:a17:903:2290:b0:19c:dbce:dce8 with SMTP id b16-20020a170903229000b0019cdbcedce8mr14292691plh.15.1678116815512;
        Mon, 06 Mar 2023 07:33:35 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/19] dt-bindings: PCI: qcom-ep: Rename "mmio" region to "mhi"
Date:   Mon,  6 Mar 2023 21:02:16 +0530
Message-Id: <20230306153222.157667-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As per Qualcomm's internal documentation, the name of the region is "mhi"
and not "mmio". So let's rename it to follow the convention.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 89cfdee4b89f..c2d50f42cb4c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -22,7 +22,7 @@ properties:
       - description: External local bus interface registers
       - description: Address Translation Unit (ATU) registers
       - description: Memory region used to map remote RC address space
-      - description: BAR memory region
+      - description: MHI register region used as BAR
 
   reg-names:
     items:
@@ -31,7 +31,7 @@ properties:
       - const: elbi
       - const: atu
       - const: addr_space
-      - const: mmio
+      - const: mhi
 
   clocks:
     minItems: 7
@@ -175,7 +175,7 @@ examples:
               <0x40002000 0x1000>,
               <0x01c03000 0x3000>;
         reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
-                    "mmio";
+                    "mhi";
 
         clocks = <&gcc GCC_PCIE_AUX_CLK>,
              <&gcc GCC_PCIE_CFG_AHB_CLK>,
-- 
2.25.1

