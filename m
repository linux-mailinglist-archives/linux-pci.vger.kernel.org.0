Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A24AC46D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 16:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiBGPyZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385919AbiBGPpX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 10:45:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36672C0401EB;
        Mon,  7 Feb 2022 07:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644248714; x=1675784714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/+662DkEN2VKV4fdJdKi0UpbMi0LWT9BZ8XRWLwrwvE=;
  b=Hl8tf/nRGe/sxXaOAB+VgNEd4j36DZ/BIYWnEEdMX0gCTWl6WXSlH0eP
   gOelkfXzOmITvc1dPZ7YXrkDxXH0JaGzkwuWeQLEcEr6g1tEWJCc3wG/U
   iUw9RRbRm/1GgwTeg5i2+eycwWpnLSQZ0liceBC1J60Fe5U2Fml8z3ShG
   +L3jHECoH8t00qc2gaI9I2789HOF4TDb1HSbeSHX+hYzFvkirE9fgoGSZ
   SYyrcI8CF26CNamFBYT5/mky9b0E3m8/2NcwMiaoAZPm4g226O3/nn6rJ
   ArLhorsOwq+NnNsx0chwdeqhhpPSbVh+eMiQXroqIoKpYJV6+Mgw0Oo67
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="248950504"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248950504"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 07:45:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="677795304"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 07:45:10 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Feb 2022 17:45:07 +0200
Date:   Mon, 7 Feb 2022 17:45:07 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Message-ID: <YgE+g9JOJE6foThi@lahna>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
 <YgC/NQFN7yOffKv3@lahna>
 <BL1PR12MB5144B3A3F70AE921721E1397F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144B3A3F70AE921721E1397F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Feb 07, 2022 at 03:00:19PM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Sent: Monday, February 7, 2022 1:42 AM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>; Andreas Noever
> > <andreas.noever@gmail.com>; open list:PCI SUBSYSTEM <linux-
> > pci@vger.kernel.org>; open list:THUNDERBOLT DRIVER <linux-
> > usb@vger.kernel.org>; Michael Jamet <michael.jamet@intel.com>; Yehezkel
> > Bernat <YehezkelShB@gmail.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
> > 
> > Hi Mario,
> > 
> > On Fri, Feb 04, 2022 at 12:28:18PM -0600, Mario Limonciello wrote:
> > > Various drivers in the kernel use `pci_is_thunderbolt_attached` to
> > > designate behaving differently from a device that is internally in the
> > > machine. This function relies upon the `is_thunderbolt` designation
> > > which checks for a specific capability only set on Intel controllers.
> > >
> > > Non-Intel USB4 designs should also match this designation so that they
> > > can be treated the same regardless of the host they're connected to.
> > 
> > Not objecting this if really needed but since USB4 is supposed to be
> > transparent to the native (tunneled) protocol, I would rather try to figure out
> > if there is really need to change driver behaviour whether it is connected
> > over USB4 or plugged natively on the PCIe slot.
> > 
> > Can you elaborate a bit what kind of functionality needs this? Perhaps we can
> > figure a better alternative?
> 
> In the AMD GPU driver we use it to determine which dGPU is built into
> a platform vs. externally connected since the internal one uses ACPI
> for certain things and the external one does not.  There are probably
> other ways to determine this, but it's not in place at the moment.

Can't you check if the device is behind a hotplug bridge? Then for
certain it is "removable".

The other option is to look for ACPI companion (ACPI_COMPANION()) of the
device. AFAICT dGPUs don't have one (as the BIOS does not know in
advance what will be connected to the hotplug ports) whereas internal
does typically have one.
