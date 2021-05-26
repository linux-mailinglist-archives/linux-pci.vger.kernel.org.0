Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C4390E97
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 05:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhEZDCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 23:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhEZDCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 May 2021 23:02:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7DAC061574
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 20:00:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o5so29702038edc.5
        for <linux-pci@vger.kernel.org>; Tue, 25 May 2021 20:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tx7mJxthlffjoZpgjkFTXSaY88IRMpEte4AbFaFhDDA=;
        b=LQMc6jfHFUJ6cTkvDVHOCnxWuNzo16DGJs3OtEEpUupISct4abFfTiemFMdmsRVDOk
         WSzfveed9bz7UpEmGfM3wEmNXmEoANOAvHvdMu2P49Yu03eh6zvEMC0CB0X0yFU54+5l
         uW9pvbq5RVf2E166cW2W77O1tOnJiuZSS9U6D7+WMP1BEanXSFCWE5Es+wvCmh9tmwSo
         npUVRqwUFB+pkZ6rxaKae5sGrdbnDkLdLAehln7p7ogfqk1VQzu3uiTpx33PIqSCj1Na
         7h2c28oIhbXd7KQQWISDfEl0qhJk1QpMt7Eh/X/R/gkCElj/Pw2wS8YhLAB6J2htwvBZ
         RM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tx7mJxthlffjoZpgjkFTXSaY88IRMpEte4AbFaFhDDA=;
        b=mVikG7xLyJP5th8EOR5qufiEqSXXaKRzVpvSI1krj5JWQu/Fm+ADz86Lq4cGCaZnwN
         z5q/k5DuYprQCx4nlUkXuiNCZNg03VukosQjjoFk201IafZfqFvf0Ky6zzkXwauQU+r7
         bAksvPR8RVlxMYv50o0+SaAHaq8v/Td6nWb2WzwC5pjKfiDjIFHwUPJYPAzmGkID2DWk
         sORKAyGW6RnR6YPLlSwpxsGOEBz7ZnmEHdZfSCcdJQwHFoTbhrk6uJsULC6p+tHx/Ej+
         1hz0hbBJSHQjo8KWN3sNrJ+Og5QUHmm2e8shL9i76OevIrA2eE8ylhvmhpdc0bOYxlmt
         8wMQ==
X-Gm-Message-State: AOAM530AWSAkGj4YZV3BKd2QgvMVxCdphYr3ms3eKsHmtm4FYIK7Z4fb
        Vz42azlRIa+ebr/2tqrLHdNeLGDNi3JWZF80Ws+hU38U
X-Google-Smtp-Source: ABdhPJzfPNPa3BkvnbzOTwwzXc9lkuymDCMxZdd6Ir3d0h3K+GkWMHGVGMTmey077lpEfDACNwQoicUOlqrT6Zn5bOQ=
X-Received: by 2002:a05:6402:1601:: with SMTP id f1mr8485886edv.383.1621998044377;
 Tue, 25 May 2021 20:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H7D-drrEaDskQhVx0c8_VAy--n3mbsQN_ijfWrRQGVQ=A@mail.gmail.com>
 <20210525135523.GA1185972@bjorn-Precision-5520> <CAAhV-H4Ayg9QyPBsXRqBbsn8OTEmN2yw7Bf3on63UVM950rARA@mail.gmail.com>
In-Reply-To: <CAAhV-H4Ayg9QyPBsXRqBbsn8OTEmN2yw7Bf3on63UVM950rARA@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 26 May 2021 13:00:33 +1000
Message-ID: <CAPM=9tx0kr7xdA8eB2+u6Xg0C7FSMbZEKGVKOTZEkdA7Kay42A@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving bridge
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jingfeng Sui <suijingfeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > > I think I would see if it's possible to call
> > > > vga_arb_select_default_device() from vga_arbiter_add_pci_device()
> > > > instead of from vga_arb_device_init().
> > > >
> > > > I would also (as a separate patch) try to get rid of this loop in
> > > > vga_arb_device_init():
> > > >
> > > >         list_for_each_entry(vgadev, &vga_list, list) {
> > > >                 struct device *dev = &vgadev->pdev->dev;
> > > >
> > > >                 if (vgadev->bridge_has_one_vga)
> > > >                         vgaarb_info(dev, "bridge control possible\n");
> > > >                 else
> > > >                         vgaarb_info(dev, "no bridge control possible\n");
> > > >         }
> > > >
> > > > and do the vgaarb_info() in vga_arbiter_check_bridge_sharing(), where
> > > > the loop would not be needed.
> > >
> > > Any updates?
> >
> > Are you waiting for me to do something else?
> >
> > I suggested an approach above, but I don't have time to actually do
> > the work for you.
> Yes, I am really waiting... but I am also investigating history and thinking.
>
> If I haven't missed something (correct me if I'm wrong). For the
> original HiSilicon problem, the first attempt is to modify
> vga_arbiter_add_pci_device() and remove the VGA_RSRC_LEGACY_MASK
> check. But vga_arbiter_add_pci_device() is called for each PCI device,
> so removing that check will cause the first VGA device to be the
> default VGA device. This breaks some x86 platforms, so after that you
> don't touch vga_arbiter_add_pci_device(), but add
> vga_arb_select_default_device() in vga_arb_device_init().
>
> If the above history is correct, then we cannot add
> vga_arb_select_default_device() in vga_arbiter_add_pci_device()
> directly. So it seems we can only add vga_arb_select_default_device()
> in pci_notify(). And if we don't care about hotplug, we can simply use
> subsys_initcall_sync() to wrap vga_arb_device_init().
>
> And DRM developers, please let me know what do you think about?

I'm not 100% following what is going on here.

Do you need call vga_arb_select_default_device after hotplug for some
reason, or it this just a race with subsys_init?

I think just adding subsys_initcall_sync should be fine

I don't see why you'd want to care about making a hotplug VGA device
the default at this point.

Dave.
