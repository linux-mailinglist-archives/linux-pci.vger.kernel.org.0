Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC357E06AB
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345483AbjKCQoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 12:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344250AbjKCQoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 12:44:13 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABDE111;
        Fri,  3 Nov 2023 09:44:08 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SMRM85W5Lz67gDh;
        Sat,  4 Nov 2023 00:40:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 16:44:06 +0000
Date:   Fri, 3 Nov 2023 16:44:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexey Kardashevskiy <aik@amd.com>
CC:     Lukas Wunner <lukas@wunner.de>, <linux-coco@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <jic23@kernel.org>, <suzuki.poulose@arm.com>
Subject: Re: TDISP enablement
Message-ID: <20231103164404.00006e0b@Huawei.com>
In-Reply-To: <4cfe829f-8373-4ff4-a963-3ee74fa39efe@amd.com>
References: <e05eafd8-04b3-4953-8bca-dc321c1a60b9@amd.com>
        <20231101072717.GB25863@wunner.de>
        <20231101110551.00003896@Huawei.com>
        <4cfe829f-8373-4ff4-a963-3ee74fa39efe@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 
> >>> - tdi_info - read measurements/certs/interface report;  
> >>
> >> Does this return cached cert chains and measurements from the device
> >> or does it retrieve them anew?  (Measurements might have changed if
> >> MEAS_FRESH_CAP is supported.)
> >>
> >>  
> >>> If the user wants only CMA/SPDM, the Lukas'es patched will do that without
> >>> the PSP. This may co-exist with the AMD PSP (if the endpoint allows multiple
> >>> sessions).  
> >>
> >> It can co-exist if the pci_cma_claim_ownership() library call
> >> provided by patch 12/12 is invoked upon device_connect.
> >>
> >> It would seem advantageous if you could delay device_connect
> >> until a device is actually passed through.  Then the OS can
> >> initially authenticate and measure devices and the PSP takes
> >> over when needed.  
> > 
> > Would that delay mean IDE isn't up - I think that wants to be
> > available whether or not pass through is going on.
> > 
> > Given potential restrictions on IDE resources, I'd expect to see an explicit
> > opt in from userspace on the host to start that process for a given
> > device.  (udev rule or similar might kick it off for simple setups).
> > 
> > Would that work for the flows described?  
> 
> This would work but my (likely wrong) intention was also to run 
> necessary setup in both host and guest at the same time before drivers 
> probe devices. And while delaying it in the host is fine (well, for us 
> in AMD, as we are aiming for CoCo/TDISP), in the guest this means less 
> flexibility in enlightening the PCI subsystem and the guest driver: 
> ideally (or at least initially) the driver is supposed to probe already 
> enabled and verified device, as otherwise it has to do SWIOTLB until the 
> userspace does the verification and kicks the driver to go proper direct 
> DMA (or reload the driver?).

In the case of a guest getting a VF, there probably won't be any way for
the kernel to run any native attestation anyway, so policy would have to
rely on the CoCo paths. Kernel stuff Lukas has would just not try to attest
or claim anything about it. If a VF has a CMA capable DOE instance
then that's not there for IDE stuff at all, but for the guest to get
direct measurements etc without PSP or anything else getting involved
in which case the guest using that directly is a reasonable thing to do.

> 
> > Next bit probably has holes...  Key is that a lot of the checks
> > may fail, and it's up to host userspace policy to decide whether
> > to proceed (other policy in the secure VM side of things obviously)
> > 
> > So my rough thinking is - for the two options (IDE / TDISP)
> > 
> > Comparing with Alexey's flow I think only real difference is that
> > I call out explicit host userspace policy controls. I'd also like  
> 
> My imagination fails me :) What is the host supposed to do if the device 
> verification fails/succeeds later, and how much later, and the device is 
> a boot disk? Or is this userspace going to be limited to initramdisk? 
> What is that thing which we are protecting against? Or it is for CUDA 
> and such (which yeah, it can wait)?

