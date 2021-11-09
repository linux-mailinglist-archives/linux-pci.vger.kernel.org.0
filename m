Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF51644B93C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 00:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhKIXNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 18:13:15 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:44992 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbhKIXNP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 18:13:15 -0500
Received: by mail-lf1-f50.google.com with SMTP id y26so1222921lfa.11;
        Tue, 09 Nov 2021 15:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6/AawMmLvnrRM8qcoM5kX5zFFgfGx8/ds9DCBn/vpEk=;
        b=xC3lp8gD47V4OZX8aoy7xs+q8BtjczBThWuOg4dYhu/1kMon66qDavuu2Gt13dcPdV
         pwCF7KSzyRcc6LyN4j4yKW5WQt66UDbEzNnwZmUSc3xPgCzEKgyQgs9aWEEVxAxTmE9W
         IGZYSXY3FXlIx6m9EDW7MRgVQupgAM1T2gOk6c1DesvTRof7qr1U9JP8sCXw6u72gI/7
         o8U7mgOC7Q/oAgjpqG23eNe6n2wBZy+/Poq81kR+gV/tOrNwLN083xd6oZpMPnaB26rs
         Vngi6/7jQaFo18fjGzraezto1a3u3XuQng2cyBrzs14QRm5dry2ECZQ70sZ98meyAP5G
         uGew==
X-Gm-Message-State: AOAM533QxmnlUUAQEQmpIozpPN7iG0cwVLQze9TCPHqnplq2Yxzm0yf1
        MqHB6Mbc/ioCcVwDm5M/NkQ=
X-Google-Smtp-Source: ABdhPJyJIbZ8sQ4c0SEaltAHCSWz9hftL19U9s5rl0bIZgifXijCztWDXBPCfOPaVtOP8Z8IhNaijw==
X-Received: by 2002:a05:6512:1051:: with SMTP id c17mr10667088lfb.35.1636499427526;
        Tue, 09 Nov 2021 15:10:27 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q5sm1921419ljb.125.2021.11.09.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 15:10:26 -0800 (PST)
Date:   Wed, 10 Nov 2021 00:10:25 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Message-ID: <YYr/4VuaXXI0JCJU@rocinante>
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
 <YYlb2w1UVaiVYigW@rocinante>
 <4ec8db2c-295a-5060-1c0e-184ee072571e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ec8db2c-295a-5060-1c0e-184ee072571e@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Paul,

> Thank you for your reply.

Thank you for getting back to us with a good insight.

[...]
> > I am curious - why is this a problem?  Are you power-cycling your servers
> > so often to the point where the cumulative time spent in enumerating PCI
> > devices and adding them later to IOMMU groups is a problem?
> > 
> > I am simply wondering why you decided to signal out the PCI enumeration as
> > slow in particular, especially given that a large server hardware tends to
> > have (most of the time, as per my experience) rather long initialisation
> > time either from being powered off or after being power cycled.  I can take
> > a while before the actual operating system itself will start.
> 
> It’s not a problem per se, and more a pet peeve of mine. Systems get faster
> and faster, and boottime slower and slower. On desktop systems, it’s much
> more important with firmware like coreboot taking less than one second to
> initialize the hardware and passing control to the payload/operating system.
> If we are lucky, we are going to have servers with FLOSS firmware.
> 
> But, already now, using kexec to reboot a system, avoids the problems you
> pointed out on servers, and being able to reboot a system as quickly as
> possible, lowers the bar for people to reboot systems more often to, for
> example, so updates take effect.

A very good point about the kexec usage.

This is definitely often invaluable to get security updates out of the door
quickly, update kernel version, or when you want to switch operating system
quickly (a trick that companies like Equinix Metal use when offering their
baremetal as a service).

> > We talked about this briefly with Bjorn, and there might be an option to
> > perhaps add some caching, as we suspect that the culprit here is doing PCI
> > configuration space read for each device, which can be slow on some
> > platforms.
> > 
> > However, we would need to profile this to get some quantitative data to see
> > whether doing anything would even be worthwhile.  It would definitely help
> > us understand better where the bottlenecks really are and of what magnitude.
> > 
> > I personally don't have access to such a large hardware like the one you
> > have access to, thus I was wondering whether you would have some time, and
> > be willing, to profile this for us on the hardware you have.
> > 
> > Let me know what do you think?
> 
> Sounds good. I’d be willing to help. Note, that I won’t have time before
> Wednesday next week though.

Not a problem!  I am very grateful you are willing to devote some of you
time to help with this.

I only have access to a few systems such as some commodity hardware like
a desktop PC and notebooks, and some assorted SoCs.  These are sadly not
even close to a proper server platforms, and trying to measure anything on
these does not really yield any useful data as the delays related to PCI
enumeration on startup are quite insignificant in comparison - there is
just not enough hardware there, so to speak.

I am really looking forward to the data you can gather for us and what
insight it might provide us with.

Thank you again!

	Krzysztof
