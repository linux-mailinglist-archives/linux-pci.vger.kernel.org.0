Return-Path: <linux-pci+bounces-39773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A996C1F1B4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4642A4E93FC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFF2338F5B;
	Thu, 30 Oct 2025 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llJpzuVU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7E2EA749
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814267; cv=none; b=J9zHbPdJ6RB9+qZPEUGjtHxVNoO1mgQ+odZhZaW37eJ8WOoPBhzxbgRouhRgr/xwARVQM6DNixljRN4OtKYTYAB5p2yiQ17OzvdYfmLZYDex2yFxW7ZeYdQct5KG2uxCcaPftMa7ijr+022NEY75h251JzIHsJys+Pao9+qMSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814267; c=relaxed/simple;
	bh=Ab4bFMlRn2+t7TcLaOM9kd7d6OlSqWi3gNKBX8PBHkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BPJVVvY9pYLz7NlRBHPpX0dTSes+S+TWSrzNJWHZacAl8L9+PFV3uGeV/h/vL1zuRNzaecXYIFtOa1eqverRDz9nE5xxZPPtnhPkgWoiu/FYYz+GNoPXxaqQF/LZS8SXxfywtM1wxAJRkRDqBMyzo+r/40E2iKyEDiREHyXCTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llJpzuVU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6dc4667305so14627466b.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761814264; x=1762419064; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fphLVYMAvPJpHfDK6UrhmubmM09SFyL/nslykzGwIZk=;
        b=llJpzuVUgcmuV7n6BUCxqyPBBxA7g3xTc7l6oj9M1mEABhtPD4Ll8/lFg1JRq9J9m8
         SPPj06G4xe4XNcgxPJoe52qK15iWWhWagWfezSyKiepDl6JrZTxcMWCUMWRbKYTUI2AP
         tHzAyhgvJ9Xmxb6DegqUHT5cdL7kYhSth8JlWJL4eDxMUy8h3BYEPPH2r/tQVHAxO6OW
         mUXA6zaygG+0o3h58Uyz/O0Ot6zEc+su61Jb8IaN0M7riGtDYCHuKsYkzyJBKZrOiG0+
         a2/rcLQ52844FWeVEULBPcEL9OWKVYrleousDHfmcGKtHMWahHiG3tB9CFh7Pv/n7XAV
         sjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814264; x=1762419064;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fphLVYMAvPJpHfDK6UrhmubmM09SFyL/nslykzGwIZk=;
        b=tT8jwEZyrIo1u3rwunWPvpS/AVELZ4WSZmR5I/rRCVcl/LH7mvE2MIj3AidvW7OV/W
         ifrigmSDK6j+LkWm2GQItxIIDnMJHYAMsm4NxgDlMtyF97oFXDNDOHMol8fj7jva8/Hs
         T2Bwv+xQx8U4z3QhDNi7jXoeHZrIIlma2VK5H1m24qwSS0tfedZxyzl05MMj1rAnoddm
         g1DxExoMA9/DocIPV4NMH0CaFL+Ol7qFxNWC0QPQl/JHZ9zxBqZi+6AcJHMzInBCKwET
         zBTY3cwzMixRtnpaOfATNfpR0XGuzup++DwIdQaf2BVibMFslmELXKBqIHLZu8tuUBvn
         Pbuw==
X-Forwarded-Encrypted: i=1; AJvYcCWk0XPkL67SsbhYv+l5iGvlsU5nAIxsjfxzk91z+9Ot5kdqH9UBlWkSAWVBhL07bgW0DOss8KW74XI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34elnb1PT7dQ/Ixop3+NxDq1luID6twvdyRlhTiL1QfwfFNpX
	ldxaYKfSIZV+VoqhfBHd3rUXvfDWAzS2Y0A2VeIku4cWIvVcGy8Cp1MGTNODXnuCA4I=
X-Gm-Gg: ASbGncuC4doQsRpd4nSeUGnP0qGUWbclIj6B+fbF4nwrHlJFvCoFASgCZ0GZ964bxBx
	wEWpcZVl7AhCz6qoh4AkSENIfZeKuXhIlzTN4OnZPpQ5AdxtJrvDwppHkEg+/Zc4XJddmLeoghs
	OYb9JuvMboX8vGXW2w2ySxw74A0I5G6Sk3nyJMYzKKtJer1jiEMn2aVwT3ezS6WcaULniNWxYTE
	OTlRTnC1qKJjBsf5oQ5bMkMSPqq8SdhuU7OU6nMJ+uLO+4n7fyr+W1QLUY4xXDbZn7M2dJTCpUL
	7KQTmgIllQYKKvCTfqutVIN55b1nn5jGVelpgKnZ+y2Dcx/XMBk31IjiKLWoA8CQKs/6Gx59Ehe
	+v8u39W9ZFi2Fj0qqBeZUNkPXGaams2gbFyqrMm8xhuyhCiR06UGPmssvqxSJP+URm2Ydpvjnzd
	GCFfP3WNaTGxA1SrAsUrOAvaQb3aM=
