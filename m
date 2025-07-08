Return-Path: <linux-pci+bounces-31658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E1CAFC43B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2F42704D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6D329AAEA;
	Tue,  8 Jul 2025 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1a0U0PS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313C21A428;
	Tue,  8 Jul 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960298; cv=none; b=RSM+zEE07d5eg6ohvUihquz9HR+AU7o/UIYxwftoIM82Yc5psZxKsViiPCLyWGagYP4y05iwq2DR8Aesh5zDqdK8iVctzcBlHfVMwiZSz/3wIf6xWSgeXlePrgzz+u4hHX1CV943qBTxeS5CfLiCZThdglzGJyIgHk4k9PGJeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960298; c=relaxed/simple;
	bh=BgLBeWI7Kkq8y/M+805ggWOqf/BrfPkUfyqfLs3mFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3ruwku13N5cWAth5PWLwY66Mooiy/kEkxppwRX+ABU90DfhWz8vbpx0ccF7s35Mqhq9CVlhi1j/FE0O/QNfJmSzYWp8x9T8urRQO7RlCcfPmTjBbK2BcBXqPjziKnI9uEIj1zJqP67UFOYJ99qEOtQv4P3O/KoDqV5P0FVO17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1a0U0PS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6BAC4CEF0;
	Tue,  8 Jul 2025 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960297;
	bh=BgLBeWI7Kkq8y/M+805ggWOqf/BrfPkUfyqfLs3mFsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1a0U0PSMSGGupuyRgulbgUXZLdDpjfrJLhgSPS5WwxsrCa0J8ONrmoM+pqFuMxqR
	 u2bONUFgKv6Rc4i2jrOzGaXJ1tDZR0MA1Qtke7UA/Xphqc4lc3mVRClNOxVJf/+4DB
	 as+KG0t0bqn2rRz8jxesekB9xKfhNUYNt/+EU4veraaEDxPZZFtqmqMv35wyuBKfwb
	 4VOjf6C61ruGEztM9CoiOtY5sHp5DXUFQjwM8zaX41ti7ZYQVfQT9zaCS/aB0A4agx
	 IyopwV8r4YnNEjaK3jHKHOcMtClKGxLWju5QQ5oD0Folr82fDLjuE4Aohjv1nJmd4z
	 7lSYEd/Mgf3XQ==
Date: Tue, 8 Jul 2025 13:08:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: brcmstb: Enable Broadcom Cable Modem SoCs
Message-ID: <jcrgjiaadle2vzeqxl556k773mz7bzzr3f26okwlhnal6dakxo@d7oio5p4kxkz>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
 <20250609221710.10315-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609221710.10315-4-james.quinlan@broadcom.com>

On Mon, Jun 09, 2025 at 06:17:06PM GMT, Jim Quinlan wrote:
> Broadcom's Cable Modem (CM) group also uses this PCIe driver
> as it shares the PCIe HW core with the STB group.
> 
> Make the modifications to enable the CM SoCs.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 186 +++++++++++++++++++++-----
>  1 file changed, 152 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index db7872cda960..e25dbcdc56a7 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -51,6 +51,9 @@
>  #define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
>  #define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
>  
> +#define PCIE_RC_DL_PDL_CONTROL_4			0x1010
> +#define  PCIE_RC_DL_PDL_CONTROL_4_NPH_FC_INIT_MASK	0xff000000
> +
>  #define PCIE_RC_DL_MDIO_ADDR				0x1100
>  #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
> @@ -60,6 +63,7 @@
>  #define  PCIE_RC_PL_PHY_CTL_15_PM_CLK_PERIOD_MASK	0xff
>  
>  #define PCIE_MISC_MISC_CTRL				0x4008
> +#define  PCIE_MISC_MISC_CTRL_PCIE_IN_CPL_RO_MASK	0x20
>  #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
>  #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
>  #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
> @@ -170,6 +174,7 @@
>  /* MSI target addresses */
>  #define BRCM_MSI_TARGET_ADDR_LT_4GB	0x0fffffffcULL
>  #define BRCM_MSI_TARGET_ADDR_GT_4GB	0xffffffffcULL
> +#define BRCM_MSI_TARGET_ADDR_FOR_CM	0xfffffffffcULL
>  
>  /* MDIO registers */
>  #define MDIO_PORT0			0x0
> @@ -223,13 +228,23 @@ enum {
>  enum pcie_soc_base {
>  	GENERIC,
>  	BCM2711,
> +	BCM3162,
> +	BCM3392,
> +	BCM3390,
>  	BCM4908,
>  	BCM7278,
>  	BCM7425,
>  	BCM7435,
>  	BCM7712,
> +	BCM33940,
>  };
>  
> +/*
> + * BCM3390 CM chip actually conforms to STB design, so it
> + * is not present in the macro below.
> + */
> +#define IS_CM_SOC(t) ((t) == BCM3162 || (t) == BCM33940 || (t) == BCM3392)
> +
>  struct inbound_win {
>  	u64 size;
>  	u64 pci_offset;
> @@ -757,6 +772,9 @@ static int brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
>  	int ret = 0;
>  
> +	if (IS_CM_SOC(pcie->cfg->soc_base))
> +		return 0;
> +
>  	if (pcie->bridge_reset) {
>  		if (val)
>  			ret = reset_control_assert(pcie->bridge_reset);
> @@ -891,13 +909,13 @@ static int brcm_pcie_get_inbound_wins(struct brcm_pcie *pcie,
>  	struct inbound_win *b = b_begin;
>  
>  	/*
> -	 * STB chips beside 7712 disable the first inbound window default.
> -	 * Rather being mapped to system memory it is mapped to the
> -	 * internal registers of the SoC.  This feature is deprecated, has
> -	 * security considerations, and is not implemented in our modern
> -	 * SoCs.
> +	 * STB chips beside CM chips and 7712 disable the first inbound
> +	 * window default.  Rather being mapped to system memory it is
> +	 * mapped to the internal registers of the SoC.  This feature is
> +	 * deprecated, has security considerations, and is not
> +	 * implemented in our modern SoCs.

May I know what is the purpose of allowing inbound access to these regions? TBH,
I'm not sure what is the usecase of 'inbound memory' for PCIe host.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

