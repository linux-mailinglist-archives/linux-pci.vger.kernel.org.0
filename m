Return-Path: <linux-pci+bounces-26535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F8A98AE6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE5E5A1CDE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE961624DE;
	Wed, 23 Apr 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOM/Y90Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EE18DB18;
	Wed, 23 Apr 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414679; cv=none; b=MDXQOr60vC8kJgoYdX3Mmu4BPNau3qPTgfe5+ID0mwy72BoKCMqEzwsNmRpfaEI0phmwFuSvihOtnhCVWFywBwy+g9c2dtc6kDUTnqpkhAfN+DrnUYmYkSv5KBW3VxxpoNnMapdI+eIAq4USWTLw+38HpB3FY+ZpNhpfs/kMNfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414679; c=relaxed/simple;
	bh=gmTewFvvAA2ss6kxUAoJF1HbwlnqsG2fYLPC6chwa5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbjNhX6Jdkh6bNL9hAxxMNk/w4Zu6kEOdEstsmgwuAiySVlLB57xxtqWweyEdvJwfip82zZ+fAK+pOShVbjIi4DYmFQwRfjBwPnwU1r27OOPwWdwxXco+LhS48ncbF2wJQ3nsKzZ6/zC/sYdDH/sRkmYPET0PwNeBk1FCd9N87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOM/Y90Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0756CC4CEE2;
	Wed, 23 Apr 2025 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414678;
	bh=gmTewFvvAA2ss6kxUAoJF1HbwlnqsG2fYLPC6chwa5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOM/Y90YnRinmVoY3lacE472oJ4q8s2UdAr1WS+QmPW6e+7Oz0ngnRqYXBtAZpYEf
	 OO60QLKauvGW+eKBWugPQWyuU8fnIG5zXc/qriOR40i8rgKLniQuyHOSo7MG1+3+1i
	 TNQszzH6zm2VT7uLrG8N8iLp6UksjmVmQvY6XWEig2IUe7B7MDRbHMe+qyLFpuxNVV
	 lI+E8AVKwxk9iixOR0Fck//N3m28omEqGZLZxA6nk5X8M+lOgsP9SaZ9VUSy1K8P3/
	 MIRvct15/SXsRIgsujRmoM6UDU8SScaX7C5T/Jgc2PX1dLPZyjLbvbB/Sx2QplG0TP
	 6X6PTrYeZkJHw==
Date: Wed, 23 Apr 2025 15:24:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, krishna.chundru@oss.qualcomm.com,
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
	quic_cang@quicinc.com, quic_qianyu@quicinc.com
Subject: Re: [PATCH v2] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
Message-ID: <aAjqEUifc-W-MmJy@ryzen>
References: <20250422103623.462277-1-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422103623.462277-1-quic_wenbyao@quicinc.com>

On Tue, Apr 22, 2025 at 06:36:23PM +0800, Wenbin Yao wrote:
> As per DWC PCIe registers description 4.30a, section 1.13.43, NUM_OF_LANES
> named as PORT_LOGIC_LINK_WIDTH in PCIe DWC driver, is referred to as the
> "Predetermined Number of Lanes" in section 4.2.6.2.1 of the PCI Express
> Base 3.0 Specification, revision 1.0. This section explains the conditions
> need be satisfied for entering Polling.Configuration:
> 
> "Next state is Polling.Configuration after at least 1024 TS1 Ordered Sets
> were transmitted, and all Lanes that detected a Receiver during Detect
> receive eight consecutive training sequences.
> 
> Otherwise, after a 24 ms timeout the next state is:
> Polling.Configuration if
> (i) Any Lane, which detected a Receiver during Detect, received eight
> consecutive training sequences and a minimum of 1024 TS1 Ordered Sets are
> transmitted after receiving one TS1 or TS2 Ordered Set.
> And
> (ii) At least a predetermined set of Lanes that detected a Receiver during
> Detect have detected an exit from Electrical Idle at least once since
> entering Polling.Active.
> 
> Note: This may prevent one or more bad Receivers or Transmitters from
> holding up a valid Link from being configured, and allow for additional
> training in Polling.Configuration. The exact set of predetermined Lanes is
> implementation specific.
> 
> Note: Any Lane that receives eight consecutive TS1 or TS2 Ordered Sets
> should have detected an exit from Electrical Idle at least once since
> entering Polling.Active."
> 
> In a PCIe link that supports multiple lanes, if PORT_LOGIC_LINK_WIDTH is
> set to lane width hardware supports, all lanes that detect a receiver
> during the Detect phase must receive eight consecutive training sequences.
> Otherwise, the LTSSM cannot enter Polling.Configuration and link training
> will fail.
> 
> Therefore, always set PORT_LOGIC_LINK_WIDTH to 1, regardless of the number
> of lanes the port actually supports, to make linking up more robust. This
> setting will not affect the intended link width if all lanes are
> functional. Additionally, the link can still be established with at least
> one lane if other lanes are faulty.
> 
> Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
> Changes in v2:
> - Reword commit message.
> - Link to v1: https://lore.kernel.org/all/1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com/
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 97d76d3dc..be348b341 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -797,22 +797,19 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  	/* Set link width speed control register */
>  	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>  	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
> +	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>  	switch (num_lanes) {
>  	case 1:
>  		plc |= PORT_LINK_MODE_1_LANES;
> -		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
>  		break;
>  	case 2:
>  		plc |= PORT_LINK_MODE_2_LANES;
> -		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
>  		break;
>  	case 4:
>  		plc |= PORT_LINK_MODE_4_LANES;
> -		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
>  		break;
>  	case 8:
>  		plc |= PORT_LINK_MODE_8_LANES;
> -		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
>  		break;
>  	default:
>  		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
> -- 
> 2.34.1
> 

I still see the link to my EP (which also have this patch) using all
four lanes according to lspci, so:

Tested-by: Niklas Cassel <cassel@kernel.org>

