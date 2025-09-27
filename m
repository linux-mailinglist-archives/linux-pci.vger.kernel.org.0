Return-Path: <linux-pci+bounces-37155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCDBA58AD
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 05:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2C8326FCD
	for <lists+linux-pci@lfdr.de>; Sat, 27 Sep 2025 03:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497631C8603;
	Sat, 27 Sep 2025 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afLb2RSq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1307F18DF8D;
	Sat, 27 Sep 2025 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758945174; cv=none; b=eA9KZpbAxExoMPwATXNUq6tvHreuhHQwSjf5xWIKIpHb2mK7uU88YLwegJsy/OCLaOX8waj7MKWy7xbHySeZrB3i/pp2wrZwQgpwo/W3p6I7O7KZN4ilTObfUm7dmv89LBfk6RfNRa3SrFV31KxIzl+jzHIjoT4RHRUrcxw9iVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758945174; c=relaxed/simple;
	bh=W/z5cqAffsitkvS3CbuGOrlcjmQu/FBVIDqgLsCp8p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3QSen6//xwP3tm9wYg8DKckyd22OHNEWBImx6yznPS7/um6PjrtJIHczgyZf1RoREi0vh5d7IVI31B1xmw2lCwTGg+S1mzsve1eZ3C2LCkqGuOqPeaptIlcH8hScC9P2tBVNICOtApLbsWBsQhQ8l05WQ5W/qpnvrDbYjqJato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afLb2RSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACF4C4CEE7;
	Sat, 27 Sep 2025 03:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758945173;
	bh=W/z5cqAffsitkvS3CbuGOrlcjmQu/FBVIDqgLsCp8p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afLb2RSqGIIpgahmXAMZRfTysN7c1Dd/ZiZIsaQk5XOLHULfcAdf4deyC2gcAOHfx
	 BWgtesSCx/m/1oPyP18AO7ij+rcOpqM7jaDuyOGijs3UY9j6G3NswqLY5WsPcqk2PA
	 SIZ2JesLIyC30hmZP5h90FESCR1VIwjaS/0xy+9gXZDqhbr0qMAOjjgIoG57x0pw92
	 /qucid6M0/DYR3toxdvqvMh9HWbvrFtRJtCIwNa/oXPTiwfNkwLej/iKwBfOsLR1Gg
	 mViNAN8nqAlZSheI95C2THZMAGXjxGnLvzHnIPsPu4lzwdZnasycb4bORvZFdiYRsb
	 JjKXwMSmipjEQ==
Date: Sat, 27 Sep 2025 09:22:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chaitanya chundru <quic_krichai@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com, 
	amitk@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Message-ID: <3tuxxskusi5ck7cu2nqfkilqdqvzqjy77qgpvuo4nhcugdebug@geqxeslmxmdr>
References: <4a3f9494-27a2-47d6-bdef-0b1bcbd99903@oss.qualcomm.com>
 <20250926203916.GA2266029@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250926203916.GA2266029@bhelgaas>

On Fri, Sep 26, 2025 at 03:39:16PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 26, 2025 at 07:09:17PM +0530, Krishna Chaitanya Chundru wrote:
> > On 9/25/2025 10:55 PM, Bjorn Helgaas wrote:
> > > On Thu, Sep 25, 2025 at 09:49:16PM +0530, Manivannan Sadhasivam wrote:
> > > > On Thu, Sep 25, 2025 at 09:54:16AM -0500, Bjorn Helgaas wrote:
> > > > > On Thu, Aug 28, 2025 at 05:39:02PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > > Implement stop_link() and  start_link() function op for dwc drivers.
> > > > > > 
> > > > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > > > ---
> > > > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
> > > > > >   1 file changed, 18 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
> > > > > >   }
> > > > > >   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
> > > > > > +static int dw_pcie_op_start_link(struct pci_bus *bus)
> > > > > > +{
> > > > > > +	struct dw_pcie_rp *pp = bus->sysdata;
> > > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > +
> > > > > > +	return dw_pcie_host_start_link(pci);
> > > > > 
> > > > > This takes a pci_bus *, which could be any PCI bus, but this only
> > > > > works for root buses because it affects the link from a Root Port.
> > > > > 
> > > > > I know the TC9563 is directly below the Root Port in the current
> > > > > topology, but it seems like the ability to configure a Switch with
> > > > > I2C or similar is potentially of general interest, even if the
> > > > > switch is deeper in the hierarchy.
> > > > > 
> > > > > Is there a generic way to inhibit link training, e.g., with the
> > > > > Link Disable bit in the Link Control register?  If so, this could
> > > > > potentially be done in a way that would work for any vendor and
> > > > > for any Downstream Port, including Root Ports and Switch
> > > > > Downstream Ports.
> > > > 
> > > > FWIW, the link should not be stopped for a single device, since it
> > > > could affect other devices in the bus. Imagine if this switch is
> > > > connected to one of the downstream port of another switch. Then
> > > > stopping and starting the link will affect other devices connected
> > > > to the upstream switch as well.
> > > 
> > > Link Disable would affect all devices downstream of the bridge where
> > > it is set, same as dw_pcie_op_stop_link().
> > > 
> > > > This driver is doing it right now just because, there is no other
> > > > way to control the switch state machine. Ideally, we would want the
> > > > PERST# to be in asserted stage to keep the device from starting the
> > > > state machine, then program the registers over I2C and deassert
> > > > PERST#. This will work across all of the host controller drivers (if
> > > > they support pwrctrl framework).
> > > 
> > > I don't think there's a way to implement .start_link() and
> > > .stop_link() for ACPI unless it's by using Link Disable, which is why
> > > I asked about this.  If Link Disable *does* work, it would be a very
> > > generic way to do this because it's part of the PCIe base spec.
> > 
> > We did test as you suggested but unfortunately the setting are not
> > getting reflected we need to explicitly assert perst to make sure
> > pcie is in reset state while applying these settings.
> 
> Maybe ".stop_link()" is the wrong name if what's actually required is
> PERST#?
> 

If we rename this callback to foo_perst(), then it will be similar to my Pwrctrl
PERST# integration series [1]. I'm wondering why shouldn't we merge it instead
and get rid of this callback from this series for good?

- Mani

[1] https://lore.kernel.org/linux-pci/20250912-pci-pwrctrl-perst-v3-0-3c0ac62b032c@oss.qualcomm.com/

-- 
மணிவண்ணன் சதாசிவம்

