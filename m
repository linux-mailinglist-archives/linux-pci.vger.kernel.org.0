Return-Path: <linux-pci+bounces-19905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62056A128B8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC351889A3B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB319165F18;
	Wed, 15 Jan 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFTeRhR1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C51922F9
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958612; cv=none; b=rJVaDiCuhKBulYB01bAAxiFNbQvWv1OLgFbkD4WykyWvVBnRwOigrBRZtdViTPtJcEFsb04Zkzo91NL5Iq+wOQoVof0DTd6T/3ESUTKXXaCPHSEtHah/44ST6H3FbGwvvVb9qRYjridDwLR3xhwMInlGlzC/epW4olts5oVFKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958612; c=relaxed/simple;
	bh=EjbjhB4nWdTPY/Sb1MthSkDSTodqXRjxI9avRhV9qTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do+DOvHP9DaIElGQqfOHIrjKr0A9EDrC/wNP/Bf0HrIIbwuFX2EvYvB7CnoW58lcuuZnyCv4DRuun+WTZdfBIC6tRAHTnW4WrNivi86pR05VaI3+jNamrhmyiDFKHVqQG+aOsnm4dUZCd/LC4CCsBqdmTIj+qoWieLdJNX2F24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFTeRhR1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21680814d42so105164745ad.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 08:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736958610; x=1737563410; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f7qIsaOwOTTDTixEG1mPY3hDLZUo6K7d0W+1fzYSSaM=;
        b=nFTeRhR1QGDucJ8D5DByy1eYX9W5DVY1H93sIagS/prUIYPBPEBWtRaPRMqJkdfRaG
         yP+juXtMWCGU6XOHUmW1NB3oE2CWaRJRTKG9hxgK0sKW2KfWc9PvpSZn3NifJrgytGeS
         7wNgE0TZOEYclKYVTK02o67SJscrS+pcR72/fpfFAx9EfscJvIvqNqezJQaTt6WypfkS
         gcaBs971TEoUDrv028UFAC1JzUII4sApKq6jV1/IOaHY+oy6iokU6MHir7YeyEqLh1M1
         BiqHbA+C1lQQZW3GAAMcGDg0f5Vaz7KaryIYKCWboIFNYRn2UOOAehVKpIv+qUqKepHN
         WTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736958610; x=1737563410;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7qIsaOwOTTDTixEG1mPY3hDLZUo6K7d0W+1fzYSSaM=;
        b=kUQuOWe8jW2bpuqpCB0Wt8okFHWeD59RgYpqtYmk7DVE3DQlqBTi35NIy7eMbL2MnT
         eIWXpfw5k8cfCgz3hkuTuLfN2ZixJhXL3+Vc4bFt3uf4VdM6dod1pXUlJwMj5ks09VZk
         ygxwEN3iRzjmuFlRGFD3P90csDlqgWIihvtSxPRt4SZu1a3AH0ft0srbkzMCuVqTxCgf
         /DQ2df6tneUGrK+/NJixwOMAEtR2WKaySRWHcYuvQcCMJjNl3Baebp8w1cLqzUarN6lj
         Q+Zo3ZSmLmVRVCv9lqyzcMh76wzAeSzj1PCF4BP5XCtFMNmi5ePDazl7AwBO/9gQcDqc
         SgEA==
X-Forwarded-Encrypted: i=1; AJvYcCVNFvwkCO8dAOQA1ay3797YdwQ0xRgfZD4P6cAgBwPLDFW7EL8ogovN8X4Jkt5DP6ykd8NIO9LTEUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxos7haxxH8EgtUjhW0NnMjLI1A82gkSWR15YUlM0JwKCQW+saT
	YXqb6aEodN9mpwrb+6lLIP42P/r+h+Ub4KhvCQN95NBDdF1E9aJ0ihZgOPPsmQ==
X-Gm-Gg: ASbGncvqZeCEAX91zs8ea5Nn7UlLkFxBl59hbD20xgElCh7QIMkEnMn6GAP8ClnCxxb
	rkIBtlt7r33Sx47jJlGlMKragCDp6uOZ8AugvvddPS5hti8PemgAkdKBeptEwq3JFEaRX860k15
	+v+wHlsJkm5qpTURiF6ipYwP/iaaajJ25SqDbkVW/5BS02CvW0TlbDMDNu2wZU3cXXT8kbmAGIU
	yUXwgqL3IZPCsZ2ilNrYiUj1NPbkLKOThnxqYak44zTiYPQ726EUXg6k+rkJQipLBI=
X-Google-Smtp-Source: AGHT+IEOljgRwJBJJaJeTEE929d6cFWXwy22qzqGlQU3WNIplw9nnHynws7EFQ6t2c9kzt1nv+UAsA==
X-Received: by 2002:a05:6a21:33a6:b0:1e8:bff6:8356 with SMTP id adf61e73a8af0-1e8bff68643mr29933029637.20.1736958609567;
        Wed, 15 Jan 2025 08:30:09 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a319c3860easm9953727a12.50.2025.01.15.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:30:08 -0800 (PST)
Date: Wed, 15 Jan 2025 21:59:53 +0530
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
Message-ID: <20250115162953.yiwhq2m5s5nf7b33@thinkpad>
References: <20250115152742.yhb57c6cbbwrnjcg@thinkpad>
 <20250115161201.GA532637@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250115161201.GA532637@bhelgaas>

