Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA260B4AB7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfIQJhL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 17 Sep 2019 05:37:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50334 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfIQJhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 05:37:06 -0400
Received: from mail-oi1-f199.google.com ([209.85.167.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iA9uy-0006s3-1d
        for linux-pci@vger.kernel.org; Tue, 17 Sep 2019 09:37:04 +0000
Received: by mail-oi1-f199.google.com with SMTP id k185so1382509oih.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Sep 2019 02:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIbijquzMtQBr8kkr1tOGfR+o3tuxAs9+vpk/bBLO3Q=;
        b=D4mYChy/AJa8yZuHpZJxKNal4C+dPsdBUcUYzUJuDVntoq0pTJi6zdwoAxyGfvOhiG
         F8ZkLI/GwoRQ+2Ol4wttZFxdYgAGQnmW4lVRIlmg+8cnmy9hb+ZKPipE6x5ttzcoGe9V
         ttf+9nYa4M08uMl/pY2EJWudjTYZpSUboq4qKC7S8YakpCuMVd5wjGAUSTzL5UJmwDI0
         H5z8laU97LECMUP5KMyswI6jGowujxLcKeOEXEyr1XrVjVzHy/asvROxnmJe0qq43eIF
         l+PCXw0c5V4RKcXPJwYMCfsIgTYeG7nLZ3+zw+oMRTXgBt7jthyOwYb1nGB1HROJwr6k
         rUHg==
X-Gm-Message-State: APjAAAVHu0w2dIY4XxsqbiVzmbtTrhbTBtsNGiz8+eTyMRNdQn+tD7O4
        b4DS7Ta2pk6K6q4xf3CLOJjSJgDfzaQi3aWM9rYxD3om00IzHUlPk4MjCyt4nnebhfsd/4sJhja
        60ApyTgUXchrVSWfn17pmwLTyO8KSDCQdfOlzAQbmWqSckqsrQW0jOg==
X-Received: by 2002:a05:6830:2306:: with SMTP id u6mr2117286ote.0.1568713022838;
        Tue, 17 Sep 2019 02:37:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwicLemrKh18hQPput+im8uQ+JqnJfWBVlweGggNmdSwQZv1LUrL1ZnqK0WlQoEBSHLeeBlQIMwrEGN5/Bcbgo=
X-Received: by 2002:a05:6830:2306:: with SMTP id u6mr2117270ote.0.1568713022472;
 Tue, 17 Sep 2019 02:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134756.10807-2-kai.heng.feng@canonical.com>
 <20190828180128.1732-1-kai.heng.feng@canonical.com> <20190905213509.GI103977@google.com>
In-Reply-To: <20190905213509.GI103977@google.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 17 Sep 2019 11:36:51 +0200
Message-ID: <CAAd53p5LUat5MVkjbkk+st0TJA96y36keD898ZOepEdsnaiihw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     tiwai@suse.com, Linux PCI <linux-pci@vger.kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Sep 5, 2019 at 11:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Aug 29, 2019 at 02:01:28AM +0800, Kai-Heng Feng wrote:
> > It's a common practice to let dGPU unbound and use PCI platform power
> > management to disable its power through _OFF method of power resource,
> > which is listed by _PR3.
> > When the dGPU comes with an HDA function, the HDA won't be suspended if
> > the dGPU is unbound, so the power resource can't be turned off.
>
> I'm not involved in applying this patch, but from the peanut gallery:
>
>   - The above looks like it might be two paragraphs missing a blank
>     line between?  Or maybe it's one paragraph that needs to be
>     rewrapped?

I think it can be both. I'll rephrase it.

>
>   - I can't parse the first sentence.  I guess "dGPU" and "HDA" are
>     hardware devices, but I don't know what "unbound" means.  Is that
>     something to do with a driver being bound to the dGPU?  Or is it
>     some connection between the dGPU and the HDA?

Yes, "unbound" in this context means the dGPU isn't bound to a driver.

>
>   - "PCI platform power management" is still confusing -- I think we
>     either have "PCI power management" that uses the PCI PM Capability
>     (i.e., writing PCI_PM_CTRL as in pci_raw_set_power_state()) OR we
>     have "platform power management" that uses some other method,
>     typically ACPI.  Since you refer to _OFF and _PR3, I guess you're
>     referring to platform power management here.

Yes, I'll make it clearer in next version. It's indeed referring to
platform power management.

>
>   - "It's common practice to let dGPU unbound" -- does that refer to
>     some programming technique common in drivers, or some user-level
>     thing like unloading a driver, or ...?  My guess is it probably
>     means "unbind the driver from the dGPU" but I still don't know
>     what makes it common practice.

Yes it means keep driver for dGPU unloaded. It's a common practice
since the proprietary nvidia.ko doesn't support runtime power
management, so when users are using integrated GPU, unload the dGPU
driver can make PCI core use platform power management to disable the
power source to save power.

>
> This probably all makes perfect sense to the graphics cognoscenti, but
> for the rest of us there are a lot of dots here that are not
> connected.

Will send a v2 with clearer description.
Kai-Heng

>
> > Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> > discrete GPU") only allows HDA to be runtime-suspended once GPU is
> > bound, to keep APU's HDA working.
> >
> > However, HDA on dGPU isn't that useful if dGPU is unbound. So let's
> > relax the runtime suspend requirement for dGPU's HDA function, to save
> > lots of power.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1840835
> > Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers”)
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v2:
> > - Change wording.
> > - Rebase to Tiwai's branch.
> >
> >  sound/pci/hda/hda_intel.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 91e71be42fa4..c3654d22795a 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1284,7 +1284,11 @@ static void init_vga_switcheroo(struct azx *chip)
> >               dev_info(chip->card->dev,
> >                        "Handle vga_switcheroo audio client\n");
> >               hda->use_vga_switcheroo = 1;
> > -             chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
> > +
> > +             /* cleared in either gpu_bound op or codec probe, or when its
> > +              * root port has _PR3 (i.e. dGPU).
> > +              */
> > +             chip->bus.keep_power = !pci_pr3_present(p);
> >               chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
> >               pci_dev_put(p);
> >       }
> > --
> > 2.17.1
> >
