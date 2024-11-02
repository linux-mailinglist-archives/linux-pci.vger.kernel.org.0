Return-Path: <linux-pci+bounces-15842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B669BA014
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 13:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54C51F21C44
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66535189BB4;
	Sat,  2 Nov 2024 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5NeChck"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FD19A
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551749; cv=none; b=Ds1FcPXGpkm3zSDqiO2FNbJ04hfXLboh9fi+nw1WmNWSdEvQ9voT+HfVkHeZDb7Q4wyTO0Hx8sxfICmrufnU0/F0oc2vm8VwMLGcL+zYK+MImNWdN3ogDDa93g9zoExmKl+cIwLpqic9DP3Lw7sol/1WGrLOAS0Q/JLt3QaVjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551749; c=relaxed/simple;
	bh=752tm1zHFUoUxLVT8d/Kyt3IfN/+0+C8drqEuOo4KZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrAuOJYecbfVlitCf5P4MTzvZj0+zh3tkB/IXA5Vu7iqJ4PoHsjOL/QqnMuduwg5BuAzgPjwxqHJ4aZunAR6/PF746Gz+zXTQFf3DHNKRw3yM2uEFDHySx0Yc/SpH2rGAv7/9GPcDp2I7AcnddqsgzrqYRy+ePoiPYNTkuboT4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5NeChck; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1366790b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730551747; x=1731156547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R62GHxpMLcqbWJtHlNo45biE4A5QHRMLQkq3r0GrtUU=;
        b=Y5NeChckYx1rSoENI7oXBknN4QOEn7ZpXJuA38fFIfnYrTKE9/7g3xl+XXq88o/kBX
         RPJgCR6x7a/u/o766LB3L35zx3ZJPb+d1VEJOQgav/VlLJ4G45bJcBiQTjfsHLzwmUID
         BKQwNo3qNP6K/hsRs9o4gd0HSVWIf3bgEkiGZ9J5aQbtXwxbyFnUSC4FLME+f72ATvMe
         nyosaB4/M57KXyXtL4aQ34PGNvIi3gmnY5Z0TTzBYXDMO/QcbgalTpBV/u2AlOEp1Kkl
         jnG7V2n42qHEoMrTysLjMMEJqlaTMtOxVvW8bZQDmbbq3YERFTt4DQwR/9S1i3Flac//
         Ar5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551747; x=1731156547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R62GHxpMLcqbWJtHlNo45biE4A5QHRMLQkq3r0GrtUU=;
        b=wCFay/hBacbnTTP7sFERuexF2qBKkC3qnDkjXJ2Ti4QJKtv8td/j/oDk1GwU8z+CNF
         pDkf56hWZta/1L0NMb+UAXRlG8GOatE4wlJuzcSaj4ODleCmfs/v0CkG6u41dOW0eYkq
         V6P4NAukib2fqgYD4t800wqTF61rHUSkd+0R584J9UGpTTRmI4PefR/8H8qJOUVjt+xK
         +thMxeeaPJ6YGHA4NLf2FLPSi/TSd4QwNx2JaI0Q1Fbx2cpdpEpWNlAXmJFdIujO6UTc
         TKZM8/L0gimE16Icf+Trq9Gklkms393+j9ns81OkmvhjwV4D6aqTuGAAeNinioGHu/gu
         Jk2w==
X-Forwarded-Encrypted: i=1; AJvYcCUY0LWuYpOuogiV5I+WTqom3pVmZA7Gp7PhXrN5LcPOAxBxTFY2cbKASGmIslyCqaUrqc/j8EVDXTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7smAhNo92vd0zgPNK1vSxvq3oul3Lf8IQUZfXzkjNZPf8AsY
	5Jft7xzzzvwMVIIKql+VdhY272eaJyI9ZRjUX84b6pQDNfcsg+eSFGFCwGE80Q==
