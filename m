Return-Path: <linux-pci+bounces-11159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE89B945794
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804152827BD
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8560220B28;
	Fri,  2 Aug 2024 05:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn/K0hlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11C81C2BD
	for <linux-pci@vger.kernel.org>; Fri,  2 Aug 2024 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576137; cv=none; b=QVgRqJXMSCuZgCY+iDflIfBXYKgvoLP4CGG32HPDOLNTRmZDxN9oMliN3xeO6wePWosK+0w27cq/On/9gw6RcPxVNUKmw85SpaYg9SKhJiy64WVYxs0dfEmFMn24cC1uifhjK0VxMbX0Xu5UKCPYIZ8ZDUvnlYUxq79o4bgUngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576137; c=relaxed/simple;
	bh=wtlXhm/jl2MNCMjIzKQsVNAViYpU7vJub90vArhhHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijK/UZNhyrWrqmoToVvWBodRK8ZEpSYjAaAtICtvdh+5eK+rJwXJZKpG/4XZhVFC7Chf2hdyIp+o8aN3R8nVLEYokPhRnw8YDueCalEfWCaY27UdimrMuSU6lYzqy36gL40Bpakuy+LXyARbxdw/IkaTQgDmavn6DKYq5BXQJCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fn/K0hlY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cb5e0b020eso5921892a91.2
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722576135; x=1723180935; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwnrgE59fn2s0gNS2+2iuui0VL6EXW14nSMF+AEcczs=;
        b=fn/K0hlY0z9d/41TLzZAo3Tnn5wH9yGW065zfj4pCr2FPKWiDYOjPNHWTL15+pelih
         +Dq9z86foA0n9mNDxhzrKtFG9a2nlo8dx8r7tg4B1aEZE/EBvuM3mBv+KAMTwclNpy1X
         NeH9YmmNVJuXq5ZZEvXYvd7y1ieBQTb1IPjY2Z6slRyE8KabWhImi3dlFhpbh07mZPrE
         3BlxrqV6g/IqGtjm0y65WmUgxkssAKTw2iSbNnosGyjA6T8IF+F0dLLLXIAr7AcNmLnj
         lMwcZLGKwZtje5jggE+RGbD0HUJ7kfHPDHZg2FhXE2GZMHztIcHKR2CXYPDS3IcnyQ0A
         w9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722576135; x=1723180935;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwnrgE59fn2s0gNS2+2iuui0VL6EXW14nSMF+AEcczs=;
        b=PtggEU/HV2lRkJnPeeE88yE8oK5T8GvXFx1PJC7exnZNVGKbekAuoNwlQwIAZUeUE1
         VQrH51l+04c3EOmxS1WgXDy5TMep/NA94ALJvhemx6o4JnFy2rouCoymoVrbmVesgj+t
         WGwvRaF6JW7wqQbtgbDGvZeHTZwdTI9gOiTlPVZeD1jXxaX9m7G9YZVcDKPODZX+fjZ3
         xy7a1hIrutQc0hhxlA1oTIwYJdITxnFrn0KSTjrayaYjdf5ByLYKyfUnnpnk+/d7FuSQ
         PTUjO75jV4n4q8c+5eHPIY/QwnAsEFFaZpTex35S8wBbsF4z6YWI5BG/VTGgZZ6ACrbR
         g7zg==
X-Forwarded-Encrypted: i=1; AJvYcCUOcKO31l2cHYK9NuMOdzXVXRuwCQX0fGTRvFHd06VeGS9FvmA5QQCy0bku3DPJlAdz8QCTPLa2M8PIAEffe/SUwDul7YXne/Sp
X-Gm-Message-State: AOJu0Yzub67enAtx1C7kX7Jz0JsGW95NrmVPWjp7IEE2lH3EzBnJpK+2
	ZCX4858EG150Bl+yzS+Oeh+rB3EnUCAvQNSX+6X13vAFHB068Yv2Hni9AokaGQ==
