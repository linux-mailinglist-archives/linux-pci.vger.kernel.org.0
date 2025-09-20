Return-Path: <linux-pci+bounces-36583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24715B8C473
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 11:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEB1BC6783
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC7029A31D;
	Sat, 20 Sep 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZioOIh4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DD283128
	for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360389; cv=none; b=S0b8sqQLMgYJX/jhljaAQo7+euXv5qNZwvmdKT8cFdjpeVUmiV1VvGfiBD0u5iG2W3aZwjSvkq+dEoacdIZt1B5Xc724xoCV2Vool5j9Szksjmu+uIMG0Zph8h0qZxLZ0Nhazez4HzEl5khPuWKB++BNyjUEG5RcuGjyWZlMUkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360389; c=relaxed/simple;
	bh=o5EN6c1YWCxp4RRj5b0KuE59KXin0qqHFu3hvf1nM5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beyWuXQxaWaMHhD9QKuu0l5J5dxspExAdHaGvqAyRBvuCNQ6PZXGcePA3Jx7qcyUAiusYXy0/y4wXrs+2D5TBTWMvWN+olaApiFBk0aFGViIRKIWADl48/Nv5YjjSX6n5/iXibdaxK1/WpNgx1Bww3uC4GaXg7+osVd3LA/9v5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZioOIh4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ed646b656so26380005e9.3
        for <linux-pci@vger.kernel.org>; Sat, 20 Sep 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758360386; x=1758965186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb3oQ4OLLQ4LwjywIbmgSN/BEASRwYQS+6IVWtGhrH0=;
        b=hZioOIh4XAxl6Cb/jPs7/sefRY1N0maSmi7161+3c/70JsFpuyRA2dHQ/bQLFLA8TO
         I+1gS8U2WdC4HYuFQ/XrgxQuIXBRGoX64yyNZjqRaVxOAFVrvxjiVfCSPIEY+FIq26GV
         rzFoSk8xFtinYzMTkPjz/ZKXmwsaEdFIURR3MVDnedpXnHo9JyhZQMZhYxJZY/HpQNK4
         yeIG9zLWauOh5cy6tTZ3CmTFHzxBcZfn17BolZ1vyyVETM4Bm/C0nJ/9w6CSZODrw3tu
         ZOHzam8D2CG6tAj4q4vN5Tafo3oWUouZ/6n27GpkACKsMcr3zQ1lK2m3mx4y1ufAKi82
         oekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758360386; x=1758965186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb3oQ4OLLQ4LwjywIbmgSN/BEASRwYQS+6IVWtGhrH0=;
        b=gAb4yZ1pIgtMAfvYEh72jIGByloTGtcRjDpEvvIGT86UyIycRnJL/qhG3f/Cs8ik+b
         X1+be/Q9KLb3bPyOsIEk8SuegmGirnhxVv9h/QFleD3mU3e/Y7wFfDltp4T6TImGiFbL
         yhZ4+r6+iExGB14fL1OB6FZngVkZpjiOpa74qmAQFjldtBRTVykppRHNqOX5Rvf/sPid
         e01Y1vloN1UnZ33lBlrLtaCLvgNu3Fp6PZnLM+8JzL4OYS6b4650ilTb4InyeuJRuNmb
         63q3aISH+V7+gZezAkHf/hHkHqo991Eal1pOiRELUWptf4e0Z33MOqWCB41PF1NSbLBN
         y8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW9HGM2frXU6LDl4B827YXPW0JQwo9FJuojfVUqJrkL088wyg5tqWRHHEOtSfJKtgcF1pLyXuV/7zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxxyYfKt1PaDSXlRbAjZd3vffEfcON9qMjrxTeLJygpbpOi0A8
	h5MeyEQQ4SrspSExVdG1DakjvQPQRgm1UaGy1f7NEApkXbFRNUNvL7AI
X-Gm-Gg: ASbGnctje+J4+5i8wcv4Z5J2HcIXGBd7tU6OxIhdqbeLTs9zQ7wGguWq6lmCWrztCkG
	TfRaE7OS9Y6FjuVE9Iw+LPbgIa957Tg+wHNv6pojNdbi2vf28kbGQjRy7zoTMv463baW2aqRaMk
	NgddsImncczuUlIFx2Qrz0q5mwWBQ4zYfMOkjZ9pv1sBTGibmtux4TRsNwv/j+f/+6YIHlLRk8k
	QGsYRmilim5a5e0HjTiDi3UODQMhzBfhUP4ZEQUOgNEwo8NpaGxjmh5CdxOFz0VGfnHMlmMJ75F
	PjsRIpbXjMA8HCf/2Ofc7TNMMy375bCGMVHQaaMwMpxBISm2gEgLVUQaA4aVwBm8nytq8TrcdSr
	Go/LnAyv2igj/+vra13u1QODYScIVYJVfQDJdhP7BSoUDKiL8RgxQnh4c7SaDJW6xs+JSmzg=
X-Google-Smtp-Source: AGHT+IGt8P3rEmePLNMaAwjTE9SxZVmwgeAbuDHf0WXIvJ1mTKDwPrysE7A1gCCOMrssz2H1L7Vmmg==
X-Received: by 2002:a05:600c:3555:b0:45f:2f0f:6649 with SMTP id 5b1f17b1804b1-467ec36a2camr71215025e9.8.1758360385528;
        Sat, 20 Sep 2025 02:26:25 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm73648535e9.0.2025.09.20.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:26:25 -0700 (PDT)
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
Subject: [PATCH 2/2] PCI: mediatek-gen3: add support for Airoha AN7583 SoC
Date: Sat, 20 Sep 2025 11:25:35 +0200
Message-ID: <20250920092612.21464-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920092612.21464-1-ansuelsmth@gmail.com>
References: <20250920092612.21464-1-ansuelsmth@gmail.com>
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
 drivers/pci/controller/pcie-mediatek-gen3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..db9985375be9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1360,8 +1360,18 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
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
 	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
+	{ .compatible = "airoha,an7583-pcie-gen3", .data = &mtk_pcie_soc_an7583 },
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
 	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
 	{},
-- 
2.51.0


