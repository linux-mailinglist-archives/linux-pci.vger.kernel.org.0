Return-Path: <linux-pci+bounces-10682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563B793A9A7
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 01:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46E81F215FC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66F149C40;
	Tue, 23 Jul 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHZzE8me"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5651494B1;
	Tue, 23 Jul 2024 23:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776502; cv=none; b=aMpC71l92coumUl/2laP18FSYzc0b66mDg4z0csuKatLnNBNUnps26RpaD3I+BsKt4utA4QL5sWlaBViDEkG/WG+0q++/8OkkxlJh0bXsRBecfdOZNcM2bMWxijP5k0VZbnG2ffuJFEH/TIcgeGUZIBPM7iW0gVPzyL23Vlji+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776502; c=relaxed/simple;
	bh=J+shRoyWxjjFtSLRx0IPGcWXX70uvHYdX9iSt+m2JAs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QGA1EwWZ4Z98nKDUl6mtjS2rXAjQhMM5ML+szscTiSLtGiA3gAM9qViIlk+yuwU8ImvYCPfPxJb7G1abkvlXUOuSg0EIABnJNbLKA4tYbljkOZh21INPPSNXEGW7xqDwm9Tx0anKsZ7GoMTqsBjjpYzcDW2npKauWtSJSPS1AVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHZzE8me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B4CC4AF0A;
	Tue, 23 Jul 2024 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721776502;
	bh=J+shRoyWxjjFtSLRx0IPGcWXX70uvHYdX9iSt+m2JAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cHZzE8mek6vHkvSiyBnoztg4W+HvovQefLXWlpKDiFnSjb+mwvQ0XfEZwxjRuE0kD
	 L8W+JNSdAh0yVxY7EiqYs2KJdhnKVYq+zWlK2IhgLvlRsx/fXWC6ezoanGH2UdIvtS
	 bbOsQeKo5xoeZxTyfh/96jxOloIcPuuvt/+ZhXLicVVoHUQ+Pjym9P1cOQk44lybXt
	 eJeDKziSAYGXbzF4ItxCg9Wopd22Mcoc/gM9U0yZvsUWQ6WBHlw4FrtuoJojr/MCtj
	 Vcupn2zVpRdLZ0Sgxbgb9lp9Dm9xAD7cXOQhXTZkPJo0hK4d52jX+SzFbHfBVdIUOV
	 mehJxWND3VYcg==
Date: Tue, 23 Jul 2024 18:15:00 -0500
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
Subject: Re: [PATCH V3 07/10] PCI/TPH: Introduce API to update TPH steering
 tags in PCIe devices
Message-ID: <20240723231500.GA780146@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-8-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:08PM -0500, Wei Huang wrote:
> Add an API function, pcie_tph_set_st(), to allow endpoint device driver
> to update the steering tags. Depending on ST table location, the tags
> will be written into device's MSI-X table or TPH Requester Extended
> Capability structure.

> +static u32 get_st_table_loc(struct pci_dev *pdev)
> +{
> +	u32 reg_val;
> +
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg_val);
> +
> +	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg_val);
> +}
> +
> +static bool msix_index_in_bound(struct pci_dev *pdev, int msi_idx)
> +{
> +	u32 reg_val;
> +	u16 st_tbl_sz;
> +
> +	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg_val);
> +	st_tbl_sz = FIELD_GET(PCI_TPH_CAP_ST_MASK, reg_val);

Seems like a one-time enumeration thing, not a config read we need to
do for every Steering Tag update.  Same for get_st_table_loc(), I
think.

