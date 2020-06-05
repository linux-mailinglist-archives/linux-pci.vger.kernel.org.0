Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9677E1EF287
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFEHzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jun 2020 03:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEHzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jun 2020 03:55:43 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E74FC08C5C2
        for <linux-pci@vger.kernel.org>; Fri,  5 Jun 2020 00:55:42 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so9265954iow.7
        for <linux-pci@vger.kernel.org>; Fri, 05 Jun 2020 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fn6d0rG1WRm22xj2b5NGQoFjGmqWjK3x4gd/gH4cTe0=;
        b=napgGUjtBstHaKnWWAcYRE9+wyJbxk66BBMEEh1vAYPPhh3BsNVWTmF+SaM6DRStHz
         KhfmvrVL7amdp1nsprW+RWRzE0G49LBt4ZFeCXwhSmmzsjzwRmky5fhUA3GFffzqTrW5
         0DlLgeH3O6rSTZ+w/JYgqQb0mMFgdGnYDe9IstCdBCqss5qYcgDv32OySW1Mji0SNTUI
         H3Ah1CzDBPOTiTZH8Xd/d4lnTrK223b1zYtDlvy7bNiMdzs2ago3OOb3TM/q3UICmpfy
         jmvesJKZOY6QDyxB3Irvhcxnnsti0+4q9fIcyx0I2VamPkEUjRX3qNm9JBGIncXr6hFv
         ufVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fn6d0rG1WRm22xj2b5NGQoFjGmqWjK3x4gd/gH4cTe0=;
        b=DwcT3rCW6adpzvlW3jqbcjTlLgz41QAIivknrg1u8HWJb3IR64qfTpDeT50VKKOmmX
         jVHgPhXekPjYszOF+Uu634PAU9j6dph5J6746B6rxJsOwcu/OQOpVz1kBRM331kPvLgX
         Hhn0JLkdvTWBjbiWszXC/s5lkT1qoVxlY+obZ/kmRnZowtIL6Eyk3cOth9tmNZO2yjoa
         1c39ERnRJ7S9CY5vhamBFxvkWVkJEinD2NQqGyvuIJRXeeKHVst3nhS0hXaL1f22X6Q5
         Z0wwaP2vJDA/Xp7f++U6UVtO9OvBZ6HzvfHTrNXrqq1RQ/nw6Wwrri4lxHKdEr37rIkm
         LJEA==
X-Gm-Message-State: AOAM533oKzw6nBcejxvO4J2imJGcYXzx/H1L/ZeeCqtQMUIZ5Wknnon/
        v2TA+5au5pTscD36iMmuHCG5n56j3fLNQ99rqUkD0w==
X-Google-Smtp-Source: ABdhPJzySjsrYJWlwo+qyiiIvYJv/b1UsVHtFdnZqKiqFRi+LK2PxUf4HI42eeakb5whjKDNylTXeyddpLy8O/Gu5M4=
X-Received: by 2002:a02:a003:: with SMTP id a3mr7313081jah.102.1591343741504;
 Fri, 05 Jun 2020 00:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAMpxmJX8U-uNYJPQxmkox=YTSvXVPrWss2y5MS81_bg43Co8Lg@mail.gmail.com>
 <20200604175515.GA1076951@bjorn-Precision-5520>
In-Reply-To: <20200604175515.GA1076951@bjorn-Precision-5520>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 5 Jun 2020 09:55:30 +0200
Message-ID: <CAMRc=McWFpFAC3ziWdOEYkc0YwkN-Jqf7vZpxbCBLPoe=oewdg@mail.gmail.com>
Subject: Re: [PATCH] gpio:asm28xx-18xx: new driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Richard Hsu <saraon640529@gmail.com>,
        Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

czw., 4 cze 2020 o 19:55 Bjorn Helgaas <helgaas@kernel.org> napisa=C5=82(a)=
:
>
> > > +       /* We look for our device - Asmedia 28XX and 18XX Bridge
> > > +        * I don't know about a system with two such bridges,
> > > +        * so we can assume that there is max. one device.
> > > +        *
> > > +        * We can't use plain pci_driver mechanism,
> > > +        * as the device is really a multiple function device,
> > > +        * main driver that binds to the pci_device is an bus
> > > +        * driver and have to find & bind to the device this way.
> > > +        */
> > > +
> > > +       for_each_pci_dev(pdev) {
> > > +               ent =3D pci_match_id(pci_tbl, pdev);
> > > +               if (ent) {
> > > +                       /* Because GPIO Registers only work on Upstre=
am port. */
> > > +                       type =3D pci_pcie_type(pdev);
> > > +                       if (type =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> > > +                               dev_info(&pdev->dev, "ASMEDIA-28xx/18=
xx Init Upstream detected\n");
> > > +                               goto found;
> > > +                       }
> > > +               }
> > > +       }
> > > +       goto out;
> > > +
> >
> > Bjorn: is this approach really correct? It looks very strange to me
> > and even if we were to do this kind of lookup I'd expect there to be a
> > real pci device registered as child of pdev here so that we can have a
> > proper driver in place with probe() et al.
>
> No, this is pretty broken.  The model is that one PCI device goes with
> one driver.  If there are two bits of functionality associated with a
> single PCI device, it's up to the single PCI driver to sort that out.
>
> The comment above mentions "multiple function device," which may lead
> to some confusion about the terminology.  In the PCI specs, the
> smallest addressable unit of PCI hardware is the "Function."  A
> "Device" may consist of one or more Functions.  A Device with more
> than one Function is referred to in the spec as a "Multi-Function
> Device".
>
> These PCI Functions are addressed by a (domain, bus, device, function)
> tuple.  For example, my system has these:
>
>   0000:00:14.0 Intel USB 3.0 xHCI Controller
>   0000:00:14.2 Intel Thermal Subsystem
>
> These two Functions are parts of the 0000:00:14 Multi-Function Device.
>
> In Linux, a "struct pci_dev" refers to a single Function, so there's
> a pci_dev for 0000:00:14.0 and another for 0000:00:14.2.  These are
> pretty much independent, and can be claimed by two separate drivers.
>
> But I think the "multiple function device" comment in *this* patch
> probably doesn't refer to a "Multi-Function Device" as used in the PCI
> specs.  It probably means a single PCI Function that has two kinds of
> functionality.
>
> In the Linux model, that means the Function should be claimed by a
> single driver, and that driver is responsible for coordinating the two
> pieces of functionality.
>

Thanks for the detailed explanation!

Richard: in this case I think it's pretty clear now that whatever
driver supports the "bridge" mentioned in the comment - needs to be
extended with GPIO functionality.

Bart
