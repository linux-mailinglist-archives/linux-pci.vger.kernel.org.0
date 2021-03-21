Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D71D343313
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 15:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCUO6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCUO6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Mar 2021 10:58:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544CC061574;
        Sun, 21 Mar 2021 07:58:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7224133pjv.1;
        Sun, 21 Mar 2021 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5dXHwVvv9IXUBxrS0ZMAzE1TMsjF7G3MWedvK0pWz4U=;
        b=h/kZmcRBez3kxRN1uzpDkq1nfNfxYng3ajzPuofAC9LO0W4opowUD0tDHFdOK1UFju
         ZHc+DWLSPb5K2G7tWUOWirIvUkquPyhcsxynEF9QNOR3cbGQCLdkjLrlrgqRN+voLtpJ
         x1H2/L0gfBA26BZTMSD6ZXP/JWeabxZD4SKLlFMdlpWvbVE1lAXXYXkv8ohFSWl3tkpn
         wSdqfM/HgOVGBd6UnBE40yJja4thLcy8+xLA73fkEO77MIbXHKlS08OokqtqJbEjBVoS
         Cc/G5dtZyU2s6AXnDdG4Mefeh+p3j9agizDv7ICHAkuizuKP9XZJay2vIolS/mOE4s6U
         UkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5dXHwVvv9IXUBxrS0ZMAzE1TMsjF7G3MWedvK0pWz4U=;
        b=Pv9xQYmwIPahRYajXCrHYxe/kt6ODx85spuJFqLmQg0xKAu/JiNJ5bawde81ZAkxRp
         gLNsFNqoFeGnnuYyC+r9nT8tgL0l+bLNkQoAoXD2Puy7DxgvDvBsuQHbnN+2LYwrtNRV
         DefpdN2irPizsdigqFsaIZqeLllNA7fiuPWbPpAOpBe9ts6EMOTFr9NfchoDEdxojXy9
         awS5kWG8IJj1YRHRnOcOmPYa1fS18CcCt/ggOpcGuQ79rVVMcfahfGuPKFRHtpQ5DrBf
         8UrbObM6wIAUo0veABPkJ1eBJtnIcajfmPcqGGTTtUQyN7kuFDDnhefYEPnXfXh8pSu6
         yFVQ==
X-Gm-Message-State: AOAM532sSNDhPBmWXJHRRpWjHYHUszaUkXUnN1Xf4txPjZc05zGOOKgU
        ftNtDzdLF40AvIMYeEiQWwA=
X-Google-Smtp-Source: ABdhPJzyhvbnOK5sBh9TuzaiRT4d/BehvE77EyUQPHx4YeTm7o9jbh3rg+G1SKUkjaXSxbX0Dny1Pw==
X-Received: by 2002:a17:90a:f3cc:: with SMTP id ha12mr8581843pjb.180.1616338689779;
        Sun, 21 Mar 2021 07:58:09 -0700 (PDT)
Received: from localhost ([103.77.152.181])
        by smtp.gmail.com with ESMTPSA id g21sm11140296pfk.30.2021.03.21.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 07:58:09 -0700 (PDT)
Date:   Sun, 21 Mar 2021 20:27:23 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     alex.williamson@redhat.com, info@metux.ne,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210321145723.efaj7ywkfhefc4x5@archlinux>
References: <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
 <a2b9dc7e-e73a-3a70-5899-8ed37a8ef700@metux.net>
 <YFSgQ2RWqt4YyIV4@unreal>
 <20210319102313.179e9969@omen.home.shazbot.org>
 <YFW78AfbhYpn16H4@unreal>
 <20210320085942.3cefcc48@x1.home.shazbot.org>
 <YFcGlzbaSzQ5Qota@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFcGlzbaSzQ5Qota@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/21 10:40AM, Leon Romanovsky wrote:
> On Sat, Mar 20, 2021 at 08:59:42AM -0600, Alex Williamson wrote:
> > On Sat, 20 Mar 2021 11:10:08 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> > > On Fri, Mar 19, 2021 at 10:23:13AM -0600, Alex Williamson wrote:
> > > >
> > > > What if we taint the kernel or pci_warn() for cases where either all
> > > > the reset methods are disabled, ie. 'echo none > reset_method', or any
> > > > time a device specific method is disabled?
> > >
> > > What does it mean "none"? Does it mean nothing supported? If yes, I think that
> > > pci_warn() will be enough. At least for me, taint is usable during debug stages,
> > > probably if device doesn't crash no one will look to see /proc/sys/kernel/tainted.
> >
> > "none" as implemented in this patch, clearing the enabled function
> > reset methods.
>
> It is far from intuitive, the empty string will be easier to understand,
> because "none" means no reset at all.
>
> >
> > > > I'd almost go so far as to prevent disabling a device specific reset
> > > > altogether, but for example should a device specific reset that fixes
> > > > an aspect of FLR behavior prevent using a bus reset?  I'd prefer in that
> > > > case if direct FLR were disabled via a device flag introduced with the
> > > > quirk and the remaining resets can still be selected by preference.
> > >
> > > I don't know enough to discuss the PCI details, but you raised good point.
> > > This sysfs is user visible API that is presented as is from device point
> > > of view. It can be easily run into problems if PCI/core doesn't work with
> > > user's choice.
> > >
> > > >
> > > > Theoretically all the other reset methods work and are available, it's
> > > > only a policy decision which to use, right?
> > >
> > > But this patch was presented as a way to overcome situations where
> > > supported != working and user magically knows which reset type to set.
> >
> > It's not magic, the new sysfs attributes expose which resets are
> > enabled and the order that they're used, the user can simply select the
> > next one.  Being able to bypass a broken reset method is a helpful side
> > effect of getting to select a preferred reset method.
>
> Magic in a sense that user has no idea what those resets mean, the
> expectation is that he will blindly iterate till something works.
>
> >
> > > If you want to take this patch to be policy decision tool,
> > > it will need to accept "reset_type1,reset_type2,..." sort of input,
> > > so fallback will work natively.
> >
> > I don't see that as a requirement.  We have fall-through support in the
> > kernel, but for a given device we're really only ever going to make use
> > of one of those methods.  If a user knows enough about a device to have
> > a preference, I think it can be singular.  That also significantly
> > simplifies the interface and supporting code.  Thanks,
>
> I'm struggling to get requirements from this thread. You talked about
> policy decision to overtake fallback mechanism, Amey wanted to avoid
> quirks.
Just to clarify I don't want to avoid quirks. I just want device
to be usable even if it doesn't have quirk as the quirk for that
particular device may not be developed at all for different reasons
mentioned earlier.
[...]

Thanks,
Amey
