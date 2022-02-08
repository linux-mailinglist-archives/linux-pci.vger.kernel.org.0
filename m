Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4614AD199
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 07:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiBHGd0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 01:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiBHGdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 01:33:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D1C0401EF;
        Mon,  7 Feb 2022 22:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644302004; x=1675838004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9jg7rs/9d9B2nZhgpl+jOoQzcAvvsYwCDrq5DLE+r60=;
  b=Geegj7pnVulhFAmm5CS0w+FTCNVhuMKXMNEvUkrFnG+SiAM5Vz4QVFI5
   N8L57if67/zDsm1IECxqUu2RTULMC+U9mvBnqi29sDIFZpUwGha9cQM0B
   T/Mvg0+g9sFudSGSGfJ3OCcXCI+JF2i5WHgyzppBCTej0anoUfawCDXio
   cu1n+EXbD78JDMLK4/Nx2/subrnb5G7xdlQjSUcwVVHO5ysJ8PG4A7neM
   /b40PL/QyGLR24pl1P5XM10ZHIycJ+IpPqPYy6c+jlYjLKjr9/vy2p3HK
   5FS0LeW00Wd7a9kR6K/9y+3R/fS3nAPfJZbvkJ1W9w9J538fjtneoKCby
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="312181870"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="312181870"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:33:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="484704520"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:33:21 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Feb 2022 08:33:18 +0200
Date:   Tue, 8 Feb 2022 08:33:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [PATCH 0/2] Mark USB4 controllers as is_thunderbolt
Message-ID: <YgIOro/30ouh27TU@lahna>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
 <YgC/NQFN7yOffKv3@lahna>
 <BL1PR12MB5144B3A3F70AE921721E1397F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <YgE+g9JOJE6foThi@lahna>
 <BL1PR12MB51442184B407A747E4C487F1F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20220207174703.GA25761@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207174703.GA25761@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Feb 07, 2022 at 06:47:03PM +0100, Lukas Wunner wrote:
> On Mon, Feb 07, 2022 at 03:52:13PM +0000, Deucher, Alexander wrote:
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > The other option is to look for ACPI companion (ACPI_COMPANION()) of the
> > > device. AFAICT dGPUs don't have one (as the BIOS does not know in advance
> > > what will be connected to the hotplug ports) whereas internal does typically
> > > have one.
> > 
> > Yeah, this is probably the right way to do this.
> 
> No, that doesn't work.  At least Apple represents the first few devices
> in the Thunderbolt daisy-chain in the ACPI namespace, so IIUC you'd find
> an ACPI companion for those but not for the remainder of the daisy-chain.
> This is from a 2019/2020 MacBookPro16,1:
> 
> $ grep 'Device ' acpidump/mbp161/ssdt6.dsl
>             Device (UPSB)
>                 Device (DSB0)
>                     Device (NHI0)
>                 Device (DSB1)
>                     Device (UPS0)
>                         Device (DSB0)
>                             Device (DEV0)
>                         Device (DSB3)
>                             Device (UPS0)
>                                 Device (DSB0)
>                                     Device (DEV0)
>                                 Device (DSB3)
>                                     Device (DEV0)
>             ...
> 
> There's a *reason* why I introduced the is_thunderbolt flag,
> there is no other reliable way to detect externally attached devices.

In case of dGPU, the thing (I think) that is needed is whether there is
some sort of power resource attached to the root port that allows
powering it down or so. That can still be done without is_thunderbolt
flag using the current ACPI functions.

[ IMHO we should get rid of that flag completely, or rename it to some
 more generic like "removable" (following USB, perhaps moving to driver
 core) that allows drivers to check if the device is soldered on the
 motherboard or hanging off of some hotpluggable port. ]
