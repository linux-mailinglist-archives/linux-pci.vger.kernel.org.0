Return-Path: <linux-pci+bounces-25345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36621A7CE78
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 16:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FFE188D154
	for <lists+linux-pci@lfdr.de>; Sun,  6 Apr 2025 14:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054A52192FE;
	Sun,  6 Apr 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xs56kBp/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dzkgQZet"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C524D374FF;
	Sun,  6 Apr 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743950953; cv=none; b=bRdKstgFuC27km/nMs1yUEjdgcM91WQ55synaUnSefW1q0Mre3SMXAI4/6Ynz5MLtXh5iNIjtRqCdTg9X0Wk0mFml/WiUbPQt6foUF+2evfw0bVXeZ0iUQoeIhZ3Ax56L/R00fh3fx/rLuDul96J1q7vn82QDKycwDjr1PWvu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743950953; c=relaxed/simple;
	bh=vFyvA13SlAAAEGFqFxAZNVJRL3ZoRzg/+U4zupEYhYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsCdoLdTsfv2+XnPTAx7kapf1J8ReCWSTC1NPtFxvMS1/C8zUqavDAdIfcdveOATyjHn6DIi74kWUUwXt8XAuamMRkR/kVuG+zHgM2ieajWHf2b8IPYgrf4Du/9ZQRGYNWnkjB2zCEMgP2XGfjSHHPwsDmD1z5PDu4QvdnKffvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Xs56kBp/; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dzkgQZet; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZVwGF5nR3z9tQF;
	Sun,  6 Apr 2025 16:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycBTCZ6phJ4SJE0t9zpOsgIHPcVGoFYE6E4V8wFx5YI=;
	b=Xs56kBp/4SELh2zEf2aJ79xVl+PDjsYFWhIAf5ZiYk66moWIN34LGLHnRmCtwZOhsrBuLO
	Hei5S+Lne+0ya3vfAg9A/PxfSlGxENzRC219fQ5Ofok4pStkkrPLYknik3/VA1Ox3vUbs4
	3z31LJI+F84k7AFsBG/hVWiTU+6gZIx46uwv9eHVty2tywJif72tLPOFL4DllkQOYFu0G3
	yva+EjBAEa/JnRmTLUZ7QUMOX4cT75bdr0PePafhqiebJH24LOaZq5qzggnwq7uwZ3cZXa
	GQGVmW6p2ZGv1x9ojdLyhsQKbE7+Ov1uFzlH/0HnEKrO4B3ReYqce+x/jctoQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743950947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycBTCZ6phJ4SJE0t9zpOsgIHPcVGoFYE6E4V8wFx5YI=;
	b=dzkgQZethTvaTnVe0YhtJuKnmth/syQ+cN+FkNbasZDAEhjpgpMfOpR38cT0tHirngvfzk
	rlriI/39fFN/ZdeGUHcaqQEN/gXtSh7OG6wYbYCD1FK91I5urFnHgnVpd2dctaHX4ABMz/
	qcqHUUg14dtOkIGBXXtWtJL+4LC2o6SKB2CFYavb18+LuiwfHSkCohX1/KqC6qryNAoX8r
	c1wv9NJACmdSjRMAf0v5cRFRkCsY8oXaH5YiZiTxFTiSYJk8VpRFExAvYV0q1SKP/1WgJ5
	GI0DA4G1I5da7j4alKSymglt2ylLmgGEx7ITsQZt21RjvMVvLyfSjvo8WJDbWg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Junhao Xie <bigfoot@classfun.cn>,
	Kever Yang <kever.yang@rock-chips.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: vendor-prefixes: Add Retronix Technology Inc.
Date: Sun,  6 Apr 2025 16:45:22 +0200
Message-ID: <20250406144822.21784-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
References: <20250406144822.21784-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eh3cxapmdc34r7fzbija53a6retpeg3b
X-MBO-RS-ID: a10c0140563f717f0d4
X-Rspamd-Queue-Id: 4ZVwGF5nR3z9tQF

Add vendor prefix for Retronix Technology Inc.
https://www.retronix.com.tw/en/about.html

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kw@linux.com>
Cc: "Rafał Miłecki" <rafal@milecki.pl>
Cc: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Junhao Xie <bigfoot@classfun.cn>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Add AB from Krzysztof
    - Add RB from Geert
    - Add TB from Niklas
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae2..2b1bf6709aac7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1262,6 +1262,8 @@ patternProperties:
     description: Renesas Electronics Corporation
   "^rervision,.*":
     description: Shenzhen Rervision Technology Co., Ltd.
+  "^retronix,.*":
+    description: Retronix Technology Inc.
   "^revotics,.*":
     description: Revolution Robotics, Inc. (Revotics)
   "^rex,.*":
-- 
2.47.2


