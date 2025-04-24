Return-Path: <linux-pci+bounces-26646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9BFA99FA1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711FC1944E67
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3665F198851;
	Thu, 24 Apr 2025 03:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2uvbdCn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0B4502A;
	Thu, 24 Apr 2025 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465817; cv=none; b=RHWaGAamszRFhguBewTuncvKzp+yk/sP3imDWl8O9TCz+yzxb32bY0b68H3aPUKshLLPRLiqcClDIxhEZ3CPS45cOtATwBbnqJTCjiu3HWMM3TSdTRiivlX+48gm17qbYC13ge/uuR4+uJJLj2L5kwcgphHZ8PPTw5TLgprPfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465817; c=relaxed/simple;
	bh=HhzHNCgULNfL7LJBad0ypUxqGGDAtAMFWHnub7l1hGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckrppIoZpchtE9JISSRkOqBsrD4L4Wmn6FCZQd1yYk2zMA4MHE5mXY0hTp83B5sk6zwaIQ1EN05wECL1jN+F5rntXlIs8Jig3zCY8qlulRnvjAMNJhVHcdfGU0Vs0CizxSJ6486vhpWHPoT93kHswrXH2UARIrriY+c55BvkT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2uvbdCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EE4C4CEE3;
	Thu, 24 Apr 2025 03:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745465816;
	bh=HhzHNCgULNfL7LJBad0ypUxqGGDAtAMFWHnub7l1hGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2uvbdCnr/2SmEEKHo9pru/KihtClbAMmd9KLYKDx6Txb1PNnrCinzs9VUVK+HCIC
	 /27h8ZbE2/2kuprCaA684E/y+kcgglhBFPNq1hzbFJbDoZVSDfjuA2C/R7G01SkvWg
	 BOV+onquxFFWrXSxG7DsSh9elFpU8DyNeYXp2AXlGOCNjxeXvCJhUqVIVZkN8yX8k7
	 kHu6iG6hqkYBqdS5S7VceUIG3pg4iWigKzOT4KyxpxkP05lMfhcpn4Vboc24q4JfVI
	 rY/O4YzA5/erTSV5y9xqAkN3O7lF8zOm+jrHQ1PoDnvTtzdkopHcJSqJWiZef5QBZr
	 bPChJ8ipUBTkA==
Date: Thu, 24 Apr 2025 11:36:48 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, peter.chen@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manikandan K Pillai <mpillai@cadence.com>
Subject: Re: [PATCH v4 3/5] PCI: cadence: Add header support for PCIe HPA
 controller
Message-ID: <aAmx0CaXh24co_cm@nchen-desktop>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-4-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424010445.2260090-4-hans.zhang@cixtech.com>

On 25-04-24 09:04:42, hans.zhang@cixtech.com wrote:
> From: Manikandan K Pillai <mpillai@cadence.com>
> 
> +/**
> + * struct cdns_plat_pcie_of_data - Register bank offset for a platform
> + * @is_rc: controller is a RC
> + * @is_hpa: Controller architecture is HPA
> + * @ip_reg_bank_off: ip register bank start offset
> + * @ip_cfg_ctrl_reg_off: ip config control register start offset
> + * @axi_mstr_common_off: AXI master common register start
> + * @axi_slave_off: AXI slave offset start
> + * @axi_master_off: AXI master offset start
> + * @axi_hls_off: AXI HLS offset start
> + * @axi_ras_off: AXI RAS offset
> + * @axi_dti_off: AXI DTI offset

The variable's suffix _off may confuse the reader, since off stands for
something is turned off and also used at device driver commonly,
suggest using _offset and align with your other code.

> + */
> +struct cdns_plat_pcie_of_data {
> +	u32 is_rc:1;
> +	u32 is_hpa:1;
> +	u32 ip_reg_bank_off;
> +	u32 ip_cfg_ctrl_reg_off;
> +	u32 axi_mstr_common_off;
> +	u32 axi_slave_off;
> +	u32 axi_master_off;
> +	u32 axi_hls_off;
> +	u32 axi_ras_off;
> +	u32 axi_dti_off;
>  };
>  
> +static inline void cdns_pcie_hpa_writel(struct cdns_pcie *pcie,
> +					enum cdns_pcie_reg_bank bank,
> +					u32 reg,
> +					u32 value)
> +{
> +	u32 offset =  cdns_reg_bank_to_off(pcie, bank);

More than one blank space after "=".

> +}
> +
> +static inline u32 cdns_pcie_hpa_readl(struct cdns_pcie *pcie,
> +				      enum cdns_pcie_reg_bank bank,
> +				      u32 reg)
> +{
> +	u32 offset =  cdns_reg_bank_to_off(pcie, bank);

ditto

-- 

Best regards,
Peter

