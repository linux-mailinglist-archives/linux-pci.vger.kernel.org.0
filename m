Return-Path: <linux-pci+bounces-19903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E4EA12769
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3A43A026D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270186348;
	Wed, 15 Jan 2025 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPDhGXdB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7A14D6EF
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954883; cv=none; b=YBDyeO7mkSdtnqHV5UQmKtfNpKnOOpb4EIjj3uLy5q3NmUhk3OvZ4VXd12vnr5454hTMnz7PqoyPIgkJK4a2cQD7YpP6wHFzAUO1v8dyUt3gCBqo/4j/n6PDHLMWBHdirIMxXY7DlCgr34TQ2ODipx/E7bL/Z9sG4bwNcbtiaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954883; c=relaxed/simple;
	bh=YdzGKNP/Qk23MTdjhOWkFnfepS9dKfT39BckYdG7WmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyMFWsj1ikejDOJ2xm3LDv3oYW75a8aTfTf84sa4IkCmjWrLYh1p7zE8NbopfYMInlT2CiUOYa2QgT1idjeYuxGbaLCiBRMOBwcGcwYUxLOeD4rrSllllYAafQqy87nuMe2WMth3gzhoAclaiepy04XM0hDFPJmGD7Myh960Xjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPDhGXdB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-218c8aca5f1so150919485ad.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 07:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736954881; x=1737559681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S80YuhXdzDbWTfH2sADndFqioqUD8bGbjDqieqVBsK0=;
        b=wPDhGXdBW19VLmUj5HVcOpWn0/f43abiSrHfgymad2Emu/HjldoKjt6QkqEyd3ICTN
         7Rychl7igXkOrU078xH0wwJkT1jHJMlvGB1NM22AfdZi8uo58YXuyKQ+ZOL5EjxGgdj1
         3oTb2DMyG7Ynmicrmib+t8M8wHb++VdLszFfmi43m8wBLXtH61QOavU+KMPQN+hTRL25
         F7QHSRppczJVY43h3ERM4FId6JRnCaYaFHbf64G43hYKHgrBS5gtATbZZNpuX1ojCGJG
         1o3mhsO2dmO9MALzPgWuFjGbG76Gb3nWG+8guFzXkRKUxoMnrwmE5a0re9g1YxdKXAbt
         LMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954881; x=1737559681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S80YuhXdzDbWTfH2sADndFqioqUD8bGbjDqieqVBsK0=;
        b=QBtEHoA6VYZsK9+G2VGCjFp6shwxLveYem78pdOZxdRRZoEC0A0EulYMDzNPZtaWIT
         DDSWcETKBXXSwyQpXNQi8+Bzw6fM++SQXZ+Q18Ron+qdW0SpekGVjY7OkVx02XD1BW+P
         RdXnuF0LvNBqQMWWum3TsV1mQkCAOdK7SZFOFcZGF0lJXR7EgXJecMfb5auzOjMyqeap
         WQRGFGJo1Um7He3MSUUz8xemz8SaW0Z4LqiWgKHDUewVngcMM6lNFGBgEqmcoIDQKQw8
         42B3Ab5X+K6qyFi1I63yHHGr1RwehcMaI0HdYT3MoSNQDvoCPRkfUvhikENVGLCs3eqz
         m1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU9PLkqBUPMyJt1F2ejJ+49LCXaQSVQVEhskv3f92jQ0d/vmX77rO9CeTThlJHJ00QS6iTC8Mvnyvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsrL7gStj4d/jYPzP6ZQfbwrdyKUL1O3bUbRsNXkCQ07360ck
	YLQ+2ofG74k3pdD+/KKn/vEByF7MCk50dIpGlQJ/rH8ad42fVDuw9Qce1PJ5cQ==
X-Gm-Gg: ASbGncselQNkaAfsZLVt466hYjQjlNIH4CWzyXJtAuabIEhIf+iCd8qRwvguJOBNqlR
	8E4ZqXj2kzPxYWq7LGfbewpTcM5Z1u2rQX6wOifIVSbPC8tZs2yfHyFdu32ORD0Vxo7dveKC7bc
	a4jzgTjdrvbGOWup6eId96WObc+l1jxUrhnFTpA4l51VpaysVV+IKuOTvWgZxS8PFgrLLIO8teP
	yGWMxkq0ZeAP2WMbpdnNZbhx99IlvMLu2rgbe/DG4IiOQONt6YOjEaS9WMaLVH8uo0=
