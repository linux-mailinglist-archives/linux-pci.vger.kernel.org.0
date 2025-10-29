Return-Path: <linux-pci+bounces-39658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC5C1BF90
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B33564402A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5233F373;
	Wed, 29 Oct 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VI0p/V9v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05733B6E2
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752463; cv=none; b=GMt/AiEHugQbb1aWseZfXDIoG+lWE4m0EiXGdxNr1lltLi6/Jv/LJUMN/mSxbDJZkFFBnEhx8O1xiFsanBMMwFY/+dL1M91IsGNccrgmP7Eo89BozyK7r3FrGjdqPF0vY+C0P4hiSK1IkB6jGzflidadFTP6BIUktxkyHlZL2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752463; c=relaxed/simple;
	bh=C5fheZMBlXveADhbIuGHjBBUwZi8+svZZb3r9XyaFgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UG09mecpImGOTfq2quZTpmUM7GNv2eJo16WPbPBU0DgyyK0XduK0kVVaY/FJ59Mxv4rrRAEFFM/h+kjDQZm8nRxd5euqqdkC1Dmg6twriSrkiOtUPRkhqfbCiggWijysGNTMusOtkVB2xUOWEiRCbaozXWwkU/Hhxjf58E9eBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VI0p/V9v; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426ff579fbeso896898f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752460; x=1762357260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHf+cMn6Kxy6WzhI5tfMdwjUbyEZvfJl3wRfjjKCl04=;
        b=VI0p/V9v98EGZn5H6JHrfUHp4apdEKgO8ZGVJkNihExh/sX15+MILGJ5We1GvfDypc
         6FAb42QN6fz1TnvsWHArPl7/0WgpgkUvqiBdOQ4rW/D0KOgCcvRFqQnEnuJvtuMIhjX+
         wa3OiQ4ZUgv9pXdCG6pcY1vgAqMC7bzPRbaM0QbqLwiTofwhZRKjnrCHQV4kA8dFbuqW
         UrjTa8d1yzQJyzCMo2V831Ah3+s7q79foba9FOPxUmwcy11cGTvCtmeugswZn4YSC2Ay
         X2Plc0HbfoRRqss9lxsbQGrWbHLmFAvJrCBjt+UoyTqErUaGG03H4fhSVUg0pi7w54Ei
         Btwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752460; x=1762357260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHf+cMn6Kxy6WzhI5tfMdwjUbyEZvfJl3wRfjjKCl04=;
        b=vZwtr+kvqMOJqMMN/6lk+N7DSPrS1jTPpW8ZzdR4BRvRoYwJAL5eAVaFZoad8/bknc
         MVh8c9Msf4RGF1NgzbLI5uKlprgu22ZyZdI0PmVnYsYhtmCzTSpLszZo0T9PXiyVCsv4
         1hSLBHmEpwpZpJB08tz2HtYNv5Ri6qweUje18ebWX+5kCNUVS/u1U2CINZT0faSTZIjG
         E3SNTM4K8UhKudtZaKfybX4oB5UHnOBL4NLWWkuqjWv2HnpOKL+uKnObBd0fBbYt2XFf
         EF+a/QfXlM+P5xaTNn+NLrerNCvY7bUv4+wcKtKcxgYDXHhWlpPkAnah1+vzsjNFNOOj
         QOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT8/Be1zFar3ouEUDP5RJNLkz5pU4F9Kcx7xhkY/NcXd+WapzRt4DvHQeiqsQNuZuSeL59aMNa9Gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNj2QGnFs+KiTG+mdn/mh5nqFcbMbD0P+pCMcA6+QivzZKLwhd
	P8wagMOwI9+PcQdUd/g94a42B9cp/H1VdY7bPduqT/T6ToRehe3BthQIuC2wvSnXfLk=
X-Gm-Gg: ASbGncuxm3J9nYXtbcarhM8Uz9xypvcbISVE+VGWdKuEfbAx8dHAAU5yD5qSjzW5YwJ
	vHcfdwEYHdzzIXSGf9HqJqOYqJWWMeR4XAGicojTrS+D6YiNuvluxNIWe8Fdb0Q81c1nTAet4tv
	xJyswG7iQXxFi67+L04YJ1FN+3NSZa1QBkUjbMg3l6LNiq7bcqV+fIWUKaKPYVwrgE+msKpmKr5
	6s8AAXgwSnNGiuj+sxcYnTzGbl5Qq5QUeloQhmSmKgzNqzdW23VbwXFdMX9LBASeT2K0rtEWDUa
	/mpwTw+2AtIDIsY3h+iejC7v1mdllX2npuCvboZyEpdHWPQPxOH7cLljimtABtz9K0E80cgfXTY
	Hnc0CTbSUrst5UYcw5Nynp9MgfCbJWM5af4AG/RVNLrgRcKoY1dY5OUR23TiMi9MuG/Tm7tNL24
	LCC7aH/dT4dNrJIyZL
X-Google-Smtp-Source: AGHT+IHwTcSdwYOPG6r0415Zk++YfUcU5yMqIL3/VKwOKYxZYrAgJvqhz956H0VjSJ5yRA+kTI4Y/g==
X-Received: by 2002:a05:6000:2891:b0:425:6794:f19b with SMTP id ffacd0b85a97d-429aef80d97mr1719532f8f.2.1761752459735;
        Wed, 29 Oct 2025 08:40:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:40:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:39 +0100
Subject: [PATCH 2/9] dt-bindings: PCI: qcom,pcie-sc7280: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-2-da7ac2c477f4@linaro.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=C5fheZMBlXveADhbIuGHjBBUwZi8+svZZb3r9XyaFgw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWAt2He8JZrv/2UagbsLKx6hiqQ2Hf2ne8uq
 b8GbzFp+LGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gAAKCRDBN2bmhouD
 19jkD/9Y7Yud/iWVjUfcttWhamndLFmOnwuyiuZymgw1con27IkeBHVSMvkIBdLuyikpuwWc1uW
 +Ec/O5v7B16bPf0jNppNGhvRq84rLdPVWIH66HBXdEhZ+WGrOPLWjbnR7gBu4z2ZNFJvb4sAENE
 Ceu2rWZ8Xqxusv1uPK7vgQdOyfh31QZ11tfdgb0vMnvJDX3bTNzW/yDhH1KUKMSGk+8sYtaMkiB
 p1a4+FLqpui7RYHuNhW+TShdrGEJNDoxzvTgfDKMq0jh+2VZcpgdRNY/u9f2HwvdGdz387YFUbj
 Cb9Baykvgu1ObF8OOCsX47JP/2jpbISUcqLcPXZIl+kbT+mCBo+P+SkpIjA1YFXJCmVN+JRQVGn
 ItnuHF64n2Y34BTJHGmd0BL6TkgBCftyiOvvac+k6tvcmwZljxTtZ2s0So3wqNHZlla7wgZQIHe
 NZc35CvS0VMLAfC5P/Pgd2XNo1F5V6kF7hgCmZYZhvMuBm1nY0vmJLG2R7aO43J2zXVh1AxnMOf
 HiuypfkdNcN66zEdM4SvtqATrEsym3Nr2RWO7AbQRkKmy2z0+N5lybQBPhq4iDkLl1MGtfVWNIA
 UOj7R7uIgkUvPlthOzxRVr2QqZnDynsibJjYcWKElIw/h7494pUE8qoXrN6V13ggDhqdKiL99jX
 9nDVLsO4TpIJJmg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 4d0a91556603..a2e5755855aa 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -76,6 +76,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


