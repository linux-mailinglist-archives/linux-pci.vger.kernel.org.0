Return-Path: <linux-pci+bounces-41861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA18C79802
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 14:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2747A4E8151
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 13:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153434C123;
	Fri, 21 Nov 2025 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgza6aNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63334CFA1
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732142; cv=none; b=LO8MsXx1vUaZUx/n4F6XWxX9HwZvk66ASitmK7tOU6+Vjt7ZkQtcarJOSahNZAliVtpmVxd7WkpXUFkJxIakecyC0nyiDLpOW5kqmJ5sy/K4VT6pmsVmikIHetbxEt0aHjpNPRCkBiAM4Td3vw00IAd1tTG8ge2MtBca78PnHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732142; c=relaxed/simple;
	bh=drNEbA3TGFTz25pvYcWW3qcdRYeCRjiFF+YwTp5NrEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K91gaQVneiGMLiZ73aA4mjoNpbZE+0UTBrz2rl+q4yWEmJZ8vdShdXA2XGML9dCAXjqcjRmiASh/YfhfUm1+29h7Gl4yNVD3uRLTwfpKGIxRHCkDaxguv8fcKaUyvjlhx7JB6rOtHO2FvArOp5WhnBAlsdxpo8qPLfQZL9IxkQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgza6aNi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso865498f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 05:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763732139; x=1764336939; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qf7aj+yc10CQJFCUa9U/IQT8bJQVst3NQGAAJzT7Ug8=;
        b=bgza6aNiKjTKHTmhAnHTBMa7gight++KoqJE4Mn2VeUMqsbsDSilaTiXltJJ6MjTkF
         gxlLecbECbo4+NiMcX9SWoRrD+XtwrJBPYpzaQOthC357sYCUKRClqaRXl7wWIHO88Gl
         zBgdNd/WplYLS4XsK7mbWCG3yDIrcinAksWIMZCKGQuaUrdjUmlVd349i5qyt7t0P7zH
         gDYoqFBeJTrFSZI1g566VXxanzbgn8h7wWI/uiz1TrXMZv8EoFlsRoGZG3lTF59zz43s
         8qiSmMwXll3XGXEAlz4YIxtpd1c85d19yCGxgKC5oD9cWSTrZ1sfG0+fgoyxOzHJOftY
         EOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732139; x=1764336939;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qf7aj+yc10CQJFCUa9U/IQT8bJQVst3NQGAAJzT7Ug8=;
        b=HWaBSDziFnepewNrEI+M9CeIFUnaLAiJCuOll/ykp2R+TcoUPpx9OEDeW8MYIn4z+9
         duXhSAGf9tmDRWuNjm+DBXidMZNngXYM8v2vBnY7E5j78eJBQ4LdG4Qklb7cuBTYwN5O
         l0HHlZ+vk+c8ZUW/6rKOIt2gIFdgEMS5pBm1E7pLvY+AqZ6rn5JjjpztHtI0BqjBpx+x
         iRg4dEWF1fKcQO/RE0mjdoKtwtTwWWj3yEvPsdTxCLpZbDWxaCKnEZutkCNzBYrsQSx3
         jjLrhnFXSE4YvtRp35iW5YE9vTl0dMdaQ7/0gUcIinl2wN5M1qzUuy+BwIiKHAn9qTya
         VUjg==
X-Forwarded-Encrypted: i=1; AJvYcCXCj7QkJyZvkdgYMgb6dO5q9EevvWw1RGmQacvQhOxs9eiu+LKUQAVfga8Zol+V9KNzt/9SPlmkyV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRV5vTGssa1hIzdnsAta1dv1J5Wk/i5zvEH/LAriG6GHqQg076
	B1rsJuvt/mflwZCas6GNSMKNyTWUljyLDFk9nSWWYfVKR2CUrRXtDFePuye5JmP9aG8=
X-Gm-Gg: ASbGncs4DjWaByFmBu0e00304dvq15sPyZZPQGiNA4xVxefc+4RxIPihwUMdbF2dy4w
	Tdy04NYAYzOdePyTPJg+1hgoCswwnsUm7m1V2h6ZO7oKJAj7DeBP8H1mxwHfb9PnTkFysPIov0o
	axYwAKFtWDSfH5VEVFx05AVbZG7iDyQQ0GQ/py6Uxq+LXIvGoUht6As8pgCI8Foy6rt3sHF+Hcj
	XNSp2EaQMxh3Git5aSBPr2sKtwtyUilVAI5JP4Ymv67o4lfnMfsVYRZhYZggz5+S/6noDmZ3kVu
	kBrV+2eoDN2F7ECIBWddI72PBMaA26MTmh2PL5/ohV7MynE+42ek/FhqNt+Qr6uNuGNc6GTyHci
	Dagc0exEltLmtYqskH6uhXNXAoM4gzgXKxU+0GnBy/T2pk2xIaD0RPMn/zlOvHtDlg3RF3kek1m
	rDYQUZFA/BnYViaYXF
X-Google-Smtp-Source: AGHT+IFMJQ1wANIBmqRUOFCIS/jFxvbxo35wZufea9yE3HbGd15lQ3zQbTa6IMYdQDLdKJljttL+tg==
X-Received: by 2002:a05:6000:4012:b0:428:5673:11e0 with SMTP id ffacd0b85a97d-42cc1d1999dmr2595402f8f.40.1763732138738;
        Fri, 21 Nov 2025 05:35:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7fa41d2sm10902508f8f.22.2025.11.21.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:35:38 -0800 (PST)
Date: Fri, 21 Nov 2025 16:35:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] PCI: sky1: Fix error codes in sky1_pcie_resource_get()
Message-ID: <aSBqp0cglr-Sc8na@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return negative -ENODEV instead of positive ENODEV.

Fixes: 25b3feb70d64 ("PCI: sky1: Add PCIe host support for CIX Sky1")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/controller/cadence/pci-sky1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
index 99a1f3fae1b3..d8c216dc120d 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -65,7 +65,7 @@ static int sky1_pcie_resource_get(struct platform_device *pdev,
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
 	if (!res)
-		return dev_err_probe(dev, ENODEV, "unable to get \"cfg\" resource\n");
+		return dev_err_probe(dev, -ENODEV, "unable to get \"cfg\" resource\n");
 	pcie->cfg_res = res;
 
 	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
@@ -82,7 +82,7 @@ static int sky1_pcie_resource_get(struct platform_device *pdev,
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
 	if (!res)
-		return dev_err_probe(dev, ENODEV, "unable to get \"msg\" resource\n");
+		return dev_err_probe(dev, -ENODEV, "unable to get \"msg\" resource\n");
 	pcie->msg_res = res;
 	pcie->msg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->msg_base)) {
-- 
2.51.0


