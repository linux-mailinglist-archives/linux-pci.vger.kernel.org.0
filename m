Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED432B0A57
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgKLQmk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgKLQmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 11:42:39 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D886C0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 08:42:39 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id m143so7086047oig.7
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ba+PZWKOieEYiFlC81JrcbjzPFiIPb+iZaQxXkOtdxY=;
        b=ZxWVMbFu6OlwjYN23554RnqCzda8mFXlz2Fu19cJSqtIxLkB74Jsj/uuAENdW5ui26
         niAebijycFsJZQQ5tzVfPpaQ96qytXsTzWVxQv6b/LErguZkNPPqaCWsL+IalpOgV2rT
         wwkQl3XeS5EDXVhXjNHrYfMzsEtfHpBd5rA/+cb1LnVNHPLANCavfmDwIJp8pE7HCnWy
         sJ8SeTiZZbDJbQX2MZZI5b00U+nsaPw8W33tZsgZnMI3/dzNbcjmgW34JoaUOS87uHhn
         cmfH/YMe14griForM8OZTcF2nXBPnhEnjZN4rgsHkFutfA8qOsAnOGpHYGbW0QWirpS9
         Hpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ba+PZWKOieEYiFlC81JrcbjzPFiIPb+iZaQxXkOtdxY=;
        b=iLj/WdR95gwhrMwuBAOQAneBcU1qjSAEkWQNRzlF1AxbuOhip1fQJOJ+ZLX7g2NwQQ
         Y0C3CDgaA/ejDR1UN34JlhXeS+FuV45UE0SADmlqBIBCDgWLvs0CzQGh6YB3OT8RgPe5
         tKV11KoDZEWLbXo4uk7X0GuuOLnIz05iGcXI50YZotfKkZeqcEYz03ex/j2TQTTjqkiy
         VQ1JWxBzVX1e+ZpsM6qXqcg+o5pqouVoJA4wJ1x0Sjcl6TGjHPzFCjNT55QxxAj2HMJp
         upSHe4qN4z4g0pOKYNTf7Pui0QciB36pZ75hIzeUgF7l2VU3gVWoXd5KpPEX1HyyWyUt
         vigw==
X-Gm-Message-State: AOAM530/LWceOc3DC2V1hzXNpSzb5QDf1tnYsW94AoHJrv8YFBWmd3nu
        mK1eQHp7BmKkReGXCsWc448ERZGI/J1gqM4hSx0znw==
X-Google-Smtp-Source: ABdhPJxziDA4W2xe501D6AEvpGRuKZaRYItebggo0eCbbzEc48q9kwD7pq8nb1dCBXyJ7O/pXKI2lDAwUwhlRuo5rYI=
X-Received: by 2002:aca:4797:: with SMTP id u145mr423566oia.0.1605199358924;
 Thu, 12 Nov 2020 08:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20201112131400.3775119-1-phil@raspberrypi.com>
 <883066bd-2a0c-f0d8-c556-7df0e73f0503@gmail.com> <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
In-Reply-To: <CA+-6iNxc9UiEqFXj4jMJRXW1XAS7aB4hANa7mHRsK8++t2A18A@mail.gmail.com>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Thu, 12 Nov 2020 16:42:28 +0000
Message-ID: <CAMEGJJ12UT5KN6G2-xZ4oHn4Dpj=_k77DW=Hb324HYabUyw4pg@mail.gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Restore initial fundamental reset
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
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

Hi Jim,

On Thu, 12 Nov 2020 at 16:28, Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Thu, Nov 12, 2020 at 10:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > +JimQ,
> >
> > On 11/12/2020 5:14 AM, Phil Elwell wrote:
> > > Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > > replaced a single reset function with a pointer to one of two
> > > implementations, but also removed the call asserting the reset
> > > at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
> > > VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
> > > used for USB booting but then need to be reset so that the kernel
> > > can reconfigure them. The lack of a reset causes the firmware's loading
> > > of the EEPROM image to RAM to fail, breaking USB for the kernel.
> > >
> > > Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
> > >
> > > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> >
> > This does indeed seem to have been lost during that commit, I will let
> > JimQ comment on whether this was intentional or not. Please make sure
> > you copy him, always, he wrote the driver after all.
> Hello,
>
> This wasn't accidentally lost; I intentionally removed it.  I was
> remiss in not mentioning this in comments, sorry.


Yes, a comment would have been helpful.

>  The reason I took it out is because (a) it breaks certain STB SOCs and
> (b) I considered it superfluous (see reason below).  At any rate, if
> you must restore this line please add the following guard so
> everyone's board will work :-)
>
>         if (pcie->type != BCM7278)
>                 brcm_pcie_perst_set(pcie, 1);
>
>
>
> As for me considering that  this line is superfluous -- which
> apparently it is not : AFAIK PERST# is always asserted from cold start
> on all Brcm STB SOCs, and I expected the same on the RPi.  Asserting
> PERST# at this point in time should be a no-op.  Is this not the case?


The reason it isn't superfluous here is that when using USB to boot,
the Raspberry Pi BCM2711 firmware will already have configured the
PCIe bus once, so another reset is necessary. Since the Linux driver
used to always reset everything at start of day, regardless of the
power-on reset state, there's no reason for the firmware to also reset
it before handing over - and there could be some useful state in there
when it comes to debugging.

I'm happy to add a condition - not a BCM7278 sounds reasonable - and a
comment, of course.

Phil
