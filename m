Return-Path: <linux-pci+bounces-33545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF84B1D697
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 13:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 211987A8703
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 11:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73122797A5;
	Thu,  7 Aug 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJopB5yb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2F279DDD;
	Thu,  7 Aug 2025 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565874; cv=none; b=FneOdfihseqcZ6CST3veALPIDG7HCPlI4Ii95TKW+zxlgRwQJ19kA2TqHTEtVYaf6YnKf4QcPTO087wKMCk4kRjDxzMdvGVqUWcVGK+hYDV+o5qyIELYHopLwdo3nYRxYvjocjymfk/3roeEJXYzBIS1lIX8oKPWxCtZGXgXccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565874; c=relaxed/simple;
	bh=2stwprMZvZW2XYJRa7n21iVChnBjrX0o24yCS96ndBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dH5ICKZhepllxC2szDRTcvIoMRfXUO6rWRUAdk43T01KuUE2zlVvmr2qd5kZfW3E3kDI74H1NBwdU2MW6pm8m8wYN+Q8w9HMwJCNK3gYVKOf+2iR0U6SWz8zzlfDFa3pD24tf6S/t9wVD/RGUGBnL9JiDTyVSRf3kLa9XGOTMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJopB5yb; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b978c61acso856384e87.2;
        Thu, 07 Aug 2025 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754565871; x=1755170671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+kyO7X5xrXGHDKfjnAsz54SBIL83moTTuqtIiJyAcI=;
        b=NJopB5ybuVwWaXkdN95J/UVMRH+upKLkfrpr945onBn3nN2xrJ1yt3uQLoYF94TY58
         ifRMM1dSCw2l6z9LRcAsaNT07XmldmYDJxmEYhaTI94s+sYIJTKTy8U3PibGPcuJhQCv
         EVPE4qvwcDlM7+iGLfvan+puoPkpcLW4yMu9rjBOhJquYExOx98qn5i+0RkuWL4U/fMU
         o2JdskzNZF39JdtP1VSjnQtj9HsoiyrDecobuPhBZURiOAgYV6wnyx8CLoFVkGszgfBG
         qDMiJdNVmBxK0+YSfwQQLN3HlzrG87vR3aC3FvjlPFKY4A8gOO2NYnGiH4WUWgqVm8pw
         lxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565871; x=1755170671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+kyO7X5xrXGHDKfjnAsz54SBIL83moTTuqtIiJyAcI=;
        b=hg/ct6ZSyHYbMPbbo1J0QBvUzlJNZs4cEURP3qr7d9azEoX6WyzlWTVRagcwiwkCyo
         Lqp2fX6QBul+iPRDXOmAwQRsI9vruoNBYCHMB2/Z+1aQzD1MCLNif930DsaU2tImRpwd
         45k75q8vA6BygfeqRyGoVLdC6z55rSJHhUdOcZG86lO6wqDgq3B/shf+QS8C/dHe3043
         poG52CzgjPjfby1wUJgjQf0ZQRS5oT8ow75507h1jYMsIzdkQrP9H61/q4+4/NMP4qNU
         ZyJSDkNG6ZQRw2RLTw89Z9Xc5DDK3MPiF3mHcaNhm+EhhNt/6n8t0KmdHNPNqhKnQ2fP
         rriw==
X-Forwarded-Encrypted: i=1; AJvYcCV9UWXkL1Wp2EuERt0LcPKu8+CYyNpb4sJfGieVqeO6rqqSL0iZnogAH2dqsZgy2jkfvNARGz6PiWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MqpsQpPiS71FhfBa31+gQcP+vUxjLPXFFrgexWZZyrhUOoyf
	uKg7egQ8fE9Xo1Bp5aq91ryGzz11u0jq8LITI6U6A5vOMgzYpa1HUM0lM2Ufx3XkdNo=
X-Gm-Gg: ASbGncuzix5p8qGZHGCyM11Rzkg0P0U+c1RlrEuWIfsFruMw+4pgzYfJ12YOcjSTVCg
	9MCWCUbtAkJxOwZ8jO4joT2dYq7KtFzNBhYILu8Gs1FpaExpn5NC9AsVAQ5u94N14ttjDo+fQmx
	Fi1KvZRv8k08N31PvBbWVA0OIFJJ0dg94S4RMqZ9Ban/adqmFmWbaxIBCjFiw2X+RoqPtqwqsWG
	UFtpfGx/2xqwaRIzPNGRfgiXr+0VZnXbIq39jxOOQFgwlcktvrs6anfrwFxSxoo5I0jaVgmniB9
	OFpKQOtMi7jHjoU6/2OznJYauUXISzWWCIyYxWJCvjz+bef4WE6+SE/Psm+G+C1NeMY31lNOqZV
	l592xKFCjGpDp1+Sasq5yIQ==
X-Google-Smtp-Source: AGHT+IHRxwVgdAXmWpFo5aw8+rh5B8CNDljQxH4KtZXaN26ziWtW2a/nAmokkO9elGLy9RQFkY2TQg==
X-Received: by 2002:a05:6512:b01:b0:55a:26ae:56e9 with SMTP id 2adb3069b0e04-55caf5ee78fmr1810359e87.40.1754565870969;
        Thu, 07 Aug 2025 04:24:30 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55cac7626fasm644277e87.174.2025.08.07.04.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:24:30 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 4/4] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044
Date: Thu,  7 Aug 2025 19:23:25 +0800
Message-ID: <20250807112326.748740-5-inochiama@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807112326.748740-1-inochiama@gmail.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSI controller on SG2044 has the ability to allocate
multiple PCI MSI interrupt if the controller supports it.
Add the missing flag so the controller can make full use
of it.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/irqchip/irq-sg2042-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 2b7ee17232ab..6efb34a91937 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -212,6 +212,7 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 				   MSI_FLAG_PCI_MSI_STARTUP_PARENT)
 
 #define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_MULTI_PCI_MSI |	\
 				    MSI_FLAG_PCI_MSIX)
 
 static const struct msi_parent_ops sg2044_msi_parent_ops = {
-- 
2.50.1


