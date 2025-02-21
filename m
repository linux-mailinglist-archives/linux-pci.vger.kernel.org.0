Return-Path: <linux-pci+bounces-21956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA7CA3EB0C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 04:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D6C3A2431
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 03:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1923C1E9B2B;
	Fri, 21 Feb 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thj7SIuk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380011E7C20
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107179; cv=none; b=lTudtDjmfVZWAcymF75kjLAUInhLpRQPQzhAcIMjiyVXj7MI1KlhJDZIUlQxMEl1GAs4grlkeq5pce0csmXBk/2aR14afJkcJRQPBZdix38l8wtJtI1BoC91mafofJwPskSTpCkJ5ua6tvLMzhdMK163lAmzCcREvNOJswlyqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107179; c=relaxed/simple;
	bh=r63bMyziS5VAUoRIbBTBNVf6CyjstQjiNuFZTwV1jAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EB619FKLR7qqgjTmbpraJmSgOo66OByAd62YcBvLq8wCbDus/70EPdtnlIWO9iNXNEEeU+GdY/kLVF2pPhWfhFpTEkJCNz/dBqpevT0mWXjL+z6F9ZVjuV5G/ALHUMlft/IUkhDFbOrhGh8XlVz/5ImcutdYQXH7+PP5i1R3CVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Thj7SIuk; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30a2d4b61e4so12218071fa.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 19:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107175; x=1740711975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=md2U+XG4zVBPU+kJo14bBfe09ZT4A11xAQxscpC41RA=;
        b=Thj7SIukDN7+EJpsNFLHpo0DrlnZ2pll5VT5txODaHgJKiJePmuPW/sJNkFG0VTki/
         FLFfySz9lLxKPk2CpX3ycOxUQPqRv8MIu3nVGdkjqU4gs6+MGgNSmcRfzHhUbHCZRpdZ
         sRGxJRSR3TptDQVFVV+f3A3tJU5FL8C+lOV/tua8IPwa+rb+ibNRgunfsYZCsgMMd2Ng
         AIrk2QQO2/LowCGNJNTYKyMsWtFCKKBnNX3ekrC0mszk1lcZ0mMpp561fosFhk7Xu7XO
         1MfaYGf8TS0dVxrDmrcWo0Akp721m/0ZbLMy9NiX+4nhHNtdlXsTZA5GO44mP5AW7X3S
         1tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107175; x=1740711975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md2U+XG4zVBPU+kJo14bBfe09ZT4A11xAQxscpC41RA=;
        b=AWgGaH+o4BSxVuqd0M/ThqQRrxbsBAZ1Sn/Ec0f6S+u4Z0BylonzX8GqFLjZJjAXGp
         /1MvJ1roQHhwunYY/AX8+M9CpqxpTBoX+x/JginQGCjGsnNwtlydW9djNxW94sNw2slM
         p/t3XGN6tSrzEuDdzBUPngSOPls9mzMOU6IO9WodlFV3S0nYbQ26jyNAWg875fTzkpHJ
         tE9rz49Z/ydmGk0PboNGQe9UgoTEjwIEEgj6RSdBec+xUXAJ/ByXOPVEJ/PF1ZnY4Qnw
         3cvqJVZjZb7Kg7aAtREI3MIiUgb4+/sXfr/tZdsBItAD8BbAgn8g32FAWy5HnLeMJOr+
         ZZFw==
X-Forwarded-Encrypted: i=1; AJvYcCW/ghj09DXAplhUX6TIJMmxNmWHUvr5NqZOUkzDNy+4hIudYRmY7X2OjBpcqKC3UEn/mZMPT9MVjhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKi+CvaOTLvTRZNd6fyBKsGD6FLyBxOzyS8VRIisnRxXpS1NXZ
	TRZPlVtiSDFBkVRiBUwylZca0D8luzzv6GoHFyrBRWpb+DpCQNWkVe28apcTZa8=
