Return-Path: <linux-pci+bounces-37018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5A1BA0D37
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 19:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9A33B1F39
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E638830CD95;
	Thu, 25 Sep 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkwYG/vU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7196217704;
	Thu, 25 Sep 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821119; cv=none; b=OabjhWRgoZu1+X+hKH/9Ya7XyIMDK2HSMT5bXew5SS/3xvoUQI3MCD1vR77Yyb9fAp3U+sDXNlnWxQMLBx6OZNk9CHjPJJCYzzXsVk9FJhVrCwhZKQw3l9+yNZiqhmvonoEyoy5izGbG7hUvCDd35i9PIsNRgOiz57xFLNVFJqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821119; c=relaxed/simple;
	bh=vdDtnd7eralUvO1XlLeDfYnMfW2wY9yiVB9StQbyH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cSHLXtB6pTdZGGuvJ4/zqsd2M5ne+IC5KzDnLmTNnF4SYuUs0x0PFy3VYEhA4TJf56ObSGuLEFpCRZvVW3uixcM4velkYapmy2narCNeqNVzl5joC3agYVD4e/Amlc5oSfEzGEWwYdvbPUPKpWkkHc1x1Utmtm6ZDqQpTPkSPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkwYG/vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF0C4CEF0;
	Thu, 25 Sep 2025 17:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758821119;
	bh=vdDtnd7eralUvO1XlLeDfYnMfW2wY9yiVB9StQbyH5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lkwYG/vUo/EzJ1jKlWOOEn0aUxEoQ862XOvuqFQ1HWIWXVCw8SLuwWFk4Fx7INazg
	 AYxo/tvw14FhUtCBX+5CzFGq5H8eG0qu7nk+QpdwPBzV6YlVt/Fivwrs25d2uisYZA
	 LXv4LQr6Q7yfS3zg3wG8Eu/JsXLyuQurV9HquIahNtTZ0Wm+vCI0BUTRXZasvWNvOj
	 GaSOYG1/rqSFThGrnD2AqDnGj78ARhBTvhJ6DX84WQ0L2+NubSUymF2znFkLIY+SbF
	 M7zqNIZqk4GuJ/HEedGgXWBInI8ICSRT0nk5HRIXSOvRG/epW6AglVRqX/fQk7cB6i
	 8kMkZJC0QZuaQ==
Date: Thu, 25 Sep 2025 12:25:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Message-ID: <20250925172517.GA2169496@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yofmk5uyykyv4jxzem622dtuyzknk7ipd5xlkzdrfl5v7tgojy@5aarg5wj6bar>

On Thu, Sep 25, 2025 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Sep 25, 2025 at 09:54:16AM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 28, 2025 at 05:39:02PM +0530, Krishna Chaitanya Chundru wrote:
> > > Implement stop_link() and  start_link() function op for dwc drivers.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
> > >  
> > > +static int dw_pcie_op_start_link(struct pci_bus *bus)
> > > +{
> > > +	struct dw_pcie_rp *pp = bus->sysdata;
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +
> > > +	return dw_pcie_host_start_link(pci);
> > 
> > This takes a pci_bus *, which could be any PCI bus, but this only
> > works for root buses because it affects the link from a Root Port.
> > 
> > I know the TC9563 is directly below the Root Port in the current
> > topology, but it seems like the ability to configure a Switch with
> > I2C or similar is potentially of general interest, even if the
> > switch is deeper in the hierarchy.
> > 
> > Is there a generic way to inhibit link training, e.g., with the
> > Link Disable bit in the Link Control register?  If so, this could
> > potentially be done in a way that would work for any vendor and
> > for any Downstream Port, including Root Ports and Switch
> > Downstream Ports.
> 
> FWIW, the link should not be stopped for a single device, since it
> could affect other devices in the bus. Imagine if this switch is
> connected to one of the downstream port of another switch. Then
> stopping and starting the link will affect other devices connected
> to the upstream switch as well.

Link Disable would affect all devices downstream of the bridge where
it is set, same as dw_pcie_op_stop_link().

> This driver is doing it right now just because, there is no other
> way to control the switch state machine. Ideally, we would want the
> PERST# to be in asserted stage to keep the device from starting the
> state machine, then program the registers over I2C and deassert
> PERST#. This will work across all of the host controller drivers (if
> they support pwrctrl framework).

I don't think there's a way to implement .start_link() and
.stop_link() for ACPI unless it's by using Link Disable, which is why
I asked about this.  If Link Disable *does* work, it would be a very
generic way to do this because it's part of the PCIe base spec.

Bjorn

