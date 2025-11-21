Return-Path: <linux-pci+bounces-41889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5EC7AF64
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2E814F32EF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC4434CFD3;
	Fri, 21 Nov 2025 16:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAHAsKeZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2223469E2
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743771; cv=none; b=kedGhjA1zS+IsKLScN+mXBfvYSpQT0e36z49Ue3doaBSls+zwlSCEqV7WzwM2SrjvjERaJPq7mFBp38xTwfaJcNayYh7gJ53c1FpJeHBAZOcCO0c6vLEG/3EsdOof7obz72OtBz0a7/cftYbCR8ydVgjiOSUHCTF9cgmboUsscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743771; c=relaxed/simple;
	bh=8CNzFpWGHJiJ/kMik9XkodfqnXW6wo433Z1B1kwxkag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6VexTGelNejzcDP1yF71ak7vGDC2vRxJRYzEOEylJ+0V+OYHd2Fj94aYocjjYFuugavRk+u6I4xVx1ohuV8rV8u+NTZrEGnpB1bWdyMpu6op2QDnm6Ovz740aJ7NJolwjSUeq3BoUPr1kfOcklBgJIZOUr0hADUE/UHMAvGyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAHAsKeZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so24040515e9.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 08:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763743768; x=1764348568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tA1YZwkpqBYNCNgFaNMq2uv3rKscqjzMZ5GFDmRce68=;
        b=dAHAsKeZ88W7IlUFTVKqEqp2x8NSRaxWcT7tRWVxJ3u1W9NRIxlaK+vg8Nt/kr6w0M
         hnX9SeMr866Wc6OX69rDzBjrxOVjlmt7a4VvEKllg9m+M8G8unh7/pYvEPtMXs/eCgQE
         /cr/OSa/2TGFlKyA4jq2QsgC4ihvHZDE38z7QGsseJCpwF8j1G9GzU7jSZhpuRye8Cdg
         l/GJla2UihZe+Y9MR9NDQHupp4vWwTBEN3nbYguwqDft/fRNHVjWZXCUYNddw2prYVlS
         yuOyTfNwOg6uWP4HoEXjubcrWDKEQzfftq+GlQ8vYMiSX+Sql++z5ePBG+2q5RedOlPY
         2Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743768; x=1764348568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tA1YZwkpqBYNCNgFaNMq2uv3rKscqjzMZ5GFDmRce68=;
        b=jKI0lQKibk2dsPwBsvFcrGG9QnRlzWTWVKJU5ZkMrkFzvL2g9E6BqY7nGliY/aduvs
         iPIfmCFlHdemjt4Qog4ckcHt9bWUNdFeeYnO4v3xyoEJpRkItsI7Elm3gq51iE69KKgu
         sA1imTiLdeZPFs0Uy2AdumLAzC0GVOCNWa3YFoQuCe/UkwMQZWTYTw5baJ94EG5Wx81s
         BVNCW5t8UwNBFxXNlOBQy8nkFVrgU39ZZNQqNZ1C80PX+np4fdK0AWE0cmUJ2FHx821Z
         TrC07RsyO7h43phHIEGAvOmdn9aSsf6crgwCHjF1ZlUSpDVCTuLNR46j5tF/dGmx698K
         fbnw==
X-Forwarded-Encrypted: i=1; AJvYcCVeBAXaQBzIUGmhcQ6DtDkjovugCVNu+/o0sPpNX+BgNE9fQM4dqucGgnM8Y/BefI7z2c3/Q5A1xnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMEVozRv6l8HZOFwa9emSnPSorXmJd8v3mbK4bJd8du7N1dDG
	mEwSU2jsfyuQuJW4kJEPMsti/b0zNjqzKzlMWjLjMerGKhbfAtVgxcoCEcAjT6N2A6c=
X-Gm-Gg: ASbGnct/g1xhLv5GS1ubvsmSkt7N+dSv1/eeOZ71V/qyNmZrzQUw4lneyQvYaRZsUz1
	wcGGZ1Uht6CrmFS7TetCN/Se2c9700r36fu2/xurfCOKIHOrzG00nnFKDxgZ4L3kbjBb9WRhsc0
	jLaPkqgChRx4SzpwbCltIEwErItRA3cFMt/QdQtsWUHrbT/iTesOcm65xLdLbdjhlJxG6o/6uUM
	+BvNR3JwVf4DkcuBovOeKUv7ro1PrqffFo8uklE1GW5UAnNOrMYF0nBYaoP0fSrxTi1bqSTOPGx
	QzIU+bSipYdwNTCj6ygnDNEzr+73vIjcfL1q9MA2xGYsrhAqisFCUv/iFth0CwnbUu8vA4usDpj
	WcMEJXEXXXmrdFbKt8npaUmfuIuMu2dvesbTXv1vpCxgegTiWoyQVGT92WofkN2CJMFBSx0mQpY
	+utgv+WITJ0HHp7zrxUD8=
X-Google-Smtp-Source: AGHT+IECYLnmyytfY8LzC6PdkZB/9Qv9aOOwBQ8USRlzz0beo5YI3DVNF2FJyRPzQ4ThwhycZbswbg==
X-Received: by 2002:a05:600c:4f06:b0:471:9da:5248 with SMTP id 5b1f17b1804b1-477c114ef3dmr30830045e9.26.1763743768105;
        Fri, 21 Nov 2025 08:49:28 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:803a:ae25:6381:a6fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm12938478f8f.29.2025.11.21.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:49:26 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 4/4 v6] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Fri, 21 Nov 2025 17:49:20 +0100
Message-ID: <20251121164920.2008569-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121164920.2008569-1-vincent.guittot@linaro.org>
References: <20251121164920.2008569-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new entry for S32G PCIe driver.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64b94e6b5a9..bec5d5792a5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3137,6 +3137,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
 F:	drivers/pinctrl/nxp/
 F:	drivers/rtc/rtc-s32g.c
 
+ARM/NXP S32G PCIE CONTROLLER DRIVER
+M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	imx@lists.linux.dev
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
+
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
 R:	s32@nxp.com
-- 
2.43.0


