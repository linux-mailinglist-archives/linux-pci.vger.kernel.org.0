Return-Path: <linux-pci+bounces-16111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548799BE2C6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B05B1F26F8E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F941DBB03;
	Wed,  6 Nov 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPV6OTg+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690921DDC2C;
	Wed,  6 Nov 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885808; cv=none; b=PR5g6DRiJuFtElEvreoZVNEpcpVo9jnrq17JHEmcrUoN/JcYvw24e4iOrKJ9XOEC6ZGC0VFJ3k0Tl3e9tH13s78N33LJCeW+UXkc63C1fAcdpxwF3z5hV8f1mLWbzz+I/19XDTZnZk5fL20aNoZOj+MCVv45vaO7dMb4SDMBS1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885808; c=relaxed/simple;
	bh=xK3U7kti/fKCKAedO+rH/itcrdtQnCITud0yaoSFbQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBbNAZN1qwTqAF+VWFZcF0741HP3jvd0+MqvqATxXCrhKROQAepVGq8taYi8seKPkB/bVVPiuuNVHvUTsprIu2vW0WN3ZY99JnqOk2gtkd2VxZCUByWO6jWYdYSUEzroKLJzSLYQtnOtthzw5e1vDrFxDR/mPZGW1bL6rAZ3O2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPV6OTg+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3171DC4CED4;
	Wed,  6 Nov 2024 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730885808;
	bh=xK3U7kti/fKCKAedO+rH/itcrdtQnCITud0yaoSFbQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pPV6OTg+vBv7X5R/WGjvBOheU4bK8G8JhvsUlixPtiLO5rUYV9BDUNdLzI7UOiVYb
	 Bwv5EbRukCIw0y+09TZyca8I3F8KQvGB/JQ0smVGly+lK8mYlkLLgug6hhuF/3uR/8
	 NlMxDLgFd7CMDgksnWv5ZT9/fNaXnKIIbt3RMHt14hLIZBfg72SQh+wJm9EcCLqBQ0
	 VNex18ciWplOcQJBrTI9TIQnnpbHAlQN+Ya213+nNd3XjZia7zuerp5yhqbBNrfGYq
	 fPJo35+ByDct98NuUUtrl3ErD8pcjZ8O0jZziTLe0Hhf5A20I3rT67VYNgDd8ZYmvX
	 rqtmaH3t1jehQ==
Date: Wed, 6 Nov 2024 10:36:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
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
Message-ID: <Zys4qs-uHvISaaPB@ryzen>
References: <20241031-ep-msi-v4-0-717da2d99b28@nxp.com>
 <Zyszr3Cqg8UXlbqw@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyszr3Cqg8UXlbqw@ryzen>

On Wed, Nov 06, 2024 at 10:15:27AM +0100, Niklas Cassel wrote:
> 
> I do get a domain, but I do not get any IRQ on the EP side when the RC side is
> writing the doorbell (as part of pcitest -B),
> 
> [    7.978984] pci_epc_alloc_doorbell: num_db: 1
> [    7.979545] pci_epf_test_bind: doorbell_addr: 0x40
> [    7.979978] pci_epf_test_bind: doorbell_data: 0x0
> [    7.980397] pci_epf_test_bind: doorbell_bar: 0x1
> [   21.114613] pci_epf_enable_doorbell db_bar: 1
> [   21.115001] pci_epf_enable_doorbell: doorbell_addr: 0xfe650040
> [   21.115512] pci_epf_enable_doorbell: phys_addr: 0xfe650000
> [   21.115994] pci_epf_enable_doorbell: success
> 
> # cat /proc/interrupts | grep epc
> 117:          0          0          0          0          0          0          0          0  ITS-pMSI-a40000000.pcie-ep   0 Edge      pci-epc-doorbell0
> 
> Even if I try to write the doorbell manually from EP side using devmem:
> 
> # devmem 0xfe670040 32 1

Sorry, this should of course have been:
# devmem 0xfe650040 32 1

But the result is the name, no IRQ triggered on the EP side.

(My command above was from testing "msi-parent = <&its0 0x0000>",
rather than &its1, but that also didn't work when writing the
corresponding "doorbell_addr" using e.g. devmem.)

Considering that the RC node is using &its1, that is probably
also what should be used in the EP node when running the controller
in EP mode instead of RC mode.


Kind regards,
Niklas

