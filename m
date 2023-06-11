Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD872B20E
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jun 2023 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFKNYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Jun 2023 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKNY3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2023 09:24:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A7BC;
        Sun, 11 Jun 2023 06:24:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6FAC6125D;
        Sun, 11 Jun 2023 13:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4A6C433D2;
        Sun, 11 Jun 2023 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686489866;
        bh=g9njtkoojqRfUI49HT2MGfWzoAKuf1DOFdEq/kUvHsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DGC5PWnLkcdaGgKC8g7aXKlp+cTXW37FdG3MVsm8EY5hOfYkx9wU/GrdAySg2Oi3E
         dOVMl4KJhdYBu2De+eoiciAURQiPsCqJ9ietIqhfXZzIiJ/qHaNTEP+6cbbfGxU3OF
         S1V2x+n0xz8qtn3BiYOFuIupPFOSQz5yy55SQRQJKpTgLcEvlJGss24Pfra8lHGfqX
         flOVS0h/DWl7SNIHBe4o1Tckr5hlYu9wiNquAWD9glhB7l1BDGN6MfJfYQi4jaXF/p
         CbfeGdAXGcgQoXEiIlRZ2gExfM0ZoxVnZVNTIqcbZJpWvcddhXHRqZboEHi89XhF++
         jIjqIIdIQw+Hg==
Received: by pali.im (Postfix)
        id D08BB7FD; Sun, 11 Jun 2023 15:24:23 +0200 (CEST)
Date:   Sun, 11 Jun 2023 15:24:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Toan Le <toan@os.amperecomputing.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/15] PCI: Convert to platform remove callback returning
 void
Message-ID: <20230611132423.milnj2pnvjqzwino@pali>
References: <20230530140742.ebbrxmpieuphbmz3@pengutronix.de>
 <ZHphHkNLO4tEJIm/@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHphHkNLO4tEJIm/@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 02 June 2023 16:37:34 Bjorn Helgaas wrote:
> On Tue, May 30, 2023 at 04:07:42PM +0200, Uwe Kleine-König wrote:
> > Hello Bjorn,
> > 
> > On Tue, Mar 21, 2023 at 08:31:53PM +0100, Uwe Kleine-König wrote:
> > > this series adapts the platform drivers below drivers/pci to use the
> > > .remove_new() callback. Compared to the traditional .remove() callback
> > > .remove_new() returns no value. This is a good thing because the driver core
> > > doesn't (and cannot) cope for errors during remove. The only effect of a
> > > non-zero return value in .remove() is that the driver core emits a warning. The
> > > device is removed anyhow and an early return from .remove() usually yields a
> > > resource leak.
> > > 
> > > By changing the remove callback to return void driver authors cannot
> > > reasonably assume any more that there is some kind of cleanup later.
> > > 
> > > All drivers were easy to convert as they all returned zero in their
> > > remove callback. Only for iproc the conversion wasn't trivial, the other
> > > were converted using coccinelle.
> > > 
> > > There are no interdependencies between these patches. So even if there
> > > are some concerns for individual patches, I ask you to apply the
> > > remaining set. Then I only have to care for the review feedback of the
> > > refused patches. (Having said that I don't expect any serious objection,
> > > just things like squashing or separating patches, or maybe I picked a
> > > wrong subject prefix.)
> > 
> > These patches wait for application for quite some time now. They apply
> > just fine to v6.4-rc1 and next/master. Would be great to get them in
> > during the next merge window and ideally give them some time in next
> > before.
> 
> Thanks, these seem fine to me, and Lorenzo normally takes care of
> drivers/pci/controller/.  Lorenzo, if it's easier to have me apply
> them, that's fine, too, just let me know.
> 
> The only tweaks I would make would be:
> 
>   PCI: j721e: Convert to platform remove callback returning void
>   PCI: dwc: Convert to platform remove callback returning void
> 
> to match the git history.

Hello Bjorn, it should be expected that other changes for PCIe drivers
sent by other people which were sent to the list before this patch
series and are still waiting for the review (because are without
comments), would be processed before and patches sent later.

Also I would like to point out that in past I have sent fixes for PCIe
mvebu driver, which is currently in the broken state. And this is also
on waiting on the list.
