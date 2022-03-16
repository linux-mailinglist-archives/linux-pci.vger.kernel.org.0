Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D84DB621
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiCPQ3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 12:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbiCPQ3E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 12:29:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F39FD4
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 09:27:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a5so4467166pfv.2
        for <linux-pci@vger.kernel.org>; Wed, 16 Mar 2022 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YdfDwLcCxjBdFThwwHos9x013CjhNXUSI2ePOCAUr0A=;
        b=iIS9XuZtPG0W5Be9kuSTERIiint31DBY4mh3ylmZoH9Dg3HorEwyYM9h/pjdpx5yX3
         fgMnEdo7U7Wyr2osuRjdEQBgoEgAuiqHSPJ9lIxbUaP+h+2tiylVp7bvWSvcnIuTd/6F
         I27AW6cl8/e0TlxzfCTZtE9O4Y+oX4c/otCS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YdfDwLcCxjBdFThwwHos9x013CjhNXUSI2ePOCAUr0A=;
        b=k7CqWvlZ9CnBIphDeOkXBs0kjkIyDoLzKa/Pqu2tdsYp3mAVC0tpzCUcuCJtRfTIog
         SkPcQdnO8+5tMYo06eTkFxBQBvXzdYSwDq3+FKXXbuftNMq+TvxmXZ5Mn4/8M1pk0lmy
         w7GX2mtLN2+KzXuwvelhoKPnZsCJbRfb/o1mWfiAfVwNlAg20Q72peT3PTl8qhaSJV15
         6FrDMnRtZ7MMUBhHC2FSnvpnAa55zRmTzdnL6MLogCFlRZWzLx8agy/WXYF0sBx2E9+7
         ptdt0Vk0VDKZWvO4lkWInVa8HtaY2CcdN6qCk8ccNqdObJrG50ng1VvEp6fAby0HByTZ
         oFwg==
X-Gm-Message-State: AOAM530TT+g6bIQ4kIJnD2MdG/GRto6MwSygAL0dF1QmbdCWHtsTCweM
        DyiJbQPi10ncLV4gUtI9y6o3SAZ9ILCf0g==
X-Google-Smtp-Source: ABdhPJxva7xZsTK7pkGECCA5lVC+ON1Nrx1iA73AnmCG359irVs9MLBTBJMXbSo6A+5jYzRqoELU/A==
X-Received: by 2002:aa7:9ad8:0:b0:4f7:78d4:de8c with SMTP id x24-20020aa79ad8000000b004f778d4de8cmr121241pfp.38.1647448068048;
        Wed, 16 Mar 2022 09:27:48 -0700 (PDT)
Received: from ebps (vpn.purestorage.com. [192.30.189.1])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090a394e00b001c670d67b8esm847798pjf.32.2022.03.16.09.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 09:27:47 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:27:44 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ebadger@purestorage.com
Subject: Re: [PATCH v2] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220316162744.GA1585319@ebps>
References: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220315171425.GA1521135@ebps>
 <2d4e8811-dce6-c891-e92d-e3746434685e@linux.intel.com>
 <20220315195255.GA1523195@ebps>
 <f794a3fb-4d3a-7e3d-1600-27ee831526fd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f794a3fb-4d3a-7e3d-1600-27ee831526fd@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 02:29:23PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 3/15/22 12:52 PM, Eric Badger wrote:
> > On Tue, Mar 15, 2022 at 10:26:46AM -0700, Sathyanarayanan Kuppuswamy wrote:
> > > On 3/15/22 10:14 AM, Eric Badger wrote:
> > > > >    # Prep injection data for a correctable error.
> > > > >    $ cd /sys/kernel/debug/apei/einj
> > > > >    $ echo 0x00000040 > error_type
> > > > >    $ echo 0x4 > flags
> > > > >    $ echo 0x891000 > param4
> > > > > 
> > > > >    # Root Error Status is initially clear
> > > > >    $ setpci -s <Dev ID> ECAP0001+0x30.w
> > > > >    0000
> > > > > 
> > > > >    # Inject one error
> > > > >    $ echo 1 > error_inject
> > > > > 
> > > > >    # Interrupt received
> > > > >    pcieport <Dev ID>: AER: Root Error Status 0001
> > > > > 
> > > > >    # Inject another error (within 5 seconds)
> > > > >    $ echo 1 > error_inject
> > > > > 
> > > > >    # No interrupt received, but "multiple ERR_COR" is now set
> > > > >    $ setpci -s <Dev ID> ECAP0001+0x30.w
> > > > >    0003
> > > > > 
> > > > >    # Wait for a while, then clear ERR_COR. A new interrupt immediately
> > > > >      fires.
> > > > >    $ setpci -s <Dev ID> ECAP0001+0x30.w=0x1
> > > > >    pcieport <Dev ID>: AER: Root Error Status 0002
> > > > > 
> > > > > Currently, the above issue has been only reproduced in the ICL server
> > > > > platform.
> > > > > 
> > > > > [Eric: proposed reproducing steps]
> > > > Hmm, this differs from the procedure I described on v1, and I don't
> > > > think will work as described here.
> > > 
> > > I have attempted to modify the steps to reproduce it without returning
> > > IRQ_NONE for all cases (which will break the functionality). But I
> > > think I did not correct the last few steps.
> > 
> > Well, the thinking in always returning IRQ_NONE was so that only setpci
> > modified the register and we could clearly see how writes to the
> > register affect interrupt generation.
> 
> Got it. Makes sense.
> 
> > 
> > > How about replacing the last 3 steps with following?
> > > 
> > >   # Inject another error (within 5 seconds)
> > >   $ echo 1 > error_inject
> > > 
> > >   # You will get a new IRQ with only multiple ERR_COR bit set
> > >   pcieport <Dev ID>: AER: Root Error Status 0002
> > 
> > This seems accurate. Though it does muddy a detail that I think was
> > clearer in the original procedure: was the second interrupt triggered by
> > the second error, or by the write of 0x1 to Root Error Status?
> 
> I think you are talking about the following command, right?
> 
> setpci -s <Dev ID> ECAP0001+0x30.w=0x1
> 
> If yes, my previously modified instructions already removed it. So
> no confusion.

The confusion I mention is: "what actually triggers the second
interrupt?" Since I can't find a description of the observed behavior in
the PCIe spec, I find it interesting to know what's actually happening.
Since the procedure we've discussed in this thread stalls in aer_irq(),
you can't distinguish clearly which event causes the second interrupt.

> 
> To summarize,
> 
> In your case, you have controlled both register read/write of Root
> error status register to simulate the interrupt with only multi
> ERR_COR bit set.
> 
> In my case, I have attempted to simulate it without changing the
> default behavior of aer_irq() in the kernel.
> 
> Both seem ok to me. Although my personal preference is to trigger
> the error without changing the code behavior, if both you and Bjorn
> prefer to revert to old instructions, I will fix this in the next version.

I think the amended procedure from this thread is fine to demonstrate
how to play with the patch. The other procedure is available on the list
if anyone has a need for it.

Cheers,
Eric
