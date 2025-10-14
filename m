Return-Path: <linux-pci+bounces-37999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E50BD7010
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 03:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D903E700D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 01:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9B91E51EA;
	Tue, 14 Oct 2025 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knXqxT95"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2287B7262D
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406415; cv=none; b=HAFa/NczUdgX37CTTfjsfZkr69fLoZsDUbWA7i/d536tVlfRBxyct+DwNCxq5DONlZhD95EvkboPlvdfMo5bqybz9PHr2VHTv43fJQWvTBafWoaTPRq9rG5rEoXh3gGIS/2xUMuE66v9fMq+5QIgNrfP5f/yiubI7C9yO2JUDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406415; c=relaxed/simple;
	bh=sZTjOjGO3Me7AtkyRa8dc1wyExiSmkHmQMISMnJE5zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9FSjqR23eaM5kh9HuqQpuK/KypOuxVODFRIwaijLGuOMInLTDTO391gx9+MaZgIHLILZpecNDMB3CAANR2/EU4pyB+UgWJ+kMOpOOr/MQivZYi9V8gfEWowyR6hl1TxlauKOdmCYn17ubHWhxbLN/nQk1SWslWAvRTr1cHrgX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knXqxT95; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26e68904f0eso48953985ad.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 18:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760406413; x=1761011213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Efs1OS4WhBY7qmnFUKM6SksfuFBm0C5Nz8+hgpJIUHQ=;
        b=knXqxT95gddFJx58Zj5V5nTdRzrJ39+IE1b7T/hKK6tRpx6rAHmqEG360/GLY14kDS
         nf2FvbpOIrvsd3ZCRn2+9FhQHecgTXUy/eNjS5EdIupuvfOoD0Ooqyug2MXC9ARJJje3
         kal4b/BJNeJ+yoeZy2iI19u9wjn57GyddN0UD+8UjS6ScoDf+5Gsh4egAsDLlUXO2sGP
         F9sFmDpF7gaEANoSljcTEINEqH1HDOaGHZfypeJmQxeSn+GmJONaHRgaps1tZhy6H5f2
         CiNMBcpfkl7/4tR9uVp6JEl33PNG/5jKFS1+RWnOElUK5+3VP7F6a6cuInEeepH8ihhR
         HUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406413; x=1761011213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Efs1OS4WhBY7qmnFUKM6SksfuFBm0C5Nz8+hgpJIUHQ=;
        b=INJSOMf+P/hqD562eGPaWFmFo/1QIKyyDf3oxYikqrIWjl9aG48P5JddsP0JrCi2pO
         VrhlC66FEpxnW/EuSPBCrPqNgI7cwUqKBNkcGKsmKp63xM55S9D+EotbwdBrAgAe313z
         /Sxgp6ljq8LBFkBD57u8j/e21tkUzXY33QZK68t/B4giTtikFWW8surLlH/WlZL9K04m
         8qPhVT0WeWic9QA9o3ceka0ig9BVMZrG7+abFBWPqMVJY6WTgeM/5Zh1tz1QibVM8gZb
         dgZd/hTc06HJ7O91TJM/4pVLkYFL0x4SLq7YLJJyZ9fhHRq3imao5Ik+7BLLOTJIDghP
         /7Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUimp6O4zo9vwrCxdr8+Fvihjp28qfiSA2gJOeucmdUjTi1+yzezqJ411nAHcwMUkOj5nuv3Ddm5hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTv3V1Y6qHRIn/Ln2wcJFxDaynCMZMIX6zt5L4Gga4XsO2PEes
	yExNhJUikWxo+0BcT+ctaZYLNMis9i7fAsVd5Ulogf5nUrWe5QcPDaGu
X-Gm-Gg: ASbGnctLcNo2iWrg5BR77/onU4e4jHaJ5yyis4rqK6IOxljXDQflqzRCXqFl/5TEoew
	s6Q1y0W8tjHSnHFx15wjGH7gADMJUXD4l+YdAGRveSa/3EvDwd/1vOd4uV/498jrRQz9m3Xmahr
	OXhhYcBVd6d8d9uYxeB3kg77Wjta24+CvfaavzUJUi++R+4bZR7Gw51/G4L77l7p7wVBeuABME9
	BsuMy0ljFUeZkonNlsVJD/bbj/3O0sFd30UFVjrcGJJTXLOVSp88ER7CTzFN/+Yyn9AMKpY81Zd
	035TyO+Tp7d9y0hE4/iXk7MDXLR/KU0LY1vug8XzniZARtM9Ot1DzzTwPU0A4P47+dhO5jAZ19e
	GiOTfubT3VU07cAUPQtHxWF50vhxW1nPCEXd2UWyNDk6KqprQkX3lRvj4HpMgUg==
X-Google-Smtp-Source: AGHT+IEe+imFyQTJYD/N9Ps5ZaxXk5Tjt90b0w5xM8g55o6EThQlHI5Vtkf72wtednQujA7jc8MIlA==
X-Received: by 2002:a17:903:1a03:b0:269:8059:83ab with SMTP id d9443c01a7336-290272e1ccamr265307085ad.51.1760406413487;
        Mon, 13 Oct 2025 18:46:53 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034e205a6sm146461725ad.35.2025.10.13.18.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:46:53 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Kenneth Crudup <kenny@panix.com>,
	Genes Lists <lists@sapience.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH] PCI: vmd: override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()
Date: Tue, 14 Oct 2025 09:46:07 +0800
Message-ID: <20251014014607.612586-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per
device domains") set callback irq_startup() and irq_shutdown() of
the struct pci_msi[x]_template, __irq_startup() will always invokes
irq_startup() callback instead of irq_enable() callback overridden
in vmd_init_dev_msi_info(). This will not start the irq correctly.

Also override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info(),
so the irq_startup() can invoke the real logic.

Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
Reported-by: Kenneth Crudup <kenny@panix.com>
Closes: https://lore.kernel.org/all/8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com/
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
---
 drivers/pci/controller/vmd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1bd5bf4a6097..b4b62b9ccc45 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -192,6 +192,12 @@ static void vmd_pci_msi_enable(struct irq_data *data)
 	data->chip->irq_unmask(data);
 }

+static unsigned int vmd_pci_msi_startup(struct irq_data *data)
+{
+	vmd_pci_msi_enable(data);
+	return 0;
+}
+
 static void vmd_irq_disable(struct irq_data *data)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
@@ -210,6 +216,11 @@ static void vmd_pci_msi_disable(struct irq_data *data)
 	vmd_irq_disable(data->parent_data);
 }

+static void vmd_pci_msi_shutdown(struct irq_data *data)
+{
+	vmd_pci_msi_disable(data);
+}
+
 static struct irq_chip vmd_msi_controller = {
 	.name			= "VMD-MSI",
 	.irq_compose_msi_msg	= vmd_compose_msi_msg,
@@ -309,6 +320,8 @@ static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;

+	info->chip->irq_startup		= vmd_pci_msi_startup;
+	info->chip->irq_shutdown	= vmd_pci_msi_shutdown;
 	info->chip->irq_enable		= vmd_pci_msi_enable;
 	info->chip->irq_disable		= vmd_pci_msi_disable;
 	return true;
--
2.51.0


