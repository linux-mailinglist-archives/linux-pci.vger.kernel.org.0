Return-Path: <linux-pci+bounces-9870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A792909B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9EB1F227D0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6044F510;
	Sat,  6 Jul 2024 03:54:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7EE552;
	Sat,  6 Jul 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720238059; cv=none; b=FMiJunnt+TMxXYOr3DTCC2u4MzcsboQwypponkQqwsMuneqalF3Zg+nyw5q+3pVZNbETZ0dKnseIEXIhby+DEMiHzNyq96mTkr/XpzRN5d6iwVKO7rwzyo+i0d3O68/Y9J/tv772iBmfqyQhmF9y0IcV1Hg5dIPPeIh0oSchbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720238059; c=relaxed/simple;
	bh=ITg6qRMPQUBa0g5V9kbsJV7gEtIiSexsTKQ1w1qpxm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtYyOBgtMzjC6jhueQsv8ONJpvlwyXlQIw9DxkMQL4Ey+0u58IthqE2KsJvIYl2WZ8GGb9AoMrP6LlrfUz/9BiDRpU1H2eNhAQL6Wh6SwkCpSrndXcGCsaeLR1/4YZk8ZikgXiR0qA4FKrl/ypT55DEOtmol7wGjHZFO9BQ7x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-380deeb250eso8115835ab.1;
        Fri, 05 Jul 2024 20:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720238057; x=1720842857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D4tI0AD6TKB5f8V0gI1Ny//6YFM3x96o/cMbfklP+8=;
        b=oW7a11WXUyNhgXoH/hyrXGd7nRvanv9WMt2xnOFNfjYgLEdBwwX44bkxmW+6GOnl0O
         PpnXlq7EmYuwYbM8CgT3PkHi2IPcJa0g2kRv8Vzo2X+BIYLChqFEdW3xfDsM9gky0eZ1
         +8B8LHoIMzPh5fUJ6i/I21BcEZqk2NS/J5yUfWoY+LPVEbgx+fJ0DFUp8+S5pUjDdi3t
         RdaTEC8U0WjrlRKHYQcCgUluvpwXYVHggEZuB/dNyNz3ZxK/PBunKZOSURN52TgA/dEp
         SmcbsmT4532uIhye24lrsdwG1jCRyWuYN2AyVJbvZqlsMn4J8Tt5UeF+JG1LfVBtzXHS
         3MmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfTzEk3MW9kOC5J4gicLvjTtReehrHM93r4ox0dcyMQz9N6GH4mw/2q3VRtIrs/lnqB+kGDd5QCnDgOjjSTHz1JpQm9r+zqohHB0jiY9A1lr6JQz+CHzsm5y9lFOd+5aYRtZD3dl7G0jrDxcKW7MpY3k3VZIfAGoMbKZpmTLo9QidimyYGcNRLUD1CGp8pgHKxE40Ke/pcfll9M606FVc0LMi27068MDNL33s=
X-Gm-Message-State: AOJu0YwgeBpUm+qfsl6OxmKg8WGT7GNIG7QuQT2zueNwaUUMIk7CfflT
	b27Da65LdKNCX+Y1VQqTFs/3xR1zZb6mch4LKiuBRg9989veq/eQyrqHQ4N9sPE=
X-Google-Smtp-Source: AGHT+IFkmr6rOVVQ6tzIaz/yVRjICqptKhGOdC6MQB/5XVn5kCPoeWBDP61rz3vPYC4BMP0jc8MmoA==
X-Received: by 2002:a05:6e02:1ca5:b0:381:40be:4ce6 with SMTP id e9e14a558f8ab-38398a01bcbmr78518675ab.11.1720238057336;
        Fri, 05 Jul 2024 20:54:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b12e6712esm1565477b3a.25.2024.07.05.20.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:54:16 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:54:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Will Deacon <will@kernel.org>, Joyce Ooi <joyce.ooi@intel.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] PCI: controller: add missing MODULE_DESCRIPTION()
 macros
Message-ID: <20240706035415.GJ1195499@rocinante>
References: <20240626-md-drivers-pci-controller-v2-1-94c811db7a51@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-md-drivers-pci-controller-v2-1-94c811db7a51@quicinc.com>

Hello,

> When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/dwc/pci-exynos.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pci-host-generic.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-altera-msi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mediatek-gen3.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/vmd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-apple.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/controller/pcie-mt7621.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.

Applied to misc, thank you!

[1/1] PCI: controller: Add missing MODULE_DESCRIPTION() macros
      https://git.kernel.org/pci/pci/c/df472e9b08e2

	Krzysztof

