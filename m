Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A2E3407E9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhCROcs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhCROcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 10:32:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37A5C06174A;
        Thu, 18 Mar 2021 07:32:42 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l1so1554375pgb.5;
        Thu, 18 Mar 2021 07:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EsgoK5vy2i7jVBgXdWbwbaL5Sk53QOvH3CIsF8AtkMc=;
        b=JnI+ga5OfGkt6Y01wg23uYC0k49lPui3HnqTkU7tEKvScHL7F7hrAEXOx+yALq1G29
         R7sFURj/OkOuag15t1ZR2rdGBfslOr6pmGcFLX3iBp9syzW6i8GORpdieK3Cb7ieOTjG
         hRSO72wIZvN3Fixvw/Ph8A2kbV+jp1R6ZFAQalG/bMfoxVvVOzlaVXVFB3SjA5KLvrua
         d10fEmxd+GbX/leocpPHsYg9QzQtms/AY6nrq6kPSayvL9npxhQ3wxOLM2A8k5QddPTq
         NDGd/7HDTry5KXaUBh4R2M9DHhIdVepFLzWSfmO4fGHWVL7sDExguON3x52TNpYyk0ni
         CUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EsgoK5vy2i7jVBgXdWbwbaL5Sk53QOvH3CIsF8AtkMc=;
        b=cxIgyNI0/lhrX6ry4aFRP8ZCG/auRi809sAL2frZ5P3g9p/03Z3s8KPPCfyFgmmcIN
         JQwcSo1UDh40zS2NZbJ9sqdwd2+kWyGKTM3ylkb49ugJ+h8iJtik89NDcXI+omhkA+Oz
         frAopGTDgfQuLEuePPufhw40rcmZ956I9l8d5Fmnd3CjMFISqmYnGaGUebKkuswoKdXl
         QRQuUTszh9EUZ0EnspbQZinp7J8Gov5/Kfa29xh5cU72izAPbcx3adBS3iaUZsKTgNT8
         OHvFMr78PTsv9j4bHgqMDs8tIZX9qLb9xl3qLXlD6Jremqp9Stw5uMaKrrb5ThMgQL36
         aZSw==
X-Gm-Message-State: AOAM530sxKgEWhzhRk4vPpAk+pUixXY7GvqVkx/plF782hlrjz0nrCac
        E4Ynvv9LCTvF/VuLG18dFcA=
X-Google-Smtp-Source: ABdhPJyMhsjnu3S/UFkHc5iPQjjOONV+5bZX4EldBVA5Mwvc5x1EXIhy+cES8v7rwj9/4HnM05V/AA==
X-Received: by 2002:aa7:8d84:0:b029:1f8:3449:1bc6 with SMTP id i4-20020aa78d840000b02901f834491bc6mr4367670pfr.76.1616077961292;
        Thu, 18 Mar 2021 07:32:41 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id gg22sm2717243pjb.20.2021.03.18.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 07:32:39 -0700 (PDT)
Date:   Thu, 18 Mar 2021 20:01:55 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     alex.williamson@redhat.com, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210318143155.4vuf3izuzihiujaa@archlinux>
References: <20210315083409.08b1359b@x1.home.shazbot.org>
 <20210315145238.6sg5deblr2z2pupu@pali>
 <20210315090339.54546e91@x1.home.shazbot.org>
 <20210317190206.zrtzwgskxdogl7dz@pali>
 <20210317131536.38f398b0@omen.home.shazbot.org>
 <20210317192424.kpfybcrsen3ivr4f@pali>
 <20210317133245.7d95909c@omen.home.shazbot.org>
 <20210317194024.nkzrbbvi6utoznze@pali>
 <20210317140020.4375ba76@omen.home.shazbot.org>
 <20210317201346.v6t4rde6nzmt7fwr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210317201346.v6t4rde6nzmt7fwr@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/17 09:13PM, Pali Rohár wrote:
