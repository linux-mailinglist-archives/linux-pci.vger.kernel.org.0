Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE977D25F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2019 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHAAu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 20:50:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44906 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfHAAu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 20:50:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id d79so50626221qke.11
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2019 17:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=NPkDfDpHDw3YeQl+T3W6AvueVUYarX7de1k02h9BSIY=;
        b=tlUay4a1c5SYyZkNogTJgMSTtNIzlvOg/j42Wl93iG4dQfDTekfsdigahblMENHxGL
         p/uADyStkuEgKMSiBWsDyN40vWZYpD7QnDI4g81c/Jqp7o4epUhKUYPDyfwbR4mP3dZ9
         pJ6EwGQtQ9aHXzY6aeUHi7vy6aEVW0jpE1zy7Xrn6OleQx/PCjdmegoLONtRmsfgVSxd
         Dm6nntXTDFmQ3tVLCHDUEoiNPwA/glwe4vgDaMGqOV3KDyPPkRcv7Xn6wE8yinhlkA1J
         HKCcInSN7EAEXdMYgAIqgFzbcvOVZVkUXlopuW9SazS9IfCIUW4cmZoPnBBHasN0dRT1
         wUoQ==
X-Gm-Message-State: APjAAAX7KTMgn/trv4LgeZrMu14mmgCaFF005nJ3L8P/bu/dJlu7wL/H
        44jhOlmlrZisxNkUQMwJoPq59Q==
X-Google-Smtp-Source: APXvYqwkDwn1luI7XpQfjVzNA8rWMn0lr8TYrp6rYPQ9VCloeDW1Ozpk8FUP+0y3phbatU5iT/UbJQ==
X-Received: by 2002:a05:620a:16a6:: with SMTP id s6mr82383362qkj.39.1564620625950;
        Wed, 31 Jul 2019 17:50:25 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id a6sm31199887qth.76.2019.07.31.17.50.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 17:50:24 -0700 (PDT)
Message-ID: <97d4312d883f3c031c5a6144a2f5f5dd74dfe4df.camel@redhat.com>
Subject: Re: [PATCH] Revert "PCI: Enable NVIDIA HDA controllers"
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, Lukas Wunner <lukas@wunner.de>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 31 Jul 2019 20:50:20 -0400
In-Reply-To: <b27614151184f29bb147786933cb424fddb82a23.camel@redhat.com>
References: <20190731201927.22054-1-lyude@redhat.com>
         <20190731211842.befvpoyudrm2subf@wunner.de>
         <CACO55tu=9ZBzGkwdXPOwWARy1UTspFv+v=nrmLFoOKiSGU+E5Q@mail.gmail.com>
         <b27614151184f29bb147786933cb424fddb82a23.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-07-31 at 17:35 -0400, Lyude Paul wrote:
> On Wed, 2019-07-31 at 23:26 +0200, Karol Herbst wrote:
> > On Wed, Jul 31, 2019 at 11:18 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Wed, Jul 31, 2019 at 04:19:27PM -0400, Lyude Paul wrote:
> > > > While this fixes audio for a number of users, this commit has the
> > > > sideaffect of breaking the BIOS workaround that's required to make the
> > > > GPU on the nvidia P50 work, by causing the GPU's PCI device function
> > > > to
> > > > stop working after it's been set to multifunction mode.
> > > 
> > > This is missing a reference to the commit introducing the P50 quirk,
> > > which is e0547c81bfcf ("PCI: Reset Lenovo ThinkPad P50 nvgpu at boot
> > > if necessary").
> > > 
> > > Please describe in more detail how the GPU's PCI function stops working.
> > > Does it respond with "all ones" when accessing MMIO?
> > > Do MMIO accesses cause the system to hang?
> > > 
> > > Could you provide lspci -vvxx output for the GPU and its associated
> > > HDA controller with and without b516ea586d71?
> > > 
> > > Does this machine have external display connectors via which audio
> > > can be streamed?
> > > 
> > > 
> > > > I'm not really holding my breath on this patch to being accepted:
> > > > there's a good chance there's a better solution for this (and I'm
> > > > going
> > > > to continue investigating for one after sending this patch), this is
> > > > more just to start a conversation on what the proper way to fix this
> > > > is.
> > > 
> > > Posting as an RFC might have been more appropriate then.
> > > 
> > 
> > no, a revert is actually appropriate.  If a commit fixes something,
> > but breaks something else, it gets either reverted or fixed. If nobody
> > fixes it, then revert it is.
> 
> To answer Lukas's question btw: most of the details on how things break are
> back in the original commit (sorry for forgetting the reference!), there's a
> _lot_ of explanation there that I'd rather not retype, so just refer back to
> the commit and bug @ https://bugs.freedesktop.org/show_bug.cgi?id=75985
> 
> Additionally, there was some extra discussion providing some more detail in
> the email thread that I had with Bjorn:
> 
> https://lkml.org/lkml/2019/2/12/1172
> 
> As for how this commit breaks the workaround: it seems that when we enable
> the
> HDA controller and put the GPU into multifunction mode, the function-level
> reset stops working and thus we can't reset the GPU anymore. Currently I can
> see a couple of solutions (again, please feel free to suggest more!):
> 
>  * Just revert the commit. We should do this if necessary, but of course I'd
>    much rather try finding a fix first
>  * Disable the HDA controller temporarily when a GPU reset is neded in
>    quirk_reset_lenovo_thinkpad_p50_nvgpu(), then call the function level
>    reset, then re-enable the HDA controller. I have no idea if this actually
>    works yet, but I'm about to try this on my system
>  * Get quirk_reset_lenovo_thinkpad_p50_nvgpu() to run before
>    quirk_nvidia_hda(). This would probably be fine, but we would need to
>    rework some stuff in the PCI subsystem (maybe it already has a way to do
>    this? haven't checked yet) so that we could perform an flr probe early
>    enough to perform the quirk

Good news! After some investigation looks like that function level reset
actually does work, just that after we put it in multifunction mode
pci_parent_bus_reset() sees multiple devices on the bus and returns -ENOTTY as
a result. So I should definitely be able to come up with a fix for this other
then reverting this :). Will send out patches soon

> > > > So, I'm kind of confused about why exactly this was implemented as an
> > > > early boot quirk in the first place. If we're seeing the GPU's PCI
> > > > device, we already know the GPU is there. Shouldn't we be able to
> > > > check
> > > > for the existence of the HDA device once we probe the GPU in nouveau?
> > > 
> > > I think a motivation to keep this generic was to make it work with
> > > other drivers besides nouveau, specifically Nvidia's proprietary driver.
> > > nouveau might not even be enabled.
> > > 
> > > 
> > > > that still doesn't explain why this was implemented as an early quirk
> > > 
> > > This isn't an early quirk.  Those live in arch/x86/kernel/early-
> > > quirks.c.
> > > This is just a PCI quirk executed on device enumeration and on resume.
> > > Devices aren't necessarily enumerated only on boot, e.g. think
> > > Thunderbolt.
> > > 
> > > Thanks,
> > > 
> > > Lukas
-- 
Cheers,
	Lyude Paul

