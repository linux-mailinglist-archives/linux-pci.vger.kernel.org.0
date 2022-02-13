Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8404B3A45
	for <lists+linux-pci@lfdr.de>; Sun, 13 Feb 2022 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiBMIjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 03:39:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiBMIjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 03:39:36 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5655EDDA
        for <linux-pci@vger.kernel.org>; Sun, 13 Feb 2022 00:39:31 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 68846300002A0;
        Sun, 13 Feb 2022 09:39:28 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5AF1C2DEC3C; Sun, 13 Feb 2022 09:39:28 +0100 (CET)
Date:   Sun, 13 Feb 2022 09:39:28 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH v2 3/9] PCI: drop `is_thunderbolt` attribute
Message-ID: <20220213083928.GB23572@wunner.de>
References: <20220210224329.2793-1-mario.limonciello@amd.com>
 <20220210224329.2793-4-mario.limonciello@amd.com>
 <YgY5N1eVWmi0Xyuw@lahna>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgY5N1eVWmi0Xyuw@lahna>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 12:23:51PM +0200, Mika Westerberg wrote:
> On Thu, Feb 10, 2022 at 04:43:23PM -0600, Mario Limonciello wrote:
> > @@ -2955,7 +2955,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> >  			return true;
> >  
> >  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> > -		if (bridge->is_thunderbolt)
> > +		if (dev_is_removable(&bridge->dev))
> 
> For this, I'm not entirely sure this is what we want. The purpose of
> this check is to enable port power management of Apple systems with
> Intel Thunderbolt controller and therefore checking for "removable" here
> is kind of misleading IMHO.
[...]
> and then make a quirk in quirks.c that adds the software node property
> for the Apple systems? Or something along those lines.

Honestly, that feels wrong to me.

There are non-Apple products with Thunderbolt controllers,
e.g. Supermicro X10SAT was a Xeon board with Redwood Ridge
which was introduced in 2013.  This was way before Microsoft
came up with the HotPlugSupportInD3 property.  It was also way
before the 2015 BIOS cut-off date that we use to disable
power management on older boards.

Still, we currently whitelist the Thunderbolt ports on that
board for D3 because we know it works.  What if products like
this one use their own power management scheme and we'd cause
a power regression if we needlessly disable D3 for them now?

Thanks,

Lukas
