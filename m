Return-Path: <linux-pci+bounces-10425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEA69338B6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE441F21478
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4462262B;
	Wed, 17 Jul 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD/zR25A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617C224F2
	for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203992; cv=none; b=YOjvioACTozS2nJfqsuCt5GJVVs9y53eS8eHNDQ33bGhb+lBxXY5u/5Y4RsXWDhIQYhdqR4760ogVMIJIlwq90FjcVuImpNd37+VT73iK1ONsccRIkyOHWB6Qm7xLtIL6PXm4+7g+9zQrDZnonUcRukYIPwgRXThYsLoE7tQi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203992; c=relaxed/simple;
	bh=pRdDJ7PXZYswkhdkmWCe/QL2GMo4Ndprhummi2OxoTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL0tGqnYYl7L2cJoUTlcmV2sLreE5k2vBe03h8/X01NZm56rabzPzX2JUJ7G0VVMjH6Ws4tcUXuXV245aLoSyYIZ1n9GpggeJiSCkgvN0zXh7PE02fqEd+by4fDDIgGMujsA2OwU45IzFiAPwwql/xJvbMaY8wwC3ssNJ84kCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GD/zR25A; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dab2bb288aso2384548b6e.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Jul 2024 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721203990; x=1721808790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vhx0BX0tfg4JtIj+DkkcP0J9kebOkzECCemo5fKt7Oc=;
        b=GD/zR25A1RB/JtunzgqlXswLKN43blpYkyDubuP1H4Jyxw3TxvjdXunFPSlUk6kbol
         z31eT0Gkj8KpXRhAqnpx9tQJ8ix4ir4g98U1xXCN/8XUsspOHGrf2umS8IztBH4uAS2c
         IyiYIyrVL5GFIdZpU/TzWPnoQk7anFtUXJkLnaj+MT1tSVDR4ycgSUjbxUESs1zo64K9
         XymIqCFLg/jaIgYRgvjMRLimi8R+cbAYe/f5CwKUKNAw4Ru7Z5B+Va0x2zufnFgozNkh
         bp6Skex/JkWJ/H+85D8WobHDfAsdlGKONK5lG2INOsBY5Qah5GrCrHpzIzHQ4OMh+2up
         jkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721203990; x=1721808790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhx0BX0tfg4JtIj+DkkcP0J9kebOkzECCemo5fKt7Oc=;
        b=XH9WVuAr4lLrD1WSH1GHXVtAKAKB5aswdWwiPXAF5zAEQVIZP+usR3SonqHPV5jq47
         BGWZiJSkFlQn9XwasYJErXc/q1M2LWvOyutoXEcPfNp62FkP7H/S67NwzXRvMRYA4fpy
         PEYWaKFN94bngWZSF+WJA6PnpKk6keaBd+rMpWhSs8L9i3zPMqKpozZT1q3z5zMPWprA
         /y2fPTaCeOPCz0nARjEiYIYQYXBdWBrQJ0mlXvqE5QaB0gHZOIdF2EpW0lEWe4bdVxtl
         /HhGF3qm4BCSu89UV9BFi8TF0yAUmpkE4in+bBohbqTzTdCO3/2pRvloV8/Y82Vqx+ye
         Lgqw==
X-Forwarded-Encrypted: i=1; AJvYcCXOqB8lsB/ADfP5lE7krNZ+gbDLW45VndXtfRc89wvycXSM7Faz/WHkIC0i7QIZMFhf86MITIaHZ2Va+HSCvkzN0q3Bwuyq2Y1S
X-Gm-Message-State: AOJu0YzE4nsOv2chefxTmoZyJVWG2jng/mFYezBgZSvw7hSV/+w0PcGP
	j8caKzl7CmtNbtaAiGuil82q9mNlBbGMmwO3QyS9+u2mJCG9gi5zRePjLqq0dg==
X-Google-Smtp-Source: AGHT+IHrylN07RNP4mwpeHSRVpV+GIlSCRY5wUAgEhJOzY2F72d4yL63pBqiLxefREZzW+YrMwKWFQ==
X-Received: by 2002:a05:6808:bc4:b0:3da:a0a5:a249 with SMTP id 5614622812f47-3dad1f47e3amr1070223b6e.23.1721203989990;
        Wed, 17 Jul 2024 01:13:09 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7e4bcsm7550365b3a.117.2024.07.17.01.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 01:13:09 -0700 (PDT)
