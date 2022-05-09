Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A792851FA82
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiEIKyV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 06:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiEIKyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 06:54:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F661660B4;
        Mon,  9 May 2022 03:50:10 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KxbWH2DMgz6802B;
        Mon,  9 May 2022 17:30:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 11:33:55 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 10:33:54 +0100
Date:   Mon, 9 May 2022 10:33:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linuxarm <linuxarm@huawei.com>, "Weiny, Ira" <ira.weiny@intel.com>,
        "Linux PCI" <linux-pci@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220509103352.00001085@Huawei.com>
In-Reply-To: <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
        <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 6 May 2022 15:40:25 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> [ add Lukas and Chuck ]
> 
> On Tue, May 3, 2022 at 8:35 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > So far, we have been considering Data Object Exchange (DOE) mailboxes only
> > on EPs (CXL type 3 devices).
> > CXL CDAT (technically CXL Table Query Protocol but lets just call it CDAT)
> >   https://lore.kernel.org/linux-cxl/20220414203237.2198665-1-ira.weiny@intel.com
> > CMA/SPDM support
> >   https://lore.kernel.org/linux-cxl/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
> >
> > However, a number of DOE protocols apply to switch (and root) ports.
> > DOE instances supporting CDAT occur on switch upstream ports as well as EPs.
> >
> > DOE instances supporting CMA may occur in root ports, upstream switch ports,
> > downstream switch ports and EPs (including multiple functions where relevant).
> >  
> 
> So, like you, I was envisioning all the CMA and SPDM code landing in
> the kernel until I read this:
> 
> "Extending in-kernel TLS support"
> https://lwn.net/Articles/892216/
> 
> ...and questioned why this new CMA/SPDM session establishment, which
> is similar to TLS, be done inside the kernel while TLS session
> establishment is done in userspace? I had a chance to chat with Chuck
> at LSF/MM and confirmed there is little appetite to change this
> up-call requirement for session establishment and expect CMA to be the
> same. The rough idea of how this works with CMA/SPDM is providing an
> ABI to retrieve session setup data with the end result of userspace
> instantiating a keyid via keyctl the to be used for future SPDM
> messages.

I've also begun messing around with MCTP based transport and current
MCTP subsystem exposes everything via sockets.  Mainly I wanted to
mess around with emulating the FM-API stuff but SPDM (attestation anyway)
is also somewhat plausible.

In that particular case we 'could' do it in kernel I think but it seems
a little crazy and a userspace only (or mostly) solution is probably better.
My current thinking is that if we just had DOE then a kernel only solution
is fairly clean and simple, but chances are the same infrastructure
will be used with other transports where that's not true....

One side point here is I'm not sure we can build on libspdm without substantial
surgery - so we may well end up spinning something new in userspace.
libspdm does it's job as a reference implementation but it's not currently
friendly to being integrated in anything else.

I'd be nervous about drawing any firm conclusions on moving
the sessions setup to userspace until a prototype is up and running.
It feels like it would work fine, but I never trust my feelings ;)

I'll carry on with the MCTP emulation over next week or so and see
where I end up with that.

> 
> > The intent of this RFC is to discuss how to actually implement such support.
> > The attached patch is a really rough PoC for CDAT on upstream switch ports
> > done by adding a new pcie_port_service_driver.  This is different from the
> > proposed auxiliary device used for CXL type 3 devices (for now).  
> 
> CDAT to me is on the "CXL" side of a given PCI device. Given that
> endpoints and switches are each represented by cxl_port objects it
> seems those should generically carry the CDAT binary attribute, not
> the PCI device, don't you think?

Sure, the current approach is definitely a hack.  I think
the DOE itself needs to be managed by the PCIe side of things, but the
individual protocols then instantiated by various drivers.  Some
of those may become 'standard'.

What I definitely didn't want was to end up with aux drivers on aux
drivers.  If we just add this to the cxl_port that's fine for CDAT.
Some of the other protocols may end up looking like
this PoC though (CDAT is just the easiest to hack in so I used that
as an example :) 

