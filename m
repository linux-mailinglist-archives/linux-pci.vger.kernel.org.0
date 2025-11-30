Return-Path: <linux-pci+bounces-42325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26974C9509A
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 16:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEC524E0334
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77C81F428C;
	Sun, 30 Nov 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBs4U6Vw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFC336D51D;
	Sun, 30 Nov 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764515151; cv=none; b=cku67oU+F0Yl/H5kgr8IzsdecCcGQCOML9dRjzRTMNnRu3PXq2uCncF3BFxHB0GIqciC3aY1f3TzVvJooy2VKy317wmAENlI/YJUS5CCVaNAcIgZ+C3GWwAXoO4OfJrq0emE1lWGKd2JNK0sSGYkU/scZJNqWnFUOR/BSsjerBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764515151; c=relaxed/simple;
	bh=5igU6iZCO9sZzOv7NKAHjynR/Bzto2i1XAMlvnec8a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPYBpByV4r30bg1VDYBhCw4sS70NMHAw0ecpGEYvLiFRfXlbvcLJjgQ3SvM6JQHZ9v1RP09iEL5o6ZtVyiBvHG9EvogbdMu6pk/8yyIuT8qTbgIjwE/qFQhbFAJc2Ur5Evpzq81BCF/2Ms8Mv9Eem/1RiJet6wFIiM038yVm9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBs4U6Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F04C4CEF8;
	Sun, 30 Nov 2025 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764515151;
	bh=5igU6iZCO9sZzOv7NKAHjynR/Bzto2i1XAMlvnec8a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBs4U6VwKPeehwoTBBhnMasIiMgXzfqTwKpe47JAljwaVwoCgX3Byta7rZHgBEbwC
	 Q0axt5RhFqranHo5TGtT6qP1YfGVdQ+nzaM5jXKPdgqp3H3mbMWoljUUZWsLhkl2ti
	 CN9xwnWZik9IK76+g3uIMI1biofz0AZbPny5GYeicyAIwVzVtDIlBB9gHrkGzej00s
	 MDQ+uFfyWBhSTNSRv8TqCo5GRFUGIYHwn4pVSSxDRV0fIMwcz5FGCF8DJO6ubqlN1f
	 +5lkoewUVS977NAXgbY/bsbhZyKZu797Ki21lVLvWCD7oEZ9azPxDwbjpsTPNOC1DR
	 +iZm2xM9diiHw==
Date: Sun, 30 Nov 2025 20:35:35 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Program device-id
Message-ID: <2mhc33c5wvaaa7krhfrilz7qkfm47efx7h2esnydyzz4sk5umw@jxixtcmrsq76>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
 <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
 <09aed728-51ca-42dd-b680-f6597e0ac00a@rock-chips.com>
 <mp67n7jw3azihax25yw2u25f6nrjl237exw2t66fz3bpt3wzdt@2j4ooqdfgp2l>
 <c43b637a-a0c1-4106-b37b-df389c085057@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c43b637a-a0c1-4106-b37b-df389c085057@rock-chips.com>

On Sun, Nov 30, 2025 at 10:43:14AM +0800, Shawn Lin wrote:
> 在 2025/11/29 星期六 15:34, Manivannan Sadhasivam 写道:
> > On Fri, Nov 28, 2025 at 09:03:52AM +0800, Shawn Lin wrote:
> > > 在 2025/11/27 星期四 23:30, Sushrut Shree Trivedi 写道:
> > > > For some controllers, HW doesn't program the correct device-id
> > > > leading to incorrect identification in lspci. For ex, QCOM
> > > > controller SC7280 uses same device id as SM8250. This would
> > > > cause issues while applying controller specific quirks.
> > > > 
> > > > So, program the correct device-id after reading it from the
> > > > devicetree.
> > > > 
> > > > Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> > > > ---
> > > >    drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
> > > >    drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
> > > >    2 files changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index e92513c5bda5..e8b975044b22 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -619,6 +619,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >    		}
> > > >    	}
> > > > +	pp->device_id = 0xffff;
> > > > +	of_property_read_u32(np, "device-id", &pp->device_id);
> > > > +
> > > >    	dw_pcie_version_detect(pci);
> > > >    	dw_pcie_iatu_detect(pci);
> > > > @@ -1094,6 +1097,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > > >    	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> > > > +	/* Program correct device id */
> > > > +	if (pp->device_id != 0xffff)
> > > > +		dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, pp->device_id);
> > > > +
> > > >    	/* Program correct class for RC */
> > > >    	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index e995f692a1ec..eff6da9438c4 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -431,6 +431,8 @@ struct dw_pcie_rp {
> > > >    	struct pci_config_window *cfg;
> > > >    	bool			ecam_enabled;
> > > >    	bool			native_ecam;
> > > > +	u32			vendor_id;
> > > 
> > > I don't see where vendor_id is used.
> > > And why should dwc core take care of per HW bugs, could someone else
> > > will argue their HW doesn't program correct vender id/class code, then
> > > we add more into dw_pcie_rp to fix these?
> > > 
> > 
> > Device ID and Vendor ID are PCI generic properties and many controllers specify
> > them in devicetree due to the default values being wrong or just hardcode them
> > in the driver. There is nothing wrong in DWC core programming these values if
> > they are available in devicetree.
> > 
> > > How about do it in the defective HW drivers?
> > > 
> > 
> > If the issue is a vendor DWC wrapper specific, for sure it should be added to
> > the relevant controller driver. But this issue is pretty common among the DWC
> > wrapper implementations.
> > 
> 
> I think there are already some dwc instances working around this kind of
> defects in their relevant condroller driver.
> 
> drivers/pci/controller/dwc/pci-keystone.c:806:  dw_pcie_writew_dbi(pci,
> PCI_VENDOR_ID, id & PCIE_VENDORID_MASK);
> 
> drivers/pci/controller/dwc/pcie-spacemit-k1.c:146: dw_pcie_writew_dbi(pci,
> PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
> 
> drivers/pci/controller/dwc/pcie-spear13xx.c:139: dw_pcie_writew_dbi(pci,
> PCI_VENDOR_ID, 0x104A);
> 
> drivers/pci/controller/dwc/pci-keystone.c:807:  dw_pcie_writew_dbi(pci,
> PCI_DEVICE_ID, id >> PCIE_DEVICEID_SHIFT);
> 
> drivers/pci/controller/dwc/pcie-spacemit-k1.c:147: dw_pcie_writew_dbi(pci,
> PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
> 
> drivers/pci/controller/dwc/pcie-spear13xx.c:140: dw_pcie_writew_dbi(pci,
> PCI_DEVICE_ID, 0xCD80);
> 
> If this patch applied, there are two non-consistent apporaches to work
> around this situation.

Nothing inconsistent here. DWC core will set the IDs based on the devicetree
properties if exist and controller drivers can override them or set sane default
if they want.

> Could dwc core provide a common helper for them(this
> qcom instance inclueded) to call without bothering the dwc core?
> 

Then the function will be called something like,

	dw_pcie_set_ids(dwc, 0x0, 0x0); /* for Qcom */
	dw_pcie_set_ids(dwc, PCI_VENDOR_ID_SPACEMIT, PCI_DEVICE_ID_SPACEMIT_K1);

I don't think combining both in the same API is a good idea. But I'm OK with an
API just to set the passed IDs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

