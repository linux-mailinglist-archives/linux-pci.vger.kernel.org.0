Return-Path: <linux-pci+bounces-23054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A2A54A38
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 13:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716E33AC4D5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF0204089;
	Thu,  6 Mar 2025 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZe83yYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D02190051
	for <linux-pci@vger.kernel.org>; Thu,  6 Mar 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262605; cv=none; b=T2zdEv8JzVBy8N1pcoKMFm4A+qayeLHHS34AG4t1YcSLkqeuv604sqKzYJro8WjssqRMNVF0N/5XaGGeSEKIbBq2w2aCC7fXaOi/KmgR7/QPFF4l6Wqzl4dUEaMYRbMkQRWrkn1QcUuwa+GfnurYAWw0oN1HjTC3kRqa11l+LFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262605; c=relaxed/simple;
	bh=gGxnmraNZe8Q/xOLQH6kZuR8AkdvqJ9awxgGCS31jpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdvcGErzQL3c5GemoOoaPTQoMxY47V3PBVk19TTRzqrD+GF/1rGfpAJsRP2Vm8RhSRSGMMh+02BE/abEjOApOIle69aDi6pEck8nHq7Ugxs4lsjIZdZqJYWf86sZ2H45pSJ4uUNi7OuUQdZ6zN3QBWu9VXhZ6R5Sk0BHSFg2asM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZe83yYN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390e0f7b272so80042f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Mar 2025 04:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741262602; x=1741867402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGk2GIgwQpiYu5Yel4uNS+HbqVhI6i7/CI1/SuQv8FE=;
        b=RZe83yYN8/PlXWjqejKOzfvoewsqHIvyVOhCUFf5RrDILogNLW6jP0YTAAND7sZWUX
         8BDyBCg3R/Y8hkvnGoZik/+7+SM/bG2rjonuNOovMlOj7kPRl4C5ThIRifJmetWPGm8Q
         C3QUvOSI5CYPzk8KNjHpcLFaDSYTjr6RTiNyKdQ+Mu+KSsC0Q0FSPaAeJ91iSLwKbQ0L
         lZBI42YuQZ7yvAdPqEXCblgbv31Ze0ktrEjRY5zLMW9jysBYZkzPu1QaA0wUGBwfKN9R
         qlK4iee1r85zFD90RKjfSG2YPFg4QPaiZDfUdjljiRbfyt1gWw2hXU3KquMbWG1JDkQN
         rJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262602; x=1741867402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGk2GIgwQpiYu5Yel4uNS+HbqVhI6i7/CI1/SuQv8FE=;
        b=c9NVLbP9n3bpPY4uVqK1EpPwcZyqHhzaAPX+6SAlPiRfenCgQiQkuoO35lm/DaPhCo
         8/D5B19I814/QBcEU1gTURpqUU1YY1lohJd1RQMW9OTPHkRoREmsH3XSiAlnitVAVQNf
         xy2oonTBochQg55cROTYoB45lgdWjOnHy+nv3voV33CSqPbWoc1mXZArDBI8GprHRB0N
         RaBbYv28u7hknGggzWEwWYgf8I7Dhaq5Gp4acK+mwWUEO3l3cAlT+3pEYQd9aviFff5m
         D8IzMitiqANfckJaXYRozZiMjSKoHwKx6xCpo+L8JwM3kF9jmuB3fwx2EWg3DJGcy+Jf
         FiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdhm8w+oSH2p8r6WV9bEajy59FejN29nfyLPV4LgcZmG8Nvr7QFfcBXKAazediEHtVsM7IZYU9Fvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfS+7PHGFd0iItgcir6L1pc74PbhDfP/d8MEFcG1Dr+mXjzQQz
	B8zmjNTmyvS5hsGAPmWvkHUYXLxZYU+VX5JU6sBPdAfW+S3slXDqHjIUjBOwPes=
X-Gm-Gg: ASbGncs3rWqMUqS+w1Ij9Ez1gHr+F6/R7rgZJFtnLwanvaudZ/VuvioVgSj7y6QZeZg
	wrjcSorHmYDs3/hFL6XS8iwHUUZa0lSDwePctik5V42K/PbbDYBsbpRWc5nuVp5vIPU0o+K6X0H
	hjeJJVGrkFSvJRxBeKLnVnOR+8tERApBgotRWSYhfIHBYJzaTs4FwG0o6R3eM3pMJhwcRjugoNN
	3drdKHpDL/dp64fpOyuAPVYcEnOa1yTR+23sHpHBJ9SutIKXgnf1W+sNYTJrPJdROsUQ67nk+sH
	NYGnDdrGfbu9bYQK53e9jlYueR1XOIK9ef5G6tx+JPvUIJty/hrpAOfED7Y=
X-Google-Smtp-Source: AGHT+IHWVCk6Fgh5QuVOuSqxO+Qal21JaZ2TqyoYfqoerG0z/hBOKoduA4Dwpb7zBfJiHhjp0wyWRw==
X-Received: by 2002:a5d:6486:0:b0:38d:d69e:1316 with SMTP id ffacd0b85a97d-3911f72725bmr2118733f8f.1.1741262602316;
        Thu, 06 Mar 2025 04:03:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2eafsm1886661f8f.68.2025.03.06.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 04:03:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: PCI:: Revert "dt-bindings: PCI: qcom: Use SDX55 'reg' definition for IPQ9574"
Date: Thu,  6 Mar 2025 13:03:18 +0100
Message-ID: <20250306120318.200177-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert commit 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg'
definition for IPQ9574") because it affected existing DTS (already
released), without any valid reason and without explanation.

Reverted commit 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg'
definition for IPQ9574") also introduces new warnings:

  ipq9574-rdp449.dtb: pcie@10000000: reg-names:0: 'parf' was expected

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 829aa3693f8d ("dt-bindings: PCI: qcom: Use SDX55 'reg' definition for IPQ9574")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 6696a36009da..8f628939209e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -170,6 +170,7 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -210,7 +211,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq9574
               - qcom,pcie-sdx55
     then:
       properties:
-- 
2.43.0


