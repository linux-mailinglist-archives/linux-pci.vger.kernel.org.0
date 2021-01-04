Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357AA2E95CC
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 14:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhADNWd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 08:22:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbhADNWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2021 08:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609766466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vPrbs+ygK2nW6UXpFCX2PTOIhaEcotjknLDYayf1rbg=;
        b=RR+t52c/ES0bgXN62OrfOtjjhLmMeMkufS98DPBRXA5g9l+rBb+QiyOfyxQisqKx0uxmtQ
        3VlvqXta2VBHyOSRCx6Isg5nMZsQ1u9/kJd3iXt6wmy+5nDWPVqfg4u9pib2EHkMPXVNGv
        mUDSiKXc81BwnOfOlZ57btbEyfCu4z0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-hbxcgdcJNEitLc2_SJ4LKw-1; Mon, 04 Jan 2021 08:21:04 -0500
X-MC-Unique: hbxcgdcJNEitLc2_SJ4LKw-1
Received: by mail-wr1-f69.google.com with SMTP id r11so13233933wrs.23
        for <linux-pci@vger.kernel.org>; Mon, 04 Jan 2021 05:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vPrbs+ygK2nW6UXpFCX2PTOIhaEcotjknLDYayf1rbg=;
        b=eAdvTZNQCwR5dHBz+JdwP+CwJtWydvtCiM3TZq8gRzD84Q+hrXiw0yFThp0P13hohi
         Zt/oeRFuOd2ck6xmQGXoMWMeb0eTA1rbw3p00fkdZZuBsIyqRnFUQoG5bKKlM/xhH4qZ
         LwW9yyutBUf3vHfrH/60J5mobO0c9MPbHU6dOFJCVhkOWTWoszInCVt0CkMvWPdBXH0p
         +Smi/uL1sfdTCZO/u/jVuWyCcyEP37EAm9zQpZ1S7VXQY09Xz8a/MfnPBu6E7vhCp2w0
         BhyW04LkyFKN/ygNPB6zoo9IRm5wxpqaEv0ggvNBi9N5Oh/qz41QUbDmkpNkFskzDSb5
         ddNQ==
X-Gm-Message-State: AOAM53007GYUMhUQwuxBj8JVT3Kdk0yJkXefYftkWhuGfqq14UrTbJmQ
        5R5WDKCjpxMO+AaI3XgyTYktogCZdwz/6n9vvnDSfBx91abkGfnO3grDOynTrQf+w5ciIsfnJMN
        Tlzf+RPU9uWs1iSgG5XLMqv8Os3k+NUL01KoO
X-Received: by 2002:adf:e452:: with SMTP id t18mr76929204wrm.177.1609766463248;
        Mon, 04 Jan 2021 05:21:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyejyAsfaLxHqjg5lrewtBBFczMjR6pbLPXoTYYnr8a8cMlhhVl17ylXysIJXWiOsLQQV2XV28iok3dOsd31w=
X-Received: by 2002:adf:e452:: with SMTP id t18mr76929177wrm.177.1609766463058;
 Mon, 04 Jan 2021 05:21:03 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de> <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com> <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
In-Reply-To: <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 4 Jan 2021 14:20:52 +0100
Message-ID: <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Ilia Mirkin <imirkin@alum.mit.edu>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        nouveau <nouveau@lists.freedesktop.org>, tiwai@suse.com,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 22, 2020 at 3:50 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Tue, Dec 22, 2020 at 1:56 AM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> >
> > On Mon, Dec 21, 2020 at 11:33 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > [+Cc nouveau]
> > >
> > > On Fri, Dec 18, 2020 at 4:06 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > [snip]
> > > > > Quite possibly the system doesn't power up HDA controller when there's
> > > > > no external monitor.
> > > > > So when it's connected to external monitor, it's still needed for HDMI audio.
> > > > > Let me ask the user to confirm this.
> > > >
> > > > Yeah, it's the basic question whether the HD-audio is supposed to work
> > > > on this machine at all.  If yes, the current approach we take makes
> > > > less sense - instead we should rather make the HD-audio controller
> > > > working.
> > >
> > > Yea, confirmed that the Nvidia HDA works when HDMI is connected prior boot.
> > >
> > > > > > - The second problem is that pci_enable_device() ignores the error
> > > > > >   returned from pci_set_power_state() if it's -EIO.  And the
> > > > > >   inaccessible access error returns -EIO, although it's rather a fatal
> > > > > >   problem.  So the driver believes as the PCI device gets enabled
> > > > > >   properly.
> > > > >
> > > > > This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
> > > > > regression in pci_enable_device_bars") to fix UHCI controller.
> > > > >
> > > > > >
> > > > > > - The third problem is that HD-audio driver blindly believes the
> > > > > >   codec_mask read from the register even if it's a read failure as I
> > > > > >   already showed.
> > > > >
> > > > > This approach has least regression risk.
> > > >
> > > > Yes, but it assumes that HD-audio is really non-existent.
> > >
> > > I really don't know any good approach to address this.
> > > On Windows, HDA PCI is "hidden" until HDMI cable is plugged, then the
> > > driver will flag the magic bit to make HDA audio appear on the PCI
> > > bus.
> > > IIRC the current approach is to make nouveau and device link work.
> >
> > I don't have the full context of this discussion, but the kernel
> > force-enables the HDA subfunction nowadays, irrespective of nouveau or
> > nvidia or whatever:
>
> That's the problem.
>
> The nvidia HDA controller on the affected system only gets its power
> after HDMI cable plugged, so the probe on boot fails.
>

it might be that the code to enable the sub function is a bit broken
:/ but it should work. Maybe the quirk_nvidia_hda function needs to be
called on more occasions? No idea.

> Kai-Heng
>
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?h=v5.10#n5267
> >
> > Cheers,
> >
> >   -ilia
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

