Return-Path: <linux-pci+bounces-39661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FEC1BCD3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 481AB5C4D61
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F43469F5;
	Wed, 29 Oct 2025 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEXx2Iv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647B343D70
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752468; cv=none; b=Jqk+9kxDQL0kELWyGDZtutifQfiZ1ksnvR6YLmkz6elSAXcZ768chIjJG/drtIi/x/w/gcgiQ0TUgvRbkCLSj403OqSKzs90+2ShNAfVc/d5+RTr+zUV64LmT6H95c4xKURUoxHAVqHDFil2mw/a5/1T+XPnuFvj/eQf2yznGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752468; c=relaxed/simple;
	bh=jcD/muh/yg3HFerxyFZxTqkuolBzxrZADlEk8jQbDjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YAHPbJaNeeYfqauBgGun96rrOV3akzt7yQQgqEufZ00BlH9/+vcDgYLGu45dsu8TGEuINSuB14FounTy23hDLHfdxdmFy16a4+bafTSV5UlkKo4WWmFTrzqjr99LV809Dv01vI/zSCajhRBt73ZDJ8+r1BlKOvykrfVB6X7V/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEXx2Iv7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4769bb77eb9so3107305e9.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752464; x=1762357264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB4XYlUY2JZQ36hrOiaGPtBE9KxSOxOkBTNgx+iHCVg=;
        b=CEXx2Iv7dLxz/Adf0kZlWhXsl9klwAKaYYcCA2TXyTnO9SYTQupcnYVoe1I5bngy6t
         KI4KlzKshBUr4tGptunz0Bb3G7avRHiH6OINZ2WF+iS4jei8P16Kqke2OQhlqMa6H0Kn
         KS3VDc35pRA6QnYzH8OHmbGHphQsRSbq92sGNdhQdZO35m8MYO02RzzSUcVdNP6M+AEU
         h3x96OUrZzt9ftR7vhGmmfMBN9T4OzL5sWeingZG7ZFtfC9Z+VxBDoIEE7RDHWWCXiKQ
         xYBZNpA604RjM1JWJC5U5YJL3h3uNAq0/G8pDuXedk6q57ByLD73/u+Wp3J5VXudb2td
         w13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752464; x=1762357264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB4XYlUY2JZQ36hrOiaGPtBE9KxSOxOkBTNgx+iHCVg=;
        b=dpPFvg9qLrMKlbN9PRur9xiqo1Vte79x2Ysk8vdUemro6cM/lneWuazOGOSLmlcDnP
         fT20RDMT9szfsnqX3pqeLUSzfSLB392buh5aRNAkQPmGUK4hceiURFgh1budruOFcR6a
         f1ySWooOjvo5e7dxLNeYMAwpQBynABMLyY2YJt/Udx9dzfxT04gpXJLOSK4QTrEwTYDZ
         PprIcnrmHfvVQgmdNTtzReW+6F9RaA9crg+i9iq4J1nZWQP33i1ywjpytR9DIGHnuilS
         1OeTCQ/RrMA4Htmxz4jVoWN3QthA3jbUsCThAToKIqrXqot0fqUtjkt5pBj/DQ+APCua
         bJFg==
X-Forwarded-Encrypted: i=1; AJvYcCUX0x9PnCmyFPs81U44v/qh2wfEux9I0EqPVYqUii/eDR/3uNtuwj6wPflnv30ip1cIMiFkTMaSqBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkGZdJhY2LC5v2CYzMyMzj7d+4ebeySMyfC1bOrry1/PVr4FX
	IIed/QpHqpIv32GT8r1WkaRrxOIjjLpioUcZEfKEjnEJEwdmNZjuAfGXVNheDBLjpPg=
X-Gm-Gg: ASbGncurOfKwd+G6I1GyBMV3GyDxdoiPESwAXimFGD+jCxa5ZRyARWKtPAy2egjfD+u
	F0aWYdMYju3Web1vCQUZZIv7QhBxOWtMMrTIaPW1NGjIE5AyNoUQ0BtKA4Ka+ezD/kuhAYnCgCw
	qcx7whdo7yoA422ysTC7qkdTUBQwRHPSottHVHBYuu97np83ksYq5ATPGFIBAtPWJfYvupioBOH
	svdQRXbjFxmMjOtUz42NMqns11l1S80Q1Bn9IMP6jLjrrGQahcbEMB+hwbgrrgHU8IyQqSobwCT
	e0+Y0iaFbHNcY4a9zlXULJwXRFIaLyH33CjBvJi4XlXvFG7dOApiI+hhtBy79HyayyRyZHF+Pmi
	P/E344WPD5wk4JflyTVRYfl7fv4Y8V2RM8KSQ4+kBpSw5cRBokbML4TnudqLd88ExjQX8BzIEob
	cVoqCdw6qlwVKWGmNb
X-Google-Smtp-Source: AGHT+IG9DjbF0EUlFUTGru5YaWEbzqZRQ5rKxmL+Dczniu/qZ8YVLMUMQrhXAGjSZsPLoQbulsBrFg==
X-Received: by 2002:a05:600c:4ecf:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-4771e16e538mr17553815e9.2.1761752463973;
        Wed, 29 Oct 2025 08:41:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:42 +0100
Subject: [PATCH 5/9] dt-bindings: PCI: qcom,pcie-sm8250: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-5-da7ac2c477f4@linaro.org>
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
 bh=jcD/muh/yg3HFerxyFZxTqkuolBzxrZADlEk8jQbDjE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWCdRkgSj+crNTt0ZPf5p7k3sOTszyclpDbU
 1o3zeCn0G+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1ggAKCRDBN2bmhouD
 13d6D/9i2r5Li5azvJiuPvOaq5bhZqUycmZaxUdiWiryjuPm7d3LEylVeO0glrT3h1lLvjxc66v
 2W9bOdT5RWb69wU6RRyFm7l7/pOmNC79C/zTHVypzzUIKbV1R48cbGg0MdZGqvyjcwKNgIiwNJI
 jjUfhRCJIfG0snC5pDqO5KNYUhH0B6IpC116cuoMLto5wr9wq0ADXkkXp8nBq175ACmXY0/s7aI
 Ht4DbFEmBtNwNq59/bqWeYHw6V9R9jsmLOBXv9ted9vsuULuuIW6JvQ71EVHQR/K/SuDlElL2z4
 eahFimBL9xGOnkwhizjnYmxWTFcNz8ZUYikS64Z3IZjs/d2sq4yhOU2aVMs/IcqHNgKe2byTbiB
 kl+TUgFUH+X6Hu/CUrqf/5nx5Z4IBCo5OPTSd//JIey0eaUSyBkeZAM0eBdt0UVBKRkH4rzX5Qk
 w/u58DwGiKInGkZzIuQBIOaKLZrPyZRr8kw8zLGQ6cvgezmPyq9biYlM7s3I81qEsx3YKcjN3Tv
 FA1Q4eCrJHNR0aPL2j5P+XdbUDyNUQXh45ngocNiXvkreTV5t4vm8BNYGBGS/aGrMEpnl6lBLI4
 JgF+IsBygKmMunPMjGg2z0SfP+wQSdzePL4iQEQbvVa0DYqZh3aFLRouuDyYXMl4PNkrDz2m1pQ
 THb2JVzFbi89lEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index af4dae68d508..2ad538019998 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -83,6 +83,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


