Return-Path: <linux-pci+bounces-16341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0B9C2229
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 17:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7971C2428D
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A655B1FB;
	Fri,  8 Nov 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv9ltHn0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266C11BD9DB;
	Fri,  8 Nov 2024 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083620; cv=none; b=QovavDLXiXKE2mVM5zvl87z63WLtfQKWZtJMX5AMoPppkNMjSeocHQpFmazwwzy86R8sV3lJ7MFPYrfJPiZv0G9EBVcmxs4aRne/kNCcpmSSCN+5FRMmo46a5Xbz+cMIjrTTkFlhBmIadyyRhU0Gglsmg7VzYWBfXtvQ3bomhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083620; c=relaxed/simple;
	bh=Xy9SXkJxDKG4wi0f9Sva0OdceC+je7kXOaR1Fvhuk4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZaMwaPu/9JcGl4PBrq4ncsWAGSiu4/pwnDWQDs5DVFBAfTsDLiohRNNt6pdgu6OKdlB1dNq0PjTFU6KmX6N831MqJox8gYFUABR1EmMo7ffcEQKI+uv3Ecu+zryrXGP6BVlgyp0TcjAMiL+9MWljutSI6ADDtzviS/mrxeLuxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv9ltHn0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87664C4CED3;
	Fri,  8 Nov 2024 16:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731083619;
	bh=Xy9SXkJxDKG4wi0f9Sva0OdceC+je7kXOaR1Fvhuk4Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lv9ltHn0wFgSpHXb8kslpVm8PArdkSIuQuJE5snpS1yI2IVOWksdVjn8nUo7aykjq
	 VF3j8ToVG0p5CUcoMmdui72l9m+UABLLU+2fviSDfOQwzw5La16QIau1UGD1TpY+4m
	 Wpgfwsi2SUAzEOunb8IhHZWjJIgl9vK6FWbxUZVcMGXhWZOD2FFiNqROABA2M8BsdU
	 J/bByy2pPBtM+wRvtPfQkEjUNJ9VdOlrD/PdgKJiBhCPEc1AJnHa9yeTVQbni7lfhR
	 BWx5efRqQx6QPf/CAKmr07g17TCcFAyzUDRXIa7NPlqjO3g5NUbd9/6zcb01tNejWM
	 nV2w2n4JvRklQ==
Date: Fri, 8 Nov 2024 10:33:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hui Ma =?utf-8?B?KOmprOaFpyk=?= <Hui.Ma@airoha.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"nbd@nbd.name" <nbd@nbd.name>, "dd@embedd.com" <dd@embedd.com>,
	upstream <upstream@airoha.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v4 4/4] PCI:
 mediatek-gen3: Add Airoha EN7581 support
Message-ID: <20241108163338.GA1663274@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR03MB6350EF22DE289B293D34FD6FFF5D2@KL1PR03MB6350.apcprd03.prod.outlook.com>

