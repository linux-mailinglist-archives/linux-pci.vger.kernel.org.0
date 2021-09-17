Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C417B40F0FD
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 06:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244391AbhIQEUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 00:20:38 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46450
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244382AbhIQEUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 00:20:35 -0400
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5154640261
        for <linux-pci@vger.kernel.org>; Fri, 17 Sep 2021 04:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631852353;
        bh=UUDjDxYA0DPw3fgzrTN4mBMpElX++DxNM0RaIoCame4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r+TqK7uwYaGHWjMo5nS/iJ0CQM+mrf69lLEwsqKzwJ8K8jqkz9Kvyi2pOPXuAHHvs
         FetcamnYvscSupxsAWFauGl/KiUEw/VqLtwQ4BmwfYAKha/owv0Kdgdqaepcm8i3zU
         Y2zP8UeHM46ICw/pLRZMGfpRODh+TqUJ/aC31p3i8KaiAXSjRIJA8jPwAwB7TDMEIL
         sWKOXMtKPmG4K0tpcppBbAD+w3+7AG1Kq/rDJyzbcDHghGBISMItq6Tc3cfNutjJCO
         ytWafQCjKRTmApPEpIo/fR3jJGdVSsQ7Bo3w30O4nisR9H2sJrnb10WHJilHm61GXg
         a0+nGeWT+0XnQ==
Received: by mail-oi1-f199.google.com with SMTP id r25-20020a056808211900b00268b48af6baso33354398oiw.23
        for <linux-pci@vger.kernel.org>; Thu, 16 Sep 2021 21:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUDjDxYA0DPw3fgzrTN4mBMpElX++DxNM0RaIoCame4=;
        b=cweFNJ7IbbiQbl0Jqu9OY3vsqtp6xFNx/9IIrqv+T9ffAZUMItfyjN8nisiE5aViKa
         u0FI9VYvVk/8kugRDgOs3Qb1onLVRLY6DFyQ8rDwGEdWukC0ySMlqzKuRS4ZMe09jY/g
         C7Tp8YHOePX7Lqb179rxwAYqzjZbhdM9YCTk9W2qXJxURggCUmiHcQE8XaFigOw6RkS9
         FI8tNIIIQ85V6OGNniNvE60FL176R5XtunDNisBxUlkBfjaGQTEh1lHjD0C2tnh5wiYJ
         QuYoGARoivxlfkjG0saE0znvPBddJvpWIH9uaX93eHjb7tkc6air962gbC+HLTX2Ywq8
         ai/g==
X-Gm-Message-State: AOAM531JmapOoCzhP2VZQp6YIiz2XRpEYNdajyfKEuSRSZdQLXeZzEk+
        doTs0blYc5VcMTAzUroNpTqLIL/4cLFTbTq/XF5PIi2nBj//Y8i6ooJusPF2+niBeqesYzxVIRF
        nbRbFYz19AiYxlkJHjcBqIQ4/J3NVXngfx+tQbqfmGFY152U1ga3zaA==
X-Received: by 2002:a9d:1708:: with SMTP id i8mr121633ota.233.1631852352163;
        Thu, 16 Sep 2021 21:19:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8BWvVRCIlOJi8BFuwwjSCsvzkqqa2wh2Z9e6SpR3Fxj99L8az3VQO5HrHlQdiS87jESWpUulbibbQ/b0/2Js=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr121620ota.233.1631852351941;
 Thu, 16 Sep 2021 21:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154417.664323-4-kai.heng.feng@canonical.com> <20210916171232.GA1624808@bjorn-Precision-5520>
In-Reply-To: <20210916171232.GA1624808@bjorn-Precision-5520>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 17 Sep 2021 12:19:00 +0800
Message-ID: <CAAd53p4OKjX8EAuujasaDRD_V=bO5A=euETR5kJeAGfa-84DcA@mail.gmail.com>
Subject: Re: [RFC] [PATCH net-next v5 3/3] r8169: Implement dynamic ASPM mechanism
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

On Fri, Sep 17, 2021 at 1:12 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 11:44:17PM +0800, Kai-Heng Feng wrote:
> > r8169 NICs on some platforms have abysmal speed when ASPM is enabled.
> > Same issue can be observed with older vendor drivers.
> >
> > The issue is however solved by the latest vendor driver. There's a new
> > mechanism, which disables r8169's internal ASPM when the NIC traffic has
> > more than 10 packets, and vice versa.
>
> Obviously this is a *rate*, not an absolute number.  I think you mean
> something like "10 packets in 1000ms".

Will amend this in next iteration.

>
> > The possible reason for this is
> > likely because the buffer on the chip is too small for its ASPM exit
> > latency.
> >
> > Realtek confirmed that all their PCIe LAN NICs, r8106, r8168 and r8125
> > use dynamic ASPM under Windows. So implement the same mechanism here to
> > resolve the issue.
> >
> > Also introduce a lock to prevent race on accessing config registers.
>
> Can you please include the bugzilla link where you attached lspci
> data?  I think it's this:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=214307

Yes I forgot to add it. Will include in in next iteration.

Kai-Heng

>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
