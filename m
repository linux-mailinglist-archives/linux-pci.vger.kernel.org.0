Return-Path: <linux-pci+bounces-4137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D2B869C98
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 17:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B79F2823FB
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 16:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346411EB39;
	Tue, 27 Feb 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh682Dw0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FB1D698;
	Tue, 27 Feb 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052222; cv=none; b=DtT7wb9QpRe1lDWscXrKVY4OWaQtIzixPZMsOJR6BBrt1qkDDLRfqnhkOjDA7KzHKuGSoBdNX+oqeCezGqKVxUmkCxAXoIMfAasgkXNeeshM5GsBBOVnAESda8++PQaNhYlZE6c2/RX8cNVnZ2PWdiKRi6RD6KU/3uVE3kq2el0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052222; c=relaxed/simple;
	bh=mLvoS/AS2ZkRjKX4NepsHpSZt6hm5Psw5ZqaHoeskgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LhNCZPkr+UjxeQZZ/X0Cx0Vxm6ws9H0VcGv0lySbVwXN4++3o18+sGVcFbward/5Tm5m+noEJXp9l3p+B+AghWnlam8scK+Aysy2K3FOQRQnEx6C9E4TpQVKFn5UncLV6rbG/PaSTJDBjzXwPiX+NrNcL8E6nEIjjCencCBEV+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh682Dw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619E4C433C7;
	Tue, 27 Feb 2024 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709052221;
	bh=mLvoS/AS2ZkRjKX4NepsHpSZt6hm5Psw5ZqaHoeskgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rh682Dw0RdypZcLNGgBdo/QkCAZr8CNKZKAT+9739XomzD+q/p+lQyNeJzGtiRXay
	 eVvFU3dzDKqG/uGQCDDDfQ/iE+/Q1gaC4/N0qTCe/h7Tp4VZMXLWRGtckK+n/kbHvE
	 jIwJ1xrpnnsoakkuGFjXXc+gOkzhLDnRxCtG/K/F7+L9X3LV7wwLDnnkTwJwILxQLi
	 A7NFLllMiqptTajUzaAEMTnw2odCxfuceubAsmFJvBBHQn5Iwh147+Jlb8+vWnugGc
	 hHEiaS4oCiTBUGxE/EcFOKhTQV7JqslhmU8LwB6l25nIeqNTgAJI3VaJjcPOHnFUkf
	 sOK79t4LGO3tw==
Date: Tue, 27 Feb 2024 10:43:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
	dan.j.williams@intel.com
Subject: Re: [RFC PATCH v2 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Message-ID: <20240227164339.GA239446@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227083313.87699-2-kobayashi.da-06@fujitsu.com>

On Tue, Feb 27, 2024 at 05:33:11PM +0900, Kobayashi,Daisuke wrote:
> This patch implements a process to output the link status information 
> of the CXL1.1 device to sysfs. The values of the registers related to 
> the link status are outputted into three separate files.

> +static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u8 offset = 0;

Unnecessary initialization.  Also, readw() returns u16.

> +	u32 cap_hdr;
> +	u32 linkcap = 0;

Ditto.

> +
> +	if (WARN_ON_ONCE(rcrb == CXL_RESOURCE_NONE))
> +		return 0;
> +
> +	if (!request_mem_region(rcrb, SZ_4K, dev_name(dev)))
> +		return 0;
> +
> +	addr = ioremap(rcrb, SZ_4K);
> +	if (!addr)
> +		goto out;
> +
> +	offset = readw(addr + PCI_CAPABILITY_LIST);
> +	offset = offset & 0x00ff;
> +	cap_hdr = readl(addr + offset);
> +	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
> +		offset = (cap_hdr >> 8) & 0x000000ff;
> +		if (!offset)
> +			break;
> +		cap_hdr = readl(addr + offset);
> +	}

Hmmm, it's a shame we have to reimplement pci_find_capability() here.
I see the problem though -- pci_find_capability() does config reads
and this is in MMIO space, not config space.

But you need this several times, so maybe a helper function would
still be useful so you don't have to repeat the code.

> +	if (offset)
> +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);

Testing "offset" acknowledges the possibility that it may be NULL, and
in that case, the readl() below is a NULL pointer dereference.

> +	linkcap = readl(addr + offset + PCI_EXP_LNKCAP);
> +	iounmap(addr);
> +out:
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return linkcap;
> +}

> @@ -806,6 +1003,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(mds))
>  		return PTR_ERR(mds);
>  	cxlds = &mds->cxlds;
> +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);

Is there a removal issue here?  What if "pdev" is removed?  Or what if
this module is unloaded?  Do these sysfs files get cleaned up
automagically somehow?

Bjorn

