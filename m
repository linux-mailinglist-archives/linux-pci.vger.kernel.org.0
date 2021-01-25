Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819C7303569
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 06:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbhAZFku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 00:40:50 -0500
Received: from foss.arm.com ([217.140.110.172]:51616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbhAYQvo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jan 2021 11:51:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18AD511FB;
        Mon, 25 Jan 2021 08:50:48 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 874043F68F;
        Mon, 25 Jan 2021 08:50:46 -0800 (PST)
Date:   Mon, 25 Jan 2021 16:50:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
Message-ID: <20210125165041.GA5979@e121166-lin.cambridge.arm.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e35b90e173b15870a859fd7001a712@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 08:28:36PM +0100, Michael Walle wrote:
> [RESEND, fat-fingered the buttons of my mail client and converted
> all CCs to BCCs :(]
> 
> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > > 
> > > On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > > wrote:
> > > >
> > > > fw_devlink will defer the probe until all suppliers are ready. We can't
> > > > use builtin_platform_driver_probe() because it doesn't retry after probe
> > > > deferral. Convert it to builtin_platform_driver().
> > > 
> > > If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > > shouldn't it be fixed or removed?
> > 
> > I was actually thinking about this too. The problem with fixing
> > builtin_platform_driver_probe() to behave like
> > builtin_platform_driver() is that these probe functions could be
> > marked with __init. But there are also only 20 instances of
> > builtin_platform_driver_probe() in the kernel:
> > $ git grep ^builtin_platform_driver_probe | wc -l
> > 20
> > 
> > So it might be easier to just fix them to not use
> > builtin_platform_driver_probe().
> > 
> > Michael,
> > 
> > Any chance you'd be willing to help me by converting all these to
> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> 
> If it just moving the probe function to the _driver struct and
> remove the __init annotations. I could look into that.

Can I drop this patch then ?

Thanks,
Lorenzo
