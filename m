Return-Path: <linux-pci+bounces-2215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436B82F2B0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2231A285CAC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B601CA81;
	Tue, 16 Jan 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTFtI0JU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2C1C6BC;
	Tue, 16 Jan 2024 16:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE52C433C7;
	Tue, 16 Jan 2024 16:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705424152;
	bh=vvb30FWvCMkK5KvuyLxMDAHpy7g1C7TNhUJRnix82e0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTFtI0JUPYXjGnf23ymD8iN1J/BvQkfvN05xycJohmdD9/dBLLJxrn+lAsQdLf6Gc
	 HC5VR6YolpNriimnya+VLtufx9UFno8TGB3qAFpP8nuUJJ0gszUw7fotTWZ7+1EJHc
	 TBGX4Hz6roF9hrQvBnTxUZ7F4b6hE+6IEr/eFsNb9Xicmw6HYeDleHgBY3+2bly1gK
	 YWGTRv6X4R1OWfeROefuR3dSZemhTckyEbwZtjRlYsF4RQjozf6H9sw2C2AV36NkZt
	 7J/GMVRl51LoTE4ScvwQt8AT2n8/FqUOfawWA6+KsTuaZkY0/+phMTIOWRNKrGXU+L
	 yIgKSHYRPQ2Kw==
Date: Tue, 16 Jan 2024 10:55:50 -0600
From: Rob Herring <robh@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org, kw@linux.com,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, will@kernel.org, frowand.list@gmail.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 2/2] PCI: Add support for "preserve-boot-config"
 property
Message-ID: <20240116165550.GA102137-robh@kernel.org>
References: <20240112165830.GA2271982@bhelgaas>
 <5e8f6c52-6149-42c0-affb-d8b072a77956@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e8f6c52-6149-42c0-affb-d8b072a77956@nvidia.com>

On Mon, Jan 15, 2024 at 08:02:56PM +0530, Vidya Sagar wrote:
> 
> 
> On 1/12/2024 10:28 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jan 10, 2024 at 08:37:25AM +0530, Vidya Sagar wrote:
> > > Add support for "preserve-boot-config" property that can be used to
> > > selectively (i.e. per host bridge) instruct the kernel to preserve the
> > > boot time configuration done by the platform firmware.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > V2:
> > > * Addressed issues reported by kernel test robot <lkp@intel.com>
> > > 
> > >   drivers/pci/controller/pci-host-common.c |  5 ++++-
> > >   drivers/pci/of.c                         | 18 ++++++++++++++++++
> > >   drivers/pci/probe.c                      |  2 +-
> > >   include/linux/of_pci.h                   |  6 ++++++
> > >   4 files changed, 29 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> > > index 6be3266cd7b5..d3475dc9ec44 100644
> > > --- a/drivers/pci/controller/pci-host-common.c
> > > +++ b/drivers/pci/controller/pci-host-common.c
> > > @@ -68,13 +68,16 @@ int pci_host_common_probe(struct platform_device *pdev)
> > > 
> > >        of_pci_check_probe_only();
> > > 
> > > +     bridge->preserve_config =
> > > +             of_pci_check_preserve_boot_config(dev->of_node);
> > 
> > Thanks for leveraging the existing "preserve_config" support for the
> > ACPI _DSM.  Is pci_host_common_probe() the best place for this?  I
> > think there are many DT platform drivers that do not use
> > pci_host_common_probe(), so I wonder if there's a more generic place
> > to put this.
> My understanding is that pci_host_common_probe() is mainly used in
> systems where the firmware would have taken care of all the platform
> specific initialization and giving the ECAM and 'ranges' info through DT
> for the Linux kernel to go ahead and perform the enumeration. This is
> similar to ACPI way of handing over the system from firmware to the OS.
> 
> If PCIe controllers are getting initialized in the kernel itself, then
> pci_host_probe() is called directly from the respective host controller
> drivers which is the case with all the DesignWare based implementations
> including Tegra194 and Tegra234. In those systems, since the controllers
> themselves have come up and gotten initialized in the kernel, resource
> assignment has to happen anyway.
> 
> > 
> > I see Rob's concern about adding "preserve-boot-config" vs extending
> > "linux,pci-probe-only" and I don't really have an opinion on that,
> > although I do think the "pci-probe-only" name is not as descriptive as
> > it could be.  I guess somebody will argue that "preserve_config" could
> > be more descriptive, too :)
> Honestly I would have liked to repurpose of_pci_check_probe_only() API
> to look for "preserve-boot-config" in the respective PCIe controller's
> DT node and not "linux,pci-probe-only" in the chosen entry, had it not
> for the single usage of of_pci_check_probe_only() in arch/powerpc
> /platforms/pseries/setup.c file.
> Also FWIW, "linux,pci-probe-only" is not documented anywhere.

Yes, it is[1].

> 
> Since there is at least one user for of_pci_check_probe_only(), and
> combining with the fact that the scope where "linux,pci-probe-only" and
> "preserve-boot-config" are used (i.e. chosen entry Vs individual PCIe
> controller node), I prefer to have it as a separate option.
> Rob, please let me know if you have any strong objections to that?

Didn't I already object?

What's the concern with existing users? There shouldn't be any. If 
"linux,pci-probe-only" appeared in a bridge node, it would have been 
ignored and now would be honored.

Rob

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml#L140

