Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5745169F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhKOVgE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 16:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347294AbhKOVHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 16:07:51 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3E1C0432DB
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 12:56:26 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y196so15067039wmc.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Nov 2021 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UrTT5OjFF/ppB+7IkG4hoMbeGHcKoOd9F+xHAZ+mnyo=;
        b=f7wjwIB/WhAldwlcCPBWND3Iq9q35SWJbzttX4G4tLxXYUVT7O+6uICXS4XN2fTJwt
         t0P76Pua0+3okKElXWZkrUKwUEluSn0JLOHBpcRxUNAdhr9x6B+qaLXBHvcNUNXwRBeq
         IMPA9YhnPqyh23tr+6MYSb1xrGxvBcWnMrpSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UrTT5OjFF/ppB+7IkG4hoMbeGHcKoOd9F+xHAZ+mnyo=;
        b=J2tzvkX6mWB6Qbf5/em4uemTUef+j1/BOXPKRy4xPd1R+uPF97vBVG0rCFggSg6bFw
         4OL+d6xkyfVAfzoXhXeb7+v+sUq3XuoN5s25d+ud3AqSFoHq4k23+xmS4jg742WEnkWN
         7eWoOfjcElKI/maxE7e0LGlwKCpRttnVuTfgWWCpoyRnnEUconVNBdevNhiEugJN5LDa
         n4/cNxnKmo1URZQgZuFZVbnkbtuOAOIGPHuUfntgG2vy5RkHF60IugsEPSNaADvEYWoZ
         twKB9XCKlR6c8+Bq6c8mXOuIJL/RyTACwpsGrLL231hf42YECQx+ArjPNEmiV04y3LJE
         bnDw==
X-Gm-Message-State: AOAM533LDJIOJ3B0pMZz/eWvmNasoFWx2DQQ/mk7dvbT7BebORbbSqfK
        3FUewBpS2DhlYy86jVel3n4yo+UmH6G/6eR+CjDLbw==
X-Google-Smtp-Source: ABdhPJwp3kxwH8yb+NVAAcawjhpi2GUBtHN3D9ybC50c+3BOLdWRk3C4iKCxv4dBtBMWf6wMDV52tSgm6dFPjFOrfKw=
X-Received: by 2002:a05:600c:1d01:: with SMTP id l1mr64557876wms.44.1637009785359;
 Mon, 15 Nov 2021 12:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-2-jim2101024@gmail.com> <20211111215718.GA1353371@bhelgaas>
In-Reply-To: <20211111215718.GA1353371@bhelgaas>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Mon, 15 Nov 2021 15:56:14 -0500
Message-ID: <CA+-6iNy86LG761MYvr-mB0de1TZ_EbJxzw0vFYfgXaa+96k=GA@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] PCI: brcmstb: Change brcm_phy_stop() to return void
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 4:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 10, 2021 at 05:14:41PM -0500, Jim Quinlan wrote:
> > We do not use the result of this function so make it void.
>
> I don't get it.  Can you expand on this?
>
> brcm_phy_cntl() can return -EIO, which means brcm_phy_stop() can
> return -EIO, which means brcm_pcie_suspend can return -EIO.
> brcm_pcie_suspend() is the dev_pm_ops.suspend() method.
>
> So are you saying we never use the result of dev_pm_ops.suspend()?
Hi Bjorn,

In this situation we are going into suspend.  In doing so, any
problems with the brcm phy may be erased/forgiven upon resume, since
clocks are turned off and most power removed/reduced.  An error from
brcm_phy_stop() that becomes the return value of  brcm_pcie_suspend()
will bring a halt to the entire suspend IIRC.   In fact, I forced a
-EIO in this code and it panic'd on suspend.  This is not really the
behavior I want for what is most likely a recoverable error.

Perhaps a dev_err(...) will suffice while still returning 0?

I noticed that reset_control_rearm() also returns a value, and if that
is in error it will not be erease/forgiven  by suspend sleep.  I will
fix this.

Regards,
Jim Quinlan
Broadcom STB


>
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-brcmstb.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > index cc30215f5a43..ff7d0d291531 100644
> > --- a/drivers/pci/controller/pcie-brcmstb.c
> > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > @@ -1111,9 +1111,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
> >       return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
> >  }
> >
> > -static inline int brcm_phy_stop(struct brcm_pcie *pcie)
> > +static inline void brcm_phy_stop(struct brcm_pcie *pcie)
> >  {
> > -     return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
> > +     if (pcie->rescal)
> > +             brcm_phy_cntl(pcie, 0);
> >  }
> >
> >  static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> > @@ -1143,14 +1144,13 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
> >  static int brcm_pcie_suspend(struct device *dev)
> >  {
> >       struct brcm_pcie *pcie = dev_get_drvdata(dev);
> > -     int ret;
> >
> >       brcm_pcie_turn_off(pcie);
> > -     ret = brcm_phy_stop(pcie);
> > +     brcm_phy_stop(pcie);
> >       reset_control_rearm(pcie->rescal);
> >       clk_disable_unprepare(pcie->clk);
> >
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static int brcm_pcie_resume(struct device *dev)
> > --
> > 2.17.1
> >
