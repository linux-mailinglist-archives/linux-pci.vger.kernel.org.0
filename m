Return-Path: <linux-pci+bounces-30360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78986AE3BE0
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A597A673E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B7239581;
	Mon, 23 Jun 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBlE5ybK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C5238C26;
	Mon, 23 Jun 2025 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673571; cv=none; b=gSiTR+DQI0Frdpn6P597A4GGQGkQYwMqeh/+K0ypKIEec2npZG16HF4crzllu9Ch8LIEO5dry+W7GV19/uRBnwKJpK/Z6PWcxxb6+4UYSYJowwR5gTxa8fIOwGjadLALjptumdugISbxKVVZoPQSHD02hCBUuGx7hMS4kCCdYIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673571; c=relaxed/simple;
	bh=ExnjUdK3o3V8JO7BKifNCHsFEL5+cTDvCzznc0e+CIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUE2syuPYcnEvGyEfuA2IFf9TJie0lJbi6shksInMoxYjDjhr68nGDYIUVvRuwrrdGkPTPTvwxw25sIKSx8v/N/vmn2O+ZFxwkE61PnKUadwYD9fgvLHwLWJYUtm/AhhT6MXxnEDtnSMa41rup6/XnBTAMGMuAp4Q7jRFVkX8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBlE5ybK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7F9C4CEEA;
	Mon, 23 Jun 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750673570;
	bh=ExnjUdK3o3V8JO7BKifNCHsFEL5+cTDvCzznc0e+CIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBlE5ybKSu1rLcbTXXI3HgTUqxf0bccQjD17XemEfn9oZZoTPKImPs6anBi9PoEBP
	 Jmvkc9ITMdIoVob4hp+yF00wzU4w9BUC4SZEY2sg0LZcIvdFeG8jYFoUldD2RoAdUB
	 SdnGIAUm/0lA3aJ57/3ewjwRO/DBFWePZ5xhdfY3VxPSspoI6iDG3j5N+iSSl6TH/1
	 2nJq8FNAyMs6muppcoHOtJQHO4BZ9ZZgVPqZy+S83U5m+b24fUBNuJJzd5kIYJ1cfH
	 oMj4f2OOyIDTKT6SKuf9ApmGeO85i8WFJx4ZTX4f1JSY7TMw+dabKiU9X+81PGsPCd
	 bNzh0MW/zxn6w==
Date: Mon, 23 Jun 2025 12:12:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Kever Yang <kever.yang@rock-chips.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>, Simon Xue <xxm@rock-chips.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI: dwc: Do not enumerate bus before endpoint
 devices are ready
Message-ID: <aFkonAnTZN80jsrP@ryzen>
References: <20250613124839.2197945-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613124839.2197945-8-cassel@kernel.org>

On Fri, Jun 13, 2025 at 02:48:39PM +0200, Niklas Cassel wrote:
> Hello all,
> 
> The DWC PCIe controller driver currently does not follow the PCIe
> specification with regards to the delays after link training, before
> sending out configuration requests. This series fixes this.
> 
> At the same time, PATCH 1/4 addresses a regression where a Plextor
> NVMe drive fails to be configured correctly. With this series, the
> Plextor NVMe drive works once again.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Changes since v2:
> -Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.
> 
> 
> Niklas Cassel (6):
>   PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
>     PCIE_RESET_CONFIG_WAIT_MS
>   PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
>   PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
>   PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
>   PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link
>     up
>   PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
> 
>  drivers/pci/controller/dwc/pcie-designware.c  | 13 ++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h  | 13 +++++++++----
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
>  drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
>  drivers/pci/controller/plda/pcie-starfive.c   |  2 +-
>  drivers/pci/pci.h                             |  9 +--------
>  7 files changed, 26 insertions(+), 15 deletions(-)
> 
> -- 
> 2.49.0
> 

Gentle ping

