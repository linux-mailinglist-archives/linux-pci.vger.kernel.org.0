Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E712762C785
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238874AbiKPSUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbiKPSUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:20:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB644299B;
        Wed, 16 Nov 2022 10:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7627B81DFB;
        Wed, 16 Nov 2022 18:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25648C433C1;
        Wed, 16 Nov 2022 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668622839;
        bh=52xx2cxMjYfYYtzcGVPoVln7tb0sgoWGLZmi9fAr4go=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ww2k/scGtapdtys5K2gcUYKS8Vp1Yxq9BnwvvbuwB4F0J1h7DZfFpPW77ePZvuUSv
         wO1Hx4qGsfRcdrpkRyWN4TUfoAo4/E1eLE5lcE91aC1NSd1RFhIGKZg52bE4Xa/hA6
         YcCPc5gWWB6nlJGwxIMUZ8HLuH8ZE76AM5+hl83sPv3XZUbNY8/oLHaW4Ihkk3KsK8
         JVrmD5skUyi4qDf/Wa5mTmvLe7cpaP0ADnCLUpFyuxXaNXlsE7wRr/878CNDcrti75
         iq+hX28bwPscDMEboURMgvrNW0RAiqZwsmgAyslR06o9YcZum0qcTh3XBlcitncW6+
         6L+cEj03x788g==
Date:   Wed, 16 Nov 2022 12:20:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/doe: Fix work struct declaration
Message-ID: <20221116182037.GA1127308@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116100939.GA32050@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 11:09:39AM +0100, Lukas Wunner wrote:
> On Mon, Nov 14, 2022 at 05:19:43PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The callers of pci_doe_submit_task() allocate the pci_doe_task on the
> > stack.  This causes the work structure to be allocated on the stack
> > without pci_doe_submit_task() knowing.  Work item initialization needs
> > to be done with either INIT_WORK_ONSTACK() or INIT_WORK() depending on
> > how the work item is allocated.
> > 
> > Jonathan suggested creating doe task allocation macros such as
> > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > function is not known to the callers and must be initialized correctly.
> > 
> > A follow up suggestion was to have an internal 'pci_doe_work' item
> > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > could restrict the context where tasks are used.
> > 
> > Compromise with an intermediate step to initialize the task struct with
> > a new call pci_doe_init_task() which must be called prior to submit
> > task.
> > 
> > [1] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m88a7f50dcce52f30c8bf5c3dcc06fa9843b54a2d
> > [2] https://lore.kernel.org/linux-cxl/20221014151045.24781-1-Jonathan.Cameron@huawei.com/T/#m63c636c5135f304480370924f4d03c00357be667
> 
> We have object_is_on_stack(), included from <linux/sched/task_stack.h>.
> 
> So you could just autosense in pci_doe_submit_task() whether
> pci_doe_task is on the stack and call the appropriate INIT_WORK
> variant.

Nifty, I had no idea object_is_on_stack() existed, thank you!

I wonder if there's an opportunity to use object_is_on_stack()
somewhere in the INIT_WORK() path to find usage mistakes.

Adding it in pci_doe_submit_task() would add some complexity, so I'm
not sure whether it's worth adding it unless we actually have uses for
both cases.

Bjorn
