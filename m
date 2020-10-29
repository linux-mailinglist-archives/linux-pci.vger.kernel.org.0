Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07E29EF61
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgJ2PMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 11:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbgJ2PMb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Oct 2020 11:12:31 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F7C20704
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603984350;
        bh=lEKTu7tmIyRphoUFdoItAXU9H+bU93RmSlHwSSGKAg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e8HJCzxhpLDvo1fX+lmYBhEOGLueGqJBsDeZEkykV02bPipaIKB1mlox5Szq74wE/
         0Rk+nzvhOB23WY59XhIrLs4Gu7wQzDvBiNWYZNi2MExXk9fbTl2MvsorrZ1M7Ic/0n
         Ske/GgDtEVso9Hw/sq3Lx/CZrwZyK3/WBBAdKL1A=
Received: by mail-oi1-f177.google.com with SMTP id 9so3516454oir.5
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 08:12:30 -0700 (PDT)
X-Gm-Message-State: AOAM531BVdH4l3PGUzE/0rSVc08/jgclewUS8GP4LCp2l4VV/aZD45j9
        wUL9XHtpOmS92FBN+crBccBJHCMKiHjgFGq0ug==
X-Google-Smtp-Source: ABdhPJxYHjV7pdnHuE83pId0udvukzjP63T3OfBqTOMLe4ThAZeGinLeDNJ2zAE3ClLXNziYJxetO1apNg4U12yExXk=
X-Received: by 2002:aca:ccc7:: with SMTP id c190mr95502oig.152.1603984349622;
 Thu, 29 Oct 2020 08:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201028144209.GA315566@bjorn-Precision-5520> <87pn52mlqk.fsf@toke.dk>
In-Reply-To: <87pn52mlqk.fsf@toke.dk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Oct 2020 10:12:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL0YZ+u6NXtTuZZJ=m0LqA4eWTCmMSsT5bVU9ZuL7wcBQ@mail.gmail.com>
Message-ID: <CAL_JsqL0YZ+u6NXtTuZZJ=m0LqA4eWTCmMSsT5bVU9ZuL7wcBQ@mail.gmail.com>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        vtolkm@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 10:08 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Bjorn Helgaas <helgaas@kernel.org> writes:
>
> > On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=B8rgen=
sen wrote:
> >> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
> >>
> >> > Bjorn Helgaas <helgaas@kernel.org> writes:
> >> >
> >> >> [+cc vtolkm]
> >> >>
> >> >> On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
> >> >>> Hi everyone
> >> >>>
> >> >>> I'm trying to get a mainline kernel to run on my Turris Omnia, and=
 am
> >> >>> having some trouble getting the PCI bus to work correctly. Specifi=
cally,
> >> >>> I'm running a 5.10-rc1 kernel (torvalds/master as of this moment),=
 with
> >> >>> the resource request fix[0] applied on top.
> >> >>>
> >> >>> The kernel boots fine, and the patch in [0] makes the PCI devices =
show
> >> >>> up. But I'm still getting initialisation errors like these:
> >> >>>
> >> >>> [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0xe0000004=
 !=3D 0xffffffff)
> >> >>> [    1.632714] pci 0000:01:00.0: BAR 0: error updating (high 0x000=
000 !=3D 0xffffffff)
> >> >>> [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0xe0200004=
 !=3D 0xffffffff)
> >> >>> [    1.632750] pci 0000:02:00.0: BAR 0: error updating (high 0x000=
000 !=3D 0xffffffff)
> >> >>>
> >> >>> and the WiFi drivers fail to initialise with what appears to me to=
 be
> >> >>> errors related to the bus rather than to the drivers themselves:
> >> >>>
> >> >>> [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not supported =
by this driver
> >> >>> [    3.517049] ath: phy0: Unable to initialize hardware; initializ=
ation status: -95
> >> >>> [    3.524473] ath9k 0000:01:00.0: Failed to initialize device
> >> >>> [    3.530081] ath9k: probe of 0000:01:00.0 failed with error -95
> >> >>> [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: failed w=
ith rc=3D134
> >> >>> [    3.543049] pci 0000:00:02.0: enabling device (0140 -> 0142)
> >> >>> [    3.548735] ath10k_pci 0000:02:00.0: can't change power state f=
rom D3hot to D0 (config space inaccessible)
> >> >>> [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up device :=
 -110
> >> >>> [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed with error=
 -110
> >> >>>
> >> >>> lspci looks OK, though:
> >> >>>
> >> >>> # lspci
> >> >>> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev=
 04)
> >> >>> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev=
 04)
> >> >>> 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6820 (rev=
 04)
> >> >>> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Netwo=
rk Adapter (PCI-Express) (rev 01)
> >> >>> 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac=
 Wireless Network Adapter (rev ff)
> >> >>>
> >> >>> Does anyone have any clue what could be going on here? Is this a b=
ug, or
> >> >>> did I miss something in my config or other initialisation? I've tr=
ied
> >> >>> with both the stock u-boot distributed with the board, and with an
> >> >>> upstream u-boot from latest master; doesn't seem to make any diffe=
rent.
> >> >>
> >> >> Can you try turning off CONFIG_PCIEASPM?  We had a similar recent
> >> >> report at https://bugzilla.kernel.org/show_bug.cgi?id=3D209833 but =
I
> >> >> don't think we have a fix yet.
> >> >
> >> > Yes! Turning that off does indeed help! Thanks a bunch :)
> >> >
> >> > You mention that bisecting this would be helpful - I can try that
> >> > tomorrow; any idea when this was last working?
> >>
> >> OK, so I tried to bisect this, but, erm, I couldn't find a working
> >> revision to start from? I went all the way back to 4.10 (which is the
> >> first version to include the device tree file for the Omnia), and even
> >> on that, the wireless cards were failing to initialise with ASPM
> >> enabled...
> >
> > I have no personal experience with this device; all I know is that the
> > bugzilla suggests that it worked in v5.4, which isn't much help.
> >
> > Possibly the apparent regression was really a .config change, i.e.,
> > CONFIG_PCIEASPM was disabled in the v5.4 kernel vtolkm@ tested and it
> > "worked" but got enabled later and it started failing?
>
> Yeah, I suspect so. The OpenWrt config disables CONFIG_PCIEASPM by
> default and only turns it on for specific targets. So I guess that it's
> most likely that this has never worked...

FYI, there's a bugzilla for this:

https://bugzilla.kernel.org/show_bug.cgi?id=3D209833

Rob
