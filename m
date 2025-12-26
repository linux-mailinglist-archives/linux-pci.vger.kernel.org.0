Return-Path: <linux-pci+bounces-43734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E35CDF028
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1054E3003513
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05852309EF1;
	Fri, 26 Dec 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G05ER5es"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98621D5CC9;
	Fri, 26 Dec 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766783263; cv=none; b=UKhzCkHOVq75HqqWALRjNOdgzZtnAqohMnz+Q2HKjbxmNpoFruyMjRYtUIJR+3+JDK/j9n5jAJDIL4tBfHxe4WuE0d9T75+xMabX15f2HEj8ZzGYZ/KQtdAEXa/Pd6gDyCHCa33vIXlW0tkoNZWRqYW2rcTDXxmPAAKv437rIHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766783263; c=relaxed/simple;
	bh=1rqDt38CMcXkuPUyWW7esBUPmj5SlC33JQv157e3mX4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J1HdoUhNMBF4SecpJetnbdDQffdEcPZu+l2FTMxLyG55JIytC/vMBqhmUG02+QivG1LXF9yB1w/MXdd9OwsObRTsWXviJB9alGclbh1X5yTOeTTXPTj0rdintOB1rL9lMRAxdirc8OzF7xPFUrVxcRfBS7TgUKuyBmopQHbuuQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G05ER5es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B161C4CEF7;
	Fri, 26 Dec 2025 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766783263;
	bh=1rqDt38CMcXkuPUyWW7esBUPmj5SlC33JQv157e3mX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G05ER5esrFiSm/edvAWz6H8W3ZncfKMROUM0RlNlfFSS93iBheEFizCwIF7jBii/u
	 NM6AFfln7TkKYpwSjiHOSr1JKX2EQPtaU8/mar/3EP4Fp3zOYZRELinl7FpKfB7W/a
	 yr89y1gWd2b3LWW4b2ARpCcz/VjqaYzcI9zL6FxhUtWpcRHkdTlqNj3D2SIJ912AxQ
	 4ti3ARYBvow2DLlLt75Y8ioGtb0FatvDOxLzHtJn6hzEnbPw6am3K6+K4p3rJnT8FZ
	 G0n8vAPCNIXVuaflbd6rdG2HW7q7Wk0mDhklFnjLOECsu54bh9SIqMThNR2yxlmA+K
	 GyX3KwkfOsxPQ==
Date: Fri, 26 Dec 2025 15:07:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] PCI: dwc: Add new APIs to remove standard and
 extended Capability
Message-ID: <20251226210741.GA4141010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>

On Sun, Nov 09, 2025 at 10:59:41PM -0800, Qiang Yu wrote:
> On some platforms, certain PCIe Capabilities may be present in hardware
> but are not fully implemented as defined in PCIe spec. These incomplete
> capabilities should be hidden from the PCI framework to prevent unexpected
> behavior.
> 
> Introduce two APIs to remove a specific PCIe Capability and Extended
> Capability by updating the previous capability's next offset field to skip
> over the unwanted capability. These APIs allow RC drivers to easily hide
> unsupported or partially implemented capabilities from software.

It's super annoying to have to do this, but I suppose from the
hardware point of view these things *could* work depending on the
design of the platform outside the device.  So the designers probably
assume platform firmware knows those details and hides things that
aren't supported.  But in the DT case, there likely *is* no platform
firmware, so the native RC driver has to do it instead.

> Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 53 ++++++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 5585d3ed74316bd218572484f6320019db8d6a10..24f8e9959cb81ca41e91d27057cc115d32e8d523 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -234,6 +234,59 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
>  
> +void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap)
> +{
> +	u8 cap_pos, pre_pos, next_pos;
> +	u16 reg;
> +
> +	cap_pos = PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
> +				 &pre_pos, pci);
> +	if (!cap_pos)
> +		return;
> +
> +	reg = dw_pcie_readw_dbi(pci, cap_pos);
> +	next_pos = (reg & 0xff00) >> 8;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	if (pre_pos == PCI_CAPABILITY_LIST)
> +		dw_pcie_writeb_dbi(pci, PCI_CAPABILITY_LIST, next_pos);
> +	else
> +		dw_pcie_writeb_dbi(pci, pre_pos + 1, next_pos);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_remove_capability);
> +
> +void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap)
> +{
> +	int cap_pos, next_pos, pre_pos;
> +	u32 pre_header, header;
> +
> +	cap_pos = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, &pre_pos, pci);
> +	if (!cap_pos)
> +		return;
> +
> +	header = dw_pcie_readl_dbi(pci, cap_pos);

Blank line here to match style of other comments.

> +	/*
> +	 * If the first cap at offset PCI_CFG_SPACE_SIZE is removed,
> +	 * only set it's capid to zero as it cannot be skipped.

If setting the capid to zero works here, why won't it work for all
capabilities?  If setting capid to zero is enough, we wouldn't need to
mess with keeping track of the previous capability, and we could drop
the first patch.

s/it's/its/

> +	 */
> +	if (cap_pos == PCI_CFG_SPACE_SIZE) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writel_dbi(pci, cap_pos, header & 0xffff0000);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +		return;
> +	}
> +
> +	pre_header = dw_pcie_readl_dbi(pci, pre_pos);
> +	next_pos = PCI_EXT_CAP_NEXT(header);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writel_dbi(pci, pre_pos,
> +			  (pre_header & 0xfffff) | (next_pos << 20));
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_remove_ext_capability);
> +
>  static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
>  					  u16 vsec_id)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ecd10130d3be3358827f801811387f..b68dbc528001b63448db8b1a93bf56a5e53bd33e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -552,6 +552,8 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
>  
>  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> +void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap);
> +void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap);
>  u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
>  u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
>  
> 
> -- 
> 2.34.1
> 

