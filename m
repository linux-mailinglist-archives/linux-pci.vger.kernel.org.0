Return-Path: <linux-pci+bounces-19904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427DA12878
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563C4188CAAE
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16D19CC2A;
	Wed, 15 Jan 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4n+ZtWM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644E19005D;
	Wed, 15 Jan 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957523; cv=none; b=YI+5rDIqrZWQvPKVhFI/zQ3mGfnl+4rBCw1wDGHPNVuvyjAbi0iYOS9tvvHTPV1GRbz3MNdcYDfHYatYYzMHnO6fnu+YOOLNJbygW1RJmpsn/QhWPVvqKnkCPFcKtO8+kAF8tyaqK27Vlmdq+Qb0Q79TWil/Lx5XNBYtxbGmNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957523; c=relaxed/simple;
	bh=ugyz+16BHipGJhsKjcLepcvo+Lpn9mTCoKYz+Z7BWa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MT/LjRqyctfmIB+r534jogBdRRxrINqy6wgjUTdG+mTDUMBnoHp6nMAKN/H/vIdv1tGiZB6CFJzHMwtN60f6ol1q6Ia0wqHs26CCEBhfnE4NeN1wyRQAEdYexPkZpNRdAd5lKKoGl8A/cCqXHJGrDE4IYLcVLAKgfPmnrz+EE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4n+ZtWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E74C4CED1;
	Wed, 15 Jan 2025 16:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736957523;
	bh=ugyz+16BHipGJhsKjcLepcvo+Lpn9mTCoKYz+Z7BWa4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Q4n+ZtWMcI2hQBUMlmvav3s/iqB0oW+oYbLfausJ6fuNYkRs/36c7bN7VJdGE+CQs
	 ccnUOs8sY/KHL3c448cEHzKPm39Wvt31tVPkCxhDBG8EKsi0EAM5y3sm67cIHg2+rb
	 jGCZrDZ6IzkHKioN8SMWP+FYdIPMqPl0pIxWOKwVGxQM2dNR3Vd+HvV6KhGqGjkvf2
	 xn/bFAjYlpIsSoWdYsCvASeAsbfmflJcykMU+PC1wFcr08RSqYCvikMeF39bTxBTo+
	 ywzo7Koqz52yeFDJte5N+KHbvfV0rwlwt+0O1WAhn7A0ghwJ87M7Z9c2Ko5jhr1SHo
	 hl5bNWpVKSbLg==
Date: Wed, 15 Jan 2025 10:12:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20250115161201.GA532637@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115152742.yhb57c6cbbwrnjcg@thinkpad>

On Wed, Jan 15, 2025 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 11, 2024 at 08:43:30AM -0600, Bjorn Helgaas wrote:
> > On Wed, Dec 11, 2024 at 05:15:50PM +0530, Shradha Todi wrote:
> > > > -----Original Message-----
> > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > Sent: 06 December 2024 21:43
> > > > To: Shradha Todi <shradha.t@samsung.com>
> > > > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> > > > kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> > > > fan.ni@samsung.com; a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com;
> > > > quic_krichai@quicinc.com; gost.dev@samsung.com
> > > > Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
> > > > 
> > > > On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > > > > Add vendor specific extended configuration space capability search API
> > > > > using struct dw_pcie pointer for DW controllers.
> > > > >
> > > > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> > > > > drivers/pci/controller/dwc/pcie-designware.h |  1 +
> > > > >  2 files changed, 17 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > @@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> > > > 
> > > > To make sure that we find a VSEC ID that corresponds to the
> > > > expected vendor, I think this interface needs to be the same
> > > > as pci_find_vsec_capability().  In particular, it needs to take a
> > > > "u16 vendor"
> > >
> > > As per my understanding, Synopsys is the vendor here when we talk
> > > about vsec capabilities.  VSEC cap IDs are fixed for each vendor
> > > (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP, 0x4
> > > is always PTM responder and so on).
> > 
> > For VSEC, the vendor that matters is the one identified at 0x0 in
> > config space.  That's why pci_find_vsec_capability() checks the
> > supplied "vendor" against "dev->vendor".
> > 
> > > So no matter if the DWC IP is being integrated by Samsung, NVDIA or
> > > Qcom, the vendor specific CAP IDs will remain constant. Now since
> > > this function is being written as part of designware file, the
> > > control will reach here only when the PCIe IP is DWC. So, we don't
> > > really require a vendor ID to be checked here. EG: If 0x2 VSEC ID is
> > > present in any DWC controller, it means RAS is supported. Please
> > > correct me if I'm wrong.
> > 
> > In this case, the Vendor ID is typically Samsung, NVIDIA, Qcom, etc.,
> > even though it may contain Synopsys DWC IP.  Each vendor assigns VSEC
> > IDs independently, so VSEC ID 0x2 may mean something different to
> > Samsung than it does to NVIDIA or Qcom.
> > 
> > PCIe r6.0, sec 7.9.5 has the details, but the important part is this:
> > 
> >   With a PCI Express Function, the structure and definition of the
> >   vendor-specific Registers area is determined by the vendor indicated
> >   by the Vendor ID field located at byte offset 00h in PCI-compatible
> >   Configuration Space.
> > 
> > There IS a separate DVSEC ("Designated Vendor-Specific") Capability;
> > see sec 7.9.6.  That one does include a DVSEC Vendor ID in the
> > Capability itself, and this would make more sense for this situation.
> > 
> > If Synopsys assigned DVSEC ID 0x2 from the Synopsys namespace for RAS,
> > then devices from Samsung, NVIDIA, Qcom, etc., could advertise a DVSEC
> > Capability that contained a DVSEC Vendor ID of PCI_VENDOR_ID_SYNOPSYS
> > with DVSEC ID 0x2, and all those devices could easily locate it.
> > 
> > Unfortunately Samsung et al used VSEC instead of DVSEC, so we're stuck
> > with having to specify the device vendor and the VSEC ID assigned by
> > that vendor, and those VSEC IDs might be different per vendor.
> 
> Atleast on Qcom platforms, VSEC_ID is 0x2 for RAS. But this is not
> guaranteed to be the same as per the PCIe spec as you mentioned.
> Though, I think it is safe to go with it since we have seen the same
> IDs on 2 platforms (my gut feeling is that it is going to be the
> same on other DWC vendor platforms as well). If we encounter
> different IDs, then we can add vendor id check.

This series uses:

  dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES)

in dwc_pcie_rasdes_debugfs_init(), but I don't see any calls of that
function yet.  If it is called only from code that already knows the
device vendor has assigned VSEC ID 0x02 for the DWC RAS functionality,
I guess it is "safe".

But I think it would be a bad idea because it perpetuates the
misunderstanding that DesignWare can independently claim ownership of
VSEC ID 0x02 for *all* vendors, and other vendors have already used
VSEC ID 0x02 for different things (examples at [1]).  If any of them
incorporates this DWC IP, they will have to use a different VSEC ID to
avoid a collision with their existing VSEC ID 0x02.

Bjorn

[1] https://lore.kernel.org/r/20241209222938.3219364-1-helgaas@kernel.org/

