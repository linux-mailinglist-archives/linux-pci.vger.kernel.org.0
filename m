Return-Path: <linux-pci+bounces-15841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569F9B9FFF
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 13:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357452820B0
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A26189B9B;
	Sat,  2 Nov 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGTDfj4i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D760A189F2B;
	Sat,  2 Nov 2024 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730550286; cv=none; b=WPKH6oOCfwpZ/hrlDgb8tpzXRQLMhhnqH/PpLxyFlObZva1UMTa9YbrIUZLcxPi2JKTyku2oFT7HWXBrJA2TnP1O3Lo5IABTMO8ROCjiZM3v/0YQPeTEdYLQSx8Htdk7GQGIpNs2BudgmZ46RpdSRKeHpYykmbBDIsxT3NI0Mkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730550286; c=relaxed/simple;
	bh=lFxlMfCCfbEYFC0V+aROouND/5okVB9WvHg6q+rZHF4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QI3iEJsBonw5ADpnQl8LK+Ka7tG/oheC3b+CJyL9BhniVYWz/pNw46L/vCkB/g1HQ8zp1lHbSCN4a/tc26A5fEpqLNB82XABuzCK25EkaUtFlQb5Cd77ElYnt2LQYg+Xvl4ojz6l2YeGtQ9e/f2SkeLsL63hf8a+zZg3coZd8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGTDfj4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5BEC4CEC3;
	Sat,  2 Nov 2024 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730550285;
	bh=lFxlMfCCfbEYFC0V+aROouND/5okVB9WvHg6q+rZHF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mGTDfj4iNlTIaOrnos5WbcOSLa3/dQ/q+NRiQggyBjNwVaN67twdnQJ1pN4v9Oj8K
	 HffClJSbfyDHxPTN2G4bW4ANurMzhYTf7C9IReQtZ+Qs8iLyuslNEd8LJTjSBL6iGP
	 +ZhHHK/2XqnYPziPNvEzbMPKlab6NIJhBQrWHMbgbNdrW/G9Wz9c++A71cdt8axis2
	 YsX9T0LaLXHWgs6zBoyqk5GaUKxyTwaV1+5zqVgjpR63hS2JJ/lAPJszueGGkcudyh
	 OCRdaiC7jaGk5uPg1CAOD1HmGBxYSymmEftDbD8s3m/dvNL001fJtKITlfem9V0Fnv
	 qGfEKmUU2y0gg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1t7DBK-0096Wz-Su;
	Sat, 02 Nov 2024 12:24:42 +0000
Date: Sat, 02 Nov 2024 12:24:42 +0000
Message-ID: <86ikt52585.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>,	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,	Krzysztof =?UTF-8?B?V2lsY3p5?=
 =?UTF-8?B?xYRza2k=?= <kw@linux.com>,	Rob Herring <robh@kernel.org>,	Shawn
 Guo <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,	Fabio Estevam
 <festevam@gmail.com>,	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,	alyssa@rosenzweig.io,	bpf@vger.kernel.org,
	broonie@kernel.org,	jgg@ziepe.ca,	joro@8bytes.org,	lgirdwood@gmail.com,
	p.zabel@pengutronix.de,	robin.murphy@arm.com,	will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device() callbacks for bridges
In-Reply-To: <20241102115435.s7oycrh2pjkfhpsu@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
	<20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
	<20241102111012.23zwz4et2qkafyca@thinkpad>
	<86jzdl27my.wl-maz@kernel.org>
	<20241102115435.s7oycrh2pjkfhpsu@thinkpad>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: manivannan.sadhasivam@linaro.org, Frank.Li@nxp.com, bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org, lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 02 Nov 2024 11:54:35 +0000,
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> On Sat, Nov 02, 2024 at 11:32:37AM +0000, Marc Zyngier wrote:
> > On Sat, 02 Nov 2024 11:10:12 +0000,
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > 
> > > On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> > > > Some PCIe host bridges require special handling when enabling or disabling
> > > > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > > > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > > > to identify the source of DMA accesses.
> > > > 
> > > > Without this mapping, DMA accesses may target unintended memory, which
> > > > would corrupt memory or read the wrong data.
> > > > 
> > > > Add a host bridge .enable_device() hook the imx6 driver can use to
> > > > configure the Requester ID to StreamID mapping. The hardware table isn't
> > > > big enough to map all possible Requester IDs, so this hook may fail if no
> > > > table space is available. In that case, return failure from
> > > > pci_enable_device().
> > > > 
> > > > It might make more sense to make pci_set_master() decline to enable bus
> > > > mastering and return failure, but it currently doesn't have a way to return
> > > > failure.
> > > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > > Change from v2 to v3
> > > > - use Bjorn suggest's commit message.
> > > > - call disable_device() when error happen.
> > > > 
> > > > Change from v1 to v2
> > > > - move enable(disable)device ops to pci_host_bridge
> > > > ---
> > > >  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
> > > >  include/linux/pci.h |  2 ++
> > > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
> > > >  static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > > >  {
> > > >  	int err;
> > > > +	struct pci_host_bridge *host_bridge;
> > > >  	struct pci_dev *bridge;
> > > >  	u16 cmd;
> > > >  	u8 pin;
> > > > @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > > >  	if (bridge)
> > > >  		pcie_aspm_powersave_config_link(bridge);
> > > >  
> > > > +	host_bridge = pci_find_host_bridge(dev->bus);
> > > > +	if (host_bridge && host_bridge->enable_device) {
> > > > +		err = host_bridge->enable_device(host_bridge, dev);
> > > > +		if (err)
> > > > +			return err;
> > > > +	}
> > > 
> > > How about wrapping the enable/disable part in a helper?
> > > 
> > > 	int pci_host_bridge_enable_device(dev);
> > > 	void pci_host_bridge_disable_device(dev);
> > > 
> > > The definition could be placed in drivers/pci/pci.h as an inline
> > > function.
> > 
> > What does it bring? I would see the point if there was another user.
> > But this is very much core infrastructure which doesn't lend itself to
> > duplication.
> > 
> > Unless you have something in mind?
> > 
> 
> IMO, it adds a nice encapsulation to help readers understand what this piece of
> code is all about and also keeps the callers short. Plus the disable helper is
> reused in both error and pci_disable_device() (if that matters).

Having an *internal* helper for disable definitely has its use.

But moving these helpers outside of pci.c opens the door to all sort
of abuse by making it look like an internal API drivers can use, which
is absolutely isn't.

	M.

-- 
Without deviation from the norm, progress is not possible.

