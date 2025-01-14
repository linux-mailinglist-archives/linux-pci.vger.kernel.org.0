Return-Path: <linux-pci+bounces-19788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19424A11542
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B111631A8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452F5215798;
	Tue, 14 Jan 2025 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZajQZdj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18089232429;
	Tue, 14 Jan 2025 23:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896783; cv=none; b=IqjpyLTv8EaTgBIejSr3eLyh/nIAHSfMQ4IFiHqi9bFCh7P80JmgbqQpnL/68S71NMtpY8leAZN0aby3RX4fWssBd/UiIyHdsU5xSyZqAWvCjvEF6e2hE3hUIpqITjLZ7eKSj/GvgnI+9bjjWZQcxP3wyucmE0WtlXEpuHHfpyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896783; c=relaxed/simple;
	bh=L6B6WDszISMt6Ham4nV/TMXvAl8fXJGFrEuTt4xWNE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NuXDRqk486lfjKWy1W+6zoQ9yF51ZiTgnPuTutfQgq0PLgKdxtULLnUzAxmhL9WvNpnzst0aI3I5FS01jp5MUIlZ3vQxQmxwABQiHucITQvOGL5mEi+nv9cWMhxoDKlA78eZGRSFwNvto9EEGjh+1yD+0A/Q+SJTjzQ1S0QsmEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZajQZdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EBDC4CEDD;
	Tue, 14 Jan 2025 23:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736896780;
	bh=L6B6WDszISMt6Ham4nV/TMXvAl8fXJGFrEuTt4xWNE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SZajQZdjOwBfNi9tg2ujzMMljXGL40t9RiHvJVDGaWNYPa8w6nLKeO3RTQIaF5Y3c
	 5GgkzXTxe/fwKz+0MINkN6Rx2fDI9waCP1p4rKbJzrRVaf5tBkOOIWPNx2O2y30eiW
	 aHBnafdqCP+XcAkyw5N697QUaVxvox7UjcTATXmos8mOpWBRfKZR8PIfDUNzLwa5CZ
	 T8DJSJfDrZWzcXEUbkNgi8Z37teAOsyxON2ckbhZ1WfKKF0kvGtnWSkXiKfaQx+qAP
	 toHISZ3fERNW2HY+zz6xNG+/IKy0SzD23WCNF59Bv9dyX09m0iGLw4F5Tpy/QWmwQ7
	 8++o9Z2NqLM0Q==
Date: Tue, 14 Jan 2025 17:19:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: daire.mcnamara@microchip.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, conor.dooley@microchip.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
	kevin.xie@starfivetech.com
Subject: Re: [PATCH v10 0/3] Fix address translations on MPFS PCIe controller
Message-ID: <20250114231939.GA496825@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-espresso-display-846f670d2088@spud>

On Tue, Jan 14, 2025 at 05:16:10PM +0000, Conor Dooley wrote:
> Hey folks,
> 
> Has this patchset fallen through the cracks?

Yes, unfortunately.  I applied it to pci/controller/microchip for
v6.14.

I had to adapt it slightly to account for the changes of ac7f53b7e728
("PCI: microchip: Add support for using either Root Port 1 or 2"), so
please take a look and make sure I did it right.

> On Wed, Nov 13, 2024 at 11:50:44AM +0000, Conor Dooley wrote:
> > On Fri, Oct 11, 2024 at 03:00:40PM +0100, daire.mcnamara@microchip.com wrote:
> > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > 
> > > Hi all,
> > > 
> > > On Microchip PolarFire SoC (MPFS), the PCIe controller is connected to the
> > > CPU via one of three Fabric Interface Connectors (FICs).  Each FIC present
> > > to the CPU complex as 64-bit AXI-M and 64-bit AXI-S.  To preserve
> > > compatibility with other PolarFire family members, the PCIe controller is
> > > connected to its encapsulating FIC via a 32-bit AXI-M and 32-bit AXI-S
> > > interface.
> > > 
> > > Each FIC is implemented in FPGA logic and can incorporate logic along its 64-bit
> > > AXI-M to 32-bit AXI-M chain (including address translation) and, likewise, along
> > > its 32-bit AXI-S to 64-bit AXI-S chain (again including address translation).
> > > 
> > > In order to reduce the potential support space for the PCIe controller in
> > > this environment, MPFS supports certain reference designs for these address
> > > translations: reference designs for cache-coherent memory accesses
> > > and reference designs for non-cache-coherent memory accesses. The precise
> > > details of these reference designs and associated customer guidelines
> > > recommending that customers adhere to the addressing schemes used in those
> > > reference designs are available from Microchip, but the implication for the
> > > PCIe controller address translation between CPU-space and PCIe-space are:
> > > 
> > > For outbound address translation, the PCIe controller address translation tables
> > > are treated as if they are 32-bit only.  Any further address translation must
> > > be done in FPGA fabric.
> > > 
> > > For inbound address translation, the PCIe controller is configurable for two
> > > cases:
> > > * In the case of cache-coherent designs, the base of the AXI-S side of the
> > >   address translation must be set to 0 and the size should be 4 GiB wide. The
> > >   FPGA fabric must complete any address translations based on that 0-based
> > >   address translation.
> > > * In the case of non-cache coherent designs, the base of AXI-S side of the
> > >   address translation must be set to 0x8000'0000 and the size shall be 2 GiB
> > >   wide.  The FPGA fabric must complete any address translation based on that
> > >   0x80000000 base.
> > > 
> > > So, for example, in the non-cache-coherent case, with a device tree property
> > > that maps an inbound range from 0x10'0000'0000 in PCIe space to 0x10'0000'0000
> > > in CPU space, the PCIe rootport will translate a PCIe address of 0x10'0000'0000
> > > to an intermediate 32-bit AXI-S address of 0x8000'0000 and the FIC is
> > > responsible for translating that intermediate 32-bit AXI-S address of
> > > 0x8000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.
> > > 
> > > And similarly, for example, in the cache-coherent case, with a device tree
> > > property that maps an inbound range from 0x10'0000'0000 in PCIe space to
> > > 0x10'0000'0000 in CPU space, the PCIe rootport will translate a PCIe address
> > > of 0x10'0000'0000 to an intermediate 32-bit AXI-S address of 0x0000'0000 and
> > > the FIC is responsible for translating that intermediate 32-bit AXI-S address
> > > of 0x0000'0000 to a 64-bit AXI-S address of 0x10'0000'0000.
> > > 
> > > See https://lore.kernel.org/all/20220902142202.2437658-1-daire.mcnamara@microchip.com/T/
> > > for backstory.
> > > 
> > > Changes since v9:
> > > - Dropped plda_setup_inbound_address_translation() from StarFive driver
> > 
> > Since I had some success bumping the other series for this driver, any
> > chance of some attention here?
> > AFAIK, Daire's addressed what's been pointed out by reviewers and
> > exempted the StarFive driver from overwriting the firmware-set values
> > with once calculated from DT as they requested.
> 



