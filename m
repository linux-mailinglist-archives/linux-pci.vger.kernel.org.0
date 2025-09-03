Return-Path: <linux-pci+bounces-35383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EDB4214F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3765680BE
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71FB301025;
	Wed,  3 Sep 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnRrxS0J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6072F7449;
	Wed,  3 Sep 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905683; cv=none; b=friwGBT28w5r1o57QfT2JpQEBmU69iociYSVIiPSYLlBh7/CZ8bPKNjwQ+O/YgqOUFwYllVmq6BTWQHGh/5XTCaFczgHZwgS6juo2H/JRHGxcVlxBZabm/MBoFTckSmjzuT+70yz2WXHJtLSukQQ3Qp2J5esruym5H1U1onhQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905683; c=relaxed/simple;
	bh=lBZol3zBpE9PLURdaNvaImTKk9Qw5lA3TBKTVi4cHhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSZ+6whA9eNl2xVq85DyKpMIt+yI+paGsERb91crBlpNqlql6OoMBkDOjNPlHm6T5c4/7dxQ7nQgmFpigm/OqXtT9bSdxmXiF3NVTxYLeA9nwn+Tq/kk5T5jy8JA1rpMmeMR2vIe1VU+VuTOqpfA5KY/P5UNMtch5ZgOaaJbJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnRrxS0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C89C4CEF0;
	Wed,  3 Sep 2025 13:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756905683;
	bh=lBZol3zBpE9PLURdaNvaImTKk9Qw5lA3TBKTVi4cHhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BnRrxS0Jw0KWz4Vhi0qzEoQdScbrpFv0Tv0DbeulUAa0+/CM3cfCRiifWOJb2Qkv5
	 p5g7m85ViSnSKw0b12Ci1Nbgpt7C4K2keLr5ulinYAnVcAuJ8KqMWisiULe1hvuKMS
	 OCjUVbnpCiVOGwQF3hejsvTlwrV7pNBWIppU1CJH2wy+nm+KasxAClb3gbp3w3XAZ1
	 JI43v2rSwwBt3tknYO2acreeqKbJ10G7f3176exCOMt4N7RsC/zz8366Hp0ZnCIrMI
	 EpSLpEi57i56aZHoesr2K8ErO9PacVQCXhgYHlCAr0Xyvj6Q//YsEQmscItIcSM/1Y
	 tpIrrRCxoFyFA==
Date: Wed, 3 Sep 2025 18:51:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, helgaas@kernel.org, kishon@kernel.org, vigneshr@ti.com, 
	stable@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v3] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <whinfqhjgqbbvlnuzgbukklqi6gocjji4gakqyycovrse4qq6s@6xq5imqbzvux>
References: <20250829091707.2990211-1-s-vadapalli@ti.com>
 <oztilfun77apxtjxumx4tydkcd2gsalsak4m2rvsry2oooqjna@2yvcx6cnuemm>
 <b2fb9252-6bfc-45da-973a-31cdfcc86b3d@ti.com>
 <z3ubracmtlq23yicbrhqjgnzrfoqheffm6cvhfnawlvbu4cmmp@ddu2o7xhw5tz>
 <48e9d897-2cd3-48ef-b46a-635ae75f5ac6@ti.com>
 <3wc3t6y5gzzspgfeklsqo3bupfp6gsfy6mls6t66hflcqlqsfk@cu26wv3sow4y>
 <9d2bba15-52e4-432a-8f7f-a0f5d7c2e4ad@ti.com>
 <7hxdcjm7evlphkldct7seytno4is7rjkx5vquvtfhpdkzxdhu6@yocrjgzciwu3>
 <08b87b5f-838b-4f40-ae90-10ded134356e@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08b87b5f-838b-4f40-ae90-10ded134356e@ti.com>

