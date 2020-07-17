Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3C22398F
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgGQKnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 06:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgGQKnj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2020 06:43:39 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3742C061755;
        Fri, 17 Jul 2020 03:43:39 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f23so9940446iof.6;
        Fri, 17 Jul 2020 03:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8uVrhgOhQqs7eK819gJP8Isbzose7d4S6jSpx+aI80=;
        b=Sh5xu9u/wMBK0BIZ3S3CrccFZFXqFVJ4Ty0AQHr0cL8kZHGhS3jOuXUk9jXjaeRefF
         y+C9/gckVZKpTLyBboNKSeD5GSoq5i2gnSTzY9jDo1h3YCoOiz021y7F01Wt1gFKGePd
         ZEIpDHPAYgr9nTouyQ75MdKyfuqMKP/WY7KRH7f6B6cDSyWsBc0eTi6RWbW19OBEIpWR
         7mu5uRRArsi5V/QNvhzymvCcRP0TD3pa0BJ+pTr2rbnt3ONv6qKPOKajYE/O+NHxx83H
         7vJ/K9Y/CIfHTKFwaRU7xDEQeKUUtOjYSvtWxNDzSpOm0gdBf9n+IcV7LZJHGe/MSHLZ
         3vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8uVrhgOhQqs7eK819gJP8Isbzose7d4S6jSpx+aI80=;
        b=oaLGEZLDPTUwrKyb3Q1+CkKQ1BbYh08jDTFoxlta5YUEvq1GYFgqVKsUGlH+prFLhx
         hBaxcOisWoZ/C3l0aYcfKNb+raSXRt7wX+lPr2nkR6AC5iGB6wO0boc8ZQtEjN1sT7WH
         5puzdvsiqr+GyU0Dj2ChfG+EUIm/8H1UdMePExglEdV+KlCU7uL+Up5CjoXBgT01hraV
         XYx8KLD/mF5NuteBo9g2i7hPB9bzsg1/T9HBIOJR3ZX+U6eXZ1n3xVXDW5mK/nM8KeiN
         VL1Z5bEp6k2Z6BlmiYcO9t599yVb+7sHWbZ/EknSVYVj0Pt9yW+aeoxsGrkiU1ZnuERM
         qyCw==
X-Gm-Message-State: AOAM531Msi8hvySRT+gVjBzGdG+c+OPHRhDGhnmtOw32H9xEwXx+W1gO
        vuAq+lfuN9H5wVXjRdq3tcE4iVhrWdG2LKw1M9UZ0fAII2o=
X-Google-Smtp-Source: ABdhPJxtuasrS8D2ZlPmVecjcSsGZsiTpJFsPWZr7RaOLcuYkOg1E6NK9odWW/xu2ORR28QduMslbT/r0b/7WEdeWxM=
X-Received: by 2002:a6b:c343:: with SMTP id t64mr9228896iof.66.1594982618648;
 Fri, 17 Jul 2020 03:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAO3ALPy8_pxVyFROZUWNafEH1vUCP6LVpNmBBuMDSewGitzdLw@mail.gmail.com>
 <CAOSf1CEOu5jX6KXKWiConBf=TDwF3qdASMxtfDjqSR6vOKN4XA@mail.gmail.com> <CAO3ALPwZPN1vdqHaFsuSpgj63o6Z69VUg0LngmCSnvESrO4kNg@mail.gmail.com>
In-Reply-To: <CAO3ALPwZPN1vdqHaFsuSpgj63o6Z69VUg0LngmCSnvESrO4kNg@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Fri, 17 Jul 2020 20:43:27 +1000
Message-ID: <CAOSf1CEiCOjTQ8XX=cC10eghaC+1xaRG-bju8VBFQStOCaU_xQ@mail.gmail.com>
Subject: Re: ASMedia USB 3.x host controllers triggering EEH on POWER9
To:     Forest Crossman <cyrozap@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 8:10 PM Forest Crossman <cyrozap@gmail.com> wrote:
>
> > From word 2 of the PEST entry the faulting DMA address is:
> > 0x0000203974c00000. That address is interesting since it looks a lot
> > like a memory address on the 2nd chip, but it doesn't have bit 59 set
> > so TVE#0 is used to validate it. Obviously that address is above 2GB
> > so we get the error.
>
> Ah, I see. Do you know if the information on the PEST registers is
> documented publicly somewhere? I tried searching for what those
> registers meant in the PHB4 spec but it basically just said, "the PEST
> registers contain PEST data," which isn't particularly helpful.

Most of it is in the IODA spec. See Sec 2.2.6 "Partitionable-Endpoint
State Table", the only part that isn't documented there is the top
bits of each word which are documented in the PHB spec for some
reason. For word one the top bit (PPCBIT(0)) means MMIO is frozen and
for word two (PPCBIT(64)) the top bit indicates DMA is frozen.

> > What's probably happening is that the ASmedia controller doesn't
> > actually implement all 64 address bits and truncates the upper bits of
> > the DMA address. Doing that is a blatant violation of the PCIe (and
> > probably the xHCI) spec, but it's also pretty common since "it works
> > on x86." Something to try would be booting with the iommu=nobypass in
> > the kernel command line. That'll disable TVE#1 and force all DMAs to
> > go through TVE#0.
>
> Thanks, iommu=nobypass fixed it! Plugging in one or more USB devices
> no longer triggers any EEH errors.
>
> > Assuming the nobypass trick above works, what you really need to do is
> > have the driver report that it can't address all 64bits by setting its
> > DMA mask accordingly. For the xhci driver it looks like this is done
> > in xhci_gen_setup(), there might be a quirks-style interface for
> > working around bugs in specific controllers that you can use. Have a
> > poke around and see what you can find :)
>
> Yup, the xhci driver has a quirks system, and conveniently one of
> those is XHCI_NO_64BIT_SUPPORT. After making a 3-line patch to
> xhci-pci.c to add that quirk for this chip, the host controller is now
> able to work without setting iommu=nobypass in the kernel arguments.

Cool

> Thank you so much for your help! You've likely saved me several hours
> of reading documentation, as well as several more hours of fiddling
> around with the xhci driver.

> I'm almost disappointed the fix was so
> simple, but the time savings alone more than makes up for it. I'll
> submit the patch to the USB ML shortly.

It might be only three lines, but it doesn't mean it's trivial. Most
bugs like that require a lot of context to understand, let alone fix.
Thanks for looking into it!

Oliver
