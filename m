Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B167D523F29
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 23:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiEKVCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbiEKVCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 17:02:21 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383E06161E
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 14:02:20 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s23so3334666iog.13
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9KxxV9NPaarLjUn6WnSeaJ1unQjijG7pUlU5QRc31c=;
        b=H+FMOTettN+fuJtHKZqvo9EElI2NN1SPK4306s/OFHXEpdYb2w8lMqMB9SYcHYzNYK
         fPb27VOOqwfpDDqp5639NElcCyMRqOxbTyvlNIvswSaV2AJihPzGq1xo3mRDRoBbdY9Z
         ieamvJCGxKnz7laf6bu3Els3to1eswUjqz7BPVzm8ZEFjlu+mFmArNAeeZ61qgI+39xf
         jp6z/bpGJfGdnhddB5JrTTHjNlonTnbTOU1XAcwGupZCq+QMV5rdjheyamVoOumzLFj6
         uChw2lg4VDkyw1fMCaQlWP3tiyel2InlZRfoUFjbHjqsH2+sUFi5PugWTKBosWZmIjeT
         dhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9KxxV9NPaarLjUn6WnSeaJ1unQjijG7pUlU5QRc31c=;
        b=aHYfZYm3amz5GrOATqr+URPpadB5P91UE/et+5Ad5UH7df/iL1Sj/16dli52zgFO8B
         F9z99+NIWnvxhXqiqTFid9fbOxvCW2Fe+HoFoe+GXosw+2n/oDBlcskF8xI+QVuXHpJF
         uhgSVIVeLnvaRT5Pe8H36Q5nvvwx8tBzNiJFxz3DUGmZl6UW+ExdsZbMmn2kXHuwPmhI
         r3CituSfS2cl6PIKK7uEjgJD/I6nWrj8V0yWEOMo1adfR+WUdKQurEMXvEoZYy7hAjKW
         YTWms3C6hgbDmd4yqdjhP4Bfp5oLaC7xBAhuD1jU4394Zp77SdRSfcQVy0YY/B20TtHN
         X3ug==
X-Gm-Message-State: AOAM533/BpZk/gn2iCE2Kn2IGsrRtfL9C9Z7fpT/QuMCf1fmq/0QZx6s
        ch13ccqF0KSWfRdxJ5ECidOVADkgUs54XCbgLfN2ng==
X-Google-Smtp-Source: ABdhPJwmnOOxYv5I7CBMV+/A8hb0Ch9gPYppkXgsf55Nobqofhk/HsYU3WHgCMZG16BXcmY0HTddv62MCMTE6GPSIAQ=
X-Received: by 2002:a05:6638:34a2:b0:32b:7d4f:8932 with SMTP id
 t34-20020a05663834a200b0032b7d4f8932mr13504775jal.317.1652302939471; Wed, 11
 May 2022 14:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com> <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com>
 <YmzqrqfVLQ9/4KXp@kroah.com> <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
In-Reply-To: <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
From:   Tanjore Suresh <tansuresh@google.com>
Date:   Wed, 11 May 2022 14:02:08 -0700
Message-ID: <CALVARr71u8VD0+zaWbm=6A-1_6gO=bYUm7OM4K5b6kOVz09XOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greg

On Mon, May 2, 2022 at 12:13 PM Tanjore Suresh <tansuresh@google.com> wrote:
>
> On Sat, Apr 30, 2022 at 12:52 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > A: http://en.wikipedia.org/wiki/Top_post
> > Q: Were do I find info about this thing called top-posting?
> > A: Because it messes up the order in which people normally read text.
> > Q: Why is top-posting such a bad thing?
> > A: Top-posting.
> > Q: What is the most annoying thing in e-mail?
> >
> > A: No.
> > Q: Should I include quotations after my reply?
> >
> > http://daringfireball.net/2007/07/on_top
> >
> > On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> > > Rafael,
> > >
> > > That is a good observation, however, many of the use cases in data
> > > centers (deployment of devices in data centers) do not exploit device
> > > power management. Therefore, I'm not sure that is the right way to
> > > design this.
> >
> > Yes it is, enable device power management and use that interface please.
> > Devices in data centers should of course be doing the same thing as
> > everyone else, as it actually saves real money in power costs.  To not
> > do so is very odd.
> >
>
> I guess we are intermixing the  terminology of device power management
> with shutdown.
> My second, third reasoning in my previous e-mail, thought it brings
> out that difference. Maybe not.
> I will try one more time, my thought process on this one.
>
> This patch is only for shutdown. The shutdown can be done in a system
> in various flavors,
> (this may include a power being pulled from the system components when
> all the devices
> are quiescent and it can also be soft shutdown, where power is not
> removed from the system, but system
> could be attempting a reboot)
>
> The device power management allows the device to bring down any
> devices that may be idle to various power states that
> device may support in a selective manner & based on the transition
> allowed by the device. Such a transition initiated by
> the system can be achieved using the 'dpm' interface for runtime power
> management (more for extending laptop battery life).
> It can also be exploited for system sleep models (suspend and resume -
> where state is preserved and restarted from where it left off
> --> More applicable for laptops/desktops). That does not mean data
> center devices cannot exploit, but they worry about slight latency
> variation in any
> I/O initiated to any device. Such power management could introduce
> more latency when it transitions from one state to another.
> Therefore, the use case is more apt for Laptops, in certain cases
> desktops in my opinion or understanding.
>
> The shutdown entry point has been traditionally different and the
> semantics is that the whole system is going down to a
> quiescent state and power may be pulled or may not be, IMO, i am
> seeing both are independent requirements, in my view.
> Let me know if I am mistaken. I am not sure why we should break the
> shutdown semantics as understood by driver developers and
> overload it with dpm requirements?
>

I have not seen additional comments, I request your help
in moving this further, please. If i have missed something,
Please let me know.

Thanks
sureshtk



> Thanks
> sureshtk
>
>
> > thanks,
> >
> > greg k-h
