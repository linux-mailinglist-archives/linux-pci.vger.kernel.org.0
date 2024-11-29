Return-Path: <linux-pci+bounces-17448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA539DC174
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 10:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79163162943
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873B1176FB4;
	Fri, 29 Nov 2024 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot+cqwyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D07175D5A
	for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732872410; cv=none; b=m3owqChkegRVhxxKQlYesh56/rtlCgceTRo5bqnH7grIkJiAnTiXYQU6BJaQVqxw78liD3lWXVqmAb5PzvJbqQVplIwkdn8WgcURC01k+W6OGxUru/kBO6iRNbmq2bXoaLzxF0C1APS7h25XHl0OZTkuTeei5/uSLgWwHnq1M58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732872410; c=relaxed/simple;
	bh=MHlRYTDbzpte/oyaFieIs0N72WclEbQwNH1n/UIc3uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOinklrTZ1Psi7rLVIkCt7S1cRuir1jQdYFf0zQdQVs02pfDs2nKjSmGT30A5GgAiSBK/zhpZK+lLpL7YAyqBI6//0jgOjixdCH2iA4SzJvE6imC6oHA5gbWkr/gomKxpqBSds2jlzaEJlfdyTQFFWEXki7dBn45SfnAuJnBCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot+cqwyk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-211fb27cc6bso11942085ad.0
        for <linux-pci@vger.kernel.org>; Fri, 29 Nov 2024 01:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732872408; x=1733477208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/FAcNUtBN6sCO+JgOTDya+HEEM74CaemwD9wkIfazI=;
        b=Ot+cqwykEJ6tpRizYZrjGGudxgT2+5Eo9NfsK6wGtjTq4l3pZjEgiH+0swVKVKO7KH
         AahO+SOxSswK9Xx0WGozHh1RbLODzY9h+3m5IyZN886pl6kavX8mUMHIoSeC+9PjT73I
         8ppzS3t7xPmyJa+T+4cMIeGfQ4nyGxg74WC3XGirIg4oIRWUl0t/748OYTkRuiqbiko4
         tjpImJhzRMXAC6WPAsL7QWLLmA1CxerKDV33Rl46XzxJkVpeEi7NPBVYTuOlgTdR/AEH
         JoGaqsZSFURplxNxIWavekQ2oIEznKXxpgdhOEYHdZDIjHruosiPrN0CWoIphUltiqgl
         2pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732872408; x=1733477208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/FAcNUtBN6sCO+JgOTDya+HEEM74CaemwD9wkIfazI=;
        b=iHgg8ESllbckDP/gfigxK+AZafPmmeSO6RvCKoA2TCTJBpTDTgM9YpQAaaci1qkBvR
         mJTk39Y0ZjzS5Qlg4HDFXonzOQNrhxRtyAYH0zXy8Os00M/ZHd5zB3z3DNBH/0coCU2A
         bV7EHVd1QW+voOSDnb0q+T6WoLuAlSL/QqBYnu4dmOb1DKf8GzJ9uA51Aj+V+rm4k308
         vRoEJOB+mTqj+Fn/xi3UzsvkYF9Z77YnCihFW03wjhqNvVtucsXLioYwO7pHfSXrAQZK
         zlSEXEhnNgTzCoV7N3+/kDh3UezblUFW8ea9xp36Nr6hA4wMQmIwX9ktRKJbw6PFK+Ec
         ThJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2rKKhQhhjmC6yxrXEzMGYoi+iT8hrjHdJ6RsWfjwTpJc+3j0yng8Sx/xK48wjC9N2xfxQRUyudjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEf+Fjyk3bPn4bpB++NylRmcBKUVomt3A+hZ+B7ss0uCZRdb6U
	9Cv7u1BmO3Hw6KbXN5h4n/6aba/E8he+mYR2c9fhLA99l2CkodUeVf4H9eoIdg==
X-Gm-Gg: ASbGncv6AiezWdczYHUa49gc9TdbjidOcImaludOw9NeS/OGkDZWkHCGYb1osv8dErq
	NVgFm/5o3oh+6OwHC0UN2krU7qBZbLZPKO836oRjs7js9lrrhSKZ/7wzv/MhrHi2LXKgeO+JQFh
	c1B8eRMwEo29Fr9dlYP4CgtWe1vcJvuxU3YoKsOtjT3KQLvrj20UQX1lbA1SALuUTmslC8OprVp
	QYEhUexRPoFILLjBlBM9vW7WgaQ9z8LDR4d1TGenWvEid0qq8d5j8Veop9VPeaYs6PgSkSlurAt
	Ug==
X-Google-Smtp-Source: AGHT+IHN+l6NK+tC7x8F9oy13xLI5GVuVEUr9/bO5jZlgYXRjM7dncdGqnj1qr9Z+oTM9kC3RI9r8w==
X-Received: by 2002:a17:902:ecc1:b0:215:4d90:4caf with SMTP id d9443c01a7336-2154d904ddamr4433805ad.14.1732872408394;
        Fri, 29 Nov 2024 01:26:48 -0800 (PST)
Received: from localhost.localdomain ([117.213.97.61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521987f17sm26648115ad.211.2024.11.29.01.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:26:48 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kw@linux.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	lpieralisi@kernel.org,
	shuah@kernel.org
Cc: kishon@kernel.org,
	aman1.gupta@samsung.com,
	p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable+noautosel@kernel.org
Subject: [PATCH v2 1/4] PCI: qcom-ep: Mark BAR0/BAR2 as 64bit BARs and BAR1/BAR3 as RESERVED
Date: Fri, 29 Nov 2024 14:54:12 +0530
Message-Id: <20241129092415.29437-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On all Qcom endpoint SoCs, BAR0/BAR2 are 64bit BARs by default and software
cannot change the type. So mark the those BARs as 64bit BARs and also mark
the successive BAR1/BAR3 as RESERVED BARs so that the EPF drivers cannot
use them.

Cc: stable+noautosel@kernel.org # depends on patch introducing only_64bit flag
Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index e588fcc54589..f925c4ad4294 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -823,6 +823,10 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = SZ_4K,
+	.bar[BAR_0] = { .only_64bit = true, },
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_2] = { .only_64bit = true, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
 };
 
 static const struct pci_epc_features *
-- 
2.25.1


