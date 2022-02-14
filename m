Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940104B3E99
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 01:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiBNA16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 19:27:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238856AbiBNA16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 19:27:58 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED313F3E
        for <linux-pci@vger.kernel.org>; Sun, 13 Feb 2022 16:27:51 -0800 (PST)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DC1674033D
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 00:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644798469;
        bh=ej9ajKafdGwYpCYGQHrOi84wn2e/P4L47SMVJrwt6j4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dgToTokZ+aa+7I/VTtm8bKASud+h9N+Crq2HNTW0a23E5ZtadUtWJ8luckHd5p3xl
         Svqb6U+gb7A+VxyzyUZSol+F6MJekUmpWqLm2oldCB/EPrPyH9WA/noIdjIq/NS8hz
         6B0LRhDeNUcwb+XFwAeNSVEuBNdsdoknF2TlYclxk0LBBfxUigV1DKbcedjqHL+JUt
         oST1nQ3N4+vcMElxV9Iww9ULyilNuqFVB+u7jf/5Vn1OTvGFwJrLGbE+ThK/411e/y
         dEiVVvcYbgWTGR0YzxhffvxsxrCt5KHyarVv+1Ogqqi01K8FlGFiStI43xuZOTBmj/
         euovf6Cvc8e2w==
Received: by mail-ot1-f69.google.com with SMTP id f13-20020a0568301c2d00b005a61ef44410so9400291ote.23
        for <linux-pci@vger.kernel.org>; Sun, 13 Feb 2022 16:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ej9ajKafdGwYpCYGQHrOi84wn2e/P4L47SMVJrwt6j4=;
        b=6vZtdoJNop76qat6FhyXfHJ8JvIZ0T531JMwYTBiO7SbvT7IvPOnXsKFhNRcEkDYM7
         IIz78xO1k3NpqhfPCmJz5PoP9xv3avuDi+bfIh07AC3BmDjvIjOnqVXYNZ/gFizR9HLz
         xw3DjDBJ+LtwCsbyWl+PpUWePISrHQPA76ubfIfJChWBNonA6SXXyz+/JVmQoH7wGgMm
         DJdHNkcHGV9wyuqcdeyuvabl26gEmxioy//ppVd8EX2aa1JOVGGw43gdCg3svtTdhThr
         d0uih081CkhLXxjjA0mPead/g0edrNMaz1RSS4sSzqAULrUmrGRS/ZB+4Hts/QWOYgqr
         Ilxg==
X-Gm-Message-State: AOAM531KvJaGGM68uKru2qZWqMmueq3R03oJ8XgCIxwR8nUekShuU7kr
        s5SPVkL4UH5drqUs3dG9V3na8sVR7YWeNgklKSUbKa4exYuxIXxhZi2ZlD1q4BQ22YepAe5QenB
        RNcMuSf6Nz4p+nzq9UOI27GT4BvnJbUvkLjn9uEYSn5WjELJ0lTXFpw==
X-Received: by 2002:a9d:1ca5:: with SMTP id l37mr4209244ota.233.1644798468560;
        Sun, 13 Feb 2022 16:27:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyN1ZSAVS0GC78LiPm5hAJLWowe6qWTFLHN8Mj+qs0vO1FBPjaBZJa9R1QvrGkgKJJIQGrW81OKX3Z0Ufukxwg=
X-Received: by 2002:a9d:1ca5:: with SMTP id l37mr4209230ota.233.1644798468296;
 Sun, 13 Feb 2022 16:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20220209213638.GA587920@bhelgaas> <b6032dd3-eb49-50dc-5847-484d8cc35195@linux.dev>
In-Reply-To: <b6032dd3-eb49-50dc-5847-484d8cc35195@linux.dev>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 14 Feb 2022 08:27:37 +0800
Message-ID: <CAAd53p6GoVaKKU1DGaYy0wonSQ22w61nbg+x72Xr0aV6gff3bg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Honor ACPI _OSC on PCIe features
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 1:53 AM Jonathan Derrick
<jonathan.derrick@linux.dev> wrote:
>
>
>
> On 2/9/2022 2:36 PM, Bjorn Helgaas wrote:
> > On Tue, Dec 07, 2021 at 02:15:04PM +0100, Rafael J. Wysocki wrote:
> >> On Tue, Dec 7, 2021 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
> >>> On Fri, Dec 03, 2021 at 11:15:41AM +0800, Kai-Heng Feng wrote:
> >>>> When Samsung PCIe Gen4 NVMe is connected to Intel ADL VMD, the
> >>>> combination causes AER message flood and drags the system performance
> >>>> down.
> >>>>
> >>>> The issue doesn't happen when VMD mode is disabled in BIOS, since AER
> >>>> isn't enabled by acpi_pci_root_create() . When VMD mode is enabled, AER
> >>>> is enabled regardless of _OSC:
> >>>> [    0.410076] acpi PNP0A08:00: _OSC: platform does not support [AER]
> >>>> ...
> >>>> [    1.486704] pcieport 10000:e0:06.0: AER: enabled with IRQ 146
> >>>>
> >>>> Since VMD is an aperture to regular PCIe root ports, honor ACPI _OSC to
> >>>> disable PCIe features accordingly to resolve the issue.
> >>>
> >>> At least for some versions of this hardare, I recall ACPI is unaware of
> >>> any devices in the VMD domain; the platform can not see past the VMD
> >>> endpoint, so I throught the driver was supposed to always let the VMD
> >>> domain use OS native support regardless of the parent's ACPI _OSC.
> >>
> >> This is orthogonal to whether or not ACPI is aware of the VMD domain
> >> or the devices in it.
> >>
> >> If the platform firmware does not allow the OS to control specific
> >> PCIe features at the physical host bridge level, that extends to the
> >> VMD "bus", because it is just a way to expose a hidden part of the
> >> PCIe hierarchy.
> >
> > I don't understand what's going on here.  Do we understand the AER
> > message flood?  Are we just papering over it by disabling AER?
> >
> > If an error occurs below a VMD, who notices and reports it?  If we
> > disable native AER below VMD because of _OSC, as this patch does, I
> > guess we're assuming the platform will handle AER events below VMD.
> > Is that really true?  Does the platform know how to find AER log
> > registers of devices below VMD?
> ACPI (and the specific UEFI implementation) might remain unaware of
> VMD domains. It's possible that the system management mode (SMM)
> controller which typically handles firmware-first errors would be
> capable of handling VMD errors in the vendor-specific manner.
> However if _OSC hadn't taken into account VMD ports, SMM wouldn't
> be capable of handling those errors and silently disabling AER on
> VMD domains is a bad idea.

Are VMD ports on server platforms also 'apertures' for root ports like
those on consumer platforms?

>
> The bugzilla made it sound like a specific platform/drive combination.
> What about a DMI match to mask the Corrected Physical Layer bits?

We confirmed _all_ PCIe Gen4 NVMes on that platform have the issue. So
using DMI to match won't scale...

Kai-Heng

>
> >
> >> The platform firmware does that through ACPI _OSC under the host
> >> bridge device (not under the VMD device) which it is very well aware
> >> of.
