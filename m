Return-Path: <linux-pci+bounces-8471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB84900B3D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65769287C67
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1419AA66;
	Fri,  7 Jun 2024 17:29:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDD15ACB;
	Fri,  7 Jun 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717781378; cv=none; b=U+4BnQmoXc4z3kY7R4bFh9Q0Nwwetq6ktOy1ElVFCbaBCbEp5H/np+0YZ4egMXB7bnNO2su22uvqoEAKwJdScMANY+vDLRwTerl1T0AcGIPZ6Kvxl/g6CcHWRINXye7bnvFV9nHpr4ou66Ai9R/rTB7y4xEcv5DgGl0VNoBEfzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717781378; c=relaxed/simple;
	bh=b7LvUnYdln3xPJ+gz3I73XCAq+I5Eq6pfoEuPF+Ty1c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e12LKIKvw20v5wNu+VpNIpw0QxN6fvQ9q/GRMS0ooP8T/Cs1eWkJODv9QH+t887/uTra9+x777TzxL2uZyB8DqxHcHO5SduSG9JgqvUSX1cr1tn9Its2sVScphBGtYjCjxXpYma7nOCpGIrdB2lGYCBN7MJUo2Fnl7AkhRxkdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwp43239Hz6JB9C;
	Sat,  8 Jun 2024 01:25:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DFD4F140CB1;
	Sat,  8 Jun 2024 01:29:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 18:29:31 +0100
Date: Fri, 7 Jun 2024 18:29:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Wei Huang <wei.huang2@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alex.williamson@redhat.com>,
	<gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<bagasdotme@gmail.com>
Subject: Re: [PATCH V2 5/9] PCI/TPH: Introduce API functions to manage
 steering tags
Message-ID: <20240607182930.000045d9@Huawei.com>
In-Reply-To: <20240531213841.3246055-6-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-6-wei.huang2@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:37 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> This patch introduces three API functions, pcie_tph_intr_vec_supported(),
> pcie_tph_get_st() and pcie_tph_set_st(), for a driver to query, retrieve
> or configure device's steering tags. There are two possible locations for
> steering tag table and the code automatically figure out the right
> location to set the tags if pcie_tph_set_st() is called. Note the tag
> value is always zero currently and will be extended in the follow-up
> patches.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Hi. 

There are a lot of small functions in here.  I'd look at just calling
the things they are wrapping more directly as with the register
and field names inline it's pretty obvious what is going on.
Wrapping that in a helper function doesn't necessarily help readablity
and perhaps doubles the length of the code.

Various other comments inline.

Jonathan


> ---
>  drivers/pci/pcie/tph.c  | 402 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-tph.h |  22 +++
>  2 files changed, 424 insertions(+)
> 
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index d5f7309fdf52..320b99c60365 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -43,6 +43,336 @@ static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
>  	return ret;
>  }
>  
> +static int tph_get_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
> +				 u8 shift, u32 *field)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	if (!dev->tph_cap)
> +		return -EINVAL;
> +
> +	ret = pci_read_config_dword(dev, dev->tph_cap + offset, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*field = (reg_val & mask) >> shift;
> +
> +	return 0;
> +}

Similar to earlier, I'm not seeing as strong reason for this.
Just do the tph_cap check at the external interface points rather than
in register read paths.

Mind you, if you do keep this a lot of the other helpers
could be flattened as they are simply passing particular parameters
to this and that could be done inline where the results are needed.


