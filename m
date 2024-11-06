Return-Path: <linux-pci+bounces-16183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D89BFA83
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D3B1F22BB2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C336820E00A;
	Wed,  6 Nov 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJXoojrA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963171E04AC;
	Wed,  6 Nov 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937442; cv=none; b=sFp3WW8teyLe2JBuO+8yz76adzKkGzDsM0gnuRhJyDZwqXfirl/b7E4oryHEanjYr4z6Qy4D6XWtdJAcZsqigER5yyk3SGS0vV4gKiZ1XsuyvwEnayAX8ftq00xZxM2DNhz3YVqOWEoJSksrNzLFCHRDZslgAjTAwioYLygiGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937442; c=relaxed/simple;
	bh=DonF2tK19bktznYDKFtWKjb2A0DFq9+Zr6P6AntNTwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbnJshI/1ZZHc3q45Wm63t05sAjQeTEI9OdsrkNXEwjNhcpUAN/E3z9jcVPQ+4QllTI7Qzodi34Z4LKDvoh8XvAypfezcI2O3hknkSVI2LD83+DQDsj2OqGLGM5DMP2iaj3+r1XkqxRJZVdW7Nxsfl4350xiQUCby6If2LXQ/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJXoojrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A1C4CEC6;
	Wed,  6 Nov 2024 23:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730937442;
	bh=DonF2tK19bktznYDKFtWKjb2A0DFq9+Zr6P6AntNTwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJXoojrAHfDtNDjbnHxFOTC/qc4NT08zXBL0OK2PX5didTEGluMMZUhzwmj06YkWu
	 ZN5K6sNJTXYhcr0k03da080+Qe3NWw0iSeQ+XXnbN6l9M4MPTE5bRFnLF5kuwUGl7a
	 QEUKJ/3HkurqQNoAhuZDLm/MmQG/JHH5/EoLjPt6t8LfSX+HzAoyJINSSU2mDyPiWz
	 NUrcDOkmk5UPELqWtg0Lfr3PBtoVEN5V0EfZEzWfSdyLlCM9P20ujAjcaSAmwVo7Ti
	 o3s2YjS/OFKi5cYtvJqS9lUZEq6zc1gJgEmltf89JjPo7B9WsB7RsvBmSrTZtB6968
	 /+kTV1Uw3FwrQ==
Date: Thu, 7 Nov 2024 00:57:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v4 0/5] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <ZywCXOjuTTiayIxd@ryzen>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <Zyszr3Cqg8UXlbqw@ryzen>
 <Zys4qs-uHvISaaPB@ryzen>
 <ZyujpT+4bd7TwbcM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyujpT+4bd7TwbcM@lizhi-Precision-Tower-5810>

On Wed, Nov 06, 2024 at 12:13:09PM -0500, Frank Li wrote:
> On Wed, Nov 06, 2024 at 10:36:42AM +0100, Niklas Cassel wrote:
> > On Wed, Nov 06, 2024 at 10:15:27AM +0100, Niklas Cassel wrote:
> > >
> > > I do get a domain, but I do not get any IRQ on the EP side when the RC side is
> > > writing the doorbell (as part of pcitest -B),
> > >
> > > [    7.978984] pci_epc_alloc_doorbell: num_db: 1
> > > [    7.979545] pci_epf_test_bind: doorbell_addr: 0x40
> > > [    7.979978] pci_epf_test_bind: doorbell_data: 0x0
> > > [    7.980397] pci_epf_test_bind: doorbell_bar: 0x1
> > > [   21.114613] pci_epf_enable_doorbell db_bar: 1
> > > [   21.115001] pci_epf_enable_doorbell: doorbell_addr: 0xfe650040
> > > [   21.115512] pci_epf_enable_doorbell: phys_addr: 0xfe650000
> > > [   21.115994] pci_epf_enable_doorbell: success
> > >
> > > # cat /proc/interrupts | grep epc
> > > 117:          0          0          0          0          0          0          0          0  ITS-pMSI-a40000000.pcie-ep   0 Edge      pci-epc-doorbell0
> > >
> > > Even if I try to write the doorbell manually from EP side using devmem:
> > >
> > > # devmem 0xfe670040 32 1
> >
> > Sorry, this should of course have been:
> > # devmem 0xfe650040 32 1
> 
> Thank you test it. You can't write it at EP side. ITS identify the bus
> master. master ID (streamid) of CPU is the diffference with PCI master's
> ID (streamid). You set msi-parent = <&its0 0x0000>, not sure if 0x0000 is
> validate stream.

I see, this makes sense since the ITS converts BDF to an MSI specifier.


> 
> You have to run at RC side, "devmem (Bar1+0x40) 32 0".  So PCIe EP
> controller can use EP streamid.
> 
> some system need special register to config stream id, you can refer host
> side's settings.

> <&its0 0x0000>,  second argument is your PCIe controller's stream ID. You
> can ref RC side.

The RC node looks like this:
msi-map = <0x0000 &its1 0x0000 0x1000>;
So it does indeed use 0x0 as the MSI specifier.


> 
> >
> > Considering that the RC node is using &its1, that is probably
> > also what should be used in the EP node when running the controller
> > in EP mode instead of RC mode.
> 
> Generally,  RC node should use smmu-map, instead &its1. Or your PCI
> controller direct use 16bit RID as streamid.

smmu-map? Do you mean iommu-map?

I don't see why we would need to have the SMMU enabled to use ITS.
The iommu is currently disabled on my platform.

I did enable the iommu, and all BAR tests, read tests, write tests,
and copy tests pass. However I get an iommu error when the RC is
writing the doorbell. Perhaps you need to do dma_map_single() on
the address that you are setting the inbound address translation to?



Without the IOMMU, if I modify pci_endpoint_test.c to not send the
DISABLE_DOORBELL command on error (so that EP side still has DB enabled),
I can read all BARs except BAR1 (which was used for the doorbell):
[   21.077417] pci 0000:01:00.0: BAR 0 [mem 0xf0300000-0xf03fffff]: assigned
[   21.078029] pci 0000:01:00.0: BAR 1 [mem 0xf0400000-0xf04fffff]: assigned
[   21.078640] pci 0000:01:00.0: BAR 2 [mem 0xf0500000-0xf05fffff]: assigned
[   21.079250] pci 0000:01:00.0: BAR 3 [mem 0xf0600000-0xf06fffff]: assigned
[   21.079860] pci 0000:01:00.0: BAR 5 [mem 0xf0700000-0xf07fffff]: assigned
# pcitest -B
[   25.156623] COMMAND_ENABLE_DOORBELL complete - status: 0x440
[   25.157131] db_bar: 1 addr: 0x40 data: 0x0
[   25.157501] setting irq_type to: 1
[   25.157802] writing: 0x0 to offset: 0x40 in BAR: 1
[   35.300676] we wrote to the BAR, status is now: 0x0

status is not updated after writing to DB,
and /proc/interrupts on EP side is not incrementing.

# devmem 0xf0300000
0x00000000
# devmem 0xf0400040
0xFFFFFFFF
# devmem 0xf0500000
0x00000000
# devmem 0xf0600000
0x00000000
# devmem 0xf0700000
0x00000000

So there does seem to be something wrong with the inbound translation,
at least when testing on rk3588 which only uses 1MB fixed size BARs:
https://github.com/torvalds/linux/blob/v6.12-rc6/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L276-L281



You also didn't answer which imx platform that you are using to test this,
I don't see a single imx platform that specifies "msi-parent".


Kind regards,
Niklas

