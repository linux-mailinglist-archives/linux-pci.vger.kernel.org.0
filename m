Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8A21B8F04
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgDZKqY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 06:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgDZKqX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Apr 2020 06:46:23 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC242071C
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587897982;
        bh=1sNxV3HXjycZIget41Wvk4fbDmw/0h2EekilJvHkj04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cnzF/AfgrAhLRE0KgFQB0Vh45XFaRb66QLkbji+3COEuwJRQWpFEvezAT3GfZ4sZ1
         KtPP57I26D7OuJ8cxzrlFY9Ky2SeuKtCkAxXlxWG1iX0kVw1KH6gJWVnE8G2IA5Pk9
         hMPWUmc3eUzBY431G8Rzv+vQjiGtp6pBVrax2dMg=
Received: by mail-io1-f48.google.com with SMTP id b12so15661273ion.8
        for <linux-pci@vger.kernel.org>; Sun, 26 Apr 2020 03:46:22 -0700 (PDT)
X-Gm-Message-State: AGi0PubdM0QpLVAs7321Lmn62O2xx7dHov3J6WaqS3dzOC3JAwl/ZC8F
        Ue/6WEANk0bduj5MC2n7wXov3IXVD+v3cmhzUNY=
X-Google-Smtp-Source: APiQypIkcehlOMrNTxPBCKbooK4+UK8nA4htMUWgKBAzK6KPuwh7TcvCd+mjMMevzMUf5iflEPvrmQKt74jhqQ+erI8=
X-Received: by 2002:a02:6a1e:: with SMTP id l30mr15525924jac.98.1587897982075;
 Sun, 26 Apr 2020 03:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200421162256.26887-1-ardb@kernel.org> <2fb2b8c1-89be-1e59-c82c-b63e3afa62d5@amd.com>
 <CAMj1kXE0wFtyD7YGxXzKWAx+BT6x9CYreaFyEeFfeYJFeQbo_g@mail.gmail.com>
 <CAMj1kXH3WVMehgbMwUEjBSYudAM7PtWAcAYcWspyq4eZJzBwTQ@mail.gmail.com>
 <d06a3062-ce45-fdd2-6f22-c56e2e2f8f4b@amd.com> <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
In-Reply-To: <CAMj1kXG04ehc6WxR=YSzjrV33O07h6hcWocUAfnfdGpDG13w6g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 26 Apr 2020 12:46:11 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
Message-ID: <CAMj1kXFWfhYPwfO29Qv6w1-Dk=Ph+ZZEXPgvqf5Abrg3qf2jWA@mail.gmail.com>
Subject: Re: [PATCH] PCI: allow pci_resize_resource() to be used on devices on
 the root bus
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        jon@solid-run.com, wasim.khan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 26 Apr 2020 at 11:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 26 Apr 2020 at 11:08, Christian K=C3=B6nig <christian.koenig@amd.=
com> wrote:
> >
> > Am 25.04.20 um 19:32 schrieb Ard Biesheuvel:
> > > On Tue, 21 Apr 2020 at 19:07, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >> On Tue, 21 Apr 2020 at 18:43, Christian K=C3=B6nig <christian.koenig=
@amd.com> wrote:
> > >>> Am 21.04.20 um 18:22 schrieb Ard Biesheuvel:
> > >>>> When resizing a BAR, pci_reassign_bridge_resources() is invoked to
> > >>>> bring the bridge windows of parent bridges in line with the new BA=
R
> > >>>> assignment.
> > >>>>
> > >>>> This assumes that the device whose BAR is being resized lives on a
> > >>>> subordinate bus, but this is not necessarily the case. A device ma=
y
> > >>>> live on the root bus, in which case dev->bus->self is NULL, and
> > >>>> passing a NULL pci_dev pointer to pci_reassign_bridge_resources()
> > >>>> will cause it to crash.
> > >>>>
> > >>>> So let's make the call to pci_reassign_bridge_resources() conditio=
nal
> > >>>> on whether dev->bus->self is non-NULL in the first place.
> > >>>>
> > >>>> Fixes: 8bb705e3e79d84e7 ("PCI: Add pci_resize_resource() for resiz=
ing BARs")
> > >>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > >>> Sounds like it makes sense, patch is
> > >>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>.
> > >> Thanks Christian.
> > >>
> > >>> May I ask where you found that condition?
> > >>>
> > >> In this particular case, it was on an ARM board with funky PCIe IP
> > >> that does not expose a root port in its bus hierarchy.
> > >>
> > >> But in the general case, PCIe endpoints can be integrated into the
> > >> root complex, in which case they appear on the root bus, and there i=
s
> > >> no reason such endpoints shouldn't be allowed to have resizable BARs=
.
> > > Actually, looking at this more carefully, I think
> > > pci_reassign_bridge_resources() needs to do /something/ to ensure tha=
t
> > > the resources are reshuffled if needed when the resized BAR overlaps
> > > with another one.
> >
> > The resized BAR never overlaps with an existing one since to resize a
> > BAR it needs to be deallocated and disabled. This is done as a
> > precaution to avoid potential incorrect routing and decode of memory ac=
cess.
> >
> > The call to pci_reassign_bridge_resources() is only there to change the
> > resources of the upstream bridge to the device which is resized and not
> > to adjust the resources of the device itself.
> >
>
> So does that mean that BAR resizing is only possible if no other BARs,
> either on the same device or on other ones, need to be moved?

OK, so obviously, the current code already releases and reassigns
resources on the same device.

What I am not getting is how this works with more complex topologies, e.g.,

RP 1
multi function device (e.g., GPU + HDMI)
GPU BAR 0 256M
GPU BAR 1 16 M
HDMI BAR 0 16 KB

RP 2
some other endpoint using MMIO64 BARs

So in this case, RP1 will get a prefetchable bridge BAR window of 512
M, and RP2 may get one that is directly adjacent to that. When
resizing GPU BAR 0 to 4 GB, the whole hierarchy needs to be
reshuffled, right?
