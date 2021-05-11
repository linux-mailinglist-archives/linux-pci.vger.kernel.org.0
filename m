Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5737AA8E
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhEKPYO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 11:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhEKPYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 May 2021 11:24:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E035D61932;
        Tue, 11 May 2021 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620746581;
        bh=/MMqHAl4kz6V10zlv7FjfYKtb2ajZuX+4Az+QXaHN8c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=my03m9pQbW+WhqZUHWpM7uh4MwnwK+/YjDUGlxvrbbo5bLnax4YfZvBQ1LyyVOmhR
         OspeXCTaPdiMun2HeHQEKnZPIlLFgU2tI/PkJOJT/p7THki/OzGH/6gCkNDJ0KAgUI
         +h/L0BmtfxDd0FNGxqU9hG3Af4t4rcmsV1+up/vRqP5nBn9Bezai9yVyL1+G/k3jU8
         SXN4/LWzSSjvIjkOi1istqVTZmv3+i3iU5AbgTv1eVlrfK5GzY5kSjVfvM9WfN7k3m
         zaZp90mee1fZMs1ecxS5N5a28ig56pqtWhtJtPQ2h70ciec7q1+2wBS0vvy/ruAUyk
         lnnk+91WWHoBg==
Received: by mail-qk1-f169.google.com with SMTP id c20so8096489qkm.3;
        Tue, 11 May 2021 08:23:01 -0700 (PDT)
X-Gm-Message-State: AOAM532gefBS2Z3BpJXH1zS/+xee5/8cwuikO9fbViLXy/54dTZtKjDY
        cGhx/IXaVqR+1n1gPFqxME7O+95E+LlSjz+uHw==
X-Google-Smtp-Source: ABdhPJyoLoL9+PcH2fUk/N9lm+Erm45nGkWoMGYfosfQ+USMeQcBlPflYzdFDIYPQn7agJMrLVEYewzc3ZRhYJK527A=
X-Received: by 2002:a05:620a:12a6:: with SMTP id x6mr27903646qki.364.1620746580862;
 Tue, 11 May 2021 08:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210510141509.929120-1-l.stach@pengutronix.de>
 <20210510141509.929120-3-l.stach@pengutronix.de> <20210510170510.GA276768@robh.at.kernel.org>
 <854ec10d9a32df97d1f53a784dffca4e5036b059.camel@pengutronix.de>
 <CAL_Jsq+dkJ+bbuQDQieHdocjLoNKN2vib8scJsdGnCnffSGAcA@mail.gmail.com> <2ea9546c7dc1644376576db2cb01005fb041f349.camel@pengutronix.de>
In-Reply-To: <2ea9546c7dc1644376576db2cb01005fb041f349.camel@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 May 2021 10:22:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKa2AFm6kESB8R=9pn4=_x80kpRd90THgGEkBbymOU6kA@mail.gmail.com>
Message-ID: <CAL_JsqKa2AFm6kESB8R=9pn4=_x80kpRd90THgGEkBbymOU6kA@mail.gmail.com>
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

On Tue, May 11, 2021 at 9:54 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Dienstag, dem 11.05.2021 um 09:21 -0500 schrieb Rob Herring:
> > On Tue, May 11, 2021 at 3:11 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Am Montag, dem 10.05.2021 um 12:05 -0500 schrieb Rob Herring:
> > > > On Mon, May 10, 2021 at 04:15:05PM +0200, Lucas Stach wrote:
> > > > > We don't need to have a phandle of the PHY, as we know the compatible
> > > > > of the node we are looking for. This will make it easier to put add
> > > > > more PHY handling for new generations later on, where the
> > > > > "fsl,imx7d-pcie-phy" phandle would be a misnomer.
> > > > >
> > > > > Also we can use a helper function to get the resource for us,
> > > > > simplifying out driver code a bit.
> > > >
> > > > Better yes, but really all the phy handling should be split out to
> > > > its own driver even in the older h/w with shared phy registers.
> > > >
> > > That would be a quite massive DT binding changing break, possibly even
> > > a separate driver. Maybe it's time to do this for i.MX8MM, as the
> > > current driver just kept piling on special cases for "almost the same"
> > > hardware that by now looks quite different to the original i.MX6 PCIe
> > > integration this driver was supposed to handle.
> >
> > No, you don't need to change DT, and a DT change adding a phy node
> > wouldn't even be correct modeling of the h/w IMO. For the i.MX6 phy, a
> > separate PHY driver would have to create its own platform device in
> > its initcall (if the iMX6 PCI compatible is found). Then the PCI
> > driver would need to use a non-DT based phy_get() lookup. For the
> > cases with a phandle to the phy, I'd assume a phy driver could be
> > instantiated for that node. You'll again need a non-DT phy_get() if
> > not using the phy binding.
>
> The original i.MX6 PCIe with the internal PHY is the easy case, as you
> laid out above.
>
> What I'm more concerned about is the i.MX7 and i.MX8MQ, where we have a
> MMIO mapped PHY and quite a bit of the clocks/reset/GPR handling would
> need to move from the controller to the PHY driver. Without a binding
> change I fear that we end up in a worst of both worlds situation, where
> we have lots of code in the driver to separate resources that are
> currently all attached to the PCIe controller node in the DT, without a
> real gain in making the driver any simpler or easier to maintain.

One option for handling compatibility is making an overlay for old DTs
instead of coding the old DT handling. There's an example of this for
rcar-du in drivers/gpu/drm/rcar-du/rcar_du_of_lvds_*.dts.

Rob
