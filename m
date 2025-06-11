Return-Path: <linux-pci+bounces-29436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31223AD559D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADF8174F4F
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB5155322;
	Wed, 11 Jun 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9o71ezQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E92E6123
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645218; cv=none; b=c4P7XUpQDm719+n9cKSNHVzGF7ZWA3GXMqEbB01BFOhIIyHs9iEDLR0SRumYDRWM2KkIZiUtlzVWYEfWmKaMPcQYycxvVshMu35rlerzG8vhSOw2zLgZLJ9qfmxfo10e8ix+ri2w1CshIwQqbibY/6Zz0RZr2pxMjCH+N0qKBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645218; c=relaxed/simple;
	bh=+lrA0nPf6AP9cSWAaziIRpa/y8tw6zr1d7w3+2DHq2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfxZol0OJkfPFULjfn08dKIjd2QJLdGBfcHiljr0XLM2+XVmFLn1dv+2tpCbQbLuF5om01bRZEhYbFlPGELIlRC2Nievf5mF4hQ2flJPRhlFkgC+AjvG2Hiosk2dVIBZWyUvpeNhZhQbvF7kaSYKjUsAlV4xRjTg/YDlMZiq4/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9o71ezQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AD5C4CEEE;
	Wed, 11 Jun 2025 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645218;
	bh=+lrA0nPf6AP9cSWAaziIRpa/y8tw6zr1d7w3+2DHq2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A9o71ezQ1GshfhxY7QJyatz0a7jhcqxHGo42lr4cf3GMr9SkxI16i0/HNiqReRL7E
	 Rh1nXAiBH//IOdO7w20nR+g74ZWECqC/610GHCoHKMPgqDEIgBEyu1Dwu7MIce5uaR
	 +Nht8Lu6ciosHF+3ZrupkEMApE1T9Zavh3qBArK4enTaChRPJoK1vRU5YjZvEEuW7C
	 18vAD2uqUp35iG+phmHZqxMDPkwnNhD/w0JQjResqS8AnlFhNBObtgHc5LZ/d+T8BS
	 oKQIpPha4HqPAivRtDCPo3kP2eOHi0D1vYIYTfyesqb9XBm499jyDLAHIlEyDvKrBA
	 2JcAbZLc/AZEg==
Message-ID: <8a00a1ca-fe0e-4d70-a8f8-2d328f4f1620@kernel.org>
Date: Wed, 11 Jun 2025 21:33:35 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250611105140.1639031-6-cassel@kernel.org>
 <20250611105140.1639031-7-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250611105140.1639031-7-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 19:51, Niklas Cassel wrote:
> Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> and instead enumerate the bus directly after receiving the Link Up IRQ.
> 
> This means that there is no longer any delay between link up and the bus
> getting enumerated.
> 
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add this delay in the threaded link up IRQ handler in order to satisfy
> the requirements of the PCIe spec.
> 
> Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> SSD functional again. Adding the 100 ms delay as required by the spec also
> makes the SSD functional again.
> 
> Cc: Laszlo Fiat <laszlo.fiat@proton.me>
> Fixes: ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can detect Link Up")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 93171a392879..a941a239cbfc 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -459,6 +459,13 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>  		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");

Should maybe this message be moved after the sleep ?

> +			/*
> +			 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
> +			 * supports Link speeds greater than 5.0 GT/s, software
> +			 * must wait a minimum of 100 ms after Link training
> +			 * completes before sending a Configuration Request.
> +			 */
> +			msleep(PCIE_T_RRS_READY_MS);
>  			/* Rescan the bus to enumerate endpoint devices */
>  			pci_lock_rescan_remove();
>  			pci_rescan_bus(pp->bridge->bus);

Other than that, looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

