Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9D7DD6E7
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 21:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjJaUEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 16:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjJaUEb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 16:04:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2191F7
        for <linux-pci@vger.kernel.org>; Tue, 31 Oct 2023 13:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698782668; x=1730318668;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KB6OSC/0lR/Gq1hgy9SZq/cc123pnwd0kfYS8nNLbPE=;
  b=hNr7rag0YX9awH/9jfQv5/6mR2L64dckWygETvN+M5iQqbaHKoK9ztIz
   ieSA1R+aV1EIZgTBp2420xAogFgHAL02pAoHcCY3jZxexwiHKqObiHBzf
   C5Zh+/Y3g5uD91MvNnHVyjv/Kr14moVPqMAT5nF8269xLjwV1+1avC4Xe
   rKMDlxJh3SI3xUPIXCOTXRH+vAGBbEgu64TL95OVHYq5l6GwArGqObuII
   k0pvCGuZfGY5YNU59+eMOqLH5t4AtIVhz0AClFQSLT0WF7g5g+ZUfbSOc
   EUy7jS3gcv6uBhplU5nbNnrhWzMIMCudwO7KKSiz6pVEaw88AyVzm2eiw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="367710311"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="367710311"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 13:04:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760732847"
X-IronPort-AV: E=Sophos;i="6.03,266,1694761200"; 
   d="scan'208";a="760732847"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 13:04:28 -0700
Message-ID: <3108a89a57234c37a981d2e6b9b8af437c153330.camel@linux.intel.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     "nirmal.patel@linux.intel.com; Bjorn Helgaas" <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Date:   Tue, 31 Oct 2023 13:11:08 -0700
In-Reply-To: <20231031153144.GA10760@bhelgaas>
References: <20231031153144.GA10760@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal Patel wrote:
> > VMD Hotplug should be enabled or disabled based on VMD rootports'
> > Hotplug configuration in BIOS. is_hotplug_bridge is set on each
> > VMD rootport based on Hotplug capable bit in SltCap in probe.c.
> > Check is_hotplug_bridge and enable or disable native_pcie_hotplug
> > based on that value.
> > 
> > Currently VMD driver copies ACPI settings or platform
> > configurations
> > for Hotplug, AER, DPC, PM, etc and enables or disables these
> > features
> > on VMD bridge which is not correct in case of Hotplug.
> 
> This needs some background about why it's correct to copy the ACPI
> settings in the case of AER, DPC, PM, etc, but incorrect for hotplug.
> 
> > Also during the Guest boot up, ACPI settings along with VMD UEFI
> > driver are not present in Guest BIOS which results in assigning
> > default values to Hotplug, AER, DPC, etc. As a result Hotplug is
> > disabled on VMD in the Guest OS.
> > 
> > This patch will make sure that Hotplug is enabled properly in Host
> > as well as in VM.
> 
> Did we come to some consensus about how or whether _OSC for the host
> bridge above the VMD device should apply to devices in the separate
> domain below the VMD?
> 
> I think this warrants some clarification and possibly discussion in
> the PCI firmware SIG.
> 
> At the very least, the commit log should mention _OSC and say
> something about the fact that this is assuming PCIe hotplug ownership
> for devices below VMD, regardless of what the upstream _OSC said.
I will make an adjustment to the commit log once we have some
aggrement.
> 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > ---
> > ---
> >  drivers/pci/controller/vmd.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c
> > index 769eedeb8802..e39eaef5549a 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -720,6 +720,7 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	resource_size_t membar2_offset = 0x2000;
> >  	struct pci_bus *child;
> >  	struct pci_dev *dev;
> > +	struct pci_host_bridge *vmd_bridge;
> >  	int ret;
> >  
> >  	/*
> > @@ -886,8 +887,16 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features)
> >  	 * and will fail pcie_bus_configure_settings() early. It can
> > instead be
> >  	 * run on each of the real root ports.
> >  	 */
> > -	list_for_each_entry(child, &vmd->bus->children, node)
> > +	vmd_bridge = to_pci_host_bridge(vmd->bus->bridge);
> > +	list_for_each_entry(child, &vmd->bus->children, node) {
> >  		pcie_bus_configure_settings(child);
> > +		/*
> > +		 * When Hotplug is enabled on vmd root-port, enable it
> > on vmd
> > +		 * bridge.
> > +		 */
> > +		if (child->self->is_hotplug_bridge)
> > +			vmd_bridge->native_pcie_hotplug = 1;
> > +	}
> >  
> >  	pci_bus_add_devices(vmd->bus);
> >  
> > -- 
> > 2.31.1
> > 

