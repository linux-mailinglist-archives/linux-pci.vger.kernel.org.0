Return-Path: <linux-pci+bounces-10931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5151A93EFA6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730011C208C5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0A26F2F1;
	Mon, 29 Jul 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWGb7UnC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030A54BD8;
	Mon, 29 Jul 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240983; cv=none; b=RjRzH+pQY2UWbDsbOS5FIb2NBvgKC8jbnU9LSGq9K+D2o5anTsJd/vxMgShfVHTYY1KlhVNi+TwjdrTXZma+h9O+OZiWYi/zS4SCR1ASpRyT08peZWUcsLH/oxHRl5o1lfxmhtJw0ImJyiRKt0OFijHWLvh1fEm1Z1JL4BFvQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240983; c=relaxed/simple;
	bh=ypBvY5QHCkj8QTxrc5ooWAWfb1n69myi7nhapRC2n9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIpONivzZMbohRv0M70h+4MVThuKMbNT60MiJs/gqw5IflzAcRbMDOZy8/vso89VWE34Cv+x/wX1vilnYwFKl2sKNSPq3Fvx9R33YZUE5m7k+w7D42SLaK3sg5seIPrLlQWcKOWAbppOfOWUNbKIIkBQSPK/UJWUXe4XUmoJyj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWGb7UnC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722240981; x=1753776981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ypBvY5QHCkj8QTxrc5ooWAWfb1n69myi7nhapRC2n9k=;
  b=cWGb7UnCjQOi+r57A/y7AxWgI7fFBvyjtFHBoB/avoxg7CJ8Zfb5+A8H
   UicPMgfxJyUxx8+kXGBGlLWt5NzpcLdZw8Me46W8qJY1kjF7PaqgFqrHs
   /cr/V8NSOaUIrOKTr0r2GytQAQicLnU3KIlfhtaolVjXurtTldLyhWhB8
   +aW0uYpuQi3ge/zlEpuKAzZvVsXUoIl8EAtpLDNLAECSECDpeLIU5e4ZY
   TAPlUcm01e+f8LIgoOYh4DmRoHqDfU0Dw/xauOtAuF+iQW+OUeFe7f/c8
   5TzK6Sii/dhp5hvz4wGKZjV4W+dN4gM1T05a7hSvLgi1AGAUrN+meWzXP
   A==;
X-CSE-ConnectionGUID: ke9S/IqoSfCquX/w2Nx3/A==
X-CSE-MsgGUID: tV7PcuRhQiS+ahvq/lpI9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23842154"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="23842154"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 01:16:20 -0700
X-CSE-ConnectionGUID: GU0BhnNgTAiMK+NdY4/h0A==
X-CSE-MsgGUID: asZSqmFFSxiN7EVlcFBsKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77144782"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 29 Jul 2024 01:16:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 1104719E; Mon, 29 Jul 2024 11:16:16 +0300 (EEST)
Date: Mon, 29 Jul 2024 11:16:16 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240729081616.GH1532424@black.fi.intel.com>
References: <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de>
 <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com>
 <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <20240626080517.GZ1532424@black.fi.intel.com>
 <CA+Y6NJEg-1uGCS0eJ2QP4p6EEh2S+6-yTAUKpPvvqDpyb6_DMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+Y6NJEg-1uGCS0eJ2QP4p6EEh2S+6-yTAUKpPvvqDpyb6_DMQ@mail.gmail.com>

Hi,

