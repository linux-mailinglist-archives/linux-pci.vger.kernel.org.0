Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E307DD936
	for <lists+linux-pci@lfdr.de>; Wed,  1 Nov 2023 00:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjJaXUK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbjJaXUJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 19:20:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111ACC9
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698794407; x=1730330407;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4i5Q6qILxVTBd5if9FFMyEDGLFLIbzqmYduCd7MYAjg=;
  b=nhQdc7eaCmZ0vpTycUmfAvfJIQdfyYCqQHMBKkAAnqj37pNJ0lxtMmV3
   6k/Ws6YJvZKSCj59HXPulzxtTMLzpUMqGemDZZH+gzwOsUQMzogdvuZAq
   PDuw02h3M99D+AidRvg9ot2nsuHca3OHW9+UGIDbRJKlLjkmrXVJSACBF
   IACLclSGdnsA+jb4M5fiQZXuwsC+mChqRr5JfY9em/pwCA1WP2G0f4ooz
   TMGfvdUjxFbPadHRh7dCEPeNZUbWwmJEfK9PAsyk1ROyGRC69frJTzkZw
   KW1+C9GMhfqaVL3pcwXf6VKC1FQrhXDLMPaQdoM2mokaDFneLro+gQ4IS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="388215518"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="388215518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 16:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884363646"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="884363646"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 16:20:06 -0700
Message-ID: <8542edf9a001d74895a75574d91df421e535bbcd.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, orden.e.smith@intel.com
Date:   Tue, 31 Oct 2023 16:26:46 -0700
In-Reply-To: <f0b9e19c7a976f7a81b55f432a4ed29324b319fc.camel@linux.intel.com>
References: <20231031153144.GA10760@bhelgaas>
         <f0b9e19c7a976f7a81b55f432a4ed29324b319fc.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2023-10-31 at 12:59 -0700, Nirmal Patel wrote:
> On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> > > VMD Hotplug should be enabled or disabled based on VMD rootports'
> > > Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> > > VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> > > Check is_hotplug_bridge and enable or disable native_pcie_hotplug
> > > based on that value.
> > > 
> > > Currently VMD driver copies ACPI settings or platform
> > > configurations
> > > for Hotplug, AER, DPC, PM, etc and enables or disables these
> > > features
> > > on VMD bridge which is not correct in case of Hotplug.
> > 
> > This needs some background about why it's correct to copy the ACPI
> > settings in the case of AER, DPC, PM, etc, but incorrect for
> > hotplug.
> > 
> > > Also during the Guest boot up, ACPI settings along with VMD UEFI
> > > driver are not present in Guest BIOS which results in assigning
> > > default values to Hotplug, AER, DPC, etc. As a result Hotplug is
> > > disabled on VMD in the Guest OS.
> > > 
> > > This patch will make sure that Hotplug is enabled properly in
> > > Host
> > > as well as in VM.
> > 
> > Did we come to some consensus about how or whether _OSC for the
> > host
> > bridge above the VMD device should apply to devices in the separate
> > domain below the VMD?
> We are not able to come to any consensus. Someone suggested to copy
> either all _OSC flags or none. But logic behind that assumption is
> that the VMD is a bridge device which is not completely true. VMD is
> an
> endpoint device and it owns its domain.
> 
> Also please keep this in your consideration, since Guest BIOS
> doesn't have _OSC implementation, all of the flags Hotplug, AER, DPC
> are set to power state default value and VMD's very important hotplug
> functionality is broken.

In case of Host OS, when VMD copies all the _OSC flags, Hotplug, AER,
DPC, etc, it reflects Host BIOS settings.

But in case of Guest OS or VM, the _OSC flags do not reflect Host BIOS
settings. Instead what we have is power ON default values in VM, thus
does not reflect any Host BIOS settings. For example, disabling Hotplug
in VM eventhough it is enabled in Host BIOS.

The patch 04b12ef163d1 broke the settings in Guest kernel by applying
non-host default _OSC values. This long discussion is about restoring
some of these settings to correct Host BIOS settings. i.e. Hotplug.

> 
> The patch 04b12ef163d1 assumes VMD is a bridge device and borrows/
> *imposes system settings* for AER, DPC, Hotplug, PM, etc on VMD.
> VMD is*type 0 PCI endpoint* device and all the PCI devices under VMD
> are *privately *owned by VMD not by the OS.
> 
> Also VMD has its own Hotplug setting for its rootports in BIOS under
> VMD settings that are different from global BIOS system settings. It
> is
> these settings that give VMD its own unique functionality.
> 
> That is why I suggested three solutions but never got any
> confirmation.
> 
> #1: Revert the patch 04b12ef163d1 which was added under wrong
> assumption. This patch didn't need to be added to VMD code if AER
> was disabled from BIOS platform settings.
> 
> #2: VMD driver disables AER by copying AER BIOS system settings
> which the patch 04b12ef163d1 does but do not change Hotplug.
> I proposed this patch and didn't get approval.
> 
> #3: If hotplug is enabled on VMD root ports, make sure hotplug is
> enabled on the bridge rootports are connected to. The proposed patch
> does that.
> 
> Can we please come to some decision? VM Hotplug is an important part
> of
> VMD and customers are reporting VM Hotplug issues. I would like to
> get
> some progress on this one.
> 
> Thanks
> nirmal
> > I think this warrants some clarification and possibly discussion in
> > the PCI firmware SIG.
> > 
> > At the very least, the commit log should mention _OSC and say
> > something about the fact that this is assuming PCIe hotplug
> > ownership
> > for devices below VMD, regardless of what the upstream _OSC said.
> > 
> > > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > > ---
> > > ---
> > >  drivers/pci/controller/vmd.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/vmd.c
> > > b/drivers/pci/controller/vmd.c
> > > index 769eedeb8802..e39eaef5549a 100644
> > > --- a/drivers/pci/controller/vmd.c
> > > +++ b/drivers/pci/controller/vmd.c
> > > @@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features)
> > >  	resource_size_t membar2_offset = 0x2000;
> > >  	struct pci_bus *child;
> > >  	struct pci_dev *dev;
> > > +	struct pci_host_bridge *vmd_bridge;
> > >  	int ret;
> > >  
> > >  	/*
> > > @@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev
> > > *vmd, unsigned long features)
> > >  	 * and will fail pcie_bus_configure_settings() early. It can
> > > instead be
> > >  	 * run on each of the real root ports.
> > >  	 */
> > > -	list_for_each_entry(child, &vmd->bus->children, node)
> > > +	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > > +	list_for_each_entry(child, &vmd->bus->children, node) {
> > >  		pcie_bus_configure_settings(child);
> > > +		/*
> > > +		 * When Hotplug is enabled on vmd root-port, enable it
> > > on vmd
> > > +		 * bridge.
> > > +		 */
> > > +		if (child->self->is_hotplug_bridge)
> > > +			vmd_bridge->native_pcie_hotplug = 1;
> > > +	}
> > >  
> > >  	pci_bus_add_devices(vmd->bus);
> > >  
> > > -- 
> > > 2.31.1
> > > 

