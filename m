Return-Path: <linux-pci+bounces-2543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E339283C304
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A01C23406
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5398F4F203;
	Thu, 25 Jan 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="weDifguR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6744F89C
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187837; cv=none; b=SEQdBooX5re9cKhFCttVf8Z2GNd6fn5OKg3b34jI4QqhtlISCFszrNHpxicJV0SfbVKl+ArT2u2Nypp2JoFdOPGCHTtIkB74X9PrJ98XvVLOmyp03q/qlxSnheZiRRZKsBvU8KCeXxOGLDe+KNSo2habEOreKYsD8Tuf1aM7OU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187837; c=relaxed/simple;
	bh=dMzitNsPnoQqPjgNd118SalTEtMQyVeQjDKMuBi+UoQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TD+vDQX0CiSRC4Uh55K8q+sSj2aKdGu9cI4fhKtMqv8OrxDUTDfY6oRUVeJvOG08Geo18dSyK/0OK6yfZSPk1VjFNQiWCgwca3G9tSBjD87j37fXOFos8CNhgA6ek+lTP0DZ5KoEAS7vbZ/ahAVKUg6rdR0GPp5X8b3NHSHykz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=weDifguR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a277339dcf4so733402466b.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 05:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187833; x=1706792633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nC3StrmayZyyJT4Y5X1PJTsJ1RWCkywjrpqQOvn/ptU=;
        b=weDifguReg4kw1gtKsrf7ETy8sxhrf/9QJnh1zlu+fuYBUrdMRBTkJfCE8VGnC6JLJ
         /ekERnCPzHFawaNh/LPtgXK3esfbp2ERuBCGGZTerVTinxJLHrTxeD5HeYxsYbOiQteK
         PGg7UT677UHSKYOt9RAGjoE0+0xghZbNn0M2Or9wmxjQa/01JOgyoXe9MK4lqhdJh8pM
         01mVdnZpkSKbSay5dfCgbjrmfcQUqoSn33+pBFCgXf6QXlq0KTF4NAVPR84ooHe9djR2
         FyfthSDHoZwmL3Kl07icDU3d2EIoH98kmbacHQmBot/lsBcFRXRyBpmEyCZ57TuqC9qJ
         SRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187833; x=1706792633;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nC3StrmayZyyJT4Y5X1PJTsJ1RWCkywjrpqQOvn/ptU=;
        b=R1vPXL/Xyh6qUD7wxlT2dVrSjcPgSB2SQhYD+BMKtm8LmOarFVS5M2Oxevm17yxVDg
         43pwblI3RxSyYipFt3aTO3tyAuC8Xcj2yB/c0icSuEErts/6y4+pSwgOuu1wqUTXcK3F
         MEeIe3xrw3x4BqkDLu44hvTim4sHp7qgUclUnLSCV7FU0lbPXmVOUatQEsAjf7lYvv6R
         OukBC/fF0PzvepEaW/7R7L1GhF5JItqbfGP2ienYzNFETMgH55FSkeffw1h19VP3DJRy
         mcL/qVJB1begqQA77GVbk60S2uLAZ4FvG+VwcWCWdkGaHwhr1JemEDbwJEP7AE1kbIv7
         cIGg==
X-Gm-Message-State: AOJu0YwiqP4wraHP2kU2BkypWPqhjXW+cZBUM5/kI4l7lEJLKQ90uhOQ
	0/BHXJlGLoBuu6bfgvIDKuDqrYOeSfyfddpECTpe3Wiv8TjEDEjdD4stNt9Il+U=
X-Google-Smtp-Source: AGHT+IE7+yQgGACsMLT1mGlMlqEqWVpzjqRn+96gCiTnSrWod3DHwbIcxFXJormvctck++YKYbZEwA==
X-Received: by 2002:a17:906:1993:b0:a31:6274:1762 with SMTP id g19-20020a170906199300b00a3162741762mr550246ejd.93.1706187833682;
        Thu, 25 Jan 2024 05:03:53 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:03:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/6] dt-bindings: PCI: qcom: move to dedicated schema
 (part one)
Date: Thu, 25 Jan 2024 14:03:23 +0100
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABtcsmUC/43NSw6CMBSF4a2QO/aathZqHLkPw6D0ATfBtraEa
 Ah7t7ICh98Z/GeD4jK5Ardmg+xWKhRDhTg1YCYdRodkq0EwIRlnV7QLDhQshbFgMoQvE59Y0kw
 LdkKqi/Jq0J2CGkjZeXof8UdfPVFZYv4cXyv/rX9lV44MbSu5Z62X1rH7TEHneI55hH7f9y/7k
 DqPxQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2011;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dMzitNsPnoQqPjgNd118SalTEtMQyVeQjDKMuBi+UoQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslwx0F4oYFW0LtQon17z7ECxE6oQJHsHK5DuR
 K/C8WoWL+eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcMQAKCRDBN2bmhouD
 1/IWD/9z4HIQmlHGBC+0uaQcXdHW0FyK2By1mjTNMRRUgSEiFxmh5ew2Tb0bdFgJJkRjtYtoSFv
 U8o1X/XXENxvs86lh2dI+k7Um4apfEOHjfX+ejEeNU2RL79np/VnbqT180tNNW9dCaRzyasv7x6
 KQRFk1z6QqZDgGXrYyQavelNbEveYb95g79RcNF94TSQ57NScu+PG0MGQql9AXyJDcjuGQSlKer
 4EpKhXmo+aXVW87ukSk2qZ2KOyV+Mzsd03LnuE746RMJ1YZNn9n9gy0kjjj/l3Ob9CkBREGOdId
 hHC7fPyuFbj0WSLNYE7MLE3nIOYsx2cgpqrVv4gSNXa0UhhtGcKcKHZElYc9mwRBz52pYB5h/qw
 WOMGfh6zcMYKEIJzqt4JkwM51sFCwj81TaQzFSiIpG0O0N+znL/noaywkdYe13W2Mcd+8buVmnH
 XPYo6jt4Q+hB35kS0Ms6KnISIPm+Qkijdsue7dkuzvwh0FJfgiXKEBO4z/g2nuegJXmyMDKk35C
 2CLpqCyhrmbv0sEtyzoN2un4gYRdgOqECa3vg0xIOhyG9ejmDpCT1pYGm+BmEXeT8N7kdfZpIDV
 jnaTl5ABKHFFGqmf+l1kRw7jxywD4zWnSZiGoTTwCB356qRs0ymQpNPUNmvoZmsppchrkAFhyjF
 2XZlznfCZg8kKag==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

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
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 175 ++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 268 ---------------------
 8 files changed, 1139 insertions(+), 268 deletions(-)
---
base-commit: bf5fd69c5e632ad8bbce6036894c71119d0070c2
change-id: 20240108-dt-bindings-pci-qcom-split-624737f7ba67

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