On Fri, Jul 26, 2024 at 02:17:46PM -0400, Esther Shimanovich wrote:
> On Wed, Jun 26, 2024 at 4:05 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > I will be on vacation starting next week for the whole July. The patch
> > is kind of "pseudo-code" in that sense that it probably needs some
> > additional work, cleanup, maybe drop the serial number checks and so on.
> > You are free to use it as you see fit, or submit upstream as proper
> > patch if nobody objects.
> 
> I cleaned it up, but I think I'd like to run it by you before
> submitting it, as you are the author and also some of my cleanups
> ended up being a bit more involved than I anticipated.
> 
> For cleanup, I did the following:
> 
> 1) I ended up moving the changes from pcie_set_pcie_untrusted to
> pci_set_removable for multiple reasons:
> 
> - The downstream bug I ran into happened because of the "removable" attribute.
> 
> - There seems to be a reason why both removable and untrusted exist
> despite both having the same logic. pci_fixup_early is run after
> pcie_set_pcie_untrusted, but before pci_set_removable. It seems like
> this was done on purpose so that downstream security policies can use
> quirks to set specific internal, fixed devices as untrusted.
> 
> - The way you wrote it makes the attributes removable = untrusted,
> which wasn't the case before, and undos the pci_fixup_early quirks
> logic.
> 
> - If you want to make sure that these non-tunneled discrete
> thunderbolt chips are labeled as trusted, we may have to duplicate
> this logic in both functions (which seems to be already the case
> anyways in their current state).
> I just don't fully know what the "untrusted" attribute entails, so I
> am erring on the more conservative side of only making changes I fully
> understand.

The "untrusted" means the device is something that is not "soldered
down" or equivalent. E.g something you can hot-plug through a port on the
laptop system such as USB4/TB. It is used to enable full IOMMU mappings
for these devices to avoid malicious devices from accessing memory that
does not belong to it.

So it is pretty much same as "removable".

Why we do want to have the USB4 host controller + xHCI not "untrusted"
is because they don't need to go through the full IOMMU mappings and
therefore we get for one more throughput for things like networking over
USB4.

> 2) I changed this comment into code:
> 
> > +/* root->external_facing is true, parent != NULL */
> 
> 3) I edited legacy comments to reflect what the code does now. I also
> changed your comments to reflect how I changed the code, but for the
> most part I kept your words in as they were really clear.
> 
> 4) I removed the serial checks as you suggested
> 
> > If nothing has happened when I come back, I can pick up the work if I
> > still remember this ;-)
> 
> I did my best to clean up! I'm unsure if you will want me to duplicate
> this logic to pcie_set_pcie_untrusted, so just let me know if I should
> fix that, and I'll send it to the kernel! (I'm assuming with the
> Co-developed-by, and the Signed-off-by lines, to properly attribute
> you?)

I think they should be the "same".

You can add something like "Suggested-by" or so if you like but up to
you. No need to add other tags from me.

Please Cc IOMMU folks too so that they can take a look just in case.

The patch is line-wrapped but otherwise looks good except the above.
Thanks for cleaning it up.

