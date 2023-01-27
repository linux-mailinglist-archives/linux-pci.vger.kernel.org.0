Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE967DDFC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jan 2023 07:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjA0GvU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Jan 2023 01:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjA0Gux (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jan 2023 01:50:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF05206AF
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 22:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674802084; x=1706338084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1DwKU2AtvWcdYf1CxPBfFRZLdxgXqVeSPGExG68H6A=;
  b=jGicWyR7Samn4JcZy8AtpQrKpw3FemhmBXA5rElq15CIG8G2F39923ty
   7K7PHIHEgrv3UQBOB5nqV+3reFElrJRICiWVrKcF5AJPqEMQkCEp8WWN9
   3qOdwNv2eFC0iw/BirOz+VL3ZwIEOiTOeQ7cI52aFIY8tYQk9rhlSnkN5
   Nml1ftdTcqdNebJulMaaAHcmHuX0wxQNfiv9v/msU5ANuhNK149IAG9mm
   RxmzDbbvG9+a63IFiEMcpwyJ+HWg4LY1fABRFoaLc6z8OCCt8Uie89rgu
   xRZF4Eu6Cqyd7vUqdqnGEoTJbDiTGmKd4dMhm8o/v7riALA/5lKhlKbIK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="324723010"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="324723010"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 22:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="695425394"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="695425394"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2023 22:44:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 54823154; Fri, 27 Jan 2023 08:45:14 +0200 (EET)
Date:   Fri, 27 Jan 2023 08:45:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: Align extra resources for hotplug bridges
 properly
Message-ID: <Y9Ny+ueiR/8RPOg4@black.fi.intel.com>
References: <20230112110000.59974-1-mika.westerberg@linux.intel.com>
 <20230112110000.59974-2-mika.westerberg@linux.intel.com>
 <7b4a981b-2ee8-0021-0c3a-984d6171f680@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b4a981b-2ee8-0021-0c3a-984d6171f680@ixsystems.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 26, 2023 at 11:53:55AM -0500, Alexander Motin wrote:
> Hi Mika,
> 
> Unfortunately my system was de-racked meanwhile, so it will take few more
> days for me to test this.  So far I only successfully built it on my 5.15.79
> kernel.  Meanwhile some comments below:

Okay, take your time and thanks for reviewing!

> 
> On 12.01.2023 05:59, Mika Westerberg wrote:
> > After division the extra resource space per hotplug bridge may not be
> > aligned according to the window alignment so do that before passing it
> > down for further distribution.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >   drivers/pci/setup-bus.c | 25 +++++++++++++++++++------
> >   1 file changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index b4096598dbcb..34a74bc581b0 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1891,6 +1891,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >   	 * resource space between hotplug bridges.
> >   	 */
> >   	for_each_pci_bridge(dev, bus) {
> > +		struct resource *res;
> >   		struct pci_bus *b;
> >   		b = dev->subordinate;
> > @@ -1902,16 +1903,28 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >   		 * hotplug-capable downstream ports taking alignment into
> >   		 * account.
> >   		 */
> > -		io.end = io.start + io_per_hp - 1;
> > -		mmio.end = mmio.start + mmio_per_hp - 1;
> > -		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
> > +		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> > +		align = pci_resource_alignment(dev, res);
> > +		io.end = align ? io.start + ALIGN_DOWN(io_per_hp, align) - 1
> > +			       : io.start + io_per_hp - 1;
> 
> Not bug probably, but if we align x_per_b down for one bridge, we could be
> able to increase it for other(s).

Yeah, the down align is just to make sure we don't run over what is
there because of the splitting. We could for example leave the
"leftovers" to the last bridge or so but I don't think we want to do it
in this patch series to avoid any additional bugs creeping in. Unless
you guys think it needs to be done, of course.

> > +
> > +		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> > +		align = pci_resource_alignment(dev, res);
> > +		mmio.end = align ? mmio.start + ALIGN_DOWN(mmio_per_hp, align) - 1
> > +				 : mmio.start + io_per_hp - 1;
> 
> Here is a typo, it should be mmio_per_hp here   ^^^.

Good catch! I went over these specifically for things like this but I
still missed it :( Will fix in next version.

> > +
> > +		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> > +		align = pci_resource_alignment(dev, res);
> > +		mmio_pref.end = align ? mmio_pref.start +
> > +					ALIGN_DOWN(mmio_pref_per_hp, align) - 1
> > +				      : mmio_pref.start + mmio_pref_per_hp;
> >   		pci_bus_distribute_available_resources(b, add_list, io, mmio,
> >   						       mmio_pref);
> > -		io.start += io_per_hp;
> > -		mmio.start += mmio_per_hp;
> > -		mmio_pref.start += mmio_pref_per_hp;
> > +		io.start += io.end + 1;
> > +		mmio.start += mmio.end + 1;
> > +		mmio_pref.start += mmio_pref.end + 1;
> >   	}
> >   }
> 
> -- 
> Alexander Motin
