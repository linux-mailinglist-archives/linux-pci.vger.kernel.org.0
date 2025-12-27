Return-Path: <linux-pci+bounces-43757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E19DDCDF47C
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 06:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87E863008188
	for <lists+linux-pci@lfdr.de>; Sat, 27 Dec 2025 05:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470719C566;
	Sat, 27 Dec 2025 05:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyN/v6To"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0269142A9D;
	Sat, 27 Dec 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766812220; cv=none; b=mLoadpX3FUzioyQRv7YsjnINDyBehb/TAUiq1lkIVS154YZYwXZgRuJw6Re/vXgUhKSLec58YprJRxDWG+dUCWi8C0xE7ja4o8s7JtPbNAjq3+ItuOWdQWMK4HrWF9WudSnHkTpPkxvcNqhv0pTnnJ3zqJfXjphrnwAuuH2O1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766812220; c=relaxed/simple;
	bh=Sbs7K7LSHhglyl8Edtv95fOY3s0v6ZYXYgPbT8PpirE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZByRjAi7FKha/tWk5G2k+XgvgTvZmWhlRljq+fqSQ+usgEjx37FL755XX5vagSXKyCYQ1yQV/Vr4geJK84uzEyQ/jpV8M/j5irpUHAE0+R8hEdVl9OwlQefGfQrHSZ/pQ/GhOiv+n/zFv7dR7UfTPbWOlaRJRhlZPFi+IRVJy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyN/v6To; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538ADC4CEF1;
	Sat, 27 Dec 2025 05:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766812219;
	bh=Sbs7K7LSHhglyl8Edtv95fOY3s0v6ZYXYgPbT8PpirE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZyN/v6ToUAd2CBgiPB4xgq7SP4MPnRRhOhmRl1gV0qBPBw9FC1e5e4bJqfSWnKeM5
	 iyshVNIL1TfXqH+110cwb+5kBE1FPQFzVjGp408Y8Tzo3NR8ghfc38gD0nmgwOobdk
	 IXAuunyVg6zCu6N2bQ+eNedWdBvbH8dSZMAvuUoqAg+nRnwELQ1dLwz4l/DCe1bl8X
	 0PI3JtzFwZCSLg2eFR2VK5fmgZQRlMe5u4XoiVLzpZkw/qSSxinpB4kL02S52mydH/
	 atJO4O2vIeva1CZYCh2QAtuLq5aQYAXtDbL2+pRvXt0rhib7+je/S2gatSS2P5XTfZ
	 XrvQNnNW+V6IA==
Date: Sat, 27 Dec 2025 10:40:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: Re: [PATCH 2/5] PCI: dwc: Add new APIs to remove standard and
 extended Capability
Message-ID: <466mx6loranawy6cwg2zi6fgtvnb3ij6llfamjtz5x6iz4xpaa@6p3egbit5zcy>
References: <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>
 <20251226210741.GA4141010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251226210741.GA4141010@bhelgaas>

On Fri, Dec 26, 2025 at 03:07:41PM -0600, Bjorn Helgaas wrote:
> On Sun, Nov 09, 2025 at 10:59:41PM -0800, Qiang Yu wrote:
> > On some platforms, certain PCIe Capabilities may be present in hardware
> > but are not fully implemented as defined in PCIe spec. These incomplete
> > capabilities should be hidden from the PCI framework to prevent unexpected
> > behavior.
> > 
> > Introduce two APIs to remove a specific PCIe Capability and Extended
> > Capability by updating the previous capability's next offset field to skip
> > over the unwanted capability. These APIs allow RC drivers to easily hide
> > unsupported or partially implemented capabilities from software.
> 
> It's super annoying to have to do this, but I suppose from the
> hardware point of view these things *could* work depending on the
> design of the platform outside the device.  So the designers probably
> assume platform firmware knows those details and hides things that
> aren't supported.  But in the DT case, there likely *is* no platform
> firmware, so the native RC driver has to do it instead.
> 

This is actually a synopsis IP bug, so I'm not sure what the expectations are
from vendor implementations pov. We do have platform firmware like UEFI, but
it doesn't remove the capabilities.

- Mani

> > Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> > Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
> > Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 53 ++++++++++++++++++++++++++++
> >  drivers/pci/controller/dwc/pcie-designware.h |  2 ++
> >  2 files changed, 55 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 5585d3ed74316bd218572484f6320019db8d6a10..24f8e9959cb81ca41e91d27057cc115d32e8d523 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -234,6 +234,59 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
> >  
> > +void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap)
> > +{
> > +	u8 cap_pos, pre_pos, next_pos;
> > +	u16 reg;
> > +
> > +	cap_pos = PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
> > +				 &pre_pos, pci);
> > +	if (!cap_pos)
> > +		return;
> > +
> > +	reg = dw_pcie_readw_dbi(pci, cap_pos);
> > +	next_pos = (reg & 0xff00) >> 8;
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	if (pre_pos == PCI_CAPABILITY_LIST)
> > +		dw_pcie_writeb_dbi(pci, PCI_CAPABILITY_LIST, next_pos);
> > +	else
> > +		dw_pcie_writeb_dbi(pci, pre_pos + 1, next_pos);
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_remove_capability);
> > +
> > +void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap)
> > +{
> > +	int cap_pos, next_pos, pre_pos;
> > +	u32 pre_header, header;
> > +
> > +	cap_pos = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, &pre_pos, pci);
> > +	if (!cap_pos)
> > +		return;
> > +
> > +	header = dw_pcie_readl_dbi(pci, cap_pos);
> 
> Blank line here to match style of other comments.
> 
> > +	/*
> > +	 * If the first cap at offset PCI_CFG_SPACE_SIZE is removed,
> > +	 * only set it's capid to zero as it cannot be skipped.
> 
> If setting the capid to zero works here, why won't it work for all
> capabilities?  If setting capid to zero is enough, we wouldn't need to
> mess with keeping track of the previous capability, and we could drop
> the first patch.
> 
> s/it's/its/
> 
> > +	 */
> > +	if (cap_pos == PCI_CFG_SPACE_SIZE) {
> > +		dw_pcie_dbi_ro_wr_en(pci);
> > +		dw_pcie_writel_dbi(pci, cap_pos, header & 0xffff0000);
> > +		dw_pcie_dbi_ro_wr_dis(pci);
> > +		return;
> > +	}
> > +
> > +	pre_header = dw_pcie_readl_dbi(pci, pre_pos);
> > +	next_pos = PCI_EXT_CAP_NEXT(header);
> > +
> > +	dw_pcie_dbi_ro_wr_en(pci);
> > +	dw_pcie_writel_dbi(pci, pre_pos,
> > +			  (pre_header & 0xfffff) | (next_pos << 20));
> > +	dw_pcie_dbi_ro_wr_dis(pci);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_remove_ext_capability);
> > +
> >  static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
> >  					  u16 vsec_id)
> >  {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index e995f692a1ecd10130d3be3358827f801811387f..b68dbc528001b63448db8b1a93bf56a5e53bd33e 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -552,6 +552,8 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> >  
> >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > +void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap);
> > +void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
> >  u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
> >  
> > 
> > -- 
> > 2.34.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

