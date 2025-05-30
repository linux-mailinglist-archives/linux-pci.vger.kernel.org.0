Return-Path: <linux-pci+bounces-28707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D914EAC8CD9
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2137FA27EB4
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B222A1EF;
	Fri, 30 May 2025 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BnpTPMmc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994C22D7A6
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603999; cv=none; b=oWW5jJLl5jhtVlS9XhaoNSm01M1pvc5R2uzSEcpzHmSP1J2Ra2Fyo2geix5cwk3XIs9vvgRiTzrBarggEJK2SMfAPHqL+Ixwb3qd1npYMarel6ddQKcO3R7HKjm8yHEG+IcIRq85uvSsDz9el6iiFOWA+s9QKCeB33Cg5VdDIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603999; c=relaxed/simple;
	bh=JTrdaAZ1ROVl7a1oj4t3COHx+ERflhdGhlJk2YHh1O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPdKaZtYYBcEwO2esU+ASFmdthaVmtugJW6Z6ft8jZZmseDHWQedxEUftTK5k+bfzDrONzs7OqGuW7D8qk3JwZIY1Loyou1GP8VvLrjyG64Xb1WZXqLT2ArCVwQUxQrvb594xM2BXMLnC2mLduJJs7Pn8FZjD6HqLgiQGAm5C5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BnpTPMmc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso15252635e9.2
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748603996; x=1749208796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrSNXGfd1043Q08w0S469+QeaCD1uDQKPuIZl5ROhFI=;
        b=BnpTPMmcuog4O0CSnJ+ayesc1LGoZfog+M5zTi/2AgahLxrysziU5F25UhpD2fcB5h
         gW7ClGnXI+2yMo7W/zo5idxb2t3Dhwo/Ewm9ZjbpaDHFWem1fVsu6xaT3wazo15N5UAf
         QOtFchKf1u08qipINvqXT+mp9o/+7SWzSahM5mL9+hrh8efxzK3xVRvshbGKhbICNRm+
         TzGcpoz/Yx4jZVIYvggBwlhdtnZcXvf6c/CDKJwhXnNWrC2ZKGpLXkOBiNl5qNYO47+L
         Fd2m3O7Mt72zcZ00fxG4XSv5ID5UEd0Z7ExR5Fw1jfUYdMYJBtlYsztgHdGAej5RbzbJ
         RCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603996; x=1749208796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrSNXGfd1043Q08w0S469+QeaCD1uDQKPuIZl5ROhFI=;
        b=I99A7DIcSx+CZKWLi8Lx0umNw3Bbph+IID/wW7ECoTeFs9al4N6wNYkJ6eQ1BYI10z
         xiPvkm0M1omVnEJCFRBwBqgpg7fHJdvMvEeu1EadINZX8qQLP7MeMEm+4epfT9RVW5xy
         YhS3nJ4DLoBjChrqj+lAGk8CjeOcg72hZSrP8YV+4uqOUhrmRoO45UDxJJqKHM2ZQJGB
         nuxONMn9INKWHxQ5Kl6HDeFwBGIqoJcWLw6QUvPadtJeq9xWN4Njzz+IZgPxrzWCO3PL
         u+KiHngiOhfVl/fP5hauTzf0NNDEskFKlIe4ZZu9VWCS8smsvkugZXI05dYt6vMd0rq0
         fZeg==
X-Forwarded-Encrypted: i=1; AJvYcCUj9gwr1hxDcyll6w/HPrfbHupZjrnkCAsaW4clLWsdO1IN3wc8hGs2HwMcot00xekkUBJcRy7MNV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgWGb9K9Q8UxnpgODlYsjfcc8VzzXmYZJStqQ+4S58u0unG/KE
	Vl7DXehMVbNjz1uxCB/JsFu5YZ35NH4qEs4GEMl5i80n0kd4pFGhHDom+Xf/INq1QuM=
X-Gm-Gg: ASbGncsmj1+unwXl62ZvawEldAiXP9RXuSm0dYzddivUt+v+zpT3XPnoEtCOTU7s31y
	nsNm6Xqfe29WaYG0jH+il+0cNgOM6kNU69wQ8VqqRNt7wMBT6A7kfdj91lkNBKMm2E33VcVA5Fw
	7HvbSvH44BUOjd5AF6z2CDVFPE8pG+AJ08OxpTLqhNOPK/lAoUj4S2/rdDIYDEJn0Q0TDn4cGdU
	ac46AKDEwMlUdORWFV33hxUI1xpXVN5BMq2xFe3sNmH+x0CdUo0pF5MRLhrXB8nEkrl22LD2Zx3
	0jauuX8A5FRO4PVUtMBAapqHSQH1I0yncPIEZZHgGuRmrQNd+m68M7K8A6eBBPeuQsiiKpTByor
	1v1vmRw==
X-Google-Smtp-Source: AGHT+IEOmvfgxDBSjQyjTAsEbb9y2Sc2/DFcebPrTV7oNj2NnWeeNPPvSc2ZCRmRQYNSn7XQ7be7vg==
X-Received: by 2002:a05:600c:354b:b0:442:f44f:654 with SMTP id 5b1f17b1804b1-450d656016fmr22662535e9.33.1748603996269;
        Fri, 30 May 2025 04:19:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 6/8] arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
Date: Fri, 30 May 2025 14:19:15 +0300
Message-ID: <20250530111917.1495023-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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


