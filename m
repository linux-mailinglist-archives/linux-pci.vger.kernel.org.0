Return-Path: <linux-pci+bounces-23955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFB9A653B4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 15:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6E07A86DF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 14:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A93241C99;
	Mon, 17 Mar 2025 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X33WEUha"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5823245036;
	Mon, 17 Mar 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742222136; cv=none; b=ujy3XTjQzU/DUKqg7yLPjIqch7bS1+Dx1zB1Yq6UsDSzzRMBXFMJ8rmF1n8VpboF458XJKo7CBtV4iNNfFdQjjCBWgFs6LAu5R/s9+AwNDPAWxQL+es1ZPnfpvootlbDVMriklCewJtl48gy7R0N0m+s8HfC6gwmqnW5kxcVzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742222136; c=relaxed/simple;
	bh=Os/3OUI8KCcOIG1iOxmuXB6ZFpAj0XoaeG61qBtx0NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tQ1TmoAbjMWPxrP11SgiBg+0Uae59+6klbP2ZlY2IgHeoT+Czd9wie0eO8N/vOMlIFcCuBFILWxjIE70CWDYgTHzTKmFvVlxyNEtoQVVtIAcaKIambSi4a/pmyW0fuO0WA36eiHKns3yGXz2+jAjT02OxBX9L+++slzUvnXBQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X33WEUha; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39133f709f5so2720114f8f.0;
        Mon, 17 Mar 2025 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742222133; x=1742826933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w87Zh3I28Z1+Sqxqq72rJtkODwwHBc+MVhcgl8wWLzQ=;
        b=X33WEUhab50tJOI/mwwnSQZGmqv1CRhRTg1NjUWfGiQo2MXxiFoqW5PzPMtTihkojd
         GdOT8QYVCJ+ph/1AG+8r3qW15QNnjiRmJBNyablQfzootPOb76e2iCkjOY8GicP923Af
         Cy172UBERuS590u56BgiAFD2a7HN0gfq7tAVkDpmzE63AaZ76024RgsDANcC61B8ZxT1
         cnldEF2OiRnnH8b0nCN3H5N4zstJWV4eD+iGhJBInU4b/T+Nzco3pUCxLlEEK3ai1Xk9
         Em1tiQcK6AWumBNocYhYyIP/W5dxctsrBJZgaG9RDojB0FqkI4TzGyEbld7aRipNmdPP
         7PrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742222133; x=1742826933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w87Zh3I28Z1+Sqxqq72rJtkODwwHBc+MVhcgl8wWLzQ=;
        b=J6tBfWOVc4OHYwQoC5+q5AcUILZwL5126HtXUkF+yMsBNbD/XBGUjBxhvgEIjJq/2t
         q5FYbL3VzTBFfTrNL1l5w4hE/OExw+nTPQICy0vHOPy/qdgMZBfDf4+WXnBByUjL/XwG
         XGmGwKZatDQXEj/Pj+oZDInP+hhhuuRo8CdrxNJ6cPynEBky1iEQ0vkXoRKOIL+4Rn3O
         832RoFfAUSrv+f95drX6DU7UfFq+HJE/DLmG+SRqXPL3io4BxrVdwVZFh0AJuAOKr6XH
         +h+q/q0+ocE49sQgAKbPTHJGTkZ98sVlVjqIYEjojwVhv85Z+3Nr4a2I+00M8foz5wsP
         U+rg==
X-Forwarded-Encrypted: i=1; AJvYcCUg75F7xYOMdVZJJKHhNrnb0dHLhmkRiTQ4Naqhlelpf6/PztlImjlLzvQdqib59l8Kzr2wQEacurIlONE=@vger.kernel.org, AJvYcCW40msMrNuC89cH2wXUNCMN+fQ7721Uqoak6nNadyDsEOQa4exl24oq5Fz2VsxsjsWzfUjAeoG5VqQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YySME+JfqiOEtfTurxsX/K0/SQ3nNwDsqsq/87yneAkE15nIgF7
	5zECWcmNKq6nyJG6bfLTJmt1lc07NQm+Xle0p2N1l6bFxGhiJzo0
X-Gm-Gg: ASbGncsJeRYWLgs0Aqve/9uO9N8lSNNU7viViW32sFbybMRrmVmNjsBy7PrmvYM6VZo
	/M/l9geGGg4idyu6u/2YcVQUVmdws9b9Nso9Xy37l1eo+QDDd6MFRX6j1y5phyUQ3T9+RhS9giD
	EGlx00iZVRghB9PBeoBcStFM3FcF4Lq+3mtPyhom8HTI24vZKiZ/2O20pSSsCybsisXgKgqQX3J
	Tth0i4HTbltMmQFcI+A6jcxOwCSHmgh3pa2jU7VaEuuaT92SqOMjxWUUB7uHcpPY0ls8CeVYv+L
	nKEfvyYF2kksxgCUrUBCwmLgErnztSsLS9nb6naefFhEkw==
X-Google-Smtp-Source: AGHT+IGj2U95C2D/UDRSgWDo1hfyu3+i9z8iABs6gkm9zWiBp79gxMqCjLlCuVAE4sL2PJ8+U38jmA==
X-Received: by 2002:adf:a348:0:b0:391:401f:bfd8 with SMTP id ffacd0b85a97d-39720584500mr11131524f8f.55.1742222132717;
        Mon, 17 Mar 2025 07:35:32 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb40cdd0sm15208107f8f.77.2025.03.17.07.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:35:32 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: brcmstb: make const read-only arrays static
Date: Mon, 17 Mar 2025 14:34:56 +0000
Message-ID: <20250317143456.477901-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only arrays data and regs on the stack at
run time, instead make them static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8b2b099e81eb..d258b571f642 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -832,8 +832,8 @@ static int brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
 
 static int brcm_pcie_post_setup_bcm2712(struct brcm_pcie *pcie)
 {
-	const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
-	const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
+	static const u16 data[] = { 0x50b9, 0xbda1, 0x0094, 0x97b4, 0x5030, 0x5030, 0x0007 };
+	static const u8 regs[] = { 0x16, 0x17, 0x18, 0x19, 0x1b, 0x1c, 0x1e };
 	int ret, i;
 	u32 tmp;
 
-- 
2.47.2


