Return-Path: <linux-pci+bounces-13502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03849854B3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9F8283909
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC4158524;
	Wed, 25 Sep 2024 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VqZMfJx/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886F157472
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251019; cv=none; b=iKbdcywSZZgCp8NXTgJqx+5uVDkzMSWP4L1Jkm0cIR6rVvklDQG2sJJYWSRdymdbuyxAgZem3ZB0cPDvNHG6YDkHaCUlCJpb3MmJAGK5zF812u8lfOIdoODMJnTDamxbOkpf6xG+JCeT8fHEgc/gRhgEqJrCqX/x6DyvUlWn3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251019; c=relaxed/simple;
	bh=y8UnaPWTJ2sDKUkIIYmLIYvICZTv+MOao58ntWBs9nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmKutnFe4BUVgUQ2mB79DvXa2TGMQQsSeCAU2EcY4lZZEA5dCxe9DXqWgt/0Oy4wd9zCotcqKO0k9jZaGh60Lm6HK5vVLu+M+gTjRwT+aOkG1jZtvGqBC5Ba1q3OLX0qKX2CYdXfFuVL3aMVO1Bxm3A4QWIN4PKei4sVV5zUJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VqZMfJx/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-378f600e090so3663234f8f.3
        for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727251016; x=1727855816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ex1eFr4hS+ZGn1Z31JmBv4PhcgqRDO/Hbk8Px9C2Jek=;
        b=VqZMfJx/bKI5uoZb86ZLZYPCCFco0pGjPy3QfnTb9OuH4kTBhL9KVcchJjfyKA2Wa1
         qJOM1MrFZW7ocBWzVTKCJhsAvjjZGz5ugfqcqBDR2HDt3BNFD6xnZOn3jRz7PM3Vd35M
         ty4NSKwpWisl/h5vc4eF5veKBN7wtU8ynKEyJDoPoXNeFnSEBa9Rq8X7LPb3WgS3iFtU
         uzvOhfI6MA5loYmkUDvaX3Y4vAnOKNYP+ABq3W+pE8fwyB0o6Mn7u7ZcgabZpftqQR4w
         MKnT+sJi/Ia9OhiZY+Q1a7p7P9CmQQ8v/QWQruS8VNxOISrRpjSPpUe8vwhTP+E1jUt8
         zJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727251016; x=1727855816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ex1eFr4hS+ZGn1Z31JmBv4PhcgqRDO/Hbk8Px9C2Jek=;
        b=ae45LbAwc2xahvB1nBe28kjxJYqz91pv4FDgcvyeMtiSBr5FYddFV6CkLMPFZgVNZr
         IlX8/Aam8QPPY79pmN/ZUP8bhxmHPTvkovuV9YKUrpYiMC3khyOOYTUq2nDpB7M8369T
         iPc+Xfc0lCIhZik3XSXPKhVEUstBFojq27DtvnHFSEpA+eb/rMikbMeI4eDPJKYU7C5Z
         fOj7Qa6R8H+Qy+3rD7rUZ1oXA5pjkFzoAm255kuFYYoa6xLUnmVo6ZMV6mV4reJj0vjZ
         4H3mp7MBgh4GFkl/SQ3GjbDnG+XCQXOmipVOlzJN4vnPRAu8SgSFBeHfkuLzTDKckvos
         60Kg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Npuv7cZUJdi8qUCaZpZ7ABcal2/6jM1fu7VMdEd0jbiDw+rO5Qs485OLHu0kc+XEKK7GkEIVf64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4jv+vicUhEvWSIXx9GQsYI7s3rYiavd+4YukXBN8mQP9IYL6
	07uK8Sh6PeQsGEdH+TPikwijFOIgeql5ZrOreYUBDxCKdg0TtjWB64T0XOnDuA==
X-Google-Smtp-Source: AGHT+IF2WTBpi0WKM13oYD6g9v8s+vSbS1vZ7h85OwPzdWyievegW/qIqe69gYQpJLdHkgY2OvXiUQ==
X-Received: by 2002:a5d:64c9:0:b0:368:7f4f:9ead with SMTP id ffacd0b85a97d-37cc246b30emr1075354f8f.7.1727251016023;
        Wed, 25 Sep 2024 00:56:56 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a1682csm10166775e9.36.2024.09.25.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 00:56:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 09:56:54 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 0/4] Provide devm_clk_bulk_get_all_enabled() helper
Message-ID: <20240925075654.f2pefosdspqiakvj@thinkpad>
References: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
 <20240924143634.pqpdsewoqxn3liqi@thinkpad>
 <70a24964-990b-4606-bdc8-4dd42c44785a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70a24964-990b-4606-bdc8-4dd42c44785a@collabora.com>

On Wed, Sep 25, 2024 at 09:52:44AM +0200, AngeloGioacchino Del Regno wrote:
> Il 24/09/24 16:36, Manivannan Sadhasivam ha scritto:
> > On Sat, Sep 14, 2024 at 09:04:53PM +0300, Cristian Ciocaltea wrote:
> > > Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
> > > clocks") added devm_clk_bulk_get_all_enable() function, but missed to
> > > return the number of clocks stored in the clk_bulk_data table referenced
> > > by the clks argument.
> > > 
> > > That is required in case there is a need to iterate these clocks later,
> > > therefore I couldn't see any use case of this parameter and should have
> > > been simply removed from the function declaration.
> > > 
> > 
> > Is there an user that currerntly does this?
> > 
> 
> Yes and the patch wasn't sent upstream yet, but anyway, regardless of that,
> this series is fixing inconsistency with both naming and usage between the
> clock (bulk) API functions, with that being the only function acting
> different from the others, at best confusing people.
> 

I agree with the 'inconsistency' part of the API, but I wouldn't call it as
*broken* as this series does. Please fix that and you can have my:

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Cheers,
> Angelo
> 
> > - Mani
> > 
> > > The first patch in the series provides devm_clk_bulk_get_all_enabled()
> > > variant, which is consistent with devm_clk_bulk_get_all() in terms of
> > > the returned value:
> > > 
> > >   > 0 if one or more clocks have been stored
> > >   = 0 if there are no clocks
> > >   < 0 if an error occurred
> > > 
> > > Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
> > > the past form of 'enable'.
> > > 
> > > The next two patches switch existing users of devm_clk_get_enable() to
> > > the new helper - there were only two, as of next-20240913.
> > > 
> > > The last patch drops the now obsolete devm_clk_bulk_get_all_enable()
> > > helper.
> > > 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > > ---
> > > Cristian Ciocaltea (4):
> > >        clk: Provide devm_clk_bulk_get_all_enabled() helper
> > >        soc: mediatek: pwrap: Switch to devm_clk_bulk_get_all_enabled()
> > >        PCI: exynos: Switch to devm_clk_bulk_get_all_enabled()
> > >        clk: Drop obsolete devm_clk_bulk_get_all_enable() helper
> > > 
> > >   drivers/clk/clk-devres.c                | 30 ++++++++++++++++--------------
> > >   drivers/pci/controller/dwc/pci-exynos.c |  2 +-
> > >   drivers/soc/mediatek/mtk-pmic-wrap.c    |  4 ++--
> > >   include/linux/clk.h                     | 12 +++++++-----
> > >   4 files changed, 26 insertions(+), 22 deletions(-)
> > > ---
> > > base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
> > > change-id: 20240912-clk_bulk_ena_fix-16ba77358ddf
> > > 
> > 
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

