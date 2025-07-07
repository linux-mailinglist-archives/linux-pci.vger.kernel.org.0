Return-Path: <linux-pci+bounces-31603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C246AFAD91
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833EC3A6B06
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 07:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007D1A0BF1;
	Mon,  7 Jul 2025 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0DpGCbt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C77E792
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751874537; cv=none; b=IuwFSTAx4W2t5557/KAixyv40HO5MfSix/y00mH/z39o/y8XNbJhvCkVL034D5ZqK3xLk1dveWBt5nCUxibM5kyW7nDjuGNC8Ru2RNOM+P9lLJM71PAWOBBPWti/kmYBQ6ogQSGfHIpr9jbtNXaF4I9amBeoFtCLlsDK9F3A7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751874537; c=relaxed/simple;
	bh=METOKjThibVWrKUbol8laS0fVDvw6srdG7X7xwYqTK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmr6klEPaxfTCX2q4efbukf1ledAprfsnTBpdyyK4JQQ7N+C5ji/D0piaSgxuKTAgJckb31SMB2iFb64nnI2ZEMJ4i+7a/figzZYkaqLd7Q6o0gTd2f7O+okht0ruZIkiSFyZ15aHzlYHM4PmJa8Kbzix6vz2YEXOlmkWAmWDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0DpGCbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E27C4CEE3;
	Mon,  7 Jul 2025 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751874537;
	bh=METOKjThibVWrKUbol8laS0fVDvw6srdG7X7xwYqTK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0DpGCbtSnBkDE5JWGaPKldlnRwlD70a9sOwuqzWc/ztg5ucoV8Le40IA8LoIVVpy
	 p65PGKHus/L+a/NBzvvp0QPO3g6ZhFwHbvWa0Jq0xtCn0vB4vHSyaQWI4in53JmCpN
	 WqIjInMRud59C/IGGKcBwxSIpl82PJKI8iXAZXYck4n6EzvfKJHmsockrCvRD2xHkG
	 //aTGcOrJjlEPLw6WGWHgC8B3pGb/1q9MBrP1d29DxLvsvog4z6jwIMpgusBO0UeP1
	 VuwYbfduILptW45uCAdzdlv7/EuvJjaTrsIWewCYAl/mA5i28Aq+zgBGjdcICCPGlk
	 Kk0h9LVfkLDQA==
Date: Mon, 7 Jul 2025 13:18:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <2ahvqexaof3cx6fjk3aesav5ptzqwnyicyq6w2gcaqlqaucmg5@6iovzdssfp2r>
References: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
 <20250701163844.GA1836602@bhelgaas>
 <aGT_L_hglVBP6yzB@ryzen>
 <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>
 <aGVbpTZZmYyKIffk@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGVbpTZZmYyKIffk@ryzen>

On Wed, Jul 02, 2025 at 06:17:41PM GMT, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Jul 02, 2025 at 08:17:44PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jul 02, 2025 at 11:43:11AM GMT, Niklas Cassel wrote:
> > > However, my main concern is not that qcom waits twice, it is those drivers
> > > that do not have a 100 ms delay after PERST# has been deasserted, because
> > > before commit 470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS"), those
> > > drivers might have been "saved" by the ridiculously long
> > > PCIE_LINK_WAIT_SLEEP_MS.
> > > 
> > > However, now when we sleep less in each iteration when polling for link up,
> > > those drivers that do not have a 100 ms delay after PERST# has been
> > > deasserted might actually see regressions, because (the now reduced)
> > > PCIE_LINK_WAIT_SLEEP_MS time is no longer "saving" them.
> >
> > 
> > Why can't you just add the delay to those drivers now? They can be consolidated
> > later.
> 
> Right now, I don't have the extra cycles needed to read all of these
> drivers:
> 
> $ git grep -l gpio drivers/pci/controller/dwc/
> drivers/pci/controller/dwc/pci-dra7xx.c
> drivers/pci/controller/dwc/pci-imx6.c
> drivers/pci/controller/dwc/pci-keystone.c
> drivers/pci/controller/dwc/pci-meson.c
> drivers/pci/controller/dwc/pcie-amd-mdb.c
> drivers/pci/controller/dwc/pcie-bt1.c
> drivers/pci/controller/dwc/pcie-designware-plat.c
> drivers/pci/controller/dwc/pcie-designware.c
> drivers/pci/controller/dwc/pcie-designware.h
> drivers/pci/controller/dwc/pcie-dw-rockchip.c
> drivers/pci/controller/dwc/pcie-fu740.c
> drivers/pci/controller/dwc/pcie-histb.c
> drivers/pci/controller/dwc/pcie-intel-gw.c
> drivers/pci/controller/dwc/pcie-keembay.c
> drivers/pci/controller/dwc/pcie-kirin.c
> drivers/pci/controller/dwc/pcie-qcom-ep.c
> drivers/pci/controller/dwc/pcie-qcom.c
> drivers/pci/controller/dwc/pcie-rcar-gen4.c
> drivers/pci/controller/dwc/pcie-tegra194.c
> drivers/pci/controller/dwc/pcie-visconti.c
> 
> then understanding them properly to feel that I am confident in my changes,
> waiting for reviews from each glue driver maintainer, and then waiting for
> someone to pick it up.
> 
> Also, all of the above has to be done when consolidating the PERST#
> handling anyway.
> 
> 
> 
> This whole thing started because someone reported a regression on a random
> Plextor NVMe drive. Since it was my commit ec9fd499b9c6 ("PCI: dw-rockchip:
> Don't wait for link since we can detect Link Up") that introduced the
> regression, I obviously helped debugging the issue.
> 
> The regression was solved by adding a 100 ms delay after receiving the link
> up IRQ, before enumerating the bus.
> 
> This fix was sent May 5th:
> https://lore.kernel.org/linux-pci/20250505092603.286623-7-cassel@kernel.org/
> (This series had up to v2, the series was then renamed and had up to v4,
> so basically v6 in total.)
> 
> While my responsibility was done two months ago, I still wanted to make
> sure that no one else got bit by the same bug, thus I also improved the
> generic dw_pcie_wait_for_link() (for those drivers not using link up IRQ):
> https://lore.kernel.org/linux-pci/20250625102347.1205584-14-cassel@kernel.org/
> 
> Sure, that will only help PCIe controllers that support Link speeds greater
> than 5.0 GT/s, and do not use a link up IRQ, but still something.
> 
> 
> PCIe controllers that only support Link speeds <= 5.0 GT/s, and do not use
> a link up IRQ, and do not have a delay after deasserting PERST#, can still
> send config requests too early.
> 
> However, if we drop 470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS"),
> PCIe controllers that only support Link speeds <= 5.0 GT/s, and do not use
> a link up IRQ, and do not have a delay after deasserting PERST#, will be no
> worse off than what is already in mainline.
> 
> PCIe controllers that support Link speeds greater than 5.0 GT/s, and do not
> use a link up IRQ, will still be more robust than ever :)
> (Rome wasn't built in a day.)
> 

Sounds fair! I've now dropped 470f10f18b48 from controller/linkup-fix branch.

Do you have cycles for consolidating PERST# handling?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

