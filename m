Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AEC40F0EB
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 06:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbhIQEMb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 00:12:31 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41064
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244502AbhIQEKn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 00:10:43 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14ED840260
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 04:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631851761;
        bh=2kNbCKPeMI5ps1oSfYt0rhq/83SKx4ifSFqd7Ngd/x8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=utUK6/oGCsIW/2fgDo7WEOqY+AR7tEsEZ802jPkfu7biiJRMGQOgIJJxDZ7NK/Ol5
         1wgGbYLB79wrTp8G0dph1lahy1jkhyQxt6fgsw7Ty1F1lELT0R/d27MLegrXYTZu7+
         Il3RHcCCjBeLVvFqPaLFbb4RCrGdmq7GJ8z3LQO/WN3EWYxV53dzkLuzfCaaSHvWdN
         f4EmtfwjVC5Mv1vUJdHZPQpdwzpOGjTRFkqPjot8PVChBTDrB31E9gCj8uhtirVzEf
         3DhizISlgBtM82ZdFglGLi2+GaCzYg4O69fPXVY12FN+lnYeTNdj0VEDZffKtJLmkR
         nSVvC68i9NMdQ==
Received: by mail-ot1-f72.google.com with SMTP id c21-20020a0568301af500b0051af51e2a5bso38586810otd.10
        for <linux-pci@vger.kernel.org>; Thu, 16 Sep 2021 21:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kNbCKPeMI5ps1oSfYt0rhq/83SKx4ifSFqd7Ngd/x8=;
        b=yHrohbxyquPBlXnsHcv1ovU+FRW+6McfWvLZ/vz8UdqCtqlXbQFMK3zRUivcj6u7Ez
         RTfonpsVePE7UF/y0HJ70fDY0hbS7Ty9jN86aksa/8k5AGBCYWTaOxdZPxG3RBoMIiip
         JFs2fEZ/j83m7l+X/B5Q5xIUI7hI+p/Zn8gafzU9LQAipXVJ9RA1p1Z6osriCysn9OhG
         5t1Pv1Bv/wK4+l48fc6gDfnar5KYph8RYg58m/rgTsx1bJMvfVYS9FX+pirzCY5jLAzT
         7ruXufzY4n3PRD+CL6IhYfmQYTP0jH+iXFpmDljdUO+ZscxFoNSAAseAORdo1gqFekBZ
         Y4Jw==
X-Gm-Message-State: AOAM5316PflaFQkDobAU/wv6zFbRwfW2xymMr2Cg33nG8hgK0dp/rZt+
        Znh+WNZUt46mtVHlgwYnwLXwyc3M0BNPTfaf5ugyNrsk/RjxnqkYsryK/0uIzFYraXX4VWgd6t6
        bgKcpDNYqtyj1ybJMtAzlFgZVnYS/F//vkjdA4GUFmlWb5y/fAQkPNA==
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr7577226otq.11.1631851759598;
        Thu, 16 Sep 2021 21:09:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMF308vBhb8hL4uK4kU9xdvxAyxq4JZckv5A+wbG2eFi1WlX0r+u8n875Mh+huTOVd1HQxckgRdKQLPj1/D5A=
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr7577204otq.11.1631851759263;
 Thu, 16 Sep 2021 21:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154417.664323-3-kai.heng.feng@canonical.com> <20210916170740.GA1624437@bjorn-Precision-5520>
In-Reply-To: <20210916170740.GA1624437@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 17 Sep 2021 12:09:08 +0800
Message-ID: <CAAd53p445rDeL1VFRYFA3QEbKZ6JtjzhCb9fxpR3eZ9E9NAETA@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v5 2/3] r8169: Use PCIe ASPM status for NIC
 ASPM enablement
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        nic_swsd <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 17, 2021 at 1:07 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 11:44:16PM +0800, Kai-Heng Feng wrote:
> > Because ASPM control may not be granted by BIOS while ASPM is enabled,
> > and ASPM can be enabled via sysfs, so use pcie_aspm_enabled() directly
> > to check current ASPM enable status.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v5:
> >  - New patch.
> >
> >  drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> > index 0199914440abc..6f1a9bec40c05 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -622,7 +622,6 @@ struct rtl8169_private {
> >       } wk;
> >
> >       unsigned supports_gmii:1;
> > -     unsigned aspm_manageable:1;
> >       dma_addr_t counters_phys_addr;
> >       struct rtl8169_counters *counters;
> >       struct rtl8169_tc_offsets tc_offset;
> > @@ -2664,8 +2663,13 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
> >
> >  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
> >  {
> > -     /* Don't enable ASPM in the chip if OS can't control ASPM */
> > -     if (enable && tp->aspm_manageable) {
> > +     struct pci_dev *pdev = tp->pci_dev;
> > +
> > +     /* Don't enable ASPM in the chip if PCIe ASPM isn't enabled */
> > +     if (!pcie_aspm_enabled(pdev) && enable)
> > +             return;
>
> What happens when the user enables or disables ASPM via sysfs (see
> https://git.kernel.org/linus/72ea91afbfb0)?
>
> The driver is not going to know about that change.

So it's still better to fold this patch into next one? So the periodic
delayed_work can toggle ASPM accordingly.

Kai-Heng

>
> > +     if (enable) {
> >               RTL_W8(tp, Config5, RTL_R8(tp, Config5) | ASPM_en);
> >               RTL_W8(tp, Config2, RTL_R8(tp, Config2) | ClkReqEn);
> >       } else {
> > @@ -5272,8 +5276,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> >       /* Disable ASPM L1 as that cause random device stop working
> >        * problems as well as full system hangs for some PCIe devices users.
> >        */
> > -     rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
> > -     tp->aspm_manageable = !rc;
> > +     pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
> >
> >       /* enable device (incl. PCI PM wakeup and hotplug setup) */
> >       rc = pcim_enable_device(pdev);
> > --
> > 2.32.0
> >
