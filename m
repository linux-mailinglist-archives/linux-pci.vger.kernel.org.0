Return-Path: <linux-pci+bounces-3592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C1857BC5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB261C220BB
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F477F14;
	Fri, 16 Feb 2024 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/MSlNoC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55937690B
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083238; cv=none; b=VX9/EbcYNTFKB1dQNm6Nb40L6diw/bcsTQjdNKhKldX6uCUDS8QDb4beAYmgL+m5OLAfw58gfnMjZ+pZy3AUNIqQcCve47zFRWOoT5a5J73rYxvlw/s+IDtLW8ClDo478jvjSaem0dO5JQ4ASVz9ZasEL1FlKekju34ZP1v39FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083238; c=relaxed/simple;
	bh=SPISHpn2Wk7XuuDW0mygRbL3qdnVVMzYr7AU982JFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1U4zQ3Xh0v0dk7iTXeb5nnZlls9Uus0TRfV/uyQfPYLUAcOOE3pvbieiwv/WRgQfb+0Eb/9nEv0GBaFFjkJb4tBvBejkP2BKtq2UCAnPplrkI8OQAbu3w1UXHIEcA9xNntDuWmU7YTlML5oDWjj3mIaVkRMaZ/VcQGB5Gh9aqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v/MSlNoC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2992d7530f8so636600a91.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 03:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708083235; x=1708688035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DbUuxH8+eQt+V5fPVQ90ScLeG/5OvbXcVZwS4s/Sjn8=;
        b=v/MSlNoCsibm1VaZDwVCkvYI8EjDjZsFjxnlmCNkHRNnG1fXdKCn2K1AwKY+qzUDmc
         kyEQrVLfMziBsJHXxs5mgF4TPKjsXyKkqdcT/HkM6SAdIlUd4HL2b+GJ5ABj3IR7LCbk
         2QsefJnLAq12gC/3NsSMvx4DcDzjn5xVW9gxWKbJZmHReZ3nlVeJXTtr/8BcYz9GySyp
         I+1fOM7FRATwZzeWxDBXW3eZ88Qbwrc4vOfYf2KrKVivvZB+fJ2NML1gZXzNyJT/bG+8
         ao5SFa+J/2vXZp/y7+r8b4RKVk/fLa2xhAI5ogbq585eV2oeA5jyOTBpqNHZR2t1SnUK
         1ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083235; x=1708688035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbUuxH8+eQt+V5fPVQ90ScLeG/5OvbXcVZwS4s/Sjn8=;
        b=MEGtxcPa6Ajaf81FU5nYYtXtgABcIy0FfVpOfOl8Oa3V9JIR/6D973LmCJP5AV/Ih7
         nxAqTD33R9EyWlG2EpQVSxZUbBs6N7pmuDZY1BdIUJ6FtKQ71XHFic9C+qwe3imXjc1r
         J5lwXHL3iGlW48Xl3hk3z31U2NuSdsIjynDevVYMoqRaFFzPGL29arybf9Sbgn2X4QFe
         /VmRj+1t5hm7XefnC6IvZ0f7ncMOF26X4qDWWu7wapNa0deK35Sjkzre8ZTOdCXragOM
         c12o832zong0YLgdLj40ovQ4XJMJOf9TemucjQKTqotmCczCRnsW4bwCIKqTBVkW+VRg
         HWuw==
X-Forwarded-Encrypted: i=1; AJvYcCXZgTenaGB6Oqr6qF84NQ2MDYlVm6FuDXeN3A4qFaQgPV3sQHHajYQPP1VW256qWseAVrPiWH7dgSAtZlguw1ZQlypPX3UcQ/XF
X-Gm-Message-State: AOJu0Yxb3xKj9gnEW+umah+/4aYzVe9+YogYibEgBk9G2uQCO/lsfpns
	khrDuiGcCq3iGyYVa7HK2yMwoovKXHXnDimobbYzuqjOcjXNX65Iym6fTZ2uhw==
X-Google-Smtp-Source: AGHT+IETesKAnay2AGJDq2QBceer8wDdIUIjpemHsRLi2VEq0GJGVXaiWQgru4PSBzIAejutTuKmnw==
X-Received: by 2002:a17:90a:b385:b0:299:2b9a:88c4 with SMTP id e5-20020a17090ab38500b002992b9a88c4mr3787311pjr.1.1708083234940;
        Fri, 16 Feb 2024 03:33:54 -0800 (PST)
Received: from thinkpad ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090ac08800b00299268defb9sm1946408pjs.41.2024.02.16.03.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:33:54 -0800 (PST)
Date: Fri, 16 Feb 2024 17:03:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	pankaj.dubey@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Message-ID: <20240216113347.GG2559@thinkpad>
References: <20240213132751.46813-1-shradha.t@samsung.com>
 <CGME20240213132806epcas5p43e394aea91c61797a8cc3a901e0cf574@epcas5p4.samsung.com>
 <20240213132751.46813-2-shradha.t@samsung.com>
 <20240216113147.GF2559@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216113147.GF2559@thinkpad>

On Fri, Feb 16, 2024 at 05:01:47PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 13, 2024 at 06:57:50PM +0530, Shradha Todi wrote:
> > Provide a managed devm_clk_bulk* wrapper to get and enable all
> > bulk clocks in order to simplify drivers that keeps all clocks
> > enabled for the time of driver operation.
> > 
> > Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > ---
> >  drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h      | 23 +++++++++++++++++++++++
> >  2 files changed, 63 insertions(+)
> > 

[...]

> > diff --git a/include/linux/clk.h b/include/linux/clk.h
> > index 1ef013324237..85a9330d5a5a 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > @@ -438,6 +438,22 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
> >  int __must_check devm_clk_bulk_get_all(struct device *dev,
> >  				       struct clk_bulk_data **clks);
> >  
> > +/**
> > + * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consumer (managed)
> > + * @dev: device for clock "consumer"
> > + * @clks: pointer to the clk_bulk_data table of consumer
> > + *
> > + * Returns success (0) or negative errno.
> > + *
> > + * This helper function allows drivers to get all clocks of the
> > + * consumer and enables them in one operation with management.
> > + * The clks will automatically be disabled and freed when the device
> > + * is unbound.
> > + */
> > +
> > +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> > +					      struct clk_bulk_data **clks);
> > +
> >  /**
> >   * devm_clk_get - lookup and obtain a managed reference to a clock producer.
> >   * @dev: device for clock "consumer"
> > @@ -960,6 +976,13 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> > +						struct clk_bulk_data **clks)
> > +{
> > +

Just noticed this extra newline after sending my r-b tag. Please remove it in
next iteration.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

