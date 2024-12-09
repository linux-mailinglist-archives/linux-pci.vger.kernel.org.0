Return-Path: <linux-pci+bounces-17970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C25E9EA21C
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 23:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42401888645
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 22:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF819D88F;
	Mon,  9 Dec 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUM+Xnqs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C67C1991C8;
	Mon,  9 Dec 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733784464; cv=none; b=gz2yhE4/lB9KO70vAUfIlPdTcd3fmt0TX3bs7bEO0aBl1u/to/1nwugLBMI8zDv+I+KIVylnTauxxp6safLZQclsQIzxYCFfsDM/SFs54sNAHP/QsguuuRwF95A22+FIf+l2+Cs5FAgnq7ZLZePomH842hezRqJ0om5jIoC9ZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733784464; c=relaxed/simple;
	bh=bfR3ZPj+k58Qcimmw1cGqJKij4yOncMke720Uzmfll4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s/NbTMXRa+eHeVOLrGHmMtu1xymd5mRaOft6xskisnozkLqpnlA8XaMnIXQwEfqpPUlX6hsjeW2w9eOaWtxojv9oGNUPJglXR+JvKUwI7lCcsBvgoEF1FWwjeg4Y+mzQU9+Z/i66p8pMh1nKGTvK7GHHZ6Ne+LFC+f0PMowSIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUM+Xnqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F29C4CED1;
	Mon,  9 Dec 2024 22:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733784463;
	bh=bfR3ZPj+k58Qcimmw1cGqJKij4yOncMke720Uzmfll4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KUM+Xnqsh+stm2JD9cvf12wymyTmnA8Rk7+2vT7glkmgNR2uyYLOkEWOEGx/9eC53
	 7lcm/UqJkA/3GwTO0OKaavodTQsk8IaFubNsLz3Vok44i91S+Dwj3LJ4TQg+vLPEJA
	 ykBayw4tg9Ay1YlKX4pChU7t3FVLLmqBctArRYPh6ss2Ed2OXj9HMW7oF1mE5CBZRb
	 r87aFC1k33G5i4lYGp7/RL5gEmrZDB1ZaQ9BOFf5G8kM1fQj+Vy8e6XIH10yia5PbY
	 rmCRwILvpobpMNqEDpSw4MYJzGclfuNIwC4WgjiXhjGzndB8SKSN8xLhNEOQkoxdaE
	 WzuikYFxmtr0w==
Date: Mon, 9 Dec 2024 16:47:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, ilkka@os.amperecomputing.com,
	kaishen@linux.alibaba.com, yangyicong@huawei.com,
	Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
	robin.murphy@arm.com, chengyou@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, rdunlap@infradead.org,
	mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
	renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v12 4/5] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20241209224741.GA3206765@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209154015.GA12428@willie-the-truck>

On Mon, Dec 09, 2024 at 03:40:16PM +0000, Will Deacon wrote:
> On Fri, Dec 06, 2024 at 10:54:57AM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 08, 2023 at 10:56:51AM +0800, Shuai Xue wrote:
> > > This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> > > for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> > > Core controller IP which provides statistics feature. The PMU is a PCIe
> > > configuration space register block provided by each PCIe Root Port in a
> > > Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> > > injection, and Statistics).
> > 
> > > +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
> > 
> > > +static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
> > > +	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
> > > +	{} /* terminator */
> > > +};
> > 
> > > +static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
> > > +{
> > > +	const struct dwc_pcie_vendor_id *vid;
> > > +	u16 vsec;
> > > +	u32 val;
> > > +
> > > +	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> > > +		return false;
> > > +
> > > +	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
> > > +		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
> > > +						DWC_PCIE_VSEC_RAS_DES_ID);
> > 
> > This looks wrong to me, and it promotes a misunderstanding of how VSEC
> > Capabilities work.  The VSEC ID is defined by the vendor, so we have
> > to check both the Vendor ID and the VSEC ID before we know what this
> > VSEC Capability is.
> 
> Thanks for pointing this out! The code's been merged for a while now,
> so we'll need to fix what we have rather than revert it, I think.

Yep, for sure.

> Any chance you could send a patch with those, please? I'm also not able
> to test this stuff, but I'm sure Ilkka would help us out.

Posted at https://lore.kernel.org/linux-pci/20241209222938.3219364-1-helgaas@kernel.org

Bjorn

