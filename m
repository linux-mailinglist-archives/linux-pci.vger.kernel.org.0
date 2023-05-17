Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583A77064AC
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 11:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjEQJy0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 May 2023 05:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQJy0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 05:54:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBE63C3A;
        Wed, 17 May 2023 02:54:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLpHh46Bkz6J8Hk;
        Wed, 17 May 2023 17:50:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 17 May
 2023 10:54:22 +0100
Date:   Wed, 17 May 2023 10:54:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>, <yangyicong@huawei.com>,
        <will@kernel.org>, <baolin.wang@linux.alibaba.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <rdunlap@infradead.org>, <mark.rutland@arm.com>,
        <zhuo.song@linux.alibaba.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20230517105421.00003251@Huawei.com>
In-Reply-To: <ZGPW4JzOOUT4ksMf@bhelgaas>
References: <20230516160304.00000544@Huawei.com>
        <ZGPW4JzOOUT4ksMf@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 May 2023 14:17:52 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, May 16, 2023 at 04:03:04PM +0100, Jonathan Cameron wrote:
> > 
> > PCI folks, Question below directed at you. Please take a look.
> > +CC linux-cxl because a similar question is going to bite us shortly
> > if we want CXL PMUs to work well on RP or Switch ports.
> >   
> > > >> +static int dwc_pcie_ras_des_discover(struct dwc_pcie_pmu_priv *priv)
> > > >> +{
> > > >> +    int index = 0;
> > > >> +    struct pci_dev *pdev = NULL;
> > > >> +    struct dwc_pcie_rp_info *rp_info;
> > > >> +
> > > >> +    INIT_LIST_HEAD(&priv->rp_infos);
> > > >> +
> > > >> +    /* Match the rootport with VSEC_RAS_DES_ID */
> > > >> +    for_each_pci_dev(pdev) {    
> > > > 
> > > > Does the PCI layer not offer a more robust mechanism for this?
> > > > (PCI fixups come to mind, but I don't actually know whether that
> > > > would be a viable approach or not.)     
> > > 
> > > I am afraid not yet. Jonathan try to add a PMU service but it is
> > > not merged into mainline.  
> >
> > I wouldn't read much into that 'failure'.  We never persisted with
> > that driver because it was for an old generation of hardware.
> > Mostly the aim with that was to explore the area of PCIe PMU in
> > general rather than to get the support upstream. Some of the
> > counters on that hardware were too small to be of much use anyway :)
> > 
> > Grabbing just relevant functions..
> > 
> > Bjorn, we need to figure out a way forwards for this sort of case
> > and I'd appreciate your input on the broad brush question of 'how
> > should it be done'?
> > 
> > This is a case where a PCIe port (RP here) correctly has the PCIe
> > class code so binds to the pcie_port driver, but has a VSEC (others
> > examples use DOE, or DVSEC) that provides extended functionality.
> > The referred to PCIe PMU from our older Hisilicon platforms did it
> > by adding another service driver - that probably doesn't extend
> > well.
> > 
> > The approach used here is to separately walk the PCI topology and
> > register the devices.  It can 'maybe' get away with that because no
> > interrupts and I assume resets have no nasty impacts on it because
> > the device is fairly simple.  In general that's not going to work.
> > CXL does a similar trick (which I don't much like, but too late
> > now), but we've also run into the problem of how to get interrupts
> > if not the main driver.  
> 
> Yes, this is a real problem.  I think the "walk all PCI devices
> looking for one we like" approach is terrible because it breaks a lot
> of driver model assumptions (no device ID to autoload module via udev,
> hotplug doesn't work, etc), but we don't have a good alternative right
> now.
> 
> I think portdrv is slightly better because at least it claims the
> device in the usual way and gives a way for service drivers to
> register with it.  But I don't really like that either because it
> created a new weird /sys/bus/pci_express hierarchy full of these
> sub-devices that aren't really devices, and it doesn't solve the
> module load and hotplug issues.
> 
> I would like to have portdrv be completely built into the PCI core and
> not claim Root Ports or Switch Ports.  Then those devices would be
> available via the usual driver model for driver loading and binding
> and for hotplug.

Let me see if I understand this correctly as I can think of a few options
that perhaps are inline with what you are thinking.

1) All the portdrv stuff converted to normal PCI core helper functions
   that a driver bound to the struct pci_dev can use.
2) Driver core itself provides a bunch of extra devices alongside the
   struct pci_dev one to which additional drivers can bind? - so kind
   of portdrv handling, but squashed into the PCI device topology?
3) Have portdrv operated under the hood, so all the services etc that
   it provides don't require a driver to be bound at all.  Then
   allow usual VID/DID based driver binding.

If 1 - we are going to run into class device restrictions and that will
just move where we have to handle the potential vendor specific parts.
We probably don't want that to be a hydra with all the functionality
and lookups etc driven from there, so do we end up with sub devices
of that new PCI port driver with a discover method based on either
vsec + VID or DVSEC with devices created under the main pci_dev.
That would have to include nastiness around interrupt discovery for
those sub devices. So ends up roughly like port_drv.

I don't think 2 solves anything.

For 3 - interrupts and ownership of facilities is going to be tricky
as initially those need to be owned by the PCI core (no device driver bound)
and then I guess handed off to the driver once it shows up?  Maybe that
driver should call a pci_claim_port() that gives it control of everything
and pci_release_port() that hands it all back to the core.  That seems
racey.

As another similar proposal to 3 (and one Greg KH will hate :) can we
do something similar to vfio and allow an unbind of a class driver followed by
a bind of a more specific one? 

I think 1 is probably the easiest to implement, but it just moves
the problem.

If we had a way to reliably override the class driver if a more specific
one exists, that might work around the problem but I don't think we
can do that currently.

Jonathan
 

> 
> Bjorn

