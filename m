Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1163F4B42FA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 08:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbiBNHgR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 02:36:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiBNHgQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 02:36:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21BB593BE;
        Sun, 13 Feb 2022 23:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644824169; x=1676360169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtIgUTAIsXJ4XGN4YguPnu9VZqX5t+e944YjPkCfnAQ=;
  b=SwRK8zVWJgEMXtJtpBLzZy1BsUZKzdZ+4NjbisNZaDzXs889iWGOHqSd
   GOonLu/QM7tAGFVRmW+FDlBJvZGgBbfFVfQ4U7dZDo0RDcdusIwtAohQY
   fd6aWPIchooNH8JYKbF6byvkhmh6IOfSK8jD3iB+b+UTq0Z7P0gzYCS5T
   LxLb7neO5XXg+OsWvtnsx3+lUZF1a+Ww9vNQg5F2eY/3XkfER6+wEj+nb
   mWEpZEUnyA+YMMSMLuQSrzq6BPcGfD+zG9TwCjb/De75gRDyW2G3hdXZH
   7TNGJXADQ+P3UJMbzWPhXJuNu+0TVa13kvmUD1tISvFskC37ptitYU+hm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247628389"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="247628389"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:36:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="772875545"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:36:04 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 14 Feb 2022 09:34:26 +0200
Date:   Mon, 14 Feb 2022 09:34:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com, Lukas Wunner <lukas@wunner.de>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH v3 05/12] PCI: Detect root port of internal USB4 devices
 by `usb4-host-interface`
Message-ID: <YgoGAkjZgCob8Mdl@lahna>
References: <20220211193250.1904843-6-mario.limonciello@amd.com>
 <20220211214546.GA737137@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211214546.GA737137@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, Feb 11, 2022 at 03:45:46PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 11, 2022 at 01:32:43PM -0600, Mario Limonciello wrote:
> > The root port used for PCIe tunneling should be marked as removable to
> > ensure that the entire chain is marked removable.
> > 
> > This can be done by looking for the device property specified in
> > the ACPI tables `usb4-host-interface`.
> > 
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/pci/pci-acpi.c | 10 ++++++++++
> >  drivers/pci/pci.h      |  5 +++++
> >  drivers/pci/probe.c    |  1 +
> >  3 files changed, 16 insertions(+)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index a42dbf448860..6368e5633b1b 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1391,6 +1391,16 @@ void pci_acpi_cleanup(struct device *dev, struct acpi_device *adev)
> >  	}
> >  }
> >  
> > +bool pci_acpi_is_usb4(struct pci_dev *dev)
> > +{
> > +	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > +
> > +	if (!adev)
> > +		return false;
> > +	return fwnode_property_present(acpi_fwnode_handle(adev),
> > +				       "usb4-host-interface");
> 
> Maybe it's obvious to everybody but me that "USB4" means this device
> is removable.  The Microsoft reference above doesn't say anything
> about removability.
> 
> My expectation is that "USB" (like "PCI" and "PCIe") tells me
> something about how a device is electrically connected and how
> software can operate it.  It doesn't really tell me anything about
> whether those electrical connections are permanent, made through an
> internal slot, or made through an external connector and cable.

It is used to identify "tunneled" ports (whether PCIe, USB 3.x or
DisplayPort). Tunnels are created by software (in Linux it is the
Thunderbolt driver) and are dynamic in nature. The USB4 links go over
USB Type-C cable which also is something user can plug/unplug freely.

I would say it is reasonable expectation that anything behind these
ports can be assumed as "removable".
