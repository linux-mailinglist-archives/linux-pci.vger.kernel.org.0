Return-Path: <linux-pci+bounces-2569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6112683D673
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FCB1F2BC86
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A3286A6;
	Fri, 26 Jan 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpdc6epy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276613E225
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259416; cv=none; b=kmRqRd3osSKu5up1HdKevIvWH0HZLvG/ynzy5zLr87q04kauTHITIUqy7GlMs2saMTbcIWffN8WKscDyVCF8lZ/5dMoFIjls9T9L48c+9N/Z+JCey8HvQjZ82ffDSZ/8ff+zUisr0Pa+u0TG9kJUjrU2s407mK8g2JASftb15tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259416; c=relaxed/simple;
	bh=MKKjC6jIpNRUDSBems9jU+ydUbjTp0Ejd6SJvR4oqXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C67ZLkEFMuBnsG1mbVNV7m4/c8no9LftIC13LJdJeQuhSp/GtT/qYR0hjEDC06tWiFYDcrT9jJBz8X2Z41Df4Q+z3RCHhU2X84mYvSwaOd8xXFd3VK4NC+Lpdwk/Pw9hDrOOlVc9vukMfQzdwbEsXpzHv/VAZ0gT5f8GRAEY8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpdc6epy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55cec718c30so105235a12.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259413; x=1706864213; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb194lkKB1bLoKzQ+FGE1tNJV63QbV8cNld779JBX9A=;
        b=wpdc6epy6otlEIMyqeHKnfrgAf2KMl+3oJ4dBPiqMcvb03Jxr5AVoTWtZA60FipvYJ
         dg7LjDyQFNLgrhY3Wns8pTkbX5+bVeOF1Pd7uKMJH6a8eF1n1nC8vpxvgq+8JnMx6d4f
         yZEddM2ywBqNG+m/Q0K2GjOT29AettVJNE5D5rbPf67Nq6HNUtaXhxsvuCYtmUqCcacr
         pVyCiz9omRCg808vJb5jB1YjLrdfS5tAxatuDO7I4A5cKwEv1Xyvri87FSFrLSGc+UYo
         A36SB10cKmrN2d0hjN8XOVwSmo9gE4lnbHsC8VaZsj/uXwyzboK8V26nWeMT+Caqx0n3
         aytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259413; x=1706864213;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vb194lkKB1bLoKzQ+FGE1tNJV63QbV8cNld779JBX9A=;
        b=VusvfjtEDcWj+wQL8oYpn7/FC17tfRG2sxCbXHt9jlS2bMQo72tcbW+kVib74T9D9S
         LfVhBdI/AfIENXFz1B44KtNsgECU8gNrBlbtIedQYm4PNru1P+6nOixaygiZcpdF+kPY
         h4tbauEt1zogSe/+ly6nIWpK3aa4OVIBTkeUDiIAGV5N3Ir3oUYXKzc96Tg2xbc9f4MT
         c7igjM/AfUc/T9P1n1paW1tC37T9gO3F7iCabFPqyMfeVtctA0Y8XuUJNq1S3lKHM3UL
         tMkEKCgozBUmEpLquxs5I7CurWWOGuKz186lyy6vSjmtCm3Xi14wXan5yCTMPOfZXqxR
         RFsA==
X-Gm-Message-State: AOJu0Yw0fOOf7woO4tkara/W1abfeUe6zLZGax4ZwoNSHQ9rJJ0X743A
	bJZYj/OkpkXZdB+LL7NK4I+0tbPKqgKjbWKhA6ZVjvdoMM2/tXu+N57XLTYLJD0=
X-Google-Smtp-Source: AGHT+IFmuhyfC2RUlwyNFF5e4E0qfwU7+jAR2ruSi+N9MqxMkh4+3J10M1/wq8MzR5w1hbA9hIGCTg==
X-Received: by 2002:a17:907:767a:b0:a2d:9379:7fe6 with SMTP id kk26-20020a170907767a00b00a2d93797fe6mr478368ejc.61.1706259413263;
        Fri, 26 Jan 2024 00:56:53 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:56:52 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 0/6] dt-bindings: PCI: qcom: move to dedicated schema
 (part one)
