Return-Path: <linux-pci+bounces-11509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BE194C50A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 21:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C474A1C218E9
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F9D146A9B;
	Thu,  8 Aug 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAYaY87c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BB1474BC;
	Thu,  8 Aug 2024 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143872; cv=none; b=V+93bUvX9RbJt70yfUVo3Wrce0K6xq6D0qULrXGbhjhsDKMWncWEvvcmCOWbeS7L0UmitsgMCDzx0+5UVPzxh4DafXMbDLLZdsESZvGLGCTR4fKR8CsxUmNpd+txpLE81C8tQxG6laSrF58H6uJGTPo+mvhhUW4nVMDGHkwOYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143872; c=relaxed/simple;
	bh=Df0DqA3BeFidtihY6E7YNpp0BlLbUYNUcr7YKd6GsUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VHM70o41hrKGRzozfE5c+sso1vlaqCYAmR8WaxaQ90pQCNEqWarf5srSQhPkSLEkLLId7a5Kt4vNdJ36YDJI4lfUCqVIgBPWNSi4D5LyFQTka7V7YU75H4VrXUA7RD/4LILRnJvDcFbckTC6ANhnmSVu1U3jKx9DDa/z/JoHJ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAYaY87c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1625EC32782;
	Thu,  8 Aug 2024 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723143871;
	bh=Df0DqA3BeFidtihY6E7YNpp0BlLbUYNUcr7YKd6GsUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SAYaY87cDAam5jm3mz4D5ZLYRjTg8swamWbTJIGyrC59jjVWfZ47SsonbrDL6aAGQ
	 zOJQhXIv4NQEoQakoZgDmo3aZp5Wm3KVIt02/i3vI6xPd+4vRFFhCm9rTNb6iZJ7S+
	 NChLgc4W+3TWFg7+Vah1ak0NSzReU4SH4AzM1Qmqm2+syAUiBDJ4jD8GzYZDcz9ivK
	 CA+L5WxYKwkGYgj3wPSYQBzb67DMDoanWrNYBrbXf1SWlwGphkbmVsBCnBZunwQ1f8
	 xJRt2VP2nX16PF+iPJHDkXoZ5EuLn+aAPd35qZUu1d+Wp86NasKhm3qgQLE+TJZu9e
	 qp50T2nYUM5Vg==
Date: Thu, 8 Aug 2024 14:04:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <20240808190429.GA154915@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f9a907-8010-4c13-970f-d216dd54b1f1@quicinc.com>

On Thu, Aug 08, 2024 at 11:30:52AM -0700, Prudhvi Yarlagadda wrote:
> On 8/2/2024 2:22 AM, Serge Semin wrote:
> > On Fri, Aug 02, 2024 at 10:52:06AM +0530, Manivannan Sadhasivam wrote:
> >> On Fri, Aug 02, 2024 at 12:59:57AM +0300, Serge Semin wrote:
> >>> On Thu, Aug 01, 2024 at 02:29:49PM -0700, Prudhvi Yarlagadda wrote:
> >>>> Hi Serge,
> >>>>
> >>>> Thanks for the review comment.
> >>>>
> >>>> On 8/1/2024 12:25 PM, Serge Semin wrote:
> >>>>> On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> >>>>>> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> >>>>>> driver to program the location of DBI and ATU blocks in Qualcomm
> >>>>>> PCIe Controller specific PARF hardware block.
> >>>>>>
> >>>>>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> >>>>>> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> >>>>>> ---
> >>>>>>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
> >>>>>>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> >>>>>>  2 files changed, 4 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>> index 1b5aba1f0c92..bc3a5d6b0177 100644
> >>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >>>>>> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> >>>>>>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
> >>>>>>  		if (IS_ERR(pci->dbi_base))
> >>>>>>  			return PTR_ERR(pci->dbi_base);
> >>>>>> +		pci->dbi_phys_addr = res->start;
> >>>>>>  	}
> >>>>>>  
> >>>>>>  	/* DBI2 is mainly useful for the endpoint controller */
> >>>>>> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> >>>>>>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
> >>>>>>  			if (IS_ERR(pci->atu_base))
> >>>>>>  				return PTR_ERR(pci->atu_base);
> >>>>>> +			pci->atu_phys_addr = res->start;
> >>>>>>  		} else {
> >>>>>>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> >>>>>>  		}
> >>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>> index 53c4c8f399c8..efc72989330c 100644
> >>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >>>>>> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
> >>>>>>  struct dw_pcie {
> >>>>>>  	struct device		*dev;
> >>>>>>  	void __iomem		*dbi_base;
> >>>>>
> >>>>>> +	phys_addr_t		dbi_phys_addr;
> >>>>>>  	void __iomem		*dbi_base2;
> >>>>>>  	void __iomem		*atu_base;
> >>>>>> +	phys_addr_t		atu_phys_addr;
> >>>>>
> >>>>> What's the point in adding these fields to the generic DW PCIe private
> >>>>> data if they are going to be used in the Qcom glue driver only?
> >>>>>
> >>>>> What about moving them to the qcom_pcie structure and initializing the
> >>>>> fields in some place of the pcie-qcom.c driver?
> >>>>>
> >>>>> -Serge(y)
> >>>>>
> >>>>
> >>>
> >>>> These fields were in pcie-qcom.c driver in the v1 patch[1] and
> >>>> Manivannan suggested to move these fields to 'struct dw_pcie' so that duplication
> >>>> of resource fetching code 'platform_get_resource_byname()' can be avoided.
> >>>>
> >>>> [1] https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/#mf9843386d57e9003de983e24e17de4d54314ff73
> >>>
> >>> Em, polluting the core driver structure with data not being used by
> >>> the core driver but by the glue-code doesn't seem like a better
> >>> alternative to additional platform_get_resource_byname() call in the
> >>> glue-driver. I would have got back v1 version so to keep the core
> >>> driver simpler. Bjorn?
> >>>
> >>
> >> IDK how adding two fields which is very related to DWC code *pollutes* it. Since
> >> there is already 'dbi_base', adding 'dbi_phys_addr' made sense to me even though
> >> only glue drivers are using it. Otherwise, glue drivers have to duplicate the
> >> platform_get_resource_byname() code which I find annoying.
> > 
> > I just explained why it was redundant:
> > 1. adding the fields expands the core private data size for _all_
> > platforms for no reason. (a few bytes but still)
> > 2. the new fields aren't utilized by the core driver, but still
> > defined in the core private data which is first confusing and
> > second implicitly encourages the kernel developers to add another
> > unused or even weakly-related fields in there.
> > 3. the new fields utilized in a single glue-driver and there is a small
> > chance they will be used in another ones. Another story would have
> > been if we had them used in more than one glue-driver...
> > 
> > So from that perspective I find adding these fields to the driver core
> > data less appropriate than duplicating the
> > platform_get_resource_byname() call in a _single_ glue driver. It
> > seems more reasonable to have them defined and utilized in the code
> > that actually needs them, but not in the place that doesn't annoy you.)
> > 
> > Anyway I read your v1 command and did understand your point in the
> > first place. That's why my question was addressed to Bjorn.
> > 
> > Please also note the resource::start field is of the resource_size_t
> > type. So wherever the fields are added, it's better to have them
> > defined of that type instead.
> 
> Gentle ping for your feedback on the above discussed two approaches.

I don't really care one way or the other.  Jingoo and Mani can sort it
out.

