Return-Path: <linux-pci+bounces-30264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913F9AE1EF5
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4201164B3C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE22BD5BF;
	Fri, 20 Jun 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5okcp6J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9F11FBEB9;
	Fri, 20 Jun 2025 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434124; cv=none; b=HGtP+J5u9GkM6RUnmJzTEHWAKQkbmGNYjdXvGAY3lOzE9VyZmaPtrqHZVvxfWj4fqdtwGWoVvL/vkMFx99ZPUNq80E80sXhGWWW9vLRh3qOQgcy6EoBHXVRmTe2FE4z85GlbHUs67RMNxx7imjgmQzszlq4gBSrkKvMJBlkfqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434124; c=relaxed/simple;
	bh=SHPTxnd4pbMYQOtiIQLzx9eD7HZDUt3+mEFmqV4gGBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QUfZJvtj+a3zj8dlzRmmNKe9p5hsFIBLtV0GuiALq5EScoWKvOl3oBpEL+zwiaQRVBj/PSGMiIJFyWmjB4aKEE+n7koUZjNavbKSAogoLOl0ZaqkeZYiBvNTP+x25s/dAQm27NWyV8sv56w59OiQxXfuL1nIveC/VGM5mtZW4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5okcp6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BC2C4CEE3;
	Fri, 20 Jun 2025 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750434124;
	bh=SHPTxnd4pbMYQOtiIQLzx9eD7HZDUt3+mEFmqV4gGBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g5okcp6JBl2EOByxwdGhanD/oHlYvrWI0Ju/YEgHG3PVZv122YXGG65QLIySgjCma
	 EvWhT3unRjT77HoYGSlzUPV2HwmghNbhw7zb3sVVWlaXsf4xguDKGYXMERIg2YM9pX
	 gXDqosrULppL3gOfoy8ENwCQQq1pLft2MI/KDPXuKmovWBi50brnztquvRguMV/Kf/
	 Kw4lvcJCWsZB9ch0PkRu3OxocrNdJc6cypNlM7NJoZRv/PxZRISSIqPDff2kM0uGmK
	 dqHzCD9MspAjRyfIlWI3SkIGkwfQj+F+zUfHIg8ucU5RnCXhFOQJ2ysIWuRpDdKTof
	 Uu7jXcW0sVKdQ==
Date: Fri, 20 Jun 2025 10:42:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
	shawn.lin@rock-chips.com, heiko@sntech.de, robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rockchip: Remove redundant PCIe message routing
 definitions
Message-ID: <20250620154202.GA1292011@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607154913.805027-3-18255117159@163.com>

On Sat, Jun 07, 2025 at 11:49:13PM +0800, Hans Zhang wrote:
> The Rockchip driver contained duplicated message routing and INTx code
> definitions (e.g., ROCKCHIP_PCIE_MSG_ROUTING_TO_RC,
> ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA). These are already provided by the
> PCI core in drivers/pci/pci.h as PCIE_MSG_TYPE_R_RC and
> PCIE_MSG_CODE_ASSERT_INTA, respectively.
> 
> Remove the driver-specific definitions and use the common PCIe macros
> instead. This aligns the driver with the PCIe specification and reduces
> maintenance overhead.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/pcie-rockchip.h | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 5864a20323f2..12bc8da59d73 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -215,20 +215,6 @@
>  #define RC_REGION_0_TYPE_MASK			GENMASK(3, 0)
>  #define MAX_AXI_WRAPPER_REGION_NUM		33
>  
> -#define ROCKCHIP_PCIE_MSG_ROUTING_TO_RC		0x0
> -#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ADDR		0x1
> -#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ID		0x2
> -#define ROCKCHIP_PCIE_MSG_ROUTING_BROADCAST		0x3
> -#define ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX		0x4
> -#define ROCKCHIP_PCIE_MSG_ROUTING_PME_ACK		0x5
> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA		0x20
> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTB		0x21
> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTC		0x22
> -#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTD		0x23
> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA		0x24
> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTB		0x25
> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTC		0x26
> -#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTD		0x27

Thanks for doing this!  In fact, these definitions are not only
redundant, they're not even used at all.

>  #define ROCKCHIP_PCIE_MSG_ROUTING_MASK			GENMASK(7, 5)
>  #define ROCKCHIP_PCIE_MSG_ROUTING(route) \
>  	(((route) << 5) & ROCKCHIP_PCIE_MSG_ROUTING_MASK)

And neither are these ROUTING and CODE definitions.

