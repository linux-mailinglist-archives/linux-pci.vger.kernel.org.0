Return-Path: <linux-pci+bounces-8550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D218902815
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026811F232A7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58114B952;
	Mon, 10 Jun 2024 17:54:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4E147C74;
	Mon, 10 Jun 2024 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042062; cv=none; b=PTo6GWOY1N4C3SILLeGAtlQZuaq/cCkLGmx8fBPRtNmTGUrQAgIJJccVBWHEj+gbUTlBaMxk3n+QcdZawscTjZTzfADm5B9KqDEA3dYgd96w7GC+Jp+Q/GX1tr56En3q4RvknJ4rhcaC7iSq7XJiJQgwAxOit6WynQEJ0UwyVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042062; c=relaxed/simple;
	bh=leKKf29U173teK1FhuP+pu+V4jq3YaQC555HqoGy8Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhlSxc0ePThzxBi61CJgPCjdIKESBfO4KQtbbIAwi9fe57LXgwm23WKgy7eaol5basMHNbZufZNxx1SNboF8Fd3BpyX5XO10hsgfQ4lnaOwfP9jWgn324+6OELOw8xfUKBksrlFkMMhcn5A/JFnc1Iu7pMpILxkrROia2NjmklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4248FC2BBFC;
	Mon, 10 Jun 2024 17:54:17 +0000 (UTC)
Date: Mon, 10 Jun 2024 23:24:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: qcom: Add support for IPQ9574
Message-ID: <20240610175412.GB7660@thinkpad>
References: <20240512082858.1806694-1-quic_devipriy@quicinc.com>
 <20240512082858.1806694-7-quic_devipriy@quicinc.com>
 <20240530144730.GG2770@thinkpad>
 <f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com>

On Mon, Jun 10, 2024 at 11:15:55AM +0530, Devi Priya wrote:
> 
> 
> On 5/30/2024 8:17 PM, Manivannan Sadhasivam wrote:
> > On Sun, May 12, 2024 at 01:58:58PM +0530, devi priya wrote:
> > > The IPQ9574 platform has 4 Gen3 PCIe controllers:
> > > two single-lane and two dual-lane based on SNPS core 5.70a
> > > 
> > > The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> > > Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> > > which reuses all the members of 'ops_2_9_0' except for the post_init
> > > as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> > > and 1_27_0.
> > > 
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> > > Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> > > Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> > > ---
> > >   Changes in V5:
> > > 	- Rebased on top of the below series which adds support for fetching
> > > 	  clocks from the device tree
> > > 	  https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/
> > > 
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++---
> > >   1 file changed, 32 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 3d2eeff9a876..af36a29c092e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -106,6 +106,7 @@
> > >   /* PARF_SLV_ADDR_SPACE_SIZE register value */
> > >   #define SLV_ADDR_SPACE_SZ			0x10000000
> > > +#define SLV_ADDR_SPACE_SZ_1_27_0		0x08000000
> > 
> > Can you please explain what this value corresponds to? Even though there is an
> > old value, I didn't get much info earlier on what it is.
> 
> The PARF_SLV_ADDR_SPACE_SIZE register indicates the range of RC accesses
> to the EP's memory space. Default PoR value is 16MB, which seems to be
> sufficient for IPQ9574 SoC.
> As per the memory map, the memory space corresponding to each PCIe region is
> 128Mb. As the older value corresponds to 256Mb we see PCIe enumeration
> failures.

What kind of failure? Is it because kernel is trying to allocate memory region >
128MB range?

> This register should either be updated to 128Mb(0x8000000) or left at the
> PoR value 16Mb (0x1000000).
> 

Ok, so this is essentially the same as the PCI MEM region defined in DT? In that
case, this value should be extracted from DT instead of being hardcoded.

But PCI MEM region range in DT is low on many platforms. Maybe that's due to all
PCIe instances sharing the 256MB range?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