> I hope you had a nice vacation! Both you and Lukas Wurner have been so
> helpful and attentive.
> 
> The cleaned up patch is below:
> 
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 43159965e09e9..fc3ef2cf66d58 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1613,24 +1613,161 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>                 dev->untrusted = true;
>  }
> 
> +/*
> + * Checks if the PCIe switch that contains pdev is directly under
> + * the specified bridge.
> + */
> +static bool pcie_switch_directly_under(struct pci_dev *bridge,
> +                                      struct pci_dev *parent,
> +                                      struct pci_dev *pdev)
> +{
> +       /*
> +        * If the device has a PCIe type, that means it is part of a PCIe
> +        * switch.
> +        */
> +       switch (pci_pcie_type(pdev)) {
> +       case PCI_EXP_TYPE_UPSTREAM:
> +               if (parent == bridge)
> +                       return true;
> +               break;
> +
> +       case PCI_EXP_TYPE_DOWNSTREAM:
> +               if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
> +                       parent = pci_upstream_bridge(parent);
> +                       if (parent == bridge)
> +                               return true;
> +               }
> +               break;
> +
> +       case PCI_EXP_TYPE_ENDPOINT:
> +               if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM) {
> +                       parent = pci_upstream_bridge(parent);
> +                       if (parent && pci_pcie_type(parent) ==
> PCI_EXP_TYPE_UPSTREAM) {
> +                               parent = pci_upstream_bridge(parent);
> +                               if (parent == bridge)
> +                                       return true;
> +                       }
> +               }
> +               break;
> +       }
> +
> +       return false;
> +}
> +
> +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> +{
> +       struct fwnode_handle *fwnode;
> +
> +       /*
> +        * For USB4 the tunneled PCIe root or downstream ports are marked with
> +        * the "usb4-host-interface" property so we look for that first. This
> +        * should cover the most cases.
> +        */
> +       fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> +                                      "usb4-host-interface", 0);
> +       if (!IS_ERR(fwnode)) {
> +               fwnode_handle_put(fwnode);
> +               return true;
> +       }
> +
> +       /*
> +        * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +        * before Alder Lake do not have the above device property so we
> +        * use their PCI IDs instead. All these are tunneled. This list
> +        * is not expected to grow.
> +        */
> +       if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +               switch (pdev->device) {
> +               /* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +               case 0x8a1d:
> +               case 0x8a1f:
> +               case 0x8a21:
> +               case 0x8a23:
> +               /* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +               case 0x9a23:
> +               case 0x9a25:
> +               case 0x9a27:
> +               case 0x9a29:
> +               /* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +               case 0x9a2b:
> +               case 0x9a2d:
> +               case 0x9a2f:
> +               case 0x9a31:
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
> +static bool pcie_is_tunneled(struct pci_dev *root, struct pci_dev *parent,
> +                            struct pci_dev *pdev)
> +{
> +       /* Return least trusted outcome if params are invalid */
> +       if (!(root && root->external_facing && parent))
> +               return true;
> +
> +       /* Anything directly behind a "usb4-host-interface" is tunneled */
> +       if (pcie_has_usb4_host_interface(parent))
> +               return true;
> +
> +       /*
> +        * Check if this is a discrete Thunderbolt/USB4 controller that is
> +        * directly behind a PCIe Root Port marked as "ExternalFacingPort".
> +        * These are not behind a PCIe tunnel.
> +        */
> +       if (pcie_switch_directly_under(root, parent, pdev))
> +               return false;
> +
> +       return true;
> +}
> +
>  static void pci_set_removable(struct pci_dev *dev)
>  {
> -       struct pci_dev *parent = pci_upstream_bridge(dev);
> +       struct pci_dev *parent, *root;
> +
> +       parent = pci_upstream_bridge(dev);
> 
>         /*
> -        * We (only) consider everything downstream from an external_facing
> -        * device to be removable by the user. We're mainly concerned with
> -        * consumer platforms with user accessible thunderbolt ports that are
> -        * vulnerable to DMA attacks, and we expect those ports to be marked by
> -        * the firmware as external_facing. Devices in traditional hotplug
> -        * slots can technically be removed, but the expectation is that unless
> -        * the port is marked with external_facing, such devices are less
> -        * accessible to user / may not be removed by end user, and thus not
> -        * exposed as "removable" to userspace.
> +        * We're mainly concerned with consumer platforms with user accessible
> +        * thunderbolt ports that are vulnerable to DMA attacks.
> +        * We expect those ports to be marked by the firmware as
> external_facing.
> +        * Devices outside external_facing ports are labeled as removable, with
> +        * the exception of discrete thunderbolt chips within the chassis.
> +        *
> +        * Devices in traditional hotplug slots can technically be removed,
> +        * but the expectation is that unless the port is marked with
> +        * external_facing, such devices are less accessible to user / may not
> +        * be removed by end user, and thus not exposed as "removable" to
> +        * userspace.
>          */
> -       if (parent &&
> -           (parent->external_facing || dev_is_removable(&parent->dev)))
> +       if (!parent)
> +               return;
> +
> +       if (dev_is_removable(&parent->dev))
>                 dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +
> +       root = pcie_find_root_port(dev);
> +
> +       if (root && root->external_facing) {
> +               /*
> +                * All devices behind a PCIe root port labeled as
> +                * "ExternalFacingPort" are tunneled by definition,
> +                * with the exception of discrete Thunderbolt/USB4
> +                * controllers that add Thunderbolt capabilities
> +                * to CPUs that lack integrated Thunderbolt.
> +                * They are identified because by definition, they
> +                * aren't tunneled.
> +                *
> +                * Those discrete Thunderbolt/USB4 controllers are
> +                * not removable. Only their downstream facing ports
> +                * are actually something that are exposed to the
> +                * wild so we only mark devices tunneled behind those
> +                * as removable.
> +                */
> +               if (pcie_is_tunneled(root, parent, dev))
> +                       dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +       }
>  }
> 
>  /**

