Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7657927A9C1
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 10:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1IlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 04:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1IlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 04:41:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE93C0613CE;
        Mon, 28 Sep 2020 01:41:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id r7so7316967ejs.11;
        Mon, 28 Sep 2020 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mF3TdtdfTqdhXO/Zs1AU32YnshdL+mbU+4GCV/pjrmM=;
        b=t4DZf5kqFq3rSeItFWLtpI7+uQEHgSZfjnYeqOJFHR20GdxJOcyK/6oXWamCnH+SRI
         /BspyhsOGse9XL9pl8JQPMDi6kZFqWIaXLq4kIp6kHXaL1VNU2SA3wXxuakKFiSBN6Nn
         vcACQT/8FnNAq+bAHue3v2nt0AqRqpHwp2KWMuplp+vWfRZVbBfKnGVgKCfjZD0qV1s9
         1BgA/pTXwKisJJK6GuToTDBSDbrRQNUnAIMPbRDp51sjrOGP/we+74/KyeQxflpr2zuv
         9NCG714uvjOwew2m4xSdnhOQiKwNASqhq8qaxOZlyijJwrscG0EThay5pHCsDS7dcxU5
         Lmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mF3TdtdfTqdhXO/Zs1AU32YnshdL+mbU+4GCV/pjrmM=;
        b=UdGUwfEA+2msjkCEsCV0JNUQqdZ6CPpaJGF2ljbMgW50cwMqeSYEMhnFkS1lJrS44t
         a4QG2S+lqsbz7RoQmGQtjRk7gZgVcVeVOLQnlQvzb6+2LHXZfoBfw+i1ZyGVug9HbQs4
         oCidehJfTVEwIqyY25/HxIlNu3wUispcE/kuyCqgZn/iiQSwvWZyFJ33mjsgx7k6AEno
         UQpzbSy7xX7TBid1gQFtSecuZc2GTx05KgUy3qlNU/ATiUQbUlDBiTzWSAhwcZRkFC8v
         FxkSYt9+4of4GwPlKTC+YdBE64/wy+v/8LCgjKnehv+5SqoCSyoWb/PaZacoRBKMOYMn
         HcEg==
X-Gm-Message-State: AOAM533gMFcKeE1DZyL0EGKNnWsErSZFT1GtxxePQ28Eq17VmZMLup3n
        ay4qiJOD2KAJvkWshLogaHIna7hrJhoryESPv64=
X-Google-Smtp-Source: ABdhPJyS6AEr1N1XwWtqPRGGbMSw6iqdbXjwwcgRPHr6yzv482Y9EqN0WIU5XJqEYRN7go8iB6FPpD4drdlg/yADczQ=
X-Received: by 2002:a17:906:4cd6:: with SMTP id q22mr576780ejt.139.1601282471610;
 Mon, 28 Sep 2020 01:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com> <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
 <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com> <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com> <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com> <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
 <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com> <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
 <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com> <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
 <8beca800-ffb5-c535-6d43-7e750cbf06d0@linux.intel.com> <44f0cac5-8deb-1169-eb6d-93ac4889fe7e@kernel.org>
 <3bc0fd23-8ddd-32c5-1dd9-4d5209ea68c3@linux.intel.com>
In-Reply-To: <3bc0fd23-8ddd-32c5-1dd9-4d5209ea68c3@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Mon, 28 Sep 2020 16:41:00 +0800
Message-ID: <CAKF3qh18ts53GQswbvQbcMApkR9ZpCtqyWffaRw4DvMrBMUE5Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery() call
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sathyanarayanan,

On Mon, Sep 28, 2020 at 10:44 AM Kuppuswamy, Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi,
>
> On 9/25/20 11:30 AM, Sinan Kaya wrote:
> > On 9/25/2020 2:16 PM, Kuppuswamy, Sathyanarayanan wrote:
> >>>
> >>> If this is a too involved change, DPC driver should restore state
> >>> when hotplug is not supported.
> >> Yes. we can add a condition for hotplug capability check.
> >>>
> >>> DPC driver should be self-sufficient by itself.
> >>>
> >
> > Sounds good.
> >
> >>>> Also for non-fatal errors, if reset is requested then we still need
> >>>> some kind of bus reset call here
> >>>
> >>> DPC should handle both fatal and non-fatal cases
> >> Currently DPC is only triggered for FATAL errors.
> >>   and cause a bus reset
> >
> > Thanks for the heads up.
> > This seems to have changed since I looked at the DPC code.
> >
> >>> in hardware already before triggering an interrupt.
> >> Error recovery is not triggered only DPC driver. AER also uses the
> >> same error recovery code. If DPC is not supported, then we still need
> >> reset logic.
> >
> > It sounds like we are cross-talking two issues.
> >
> > 1. no state restore on DPC after FATAL error.
> > Let's fix this.
> Agree. Few more detail about the above issue is,
>
> There are two cases under FATAL error.
>
> FATAL + hotplug - In this case, link will be reseted. And hotplug handler
> will remove the driver state. This case works well with current code.
>
> FATAL + no-hotplug - In this case, link will still be reseted. But
> currently driver state is not properly restored. So I attempted
> to restore it using pci_reset_bus().

Seems you should fix something at device driver side, not do double-reset in
DPC driver, one reset is done by hardware, and you want to do another by
DPC driver ?

Why hardware initiated reset is not enough for you ?

Thanks,
Ethan

>                 status = reset_link(dev);
> -               if (status != PCI_ERS_RESULT_RECOVERED) {
> +               if (status == PCI_ERS_RESULT_RECOVERED) {
> +                       status = PCI_ERS_RESULT_NEED_RESET;
>
> ...
>
>         if (status == PCI_ERS_RESULT_NEED_RESET) {
>                 /*
> -                * TODO: Should call platform-specific
> -                * functions to reset slot before calling
> -                * drivers' slot_reset callbacks?
> +                * TODO: Optimize the call to pci_reset_bus()
> +                *
> +                * There are two components to pci_reset_bus().
> +                *
> +                * 1. Do platform specific slot/bus reset.
> +                * 2. Save/Restore all devices in the bus.
> +                *
> +                * For hotplug capable devices and fatal errors,
> +                * device is already in reset state due to link
> +                * reset. So repeating platform specific slot/bus
> +                * reset via pci_reset_bus() call is redundant. So
> +                * can optimize this logic and conditionally call
> +                * pci_reset_bus().
>                  */
> +               pci_reset_bus(dev);
>
> >
> > 2. no bus reset on NON_FATAL error through AER driver path.
> > This already tells me that you need to split your change into
> > multiple patches.
> >
> > Let's talk about this too. bus reset should be triggered via
> > AER driver before informing the recovery.
> But as per error recovery documentation, any call to
> ->error_detected() or ->mmio_enabled() can request
> PCI_ERS_RESULT_NEED_RESET. So we need to add code
> to do the actual reset before calling ->slot_reset()
> callback. So call to pci_reset_bus() fixes this
> issue.
>
>         if (status == PCI_ERS_RESULT_NEED_RESET) {
> +               pci_reset_bus(dev);
>
>
> >
> >       if (status == PCI_ERS_RESULT_NEED_RESET) {
> >               /*
> >                * TODO: Should call platform-specific
> >                * functions to reset slot before calling
> >                * drivers' slot_reset callbacks?
> >                */
> >               status = PCI_ERS_RESULT_RECOVERED;
> >               pci_dbg(dev, "broadcast slot_reset message\n");
> >               pci_walk_bus(bus, report_slot_reset, &status);
> >       }
> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
