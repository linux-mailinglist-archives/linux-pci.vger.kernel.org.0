Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD3B22B76E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jul 2020 22:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgGWUTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jul 2020 16:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2020 16:19:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035CC0619DC;
        Thu, 23 Jul 2020 13:19:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 184so6349034wmb.0;
        Thu, 23 Jul 2020 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jz1lbK5bI0Ctyh4QZXH3ZtjdTMxnzW49HE2H6bVsMxw=;
        b=oRFGlag/zGU4CXXJ7XIQD7fPt8RRB94r0orMm2ytu8XHkavznqsppVIxVYbFUJ4DB0
         IfMmUYmi7xuRXPTKzbqCXimVAZUaIddCNZMWWNCXg0YVl08GSZU1uLAxxZZnMGYNMemJ
         lMi8RLkggLbM+U/a/ETnsoVAz2UHCnbVKiScXHLbI6T3FvividfJGqKaXYAvUQq33u5Y
         uCyAuMZ6u0kE2Rjxv8KhezALPo9NmunRoMPN3gT77vNWNgozYC5Utxu9VNy+T1+IXJ5f
         1gLPmCqmmnYIgn4b1fTLaMkHzVMRVHq4lhXBUoUPec+Ead0WNuo8hS1Tab/pEarMxiuP
         aIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jz1lbK5bI0Ctyh4QZXH3ZtjdTMxnzW49HE2H6bVsMxw=;
        b=kA9gzklvJSWsmtFbkx0P2Vplz9vyTYaF/BCskyQbiwJQ5Gh18SoZZ2c7COgqcRirdS
         IL87bqrRJGthg/+nw8YBIqEXqAk254nQimy2eDxiYcI0e10L1HAPwCObgXsW/ZucYjYu
         3/kO9vHiQxV5Ic1pV7brQWkrinD332S+3tF0MiFXWJichVdz08KVcZ1sAiiRTNQ9sIyv
         +0f9C4XX0UfiX+H+ZUgo/tjbK7GIDZ+LCia1QWV2MzYd+Hya9IBvgsAjNDVEWrn/k4UY
         2+5ohG0jI5GYcmwUJTPBCnJy5LK3Ypeg0hOdSMC6ucaftf4Mr79siV6MRPBGzsi7Ap8i
         /FJQ==
X-Gm-Message-State: AOAM530oN6GHEuaLQCiGUfTRJ39gCB9dvu5is8tmbLnGccPR1N9LKGcv
        KHaIUpDJ8fRHMpVGJABcJfJ1rOfjilw2szxNG0V2FA==
X-Google-Smtp-Source: ABdhPJwZ5ghVcpzgVD08jYmYRCKFxzaZXDMoXDwAnKc3VkUnx6aeY1yMm+lsM5vVRo5/EFxZ4Bj5gue9yJUmkyUiL10=
X-Received: by 2002:a1c:2:: with SMTP id 2mr5654439wma.79.1595535543473; Thu,
 23 Jul 2020 13:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200723195742.GA1447143@bjorn-Precision-5520> <89d853d1-9e45-1ba5-5be7-4bbce79c7fb8@deltatee.com>
In-Reply-To: <89d853d1-9e45-1ba5-5be7-4bbce79c7fb8@deltatee.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jul 2020 16:18:52 -0400
Message-ID: <CADnq5_NMKK83GaNA+w85MR8bqDbFqvcdvn9MCqZtLwctJKmOUw@mail.gmail.com>
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

On Thu, Jul 23, 2020 at 4:11 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
>
>
> On 2020-07-23 1:57 p.m., Bjorn Helgaas wrote:
> > [+cc Andrew, Armen, hpa]
> >
> > On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:
> >> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> =
wrote:
> >>>
> >>> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
> >>> transactions between root ports and found to work. Therefore add it
> >>> to the list.
> >>>
> >>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Cc: Huang Rui <ray.huang@amd.com>
> >>> Cc: Alex Deucher <alexdeucher@gmail.com>
> >>
> >> Starting with Zen, all AMD platforms support P2P for reads and writes.
> >
> > What's the plan for getting out of the cycle of "update this list for
> > every new chip"?  Any new _DSMs planned, for instance?
>
> Well there was an effort to add capabilities in the PCI spec to describe
> this but, as far as I know, they never got anywhere, and hardware still
> doesn't self describe with this.
>
> > A continuous trickle of updates like this is not really appealing.  So
> > far we have:
> >
> >   7d5b10fcb81e ("PCI/P2PDMA: Add AMD Zen Raven and Renoir Root Ports to=
 whitelist")
> >   7b94b53db34f ("PCI/P2PDMA: Add Intel Sky Lake-E Root Ports B, C, D to=
 the whitelist")
> >   bc123a515cb7 ("PCI/P2PDMA: Add Intel SkyLake-E to the whitelist")
> >   494d63b0d5d0 ("PCI/P2PDMA: Whitelist some Intel host bridges")
> >   0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under AM=
D ZEN Root Complex")
> >
> > And that's just from the last year, not including this patch.
>
> Yes, it's not ideal. But most of these are adding old devices as people
> test and care about running on those platforms -- a lot of this is
> bootstrapping the list. I'd expect this to slow down a bit as by now we
> have hopefully got a lot of the existing platforms people care about.
> But we'd still probably expect to be adding a new Intel and AMD devices
> about once a year as they produce new hardware designs.
>
> Unless, the Intel and AMD folks know of a way to detect this, or even to
> query if a root complex is newer than a certain generation, I'm not sure
> what else we can do here.

I started a thread internally to see if I can find a way.  FWIW,
pre-ZEN parts also support p2p DMA, but only for writes.  If I can get
a definitive list, maybe we could switch to a blacklist for the old
ones?

Alex

>
> Logan
