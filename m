Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC733F9458
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 08:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244310AbhH0GYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 02:24:09 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41294
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244304AbhH0GYI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 02:24:08 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8E0173F323
        for <linux-pci@vger.kernel.org>; Fri, 27 Aug 2021 06:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630045399;
        bh=ohSVakcde5SU9A5Azhvp1T8TDHvhvAjJTMuWk8UJlQA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kjcS/05w3jqjmeCMVj/qv5Cv29NjGhhwEYQ0knwiu/Q5HR2w/jHJUEeOzFLL+2nTm
         WsKcRLdqbWhEF/l3Q/qQEohkqxdQfDnb/zZN0Kh/u00x4NfTAbuFPv61vZA1ZLGbdW
         izlUfuL6xJPKaVWVN+QHdmFriPINKYJuuMcYITpHzszLJ/qNMmPSC2J4Tjsyg62uiZ
         Ga/EViqMMC/Vpcci/eyHOxaQSV/czxuEJ65yOr7MzbeE5UgNP62z1jxSVRXf9yjN7B
         kKjzkjgS+F+3vks/SFbERVgui2NyDJ0TiRYUY6hxDdNBBUSOtXu92km7q+myPviljv
         cdSB9x+3Ps8Tw==
Received: by mail-ej1-f70.google.com with SMTP id gw26-20020a170906f15a00b005c48318c60eso2206326ejb.7
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 23:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohSVakcde5SU9A5Azhvp1T8TDHvhvAjJTMuWk8UJlQA=;
        b=XLgBQlivYulrrOTmE2e6V197PI/sq4LnSENvjRAQnOy3dUBttG5h5KxjDA3Xkn2RBT
         /BstAj+8Jd/CDeZK6z2UBYnd6xsvM0mDlSwW3YJayfOaR6GilDk0IpLN7G85O+BbqQ3f
         w2x2MfpMQ6lyOGIOHfXvBoIaOhN5DCTVyL3qtG7bJa2wveQmlqwdeJlDYMtrJrPhr8kJ
         RioMYHEauCrSLVAN+WOd0AOQvVfhRzRRPSefg0kLNgO+0YxgEpqvQjaFGM+nGBNmQm3s
         93I/wGxrISA0DtG6rkBnt3b3Xnd9fD+hMcWv5VaswjUnrVbKAFNylciwCxR1GjaiYPqL
         7T7g==
X-Gm-Message-State: AOAM5309dpIdvEoZjET/k5K1bJts16NdG7qVgK60MXULtvnR2vFKL/EW
        Nt7Tzrc0b+coh5RyKfECS/qQcp/USOAbPjOUM9TWQjcd04sPhhFBxS7+Q2vQI6B/Y+nX3WuEVED
        bfEzjdoJFpK4Ev8pduIvJ5DkTrUID525ahWdO2rym1E2yFD0+aC5U1Q==
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr8486704ejc.432.1630045399169;
        Thu, 26 Aug 2021 23:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPW07mr7W5GhSow8wp/eSxl6XrHTu2nLBhPVJIML5dI1P2dUXQb8SwvbkQfC3LuSgHoRa+f3dhNXTcnF2j5Eo=
X-Received: by 2002:a17:907:2d8b:: with SMTP id gt11mr8486677ejc.432.1630045398810;
 Thu, 26 Aug 2021 23:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054542.608745-1-kai.heng.feng@canonical.com>
 <20210819054542.608745-4-kai.heng.feng@canonical.com> <084b8ea3-99d8-3393-4b74-0779c92fde64@gmail.com>
 <CAAd53p4CYOOXjyNdTnBtsQ+2MW-Jar8fgEfPFZHSPrJde=HqVA@mail.gmail.com> <d3e4ec0b-2681-1b3c-f0ca-828b24b253e7@gmail.com>
