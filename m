Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5A77D027
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 23:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbfGaVfQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 17:35:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33778 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbfGaVfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 17:35:15 -0400
Received: by mail-qk1-f195.google.com with SMTP id r6so50367389qkc.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2019 14:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Yt3D9L2XmMJM/hxeEeDRbs7n5AVGloPaWA/yadI+Qrg=;
        b=o9F2mEhW12+rSm2foBMGkHw9463N1nUaZJcTq+/FBvy621JpEG+7HAYW37w/tDZsYw
         li72iQQu0bWoJH9YOW/mlZlEKJgMQPb0BVmJfXkZe1BqMMwrWGFigEkuMEu7rB5Zlcvo
         x8zmvzHJr49RRH7OOG1YB8dAZwqtlPbxL3100HQ2lDDmAaP0LlknXvyFYlhIOOViR6y3
         mXSjNKcubfo8hC0nvvvo90xquTFjU0v1D7irC4T8EaFvONah0a6O8Ebg5MMX5MX77luj
         PJjsPJPqcMwXKvmFFZi7RHpbuJ193zIHoih1XE1lobROQFqG2d90WdVxX2agVkj0oXSa
         FfiQ==
X-Gm-Message-State: APjAAAXsdstjCsXnQ5PPG+gF31cb+V2PqI/nXmwrS88lJqYkLB8gjfVN
        kz/t8Obwso5y97C1FMm0A8QE7Q==
X-Google-Smtp-Source: APXvYqwq8iZNfTZjhmXSZpr7SbYmuaQHxbwUhmb4FHrOYyaB4ijjIYu+VCEGw1Epf8zn+a0otAy3Vw==
X-Received: by 2002:a05:620a:1411:: with SMTP id d17mr77658658qkj.137.1564608914930;
        Wed, 31 Jul 2019 14:35:14 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id e8sm28934259qkn.95.2019.07.31.14.35.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 14:35:13 -0700 (PDT)
Message-ID: <b27614151184f29bb147786933cb424fddb82a23.camel@redhat.com>
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
Date:   Wed, 31 Jul 2019 17:35:11 -0400
In-Reply-To: <CACO55tu=9ZBzGkwdXPOwWARy1UTspFv+v=nrmLFoOKiSGU+E5Q@mail.gmail.com>
References: <20190731201927.22054-1-lyude@redhat.com>
         <20190731211842.befvpoyudrm2subf@wunner.de>
         <CACO55tu=9ZBzGkwdXPOwWARy1UTspFv+v=nrmLFoOKiSGU+E5Q@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-07-31 at 23:26 +0200, Karol Herbst wrote:
> On Wed, Jul 31, 2019 at 11:18 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Jul 31, 2019 at 04:19:27PM -0400, Lyude Paul wrote:
> > > While this fixes audio for a number of users, this commit has the
> > > sideaffect of breaking the BIOS workaround that's required to make the
> > > GPU on the nvidia P50 work, by causing the GPU's PCI device function to
> > > stop working after it's been set to multifunction mode.
> > 
> > This is missing a reference to the commit introducing the P50 quirk,
> > which is e0547c81bfcf ("PCI: Reset Lenovo ThinkPad P50 nvgpu at boot
> > if necessary").
> > 
> > Please describe in more detail how the GPU's PCI function stops working.
> > Does it respond with "all ones" when accessing MMIO?
> > Do MMIO accesses cause the system to hang?
> > 
> > Could you provide lspci -vvxx output for the GPU and its associated
> > HDA controller with and without b516ea586d71?
> > 
> > Does this machine have external display connectors via which audio
> > can be streamed?
> > 
> > 
> > > I'm not really holding my breath on this patch to being accepted:
> > > there's a good chance there's a better solution for this (and I'm going
> > > to continue investigating for one after sending this patch), this is
> > > more just to start a conversation on what the proper way to fix this is.
> > 
> > Posting as an RFC might have been more appropriate then.
> > 
> 
> no, a revert is actually appropriate.  If a commit fixes something,
> but breaks something else, it gets either reverted or fixed. If nobody
> fixes it, then revert it is.

To answer Lukas's question btw: most of the details on how things break are
back in the original commit (sorry for forgetting the reference!), there's a
_lot_ of explanation there that I'd rather not retype, so just refer back to
the commit and bug @ https://bugs.freedesktop.org/show_bug.cgi?id=75985

Additionally, there was some extra discussion providing some more detail in
the email thread that I had with Bjorn:

https://lkml.org/lkml/2019/2/12/1172

As for how this commit breaks the workaround: it seems that when we enable the
HDA controller and put the GPU into multifunction mode, the function-level
reset stops working and thus we can't reset the GPU anymore. Currently I can
see a couple of solutions (again, please feel free to suggest more!):

 * Just revert the commit. We should do this if necessary, but of course I'd
   much rather try finding a fix first
 * Disable the HDA controller temporarily when a GPU reset is neded in
   quirk_reset_lenovo_thinkpad_p50_nvgpu(), then call the function level
   reset, then re-enable the HDA controller. I have no idea if this actually
   works yet, but I'm about to try this on my system
 * Get quirk_reset_lenovo_thinkpad_p50_nvgpu() to run before
   quirk_nvidia_hda(). This would probably be fine, but we would need to
   rework some stuff in the PCI subsystem (maybe it already has a way to do
   this? haven't checked yet) so that we could perform an flr probe early
   enough to perform the quirk
> 
> > > So, I'm kind of confused about why exactly this was implemented as an
> > > early boot quirk in the first place. If we're seeing the GPU's PCI
> > > device, we already know the GPU is there. Shouldn't we be able to check
> > > for the existence of the HDA device once we probe the GPU in nouveau?
> > 
> > I think a motivation to keep this generic was to make it work with
> > other drivers besides nouveau, specifically Nvidia's proprietary driver.
> > nouveau might not even be enabled.
> > 
> > 
> > > that still doesn't explain why this was implemented as an early quirk
> > 
> > This isn't an early quirk.  Those live in arch/x86/kernel/early-quirks.c.
> > This is just a PCI quirk executed on device enumeration and on resume.
> > Devices aren't necessarily enumerated only on boot, e.g. think
> > Thunderbolt.
> > 
> > Thanks,
> > 
> > Lukas
-- 
Cheers,
	Lyude Paul

