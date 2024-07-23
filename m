Return-Path: <linux-pci+bounces-10674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A0193A91D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 00:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED841F236C3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 22:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E3146A9A;
	Tue, 23 Jul 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2vaU5DY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025DB1DDD6;
	Tue, 23 Jul 2024 22:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773353; cv=none; b=dhbvL4/M/EwronNEgppu16olBbzjLqdeVxCgyzGj4Sb1P6AwSy7hKvniaGLytBq16p7gAQi2+JdJ6oOvor27gpZ6/swBAZvE10QcZxd6I9n+h9g9O2dC+zmgm4Ec0SZgHGN4ImHMXtzaPpwz8iNc9T0S1uqziVaMjtGZh287DiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773353; c=relaxed/simple;
	bh=QcBPciMEEglSS9n38UzLJ7yUmdEkQ+0xU3UWCPIbcJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IcaojyQbM92Y750hpOz+/0tR8sVuDKsCWHRLeh/Fz5AQJmiWJAV0EiQ0P/F8ZUf6jQX9Qq9L9/tabro5fhF0Sy+ikyicZm+NLN72Q4jFwVtnxg3aF49ne9wgRgDBVCAZjLx2RqbPQV6pqxkn2Xm3/AwaRbzWPN34RXcw1D2AhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2vaU5DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A19C4AF0A;
	Tue, 23 Jul 2024 22:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773352;
	bh=QcBPciMEEglSS9n38UzLJ7yUmdEkQ+0xU3UWCPIbcJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d2vaU5DYRNG3/ujzG2Lh9oaDL+cbPXoMlZ4dQpCGRZcElPGZKojhfIWcLMQ5+NRkq
	 o378jrN3zQ2cd1dOTA2NyVaWrXE14PK/RP5sPlIrOZ2fH3ZmR/lj4XVCArxWigNZ9o
	 6WAkjw9Mye34IcgOgNqXPUmycqrSXhnWWUEai0WyVREa6S+oXcbP+nLBka+pzYMGnS
	 luAezrQkoRUzte/dI4WIi5liKNry5u40Ypr2lcH5z2g+808/Uj8F8NDC9B48cztNkd
	 Ro5Q8K62LKn4qBVjkB43Bo24Utt1Mu8xbWhAuErdVt9ZaZmH1vTNlNmqRVzn1Rcsvs
	 MXqz5VPRHlNVQ==
Date: Tue, 23 Jul 2024 17:22:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com
Subject: Re: [PATCH V3 06/10] PCI/TPH: Introduce API to retrieve TPH steering
 tags from ACPI
Message-ID: <20240723222229.GA759742@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-7-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:07PM -0500, Wei Huang wrote:
> Add an API function to allow endpoint device drivers to retrieve
> steering tags for a specific cpu_uid. This is achieved by invoking
> ACPI _DSM on device's root port.

s/an API function/<name of function>/

Also include function name in subject line.

> + * The st_info struct defines the steering tag returned by the firmware _DSM
> + * method defined in PCI Firmware Spec r3.3, sect 4.6.15 "_DSM to Query Cache
> + * Locality TPH Features"

I don't know what I'm missing, but my copy of the r3.3 spec, dated Jan
20, 2021, doesn't have sec 4.6.15.

> +static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
> +			   union st_info *st_tag)
> +{
> +	switch (req_type) {
> +	case PCI_TPH_REQ_TPH_ONLY: /* 8 bit tags */
> +		switch (mem_type) {
> +		case TPH_MEM_TYPE_VM:
> +			if (st_tag->vm_st_valid)
> +				return st_tag->vm_st;
> +			break;
> +		case TPH_MEM_TYPE_PM:
> +			if (st_tag->pm_st_valid)
> +				return st_tag->pm_st;
> +			break;
> +		}
> +		break;
> +	case PCI_TPH_REQ_EXT_TPH: /* 16 bit tags */
> +		switch (mem_type) {
> +		case TPH_MEM_TYPE_VM:
> +			if (st_tag->vm_xst_valid)
> +				return st_tag->vm_xst;
> +			break;
> +		case TPH_MEM_TYPE_PM:
> +			if (st_tag->pm_xst_valid)
> +				return st_tag->pm_xst;
> +			break;
> +		}
> +		break;
> +	default:
> +		pr_err("invalid steering tag in ACPI _DSM\n");

Needs to mention a specific device.

> +static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid, u8 ph,
> +				  u8 target_type, bool cache_ref_valid,
> +				  u64 cache_ref, union st_info *st_out)

IMO you can omit ph, target_type, cache_ref_valid, etc until you have
a need for them.  I don't see the point of parameters that always have
the same constant values.

> +{
> +	union acpi_object arg3[3], in_obj, *out_obj;
> +
> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7, BIT(TPH_ST_DSM_FUNC_INDEX)))

Wrap the code and comments in this file to fit in 80 columns instead
of 85 or whatever you used.  Lines longer than 80 are OK for printf
strings but pointless for comments, etc.

