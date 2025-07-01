Return-Path: <linux-pci+bounces-31184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006D2AF0005
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 18:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3BB441988
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB26275103;
	Tue,  1 Jul 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omjpJGXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478011A8401
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751387926; cv=none; b=Y9R40BtsOvIdx4mGBVQhVXDSu77rgzKwVK19r9WGLtI/yaHQDS78490J1FsCgtHiNjFV9YkGg2xUFRydF98Sg2c6b5FKjzVSV40+3nPmcYuAn9B5EBKZ9Z3tgRgRSUyKiW3YjPhSNMxLPvYEcagutnWKhE41rp2PHGbBUuM/KxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751387926; c=relaxed/simple;
	bh=oSKqQZCr7XF7kFBRiv5QEbxz6R+Cc+UHzbz1RMW3ENY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=d3e65W+k8t6QdFiVWb2ISVX277URWVp689GqXRcPXpHvG1T/jKXC2couXemgszRMeXuzsImXttzSt6st0DLLnwwul8XWxY/4QB04lW2+FvoACGt/0myb4gboMlWVwcyWtnAOptFcYykgQKYoIWoxGjp3Cj2RsskYUYB/DcqzDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omjpJGXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6347C4CEEB;
	Tue,  1 Jul 2025 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751387925;
	bh=oSKqQZCr7XF7kFBRiv5QEbxz6R+Cc+UHzbz1RMW3ENY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=omjpJGXwCyyQTh+YD0BpA+exIO25WGqyJILwEsNcpX/oznTYPb8+THjr5S30ViEmi
	 UfXbghvV11Itwx6+tsM7QoMlEg7mAXl/2QHSYeGyEkuejnT8t9/iUpP51Pt7LATIBD
	 ZYXqHJIAoiEzqkHBCgEs8EeNW2Rr1xu8p3Wpw7gti3kza9WxWQyEhTaH2n2l4fNLNY
	 2g+qe8vm7a1WphhCD0ESXqTIlHEz5xlkU27jk9f7CLwiDtubJkT9aOLfpepKHlPLGg
	 z56sROlfGRDfpIKozT7i3uevGSPVavwszuIViEEsFFZywkdR7MXFTChXLajqGPKi6P
	 QVTAwk6eWilMw==
Date: Tue, 1 Jul 2025 11:38:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <20250701163844.GA1836602@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>

On Tue, Jul 01, 2025 at 06:31:50PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 01, 2025 at 01:55:43PM GMT, Niklas Cassel wrote:
> > On Mon, Jun 30, 2025 at 03:19:02PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jun 25, 2025 at 12:23:51PM +0200, Niklas Cassel wrote:
> > > > As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> > > > greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> > > > training completes before sending a Configuration Request.
> > > > 
> > > > Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> > > > up. The delay will only be performed in the success case where the link
> > > > came up.
> > > > 
> > > > DWC glue drivers that have a link up IRQ (drivers that set
> > > > use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> > > > perform this delay in their threaded link up IRQ handler.
> > > > 
> > > > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > > > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 4d794964fa0f..053e9c540439 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -714,6 +714,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > > >  		return -ETIMEDOUT;
> > > >  	}
> > > >  
> > > > +	/*
> > > > +	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> > > > +	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > > > +	 * after Link training completes before sending a Configuration Request.
> > > > +	 */
> > > > +	if (pci->max_link_speed > 2)
> > > > +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > > 
> > > Sec 6.6.1 also requires "100 ms following exit from a Conventional
> > > Reset before sending a Configuration Request to the device immediately
> > > below that Port" for Downstream Ports that do *not* support Link
> > > speeds greater than 5.0 GT/s.
> > > 
> > > Where does that delay happen?
> > 
> > Argh...
> > 
> > In version 3 of this series, the wait was unconditional, so it handled both
> > cases:
> > https://lore.kernel.org/linux-pci/20250613124839.2197945-13-cassel@kernel.org/
> > 
> > But I got a review comment from Mani:
> > https://lore.kernel.org/linux-pci/hmkx6vjoqshthk5rqakcyzneredcg6q45tqhnaoqvmvs36zmsk@tzd7f44qkydq/
> > 
> > That I should only care about the greater than 5.0 GT/s case.
> > 
> > Perhaps the confusion came about since the comment only mentioned
> > one of the two the cases specified by PCIe r6.0, sec 6.6.1.
> 
> Yes, that was intentional since the DWC core code only deals with
> the link up and not PERST# (which is handled by the glue drivers).
> 
> > So I think the best thing is either (on top of pci/next):
> 
> No. The PERST# delay should be handled by the glue drivers since
> they are the ones controlling the PERST# line. Doing an
> unconditional wait for both the cases in DWC core, seems wrong to
> me.

It ends up being a little bit weird that the delay is in the DWC core
(dw_pcie_wait_for_link()) for ports that support fast links, and in
the glue drivers otherwise.  It would be easier to verify and maintain
if the delay were always in the DWC core.

If we had a dw_pcie_host_ops callback for PERST# deassertion, the
delay could be in the DWC core, but I don't know if there's enough
consistency across drivers for that to be practical.

And of course, we also have the "Link-up IRQ" drivers where the delay
is currently in the glue, although I could imagine a DWC core API that
includes both the delay and the lock/rescan logic.

I feel a little bit exposed here because none of the glue drivers
include this delay for slow ports.

Bjorn

