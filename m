Return-Path: <linux-pci+bounces-21646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22203A38981
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9EF16097B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CE226882;
	Mon, 17 Feb 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpP6C3zL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356C226547;
	Mon, 17 Feb 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810258; cv=none; b=GRs1erigjBGdO1SdbGi3hAdeLJq6Y7+4I4U70X2cGcgUXYsPOSUazfPjxSxvL/R5GKoio3sJPWwCnhFKlbRNMt9y2vfgaJaqFXDoHwnwn7XzHLCzIg0NT8MHPI4pHalrpDpzNi2PaozWE3pQjRhmpHvdUklsYhyBymwrqBceKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810258; c=relaxed/simple;
	bh=u6waITdVDCY6g9EHT0QMDOQubhyZX/Ph56utqfGWkrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgEd7FiOp0Sm3cGLME8WpBNSqMtEufWJJwI7C00jnfGnSkBQzjPiAqlmV6iIcErSI337mOaKxpgMtD9CzsYLgC515CzNKNgDLXUghELAzi2IU4zhlka6cML99f1T0Svo3l6Zpht1vEH9fdsXVO7YmRnlAyc1vwrCCK3Pv+jZzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpP6C3zL; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f3ea6207cso1241590f8f.3;
        Mon, 17 Feb 2025 08:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810255; x=1740415055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcpOOuxQgTIkODYzKhCUSbyWoJK/c0mt1V0DRu+9cfQ=;
        b=TpP6C3zL40Z9c7wbtwZ0BgCY7UQC5tp0M715oHQ2/3BSD9/jgcIFtZp/uDusy+B8RM
         /TtnEMXxvDrTO5hLoAwX/39g2tuSg7RwWocmLizu9QRiIkumeaZ04XzG6AW/GciNc9rC
         hqMeLlRJsQJA1F78xXK73KQqkUHMJWt+3PGv7RhgHcvW67X4GJvvkWalOxiVhmay4jtt
         1xMKhjkXcJaC+kfX/7u6FzFqeb3fX1kg4beqRlAUKVrjFd8YGWwZ1UYClKMwZpUiM8xA
         kJGoaBRoJdJDvP9H+McbKaxb6bj4AkfUsv/qyOyzVNpSfA//gWQIvWDa1VifeWALGKiE
         iKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810255; x=1740415055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcpOOuxQgTIkODYzKhCUSbyWoJK/c0mt1V0DRu+9cfQ=;
        b=A1LiEYK8hUwObgGRhHrumFJLGnjBjWf3jI7baLLJISD82ZRUrZRx29a43FsIaVCMK6
         nQfhh9A/mlc6FEpOGSfkxVF75X7eUFzbtQa2IXMDFcS3glSt0zdaLxfXPHCwYYZb3xkV
         6PGo+cRcYwnFmWqQedbtRz6k11EjBnpciIcm0Bpgl3fDwUn2ldnnT5MvLqNcJaKzd2u8
         aAIyBag4ISmNjvb57tdjL02YVPBK19mA+Mawn0E7X2JrlOKtgbmGIGWUGN8LUs9H4smC
         OU4yhAylSDqWodwhstH7CKZGgIRwLgecDO9JNKIMH57H0dBdLKS5iLeesb+XY3jo+Q0x
         sZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUJiuP4dAXBx8qH5jDNsTsieHQ6HyLomNevVgXz3G6TlN50uJNViNEU7H5RjuAFjBbGAHik3F1+tXe4@vger.kernel.org, AJvYcCUiidFw8Wzq0sv42P2aGhRafYPGEEPEnvtYdq3Yw96hFKE77hnNZOY2254Nqey7ukK9zo1oDqS2yHLWLGEg@vger.kernel.org, AJvYcCVJM4iKdxXB2n58tNkiL9K1ugLeb3rjpfsy/dwyC7uBZ+ByAY7DJNGC+pwf2wxZKaQ6JzhegpaDoKY=@vger.kernel.org, AJvYcCX05ntAfarKdAHldLT/6pcpPmlGxCfitBL1LVTDn952qHf8KfXrUxYUUgqYi1/W5cTBCbt3EZSi5CCt@vger.kernel.org, AJvYcCXwYp8prhNTSzuqspm6QDQE2j3/8NtmexyOkZGTU2ByoeLuQknoCmEyxn99u/Sh8Ee9aD7EllueAl+/hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXGHrMnjXEDoctuV3cZW0roRyTkld0Iu6WDuSLedP4pHAXzaH
	KA4mI7LnbUAARyG4xQREtZroqdSP/7HwuDug88GeHzGnz6B/Vn/DvEblxA==
X-Gm-Gg: ASbGnct4MHVCA+M5ECfETK6JXxzmIDDS9rwo/Ty3FeSfg3ryWeThyo0Auw7WVrcbSEX
	tQqA09QTs1FBobLeOFCU1CZXVkGddXSRcaVPJV4OTpB6oPY88ASf4mt4MSEPw+Cfb+Md/Yhyr8C
	Q+KretuIiWfypdZLkUjREfGu51FMbrhCI4aoa4m0MspKQHU70a0YJKt3Av45EUJc3J5TVPOmdFl
	+aogFXcwVl2KtnXwdF1pQE1WqOHeOqwHxbqxxAUfCLvGoU99k3pq7KcEqI2pQJJlEKixiIItfwY
	ip8ZyvcToA1RjA9De4lTE7fhx+ZHxwKpsnfiBBG8gshK+q23VmB5v6yBmkiwkbUkZ5+jUam3sr7
	Oz/vwV60=
X-Google-Smtp-Source: AGHT+IHfk4fhCYlLR37pJBvXWtv75DWNoeEDbdc68Ccdk3uRnLzXu0R2uoxz3Sfrv9nYBkbSbSFitQ==
X-Received: by 2002:a05:6000:4007:b0:38f:2b59:b550 with SMTP id ffacd0b85a97d-38f34167df2mr8240262f8f.50.1739810255313;
        Mon, 17 Feb 2025 08:37:35 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f2591570esm12881221f8f.59.2025.02.17.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:34 -0800 (PST)
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
Subject: [PATCH 7/7] soc/tegra: pmc: Derive PMC context from syscore ops
Date: Mon, 17 Feb 2025 17:37:13 +0100
Message-ID: <20250217163713.211949-8-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217163713.211949-1-thierry.reding@gmail.com>
References: <20250217163713.211949-1-thierry.reding@gmail.com>
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
index 6a3923e1c792..ea26c2651497 100644
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
2.48.1