X-Google-Smtp-Source: AGHT+IGyq5mkIxS6iUdyia2Ll49Bjnpc08UihLTPQyOs2Yj3RDpsPli9Elf82CzfHQt4rPPXja1VzA==
X-Received: by 2002:a05:6a00:b89:b0:726:f7c9:7b28 with SMTP id d2e1a72fcca58-72d21f383abmr49540140b3a.8.1736954879680;
        Wed, 15 Jan 2025 07:27:59 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a6b4sm9558412b3a.60.2025.01.15.07.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 07:27:58 -0800 (PST)
Date: Wed, 15 Jan 2025 20:57:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	quic_nitegupt@quicinc.com, quic_krichai@quicinc.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Message-ID: <20250115152742.yhb57c6cbbwrnjcg@thinkpad>
References: <0d6301db4bc2$3be58dc0$b3b0a940$@samsung.com>
 <20241211144330.GA3290532@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211144330.GA3290532@bhelgaas>

On Wed, Dec 11, 2024 at 08:43:30AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 11, 2024 at 05:15:50PM +0530, Shradha Todi wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: 06 December 2024 21:43
> > > To: Shradha Todi <shradha.t@samsung.com>
> > > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> > > kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> > > fan.ni@samsung.com; a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com;
> > > quic_krichai@quicinc.com; gost.dev@samsung.com
> > > Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
> > > 
> > > On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > > > Add vendor specific extended configuration space capability search API
> > > > using struct dw_pcie pointer for DW controllers.
> > > >
> > > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> > > > drivers/pci/controller/dwc/pcie-designware.h |  1 +
> > > >  2 files changed, 17 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > > >  	return 0;
> > > >  }
> > > >
> > > > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> > > 
> > > To make sure that we find a VSEC ID that corresponds to the
> > > expected vendor, I think this interface needs to be the same
> > > as pci_find_vsec_capability().  In particular, it needs to take a
> > > "u16 vendor"
> >
> > As per my understanding, Synopsys is the vendor here when we talk
> > about vsec capabilities.  VSEC cap IDs are fixed for each vendor
> > (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP, 0x4
> > is always PTM responder and so on).
> 
> For VSEC, the vendor that matters is the one identified at 0x0 in
> config space.  That's why pci_find_vsec_capability() checks the
> supplied "vendor" against "dev->vendor".
> 
> > So no matter if the DWC IP is being integrated by Samsung, NVDIA or
> > Qcom, the vendor specific CAP IDs will remain constant. Now since
> > this function is being written as part of designware file, the
> > control will reach here only when the PCIe IP is DWC. So, we don't
> > really require a vendor ID to be checked here. EG: If 0x2 VSEC ID is
> > present in any DWC controller, it means RAS is supported. Please
> > correct me if I'm wrong.
> 
> In this case, the Vendor ID is typically Samsung, NVIDIA, Qcom, etc.,
> even though it may contain Synopsys DWC IP.  Each vendor assigns VSEC
> IDs independently, so VSEC ID 0x2 may mean something different to
> Samsung than it does to NVIDIA or Qcom.
> 
> PCIe r6.0, sec 7.9.5 has the details, but the important part is this:
> 
>   With a PCI Express Function, the structure and definition of the
>   vendor-specific Registers area is determined by the vendor indicated
>   by the Vendor ID field located at byte offset 00h in PCI-compatible
>   Configuration Space.
> 
> There IS a separate DVSEC ("Designated Vendor-Specific") Capability;
> see sec 7.9.6.  That one does include a DVSEC Vendor ID in the
> Capability itself, and this would make more sense for this situation.
> 
> If Synopsys assigned DVSEC ID 0x2 from the Synopsys namespace for RAS,
> then devices from Samsung, NVIDIA, Qcom, etc., could advertise a DVSEC
> Capability that contained a DVSEC Vendor ID of PCI_VENDOR_ID_SYNOPSYS
> with DVSEC ID 0x2, and all those devices could easily locate it.
> 
> Unfortunately Samsung et al used VSEC instead of DVSEC, so we're stuck
> with having to specify the device vendor and the VSEC ID assigned by
> that vendor, and those VSEC IDs might be different per vendor.
> 

Atleast on Qcom platforms, VSEC_ID is 0x2 for RAS. But this is not guaranteed to
be the same as per the PCIe spec as you mentioned. Though, I think it is safe to
go with it since we have seen the same IDs on 2 platforms (my gut feeling is
that it is going to be the same on other DWC vendor platforms as well). If we
encounter different IDs, then we can add vendor id check.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

