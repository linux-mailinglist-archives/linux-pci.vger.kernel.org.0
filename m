Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860A7483A8F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 03:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiADCX7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jan 2022 21:23:59 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40808
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232193AbiADCX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jan 2022 21:23:59 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29E7D3FFD5
        for <linux-pci@vger.kernel.org>; Tue,  4 Jan 2022 02:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641263033;
        bh=5cazmRarXDvXEd4JyRxvrVTfaRwqdqkKmDWF6lTNaUE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eZ5pKBYTjmfyY/BFgck2Nk/sQafGiMzejHgUYLo04UDZJGLVfGjFKizPzLEQR7nsk
         fN5k0eGnYPeaKOgUng9PAzu0WkPXn/9pa1JpIp6XOA2K4pK9WLqnFLDTz56Vn4z3Ul
         fB3l8BpgAqg9TxfykS5chXaTwgTQnsOFgiSftpuinQABm3xshhAGGbnYo8l25A7Ov/
         SVd5zCItbbb/wjm4607RFlcauTQL8Fr+Kg4B8H81zsTwyKLnW3eQnP3VdQeFr0O0mX
         Q9aWSedJGU+Dhr557WjHSSFles0fipVpFKRMbubZgLk36Xy3MSqVdh4Vp9RlNAqvqm
         c0hWR3inNLhKw==
Received: by mail-oi1-f197.google.com with SMTP id w130-20020aca6288000000b002c6b2ccddaeso23337048oib.12
        for <linux-pci@vger.kernel.org>; Mon, 03 Jan 2022 18:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cazmRarXDvXEd4JyRxvrVTfaRwqdqkKmDWF6lTNaUE=;
        b=26XckDw7EzzUkdWGvjoNFyPhJPggcdvuLG/JKgd7Xuu/ZQ9hEwIVNSonfogM/p93pR
         jVirE4QY7VOtMjYEveB6942qNxEb0gNMC6VF+akHUAxbE0nvw2+RkQqO5xtzDDRNkbqN
         k1d2+MOE6OPlm9enCgaF5WknBrGVlVfw3nD0SGmlO5UCOc3WPilikaVdWiOcslEpJBk/
         VNJZmfN9ISpswQnjrwqPRhud3FkZ7/itUEJ1O++wwuYXxGSYq/oOWnW8F+gpRNZuhGX/
         SMWU6lXTQEBjyVr6rs8PK+4rhBZuQ4gB8IGNbsLnMV73yo8+2gdY2eVusG4FF6x28h6t
         gCRQ==
X-Gm-Message-State: AOAM532Ig/DhUNIIUrvoVH7xXDgAnXunSQpEg6/3RTPiI1wKZt8LhgU8
        pPrIXX2Qjx6Mw61z8lKfTpv8bb+tTQaa7R99Sh6Oyvv51QQVlG8fugal+1aihvmagGo2eBxiEvx
        2zv+iji2+ciFJyo1LZKCePDsJBGfrpLYqx9mWVegY7l8+037vo4x/wg==
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr33904517ota.11.1641263030936;
        Mon, 03 Jan 2022 18:23:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzPidDUDT7zkVJQH32VyKsgWKAjH6fZz3mxUzBG8x2j81B9Qp88ucqAoNaI+qAUs/lvK97Qw+QQyoy3s0UZ3/4=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr33904498ota.11.1641263030633;
 Mon, 03 Jan 2022 18:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20211224081914.345292-2-kai.heng.feng@canonical.com>
 <20211229201814.GA1699315@bhelgaas> <CAAd53p74bHYmQJzKuriDrRWpJwXivfYCfNCsUjC47d1WKUZ=gQ@mail.gmail.com>
 <SJ0PR11MB500869254A4E9DEEC1DF3B5DD7499@SJ0PR11MB5008.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB500869254A4E9DEEC1DF3B5DD7499@SJ0PR11MB5008.namprd11.prod.outlook.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 4 Jan 2022 10:23:38 +0800
Message-ID: <CAAd53p4-Sxx+8bF4ZTA9R7L=bJHv2yTCPSoFHmPpHHPFd1Bx+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: wwan: iosm: Keep device at D0 for s2idle case
To:     "Kumar, M Chetan" <m.chetan.kumar@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linuxwwan <linuxwwan@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 3, 2022 at 11:28 PM Kumar, M Chetan
<m.chetan.kumar@intel.com> wrote:
>
> > -----Original Message-----
> > From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > Sent: Thursday, December 30, 2021 6:31 AM
> > To: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: Kumar, M Chetan <m.chetan.kumar@intel.com>; linuxwwan
> > <linuxwwan@intel.com>; linux-pci@vger.kernel.org; linux-
> > pm@vger.kernel.org; Loic Poulain <loic.poulain@linaro.org>; Sergey
> > Ryazanov <ryazanov.s.a@gmail.com>; Johannes Berg
> > <johannes@sipsolutions.net>; David S. Miller <davem@davemloft.net>;
> > Jakub Kicinski <kuba@kernel.org>; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Rafael J. Wysocki <rjw@rjwysocki.net>; Vaibhav
> > Gupta <vaibhavgupta40@gmail.com>
> > Subject: Re: [PATCH 2/2] net: wwan: iosm: Keep device at D0 for s2idle case
> >
> > On Thu, Dec 30, 2021 at 4:18 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Rafael, Vaibhav]
> > >
> > > On Fri, Dec 24, 2021 at 04:19:14PM +0800, Kai-Heng Feng wrote:
> > > > We are seeing spurious wakeup caused by Intel 7560 WWAN on AMD
> > laptops.
> > > > This prevent those laptops to stay in s2idle state.
> > > >
> > > > From what I can understand, the intention of ipc_pcie_suspend() is
> > > > to put the device to D3cold, and ipc_pcie_suspend_s2idle() is to
> > > > keep the device at D0. However, the device can still be put to
> > > > D3hot/D3cold by PCI core.
> > > >
> > > > So explicitly let PCI core know this device should stay at D0, to
> > > > solve the spurious wakeup.
>
> Did you get a chance to check the cause of spurious wakeup ? Was there any
> information device is trying to send while platform is entering suspend/
> host sw missed to unsubscribe certain notifications which resulted in wake event.

Can you please let me know how to check it?

>
> In our internal test (x86 platform) we had not noticed such spurious wakeup but would
> like to cross check by running few more tests.

Sure, let me know what tests you want me to run.

>
> > > >
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >  drivers/net/wwan/iosm/iosm_ipc_pcie.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > > > b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > > > index d73894e2a84ed..af1d0e837fe99 100644
> > > > --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > > > +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> > > > @@ -340,6 +340,9 @@ static int __maybe_unused
> > > > ipc_pcie_suspend_s2idle(struct iosm_pcie *ipc_pcie)
> > > >
> > > >       ipc_imem_pm_s2idle_sleep(ipc_pcie->imem, true);
> > > >
> > > > +     /* Let PCI core know this device should stay at D0 */
> > > > +     pci_save_state(ipc_pcie->pci);
> > >
> > > This is a weird and non-obvious way to say "this device should stay at
> > > D0".  It's also fairly expensive since pci_save_state() does a lot of
> > > slow PCI config reads.
> >
> > Yes, so I was waiting for feedback from IOSM devs what's the expected PCI
> > state for the s2idle case.
>
> D3 is the expected state.

Is it D3hot or D3cold?

Kai-Heng

>
> > Dave, can you drop it from netdev until IOSM devs confirm this patch is
> > correct?
>
> Dave, please drop this patch from netdev.
