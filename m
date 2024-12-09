Return-Path: <linux-pci+bounces-17950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA39E9AB7
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 16:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE5118880E5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38B1E9B21;
	Mon,  9 Dec 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdx6g1oj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83781E9B1D;
	Mon,  9 Dec 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758822; cv=none; b=UIMRwuaPL+bNWoAFub13N3SnC2tJDcNgNtVBlD7IJA0yOUhSkOMfFeg4unSSUO45wHDZ50Gb3SY8U2rXslt2c8ptK3B4pP3bTYkeh34nLtjrNzUUpNMsF8c+HKQMrytYPGInpv5CMarJAnKTIZ2j77J3AzIsgk5A1LR48RaZ4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758822; c=relaxed/simple;
	bh=NXv2kZ+6ea8xYm0jQ8k8JDr041Cwb8mryXemzF+bjlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jthzta/fNKDgCVnHKYSCslps01qQyCewHgg1hiLBe1h3j0eecYA/l/nDhyxXmi7hLgouijj+fuuxtDXGNVr1uaHk9M/0O9FlNnvg81Cem+oQMxpahf5W4bJdul6qm5XrkU41CPjAA1fJF6BBNPwWvgVRpfZAxSWyBy7CtkV54cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdx6g1oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCA1C4CEDD;
	Mon,  9 Dec 2024 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758822;
	bh=NXv2kZ+6ea8xYm0jQ8k8JDr041Cwb8mryXemzF+bjlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fdx6g1ojyc0L2SkxZDCTO002TVnWmRHi2OTGtVQUTYCnm5t7DqW3R973eYt6YB+CE
	 4+D5iQcF1CPusPEkIL7gMYMQ6OxfKQkB/EaFfBaTEm9yhGCO9EQKCJ3WEw5A4ywqbk
	 CVDP2H7AUD4lfGXJPs/Ydmoy0RVnQwfH6rBbqNs9Aw1AM2cbMOyW68QL/z9Zmlgvlm
	 jixnZLjQF+PdlyNJTEuUX2XgNLxdeZ6TBUYV1ri0UyC+XhhnqjOWEoVuPwuK9aWoNv
	 OuHkWmK8jJT0u0gd2mMAv8LmeYOCoKrbYTIf8WT/mPcFH7GWKwq4Aq/44r7pZp/7gR
	 2sQ5F3I6SaS2g==
Date: Mon, 9 Dec 2024 15:40:16 +0000
From: Will Deacon <will@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, ilkka@os.amperecomputing.com,
	kaishen@linux.alibaba.com, yangyicong@huawei.com,
	Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
	robin.murphy@arm.com, chengyou@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, rdunlap@infradead.org,
	mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
	renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v12 4/5] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20241209154015.GA12428@willie-the-truck>
References: <20231208025652.87192-5-xueshuai@linux.alibaba.com>
 <20241206165457.GA3101599@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206165457.GA3101599@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Bjorn,

On Fri, Dec 06, 2024 at 10:54:57AM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 08, 2023 at 10:56:51AM +0800, Shuai Xue wrote:
> > This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> > for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> > Core controller IP which provides statistics feature. The PMU is a PCIe
> > configuration space register block provided by each PCIe Root Port in a
> > Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> > injection, and Statistics).
> 
> > +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
> 
> > +static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
> > +	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
> > +	{} /* terminator */
> > +};
> 
> > +static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
> > +{
> > +	const struct dwc_pcie_vendor_id *vid;
> > +	u16 vsec;
> > +	u32 val;
> > +
> > +	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> > +		return false;
> > +
> > +	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
> > +		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
> > +						DWC_PCIE_VSEC_RAS_DES_ID);
> 
> This looks wrong to me, and it promotes a misunderstanding of how VSEC
> Capabilities work.  The VSEC ID is defined by the vendor, so we have
> to check both the Vendor ID and the VSEC ID before we know what this
> VSEC Capability is.

Thanks for pointing this out! The code's been merged for a while now,
so we'll need to fix what we have rather than revert it, I think.

[...]

> I think the table should be extended to contain the Vendor ID, *and*
> the VSEC ID, *and* the VSEC Rev used by that vendor, i.e., it should
> look like this:
> 
>   struct dwc_pcie_pmu_vsec {
>     u16 vendor_id;
>     u16 vsec_id;
>     u8 vsec_rev;
>   };
> 
>   struct dwc_pcie_pmu_vsec dwc_pcie_pmu_vsec_ids[] = {
>     { .vendor_id = PCI_VENDOR_ID_ALIBABA,
>       .vsec_id = DWC_PCIE_VSEC_RAS_DES_ID, .vsec_rev = 0x4 },
>     { .vendor_id = PCI_VENDOR_ID_AMPERE,
>       .vsec_id = DWC_PCIE_VSEC_RAS_DES_ID, .vsec_rev = 0x4 },
>     { .vendor_id = PCI_VENDOR_ID_QCOM,
>       .vsec_id = DWC_PCIE_VSEC_RAS_DES_ID, .vsec_rev = 0x4 },
>     {}
>   };
> 
> This *looks* the same, but it's not, because it makes it obvious that
> the VSEC ID and VSEC Rev are defined separately by each vendor.  It's
> just a lucky coincidence that they happen to be the same for these
> vendors.

[...]

> I suggest updating dwc_pcie_match_des_cap() to iterate through the
> dwc_pcie_pmu_vsec_ids[] table and return the capability offset so you
> can call it from here.

Any chance you could send a patch with those, please? I'm also not able
to test this stuff, but I'm sure Ilkka would help us out.

Cheers,

Will

