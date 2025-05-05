Return-Path: <linux-pci+bounces-27181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392AEAA9A92
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F2B3A9C22
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9300526D4C8;
	Mon,  5 May 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu+4aZca"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87D26D4C3
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466272; cv=none; b=ZGqin4bmegjTrUzzXgjPjYKjMHIeyZqcpwtCFle/s14CxKdlT5osfV4nszOiX9gZ5tHV6ylZvUzoioNttUkRkPGvczTrS4egBsFNRKJ3TCfzmdQ0yQSpAt+BgzMCToOcxSvT/zIEp8xvG9NdXrBG6BXJ7Cxtt31Afutjhz1SY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466272; c=relaxed/simple;
	bh=zi41LVtYl/FGXAoXJPYC/8qIhjG0UClIdjZnL2Ga1wc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bc9vK4BvgvLEoXNjONaQOJoRVIBNMWvo1dllh8Pw8ObHNtSXMgrUlYqsPm7zIZKL3uXSCBh35kc6QnoJp+nQx785mbmNAaYrNc/U1AAphXUaTAjSnYrU7HLjcaWNOOpozt8abEeP2QfafqWjXnRYxDlOHdPReMn9SDWyIZdG3ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu+4aZca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4652C4CEE4;
	Mon,  5 May 2025 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466271;
	bh=zi41LVtYl/FGXAoXJPYC/8qIhjG0UClIdjZnL2Ga1wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cu+4aZcao5H5JiwMrGxJEn1sJ3vuNC2radPmXw+FagY1dfWrIVLf6yAvaGoEGmXsH
	 7M9Lqf3qymrCwboqGLhc8QNv+EnR7cqamq+Vo6a8OCH839CUu+JsHavErRyYN2k0kJ
	 x2Hnkd9C77Ahkt3p4pHtjkgwV9Rp6v11fCQSkOkkxRspamo6nJhvOLN+4OQkImgcJw
	 lvwYpuo0m1ckNAhsb74LnP4Qt63bwQfksmSwUU3zfYhqTCU9uPq/yQwqsQFpkxT9sW
	 M/NhuhbR+5MsI8c6Nc7sthUfxDH3Cbxa9lxCc09cf9iLcHIEdEjF5pt3Kuz6tZXlmC
	 AJG8Gj3t+pNTA==
Date: Mon, 5 May 2025 12:31:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Subject: Re: [PATCH v3 8/8] PCI: vmd: Add workaround for bus number hardwired
 to fixed non-zero value
Message-ID: <20250505173110.GA949447@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122085215.424736-9-szymon.durawa@linux.intel.com>

On Fri, Nov 22, 2024 at 09:52:15AM +0100, Szymon Durawa wrote:
> VMD BUS1 rootbus primary number is 0x80 and pci_scan_bridge_extend()
> detects that primary bus number doesn't match the bus it's sitting on.
> As a result primary  rootbus number is deconfigured in the first pass
> of pci_scan_bridge() to be re-assigned to 0x0 in the second pass.

Every bus has a bus number, but when we're talking about the bus
itself, there's only one bus number, so it is not a *primary* number.

"Primary" and "secondary" only apply in the context of a bridge
because it's connected to two buses and we need to distinguish them.

A root bus is created by a host bridge (in this case, a VMD bridge),
and the root bus number is determined by the host bridge.  It sounds
like the bus number of the VMD BUS1 root bus is fixed in hardware to
0x80.

I think what you mean is something like:

  The VMD BUS1 root bus number is fixed in hardware to 0x80, but after
  reset, the default Primary Bus Number of Root Ports on BUS1 is 0x00.

"Primary bus number doesn't match the bus it's sitting on" is a
bit ambiguous because a bus is not a device and a bus does not "sit on
a bus."  A Root Port *does* sit on a bus.

The struct pci_bus.primary member is misleading and probably
contributes to confusion here.

s/rootbus/root bus/ throughout
s/rootport/root port/ throughout

s/primary  /primary / (spurious double space)

> To avoid bus number reconfiguration, BUS1 number has to be the same
> as BUS1 primary number.
> 
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
> ---
>  drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 6cd14c28fd4e..3b74cb8dd023 100755
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -421,8 +421,22 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
>  static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
> -	unsigned int busnr_ecam = bus->number - vmd->busn_start[VMD_BUS_0];
> -	u32 offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> +	unsigned char bus_number;
> +	unsigned int busnr_ecam;
> +	u32 offset;
> +
> +	/*
> +	 * VMD workaraund: for BUS1, bus->number is set to VMD_PRIMARY_BUS1
> +	 * (see comment under vmd_create_bus() for BUS1) but original value
> +	 * is 225 which is stored in vmd->busn_start[VMD_BUS_1].

s/workaraund/workaround/

There is no comment in vmd_create_bus().

Another case of bus numbers in decimal (225,
VMD_RESTRICT_3_BUS_START), but we're comparing with VMD_PRIMARY_BUS1
(0x80).  Needlessly confusing.

> +	if (vmd->bus1_rootbus && bus->number == VMD_PRIMARY_BUS1)
> +		bus_number = vmd->busn_start[VMD_BUS_1];
> +	else
> +		bus_number = bus->number;
> +
> +	busnr_ecam = bus_number - vmd->busn_start[VMD_BUS_0];
> +	offset = PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
>  
>  	if (offset + len >= resource_size(&vmd->dev->resource[VMD_CFGBAR]))
>  		return NULL;
> @@ -1170,6 +1184,18 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		 */
>  		vmd->bus[VMD_BUS_1]->primary = VMD_PRIMARY_BUS1;
>  
> +		/*
> +		 * This is a workaround for pci_scan_bridge_extend() code.
> +		 * It detects that non-zero (0x80) primary bus number doesn't
> +		 * match the bus it's sitting on. As a result rootbus number is
> +		 * deconfigured in the first pass of pci_scan_bridge() to be
> +		 * re-assigned to 0x0 in the second pass.
> +		 * Update vmd->bus[VMD_BUS_1]->number and
> +		 * vmd->bus[VMD_BUS_1]->primary to the same value, which
> +		 * bypasses bus number reconfiguration.

If you can include dmesg snippets in the commit log showing how
pci_scan_bridge_extend() and pci_scan_bridge() deal with this, I think
it will help understand this.  There might be some improvement we can
make in pci_scan_bridge_extend() (someday, not today).

> +		 */
> +		vmd->bus[VMD_BUS_1]->number = VMD_PRIMARY_BUS1;
> +
>  		WARN(sysfs_create_link(&vmd->dev->dev.kobj,
>  				       &vmd->bus[VMD_BUS_1]->dev.kobj,
>  				       "domain1"),
> -- 
> 2.39.3
> 

