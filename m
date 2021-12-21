Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8547C868
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhLUUte (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 15:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLUUte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Dec 2021 15:49:34 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292ABC061574
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 12:49:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 196so323814pfw.10
        for <linux-pci@vger.kernel.org>; Tue, 21 Dec 2021 12:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fpO1/NlhpUP+zpvFyoU92x0nPSjJTWIVWohS5NSVrdk=;
        b=UFkRgPpoj8/4s09OJvWdScMDwbhctE0SausDKsVQkZt+H1AJvbzQwoj0h/VtR7bVUQ
         tb8XKafvY7akt74fRcxEykmZHbmBErOlalqeeBUHSU9PEk6fTq8J3hPpjgzLChUlBlBx
         yDBKpblqIxmbEppmWlqjQhu+2Qh0juhhYTZahIcLr8a6sj5LJ28qRNCeGIqJclOP+NOR
         udEUyTp0IRfxuFiPjwZI8pxPbGMYyii3AR9/eQXuD0woe82LTAV/w25BFuAfFWPyqSkk
         2IGREq0v5AJqx0hjBR9EicodE+T9wAg4i6K4noFelI7JXTR83N+qDt+ctLoOsCl1RKpC
         dckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fpO1/NlhpUP+zpvFyoU92x0nPSjJTWIVWohS5NSVrdk=;
        b=7YbeVVhyMg75XQEOyhsMKKxfEA0wSCZ2lEaOzHgCNmh5+sR3xD3grKFZE4fiw0DMBZ
         ZmVXDyjpD2PZ94hx4rKuuJWNLXzuzASsEzErZWGKWg32/9AvnAX8IYnYtfJDCibWO0t1
         XzYtY6CMzO+LqNFERdgNRqZscGPofE3qHGOzWQh+RlDFCG5GRfJs2I83oEO10TILMggA
         ihuofoloBcWQ71QM/fP/NbZNMajZ988xGejkvsdq/Nof3FxQA8lEgdC78hn39ZlpPRLq
         g7u5iOjkNyF+dlyXpzQRj1/NXOQz9aZPu3nGZp+jo0t7FAvM7BA++JjmQ8cIoN1DM3jf
         2wDQ==
X-Gm-Message-State: AOAM530UMXOpcWgRpqHZ6zhQSQUB9RrjexQ5ourb2p0vTB3HvmFdC/Wu
        TBjII3dNgONIJGg/4TaoRL7qjdvFTtZsXGkFgXx0SeFaI/0=
X-Google-Smtp-Source: ABdhPJwwlnon/L9UYJYUity9KycjKvDIATfDZtJC6s1wxckPxFJJOJHF6y0IN6o0gH8KrSZABlS7Uv015+tM9zoMjXQ=
X-Received: by 2002:a63:85c8:: with SMTP id u191mr118380pgd.146.1640119773228;
 Tue, 21 Dec 2021 12:49:33 -0800 (PST)
MIME-Version: 1.0
References: <CACK8Z6FpSYeGxZBe12qkmGLmL+Z+h8gMEJ_Z1VyYbbSeBtDf_g@mail.gmail.com>
In-Reply-To: <CACK8Z6FpSYeGxZBe12qkmGLmL+Z+h8gMEJ_Z1VyYbbSeBtDf_g@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 21 Dec 2021 12:48:56 -0800
Message-ID: <CACK8Z6GR9pR0Oc_G70q2MxTVgrk+PXWTFbWT1EjARnuYCRavLw@mail.gmail.com>
Subject: Re: [RFC Proposal] A mechanism to quirk all configuration access to a
 PCI device
To:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 12:46 PM Rajat Jain <rajatja@google.com> wrote:
>
> Hello Bjorn, List,
>
> Sometimes we come across PCI devices that have an errata that require
> special handling when accessing that device's configuration space.
> (E.g. https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf):
>  - Some registers may only support access of a particular size.
>  - Some registers may have a bad value, so need to return some other good value.
>  - etc.
>
> So I have been thinking about implementing a mechanism that allows a
> PCI quirk for a device (VID/DID/ etc), such that all the PCI
> configuration accesses to that device goes through that quirk (thus
> giving it a chance to do any special handling). This includes access
> from kernel, userspace and drivers. AFAIU, a reasonable central point
> where all the PCI configuration accesses go through are:
>
> pci_bus->ops->read()
> pci_bus->ops->write()
>
> thus making the macros
>
> pci_bus_read_config_##size()
> pci_user_read_config_##size()
>
> good candidates for tapping configuration accesses. Here is a
> proposal, I'd appreciate it if you could please let me know what you
> think about this. I've tried this to be as less intrusive and as
> efficient as possible.
>
> BASIC IDEA:
>
> (1) Provide macros that follow existing fixup macros:
>
> #define DECLARE_PCI_FIXUP_CONFIG_READ(...)
>               ....
> #define DECLARE_PCI_FIXUP_CONFIG_WRITE(...)
>               ....
> These macros shall allow to place hooks for particular VIDs/DIDs in
> special sections (.pci_fixup_config_read, .pci_fixup_config_write)
>
> (2) Add the following data structures to the struct pci_bus, all of
> them initialized with 0/NULL:
>
> /*
>  *  Bitmap with 1 bit for each devfn on this pci_bus.
>  * Each bit, if set, means that config accesses to that
>  * devfn needs to go through a quirk
>  */
> u32 bitmap_quirk;
>
> /*
>  * Array of 32 function pointers (config space quirk functions),
>  * 1 for each devfn possible on this pci_bus.
>  * ("quirk_function_ptr" is a typedef here)
>  *
> /
> quirk_function_ptr config_read_quirk[32];
> quirk_function_ptr config_write_quirk[32];
>
> (3) When the config access is made, in the following macros:
>
> pci_bus_read_config_##size
> pci_bus_write_config_##size
> pci_user_read_config_##size
> pci_user_write_config_##size
>
> Check and quirk if we need to:
>
> if (bus->bitmap_quirk & (1 << devfn)) {    /* Does this devfn needs
> config quirk? */
>     bus->config_read_quirk[devfn](...)
> } else {
>      bus->ops->read(...)
> }
>
> (4) Somewhere during the pci_dev addition time (perhaps in pci_setup_device()):
>      Do something like:
>      pci_attach_config_fixup(pci_fixup_config_read, dev);
>      pci_attach_config_fixup(pci_fixup_config_write, dev);
>       - These functions shall be somewhat similar to pci_do_fixups()
> in matching DID/VID etc and if there is a match:
>       - Set the corresponding bit and function pointers in the parent pci_bus.
>
> (5) Somewhere during the pci_dev removal time (perhaps in
> pci_device_add() or  pci_setup_device()):
>      Do something like:
>      pci_attach_config_fixup(pci_fixup_config_read, dev);
>      pci_attach_config_fixup(pci_fixup_config_write, dev);
>       - These functions shall be somewhat similar to pci_do_fixups()
> in matching DID/VID etc and if there is a match:
>       - Set the corresponding bit in the bitmap and function pointer
> in the parent pci_bus.

ARGHH. A copy paste issue :-(. But I think you get the idea. Step (5)
is the reverse of Step (4) i.e. it will undo what step (4) did
 - clear the bit in the bit map
- clear the function pointer.

Thanks,

Rajat

>
> NOTES:
>
> a. Since the device quirk, shall be called while holding the pci_lock,
> it shall need to be fast (perhaps not allowed to do anything else
> rather than dev->bus->ops->read() and perhaps massage values before
> returning it).
>
> b. Note that in step (4) and (5), we're changing the pci_bus fields
> when we add or remove pci_dev. I think that should be OK to do without
> a lock because we can choose to do it at a place where we are holding
> the pci_bus_sem.
>
> c. I think I might have to use a lock to protect the pci_bus new
> fields anyway but I think it should be fast. Anyway, I think we can
> think about the locking as a next step once I get some feedback.
>
> This is something I came up with this morning, so of course there
> might be gaps or things I didn't think of. Please let me know your
> comments and / or thoughts.
>
> Thanks & Best Regards,
>
> Rajat
