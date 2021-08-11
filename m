Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A063E9A37
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhHKVHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKVHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 17:07:23 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE9CC061765;
        Wed, 11 Aug 2021 14:06:59 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so1110260ooo.7;
        Wed, 11 Aug 2021 14:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CWnPOaXqwG7kn4SEtHcFJeDqfvrX/IkhUBZgOG8Xn+I=;
        b=ND+o9xQuiGBiwFoK5Fwd3WFKu3m1KxQgoSQ3dnGdS8By0mIO59fqEmOZywQZagOxgN
         0GSR3eBYLcSrLD1p7A7XZAOAf2wg0oMGq7XuruiN6Ie8NvO3qrxXk7qcjhzfINjLPDoT
         4fZpIW6gSN9KFap1MP8BiOxTGZqEmfP43+o1c87f7XfQGDZrYT7tMI+LS8F5SolqW1Ep
         DUOKMsMS2NRRoB999WODOP/gMj/MAfk8t0XODOOEBuBlytQox4EYrxJ9HKEN/7JD45po
         6ZFRYt23PmfDcoqXTNDYGGz8XSDIZrfy3cLEofPT4uFCIPs1LOI+sATDgun10wJEx71K
         lEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CWnPOaXqwG7kn4SEtHcFJeDqfvrX/IkhUBZgOG8Xn+I=;
        b=scAc+mBXquL8g5lWcvnFzGXNXxw519KpqFFbYtZ2PgW/i0FWIMud0d3Xaw2qE+ra1s
         BoD9IExgBr2U1riZ9HqR9M58y9pVGSSp9MPtZZ8wtUdkPwUroe21vjqjSr302b+lWpOd
         d5IWJYyZ/LBAJefUzu5hIrT0EvavpZN7u/85vgDKjhUOkH0792Evum358ymTZtED2gVy
         aY6xGwqphkyk++GR4WluxYQls6+DBdK49YCyOJf5CNU4+Hl1/p2J+sOVC8DUCuAescsU
         flW3AJ65GsCIjtsuzGDzwMdqbGTe2WlOnl/q4Y/PvLW7TkcKI6f3Q+jNG2csswuD56v4
         sBAQ==
X-Gm-Message-State: AOAM533MDb6bzBi9jFcT6RA+YJLV31gsxoNdXlLBysBl3PEEKKf4/Zlh
        xj9gmtXmlvgVcPetdv7DvU2TxEFsVaSgXz/LLPU=
X-Google-Smtp-Source: ABdhPJz50GMn/63EG6LYzmro/LcC+4AaIqvjolekdLwtXM1aGZhDDRXgd3BlXm/8kV4KHY/A60Gyc+7Vkz9Bm/JQkHQ=
X-Received: by 2002:a4a:a38a:: with SMTP id s10mr537795ool.72.1628716018794;
 Wed, 11 Aug 2021 14:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210811191104.21919-1-Ramesh.Errabolu@amd.com>
 <CADnq5_OVA1fB5x6=CGrd_5O-i=P7snmoJaTyauF2RKuWjc8Gog@mail.gmail.com> <ba4ee532-d64a-72c5-7aab-2b86a75b8174@amd.com>
In-Reply-To: <ba4ee532-d64a-72c5-7aab-2b86a75b8174@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 11 Aug 2021 17:06:47 -0400
Message-ID: <CADnq5_OmH6ZsL_Q_wO2B7dbaD_JFcaNbYFzd_Nv4kui1npkVPw@mail.gmail.com>
Subject: Re: [PATCH] Whitelist AMD host bridge device(s) to enable P2P DMA
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 4:50 PM Felix Kuehling <felix.kuehling@amd.com> wro=
te:
>
>
> Am 2021-08-11 um 3:29 p.m. schrieb Alex Deucher:
> > On Wed, Aug 11, 2021 at 3:11 PM Ramesh Errabolu <Ramesh.Errabolu@amd.co=
m> wrote:
> >> Current implementation will disallow P2P DMA if the participating
> >> devices belong to different root complexes. Implementation allows
> >> this default behavior to be overridden for whitelisted devices. The
> >> patch adds an AMD host bridge to be whitelisted
> > Why do we need this?  cpu_supports_p2pdma() should return true for all
> > AMD Zen CPUs.
>
> This is part of our on-going work to get P2P support upstream. We want
> to use pci_p2pdma_distance_many to determine whether P2P is possible
> between a pair of devices. This whitelist is used in this function. This
> will affect the P2P links reported in the topology and it will be
> double-checked in the BO mapping function to ensure a peer mapping is leg=
al.
>
> I think this change is a bit free of context at the moment, as we're
> still working on a few other loose ends for P2P support in our internal
> branch. I'm hoping we'll have a bigger patch series for upstreamable KFD
> P2P support ready in a few weeks. I also think we'll probably want to
> add a few more PCI IDs for other supported AMD root complexes.

We don't need to keep adding AMD root complexes.  You must be using an
older kernel or something.  All root complexes on all Zen platforms
support P2P DMA.  See:

commit dea286bb71baded7d2fb4f090e3b9fd2c1ccac58
Author: Logan Gunthorpe <logang@deltatee.com>
Date:   Wed Jul 29 17:18:44 2020 -0600

    PCI/P2PDMA: Allow P2PDMA on AMD Zen and newer CPUs

    Allow P2PDMA if the CPU vendor is AMD and family is 0x17 (Zen) or great=
er.

    [bhelgaas: commit log, simplify #if/#else/#endif]
    Link: https://lore.kernel.org/r/20200729231844.4653-1-logang@deltatee.c=
om
    Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
    Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
    Cc: Huang Rui <ray.huang@amd.com>

Alex


>
> Regards,
>   Felix
>
>
> >
> > Alex
> >
> >> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> >> ---
> >>  drivers/pci/p2pdma.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 196382630363..7003bb9faf23 100644
> >> --- a/drivers/pci/p2pdma.c
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -305,6 +305,8 @@ static const struct pci_p2pdma_whitelist_entry {
> >>         {PCI_VENDOR_ID_INTEL,   0x2032, 0},
> >>         {PCI_VENDOR_ID_INTEL,   0x2033, 0},
> >>         {PCI_VENDOR_ID_INTEL,   0x2020, 0},
> >> +       /* AMD Host Bridge Devices */
> >> +       {PCI_VENDOR_ID_AMD,     0x1480, 0},
> >>         {}
> >>  };
> >>
> >> --
> >> 2.31.1
> >>
