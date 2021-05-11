Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA40337A900
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 16:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhEKOWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 10:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhEKOWj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 May 2021 10:22:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 443B0611CC;
        Tue, 11 May 2021 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620742892;
        bh=754tmoCujVq6lcUy8BeWkfA3aUF0gZ2lG5aHBKFhZ3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tQIEz3IwTFUbXijv/Wx2YlxtAGBXUQfAW+URx78HUJvoivQS9TfrOKYIC0BKBgy4x
         gD8gar4U/unzs6QO4CJtsAMBTTVw2yCiPHdM+czxxV0ONyPDI9irklHQmqStfYXNWO
         X2JI+YHdqSJ6Hz4JzWnPg5EyNt3DDN0ys/mn6nO3i7d9LiLz5kCN9VRYrdB30KE14s
         SrVzJssgH9JFdXZv8ALK72yytJrSou+o1ZBFkEF+jmJiie1/+t3F5Dl5Qdi6XBpE4o
         j7LNZ/DolKP6A8W6Xcnagdi5jF0n0SsXG7bi76q4sUUj3KfoLFTFlANmNGlFIBQ+ym
         +YqeHlYvLEAUg==
Received: by mail-ed1-f43.google.com with SMTP id s6so23054227edu.10;
        Tue, 11 May 2021 07:21:32 -0700 (PDT)
X-Gm-Message-State: AOAM531uuhGC6Wk8yfP4Sa0A8AFtFTNH+5HtukWmP6mhk0zNuToFJV1n
        htb90R/zTF0njaJzOdFKyaxF/YzKVHnymPRo0A==
X-Google-Smtp-Source: ABdhPJz6YEH4sg1aBHVhiGqT0sRQACzH0OtRLw5u2iOJhPP/q+aSP4ABZ5LhSBxOqn6ObbdH+LmLAfnUs2+wn8l27b4=
X-Received: by 2002:a05:6402:c9b:: with SMTP id cm27mr30368188edb.258.1620742890641;
 Tue, 11 May 2021 07:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210510141509.929120-1-l.stach@pengutronix.de>
 <20210510141509.929120-3-l.stach@pengutronix.de> <20210510170510.GA276768@robh.at.kernel.org>
 <854ec10d9a32df97d1f53a784dffca4e5036b059.camel@pengutronix.de>
In-Reply-To: <854ec10d9a32df97d1f53a784dffca4e5036b059.camel@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 May 2021 09:21:13 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+dkJ+bbuQDQieHdocjLoNKN2vib8scJsdGnCnffSGAcA@mail.gmail.com>
Message-ID: <CAL_Jsq+dkJ+bbuQDQieHdocjLoNKN2vib8scJsdGnCnffSGAcA@mail.gmail.com>
Subject: Re: [PATCH 3/7] PCI: imx6: Rework PHY search and mapping
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        patchwork-lst@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 11, 2021 at 3:11 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Montag, dem 10.05.2021 um 12:05 -0500 schrieb Rob Herring:
> > On Mon, May 10, 2021 at 04:15:05PM +0200, Lucas Stach wrote:
> > > We don't need to have a phandle of the PHY, as we know the compatible
> > > of the node we are looking for. This will make it easier to put add
> > > more PHY handling for new generations later on, where the
> > > "fsl,imx7d-pcie-phy" phandle would be a misnomer.
> > >
> > > Also we can use a helper function to get the resource for us,
> > > simplifying out driver code a bit.
> >
> > Better yes, but really all the phy handling should be split out to
> > its own driver even in the older h/w with shared phy registers.
> >
> That would be a quite massive DT binding changing break, possibly even
> a separate driver. Maybe it's time to do this for i.MX8MM, as the
> current driver just kept piling on special cases for "almost the same"
> hardware that by now looks quite different to the original i.MX6 PCIe
> integration this driver was supposed to handle.

No, you don't need to change DT, and a DT change adding a phy node
wouldn't even be correct modeling of the h/w IMO. For the i.MX6 phy, a
separate PHY driver would have to create its own platform device in
its initcall (if the iMX6 PCI compatible is found). Then the PCI
driver would need to use a non-DT based phy_get() lookup. For the
cases with a phandle to the phy, I'd assume a phy driver could be
instantiated for that node. You'll again need a non-DT phy_get() if
not using the phy binding.

Rob