> +
> +static int tph_get_table_size(struct pci_dev *dev, u16 *size_out)
> +{
> +	int ret;
> +	u32 tmp;
> +
> +	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP,
> +				    PCI_TPH_CAP_ST_MASK,
> +				    PCI_TPH_CAP_ST_SHIFT, &tmp);
> +
> +	if (ret)
> +		return ret;
> +
> +	*size_out = (u16)tmp;
> +
> +	return 0;
> +}
> +
> +/*
> + * For a given device, return a pointer to the MSI table entry at msi_index.
> + */
> +static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
> +					  u16 msi_index)
> +{
> +	void __iomem *entry;
> +	u16 tbl_sz;
> +	int ret;
> +
> +	ret = tph_get_table_size(dev, &tbl_sz);
> +	if (ret || msi_index > tbl_sz)
> +		return NULL;
Nice to return the error code via ERR_PTR() etc so ultimate caller gets
some information.
> +
> +	entry = dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;

return dev->msix_base + msi_index * PCI_MSIX_ENTRY_SIZE;

> +
> +	return entry;
> +}
> +
> +/*
> + * For a given device, return a pointer to the vector control register at
> + * offset 0xc of MSI table entry at msi_index.
> + */
> +static void __iomem *tph_msix_vector_control(struct pci_dev *dev,
> +					     u16 msi_index)
> +{
> +	void __iomem *vec_ctrl_addr = tph_msix_table_entry(dev, msi_index);
> +
> +	if (vec_ctrl_addr)
> +		vec_ctrl_addr += PCI_MSIX_ENTRY_VECTOR_CTRL;

I'd do this addition at the caller.  Then don't need this function.

> +
> +	return vec_ctrl_addr;
> +}
> +
> +/*
> + * Translate from MSI-X interrupt index to struct msi_desc *
> + */
> +static struct msi_desc *tph_msix_index_to_desc(struct pci_dev *dev, int index)
> +{
> +	struct msi_desc *entry;
> +
> +	msi_lock_descs(&dev->dev);

I'd take the lock at the caller as not obvious this is going to keep holding it
from the name.

If you call it tph_msix_get_desc_from_index() that would help.

> +	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ASSOCIATED) {
> +		if (entry->msi_index == index)
> +			return entry;
> +	}
> +	msi_unlock_descs(&dev->dev);
> +
> +	return NULL;
> +}

> +
> +static bool msix_nr_in_bounds(struct pci_dev *dev, int msix_nr)
> +{
> +	u16 tbl_sz;
> +
> +	if (tph_get_table_size(dev, &tbl_sz))
> +		return false;
> +
> +	return msix_nr <= tbl_sz;

Use the table entry request and just check reutrn for NULL.

So instead of calling this function,

if (!tph_msix_table_entry(dev, msix_nr));

and drop this function.

> +}
> +
> +/* Return root port capability - 0 means none */
> +static int get_root_port_completer_cap(struct pci_dev *dev)

I'd expect anything ending in _cap in PCI code to be giving
me the offset of a capability. 

static int root_port_tph_support() maybe?