> +	return msi_idx <= st_tbl_sz;
> +}
> +
> +/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise errno */
> +static int tph_write_tag_to_msix(struct pci_dev *pdev, int msi_idx, u16 tag)
> +{
> +	struct msi_desc *msi_desc = NULL;
> +	void __iomem *vec_ctrl;
> +	u32 val;
> +	int err = 0;
> +
> +	if (!msix_index_in_bound(pdev, msi_idx))
> +		return -EINVAL;
> +
> +	msi_lock_descs(&pdev->dev);
> +
> +	/* find the msi_desc entry with matching msi_idx */
> +	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
> +		if (msi_desc->msi_index == msi_idx)
> +			break;
> +	}
> +
> +	if (!msi_desc) {
> +		pci_err(pdev, "MSI-X descriptor for #%d not found\n", msi_idx);
> +		err = -ENXIO;
> +		goto err_out;
> +	}
> +
> +	/* get the vector control register (offset 0xc) pointed by msi_idx */
> +	vec_ctrl = pdev->msix_base + msi_idx * PCI_MSIX_ENTRY_SIZE;
> +	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
> +
> +	val = readl(vec_ctrl);
> +	val &= 0xffff;
> +	val |= (tag << 16);

Seems like there should be some kind of #defines here to connect this
to the MSI-X table structure.  Maybe next to or connected somehow with
PCI_MSIX_ENTRY_VECTOR_CTRL.

