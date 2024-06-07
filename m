Return-Path: <linux-pci+bounces-8444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD04900157
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 12:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B48B1C2285C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86833186E56;
	Fri,  7 Jun 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBS/bdXt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD44E1862BF
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757899; cv=none; b=h6kE7E4cuavDhE/Abk5iIYPLlKGhBNFDFI9VRXDO1H0uGE3KTdyzQUq3erxr/X4GJtnWCpuOKB4PMTfqx3ktTh6Z1tM2V3qTodCL0D8/zmXBVPR6x+kLyFEXLNsQ+U3YE/yHHa7J86gRwb11rPZbpucJxr0FUmFVFdlqFy+1uXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757899; c=relaxed/simple;
	bh=O41O/1MskzYdTSPlRhjh40nzcnbFdwsOlCE890eRNOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdQGaSMDDZ4phSFfCHpKOJ25wv8iT0NSKr4j0zSBEuoJEE5Y+qsZKGIs1yiEH6ckI4Xy8GbA4OGWQ+y431babJmBzo/ojQfbS7Ckz5UXPPd4g2jhkRiQLiapZH5Peg++g6o5YgfAec/V0yBK0eu6MswSvgH5xMdRVhlJF6l7RG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBS/bdXt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35e573c0334so1796249f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Jun 2024 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757896; x=1718362696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjEqBh5QuB3m0cSYJF5Sevhh+bm02dLUsdiKcr4Stbk=;
        b=MBS/bdXtlEAlqZv9G5/y4Fs48irk8t1uVoqz7pB4ukvt4JAFTGA3cMY9rv3wUesGYj
         OoODXtkDiT/sF8M6Rz98mblL8QUtQC9fYq5TJ8mPafbuxVXxWWOBXJW9rKKWXyV7ce2d
         VTlgpqdhGAcv9gsJW3hWiDP0hkW6bAlNi1x2osLDngltsesVBhbzjfsNojK9yJA+HQSt
         DR6qIo5wAyFUcsk2tsjjOtZJ2zBKWaM4ugczjv55KjHSGzIhfFtXZeXqjkvNXs9s1prZ
         kCnldbHuohzC5dmgfo3LbJgX1uhfulFoBKDMLlUaaMYFL7Q4yQXJ8iANdGVPGrlIGWdO
         o4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757896; x=1718362696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjEqBh5QuB3m0cSYJF5Sevhh+bm02dLUsdiKcr4Stbk=;
        b=nHbtMAiWlZheuw4J8nvxcFJMWuRVh3GEDDy/9a1IVITWs9lWKgOqiIWltX3h1dP2Ux
         doqg6VxNqdg5iXDB9cogQVLkTW79SA7/kYyKHtLuX2YeOc0THutzdITn+rxkXPsvoN6w
         Fty7GpgRmrau4zef7D47HGOfx2zcEP44iCEKIsIIH+5xt6qZ5SSnIK039iY+oVjCtB4M
         3A98iNq+vCXmn3Zci3NORWRtzErD7SvvM5+CUdlnZ6WTOxe9roLr+g9FmjzO9L+6CPAd
         xiciJ3IJHYjEJWTf5zWi1EZxglcZQ7C2PxN3Fu7VMnphWOQkRbz4BnNcEL7PxMwcX5Vo
         yEgg==
X-Forwarded-Encrypted: i=1; AJvYcCXhCcESfC7WnX9duEh6oKquFu7dqANfJeDsKWXxy3XK4R6MjhfcYcaA5giFxaU/36RGExP/Iq4XThUcD54bqR8YxdAK5PbtTE5Y
X-Gm-Message-State: AOJu0YwyqadB+0ef6jx2zqyd0R2KheOYRlYdqpuOBuxJPrCHUyNJJ2c/
	60qbET/ix3hdaGHdeeoOFn+zSxxP3ODOoE5//HcVcVDTWkP71C06hUgs4ZtWYf4=
X-Google-Smtp-Source: AGHT+IFX4FLgpNJ8GaYxoZxGPgBzPu85Hq8iJpZp9pD83eICpSj6uwNOOa6+5UgHkLP9J9gGJbKS8w==
X-Received: by 2002:a5d:5090:0:b0:35e:ec8f:cb3d with SMTP id ffacd0b85a97d-35ef0926828mr4809560f8f.0.1717757896329;
        Fri, 07 Jun 2024 03:58:16 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fd1c5fsm3739485f8f.113.2024.06.07.03.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:58:16 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
Date: Fri,  7 Jun 2024 11:54:16 +0100
Message-ID: <20240607105415.2501934-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607105415.2501934-2-jean-philippe@linaro.org>
References: <20240607105415.2501934-2-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Declare that the host controller supports ATS, so the OS can enable it
for ATS-capable PCIe endpoints.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
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
2.45.2


