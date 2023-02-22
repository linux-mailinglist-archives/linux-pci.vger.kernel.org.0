Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1869F7E7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBVPdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 10:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjBVPdO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 10:33:14 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20D38B44
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 07:33:11 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id l15so10302754pls.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl2oK6m3W4idoG0++YXdR0eH/S7JB1Clcx3ixNJBnNA=;
        b=nX0UqMMW/E/UxVR2q2VD0VyQdZv/U42NNCRZwdTFx0DjM8Qyqtsg7ufdwoour0UicS
         wq1ZzUObu+TF5PHoVoH5zuoCj+k+M6DRqLhhkkmn11eyzeyNegyeA3TmxNu/ogBgVA7/
         TF6RzsorxQ8e8lMsigtdFHwEpXi4mTgucncArvai3O1Lug3RECeqg3q1w+2xQxjjTM08
         teK5+it+Nt0pXvwNWzSSGnmX4jp+A2iKSt2gOCmG4oEctC65y5rN8zZXxifQ/K7yhbDd
         ph25MXMBSO8ZE6ZiZljWEha52/6TxAARJJRyadNQgbnrkgBwtnt4RH+jiGVf5rh+jEGs
         ckbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gl2oK6m3W4idoG0++YXdR0eH/S7JB1Clcx3ixNJBnNA=;
        b=Sxz9ubHeYFizoWPdQ3+wJFBKhYQVfD1OPriNmJ+WTXyuBJonBOoMulFCqEu5uroQHX
         j1kLIwLbF2lz4w1yJ/TjZHUShA0ZSaqG4dasW8tLmgkaiODcubgYAkOe4wg8ZelNpgHH
         cHSegAJ+03CnuNo1yO37wwBhimMDGpzZaInTC+0Hql6gdgW6LdIn5tox+0Aa3Xo2Zt8K
         15vDodeSbQQj329ZC2iIzZ4QBhUcmX9QbMmJFwmJf/IhIXhrVLL4MGlAQB1PHcxwE0Bk
         XvCcMYpULEltPACLTbBYNQNFu1k2cJ25X50+3cNoWi1f/Lu9zUU2sY6Tv+wGGEr/pk+f
         2+mQ==
X-Gm-Message-State: AO0yUKWgvvghTjfKqUVfMru8wq+n81TW6VSDx36pt+Maa6lVm+CN5Gse
        o3HzZIRkxztz6O2Qie0u7xGa
X-Google-Smtp-Source: AK7set9WVD42hOyS9N9jO61XZ88ae5caQzTdmddlRBoTHPQZ+QttHFEtj2SdZp7EPHxzDn9YD9Gb/Q==
X-Received: by 2002:a05:6a20:671a:b0:cb:7ae6:b42f with SMTP id q26-20020a056a20671a00b000cb7ae6b42fmr5975151pzh.62.1677079990532;
        Wed, 22 Feb 2023 07:33:10 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 01/11] dt-bindings: PCI: qcom: Update maintainers entry
Date:   Wed, 22 Feb 2023 21:02:41 +0530
Message-Id: <20230222153251.254492-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
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

Stan is no longer working with MMSOL and expressed his interest to not
continue maintaining Qcom PCIe driver. Since I took over the driver
maintainership, I'm stepping in to maintain the binding also.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a5859bb3dc28..a3639920fcbb 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -8,7 +8,7 @@ title: Qualcomm PCI express root complex
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Stanimir Varbanov <svarbanov@mm-sol.com>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
 description: |
   Qualcomm PCIe root complex controller is based on the Synopsys DesignWare
-- 
2.25.1

