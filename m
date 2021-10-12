Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF342AD91
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 22:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhJLUHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 16:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26243 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234166AbhJLUHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Oct 2021 16:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634069121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Izu+rZ+bydrqP5Ea4+zsV5r5PHcw8FRNGYQmKnuuTsQ=;
        b=Qesu7kYU2iLqRQ/fK5gVfhKvN2RjN+d0ZA7SsNAGuzMoVjp88GuNedbUKXUYJN9b9lu6Lb
        4c11FDzauZzDSEMOFjNPLN5/0xC5wDQ2+ERddqu5rDztXopnu97EhPSV/5mH+bE1kGDJda
        ZMpAq8lDokzoO+PsjI/D12gVpI+uDBA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-fozeszAcMSejyaH-H1l5Vw-1; Tue, 12 Oct 2021 16:05:19 -0400
X-MC-Unique: fozeszAcMSejyaH-H1l5Vw-1
Received: by mail-ot1-f72.google.com with SMTP id r3-20020a056830236300b0054d43b72ba5so305527oth.17
        for <linux-pci@vger.kernel.org>; Tue, 12 Oct 2021 13:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Izu+rZ+bydrqP5Ea4+zsV5r5PHcw8FRNGYQmKnuuTsQ=;
        b=GCzdnzj+TTzv8vfKqC73L38kMXX3iUtMkg/ZUyHvzhLt/eM4AO7TsCfiaLQ/Xh+wg5
         BTbz7YI3AnHqH9mclkPkD89NgTOM1EQuypfIobO2HlxS7Fn0A/1gezWWkSCsNwxmRIhX
         CHuVsrrt7VTr8PogBubIOSMz+3jKxToAnLsjjgLaD5PhrEB99uLQaV97JHTmoErE8x5G
         l3EoSOqMxbOYO+X6wvO8fxQuG/6mibV3DT5D0IrhbgiVBriTGw00Z10vnV/dxoDk5mis
         pIBdy6NP+tDlIUej5ZF3TsBXwAq8yBS8l05WZm1wg26jBcyIYQS6ktsUsytiRrqc64Rs
         eXDA==
X-Gm-Message-State: AOAM530iFbrIdfzj5FYrhsFUwBI7bSgb3KM/ZSXx22DxlwUnw1f+Byrz
        prtWTas2VNn5TtxeguRcw6RVYo+jgTXQ3TzHfqfSbBGCN7HcZ88DYzSkiPW6sqyc6XuBo4Qe/6i
        vkkWUMMHBodgVFT4TTeY6
X-Received: by 2002:a9d:1b7:: with SMTP id e52mr23201510ote.352.1634069118749;
        Tue, 12 Oct 2021 13:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypL1uduEwPyz5IFlx9E/9+AA+30xBIuVrw1wb7qiXdQjSf3ur9Ov2wqqb1YqMhwczA/WtR2w==
X-Received: by 2002:a9d:1b7:: with SMTP id e52mr23201490ote.352.1634069118419;
        Tue, 12 Oct 2021 13:05:18 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s18sm2135912otd.55.2021.10.12.13.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:05:18 -0700 (PDT)
Date:   Tue, 12 Oct 2021 14:05:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Ruffell <matthew.ruffell@canonical.com>
Cc:     linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org, nathan.langford@xcelesunifiedtechnologies.com
Subject: Re: [PROBLEM] Frequently get "irq 31: nobody cared" when passing
 through 2x GPUs that share same pci switch via vfio
Message-ID: <20211012140516.6838248b.alex.williamson@redhat.com>
In-Reply-To: <CAKAwkKtJQ1mE3=iaDA1B_Dkn1+ZbN0jTSWrQon0=SAszRv5xFw@mail.gmail.com>
References: <d4084296-9d36-64ec-8a79-77d82ac6d31c@canonical.com>
        <20210914104301.48270518.alex.williamson@redhat.com>
        <9e8d0e9e-1d94-35e8-be1f-cf66916c24b2@canonical.com>
        <20210915103235.097202d2.alex.williamson@redhat.com>
        <2fadf33d-8487-94c2-4460-2a20fdb2ea12@canonical.com>
        <20211005171326.3f25a43a.alex.williamson@redhat.com>
        <CAKAwkKtJQ1mE3=iaDA1B_Dkn1+ZbN0jTSWrQon0=SAszRv5xFw@mail.gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 12 Oct 2021 17:58:07 +1300
