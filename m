Return-Path: <linux-pci+bounces-43756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B1CDF46A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 05:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 406B43008885
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 04:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FEE2417F2;
	Sat, 27 Dec 2025 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNQW9Z98"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FA199E89;
	Sat, 27 Dec 2025 04:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766811509; cv=none; b=KEWXEHjpx/JsFgtSr7RBEHn18ItysyfY+/EMaMU+vy3YhRmw+b9auZS155yG06TX52X0UuzCvwMBiS1PVL4kbFkPHVX+3pCU8RBI9443PTDjvBrB69g+MRYiL6cQPq54WeNM15XSgOzfhnZCrgwp/fn02zK1U4huEtoaY7hHNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766811509; c=relaxed/simple;
	bh=tcLUI5UY++KkdVuVgdeQjDsSF5LTTJeX7voGTUcPpu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it7FQ1FLQhmjgFlXKLTPgoWdsjMiaf0eacQmlN0LPntqXkbc5bjOR0iNhP0bK+MEFiEjqNmFeO4dCcYEHbJQozcmAQqcUvCT9jpLGa0nY4wmiLEz69G8z2QSFF5JZHXXstzxSemZ2WeoHGrbUcLBen9EcOZLo7w8VwM0JDd4/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNQW9Z98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6E5C4CEF1;
	Sat, 27 Dec 2025 04:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766811508;
	bh=tcLUI5UY++KkdVuVgdeQjDsSF5LTTJeX7voGTUcPpu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNQW9Z98szYm11CBjrdPZkbmOEoM8dF/SaCC50D3XeS4cJyggJtFWZq4V3fTzddph
	 ZS75BNNF8i15tQRIIKcwrH6+IZGPXD11h6oWFXj1XdD+OJlV3dCxlDy5yVe0znw2lD
	 bu4R5KYBf+70TvwlcVNjUsogWG5187qW5qDbI+LsQO6FIdTsGcYJU+UMNinCKh1WyK
	 FuTJsqxIm4reTHkMW/YGuR7kykDF6IdbjlpsbocgT0I79/+S/cv/ushOk0tsFXvxln
	 jMKwrgARlOSXwYdJQYRVyZu7ahyTmbih4V/QOCC2xLFmmR2WWaP7ibhDFwJ4TPjwhU
	 ajXXKOUm4/bXw==
Date: Sat, 27 Dec 2025 10:28:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: dwc: Remove MSI/MSIX capability if iMSI-RX is
 used as MSI controller
Message-ID: <cpv4b2d2uxdefxjhequj77y4bizsghmmcmkseksitzrwhr3a5b@3f77unlrpwcr>
References: <7d4xj3tguhf6yodhhwnsqp5s4gvxxtmrovzwhzhrvozhkidod7@j4w2nexd5je2>
 <20251226212529.GA4142038@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251226212529.GA4142038@bhelgaas>

On Fri, Dec 26, 2025 at 03:25:29PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 20, 2025 at 10:30:41PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Nov 20, 2025 at 10:06:03PM +0800, Shawn Lin wrote:
> > > 在 2025/11/10 星期一 14:59, Qiang Yu 写道:
> > > > Some platforms may not support ITS (Interrupt Translation Service) and
> > > > MBI (Message Based Interrupt), or there are not enough available empty SPI
> > > > lines for MBI, in which case the msi-map and msi-parent property will not
> > > > be provided in device tree node. For those cases, the DWC PCIe driver
> > > > defaults to using the iMSI-RX module as MSI controller. However, due to
> > > > DWC IP design, iMSI-RX cannot generate MSI interrupts for Root Ports even
> > > > when MSI is properly configured and supported as iMSI-RX will only monitor
> > > > and intercept incoming MSI TLPs from PCIe link, but the memory write
> > > > generated by Root Port are internal system bus transactions instead of
> > > > PCIe TLPs, so they are ignored.
> 
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -1083,6 +1083,16 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > > >   	dw_pcie_dbi_ro_wr_dis(pci);
> > > > +	/*
> > > > +	 * If iMSI-RX module is used as the MSI controller, remove MSI and
> > > > +	 * MSI-X capabilities from PCIe Root Ports to ensure fallback to INTx
> > > > +	 * interrupt handling.
> > > > +	 */
> > > > +	if (pp->has_msi_ctrl) {
> > > 
> > > Isn't has_msi_ctrl means you have something like GIC-ITS
> > > support instead of iMSI module? Am I missing anything?
> > 
> > It is the other way around. Presence of this flag means, iMSI-RX is
> > used. But I think the driver should clear the CAPs irrespective of
> > this flag.
> 
> I didn't see any response to this.

Shawn did respond to my comment:
https://lore.kernel.org/linux-pci/3ac0d6c5-0c49-45fd-b855-d9b040249096@rock-chips.com/

>  Is there a case where we want to
> preserve these capabilities?  To ask another way, is there some
> platform where DWC-based Root Ports can generate MSIs themselves?
> 

Unless the DWC controller implements a custom internal MSI controller (if it
does then dw_pcie_host_ops::msi_init() callback will be populated), Root Port
MSIs cannot be received. This series did exclude only one of those platforms,
pci-keystone by skipping capability removal if 'dw_pcie_rp::has_msi_ctrl' is
set.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

