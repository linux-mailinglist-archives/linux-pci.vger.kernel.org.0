Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CBF2AF8FA
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 20:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgKKTYN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 14:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbgKKTYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 14:24:13 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E82C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 11:24:12 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id f20so4310531ejz.4
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 11:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17t0cJZV83rKsdnF26ww0x8Qr/bgJ69PEyc9Tg6QeSc=;
        b=ExiNS17a/zUnWHOCo86frpvNdG7ej33nbmJqo1kWfIWFOhO5vU83hkuoQWpKK38ysd
         aM/y7fynS/NWiLjeFIeky6lvAOKsO9RWsLM7Iv6PYnnPHJuMN14DzcDfVoabEEhFozWn
         YZ9sRNTRhU6PyfEgNjl57++iL9JXKN5aUsRFNGisW1eCJzkJYIT70ZtfeyxHWd2izt1x
         BJd+X+5/hw9VKe62FQk0pD8ogncWqB+NdtFy+UoWNCmVWHRkjifPgmlCU9DIkNv6PhWE
         1ph4M76zE/KxHB0pkE9xuWk3cO0kyVaAD//AKv6cc2IE6/q3NxGYgjmhkObxpOMQQvif
         4SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17t0cJZV83rKsdnF26ww0x8Qr/bgJ69PEyc9Tg6QeSc=;
        b=tZtsbp/OfvBq6kvwcCwE2Flx1ZXigQQsvCuZTHqct7FMRQ+fKHOxAGNJAEY7wDZXPw
         Hs78618t01sAAR23kGuFh1jT2Hzh96ldrjKjB2hSC9GZCneHpc9GgTDkf9u7BiguJ8Ez
         Z1Qjx96X1vOOxO7+w8ulYhbeqwsn75Fr7zK49ncw+Dz9VsblxKD3xoZbhsuao9PnFUbz
         NYY8L6QbKuaZsxBgWc1qb/WZAZrUwhe3BbwXvWA3Ohz1MBKhpgpPMuF6AQ01RGf2rQek
         G8AlX3ojqKOrdtCoHOaT3t4njhsxcOoi9Gf3wrcoG8wM1m9Vp+QIfXwCtL/FRFcbZfq6
         71kQ==
X-Gm-Message-State: AOAM530qBD+pvHAnkRTqk/6pZnJabxTywaOOl7RNmcdl3w0c83rZKAQ0
        HKB/3xnz1kynw+RR3KI/AZ1x8nlB4IXA+i99DuTUQA==
X-Google-Smtp-Source: ABdhPJw7o+dPmaEGjq8oyHyvXpyezprGFoE+FcyvOGGYPi8wbF8KZirC7QFGBQ6ozUKd81XDNvNdvsU/Ra6dVjQAQd4=
X-Received: by 2002:a17:906:8812:: with SMTP id zh18mr25328865ejb.361.1605122650885;
 Wed, 11 Nov 2020 11:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org>
In-Reply-To: <87imab4slq.fsf@codeaurora.org>
From:   wi nk <wink@technolu.st>
Date:   Wed, 11 Nov 2020 20:24:00 +0100
Message-ID: <CAHUdJJVfrBGHcT1Sjmqn=HK4=ptk3xKmAOLrF8Rd=fONUne-0A@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Thomas Krause <thomaskrause@posteo.de>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kalle,

  Thanks so much for your and your teams efforts.  I've applied the
patch, and I'm receiving some errors similar to what you thought might
occur:

[    7.802756] ath11k_pci 0000:55:00.0: WARNING: ath11k PCI support is
experimental!
[    7.802797] ath11k_pci 0000:55:00.0: BAR 0: assigned [mem
0x8e300000-0x8e3fffff 64bit]
[    7.802815] ath11k_pci 0000:55:00.0: enabling device (0000 -> 0002)
[    7.803291] ath11k_pci 0000:55:00.0: MSI vectors: 1
[    8.172623] ath11k_pci 0000:55:00.0: Respond mem req failed,
result: 1, err: 48
[    8.172624] ath11k_pci 0000:55:00.0: qmi failed to respond fw mem req:-22

I've reverted the commit you mentioned and am rebuilding now.  I'll
test in a few minutes.

Thanks!

On Wed, Nov 11, 2020 at 8:10 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Kalle Valo <kvalo@codeaurora.org> writes:
>
> > Thomas Krause <thomaskrause@posteo.de> writes:
> >
> >> Am 10.11.20 um 09:33 schrieb Kalle Valo:
> >>>
> >>>> I was told that on Dell XPS 15 (with a working QCA6390 setup) there's a
> >>>> separate "Virtualisation" setting in BIOS. See if you have that and try
> >>>> enabling it.
> >>> I was informed about another setting to test: try disabling "Enable
> >>> Secure Boot" in the BIOS. I don't know yet why it would help, but that's
> >>> what few people have recommended.
> >>>
> >>> Please let me know how it goes.
> >>>
> >> I have two options under "Virtualization" in the BIOS: "Enable Intel
> >> Virtualization Technology (VT)" and "VT for Direct I/O". Both were
> >> enabled. Secure boot was also turned off. BIOS version is also at the
> >> most current version 1.1.1.
> >
> > This is good to know, thanks for testing. Now we have explored all
> > possible BIOS options as I know of.
> >
> >> Because of the dmesg errors Thomas Gleixner mentioned, I assume it
> >> would be best to contact Dell directly (even if I'm not sure if and
> >> how fast they will respond).
> >
> > I have asked our people to report this to Dell, but no response yet.
> >
> >> If the driver would manage to work with only 1 vector, I assume this
> >> would also make it work on my configuration, even with possible
> >> performance hits.
> >
> > This is the workaround we are working on at the moment. There's now a
> > proof of concept patch but I'm not certain if it will work. I'll post it
> > as soon as I can and will provide the link in this thread.
>
> The proof of concept patch for v5.10-rc2 is here:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
>
> Hopefully it makes it possible to boot the firmware now. But this is a
> quick hack and most likely buggy, so keep your expectations low :)
>
> In case there are these warnings during firmware initialisation:
>
> ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
>
> Try reverting this commit:
>
> 7fef431be9c9 mm/page_alloc: place pages to tail in __free_pages_core()
>
> That's another issue which is debugged here:
>
> http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
