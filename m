Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04841005BF
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 13:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKRMjz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 07:39:55 -0500
Received: from foss.arm.com ([217.140.110.172]:33962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRMjz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 07:39:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EB901FB;
        Mon, 18 Nov 2019 04:39:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE583F6C4;
        Mon, 18 Nov 2019 04:39:53 -0800 (PST)
Date:   Mon, 18 Nov 2019 12:39:51 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>, shawn.lin@rock-chips.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, heiko@sntech.de,
        lgirdwood@gmail.com, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: rockchip: Simplify optional regulator handling
Message-ID: <20191118123951.GM43905@e119886-lin.cambridge.arm.com>
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
 <347bc3ef8399577e4cef3fdbf3af34d20b4ad27e.1573908530.git.robin.murphy@arm.com>
 <20191118115930.GC9761@sirena.org.uk>
 <a59da4a4-de88-62a5-5f44-001f8e30221e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59da4a4-de88-62a5-5f44-001f8e30221e@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 12:20:10PM +0000, Robin Murphy wrote:
> On 18/11/2019 11:59 am, Mark Brown wrote:
> > On Sat, Nov 16, 2019 at 12:54:20PM +0000, Robin Murphy wrote:
> > > Null checks are both cheaper and more readable than having !IS_ERR()
> > > splattered everywhere.
> > 
> > > -	if (IS_ERR(rockchip->vpcie3v3))
> > > +	if (!rockchip->vpcie3v3)
> > >   		return;
> > >   	/*
> > > @@ -611,6 +611,7 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
> > >   		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> > >   			return PTR_ERR(rockchip->vpcie12v);
> > >   		dev_info(dev, "no vpcie12v regulator found\n");
> > > +		rockchip->vpcie12v = NULL;
> > 
> > According to the API NULL is a valid regulator.  We don't currently
> > actually do this but it's storing up surprises if you treat it as
> > invalid.
> 
> Ah, OK - I'd assumed NULL wasn't valid based on regulator_enable()
> immediately dereferencing its argument without any checks. If we'd rather
> not bake in that assumption then this patch can happily be ignored.

I'd suggest we drop this patch.

"IS_ERR(ptr)" is not the same as "!ptr", for values of ptr between 0 and
-4095 inclusive.

Regardless the effect of this patch with the regulator framework, I don't
think we want to create an example that others may follow.

Thanks,

Andrew Murray

> 
> Thanks,
> Robin.