On Tue, Sep 02, 2025 at 10:34:51AM GMT, Siddharth Vadapalli wrote:
> On Mon, Sep 01, 2025 at 08:15:24PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Sep 01, 2025 at 04:50:02PM GMT, Siddharth Vadapalli wrote:
> > > On Mon, Sep 01, 2025 at 12:14:51PM +0530, Manivannan Sadhasivam wrote:
> > > > On Mon, Sep 01, 2025 at 11:51:33AM GMT, Siddharth Vadapalli wrote:
> 
> [...]
> 
> > > > > 
> > > > > If I understand correctly, are you suggesting the following?
> > > > > 
> > > > > j721e_pcie_probe()
> > > > > 	pm_runtime_set_active()
> > > > > 	pm_runtime_enable()
> > > > > 	ret = j721e_pcie_ctrl_init(pcie);
> > > > > 		/*
> > > > > 		 * PCIe Controller should be powered off here, but is there
> > > > > 		 * a way to ensure that it has been powered off?
> > > > > 		 */
> > > > > 		=> Program the strap settings and return to
> > > > > 		j721e_pcie_probe()
> > > > > 	/* Power on the PCIe Controller now */
> > > > > 	ret = pm_runtime_get_sync(dev);
> > > > 
> > > > This pm_runtime_get_sync() should be part of j721e_pcie_ctrl_init() where you
> > > > do power off, program strap and power on.
> > > > 
> > > > This should not be part of probe() as by that time, controller is already
> > > > powered on. So pm_runtime_set_active() and pm_runtime_enable() should be enough
> > > > to convey the state of the device to PM core.
> > > 
> > > I have tried out the suggestion in the following manner:
> > > 
> > > 	j721e_pcie_probe()
> > > 		...
> > > 		pm_runtime_set_active(dev);
> > > 		pm_runtime_enable(dev);
> > > 		ret = j721e_pcie_ctrl_init(pcie);
> > > 			... within j721e_pcie_ctrl_init()
> > > 			ret = pm_runtime_put_sync(dev);
> > > 			/* Program Strap Settings */
> > > 			ret = pm_runtime_get_sync(dev);
> > > 			...
> > > 		...
> > > 		exit probe
> > > 
> > > Since a 'pm_runtime_get_sync()' hasn't yet been invoked prior to the
> > > section where 'pm_runtime_put_sync()' is invoked, it leads to a ref-count
> > > underflow error at runtime. Please let me know if I am missing
> > > something.
> > > 
> > 
> > Doh... At the start of probe(), device PM usage_count will be 0. So we cannot
> > decrement it without incrementing it.
> > 
> > Could you try below sequence?
> > 
> > 	probe()
> > 	...
> > 	pm_runtime_set_active()
> > 	pm_runtime_enable()
> > 	j721e_pcie_ctrl_init()
> > 		...
> > 		pm_runtime_get() /* Just increment usage_count */
> > 		pm_runtime_put_sync() /* ask PM core to turn off */
> > 		/* program strap setting */
> > 		pm_runtime_get_sync() /* ask PM core to turn on */
> > 		pm_runtime_put_noidle() /* balance the usage_count without
> > 						suspending the device */
> > 	...
> 
> The above sequence powers off the controller at the point in time that
> the strap settings are programmed. 'pm_runtime_get_sync()' is powering
> on the controller afterwards. However, the 'pm_runtime_put_noidle()'
> at the end is causing the controller to be powered off again leading to
> a crash. Removing 'pm_runtime_put_noidle()' results in a functional
> sequence.
> 
> Please consider the existing sequence prior to this patch:
> 
> probe()
> 	...
> 	pm_runtime_enable()
> 	pm_runtime_get_sync() => usage_count is 1
> 	...
> 	exit probe
> 
> With the suggested sequence above, we have:
> 
> probe()
> 	...
> 	pm_runtime_set_active()
> 	pm_runtime_enable()
> 	j721e_pcie_ctrl_init()
> 		...
> 		pm_runtime_get() => usage_count is 1
> 		pm_runtime_put_sync() => usage_count is 0
> 		/* Controller is powered off now */
> 		/* Strap settings are programmed */
> 		pm_runtime_get_sync() => usage_count is 1
> 		/* Controller is powered on now */
> 		pm_runtime_put_noidle() => usage_count is 0
> 		/* Controller is powered off in a while */
> 	...
> 	/* Crash is observed aroung this point before probe finishes */
> 
> Please let me know if the fix is to drop 'pm_runtime_put_noidle()'
> from the above sequence.
> 

I thought put_noidle() will just reduce the refcount and not invoke the
idle/suspend callbacks, but I seem to be wrong here.

Anyway, I guess we have no option here other than to drop the
pm_runtime_put_noidle() call. This will keep refcount as 1 and will prevent the
parent (genpd) to not enter runtime suspend, but we have to live with it (this
was also the previous beahvior as well).

Btw, pm_runtime_set_active/enable change belongs to a separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

