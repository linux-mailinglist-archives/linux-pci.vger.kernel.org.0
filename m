Return-Path: <linux-pci+bounces-31289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B37AF5E63
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A147A95DD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381EF267B12;
	Wed,  2 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVtVzbC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137681E51EA
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751473067; cv=none; b=tUP0e1ax+o1ffLHo+EzG1H1w+srZl0Xwd9sJ4ZLauy+53ww+e6ZKSCFQM4uAGslQDkcf7Q2l3klGNFIZnyElvf4h5WLEv46C8FTjdPDlAmUcKJp25DJeH98YXXlqZzTGUa1jppqR74z57jLdeiKPnT8SLthzNhCV8SXY2O0zWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751473067; c=relaxed/simple;
	bh=d+uZw9ZRVA/NPSRFkuvtvCBvmU/EM0uLirz8kl0PO8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfzJZ/4mFehHZS/yeKzXPlFVVbUf97jru3233iGkwR/iNmDMLCDOPIf8VCfo36DY/s4YUll+TU26U9t4Gx9H4tD2AV2bqYVNlpmClOXLDTOmTn2jPqYxlxutlTVWKLqgy3mXq/FACCHsIPX3Dh9/zgKxMWX+vyXM64a/daaTcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVtVzbC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D298C4CEE7;
	Wed,  2 Jul 2025 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751473066;
	bh=d+uZw9ZRVA/NPSRFkuvtvCBvmU/EM0uLirz8kl0PO8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KVtVzbC5zhNdPBWwiDeeuMb0sVSJC5ybEHDmtyQThgT02QObRHoIdaGlnY0gnYXXt
	 65wsK3p3LOQUTYptwhUI8KwgeDYhMjaNnTNqXCB37UnF6gMzSUXRM/27szfasY+g3K
	 4Rw3GN2qFjz7vULiLK0u4J7X3LafafcgyrG8WTHgPOmtqwT9ZrE8YBHp+jt9566IK4
	 AJlNQYa/DEEd6LjBccLFwmU73ilRE+tJpVuu8d3+E8fEdLCJjFhLFS/34qAqNPbJyZ
	 aP3JeQPE9wVbM16i15epZKSgK8OTsqT4Nl24Ze2+RakhV3vfrvWS0xsPs1Z/P0lmoF
	 ARFJnD2OMcO3g==
Date: Wed, 2 Jul 2025 18:17:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 5/7] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <aGVbpTZZmYyKIffk@ryzen>
References: <hcjcvo4sokncindwqhhmsx5g25ovj5n5zghemeujw7f4kqiaia@hbefzblsrhqx>
 <20250701163844.GA1836602@bhelgaas>
 <aGT_L_hglVBP6yzB@ryzen>
 <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hhyxhxvohmeqzjdu3amabcpf3e4ufi4ps5xd2uia4ea6i2u5oj@sxyjavqyqc7m>

Hello Mani,

On Wed, Jul 02, 2025 at 08:17:44PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 11:43:11AM GMT, Niklas Cassel wrote:
> > However, my main concern is not that qcom waits twice, it is those drivers
> > that do not have a 100 ms delay after PERST# has been deasserted, because
> > before commit 470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS"), those
> > drivers might have been "saved" by the ridiculously long
> > PCIE_LINK_WAIT_SLEEP_MS.
> > 
> > However, now when we sleep less in each iteration when polling for link up,
> > those drivers that do not have a 100 ms delay after PERST# has been
> > deasserted might actually see regressions, because (the now reduced)
> > PCIE_LINK_WAIT_SLEEP_MS time is no longer "saving" them.
>
> 
> Why can't you just add the delay to those drivers now? They can be consolidated
> later.

Right now, I don't have the extra cycles needed to read all of these
drivers:

$ git grep -l gpio drivers/pci/controller/dwc/
drivers/pci/controller/dwc/pci-dra7xx.c
drivers/pci/controller/dwc/pci-imx6.c
drivers/pci/controller/dwc/pci-keystone.c
drivers/pci/controller/dwc/pci-meson.c
drivers/pci/controller/dwc/pcie-amd-mdb.c
drivers/pci/controller/dwc/pcie-bt1.c
drivers/pci/controller/dwc/pcie-designware-plat.c
drivers/pci/controller/dwc/pcie-designware.c
drivers/pci/controller/dwc/pcie-designware.h
drivers/pci/controller/dwc/pcie-dw-rockchip.c
drivers/pci/controller/dwc/pcie-fu740.c
drivers/pci/controller/dwc/pcie-histb.c
drivers/pci/controller/dwc/pcie-intel-gw.c
drivers/pci/controller/dwc/pcie-keembay.c
drivers/pci/controller/dwc/pcie-kirin.c
drivers/pci/controller/dwc/pcie-qcom-ep.c
drivers/pci/controller/dwc/pcie-qcom.c
drivers/pci/controller/dwc/pcie-rcar-gen4.c
drivers/pci/controller/dwc/pcie-tegra194.c
drivers/pci/controller/dwc/pcie-visconti.c

then understanding them properly to feel that I am confident in my changes,
waiting for reviews from each glue driver maintainer, and then waiting for
someone to pick it up.

Also, all of the above has to be done when consolidating the PERST#
handling anyway.



This whole thing started because someone reported a regression on a random
Plextor NVMe drive. Since it was my commit ec9fd499b9c6 ("PCI: dw-rockchip:
Don't wait for link since we can detect Link Up") that introduced the
regression, I obviously helped debugging the issue.

The regression was solved by adding a 100 ms delay after receiving the link
up IRQ, before enumerating the bus.

This fix was sent May 5th:
https://lore.kernel.org/linux-pci/20250505092603.286623-7-cassel@kernel.org/
(This series had up to v2, the series was then renamed and had up to v4,
so basically v6 in total.)

While my responsibility was done two months ago, I still wanted to make
sure that no one else got bit by the same bug, thus I also improved the
generic dw_pcie_wait_for_link() (for those drivers not using link up IRQ):
https://lore.kernel.org/linux-pci/20250625102347.1205584-14-cassel@kernel.org/

Sure, that will only help PCIe controllers that support Link speeds greater
than 5.0 GT/s, and do not use a link up IRQ, but still something.


PCIe controllers that only support Link speeds <= 5.0 GT/s, and do not use
a link up IRQ, and do not have a delay after deasserting PERST#, can still
send config requests too early.

However, if we drop 470f10f18b48 ("PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS"),
PCIe controllers that only support Link speeds <= 5.0 GT/s, and do not use
a link up IRQ, and do not have a delay after deasserting PERST#, will be no
worse off than what is already in mainline.

PCIe controllers that support Link speeds greater than 5.0 GT/s, and do not
use a link up IRQ, will still be more robust than ever :)
(Rome wasn't built in a day.)


Kind regards,
Niklas

