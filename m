Return-Path: <linux-pci+bounces-40107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09773C2CB9D
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091394E58D6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD400314D14;
	Mon,  3 Nov 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQW/6Q8B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC4314A8B
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182900; cv=none; b=RtUOOMQKa+exaYCaEjqJKzrudLZWtdq7FF7wOaGKly/fKC75C4ulfoCMKcGxDgZsuz7EUx9VhW85jpg7FfGiYml67049plyz2p2lgKPMtoCevCL8SJcKlz+ckcxOIzcA69vQa/RsBzdN7zvbFDEWDvoHp8UpUwUnUKG+jLI0Exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182900; c=relaxed/simple;
	bh=8NBFLjzMEgjTDyxAIQC0mdB6Oa7ms21UQ+blpDKfkTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RQQ2lKViVIlLSdfcA5CgoKQG/grFOEYmSWsmuzhM7wsBwZR0q1zTKZIg/QowEzOieOqrulWG1vnFim88VH8De713B5ik0w0hzub8slIs4JDWZzW+dxspo8SOECFu707FN7edPHCtFdCm0wYMJ8KjEpSNALOvpsFL6qncwAMMTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQW/6Q8B; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b70afc39b87so9894466b.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182897; x=1762787697; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGi4/MumABrJMjqvBNuWbmBgVsY5VFid+04xGbYF4nU=;
        b=BQW/6Q8BCVStHUZL1yr1fIVexirXkOb78K8WKxV3UrUy8uHfQ4LV1tpVmR7c8Pj/To
         86C6CW7mME4Svm9J4HsE2VSQrbtiMMgoWPZUxpvWVd1DDYd2kR7cGNE0ZAUXWr8Sw3OL
         Tw7it0JyQBIW9WNtuMTWqvyagmrMBpCpgayCyiYeSVyNxGQfgF0KQWEA27373LaKrVC1
         6yh2es0JDRobtw61VUi/TIPIgsQCV3dg1gxE8h3B9fYedRWo0fmo2GyfZw2eQDs/gOCR
         3HDqayLcX6PTrKDyg8nz/+ZW3i05K3FDFWmDdeP1LE+ta/lrkCIYcFDmHS0TptgMnT7m
         JS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182897; x=1762787697;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGi4/MumABrJMjqvBNuWbmBgVsY5VFid+04xGbYF4nU=;
        b=nZJsjxo6R39sToM4CMNwcGeIbWy6GTWumrrohBHCymKID5TdRv6pnTGZn+f5PYMKic
         oJNh2BnUCL/S4lxQiFuJjMdk1r5TzvSC0sQvPG7JFW+ozNyDGM/iCn5vTtb/9suJE2rk
         PYlXLmGNIpWp+xEtByOYmGrhBNLnid9NCeo2vKjuvcHKEfljamHNImOozTDeybyQnAxh
         a+sNoZarnVS3kvLraj9f9HPDmutJgQzaCZGYZnjXQtX7cuNtPuCDEH3C2IEiUTd3woyE
         g0+BnpOwUUOrT/v03egXdUL9iFc9tMiGT1nE1qdeP5afuql/YwoW38qwg5PTHrRa6PgE
         tItQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSji9DyQrCc+eddJv1/2gs1G9kLMT5TIJkFmD7jPaSnk74w1UrFMLI4bBtb/S3X+eoZcpia8junTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ot5jcFDk4Hs6/8GtmmqRJFqOsFYJNUu2q5uCRX2RT/ndLMCL
	SlAGhCOPqfkPkJHTZASGq90/mSXiI5o74bZfnrzuN3Mp73mKrCFaRy330kZ6qWN0fCA=
X-Gm-Gg: ASbGncvHObU7qc108i9iGPfPI++uIwznefehbgmxEsQprcybgtUeuZy0jn3pp1sILWb
	L0pnpjbXBBX97Wp/uI6CYrNO9u/zxLOSYbn7iKTlxgWKqLq4+THetC/pL7pKlXklNAr6pNeeWM4
	BC2YfsFSlRrsAnnouvED/hcrdsj1UtiOxeyHNnu06g3jDoNlwCqZVpno8YkLXnu4/FEuR2Thjq8
	YQ7XWX/4CQrH0KpTMrjuRPhVsbT+fbHxWWzo4QUXlrBAYsbfqIZjCKc/NpVtXyZ9wPlS2Zz/wse
	88kO3tfd6AjBMDFCXe0bUoAAK5yrQtAFUsQrmrj1gLiKNWCnFcSctqZQ6yoW+ATlcwp8KzPWkAj
	VfwGRdtOQQHcuC8KjQJl960o5K3G/PMEYmGE0AURkBP9gkgZsguDHRhfvHoLbXyqwZJpdv6mE0U
	I5p2TcfnDJhEGQ3ABV
