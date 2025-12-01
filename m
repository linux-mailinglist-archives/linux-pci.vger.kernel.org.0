Return-Path: <linux-pci+bounces-42358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA091C971F9
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 12:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F9B3A4144
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 11:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5A2F25E3;
	Mon,  1 Dec 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxxVMSdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6E2F1FCF;
	Mon,  1 Dec 2025 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764589910; cv=none; b=bQYfXqjLv2TtCXxwEK3DwEr1Gw4DOA2jYNYiu8O0QubKDu/NnwU/lXQKVsuYvOExWemaaGjWzdfthZhX7vBDw/F4liOmOCn70lb+APnCGoAnFBtAM/rp5UmykLgl0iISx6QHqSk3El8a6GLyI55m2kwH2UiJ03S9T1AO2Y3qRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764589910; c=relaxed/simple;
	bh=3HC8X3QnxHsDdV1qdXMUkclAd82ZLov/gFh81kRCVuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOG5ICaCve+ve/ilTtJN69zLo2ABI/V1FI7lvHmQAWsVAGVYXPHZeiyg7XLNfk7eIR2komYNUsSqHFVJXG5FV3a5/4b5cSfIr+jQAGcdvcL6XXM1KrBV5pIIDYBOiY3gRmH0n2i+b5Lu7a75QBTVYCP4acNU70+9uaSIFQS3eUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxxVMSdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1CFC4CEF1;
	Mon,  1 Dec 2025 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764589910;
	bh=3HC8X3QnxHsDdV1qdXMUkclAd82ZLov/gFh81kRCVuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxxVMSdRYaTGz7G2omN0JBxOHZ3CcZ9mhrs//pSijQsiiPaJIso1SqReYJBs0jEpm
	 XJpNxdIivIO2KdC2D7r944Fc7aTMl2XqBp4nhQ3ZBsgPyA0KYWJjibmcdLv8OKdcEm
	 EQrebsr6Uo47RM4k86dE15Gq3XH1CmGgW5zI4ZcNpjr/Rog/9FMG9ASYnaVvIH92ky
	 oF+GDmFTqYRQTkZQTbJj3jFrOef62kmz9pbOq2jRuImXtQOMJDm1oZXfHEwSHxDfzP
	 1hw/WpaH1eAnFKF14GTxAfvCtBXjc4Hw+UQuIG7cisBjI536GiDTCgWbjCeS+FcA4J
	 8+O4GNY101p6g==
Date: Mon, 1 Dec 2025 17:21:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
Message-ID: <h7pgm3lqolm53sb4wrcpcurk4ghz4tulqnr7vgd7rzxy4hscue@jcn5tepevlwl>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
 <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
 <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk>
 <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk>
 <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
 <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
 <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
 <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>

