Return-Path: <linux-pci+bounces-30401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40470AE470C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52D2443A29
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703D24A067;
	Mon, 23 Jun 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE8iV91v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D514524C669
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688938; cv=none; b=bdevAiwJT6CHaY2cqkqzaZ+gHGZYUOXthcPZSJOJYClGqFnRNYkDJAs6I0fBed8BB2FiwqR3Vc5MdUGTtgzbOyC/cmRWt6tygLFkGIq5sy/DdMVTHYCD9WMFb7jthwSPZekzmfCiuCrY3X2pBGiMWuW4BSnTto4mO5lTAWvIaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688938; c=relaxed/simple;
	bh=shX5hlmjJfaDe+DTouCt072DInTwBudmDsKWHyroxj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGx2fOJ7A8aVGCfpDYCmb8xM01NrQ+VUTn57Cj6hBhzyBZfnSmIEQmOg9t2OgpLwxDgpRcBwNj9Eldh5Pbo+1TRg5A7dpZ6Q+7jH/RICmfwDH07YoZT012N3DRoxZriMC3X/t+us8CyGCUaPeI4i9H3u0uQJvL8TYaHRgzMI+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE8iV91v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BF8C4CEEA;
	Mon, 23 Jun 2025 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750688938;
	bh=shX5hlmjJfaDe+DTouCt072DInTwBudmDsKWHyroxj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vE8iV91vNQJ/iJnyjMFuuv0qqGycQTRioLAjSWUj2ylrAv9K0FGUZPWyNETXxhXPK
	 CiKkSQxFMCkSvBlcEvK4am2gRWW7CywUUH1iwzlhtVR2SN+mh/Lwcls9wS5hlTZw/Q
	 fRMFeSsRAWMsEAU8Th1d8dob6+TLdp1qPk6Q7eM8N2FxHmAj2+GfAKCp6JEk/SHcNo
	 ragJdpTBYo3H7qXugKDOFfXZomx6viJDfgGtIOEY8/3moid2SV3eqN9NkIEN+NDeD7
	 wqwcfXzO3WcLUQ2oG37PswHbvmlx3ryc9heD9Wd2mne5R+49azCqXZicBdfJWobc1A
	 m3oQgdWDjDR0A==
Date: Mon, 23 Jun 2025 08:28:55 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/6] PCI: dwc: Ensure that dw_pcie_wait_for_link()
 waits 100 ms after link up
Message-ID: <hmkx6vjoqshthk5rqakcyzneredcg6q45tqhnaoqvmvs36zmsk@tzd7f44qkydq>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-13-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613124839.2197945-13-cassel@kernel.org>

On Fri, Jun 13, 2025 at 02:48:44PM +0200, Niklas Cassel wrote:
> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
> training completes before sending a Configuration Request.
> 
> Add this delay in dw_pcie_wait_for_link(), after the link is reported as
> up. The delay will only be performed in the success case where the link
> came up.
> 
> DWC glue drivers that have a link up IRQ (drivers that set
> use_linkup_irq = true) do not call dw_pcie_wait_for_link(), instead they
> perform this delay in their threaded link up IRQ handler.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 4d794964fa0f..24903f67d724 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -714,6 +714,13 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		return -ETIMEDOUT;
>  	}
>  
> +	/*
> +	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
> +	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
> +	 * after Link training completes before sending a Configuration Request.
> +	 */

As the comment clearly states, we should only wait if the downstream port
supports link speed > 5.0 GT/s. So you should have the below check:

	if (pci->max_link_speed > 1)
		msleep(PCIE_RESET_CONFIG_WAIT_MS);

- Mani

-- 
மணிவண்ணன் சதாசிவம்

