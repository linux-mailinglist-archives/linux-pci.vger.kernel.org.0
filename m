Return-Path: <linux-pci+bounces-18143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C59ECEE2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE601885DEF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD363195811;
	Wed, 11 Dec 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpjv7a8u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B3316F0CF;
	Wed, 11 Dec 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928212; cv=none; b=EaOErRNMMMYB/DjTw91eAj5GM3uSB5Mg6d2Ixvm/hqY75WR3VRt1HNGU7vXNEoamWUh++2MrjCa+cN9Ltmrab0UxxTczPvzG2K4Bj1Ia0Va2Kz+4HPNd9iBCQitS5KkHNd4vHvKmq/7CBrvkuTfTsLxVBRHw1s+nKJorm+esC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928212; c=relaxed/simple;
	bh=WdusEtqXKPC2wUkbqXcTD3TRpiQ9dBT+3oTxsPyVwvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hg1aiBzn9BUYbpLIOmidx8TE/ZSOcNgLuH+n/7znQA3yNhrnuNF6SsqLmTeVZGeBFg3l6vhHID8Tc+uobey2G15EU/3FxVG/1cRJqbPDzIB74ymyJnex+RGatYjGvtcqoaUEwumBfYsc4si5qn7l+qdnDIZIUdxx9eUHekt2bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpjv7a8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E49C4CEDD;
	Wed, 11 Dec 2024 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928212;
	bh=WdusEtqXKPC2wUkbqXcTD3TRpiQ9dBT+3oTxsPyVwvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dpjv7a8uGeLiT2jrmKW+d7QCKB1bfw4GfXJByBI7BFW41UV1NXM9W451Ydtu2I905
	 XnpN8mtlObefYXuEEICnUvbWWaf96xtvyM183YJW+UcOOdxhFYpDnj0CrSdMv/y8jZ
	 Md38AXagqAhO/b08S94FAibWpECp3IbKYq1LsldPBZu67gkHDL9eeGFd5kIWt7DAMF
	 ZfRAchXRDhfL6rIO5RAPhjuz8MWBAadHf/Hfs5/Tu/VSejTVifQfJfjZ01+nfx+B3x
	 LYxLJxzUq1qwQUuD3qeBUDVEFDkLq4i6E7r14kvNQwr1ZSy2RgmA0sFZqSJO1tc9zj
	 b8gxdgS1XelcQ==
Date: Wed, 11 Dec 2024 08:43:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, quic_nitegupt@quicinc.com,
	quic_krichai@quicinc.com, gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20241211144330.GA3290532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d6301db4bc2$3be58dc0$b3b0a940$@samsung.com>

On Wed, Dec 11, 2024 at 05:15:50PM +0530, Shradha Todi wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: 06 December 2024 21:43
> > To: Shradha Todi <shradha.t@samsung.com>
> > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> > kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> > fan.ni@samsung.com; a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com;
> > quic_krichai@quicinc.com; gost.dev@samsung.com
> > Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
> > 
> > On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > > Add vendor specific extended configuration space capability search API
> > > using struct dw_pcie pointer for DW controllers.
> > >
> > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> > > drivers/pci/controller/dwc/pcie-designware.h |  1 +
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > @@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > >  	return 0;
> > >  }
> > >
> > > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> > 
> > To make sure that we find a VSEC ID that corresponds to the
> > expected vendor, I think this interface needs to be the same
> > as pci_find_vsec_capability().  In particular, it needs to take a
> > "u16 vendor"
>
> As per my understanding, Synopsys is the vendor here when we talk
> about vsec capabilities.  VSEC cap IDs are fixed for each vendor
> (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP, 0x4
> is always PTM responder and so on).

For VSEC, the vendor that matters is the one identified at 0x0 in
config space.  That's why pci_find_vsec_capability() checks the
supplied "vendor" against "dev->vendor".

> So no matter if the DWC IP is being integrated by Samsung, NVDIA or
> Qcom, the vendor specific CAP IDs will remain constant. Now since
> this function is being written as part of designware file, the
> control will reach here only when the PCIe IP is DWC. So, we don't
> really require a vendor ID to be checked here. EG: If 0x2 VSEC ID is
> present in any DWC controller, it means RAS is supported. Please
> correct me if I'm wrong.

In this case, the Vendor ID is typically Samsung, NVIDIA, Qcom, etc.,
even though it may contain Synopsys DWC IP.  Each vendor assigns VSEC
IDs independently, so VSEC ID 0x2 may mean something different to
Samsung than it does to NVIDIA or Qcom.

PCIe r6.0, sec 7.9.5 has the details, but the important part is this:

  With a PCI Express Function, the structure and definition of the
  vendor-specific Registers area is determined by the vendor indicated
  by the Vendor ID field located at byte offset 00h in PCI-compatible
  Configuration Space.

There IS a separate DVSEC ("Designated Vendor-Specific") Capability;
see sec 7.9.6.  That one does include a DVSEC Vendor ID in the
Capability itself, and this would make more sense for this situation.

If Synopsys assigned DVSEC ID 0x2 from the Synopsys namespace for RAS,
then devices from Samsung, NVIDIA, Qcom, etc., could advertise a DVSEC
Capability that contained a DVSEC Vendor ID of PCI_VENDOR_ID_SYNOPSYS
with DVSEC ID 0x2, and all those devices could easily locate it.

Unfortunately Samsung et al used VSEC instead of DVSEC, so we're stuck
with having to specify the device vendor and the VSEC ID assigned by
that vendor, and those VSEC IDs might be different per vendor.

Bjorn

