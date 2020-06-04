Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BE1EE9DB
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 19:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgFDRzU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 13:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbgFDRzT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:19 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB32206DC;
        Thu,  4 Jun 2020 17:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591293318;
        bh=MT5qKU/iMjw6YreBb1u2uotYSev1lMfE5vRFN/e38l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KA/1zd7/QKhgnl/GXFWFNaJ+yzz0htCDijcndCocNBLefqCfL/9Ai+wbn2If6Ehhz
         a/nV/sP2XmrhTf/xan8OVGlECkUlt/dGEv+//LTEtLVHkcRRzjQye4bt0GCNUawE4Q
         eH+qz1a3JxfZLCoxIqHGvzs1peLRXo6OSzqLoaCA=
Date:   Thu, 4 Jun 2020 12:55:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Richard Hsu <saraon640529@gmail.com>, Richard_Hsu@asmedia.com.tw,
        Yd_Tseng@asmedia.com.tw, Jesse1_Chang@asmedia.com.tw,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] gpio:asm28xx-18xx: new driver
Message-ID: <20200604175515.GA1076951@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJX8U-uNYJPQxmkox=YTSvXVPrWss2y5MS81_bg43Co8Lg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 04, 2020 at 01:54:21PM +0200, Bartosz Golaszewski wrote:
> czw., 4 cze 2020 o 09:33 Richard Hsu <saraon640529@gmail.com> napisał(a):
> >
> > Hi Linus Walleij,Bartosz Golaszewski and kbuild test robot,
> >    I have fixed the warnings(make W=1 ARCH=i386) by replace two functions
> > with static type,and resend the patch.
> > line 69:
> > <<void pci_config_pm_runtime_get(struct pci_dev *pdev)
> > >>static void pci_config_pm_runtime_get(struct pci_dev *pdev)
> > line 91:
> > <<void pci_config_pm_runtime_put(struct pci_dev *pdev)
> > >>static void pci_config_pm_runtime_put(struct pci_dev *pdev)
> >
> > Thanks
> >
> > BR,
> >   Richard
> > Signed-off-by: Richard Hsu <saraon640529@gmail.com>

> > +       /* We look for our device - Asmedia 28XX and 18XX Bridge
> > +        * I don't know about a system with two such bridges,
> > +        * so we can assume that there is max. one device.
> > +        *
> > +        * We can't use plain pci_driver mechanism,
> > +        * as the device is really a multiple function device,
> > +        * main driver that binds to the pci_device is an bus
> > +        * driver and have to find & bind to the device this way.
> > +        */
> > +
> > +       for_each_pci_dev(pdev) {
> > +               ent = pci_match_id(pci_tbl, pdev);
> > +               if (ent) {
> > +                       /* Because GPIO Registers only work on Upstream port. */
> > +                       type = pci_pcie_type(pdev);
> > +                       if (type == PCI_EXP_TYPE_UPSTREAM) {
> > +                               dev_info(&pdev->dev, "ASMEDIA-28xx/18xx Init Upstream detected\n");
> > +                               goto found;
> > +                       }
> > +               }
> > +       }
> > +       goto out;
> > +
> 
> Bjorn: is this approach really correct? It looks very strange to me
> and even if we were to do this kind of lookup I'd expect there to be a
> real pci device registered as child of pdev here so that we can have a
> proper driver in place with probe() et al.

No, this is pretty broken.  The model is that one PCI device goes with
one driver.  If there are two bits of functionality associated with a
single PCI device, it's up to the single PCI driver to sort that out.

The comment above mentions "multiple function device," which may lead
to some confusion about the terminology.  In the PCI specs, the
smallest addressable unit of PCI hardware is the "Function."  A
"Device" may consist of one or more Functions.  A Device with more
than one Function is referred to in the spec as a "Multi-Function
Device".

These PCI Functions are addressed by a (domain, bus, device, function)
tuple.  For example, my system has these:

  0000:00:14.0 Intel USB 3.0 xHCI Controller
  0000:00:14.2 Intel Thermal Subsystem

These two Functions are parts of the 0000:00:14 Multi-Function Device.

In Linux, a "struct pci_dev" refers to a single Function, so there's
a pci_dev for 0000:00:14.0 and another for 0000:00:14.2.  These are
pretty much independent, and can be claimed by two separate drivers.

But I think the "multiple function device" comment in *this* patch
probably doesn't refer to a "Multi-Function Device" as used in the PCI
specs.  It probably means a single PCI Function that has two kinds of
functionality.

In the Linux model, that means the Function should be claimed by a
single driver, and that driver is responsible for coordinating the two
pieces of functionality.

Bjorn
