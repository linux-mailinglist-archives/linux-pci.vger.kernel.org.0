Return-Path: <linux-pci+bounces-42283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0EC938E3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 08:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E34E11B5
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D522B5A3;
	Sat, 29 Nov 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJXetbg0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF78322A;
	Sat, 29 Nov 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764401670; cv=none; b=E6Ky4B9YwShwkM5nfrC2mCMiWj+a3VKlQVcz8uPVeyYTRTL7PN4yikmP4M5+YfPXseeWDL8iu84eJg52n4zeVd1xa2qUjfhbngld6778QmTsBahLRL4UM6YrnJaWS624f2YYDDBvAJEpXxGZrKXcsf2M1ozq3VAZr8biT2j1VS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764401670; c=relaxed/simple;
	bh=eEMtRQQCdmCVNO+7tt/qLoH3sNPqRe8CEMaQ020tpxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnIDKQYvZk8hLjiDQROJtYPL+1XoGq9uxJ8pKLNDjzs2dTpMKzSO4doOqkM7AkSTIeuClKtG6mTJ8AUkJsbJBTifMQOWRaAqJuEn4JxuHG0lvSGDn6O4Qa6zbxcsSRffey+7mIeSdsV0H8UO+yVehjkSO6ZfpPm4F0EXSdUI584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJXetbg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE38C4CEF7;
	Sat, 29 Nov 2025 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764401670;
	bh=eEMtRQQCdmCVNO+7tt/qLoH3sNPqRe8CEMaQ020tpxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gJXetbg09Jz3XDriDH0EYviTuAI/GZ8jq8NknjECxGrY2zdZFU6D8XoCGT2YnnuUl
	 Sb1myUGqp2N1dsxWMk2ASKDe8J2LeYP9tuhO4rn0eLrhvN4S4hehtoikyKKttjZSOY
	 eSdTkS1IZR18uKsvuDwUc8HgsvHimuL32KiNEJzkBXKrSErVKm7ZlFl+k7mylKFw30
	 vjs15jPu4/r2u0/XvHg2xpGlLUezVBms6mFSjo03+fUBw/g/UpRocq3DSXbeqE/7bk
	 YpWaRWbRUK8UDFgfGmAvEFIAw0rgb9L//THQKYwu9PxC2oxIjZidQy/8DW2zHHgQuD
	 2AjU9f/ntfviw==
Date: Sat, 29 Nov 2025 13:04:15 +0530
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
Message-ID: <mp67n7jw3azihax25yw2u25f6nrjl237exw2t66fz3bpt3wzdt@2j4ooqdfgp2l>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
 <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
 <09aed728-51ca-42dd-b680-f6597e0ac00a@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09aed728-51ca-42dd-b680-f6597e0ac00a@rock-chips.com>

On Fri, Nov 28, 2025 at 09:03:52AM +0800, Shawn Lin wrote:
> 在 2025/11/27 星期四 23:30, Sushrut Shree Trivedi 写道:
> > For some controllers, HW doesn't program the correct device-id
> > leading to incorrect identification in lspci. For ex, QCOM
> > controller SC7280 uses same device id as SM8250. This would
> > cause issues while applying controller specific quirks.
> > 
> > So, program the correct device-id after reading it from the
> > devicetree.
> > 
> > Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
> >   drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
> >   2 files changed, 9 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index e92513c5bda5..e8b975044b22 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -619,6 +619,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   		}
> >   	}
> > +	pp->device_id = 0xffff;
> > +	of_property_read_u32(np, "device-id", &pp->device_id);
> > +
> >   	dw_pcie_version_detect(pci);
> >   	dw_pcie_iatu_detect(pci);
> > @@ -1094,6 +1097,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >   	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> > +	/* Program correct device id */
> > +	if (pp->device_id != 0xffff)
> > +		dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, pp->device_id);
> > +
> >   	/* Program correct class for RC */
> >   	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index e995f692a1ec..eff6da9438c4 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -431,6 +431,8 @@ struct dw_pcie_rp {
> >   	struct pci_config_window *cfg;
> >   	bool			ecam_enabled;
> >   	bool			native_ecam;
> > +	u32			vendor_id;
> 
> I don't see where vendor_id is used.
> And why should dwc core take care of per HW bugs, could someone else
> will argue their HW doesn't program correct vender id/class code, then
> we add more into dw_pcie_rp to fix these?
> 

Device ID and Vendor ID are PCI generic properties and many controllers specify
them in devicetree due to the default values being wrong or just hardcode them
in the driver. There is nothing wrong in DWC core programming these values if
they are available in devicetree.

> How about do it in the defective HW drivers?
> 

If the issue is a vendor DWC wrapper specific, for sure it should be added to
the relevant controller driver. But this issue is pretty common among the DWC
wrapper implementations.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