X-Gm-Gg: ASbGncv5d4fVIKcpMpZB7Os/PbKyEp2BbH1iNPwio6N0ypBMwZN4nH1EF46tedfkD3p
	pJj8mjEoO4CB3reg5hZK/HEuVjQlcMtV0Wl4F/4KLx1R5MYcY4kd7rR3EgGnMX7kG56dHsQvJ4n
	/u7DHwFeEtEOKrQhFGPdb75n4CGw4j+kikp3Z+wVKr+kDtptVvTJ73BKywMsQD0gxYPSoFR+6dh
	8/kxPC9xtoXqC9Vg6zyx89vyAVgr+ksv7P3MJPzRGSVw1wy061nNjONyglz33T9dlS/j+3Ukv4f
	e5qUKhrimiGrRWby1u2Plhqqnp7/tnmDB1e9JwJ0NpnC5zpC14HZ3VGWItv2xNSmnXWhMg==
X-Google-Smtp-Source: AGHT+IEkCKO1qHn/CLGLJrlkaW0VmyfjmyJLlNnnkj2GKxT28k4CdaGsFTxMvNT8RgAQ7Nxch7LsGg==
X-Received: by 2002:a2e:9e13:0:b0:30a:4484:3ee4 with SMTP id 38308e7fff4ca-30a59960525mr4536621fa.23.1740107175293;
        Thu, 20 Feb 2025 19:06:15 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:14 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 05:06:03 +0200
Subject: [PATCH v2 4/6] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v2-4-cc87590ffbeb@linaro.org>
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=r63bMyziS5VAUoRIbBTBNVf6CyjstQjiNuFZTwV1jAY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2aLBoqC7gDH2lR6m3K+MOfN99dXco+FQOjY
 Z7D5QrZfN6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmgAKCRAU23LtvoBl
 uNpAD/4kNOZSOtJdaVWeVbYNca7r58HQ6qqCh6bHGhy2ow0CqxOf3rrkU++ZvfSR+uU+7nMIOhB
 dPIj/V1OG694l1g6LN0r2mYQGAwzhkGID6G1A30OQJg6Jeb4qCGOIBrv0GLKdeppxVk4O9k5Euk
 X85HA795bwkpC95P9r4jYNMFr1oNagHER9g1KKlUOJH6fYOB+llzsCYVNaCmad5of9zuMOkK6Qw
 8PnYX3uP+YKUog7y52RIca5OC/v4WRzzp8U8fNcxsjuEtngK2igQuvsMaZLM46jL9rP4wbr6Gtt
 OZ5WK78E+a0lqaUM22kkOCFkmkZ4gMM1q08hQFZOi0snXM5WCRJvIJOv1dbTBrtJ6x0xaAV1HKp
 yahVAV+hB/DiUlYvB6KoxAJjuixvSz1v8ZmZcCKnK7awHOYjVKgFTpb0BNab4VfHol1xUdc+fUx
 DWQOfBb4uzMPQFr8LRgMpVrumqf0gNrm+Nf8SJCHYAq1LPGqVfomkKWGtq05gsJ6OFQlHTeQLA6
 g1mq7f4ZRp4m6jAX6d0yLeJDdLFZdftnlAhJYrF+k61kqr7fIHUIWKi7PS62nfWGoGQKEvfbWZn
 k5SCY/74hHLh5Ii8iFRYLoSuCtsrPw8dNTBirjYm3XL1ysv0OIkoQnzcGk9z937Vc+SrZjecIY7
 SmyMA1H7CsmeeGA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable PCIe endpoint support for the Qualcomm SAR2130P platform. It is
impossible to use fallback compatible to any other platform since
SAR2130P uses slightly different set of clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index c08f64d7a825fa5da22976c8020f96ee5faa5462..dec5675c7c9d52b77f084ae139845b488fa02d2c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -933,6 +933,7 @@ static const struct of_device_id qcom_pcie_ep_match[] = {
 	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
+	{ .compatible = "qcom,sar2130p-pcie-ep", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pcie_ep_match);

-- 
2.39.5


