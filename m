Return-Path: <linux-pci+bounces-41645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32945C6F608
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id C5E732966B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3FE3AA18F;
	Wed, 19 Nov 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bPqUCbMN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31308365A10
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562957; cv=none; b=e2RHA96iwlzWYC/TDF5n7dCB58R/v+DaOfq2aFYTAg1SB7l6IvYAtzASdrNH5vABKdKriw6iwg2PvO1b9g39FwAfj8KLcurMSjAWzy8rArmBhTdhngNjc3KwBr9bGGpZOwmdKC8w67bWi/5O86f/GOF1ykJCNaYL2mehUsS5/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562957; c=relaxed/simple;
	bh=GxxNnKqOhhteuHOBQbAn6ykS5DynDGw/557Fxfc/0MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUKEhH05L+5ffpg9lNPrNBo+CtbuGEZ36C43D6od89zFQOW9zzmSVFPQG7mZt19nMl5j1/3hr61T/ygSGinTon92ZI7vBNMbKjfyB/vR16G8IXungLJBkHAN7y6LhnU9s82/s0UaCTmYx6RMJuSOtoOsoH6yYqxWBzyBgyx8Los=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bPqUCbMN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so68066965e9.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763562954; x=1764167754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE8+3pdeBgHj1yFTM9VT3Mx7PcWOCuB8Xgf4pUk7jgQ=;
        b=bPqUCbMNu+n/VTE/gI8v9H9621pt7VydXpcpFX1VcbE5fCRXAHJd9K2lv09NvIQ0WU
         1z8LOg8d4mXR/X23Ki0D0PEQw6rbikm6/qv96guleehIfiZ8Up+OJkLALModhiDwHZ5m
         xHxFjL5ge64gnkDk9Be81JZ0h52Y2bxRCpcP7Z/fFP8ZsOjPyWvRGVZB+m1nyG7ZWBRu
         wVd/5ywQZbY0nN22f+CHYBW2lEUnJG8fr4cPzsoFKnkwXcT4ZDt1NkmklEcwi9JA6qmV
         dzRMCubbh+g+An8RJEKA9XxPxtuZEzTspxVw2W1K5+zPjDFlKhuEph9Be48q+8jXW/1K
         L0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562954; x=1764167754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YE8+3pdeBgHj1yFTM9VT3Mx7PcWOCuB8Xgf4pUk7jgQ=;
        b=lKxaMDstEp+wOS3qJF1D+OIzwOPWfEVDOX+y/dDK27aruSnakXzJL1CLPwKzGg+U1C
         iJ75WF35UrU42rLwDh9GfuufjNx3l/GCUo7WO82Al8qlc13oB2M90VKNki3m7K5Txu+r
         tpq4doF0WLbwvgH5IyW1Ghf6hmk9OoQ0mB32fJ568n0Taf8lG0ORvolVUuhNiXHpKyWe
         J6Gc2LGbXd/VUZvvS1+8Sih+uicvfrIm/CHL3kjlhqKjq84gm2yDY5v8wPyYu/Rt5cpa
         4Gi6VlMrtC+h5rNPO6vd+KDMz6gt4vqiBk/EcZXsbty36EcPwlLN8co7nix2eFSGouBZ
         +0lw==
X-Forwarded-Encrypted: i=1; AJvYcCVMzQMLPCTWcuv26n53j7nC8tsnDwaBqsVnysTXbkVpoB6ciOlr8CCtynGCYg0rbpQY+dQnDuAn3y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpAMTl2ypLjVQGDgIBUrPcD6A6qFgGkrse66q4F8Up5j9KB8fm
	fE0bl6FQ4/auyCtkQlGv7gMwcTui6Iwbj15ZST/Ssam0VMyr8gwhW+nKDKq7gftCrZY=
X-Gm-Gg: ASbGncutLfEKDTAuw9GkVjTTCqUEYQXCmzBWgCo6pjazWxWE0zYUZOYDHBgUxa/2lnO
	1fYiygP3rXeE48sK9j+tyUduYoW1bMl18Etde9YkHGsLUGV400OPuslTzq+uMTHseeQFnJ0diqE
	qn2fZaFnlP1jrW8JeBIYDw+qet+YtH873PQokFhegH4BAkbEyUUIWy53vMVoI4rkcTaAMkUgWFd
	WCUXpsMQE1WfN7eg9sqtz+Gtr+DsnaqpbdV9rtwzNRYU8wOUq+zM6fUl1RK7xY3d4MlguWC/CzT
	r8UQYSzK6gt+E+JxJFG5/4afaS4NjLRZT2YzskiD1T+V4sEkSTUivRIIh+oUMaLZ/XdCJ19Dt2u
	+q6xgqHOD/l38pawuPUHStjRnkYXt9BtKhKO0lAYZLYmNC3hE2z2v4a1QQ/HB5bnCNsMAroJwb+
	etheVv4v1UjuYWoEUtMvPzaz69Qwkz9frGdaOOYLxsd9C49iBU93g=
X-Google-Smtp-Source: AGHT+IEd2Ccf5fjluRhtVp52Y5wk7ZOl2KQ0o3HpW4E+mTPRtKka6q7IqCIxDBj/nihRBjkex/U8QA==
X-Received: by 2002:a05:6000:2585:b0:426:ee08:8ea9 with SMTP id ffacd0b85a97d-42b593901d2mr20461307f8f.44.1763562954457;
        Wed, 19 Nov 2025 06:35:54 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm39973399f8f.26.2025.11.19.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:35:53 -0800 (PST)
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
Subject: [PATCH v8 6/6] arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC
Date: Wed, 19 Nov 2025 16:35:23 +0200
Message-ID: <20251119143523.977085-7-claudiu.beznea.uj@bp.renesas.com>
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

Enable PCIe for the Renesas RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- rebased on top of v6.18-rc1

Changes in v6:
- collected tags

Changes in v5:
- dropped Tb tag

Changes in v4:
- made it builtin

Changes in v3:
- collected tags

Changes in v2:
- none

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..54fd09317edf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -230,6 +230,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCIE_RCAR_EP=y
+CONFIG_PCIE_RENESAS_RZG3S_HOST=y
 CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_IMX6_HOST=y
-- 
2.43.0


