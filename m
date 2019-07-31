Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623737D000
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfGaV0v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 17:26:51 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45519 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfGaV0v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 17:26:51 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so139575668ioc.12
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2019 14:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIGma61wLHtzNprRff+9TEgirnDHGnLDSLV4ZUKzd0A=;
        b=GGXOQNvcvh9x7DPOaCvU6Mr/Yimq3x5XwNnQN6gr/ZHoEilUolJo7BffsSizrIKoaq
         Nvt5S5f/l96bE8UzIyGWrKu9M6OmuGwEIkUBOcPG7ItKNl1ub0y24rlTsmSb5gkHjv+I
         HRhspEiI4+2x/FmaeNFaxKcsR1mE3Jt/lTysULwoVag6yKMoprB7+94K9IvXdIVBD6oT
         tiI32H/V90GKX1vFGIKtCEuENsbR+5iaDNBSPHZ9TSmU7Ogyd5niSjer+0qybta+oFu5
         XdXVilp8mPqOgp0b437a94cM+w2vJnbkVnluZx2Me9+NvotIuEaLZ3OqLlhjc5oqDq2P
         gycQ==
X-Gm-Message-State: APjAAAXw9nHikL+iooTm8LXv9dWUe6swOcAIKFG1u8G7irmzT9PWAPIX
        laNnRZ0TrZsapdYfys6jo1nnA6xC4FuROKgNQJ8SzQ==
X-Google-Smtp-Source: APXvYqzESQ6j/S2FQ4K/46lCRs2V5bZ+p/HVw7BDuXGgow808D74rbDC31pUP/jqnm5XyBJWHTuU22rvCZ1LzMnu6TU=
X-Received: by 2002:a02:230a:: with SMTP id u10mr46030961jau.117.1564608410139;
 Wed, 31 Jul 2019 14:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190731201927.22054-1-lyude@redhat.com> <20190731211842.befvpoyudrm2subf@wunner.de>
In-Reply-To: <20190731211842.befvpoyudrm2subf@wunner.de>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 31 Jul 2019 23:26:39 +0200
Message-ID: <CACO55tu=9ZBzGkwdXPOwWARy1UTspFv+v=nrmLFoOKiSGU+E5Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "PCI: Enable NVIDIA HDA controllers"
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Maik Freudenberg <hhfeuer@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 31, 2019 at 11:18 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, Jul 31, 2019 at 04:19:27PM -0400, Lyude Paul wrote:
> > While this fixes audio for a number of users, this commit has the
> > sideaffect of breaking the BIOS workaround that's required to make the
> > GPU on the nvidia P50 work, by causing the GPU's PCI device function to
> > stop working after it's been set to multifunction mode.
>
> This is missing a reference to the commit introducing the P50 quirk,
> which is e0547c81bfcf ("PCI: Reset Lenovo ThinkPad P50 nvgpu at boot
> if necessary").
>
> Please describe in more detail how the GPU's PCI function stops working.
> Does it respond with "all ones" when accessing MMIO?
> Do MMIO accesses cause the system to hang?
>
> Could you provide lspci -vvxx output for the GPU and its associated
> HDA controller with and without b516ea586d71?
>
> Does this machine have external display connectors via which audio
> can be streamed?
>
>
> > I'm not really holding my breath on this patch to being accepted:
> > there's a good chance there's a better solution for this (and I'm going
> > to continue investigating for one after sending this patch), this is
> > more just to start a conversation on what the proper way to fix this is.
>
> Posting as an RFC might have been more appropriate then.
>

no, a revert is actually appropriate.  If a commit fixes something,
but breaks something else, it gets either reverted or fixed. If nobody
fixes it, then revert it is.

>
> > So, I'm kind of confused about why exactly this was implemented as an
> > early boot quirk in the first place. If we're seeing the GPU's PCI
> > device, we already know the GPU is there. Shouldn't we be able to check
> > for the existence of the HDA device once we probe the GPU in nouveau?
>
> I think a motivation to keep this generic was to make it work with
> other drivers besides nouveau, specifically Nvidia's proprietary driver.
> nouveau might not even be enabled.
>
>
> > that still doesn't explain why this was implemented as an early quirk
>
> This isn't an early quirk.  Those live in arch/x86/kernel/early-quirks.c.
> This is just a PCI quirk executed on device enumeration and on resume.
> Devices aren't necessarily enumerated only on boot, e.g. think Thunderbolt.
>
> Thanks,
>
> Lukas