Date: Wed, 17 Jul 2024 13:43:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_mrana@quicinc.com, quic_devipriy@quicinc.com
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
Message-ID: <20240717081303.GA2574@thinkpad>
References: <20240620213405.3120611-1-quic_pyarlaga@quicinc.com>
 <20240622035444.GA2922@thinkpad>
 <a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com>

On Fri, Jun 28, 2024 at 07:02:04PM -0700, Prudhvi Yarlagadda wrote:
> Hi Manivannan,
> 
> Thanks for the review comments.
> 
> On 6/21/2024 8:54 PM, Manivannan Sadhasivam wrote:
> > On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
> >> PARF hardware block which is a wrapper on top of DWC PCIe controller
> >> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
> >> register to get the size of the memory block to be mirrored and uses
> >> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
> >> address of DBI and ATU space inside the memory block that is being
> >> mirrored.
> >>
> > 
> > This PARF_SLV_ADDR_SPACE register is a mystery to me. I tried getting to the
> > bottom of it, but nobody could explain it to me clearly. Looks like you know
> > more about it...
> > 
> > From your description, it seems like this register specifies the size of the
> > mirroring region (ATU + DBI), but the response from your colleague indicates
> > something different [1].
> > 
> > [1] https://lore.kernel.org/linux-pci/f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com/
> > 
> 
> PARF_SLV_ADDR_SPACE_SIZE is used for mirroring the region containing ATU + DBI.
> But the issue being observed in the patch pointed above and the issue I am
> observing are a bit different even though the same fix could be used for both issues.
> 
> The issue I am observing is that the DBI and ATU region is getting mirrored into the
> BAR/MMIO region and thereby the DBI and ATU registers contents are getting modified
> while accessing the BAR region content.
> 
> As per my discussions internally with Devi Priya (author of the patch pointed above),
> the issue being seen there is that the DBI register contents are not available
> at the expected address by software and this is causing enumeration failures.
> 
> Below is the memory map of the IPQ9574 platform being mentioned in the above patch
> along with the memory locations of the DBI of respective PCIe Root Complexes.
> 
>                       |--------------------|
>                       |                    |
>                       |                    |
>                       |                    |
>                       |                    |
>                       |--------------------|
>                       |                    |
>                       |       PCIe2        |
>                       |                    |
>                       |--------------------|---->0x2000_0000 ->DBI
>                       |                    |
>                       |       PCIe3        |
>                       |                    |
>                       |--------------------|---->0x1800_0000 ->DBI
>                       |                    |
>                       |       PCIe1        |
>                       |                    |
>                       |--------------------|---->0x1000_0000 ->DBI
>                       |                    |
>                       |                    |
>                       |                    |
>                       |--------------------|
> 
> Previously PARF_SLV_ADDR_SPACE_SIZE is configured as 256MB (0x1000_0000) and
> PARF_DBI_BASE_ADDR is configured as 0x0 for each of the PCIe Root complex. With
> this configuration, in the case of PCIe1 DBI contents get accessible at 0x0,
> 0x1000_0000 and 0x2000_0000 and so on due to mirroring. Although NOC allows access
> only to region 0x1000_0000 to 0x1800_0000 for PCIe1. So in the case of PCIe1 DBI
> is accessible at the expected location 0x1000_0000.
> 
> Similarly in the case of PCIe3 its DBI contents are accessible at 0x0, 0x1000_0000
> and 0x2000_0000 but the expectation is to have DBI at 0x1800_0000 (as 0x1800_0000 is
> the physical address of DBI per devicetree). This is causing enumeration failures as
> DBI is not at the expected location (same issue w.r.t ATU).
> 
> When PARF_SLV_ADDR_SPACE_SIZE is modified to 128MB (0x800_0000) and PARF_DBI_BASE_ADDR
> is kept 0x0, for PCIe3 the DBI gets accessible at 0x0, 0x800_0000, 0x1000_0000,
> 0x1800_0000, 0x2000_0000 and so on. So, now the DBI becomes accessible at the
> expected location of 0x1800_0000 and its fixing the issue in the above patch.
> 

Thanks for the explanation. This really clarifies.

> Alternate way to fix the above issue is if we use the current patch to disable
> mirroring and configure the PARF_DBI_BASE_ADDR then the DBI gets accessible only at
> the location given in PARF_DBI_BASE_ADDR register which will be the same location
> mentioned in devicetree.
> 

Agree.

