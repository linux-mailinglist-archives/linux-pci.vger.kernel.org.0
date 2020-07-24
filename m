Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B69B22CA29
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgGXQHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgGXQHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 12:07:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD3C0619E4;
        Fri, 24 Jul 2020 09:07:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so8752319wrj.13;
        Fri, 24 Jul 2020 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RhJpy+OvuiZv7MNQSIPaKzKl699i34XcNbcjAQN++mU=;
        b=dwVZ1BNSTwWjuPgDCE91/UvIadNB7y0CUTggjSFZ17o/X4tYGikLjPqGSofswqtdWB
         /vfaWNd1Oiha1OwLdV7rTUiEayhZYdCd6IR1CjgmzO6POJABikyhP9A8r3izTR70SNE7
         MQ+RYsmgZHyQoasr9edkBIEV139XEl/WMWqxXffm650ttJxQ7cYPkK0E3vk0oKzLDYyT
         gdOEr1+L0xq2MajUl5oLD+9gyH0G16/V48131CXvXu2M1DNNjVRezX88tm+/JalsWcLr
         ackVLAWPk3qHUH5KTpt46Xa8UCVmvScXqt61HRNUFidD/QSQUllZoHpUEQpC+Qw6Yn5y
         opNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhJpy+OvuiZv7MNQSIPaKzKl699i34XcNbcjAQN++mU=;
        b=ld0ltzZzz+fG/uLxDRN/vu9Oc4x0vUOLHdFo2PSjDc0Gf3OroReAJ8Cvw5GL7M12h5
         aoBPhVCYCNOb//E81NU7hidEzSd+vtSAd6t3vLHLsJBnUucStWQhiVjCowMsAHCeDLbO
         5fZjNZKP01HZGjdIoxosUNZ5pBdlCa4WlZkl5Nz/goTReBtHHpuwmndp+Mz37FBbKTFV
         k2zc+lBhpgaOryOoSGINePlo+pGev8Z75hi8MgUwIT0Cl3D64/UrLXtJ2tp/917BY94M
         7EWFUvS2/uCJkWhvVOk3RNEGEhOl5734BgYpEu8nlDldJrY+ip5+X1wLryFAjdGse5c3
         izSQ==
X-Gm-Message-State: AOAM531fYVXPYIT3XDR3o2rkp36vZgkbcwdPMunG/KJGkLI/9+SpVObJ
        +VIJ+kaI5iTUie74OlyZfG4K5kNb/AK2+/EFfnc=
X-Google-Smtp-Source: ABdhPJy0wLXIQikSh4izF0ApEYr9jJbbykOJr2Ds0q+OjmmFkILcjFy76pjswDLypwV4vbwT3fVx6bJk8OQAsXrrYyQ=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr9614021wru.374.1595606835774;
 Fri, 24 Jul 2020 09:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200723195742.GA1447143@bjorn-Precision-5520>
 <89d853d1-9e45-1ba5-5be7-4bbce79c7fb8@deltatee.com> <CADnq5_NMKK83GaNA+w85MR8bqDbFqvcdvn9MCqZtLwctJKmOUw@mail.gmail.com>
In-Reply-To: <CADnq5_NMKK83GaNA+w85MR8bqDbFqvcdvn9MCqZtLwctJKmOUw@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 24 Jul 2020 12:07:04 -0400
Message-ID: <CADnq5_MCPTyxG31guPFL-uvs7HisGxwO5KpALnufc=Bj4MfYCw@mail.gmail.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 23, 2020 at 4:18 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Jul 23, 2020 at 4:11 PM Logan Gunthorpe <logang@deltatee.com> wro=
te:
> >
> >
> >
> > On 2020-07-23 1:57 p.m., Bjorn Helgaas wrote:
> > > [+cc Andrew, Armen, hpa]
> > >
> > > On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:
> > >> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com=
> wrote:
> > >>>
> > >>> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
> > >>> transactions between root ports and found to work. Therefore add it
> > >>> to the list.
> > >>>
> > >>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > >>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > >>> Cc: Huang Rui <ray.huang@amd.com>
> > >>> Cc: Alex Deucher <alexdeucher@gmail.com>
> > >>
> > >> Starting with Zen, all AMD platforms support P2P for reads and write=
s.
> > >
> > > What's the plan for getting out of the cycle of "update this list for
> > > every new chip"?  Any new _DSMs planned, for instance?
> >
> > Well there was an effort to add capabilities in the PCI spec to describ=
e
> > this but, as far as I know, they never got anywhere, and hardware still
> > doesn't self describe with this.
> >
> > > A continuous trickle of updates like this is not really appealing.  S=
o
> > > far we have:
> > >
> > >   7d5b10fcb81e ("PCI/P2PDMA: Add AMD Zen Raven and Renoir Root Ports =
to whitelist")
> > >   7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D =
to the whitelist")
> > >   bc123a515cb7 ("PCI/P2PDMA: Add Intel SkyLake-E to the whitelist")
> > >   494d63b0d5d0 ("PCI/P2PDMA: Whitelist some Intel host bridges")
> > >   0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under =
AMD ZEN Root Complex")
> > >
> > > And that's just from the last year, not including this patch.
> >
> > Yes, it's not ideal. But most of these are adding old devices as people
> > test and care about running on those platforms -- a lot of this is
> > bootstrapping the list. I'd expect this to slow down a bit as by now we
> > have hopefully got a lot of the existing platforms people care about.
> > But we'd still probably expect to be adding a new Intel and AMD devices
> > about once a year as they produce new hardware designs.
> >
> > Unless, the Intel and AMD folks know of a way to detect this, or even t=
o
> > query if a root complex is newer than a certain generation, I'm not sur=
e
> > what else we can do here.
>
> I started a thread internally to see if I can find a way.  FWIW,
> pre-ZEN parts also support p2p DMA, but only for writes.  If I can get
> a definitive list, maybe we could switch to a blacklist for the old
> ones?

After talking with a few people internally, for AMD chips, it would
probably be easiest to just whitelist based on the CPU family id for
zen and newer (e.g., >=3D 0x17).

Alex

>
> Alex
>
> >
> > Logan