Matthew Ruffell <matthew.ruffell@canonical.com> wrote:

> Hi Alex,
> 
> On Wed, Oct 6, 2021 at 12:13 PM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > With both of these together, I'm so far able to prevent an interrupt
> > storm for these cards.  I'd say the patch below is still extremely
> > experimental, and I'm not sure how to get around the really hacky bit,
> > but it would be interesting to see if it resolves the original issue.
> > I've not yet tested this on a variety of devices, so YMMV.  Thanks,  
> 
> Thank you very much for your analysis and for the experimental patch, and we
> have excellent news to report.
> 
> I sent Nathan a test kernel built on 5.14.0, and he has been running the
> reproducer for a few days now.
> 
> Nathan writes:
> 
> > I've been testing heavily with the reproducer for a few days using all 8 GPUs
> > and with the MSI fix for the audio devices in the guest disabled, i.e. a pretty
> > much worst case scenario. As a control with kernel 5.14 (unpatched), the system
> > locked up in 2,2,6,1, and 4 VM reset iterations, all in less than 10 minutes
> > each time. With the patched kernel I'm currently at 1226 iterations running for
> > 2 days 10 hours with no failures. This is excellent. FYI, I have disabled the
> > dyndbg setting.  
> 
> The system is stable, and your patch sounds very promising.

Great, I also ran a VM reboot loop for several days with all 6 GPUs
assigned, no interrupt issues.

> Nathan does have a small side effect to report:
> 
> > The only thing close to an issue that I have is that I still get frequent
> > "irq 112: nobody cared" and "Disabling IRQ #112" errors. They just no longer
> > lockup the system. If I watch the reproducer time between VM resets, I've
> > noticed that it takes longer for the VM to startup after one of these
> > "nobody cared" errors, and thus it takes longer until I can reset the VM again.
> > I believe slow guest behavior in this disabled IRQ scenario is expected though?  
> 
> Full dmesg:
> https://paste.ubuntu.com/p/hz8WdPZmNZ/
> 
> I had a look at all the lspci Nathan has provided me in the past, but 112 isn't
> listed. I will ask Nathan for a fresh lspci so we can see what device it is.
> The interesting thing is that we still hit __report_bad_irq() for 112 when we
> have previously disabled it, typically after 1000+ seconds has gone by.

The device might need to be operating in INTx mode, or at least had
been at some point, to get the register filled.  It's essentially just
a scratch register on the card that gets filled when the interrupt is
configured.

Each time we register a new handler for the irq the masking due to
spurious interrupt will be removed, but if it's actually causing the VM
boot to take longer that suggests to me that the guest driver is
stalled, perhaps because it's expecting an interrupt that's now masked
in the host.  This could also be caused by a device that gets
incorrectly probed for PCI-2.3 compliant interrupt masking.  For
probing we can really only test that we have the ability to set the
DisINTx bit, we can only hope that the hardware folks also properly
implemented the INTx status bit to indicate the device is signaling
INTx.  We should really figure out which device this is so that we can
focus on whether it's another shared interrupt issue or something
specific to the device.

I'm also confused why this doesn't trigger the same panic/kexec as we
were seeing with the other interrupt lines.  Are there some downstream
patches or configs missing here that would promote these to more fatal
errors?

> We think your patch fixes the interrupt storm issues. We are happy to continue
> testing for as much as you need, and we are happy to test any followup patch
> revisions.
> 
> Is there anything you can do to feel more comfortable about the
> PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG dev flag hack? While it works, I can see why
> you might not want to land it in mainline.

Yeah, it's a huge hack.  I wonder if we could look at the interrupt
status and conditional'ize clearing DisINTx based on lack of a pending
interrupt.  It seems somewhat reasonable not to clear the bit masking
the interrupt if we know it's pending and know there's no handler for
it.  I'll try to check if that's possible.  Thanks,

Alex