> +	writel(val, vec_ctrl);
> +
> +	/* read back to flush the update */
> +	val = readl(vec_ctrl);
> +
> +err_out:
> +	msi_unlock_descs(&pdev->dev);
> +	return err;
> +}
> +
> +/* Return root port TPH completer capability - 0 means none */
> +static u8 get_rp_completer_support(struct pci_dev *pdev)
> +{
> +	struct pci_dev *rp;
> +	u32 reg_val;
> +	int ret;
> +
> +	rp = pcie_find_root_port(pdev);
> +	if (!rp) {
> +		pci_err(pdev, "cannot find root port of %s\n", dev_name(&pdev->dev));
> +		return 0;
> +	}
> +
> +	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &reg_val);
> +	if (ret) {
> +		pci_err(pdev, "cannot read device capabilities 2\n");
> +		return 0;
> +	}
> +
> +	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg_val);
> +}
> +
> +/*
> + * TPH device needs to be below a rootport with the TPH Completer and
> + * the completer must offer a compatible level of completer support to that
> + * requested by the device driver.

Use spec spelling of "Root Port" (not a mix of "rootport", "root
port", etc).

> + */
> +static bool rp_completer_support_ok(struct pci_dev *pdev, u8 req_cap)
> +{
> +	u8 rp_cap;
> +
> +	rp_cap = get_rp_completer_support(pdev);
> +
> +	if (req_cap > rp_cap) {
> +		pci_err(pdev, "root port lacks proper TPH completer capability\n");

Doesn't look like an error we should log to me.  The *driver* might
need to know this, but the *user* can't do anything with this message,
so I don't think we should print it.  There's nothing actually broken
in the hardware or software here.

> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* Return 0 if OK, otherwise errno on failure */
> +static int pcie_tph_write_st(struct pci_dev *pdev, unsigned int msix_idx,
> +			     u8 req_type, u16 tag)
> +{
> +	int offset;
> +	u32 loc;
> +	int err = 0;
> +
> +	/* setting ST isn't needed - not an error, just return OK */
> +	if (!pdev->tph_cap || pci_tph_disabled() || pci_tph_nostmode() ||
> +	    !pdev->msix_enabled || !int_vec_mode_supported(pdev))

I see now why you made int_vec_mode_supported() a separate helper.
Makes sense since you call it several places, so disregard my earlier
comment about inlining it.

> +		return 0;
> +
> +	/* setting ST is incorrect in the following cases - return error */
> +	if (!msix_index_in_bound(pdev, msix_idx) || !rp_completer_support_ok(pdev, req_type))
> +		return -EINVAL;
> +
> +	/*
> +	 * disable TPH before updating the tag to avoid potential instability
> +	 * as cautioned in PCIE Base Spec r6.2, sect 6.17.3 "ST Modes of Operation"

Wrap to fit in 80 columns.  Capitalize as normal for English
sentences.

s/PCIE Base Spec/PCIe/
s/sect/sec/ (as used in similar citations elsewhere)

Apply to all comments in this series.

> +	 */
> +	pcie_tph_disable(pdev);
> +
> +	loc = get_st_table_loc(pdev);
> +	/* Note: use FIELD_PREP to match PCI_TPH_LOC_* definitions in header */
> +	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> +
> +	switch (loc) {
> +	case PCI_TPH_LOC_MSIX:
> +		err = tph_write_tag_to_msix(pdev, msix_idx, tag);
> +		break;
> +	case PCI_TPH_LOC_CAP:
> +		offset = pdev->tph_cap + PCI_TPH_BASE_SIZEOF + msix_idx * sizeof(u16);
> +		err = pci_write_config_word(pdev, offset, tag);
> +		break;
> +	default:
> +		pci_err(pdev, "unable to write steering tag for device %s\n",
> +			dev_name(&pdev->dev));

I *guess* this message is really telling me that the ST Table Location
field is "Reserved"?  I don't think we should emit an error here
because if it becomes defined in the future, we'll start warning about
all devices that use it, even though nothing is actually wrong except
that we don't know how to use the new value.

In any event, "unable to write steering tag" isn't actually the
problem here; it's only that "ST Table Location" contains something we
don't know about.

> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	if (!err) {
> +		/* re-enable interrupt vector mode */
> +		set_ctrl_reg_mode_sel(pdev, PCI_TPH_INT_VEC_MODE);
> +		set_ctrl_reg_req_en(pdev, req_type);

I wish this code *looked* parallel to the pcie_tph_disable() above,
since it *is* actually paralle.

> +	}

  if (err)
    return err;

  /* Re-enable ... */

  return 0;

> +
> +	return err;
> +}

> + * pcie_tph_set_st() - Set steering tag in ST table entry
> + * @pdev: pci device
> + * @msix_idx: ordinal number of msix interrupt.
> + * @cpu_acpi_uid: the acpi cpu_uid.
> + * @mem_type: memory type (vram, nvram)
> + * @req_type: request type (disable, tph, extended tph)
> + *
> + * Return: 0 if success, otherwise errno
> + */
> +int pcie_tph_set_st(struct pci_dev *pdev, unsigned int msix_idx,
> +		    unsigned int cpu_acpi_uid, enum tph_mem_type mem_type,
> +		    u8 req_type)

I think this function name should include something about "cpu".

Seems like this file uses "cpu_uid" and "cpu_acpi_uid"
interchangeably.  I'm a little unclear on whether that's actually the
case or what the legal values are.  Driver passes cpumask_first(),
which I think is a generic Linux CPU ID.   Is that identical with an
ACPI CPU UID?  It looks like we assume that since we pass this
unaltered to the _DSM.  I didn't dig into this, but would like to be
reassured that all is well here.

In any case, please use a consistent name so I don't have to wonder
whether "cpu_uid" and "cpu_acpi_uid" are the same.

> +{
> +	u16 tag;
> +	int err = 0;
> +
> +	if (!pdev->tph_cap)
> +		return -ENODEV;
> +
> +	err = pcie_tph_get_st_from_acpi(pdev, cpu_acpi_uid, mem_type,
> +					req_type, &tag);
> +
> +	if (err)
> +		return err;
> +
> +	pci_dbg(pdev, "%s: writing tag %d for msi-x intr %d (cpu: %d)\n",
> +		__func__, tag, msix_idx, cpu_acpi_uid);
> +
> +	err = pcie_tph_write_st(pdev, msix_idx, req_type, tag);
> +
> +	return err;

  return pcie_tph_write_st(...);

> +}
> +EXPORT_SYMBOL(pcie_tph_set_st);

> +static inline int pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
> +				   unsigned int cpu, enum tph_mem_type tag_type,
> +				   u8 req_enable)
> +{ return false; }

"false" is not int.  This looks like "success" to the caller, and I'm
not sure that's what you want.

Bjorn

