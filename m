Return-Path: <linux-pci+bounces-6193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6238A3612
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 20:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903F91C21884
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A833014F124;
	Fri, 12 Apr 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puZdoiB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8C14F120
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948344; cv=none; b=nSS/zG+7VRHZrg+sNFOTJMDG5d2QIkX+aRSvmgtdMBpW3gsMxcFoi5orzjPqW6bNeN4M7/Tgq62V2SmTQl4uZKvtF8zcNMn2Y08ECmdxtZRwg/fUhf+HwIFsPZezO5AYOUXeWYPXniGjHnnAx7ivkcgvmROIGx0by7+PHL2TRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948344; c=relaxed/simple;
	bh=37C1C4f8sh6Sv4UkKghlBLhlizZj4K22kLsB/RNSa/4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qYBjh23Z3OFkQlsf+zWOWFIHERyjvFv2LnQQynNMLWzm37kjLDB5769UCgVg/Jc+Xrulaaz+hmcCEjKXSlk7IST3sM97AqiTDcMW7Jokf4k0GpR6JeMykYcBlh0aSPX5E2q21UEdw6l5dSvfzddQceUPx5jwj/QHZ2cSxxy24Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puZdoiB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41C7C113CC;
	Fri, 12 Apr 2024 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712948344;
	bh=37C1C4f8sh6Sv4UkKghlBLhlizZj4K22kLsB/RNSa/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=puZdoiB5ez8mf1zOE1eKGW0ybXjGY8UCbYIvmw1QK8unfZ/zbjpFsW7+9mCOUSdTA
	 ErrK2jr87zTzNDEiMBaj/N/EeSCn/s9KpC1tEQdG+VIh8dEdhU5D8Ca5k/HBMDKVZK
	 pAAwc+lWKPioH9X2Q+mjpj+8sMwa6XtJNDItbGJ+z8EEmwKvZm0jH1kqDsC3KO3Mjm
	 PMtsD6X3n4HTNCI33XBqA2YGYb2/jlJmEHXOkINO26ZyqrtXXWEKJclW5rHYMOcFrc
	 i+D86AF3JVbnL819BisrI3vPRKSjgYyqhtbP/PpYItS//WzNfIu8fd8390zrYEuuiw
	 IVYwFBIL8I0JA==
Date: Fri, 12 Apr 2024 13:59:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Message-ID: <20240412185901.GA10301@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313105804.100168-9-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:58:00AM +0100, Niklas Cassel wrote:
> ...

> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
>  	} else {
>  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> -		bool is_64bits = sz > SZ_2G;
> +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
>  
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;

Completely unrelated to *these* patches, but the BAR_CFG_CTRL
definitions in both cadence and rockchip lead to some awkward case
analysis:

  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS              0x4
  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS     0x5
  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS              0x6
  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS     0x7

  if (is_64bits && is_prefetch)
          ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
  else if (is_prefetch)
          ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH_MEM_32BITS;
  else if (is_64bits)
          ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_64BITS;
  else
          ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM_32BITS;

that *could* be just something like this:

  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM           0x4
  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_64BITS        0x2
  #define ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH      0x1

  ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_MEM;
  if (is_64bits)
    ctrl |= ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_64BITS;
  if (is_prefetch)
    ctrl |= ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_PREFETCH;

