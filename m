Return-Path: <linux-pci+bounces-39053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF3ABFDA9B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B49B4F808F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6843D2DE6F7;
	Wed, 22 Oct 2025 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oNnzfZeA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF92DC322
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155002; cv=none; b=d9uwMM2ChbriPLhJCX1ejsNVfQjLXZ7Hvmhgns+fwtYTrktzgDgVqWtF6hIKuyw8lyb7jia8+KRzYAC0bDZwMOtLfUAayIeUQ1bi6DyueyqPnCe/PAhzi/vVbMQ787rFCZgim9g80exiCEGCfaNKXqDr+/LFptcKZj0XqFkBI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155002; c=relaxed/simple;
	bh=pebkCgjq2t7R/8JhhzKY0KYiQYww5PdgMrly8jY12Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuCx37W/eTV7426cWTvqWuHzQRn5TxEJtIRE3Thqo5bG/8+Yyn9ZpTTnokoxTUhsKjuB0JWjrOEy+Er6/+xGEXkwtEfKUHRLRpusy5S0xLS3e5433Ndr3Efl9hyRvg52vbBuXRtS8g9zw0Y2xxhDtkfoxWEB+F97CbK8HvEAlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oNnzfZeA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-428564f8d16so521640f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154998; x=1761759798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBgZ5OtYg07NCXp61kXr/BSbIWhE2fs8T+/yOfxFjCU=;
        b=oNnzfZeAzg9okwy0bKEyYuUIuYr4oexT+gBg+RSOAjwRHpWtgvPu7fgFDmYiPRbXqI
         6tKoz/1AMxOKEko8xgPQrOWwC7P39+sZ+IH2BQ8ViOILGuUfjQdIW0fdybVmQDT6iRhK
         eF2450YMmjC+Y2e3F0Ch9U0500cjyzVyT7JZEE+Juy2twckYEmK6MmnpUX2Cd2XDQFVD
         sUQvagOUpCp1RuqLYjdPALLkih2bMo26EzRCpqw8rB0P8OQQ7BZGM5WCMUk6cU7IR/L8
         it9ixpe4rZH6GPcUiW/0FvAiFf8JxZp/wm8b1IYd/AiSreeI7WiU6sFk9s8DOIVwiT2w
         +tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154998; x=1761759798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBgZ5OtYg07NCXp61kXr/BSbIWhE2fs8T+/yOfxFjCU=;
        b=axv13FPS4qEjYItA25lqp14NCVvcZMoBviQuAMYupA2hg7WAygqqP3VCLtF5bJ4ICz
         WjIdhmgQPTdvHm94IoqeIuehg9FjSLuLMutngo4isVNpbAJL3gHY6QnQTTshRnSCjcmA
         65vrLb15FaGsbf5+xpwTfakVW3/SZUE6p8kMiCUcEDIokjPmYK8hyOnEsN0YcnUFG/Ek
         dF1efhmvHkMzDmwdjo+5LaqLHS3FEsk3x7XZDDMVktzKJaZPhqEb0TBxxwLT9fGkU1aZ
         b84YwZoP76c2bDNwiaWuYNsKl6C+S4vc+7BomezHqlS6oNC1w6+zgrBb9F6yeJjkdnfM
         Q6xw==
X-Forwarded-Encrypted: i=1; AJvYcCWduWQZisQwjJsl6F/rVI+r4Ejw8CUdJ4XVnpv4oUD8XbxSf/ZFRlhMnQwAUp8une9AgG31x+f7dCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVuIDfX+e6vv2ScoOhrarcWTfZZWLu5QV4q7yDxafLU8XV4dd
	H/ThLjyYRI1jyQhqF+AO66sHbTBHZL/3D7Ro8RNgO66n0+72fYuo05VAxvL7ogFXdOI=
X-Gm-Gg: ASbGncu0+NV2Gs6TM3y3q5mmuYbbZexj8As+I3OMCCcbv1R5nnWzjqm+PatD+EF2nOk
	PrgN+lPrsZIvzTFpu+7Pm55favVU056VfNoBvPOTcRTk4XHjhqt4HgSkt7hFIz8lbJX4OLfCIGp
	OyPa3aJYjNcjTKIblH0g98Kl6+7Ms8GCYl+NyPrsaaDvfbEDqV9OhQIa4HDFeAtgexJn1hj+dv8
	sYm+iCUWIhnFGe3iCqBbG1bgeeUbNycMrpQOBZg/B6AFZk9YoB+X838owPWir3SfGQJx1syzOw1
	zotA5bOJBY90XC3UT1MN0ZzS5CxFx538BjgpG2qeGVILPiXAij3EBqHlypMuv7QutK8ZO3d0vKc
	vEseqpXPdNbMb3zuMedpqLLslfu1VuJ0EMgoYv15r0qCz1+QqIFZdMdLR67lcCSxKLND77I5wPU
	WvRn3Exy9q
X-Google-Smtp-Source: AGHT+IFjziwUg1Dl3LOqBcFgSgns22D4G3uLdqScO3DNYkyYm03zLF/NNOMCJcEGGUm1q7BfvTYL1w==
X-Received: by 2002:a05:6000:2289:b0:427:84a:6db1 with SMTP id ffacd0b85a97d-42856a8c525mr2170414f8f.31.1761154998227;
        Wed, 22 Oct 2025 10:43:18 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:edfc:89e3:4805:d8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm43434755e9.2.2025.10.22.10.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:43:16 -0700 (PDT)
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
Subject: [PATCH 4/4 v3] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Wed, 22 Oct 2025 19:43:09 +0200
Message-ID: <20251022174309.1180931-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022174309.1180931-1-vincent.guittot@linaro.org>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new entry for S32G PCIe driver.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 545a4776795e..e542aae55556 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3132,6 +3132,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
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


