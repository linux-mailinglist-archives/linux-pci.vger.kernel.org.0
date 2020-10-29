Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1529EA35
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 12:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgJ2LMa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 07:12:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57702 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbgJ2LM3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 07:12:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603969947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8nF3boRYdqx4i33vgKIM7xiE/BjVsUI6nPsNJGDbavg=;
        b=cLIWuoceRx4XVa8IBRIyZg60HbbWkGbufdZVdwIK5C2fsk6p5VOnMGCPEcZ8mec/zylNNg
        Gf3i748CGFVVBO+0nUKFJ1Tod3hIypAvsdE88ni9E+KsGNFRxOo43b4tFNgRH2qdtFPUyC
        ZgDioqi05/o97rYoWcd0mvsC8vgmLY8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-IyuARCG0MX6Yi1PBGWslYg-1; Thu, 29 Oct 2020 07:12:26 -0400
X-MC-Unique: IyuARCG0MX6Yi1PBGWslYg-1
Received: by mail-il1-f200.google.com with SMTP id r12so1649255iln.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 04:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8nF3boRYdqx4i33vgKIM7xiE/BjVsUI6nPsNJGDbavg=;
        b=kRJ0hCPvgCQfNyZPera44xMB59d96H+wjiSr/0VcBm7J0DA9/hOuACyNGY2kOd/7O6
         GTiB4yBWR+EP5dufkw0Bt7NLZ88CVn68+x0Ta61mFLR01/ZRhd312zxdW7XBK8VzS5De
         fnf6lhgazGgoBRdTgCXLlT1EAlYAc3Lu2IuAj7621wbkwVJrhJbzK3kIKlZ6kHB2ZSsQ
         iS9/2C4e2F50E6NjMLSeskiMEAHcSHEOryOipQbfhVXd/GMGqysM39klM3HKmsWC49yF
         T5a6F2WOOM0GvknvJTxT8tINwAIZTFCsBtJfxvm6EH1zLngA+6oXNL7RI6Lo3jNF6EfS
         Cyqw==
X-Gm-Message-State: AOAM533jtmNWe9fr65x2jFg0Cjhm7UeEAwlxtwvwcRDMOe+3Ky8nzdLc
        EJLEEoRss/pxVTK7ACCD3ynZeuJ1kH7NBqaw6VBb7fFeO3cqhmHA2yhdKx5r0ePq8zW0VNpR28O
        rhLQLBisRgFG4oOIuKjhl
X-Received: by 2002:a92:130b:: with SMTP id 11mr2496429ilt.15.1603969945628;
        Thu, 29 Oct 2020 04:12:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxysUDGeE+ye/llio8+aICM4VbeF73k3GfPl5P1xsFX1Oa9kchLem/dTr1TsrizmHrGG44TnA==
X-Received: by 2002:a92:130b:: with SMTP id 11mr2496411ilt.15.1603969945411;
        Thu, 29 Oct 2020 04:12:25 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id l29sm2233153ili.29.2020.10.29.04.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 04:12:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8E78E181CED; Thu, 29 Oct 2020 12:12:21 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     vtolkm@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: PCI trouble on mvebu (Turris Omnia)
In-Reply-To: <20201029100914.2e5x7lkbvks2gu4a@pali>
References: <2fb69e2a-4423-2b04-cd0f-ca819092bc5f@gmail.com>
 <20201028231626.GA344207@bjorn-Precision-5520>
 <20201029100914.2e5x7lkbvks2gu4a@pali>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 29 Oct 2020 12:12:21 +0100
Message-ID: <871rhhmgkq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Hello!
>
> On Wednesday 28 October 2020 18:16:26 Bjorn Helgaas wrote:
>> [+cc Pali, Marek, Thomas, Jason]
>>=20
>> On Wed, Oct 28, 2020 at 04:40:00PM +0000, =E2=84=A2=D6=9F=E2=98=BB=D2=87=
=CC=AD =D1=BC =D2=89 =C2=AE wrote:
>> > On 28/10/2020 16:08, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > > Bjorn Helgaas <helgaas@kernel.org> writes:
>> > > > On Wed, Oct 28, 2020 at 02:36:13PM +0100, Toke H=C3=B8iland-J=C3=
=B8rgensen wrote:
>> > > > > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>> > > > > > Bjorn Helgaas <helgaas@kernel.org> writes:
>> > > > > >=20
>> > > > > > > [+cc vtolkm]
>> > > > > > >=20
>> > > > > > > On Tue, Oct 27, 2020 at 04:43:20PM +0100, Toke H=C3=B8iland-=
J=C3=B8rgensen wrote:
>> > > > > > > > Hi everyone
>> > > > > > > >=20
>> > > > > > > > I'm trying to get a mainline kernel to run on my Turris Om=
nia, and am
>> > > > > > > > having some trouble getting the PCI bus to work correctly.=
 Specifically,
