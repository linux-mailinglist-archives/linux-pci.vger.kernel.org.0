Return-Path: <linux-pci+bounces-37860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F4BD0C3D
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 22:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAD994E3967
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20772376E4;
	Sun, 12 Oct 2025 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6ty8NE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5498233707
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302752; cv=none; b=b7x8h2eR3Bb7GQBcoP1G1sGKLaOTqmGnFn9ySI9ha+bRrsMlAtrjfN+wXkpgRCWKDJCI6Hj2++Q4V7wvEOl8WY49Mx8bccFuMZDbOWpdwIzQLUzM2K9l99AA8qtRJTrsglvbfD0j/N2KdfwDLWoM1LhqeXGpeQzQprpqizIm8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302752; c=relaxed/simple;
	bh=6sa4dBlIVtXXSWxWD+PhcdWd6PIrRysSNnN6dDj8eWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wpo0qKiusFRvVQ6AE/2jxuNPEYmjbrASXDgK9m/SA05r4qncECtdwzZnqbCvgJsQd2UYCUyibPeWsL9g7ff4PU5kaqjqCiHR/rCnnosg3Oo/HvR9D75qstbIQgyRfUcMq9CwnfUpOeJ8sYJXvP/iHYgBH9f8Ql5fHtvWFB2SjXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6ty8NE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso2680492f8f.3
        for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760302749; x=1760907549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=d+6ty8NEJ9SIn8PG2grgbLKg8UgW2mfoRDM7bEePjYVwOqD+wMQMakeMDC+b43zlRQ
         4zdWQDSU+p2ryzkr/3kHXfX04kS4So5mBIgx9E4gSQg9wK//27EjnOkr79Zud6JUKOXs
         Lp//2gpP+V7F5/KiHC3GvpTZekiWy8wlO/V58YETmnWmXRmziaHY6sUDaMqNmV/DTQxs
         yI8wSRqckSuRTtIJdldJTDBB7YTbnFELPzUIr6ZjxvXVJj8VaOx+wHJ8Ip0qte7UxWuq
         TXLTVKAPx93hzkqsJ2xdtOta9FFMzw2oFhy1hFK3UrT2KyF7oLJhkPhIvIJtSFciycTK
         5QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760302749; x=1760907549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FV+6yoKv/P9OgvlWPQKcQD99p3mLWnHYMK2iXPsZM3o=;
        b=ZTwYrtMY14lRnxh/28RhHNb/5LaZqjebF409tPnJtsnXZtrgIJwMIybIMDIQ50aSEd
         TccCOC2cjlluTs3ucAfu3VBFXxfBenhcmZ2S9kc0OcR3x82tX2kJLeDDHill3orRQsWS
         JLrCpa4oRP27/FFhi1Odb0fNynIyjrJqnalHvkWgptFHDuMgD52yCft9LMQhFMqW7q1A
         fGO0B3r4HtJOcCXAfz6LUiw8wuHnmFYZ0LD/UdXZg1vtIw31VFEkom2O7S4/iPArS2B/
         sQYia7p7JNlY3AkDt70GKovXpC+l2/7B5acF6DqsOg9omky3HkIk9UsIDLqFn+SYpJt1
         qIZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCAAoAEUk8Ceg1u70cTXnqTmx0BQgu4KM213sus32O5BRsThl/SYdMFRpgPxnEq7jRxskDkGHjvYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYaZAik8AbjWtaymXSuGMV6OCIEre93RkDWdZTtOlu7tNi4pCh
	t534qRQhs40aKjsRsJp5EP45sa2duK4S7pcj8wzIttyxsMUelMMjB/rf
X-Gm-Gg: ASbGncvSSjC/MW8lMOC5va7wEeycsp2jWbr6/kFAXN8nQqEMhtLXaumHGMqL6dDavNi
	Vj1fum/ghwm1SFTeQgCQKZ7jcsXtz7FO8F1UytUMjXUkrcrugIJqFzIMsDxhxXxD9ZQkCWDS2Gq
	vR0HPB3VvdGUj6hnv3cm6cIp1W619SjOlrtXh07MT3i9/82yZC9t8yAqQWqirXjEvxOW7wFUSmA
	d+s9vguikkyQfobjtgcl58Ika41TBlL53Q5pdjVuEWE2SG3jh56pN7t8K84Dj9hS/XUuVjdPezJ
	s6oCwWHcoPMVALtlDE/29lC9nz7CmZZNgaSopvY7wXivFrWW1QZ/OLnaFBriXTJQnwGqZc3ZpLB
	u4typ1OiU13SdGOs2izA+GbfIEld/1zLa4hgEZzkigLm1JEyn4sqjkSKaNutyCwhBACH91fn/90
	f6EG+gG3b3
X-Google-Smtp-Source: AGHT+IHtY+2+uH13hhyazhLdneYWQO5n0wlug1GAYN01XwbK9r5lScGjBtdQeUGHDHf1GNUaqgMf6Q==
X-Received: by 2002:a05:6000:3111:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42667177d9fmr12401174f8f.14.1760302749069;
        Sun, 12 Oct 2025 13:59:09 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm156506505e9.10.2025.10.12.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:59:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v5 1/5] ARM: dts: mediatek: drop wrong syscon hifsys compatible for MT2701/7623
Date: Sun, 12 Oct 2025 22:56:55 +0200
Message-ID: <20251012205900.5948-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
was wrongly added following the pattern of other clock node but it's
actually not needed as the register are not used by other device on the
SoC.

On top of this it's against the schema for hifsys YAML and causes a
dtbs_check warning.

Drop the "syscon" compatible to mute the warning and reflect the
compatible property described in the mediatek,mt2701-hifsys.yaml schema.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/mediatek/mt2701.dtsi | 2 +-
 arch/arm/boot/dts/mediatek/mt7623.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/mediatek/mt2701.dtsi
index ce6a4015fed5..128b87229f3d 100644
--- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
@@ -597,7 +597,7 @@ larb1: larb@16010000 {
 	};
 
 	hifsys: syscon@1a000000 {
-		compatible = "mediatek,mt2701-hifsys", "syscon";
+		compatible = "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/mediatek/mt7623.dtsi b/arch/arm/boot/dts/mediatek/mt7623.dtsi
index fd7a89cc337d..4b1685b93989 100644
--- a/arch/arm/boot/dts/mediatek/mt7623.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt7623.dtsi
@@ -744,8 +744,7 @@ vdecsys: syscon@16000000 {
 
 	hifsys: syscon@1a000000 {
 		compatible = "mediatek,mt7623-hifsys",
-			     "mediatek,mt2701-hifsys",
-			     "syscon";
+			     "mediatek,mt2701-hifsys";
 		reg = <0 0x1a000000 0 0x1000>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.51.0


