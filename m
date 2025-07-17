Return-Path: <linux-pci+bounces-32375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BBDB08AC5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 12:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0234216CA6F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF84A29E0F1;
	Thu, 17 Jul 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yam7EXq6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF529DB80;
	Thu, 17 Jul 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748385; cv=none; b=Ry7eP7v+cwpgeEM7bgaUUciArhb9Xb+0ZzDpzXkEBsOt+iaUDfqNVkKkXVvT+X/lffRv7LuWtKhexyRa5cpa4nfyKj/fXIg2XU82NzhZV5dqhYfKmuGkSqnx+QCuWUmVv/glbm4fM8L0fk7TVW2z5jLRdhomW8eU9Zyf6fILo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748385; c=relaxed/simple;
	bh=Q1EP3fcNvNx8PjpgFAFaM/WAmgg9+NrPEMcfSO1OfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfFKh0hJzZCRVJDWUIOzjMjBoe3C7zxfp7CPmBl5CEmahF18aHVZ390pAD0BM87c+3UIrQnEKEyuSxHxEP0CQhOnOx8s6TPVngykibcBrmjxa6t6BHKtsTCavFPa9OefXgiynJpeT8XkLXY+GsgFMtZM7iZnebJ4JRAXckeuUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yam7EXq6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so605085f8f.1;
        Thu, 17 Jul 2025 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752748383; x=1753353183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hAdkFjzlZ96J9ZvADDEOxzZCwxKXpOY5bpgjR9cuyI=;
        b=Yam7EXq6THzjjWwUzB6kw/P2K3YvTODJTJ/ZckCQDkpPtGQ0YZ6HJ91DGmrWTuGfP9
         vHIGhc3omFgcLJbPX1622yccZxFgR6+vO57908tCFrtGjeYbtJQioCexWafg4CwfxQN4
         jCfu0K/pJzEDQGgzuNxUmJ30aDsKOPcjuYRVjO4XGQWUnzIyQGMM6+uJRpfU2IAlVRAL
         XmlboH8neQ7Kh0ELpMWsQ9xHCFBjLDlOnl3+/PLa8d2cUbLIhe8Dz9m4KPObnjHVJva4
         V1ak2G59iG3nPpdPd/zNyygPVzSUJIVrvco1VUNe/gpkTQLo9gkzfy2uxLv5ihDfN0XI
         34nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752748383; x=1753353183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hAdkFjzlZ96J9ZvADDEOxzZCwxKXpOY5bpgjR9cuyI=;
        b=dP+URilrA6NaiTf2dHYsfjouX97DV1n91JX5s+jg30GwCdF06EtGvywMsNwwQZu4Kb
         ty8McIfWoelCfs6WGvxaXZx7XotHmboNof4AlqXNdyDS+nPWvYUXcWYietYzgM6raUuN
         quUY+HnfdL4iw/V1juJfV8oSP5jSD72Am9EngdJuGuaxopFrvHyXdwCRDhOF3LO+RVaE
         sQmYvn2tyM0UIkX9HEAt3ETlT1smf/+5rtE9Ehlhddwt5xIWi+IejQIpY4/m87kevO+F
         ytXbqZWHe3Kxe+1cUNxiMAHsSY3aVBmT0PedHAr19mbdVG2wCIHDUaNglvMKFkz70BnN
         JBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjwCk4QONUExn1aLjkZAunFU6H7kZJOQ+u/RmM1ihR3GAGq2kdT5K9iLQMyQEbIKB1aegs4lEKhgk=@vger.kernel.org, AJvYcCVRtuKFMEhN26vawTsN7TvDn9kglvcupgvawUkWFoEP8JjTnuMGVslvPvzuO24RNuGiLVDv2zf+kLtPXA==@vger.kernel.org, AJvYcCWXH2uhy4ncDrAn/okj+PaClMt0hxTHt0xPTez9v3qtNu8ZjKGQ/KL+TG56nEIwDDFwa9XIgo+vxk8y@vger.kernel.org, AJvYcCWbjC/JIrV9tF0vAR9BqBc5fBIniVrSnQwaVam5fi4wzXhRrDfLnHaFl2FGpeS5df+2yE6TYxfLgrEM@vger.kernel.org, AJvYcCXbNiNOGFZn75Z/k/bhYrTmMyIo5KPBwx5zEXOQ9gCZspXo4pzjQCkjyJLtMx39I44h9apKo8nzdnziXVES@vger.kernel.org
