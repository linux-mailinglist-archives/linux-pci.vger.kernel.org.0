Return-Path: <linux-pci+bounces-30594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16746AE7B5B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4641BC7B34
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 09:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80771287507;
	Wed, 25 Jun 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PURLJeKx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B821286422
	for <linux-pci@vger.kernel.org>; Wed, 25 Jun 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842162; cv=none; b=RzNNdf50rqVQ3jYvgsWIBLdqcwHRZexB7j7q97fev4HuRSwPrqhJDsclNLyHwmL4TAVADGPTizWDv++o1SYrzefwa57x84a6890oee50u4LkVR0h1yMWcnQ5RE/L1ZKRHFD6Bl8XPxxLDZoxly0C5/zrOsh0i4M00E3m0oQ8cV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842162; c=relaxed/simple;
	bh=eI4HE4VJPF3TGby+cUaEhfeWOdhJ6LfqpatKd/xLTuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHN6qt+lYqp5nHW2SWJ8CawVU+dl6g0dkcbqy7VAZaAU9TCeWko0K/bGH2+6T0aw4iY8743ymucLXsax5G+7yCXKiqtvcEpKzXe6dgX9w7z0qrWcWbNEXAR1sxPiqkJxFt8sEyPZ7nQr9g7Qw1+oNNG/76W8djvHNg2A0bdIf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PURLJeKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67E7C4CEEA;
	Wed, 25 Jun 2025 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842162;
	bh=eI4HE4VJPF3TGby+cUaEhfeWOdhJ6LfqpatKd/xLTuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PURLJeKxxXmI6ve2knKVedg6Lo3H12K2Ux+bUHKEJy2X9ZbUGGEJVGqg/NdyZ9jRk
	 GK+xH+osjI3p9xhRG6H+V1W8tW+cIEa3su6yIVyYLIHAyqFU+oPDIyIB13y5LK8NOw
	 nwJPk8Qd5vctloI2J843pgcQUu2C2YokhplS4iVYuQGNMlAnXUApkpjnqHPIZ1xtSR
	 CVuLmhdTNGE7KJYZuYNVAo6JFEdJlX78F/8JzGBnGFAhQNwbm8iVkbaxG2XyjpLeFp
	 c4GlN9Xw76hJFbP++PXhU1kgmpLM7AoJ7GGVICt8TBGslTVigoFOXCTZMCxwvNN9t+
	 p9l7T+qt4HUbg==
Date: Wed, 25 Jun 2025 11:02:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 6/6] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Message-ID: <aFu7LSidSk9NB0Ey@ryzen>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-14-cassel@kernel.org>
 <fpnu2jymgzicr23fygizjg3jnaddrzjorvtsgyzxiy25umurhq@yovbbyx36ibv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fpnu2jymgzicr23fygizjg3jnaddrzjorvtsgyzxiy25umurhq@yovbbyx36ibv>

On Mon, Jun 23, 2025 at 08:52:24AM -0600, Manivannan Sadhasivam wrote:
> On Fri, Jun 13, 2025 at 02:48:45PM +0200, Niklas Cassel wrote:
> > There is no reason for the delay, in each loop iteration, while polling for
> > link up (LINK_WAIT_SLEEP_MS), to be so long as 90 ms.
> > 
> > PCIe r6.0, sec 6.6.1, still require us to wait for up to 1.0 s for the link
> > to come up, thus the number of retries (LINK_WAIT_MAX_RETRIES) is increased
> > to keep the total timeout to 1.0 s.
> > 
> > PCIe r6.0, sec 6.6.1, also mandates that there is a 100 ms delay, after the
> > link has been established, before performing configuration requests (this
> > delay already exists in dw_pcie_wait_for_link() and is unchanged).
> > 
> > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c |  6 +++++-
> >  drivers/pci/controller/dwc/pcie-designware.h | 13 +++++++++----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 24903f67d724..ae6f0bfe3c56 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -701,7 +701,11 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  	u32 offset, val;
> >  	int retries;
> >  
> > -	/* Check if the link is up or not */
> > +	/*
> > +	 * Check if the link is up or not. As per PCIe r6.0, sec 6.6.1, software
> > +	 * must allow at least 1.0 s following exit from a Conventional Reset of
> > +	 * a device, before determining that the device is broken.
> > +	 */
> >  	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> >  		if (dw_pcie_link_up(pci))
> >  			break;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index ce9e18554e42..b225c4f3d36a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -62,11 +62,16 @@
> >  #define dw_pcie_cap_set(_pci, _cap) \
> >  	set_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> >  
> > -/* Parameters for the waiting for link up routine */
> > -#define LINK_WAIT_MAX_RETRIES		10
> > -#define LINK_WAIT_SLEEP_MS		90
> > +/*
> > + * Parameters for waiting for a link to be established. As per PCIe r6.0,
> > + * sec 6.6.1, software must allow at least 1.0 s following exit from a
> > + * Conventional Reset of a device, before determining that the device is broken.
> > + * Therefore LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS should equal 1.0 s.
> > + */
> > +#define LINK_WAIT_MAX_RETRIES		100
> > +#define LINK_WAIT_SLEEP_MS		10
> 
> These are not DWC specific. So I'd recommend moving it to drivers/pci/pci.h.

The total time to wait (LINK_WAIT_MAX_RETRIES * LINK_WAIT_SLEEP_MS) is not DWC
specific.

However, that we choose to wait 10 ms between polls is definitely DWC specific.

But sure, I can move these to drivers/pci/pci.h.


Kind regards,
Niklas

