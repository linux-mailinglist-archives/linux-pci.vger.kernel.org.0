Return-Path: <linux-pci+bounces-11180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A3945ADA
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F681F239B4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790041DAC69;
	Fri,  2 Aug 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+Tgt2u7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F31DAC61;
	Fri,  2 Aug 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590569; cv=none; b=kwezrKROPws8MRjxL/vtvRodu0YuE0kPahULyY064TmaSv/XCHa9bu9/q7+ZbOuKbp6wWrR54V893Ald3Kr56/P8sKhs8pvLENH2K4PjpTvy68Vkrdwy/M1mE4L9nnCzw+abj+yOxdIjDMMRwRSzXMoLJjMMnWfZSHRMthY8kEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590569; c=relaxed/simple;
	bh=Cg/MKCTgd7hojhmxXQb7ju0BBua/MVvhWfRNKo9kc9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8Z/YxxW/dU1J3o3XlJvUlyOtMT/T4rrCBhaXd9jebMdm+oVnA/dC8Ne8Ok6xGYieyfdGrVUe4BTBx1mKW8X4wnjbWRhvxGEIsyD8vnb8j1mtLyecBsKG7cBt1pccHnIQV4k3BXLZ+OseeX+DC/r0/36QNfjYWlUYefEoX28JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+Tgt2u7; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f042c15e3so2729831e87.0;
        Fri, 02 Aug 2024 02:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722590566; x=1723195366; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ye5tA42uMBNtvT73KdG8A94PBs19ktzkMoJkqT5xskw=;
        b=G+Tgt2u724xXWxeV+8GWWw7KJByFn9b90RX4Sm0p2n3Hn1gVOGrDrOkf4zzOTMMjEd
         hl0MM8GSvSIvKn4D5gQ96ra6B2Wn0SXQi5Bsq9JFJDPekx7UupdoTS461QDeZabDsTx6
         dp2mXEG2GbWP68w9H4yG7Nd9mzCPObtWGolCgSi6PrXm/1ItZ01J68R5IzqvBVq7vGla
         DpoHeFylkBOsBOryEExW4Y9GmrqFbCNtSsm5GSqwzB/BHXIcgm07wB9fOQvwfRKbPGLl
         Lf5R4dQtS9usJ3x0IW2pXpbeAGsDwQ0b2Pg7G6PObGk06/DVB1He517ZNjwtoCWPJbW+
         ZL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722590566; x=1723195366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ye5tA42uMBNtvT73KdG8A94PBs19ktzkMoJkqT5xskw=;
        b=IL7kFH7bLcUL8rwUIxNaioW+U4RNb0mji1uW8vo+qx7wgJNfk/u8qK/XaazKPUzHQC
         2jbw+YlYoLxVQQHCeZ6R4MpuxH4fuataERiIXL1eh4WamTf+et1LaOfnRCWAAD9xhGAa
         nqRiYF8CtmJP7+sSGAfSLiaRuppG5jRf+KAe1iqI+AP/14RMV7puiJ3ICwvSgdyHMPD4
         nKuXFt3+XJotHNBKyyxtLfTt7kl5ApmBWwOaFhi8WFEHNYWy7trYkH3O3gHZvq7orUOE
         yv+vwyORROTXxQUwEdbbdyeYVAqGZB8VjWS61plADNg/kZfxUdxH7G7HifmekdsbL2AH
         GohA==
X-Forwarded-Encrypted: i=1; AJvYcCUExlCjb4buIFr1G0edXmO8Rg+/ZW27Y2apvZbP+MoAWnOd/MCjNCtkdhy4LG/JalHOBwq46tFelp0brkQwtmSwazNDYEwyu0aiyPefNHEM6xGa7mZRu2QXUF+GJjJhjfe1PZPi5EZazFgYtnZHqh210J6FvsKPqQFYFOWDUgaWmc6xepfY2Q==
X-Gm-Message-State: AOJu0YwLOTkeqNpgOGzih1vlkYQyiyVxMJyA/4YdOj2ypgS+loG4DsiV
	mLqcYyIobW4X+z0EU02bQapEcEyrPJHDF0zURh2y5zauynJjEGAI
X-Google-Smtp-Source: AGHT+IHHynU+MvKkk5v8go0Stm9aPxO3OHJ73yl2a7M0njc/TuGYR9a+LcLadnndQkGuDNy47AS//Q==
X-Received: by 2002:a05:6512:2206:b0:52f:c16d:5c6a with SMTP id 2adb3069b0e04-530b8d17b54mr1271536e87.16.1722590565143;
        Fri, 02 Aug 2024 02:22:45 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba29dafsm175361e87.171.2024.08.02.02.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 02:22:44 -0700 (PDT)
