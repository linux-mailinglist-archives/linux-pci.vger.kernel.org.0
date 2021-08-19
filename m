Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7942F3F13CB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 08:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhHSGvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 02:51:36 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:42910
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231831AbhHSGvf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 02:51:35 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 16CB3411C7
        for <linux-pci@vger.kernel.org>; Thu, 19 Aug 2021 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629355859;
        bh=0jvhx6f4zq/7XnfZg+ORPB90W+qrIJ0dzkFCj+LBYPM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=TTXyVUK1NiJFkvRXZqkciOl1mNHmX3yki2Ep6agB9Jo5O+TEsRwcE62TCDuOBEG8d
         T11zLtrfAxGHuEvpzByY97e+ddP4Iotuyse0yC+/4QOMLSLsHelBPwogiaxiV2ALA9
         PR+vqHKvAaydmwBVG2wfwmXYeCjccYOb6ySvACzST29EAnYYlx4E0NgAFV+aUTjrLp
         OaoiOgAP4lYMfUUqrx0FMhMY/7Lv6P9YnuqKap1gYi03dk/Pe9rol6L8uWrbNggAJI
         7b69/dHwMiFwly24tHzVH0sXCfBOM5QNcmeGDEZvjEcklnikYkz/i7z+pNG0oDi55C
         2FIdoDF71xblA==
Received: by mail-ed1-f72.google.com with SMTP id bx23-20020a0564020b5700b003bf2eb11718so2299839edb.20
        for <linux-pci@vger.kernel.org>; Wed, 18 Aug 2021 23:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jvhx6f4zq/7XnfZg+ORPB90W+qrIJ0dzkFCj+LBYPM=;
        b=KM1rj0J6/skZZrtXZkXJi2hqm7Db/UfOnw5/FPRZV+c8+/Z/S3as0hoOwRnYz1+y1X
         UHpjZGKH15xmdb8wHOwrj/ZD5DceTTixflNcXf6pGQ1hBgvAt3dyfwdye3XcHIWa5+hk
         VHb0ATU6fFQWlIrPvdSC17/wtoSzqCUmh5aL2HGxTZ/lz7dsVlIuwMMXuSwcHgd0Tj5H
         seqAw4O7W6pbEHHhU1Dw88jXrqPEEYSlfx/pf62CtWAadh785eQf8/XvGruaxmpGhDUh
         uwAqg0ZlVRwL8TMMNq12ZX8WCXx/EcMIFnVgIex1IJWqwB02wszbkVUXz/LtBLmClIdZ
         hhHQ==
X-Gm-Message-State: AOAM533XJZfJNMmz8q8qSUVy2O4COHLR/ERFfShk9Odb6HRIIln6RCwu
        ljKsk40mRxkecoSseytewu+K8lNrl5vBqdWcROC+yBXTeCIbHZqDhehjjjBXPAgOdCmapnKIHMB
        6WNV81gta8MhVJUrPqBjPyJo3QseIDqJu0j8icgGgQAsP8wdTe+vRxA==
X-Received: by 2002:a17:906:f8c4:: with SMTP id lh4mr14052771ejb.542.1629355857651;
        Wed, 18 Aug 2021 23:50:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7XQhtjEFl5wsBgomaAboB0rmAqmgcek25DRCCx7AdlA7HAMg46JkTr7MA3PiPZ8CWLKTxjQcDb0l3DC8Hxm0=
X-Received: by 2002:a17:906:f8c4:: with SMTP id lh4mr14052749ejb.542.1629355857324;
 Wed, 18 Aug 2021 23:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054542.608745-1-kai.heng.feng@canonical.com>
 <20210819054542.608745-4-kai.heng.feng@canonical.com> <084b8ea3-99d8-3393-4b74-0779c92fde64@gmail.com>
In-Reply-To: <084b8ea3-99d8-3393-4b74-0779c92fde64@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 19 Aug 2021 14:50:44 +0800
Message-ID: <CAAd53p4CYOOXjyNdTnBtsQ+2MW-Jar8fgEfPFZHSPrJde=HqVA@mail.gmail.com>
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

On Thu, Aug 19, 2021 at 2:08 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 19.08.2021 07:45, Kai-Heng Feng wrote:
> > The latest vendor driver enables ASPM for more recent r8168 NICs, so
> > disable ASPM on older chips and enable ASPM for the rest.
> >
> > Rename aspm_manageable to pcie_aspm_manageable to indicate it's ASPM
> > from PCIe, and use rtl_aspm_supported for Realtek NIC's internal ASPM
> > function.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v3:
> >  - Use pcie_aspm_supported() to retrieve ASPM support status
> >  - Use whitelist for r8169 internal ASPM status
> >
> > v2:
> >  - No change
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 3359509c1c351..88e015d93e490 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -623,7 +623,8 @@ struct rtl8169_private {
> >       } wk;
> >
> >       unsigned supports_gmii:1;
> > -     unsigned aspm_manageable:1;
> > +     unsigned pcie_aspm_manageable:1;
> > +     unsigned rtl_aspm_supported:1;
> >       unsigned rtl_aspm_enabled:1;
> >       struct delayed_work aspm_toggle;
> >       atomic_t aspm_packet_count;
> > @@ -702,6 +703,20 @@ static bool rtl_is_8168evl_up(struct rtl8169_private *tp)
> >              tp->mac_version <= RTL_GIGA_MAC_VER_53;
> >  }
> >
> > +static int rtl_supports_aspm(struct rtl8169_private *tp)
> > +{
> > +     switch (tp->mac_version) {
> > +     case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_31:
> > +     case RTL_GIGA_MAC_VER_37:
> > +     case RTL_GIGA_MAC_VER_39:
> > +     case RTL_GIGA_MAC_VER_43:
> > +     case RTL_GIGA_MAC_VER_47:
> > +             return 0;
> > +     default:
> > +             return 1;
> > +     }
> > +}
> > +
> >  static bool rtl_supports_eee(struct rtl8169_private *tp)
> >  {
> >       return tp->mac_version >= RTL_GIGA_MAC_VER_34 &&
> > @@ -2669,7 +2684,7 @@ static void rtl_pcie_state_l2l3_disable(struct rtl8169_private *tp)
> >
> >  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> >  {
> > -     if (!tp->aspm_manageable && enable)
> > +     if (!(tp->pcie_aspm_manageable && tp->rtl_aspm_supported) && enable)
> >               return;
> >
> >       tp->rtl_aspm_enabled = enable;
> > @@ -5319,12 +5334,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >       if (rc)
> >               return rc;
> >
> > -     /* Disable ASPM completely as that cause random device stop working
> > -      * problems as well as full system hangs for some PCIe devices users.
> > -      */
> > -     rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S |
> > -                                       PCIE_LINK_STATE_L1);
> > -     tp->aspm_manageable = !rc;
> > +     tp->pcie_aspm_manageable = pcie_aspm_supported(pdev);
>
> That's not what I meant, and it's also not correct.

In case I make another mistake in next series, let me ask it more clearly...
What you meant was to check both link->aspm_enabled and link->aspm_support?

>
> > +     tp->rtl_aspm_supported = rtl_supports_aspm(tp);

Is rtl_supports_aspm() what you expect for the whitelist?
And what else am I missing?

Kai-Heng

> >
> >       /* enable device (incl. PCI PM wakeup and hotplug setup) */
> >       rc = pcim_enable_device(pdev);
> >
>
