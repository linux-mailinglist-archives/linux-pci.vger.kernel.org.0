Return-Path: <linux-pci+bounces-41260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F2C5EA7D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7B44ED37A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3C6341ACC;
	Fri, 14 Nov 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhmnV6vX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD68341648;
	Fri, 14 Nov 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142088; cv=none; b=SUrJpPiSujFXCiGDpq+xyxdVQ4ITe+BopcGtl8tNU6QBjc9ej7AFYz82OO9JBuRx0LzQN3zpmAXTDWRXz5a4+6lB3wmsT7jfNYHnNCzdnAh4Gx2CjdwKcgt12/tCxNgsi2GQo2mQ3uLKvb724lwgjVaT4+gM+l/8yXHwQMxJsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142088; c=relaxed/simple;
	bh=2V3OLxIecUTL1cM3zq/62ram03w6p7XMUaZIz24wlCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C86aKFbgCWcXPJwjYqUlk6u8DWhpZhs+EfIiB1VG3xPgb8JQUlInMYk1MWcPNKNgBCAuytwWjJZJlKXs95DhBhRzMXMYTDVggIm0PC7uQwlYhOcaLJ0btCM2w+UGW2VDC8xVcfYc8QOnn7bjzto15SbIa5N/OovMMzdhUzkjbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhmnV6vX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D05DC116B1;
	Fri, 14 Nov 2025 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763142088;
	bh=2V3OLxIecUTL1cM3zq/62ram03w6p7XMUaZIz24wlCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhmnV6vXy852CWEIToaemzbCEgrFWFg5CROl4hSb70/c3CZLymUm8qoGQl7tKw5pH
	 UM1H4wYOJ6FJSAn90NUEvIMrGCQKrIrIG1cqf0HcNVFFhNE15YC32oKKDcV6s+Ea6V
	 UB3V0LtRUe9wNI/vmA/JeBr82HtrAsrg6jcvvItWkWtXBUdteb9S15Jcym/aokefzH
	 ctfqH665edLDzD7y5Bc2bbijQIe3tf0rUbfqe588Iipgl+ClmLrjzm63yoKMD604Jv
	 fkG2y7oqlsLYQEbaZK6IHaHfgECLk3V5TbZUSzKujQqbZzwSUYnI5mzm9UHoNWRq6s
	 0w8zg9lYAyxWw==
Date: Fri, 14 Nov 2025 23:11:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 10/10] arm64: dts: cix: Enable PCIe on the Orion O6
 board
Message-ID: <43qyfkyaiq2xnp5wlu7aw4h6misa2ksh77ya2g4ue3hkxr45ru@yeghcl7gntby>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
 <20251108140305.1120117-11-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108140305.1120117-11-hans.zhang@cixtech.com>

On Sat, Nov 08, 2025 at 10:03:05PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add PCIe RC support on Orion O6 board.
> 
> The Orion O6 board includes multiple PCIe root complexes. The current
> device tree configuration enables detection and basic operation of PCIe
> endpoints on this platform.
> 
> GPIO and pinctrl subsystems for this platform are not yet ready for
> upstream inclusion. Consequently, attributes such as reset-gpios and
> pinctrl configurations are temporarily omitted from the PCIe node
> definitions.
> 
> Endpoint detection and functionality are confirmed to be operational with
> this basic configuration. The missing GPIO and pinctrl support will be
> added incrementally in future patches as the dependent subsystems become
> available upstream.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Dear Krzysztof and Mani,
> 
> Due to the fact that the GPIO, PINCTRL and other modules of our platform are
> not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
> and pinctrl*, have not been added for the time being. It will be added gradually
> in the future.
> 
> The following are Arnd's previous comments. We can go to upsteam separately.
> https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/
> 
> 
> The following are the situations of five PCIe controller enumeration devices.
> 
> root@cix-localhost:~# uname -a
> Linux cix-localhost 6.18.0-rc4-00010-g0f5b0f23abef #237 SMP PREEMPT Sat Nov  8 21:47:44 CST 2025 aarch64 GNU/Linux
> root@cix-localhost:~#
> root@cix-localhost:~# lspci
> 0000:c0:00.0 PCI bridge: Device 1f6c:0001
> 0000:c1:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> 0001:90:00.0 PCI bridge: Device 1f6c:0001
> 0001:91:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
> 0002:60:00.0 PCI bridge: Device 1f6c:0001
> 0002:61:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller
> 0003:00:00.0 PCI bridge: Device 1f6c:0001
> 0003:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> 0004:30:00.0 PCI bridge: Device 1f6c:0001
> 0004:31:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
> ---
>  arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> index d74964d53c3b..be3ec4f5d11e 100644
> --- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> +++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
> @@ -34,6 +34,26 @@ linux,cma {
>  
>  };
>  
> +&pcie_x8_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x4_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x2_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x1_0_rc {
> +	status = "okay";
> +};
> +
> +&pcie_x1_1_rc {
> +	status = "okay";
> +};
> +
>  &uart2 {
>  	status = "okay";
>  };
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

