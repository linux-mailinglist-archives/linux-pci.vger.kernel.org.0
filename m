Return-Path: <linux-pci+bounces-5946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263989DD6F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B553E1F277F1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050E7FBD3;
	Tue,  9 Apr 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HauNwtVj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A452747B;
	Tue,  9 Apr 2024 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674775; cv=none; b=I1CuaQlAJp8qlHfkBh1tnao+Z08ahIIrCqMRfu7TcYNZW1PUUnfavdzHQuSI/Q+QOb0HB6g/7PsCHdYzseN9QlP/XtvL037Rvxzye8X7D/mh2JTxFetcUoYVRC2jGy+RmOmirEmXYgzSbmrBEyJjK7xhnAnW1++9ALqhfBJft+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674775; c=relaxed/simple;
	bh=c+QBlOpbEr0u6QYysHA9TwZNwK1GaI2bRUzwL4bi/iU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hee608nhBd8yuWOIVPSCw/kYvAdPcLV2NrPsBHj5GpFTZGh82s4cLYmfr2VYiWvhAPLh+SmrH0/tsYr92VnTfCBe+h9mcGcwGHy8fdZ55o9f9++A+xUT0W5f3SMWh5wcWr2BInhaWYQHYvXaeYD6rKi7I9XErAvAcDbuHp3QRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HauNwtVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66D6C433F1;
	Tue,  9 Apr 2024 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712674775;
	bh=c+QBlOpbEr0u6QYysHA9TwZNwK1GaI2bRUzwL4bi/iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HauNwtVjYMkpIDVvI7B9318a/ds1ZtSzB3a15r6giUEtmk4iglMUVKlMy08Nc1MAG
	 oYEInIOJOj5g3tK39OnD+lC3EHlsKysnVFtIvJq5ULpkWAmf7JeoSAQzA6U4r/BekQ
	 7vY/lpJUJi3NhTnMmlPphedJZYkW0KALo+vUA3lmtocKfpycK/Xv9z2WyfQ7HcGZ/c
	 eBauAhxYlNJNhfzpA1Wk+ytkb5cEeniPGPkEIRDMPI1lEup2bAdsxWMq4yfYcLeTFE
	 D8lnGGUwGYbZiMNm4ScETc337I1T/rDFCiDU2s5wykbtnxpbfTytt9rT+XlhF9lNpD
	 VamtSpvqxKK8g==
Date: Tue, 9 Apr 2024 09:59:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
	dan.j.williams@intel.com
Subject: Re: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Message-ID: <20240409145933.GA2074336@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>

On Tue, Mar 12, 2024 at 05:05:57PM +0900, Kobayashi,Daisuke wrote:
> This patch implements a process to output the link status information 
> of the CXL1.1 device to sysfs. The values of the registers related to 
> the link status are outputted into three separate files.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. This function accesses the address where
> the device's RCRB is mapped.
> 
> 

Spurious blank line in the commit log.

Perhaps include the names of the sysfs files?  And a hint of what they
mean?

I think it's also conventional for the patch to add entries to
Documentation/ABI/...  to show how to use the new files.

> +static u8 cxl_rcrb_get_pcie_cap_offset(void __iomem *addr){

Opening brace would typically be on the next line.

> +	u8 offset;
> +	u32 cap_hdr;
> +
> +	offset = readb(addr + PCI_CAPABILITY_LIST);
> +	cap_hdr = readl(addr + offset);
> +	while ((cap_hdr & 0x000000ff) != PCI_CAP_ID_EXP) {
> +		offset = (cap_hdr >> 8) & 0x000000ff;
> +		if (offset == 0) // End of capability list
> +			return 0;
> +		cap_hdr = readl(addr + offset);
> +	}
> +	return offset;

Possibly mimic the name and structure of pci_find_capability(), in
particular, the loop structure of __pci_find_next_cap_ttl().

> +

Spurious blank line.

> +}
> +
> +static u32 cxl_rcrb_to_linkcap(struct device *dev, resource_size_t rcrb)
> +{
> +	void __iomem *addr;
> +	u8 offset;
> +	u32 linkcap;
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
> +	offset = cxl_rcrb_get_pcie_cap_offset(addr);
> +	if (offset)
> +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> +	else
> +		goto out;
> +
> +	linkcap = readl(addr + offset + PCI_EXP_LNKCAP);
> +	iounmap(addr);
> +out:
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return linkcap;
> +}

> +static u16 cxl_rcrb_to_linkctr(struct device *dev, resource_size_t rcrb)

Why name this "linkctr" when other references here use "linkctrl"?

> +{
> +	void __iomem *addr;
> +	u8 offset;
> +	u16 linkctrl;
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
> +	offset = cxl_rcrb_get_pcie_cap_offset(addr);
> +	if (offset)
> +		dev_dbg(dev, "found PCIe capability (0x%x)\n", offset);
> +	else
> +		goto out;
> +
> +	linkctrl = readw(addr + offset + PCI_EXP_LNKCTL);
> +	iounmap(addr);
> +out:
> +	release_mem_region(rcrb, SZ_4K);
> +
> +	return linkctrl;

There's a lot of duplicated boilerplate here between
cxl_rcrb_to_linkcap(), cxl_rcrb_to_linkctr(),
cxl_rcrb_to_linkstatus().

It also seems like a lot of repeated work to search for the PCIe Cap,
ioremap, tear down, etc., for each file, every time it is read.  I
assume most readers will be interested in all three items at the same
time.

> +static umode_t cxl_rcd_visible(struct kobject *kobj,
> +					  struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (is_cxl_restricted(pdev))

Not related to *this* patch, but I can't connect the dots between the
"is_cxl_restricted()" name, the meaning of "restricted", and the "CXL
memory expander class code" mentioned in the is_cxl_restricted()
function comment.  It doesn't check the "class code".  It's not
obvious why this applies to RCiEPs but not other endpoints.  No doubt
all obvious to the CXL-initiated, which I am not.

Bjorn