In-Reply-To: <d3e4ec0b-2681-1b3c-f0ca-828b24b253e7@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 27 Aug 2021 14:23:07 +0800
Message-ID: <CAAd53p7JLemocM+rA-EyiuX=asYg5__J07+F9W7YZpUgWVMrPg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] r8169: Enable ASPM for selected NICs
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 5:56 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 19.08.2021 08:50, Kai-Heng Feng wrote:
> > On Thu, Aug 19, 2021 at 2:08 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 19.08.2021 07:45, Kai-Heng Feng wrote:
> >>> The latest vendor driver enables ASPM for more recent r8168 NICs, so
> >>> disable ASPM on older chips and enable ASPM for the rest.
> >>>
> >>> Rename aspm_manageable to pcie_aspm_manageable to indicate it's ASPM
> >>> from PCIe, and use rtl_aspm_supported for Realtek NIC's internal ASPM
> >>> function.
> >>>
> >>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >>> ---
> >>> v3:
> >>>  - Use pcie_aspm_supported() to retrieve ASPM support status
> >>>  - Use whitelist for r8169 internal ASPM status
> >>>
> >>> v2:
> >>>  - No change
> >>>
> >>>  drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++-------
> >>>  1 file changed, 19 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> >>> index 3359509c1c351..88e015d93e490 100644
> >>> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >>> @@ -623,7 +623,8 @@ struct rtl8169_private {
> >>>       } wk;
> >>>
> >>>       unsigned supports_gmii:1;
> >>> -     unsigned aspm_manageable:1;
> >>> +     unsigned pcie_aspm_manageable:1;
> >>> +     unsigned rtl_aspm_supported:1;
> >>>       unsigned rtl_aspm_enabled:1;
> >>>       struct delayed_work aspm_toggle;
> >>>       atomic_t aspm_packet_count;
> >>> @@ -702,6 +703,20 @@ static bool rtl_is_8168evl_up(struct rtl8169_private *tp)
> >>>              tp->mac_version <= RTL_GIGA_MAC_VER_53;
> >>>  }
> >>>
> >>> +static int rtl_supports_aspm(struct rtl8169_private *tp)
> >>> +{
> >>> +     switch (tp->mac_version) {
> >>> +     case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_31:
> >>> +     case RTL_GIGA_MAC_VER_37:
> >>> +     case RTL_GIGA_MAC_VER_39:
> >>> +     case RTL_GIGA_MAC_VER_43:
> >>> +     case RTL_GIGA_MAC_VER_47:
> >>> +             return 0;
> >>> +     default:
> >>> +             return 1;
> >>> +     }
> >>> +}
> >>> +
> >>>  static bool rtl_supports_eee(struct rtl8169_private *tp)
> >>>  {
> >>>       return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
> >>> @@ -2669,7 +2684,7 @@ static void rtl_pcie_state_l2l3_disable(struct rtl8169_private *tp)
> >>>
> >>>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> >>>  {
> >>> -     if (!tp->aspm_manageable && enable)
> >>> +     if (!(tp->pcie_aspm_manageable && tp->rtl_aspm_supported) && enable)
> >>>               return;
> >>>
> >>>       tp->rtl_aspm_enabled = enable;
> >>> @@ -5319,12 +5334,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >>>       if (rc)
> >>>               return rc;
> >>>
> >>> -     /* Disable ASPM completely as that cause random device stop working
> >>> -      * problems as well as full system hangs for some PCIe devices users.
> >>> -      */
> >>> -     rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
> >>> -                                       PCIE_LINK_STATE_L1);
> >>> -     tp->aspm_manageable = !rc;
> >>> +     tp->pcie_aspm_manageable = pcie_aspm_supported(pdev);
> >>
> >> That's not what I meant, and it's also not correct.
> >
> > In case I make another mistake in next series, let me ask it more clearly...
> > What you meant was to check both link->aspm_enabled and link->aspm_support?
> >
> aspm_enabled can be changed by the user at any time.

OK, will check that too.

> pci_disable_link_state() also considers whether BIOS forbids that OS
> mess with ASPM. See aspm_disabled.

I think aspm_disabled means leave BIOS ASPM setting intact?
So If PCIe ASPM is already enabled, we should also enable Realtek
specific bits to make ASPM really work.

>
> >>
> >>> +     tp->rtl_aspm_supported = rtl_supports_aspm(tp);
> >
> > Is rtl_supports_aspm() what you expect for the whitelist?
> > And what else am I missing?
> >
> I meant use rtl_supports_aspm() to check when ASPM is relevant at all,

I think that means the relevant bits are link->aspm_capable and
pcie_aspm_support_enabled().
ASPM can be already enabled by BIOS with aspm_disabled set.

Then check link->aspm_enabled in aspm_toggle() routine because it can
be enabled at runtime.

> and in addition use a blacklist for chip versions where ASPM is
> completely unusable.

Thanks for your suggestion and review.

Kai-Heng

>
> > Kai-Heng
> >
> >>>
> >>>       /* enable device (incl. PCI PM wakeup and hotplug setup) */
> >>>       rc = pcim_enable_device(pdev);
> >>>
> >>
>
