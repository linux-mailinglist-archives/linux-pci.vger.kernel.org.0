Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFB634245
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiKVROJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 12:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiKVROI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 12:14:08 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63AF6E577;
        Tue, 22 Nov 2022 09:14:07 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8A7FA100DCEC0;
        Tue, 22 Nov 2022 18:14:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6BAF4A236D; Tue, 22 Nov 2022 18:14:06 +0100 (CET)
Date:   Tue, 22 Nov 2022 18:14:06 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'ira.weiny@intel.com'" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <20221122171406.GC11310@wunner.de>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
 <20221122171309.GA11310@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122171309.GA11310@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now with Thomas added to cc for real.

On Tue, Nov 22, 2022 at 06:13:09PM +0100, Lukas Wunner wrote:
> [+cc Thomas Gleixner, author of dc186ad741c1]
> 
> On Fri, Nov 18, 2022 at 09:20:38AM +0000, David Laight wrote:
> > > From: ira.weiny@intel.com
> > > Sent: 18 November 2022 00:05
> > > 
> > > Work item initialization needs to be done with either
> > > INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> > > allocated.
> > > 
> > > The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> > > stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> > > 
> > > Jonathan suggested creating doe task allocation macros such as
> > > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > > function is not known to the callers and must be initialized correctly.
> > > 
> > > A follow up suggestion was to have an internal 'pci_doe_work' item
> > > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > > could restrict the context where tasks are used.
> > > 
> > > Another idea was to have an intermediate step to initialize the task
> > > struct with a new call.[3]  This added a lot of complexity.
> > > 
> > > Lukas pointed out that object_is_on_stack() is available to detect this
> > > automatically.
> > > 
> > > Use object_is_on_stack() to determine the correct init work function to
> > > call.
> > 
> > This is all a bit strange.
> > The 'onstack' flag is needed for the diagnostic check:
> > 	is_on_stack = object_is_on_stack(addr);
> > 	if (is_on_stack == onstack)
> > 		return;
> > 	pr_warn(...);
> > 	WARN_ON(1);
> > 
> > So setting the flag to the location of the buffer just subverts the check.
> > It that is sane there ought to be a proper way to do it.
> 
> If object_is_on_stack() is sufficient to check whether a struct
> is on the stack or not, why doesn't __init_work() use it to
> auto-detect whether to call debug_object_init_on_stack() or
> debug_object_init()?
> 
> Forcing developers to use a specific initializer for something
> that can be auto-detected is akin to treating them like kids
> and telling them "You didn't say the magic word."
> 
> What's the point?
> 
> Thanks,
> 
> Lukas
