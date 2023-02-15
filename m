Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF12697CF6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 14:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjBONRO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 08:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjBONRN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 08:17:13 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340C2528C;
        Wed, 15 Feb 2023 05:17:09 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGz8X2tFFz6J9rm;
        Wed, 15 Feb 2023 21:15:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 15 Feb
 2023 13:17:07 +0000
Date:   Wed, 15 Feb 2023 13:17:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 13/18] cxl: Add latency and bandwidth calculations for
 the CXL path
Message-ID: <20230215131706.0000592d@Huawei.com>
In-Reply-To: <8b2bbf7b-fe3f-c80b-163b-8247e0c47821@intel.com>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571667794.587790.14172786993094257614.stgit@djiang5-mobl3.local>
        <20230209152417.00007f47@Huawei.com>
        <8b2bbf7b-fe3f-c80b-163b-8247e0c47821@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Feb 2023 16:03:27 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 2/9/23 8:24 AM, Jonathan Cameron wrote:
> > On Mon, 06 Feb 2023 13:51:19 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> >   
> >> CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
> >> caluclate latency and bandwidth for CXL memory device. Calculate minimum  
> > 
> > Spell check your descriptions (I often forget to do this as well!
> > )  
> >> bandwidth and total latency for the path from the CXL device to the root
> >> port. The calculates values are stored in the cached DSMAS entries attached
> >> to the cxl_port of the CXL device.
> >>
> >> For example for a device that is directly attached to a host bus:
> >> Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
> >> 		Latency
> >> Min Bandwidth = Link Bandwidth between Host Bus and CXL device
> >>
> >> For a device that has a switch in between host bus and CXL device:
> >> Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
> >> 		Switch (CDAT) Latency + Switch to HB Link Latency  
> > 
> > For QTG purposes, are we also supposed to take into account HB to
> > system interconnect type latency (or maybe nearest CPU?).
> > That is likely to be non trivial.  
> 
> Dan brought this ECN [1] to my attention. We can add this if we can find 
> a BIOS that implements the ECN. Or should we code a place holder for it 
> until this is available?
> 
> https://lore.kernel.org/linux-cxl/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/

I've had Generic Ports on my list to add to QEMU for a while but not been
high enough priority to either do it myself, or make it someone else's problem.
I suspect the biggest barrier in QEMU is going to be the interface to add
these to the NUMA description.

It's easy enough to hand build and inject a SRAT /SLIT/HMAT tables with
these in (that's how we developed the Generic Initiator support in Linux before
any BIOS support).  

So I'd like to see it soon, but I'm not hugely bothered if that element
follows this patch set. However, we are potentially going to see different
decisions made when that detail is added so it 'might' count as ABI
breakage if it's not there from the start. I think we are fine as probably
no BIOS' yet though.

> 
> >   
> >> Min Bandwidth = min(dev to switch bandwidth, switch to HB bandwidth)
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> > 
> > Stray sign off.
> >   
> >>
> >> The internal latency for a switch can be retrieved from the CDAT of the
> >> switch PCI device. However, since there's no easy way to retrieve that
> >> right now on Linux, a guesstimated constant is used per switch to simplify
> >> the driver code.  
> > 
> > I'd like to see that gap closed asap. I think it is fairly obvious how to do
> > it, so shouldn't be too hard, just needs a dance to get the DOE for a switch
> > port using Lukas' updated handling of DOE mailboxes.  
> 
> Talked to Lukas and this may not be difficult with his latest changes. I 
> can take a look. Do we support switch CDAT in QEMU yet?

I started typing no, then thought I'd just check.  Seems I did write support
for CDAT on switches (and then completely forgot about it ;)
It's upstream and everything!
https://elixir.bootlin.com/qemu/latest/source/hw/pci-bridge/cxl_upstream.c#L194

