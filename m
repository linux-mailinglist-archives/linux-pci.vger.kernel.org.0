Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6A2FA229
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392367AbhARNvS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 08:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392303AbhARNeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jan 2021 08:34:13 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE47C061575
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 05:33:33 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p5so17676082oif.7
        for <linux-pci@vger.kernel.org>; Mon, 18 Jan 2021 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWQeMSsdJuSsUOBrsXP1MhR52IRX9itp1JrcMK5DUKQ=;
        b=DU+i5epEQ7Ee+6EDmRPzweIuJWs3968A4CyA1VPzGaW0yB3jIHqEVsGiZ1bVhbgrDO
         +ekX2uEGi5XNcAJhItor2ODi361YOaPR/n06Z2G1tmH8pNS1gnosR3Bt/3s1hNPHnHX0
         lqMHhTsG0IT5najJM+faL3y7o1VeV+tY1zrO4etxMQPQMKGVngvrI72ImQs2/EZ2pbk0
         5DIN+nffAVLHpM1sKTpUJCRe9/Ojrj5Kn9VxfnOMh7e3g9o5Zhy4bYjxMkJHsVkOpLzv
         qtPgkUgk7NVsoQZF32UhOnHihWbPxpeO61MjQ8kTgvdZdQUOaVmkQthtRMAkmG4/gDbD
         YLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWQeMSsdJuSsUOBrsXP1MhR52IRX9itp1JrcMK5DUKQ=;
        b=cWmIWWH4PTNYZ+Q63JbaaJknyDdq+hNf7CSZeh9sICIUkWrPF7rG+9M346+9fcnoAT
         jozpIMWl+Sy52AX4J8VVe2KJHhaWyOJzRuJBnf7pczDIs2lJdocgNLBnpukwbShbmJAu
         hdxasId462MEsbG29DHEjw9L6zKixnVdfyejZbFr4LW+1GF1tZhV3hlGdoxQtDlu9/Vk
         PMeJ8jqEQ+J077/5GGrExWFdYvzQY4g6jR3xX6xeTEoTkv/5Dn5dGidg86j/BlFqAL3v
         RlInGiPtl++3FJaBSWNJM9V7H/HuOuyG/rAcnsaq+RI5Sdiv+zWUvKVwPDwVQtNicHjZ
         qVtg==
X-Gm-Message-State: AOAM533nSPtxAdw1Uo2bSj4Oz5p+Z+X1wWp6SUTd2g7ZMNX/CtXkbjo5
        NyNwR/OqEK7qABOtHDBMARSm67V24KzZzHNKiyYx/Q==
X-Google-Smtp-Source: ABdhPJxWcsveD8tTonu9adarn0VorNJNyetPA3pDbFk9LMHgOAXw36lpd19zdZdTLXi+y0mlfXSuq4nHOdbn9mlLUOs=
X-Received: by 2002:aca:4257:: with SMTP id p84mr12490560oia.68.1610976812764;
 Mon, 18 Jan 2021 05:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20201112172709.1817-1-phil@raspberrypi.com> <CA+-6iNwH3v78QhQOFpsXfA4hgUo9TXJaF4hy_imA60iQ2a3bMg@mail.gmail.com>
 <20210118124003.GA12967@e121166-lin.cambridge.arm.com> <9c50176681925fa06a0c1c385a3ab7f88a3faec7.camel@suse.de>
In-Reply-To: <9c50176681925fa06a0c1c385a3ab7f88a3faec7.camel@suse.de>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Mon, 18 Jan 2021 13:33:22 +0000
Message-ID: <CAMEGJJ2ZxrWJp-+E4rrCQV9H8WdcxKxFSntNwGCkYTrEfcratw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: brcmstb: Restore initial fundamental reset
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        phil <phil@raspberrypi.org>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 Jan 2021 at 12:44, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Mon, 2021-01-18 at 12:40 +0000, Lorenzo Pieralisi wrote:
> > On Thu, Nov 12, 2020 at 01:38:13PM -0500, Jim Quinlan wrote:
> > > On Thu, Nov 12, 2020 at 12:27 PM Phil Elwell <phil@raspberrypi.com> wrote:
> > > >
> > > > Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > > > replaced a single reset function with a pointer to one of two
> > > > implementations, but also removed the call asserting the reset
> > > > at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> > > > VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> > > > used for USB booting but then need to be reset so that the kernel
> > > > can reconfigure them. The lack of a reset causes the firmware's loading
> > > > of the EEPROM image to RAM to fail, breaking USB for the kernel.
> > > >
> > > > Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > > >
> > > > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> > > > Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > ---
> > > > Changes in v2:
> > > >   - Exclude BCM7278 from the initial reset
> > > >   - Ack from Nicolas
> > > > ---
> > > >  drivers/pci/controller/pcie-brcmstb.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > > index bea86899bd5d..83aa85bfe8e3 100644
> > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > @@ -869,6 +869,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > > >
> > > >         /* Reset the bridge */
> > > >         pcie->bridge_sw_init_set(pcie, 1);
> > > > +
> > > > +       /* Assert the fundemental reset, except on BCM7278 */
> > > > +       if (pcie->type != BCM7278)
> > > > +               pcie->perst_set(pcie, 1);
> > > I'm okay with this although I  would rather it not be needed.
> >
> > Can I merge this patch as is then ?
>
> No. IIUC the consensus was to fix this in firmware. There is a u-boot fix
> available in their mailing list, and I think RPi's firmware was also patched
> accordingly (@Phil please confirm).

Any users running firmware released since mid-November should not
require the precautionary reset in order to have functioning USB.
Having said that, we'll be keeping this patch in our repo for the
benefit of everybody else.

Phil