X-Gm-Message-State: AOJu0YyI+ucyFEZUrOk9eLpxKDbJznRsYDP0O0mB4LIifSy8cjDSM4tL
	ZkxR5+6srVBTsaDn7JGu2UIBES42tK9Dvdxz0tG7iFcgKpaWn4SCcYeG
X-Gm-Gg: ASbGncufmnJcGb/kVFS3APtBNCgvvL+ny/E3spAOGeqTgljT0QeCJEcV7Dn1WNYKCTZ
	Tuw7XA/rsD7ySAFaI4+fZ8D8yNLAuvpR6d/BcMtgCEBeOt8CrB4g+1fdVfAk/KQCT7UEs01u5hO
	BRB3z5ZxlZColeUfEPRGVcnUF8bGG91vqB292chyI2ZfGADgLXp6jhXK/37Z11BTpBO0h8Mq0xI
	njFooRqrmzUT1Xxc1GuzPIOpq96jcu6QX02jUO9jW3q0EwHhvGVkZa8LadUGRKrviT9f7Y1x2N4
	mcgzdI1emMa53iCl2clruCnEECITLr7ZrwCzgNu+kxMYGZtZe+ipjuTHQwAOXrdDJv8XbpmX4p7
	fz6xK80H2yZY78yMjHlm5FDpVvgTQGjhMDnIkj6vS4OT/A4OPR7ZybQJ1mGEpHAZsmmPLQsl+Oq
	/GaIJBU//Fmiy8TeV1wPnYZn/s
X-Google-Smtp-Source: AGHT+IEqfCFpIQcuogdtVlks+s7mtGT9PHZg7lN5UDyP9j1DEHEgnDRrYCSmStX9iLPaLpOJf76oyg==
X-Received: by 2002:a05:6000:1ac9:b0:3b6:d7c:f4ce with SMTP id ffacd0b85a97d-3b60dd88801mr5936545f8f.54.1752748382518;
        Thu, 17 Jul 2025 03:33:02 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b612db7060sm2629613f8f.52.2025.07.17.03.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 03:33:01 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Subject: [PATCH v2 7/7] soc/tegra: pmc: Derive PMC context from syscore ops
Date: Thu, 17 Jul 2025 12:32:41 +0200
Message-ID: <20250717103241.2806798-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717103241.2806798-1-thierry.reding@gmail.com>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Rather than relying on a global variable, make use of the fact that the
syscore ops are embedded in the PMC context and can be obtained via
container_of().

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 455e55cbd2cc..a5c179636a69 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -3143,6 +3143,7 @@ static void tegra186_pmc_process_wake_events(struct tegra_pmc *pmc, unsigned int
 
 static void tegra186_pmc_wake_syscore_resume(struct syscore_ops *ops)
 {
+	struct tegra_pmc *pmc = container_of(ops, struct tegra_pmc, syscore);
 	u32 status, mask;
 	unsigned int i;
 
@@ -3156,6 +3157,8 @@ static void tegra186_pmc_wake_syscore_resume(struct syscore_ops *ops)
 
 static int tegra186_pmc_wake_syscore_suspend(struct syscore_ops *ops)
 {
+	struct tegra_pmc *pmc = container_of(ops, struct tegra_pmc, syscore);
+
 	wke_read_sw_wake_status(pmc);
 
 	/* flip the wakeup trigger for dual-edge triggered pads
-- 
2.50.0


