Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B906349C5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiKVWGP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 22 Nov 2022 17:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiKVWGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 17:06:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D7368287
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2022 14:06:08 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-254-sgcAsR24PNu03owwWGE96w-1; Tue, 22 Nov 2022 22:06:05 +0000
X-MC-Unique: sgcAsR24PNu03owwWGE96w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 22 Nov
 2022 22:06:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 22 Nov 2022 22:06:04 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dan Williams' <dan.j.williams@intel.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     "'ira.weiny@intel.com'" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Thread-Topic: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Thread-Index: AQHY+uF8IwLsQKEiakO+LlTXtrnK365EZJiQgAcGD4iAABtQEA==
Date:   Tue, 22 Nov 2022 22:06:04 +0000
Message-ID: <f2beb27f87d44ae180d1fe9f040442a0@AcuMS.aculab.com>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <20221122171309.GA11310@wunner.de> <20221122171406.GC11310@wunner.de>
 <637d2f98db8b_12cdff29464@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <637d2f98db8b_12cdff29464@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams
> Sent: 22 November 2022 20:23
...
> > > > > Lukas pointed out that object_is_on_stack() is available to detect this
> > > > > automatically.
> > > > >
> > > > > Use object_is_on_stack() to determine the correct init work function to
> > > > > call.
> > > >
> > > > This is all a bit strange.
> > > > The 'onstack' flag is needed for the diagnostic check:
> > > > 	is_on_stack = object_is_on_stack(addr);
> > > > 	if (is_on_stack == onstack)
> > > > 		return;
> > > > 	pr_warn(...);
> > > > 	WARN_ON(1);
> > > >
> > > > So setting the flag to the location of the buffer just subverts the check.
> > > > It that is sane there ought to be a proper way to do it.
> > >
> > > If object_is_on_stack() is sufficient to check whether a struct
> > > is on the stack or not, why doesn't __init_work() use it to
> > > auto-detect whether to call debug_object_init_on_stack() or
> > > debug_object_init()?
> > >
> > > Forcing developers to use a specific initializer for something
> > > that can be auto-detected is akin to treating them like kids
> > > and telling them "You didn't say the magic word."
> > >
> > > What's the point?
> 
> I had this initial reaction as well, but INIT_WORK_ONSTACK() documents
> an important detail of the object's lifetime. Here are 2 examples of
> functions that would become trickier to read if the kernel did a
> global s/INIT_WORK_ONSTACK()/INIT_WORK()/
> 
>     synchronize_rcu_expedited_queue_work()
>     insert_wq_barrier()
> 
> ...where those take arguments that are known to come from the stack and
> be used in async context.

I suspect the check was added in response to some code that added
on on-stack item and then slept after returning from that function.

One option would be to change the diagnostic check to:
	is_on_stack != !object_is_on_stack(addr)
and then pass in 2 so the test always succeeds.
But I suspect that won't be liked.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

