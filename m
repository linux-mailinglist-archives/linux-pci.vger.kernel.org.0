Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CA62D558
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 09:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiKQIpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 03:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbiKQIpP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 03:45:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2B75131C;
        Thu, 17 Nov 2022 00:45:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668674702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFD4940PdGeyc4AycwTJ7Rt3IIqMoidCx43MEiDgKO8=;
        b=kqBokhCHAotNmU+TSkdOcKWyM1/wnNaGUoMkcHb+RsWz3C/lY+B79sn+yqdH1QqGEd3dRL
        OcCowdcDYZFW5GK6M+fp38J6ZWJA3ezRunOT1NGputDqgizUollQLGngmoVPmplggENdsE
        buR2+9ejzgSdvtNPidMwx51raKkiWoBQhK2syksNlLHd1wcFXMiVgeoXuKyTRoSb4ALfne
        8wE+2fwCRu9L0Hhv1GyGtxnx2bi/wnJ8OSSjTAybeCA2CKj9JttEHSN2FmbLvAc8xFsZnx
        0zfPD7WR7c7WiHz5T+ZJ7aBg8acagaPnbUl+Z4AQF3hydkEgpxH6CnoNCdIG9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668674702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MFD4940PdGeyc4AycwTJ7Rt3IIqMoidCx43MEiDgKO8=;
        b=6I0AWqHA8sWxjMJBVsjmucVVAUGrlP0tM/8kTWAYwM21uvnv5BbpzS4ODOCgLPBdmx2BCE
        OQiobakl4xvr1VDg==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
In-Reply-To: <Y3WCN2bAvBvbp/w5@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.500733944@linutronix.de> <Y3UtlTwIka6n0RuT@nvidia.com>
 <87wn7uo7io.ffs@tglx> <Y3WCN2bAvBvbp/w5@nvidia.com>
Date:   Thu, 17 Nov 2022 09:45:02 +0100
Message-ID: <87zgcqm0kx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 20:37, Jason Gunthorpe wrote:
> On Wed, Nov 16, 2022 at 11:32:15PM +0100, Thomas Gleixner wrote:
>> On Wed, Nov 16 2022 at 14:36, Jason Gunthorpe wrote:
>> > On Fri, Nov 11, 2022 at 02:56:50PM +0100, Thomas Gleixner wrote:
>> >> To support multiple MSI interrupt domains per device it is necessary to
>> >> segment the xarray MSI descriptor storage. Each domain gets up to
>> >> MSI_MAX_INDEX entries.
>> >
>> > This kinds of suggests that the new per-device MSI domains should hold
>> > this storage instead of per-device xarray?
>> 
>> No, really not. This would create random storage in random driver places
>> instead of having a central storage place which is managed by the core
>> code. We've had that back in the days when every architecture had it's
>> own magic place to store and manage interrupt descriptors. Seen that,
>> mopped it up and never want to go back.
>
> I don't mean shift it into the msi_domain driver logic, I just mean
> stick an xarray in the struct msi_domain that the core code, and only
> the core code, manages.
>
> But I suppose, on reflection, the strong reason not to do this is that
> the msi_descriptor array is per-device, and while it would work OK
> with per-device msi_domains we still have the legacy of global msi
> domains and thus still need a per-device place to store the global msi
> domain's per-device descriptors.

I tried several approaches but all of them ended up having slightly
different code pathes and decided to keep everything the same from
legacy arch over global MSI and the modern per device MSI models.

Due to that some of the constructs are slightly awkward, but the
important outcome for me was that I ended up with as many shared code
pathes as possible. Having separate code pathes for all variants is for
one causing code bloat and what's worse it's a guarantee for divergance
and maintenance nightmares. As this is setup/teardown management code
and not the fancy hotpath where we really want to spare cycles, I went
for the unified model.

> You could have as many secondary domains as is required this way. Few
> drivers would ever use a secondary domain, so it not really a big deal
> for them to hold the pointer lifetime.
>
>> So what are you concerned about?
>
> Mostly API clarity, I find it very un-kernly to swap a clear pointer
> for an ID #. We loose typing, the APIs become less clear and we now
> have to worry about ID allocation policy if we ever need more than 2.

I don't see an issue with that.

  id = msi_create_device_domain(dev, &template, ...);
  
is not much different from:

  ptr = msi_create_device_domain(dev, &template, ...);

But it makes a massive difference vs. encapsulation and pointer leakage.

If you have a stale ID then you can't do harm, a stale pointer very much
so.

Aside of that once pointers are available people insist on fiddling in
the guts. As I'm mopping up behind driver writers for the last twenty
years now, my confidence in them is pretty close to zero.

So I rather be defensive and work towards encapsulation where ever its
possible. Interrupts are a source of hard to debug subtle bugs, so
taking the tinkerers the tools away to cause them is a good thing IMO.

Thanks,

        tglx
