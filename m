Return-Path: <linux-pci+bounces-4652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17293876141
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 10:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D552829B1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624D5535BA;
	Fri,  8 Mar 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDUwHABd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280153385
	for <linux-pci@vger.kernel.org>; Fri,  8 Mar 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891408; cv=none; b=Cp8hl9vZ+eO27oFNZlColEc7mY00trB6K5U/gFoEp2lRRuE77Hhq01I6w7ojVkAbQ+kG2NY0gZbBcwSORyATT6aBUthZfe3Nxsg/YBCyxuWhbxNZC1H2Dn0Kgj+zPc3MwohWNKtAUx46rxsx2z58xb0RZU3SUN1GJtKEIRpk9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891408; c=relaxed/simple;
	bh=N+FnD75U9P5fcQ38HlMO4pcD/DzIJlqTaauzTbsehwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B22+f5Ujk4Um9FhYSDaZM28QN19w2Kb230RrWdNnlyAiyaOGDgmidNXG0D0PuAHbyaYQVxN0qZfU5SEXaZ/9ziGszNKE9loN/b+VZiDu5GaO5PH05jruLwVNm61p1yBpC4NxEa+vbN9kYm9vwxv2fRcdpNrHIEq8ghFPXy0jCKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HDUwHABd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1532553a12.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Mar 2024 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709891405; x=1710496205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dKXhomeB6Ij6pEZAsrhigScw7Imo0KcKY8tqU3ajKw=;
        b=HDUwHABdT92cmTAErIymd71gIzFwxlngdnjYnnJDu5wUhDIg1nJK4RHjEo4BS0jKuB
         G99mFpPQfLPiXRRmEYZJDp2kreUmiWDm9R94GfowCB8JSfRVXY/vnKddRLtk8N67lqxu
         fePNWztxa8g5MNRwH2cxR97zdVlikMFyNII48E6VE6zZr0xkdfANfTA5y+GPT+QZVVDr
         ScS4ME+JQyD1CYdFB31P8uecrdFfh/L4t2a6g+sw/vUJxDXIYuvM3OUXmE1K47WLZvY6
         1ibvW+/j9gbUHU4aPBtNNaTmQxXVENs4Mt4GwBC1zu5fQyAMM1uYwDlX/8GvgnNIU2f4
         Gq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891405; x=1710496205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dKXhomeB6Ij6pEZAsrhigScw7Imo0KcKY8tqU3ajKw=;
        b=RdoYpHKtqxpjcEm/X0m9jLnjwW58Wfg9uWe/nUD6u8IU1GhxMs8uDO/ObNJ6DyjiSO
         1BxUA7tlWfrh15IMNvEl/dg1uO6ismKW54ktWwh1irlMenNsOtZ6u5E5NnoHCWibVG/k
         6aWziz38muIdLbgN70ADcQ0iNRyQdRz99+UGEGrXjsnmOZK5q++DpCSfRd+0WQZFiZyL
         8QmFzodIeL75Gjw6nXCHbzNYqiA21QwZHtFiJA1SmpZgtYuuLWHAmAuhVvszvsBkjmZD
         pNpBWAGCrOIz9ZOGJ/Bn/H8cPmkd3aiLRP30yv2a/eGTzZnzoBMq588U8pKhm/tOX+R2
         uJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUryZjx+VCAo4+Muwv/e7CPtBrTOg/nRI+HsjR4q8uGn8Wqu1yyUNTZlpi3NYTgcsAnhik7quz0/Wd7yEVJAOF31iYG1I6nziMt
X-Gm-Message-State: AOJu0YzulzjFlFW0B4opjt4bw+jUUM6nDRi1S9z03KVb0hSpqHBz2oLW
	KkSgkhA5KfKrZnSgWB79ZDOnf42ov8em3ye2g5jxIMdhqfHNB78icg1+sGbTCQ==
X-Google-Smtp-Source: AGHT+IEMW10NsMpl6QbbrMpGgV+z8bvUPkiIHa5C3nopapJCs9aJNBuwrvqex+LlxA53iZxgm5hkkg==
X-Received: by 2002:a05:6a20:160a:b0:1a1:4a45:c05f with SMTP id l10-20020a056a20160a00b001a14a45c05fmr12756809pzj.25.1709891405150;
        Fri, 08 Mar 2024 01:50:05 -0800 (PST)
