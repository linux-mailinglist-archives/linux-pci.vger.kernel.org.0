Return-Path: <linux-pci+bounces-217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9097FB450
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58560282370
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E9110A32;
	Tue, 28 Nov 2023 08:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rzXrRXwM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495641A3
	for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 00:36:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5094cb3a036so7057917e87.2
        for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 00:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160617; x=1701765417; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndvlHffn+v+7jRpIhr2PQ0zOxK49/EI25GTkz7n0JYg=;
        b=rzXrRXwMse+hL/IS8rQXfGsWgbtnROBLXA4udvTw97XvZ51PlMDzMUsgrAAagcHs1Z
         BJOlD/DBYM7MNeRaAQH68h+nIUzioiQ1ia1NPsPSPkQEaiZETC/oOJlQOlb0Uvhf6ujO
         zGmZf9JUGhW94ju1PuOqygpmPfc3dB9KM4b/joI17QWAEUyV534ftf+y1SKxmjFNF+Pi
         RGKkMBWpsUW62r0tNWl+ukriDUqhkcxsn+B7fzmQY0nzyfNFR+W7x+SLRCbK6J57wRAT
         vBbMH9YWw6PtGtW9OVszzX5i8hVfb1mN9RP9eXSkM+YRZgQbUGm0YF5vFGH6qvmVdw2S
         /ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160617; x=1701765417;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndvlHffn+v+7jRpIhr2PQ0zOxK49/EI25GTkz7n0JYg=;
        b=JIwKAb6vCjxAm69Sn5de8teqIUT7Iq0WH18zOMMD0Uk2uN/H6DWZy04C+KdgC5CR1z
         o3Ubr7oC5pNiMAthOStKoLQq33ELQ699FU2Z55gD0oAgHL8FC32lYh5upeepuzbTckrf
         A+QyX8GAk4TrU8XieCzdb0CWT0nbTi3PGd/FAgq1PRXcXF+y6N1EaUVg8A/FMTOdrHzc
         9fZcZdSLGmb1tzexh7TZRwQ/s081OtnaIWbQ3I54fhXPMRQQmaijdZDmPFmyyZy3d4AV
         WN2EYVE866p8GI80EDzv4vbU6L4XV7Db7NsTZAAvFeb81Va0gWe6TYNf38yY5uF5bQxB
         B7Eg==
X-Gm-Message-State: AOJu0YwvLkfaKoUogzFibMajRA6eOafYNykQKt0PXIOGfApS2S9CyjYB
	LN/dKLBahD39NoT5H1vcWC7RsA==
X-Google-Smtp-Source: AGHT+IH3naDiSAvMe65JEiUJ41gZDSqerHZJlISGg2SLDjWoDzje6LCP07SmqxC7BoqRB9JB0du7gw==
X-Received: by 2002:a05:6512:1386:b0:507:a9b7:f071 with SMTP id fc6-20020a056512138600b00507a9b7f071mr13195200lfb.1.1701160617415;
        Tue, 28 Nov 2023 00:36:57 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040588d85b3asm17390529wmb.15.2023.11.28.00.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:36:56 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 Nov 2023 09:36:50 +0100
Subject: [PATCH RESEND] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-topic-sm8650-upstream-bindings-pcie-v1-1-9c803b439952@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9202tyaMMRdGcdJf/JRZ0vhX+oG3wOQczHTXpC7CSu8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlZaanrPZ4eB3vQ9G+ZXaEF6naExHNnSvlxOAbGMkH
 JuEn2W+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZWWmpwAKCRB33NvayMhJ0fpFD/
 9ajTKwAHyrK3169CtWuLrK2jizVnpbTvGTMo4pbUyk8yDZCKUGP7aDtHj6kLD1vSZR/Y49MnBeiMba
 /Hwx9wXRqLL/R7Exd+ZF0YcjZsy/hNe+CUE/AcR19pcRwQfHW4E0D0V3sn23kRalKDJOeR+SHJGH2a
 fyOptO+FdjrAvZ0Tnn004/6hdbrIflbupjpkcCLZCjIliitzz9lxLZz86+umD1FxLn2tKixtdcyjN5
 kuy4uTh+5a2hPG0VB9/Zay9kU5nEruocuf87H/llQBVdk4YxHNxV9TeCN12tlWlFIkBkqiWE3JvGYM
 dvm54f4jD0pFg+IvwRrGScHnTmbl53H1q3lgiG18q8zswlrt7Dyp3ItImxXiAwKV9JWMZDE3/4QeC2
 71s2+NOYy4Q7Gfwj6t5P89TTsBXvj0/8/r4CQCVirQNfwx9n2HgC6uYQKCQmVRE06gwDlLQAoE5JqL
 NEyMuOaQRIvzQM4ZVtiTtv3WYETpVSCWdG421PMYv6o6PoNdN/VN69+4gO2mgYYi3GGRQqu06hlIr2
 /8j/UItWEKdZVi3GkSeCHyXSd7VdshNfNYZe8D3Sca0sGe6UU++h2KjjgrKsRnvqInZbCQMR4cYAkB
 RDBR2Jf7syf26uPh7QIxZJw6g4PHjz+04DOjNkZ1kfuKYw7bVP7mNX7wpDpg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the PCIe Controller on the SM8650 platform by using the
SM8550 bindings as a fallback.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index eadba38171e1..af537732ded6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -41,6 +41,10 @@ properties:
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
           - qcom,pcie-sm8550
+      - items:
+          - enum:
+              - qcom,pcie-sm8650
+          - const: qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996

---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-bindings-pcie-56e90536c258

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