Date: Fri, 26 Jan 2024 09:56:41 +0100
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMlzs2UC/43NsQ6DIBSF4VcxzL0NIIrt1PdoOqCA3sSCBUPaG
 N+96NQuTcf/DN9ZSDQBTSTnYiHBJIzoXY7yUJBuUK43gDo34ZQLymgDeoYWnUbXR5g6hEfn7xC
 nEWeouZCltLJVtSQZmIKx+Nzx6y33gHH24bV/Jbatf7GJAQVdCWZpZYU29DKiU8EffejJ5ib+Y
 fHqp8WzVbdVY6w+MSXVl7Wu6xvyqjIVEQEAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MKKjC6jIpNRUDSBems9jU+ydUbjTp0Ejd6SJvR4oqXQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PLd8yQ5ncoVHzjUyAg4elRjb+jHcgGKrymB
 q3dJFqQuLOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNzywAKCRDBN2bmhouD
 163bD/0QlrQ93tdsF0JT6znrhvIvIMUD60bqyubg4GqAClV5bWlg7dulzuN+ehkFq5lTU6fB+F4
 qzx4tXtBTAfLU8JKysnVTXSQZ+8338m7bYJdDRHVLk4HudDHCMlTH5K37rrYV1pbNrT7SGcEQmP
 zKv+3wwIVniz1wJGCDGUgscLUPiT4YXDC1W8Y69hKJteg6Fhgc7NnPlx3ilOJ0dQHN382GAPXWL
 XfELpBkeVljIrEjTwphGH3N4cwCDEHU30bnetwmYnkw3f8CI2j3sNSocOyTQJTaH3EDkRU6KcT7
 jW3o9NojDy1ma7KEbdMRUTPHj15Skr8Ing+u7xNpXNEa71SlJeuykT0IxrjX7yz4kVNAnKCaI8P
 l0G7PxBwe8VPCicOu34hFgJqSeksy8ANVZbflH7tYA8rQplfkmu0tRz3aHX9fVxHYgRCM0n+vRK
 3+2Gcie72DBUUx2jpJHb2hJ257Kqsq32fDJtKYtVoS1mxOv2ZyPdhAym8wSpZwqIfT/pyg8ZncW
 h57xlns05uuNmT3GBseosisho+WHO5V25lHDkinbO94y89j41hYpw0MU0enSURrDNrWJ+5hfmxd
 W3zKbCoYtf4yLcHZJPaX5udYbzl8EVqGGgdvg2BexZalzKsh1ZJBe4YP1d38iY93FlxRf8rcvrq
 84Epc8+TtNss1Mw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v3:
- sm8450: add missing allOf: to common schema, which also fixes issue
  reported by Rob's robot.
- Link to v2: https://lore.kernel.org/r/20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org

Changes in v2:
- Switch on SM8[123456]50 to 8 MSI interrupts.
- Simplify SM8450 clocks.
- Add Acks/Rb.
- Link to v1: https://lore.kernel.org/r/20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org

DTS fixes for interrupts will be send separately

The qcom,pcie.yaml containing all devices results in huge allOf: section
with a lot of if:then: clauses making review and changes quite
difficult.

Split common parts into common schema and then move few devices to
dedicated files, so that each file will be easier to review.

I did not split/move all devices yet, so if this gets accepted I plan to
send more patches.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (6):
      dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP to dedicated schema

 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  98 ++++++++
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 ++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 158 ++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 173 +++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 184 ++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 178 ++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 268 ---------------------
 8 files changed, 1142 insertions(+), 268 deletions(-)
---
base-commit: 9357735abbd23457a3e06ba0142b7e88e7424410
change-id: 20240108-dt-bindings-pci-qcom-split-624737f7ba67

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


