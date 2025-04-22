Return-Path: <linux-pci+bounces-26395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C25F2A969F3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A62617E70E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD5280CFC;
	Tue, 22 Apr 2025 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5/8Jozm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243D281500;
	Tue, 22 Apr 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325059; cv=none; b=MAChoAHl5uhWjaWLggwC7RWgd/YXUq3KvE8rydISNC0OY8UYvEyU7rgQxuFqXz02E6sMMmpWjQIuC3BA+4hPGbhX9dYg16SGFdXYk+8asBCxPpWWvZ7f0KIjnlLYAjHgAOcgM2bacNx5s5TR+JHHOSMsOwmzYA0auNZVIrot1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325059; c=relaxed/simple;
	bh=xKrfLs7qzUWVH8zA5N9jPbcdhMGwcx6yfh8zqByQ+e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMJ9oAo0W97xt24+LiFTKmne13vdzfs3mht+15PR34u+OtSbfmVqN7bRMA7671fe77lrWHiIKFufABcGQGBspnVg/eEGHTrS5qHnVZPe42T90VG0ElEb0yKSBxYeFFcuC+4delnnSoaKd70WyNxQE5pSUYdhNSuJhvxA/Tcoxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5/8Jozm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF38C4CEE9;
	Tue, 22 Apr 2025 12:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745325058;
	bh=xKrfLs7qzUWVH8zA5N9jPbcdhMGwcx6yfh8zqByQ+e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5/8JozmzsqHMFr9MfAeEsbe5a13Rm5wB6vFbHudtpq6sMRptR/iJgl8XzsF+X0yR
	 1NIDbkxXx+l8/FeBcmi+gOa5RHq9hiEZDvoIw5KpIdWs129N8fmR0IrrXPgb8D5a12
	 y5OwXdylmUPmPs1b1Z9EEplSj5AJ/HCp0u0VAtTU1FyVO6mf96CCiLTDQmO3fEKFB7
	 f1gwCGiHRvXUrF8G0bivHZdAIeW4G0nWdBoIzaOdg1sk7HW+zGvDpwCEE73/c2aCR+
	 5994uqd8N87I/3433Bm1culIf0dK1HyTu91JlMlNNVOq4O7G5y0vbjjjwiPfc8P+1y
	 BC1lIJRQP6I8g==
Date: Tue, 22 Apr 2025 14:30:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/3] PCI: dw-rockchip: Reorganize register and bitfield
 definitions
Message-ID: <aAeL_Wr42ETm7S96@ryzen>
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422112830.204374-3-18255117159@163.com>

On Tue, Apr 22, 2025 at 07:28:29PM +0800, Hans Zhang wrote:
> Register definitions were scattered with ambiguous names (e.g.,
> PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
> hierarchical grouping. Magic values for bit operations reduced code
> clarity.
> 
> Group registers and their associated bitfields logically. This improves
> maintainability and aligns the code with hardware documentation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 42 +++++++++++--------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index fd5827bbfae3..cdc8afc6cfc1 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -8,6 +8,7 @@
>   * Author: Simon Xue <xxm@rock-chips.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -34,30 +35,35 @@
>  
>  #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
>  
> -#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
> -#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
> -#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
> -#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
> -#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
> +#define PCIE_CLIENT_GENERAL_CONTROL	0x0
> +#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
> +#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
> +#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
> +#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
> +
> +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x4
> +#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> +
>  #define PCIE_CLIENT_INTR_STATUS_MISC	0x10
> +#define  PCIE_RDLH_LINK_UP_CHGED	BIT(1)
> +#define  PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> +
> +#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> +
>  #define PCIE_CLIENT_POWER		0x2c
> +#define  PME_READY_ENTER_L23		BIT(3)
> +
>  #define PCIE_CLIENT_MSG_GEN		0x34
> -#define PME_READY_ENTER_L23		BIT(3)
> -#define PME_TURN_OFF			(BIT(4) | BIT(20))
> -#define PME_TO_ACK			(BIT(9) | BIT(25))
> -#define PCIE_SMLH_LINKUP		BIT(16)
> -#define PCIE_RDLH_LINKUP		BIT(17)
> -#define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)

This patch removes PCIE_LINKUP, without adding it somewhere else
so I don't think this patch will compile.

I think the removal of this line has to be in patch 3/3.



Also, I think that Bjorn's primary concern:
"""
The #defines for register offsets and bits are kind of a mess,
e.g., PCIE_SMLH_LINKUP, PCIE_RDLH_LINKUP, PCIE_LINKUP,
PCIE_L0S_ENTRY, and PCIE_LTSSM_STATUS_MASK are in
PCIE_CLIENT_LTSSM_STATUS, but you couldn't tell that from the
names, and they're not even defined together.
""""

is that the fields are not prefixed with the register name.

the secondary concern is that they are not grouped together.

This patch is just solving the secondary concern.

Since you are fixing his secondary concern, should you perhaps also
address his primary concern?



Kind regards,
Niklas

