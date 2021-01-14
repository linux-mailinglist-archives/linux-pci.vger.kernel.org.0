Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1862F6187
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 14:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhANNHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 08:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbhANNHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 08:07:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7746523A57;
        Thu, 14 Jan 2021 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610629588;
        bh=D/+/bkmIIfUUeCxv5tjLKpAVV+Rlk4zpoC2NQcbuLb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AC/B8BKOqp7Z35A6gK8NMvjeg+/ildA3STf2gnCVnVAfAVf0awZaDlD+expNz0HY/
         0AYhZJ7ZQp+jLHnISNeiA8yT4hYX5XJHdkdyFJeQCBzdXox8o8lW1gYxm9GnYgmsko
         YoRoawyCJJkwaiL6M6ZOv74P+Bdhqm877wXtzLAhBmCTD/r4mW6NG1YZOIySifTTaU
         iCQKNmN46r61IgGMOWvKEWM8Hc+tDeG6Hdyqoi1MoDayDRHMwdKn7huEsgEWhXoTx9
         U1lBfyif8afErmlKXSsEejDUIk4e45NPSGA32zsaygHDTHyGD8guygfli/HKAMfJUh
         laPKlbqa8JK1w==
Date:   Thu, 14 Jan 2021 15:06:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: Re: [RESEND PATCH v5 2/2] PCI: sprd: Add support for Unisoc SoCs'
 PCIe controller
Message-ID: <20210114130624.GR4678@unreal>
References: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
 <1610612968-26612-3-git-send-email-wuht06@gmail.com>
 <20210114085233.GO4678@unreal>
 <CAG_R4_UJ0=8=31XZD-SiiuL91M02N+fn=CLNA4_5Xm7jRDE1Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_R4_UJ0=8=31XZD-SiiuL91M02N+fn=CLNA4_5Xm7jRDE1Rg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 14, 2021 at 08:00:50PM +0800, Hongtao Wu wrote:
> On Thu, Jan 14, 2021 at 4:52 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jan 14, 2021 at 04:29:28PM +0800, Hongtao Wu wrote:
> > > From: Hongtao Wu <billows.wu@unisoc.com>
> > >
> > > This series adds PCIe controller driver for Unisoc SoCs.
> > > This controller is based on DesignWare PCIe IP.
> > >
> > > Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig     |  12 ++
> > >  drivers/pci/controller/dwc/Makefile    |   1 +
> > >  drivers/pci/controller/dwc/pcie-sprd.c | 293 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 306 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-sprd.c
> >
> > <...>
> >
> > > +static struct platform_driver sprd_pcie_driver = {
> > > +     .probe = sprd_pcie_probe,
> > > +     .remove = __exit_p(sprd_pcie_remove),
> >                    ^^^^^^ why is that?
> >
>
> Thanks for the review.
>
> I think that if 'MODULE' is defined, '.remove = sprd_pcie_remove',
> else '.remove = NULL'.
> I would appreciate hearing your opinion about this.

If module not defined, these .probe and .remove won't be called.

>
> > > +     .driver = {
> > > +             .name = "sprd-pcie",
> > > +             .of_match_table = sprd_pcie_of_match,
> > > +     },
> > > +};
> > > +
> > > +module_platform_driver(sprd_pcie_driver);
> > > +
> > > +MODULE_DESCRIPTION("Unisoc PCIe host controller driver");
> > > +MODULE_LICENSE("GPL v2");
> >
> > I think that it needs to be "GPL" and not "GPL v2".
> >
>
> Many platform drivers use 'GPL v2', but others use 'GPL'.
> I am not sure whether to use 'GPL' or 'GPL v2'.
> Could you tell me why ‘GPL’ is needed here?

Because GPL already means v2, see Documentation/process/license-rules.rst

  447
  448     "GPL v2"                      Same as "GPL". It exists for historic
  449                                   reasons.


>
> > Thanks
> >
> > > --
> > > 2.7.4
> > >
