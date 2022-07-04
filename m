Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9B564DE1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 08:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiGDGpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 02:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiGDGpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 02:45:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF6389D;
        Sun,  3 Jul 2022 23:45:16 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lbx5r1kW5z686XZ;
        Mon,  4 Jul 2022 14:41:04 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 08:45:13 +0200
Received: from localhost (10.81.220.224) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 07:45:11 +0100
Date:   Mon, 4 Jul 2022 07:45:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Kangkang Shen <kshen@futurewei.com>
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support
 of DOE mailboxes.
Message-ID: <20220704074508.00000cac@Huawei.com>
In-Reply-To: <Yr9zroBeSLfWyp5U@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
        <20220628041527.742333-4-ira.weiny@intel.com>
        <20220628151626.00001c0f@Huawei.com>
        <YrtGcNWcmzumj2gA@iweiny-desk3>
        <20220629150947.000012be@Huawei.com>
        <Yr0nysRl7x49me1K@iweiny-desk3>
        <20220630162540.00002910@Huawei.com>
        <Yr9zroBeSLfWyp5U@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.220.224]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
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

On Fri, 1 Jul 2022 15:22:38 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Jun 30, 2022 at 04:25:40PM +0100, Jonathan Cameron wrote:
> > On Wed, 29 Jun 2022 21:34:18 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> >   
> 
> [snip]
> 
> I've dropped the IRQ support and was polishing things up.  Without the IRQ I
> don't think any 'arming' makes sense.
> 
> However, in working through the sequence again I think I found another problem.
> I _think_...  :-/
> 
> > > 
> > > But we are only going to see this if some other entity is using the mailbox
> > > right?  And I don't think that is going to be common, is it?  
> > 
> > BUSY on entry to doe_statemachine_work() is indeed only relevant if
> > some other entity is trampling on us. It's best effort only.
> > 
> > BUSY during normal flow is the one I care about.
> > In most cases it will go like (assuming we clear the int status in the handler as now)
> > 
> >              Send Object
> > BUSY      ________|-----___________________
> > PROC      ________|------------------______
> > OBJ RDY   ___________________________-------
> > Int Status______________-____________-_____  
> 
> So I did not realize that BUSY could clear like this.  I thought the point of
> BUSY was to indicate someone else had an exchange in flight.

Unfortunately the spec doesn't provide any way of indicating 'who' is using
the DOE. All busy says is that right now the mailbox is not capable of receiving
a new request.  Way back in one of the early posting we considered just dropping
the 'best effort' wait that is there, but I think we concluded it was harmless
and might make things a tiny bit more stable if there was something stale
from before OS load.

> 
> What happens if another entity jumps in during the PROC time?  How does one
> know that OBJ RDY is _our_ object ready and not someone else's?

Absolutely.  The reality is that DOE isn't suitable for multi actor use.
We need to put in some mediation.  One thing being neglected on my todo
list is that we need a _DSM in ACPI or similar to negotiate access plus
potentially some firmware interfaces to allow the OS to make firmware
mediated calls.  Those firmware interfaces may be at the protocol level
or even further up the stack.

Not sure if we got to it, but this problem was in the slides for
last years Plumbers uconf talk on DOE.

> 
> For example 'entity' issues a send, we see busy clear and also start a
> send.  But the device is still processing the send from 'entity':
> 
>             Send Object(entity) Send Object (Linux)
> BUSY      ___|----_______________|---______________________________
> PROC      ___|-----------------------------___|-----------------___
> OBJ RDY   _________________________________-------______________---
> Int Status________-__________________-_____-____________________-__
> 
>                                           ^^^
> 					  This...
> 
> ... is _not_ Linux's object!?!?!?!
> 
> Can that happen?

yup.

> 
> If so this is entirely broken.  Even Polling OBJ RDY will break.  And worse yet
> we will not even see BUSY being set in any 'abnormal' way.
> 
> > 
> > where I've added PROC to mean the device is processing the data.
> > Once it clears the input buffer on the device and hence the device can accept
> > another protocol request BUSY will drop.  If device has some pipelining
> > or runs multiple protocols in different threads, you can think of that busy
> > period just being the time it needs to copy out the request to some protocol
> > thread specific storage.  
> 
> BUSY was not at all doing what I thought it did.  I'm now concerned that it is
> completely broken WRT to other entities even without IRQs.  Frankly I'm
> confused why pci_doe_send_req() even checks for busy because it is unlikely
> that we will ever see it set.  For sure we won't from our side because the
> workqueue is going to process one task at a time.

yup, we could drop it, but leave some comment in there that says the spec
suggests checking it.

> 
> If Linux wanted to have multiple objects in flight I think we would need a much
> more complex state machine than we had.  Maybe your original state machine
> handled this.  If so, I apologize for missing this subtle point.

It didn't.  I decided that it wasn't worth the effort :)

> 
> At this point I'm debating removing the check for BUSY as well because I don't
> see the point.  (Other than maybe flagging some error to say that 'entity' may
> be messing things up for us and bailing.)
> 
> Thoughts?

I'm fine with replacing it with comments, or an error print to say that IIRC
the spec says we should wait for it, but reality is that it doesn't work.

Guess I should get on with proposing a _DSM interface to deal with this.
It's a bit messy though as relies on reliable matching of PCI devices against
firmware.  In theory, with the right 'no reenumeration' flags that has a high
chance of working these days but requires some extra language to say that all
bets are off if you reenumerate before figuring out the ACPI to PCI device mapping.
I dropped the ball on getting that element in place.

What fun ;)

Jonathan


> Ira
> 
> > 
> > You won't see this in QEMU without extra hacks because we shorten the
> > flow so that whole thing is instantaneous.
> > 
> > If those two interrupts per transfer occur well spread out they can result in
> > your INT flag being set too often and some of the waits dropping through early.
> > 
> > It will 'work' I think though because you ultimately spin on Data object
> > ready which won't be set until after the second interrupt.
> >   

