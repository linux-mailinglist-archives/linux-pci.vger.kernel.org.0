Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A682EC44D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 20:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbhAFT6K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 14:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbhAFT6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 14:58:10 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DA9C06134C;
        Wed,  6 Jan 2021 11:57:30 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i5so3001389pgo.1;
        Wed, 06 Jan 2021 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TFPxgk7ugqCN9QHQNn2fEjzxHi920s9td3tzX/Yo4w=;
        b=Pzl4TQX0it0x07hLoFXTCZukEvY6JByQlyqa9/NO4b64vANYEUBXu8pOle6b0bim0x
         0qFqQl1rij8KM2nmcYWn2g+1uYb6ht/YVMnHMJ4flr43AtZ/BlcnMznf9kiWwYviise2
         Mn9sirLT+xdCeLifNMdV91ffGHHC9DrpwAr/avQvvi+qU/hUJyqmlOt8bmvq68dlIgeN
         FMO164ecu7+iEK6QFAZEvu0pw/E16XcTQuRHlJZuowg/kQ9t8okGs0eKN1II3ehiIQ+/
         dFoy//m+lLyfzjknXO8zPd3IDjS1Kum0+bGmzxtQ1mwruwi/Ml0ggiso22D6juIpPBCl
         fTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TFPxgk7ugqCN9QHQNn2fEjzxHi920s9td3tzX/Yo4w=;
        b=hRmtKbUpQ87Igv6dc4ZwqPMJrSGwS/Go6vl7OBzKbIgn2m3iy4HTAWdm0eaNxY5l0R
         shfKKc4n73U4t7Mp/Lqh2Xri3huNybO30VkRcImNv7czYDJzRhrhn84BkJ8Ji4q8I+Zz
         0s7SdeUe4x8WLqtgcDghpBErXxAWwiigNQuqzqPznwbeUfQzR/z5LJEFcSezYoDNKwqy
         24RPZoik3zyA+unt3hpWLfFs7P9hrvwVG5hjPu8TpUnM5h9cTKa8CNl2+iwCCcIWOL6P
         RXWwHd6MhkQ7yB2OaYVPyPsH0L3QkSci4htVL2+IhM+7hwlqbgfnlta6PWHpE0EXxXAq
         6QEw==
X-Gm-Message-State: AOAM533Q1rWVlQb1lmWS7ncqHJF4ldXfDyHOGm4Jp0vF8gYvnsbzm3eE
        Jr5lbMFfAB4x2BwlWvCGV70Zt+b5IOVNHhmdgWU=
X-Google-Smtp-Source: ABdhPJw6ExobZUrWRlZg0yQ2U+JP0S5iAEVohn1eSZTN2g6rh95JwTZOk4qh2BfAsWTtfnssn8RLpti8/3sDjGpFdW8=
X-Received: by 2002:a63:1f10:: with SMTP id f16mr5974644pgf.111.1609963049972;
 Wed, 06 Jan 2021 11:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20201130211145.3012-6-james.quinlan@broadcom.com>
 <20210106191949.GA1328757@bjorn-Precision-5520> <CA+-6iNzARUT63Mv7qFzk_g5wep4v6aPuN8f8yjQcgozVcKhVTw@mail.gmail.com>
In-Reply-To: <CA+-6iNzARUT63Mv7qFzk_g5wep4v6aPuN8f8yjQcgozVcKhVTw@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 6 Jan 2021 14:57:19 -0500
Message-ID: <CANCKTBt7C+EhcpbgYdreK=xvQuOzEaDm+us-6P+PtoEfCny2Vg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 6, 2021 at 2:42 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> ---------- Forwarded message ---------
> From: Bjorn Helgaas <helgaas@kernel.org>
> Date: Wed, Jan 6, 2021 at 2:19 PM
> Subject: Re: [PATCH v2 5/6] PCI: brcmstb: Add panic/die handler to RC driver
> To: Jim Quinlan <james.quinlan@broadcom.com>
> Cc: <linux-pci@vger.kernel.org>, Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>, <broonie@kernel.org>,
> <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn
> Helgaas <bhelgaas@google.com>, Florian Fainelli
> <f.fainelli@gmail.com>, moderated list:BROADCOM BCM2711/BCM2835 ARM
> ARCHITECTURE <linux-rpi-kernel@lists.infradead.org>, moderated
> list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>, open list
> <linux-kernel@vger.kernel.org>
>
>
> On Mon, Nov 30, 2020 at 04:11:42PM -0500, Jim Quinlan wrote:
> > Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> > by default Broadcom's STB PCIe controller effects an abort.  This simple
> > handler determines if the PCIe controller was the cause of the abort and if
> > so, prints out diagnostic info.
> >
> > Example output:
> >   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
> >   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0
>
> What does this mean for all the other PCI core code that expects
> 0xffffffff data returns?  Does it work?  Does it break differently on
> STB than on other platforms?
Hi Bjorn,

Our PCIe HW causes a CPU abort when this happens.  Occasionally a
customer will have a fault handler try to fix up the abort and
continue on, but we recommend solving the root problem.  This commit
just gives us a chance to glean info about the problem.  Our newer
SOCs have a mode that doesn't abort and instead returns 0xffffffff.

BTW, can you point me to example files where "PCI core code that
expects  0xffffffff data returns" [on bad accesses]?

Regards,
Jim Quinlan
Broadcom STB

>
> > +/*
> > + * Dump out pcie errors on die or panic.
>
> s/pcie/PCIe/
> This could be a single-line comment.
>
> > + */
>