>> > > > > > > > I'm running a 5.10-rc1 kernel (torvalds/master as of this =
moment), with
>> > > > > > > > the resource request fix[0] applied on top.
>> > > > > > > >=20
>> > > > > > > > The kernel boots fine, and the patch in [0] makes the PCI =
devices show
>> > > > > > > > up. But I'm still getting initialisation errors like these:
>> > > > > > > >=20
>> > > > > > > > [    1.632709] pci 0000:01:00.0: BAR 0: error updating (0x=
e0000004 !=3D 0xffffffff)
>> > > > > > > > [    1.632714] pci 0000:01:00.0: BAR 0: error updating (hi=
gh 0x000000 !=3D 0xffffffff)
>> > > > > > > > [    1.632745] pci 0000:02:00.0: BAR 0: error updating (0x=
e0200004 !=3D 0xffffffff)
>> > > > > > > > [    1.632750] pci 0000:02:00.0: BAR 0: error updating (hi=
gh 0x000000 !=3D 0xffffffff)
>> > > > > > > >=20
>> > > > > > > > and the WiFi drivers fail to initialise with what appears =
to me to be
>> > > > > > > > errors related to the bus rather than to the drivers thems=
elves:
>> > > > > > > >=20
>> > > > > > > > [    3.509878] ath: phy0: Mac Chip Rev 0xfffc0.f is not su=
pported by this driver
>> > > > > > > > [    3.517049] ath: phy0: Unable to initialize hardware; i=
nitialization status: -95
>> > > > > > > > [    3.524473] ath9k 0000:01:00.0: Failed to initialize de=
vice
>> > > > > > > > [    3.530081] ath9k: probe of 0000:01:00.0 failed with er=
ror -95
>> > > > > > > > [    3.536012] ath10k_pci 0000:02:00.0: of_irq_parse_pci: =
failed with rc=3D134
>> > > > > > > > [    3.543049] pci 0000:00:02.0: enabling device (0140 -> =
0142)
>> > > > > > > > [    3.548735] ath10k_pci 0000:02:00.0: can't change power=
 state from D3hot to D0 (config space inaccessible)
>> > > > > > > > [    3.588592] ath10k_pci 0000:02:00.0: failed to wake up =
device : -110
>> > > > > > > > [    3.595098] ath10k_pci: probe of 0000:02:00.0 failed wi=
th error -110
>> > > > > > > >=20
>> > > > > > > > lspci looks OK, though:
>> > > > > > > >=20
>> > > > > > > > # lspci
>> > > > > > > > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6=
820 (rev 04)
>> > > > > > > > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6=
820 (rev 04)
>> > > > > > > > 00:03.0 PCI bridge: Marvell Technology Group Ltd. Device 6=
820 (rev 04)
>> > > > > > > > 01:00.0 Network controller: Qualcomm Atheros AR9287 Wirele=
ss Network Adapter (PCI-Express) (rev 01)
>> > > > > > > > 02:00.0 Network controller: Qualcomm Atheros QCA986x/988x =
802.11ac Wireless Network Adapter (rev ff)
>> > > > > > > >=20
>> > > > > > > > Does anyone have any clue what could be going on here? Is =
this a bug, or
>> > > > > > > > did I miss something in my config or other initialisation?=
 I've tried
>> > > > > > > > with both the stock u-boot distributed with the board, and=
 with an
>> > > > > > > > upstream u-boot from latest master; doesn't seem to make a=
ny different.
>> > > > > > > Can you try turning off CONFIG_PCIEASPM?  We had a similar r=
ecent
>> > > > > > > report at https://bugzilla.kernel.org/show_bug.cgi?id=3D2098=
33 but I
>> > > > > > > don't think we have a fix yet.
>> > > > > > Yes! Turning that off does indeed help! Thanks a bunch :)
>
> I have been testing mainline kernel on Turris Omnia with two PCIe
> default cards (WLE200 and WLE900) and it worked fine. But I do not know
> if I had ASPM enabled or not.
>
> So it is working fine for you when CONFIG_PCIEASPM is disabled and whole
> issue is only when CONFIG_PCIEASPM is enabled?

Yup, exactly. And I'm also currently testing with the default WLE200/900
cards... I just tried sticking an MT76-based WiFi card into the third
PCI slot, and that doesn't come up either when I enable PCIEASPM.

-Toke

