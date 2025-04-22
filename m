Return-Path: <linux-pci+bounces-26387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E3A96819
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DACD7A76C2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7A27BF8F;
	Tue, 22 Apr 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRDzEyMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3C265619;
	Tue, 22 Apr 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322482; cv=none; b=ZcDnGa+evi7aNGTG9r/iKoxvZADp9lOZicXOhWSdTOaKXW7d8nL84CnPJ/MUNcGwi1VneJB/C+2GJ8kSXkfpVqAF6aeS4fzWp9W7e+kcX2Qb+vJed9GjTAjhKdjjJbCfAUvNJMtyBwhNDsgdNh2xvJOWcu4cVM2XoCGYjxIbLBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322482; c=relaxed/simple;
	bh=SZ8P4ntOmJ6xAh7cT6ZK7CKYPq0r/WrQHbODqpRB9eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrNH2iIb/dy+/E1qR+73R6T9ZkI5R4Utmk5KR2lquA+gWgtZQEZPdEZE0G+Sbc7zyz4jW/SXCxJdIpeQQvW5bzSy/ep4K920ILSSAgOHeMqqmOGa9SopXSk8BJclNRr85et6gxrkmD16PiO45o9mWS3ZT9x5JBj9MT1dLVIm6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRDzEyMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B256EC4CEEA;
	Tue, 22 Apr 2025 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745322482;
	bh=SZ8P4ntOmJ6xAh7cT6ZK7CKYPq0r/WrQHbODqpRB9eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QRDzEyMldtGbO5SWm1dZjfG4oaLyAwAmKGNnHOMl4KG2HzB6lvgFr/K2m7vOIVyuU
	 wsM5aivTeQLj++TyDw2WdAzw1sjWypyPaJl/fhyjOl+H9qsN//D0jKpLvpLvagmEgo
	 bvY6KJdUkCMl9g2fqD4QcfPxC/kdv0yuNR3ODOFn142YIIvpdSTwu+TMqhhEjexl/4
	 PyNVgwAgxP3TBEFhRA1P6MhW/RL+oeTdUmRp51YAMwD8TLiZcDWpZcluYrqsDH1477
	 Ons0Wmxl1vK8y4gMrmELPRZ/iiPFfyi1DKOSJ6BqsOeH+h5MbcWJq67E6VcBYHe/gw
	 69UKzeXakmmEQ==
Date: Tue, 22 Apr 2025 13:47:57 +0200
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
Message-ID: <aAeB7fO_LCzi-xCh@ryzen>
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
> -#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
> -#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
> -#define PCIE_CLIENT_GENERAL_CONTROL	0x0
> -#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
> -#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
> +#define  PME_TURN_OFF			HIWORD_UPDATE_BIT(BIT(4))
> +#define  PME_TO_ACK			HIWORD_UPDATE_BIT(BIT(9))
> +
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> +#define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> +
>  #define PCIE_CLIENT_LTSSM_STATUS	0x300
> -#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> -#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
> +#define  PCIE_LINKUP_MASK		GENMASK(17, 16)

Here you are adding a macro (PCIE_LINKUP_MASK) that is not used.

I suggest that you move the addition to the patch where it is actually used.


Kind regards,
Niklas

