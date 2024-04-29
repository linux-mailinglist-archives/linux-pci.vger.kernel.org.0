Return-Path: <linux-pci+bounces-6782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD888B5701
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA4C1F22C66
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201E4503F;
	Mon, 29 Apr 2024 11:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WV+TRVrK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CF22084
	for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390992; cv=none; b=OZVq7qh8O0ydUHBXgGQTGzNmCuLHSO2M89bIq/PHhvUrDKdr7l6A37q7KxeFCpZigGJfWjaIeaNSVvUQStaV2+VdQ1eCF/gloPgna/S4n9n5GYE2e26o3B5c6vqm6iLbaNxtIr2d0A4lcvAAjKfN+VmaHt1wz+mRtbjtUxwwaUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390992; c=relaxed/simple;
	bh=wlwCiZQhxacSX1iOcX1bXb8eeSP8O9zxMxdtgI9EZUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D98cN9lIMxFzF+ZyrkbOazENwNbaJHJCohA/QCCyRIwhWZUZEFgSjF0E2tKsFtzpAWYWZLGC8uBpN4raJ1Gg256smphZL0JpVYFYneCPQ22pin5FQP+5CfC0D3ElOlVtFwuNZkiV5NZYGRNzuUl4eq7v8knO4DgJNzf7yI0mb9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WV+TRVrK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso14740875e9.1
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 04:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390989; x=1714995789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i14vi0uS6yalE2yHHE98+WWyzuINERvn0mRjSQcogLE=;
        b=WV+TRVrKzWsLalu7QCkeNYUozng7DAsGN0XSKRX1CNokWvNXd55nq3Dd7rAgTvK9GK
         zUH2Xs1yederuAN3LPawxA1ae/351v3u9WdF9No33Suyk9Z6Qg0oq0mgGc1W6+rAf6dt
         IezKYNN9yhrFsad8qUXw/hWS1atX5oNWQtpCs0fZtGmkvh0IU+LzPLqwWn9E6g84/3j2
         /EFw8H3SNzz3Pl/2Wcss+34usZYfcacj6MO152T4QpZOwfeU9kPDVxI7tuN/t8iGSogu
         D80eTjcq/NHuud+Koouk2V8sZjLmkV6wyZ0zFKmeCTHdc11SeJdWn8vihxMFV8I45hEp
         PigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390989; x=1714995789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i14vi0uS6yalE2yHHE98+WWyzuINERvn0mRjSQcogLE=;
        b=fX9Icqg9EjSILkb+j9EGB7K/x6nC50nX6jb+2AxfMUWc5S8W0/GBJdDW+DmdcnSkD+
         9u+IS3Kn6SBdWi79CF39RXiRobsrU5pdoTrgBzcAAaXzYKSHnJ6zlpO/VT62MGuR47nN
         z68+Cvvt++ssvcjqFaw9uAf3lplQ6Vj/OA7AxfYhRYIDnAblaWRnTBhEBJjgVKfC3RhX
         Urd4qShWJXgQ4t8ZgOcJhUtc31EvOcge1p++wD7a7ZDsTjqPeeETIGjsBbvWGUF95QEE
         O1y8OGM6qwWO+WnpsA1iHePomnel3Mivi/773OKuVSSv5DbqAp+j0xJ7aHcyLGkccdte
         nRcw==
X-Forwarded-Encrypted: i=1; AJvYcCUCtKbc8bug01rMElTugmFIo01zV8Yo7OK7g6VxRV8MnVc85HyNKqUPJ/rRTP1PmZGtDDlWO6rv3IDFwZddJS/4Gm5O6SqJmDoR
X-Gm-Message-State: AOJu0YxLzegq/Ghw9yFO0PONLQsJHGs/djoCYg1F/IeSdUOvjLH07Go/
	SCV8+38KNEq+DJANUL0bPlZasaGsWIBMrY1UH64/l7azJedTwj/+RMQZNuMRQmA=
X-Google-Smtp-Source: AGHT+IEI1UVkZOMPYRMSz4HtjyDrrZTWNzj/RlriUs5QHmYdGK5xHJYWjf4nbA7zpSf33ACYcYdQ4A==
X-Received: by 2002:a05:600c:3587:b0:41b:8c5c:31b9 with SMTP id p7-20020a05600c358700b0041b8c5c31b9mr7553097wmq.14.1714390989553;
        Mon, 29 Apr 2024 04:43:09 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:09 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
Date: Mon, 29 Apr 2024 12:39:39 +0100
Message-ID: <20240429113938.192706-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429113938.192706-2-jean-philippe@linaro.org>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare that the host controller supports ATS, so the OS can enable it
for ATS-capable PCIe endpoints.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 60472d65a3557..85f1c15cc65d0 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -243,6 +243,7 @@ pci: pci@40000000 {
 		iommu-map = <0x0 &smmu 0x0 0x10000>;
 
 		dma-coherent;
+		ats-supported;
 	};
 
 	smmu: iommu@2b400000 {
-- 
2.44.0