> 
> >
> > So open questions:
> >
> > 1. Granularity. Should we do a driver per group of protocols that may
> >    be collocated, or one per DOE instance. For now, we might be looking
> >    at CDAT as done for this PoC, and CMA/IDE.  
> 
> The more time goes by the more I am coming around to Bjorn's initial
> reaction to all this that DOE is closer to a VPD model than an
> auxiliary_device model or pcie_port_device model.
> 
> I.e. have some common discovery in the PCI core for enumerating DOE
> instances and advertisting protocols, but otherwise leave it up to
> individual leaf drivers like cxl_pci or cxl_port to use that core to
> run a given protocol.

Sounds pretty close to where we started with earlier versions (v3 for example)
https://lore.kernel.org/linux-cxl/20210419165451.2176200-4-Jonathan.Cameron@huawei.com/
of the DOE set though we kicked off enumeration by PCI core code via an explicit call
to pci_doe_register_all().  The reasoning behind that was the need for interrupts.

We could play a similar game to I did in this series and do discovery
via polling and then bring up interrupts once available.
It's a bit clunky. Either:
a) When first protocol is requested by a driver, check if the device happens to
   have appropriate interrupts enabled then use them.
b) Have the request for a protocol explicitly request interrupts on basis
   the driver has figured out what vectors are needed and enabled them.

Either is a pretty horrible layer crossing given you'd typically not want the
CXL or similar driver to be that aware of interrupt vector info from the DOE
capability, but the only way it can find out what vectors to enable is to do
what the pci port driver does and walk all the capabilities that might need
a vector and find the max value that is specified anywhere.

I suppose we 'could' add a pci_vectors_get_std_max()
or something like that to paper over this.  Idea being the driver would
know about any other vectors that aren't specified in standards defined
capabilities.

I suspect we'll still end up with some DOE protocol drivers as pci port
services drivers (or a newer version of something similar) as they will
occur on generic PCI ports so there is nothing else to hang them off.

> 
> > 2. Use of a pcie_port_service_driver a reasonable way to do this?
> > 3. Service provision. It is likely that all of the protocols defined
> >    above will be used as part of activities that span multiple devices.
> >    a) CDAT used to establish latencies and bandwidth between host CPU
> >       and memory on a CXL type 3 device beyond one or more CXL switches.
> >    b) CMA.  Might just be used to provide simple device attestation
> >       and potentially lock out the upstream port above a switch if the
> >       switch does not pass attestation.  Many many other uses possible...  
> 
> Per above once userspace has installed an SPDM session keyid for a
> given PCI device it can also optionally set an 'authorized' attribute
> (similiar to what USB and Thunderbolt have) to indicate whether a
> device has passed attestation. As for the actual protocols that are
> going to run over the SPDM session those would need their own drivers
> that reference the established keyid.

Ok. That flow seems to make sense (at first glance).

> 
> >    c) Secure CMA / IDE. Likely to be used to set up link IDE.  What
> >       this will look like is a question I've not really started
> >       thinking about yet.
> >
> >    So how do we support this?  If nothing else we need to make sure
> >    the drivers for the port don't go away whilst in use.  
> 
> Another reason to make it a core aspect of the PCI device like VPD so
> there are no entanglements beyond "PCI device exists".

Hmm. I'm not totally sure that will be enough but 'maybe'.  Guess we'll
see as things come together.

> 
> > The patch is a very early PoC just to show it would 'work'...
> >
> > Note I am keen to not have the discussion around this support delay
> > Ira's series.  
> 
> Is there a nearer term forcing function for this? I.e. v5.20 seems to
> be where the current DOE series is going to intercept. I think abandon
> the "aux" organization for now and make DOE like VPD.

Main forcing function is the nebulous fact that we all keep forgetting
how this works and having to spend non trivial time getting back into
it. 5.20 cycle is probably fine given timing of anything
else landing.

Jonathan



