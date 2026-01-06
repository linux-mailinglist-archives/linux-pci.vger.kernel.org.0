Return-Path: <linux-pci+bounces-44113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A00CFAC71
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 20:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A659319BE89
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 19:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75589348880;
	Tue,  6 Jan 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzeXvbfh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9F347FFB;
	Tue,  6 Jan 2026 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721430; cv=none; b=ljMElKukkMcvRI1gEa/LHihahr/0fafpTmmaW73LSEM2P9P02muoG0Nqh8AsSHVojyDKEnWJZX28Jc0oW6EOjndI0YaCQANINXG7/s8DdoH3w/ca88w3wLrTY3KKI0jslkJ3HX+ET9/UV8CWUEFtChM5Zzcrt8So8MYOYpBaJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721430; c=relaxed/simple;
	bh=NMRzBgPMATlkTm0f50YVEsRzDjIrZY2oM6Hy3objjVs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oNpBRFL+bP4EcHk4prZNZfu75e83PmBt0BV20GnXTEhecZigpDF76WJ4dDx6C2ad2jlv0O03UeR8p9JzUP8tjM+XzHzGXu1/TAtw7YmKjzJPKu+fRX4vV7qWUqUuFOjZmQS6XYwzVNoByBWDE+35FiCNM+/ducHfwImKotHa9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzeXvbfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B77C2BC87;
	Tue,  6 Jan 2026 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767721430;
	bh=NMRzBgPMATlkTm0f50YVEsRzDjIrZY2oM6Hy3objjVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tzeXvbfhmHVkjq0VbUefLPWiz/RWjpWtNr7seZ7zbVbxKXqvnMsc4FVfYGDbroS7c
	 JT2/4Eg5gnjcF0XmT8xc5FgmYwrfJvCLuM+Yyt9VG7MFluY1j90+LV+to2gqRIW/bJ
	 +3JkhEJVbvWldHKg+ra9OizdFyxscvugTiYs1k3bBALyMXWw4gsSYvduz2crPDKQvZ
	 rg6d6eWeG+X8bCZYvdAS6xuk8lohfQSmAICIsfe7oA1EZOrhLujLDLG8tE8M8Y4oJA
	 CkGLngJp74qXAk6So1os/WrFST3fQW6sSM8X1jLzTCOKt9qXFTVOM6FhP0hslLGtzS
	 U2SD0Z2MR5Y2g==
Date: Tue, 6 Jan 2026 11:43:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: zhangsenchuan <zhangsenchuan@eswincomputing.com>, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <20260106174348.GA365798@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3rhkrlp3jypajh77rohqgpoujivpxq6g3o6vrt6u7u5j2atd@gd5o3vtlhapp>

On Tue, Jan 06, 2026 at 06:49:58PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jan 06, 2026 at 08:43:11PM +0800, zhangsenchuan wrote:
> > > On Mon, Dec 29, 2025 at 07:32:07PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > 
> > > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > > interrupts.
> > > 
> > > > +config PCIE_EIC7700
> > > > +	tristate "Eswin EIC7700 PCIe controller"
> > > 
> > > > +/* Vendor and device ID value */
> > > > +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> > > > +#define PCI_DEVICE_ID_ESWIN		0x2030
> > > 
> > > Usually the device name is a little more than just the vendor.  What
> > > if Eswin ever makes a second device?
> > 
> > Okey, thanks.
> > Perhaps it's a problem. Maybe PCI_DEVICE_ID_EIC7700 is better?

Check pci_ids.h and follow the style used there.  Device ID macros
typically include both the vendor and the device.

> > > > +static struct platform_driver eic7700_pcie_driver = {
> > > > +	.probe = eic7700_pcie_probe,
> > > 
> > > This driver is tristate but has no .remove() callback.  Seems like it
> > > should have one?
> > 
> > In v2 patch, I referred to Mani's comments and removed the .remove()
> > callback, as follows:
> > "Since this controller implements irqchip using the DWC core driver,
> > it is not safe to remove it during runtime."
> > https://lore.kernel.org/linux-pci/jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi/
> > 
> > In addition, remove .remove() callback, because this driver has been 
> > modified to builtin_platform_driver and does not support HotPlug, 
> > therefore, the .remove() callback is not needed. Do you have any
> > better suggestions?
> 
> Yes, builtin_platform_driver() wouldn't allow the users to remove
> the module. So remove() callback will become useless. The reason why
> this driver is tristate is that it could be loaded from rootfs and
> not always statically built to the kernel image.

This .remove() vs IRQ thing is a perennial issue and it's hard to know
what style new drivers should copy.

There are lots of DWC-based drivers that are tristate, implement
.remove(), and use module_platform_driver() (e.g., bt1, kirin,
tegra194, rcar-gen4, exynos, k1, stm32).  Is there something different
about the way they implement irqchip that makes .remove() safe?

