Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182082DFF14
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLUR5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 12:57:31 -0500
Received: from mail-ua1-f50.google.com ([209.85.222.50]:35414 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUR5a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2020 12:57:30 -0500
Received: by mail-ua1-f50.google.com with SMTP id y21so3567688uag.2;
        Mon, 21 Dec 2020 09:57:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MrAF3XcfgmbCY17OqyOzfLrhkI98KCYJDR2DMtLfdY8=;
        b=FARL21fepaGwlqbh/znW1t6ArcgYhrw+vNSqHVaHhhpo12JPUl6ZgqPMfJovTSkS1V
         YRZweEnvWbfysQwqaJaBhUsQEruNg/YIqjIhXc3ko4T+y0czYl5jzOJ0hfQuExluwubW
         ncZ6DYd09EWUET9T3FIkl/QhY4G0cYZFKyskfQSkx89JirSj9SgbDXzbVqai1OrdbHN5
         Xe2JVYjhVNrUsL9I/dfxDq+notIe/d88ifeo8V9/PS0lryRGl0WG2+36t7UI37NJBTcd
         K2fNFt9wjRTM0c5zBAlOhUOeVofj1wiW0PBJy/pHaYbyYuJcAPmiScGJYqU7t13G7+He
         dk6g==
X-Gm-Message-State: AOAM532NMv9GRv9x+BOjE8Qe3nBdYdq2SRZDOfTRFTP2h2hHfY6lv4TU
        1KxGhCON57ztne31MZvtGgHg0WxijSaBHElZADc=
X-Google-Smtp-Source: ABdhPJzVdL7B8bTZxy+rQMk6er8L4T5ie68H4w9L1UEygB7FM35lOkrdx7hEzcfKNr2eDQb6J0Pb9eQgDYeA07DY5rA=
X-Received: by 2002:ab0:1e4a:: with SMTP id n10mr13442742uak.98.1608573409390;
 Mon, 21 Dec 2020 09:56:49 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de> <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
In-Reply-To: <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 21 Dec 2020 12:56:38 -0500
Message-ID: <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 21, 2020 at 11:33 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> [+Cc nouveau]
>
> On Fri, Dec 18, 2020 at 4:06 PM Takashi Iwai <tiwai@suse.de> wrote:
> [snip]
> > > Quite possibly the system doesn't power up HDA controller when there's
> > > no external monitor.
> > > So when it's connected to external monitor, it's still needed for HDMI audio.
> > > Let me ask the user to confirm this.
> >
> > Yeah, it's the basic question whether the HD-audio is supposed to work
> > on this machine at all.  If yes, the current approach we take makes
> > less sense - instead we should rather make the HD-audio controller
> > working.
>
> Yea, confirmed that the Nvidia HDA works when HDMI is connected prior boot.
>
> > > > - The second problem is that pci_enable_device() ignores the error
> > > >   returned from pci_set_power_state() if it's -EIO.  And the
> > > >   inaccessible access error returns -EIO, although it's rather a fatal
> > > >   problem.  So the driver believes as the PCI device gets enabled
> > > >   properly.
> > >
> > > This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
> > > regression in pci_enable_device_bars") to fix UHCI controller.
> > >
> > > >
> > > > - The third problem is that HD-audio driver blindly believes the
> > > >   codec_mask read from the register even if it's a read failure as I
> > > >   already showed.
> > >
> > > This approach has least regression risk.
> >
> > Yes, but it assumes that HD-audio is really non-existent.
>
> I really don't know any good approach to address this.
> On Windows, HDA PCI is "hidden" until HDMI cable is plugged, then the
> driver will flag the magic bit to make HDA audio appear on the PCI
> bus.
> IIRC the current approach is to make nouveau and device link work.

I don't have the full context of this discussion, but the kernel
force-enables the HDA subfunction nowadays, irrespective of nouveau or
nvidia or whatever:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?h=v5.10#n5267

Cheers,

  -ilia
