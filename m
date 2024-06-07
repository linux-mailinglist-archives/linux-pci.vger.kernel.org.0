Return-Path: <linux-pci+bounces-8475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB33900B7A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CC028C12A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7E719AA5B;
	Fri,  7 Jun 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv4tADCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57C190672;
	Fri,  7 Jun 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782344; cv=none; b=t+HQUi4IMXaSSOg7HGHnmkYnyczVAGh/KBbWdmb1WUTw79L+8N+l9c9ejRny0zeI3VeUh6CWqpLQs++fSJwjOlM0AKa9oH8xLS/S7Xb5rQaRmNQ7h2AlfHAJm7Zy2AH7U74cBCiKDvAfJJyiu9wJdLX7Ff68MTaYCSjDRH2NBj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782344; c=relaxed/simple;
	bh=zCG8FQxsaI/w6vMFJhp8K3xWTo7Bswlks8CEu7zqit0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NljP3LWWRNg9l7I3NDx+z69x+JYTD2l1jPw9gYnLW2JS0LVbWn9d6RpYrzb1bFJMZ/25FIKrvTw4tcHVbOX5bRHNgdJ6qj6ZlXi6FN3ZBy2I5equsm8HTQM5gtK1/Q7CZ0RiH8X1Pf+27LIPq7Tf8MS4o9aEmsHek05elYkKe34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv4tADCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6B4C2BBFC;
	Fri,  7 Jun 2024 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717782344;
	bh=zCG8FQxsaI/w6vMFJhp8K3xWTo7Bswlks8CEu7zqit0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Xv4tADCcOcuqv6Lb0hkMlr6KfY8ZZAVX1NweUPXXrwO/A9LSokeflWwf5Z0CzmHZu
	 umJynmWvTAhFDM55M84wu6wrXEpR8YwceWFTT30lGjCu3PSVSSZlhrhAoj+C9zX6Nn
	 CRFWZF4xCvQF2jacp2/buepX4wL+H69iBxq/R3lqdiWPD6/KUfiyzCF7XvRFe3iZB/
	 TLzCzcUtAESSSGP49tHVLU+/LJV20h+isLVpIooqd4nEHHg8nnqxmdLtASDvtkQysV
	 7GhvJOyrbJZCb/mz+biBsFEz4ciyXk7QgVJ1xX1bQChbltDDuoH96Lf6GjTW41cKeA
	 YsKyjLOKoo4VQ==
Date: Fri, 7 Jun 2024 12:45:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH V2 5/9] PCI/TPH: Introduce API functions to manage
 steering tags
Message-ID: <20240607174542.GA853103@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531213841.3246055-6-wei.huang2@amd.com>

On Fri, May 31, 2024 at 04:38:37PM -0500, Wei Huang wrote:
> This patch introduces three API functions, pcie_tph_intr_vec_supported(),
> pcie_tph_get_st() and pcie_tph_set_st(), for a driver to query, retrieve
> or configure device's steering tags. There are two possible locations for
> steering tag table and the code automatically figure out the right
> location to set the tags if pcie_tph_set_st() is called. Note the tag
> value is always zero currently and will be extended in the follow-up
> patches.

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
> +
> +static int tph_get_table_size(struct pci_dev *dev, u16 *size_out)
> +{
> +	int ret;
> +	u32 tmp;
> +
> +	ret = tph_get_reg_field_u32(dev, PCI_TPH_CAP,
> +				    PCI_TPH_CAP_ST_MASK,
> +				    PCI_TPH_CAP_ST_SHIFT, &tmp);

Just use FIELD_GET() instead.

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

s/MSI/MSI-X/ to avoid any possible confusion.

> +static void __iomem *tph_msix_table_entry(struct pci_dev *dev,
> +					  u16 msi_index)

> +	ret = pcie_capability_read_dword(rp, PCI_EXP_DEVCAP2, &val);
> +	if (ret) {
> +		pr_err("cannot read device capabilities 2 of %s\n",
> +		       dev_name(&dev->dev));

Never use pr_err() when you can use pci_err() instead.  Obviously no
dev_name() needed with pci_err().  Other instances below.

> +	val &= PCI_EXP_DEVCAP2_TPH_COMP;
> +
> +	return val >> PCI_EXP_DEVCAP2_TPH_COMP_SHIFT;

FIELD_GET()

> + * The PCI Specification version 5.0 requires the "No ST Mode" mode
> + * be supported by any compatible device.

Cite r6.0 or newer and include section number.

> +	/* clear the mode select and enable fields and set new values*/

Space before closing */

> +	ctrl_reg &= ~(PCI_TPH_CTRL_REQ_EN_MASK);
> +	ctrl_reg |= (((u32)req_type << PCI_TPH_CTRL_REQ_EN_SHIFT) &
> +			PCI_TPH_CTRL_REQ_EN_MASK);

FIELD_GET()/FIELD_PREP()

> +static bool pcie_tph_write_st(struct pci_dev *dev, unsigned int msix_nr,
> +			      u8 req_type, u16 tag)

This function is not a predicate and testing for true/false gives no
indication of the sense.

For typical functions that do read/write/etc, returning 0 means
success and -errno means failure.  This is the opposite.

> +	/*
> +	 * disable TPH before updating the tag to avoid potential instability
> +	 * as cautioned about in the "ST Table Programming" of PCI-E spec

s/disable/Disable/

"PCIe r6.0, sec ..."

> +bool pcie_tph_set_st(struct pci_dev *dev, unsigned int msix_nr,
> +		     unsigned int cpu, enum tph_mem_type mem_type,
> +		     u8 req_type)

Should return 0 or -errno.