X-Google-Smtp-Source: AGHT+IEt8D2L4/c6q1jdTDxYKJlbkQpEhxwOFjDzoJ6qunqS5xAMVH0vozm3Ngjbg+T611/Y2L59WQ==
X-Received: by 2002:a17:906:f9da:b0:b70:b6f5:4239 with SMTP id a640c23a62f3a-b70b6f546e4mr200213666b.3.1762182897081;
        Mon, 03 Nov 2025 07:14:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:14:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/12] dt-bindings: PCI: qcom: Move remaining devices to
 dedicated schema
Date: Mon, 03 Nov 2025 16:14:40 +0100
Message-Id: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODGCGkC/x3MQQqAIBBA0avErBsoMbCuEi1ynGwWWWlEIN09a
 fkW/2dIHIUTDFWGyLck2UNBW1dA6xw8o7hiUI3q2kb16C60EpwEn/AgwZP2DYm0NqzNbDsDJT0
 iL/L823F63w+cKLA9ZgAAAA==
X-Change-ID: 20251029-dt-bindings-pci-qcom-cc448e48ab58
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8NBFLjzMEgjTDyxAIQC0mdB6Oa7ms21UQ+blpDKfkTA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbjt3er7ucG129PkdA5E8TLG29nLG+vnZR7D
 FnhP5yHZIqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG4wAKCRDBN2bmhouD
 1y63D/9Avm0LvO4w9yYE/ebFsc+SFal8QNN9EOvj9Onab7bqIUuXswJh4jSHnZIL9O+WP3XqGAH
 CypktuH1H+6phnXh/FEWgzjHg+xlLWB8hcQNSSVDnDhlZ/fLyN4e8dRWbaMgYJSOf2Wg66jhsPC
 jDIy6gjxc8D5O9aHnrXH1bZxRAT4U87MGWkDiaUQG4hGmJad80rb1KJdqDkbipf1qH+VjfpQLcM
 1DGT40+XbLt0w2hxR2bRxP6lhfORQUe4BRpmmGeabenn6/KDPBTLT52nA0XccYOvHIKl16Nd3nv
 zRfOspsR8OtjRr2vJ+mxaZrZwhvgFNOJ8ftagWprDSuBv9rzGCxakqV4BuxbN4JyDu8HrGygCc0
 6sp06nz/MS+MtHQBMCegd4niQTKrlHezUoa7N457fU6zM9LPWB5RnO4P17k2CRcjgAAIbXqaqWN
 qA9uXE0UYOetER3cjGZi77ntvxGeJYwMIJa7oiKW35fP26SR2jJEZTCToGgMhx2/E30h/dxGdRx
 zff2ZK4RcEpEPuD8d67ZlG5K3NzvCxqTBwbqVOMstonmyhlbUYgMBMSe3uk+weVAcqWL0yAI33n
 1JneDZXFrF4kzL/DiIsljKxLvN8QtNZzrGpnZL/XuPfJbYAtAEQ/KgB8PpM1uWHzg9upc/tB7pq
 R7ImR3USL2MNCgA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Some time ago I already moved several devices from qcom,pcie.yaml
binding to a dedicated binding files for easier reviewing and
maintenance.

Move the remaining one which makes the qcom,pcie.yaml empty thus can be
entirely removed.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (12):
      dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x into SM8150
      dt-bindings: PCI: qcom,pcie-sdx55: Move SDX55 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sdm845: Move SDM845 to dedicated schema
      dt-bindings: PCI: qcom,pcie-qcs404: Move QCS404 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq5018: Move IPQ5018 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq6018: Move IPQ6018 and IPQ8074 Gen3 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq9574: Move IPQ9574 to dedicated schema
      dt-bindings: PCI: qcom,pcie-apq8064: Move APQ8064 to dedicated schema
      dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996 to dedicated schema
      dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to dedicated schema

 .../devicetree/bindings/pci/qcom,pcie-apq8064.yaml | 170 +++++
 .../devicetree/bindings/pci/qcom,pcie-apq8084.yaml | 109 +++
 .../devicetree/bindings/pci/qcom,pcie-ipq4019.yaml | 146 ++++
 .../devicetree/bindings/pci/qcom,pcie-ipq5018.yaml | 189 +++++
 .../devicetree/bindings/pci/qcom,pcie-ipq6018.yaml | 179 +++++
 .../devicetree/bindings/pci/qcom,pcie-ipq8074.yaml | 165 +++++
 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 183 +++++
 .../devicetree/bindings/pci/qcom,pcie-msm8996.yaml | 156 ++++
 .../devicetree/bindings/pci/qcom,pcie-qcs404.yaml  | 131 ++++
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 168 -----
 .../devicetree/bindings/pci/qcom,pcie-sdm845.yaml  | 190 +++++
 .../devicetree/bindings/pci/qcom,pcie-sdx55.yaml   | 172 +++++
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |   1 +
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 782 ---------------------
 14 files changed, 1791 insertions(+), 950 deletions(-)
---
base-commit: 503fcb70f99075032f5bbf528cec4650cb7dd7d0
change-id: 20251029-dt-bindings-pci-qcom-cc448e48ab58

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