There are a bunch of non obvious cases indeed.  Hence make it all policy.
Though if you have a flow where verification is needed for boot disk and
it fails (and policy says that's not acceptable) then bad luck you
probably need to squirt a cert into your ramdisk or UEFI or similar.

> 
> > to use similar interfaces to convey state to host userspace as
> > per Lukas' existing approaches.  Sure there will also be in
> > kernel interfaces for driver to get data if it knows what to do
> > with it.  I'd also like to enable the non tdisp flow to handle
> > IDE setup 'natively' if that's possible on particular hardware.
> > 
> > 1. Host has a go at CMA/SPDM. Policy might say that a failure here is
> >     a failure in general so reject device - or it might decide it's up to
> >     the PSP etc.   (userspace can see if it succeeded)
> >     I'd argue host software can launch this at any time.  It will
> >     be a denial of service attack but so are many other things the host
> >     can do.  
> 
> Trying to visualize it in my head - policy is a kernel cmdline or module 
> parameter?

Neither - it's bind not happening until userspace decides to kick it off.
The module could provide it's own policy on top of this - so userspace
could defer to that if it makes sense (so bind but rely on probe failing
if policy not met).

> 
> > 2. TDISP policy decision from host (userspace policy control)
> >     Need to know end goal.  
> 
> /sys/bus/pci/devices/0000:11:22.3/tdisp ?

Maybe - I'm sure we'll bikeshed anything like that :)

> 
> > 3. IDE opt in from userspace.  Policy decision.
> >    - If not TDISP
> >      - device_connect(IDE ONLY) - bunch of proxying in host OS.
> >      - Cert chain and measurements presented to host, host can then check if
> >        it is happy and expose for next policy decision.
> >      - Hooks exposed for host to request more measurements, key refresh etc.
> >        Idea being that the flow is host driven with PSP providing required
> >        services.  If host can just do setup directly that's fine too.  
> 
> I'd expect the user to want IDE on from the very beginning, why wait to 
> turn it on later? The question is rather if the user wants to panic() or 
> warn() or block the device if IDE setup failed.

There are some concerns about being able to support enough selective IDE streams.
Might turn out to be a false concern (I've not yet got visibility of enough
implementations to be able to tell).
Also (as I understand it as a software guy) IDE has a significant performance
and power cost (and for CXL at least there are various trade offs and options
you can enable depending on security model and device features).

There is "talk" of people turning IDE off if they can cope without it and only
enabling for CoCo (and possibly selectively doing that as well)

> 
> >    - If TDISP (technically you can run tdisp from host, but lets assume
> >      for now no one wants to do that? (yet)).
> >      - device_connect(TDISP) - bunch of proxying in host OS.
> >      - Cert chain and measurements presented to host, host can then check if
> >        it is happy and expose for next policy decision.  
> 
> On AMD SEV TIO the TDISP setup happens in "tdi_bind" when the device is 
> about to be passed through which is when QEMU (==userspace) starts.
Ah. Ok.

> 
> > 
> > 4. Flow after this depends on early or late binding (lockdown)
> >     but could load driver at this point.  Userspace policy.
> >     tdi-bind etc.  
> 
> Not sure I follow this. A host or guest driver?

Hmm - I confess I'm confusing myself now.

At this stage we just have enough info to load a driver for the PF because
to get to state we want locked prior to VF assignment the PF driver may
have some configuration to do.

If all that goes well and the TDI can be moved to locked state, and assigned
to a TVM which then has to decide to issue tdi_validate before binding
the guest driver (which I assume is the TDISP START_INTERFACE_REQUEST
bit of the state machine). Or is the guest driver ever needed before this
transition? (I see you called it out as not, but is it always a one time
thing on driver load or can that decision change without unbind/bind
of driver?)

I know this gets more complex for the PF pass through cases where the
driver needs to load and do some setup before you can lock down the device
but do people have that requirement for VFs? If they do it feels like
device was designed wrong to me...

Too many specs (some of which provide too many ways you 'could' do it)
so I may well have a bunch of this wrong :(

Jonathan
