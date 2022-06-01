Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0314539C5C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 06:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiFAExx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 00:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiFAExv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 00:53:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BEF9D06A;
        Tue, 31 May 2022 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654059230; x=1685595230;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2BPmfI7+VWxsW5xSu/b2ZDNOg6Dpg5wYC/5y7r5YRU=;
  b=h/lpOwb2KcUeQDeOo0cLgN3QgChP+EjKbVNym5MViqZYdb/k/SdGdcKe
   ADYZITfrkt/+LGNxfm4uMfuPjUe+x+kXV5qfH8LX3uQZw9GvbRuRahw5G
   c+dwOmCS87YvpAhHdEk2AcH3XZcFoqXm0poSgH2sy4hrTZIvPrnsRMz+k
   jdEgEfrTAPIdFijL+7bL20gH3v/n5WUt6HCDSHTcisSYwi1MVaVRpMiq6
   KN/owp6lOezE0KSGIJKApXB1ek9R1ZxT6ihiqB3hR+IA7WchoTE0QvWur
   YwPkVOLykacArRX9yJmMVpQLAx7C2eprIE94LMgCLkgtnB0byKso3yJbi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275481252"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275481252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 21:53:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="576753246"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 21:53:50 -0700
Date:   Tue, 31 May 2022 21:53:49 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        a.manzanares@samsung.com
Subject: Re: [PATCH v9 3/9] PCI: Create PCI library functions in support of
 DOE mailboxes.
Message-ID: <Ypbw3d/vUyMHGcBW@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-4-ira.weiny@intel.com>
 <20220531172507.5ert5tgwellpe7fx@offworld>
 <20220531175652.qog7xaqmypy36whu@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531175652.qog7xaqmypy36whu@offworld>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 10:56:52AM -0700, Davidlohr Bueso wrote:
> On Tue, 31 May 2022, Davidlohr Bueso wrote:
> 
> > On Tue, 31 May 2022, ira.weiny@intel.com wrote:
> > 
> > > +static void doe_statemachine_work(struct work_struct *work)
> > > +{
> > > +	struct delayed_work *w = to_delayed_work(work);
> > > +	struct pci_doe_mb *doe_mb = container_of(w, struct pci_doe_mb,
> > > +						 statemachine);
> > > +	struct pci_dev *pdev = doe_mb->pdev;
> > > +	int offset = doe_mb->cap_offset;
> > > +	struct pci_doe_task *task;
> > > +	u32 val;
> > > +	int rc;
> > > +
> > > +	mutex_lock(&doe_mb->task_lock);
> > > +	task = doe_mb->cur_task;
> > > +	mutex_unlock(&doe_mb->task_lock);
> > 
> > Instead of a mutex, would it be better to use a rwsem here to protect
> > the state machine and allow for concurrent reads for the work callback?
> > It is a general interface and a trivial change, but not sure how much
> > performance is cared about.
> 
> Actually why is this a sleeping lock at all? Afaict all critical regions
> are short and just deal with loads and stores of oe_mb->task_lock (and
> pci_doe_submit_task also checks the doe_mb->flags with the lock held).
> This could be a spinlock or similarly a rwlock.

This is a good point...  My only excuse is that task_lock used to lock more
than just the cur_task so I suspect that I just kept it as a mutex after a
rework at some point with out thinking about this deeper.

Thinking about it I don't see a benefit to a rwlock.  We don't have multiple
readers.

But I've just looked at this code again and I'm not sure that the exclusion is
correct with regard to the state machine.  I think the state needs to be IDLE
before retire_cur_task() is called or the state machine could be in an invalid
state when the next task runs.  I think there is a bug in the DOE_WAIT_ABORT*
cases when not error and not busy.  In that case there is a race with the next
task getting run the state being DOE_WAIT_ABORT*.  In the timeout case we will
call the mailbox dead.

I can't remember if Jonathan originally locked the state machine or the
task or both.

I think I have fixed it but, I'll look at it again in the morning.

Thanks,
Ira

> 
> Thanks,
> Davidlohr
