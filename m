Return-Path: <linux-pci+bounces-41643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D937C6F764
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DABA3A6871
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4636655A;
	Wed, 19 Nov 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UELPLbVE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C8364E93
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562954; cv=none; b=p5Ju2Fl2hgN3FNxDi+pY9ATi/gQ+oHT7T2xOtrdcE+bOXzkjzVhxUnd96uG+kqk24vKXduNAKqLHcCMnhmcAs116P1BzZJJvcqaOkHZphH0+ASiDmQ+PLRCakTAditecJvAO0UvpJ9K/fkzcQoyAQ4UbdEB/qrlJXXl0bTBoEME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562954; c=relaxed/simple;
	bh=11llYBJlsNGu46qBbvgUePXbm5WDYTu1X+hgJv0rNa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlbVqaPHk1iLLftqMw2N/DEiQR9WMqSnzkOpHZNmjigSkJtJ4d4uoWqSwtuQ+HselgOxlIzfFTa2kigSHESz16sVAO97Wh8LJB3/7dajD6YqRlL9lfEp9LdCO9Pv96SDbtcDdwi/qCmsrdylSicKyyrAEv/tQMapMJUHhOHyrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UELPLbVE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779adb38d3so35928805e9.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 06:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763562951; x=1764167751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNQs+jMGb0vll66kRY8SuunRCpU0Vo1BfiANzBw4F1c=;
        b=UELPLbVE1WnSMn/cS4lA838slWRaGWPaZgsLYDymmrkD9LBuFTDgHzM23VXe8WxxwR
         EoXAw6icDtrX49NMgpFZ68iDHNtzvQMcmh2tkOY78eYq+a3i7pmEo44Z8ZuZd0FndX1m
         RifGHZgN/DFOoRXyQHwYL/9D2vy12FZYxCQ55zQWA8GKGsmzIGNBIrtlSc67npjPr5f6
         4pzz2PVwicpeMTWIXktz2kJSfCWjTwskHCuKQVTkLyXBoCbIVPI5wFtyUG+LUHT1ZB71
         FXR5XDq1Qmscc7H3ZrPmvxn7umgjahqA0Y5pihUFoonsIrOwZQUzlgpUWG03OdsjzZ5G
         Frdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562951; x=1764167751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNQs+jMGb0vll66kRY8SuunRCpU0Vo1BfiANzBw4F1c=;
        b=dJIl7yXIT7fAoX0NpLWuG4+ARLDmuxqjx+EOfdJISHFEZQjo8zfBwcZTkebnFRFcSU
         modgB01vbbE57Mh/h9GiymgCWRw01wuQfJ6JRTOkVqBnmj8lZbDQ3TMfuPcuAogc5yIq
         QP1ZM6GZpZkNkLPBHvJExcAcaLXp9avZxWQaHVomunKSAzbliKPiJyRP0J7/CSXKTCL6
         5LW9+2vBp2uIxJH8XP1t7hCm3qbNZqTB442ti+2nB+N+ruT7OhTbDkSg5I1fHMHabtAy
         L84IaFueEk5BOHQ0kTQ3dnsmgG31Q67ALU+K/9JIjtuwPQ/YRq81qcJf7fPDjm92OXYb
         h9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWJl68qzWNAXdO2BkuDR/Cwy/aylkOQtmLkG7i37qALQ7NJWabSavcqpQnAZjBCfcDI7Wv3/GwiJY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqEeCciY9Sw1+2X3i6I3CLA3z1aPbC4QmNPP3ARZtzivl5tcO
	5BQTlggSk+rQmainMeNMSxERBvvCozBP/40BHAH2pVv+vItBJX2pWuVksL+U+EH6sJw=
X-Gm-Gg: ASbGncurDBNJZ0XpGWx3vXdJtqSPDmptNf9Mtc/9dAWlHApc7iW7esF5mIxNtU8+Vmv
	jq6yeyAH/XW+empSWTeAJstZzZV+3BKnX7Im5yBtzz+zrbb+B17dKLIdGb6i+LMcf9E5uC0GAgA
	h1h3zF9ozdh8epIeuH4WBB7oXHETUnw3O6ESBYKoxWFrhqTuY2UL30ArdP7MSexG8M+75iL9kbl
	F+aiuYFGy2NKU65Mbg3F9541yohINu89MwAt4aYAHD8k0u3RY3XZA7KwD23DKWNi1cLJv1XbNus
	YPZilOrO/SGspwXD/HU0n8cBohBKXS0jIBLRU43zZ+/RYf1ltC20J6WATQbJaAc9D1NsK9TPwxn
	rXRzidJwWDn8Lzu0tv+XVmIMSD/TMWREpAML8lxkQHR/3Bts/MHWzd6jeMEaiccqZvYTlKGV8l4
	TqW+hRdraGikG4lBbCxI27fh9xxd3CLnV0VZoFcA2zYjEUd11VFps=
X-Google-Smtp-Source: AGHT+IETrxRzLL90ssPWWldKaErlCBtXruYKnH8kKJ9M+zXXzSsOk2J5nfNKsRlo8J6q3wsX3XzrlA==
X-Received: by 2002:a05:6000:1a8e:b0:42b:3bc4:16dc with SMTP id ffacd0b85a97d-42b59350576mr19482167f8f.21.1763562950591;
        Wed, 19 Nov 2025 06:35:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm39973399f8f.26.2025.11.19.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:35:49 -0800 (PST)
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
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v8 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Wed, 19 Nov 2025 16:35:21 +0200
Message-ID: <20251119143523.977085-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- collected tags

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