On Fri, Nov 08, 2024 at 01:23:35AM +0000, Hui Ma (马慧) wrote:
> > On Thu, Nov 07, 2024 at 05:21:45PM +0100, Lorenzo Bianconi wrote:
> > > On Nov 07, Bjorn Helgaas wrote:
> > > > On Thu, Nov 07, 2024 at 08:39:43AM +0100, Lorenzo Bianconi wrote:
> > > > > > On Wed, Nov 06, 2024 at 11:40:28PM +0100, Lorenzo Bianconi wrote:
> > > > > > > > On Wed, Jul 03, 2024 at 06:12:44PM +0200, Lorenzo Bianconi wrote:
> > > > > > > > > Introduce support for Airoha EN7581 PCIe controller to 
> > > > > > > > > mediatek-gen3 PCIe controller driver.
> > > > > > > > > ...
> > > > 
> > > > > > > > Is this where PERST# is asserted?  If so, a comment to 
> > > > > > > > that effect would be helpful.  Where is PERST# deasserted?  
> > > > > > > > Where are the required delays before deassert done?
> > > > > > > 
> > > > > > > I can add a comment in en7581_pci_enable() describing the 
> > > > > > > PERST issue for EN7581. Please note we have a 250ms delay in 
> > > > > > > en7581_pci_enable() after configuring REG_PCI_CONTROL register.
> > > > > > > 
> > > > > > > https://github.com/torvalds/linux/blob/master/drivers/clk/cl
> > > > > > > k-en7523.c#L396
> > > > > > 
> > > > > > Does that 250ms delay correspond to a PCIe mandatory delay, 
> > > > > > e.g., something like PCIE_T_PVPERL_MS?  I think it would be 
> > > > > > nice to have the required PCI delays in this driver if 
> > > > > > possible so it's easy to verify that they are all covered.
> > > > > 
> > > > > IIRC I just used the delay value used in the vendor sdk. I
> > > > > do not have a strong opinion about it but I guess if we move
> > > > > it in the pcie-mediatek-gen3 driver, we will need to add it
> > > > > in each driver where this clock is used. What do you think?
> > > > 
> > > > I don't know what the 250ms delay is for.  If it is for a required 
> > > > PCI delay, we should use the relevant standard #define for it, and 
> > > > it should be in the PCI controller driver.  Otherwise it's 
> > > > impossible to verify that all the drivers are doing the correct delays.
> > > 
> > > ack, fine to me. Do you prefer to keep 250ms after 
> > > clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up() or just use PCIE_T_PVPERL_MS (100)?
> > > I can check if 100ms works properly.
> > 
> > It's not clear to me where the relevant events are for these chips.
> > 
> > Do you have access to the PCIe CEM spec?  The diagram in r6.0, sec 
> > 2.2.1, is helpful.  It shows the required timings for Power Stable, 
> > REFCLK Stable, PERST# deassert, etc.
> > 
> > Per sec 2.11.2, PERST# must be asserted for at least 100us (T_PERST), 
> > PERST# must be asserted for at least 100ms after Power Stable 
> > (T_PVPERL), and PERST# must be asserted for at least 100us after 
> > REFCLK Stable.
> > 
> > It would be helpful if we could tell by reading the source where some 
> > of these critical events happen, and that the relevant delays are 
> > there.  For example, if PERST# is asserted/deasserted by 
> > "clk_enable()" or similar, it's not at all obvious from the code, so 
> > we should have a comment to that effect.
> 
> >I reviewed the vendor sdk and it just do something like in clk_enable():
> >
> >	...
> >	val = readl(0x88);
> >	writel(val | BIT(16) | BIT(29) | BIT(26), 0x88);
> >	/*wait link up*/
> >	mdelay(1000);
> >	...
> >
> >@Hui.Ma: is it fine use msleep(100) (so PCIE_T_PVPERL_MS) instead
> >of msleep(1000) (so PCIE_LINK_RETRAIN_TIMEOUT_MS)?
>
> 	I think msleep(1000) will be safer, because some device won't
> 	link up with msleep(100).

Do you have details about this?  I guess it only hurts mediatek, but
increasing the minimum time to bring up a PCI hierarchy by almost an
entire second is a pretty big deal.

If this delay corresponds to the required T_PVPERL delay and 100ms
isn't enough for some endpoints, those endpoints should fail with many
host controllers, not just mediatek, so I would suspect the mediatek
controller or a certain platform, not the endpoint itself.

If this corresponds to T_PVPERL and mediatek needs longer, I would
document that by using "PCIE_T_PVPERL_MS * 10" and adding a comment
about why (affected platform/device, hardware erratum, etc).

Bottom line, I don't really care what the value is, but I *would* like
to be able to read pcie-mediatek-gen3.c and see the point where PCI
power is stable, a delay of at least T_PVPERL, and where PERST# is
deasserted because that's the main timing requirement on software.

Bjorn

