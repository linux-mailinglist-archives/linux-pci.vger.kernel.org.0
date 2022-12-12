Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E4464A661
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiLLR6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 12:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiLLR6z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 12:58:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5A117F;
        Mon, 12 Dec 2022 09:58:52 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NW8RM4hlwz6HJTS;
        Tue, 13 Dec 2022 01:55:11 +0800 (CST)
Received: from localhost (10.45.147.154) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 12 Dec
 2022 17:58:49 +0000
Date:   Mon, 12 Dec 2022 17:58:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <20221212175847.00006f85@Huawei.com>
In-Reply-To: <Y5PGEr4Ngrp07CMU@iweiny-desk3>
References: <20221208052115.800170-1-ira.weiny@intel.com>
        <20221208052115.800170-2-ira.weiny@intel.com>
        <639376e1452bd_579c12945c@dwillia2-xfh.jf.intel.com.notmuch>
        <Y5Oh89JFAWYIITUV@iweiny-desk3>
        <6393b7b0e4953_579c1294af@dwillia2-xfh.jf.intel.com.notmuch>
        <Y5PGEr4Ngrp07CMU@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.147.154]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Fri, 9 Dec 2022 15:34:42 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Fri, Dec 09, 2022 at 02:33:20PM -0800, Dan Williams wrote:
> > Ira Weiny wrote:
> > [..]  
> > > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > > index 3a66aadb4df0..86c84611a168 100644
> > > > > --- a/drivers/cxl/pci.c
> > > > > +++ b/drivers/cxl/pci.c
> > > > > @@ -417,8 +417,44 @@ static void disable_aer(void *pdev)
> > > > >  	pci_disable_pcie_error_reporting(pdev);
> > > > >  }
> > > > >  
> > > > > +static void cxl_mem_free_event_buffer(void *buf)
> > > > > +{
> > > > > +	kvfree(buf);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * There is a single buffer for reading event logs from the mailbox.  All logs
> > > > > + * share this buffer protected by the cxlds->event_log_lock.
> > > > > + */
> > > > > +static void cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > > > > +{
> > > > > +	struct cxl_get_event_payload *buf;
> > > > > +
> > > > > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > > > > +		cxlds->payload_size);
> > > > > +
> > > > > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > > > > +	if (WARN_ON_ONCE(!buf))  
> > > > 
> > > > No, why is event init so special that it behaves differently than all
> > > > the other init-time allocations this driver does?  
> > > 
> > > Previous review agreed that a warn on once would be printed if this universal
> > > buffer was not allocated.
> > >   
> > > >   
> > > > > +		return;  
> > > > 
> > > > return -ENOMEM;
> > > >   
> > > > > +
> > > > > +	if (WARN_ON_ONCE(devm_add_action_or_reset(cxlds->dev,
> > > > > +			 cxl_mem_free_event_buffer, buf)))
> > > > > +		return;  
> > > > 
> > > > ditto.  
> > > 
> > > I'll change both of these with a dev_err() and bail during init.  
> > 
> > No real need to dev_err() for a simple memory allocation faliure, but
> > at least it is better than a WARN  
> 
> Ok no error then.
> 
> >   
> > >   
> > > >   
> > > > > +
> > > > > +	cxlds->event.buf = buf;
> > > > > +}
> > > > > +
> > > > > +static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
> > > > > +{
> > > > > +	/* Force read and clear of all logs */
> > > > > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > > > > +	/* Ensure prior partial reads are handled, by starting over again */  
> > > > 
> > > > What partial reads? cxl_mem_get_event_records() reads every log until
> > > > each returns an empty result. Any remaining events after this returns
> > > > are events that fired during the retrieval.  
> > > 
> > > Jonathan was concerned that something could read part of the log and because of
> > > the statefullness of the log processing this reading of the log could start in
> > > the beginning.  Perhaps from a previous driver unload while reading?  
> > 
> > The driver will not unload without completing any current executions of
> > the event retrieval thread otherwise that's an irq shutdown bug.
> >   
> > > I guess I was also thinking the BIOS could leave things this way?  But I think
> > > we should not be here if the BIOS was ever involved right?  
> > 
> > If the OS has CXL Error control and all Event irqs are steered to the OS
> > then the driver must be allowed to assume that it has exclusive control
> > over event retrieval and clearing.

The OS has control once it's asked for it ;)  We have no idea what the firmware
did before that.

> >   
> > > > So I do not think cxl_clear_event_logs() needs to exist, just call
> > > > cxl_mem_get_event_records(CXLDEV_EVENT_STATUS_ALL) once and that's it.  
> > > 
> > > That was my inclination but Jonathan's comments got me thinking I was wrong.  
> > 
> > Perhaps that was before we realized the recent CXL _OSC entanglement.  
> 
> Yea that could have been.  I'm not clear on the order of the comments.

I'm just paranoid - particularly when my excellent firmware writing colleagues
are involved (or our test teams who like to simulate weird sequences of events).

I'm fine crossing fingers until we know there is someone doing this sort of
crazy in the wild.

Jonathan


> 
> Ok this should be good to go.  Reworking the rest of the series.
> 
> Thanks for the review!
> Ira

