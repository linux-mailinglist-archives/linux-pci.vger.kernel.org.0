Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC786DDA8E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKMPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 08:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDKMPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 08:15:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37DD3C16
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 05:15:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id kh6so6054093plb.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2023 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681215341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl6l4pmsVIKYsgnNA2+nACABPsEa8mbnnBa/Av4PeQM=;
        b=xWYHxr5HtfgeiK3Om+VC8yvjGyC1aXQONqcDB4WqO5IRE24MbwxPoFa+tfmj9t0YDU
         RrXLj21NztqOELflD7ho3wDonXE3pg6fE+vVOxpIR8hsLgRyb2oOi3Ag7G94Tie1511N
         bCiBez8s9hpAbtKWsorpQgYxNZ4XQzALO03BNe4Md1gOe2bIioqYhvpcdZP2orFTf4F6
         WcyJb0I95p7zNr3adPihAR9gwQ2hpntSpyfUfIBX/jvxPuiBB67oP1cWBCTdxuGpO/Wn
         9nuws8n6EgTDePJFaP/DgL1wOLI1uGVeQVE5ACTtPusqeYCN1mz+JlppufZxzwiaG2Wt
         wsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681215341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl6l4pmsVIKYsgnNA2+nACABPsEa8mbnnBa/Av4PeQM=;
        b=Z4ality4FocHATUykFy93zgEPhctRHkZk7Qari+NV0dgG0AHSzWfAqslrejSm53mQb
         Auw8bnwp37V7KnZn5PmvbacalfUTKU2Cs/P7qbAA/wJwIP1OSBZa3aKmxuXjm770WJxf
         Veg4f5STjknlNTdb21/v7EVzesgEpdiF5w5Mb5avpO/j5L7GYtFaav9+xMWvSWPD7HkH
         4iyjsflq75iIamQtNLsM0RNcfWtEAbrCK6rXIbAbscQBvnKIc+ClPUd1tTuJBDj2NV2y
         AcbXWST7beJ9Mig9seZMsnifO2ZGa/NS2zOBjaQI0DxcjOtcedOH+Sd3NJqDy2pE6F/l
         m8AQ==
X-Gm-Message-State: AAQBX9eVGVS8GvZUWm9p/BmPViis5ienciSQguf9Ii7wr3Tm3NGaOCtH
        0PomevDCpO/QmhhZo1MzVjxd
X-Google-Smtp-Source: AKy350Y5ZPEcFroY7YBGQtp21m1/nnED3TktLrG5ktmD6zwCyz7sBUsShfHcjgTxcB3ZMyW2k0fhLA==
X-Received: by 2002:a17:903:22c9:b0:1a6:3d6d:3157 with SMTP id y9-20020a17090322c900b001a63d6d3157mr8819044plg.62.1681215341176;
        Tue, 11 Apr 2023 05:15:41 -0700 (PDT)
Received: from localhost.localdomain ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b0019aa5e0aadesm7238309plj.110.2023.04.11.05.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 05:15:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        lpieralisi@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] Revert "dt-bindings: PCI: qcom: Add iommu-map properties"
Date:   Tue, 11 Apr 2023 17:45:33 +0530
Message-Id: <20230411121533.22454-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 6ebfa40b63ae65eac20834ef4f45355fc5ef6899.

"iommu-map" property is already documented in commit
("dt-bindings: PCI: qcom: Add SM8550 compatible") along with the "iommus"
property.

So let's revert the commit that just added "iommu-map" to avoid
duplication.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5d236bac99b6..a1318a4ecadf 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -78,8 +78,6 @@ properties:
 
   dma-coherent: true
 
-  iommu-map: true
-
   interconnects:
     maxItems: 2
 
-- 
2.25.1

