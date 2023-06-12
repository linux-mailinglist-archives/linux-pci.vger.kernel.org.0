Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15A72CDB3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjFLSRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFLSRc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 14:17:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8693;
        Mon, 12 Jun 2023 11:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1F2662CAE;
        Mon, 12 Jun 2023 18:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08B2C433EF;
        Mon, 12 Jun 2023 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686593850;
        bh=aIVis3zgOCngnfMmwgBuVeG+/iKrmnOowlmIUV+paHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n5n/9orbod8cmo3ZlSZq+q3v9s1JEnf2Sa4uJLUMrgOII1qaquSOhuepHl3fIUF2n
         +dncfZDS6aLE7N8e/fDxJJes4MFT7sS240EjejOXi0oHxsUrf8fhC1jiWKkOPIjQbW
         newqIPRW6XIZzq8JySqv1eMuk1ZeGSksIt+JaOAbFd2NJ+vHD9K4BQR1vcHQjvyOFY
         yojO9w2pWRuJXETvSoPOoKqIYvGSs3gAnEmbky9i+u83nxU9v8UtiLImEDmvnb31Ue
         Io4TaH78Rz41ZMfnyO1IAijddSeTN0ZEvAZjX/feIO4kwYYP+zSxf7KmDUznHkciU+
         MeB6+M43iQovA==
Received: by pali.im (Postfix)
        id A820E7EB; Mon, 12 Jun 2023 20:17:26 +0200 (CEST)
Date:   Mon, 12 Jun 2023 20:17:26 +0200
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
Message-ID: <20230612181726.itcctpkq57tfmdmo@pali>
References: <20230611132423.milnj2pnvjqzwino@pali>
 <20230612161927.GA1335109@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612161927.GA1335109@bhelgaas>
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

On Monday 12 June 2023 11:19:27 Bjorn Helgaas wrote:
> On Sun, Jun 11, 2023 at 03:24:23PM +0200, Pali Rohár wrote:
> > On Friday 02 June 2023 16:37:34 Bjorn Helgaas wrote:
> > > On Tue, May 30, 2023 at 04:07:42PM +0200, Uwe Kleine-König wrote:
> > > > On Tue, Mar 21, 2023 at 08:31:53PM +0100, Uwe Kleine-König wrote:
> > > > > this series adapts the platform drivers below drivers/pci to
> > > > > use the .remove_new() callback. Compared to the traditional
> > > > > .remove() callback .remove_new() returns no value. This is a
> > > > > good thing because the driver core doesn't (and cannot) cope
> > > > > for errors during remove. The only effect of a non-zero return
> > > > > value in .remove() is that the driver core emits a warning.
> > > > > The device is removed anyhow and an early return from
> > > > > .remove() usually yields a resource leak.
> > ...
> 
> > Hello Bjorn, it should be expected that other changes for PCIe drivers
> > sent by other people which were sent to the list before this patch
> > series and are still waiting for the review (because are without
> > comments), would be processed before and patches sent later.
> 
> I don't think it's necessary to delay simple, easily-reviewed changes
> behind more complicated ones.
> 
> > Also I would like to point out that in past I have sent fixes for PCIe
> > mvebu driver, which is currently in the broken state. And this is also
> > on waiting on the list.
> 
> Thanks for this reminder.  Would you mind reposting them?  I poked
> around in patchwork and I must be doing something wrong because I
> can't find *any* patches from you, though obviously there are many.
> 
> If you repost them at least we'll know unambiguously what is on the
> table.
> 
> Bjorn

Well, my patches I reposted more times. And some were also reposted by
other people. I do not know if they are in patchwork, but they are in
email archive. For example last repost of aardvark patches are here:
https://lore.kernel.org/linux-pci/20220927141926.8895-1-kabel@kernel.org/
And some other aardvark are also here:
https://lore.kernel.org/linux-pci/20220711120626.11492-1-pali@kernel.org/
