Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8353379B800
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjIKXRB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352370AbjIKVpE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 17:45:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4F5252;
        Mon, 11 Sep 2023 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694466969; x=1726002969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdu/qy8147uIVVSTXdWZn2iHz/+9TqVoz5bgFNXyio4=;
  b=d6DhgI3elWCUDyG9EI14WLd+3/UzzR1WqFxMD6DmKA+iNVTK9QH+m47S
   eeHy0G+EkP9ZnXHkRhcbjcTgV43wKZ39qQu/BLWzwiZ5PC8BC5GC8aFVf
   Q9j/jmQXxlsXZj3Gu7BgYc0Iecf/SW+T1nvw4f1Obd8jNJzsFW75C8YNW
   WgRMnnLIdRygpD52cQUrR9zVkN8n7KxNHfHH9Vhi4kvapfkQtOkiFOsxd
   vYVqbmKG+uEATN4MSUCsCBYcnOIyfbv1sG0JGDK69Q7h5xV5rcBPDikn1
   9wsqjFvj37S+SAKcF3bTM9bLPFgi9B4ByS83hCgCO3xPF6Q0rqAdl+lzA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378115893"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378115893"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858492595"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858492595"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:13:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfoE4-008QR8-1H;
        Tue, 12 Sep 2023 00:13:44 +0300
Date:   Tue, 12 Sep 2023 00:13:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, max.zhen@amd.com, sonal.santan@amd.com,
        stefano.stabellini@xilinx.com,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <ZP+DCFqQIKth5eAL@smile.fi.intel.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
 <20230911154856.000076c3@Huawei.com>
 <20230911173503.0db85e4b@bootlin.com>
 <20230911164741.00003904@Huawei.com>
 <20230911172256.00002ee3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911172256.00002ee3@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 11, 2023 at 05:22:56PM +0100, Jonathan Cameron wrote:
> On Mon, 11 Sep 2023 16:47:41 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > On Mon, 11 Sep 2023 17:35:03 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> > > On Mon, 11 Sep 2023 15:48:56 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > > > On Tue, 15 Aug 2023 10:19:57 -0700
> > > > Lizhi Hou <lizhi.hou@amd.com> wrote:

> > > > > The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> > > > > spaces from multiple hardware peripherals to its PCI BAR. Normally,
> > > > > the PCI core discovers devices and BARs using the PCI enumeration process.
> > > > > There is no infrastructure to discover the hardware peripherals that are
> > > > > present in a PCI device, and which can be accessed through the PCI BARs.
> > > > > 
> > > > > Apparently, the device tree framework requires a device tree node for the
> > > > > PCI device. Thus, it can generate the device tree nodes for hardware
> > > > > peripherals underneath. Because PCI is self discoverable bus, there might
> > > > > not be a device tree node created for PCI devices. Furthermore, if the PCI
> > > > > device is hot pluggable, when it is plugged in, the device tree nodes for
> > > > > its parent bridges are required. Add support to generate device tree node
> > > > > for PCI bridges.
> > > > > 
> > > > > Add an of_pci_make_dev_node() interface that can be used to create device
> > > > > tree node for PCI devices.
> > > > > 
> > > > > Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> > > > > the kernel will generate device tree nodes for PCI bridges unconditionally.
> > > > > 
> > > > > Initially, add the basic properties for the dynamically generated device
> > > > > tree nodes which include #address-cells, #size-cells, device_type,
> > > > > compatible, ranges, reg.
> > > > > 
> > > > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>      
> > > > 
> > > > I tried to bring this up for a custom PCIe card emulated in QEMU on an ARM ACPI
> > > > machine.
> > > > 
> > > > There are some missing parts that were present in Clements series, but not this
> > > > one, particularly creation of the root pci object.
> > > > 
> > > > Anyhow, hit an intermittent crash...    
> > > 
> > > I am facing the same issues.
> > > 
> > > I use a custom PCIe board too but on x86 ACPI machine.
> > > 
> > > In order to have a working system, I need also to build a DT node for the PCI
> > > Host bridge (previously done by Clement's patch) and I am a bit stuck with
> > > interrupts.
> > > 
> > > On your side (ACPI machine) how do you handle this ?  
> > 
> > That was next on my list to look at now I've gotten the device tree stuff
> > to show up.
> > 
> > > I mean is your PCI host bridge provided by ACPI ? And if so, you probably need
> > > to build a DT node for this PCI host bridge and add some interrupt-map,
> > > interrupt-map-mask properties in the DT node.  
> > 
> > Agreed. Potentially some other stuff, but interrupts are the thing that
> > showed up first as an issue.
> > 
> > Given the only reason I'm looking at this is to potentially solve
> > a long term CXL / MCTP over I2C upstreaming problem on QEMU side, I've only
> > limited time to throw at this (thought it was a short activity
> > for a Friday afternoon :)  Will see if it turns out not too be
> > too hard to build the rest.
> > 
> > I can at least boot same system with device tree and check I'm matching
> > what is being generated by QEMU.
> 
> So, I'm not really sure how to approach this.  It seems 'unwise'/'unworkable' to
> instantiate the device tree blob for the interrupt controller we already have
> ACPI for and without that I have nothing to route to.
> 
> Or can we just ignore the interrupt map stuff completely and instead
> rely on instantiating an interrupt controller on the card (that under
> the hood uses non DT paths to make interrupts actually happen?)
> 
> That path to me seems workable and keeps the boundary of ACPI vs DT
> actually getting used within the card specific driver.
> 
> Suggestions welcome!

Interestingly I haven't got your message in the thread via `b4`.
Anyways, I think that was has been discussed at some point and
DT appears just to be handy blob format to be supplied along with
the device as "description of its configuration". Whatever format
is chosen it should be available for ACPI/DT/etc platforms and
be uniform. ACPI also supports overlays (as a debug feature, though)
but would it make sense to have AML (compiled ASL) for ACPI and DTB
for DT platforms and etc for etc platforms with duplicative data
inside with all limitations of the each of those formats and their
respective parsers/interpreters?

-- 
With Best Regards,
Andy Shevchenko


