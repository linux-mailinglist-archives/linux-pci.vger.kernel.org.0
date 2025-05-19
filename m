Return-Path: <linux-pci+bounces-27949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C11E4ABBA7A
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB963BD0D7
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD24200110;
	Mon, 19 May 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuTHSvGB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31BB1C700D;
	Mon, 19 May 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648794; cv=none; b=kUtnny2uo5rCguLFqoqGfg04XTcNABFcX9zoWUdkYF79MZvmKD1ucAh0QRBidLVCJT28ZabkoM2l8t9yQPWQccvqCD6V65rEX0u3QlpiirSq4/34Jq0/lLZhTGQx0+bD/sMKXqJ0nn5fDfCoIWrFzPVhzbFMhRwd8/ISdKZiidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648794; c=relaxed/simple;
	bh=WdkVZramwGI8mC1TPOoMUf9FA7POUXwjiwSg9TZ1T34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izTDwvfiN9pQGdFOcXReHrthv6+AUd8M9mkh6l7ydMHJTz4wAh9EVuN5mFi9bKH+j0Pi1PtmkRDQCShYN1/coMyIClyQvMzC4iADBAQNciE4sxA19/J8lrtm13OFPKYJDPtKYLNdNOyr2pU4cNsSV5QjQtRdLHEH+xCaJeVfOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuTHSvGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C87CC4CEE4;
	Mon, 19 May 2025 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648794;
	bh=WdkVZramwGI8mC1TPOoMUf9FA7POUXwjiwSg9TZ1T34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuTHSvGBuao+udd62qaUwmn5rY/W8IWSEw+QbgqOARvez+B1Z1eKRyiuGxy3WxyOv
	 xq/RipGvKezUbwf9tYIZ3WTQCgIPGQwQAGZIgmG3StIeq8J/rPW5R78MHTCV9/hyrE
	 VRYXyHZf3PKgQVO7twf1h7MYXvMLkcilE4Y8CwdPLwoPB42cISK9tDvdS4pD7moz0h
	 oi7VMJ7s1QbtLzlopdAfgjMg8QFXjp54qT7xblesUcVMwbBmhpQgR1/acb0cnZiv6/
	 N7rHl2MnRI5egEGl52GAvTicTvrX1h0U+l7so3OhndJIfRfUSHRuXHYu1HKLPS09SJ
	 3UEam3TxKTsBg==
Date: Mon, 19 May 2025 11:59:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com
Subject: Re: [PATCH 10/10] misc: pci_endpoint_test: Add driver data for FSD
 PCIe controllers
Message-ID: <aCsBE7uwU9wyZIXn@ryzen>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193305epcas5p263b59196e93ef504eab8537f82c37342@epcas5p2.samsung.com>
 <20250518193152.63476-11-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-11-shradha.t@samsung.com>

Hello Shradha,

On Mon, May 19, 2025 at 01:01:52AM +0530, Shradha Todi wrote:
> dma_map_single() might not return a 4KB aligned address, so add the
> default_data as driver data for FSD PCIe controllers to make it
> 4KB aligned.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 3 +++
>  include/linux/pci_ids.h          | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c4e5e2c977be..d94a94231ee5 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1110,6 +1110,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
>  	  .driver_data = (kernel_ulong_t)&default_data,
>  	},
> +	{ PCI_DEVICE(PCI_VENDOR_ID_TESLA, 0x7777),
> +	  .driver_data = (kernel_ulong_t)&default_data,
> +	},

Are you sure that you actually require this?

Since we now have these two commits:
e73ea1c2d4d8 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
0d292a1e6d90 ("misc: pci_endpoint_test: Add support for capabilities")

My expectation is that DWC based endpoint controller drivers should no longer
need an explicit 4k alignment in the host side driver.

Thus, I would expect that:
{ PCI_DEVICE(PCI_VENDOR_ID_TESLA, 0x7777),},

(i.e. no explicit 4k alignment)
should be sufficient.


Kind regards,
Niklas

