Return-Path: <linux-pci+bounces-31542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F36AF97D4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CA8589330
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D854C2E0905;
	Fri,  4 Jul 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m8REOPak"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F632DC32A
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645693; cv=none; b=JINdEQtQNEtOn9Vt4oGr0Pc31Zl8Q2v+0aAMXs+9wv1IXv7oXkecAAQZNYqSR5Skr8RzLs7MvANHNFflgzD+hCS0hIUVH39ziYxr+XZg1b1In9GBMYvFwxDrV1Zg/oxz60QR9mDtlHuw9Ma9L8urXTuelgag1GN6GFpz+9d4rQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645693; c=relaxed/simple;
	bh=gR9Wn5lFTL1dH5LwfqEgIlxPVfhpUTsJpw7A7wwQ7mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAiel8vEc0id8BbgBrmVQZIyFBHiMN/e27lWcp1q7y8GmRNihOBBefdLMACDGa8pwxvke6UuDXxJWDoQxOMDzNGPRwnKtYfWcKo6jv9+n+lp743pMaFhH/VazC+/i9Gvrh76sdzOfGnWnWncDJzuJ3rb6ZwclzfXc00I+C009eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m8REOPak; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0de1c378fso162925266b.3
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 09:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751645689; x=1752250489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkNu2VPdZ05H1WkOeVUqdreqBFI4sSTNmK5wwP9pjsA=;
        b=m8REOPakEYChY/mVGl38GgbbgXq8xyhEg1Or896sgrIw5Qzg1QW8elA6BNjvsChfYT
         UFLIQDjY1bXM3NbgpofiqjFzcJvWpJEsIzIZelVjooXtoBfKkHKY7FsTCHKeA8mwUpu/
         NOCQDWBd1vrZy61n8WxjirBvbk05J1Z9qph2yinwT/CdxV9eNucZFu7ljm3+nKXoZh6n
         J7XFM2c+NHh+B3QPw0E1fTXCbQvUQRuSHCxqmZRlfXjRZwgGNmdR9XKpo7kc/dv6GZ+e
         oXyMEpHgqwH/F7u4wbRgpRyW6kLmblDiseIaCrPuIqtWC7Ec4Sn9EVV0baoJ1UYM9+JI
         uukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751645689; x=1752250489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkNu2VPdZ05H1WkOeVUqdreqBFI4sSTNmK5wwP9pjsA=;
        b=xPUheaEF2yd9hcGZcBBiwo1M9+O4RVCFdu80/Kh6B1x+fwmRr9FYB5p6/FQofKLs2e
         4URAp25J7/x6CxoNYHSExsb/4UVPsp2j+AxIfRwyWSDl7EtSaH+dyz59SmJ78+E8SkVf
         o8iZ5oEqDIO+DmlYpxYllJ1sYihtkoC9jzC0oAIRMqkt8GCps5eIU3DwNJU9zkrRSecr
         RZuaZfHnxCpXZFJSt11uC8MyA51CAfShgn/vWpSpBcZ8JvcwXwSXrMTzVmh/1cHmZjg9
         vHxJibNNhfX/TU5YONcVFHr5+0H0sHnuqDyaf3Mhm/z6VdU3HshklLQvbXnz6+5C6Uw8
         7L5A==
X-Forwarded-Encrypted: i=1; AJvYcCUpMjvL5NN8Hxei+WTrM3oBsPQ2GdT0fgxYrEbkezS43GcN4zLjxjIwSLxtr6TBk+FtPpXVtXdfY6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLIqGiomkVUS4PksrLwHZtJTriDgS61JlzLfU1Ce+PH2xvNoo
	+nmCTQYYMiIxQ4r5id+WHAEWVrkP8E8EGw1djBruEgDXKUpkdv28JVPSSchkcJ50xgA=
X-Gm-Gg: ASbGncteM6/XGn5YAmjQGAy6EgHb2iWPwH5SWKYH+jdjt+0PWFLnXL4fppIvJQWfr66
	2M8CEVBhiPDEHokrRmFmC2ajWVB5nMR1pr2T2m4kTFIFRn4V44k4VBak033MZSTKaCH5js8BN+G
	ikqUbE3BXl3fCXxEpHMJ9a8wR5E10PIL2sPgPIcWboa0jmjSZ0UKEWWu54Zo+IWeaqKK23PSqB0
	xLObBoH/MNrYHBCYrmba7X9pFM706XD9PtJITPhU863DUD0xLIgBgWStDD63Kd15czN0nXE37uq
	U9RtkSydv7X205AG4toYodijkYY0uArwk+VCxG2wMnu2ZrqqPxIMPN5kv7lYnj/POpvjs8iNRvy
	v8nW4uyW04idRx2A=
X-Google-Smtp-Source: AGHT+IF8OBJYopz78uTu4zjr9M4q7cZs8YsJ5lxwKzH9GFcsxUYxUdsvzpbrV/sgFDsSrcOtLDUf2g==
X-Received: by 2002:a17:907:3d0c:b0:ae3:163a:f69a with SMTP id a640c23a62f3a-ae3fbd13e86mr283273366b.33.1751645689346;
        Fri, 04 Jul 2025 09:14:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d9215sm194703766b.2.2025.07.04.09.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:14:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	lizhi.hou@amd.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
Date: Fri,  4 Jul 2025 19:14:07 +0300
Message-ID: <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The first 128MB of memory is reserved on this board for secure area.
Update the PCIe dma-ranges property to reflect this.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags

Changes in v2:
- none, this patch is new

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..1b03820a6f02 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -214,6 +214,11 @@ &sdhi2 {
 };
 #endif
 
+&pcie {
+	/* First 128MB is reserved for secure area. */
+	dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
+};
+
 &pinctrl {
 #if SW_CONFIG3 == SW_ON
 	eth0-phy-irq-hog {
-- 
2.43.0


