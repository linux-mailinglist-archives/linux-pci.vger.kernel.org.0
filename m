Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C613CAEF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAOR0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 12:26:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54918 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgAOR0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 12:26:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id b19so792946wmj.4
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2020 09:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=79CyoPm4V7zjcWE2b3ht/ZY8oOgKh4RF8gb01hp53+g=;
        b=SB/5K17ZuzyYkzbIcOoO0aKfItni6DL3IukChm/9PfLc55oTTg9b+UUEACWrjLqoOi
         gd5JkWO38K7oqMwORnALQSlk4he2l+bvQNlzu1SsglRxH/uCwhS+t+AK0OQGEVcYc7sF
         ZhTuBEXPko9sTRVSP23TuSSeCKLKFeBLdfQoHDp7o0Id/ZPRAJqtM+3o6zB4mB9YIYTA
         J2L61dRF7SAI//XeBLrJ3xbnJ3UoibrhNysjDSfZIps1OntgoPKWzKSqdBXtn8xGbGy8
         NvLhIzT4l5MFYEHzdccZtfo+kH/ViEneeZyukEldJBPQwK7nFBF2/hH81FeGSbcuF8PZ
         +VzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=79CyoPm4V7zjcWE2b3ht/ZY8oOgKh4RF8gb01hp53+g=;
        b=Be0dXJXYepowTqeRivs3MK9locgi04gtmF8oMRQeTHPNEBfVMec3LyWfTOlZt6oSYN
         UKB1yAoalZM13ttSljkszFM+rZw0R8cUziYbvPRwWS9wSoc1uCEgps6MfmIz1lu0MVuG
         T7JpHbKKgKGJKqxpr97m32tGNTbfHklLczo1M4sGCPlay5DsOKrBqh+MGnAwIu/TEGpn
         nIWS17VoaYKLLtbpCqR05Lit4hUVlnimUpU1jX2IGaAFjbg99oPDJ7IgcGpeTY+BnEKX
         p00ztw3k0AWaLy2hgVUx8rEwhS8D1xkbdeJh/WsfsiaixCysZHPeFob1KzMVx4OCmGU5
         tFSw==
X-Gm-Message-State: APjAAAWF2S8XQtMI08Y4IsnKkGApT+0Xk27YYDHMXMzfFYV2oQPtFhhR
        9V9wD0jUOvuVQrsODUJ407L3mcJGlN1SfyWGIP4=
X-Google-Smtp-Source: APXvYqwVq9QiSnKimj4bU4brSinzt9yBQo3hvzJegDc65tcqm9afBzu1qb7WfGlzwXWLd4ARAfC6+z4tgCS6BZuzKs4=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr959711wmb.143.1579109205063;
 Wed, 15 Jan 2020 09:26:45 -0800 (PST)
MIME-Version: 1.0
References: <20200114234144.GA56595@google.com> <20200115171421.GA174505@google.com>
In-Reply-To: <20200115171421.GA174505@google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 15 Jan 2020 12:26:32 -0500
Message-ID: <CADnq5_Onw1JgtAYiJgkdL55pe5UdVaJ7j-Tmj3THikWEs-nbkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Adjust AMD GPU ATS quirks
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 12:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 14, 2020 at 05:41:44PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 14, 2020 at 03:55:21PM -0500, Alex Deucher wrote:
> > > We've root caused the issue and clarified the quirk.
> > > This also adds a new quirk for a new GPU.
> > >
> > > Alex Deucher (2):
> > >   pci: Clarify ATS quirk
> > >   pci: add ATS quirk for navi14 board (v2)
> > >
> > >  drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
> > >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > I propose the following, which I intend to be functionally identical.
> > It just doesn't repeat the pci_info() and pdev->ats_cap = 0.
>
> Applied to pci/misc for v5.6, thanks!

Can we add this to stable as well?

Alex

>
> > commit 998c4f7975b0 ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Tue Jan 14 17:09:28 2020 -0600
> >
> >     PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken
> >
> >     To account for parts of the chip that are "harvested" (disabled) due to
> >     silicon flaws, caches on some AMD GPUs must be initialized before ATS is
> >     enabled.
> >
> >     ATS is normally enabled by the IOMMU driver before the GPU driver loads, so
> >     this cache initialization would have to be done in a quirk, but that's too
> >     complex to be practical.
> >
> >     For Navi14 (device ID 0x7340), this initialization is done by the VBIOS,
> >     but apparently some boards went to production with an older VBIOS that
> >     doesn't do it.  Disable ATS for those boards.
> >
> >     https://lore.kernel.org/r/20200114205523.1054271-3-alexander.deucher@amd.com
> >     Bug: https://gitlab.freedesktop.org/drm/amd/issues/1015
> >     See-also: d28ca864c493 ("PCI: Mark AMD Stoney Radeon R7 GPU ATS as broken")
> >     See-also: 9b44b0b09dec ("PCI: Mark AMD Stoney GPU ATS as broken")
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4937a088d7d8..fbeb9f73ef28 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5074,18 +5074,25 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0422, quirk_no_ext_tags);
> >
> >  #ifdef CONFIG_PCI_ATS
> >  /*
> > - * Some devices have a broken ATS implementation causing IOMMU stalls.
> > - * Don't use ATS for those devices.
> > + * Some devices require additional driver setup to enable ATS.  Don't use
> > + * ATS for those devices as ATS will be enabled before the driver has had a
> > + * chance to load and configure the device.
> >   */
> > -static void quirk_no_ats(struct pci_dev *pdev)
> > +static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)
> >  {
> > -     pci_info(pdev, "disabling ATS (broken on this device)\n");
> > +     if (pdev->device == 0x7340 && pdev->revision != 0xc5)
> > +             return;
> > +
> > +     pci_info(pdev, "disabling ATS\n");
> >       pdev->ats_cap = 0;
> >  }
> >
> >  /* AMD Stoney platform GPU */
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_no_ats);
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_no_ats);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
> > +/* AMD Iceland dGPU */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_ats);
> > +/* AMD Navi14 dGPU */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_ats);
> >  #endif /* CONFIG_PCI_ATS */
> >
> >  /* Freescale PCIe doesn't support MSI in RC mode */
