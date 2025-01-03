Return-Path: <linux-pci+bounces-19231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E237A00ACD
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 15:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8C21884517
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744B31FA8E9;
	Fri,  3 Jan 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edzXVPeo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADB1FA8DD;
	Fri,  3 Jan 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915562; cv=none; b=TzhR2cxi0y6kQcIhusRBBOeJwCuy2M3TLK2GfCczAOoaoMDRHQi07UB4SZHqMh++vZZpF0XjE4XPZyNg6/8JH+TT2VPGQoBIvJZLcWEyMlfrI5FPdxfDRMEFxLfsphBJ2jtFFrLty549Tq9x1p9KmER7QJUWTy9LcFAMIDhLUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915562; c=relaxed/simple;
	bh=MfVK8HSZs+/BrBxQ1QeZp461yTp5dPXrpsgyNMkk5q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQwX39XEUkroRWw2O8YlE0QLGOFHtQC5Dr4dMt4JD6igiIr/kG/dUAD/1UKlsqLLt9d4iWL36yoR7GxA9jmQWbYih8IA+GDaIAqa35ib/JhVykcPbd4Y88JrclL2ghDyfEgf1iDyjr0IoDOeMY1SQTSyZ1KLbvpkkv8VJMvW0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edzXVPeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF51C4CECE;
	Fri,  3 Jan 2025 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735915561;
	bh=MfVK8HSZs+/BrBxQ1QeZp461yTp5dPXrpsgyNMkk5q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edzXVPeoEnin4dtWT3JZmMhVXMA43QdAN15oHHhjV6Z7/aiQOrLpRbiLQsJr4xXWa
	 fNsNZKqchNrU/5eyNK6KnPDPvv0EPcHOsDF6WQ0RqEiB3wJGVDIs+jfmYgkBKfaL2o
	 y4Uchqz504GnPWTlpMH+2Od7E8yJEN+Zxgu3HbsE+D7bFYOa22lLRNW2ZVzYNEMijO
	 CijlzLvps5e4tKU1XxpHF31p/jofzetZeBZu/B1kbo5xu16hYuNl0Uc54x57KBwH/y
	 UShjRy/sC/RI5mA7sBGq8wdcBuzN2DBCf3DnkFt+9Zrcrr05KjcNK5qL3cviyREquf
	 ejV5wUsOXdUhg==
Date: Fri, 3 Jan 2025 15:45:57 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <Z3f4JQZ6yYV1BJ-b@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <Z3fzad51PIxccDGX@ryzen>
 <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgQEunirUf3O3FJJAUsQu9mQYD_Y40uJ_zMYDZYVy5J=wQ@mail.gmail.com>

On Fri, Jan 03, 2025 at 08:10:17PM +0530, Anand Moon wrote:
> Hi Niklas
> 
> On Fri, 3 Jan 2025 at 19:55, Niklas Cassel <cassel@kernel.org> wrote:
> >
> > Hello Anand,
> >
> > On Fri, Jan 03, 2025 at 07:24:07PM +0530, Anand Moon wrote:
> > >
> > > Thanks for testing this patch.
> > >
> > > This patch should have been tested on hardware that includes all the
> > > relevant controllers,
> > > such as PCI 2.0, PCI 3.0, and the SATA controller.
> > > I will test this patch again on all the Radxa devices I have.
> > >
> > > This patch's dependency lies in deferring the probe until the PHY
> > > controller initializes.
> > >
> > > CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m
> >
> >
> > Note that the splat, as reported in this thread, and in:
> > https://lore.kernel.org/netdev/20250101235122.704012-1-francesco@valla.it/T/
> >
> > is related to the network PHY (CONFIG_REALTEK_PHY) on the RTL8125 NIC,
> > which is connected to one of the PCIe Gen2 controllers, not the PCIe PHY
> > on the PCIe controller (CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY) itself.
> >
> > For the record, I run with all the relevant drivers as built-in:
> > CONFIG_PCIE_ROCKCHIP_DW_HOST=y
> > CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=y (for the PCIe Gen2 controllers)
> > CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y (for the PCIe Gen3 controllers)
> > CONFIG_R8169=y
> > CONFIG_REALTEK_PHY=y
> >
> >
> > >
> > > To my surprise, we have not enabled mdio on Rock-5B boards.
> > > can you check if these changes work on your end?
> >
> > I think these changes are wrong, at least for rock5b.
> 
> We need to enable the GMAC PHY and reset it using the proper GPIO pin
> (PCIE_PERST_L).
> Please refer to the schematic for more details.

The PERST# GPIO is already asserted + deasserted from the PCIe Root Complex
(host) driver:
https://github.com/torvalds/linux/blob/v6.13-rc5/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L191-L206

which will cause the endpoint device (a RTL8125 NIC in this case)
to be reset during bootup.


Kind regards,
Niklas

