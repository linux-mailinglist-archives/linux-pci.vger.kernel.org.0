Return-Path: <linux-pci+bounces-29063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DEBACF9E0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4714189B0EE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF0A27E7D9;
	Thu,  5 Jun 2025 22:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7J4N7AR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67A628E17;
	Thu,  5 Jun 2025 22:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749164253; cv=none; b=N3z6Wp2+daDDtjxx+NtE3nsHUQLB8IhGFpYf47FWkOM1PB+ZnWj63F3+HsM9ZwHZMtI9jkhPVRslEALdPLVw4oQ8mZp1NawqhdwfzhZT5V2t5p44Zd+kCtDd+nmKLorXZG8e2plRCmg05uFpdvxmY10osYYY6boQ57eMU7NVQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749164253; c=relaxed/simple;
	bh=ttq74J8zgl/CqPTmFPHRqNeX1HBQ5yWBTsGcAVjdt5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nqDKZD1dx/NzCe1jsLqRmiVdhKTyPVSwa2LGHxN9I/TqlrLetliPViGU62J6ajYEQsddgEw50XTZJBFGrn3GSY31VmV2JgDKMRfE45UcQyuHT6M+6B5l8jbRj/rXCnUdbrSF45uKe7vffqHrFlTEabyaYMYUlI2HYHARKw8kOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7J4N7AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30293C4CEE7;
	Thu,  5 Jun 2025 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749164252;
	bh=ttq74J8zgl/CqPTmFPHRqNeX1HBQ5yWBTsGcAVjdt5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F7J4N7AROXpSNCIcWVGENA6Qg3/33Ich5ukiqOms+VM42I5Zq1EHSHryln5/6ji+/
	 bvlS2Ffc/4RS8aVyTKpO7Wc83areCxJzQ3L/Evs3CG9vuC+Tk6fYcvJT8O+90wjHnb
	 F8cJlAE+J6PzkZjQzSCI+jPvUWCJGbPf1MiGlZNDgD3mxKIxzmFCLvpT3kFBcvpgyI
	 RXvFQPh6UYp7n7DG0YI6U1PdH7I1oTrkbfVLZYKi9Ajk6rLWDdKavUoB2rf05X4Hwk
	 hYmDWxDGxGWYve2Iy+Tm6lzEYHj8Y/ZNW7StUx+lCwF4wRcJV1tPYGObRoxY8PiQOD
	 wW3m6rV4OlNMw==
Date: Thu, 5 Jun 2025 17:57:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org, john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 4/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
Message-ID: <20250605225730.GA625963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530111917.1495023-5-claudiu.beznea.uj@bp.renesas.com>

On Fri, May 30, 2025 at 02:19:13PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.

> +/* Timeouts */
> +#define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
> +#define RZG3S_LTSSM_STATE_TIMEOUT_US		1000
> +#define RZG3S_LS_CHANGE_TIMEOUT_US		1000
> +#define RZG3S_LINK_UP_TIMEOUT_US		500000

Are any of these timeouts related to values in the PCIe spec?  If so,
use #defines from drivers/pci/pci.h, or add a new one if needed.

If they come from the RZ/G3S spec, can you include citations?

> +static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host, bool probe)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* Initialize the PCIe related registers */
> +	ret = rzg3s_pcie_config_init(host);
> +	if (ret)
> +		return ret;
> +
> +	/* Initialize the interrupts */
> +	rzg3s_pcie_irq_init(host);
> +
> +	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
> +					  host->cfg_resets);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for link up */
> +	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
> +				 !(val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS), 5000,
> +				 RZG3S_LINK_UP_TIMEOUT_US);

Where do we wait for PCIE_T_RRS_READY_MS before pci_host_probe()
starts issuing config requests to enumerate devices?

> +	if (ret) {
> +		reset_control_bulk_assert(host->data->num_cfg_resets,
> +					  host->cfg_resets);
> +		return ret;
> +	}
> +
> +	val = readl(host->axi + RZG3S_PCI_PCSTAT2);
> +	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
> +
> +	val = FIELD_GET(RZG3S_PCI_PCSTAT2_STATE_RX_DETECT, val);
> +	dev_info(host->dev, "PCIe x%d: link up\n", hweight32(val));
> +
> +	if (probe) {
> +		ret = devm_add_action_or_reset(host->dev,
> +					       rzg3s_pcie_cfg_resets_action,
> +					       host);
> +	}
> +
> +	return ret;
> +}

> +		 * According to the RZ/G3S HW manual (Rev.1.10, section
> +		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
> +		 * 12 LSB bits to be 0xfff. Extract 1 from size for this.

s/Extract/Subtract/

> +		 */
> +		size = roundup_pow_of_two(size) - 1;

