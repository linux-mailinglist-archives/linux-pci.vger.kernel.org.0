Return-Path: <linux-pci+bounces-36801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF68DB974A1
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8462E19C5E17
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 19:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC6E304968;
	Tue, 23 Sep 2025 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI8sVTq8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5B303A1D
	for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654446; cv=none; b=MuukBMbNuEh1hYc/RSU5i/aSG0Ydrw0D2DIxffWIN+GYMKRz28qfLgNATPywQszh1eg0qb6qG+m2dcMuOe3kK2djWGoAc4BooOvTDq8A5AQz3LUBZ9ZZJvDmHvEeV2TmBvryq+b8RY3jEKGVfavHM5njDObV7+liiZH/kMT4T5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654446; c=relaxed/simple;
	bh=zdGNgePx0iG5TdC4PLAwgN6HlxLRLnRyX/Uw1iUB1ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMhtre/gXLcdeF/NNfnS45uyOtvgsH6b/Ff2XyRR1EI7N+qoDwMqWO/5RhdfeP+SdyOz1ofFyI/BO7AVdhLXTljFMljpBFsqOGU8cVkQepGUjMlLJao0C44NnRZcK6LRKacF8eBU2rLeLuZ1lutqzC5HXAad8g/xLlxWnO/Y9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI8sVTq8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46dfd711172so19964725e9.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Sep 2025 12:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758654441; x=1759259241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlIfyIuKUfu0Giv/t2LPO4IvsJ2XIyV5+eVLug5OMo8=;
        b=dI8sVTq8eldQu5ZiKhybJdHZq+g7GVV1+DnBjxOp3GuLo654huGMp5DGVsXCu4kszp
         UOhCZjFErqE1W3pS92GTPmBhZjVkLslKwtJB7qgHn41Tn3ccsSDn0e8MAnkGte18F+n8
         cHZwku61Wu2og1kMqqynYdC9hln1PAJ5262pagCWIsRE0Pa8uRTGxMGNqPjY/fxqZpAl
         gOivuSrjT2Cf6PgLeXeP1Sv6an5g6T2fVdYPinKsxZpynZ8J7Dcm/HbvUWqpPX94qsAR
         P8xTIxLX0ezaP/ut6jFvNPtxijx2COVxNuJh6LSWOh9FVjd0/nrLZiZGaw94K7MKM680
         g6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758654441; x=1759259241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlIfyIuKUfu0Giv/t2LPO4IvsJ2XIyV5+eVLug5OMo8=;
        b=vsj4P/61z1nwsJmwH/7BzoFfWemeX8juTlowD8MJrQiGJnqtFO3u8ssjHr+SIiy6v9
         GRgMHJa3bZs7z3iEeQpxOVUGPBbfvAwfm4ejjsZJ9+ytMGBbmfAd4EXUW08Jrl0ERl6/
         3u+ooTgGl09u0ELpHK/nUELKxEmWZ7waqDmUstnXAq7kYP5rWX1g48MXNDt9RhDVQ3Uz
         xNbrmqjHU34e48GVF7vNsD3CUnp9EITVcdz5+dDZOxrL6b4WNQmGVj/Sbax0dM/jflh6
         ZTuT5MOXxSzmK+3xm9v8XESRhVB61+j/SWuHwcKe4nAnz11s021t4iSjag1i3YleQYAw
         AujQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8gdXUa7uZcFKrwdncMH0khyr0iCXmJyQ3mSrqIfZhqrvi9EyY1uneuLUHLmHXzTM1enZUga7e+HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4RUJY94z3VJgE68LHFhSMStdB8/t/f/Qvy6g5N4nwruFPdTyJ
	aLasPCBlLfXf/3yqKHHoZAbK97gyk2adG6uzZmyUZlmpjJeaK/3PnaC5php0MQ==
X-Gm-Gg: ASbGncuyYbICM+o0ECEkzCRO1WmgRT632bAygPdRHvsAhYLLjVDow7RV9OWQPcvxRWw
	Wgv2ejEKbe1WuBh6HYM8PNQvG77/qSGkcJhp1zZPJ5v4A9NO3uW9tG/t8z6mm6L97oFJiQRdHDa
	425AjQAHJNk7pT96kSOz7XTN/Bj9rIYnwCLBn9+Fr1+fvPjD0nzHnCUdTRH8MY6FJAkByHr3BzS
	r6iapBTYAbwZdcZXLoc2UFl/SXY0mRSMp+JYMjj6Do6rWW1i+YlCCG6EbjrwnjZ3NxlURJL8Ed3
	2FPaug2P8PXRGwKQV0QKQH46XvSg2eeDIlBsKdpi2Jm9UzG4bNtvk2/rKtcRqRWbKqqa+A8aAs0
	pHGiLBP+2DEd3zSdm1SLB4AHiAiZ1z1vkdfc9j9M6q/Ka1wEi5Vb39ZddJ0a+Sd6OwTDUlzo=
X-Google-Smtp-Source: AGHT+IFoxRtCJp+VI5Tw8FmClZ4lUAsWofpK0fvdL3jcvd8nDXAM5pqPxbH7pHIHEhBDKvkDPaydXg==
X-Received: by 2002:a05:600c:45d4:b0:46e:1b89:77f1 with SMTP id 5b1f17b1804b1-46e1d98004emr43610015e9.9.1758654440543;
        Tue, 23 Sep 2025 12:07:20 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm265240915e9.2.2025.09.23.12.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:07:20 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/2] PCI: mediatek-gen3: add support for Airoha AN7583 SoC
Date: Tue, 23 Sep 2025 21:07:00 +0200
Message-ID: <20250923190711.23304-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923190711.23304-1-ansuelsmth@gmail.com>
References: <20250923190711.23304-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN7583 SoC that implement the same logic of
Airoha EN7581 with the only difference that only 1 PCIe line is
supported (for GEN3).

A dedicated compatible is defined with the pdata struct with the 1 reset
line.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Fix alphabetical order

 drivers/pci/controller/pcie-mediatek-gen3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..6e68ed75b564 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1360,7 +1360,17 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 	.flags = SKIP_PCIE_RSTB,
 };
 
+static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_an7583 = {
+	.power_up = mtk_pcie_en7581_power_up,
+	.phy_resets = {
+		.id[0] = "phy-lane0",
+		.num_resets = 1,
+	},
+	.flags = SKIP_PCIE_RSTB,
+};
+
 static const struct of_device_id mtk_pcie_of_match[] = {
+	{ .compatible = "airoha,an7583-pcie-gen3", .data = &mtk_pcie_soc_an7583 },
 	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
 	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
-- 
2.51.0


