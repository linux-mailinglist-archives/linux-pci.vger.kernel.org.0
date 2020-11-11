Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94332AF916
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 20:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgKKTaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 14:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgKKTaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 14:30:46 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8123C0613D4
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 11:30:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l5so3501463edq.11
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 11:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technolu-st.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfpvlr42Ejlp4UIVAMApVw3GFjdSl1xlqVfP6UN0K3o=;
        b=pJiY6vJnkK/IWOQQ7MSZuQovzJvbc5eu+lN2xJTomu/pmX8KGiZM5ER71Vz+4A0/02
         Miy5XSD82QsEJ4xfiquGUrs6sokPTO71DbNcrgck5gxl8etL0nUIPXd1s5bkt03818Lt
         g6OoxVfKqyR+Eccf4l5OxM7j45T/m342mN1BpvlXo+qNr9HByJxn4KtNtwQLRT1VyrxN
         Q240z9luSemx32NNWPvTgvEFCpKsQh0nk8NYGtmyNGjRnCVVkIeGZcGEmRpiRujAywhN
         1ACC7Hz7vJAWDO7hSQfZ0nzgWqtR85wa9nV6thN8MYSwyRxzZ+R/p5xYOuJbZwfZdm1G
         0Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfpvlr42Ejlp4UIVAMApVw3GFjdSl1xlqVfP6UN0K3o=;
        b=IdudXBZLl0QCOkyqf9E+ScCHTk9vXjnVMqyoGpJftl8s6PHJJ9m2/LO82DIgoHo9v/
         MnOn4nCOzlkGIzrsejWxL3qKU3nB3ttkRfagU8hUYnJqdnHEA7o6bfebs98OjvurIpI7
         Hej3i3Bv91GzFaTCWlJJ3oUnPqTK7f438WmMZ0Zqa/EGsWoB7bBWHYsC+DjKPwiHO93J
         7unJcDn6M3+t7e15pdWTjVUClShxCc/UntqV1Hk7rpkEDLVUKlFKPEC2o8OlnRqGudxC
         /3Rm2NLK2TeF614MFKp/nftDyWjoqWV6nMlPxo92lJyYVzuI+MvXPG/rWV3xUyvzZOLL
         bA9w==
X-Gm-Message-State: AOAM5315bqZ9aXHlO75gpXDwdW4EZpse/4qIcOSqn8k4NtB7peW3SgNC
        muNu+FkeOnJGgvUjhxiQhcw1MoPKrPcSqNpsadFKM1cSIFeEzyr9u6g=
X-Google-Smtp-Source: ABdhPJxZNIlsWPBdv1WXYEqgX/DBT8BW1V0akDXPxZZkDlCe8PEfY7ywmVIBS1SrlofIUA8RuHOK9MII7W6OOsnFbNs=
X-Received: by 2002:a50:d315:: with SMTP id g21mr1203522edh.84.1605123044430;
 Wed, 11 Nov 2020 11:30:44 -0800 (PST)
MIME-Version: 1.0
References: <20201103160838.GA246433@bjorn-Precision-5520> <874km61732.fsf@nanos.tec.linutronix.de>
 <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de> <87mtzxkus5.fsf@nanos.tec.linutronix.de>
 <87wnz0hr9k.fsf@codeaurora.org> <87ft5hehlb.fsf@codeaurora.org>
 <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de> <87v9ec9rk3.fsf@codeaurora.org>
 <87imab4slq.fsf@codeaurora.org> <CAHUdJJVfrBGHcT1Sjmqn=HK4=ptk3xKmAOLrF8Rd=fONUne-0A@mail.gmail.com>
In-Reply-To: <CAHUdJJVfrBGHcT1Sjmqn=HK4=ptk3xKmAOLrF8Rd=fONUne-0A@mail.gmail.com>
From:   wi nk <wink@technolu.st>
Date:   Wed, 11 Nov 2020 20:30:33 +0100
Message-ID: <CAHUdJJVVj3y-mHxAyUx=P51hG=NspuHe=cOWWRxEjYF0nVquyw@mail.gmail.com>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Thomas Krause <thomaskrause@posteo.de>,
        Govind Singh <govinds@codeaurora.org>,
        linux-pci@vger.kernel.org, Stefani Seibold <stefani@seibold.net>,
        linux-wireless@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, Devin Bayer <dev@doubly.so>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok with 7fef431be9c9 reverted, it doesn't seem to change the initialization any:

