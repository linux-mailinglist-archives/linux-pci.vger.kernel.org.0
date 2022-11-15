Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110C262ADF6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 23:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKOWNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Nov 2022 17:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiKOWNC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2022 17:13:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179623E9E;
        Tue, 15 Nov 2022 14:13:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46F20618F5;
        Tue, 15 Nov 2022 22:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72063C433D6;
        Tue, 15 Nov 2022 22:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668550380;
        bh=jh9CtEAIl4VyKEMdbO0r63nNKRHJc4qHe8W+S9YVK/g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d18B8alLG0iRmncEtwhS9oPfkperAKWh5UEwrotkifx/FYTWFcgFFThjfMNiGIb9x
         ZrSw+5MSRBJHGYB1J6WW1AY3uHem3SLWzzulGEkmRoe2DqrA12HLpSO+zMM4pRBp12
         cLX8wO8f3DWvqDv5PxtE2qdlVi3HzofIcJUEIFUZq7GE2gx1h9omDJ7s5Z5VPBorUq
         vDDjU9TNc5H1QZvkMPIQ2chAM43kRro5+W6C6cVTcD3fLqhgnSlZU4/Qn5HZCIUPlR
         NoSOwW+QEtWXhl9LKz7SCxoDPwfKjR5kY708AUIpp6G/Uc0XfgPQohvvVh1BF2TXEO
         9iTKSJsTI7/hw==
Date:   Tue, 15 Nov 2022 16:12:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <20221115221258.GA1053475@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3P8jyhGDIjSAoTT@iweiny-mobl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 15, 2022 at 12:54:39PM -0800, Ira Weiny wrote:
> On Tue, Nov 15, 2022 at 02:41:35PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 15, 2022 at 12:18:38PM -0800, Ira Weiny wrote:
> > > On Tue, Nov 15, 2022 at 01:44:24PM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > The callers of pci_doe_submit_task() allocate the
> > > > > pci_doe_task on the stack.  This causes the work structure
> > > > > to be allocated on the stack without pci_doe_submit_task()
> > > > > knowing.  Work item initialization needs to be done with
> > > > > either INIT_WORK_ONSTACK() or INIT_WORK() depending on how
> > > > > the work item is allocated.
> > > > > 
> > > > > Jonathan suggested creating doe task allocation macros such
> > > > > as DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this
> > > > > is the work function is not known to the callers and must be
> > > > > initialized correctly.
> > > > > 
> > > > > A follow up suggestion was to have an internal
> > > > > 'pci_doe_work' item allocated by pci_doe_submit_task().[2]
> > > > > This requires an allocation which could restrict the context
> > > > > where tasks are used.
> > > > > 
> > > > > Compromise with an intermediate step to initialize the task
> > > > > struct with a new call pci_doe_init_task() which must be
> > > > > called prior to submit task.
> > > > 
> > > > I'm not really a fan of passing a parameter to say "this struct is on
> > > > the stack" because that seems kind of error-prone and I don't know
> > > > what the consequence of getting it wrong would be.  Sounds like it
> > > > *could* be some memory corruption or reading garbage data that would
> > > > be hard to debug.
> > > > 
> > > > Do we have cases today where pci_doe_submit_task() can't do the
> > > > kzalloc() as in your patch at [3]?
> 
> No.
> 
> > > > If the current use cases allow a
> > > > kzalloc(), why not do that now and defer this until it becomes an
> > > > issue?
> 
> I do like pci_doe_submit_task() handling this as an internal detail.
> I'm happy with that if you are.
> 
> I was just concerned about the restriction of context.  Dan
> suggested this instead of passing a gfp parameter.
> 
> If you are happy with my original patch I will submit it instead.
> (With a better one liner.)

I don't know what's coming as far as pci_doe_submit_task() callers.
If there's some imminent caller that will require atomic context, I
guess we could solve it now.  But DOE doesn't really seem like an
atomic context thing to begin with, so maybe we could postpone dealing
with it.

That patch in [3] is more complicated than I expected, but I admit I
haven't looked closely.

Bjorn

> > > > > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > > > > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> > > > 
> > > > [3] https://lore.kernel.org/linux-cxl/Y2AnKB88ALYm9c5L@iweiny-desk3/
