Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1C46576D
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbhLAUyi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 15:54:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58811 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353181AbhLAUyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 15:54:13 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MqJyX-1mDx0r3N5v-00nQBL; Wed, 01 Dec 2021 21:50:50 +0100
Received: by mail-wr1-f45.google.com with SMTP id j3so55077007wrp.1;
        Wed, 01 Dec 2021 12:50:50 -0800 (PST)
X-Gm-Message-State: AOAM531V/fVa8/1nkSatwozvcTdofCkRVRUD585XjA1jI4mb9LQawBj/
        UiebZzinoxNFKqqaCZqodAdMQfPeZqz4hTFgVrk=
X-Google-Smtp-Source: ABdhPJy3odhEkjPswm8W3FP+Lv8hzUHatDu8HWlNNQ5COgwGd0PgGAudbvzHJNrhdkYewPzVy1QacKwcJDH93MqqvzA=
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr9552455wri.137.1638391850399;
 Wed, 01 Dec 2021 12:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20211119232017.GA1981034@bhelgaas> <20211201202433.GA2837547@bhelgaas>
In-Reply-To: <20211201202433.GA2837547@bhelgaas>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Dec 2021 21:50:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2bb3w+6G4W0OAv1ASmfeOr0NTHMPpJ2An-ms2Vk7VnhQ@mail.gmail.com>
Message-ID: <CAK8P3a2bb3w+6G4W0OAv1ASmfeOr0NTHMPpJ2An-ms2Vk7VnhQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to 'bridge->windows'
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Tukz/1HhzPO7mRE/8y4rnl2v5Bts7hpYkSys506DXl0FxQK1kGl
 bnFMIy36D31ArSmLPrkyCq9wcUMu2kaABrF+BAQxsrmbmMrdoZQk7ZXDhDAyO6XilrZ5Eoz
 DMPMxQozUEFg4gVonqqCrlxAtOLE0Gx2QACyX1kpL/HthY1de2SdHAzavRtrrf88krJjmm8
 YR6k6tfGuctsfpmiYbtSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1NQTz62PwxE=:3uWKsgT3bi2/vSfJRH9qg+
 eCE45pX9jpvlWqOrbWVDxkFM7II8Vve2v2BEezD0MgfGWEGleC2fKTF++y8zDpkkWmA67PFg2
 ANhSxlm+zIAk+3zMLkUmGT3ZH7+nQu9IUHP9/VfRA1VR/EVfd3rFY3mohdWaaYVeMX34JO8/x
 x5w1TppSvuSY+K1PjQJymh2ruHccl8WGm+Rum8/oSgN3gaysydgq7hVw3VP8gqkTGdRnztHoQ
 BTHgwhu1WXfaGD6DcE9wY7wR3arhfVPRtqMauO0uDUoub4LF35a9nZi+fvafkN47ACdv3a+XF
 ig+S59SsqJE4dr7OaOSKw4FkL+SWRIt6cD9XkzwUbpoDNRcvMbdpZZ/8Muj+KglgkJfG5oWbV
 ud/y7RGTmnoHLph7y/DZ1yFCHfK6P1t+h+13QrTQxP59I1OyN3zGvfHry8TmiwVsuyc7eF+28
 J4GtOMOHyN7F2zFm6+wJLVEqhhWYUlJXASlNb5mmF+aYMeGz+kcww7FhAof4/QHum79wtzV8Q
 8/yydwQE1emF+CA4p5C8ALSXHiX4Cvu9FTI1V4G6gtcHV1Md+HFtCpHlNaEFZrQwyZkp8d455
 /SByYDTXq9J5T8ZkzYTvd0HQC0TVsgR2lEsStPIUbkbM7dhjfloyT6Gomd5i36sDJZ1cxrlIR
 xGD9GEpTE/VerseKEzJXQyfQ/xLfyzZWRuSfxb4v12ezoo1P3ZRQF2McP75U18JpfOHg=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 1, 2021 at 9:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Fri, Nov 19, 2021 at 05:20:17PM -0600, Bjorn Helgaas wrote:
> >
> > Arnd added this with 37d6a0a6f470 ("PCI: Add
> > pci_register_host_bridge() interface") [1].
> >
> > I can't remember why this was done, but we did go to some trouble to
> > move things around, so there must have been a good reason.
> >
> > Arnd or Thierry, do you remember?
>
> Nobody seems to remember, so I think we should go ahead and make this
> change after the usual due diligence (audit the code between the old
> site and the new site to look for any uses of bridge->windows).
>
> I think this would be material for v5.17.

Sorry I forgot to reply to your earlier mail. I think this is fine, as far as I
remember, the only reason the bridge windows are moved from the list
and added back one at a time was to preserve the exact orderorks.

We could probably even skip that step entirely and iterate throughing
that was there originally, to keep the behavior after a series of reworks.

We could probably even skip that step entirely and iterate through
bridge->windows instead of the local list to simplify this.

For Sergio's patch:

Acked-by: Arnd Bergmann <arnd@arndb.de>
