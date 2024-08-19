Return-Path: <linux-pci+bounces-11803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735E956648
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 11:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894541C2194F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344415B98E;
	Mon, 19 Aug 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF8POMJV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831615D5CE;
	Mon, 19 Aug 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058277; cv=none; b=qbsT1ILGUd/GxXbgKPjkt/Ef65pOKS86y7MbjhOxdXYn7rt3qe4FvN+EPxqcmlMN1xOzFK2VTVgl1JT2jbSfMEIgAGbUr7LEOhMlGQBkjjj1V42bW0m/1/HchQBN0hq9VPbo8tAdUSK6Yw8lf/kM9Zro2Mre7Fu7DVLCmbgOJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058277; c=relaxed/simple;
	bh=PBWJwpQrTmQMhxS1evGm66Kvqii7McCIh/AU7DcqbUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR0Zf8KPFJPsXI51eiH7Regv2eGoZamlQwKoEHmlYGbs0gtoBwm7QNm1MJqk3zOMvWMOPbiyA1nnBrJrtE/e1OuZHFYLvpgUtabg+jO13U5QT0VtihHnY8GC/5yIcm9NJkVWRfccU/iUt9bgebnWSCWcu15/aUTR4doh7nN5fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mF8POMJV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3719f0758c6so1340178f8f.1;
        Mon, 19 Aug 2024 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724058274; x=1724663074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1WZmnJzwRNoGQ6pe2EZwbvZJ2ojrMh6cxbYC/hMf9M=;
        b=mF8POMJV/6nM6FZNoyS7UyW0poWrmGkEHY4Gn0gV5QiYO9j2ACOKPquQZB8uD6sa1/
         L5YDJSnAVthDPv6+KqyBNVaFpXCEIEBNK6cmOCOaGPkEUVYpuLBpAP4D7LK4oylXJA8I
         wDXoiywM0E405CNf5tslJuv5FoVmLg29qniNotUVb78dpg2Fj57X5L2NBqDKHeX7zCTw
         QLhihNTvBThjybNtus//QRYwatfJOgTqJyzkL2sUy6pzthIS5ga0DbWmXd2KF2xebxiU
         oP4AmVyVxpk2KJEDnFAHVdOxNCfPC8oBnUTT5zdrU+TjsrcxcaZtrr4kpKCatxWtgXVy
         04Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058274; x=1724663074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1WZmnJzwRNoGQ6pe2EZwbvZJ2ojrMh6cxbYC/hMf9M=;
        b=KgdlFufvzamx7vuWh6cPDqVfGmhw3nDnepozPrQJ7u2NatB2cxhpOLtdKDZ4B2vAMs
         jzd3SyIbx+zwXVNliunKgc/YMdn2gBMQf1HDLEUH0l2NAFbG99QzJzMN/byNJPbgsu+3
         yDfP6O8xvnAmRyPyWwZ1gzTgSTuMAILDStz3ensBqd2YDKBzX3+iiDXsqIhUwUwuOUqZ
         hAI2Yd0HCCyiq69jw7kRsiW3XjDjjpvnznLQbUjSXu93VkeGAeweH7HFN6ZHMqRhinL+
         zdENdUi8LTm+0iNTjxsQ3op9tr/9u2QeRthL2vTjfx19Ps6IifgPb2xIBUUWYpy6+i7H
         c2zA==
X-Forwarded-Encrypted: i=1; AJvYcCV1YQH/lE6cDa7IfX/NhIESzcX7qfXoYK81TuM4dzISsPd7NdMAjgwZlJbqa36xeyjRthAMo3xqG07F85aLnSXWBmnDGed/UN1zX68N
X-Gm-Message-State: AOJu0YyvoqGDlQhYt1WnESDTU57nkks/aWWg+FnfmSK1Q4Qpf0xQRunc
	8FDKWPcJL3g2uavfU6D/+X+RayAhqhCmzuOVSFV3lN3oss34NAff1bth4H2Y
X-Google-Smtp-Source: AGHT+IHE05TuCyt00A6s9cE1mKfpK9EVIx9TkS3oCHaFi1BhoF8/ztPZ5xgaGZQyiwuRYNARtev9jw==
X-Received: by 2002:a05:6000:1a89:b0:371:8d08:6309 with SMTP id ffacd0b85a97d-371a7477af5mr5590541f8f.55.1724058273566;
        Mon, 19 Aug 2024 02:04:33 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:a64c:8731:e4fb:38f1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded19627sm154672095e9.5.2024.08.19.02.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 02:04:33 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1 1/3] PCI: imx6: Add a function to deassert the reset gpio
Date: Mon, 19 Aug 2024 11:03:17 +0200
Message-ID: <20240819090428.17349-2-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819090428.17349-1-eichest@gmail.com>
References: <20240819090428.17349-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

To avoid code duplication, move the code to disable the reset GPIO to a
separate function.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 964d67756eb2b..fda704d82431f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -722,6 +722,17 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 1);
 }
 
+static void imx6_pcie_deassert_reset_gpio(struct imx6_pcie *imx6_pcie)
+{
+	/* Some boards don't have PCIe reset GPIO. */
+	if (imx6_pcie->reset_gpiod) {
+		msleep(100);
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 0);
+		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
+		msleep(100);
+	}
+}
+
 static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -766,13 +777,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	/* Some boards don't have PCIe reset GPIO. */
-	if (imx6_pcie->reset_gpiod) {
-		msleep(100);
-		gpiod_set_value_cansleep(imx6_pcie->reset_gpiod, 0);
-		/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
-		msleep(100);
-	}
+	imx6_pcie_deassert_reset_gpio(imx6_pcie);
 
 	return 0;
 }
-- 
2.43.0


