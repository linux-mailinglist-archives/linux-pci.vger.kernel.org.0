Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA3743BCA9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 23:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbhJZVwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbhJZVwK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 17:52:10 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF4C061570
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 14:49:45 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y17so772132ilb.9
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mccorkell.me.uk; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZANu9pQEczo+BkuGe3DHw2ps1kazzRdLDShlAEwreA=;
        b=SmMjIPjmvNn9Onyw5Dn1BiZeve7iktVeR7YgsZM2FJQQs9X9evwmIRusrKDBPmVJW3
         /9FjhGha7uDUqiXIxfKU13gByUuj/EzRuVZiHL09qJ+FR/ZKgQP4scwqDp+3UousKOcJ
         XwwRvvsUpFxC8jtwz01ac3me3AsjMNfKgrnODcjUi5b8lbW/cEoccBEDnU2+z5fy/yOv
         5snSo2OxQNkbzmhuYkg8WSBCAT1pr/Mw1ufn57JnbncT89D4eBlcgpByRWthD0S2/S+d
         lFMg6Vhg61ATiwc/YFwD0YTYQKpnF9lph4SWHMDTboJVsgkDV4GHm+lxSh8OpR9lCR5q
         Rfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZANu9pQEczo+BkuGe3DHw2ps1kazzRdLDShlAEwreA=;
        b=Wb+VbpJJ1LjDfwKjtcuYcifEzLdMB5NjX0q9nASjj55x+jCX0xepmb36b3fC+dO9VQ
         6VweYRDHui2Jn7dB7lTdIin0Kg0XKDEit6+2v+wTtQJwMFItotrN0h18jVGGkeksrujM
         IwywuzuWIy17kHBsgRp1560/jTkkFDdfnbPdXczkXQaNLh3KkOkBc2uqhJm+jomaQPf8
         GyIai+kUtDpkY69dkXD5rqEqf+D+tQE0vhokSZKjbLnf7TnBvXDMVhypiqjXAPFN3gFt
         Bd/dTe5+P6dVHtXyJw1PG+KGtlS3YqTSnFaKCmMuQzyOqtjbGG3TiK50s3P11/5V1/Um
         37TA==
X-Gm-Message-State: AOAM532rkZgpD2U5w33YDBTmUG2q/HKBzPl/aL7kGxZa8ZNGEKGo+xVL
        b4Fh/AfyH6QCQ9FfNmIUe5abqNVdy2aXstNzO5v0qg==
X-Google-Smtp-Source: ABdhPJz4d27FMQLZorF+A5kEGelMDgQZ4qJVafp6JznX/SE0OTw78B9XiUBDJGXxlS5V5daQnUXpWH6czPqVfcTVaPk=
X-Received: by 2002:a05:6e02:b4f:: with SMTP id f15mr16590042ilu.58.1635284984700;
 Tue, 26 Oct 2021 14:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211026204639.21178-1-robin@mccorkell.me.uk> <20211026212835.GA167500@bhelgaas>
In-Reply-To: <20211026212835.GA167500@bhelgaas>
From:   Robin McCorkell <robin@mccorkell.me.uk>
Date:   Tue, 26 Oct 2021 22:49:33 +0100
Message-ID: <CAJJH32EoZUEoi48qAbfVK9CJDQfUUTOFYq53+wuN=E0RQXZh8A@mail.gmail.com>
Subject: Re: [PATCH] Limit AMD Radeon rebar hack to a single revision
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks, v2 posted with the commit message fixes and correct tagging.

My device isn't a Sapphire RX 5600 XT Pulse, it's an RX 5600M and OEM
as far as I can tell. The condition in the original code was too broad
and was catching devices like mine (or the devices of the other bug
participants) where the hack was breaking things.

On Tue, 26 Oct 2021 at 22:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Christian, Nirmoy, authors of 907830b0fc9e]
>
> Subject line should look like previous ones for this file, e.g.,
>
>   88769e64cf99 ("PCI: Add ACS quirk for Pericom PI7C9X2G switches")
>   e3f4bd3462f6 ("PCI: Mark Atheros QCA6174 to avoid bus reset")
>   60b78ed088eb ("PCI: Add AMD GPU multi-function power dependencies")
>   8304a3a199ee ("PCI: Set dma-can-stall for HiSilicon chips")
>   8c09e896cef8 ("PCI: Allow PASID on fake PCIe devices without TLP prefixes")
>   32837d8a8f63 ("PCI: Add ACS quirks for Cavium multi-function devices")
>   e0bff4322092 ("PCI: Increase D3 delay for AMD Renoir/Cezanne XHCI")
>   ...
>   907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>
> Would be good to mention "Sapphire RX 5600 XT Pulse" explicitly since
> that's what 907830b0fc9e said.
>
> On Tue, Oct 26, 2021 at 09:46:38PM +0100, Robin McCorkell wrote:
> > A particular RX 5600 device requires a hack in the rebar logic, but the
> > current branch is too general and catches other devices too, breaking
> > them. This patch changes the branch to be more selective on the
> > particular revision.
> >
> > See also: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>
> There's a lot of legwork in the bug report to bisect this, but no
> explanation of what the root cause turned out to be.
>
> 907830b0fc9e says RX 5600 XT Pulse advertises 256MB-1GB BAR 0 sizes but
> actually supports up to 8GB.
>
> Does this patch mean your RX 5600 XT Pulse supports fewer sizes and
> advertises them correctly?  And consequently we resize BAR 0 to
> something that's too big, and something fails when we try to access
> the part the isn't actually implemented by the device?
>
> It would be useful to attach your "lspci -vv" output to the bug
> report.
>
> > This patch fixes intermittent freezes on other RX 5600 devices where the
> > hack is unnecessary. Credit to all contributors in the linked issue on
> > the AMD bug tracker.
>
> Thanks.  This would need a signed-off-by [1].
>
> We should also include a "Fixes:" line for the commit the problem was
> bisected to, 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire
> RX 5600 XT Pulse"), if I understand correctly, e.g.,
>
>   Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
>
> And probably a stable tag, since 907830b0fc9e appeared in v5.12, e.g.,
>
>   Cc: stable@vger.kernel.org    # v5.12+
>
> If stable maintainers backported 907830b0fc9e to earlier kernels, as
> it appears they have, it's up to them to watch for fixes to
> 907830b0fc9e.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.14#n365
>
> > ---
> >  drivers/pci/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index ce2ab62b64cf..1fe75243019e 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3647,7 +3647,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
> >
> >       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0 */
> >       if (pdev->vendor == PCI_VENDOR_ID_ATI && pdev->device == 0x731f &&
> > -         bar == 0 && cap == 0x7000)
> > +         pdev->revision == 0xC1 && bar == 0 && cap == 0x7000)
>
> I'd like to get the AMD folks to chime in and confirm that revision
> 0xC1 is the only one that requires this quirk.
>
> >               cap = 0x3f000;
> >
> >       return cap >> 4;
> > --
> > 2.31.1
> >