Received: from thinkpad ([117.217.183.232])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090aea0800b0029bb8ebdc23sm374544pjy.37.2024.03.08.01.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:50:04 -0800 (PST)
Date: Fri, 8 Mar 2024 15:19:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v9 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <20240308094947.GH3789@thinkpad>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>
 <ZeolaEIRYmKZjnvT@ryzen>
 <20240308053624.GB3789@thinkpad>
 <ZerUx9Vw_W997LZk@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZerUx9Vw_W997LZk@ryzen>

On Fri, Mar 08, 2024 at 10:05:11AM +0100, Niklas Cassel wrote:
> On Fri, Mar 08, 2024 at 11:06:24AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Mar 07, 2024 at 09:36:56PM +0100, Niklas Cassel wrote:
> > > On Mon, Mar 04, 2024 at 02:52:18PM +0530, Manivannan Sadhasivam wrote:
> > > > Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> > > > drivers requiring active refclk from host. But for the other drivers, it is
> > > > getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> > > > that this API initializes DWC EP specific registers and that requires an
> > > > active refclk (either from host or generated locally by endpoint itsef).
> > > > 
> > > > But, this causes a discrepancy among the glue drivers. So to avoid this
> > > > confusion, let's call this API directly from all glue drivers irrespective
> > > > of refclk dependency. Only difference here is that the drivers requiring
> > > > refclk from host will call this API only after the refclk is received and
> > > > other drivers without refclk dependency will call this API right after
> > > > dw_pcie_ep_init().
> > > > 
> > > > With this change, the check for 'core_init_notifier' flag can now be
> > > > dropped from dw_pcie_ep_init() API. This will also allow us to remove the
> > > > 'core_init_notifier' flag completely in the later commits.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
> > > >  drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
> > > >  drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
> > > >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
> > > >  drivers/pci/controller/dwc/pcie-artpec6.c         | 13 ++++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
> > > >  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
> > > >  drivers/pci/controller/dwc/pcie-keembay.c         | 16 +++++++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
> > > >  10 files changed, 90 insertions(+), 26 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > > > index 0e406677060d..395042b29ffc 100644
> > > > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > > > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > > > @@ -467,6 +467,13 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > +	ret = dw_pcie_ep_init_registers(ep);
> > > > +	if (ret) {
> > > 
> > > Here you are using if (ret) to error check the return from
> > > dw_pcie_ep_init_registers().
> > > 
> > > 
> > > > index c0c62533a3f1..8392894ed286 100644
> > > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > > @@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > > >  		ret = dw_pcie_ep_init(&pci->ep);
> > > >  		if (ret < 0)
> > > >  			goto err_get_sync;
> > > > +
> > > > +		ret = dw_pcie_ep_init_registers(&pci->ep);
> > > > +		if (ret < 0) {
> > > 
> > > Here you are using if (ret < 0) to error check the return from
> > > dw_pcie_ep_init_registers(). Please be consistent.
> > > 
> > 
> > I maintained the consistency w.r.t individual drivers. Please check them
> > individually.
> > 
> > If I maintain consistency w.r.t this patch, then the style will change within
> > the drivers.
> 
> Personally, I disagree with that.
> 
> All glue drivers should use the same way of checking dw_pcie_ep_init(),
> depending on the kdoc of dw_pcie_ep_init().
> 
> If the kdoc for dw_pcie_ep_init() says returns 0 on success,
> then I think that it is strictly more correct to do:
> 
> ret = dw_pcie_ep_init()
> if (ret) {
> 	<error handling>
> }
> 
> And if a glue driver doesn't look like that, then I think we should change
> them. (Same reasoning for dw_pcie_ep_init_registers().)
> 
> 
> If you read code that looks like:
> ret = dw_pcie_ep_init()
> if (ret < 0) {
> 	<error handling>
> }
> 
> then you assume that is is a function with a kdoc that says it can return 0
> or a positive value on success, e.g. a function that returns an index in an
> array.
> 

But if you read the same function from the individual drivers, it could present
a different opinion because the samantics is different than others.

I'm not opposed to keeping the API semantics consistent, but we have to take
account of the drivers style as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

