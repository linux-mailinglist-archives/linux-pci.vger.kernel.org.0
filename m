Return-Path: <linux-pci+bounces-2712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9AE840390
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FE8284E89
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852F60251;
	Mon, 29 Jan 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xL8VnNzG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12A5B213
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526644; cv=none; b=YrUKHRHOIS1Nf0J1lpv1NZqMFvsytkKEmlzi7qXYhrpxnX97fVAHPalqlGfbFCcTNmKNyjVXDlV86LTU4Nz1A+jdkWU84RPgM0nWuMFAalhhZ4H3h01XzSSy0HTdPUvhpSx4mEPcO2dEGkD7P14iTpgZqqpxn4aFMGBv5flToi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526644; c=relaxed/simple;
	bh=sa4E+CoKAN/LlXCOMcKVwg7cxW2KNFDdu3uPIropwl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z9dYai8yo/ISgCeiP5OvU9TXSp5q7cgb/yyC5HgJA8lkPcjFmK0XhasbatXzoJr3NTIRDDwATVFfTWXltSGC/H+xcv40TP0UtLkHafIGzBkeuz+CV4knd0aecRjtTs2h00sI7cRDdDP+Y88kTQpu1HiTushHuFAvgtZA0Lzpj98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xL8VnNzG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28a6cef709so307073366b.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 03:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706526638; x=1707131438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4SJ32iyQg/UWstplGgnSu+pyJqIEZM8JZ0B98PjYHE=;
        b=xL8VnNzGk8TyB6Iu1suJFHNJ7ewans2L1A/MfkKdxuW2HKlJ+kv2JqWCtRTV2le2Ie
         CfG+TUECGrAlkdmi1+jSeQm2VLKXdk/kAfBeshJVbUOs7SsJ57d1SWcCpGlUlYY1bh4d
         vtNhnZk79drqZDWe/KbpMmVoW0LGiZUa2+DjSC3S4G6cGXmexlz97U9fYZTj7Fwy3yAK
         VtkrMDLZ4GndLt+viWRgTnHflEJrd8+Jz3L5NJ2auQARD+r2vQ2+kjY1/l9XlLmUo2rW
         XfeoJ9yWYEUJrOtEKbZaoisHs6zMX7JrGox7kyDmE4JHdK8BJDFySuK5hP2RBQLRZ90o
         RwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706526638; x=1707131438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4SJ32iyQg/UWstplGgnSu+pyJqIEZM8JZ0B98PjYHE=;
        b=ORNc3cpiYMFpiSCcUGyMvUdjDtLqA4BVLVDTUUoq2zrVHGmF6wxKa3IFHzpK8rROZ2
         LVJSTcz0x8qJhGa2OHJ9vj5vkAOPi70G2/xNvz2VhMB3apljFacj2dYROvTPaK+P15ry
         nf2lOGGeS9/hBfeUqBkFbGEWTg+34+yY7jQ92iqG4GQ9T5EZ68EMrXCucgx1wp1dLWZZ
         Z3dFP4sq+Pjo6NFOk0J2MTlb26eipDoK1XcBm1+lRXWegI3N6DsXQUsfJ+s8BJb+x5ZQ
         4mvSWpOziXGpiB3Seil902wNE5vS/yc8wFPcz3+DK7kXnmFQ30b/tpxi+UaMfVVS5J9T
         rXeg==
X-Gm-Message-State: AOJu0YzN9lPGE+Waseq/+vAmU1coko04JOfsryrWk2OUR18EW9tW4g0f
	s0KLZ+bwtN46NGQp1q/X4gr5iNmiYX4JmLKGoa5ZsJHQCxvqDmdPQsA/GRHdGv0=
X-Google-Smtp-Source: AGHT+IGdRIhytUQuCWuGECa23nBQpCFG0Gpy1ikLzNadB9MbtaYP9ACSUsjUGeNTkyw/dBcfPDt6nQ==
X-Received: by 2002:a17:906:494b:b0:a35:d914:c33e with SMTP id f11-20020a170906494b00b00a35d914c33emr783314ejt.52.1706526638475;
        Mon, 29 Jan 2024 03:10:38 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id tj4-20020a170907c24400b00a352f7a57a4sm2934620ejc.178.2024.01.29.03.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:10:38 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 13:10:26 +0200
Subject: [PATCH v2 1/2] dt-bindings: PCI: qcom: Document the X1E80100 PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-x1e80100-pci-v2-1-a466d10685b6@linaro.org>
References: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
In-Reply-To: <20240129-x1e80100-pci-v2-0-a466d10685b6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2268; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=sa4E+CoKAN/LlXCOMcKVwg7cxW2KNFDdu3uPIropwl8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt4epwCtmMzZ2Ir+cckMPH41sUypK/5mvakXj+
 I/pfUGdQqWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbeHqQAKCRAbX0TJAJUV
 VqfdEADHyiQfS3v+gZkvdIdKUFS566uOhaOc9iT6Sip+116mVjNQYQhtg5Nxgvthyrm2B9LQs81
 v+Tw67Ef7RtrMxzLri7NRq34p9lpo6gqOGHU9mxA41jaFX1SJ5Ozt9eANkU05ZmHIr8wEkl9UoG
 HWpcqgnUMuBfFcnZKxIlulAnx0qlVogbdjjMShTiC6B+NNMoFbRBt3kwHE/QLwyj/YEsn+G1ml+
 qDRHFnWGhnG722nMcfJWqxGA5vIkOu2t4O+zTtlq0KRL4gmoA9asgqvioqmMipXgo+oWUsVG0t0
 2BWdMazV7RBtZaa6qWevnVQ83si/rCb3gPvRvfrnCo5Lbpe9/4foBcM2QxMfLedwysFlQeCkJJ/
 UA5FDSkPvfEGtSWu7hbK/uElxgajMnj0LXG0tn6FC5gspj51Vf/hXpi2YFIDZ+VzCnqn7FI/gBb
 ZLvOiWGlag7022AjJ6RSWg6DeFkBWmjptEByk7ScSFjCm/qaRRm4pZXv2wQHEtFpuD//LFby+9m
 pgaBdIe6z5dBOsJnIlnJ3ZPx3Wcf5qXr9e/I/d+xUJWPyshCT4RfDhZALk8FoMLKtvnVC/OKvxm
 c2ZxCDebwjKfEBXGD1yX7EKYLZPHb8p0PYLc6ajgM3UGP+Xud8MAUbuQTripPlOHUm+zqZM3Za9
 dfNl5idsFES4tkg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the PCIe Controllers on the X1E80100 platform. They are similar
to the ones found on SM8550, but they don't have SF QTB clock.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a93ab3b54066..7381e38b7398 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+          - qcom,pcie-x1e80100
       - items:
           - enum:
               - qcom,pcie-sm8650
@@ -227,6 +228,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-x1e80100
     then:
       properties:
         reg:
@@ -826,6 +828,32 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-x1e80100
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: noc_aggr # Aggre NoC PCIe AXI clock
+            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+        resets:
+          maxItems: 2
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+            - const: link_down # PCIe link down reset
+
   - if:
       properties:
         compatible:
@@ -884,6 +912,7 @@ allOf:
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
               - qcom,pcie-sm8550
+              - qcom,pcie-x1e80100
     then:
       oneOf:
         - properties:

-- 
2.34.1


