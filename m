Return-Path: <linux-pci+bounces-9878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F355B929457
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 17:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC210282DDF
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565CA13B58B;
	Sat,  6 Jul 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiHeHYf0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7ADB13AD06;
	Sat,  6 Jul 2024 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278481; cv=none; b=bsRHEmbeY7WrHMuUw3ikNisb7+LLsT9YsAAwDdHTNE+ZWVqOOwK8rqx2TCI+K0IVA2YnGYZ9gJ1gl7crHwQtBm11tKsG/6WW1GSavQGqCFJY9Eun7XlKlF+Xy6/nYwgrTbz30ondwliGZ07h6Zk4L3YfD43MZFibdo7S2vPzwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278481; c=relaxed/simple;
	bh=Aj0FTMQ6ziAfGNoL39PuVZNWcf3cIo8t3fpEww1eCso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q7vGkvEGgUoq4zWhU4/JfySf9XmXhz6g3a0nhXZEPX73u93g8V3EMDNPXAc/9/umH2rKeFbfPh8cb9EGJu2wy7W/W2+j4/niVb285fVumuhJ+awKoHocq5v8TD6D+jf4e+IGJlUJETb+AscDinQHE4l7zZHV1BSO50jbqjTJdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiHeHYf0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36796aee597so1528331f8f.1;
        Sat, 06 Jul 2024 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720278478; x=1720883278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjL3qyowNZJyDqoLGtKUFEYrHzdrW4lz2WRY4ZZz4uw=;
        b=MiHeHYf0aocvMNnZINVibEZ2cRAmXQxYi1hqu+ySLha9udeZlLPCDmD/lu90dp9HBD
         ynXEwfoiMONWTNpP3ZPlpetKQVvjFAV2wSdYt2aKUrcV1CYwcOs6uV/236c/oHTroT4a
         bqOU6w8dqiVpPXNtJXxe8+cdZ4yn0AjgJ2rDqFI6plKmm1dXiI+IZObHPrJ/gIOKCkK6
         USv8lvoARWs4fqXRJcnKxGEN2CmqVC0IdaG5SYvvSX0Og/L3Dj9dlxBGca7vCdMVhHsL
         MiMKGcteJWZpa1Dy7ult0vKbrELcmm6nZwTGTA05SkxHqtGivPg9G1gK7mGxEB95g/NB
         Lt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278478; x=1720883278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjL3qyowNZJyDqoLGtKUFEYrHzdrW4lz2WRY4ZZz4uw=;
        b=bq/nnDdPbcPbaAkWgy50nCG5T6i7anboGIx/Qnx5XDrmdA9Bqsvd+sloQOxxxvhw0G
         tAa2ZJRCU9BvyU44FcwHKCaIJFmAliWDrbynqzkK/q4gky9ILj5MxNtQKAavOCVGbnLe
         dUGeKYyTDrwcUmlYFzjWZKvjiDk5Iiy8W9jwR6Y2YPMryyvGcM9gC4LHVKL3LfJ0Llg0
         wTz0Rvc2LqCvyfQejqcya7PNWZIyD3ouJtLIZJmKtGX2V37IyQL86c23WZyFrW5bnA1u
         2GhlQQa95APKAhfitP0e1tDefsXhanraJXrZlyOcNnTUR1IOql00HVuy61BnZa0gtqYQ
         mpXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCcgSuImvudBreN0YSwP9mMbF1VNZLVW5IaZepNiD2T3yek+zYe5DZ3imDmtEtMDfLrxD0heVy8s+u9Is6QNZBkO/gz9/Tp3tP5KMW
X-Gm-Message-State: AOJu0YyRJNp7vTGksJoqYlvdx+LlAwGk4CX4rtGrWoOmc2TOjb5brjJM
	AKYAjEVArXT8i/KaOKv7hYqt1Bmt6LK5iL/nWJBC4UsvoPCxyJl+
X-Google-Smtp-Source: AGHT+IG6jSeqx5EZbXOPart54XwPBHNDh2n6ekhDnLKyOfX6o+3EF0gaUeYCKKE1pQDgw8IwtSKPuA==
X-Received: by 2002:a5d:6502:0:b0:367:9ac6:d56a with SMTP id ffacd0b85a97d-3679dd723c6mr5002757f8f.59.1720278478034;
        Sat, 06 Jul 2024 08:07:58 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1805e53sm5896437f8f.22.2024.07.06.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:07:57 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:07:47 +0200
Subject: [PATCH 2/2] PCI: kirin: use
 for_each_available_child_of_node_scoped()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-pcie-kirin-dev_err_probe-v1-2-56df797fb8ee@gmail.com>
References: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
In-Reply-To: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720278473; l=1398;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Aj0FTMQ6ziAfGNoL39PuVZNWcf3cIo8t3fpEww1eCso=;
 b=6m1K/lU7liwiBGvKjtNORkPhwp23OJWS4+tSb1IyB5y7ffKdbG3RhP4hrrrgTAEL3r/aXdu6v
 WdfjQ2GvuvdBWAbDr3mhwBoRoWq1F2n6g6EwaYYduDNR2pavO5x+UA9
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The scoped version of the macro automatically decrements the child node
refcount on early exits, removing the need for the `goto` and
`of_node_put()`.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index da8091f6b22b..ac0aacb11489 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -447,7 +447,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child, *node = dev->of_node;
+	struct device_node *node = dev->of_node;
 	void __iomem *apb_base;
 	int ret;
 
@@ -472,17 +472,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 		return ret;
 
 	/* Parse OF children */
-	for_each_available_child_of_node(node, child) {
+	for_each_available_child_of_node_scoped(node, child) {
 		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
 		if (ret)
-			goto put_node;
+			return ret;
 	}
 
 	return 0;
-
-put_node:
-	of_node_put(child);
-	return ret;
 }
 
 static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,

-- 
2.40.1


