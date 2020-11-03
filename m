Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACD2A5A1C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 23:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgKCWcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 17:32:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbgKCWcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 17:32:19 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B68223C6;
        Tue,  3 Nov 2020 22:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604442738;
        bh=LVFmfl7SFRM115YRpJ+p2JJKc/6zzZ3EFVZTVi2Yqiw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sptZfr8rJcsKmBnkii0A6TKNyefSYP2WXK4SaT01qTobFRe8FM34wyknauXgwNOZD
         xrAGhSZ0Dx0zmzbv+syOwDsRhxZhKz/HRbICaztCIz0gXIJHj42UtJZg1P8wG+m5rT
         c3/Y636UnmcPM2nt+zGltkOBYZ6vrR3XPY1sYsb8=
Date:   Tue, 3 Nov 2020 16:32:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 1/3] PCI: Add the IDs for Etron EJ168 and EJ188
Message-ID: <20201103223216.GA270921@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCCNHXfit5FkkvgHSh4NdbunKBp3kw3okqTY6ohsK7zNzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 07, 2020 at 09:45:23PM +0200, Martin Blumenstingl wrote:
> Hi Linus,
> 
> On Wed, Oct 7, 2020 at 11:14 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Sun, Oct 4, 2020 at 8:00 PM Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> >
> > > Add the vendor ID for Etron Technology, Inc. as well as the device IDs
> > > for the two USB xHCI controllers EJ168 and EJ188.
> > >
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > (...)
> >
> > >  #define PCI_VENDOR_ID_REDHAT           0x1b36
> > >
> > > +#define PCI_VENDOR_ID_ETRON            0x1b6f
> > > +#define PCI_DEVICE_ID_ETRON_EJ168      0x7023
> > > +#define PCI_DEVICE_ID_ETRON_EJ188      0x7052
> >
> > If you're defining that here, I think it should also be
> > removed in
> > drivers/usb/host/xhci-pci.c
> > by including this file instead?
> you are absolutely right - I missed that part
> I will change this in v2 - thanks for pointing it out!

And please mention the 2+ places these are used in the commit log (see
the comment at the top of include/linux/pci_ids.h).