X-Google-Smtp-Source: AGHT+IHJ+NvyJqJsm2sd6i7P9lBOMCDJCLw5mFMqxRjQKzc9Q0COhGnO26H8RAbp736bWj9OzK8dVA==
X-Received: by 2002:a17:902:d487:b0:20c:5c6b:2eac with SMTP id d9443c01a7336-21103c8c51fmr134891675ad.49.1730551746899;
        Sat, 02 Nov 2024 05:49:06 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a5ff1sm33417305ad.123.2024.11.02.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:49:06 -0700 (PDT)
Date: Sat, 2 Nov 2024 18:18:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241102124857.dx4hxdjy2jxjmara@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
 <20241102111012.23zwz4et2qkafyca@thinkpad>
 <86jzdl27my.wl-maz@kernel.org>
 <20241102115435.s7oycrh2pjkfhpsu@thinkpad>
 <86ikt52585.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86ikt52585.wl-maz@kernel.org>

On Sat, Nov 02, 2024 at 12:24:42PM +0000, Marc Zyngier wrote:
> On Sat, 02 Nov 2024 11:54:35 +0000,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Sat, Nov 02, 2024 at 11:32:37AM +0000, Marc Zyngier wrote:
> > > On Sat, 02 Nov 2024 11:10:12 +0000,
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > > 
> > > > On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> > > > > Some PCIe host bridges require special handling when enabling or disabling
> > > > > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > > > > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > > > > to identify the source of DMA accesses.
> > > > > 
> > > > > Without this mapping, DMA accesses may target unintended memory, which
> > > > > would corrupt memory or read the wrong data.
> > > > > 
> > > > > Add a host bridge .enable_device() hook the imx6 driver can use to
> > > > > configure the Requester ID to StreamID mapping. The hardware table isn't
> > > > > big enough to map all possible Requester IDs, so this hook may fail if no
> > > > > table space is available. In that case, return failure from
> > > > > pci_enable_device().
> > > > > 
> > > > > It might make more sense to make pci_set_master() decline to enable bus
> > > > > mastering and return failure, but it currently doesn't have a way to return
> > > > > failure.
> > > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > Change from v2 to v3
> > > > > - use Bjorn suggest's commit message.
> > > > > - call disable_device() when error happen.
> > > > > 
> > > > > Change from v1 to v2
> > > > > - move enable(disable)device ops to pci_host_bridge
> > > > > ---
> > > > >  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
> > > > >  include/linux/pci.h |  2 ++
> > > > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
> > > > >  static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > > > >  {
> > > > >  	int err;
> > > > > +	struct pci_host_bridge *host_bridge;
> > > > >  	struct pci_dev *bridge;
> > > > >  	u16 cmd;
> > > > >  	u8 pin;
> > > > > @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > > > >  	if (bridge)
> > > > >  		pcie_aspm_powersave_config_link(bridge);
> > > > >  
> > > > > +	host_bridge = pci_find_host_bridge(dev->bus);
> > > > > +	if (host_bridge && host_bridge->enable_device) {
> > > > > +		err = host_bridge->enable_device(host_bridge, dev);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +	}
> > > > 
> > > > How about wrapping the enable/disable part in a helper?
> > > > 
> > > > 	int pci_host_bridge_enable_device(dev);
> > > > 	void pci_host_bridge_disable_device(dev);
> > > > 
> > > > The definition could be placed in drivers/pci/pci.h as an inline
> > > > function.
> > > 
> > > What does it bring? I would see the point if there was another user.
> > > But this is very much core infrastructure which doesn't lend itself to
> > > duplication.
> > > 
> > > Unless you have something in mind?
> > > 
> > 
> > IMO, it adds a nice encapsulation to help readers understand what this piece of
> > code is all about and also keeps the callers short. Plus the disable helper is
> > reused in both error and pci_disable_device() (if that matters).
> 
> Having an *internal* helper for disable definitely has its use.
> 
> But moving these helpers outside of pci.c opens the door to all sort
> of abuse by making it look like an internal API drivers can use, which
> is absolutely isn't.
> 

Hmm, agree with this part, thanks!

Frank, please keep the helpers in pci.c.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