[    7.961867] ath11k_pci 0000:55:00.0: WARNING: ath11k PCI support is
experimental!
[    7.961913] ath11k_pci 0000:55:00.0: BAR 0: assigned [mem
0x8e300000-0x8e3fffff 64bit]
[    7.961930] ath11k_pci 0000:55:00.0: enabling device (0000 -> 0002)
[    7.962009] ath11k_pci 0000:55:00.0: MSI vectors: 1
[    8.461553] ath11k_pci 0000:55:00.0: Respond mem req failed,
result: 1, err: 48
[    8.461556] ath11k_pci 0000:55:00.0: qmi failed to respond fw mem req:-22

and just for thoroughness, here are my firmware file checksums (sha256):

9cc48d1dce819ead4112c6a8051c51e4d75e2b11f99ba9d8738cf8108967b70e  amss.bin
5081930c3b207f8ed82ff250f9b90fb77e87b2a92c3cf80ad020a58dea0bc5b7  board.bin
596482f780d21645f72a48acd9aed6c6fc8cf2d039ac31552a19800674d253cc  m3.bin


Thanks!


On Wed, Nov 11, 2020 at 8:24 PM wi nk <wink@technolu.st> wrote:
>
> Kalle,
>
>   Thanks so much for your and your teams efforts.  I've applied the
> patch, and I'm receiving some errors similar to what you thought might
> occur:
>
> [    7.802756] ath11k_pci 0000:55:00.0: WARNING: ath11k PCI support is
> experimental!
> [    7.802797] ath11k_pci 0000:55:00.0: BAR 0: assigned [mem
> 0x8e300000-0x8e3fffff 64bit]
> [    7.802815] ath11k_pci 0000:55:00.0: enabling device (0000 -> 0002)
> [    7.803291] ath11k_pci 0000:55:00.0: MSI vectors: 1
> [    8.172623] ath11k_pci 0000:55:00.0: Respond mem req failed,
> result: 1, err: 48
> [    8.172624] ath11k_pci 0000:55:00.0: qmi failed to respond fw mem req:-22
>
> I've reverted the commit you mentioned and am rebuilding now.  I'll
> test in a few minutes.
>
> Thanks!
>
> On Wed, Nov 11, 2020 at 8:10 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > Kalle Valo <kvalo@codeaurora.org> writes:
> >
> > > Thomas Krause <thomaskrause@posteo.de> writes:
> > >
> > >> Am 10.11.20 um 09:33 schrieb Kalle Valo:
> > >>>
> > >>>> I was told that on Dell XPS 15 (with a working QCA6390 setup) there's a
> > >>>> separate "Virtualisation" setting in BIOS. See if you have that and try
> > >>>> enabling it.
> > >>> I was informed about another setting to test: try disabling "Enable
> > >>> Secure Boot" in the BIOS. I don't know yet why it would help, but that's
> > >>> what few people have recommended.
> > >>>
> > >>> Please let me know how it goes.
> > >>>
> > >> I have two options under "Virtualization" in the BIOS: "Enable Intel
> > >> Virtualization Technology (VT)" and "VT for Direct I/O". Both were
> > >> enabled. Secure boot was also turned off. BIOS version is also at the
> > >> most current version 1.1.1.
> > >
> > > This is good to know, thanks for testing. Now we have explored all
> > > possible BIOS options as I know of.
> > >
> > >> Because of the dmesg errors Thomas Gleixner mentioned, I assume it
> > >> would be best to contact Dell directly (even if I'm not sure if and
> > >> how fast they will respond).
> > >
> > > I have asked our people to report this to Dell, but no response yet.
> > >
> > >> If the driver would manage to work with only 1 vector, I assume this
> > >> would also make it work on my configuration, even with possible
> > >> performance hits.
> > >
> > > This is the workaround we are working on at the moment. There's now a
> > > proof of concept patch but I'm not certain if it will work. I'll post it
> > > as soon as I can and will provide the link in this thread.
> >
> > The proof of concept patch for v5.10-rc2 is here:
> >
> > https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
> >
> > Hopefully it makes it possible to boot the firmware now. But this is a
> > quick hack and most likely buggy, so keep your expectations low :)
> >
> > In case there are these warnings during firmware initialisation:
> >
> > ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> > ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> >
> > Try reverting this commit:
> >
> > 7fef431be9c9 mm/page_alloc: place pages to tail in __free_pages_core()
> >
> > That's another issue which is debugged here:
> >
> > http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
> >
> > --
> > https://patchwork.kernel.org/project/linux-wireless/list/
> >
> > https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
