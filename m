Return-Path: <linux-pci+bounces-39683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C78C1C2D6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31F81A228BC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A6351FDB;
	Wed, 29 Oct 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b44pwGnt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA577350A17
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755642; cv=none; b=lAZsj4bYsJVpudlsgKpVfC4w20neCiZjkV37EOD5591HpTeGsfj7V7+HIvOLme1LK9PjONHG320A6Lp15K6QUHvc1dEzrCVkd4kH/RWBahyYzSAdmnK0pbgRbGxG6BM3b2lPZQOfMbOtvNjN76NX9KG+wTPZzoZKINxxPyvyY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755642; c=relaxed/simple;
	bh=1X730H41akqVRCdUivi5jsHS02y7Sh1RLu5JYxa09ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFaiE0+CHC4pmQaUVYCnmvr1NvV2erkMtNf6act0fcyorrAt0or4sbkxayxAZpg6w+lO9qfBpEVM7iPgcBhtCTewYx20J8xafjMbsMWouK9q+3aq095kqJCiBqjzkEu+lCQMtaLRe7tUE3OncCq3PT4LOlIryaJlKPDF74aVIXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b44pwGnt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so14650828a12.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761755638; x=1762360438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkaU4JsM1D+JY4wiuorXEjJy2zEEfje0oExQGt/PLrU=;
        b=b44pwGntTRz8gLMUqd2gjzyocJPKEPm/g1rTfBAtqXPxeCbUzveo3LWabswC/+gXrJ
         uEScr3Ytkylq7c7h9FMLlQJ/+GdD44F6jngEIePa8praZsXBgwvK+75UGN+FiN7OKmw2
         MGzAqbozNv7izs7u5BoKXjjeaZhw7gkRUPbJ5F/r2236rI/kFGl66tjhqA1TIklTkJaf
         QsnXkowHK1vlrVsSN9y6IVCcy8nGdy3RNK+lcetSjUb6kQ9DchO5w47U/9ZVuucsk1fC
         +BZX+tp7XaTjJ/4oq4HbpM2IIVdhD6RPs6sZGmO0Xl9j4L8RBhXYM0Bz4sKp2/XTPQAF
         e2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755638; x=1762360438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkaU4JsM1D+JY4wiuorXEjJy2zEEfje0oExQGt/PLrU=;
        b=W4FGKZrxHrjqBJ2Y0ueCJpTpldRHdv3EW4UvN0299Yz+95WX29cJsrHfiohxPAMIVm
         GvVBcX6deyjZLalnk9W1/7M6t0QI9QPf/aiF1vdtbbhVmklhaGLii+QI1+HUUHP7j8s3
         D+q3H0kIC3DuyFm2wg7ETE9aIDlCL289we/VeAja2WSXDdnRFXZA5MebqjuBzZmjYI++
         P6YiRPJd5jy5jF3YeF3LDe6dacePiahd89YEHPvci2SbAvD5u/GLSsnrMecyPaSxVayN
         rAXDBEtYWPyGLwz0QctCi05NLwZIzgY1r59O6Z2PSvj2THvb9bxnehVF7bZKWfmL+Jsp
         rX3A==
X-Forwarded-Encrypted: i=1; AJvYcCXvzO3sj4W6fUrFmf638Kc9EBBj7Iy0LWIG5grnIjwvyqVC9t6rBWvWcab4OtNKNTJwjgr01tsU3As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo83Qjs8I0tO9OuX9i8Sz2K6uCsJcSjuvW2FYUDxgPuCMGaFmn
	3YJqcxqzZGihh0YydzkW82y7msZURGcJ1nRc0BJzJR/4AuJQ2aKtltqg
X-Gm-Gg: ASbGncu7Ww0ien41kK+eVxuhhv+7D1jyfcWlc7K5oFsDyOpTJ4tXYfTte5SKW7fcuq+
	DduYNiqJIAIgMdusOK8CSwDINdCPu/k5QeZ74IUDMD+fs/2DVmOWogXOSUEfuwQpO9OsdLCQtnA
	z9tX0Ms9qHs0a4a2kIAi/i8PN67Sdv38ds4BdlpW5qs9KfGkigTdCT0X/xPzpZa80b3/ZFrU5vn
	PBHhH+6tZuV2CgWUTd1DWupBH7wRpVw5LU4DLhxzmQHJmelMD3xqxhgx0MIvPpmoPf38WM7CdkH
	oDQ5RDQL0uQnEo+bCLZM49OquNO49DZnUs4H02r6ARQ6ZPU8UGfYaemr6zA4DLfrozuHInyzm1P
	oA/u3AU3UuI+ImPfcMvkVD+xHravDXoOrTTehP2Ur43wrLZGXoZxP67TVDB484LAKzF05NtU61b
	9LHryFCy7hBAySqNxC8pd+Ch+oI3eLrz5uQ5T0dx4mpG6rFb5y59AJYU0b831vnJVV7QPt
X-Google-Smtp-Source: AGHT+IHnWRqBehOWBCyuY7cscNzDJLcQ8Q1/xskpkrSKjJiOMcliraM9J9uBI/ZGi7u/t3zd09QFLA==
X-Received: by 2002:a05:6402:e9b:b0:634:544b:a740 with SMTP id 4fb4d7f45d1cf-64044255cf2mr2554809a12.22.1761755638150;
        Wed, 29 Oct 2025 09:33:58 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e86c6d7d3sm12474615a12.27.2025.10.29.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:33:56 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] soc/tegra: pmc: Use contextual data instead of global variable
Date: Wed, 29 Oct 2025 17:33:36 +0100
Message-ID: <20251029163336.2785270-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029163336.2785270-1-thierry.reding@gmail.com>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Pass the driver-specific data via the syscore struct and use it in the
syscore ops.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- adjust for API changes and update commit message

 drivers/soc/tegra/pmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index f57e5a4b4d96..6e0ae0ede263 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3150,6 +3150,7 @@ static void tegra186_pmc_process_wake_events(struct tegra_pmc *pmc, unsigned int
 
 static void tegra186_pmc_wake_syscore_resume(void *data)
 {
+	struct tegra_pmc *pmc = data;
 	u32 status, mask;
 	unsigned int i;
 
@@ -3163,6 +3164,8 @@ static void tegra186_pmc_wake_syscore_resume(void *data)
 
 static int tegra186_pmc_wake_syscore_suspend(void *data)
 {
+	struct tegra_pmc *pmc = data;
+
 	wke_read_sw_wake_status(pmc);
 
 	/* flip the wakeup trigger for dual-edge triggered pads
@@ -3836,6 +3839,7 @@ static const struct tegra_pmc_regs tegra186_pmc_regs = {
 static void tegra186_pmc_init(struct tegra_pmc *pmc)
 {
 	pmc->syscore.ops = &tegra186_pmc_wake_syscore_ops;
+	pmc->syscore.data = pmc;
 	register_syscore(&pmc->syscore);
 }
 
-- 
2.51.0