X-Google-Smtp-Source: AGHT+IHFbhCJxIHhxK1PfIfJ3CGHx1FwG3numMCvfaT1IhJ+pDSEZ5JnH3CdW8UpTPiDkI4IfhzqnQ==
X-Received: by 2002:a17:906:dc91:b0:b6d:606f:2a96 with SMTP id a640c23a62f3a-b703d30b8a2mr277791766b.4.1761814263561;
        Thu, 30 Oct 2025 01:51:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm1691789366b.39.2025.10.30.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:51:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/9] dt-bindings: PCI: qcom: Add missing required
 power-domains and resets
Date: Thu, 30 Oct 2025 09:50:43 +0100
Message-Id: <20251030-dt-bindings-pci-qcom-fixes-power-domains-v2-0-28c1f11599fe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMmA2kC/52NTQ6CMBBGr0Jm7RgY+QmuvIdhUdoBJpEWW4Ia0
 rtbOYLL9+XLezsE9sIBrtkOnjcJ4mwCOmWgJ2VHRjGJgXKqipxaNCv2Yo3YMeCiBZ/azTjImxO
 6F3s0blZiA15qVddtT0wVQdItno9bst27xJOE1fnPUd6K3/pHZCswR6MapUmXTTOUt4dY5d3Z+
 RG6GOMX1QszouEAAAA=
X-Change-ID: 20251029-dt-bindings-pci-qcom-fixes-power-domains-36a669b2e252
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2135;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Ab4bFMlRn2+t7TcLaOM9kd7d6OlSqWi3gNKBX8PBHkw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAybq5uKkpMdxtoEseaUzYb3uSZL+fy7PNhr1U
 nPiy80XCSCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQMm6gAKCRDBN2bmhouD
 12vbEACY82plr/2mBhTr/qkdJBo+0J2zKAWHMAMn2UGMm7j5dR/tmOp60DOC1zZP5kZJ6QBIAi6
 crJEdgmncJ1ahlWEP3eLVBUvkttmcUonO6eozGNnczKYjTUT7K5JjiJpLHDDgCOzf4y3gPzG3I4
 w8aAxVYirXSjaRz5Tr5kZ1YqmgPezND/8Ce5Dm2sKm8y0OgIf+qAdnQcdmFBBWHpzbbYZRd4J9y
 yp49RXp//pp+CCYDpPXrXCw1IZgSiIrAHzRFxMgAp6HCcryghrjPtm3NJuDeCxJWzZwoCWBEJCE
 eahc4hKM5a+kOqLQi6w0vXij8fx+uVcjMavX9ZWR9s4Co2e3VMVOWFF8RJQsioR8Hl3hdmk+03m
 C3C+AcbssyW/A5PEaftf7Xu9FVIM759ZoQT+CHlB3R1wSbwaIHD2YiUkJWopI5KSZ1OGcyz1tZO
 zx9Z077/bEh7WYakdRWsHZMh4TcGOpipdt0LLE1+PJ30IRnP7NST/5M5PTAkNBIoykDtjIMdyeB
 P5R2HoMXlgvCpmpZGN21ge7uO7kMZid3IJPmTcBxbIwDBJ8igU+9SDoX7GTZF3MlwO8c/2YXODC
 /qUbCsv+5zTtluq/6hreLaPjj+TLXQ9DloOQQDLpfe0ZCdla/yBM/p8N5KEIWg9uKDMYzoAKmrC
 GzZXj9QFLrCEDrg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Add also resets
- Drop cc-stable tag in the last patch
- Link to v1: https://patch.msgid.link/20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org

Recent binding changes forgot to make power-domains and resets required.

I am not updating SC8180xp because it will be fixed other way in my next
patchset.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (9):
      dt-bindings: PCI: qcom,pcie-sa8775p: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains and resets
      dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains and resets

 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 5 +++++
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml   | 5 +++++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml   | 5 +++++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml   | 5 +++++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml   | 5 +++++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml   | 5 +++++
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 5 +++++
 9 files changed, 41 insertions(+)
---
base-commit: 326bbf6e2b1ce8d1e6166cce2ca414aa241c382f
change-id: 20251029-dt-bindings-pci-qcom-fixes-power-domains-36a669b2e252

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