> +{
> +	struct pci_dev *rp;
> +	int ret;
> +	int val;
> +
> +	rp = pcie_find_root_port(dev);
> +	if (!rp) {
> +		pr_err("cannot find root port of %s\n", dev_name(&dev->dev));
> +		return 0;
> +	}
> +
> +	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &val);
> +	if (ret) {
> +		pr_err("cannot read device capabilities 2 of %s\n",
> +		       dev_name(&dev->dev));
> +		return 0;
> +	}
> +
> +	val &= PCI_EXP_DEVCAP2_TPH_COMP;
> +
> +	return val >> PCI_EXP_DEVCAP2_TPH_COMP_SHIFT;
> +}
> +
> +/*
> + * TPH device needs to be below a rootport with the TPH Completer and
> + * the completer must offer a compatible level of completer support to that
> + * requested by the device driver.
> + */
> +static bool completer_support_ok(struct pci_dev *dev, u8 req)
> +{
> +	int rp_cap;
> +
> +	rp_cap = get_root_port_completer_cap(dev);
> +
> +	if (req > rp_cap) {
> +		pr_err("root port lacks proper TPH completer capability\n");

Assumption is that any driver getting to here should really have checked
if this was fine before enabling TPH?  a pr_err() seems overly noisy
otherwise.

> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * The PCI Specification version 5.0 requires the "No ST Mode" mode
> + * be supported by any compatible device.

Why do we need to check something that 'must' be set to 1?
Are there known buggy devices?  If not, just don't check it
as we can assume this is true and save 20 lines of code.

> + */
> +static bool no_st_mode_supported(struct pci_dev *dev)
> +{
> +	bool no_st;
> +	int ret;
> +	u32 tmp;
> +
> +	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP, PCI_TPH_CAP_NO_ST,
> +				    PCI_TPH_CAP_NO_ST_SHIFT, &tmp);
> +	if (ret)
> +		return false;
> +
> +	no_st = !!tmp;
> +
> +	if (!no_st) {
> +		pr_err("TPH devices must support no ST mode\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static int tph_write_ctrl_reg(struct pci_dev *dev, u32 value)
> +{
> +	int ret;
> +
> +	ret = tph_set_reg_field_u32(dev, PCI_TPH_CTRL, ~0L, 0, value);
> +
> +	if (ret)
> +		goto err_out;
> +
> +	return 0;
> +
> +err_out:
> +	/* minimizing possible harm by disabling TPH */
> +	pcie_tph_disable(dev);

If the write failed, something is horribly wrong. Do we need
to defend against that case?  It complicates the code a fair bit so
it needs a strong reasoning.  Preferably why can this fail other
than in bug cases or surprise removal or similar.

> +	return ret;
> +}
> +
> +/* Update the ST Mode Select field of the TPH Control Register */
> +static int tph_set_ctrl_reg_mode_sel(struct pci_dev *dev, u8 st_mode)
> +{
> +	int ret;
> +	u32 ctrl_reg;
> +
> +	ret = tph_get_reg_field_u32(dev, PCI_TPH_CTRL, ~0L, 0, &ctrl_reg);
> +	if (ret)
> +		return ret;
> +
> +	/* clear the mode select and enable fields */
> +	ctrl_reg &= ~(PCI_TPH_CTRL_MODE_SEL_MASK);
> +	ctrl_reg |= ((u32)(st_mode << PCI_TPH_CTRL_MODE_SEL_SHIFT) &
> +		     PCI_TPH_CTRL_MODE_SEL_MASK);
> +
> +	ret = tph_write_ctrl_reg(dev, ctrl_reg);

return tph_write_ctrl_reg()

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Write the steering tag to MSI-X vector control register */
> +static void tph_write_tag_to_msix(struct pci_dev *dev, int msix_nr, u16 tag)
> +{
> +	u32 val;
> +	void __iomem *vec_ctrl;
> +	struct msi_desc *msi_desc;
> +
> +	msi_desc = tph_msix_index_to_desc(dev, msix_nr);
> +	if (!msi_desc) {
> +		pr_err("MSI-X descriptor for #%d not found\n", msix_nr);
> +		return;
return an error so we can handle it at caller.

> +	}
> +
> +	vec_ctrl = tph_msix_vector_control(dev, msi_desc->msi_index);

Whilst this would have already failed, I'd still check for vec_ctrl == NULL
as easier to read.

> +
> +	val = readl(vec_ctrl);
> +	val &= 0xffff;
> +	val |= (tag << 16);
> +	writel(val, vec_ctrl);
> +
> +	/* read back to flush the update */
> +	val = readl(vec_ctrl);
> +	msi_unlock_descs(&dev->dev);
Who took the lock? Not obvious from function naming - see above

> +}
> +

> +static bool pcie_tph_write_st(struct pci_dev *dev, unsigned int msix_nr,
> +			      u8 req_type, u16 tag)

Why bool for error or not?  Better to return an error code.

> +{
> +	int offset;
> +	u8  loc;

Unusual to align the local variables like this. I'd just have a single space before
loc..

> +	int ret;
> +
> +	/* setting ST isn't needed - not an error, just return true */
> +	if (!dev->tph_cap || pci_tph_disabled() || pci_tph_nostmode() ||
> +	    !dev->msix_enabled || !tph_int_vec_mode_supported(dev))
> +		return true;
> +
> +	/* setting ST is incorrect in the following cases - return error */
> +	if (!no_st_mode_supported(dev) || !msix_nr_in_bounds(dev, msix_nr) ||
> +	    !completer_support_ok(dev, req_type))
> +		return false;
> +
> +	/*
> +	 * disable TPH before updating the tag to avoid potential instability
> +	 * as cautioned about in the "ST Table Programming" of PCI-E spec
> +	 */
> +	pcie_tph_disable(dev);
> +
> +	ret = tph_get_table_location(dev, &loc);
> +	if (ret)
> +		return false;
> +
> +	switch (loc) {
> +	case PCI_TPH_LOC_MSIX:
> +		tph_write_tag_to_msix(dev, msix_nr, tag);
handle errors.
> +		break;
> +	case PCI_TPH_LOC_CAP:
> +		offset = dev->tph_cap + PCI_TPH_ST_TABLE
> +			  + msix_nr * sizeof(u16);
> +		pci_write_config_word(dev, offset, tag);
handle errors.
> +		break;
> +	default:
> +		pr_err("unable to write steering tag for device %s\n",
> +		       dev_name(&dev->dev));
> +		return false;
> +	}
> +
> +	/* select interrupt vector mode */
> +	tph_set_ctrl_reg_mode_sel(dev, PCI_TPH_INT_VEC_MODE);
handle errors
> +	tph_set_ctrl_reg_en(dev, req_type);
etc.

> +
> +	return true;
> +}
> +

> +
> +/**
> + * pcie_tph_get_st() - Retrieve steering tag for a specific CPU
> + * @dev: pci device
> + * @cpu: the acpi cpu_uid.
> + * @mem_type: memory type (vram, nvram)
> + * @req_type: request type (disable, tph, extended tph)
> + * @tag: steering tag return value
> + *
> + * Return:
> + *        true : success
> + *        false: failed
> + */
> +bool pcie_tph_get_st(struct pci_dev *dev, unsigned int cpu,

Rename so that it's obvious this isn't just reading back the st
previously set to the device (i.e. it isn't the opposite of
pci_tph_set_st())

pci_tph_get_st_to_use() or something like that.

int so we can have some error information once implemented.
I'm not keen on introducing a stub like this though that doesn't
yet do anything. Bring it in when useful.




> +		    enum tph_mem_type mem_type, u8 req_type,
> +		    u16 *tag)
> +{
> +	*tag = 0;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(pcie_tph_get_st);
> +
> +/**
> + * pcie_tph_set_st() - Set steering tag in ST table entry
> + * @dev: pci device
> + * @msix_nr: ordinal number of msix interrupt.
> + * @cpu: the acpi cpu_uid.

Given most linux CPU numbers are not necessarily the ACPI CPU ID
I'd call it that.  e.g. cpu_acpi_uid.


> + * @mem_type: memory type (vram, nvram)
> + * @req_type: request type (disable, tph, extended tph)
> + *
> + * Return:
> + *        true : success
> + *        false: failed
> + */
> +bool pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
> +		     unsigned int cpu, enum tph_mem_type mem_type,
> +		     u8 req_type)
> +{
> +	u16 tag;
> +	bool ret = true;
> +
> +	ret = pcie_tph_get_st(dev, cpu, mem_type, req_type, &tag);
> +
> +	if (!ret)
> +		return false;
> +
> +	pr_debug("%s: writing tag %d for msi-x intr %d (cpu: %d)\n",
> +		 __func__, tag, msix_nr, cpu);
> +
> +	ret = pcie_tph_write_st(dev, msix_nr, req_type, tag);
> +
> +	return ret;
return pcie_tph_write_st() but make it return an integer so caller
gets some information on what when wrong.

> +}
> +EXPORT_SYMBOL(pcie_tph_set_st);


