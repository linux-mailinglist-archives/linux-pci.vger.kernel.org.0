Return-Path: <linux-pci+bounces-41887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ACAC7AEE7
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47973A2E68
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0354346A0E;
	Fri, 21 Nov 2025 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2wFxLI3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85450332909
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743768; cv=none; b=e1q2rlMSooeNS3tTZVqbCNoVD5P2tee0fBdryQhTJ/zLuAsYHU33t4gXA3YsEaru3jJFB3WPAomljaGVntp29/s8jCzHi0LjwofX9kNl6nW3JlbzJ4/TlOWtB/3MXFZ8ThxGINGDQabjAoDWAgWDfkQnobCFiukX7cj1CDf5X2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743768; c=relaxed/simple;
	bh=VCW8CcHFML0MXmdga8MAbRkdEeTTdT135VPBj1W+VvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad7rAHEocB9OtuwbrQN4NOE8rDTuv1+1aJCBA7CiHJKF1q2OUSR1iuncesxYg3pCL/ZWhRW6gtl6fyW4/inJtwV2tjGYVgPWVVwsTLyYp86C5lqe4wWsewBO9ZpLzvwdgVt+78SVko1eN3uccdNz2FuWLrstu3L01Hq+tJ0hJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K2wFxLI3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b427cda88so1585555f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763743765; x=1764348565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97IM0y9keENG43ISIlS/0C0BXR0E7thIuAT6dZAC+oc=;
        b=K2wFxLI3iga2rG3qTy7zq+1/g3uQdlhmfheb3DR2teV33UDTRpG/3Uen0d2bIDluyD
         sp1VUtexXi6pjWUB13hNJixv442R2W7IBniTdzgyupgN7I5jUPxr6rjbHVf78saQzMS/
         IkkekKOLZ+NaJ3f+i3L6dlgxkbGf7Lp/wC/CaHVLc2oaTkHn1zvt9CfiCFuFIkHQG19J
         Zijh13aLW8TRvxia6SJp6fad+ehf/Vocj4x/2Tqt3Qsn502hMd9CFeY5dTXnSXBogAqv
         BkgRp8yArvrQIMDU/XkANfEVwD92JKJLoLK7jytehuccsELOAiJF5AmFTAKJLzYbP6UH
         odAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743765; x=1764348565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=97IM0y9keENG43ISIlS/0C0BXR0E7thIuAT6dZAC+oc=;
        b=bGNehev/QhMv74okzbEyQm8GF3X+6j/1Qag3CFV04WFKvJYpLrRqhdcU8ySLSF/JaM
         0rn93t1XOsLc+8Z42tgBfi3e+MbWLfNrsp/oBR6FxHo9xLV4343I/zCHqGsoMumw9Y3R
         cHC721H0b7X4BPNWlmRKnXfvhOgZ5kMvE5HlW/dGTrH3WLJbSCOK4TFePh6toiU9jqAT
         OwVinUu06DMbCaBTu1Sqm6hekFGbECQ6U05+Oq2rn53e2MWEuiLRSvuAK6gN76EofTyw
         8PixtZWmMxRrE3yGyjnbPqXFj9goFWleAGmwYvQKMJU1C/L/Y6xWbmuKoJQHjbuecZWs
         JuYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmzmGFOBNZ7w1GSMVs26tl5qlwf0lrrvVdRCBAYxvfFoGL1a+zWJERpLVCV9ELG3hANFNng+5m/0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YywE2R6pfyBPCJ9vPwaO2W3f2BlEFm0/MM5GgeGENXu1wEO3Wom
	ONtklATulu7OQ3IWFTOAFKaa6zpZs4I8LwPwTUlYBjpu9FeJyaXRWUGGF44GPF43ows=
X-Gm-Gg: ASbGncsWQlMBKhn8hNzGkkQtK8kMJz5NlSSNgB2nAOlnYZhSV7rgvGAFUfxfHZ8rOb9
	d3hxViNuX3DW1ZkiwgVZ7hG0/ETDXhJapdZJacIsrhrWfdLsyuTTXYSKNNMBW9Hejy8zKc8Zdw4
	GytpJXPIhYvV4Z0toxT4Mf1U14gT/kiITkIbKexGed7Thf2tumksN8aF7zknaxCgaolS6Tk8ARJ
	PRQk2CAe4F9JRqFWKOiycsYhuOSFCiQnq/8buLwC4xbcCb0qvrzv5Nh6/DUJ8sqiUJYWh0Xvy5E
	UjVOJQfPr9+G5SDS2e34NdDV8Xu3TXfM5HhvMxckkucGvZwImDW76LSkUfAbH9YlYmQWp5sIiq/
	+70khSzsYPOuop42WhTZ7UUYLOxDqKLPdOJtlB3nCluG7Gvynt1+sXNwexh5Bz3QQRxi8LXm2Dm
	L6CXJu9uk1uF97nVYCvA0=
X-Google-Smtp-Source: AGHT+IGP1z5eL7MkRZMuT+/A4f802SQOHcacTCZ+7w4s9B7xrEEQz3dSr55JMvgGIquLZen+ZtXkxg==
X-Received: by 2002:a05:6000:2909:b0:42b:40df:2337 with SMTP id ffacd0b85a97d-42cc1d0ce73mr3080145f8f.50.1763743764670;
        Fri, 21 Nov 2025 08:49:24 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:803a:ae25:6381:a6fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm12938478f8f.29.2025.11.21.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:49:23 -0800 (PST)
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
Subject: [PATCH 2/4 v6] PCI: dw: Add more registers and bitfield definition
Date: Fri, 21 Nov 2025 17:49:18 +0100
Message-ID: <20251121164920.2008569-3-vincent.guittot@linaro.org>
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

Add new registers and bitfield definition:
- GEN3_RELATED_OFF_EQ_PHASE_2_3 field of GEN3_RELATED_OFF
- 3 Coherency control registers

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..e60b77f1b5e6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -121,6 +121,7 @@
 
 #define GEN3_RELATED_OFF			0x890
 #define GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL	BIT(0)
+#define GEN3_RELATED_OFF_EQ_PHASE_2_3		BIT(9)
 #define GEN3_RELATED_OFF_RXEQ_RGRDLESS_RXTS	BIT(13)
 #define GEN3_RELATED_OFF_GEN3_EQ_DISABLE	BIT(16)
 #define GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT	24
@@ -138,6 +139,13 @@
 #define GEN3_EQ_FMDC_MAX_PRE_CURSOR_DELTA	GENMASK(13, 10)
 #define GEN3_EQ_FMDC_MAX_POST_CURSOR_DELTA	GENMASK(17, 14)
 
+#define COHERENCY_CONTROL_1_OFF			0x8E0
+#define CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK	GENMASK(31, 2)
+#define CFG_MEMTYPE_VALUE			BIT(0)
+
+#define COHERENCY_CONTROL_2_OFF			0x8E4
+#define COHERENCY_CONTROL_3_OFF			0x8E8
+
 #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
 #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
 
-- 
2.43.0