> >> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
> >> boundary is used for BAR region then there could be an overlap of DBI and
> >> ATU address space that is getting mirrored and the BAR region. This
> >> results in DBI and ATU address space contents getting updated when a PCIe
> >> function driver tries updating the BAR/MMIO memory region. Reference
> >> memory map of the PCIe memory region with DBI and ATU address space
> >> overlapping BAR region is as below.
> >>
> >> 			|---------------|
> >> 			|		|
> >> 			|		|
> >> 	-------	--------|---------------|
> >> 	   |	   |	|---------------|
> >> 	   |	   |	|	DBI	|
> >> 	   |	   |	|---------------|---->DBI_BASE_ADDR
> >> 	   |	   |	|		|
> >> 	   |	   |	|		|
> >> 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
> >> 	   |	BAR/MMIO|---------------|
> >> 	   |	Region	|	ATU	|
> >> 	   |	   |	|---------------|---->ATU_BASE_ADDR
> >> 	   |	   |	|		|
> >> 	PCIe	   |	|---------------|
> >> 	Memory	   |	|	DBI	|
> >> 	Region	   |	|---------------|---->DBI_BASE_ADDR
> >> 	   |	   |	|		|
> >> 	   |	--------|		|
> >> 	   |		|		|---->SLV_ADDR_SPACE_SIZE
> >> 	   |		|---------------|
> >> 	   |		|	ATU	|
> >> 	   |		|---------------|---->ATU_BASE_ADDR
> >> 	   |		|		|
> >> 	   |		|---------------|
> >> 	   |		|	DBI	|
> >> 	   |		|---------------|---->DBI_BASE_ADDR
> >> 	   |		|		|
> >> 	   |		|		|
> >> 	----------------|---------------|
> >> 			|		|
> >> 			|		|
> >> 			|		|
> >> 			|---------------|
> >>
> >> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is not
> >> used for BAR region which is why the above mentioned issue is not
> >> encountered. This issue is discovered as part of internal testing when we
> >> tried moving the BAR region beyond the SLV_ADDR_SPACE_SIZE boundary. Hence
> >> we are trying to fix this.
> >>
> > 
> > I don't quite understand this. PoR value of SLV_ADDR_SPACE_SIZE is 16MB and most
> > of the platforms have the size of whole PCIe region defined in DT as 512MB
> > (registers + I/O + MEM). So the range is already crossing the
> > SLV_ADDR_SPACE_SIZE boundary.
> > 
> > Ironically, the patch I pointed out above changes the value of this register as
> > 128MB, and the PCIe region size of that platform is also 128MB. The author of
> > that patch pointed out that if the SLV_ADDR_SPACE_SIZE is set to 256MB, then
> > they are seeing enumeration failures. If we go by your description of that
> > register, the SLV_ADDR_SPACE_SIZE of 256MB should be > PCIe region size of
> > 128MB. So they should not see any issues, right?
> > 
> 
> As mentioned above, configuring PARF_SLV_ADDR_SPACE_SIZE as 256MB is causing
> issue with the PCIe instances in which DBI is not aligned with the multiples of
> 256MB and due to PARF_DBI_BASE_ADDR being configured as 0x0 instead of the
> actual DBI address given in devicetree.
> 
> >> As PARF hardware block mirrors DBI and ATU register space after every
> >> PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary multiple, write
> >> U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to avoid mirroring DBI and
> >> ATU to BAR/MMIO region.
> > 
> > Looks like you are trying to avoid this mirroring on a whole. First of all, what
> > is the reasoning behind this mirroring?
> > 
> 
> The reason is to have more control over where to have the DBI and ATU register
> contents in the system memory using the PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR.
> For the PARF_SLV_ADDR_SPACE_SIZE register we don't have an existing use case
> to utilize mirroring functionality.
> 

Okay. Then I guess you could disable mirroring globally for all SoCs. Some SoCs
doesn't have both DBU and ATU regions, so the helper could conditionally write
the base address if available in DT.

> >> Write the physical base address of DBI and ATU
> >> register blocks to PARF_DBI_BASE_ADDR (default 0x0) and PARF_ATU_BASE_ADDR
> >> (default 0x1000) respectively to make sure DBI and ATU blocks are at
> >> expected memory locations.
> >>
> > 
> > Why is this needed? Some configs in this driver writes 0 to PARF_DBI_BASE_ADDR.
> > Does the hardware doesn't know where the registers are located?
> > 
> 
> Yes, hardware doesn't know where the DBI, ATU registers are located in the
> PARF_SLV_ADDR_SPACE_SIZE memory block or system memory. Hardware gets the location
> of DBI and ATU registers from the PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR
> registers. So these registers must be programmed to have the DBI and ATU at
> expected memory locations.
> 

Sounds good.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

