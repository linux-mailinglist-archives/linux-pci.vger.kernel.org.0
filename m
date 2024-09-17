Return-Path: <linux-pci+bounces-13255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C351397AC45
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 09:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A70C1F22713
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 07:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DB14A4D6;
	Tue, 17 Sep 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKj5ky0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8F7F477;
	Tue, 17 Sep 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558711; cv=none; b=YygJjqjUdK/5VOx4BQFLbn/hD48OzzOF1wHdLl2bw7YEs6trq7YJrvRpFN6Aqqg43miNY/eLfMCyhUgZE1d2qaj5ovOLRlIRpsWw89QIk/rFhZ3rTlLbpdW1kaLQdz/s7vi1Jzktf0nAys5CnVPZl4psjMGVM422+o5hRaUkdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558711; c=relaxed/simple;
	bh=W9FGfW3WwX5TvvthiroecfgwLNT2pwNbL4OeKD5b7GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnyBO/hUvT1xCYhewq0fmSvWO4OdnYyoE4DuxtQQ9182rHA+1VUCG8xkMZlvvUcGO4N/AnRTi0Xst2X/TwRDM+tgt39i0BJ4JlMe0+B1YDutZiDeie4TsOMzWpbNiHCqSyksDcBrFq/gWVj9412xYjTtPNLMV6j6+5Ldo/mE9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKj5ky0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D565C4CECE;
	Tue, 17 Sep 2024 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726558711;
	bh=W9FGfW3WwX5TvvthiroecfgwLNT2pwNbL4OeKD5b7GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKj5ky0RMiLXrrPB/xPe5xRerlV2/ArPrqisvhkNlrLz+KlGKurcuZnUY0U6XrDpL
	 JAzWEOaEq22x89QfKEMdEigAxRySjFEfLbL29a1lJgVgrfu65rC5b3z9zbYC9c7mss
	 g4vAAZpcLBLIapuT3KJ/qr7bnaxnmT8CXsj/vNd/ANZngjDVjzZNAxFPWDttUgsmsK
	 o+o5JUs3y95ZXh3deyIys66IBEKiEacJQLPEaI/jQukb0NCWpEh/+jTTc/k97LyImk
	 HD9hpy1NfGZYg5yRGk1mb9KUabxKKbHoAVhYjxhM4Fhj3nEIVTZGQ4A6KyUmOklHwv
	 mDD1iNdKJBjtw==
Date: Tue, 17 Sep 2024 08:38:24 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V5 1/5] PCI: Add TLP Processing Hints (TPH) support
Message-ID: <20240917073824.GJ167971@kernel.org>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-2-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916205103.3882081-2-wei.huang2@amd.com>

On Mon, Sep 16, 2024 at 03:50:59PM -0500, Wei Huang wrote:
> Add support for PCIe TLP Processing Hints (TPH) support (see PCIe r6.2,
> sec 6.17).
> 
> Add missing TPH register definitions in pci_regs.h, including the TPH
> Requester capability register, TPH Requester control register, TPH
> Completer capability, and the ST fields of MSI-X entry.
> 
> Introduce pcie_enable_tph() and pcie_disable_tph(), enabling drivers to
> toggle TPH support and configure specific ST mode as needed. Also add a
> new kernel parameter, "pci=notph", allowing users to disable TPH support
> across the entire system.
> 
> Co-developed-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

...

> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c

...

> +/**
> + * pcie_enable_tph - Enable TPH support for device using a specific ST mode
> + * @pdev: PCI device
> + * @mode: ST mode to enable. Current supported modes include:
> + *
> + *   - PCI_TPH_ST_NS_MODE: NO ST Mode
> + *   - PCI_TPH_ST_IV_MODE: Interrupt Vector Mode
> + *   - PCI_TPH_ST_DS_MODE: Device Specific Mode
> + *
> + * Checks whether the mode is actually supported by the device before enabling
> + * and returns an error if not. Additionally determines what types of requests,
> + * TPH or extended TPH, can be issued by the device based on its TPH requester
> + * capability and the Root Port's completer capability.
> + *
> + * Return: 0 on success, otherwise negative value (-errno)
> + */
> +int pcie_enable_tph(struct pci_dev *pdev, int mode)
> +{
> +	u32 reg;
> +	u8 dev_modes;
> +	u8 rp_req_type;
> +
> +	/* Honor "notph" kernel parameter */
> +	if (pci_tph_disabled)
> +		return -EINVAL;
> +
> +	if (!pdev->tph_cap)
> +		return -EINVAL;
> +
> +	if (pdev->tph_enabled)
> +		return -EBUSY;
> +
> +	/* Sanitize and check ST mode comptability */

Hi Wei Huang, all,

Another minor nit from my side (the last one, I think):

comptability -> compatibility

Flagged by checkpatch.pl --codespell

> +	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
> +	dev_modes = get_st_modes(pdev);
> +	if (!((1 << mode) & dev_modes))
> +		return -EINVAL;
> +
> +	pdev->tph_mode = mode;
> +
> +	/* Get req_type supported by device and its Root Port */
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
> +	if (FIELD_GET(PCI_TPH_CAP_EXT_TPH, reg))
> +		pdev->tph_req_type = PCI_TPH_REQ_EXT_TPH;
> +	else
> +		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
> +
> +	rp_req_type = get_rp_completer_type(pdev);
> +
> +	/* Final req_type is the smallest value of two */
> +	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
> +
> +	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
> +		return -EINVAL;
> +
> +	/* Write them into TPH control register */
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, &reg);
> +
> +	reg &= ~PCI_TPH_CTRL_MODE_SEL_MASK;
> +	reg |= FIELD_PREP(PCI_TPH_CTRL_MODE_SEL_MASK, pdev->tph_mode);
> +
> +	reg &= ~PCI_TPH_CTRL_REQ_EN_MASK;
> +	reg |= FIELD_PREP(PCI_TPH_CTRL_REQ_EN_MASK, pdev->tph_req_type);
> +
> +	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
> +
> +	pdev->tph_enabled = 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pcie_enable_tph);

...

