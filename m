Return-Path: <linux-pci+bounces-18945-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721FA9FA846
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 22:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C5F163D5B
	for <lists+linux-pci@lfdr.de>; Sun, 22 Dec 2024 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0B1FDA;
	Sun, 22 Dec 2024 21:18:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCFFA35
	for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734902284; cv=none; b=rWvb1VckA5K46D9zXbn+S+vpMbBHpA99lhTpQyauH1meAhnt7hmnIY0Ao0GBfsTNJLUvRsmQLl9vEpQu/uYVsb5zRm8HkD26mJeT9mhuMrg35IHw1YSiv6McnIYt0Q9r0v5gWMIUun7qNkyFOa/y8xOgIVkKBgXx5PzO+BsphNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734902284; c=relaxed/simple;
	bh=0KiKk4Hf8ft1TQ6boAECfCi0xCDdKVP4/V2RgnDPOgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGWgU6tl4Ulbj8/5lAOiQadC8eoLu7pfVu2g2O81wwqIcK25gtORFO/44KuYHOLHuIllTC4jbwQ8akTVmu+Jouu55imYa5WbQgEd1Ow0+/99ba3gNM3iNxRNIXDdEqMvp7gjL7ARdHkUpUhFDlr92u1LOvrYyFonPk/6cFXjgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728e729562fso2876315b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 13:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734902282; x=1735507082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySFOKP2T6SSvf2783MptIdxQD1iRTp1mDG8rIDy1B2I=;
        b=pzyf9I+p99bt15YvMAfYm3Ftz9Y7LDtq4R7Ndh4tdaNKXfJoO5+0O9eWd0EQFzyBZ4
         ChkDl5x4vxSR4AWKTgkxioorEvlISYAT88zUbxLW51q9UhiOX0nHekR1ZHbq8HwwXSMe
         FOj1t7USkeKXgu/9TazUAdFY01xANwMWvFdVt9o9mjQ2UWmfzSNkod5zsEbsqAJHHXwO
         A4o9gE3/CrOtAcLTStCoiZpxnvvsV2+eFJlOs0ImsWWOS2FRkRhTfhxQVyFbcH3r5ZGd
         xcW9Cvjn8V+/ta3wkKNKBsc0wUmCVFdGYNhHeD+o4Fe+1Uz3Y6qZj+cO4vaZxCw99qL3
         ngPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6O3EpVZoNKwERnd07WhSKAy3eYDmz6owwwAJUp+kLgBxRyVSdC3rnkpucfIIwVtDWys3qhzyp1T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQt8wmBjJHsSUKrC9r/U7i4izuvqk3811SP8Mqp+N2zIEuzpW8
	+Kk6anOSMm8PfYwAC8Gx2xSVp1mwucwL8T2GlDjaNSsDYsAWbfVk
X-Gm-Gg: ASbGncuc7I1KsTK9m2QYW47opWZtBo5D/igDvaGmpRKvoPba8OdFDXvw/qrINmXMSJP
	tVFHu6zdsmW6ok0DrRCd1MA4Sj/NonG6N8zm3SyVD2J7kqObgxxfFkXfOmYvaMa+zruUo0arDXi
	NdHTAIdT6+PIyiFZL9a60Gn93OwrAonADnvAXIdmMshiVhlXK046Gz1N/RNf5v2+DRP5wHHg84O
	weoz0Rt/nlUO3nmJz7/x2ZNLS9udvuwGIKXwNYp22E/jPCbKy4ct6nOi6t/sLBE2OxJ1+KdH4Gp
	nVmpdAibcVcZuPI=
X-Google-Smtp-Source: AGHT+IFThwQq8fk2Aa5r1r9/KyCTguIoXFq3omelBgI+dXM6jILXlipwMI/2/TJlCG5GvLarF8F9Hw==
X-Received: by 2002:a05:6a00:330b:b0:728:e382:5f14 with SMTP id d2e1a72fcca58-72abdd7bae3mr12566717b3a.9.1734902282291;
        Sun, 22 Dec 2024 13:18:02 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fb957sm6746272b3a.140.2024.12.22.13.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 13:18:01 -0800 (PST)
Date: Mon, 23 Dec 2024 06:17:59 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	Hui Ma <hui.ma@airoha.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Avoid PCIe resetting via
 PCIE_RSTB for Airoha EN7581 SoC
Message-ID: <20241222211759.GF3111282@rocinante>
References: <20241113-pcie-en7581-rst-fix-v3-1-23c5082335f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-pcie-en7581-rst-fix-v3-1-23c5082335f7@kernel.org>

Hello,

> Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
> causing occasional PCIe link down issues. In order to overcome the
> problem, PCIE_RSTB signals are not asserted/released during device probe or
> suspend/resume phase and the PCIe block is reset using REG_PCI_CONTROL
> (0x88) and REG_RESET_CONTROL (0x834) registers available in the clock
> module running clk_bulk_prepare_enable in mtk_pcie_en7581_power_up().
> 
> Introduce flags field in the mtk_gen3_pcie_pdata struct in order to
> specify per-SoC capabilities.

Applied to controller/mediatek, thank you!

[01/01] PCI: mediatek-gen3: Avoid PCIe resetting via PCIE_RSTB for Airoha EN7581 SoC
        https://git.kernel.org/pci/pci/c/0d0a2b74dc08

	Krzysztof

