Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF60100B3E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 19:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfKRSPp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 13:15:45 -0500
Received: from foss.arm.com ([217.140.110.172]:38290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfKRSPp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 13:15:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C48A41FB;
        Mon, 18 Nov 2019 10:15:44 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49A283F703;
        Mon, 18 Nov 2019 10:15:43 -0800 (PST)
Date:   Mon, 18 Nov 2019 18:15:38 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, shawn.lin@rock-chips.com,
        andrew.murray@arm.com, heiko@sntech.de, lgirdwood@gmail.com,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: rockchip: Simplify optional regulator handling
Message-ID: <20191118181538.GA2261@e121166-lin.cambridge.arm.com>
References: <20191118115930.GC9761@sirena.org.uk>
 <20191118142428.GA27459@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118142428.GA27459@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 08:24:28AM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 18, 2019 at 11:59:30AM +0000, Mark Brown wrote:
> > On Sat, Nov 16, 2019 at 12:54:20PM +0000, Robin Murphy wrote:
> > > Null checks are both cheaper and more readable than having !IS_ERR()
> > > splattered everywhere.
> > 
> > > -	if (IS_ERR(rockchip->vpcie3v3))
> > > +	if (!rockchip->vpcie3v3)
> > >  		return;
> > >  
> > >  	/*
> > > @@ -611,6 +611,7 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
> > >  		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> > >  			return PTR_ERR(rockchip->vpcie12v);
> > >  		dev_info(dev, "no vpcie12v regulator found\n");
> > > +		rockchip->vpcie12v = NULL;
> > 
> > According to the API NULL is a valid regulator.  We don't currently
> > actually do this but it's storing up surprises if you treat it as
> > invalid.
> 
> I don't know anything about the regulator API, but the fact that NULL
> can be a valid regulator is itself a little surprising :)

if (rockchip->vpcie3v3 == NULL) is true the driver would currently
panic the kernel AFAICS.

rockchip_pcie_set_power_limit()
->regulator_get_current_limit(NULL)
 -> _regulator_get_current_limit(NULL)
   -> regulator_lock(NULL)
     -> regulator_lock_nested(NULL, NULL)
       -> ww_mutex_trylock(&NULL->mutex)

Also, by making NULL a valid regulator, it means that regulators
(ie pointers) with default values are valid whether we call
devm_regulator_get* or not. I understand this patch can be dropped
but that per-se does not make this driver code any more robust AFAICS.

Lorenzo
