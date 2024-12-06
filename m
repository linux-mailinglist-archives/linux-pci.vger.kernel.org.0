Return-Path: <linux-pci+bounces-17865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39F9E7681
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43931613BA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970401F3D2D;
	Fri,  6 Dec 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHmXV3QX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52C20628A;
	Fri,  6 Dec 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504099; cv=none; b=b6/vg1rTO8YtF4ZegbXOBQe2ZWtB9WydjvO64iNtXbntGXyUVXXBRYMAoompqQq2+ibDG3cJeSW/6ZwCXzutSSLTtFxCGkA9n4xTlV3O1knYE1F6W98iQZx1VBfVL0y+6CDN+f9T0iMTGTecAAoQaCxp66cQdx+AmVPZQkbbMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504099; c=relaxed/simple;
	bh=np6gijQaJ2x8dV5tPEnKGpmtFkb0N2ZUr3OIxXLKdYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QxYHXZSNLzjAUuLhcn4veoRbjhfC1Xl99SGqxB1Yj7A9CUjoOwbTwNv7aLFLk0BzEsQhDqX1YDEsA9UlVAQawY2HhmvMJ+SbRNrfbXzcfvEFn4sSdrtOUhM2KinpOehzBcY2FhjBquD3ZxWd8z0631H1B67Sa2+jMnjYWngGmn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHmXV3QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59EDC4CED1;
	Fri,  6 Dec 2024 16:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504098;
	bh=np6gijQaJ2x8dV5tPEnKGpmtFkb0N2ZUr3OIxXLKdYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OHmXV3QX4IIj37XKRydmQO6CdiMsGQTMjhUjio6TN2j6HRFguE72Bcc6sUNFYPePF
	 xBW8jxki98Q/fX72d1w/6Z8/cbmFUH7IlGHPpXgNeVtUH6Z+xxIkhADMnoZnHDu6ny
	 09abxs+PBL+KFW2dwFVPb7N10ptQTr5Wb5pqGsIWajRKAaWZYh2sOJkv2ZD8PM0sUu
	 0qeX1nQfIqjRZv/vQSmKxPWO8PQasbHzVXLOyBeW0w7oeU45kk8Us3kxvTZMMd958/
	 ItKdqjHGo8moZJqmS0W0WzwXtl9yu5ESZ86aYUb7doZWKfgs3LXNuVeae7y9L+3fJX
	 ALExZT5dld14w==
Date: Fri, 6 Dec 2024 10:54:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
	yangyicong@huawei.com, will@kernel.org, Jonathan.Cameron@huawei.com,
	baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
	chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	rdunlap@infradead.org, mark.rutland@arm.com,
	zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v12 4/5] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20241206165457.GA3101599@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208025652.87192-5-xueshuai@linux.alibaba.com>

On Fri, Dec 08, 2023 at 10:56:51AM +0800, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is a PCIe
> configuration space register block provided by each PCIe Root Port in a
> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> injection, and Statistics).

> +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02

> +static const struct dwc_pcie_vendor_id dwc_pcie_vendor_ids[] = {
> +	{.vendor_id = PCI_VENDOR_ID_ALIBABA },
> +	{} /* terminator */
> +};

> +static bool dwc_pcie_match_des_cap(struct pci_dev *pdev)
> +{
> +	const struct dwc_pcie_vendor_id *vid;
> +	u16 vsec;
> +	u32 val;
> +
> +	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> +		return false;
> +
> +	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
> +		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
> +						DWC_PCIE_VSEC_RAS_DES_ID);

This looks wrong to me, and it promotes a misunderstanding of how VSEC
Capabilities work.  The VSEC ID is defined by the vendor, so we have
to check both the Vendor ID and the VSEC ID before we know what this
VSEC Capability is.

In this patch, we only find a VSEC Capability that matches
(PCI_VENDOR_ID_ALIBABA, DWC_PCIE_VSEC_RAS_DES_ID), but as of
v6.13-rc1, it finds all of these:

  (PCI_VENDOR_ID_ALIBABA, DWC_PCIE_VSEC_RAS_DES_ID)
  (PCI_VENDOR_ID_AMPERE, DWC_PCIE_VSEC_RAS_DES_ID)
  (PCI_VENDOR_ID_QCOM, DWC_PCIE_VSEC_RAS_DES_ID)

There is no assurance that DWC_PCIE_VSEC_RAS_DES_ID means the same
thing to Alibaba, Ampere, and Qualcomm because each company defines
what 0x02 means to it.  PCIe r6.0, sec 7.9.5 for details.

I alluded to this earlier [1] and suggested that these devices should
have used a Designated Vendor-Specific (DVSEC) Capability instead of a 
Vendor-Specific (VSEC) Capability.

But since they didn't, I think the dwc_pcie_vendor_ids[] table is a
dangerous way to work around this because it suggests that all we have
to do is add new vendors to that table.

I think the table should be extended to contain the Vendor ID, *and*
the VSEC ID, *and* the VSEC Rev used by that vendor, i.e., it should
look like this:

  struct dwc_pcie_pmu_vsec {
    u16 vendor_id;
    u16 vsec_id;
    u8 vsec_rev;
  };

  struct dwc_pcie_pmu_vsec dwc_pcie_pmu_vsec_ids[] = {
    { .vendor_id = PCI_VENDOR_ID_ALIBABA,
      .vsec_id = DWC_PCIE_VSEC_RAS_DES_ID, .vsec_rev = 0x4 },
    { .vendor_id = PCI_VENDOR_ID_AMPERE,
      .vsec_id = DWC_PCIE_VSEC_RAS_DES_ID, .vsec_rev = 0x4 },
    { .vendor_id = PCI_VENDOR_ID_QCOM,
      .vsec_id = DWC_PCIE_VSEC_RAS_DES_ID, .vsec_rev = 0x4 },
    {}
  };

This *looks* the same, but it's not, because it makes it obvious that
the VSEC ID and VSEC Rev are defined separately by each vendor.  It's
just a lucky coincidence that they happen to be the same for these
vendors.

> +		if (vsec)
> +			break;
> +	}
> +	if (!vsec)
> +		return false;
> +
> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	if (PCI_VNDR_HEADER_REV(val) != 0x04)
> +		return false;
> +
> +	pci_dbg(pdev,
> +		"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> +	return true;
> +}

> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> +{
> +	struct pci_dev *pdev = plat_dev->dev.platform_data;
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	char *name;
> +	u32 bdf, val;
> +	u16 vsec;
> +	int ret;
> +
> +	vsec = pci_find_vsec_capability(pdev, pdev->vendor,
> +					DWC_PCIE_VSEC_RAS_DES_ID);
> +     pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);

Nit: "val" is never used, so why read it?

This looks even more wrong, because this matches ANY VSEC Capability
from ANY vendor that happens to be numbered DWC_PCIE_VSEC_RAS_DES_ID.

I know this is indirectly qualified by the check above in
dwc_pcie_match_des_cap(), but duplicating this here just spreads the
confusion about how to interpret VSEC IDs.

I suggest updating dwc_pcie_match_des_cap() to iterate through the
dwc_pcie_pmu_vsec_ids[] table and return the capability offset so you
can call it from here.

Bjorn

[1] https://lore.kernel.org/r/20231012162512.GA1069387@bhelgaas