On Sat, Nov 29, 2025 at 06:04:24AM +0000, Maciej W. Rozycki wrote:
> On Sat, 29 Nov 2025, Krishna Chaitanya Chundru wrote:
> 
> > > > Hi Maciej, Can you try attached patch and let me know if that is helping
> > > > you
> > > > or not. - Krishna Chaitanya.
> > >   No change, it's still broken, sorry.
> > HI Maciej,
> > For the previous patch can you apply this diff and share me dmesg o/p
> 
>  Your patch came though garbled, likely due to:
> 
> Content-Type: text/plain; charset=UTF-8; format=flowed
> 
> Please refer Documentation/process/email-clients.rst and reconfigure your 
> e-mail client if possible.
> 
>  Regardless, I've fixed it up by hand and the only difference in the log, 
> except for usual noise which I removed, is this:
> 
> --- dmesg-bad.log	2025-11-28 03:47:29.582049781 +0100
> +++ dmesg-debug.log	2025-11-29 05:41:23.384645926 +0100
> @@ -164,6 +164,8 @@
>  fu740-pcie e00000000.pcie: ECAM at [mem 0xdf0000000-0xdffffffff] for [bus 00-ff]
>  fu740-pcie e00000000.pcie: Using 256 MSI vectors
>  fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4096G
> +fu740-pcie e00000000.pcie: Current iATU OB index 2
> +fu740-pcie e00000000.pcie: Current iATU OB index 4
>  fu740-pcie e00000000.pcie: cap_exp at 70
>  fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>  fu740-pcie e00000000.pcie: changing speed back to original
> 
> I've attached a full copy of the debug log too.  I hope this helps you 
> narrow the issue down or otherwise let me know what to try next.
> 
>  NB I note that code you've been poking at only refers resources of the 
> IORESOURCE_MEM type.  What about IORESOURCE_IO, which seems more relevant 
> here?
> 
>  Also as a quick check I've now reconfigured the defxx driver for PCI port 
> I/O (which is a one-liner; the mapping used to be selectable by hand, but 
> distributions got it wrong for systems w/o PCI port I/O, so I switched the 
> driver to an automatic choice a few years ago, but the logic remains):
> 
> # cat /proc/ioports
> 00000000-0000ffff : pcie@e00000000
>   00001000-00002fff : PCI Bus 0000:01
>     00001000-00002fff : PCI Bus 0000:02
>       00001000-00002fff : PCI Bus 0000:05
>         00001000-00002fff : PCI Bus 0000:06
>           00001000-00001fff : PCI Bus 0000:07
>           00001000-00001007 : 0000:07:00.0
>           00001000-00001002 : parport0
>           00001003-00001007 : parport0
>           00001008-0000100b : 0000:07:00.0
>           00001008-0000100a : parport0
>           00002000-00002fff : PCI Bus 0000:08
>           00002000-00002fff : PCI Bus 0000:09
>           00002000-000020ff : 0000:09:01.0
>           00002100-0000217f : 0000:09:02.0
>           00002100-0000217f : defxx
> # 
> 
> and:
> 
> defxx 0000:09:02.0: assign IRQ: got 40
> defxx: v1.12 2021/03/10  Lawrence V. Stefani and others
> defxx 0000:09:02.0: enabling device (0000 -> 0003)
> defxx 0000:09:02.0: enabling bus mastering
> 0000:09:02.0: DEFPA at I/O addr = 0x2100, IRQ = 40, Hardware addr = 00-60-6d-xx-xx-xx
> 0000:09:02.0: registered as fddi0
> 
> (as at commit 4660e50cf818) and likewise it has stopped working here from 
> commit 0da48c5b2fa7 onwards:
> 
> defxx 0000:09:02.0: assign IRQ: got 40
> defxx: v1.12 2021/03/10  Lawrence V. Stefani and others
> defxx 0000:09:02.0: enabling device (0000 -> 0003)
> defxx 0000:09:02.0: enabling bus mastering
> 0000:09:02.0: Could not read adapter factory MAC address!
> 
> So it's definitely nothing specific to the parport driver, but rather a 
> general issue with PCI/e port I/O not working anymore.  I do hope these 
> observations will let you address the issue now.  You might be able to 
> reproduce it with hardware you have available even.
> 

Yes, looks like the I/O port access is not working with the CFG Shift feature.
The spec says that both I/O and MEM TLPs should be handled by this feature, so
we are currently unsure why MEM works, but not I/O.

The issue you reported with parport_pc driver is that the driver gets probed,
but it fails to detect the parallel ports on the device. More precisely, it
fails due to the parport_SPP_supported() check in drivers/parport/parport_pc.c.
This function performs some read/write checks to make sure that the port exists,
but most likely the read value doesn't match the written one. And since there is
no log printed in this function, it just failed silently.

We will check why I/O access fails with ECAM mode and revert back asap. Since
the merge window is now open, it becomes difficult to revert the CFG shift
feature cleanly. The timing of the report also made it difficult to fix the
issue in v6.18. Hopefully, we can backport the fix once we identify the culprit.

Sorry for the inconvenience!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

