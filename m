Return-Path: <linux-pci+bounces-21640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1861A38951
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0740B16955B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44F4225A20;
	Mon, 17 Feb 2025 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaTypaLC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D6225789;
	Mon, 17 Feb 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810249; cv=none; b=XLw5nVBVf9G8bPV0EUX3Dizk5+cA7660uFDIGq26H+eYrLR9kbYyGxQfRQzdmpd06+1O6uc6cZG7peIwPHIAVA4t2DGCwSk5lc1BHHRhYo24UWsMVkVVIKf5S9ZZkY/9hauoOopr8kH2vt7z+ebYsdw0gUzGAKPRoDWcazvR92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810249; c=relaxed/simple;
	bh=gGmAUEWaafmCQUQ4+KQkgUfoEYeY+CBLOaPF/qC3m/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkJnk0YrrxJKdV6vp2U5XuxJVuJDTPRVEVyuaVexVVx2L+vvNikIM+YDvb7pVCL77jHtAUQpYbp4AZ2zKu/bxMwNLrYNlv203PokompQwx44ok/E2WGqLOLbaN0B5326CRcZVUfYo68q/UaEWU6dTA6rf3blYj99LHMoPwxuHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaTypaLC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43962f7b0e4so27681855e9.3;
        Mon, 17 Feb 2025 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810245; x=1740415045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/0biRJus/9M4PhuIap27DDVgRLzlMn9BGl57AT63dU=;
        b=NaTypaLCwi+5LQeQMa5QKEy2srMpKQnQ1kZVln6ywDBBJasPIUlJt9tGYhGOSGXMjb
         og4MpuIaCsVif7iknSyedDPAt9Dq9IMbNaET+LZF4EmpAzhhs9qHwtGPWL9KxXLnd5XW
         MBW69rF2yjuvMAWSJpgxQvqby1x3u7vLDCQ53w4MMRy9/hra24406xkcCSl4o5JnF4wQ
         5LhKCb5tOAu78t9Qxb7Y/wXG58JZUnY+2al+42ImIq+DpeBShBTQpRIf+EuHLiczEjo3
         wHbSDS6MzfZ5nq6Vfn3yyBeglalOHJeACKPmeusDSzdnI+pfYMaz4EMfPqPWMXAtCO1Y
         8EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810245; x=1740415045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/0biRJus/9M4PhuIap27DDVgRLzlMn9BGl57AT63dU=;
        b=XjW4/F5YAPYAMcUP/+42c49dalzeHttzhWjuil+hxogKyk3pzI8YZJl8HBK6xU4Yns
         YNToL2JCH/7W5pMao4LBHoiNYDRVhSII/tCIrIEmJhm+AN/v/o52s0w+p1Jy5IP3O1Ye
         vwMcW7ly1z6BiKLfB109oor4mF/Ykivt6q2/Vyrp/ELc1165DJ9wx6jNgCgW6X4i6SCl
         o53EqX1cQ+16UcbGa08rDFsDtDGDXmjEwM4+yemglXpfQ1+ExwI6qXLX/I+3RuDgODLq
         cxZrj9J+EG1nTB+CUIpkj52KqdMPPrg2tR8BizG6ezP4Kv5zMQ+Il0DqLOEVcwsQjwqG
         n8kw==
X-Forwarded-Encrypted: i=1; AJvYcCU2J5H7abMQsGEkuZIVVUi7lVAhWIWpkk3phdblxh7RsNa7tQse9KF/TLT3BVYuShyIdTE/E6LuDvLi@vger.kernel.org, AJvYcCVO86yWVqB/tnzzqyZlXCEJaB2uq3xEPF1hvXlB+EajJds1GrdP2of5hlbIHU5n3eolKe8bm29XcJQ=@vger.kernel.org, AJvYcCW9HzDN/FJ1HOoA4hDUPfgs0iW6/Vf6suN/5q0/TKckJJgp3GLhaXQIwr/R9KsyEI3B9bHnurk8GZjN@vger.kernel.org, AJvYcCWTr+Y9xq1/w+tcXfYOiR1izDYwo+fm6e59R1zt/m0jmz7wncmzSrIvqJiLSfiSAfpieDc1GRuYHrJs3Ims@vger.kernel.org, AJvYcCX9o6IgU/07B1nkPTxS3iAqudFmuX42HD0ZtDJZO8xqWn8k8BAJCz7d9gLORed+BeHdOFuJib7olBXWwA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CN76IAc6pXL3o+Jsa0tDEslxNVq38f/p1Mn5nTIT+8gQlLLc
	qRR5fwG42+pLvL+eoBX0cOkiHepkPyQ0iRTcwRZmKg0/L0TjmKHf
