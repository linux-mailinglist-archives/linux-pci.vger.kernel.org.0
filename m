Return-Path: <linux-pci+bounces-7273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E18C074F
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8976E1F22EDE
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 22:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A2133285;
	Wed,  8 May 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCjR1f+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F429130E4B;
	Wed,  8 May 2024 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207104; cv=none; b=JKUrQPwOLLZ0iolFF6M40S8DMOINZHfPbcKvEADhJVY0fE6thvz+/O+ttdKPfPtFX+YLONqKPM5Q3sib5Md8WtU2NrQ/TAEF1DRC5muE2FNTUIi/wnir3Hh8lsxwmZQ9bIxIzCpzcW3yXRJ87r3rFK4ByoNNYl91uYCsg0VBWOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207104; c=relaxed/simple;
	bh=v8DQvHY+2r78tKC2XBRoOvgdQLkOP1CAvCK2xKElKmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SrUVz9Qbx7xfOdYEn3OOaOtR3aVVbhrJeKfjI0FKqceyFVeeJShTKVSvLd3UCL2dcxTfX2DBwlwKZWXPD/f4KDX6Pk/OfbP1+H/+ZO+rQRoTYxWckPEgT3JjgA4mnI3obaFjOeAL3ksto1AssS/3Sc0AcSJbFnkyCCLci7JIYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCjR1f+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7E5C113CC;
	Wed,  8 May 2024 22:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715207103;
	bh=v8DQvHY+2r78tKC2XBRoOvgdQLkOP1CAvCK2xKElKmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fCjR1f+6ZoEAdzjfwhRhxRiNTSNrZ26+rWIfMOxL3Rs1Qn7TUEYWbOVSwKIITkbC/
	 BVSnZxsxr1heihDdECVlpXkUHI2u6pUM+OrUCAXg4R+6vxGFsuC3/49Aa76+nXB1ta
	 z2hIkQLVzjpI7GXUFlOD06o/fwFUXdOLbn1isLXC71gXZiYuXI/i0XD7vha0VEFzlb
	 /8bpWSmvNcR2K8EBp1O2DrdNQIqp73+Pa6Y4DH9kP5Zcr/mC0J3BHvk4R9xjLRAqjJ
	 ZYaub2vGZMEd2EEvPszqGlMAwY5iXAQBxwSd+fS5F1Dm4CgpZdCkzHlapBxnpwLARp
	 hjTi3K5jb2/bg==
Date: Wed, 8 May 2024 17:24:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
	tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
	robert.moore@intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH v2 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20240508222459.GA1791619@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218030430.783495-4-LeoLiu-oc@zhaoxin.com>

On Mon, Dec 18, 2023 at 11:04:30AM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Call the func pci_acpi_program_hest_aer_params() for every PCIe device,
> the purpose of this function is to extract register value from HEST PCIe
> AER structures and program them into AER Capabilities.
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> ---
>  drivers/pci/pci-acpi.c | 98 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h      |  9 ++++
>  drivers/pci/probe.c    |  1 +
>  3 files changed, 108 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 004575091596..3a183d5e20cb 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/rwsem.h>
> +#include <acpi/apei.h>
>  #include "pci.h"
>  
>  /*
> @@ -783,6 +784,103 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  	return -ENODEV;
>  }
>  
> +#ifdef CONFIG_ACPI_APEI
> +static void program_hest_aer_endpoint(struct acpi_hest_aer_common aer_endpoint,
> +				struct pci_dev *dev, int pos)
> +{
> +	u32 uncor_mask;
> +	u32 uncor_severity;
> +	u32 cor_mask;
> +	u32 adv_cap;
> +
> +	uncor_mask = aer_endpoint.uncorrectable_mask;
> +	uncor_severity = aer_endpoint.uncorrectable_severity;
> +	cor_mask = aer_endpoint.correctable_mask;
> +	adv_cap = aer_endpoint.advanced_capabilities;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, uncor_mask);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, uncor_severity);
> +	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, cor_mask);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP, adv_cap);

This is named for "endpoint", but it is used for Root Ports,
Endpoints, and PCIe to PCI/PCI-X bridges.  It relies on these four
fields being in the same place for all those HEST structures.

That makes good sense, but maybe should have a one-line hint about
this and maybe even a compiletime_assert().

> +}
> +
> +static void program_hest_aer_root(struct acpi_hest_aer_root *aer_root, struct pci_dev *dev, int pos)
> +{
> +	u32 root_err_cmd;
> +
> +	root_err_cmd = aer_root->root_error_command;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, root_err_cmd);
> +}
> +
> +static void program_hest_aer_bridge(struct acpi_hest_aer_bridge *hest_aer_bridge,
> +				struct pci_dev *dev, int pos)
> +{
> +	u32 uncor_mask2;
> +	u32 uncor_severity2;
> +	u32 adv_cap2;
> +
> +	uncor_mask2 = hest_aer_bridge->uncorrectable_mask2;
> +	uncor_severity2 = hest_aer_bridge->uncorrectable_severity2;
> +	adv_cap2 = hest_aer_bridge->advanced_capabilities2;
> +
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK2, uncor_mask2);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER2, uncor_severity2);
> +	pci_write_config_dword(dev, pos + PCI_ERR_CAP2, adv_cap2);
> +}
> +
> +static void program_hest_aer_params(struct hest_parse_aer_info info)
> +{
> +	struct pci_dev *dev;
> +	int port_type;
> +	int pos;
> +	struct acpi_hest_aer_root *hest_aer_root;
> +	struct acpi_hest_aer *hest_aer_endpoint;
> +	struct acpi_hest_aer_bridge *hest_aer_bridge;
> +
> +	dev = info.pci_dev;
> +	port_type = pci_pcie_type(dev);

I'd put these two initializations up at the declarations, e.g.,

  struct pci_dev *dev = info.pci_dev;
  int port_type = pci_pcie_type(dev);

> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!pos)
> +		return;
> +
> +	switch (port_type) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +		hest_aer_root = info.hest_aer_root_port;
> +		program_hest_aer_endpoint(hest_aer_root->aer, dev, pos);
> +		program_hest_aer_root(hest_aer_root, dev, pos);
> +		break;
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		hest_aer_endpoint = info.hest_aer_endpoint;
> +		program_hest_aer_endpoint(hest_aer_endpoint->aer, dev, pos);
> +		break;
> +	case PCI_EXP_TYPE_PCI_BRIDGE:
> +	case PCI_EXP_TYPE_PCIE_BRIDGE:

PCI_EXP_TYPE_PCIE_BRIDGE is a PCI/PCI-X to PCIe Bridge, also known as
a "reverse bridge".  This has a conventional PCI or PCI-X primary
interface and a PCIe secondary interface.  It's not clear to me that
these bridges can support AER.  

For one thing, the AER Capability must be in extended config space,
which would only be available for PCI-X Mode 2 reverse bridges.

The acpi_hest_aer_bridge certainly makes sense for
PCI_EXP_TYPE_PCI_BRIDGE (a PCIe to PCI/PCI-X bridge), but the ACPI
spec (r6.5, sec 18.3.2.6) is not very clear about whether it also
applies to PCI_EXP_TYPE_PCIE_BRIDGE (a reverse bridge).

Do you actually need this PCI_EXP_TYPE_PCIE_BRIDGE case?

> +		hest_aer_bridge = info.hest_aer_bridge;
> +		program_hest_aer_endpoint(hest_aer_bridge->aer, dev, pos);
> +		program_hest_aer_bridge(hest_aer_bridge, dev, pos);
> +		break;
> +	default:
> +		return;
> +	}
> +}