> +		return AE_ERROR;
> +
> +	/* DWORD: feature ID (0 for processor cache ST query) */
> +	arg3[0].integer.type = ACPI_TYPE_INTEGER;
> +	arg3[0].integer.value = 0;
> +
> +	/* DWORD: target UID */
> +	arg3[1].integer.type = ACPI_TYPE_INTEGER;
> +	arg3[1].integer.value = cpu_uid;
> +
> +	/* QWORD: properties */
> +	arg3[2].integer.type = ACPI_TYPE_INTEGER;
> +	arg3[2].integer.value = ph & 3;
> +	arg3[2].integer.value |= (target_type & 1) << 2;
> +	arg3[2].integer.value |= (cache_ref_valid & 1) << 3;
> +	arg3[2].integer.value |= (cache_ref << 32);
> +
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = ARRAY_SIZE(arg3);
> +	in_obj.package.elements = arg3;
> +
> +	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
> +				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
> +
> +	if (!out_obj)
> +		return AE_ERROR;
> +
> +	if (out_obj->type != ACPI_TYPE_BUFFER) {
> +		ACPI_FREE(out_obj);
> +		return AE_ERROR;
> +	}
> +
> +	st_out->value = *((u64 *)(out_obj->buffer.pointer));
> +
> +	ACPI_FREE(out_obj);
> +
> +	return AE_OK;
> +}
> +
>  /* Update the ST Mode Select field of TPH Control Register */
>  static void set_ctrl_reg_mode_sel(struct pci_dev *pdev, u8 st_mode)
>  {
> @@ -89,3 +210,44 @@ bool pcie_tph_intr_vec_supported(struct pci_dev *pdev)
>  	return true;
>  }
>  EXPORT_SYMBOL(pcie_tph_intr_vec_supported);
> +
> +/**
> + * pcie_tph_get_st_from_acpi() - Retrieve steering tag for a specific CPU
> + * using platform ACPI _DSM

1) TPH and Steering Tags are not ACPI-specific, even though the only
current mechanism to learn the tags happens to be an ACPI _DSM, so I
think we should omit "acpi" from the name drivers use.

2) The spec doesn't restrict Steering Tags to be for a CPU; it says
"processing resource such as a host processor or system cache
hierarchy ..."  But obviously this interface only comprehends an ACPI
CPU ID.  Maybe the function name should include "cpu".

3) Nobody outside the file calls this yet, so it should probably be
static (and removed from the doc) until a driver needs it.

> + * @pdev: pci device
> + * @cpu_acpi_uid: the acpi cpu_uid.
> + * @mem_type: memory type (vram, nvram)
> + * @req_type: request type (disable, tph, extended tph)
> + * @tag: steering tag return value
> + *
> + * Return: 0 if success, otherwise errno
> + */
> +int pcie_tph_get_st_from_acpi(struct pci_dev *pdev, unsigned int cpu_acpi_uid,
> +			      enum tph_mem_type mem_type, u8 req_type,
> +			      u16 *tag)
> +{
> +	struct pci_dev *rp;
> +	acpi_handle rp_acpi_handle;
> +	union st_info info;
> +
> +	if (!pdev->tph_cap)
> +		return -ENODEV;
> +
> +	/* find ACPI handler for device's root port */

Superfluous comments since the code is obvious.  And this finds a
"handle", not a "handler" :)

> +	rp = pcie_find_root_port(pdev);
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return -ENODEV;
> +	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> +
> +	/* invoke _DSM to extract tag value */
> +	if (tph_invoke_dsm(rp_acpi_handle, cpu_acpi_uid, 0, 0, false, 0, &info) != AE_OK) {
> +		*tag = 0;
> +		return -EINVAL;
> +	}
> +
> +	*tag = tph_extract_tag(mem_type, req_type, &info);
> +	pci_dbg(pdev, "%s: cpu=%d tag=%d\n", __func__, cpu_acpi_uid, *tag);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pcie_tph_get_st_from_acpi);
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index 854677651d81..b12a592f3d49 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -9,15 +9,27 @@
>  #ifndef LINUX_PCI_TPH_H
>  #define LINUX_PCI_TPH_H
>  
> +enum tph_mem_type {
> +	TPH_MEM_TYPE_VM,	/* volatile memory type */
> +	TPH_MEM_TYPE_PM		/* persistent memory type */

Where does this come from?  I don't see "vram" or "volatile" used in
the PCIe spec in this context.  Maybe this is from the PCI Firmware
spec?

> +static inline int pcie_tph_get_st_from_acpi(struct pci_dev *dev, unsigned int cpu_acpi_uid,
> +					    enum tph_mem_type tag_type, u8 req_enable,
> +					    u16 *tag)
> +{ return false; }

"false" is not "int".

Apparently you want to return "success" in this case, when
CONFIG_PCIE_TPH is not enabled?  I suggested leaving this non-exported
for now, which would mean removing this altogether.  But if/when we do
export it, I think maybe it should return error so a caller doesn't
assume it succeeded, since *tag will be garbage.

Bjorn