> On Wednesday 17 March 2021 14:00:20 Alex Williamson wrote:
> > On Wed, 17 Mar 2021 20:40:24 +0100
> > Pali Rohár <pali@kernel.org> wrote:
> >
> > > On Wednesday 17 March 2021 13:32:45 Alex Williamson wrote:
> > > > On Wed, 17 Mar 2021 20:24:24 +0100
> > > > Pali Rohár <pali@kernel.org> wrote:
> > > >
> > > > > On Wednesday 17 March 2021 13:15:36 Alex Williamson wrote:
> > > > > > On Wed, 17 Mar 2021 20:02:06 +0100
> > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > >
> > > > > > > On Monday 15 March 2021 09:03:39 Alex Williamson wrote:
> > > > > > > > On Mon, 15 Mar 2021 15:52:38 +0100
> > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > >
> > > > > > > > > On Monday 15 March 2021 08:34:09 Alex Williamson wrote:
> > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > > > > > > warm reset respectively.
> > > > > > > > > > >
> > > > > > > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > > > > > > kernel function (yet).
> > > > > > > > > >
> > > > > > > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > > > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > > > > > > defined here.
> > > > > > > > >
> > > > > > > > > Ok!
> > > > > > > > >
> > > > > > > > > > Note that with this series the resets available through
> > > > > > > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > > > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > > > > > > methods used here are limited to devices where only a single function is
> > > > > > > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > > > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > > > > > > series only enables selection of the existing methods.  Thanks,
> > > > > > > > > >
> > > > > > > > > > Alex
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > But with this patch series, there is still an issue with PCI secondary
> > > > > > > > > bus reset mechanism as exported sysfs attribute does not do that
> > > > > > > > > remove-reset-rescan procedure. As discussed in other thread, this reset
> > > > > > > > > let device in unconfigured / broken state.
> > > > > > > >
> > > > > > > > No, there's not:
> > > > > > > >
> > > > > > > > int pci_reset_function(struct pci_dev *dev)
> > > > > > > > {
> > > > > > > >         int rc;
> > > > > > > >
> > > > > > > >         if (!dev->reset_fn)
> > > > > > > >                 return -ENOTTY;
> > > > > > > >
> > > > > > > >         pci_dev_lock(dev);
> > > > > > > > >>>     pci_dev_save_and_disable(dev);
> > > > > > > >
> > > > > > > >         rc = __pci_reset_function_locked(dev);
> > > > > > > >
> > > > > > > > >>>     pci_dev_restore(dev);
> > > > > > > >         pci_dev_unlock(dev);
> > > > > > > >
> > > > > > > >         return rc;
> > > > > > > > }
> > > > > > > >
> > > > > > > > The remove/re-scan was discussed primarily because your patch performed
> > > > > > > > a bus reset regardless of what devices were affected by that reset and
> > > > > > > > it's difficult to manage the scope where multiple devices are affected.
> > > > > > > > Here, the bus and slot reset functions will fail unless the scope is
> > > > > > > > limited to the single device triggering this reset.  Thanks,
> > > > > > > >
> > > > > > > > Alex
> > > > > > > >
> > > > > > >
> > > > > > > I was thinking a bit more about it and I'm really sure how it would
> > > > > > > behave with hotplugging PCIe bridge.
> > > > > > >
> > > > > > > On aardvark PCIe controller I have already tested that secondary bus
> > > > > > > reset bit is triggering Hot Reset event and then also Link Down event.
> > > > > > > These events are not handled by aardvark driver yet (needs to
> > > > > > > implemented into kernel's emulated root bridge code).
> > > > > > >
> > > > > > > But I'm not sure how it would behave on real HW PCIe hotplugging bridge.
> > > > > > > Kernel has already code which removes PCIe device if it changes presence
> > > > > > > bit (and inform via interrupt). And Link Down event triggers this
> > > > > > > change.
> > > > > >
> > > > > > This is the difference between slot and bus resets, the slot reset is
> > > > > > implemented by the hotplug controller and disables presence detection
> > > > > > around the bus reset.  Thanks,
> > > > >
> > > > > Yes, but I'm talking about bus reset, not about slot reset.
> > > > >
> > > > > I mean: to use bus reset via sysfs on hardware which supports slots and
> > > > > hotplugging.
> > > > >
> > > > > And if I'm reading code correctly, this combination is allowed, right?
> > > > > Via these new patches it is possible to disable slot reset and enable
> > > > > bus reset.
> > > >
> > > > That's true, a slot reset is simply a bus reset wrapped around code
> > > > that prevents the device from getting ejected.
> > >
> > > Yes, this makes slot reset "safe". But bus reset is "unsafe".
> > >
> > > > Maybe it would make
> > > > sense to combine the two as far as this interface is concerned, ie. a
> > > > single "bus" reset method that will always use slot reset when
> > > > available.  Thanks,
> > >
> > > That should work when slot reset is available.
> > >
> > > Other option is that mentioned remove-reset-rescan procedure.
> >
> > That's not something we can introduce to the pci_reset_function() path
> > without a fair bit of collateral in using it through vfio-pci.
> >
> > > But quick search in drivers/pci/hotplug/ results that not all hotplug
> > > drivers implement reset_slot method.
> > >
> > > So there is a possible issue with hotplug driver which may eject device
> > > during bus reset (because e.g. slot reset is not implemented)?
> >
> > People aren't reporting it, so maybe those controllers aren't being
> > used for this use case.  Or maybe introducing this patch will make
> > these reset methods more readily accessible for testing.  We can fix or
> > blacklist those controllers for bus reset when reports come in.  Thanks,
>
> Ok! I do not know neither if those controllers are used, but looks like
> that there are still changes in hotplug code.
>
> So I guess with these patches people can test it and report issues when
> such thing happen.
So after a bit research as I understood we need to group slot
and bus reset together in a single category of reset methods and
then implicitly use slot reset if it is available when bus reset is
enabled by the user.
Is that right?

Thanks,
Amey
