Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0B64F123
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiLPSkF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 13:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiLPSjf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 13:39:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F82B243;
        Fri, 16 Dec 2022 10:39:09 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NYd7n1LyCz6HJVH;
        Sat, 17 Dec 2022 02:35:17 +0800 (CST)
Received: from localhost (10.45.152.125) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 18:39:06 +0000
Date:   Fri, 16 Dec 2022 18:39:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 0/9] CXL: Process event logs
Message-ID: <20221216183902.00002bc8@Huawei.com>
In-Reply-To: <639ca459102ad_b41e3294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
        <20221216122531.00001bef@huawei.com>
        <639ca459102ad_b41e3294c7@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.152.125]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Fri, 16 Dec 2022 09:01:13 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Sun, 11 Dec 2022 23:06:18 -0800
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > This code has been tested with a newer qemu which allows for more events to be
> > > returned at a time as well an additional QMP event and interrupt injection.
> > > Those patches will follow once they have been cleaned up.
> > > 
> > > The series is now in 3 parts:
> > > 
> > > 	1) Base functionality including interrupts
> > > 	2) Tracing specific events (Dynamic Capacity Event Record is defered)
> > > 	3) cxl-test infrastructure for basic tests
> > > 
> > > Changes from V3
> > > 	Feedback from Dan
> > > 	Spit out ACPI changes for Bjorn
> > > 
> > > - Link to v3: https://lore.kernel.org/all/20221208052115.800170-1-ira.weiny@intel.com/  
> > 
> > Because I'm in a grumpy mood (as my colleagues will attest!)...
> > This is dependent on the patch that moves the trace definitions and
> > that's not upstream yet except in cxl/preview which is optimistic
> > place to use for a base commit.  The id isn't the one below either which
> > isn't in either mailine or the current CXL trees.  
> 
> I do not want to commit to a new baseline until after -rc1, so yes this
> is in a messy period.

Fully understood. I only push trees out as 'testing' for 0-day to hit
until I can rebase on rc1.

> 
> > Not that I actually checked the cover letter until it failed to apply
> > (and hence already knew what was missing) but still, please call out
> > dependencies unless they are in the branches Dan has queued up to push.
> > 
> > I just want to play with Dave's fix for the RAS errors so having to jump
> > through these other sets.  
> 
> Yes, that is annoying, apologies.
Not really a problem I just felt like grumbling :)

Have a good weekend.

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> > > 
> > > 
> > > Davidlohr Bueso (1):
> > >   cxl/mem: Wire up event interrupts
> > > 
> > > Ira Weiny (8):
> > >   PCI/CXL: Export native CXL error reporting control
> > >   cxl/mem: Read, trace, and clear events on driver load
> > >   cxl/mem: Trace General Media Event Record
> > >   cxl/mem: Trace DRAM Event Record
> > >   cxl/mem: Trace Memory Module Event Record
> > >   cxl/test: Add generic mock events
> > >   cxl/test: Add specific events
> > >   cxl/test: Simulate event log overflow
> > > 
> > >  drivers/acpi/pci_root.c       |   3 +
> > >  drivers/cxl/core/mbox.c       | 186 +++++++++++++
> > >  drivers/cxl/core/trace.h      | 479 ++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxl.h             |  16 ++
> > >  drivers/cxl/cxlmem.h          | 171 ++++++++++++
> > >  drivers/cxl/cxlpci.h          |   6 +
> > >  drivers/cxl/pci.c             | 236 +++++++++++++++++
> > >  drivers/pci/probe.c           |   1 +
> > >  include/linux/pci.h           |   1 +
> > >  tools/testing/cxl/test/Kbuild |   2 +-
> > >  tools/testing/cxl/test/mem.c  | 352 +++++++++++++++++++++++++
> > >  11 files changed, 1452 insertions(+), 1 deletion(-)
> > > 
> > > 
> > > base-commit: acb704099642bc822ef2aed223a0b8db1f7ea76e  
> >   
> 
> I think going forward these base-commits need to be something that are
> reachable on cxl.git. For now I have pushed out a baseline for both Dave
> and Ira's patches to cxl/preview which will rebase after -rc1 comes out.
> 
> Just the small matter of needing some acks/reviews on those lead in
> patches so I can move them to through cxl/pending to cxl/next:


Don't move too fast with Ira's.  Some issues coming up in testing..
(admittedly half of them were things where QEMU hadn't kept up with
what the kernel code now uses).


> 
> http://lore.kernel.org/r/167051869176.436579.9728373544811641087.stgit@dwillia2-xfh.jf.intel.com
> http://lore.kernel.org/r/20221212070627.1372402-2-ira.weiny@intel.com