Date: Fri, 2 Aug 2024 12:22:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <rw45lgwf5btlsr64okzk2e4rpd62fdyrou7u2c6lndozxjhdpq@qm5qx4dvw5ci>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
 <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
 <6d926346-1c24-4aee-85b1-ffb5a0df904b@quicinc.com>
 <j62ox6yeemxng3swlnzkqpl4mos7zj4khui6rusrm7nqcpts6r@vmoddl4lchlt>
 <20240802052206.GA4206@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802052206.GA4206@thinkpad>

On Fri, Aug 02, 2024 at 10:52:06AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 02, 2024 at 12:59:57AM +0300, Serge Semin wrote:
> > On Thu, Aug 01, 2024 at 02:29:49PM -0700, Prudhvi Yarlagadda wrote:
> > > Hi Serge,
> > > 
> > > Thanks for the review comment.
> > > 
> > > On 8/1/2024 12:25 PM, Serge Semin wrote:
> > > > On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> > > >> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> > > >> driver to program the location of DBI and ATU blocks in Qualcomm
> > > >> PCIe Controller specific PARF hardware block.
> > > >>
> > > >> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > > >> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> > > >> ---
> > > >>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
> > > >>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> > > >>  2 files changed, 4 insertions(+)
> > > >>
> > > >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > >> index 1b5aba1f0c92..bc3a5d6b0177 100644
> > > >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > >> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > > >>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
> > > >>  		if (IS_ERR(pci->dbi_base))
> > > >>  			return PTR_ERR(pci->dbi_base);
> > > >> +		pci->dbi_phys_addr = res->start;
> > > >>  	}
> > > >>  
> > > >>  	/* DBI2 is mainly useful for the endpoint controller */
> > > >> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > > >>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
> > > >>  			if (IS_ERR(pci->atu_base))
> > > >>  				return PTR_ERR(pci->atu_base);
> > > >> +			pci->atu_phys_addr = res->start;
> > > >>  		} else {
> > > >>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> > > >>  		}
> > > >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > > >> index 53c4c8f399c8..efc72989330c 100644
> > > >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > >> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
> > > >>  struct dw_pcie {
> > > >>  	struct device		*dev;
> > > >>  	void __iomem		*dbi_base;
> > > > 
> > > >> +	phys_addr_t		dbi_phys_addr;
> > > >>  	void __iomem		*dbi_base2;
> > > >>  	void __iomem		*atu_base;
> > > >> +	phys_addr_t		atu_phys_addr;
> > > > 
> > > > What's the point in adding these fields to the generic DW PCIe private
> > > > data if they are going to be used in the Qcom glue driver only?
> > > > 
> > > > What about moving them to the qcom_pcie structure and initializing the
> > > > fields in some place of the pcie-qcom.c driver?
> > > > 
> > > > -Serge(y)
> > > > 
> > > 
> > 
> > > These fields were in pcie-qcom.c driver in the v1 patch[1] and
> > > Manivannan suggested to move these fields to 'struct dw_pcie' so that duplication
> > > of resource fetching code 'platform_get_resource_byname()' can be avoided.
> > > 
> > > [1] https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/#mf9843386d57e9003de983e24e17de4d54314ff73
> > 
> > Em, polluting the core driver structure with data not being used by
> > the core driver but by the glue-code doesn't seem like a better
> > alternative to additional platform_get_resource_byname() call in the
> > glue-driver. I would have got back v1 version so to keep the core
> > driver simpler. Bjorn?
> > 
> 
> IDK how adding two fields which is very related to DWC code *pollutes* it. Since
> there is already 'dbi_base', adding 'dbi_phys_addr' made sense to me even though
> only glue drivers are using it. Otherwise, glue drivers have to duplicate the
> platform_get_resource_byname() code which I find annoying.

I just explained why it was redundant:
1. adding the fields expands the core private data size for _all_
platforms for no reason. (a few bytes but still)
2. the new fields aren't utilized by the core driver, but still
defined in the core private data which is first confusing and
second implicitly encourages the kernel developers to add another
unused or even weakly-related fields in there.
3. the new fields utilized in a single glue-driver and there is a small
chance they will be used in another ones. Another story would have
been if we had them used in more than one glue-driver...

So from that perspective I find adding these fields to the driver core
data less appropriate than duplicating the
platform_get_resource_byname() call in a _single_ glue driver. It
seems more reasonable to have them defined and utilized in the code
that actually needs them, but not in the place that doesn't annoy you.)

Anyway I read your v1 command and did understand your point in the
first place. That's why my question was addressed to Bjorn.

Please also note the resource::start field is of the resource_size_t
type. So wherever the fields are added, it's better to have them
defined of that type instead.

-Serge(y)

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

