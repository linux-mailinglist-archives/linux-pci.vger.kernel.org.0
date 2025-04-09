Return-Path: <linux-pci+bounces-25600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96CBA833F8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 00:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A75A8A0F5B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407C1215F4B;
	Wed,  9 Apr 2025 22:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc/HuFTP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19837214A64
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236574; cv=none; b=UVcHuaH2Ukn72ZtHL8S5OZ06t2sPK18upUVxSfsqQXM3eK4MhpjdnTdkpNrcn43dW4luKhex9keUVSrTgaCdnNRv6TNnWmgomtOxsX0bQltg9r9HoLXbHF06wmtg2T2DWgsnMI3lxERmTVQPJU9bz4+YRcYKrr0RzYhRZg7OlQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236574; c=relaxed/simple;
	bh=k3JW0TzaUfLa8ZcM6+rN56EQqG/gP+lTcIwZhwKlSSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=knp39+UkumNDZEk1BGjkZPGySCleK8COrPhbgo0SW2gWrebSVmMFSk8d7fp1BQccpW6a7hBo1kUPiWYGF65w5XtTkDdd/G0li/i420SY7juSIzTFB+nK7C03xQIwKOy0o+i1cC5ClCgaX1/Yruq38lpBkIw7dnHIA/8JMc1yc7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc/HuFTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D787C4CEE2;
	Wed,  9 Apr 2025 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744236573;
	bh=k3JW0TzaUfLa8ZcM6+rN56EQqG/gP+lTcIwZhwKlSSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hc/HuFTPTefoPtHypd8bfph374e3hHCylRS2IWC5TJtxgY5aYwpbibbSXRzDynXi9
	 /Ybqrcmd54gynGjhMqR0NLce9mvXi8Qu7KqDFqDywJGO7K3S3dl8cly0pqCmCixMUr
	 ftN0apKefnS4TRH06jqyOz+TTaQzEURktDXLHUExU+GY7LncdSJb5lybPtRQ6C/hGZ
	 N2qEJzQYKwQLHoJe/1zxdxCc8vxdtMrMHnv0bM61+Fqu3DJrKzm6jJRvM4mOftlc5f
	 Q3g5d5aRjTZB5cuNvSj9gGAqiJasM5EgsQchQSqXIFMGIue3xkjc1vz5ZGlhdYZLGs
	 nhaGdnUfmsA6w==
Date: Wed, 9 Apr 2025 17:09:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/7] PCI: cadence: Add platform related architecture and
 register information
Message-ID: <20250409220932.GA299761@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C5086A79888CB5AD0A01AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Thu, Mar 27, 2025 at 11:39:43AM +0000, Manikandan Karunakaran Pillai wrote:
> Add the register bank offsets for different platforms and update the global
> platform data - platform architecture, EP or RP configuration and the
> correct values of register offsets for different register banks during the
> platform probe

Add period.

> @@ -72,6 +81,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  		rc = pci_host_bridge_priv(bridge);
>  		rc->pcie.dev = dev;
>  		rc->pcie.ops = &cdns_plat_ops;
> +		rc->pcie.is_hpa = data->is_hpa;
> +		/*

Add a blank line between the code and the start of the comment.

> +		 * Store all the register bank offsets
> +		 */
> +		rc->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off = data->ip_reg_bank_off;
> +		rc->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off = data->ip_cfg_ctrl_reg_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off = data->axi_mstr_common_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_master_off = data->axi_master_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_slave_off = data->axi_slave_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_hls_off = data->axi_hls_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_ras_off = data->axi_ras_off;
> +		rc->pcie.cdns_pcie_reg_offsets.axi_dti_off = data->axi_dti_off;

But what's the point of copying all these offsets?  Can't you just
keep the offsets in a couple separate structures and save the pointer?

It looks like cdns_plat_pcie_host_of_data and
cdns_plat_pcie_ep_of_data could use the same pointer, as could
cdns_plat_pcie_hpa_host_of_data and cdns_plat_pcie_hpa_ep_of_data.

> @@ -99,6 +121,19 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  
>  		ep->pcie.dev = dev;
>  		ep->pcie.ops = &cdns_plat_ops;
> +		ep->pcie.is_hpa = data->is_hpa;
> +		/*

Add blank line again.

> +		 * Store all the register bank offset

>  static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
>  	.is_rc = true,
> +	.is_hpa = false,
> +	.ip_reg_bank_off = 0x0,
> +	.ip_cfg_ctrl_reg_off = 0x0,
> +	.axi_mstr_common_off = 0x0,
> +	.axi_slave_off = 0x0,
> +	.axi_master_off = 0x0,
> +	.axi_hls_off = 0x0,
> +	.axi_ras_off = 0x0,
> +	.axi_dti_off = 0x0,

In my opinion, you should only initialize fields that are non-false
and non-zero.  Then the differences are more obvious.

Bjorn

