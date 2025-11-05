Return-Path: <linux-pci+bounces-40350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E92C3644A
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3145C4F7945
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57C30146B;
	Wed,  5 Nov 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEhS4opn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08911DF256;
	Wed,  5 Nov 2025 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355425; cv=none; b=hCHR4pZuQe+JSqWtW3RMfbzc4yIYctH7TfJZIZvwh+J73yHf4dLbowSj4IxfgROjGxv8CvySeLB8ue/FBHps/4jOoBYA1i72msxP5xgU1NxfZ2GkuymfgT1VQJrUqeDEprhbQ13pm+JdvxZCmBBLwwY5rm1+ZxujN0+zYfwPy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355425; c=relaxed/simple;
	bh=oaPdlpBofdsmKuByKa4GxzGVplmxokinAJprGu/nEE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOZE8pHE4t5kltpatoZGQ2OpetJQUzR+rs0xpsE02CoDTzBTGTMMawWP3F+ZIBjHYthclNGEMd6FgmDhpCmy6WjwnIgvIcSgUa46vXU1z/Xupr2tKLnpXH1diKeMG+kQqBDX71S5fmX6/fpXCkzuMSGVY9Jk1cbLR5Ui8NQ7lU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEhS4opn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDF2C4CEF5;
	Wed,  5 Nov 2025 15:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762355425;
	bh=oaPdlpBofdsmKuByKa4GxzGVplmxokinAJprGu/nEE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEhS4opnOWrntlWlcJU82PLlbQQ/6tnpU+NzNmKhC0h5KycxiLh3uPmz+j+S7Oak+
	 9HMSGfKvUG2jxyJQvQ6tVrxMkKVwfiDBi6ak6PO5AQBuiCd7A9DAbHxYvrMlypeQZE
	 nmwhWAbupCJw4ySM8W+YJWeTZyCaki+WUki31WRNqQIWS14sdI+12oRqNSDhW9NPcH
	 VQmMnIN0k3sLPwpQgdNkq7nyHvGwoppWmJxi/T79RuH7om/+6dYcgT2KS6y1hg19G3
	 H9GAm0SKuqhyp6eG2ADnuHVl6zZ1o5IS2awGpV9r9hXIjTOmWmw8jbPuME8EhD33Jb
	 CyHkULgyD+cFw==
Date: Wed, 5 Nov 2025 20:40:14 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, 18255117159@163.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2] PCI: cadence: Enable support for applying lane
 equalization presets
Message-ID: <57nw5lae3ev7krf3dtrllxaq2wvoajijq62ac5uttvajxjvpor@cmahebflp37x>
References: <20251028134601.3688030-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251028134601.3688030-1-s-vadapalli@ti.com>

On Tue, Oct 28, 2025 at 07:15:58PM +0530, Siddharth Vadapalli wrote:
> The PCIe Link Equalization procedure allows peers on a PCIe Link to
> improve the signal quality by exchanging transmitter presets and
> receiver preset hints in the form of Ordered Sets.
> 
> For link speeds of 8.0 GT/s and above, the transmitter presets and the
> receiver preset hints are configurable parameters which can be tuned to
> establish a stable link. This allows setting up a stable link that is
> specific to the peers across a Link.
> 
> The device-tree property 'eq-presets-Ngts' (eq-presets-8gts,
> eq-presets-16gts, ...) specifies the transmitter presets and receiver
> preset hints to be applied to every lane of the link for every supported
> link speed that is greater than or equal to 8.0 GT/s.
> 
> Hence, enable support for applying the 'optional' lane equalization
> presets when operating in the Root-Port (Root-Complex / Host) mode.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20251028.

Just rebase on top of pci/main or any topic branches in pci tree if there are
any dependency.

> It also applies cleanly on v6.18-rc1.
> 
> Link to v1 patch:
> https://lore.kernel.org/r/20251027133013.2589119-1-s-vadapalli@ti.com/
> Changes since v1:
> - Implemented Bjorn's suggestion of adding 'fallthrough' keyword in
>   switch-case to avoid compilation warnings, since 'fallthrough' is
>   intentional.
> 
> Regards,
> Siddharth.
> 
>  .../controller/cadence/pcie-cadence-host.c    | 85 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h |  5 ++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index fffd63d6665e..ae85ad8cce82 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -168,6 +168,90 @@ static void cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val | CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
>  }
>  
> +static void cdns_pcie_setup_lane_equalization_presets(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	struct device *dev = pcie->dev;
> +	struct device_node *np = dev->of_node;
> +	int max_link_speed, max_lanes, ret;
> +	u32 lane_eq_ctrl_reg;
> +	u16 cap;
> +	u16 *presets_8gts;
> +	u8 *presets_ngts;
> +	u8 i, j;
> +
> +	ret = of_property_read_u32(np, "num-lanes", &max_lanes);
> +	if (ret)
> +		return;
> +
> +	/* Lane Equalization presets are optional, so error message is not necessary */
> +	ret = of_pci_get_equalization_presets(dev, &rc->eq_presets, max_lanes);
> +	if (ret)
> +		return;
> +
> +	max_link_speed = of_pci_get_max_link_speed(np);

'max-link-speed' property is used to *limit* the max link speed of the
controller, in case the hardware default value is wrong or to workaround the
hardware defect. If you goal is to find the actual max link speed of the Root
Port, you should read the Link Capabilities register.

Unfortunately, the ti,j721e-pci-host.yaml binding has marked this property as
'required'. It should've been optional instead.

> +	if (max_link_speed < 0) {
> +		dev_err(dev, "%s: link-speed unknown, skipping preset setup\n", __func__);

Don't print the function names in error log.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