X-Gm-Gg: ASbGncvwMj4BqR0f4QiSpaqMGPLqg+R00l+qk+JjxKcrsHf+6dbjvYP85Be23A1d34B
	QaKkcJeI6+9jIT0k46HWzyNBnJIyadtM+GomAUvIuIB2APMCyAoQ84Hnt2WPbNWypHyPHLhBj4y
	Wcpe0Yp0Wdjttz/lbWH1CB9oMxTrRrAAoiOba9anGcI8oJ3BBePPQlfqpQ7lB3AKwI/8Uizxyh7
	dkYPTNuRFE0wnymATXJgbeG6NKMqKMcN3drrEHZNoV9TIRzX0nq75KbbtwZgafa6gHhuMBwvjJj
	6C4TkuSQ0Ufk/nmrzDUwd0AJ7Z+BYTN8Yh0wBoOXwh4GqyCNufykUG8dS2svpsMZ+F94MdRPKa4
	PzgXef0A=
X-Google-Smtp-Source: AGHT+IGnpGd1arKCvdVh8OB0EDoGo4KblVvIlIVVW7BFnKV8rTfrkS3K0VNVohWAHieTwgBwEJe4Nw==
X-Received: by 2002:a05:600c:4688:b0:439:89e9:4eff with SMTP id 5b1f17b1804b1-43989e951bbmr25428885e9.10.1739810245015;
        Mon, 17 Feb 2025 08:37:25 -0800 (PST)
Received: from localhost (p200300e41f22a600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f22:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4398872fa85sm24012905e9.28.2025.02.17.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:37:23 -0800 (PST)
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
Subject: [PATCH 2/7] MIPS: Embed syscore_ops in PCI context
Date: Mon, 17 Feb 2025 17:37:08 +0100
Message-ID: <20250217163713.211949-3-thierry.reding@gmail.com>
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

This enables the syscore callbacks to obtain the PCI context without
relying on a separate global variable.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/mips/pci/pci-alchemy.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/pci/pci-alchemy.c b/arch/mips/pci/pci-alchemy.c
index a20de7160b6b..02f0616518e1 100644
--- a/arch/mips/pci/pci-alchemy.c
+++ b/arch/mips/pci/pci-alchemy.c
@@ -33,6 +33,7 @@
 
 struct alchemy_pci_context {
 	struct pci_controller alchemy_pci_ctrl; /* leave as first member! */
+	struct syscore_ops pmops;
 	void __iomem *regs;			/* ctrl base */
 	/* tools for wired entry for config space access */
 	unsigned long last_elo0;
@@ -46,6 +47,12 @@ struct alchemy_pci_context {
 	int (*board_pci_idsel)(unsigned int devsel, int assert);
 };
 
+static inline struct alchemy_pci_context *
+syscore_to_pci_context(struct syscore_ops *ops)
+{
+	return container_of(ops, struct alchemy_pci_context, pmops);
+}
+
 /* for syscore_ops. There's only one PCI controller on Alchemy chips, so this
  * should suffice for now.
  */
@@ -306,9 +313,7 @@ static int alchemy_pci_def_idsel(unsigned int devsel, int assert)
 /* save PCI controller register contents. */
 static int alchemy_pci_suspend(struct syscore_ops *ops)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return 0;
+	struct alchemy_pci_context *ctx = syscore_to_pci_context(ops);
 
 	ctx->pm[0]  = __raw_readl(ctx->regs + PCI_REG_CMEM);
 	ctx->pm[1]  = __raw_readl(ctx->regs + PCI_REG_CONFIG) & 0x0009ffff;
@@ -328,9 +333,7 @@ static int alchemy_pci_suspend(struct syscore_ops *ops)
 
 static void alchemy_pci_resume(struct syscore_ops *ops)
 {
-	struct alchemy_pci_context *ctx = __alchemy_pci_ctx;
-	if (!ctx)
-		return;
+	struct alchemy_pci_context *ctx = syscore_to_pci_context(ops);
 
 	__raw_writel(ctx->pm[0],  ctx->regs + PCI_REG_CMEM);
 	__raw_writel(ctx->pm[2],  ctx->regs + PCI_REG_B2BMASK_CCH);
@@ -354,11 +357,6 @@ static void alchemy_pci_resume(struct syscore_ops *ops)
 	alchemy_pci_wired_entry(ctx);	/* install it */
 }
 
-static struct syscore_ops alchemy_pci_pmops = {
-	.suspend	= alchemy_pci_suspend,
-	.resume		= alchemy_pci_resume,
-};
-
 static int alchemy_pci_probe(struct platform_device *pdev)
 {
 	struct alchemy_pci_platdata *pd = pdev->dev.platform_data;
@@ -478,7 +476,9 @@ static int alchemy_pci_probe(struct platform_device *pdev)
 
 	__alchemy_pci_ctx = ctx;
 	platform_set_drvdata(pdev, ctx);
-	register_syscore_ops(&alchemy_pci_pmops);
+	ctx->pmops.suspend = alchemy_pci_suspend;
+	ctx->pmops.resume = alchemy_pci_resume;
+	register_syscore_ops(&ctx->pmops);
 	register_pci_controller(&ctx->alchemy_pci_ctrl);
 
 	dev_info(&pdev->dev, "PCI controller at %ld MHz\n",
-- 
2.48.1


