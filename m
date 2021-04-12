Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146E135D1B0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Apr 2021 22:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbhDLUEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Apr 2021 16:04:14 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:36532 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhDLUEN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Apr 2021 16:04:13 -0400
Received: by mail-io1-f46.google.com with SMTP id d5so5307912iof.3;
        Mon, 12 Apr 2021 13:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1DKBip1cD3aSFLjp4/QXCXfgqw6DxdHnGOMaVMs/Mk=;
        b=Wxl/CsXMlTrlJjA6dZhUr8xyacdgcncz2+KRG8yA9LpXndOH9nBi5qvJ5gBtPBrp5u
         hENprIu3eHEaFdgLBasmRFBKlnRuqwtekrkFs6kgVYzvilOXVJ5oA/vagRWrKDMHuCwQ
         9OlOAwNW950qF4EppyxjJAoRwXKhymCw9RMRs2M9E8CP/BhLOGr6QtEKMi/rwUCue3o9
         cCHP9HMlP8mB5sV8ZGpEB4NIUSUkOCxO1TbSk/rTcIrRl5pLTGePq8kjQYafhNx3Prnq
         CQODEiVvYFAeUN1h+ulKCUuQq4qj6MKCjwhX/pGq7ZWTPoDkVAa3PHqT8UGJb9MRnwUP
         qx0Q==
X-Gm-Message-State: AOAM530s2YCsSdJT3d26Zw1VzAYwN5NN88MhEz6aoXx7NPbJW/AV8/Ud
        nEpOTxR+VNzoObjX5takoToT2hxfoxylkb4KyCk=
X-Google-Smtp-Source: ABdhPJyY69c31V3iKZiKQc18J3Idwmvowy5sUcT5nSDjCCDU2vU8FsrTnez4bmmXKiJh9b4vCq2zBbyoii3mC3d+KvE=
X-Received: by 2002:a6b:ec08:: with SMTP id c8mr23006489ioh.55.1618257834792;
 Mon, 12 Apr 2021 13:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de> <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
 <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
 <CACO55tsPx_UC3OPf9Hq9sGdnZg9jH1+B0zOi6EAxTZ13E1tf7A@mail.gmail.com>
 <d01e375f-bf16-a005-ec66-0910956cc616@spliet.org> <20210410192314.GB16240@wunner.de>
 <bddba2ca-15d5-7fd3-5b64-f4ba7e179ec0@spliet.org> <81b2a8c7-5b0b-b8fa-fbed-f164128de7a3@nvidia.com>
 <8d358110-769d-b984-d2ec-825dc2c3d77a@spliet.org> <d616715e-b0e3-74f6-9621-805fb5a0c898@nvidia.com>
In-Reply-To: <d616715e-b0e3-74f6-9621-805fb5a0c898@nvidia.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Mon, 12 Apr 2021 16:03:43 -0400
Message-ID: <CAKb7UvjMmL3wp4uRCnkAW0r551uj5526RW7u==Arad23zF_Z8g@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Aaron Plattner <aplattner@nvidia.com>
Cc:     Roy Spliet <nouveau@spliet.org>, Lukas Wunner <lukas@wunner.de>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        nouveau <nouveau@lists.freedesktop.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 12, 2021 at 4:01 PM Aaron Plattner <aplattner@nvidia.com> wrote:
>
> On 4/12/21 12:36 PM, Roy Spliet wrote:
> > Hello Aaron,
> >
> > Thanks for your insights. A follow-up query and some observations
> > in-line.
> >
> > Op 12-04-2021 om 20:06 schreef Aaron Plattner:
> >> On 4/10/21 1:48 PM, Roy Spliet wrote:
> >>> Op 10-04-2021 om 20:23 schreef Lukas Wunner:
> >>>> On Sat, Apr 10, 2021 at 04:51:27PM +0100, Roy Spliet wrote:
> >>>>> Can I ask someone with more
> >>>>> technical knowledge of snd_hda_intel and vgaswitcheroo to
> >>>>> brainstorm about
> >>>>> the possible challenges of nouveau taking matters into its own
> >>>>> hand rather
> >>>>> than keeping this PCI quirk around?
> >>>>
> >>>> It sounds to me like the HDA is not powered if no cable is plugged in.
> >>>> What is reponsible then for powering it up or down, firmware code on
> >>>> the GPU or in the host's BIOS?
> >>>
> >>> Sometimes the BIOS, but definitely unconditionally the PCI quirk
> >>> code:
> >>> https://github.com/torvalds/linux/blob/master/drivers/pci/quirks.c#L5289
> >>>
> >>>
> >>> (CC Aaron Plattner)
> >>
> >> My basic understanding is that the audio function stops responding
> >> whenever the graphics function is powered off. So the requirement
> >> here is that the audio driver can't try to talk to the audio function
> >> while the graphics function is asleep, and must trigger a graphics
> >> function wakeup before trying to communicate with the audio function.
> >
> > I believe that vgaswitcheroo takes care of this for us.
> >
> >> I think there are also requirements about the audio function needing
> >> to be awake when the graphics driver is updating the ELD, but I'm not
> >> sure.
> >>
> >> This is harder on Windows because the audio driver lives in its own
> >> little world doing its own thing but on Linux we can do better.
> >>
> >>>> Ideally, we should try to find out how to control HDA power from the
> >>>> operating system rather than trying to cooperate with whatever
> >>>> firmware
> >>>> is doing.  If we have that capability, the OS should power the HDA up
> >>>> and down as it sees fit.
> >>
> >> After system boot, I don't think there's any firmware involved, but
> >> I'm not super familiar with the low-level details and it's possible
> >> the situation changed since I last looked at it.
> >>
> >> I think the problem with having nouveau write this quirk is that the
> >> kernel will need to re-probe the PCI device to notice that it has
> >> suddenly become a multi-function device with an audio function, and
> >> hotplug the audio driver. I originally looked into trying to do that
> >> but it was tricky because the PCI subsystem didn't really have a
> >> mechanism for a single-function device to become a multi-function
> >> device on the fly and it seemed easier to enable it early on during
> >> bus enumeration. That way the kernel sees both functions all the time
> >> without anything else having to be special about this configuration.
> >
> > Right, so for a little more context: a while ago I noticed that my
> > laptop (lucky me, Asus K501UB) has a 940M with HDA but no codec. Seems
> > legit, given how this GPU has no displays attached; they're all hooked
> > up to the Intel integrated GPU. That threw off the snd_hda_intel
> > mid-probe, and as a result didn't permit runpm, keeping the entire
> > GPU, PCIe bus and thus the CPU package awake. A bit of hackerly later
> > we decided to continue probing without a codec, and now my laptop is
> > happy, but...
>
> What is the PCI class of the GPU in your system? If it has no display
> outputs it's probably 0x302 ("3D Controller") rather than 0x300 ("VGA
> Controller"). Looking at the code it looks like this workaround is being
> applied to both but maybe it should be restricted to just VGA controllers.

That was a comment I had back when the quirk was being implemented,
but helpfully there are some of these devices running around which say
"3D Controller" but still have displays attached to them. Lukas
probably remembers more specifics.

  -ilia