On Wed, Jan 15, 2025 at 10:12:01AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2025 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Dec 11, 2024 at 08:43:30AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Dec 11, 2024 at 05:15:50PM +0530, Shradha Todi wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Sent: 06 December 2024 21:43
> > > > > To: Shradha Todi <shradha.t@samsung.com>
> > > > > Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> > > > > kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> > > > > fan.ni@samsung.com; a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com;
> > > > > quic_krichai@quicinc.com; gost.dev@samsung.com
> > > > > Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
> > > > > 
> > > > > On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > > > > > Add vendor specific extended configuration space capability search API
> > > > > > using struct dw_pcie pointer for DW controllers.
> > > > > >
> > > > > > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > > > > > ---
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> > > > > > drivers/pci/controller/dwc/pcie-designware.h |  1 +
> > > > > >  2 files changed, 17 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > @@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> > > > > >  	return 0;
> > > > > >  }
> > > > > >
> > > > > > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> > > > > 
> > > > > To make sure that we find a VSEC ID that corresponds to the
> > > > > expected vendor, I think this interface needs to be the same
> > > > > as pci_find_vsec_capability().  In particular, it needs to take a
> > > > > "u16 vendor"
> > > >
> > > > As per my understanding, Synopsys is the vendor here when we talk
> > > > about vsec capabilities.  VSEC cap IDs are fixed for each vendor
> > > > (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP, 0x4
> > > > is always PTM responder and so on).
> > > 
> > > For VSEC, the vendor that matters is the one identified at 0x0 in
> > > config space.  That's why pci_find_vsec_capability() checks the
> > > supplied "vendor" against "dev->vendor".
> > > 
> > > > So no matter if the DWC IP is being integrated by Samsung, NVDIA or
> > > > Qcom, the vendor specific CAP IDs will remain constant. Now since
> > > > this function is being written as part of designware file, the
> > > > control will reach here only when the PCIe IP is DWC. So, we don't
> > > > really require a vendor ID to be checked here. EG: If 0x2 VSEC ID is
> > > > present in any DWC controller, it means RAS is supported. Please
> > > > correct me if I'm wrong.
> > > 
> > > In this case, the Vendor ID is typically Samsung, NVIDIA, Qcom, etc.,
> > > even though it may contain Synopsys DWC IP.  Each vendor assigns VSEC
> > > IDs independently, so VSEC ID 0x2 may mean something different to
> > > Samsung than it does to NVIDIA or Qcom.
> > > 
> > > PCIe r6.0, sec 7.9.5 has the details, but the important part is this:
> > > 
> > >   With a PCI Express Function, the structure and definition of the
> > >   vendor-specific Registers area is determined by the vendor indicated
> > >   by the Vendor ID field located at byte offset 00h in PCI-compatible
> > >   Configuration Space.
> > > 
> > > There IS a separate DVSEC ("Designated Vendor-Specific") Capability;
> > > see sec 7.9.6.  That one does include a DVSEC Vendor ID in the
> > > Capability itself, and this would make more sense for this situation.
> > > 
> > > If Synopsys assigned DVSEC ID 0x2 from the Synopsys namespace for RAS,
> > > then devices from Samsung, NVIDIA, Qcom, etc., could advertise a DVSEC
> > > Capability that contained a DVSEC Vendor ID of PCI_VENDOR_ID_SYNOPSYS
> > > with DVSEC ID 0x2, and all those devices could easily locate it.
> > > 
> > > Unfortunately Samsung et al used VSEC instead of DVSEC, so we're stuck
> > > with having to specify the device vendor and the VSEC ID assigned by
> > > that vendor, and those VSEC IDs might be different per vendor.
> > 
> > Atleast on Qcom platforms, VSEC_ID is 0x2 for RAS. But this is not
> > guaranteed to be the same as per the PCIe spec as you mentioned.
> > Though, I think it is safe to go with it since we have seen the same
> > IDs on 2 platforms (my gut feeling is that it is going to be the
> > same on other DWC vendor platforms as well). If we encounter
> > different IDs, then we can add vendor id check.
> 
> This series uses:
> 
>   dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES)
> 
> in dwc_pcie_rasdes_debugfs_init(), but I don't see any calls of that
> function yet.

I guess that the caller got missed unintentionally in patch 2/2.

>  If it is called only from code that already knows the
> device vendor has assigned VSEC ID 0x02 for the DWC RAS functionality,
> I guess it is "safe".
> 

It should be called from the DWC code driver (pcie-desginware-host.c).

> But I think it would be a bad idea because it perpetuates the
> misunderstanding that DesignWare can independently claim ownership of
> VSEC ID 0x02 for *all* vendors, and other vendors have already used
> VSEC ID 0x02 for different things (examples at [1]).  If any of them
> incorporates this DWC IP, they will have to use a different VSEC ID to
> avoid a collision with their existing VSEC ID 0x02.
> 

Fair enough. I was trying to avoid updating the vendor id table for enabling the
RAS DES debug feature, but I think it would be worth doing so (perf driver is
also doing the same).

So yeah, I'm OK with the idea of having the vendor_id check in this API.

(Also, I don't see the VSEC_IDs defined in the DWC reference manual that I got
access to).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

