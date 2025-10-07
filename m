Return-Path: <linux-pci+bounces-37671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D5BBC187E
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F95919A334C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51AB2E2EEF;
	Tue,  7 Oct 2025 13:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Nvi3bpaq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA12E1C7A
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844247; cv=none; b=CwGRXfSpiPgmUokVmYGbLuG4HDjBba8CiHkzlxdFv8vYtHH0MAv346prG2JUMwkPPJ5w8KMp83CDRllzyZivXPjcXq6gT8e/4rI1k26axyDiTCYnrsBBs7QfP3+8Dc/wWTAGR8lWGqm8/Tnej7a5paMc4DGdGKIwwSCsOeeCWOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844247; c=relaxed/simple;
	bh=yaCx/QXvNC+g5usMHZ3TsHW2T6LwSJ/D6SVOOxCGqwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+Q60sG+G4DyiMWS4dj1ea/Ps4b9SNg/eAH6U45dipxPjuPqlIUBkDLSFWWviYf2uVDP00/HsI5R793PUrEwWfGoQbm1FUQp0KAQmIiXGZnNXqThMwQvVmTyqAowJc84kyNWp4hgOgmSfBC7BgXPDTDQYjbUVUVSdJCK6RxoZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Nvi3bpaq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so58730975e9.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844242; x=1760449042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1z8hWvOzadOavRT6eY0ADJYVQmzPY5Un07yvaG3S8o=;
        b=Nvi3bpaqAeNOr99iDZCXPGZUh/cBiCtvjUs9HYDnQsWXWQod7HuHRsHpQa5xg79Iy4
         6tAVoFt1VO2SKwgfE1oIj/kVl9gbu8w/d7ikwsCkkBp95Ydew2Yo6J818tA/TsqMCgHK
         H7j3ZWYK+py6DtxUeFa5L82eWNU3S2JCIWlmFBClaTJdOola0x9q5oolVoH72cthR0KB
         /88AnyjeItBSGe0/uP6ZHGgZJqAqzEg1tTlpTIXrmRR8ibydKUTk9cmEPE2P1SeKgDLh
         /SBmgbbT7twGNf7dWAw8LkFiC9uVEXs0FxoafghV/ppsenWun3HE3EGRbw4Yp7rSp+f2
         C77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844242; x=1760449042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1z8hWvOzadOavRT6eY0ADJYVQmzPY5Un07yvaG3S8o=;
        b=L/lSi/jnKZmU1Kt4GychqGcwRVQFP3ewphYDodgQ1JveWCDA7INua+zlT3GgSf7Cbe
         qRUCdtSltMQmYYHKJF/Wm3TO5j9VfUn8/3kB2XB9ld/GKuWU2CRWmX6xF9TwrO/G5zzA
         cGkLtttbF+Qbe5f5uFew87NbOTomttNq+s3wBI1H/nCOIa6QZVt44+ZKK2Pi3jX96Rv8
         BPQ00w9VnM41LpxmgOGmiRxwql5S8+n/z3YPjbkT9xezMe79eX8VnvOxKk+vBz6tZZw4
         kLpO0O3AK1TLcK6qWtrm4ZmVWXaZbx8GvlXxT7vw5HAoaM2WnAp+xtZn/qc+t5Jilqgf
         irJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMW31heyYqoy4l+8461UYTzaZWYpVFJS6XtsBh4j3YdCfnFK/J/rVXtHgPmTUNwDNN8AF8vyyM0dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2anrJNzSXiHAPpiBP+bwnH2lKKsBAEgtrXozrrcIXIkUFwtiD
	C1AbeQLUk+Fjt/eGdQ2Nl0gd+pEaTPlr+i1tCNFUo/2gKBIdY85GEs/bhUMj3CHw5XA=
X-Gm-Gg: ASbGncvnVMA8Ni+RPjvtT74FxcP0E+f1MlPfjzGIEylh0n+zyab5sIQobs8g9wn4uZM
	f7W5dYYUA5e1HvOjLLeKvVR+8Nuy2PPbeNrPMScTvwgZzYkyFETpVUB4FKI94vvy5xlOasDx7AN
	MsiCtK+rVJ7iwdRC2eyUpUyZcocgy1OnK3Z+/8ym24V814RbkTWMTSC0bYJVPkd7MJGMSR2AjCS
	sOqVg+Eql1QFL0Sy9GEZd7Fkgi03P/yDSvn5Kck+g5zTRosFt6KGbDduvCRzTDOxfRZocWbCLZL
	pMdl43MaJSEDo7QRu8DMhV9sfvysKIeCHMTo1Z7nVnIK64pfY2rGml3YzpfjSjqjkGXRJekJaLy
	+Bwg+pPy6pDtjUMKBOCnePADDkzLUPpwz
X-Google-Smtp-Source: AGHT+IHfz9zJI0lmSyerN85rG4LviPI/1bLy+sw6oZnepm7Ovg0zyDxv3/LrYkgGVaFxC0dz9CvL7A==
X-Received: by 2002:a05:600c:5488:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-46e7115afa8mr119636995e9.37.1759844241581;
        Tue, 07 Oct 2025 06:37:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Tue,  7 Oct 2025 16:36:55 +0300
Message-ID: <20251007133657.390523-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Versa3 clock generator available on RZ/G3S SMARC Module provides the
reference clock for SoC PCIe interface. Update the device tree to reflect
this connection.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- this patch is the result of dropping the updates to dma-ranges for
  secure area and keeping only the remaining bits

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..b196f57fd551 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -172,6 +172,11 @@ a0 80 30 30 9c
 	};
 };
 
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


