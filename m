Return-Path: <linux-pci+bounces-31172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0992DAEF99C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 15:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB4A4E1122
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E92274676;
	Tue,  1 Jul 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPKMZ/wa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D593273D76
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374924; cv=none; b=DkCM8u1CYPLT9U2mGV0ewiATGdpR++L2/TA9vSLsDjcYqHDeXIDjXwdFtmNbB3LKRxPuJAP/xNBuPP7PfevO2idqxG5aTpConqzZIADEHVbbrCnsRv8zBnzEqvx98SvHdrGXJan2JWvs4jgVyxRV26QugMUekvGgKgMLsYBR9Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374924; c=relaxed/simple;
	bh=blDez+URtrrsfNGy/XxiJMPJAphGMgIC/F4Dj0mxMR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwK6lo0eYD3uWviWRjMmjvQYSpk4GOPShCejFPstPBPG6dH1fk6hsyhSpTZtRPjR5MoHYCugMMC07SpQ2fWdicgjmEkX8BpBCj/xnA2torX3yYe+xcHUaLgUgdB3RHU+S/Ytra2lWDCb7VVfDu75S1ddW97FXahk1jA0Uwqv+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPKMZ/wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C50C4CEEB;
	Tue,  1 Jul 2025 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751374924;
	bh=blDez+URtrrsfNGy/XxiJMPJAphGMgIC/F4Dj0mxMR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPKMZ/wab08OBNBONnN1+9j7+I4rZ7vFVLHw/kHS9dd1uNrC1rF3kL2nJ7I7o719Q
	 f8I+iFf17UDNXc4VsPlu0JShHQXzCFj3XYJ4C3d1TPj6zfWfesm1LkY1VItgBH0rpy
	 iXOf0WMHG7MLUpMG/QWB41IiJrfCFNULTgu8ZTGyEea1b7mDddkGnQaE6Q9rHiqaOx
	 FdSpi9/3KwgZvKUS258iAKld8tA2uSZs53hXZtoLAZLFzb6t2ljJ7g0IuRWL4WQB0A
	 HHEz664bC8Z9shywyBOKDwd9KdPHNTAIh18EF8NfdFXo7SwAn/W5ABYMHgh8TfUTUz
	 UHPCg15wO3izg==
Date: Tue, 1 Jul 2025 18:31:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
References: <20250625102347.1205584-14-cassel@kernel.org>
 <20250630201902.GA1798294@bhelgaas>
 <aGPMv8ny9+2wm7pY@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGPMv8ny9+2wm7pY@x1-carbon>

On Tue, Jul 01, 2025 at 01:55:43PM GMT, Niklas Cassel wrote:
> Hello Bjorn, Mani,
> 
> On Mon, Jun 30, 2025 at 03:19:02PM -0500, Bjorn Helgaas wrote:
> > On Wed, Jun 25, 2025 at 12:23:51PM +0200, Niklas Cassel wrote:
> > > As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> > > greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> > > training completes before sending a Configuration Request.
> > > 
> > > Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> > > up. The delay will only be performed in the success case where the link
> > > came up.
> > > 
> > > DWC glue drivers that have a link up IRQ (drivers that set
> > > use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> > > perform this delay in their threaded link up IRQ handler.
> > > 
> > > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > > Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 4d794964fa0f..053e9c540439 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -714,6 +714,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> > >  		return -ETIMEDOUT;
> > >  	}
> > >  
> > > +	/*
> > > +	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> > > +	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> > > +	 * after Link training completes before sending a Configuration Request.
> > > +	 */
> > > +	if (pci->max_link_speed > 2)
> > > +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> > 
> > Sec 6.6.1 also requires "100 ms following exit from a Conventional
> > Reset before sending a Configuration Request to the device immediately
> > below that Port" for Downstream Ports that do *not* support Link
> > speeds greater than 5.0 GT/s.
> > 
> > Where does that delay happen?
> 
> Argh...
> 
> In version 3 of this series, the wait was unconditional, so it handled both
> cases:
> https://lore.kernel.org/linux-pci/20250613124839.2197945-13-cassel@kernel.org/
> 
> But I got a review comment from Mani:
> https://lore.kernel.org/linux-pci/hmkx6vjoqshthk5rqakcyzneredcg6q45tqhnaoqvmvs36zmsk@tzd7f44qkydq/
> 
> That I should only care about the greater than 5.0 GT/s case.
> 
> Perhaps the confusion came about since the comment only mentioned one of the
> two the cases specified by PCIe r6.0, sec 6.6.1.
> 

Yes, that was intentional since the DWC core code only deals with the link up
and not PERST# (which is handled by the glue drivers).

> So I think the best thing is either (on top of pci/next):
> 

No. The PERST# delay should be handled by the glue drivers since they are the
ones controlling the PERST# line. Doing an unconditional wait for both the
cases in DWC core, seems wrong to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