X-Google-Smtp-Source: AGHT+IEgEr5N3+PXiQ+BoGlKgdS6rqZ3l0cctx4M5lLdFiCLJVHXOAORaubVDFnVgtb4wTJbWgnn/g==
X-Received: by 2002:a17:90b:33ca:b0:2ca:d1dc:47e2 with SMTP id 98e67ed59e1d1-2cff9559d93mr3100782a91.33.1722576135113;
        Thu, 01 Aug 2024 22:22:15 -0700 (PDT)
Received: from thinkpad ([120.60.54.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb390164sm846437a91.47.2024.08.01.22.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:22:14 -0700 (PDT)
Date: Fri, 2 Aug 2024 10:52:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
	Bjorn Helgaas <helgaas@kernel.org>, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <20240802052206.GA4206@thinkpad>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
 <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
 <6d926346-1c24-4aee-85b1-ffb5a0df904b@quicinc.com>
 <j62ox6yeemxng3swlnzkqpl4mos7zj4khui6rusrm7nqcpts6r@vmoddl4lchlt>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <j62ox6yeemxng3swlnzkqpl4mos7zj4khui6rusrm7nqcpts6r@vmoddl4lchlt>

On Fri, Aug 02, 2024 at 12:59:57AM +0300, Serge Semin wrote:
> On Thu, Aug 01, 2024 at 02:29:49PM -0700, Prudhvi Yarlagadda wrote:
> > Hi Serge,
> > 
> > Thanks for the review comment.
> > 
> > On 8/1/2024 12:25 PM, Serge Semin wrote:
> > > On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> > >> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> > >> driver to program the location of DBI and ATU blocks in Qualcomm
> > >> PCIe Controller specific PARF hardware block.
> > >>
> > >> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> > >> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> > >> ---
> > >>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
> > >>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> > >>  2 files changed, 4 insertions(+)
> > >>
> > >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > >> index 1b5aba1f0c92..bc3a5d6b0177 100644
> > >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> > >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > >> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > >>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
> > >>  		if (IS_ERR(pci->dbi_base))
> > >>  			return PTR_ERR(pci->dbi_base);
> > >> +		pci->dbi_phys_addr = res->start;
> > >>  	}
> > >>  
> > >>  	/* DBI2 is mainly useful for the endpoint controller */
> > >> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> > >>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
> > >>  			if (IS_ERR(pci->atu_base))
> > >>  				return PTR_ERR(pci->atu_base);
> > >> +			pci->atu_phys_addr = res->start;
> > >>  		} else {
> > >>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> > >>  		}
> > >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > >> index 53c4c8f399c8..efc72989330c 100644
> > >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> > >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > >> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
> > >>  struct dw_pcie {
> > >>  	struct device		*dev;
> > >>  	void __iomem		*dbi_base;
> > > 
> > >> +	phys_addr_t		dbi_phys_addr;
> > >>  	void __iomem		*dbi_base2;
> > >>  	void __iomem		*atu_base;
> > >> +	phys_addr_t		atu_phys_addr;
> > > 
> > > What's the point in adding these fields to the generic DW PCIe private
> > > data if they are going to be used in the Qcom glue driver only?
> > > 
> > > What about moving them to the qcom_pcie structure and initializing the
> > > fields in some place of the pcie-qcom.c driver?
> > > 
> > > -Serge(y)
> > > 
> > 
> 
> > These fields were in pcie-qcom.c driver in the v1 patch[1] and
> > Manivannan suggested to move these fields to 'struct dw_pcie' so that duplication
> > of resource fetching code 'platform_get_resource_byname()' can be avoided.
> > 
> > [1] https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/#mf9843386d57e9003de983e24e17de4d54314ff73
> 
> Em, polluting the core driver structure with data not being used by
> the core driver but by the glue-code doesn't seem like a better
> alternative to additional platform_get_resource_byname() call in the
> glue-driver. I would have got back v1 version so to keep the core
> driver simpler. Bjorn?
> 

IDK how adding two fields which is very related to DWC code *pollutes* it. Since
there is already 'dbi_base', adding 'dbi_phys_addr' made sense to me even though
only glue drivers are using it. Otherwise, glue drivers have to duplicate the
platform_get_resource_byname() code which I find annoying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

