Return-Path: <linux-pci+bounces-11142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09454945450
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 00:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09E5286795
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B60814BFBF;
	Thu,  1 Aug 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKRprEAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F73814B956;
	Thu,  1 Aug 2024 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722549604; cv=none; b=AYhHPL6JzggD6JMnQdZ02qF4NAnyoaKS9DKfTiiJocq/JhhSi7rsPefMaRWq9sCtxOllWXf5jfdqG9T0YLgcEwbeuCY4vodWS6fkBTXqJZXADauua5YR1RvqHYUup0Jf5DwUST825rwPjuJj7sa1AerU1umerNV3S67aaq2wL4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722549604; c=relaxed/simple;
	bh=51LgvSDN4Q0xgB1nQGohT2M6YA+WmOi/ZJF+nHCgu9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8xtQ/SL9j1WrbBG91mdKwnQJLUdWs6uZ2+bke6UhWLjBjZ2qxNSb3Tp0HkbsEwAStm4wp1h9TzD/G4e7qt2f0Y5vGT96RXTxJmclW3PTbsczZQhKGbZEhxqvRKVAYhdqAM1/VlvYSOEA1i+6S9daMegF7fKE/97Rhzi/mhzd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKRprEAB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so8524728a12.1;
        Thu, 01 Aug 2024 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722549601; x=1723154401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEWWzKV7FilEILhztxlLpWzopz9rHwAsQE6OK+zS2H8=;
        b=kKRprEABZTQXo2b2xwbJbPM7IkQOB0cxMOTYE4P7w4r8Cdwmjgf8C6D2ugKWMMwWH1
         qksWiCULwkP8Zk/e7mvWsbM3oDEuZigG7m/Nia/bJyR1fszlpfxhIuXK8drqu10+SO8D
         IjJ62Bp4Xnt8luGOZ1IzGcROeETvWSzUQl70JMLVdNJQNoORpm3aX18DLLzFUZdqOGAh
         d+lud2SSOXgkJNNGKvuGNmUI/pu30SbKptyHPfWi5DwCOHWCi44Jmcfv0yqXBTpMSrD3
         Vf/viB3gRVrodYtD6oyfuPnASAPlY1KVCAl6MG2Y6dWGZIlp3uVzjtAcH+fdLinWaiv1
         HfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722549601; x=1723154401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEWWzKV7FilEILhztxlLpWzopz9rHwAsQE6OK+zS2H8=;
        b=aZK45+h9309i4boM4VoO1Wq2tOJtG/rQ15LdFDL1b0kaAkButlOEmNolj66Ns7z3rV
         Qt6b8mm0xOSWBsj3l1qKd8+PDvL2y8lGCP8obhgqyyI7lo5W3xcHHy3Pcr/+9+YaHtpO
         LJWXM/oQx3R4WYanHYDrfVW94kCeJmK+lOGcvexDGXyTFmx/cNIpdQ03wmCkomKotCRk
         PExVcoCdrvMpTYOXVbXJI8HyBrcHNn7VPNVhrgJKEVlDbRn190TnTR1xr2DPF6+n9MdT
         3+lzgQtabcvl7eP6BFECShjd4FslaaIc2L0unTj8xnnBw2eOvXm/FeKYI0/EZ62ujJuX
         wUTw==
X-Forwarded-Encrypted: i=1; AJvYcCWMhYK7sRgWdeI1/JBKEjOoOa2hLIddGBEBL1OjsuVK+32T2VOyxTiU1VlE+ycw6Ychmp8X5/BX9vCS@vger.kernel.org, AJvYcCWpieZ5Chkf7Ef1uldW+JfUobhkDBge+x6gPbD5ht//OP11oB9pMjQ8Rra+vajd+Sg/RsPlLiL2HtYSCv4X@vger.kernel.org, AJvYcCXKD3LArUAVRyb6RX2Uq2RPbJwE64Olhm6Y6wOJey6K5M79b2KRIObaCpNdYFKmAE9OQoiZSlIOd35bulvN@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQWyA9USzLV1ReqeT4aXTRNJRg1Xu7OPyQrWwKHBhMEP7wp79
	dHpbK/r9fIexoAgfLkRnqT/y1QEzd7xj+9SPcS1+CPtBIOVps9cm
X-Google-Smtp-Source: AGHT+IGQ77USyhjHrCLgIMYcXsO5YF2t3I7vQ9r7lkx3P38C4elQidfDjTQQpvKCQxgZ3LPQOLXsmg==
X-Received: by 2002:aa7:c406:0:b0:5a0:f0c4:aa7b with SMTP id 4fb4d7f45d1cf-5b7f5129461mr977426a12.27.1722549600395;
        Thu, 01 Aug 2024 15:00:00 -0700 (PDT)
Received: from mobilestation ([176.213.10.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b2b556sm256336a12.25.2024.08.01.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 14:59:59 -0700 (PDT)
Date: Fri, 2 Aug 2024 00:59:57 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, 
	Bjorn Helgaas <helgaas@kernel.org>
Cc: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to
 struct dw_pcie
Message-ID: <j62ox6yeemxng3swlnzkqpl4mos7zj4khui6rusrm7nqcpts6r@vmoddl4lchlt>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
 <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
 <vbq3ma3xanu4budrrt7iwk7bh7evgmlgckpohqksuamf3odbee@mvox7krdugg3>
 <6d926346-1c24-4aee-85b1-ffb5a0df904b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d926346-1c24-4aee-85b1-ffb5a0df904b@quicinc.com>

On Thu, Aug 01, 2024 at 02:29:49PM -0700, Prudhvi Yarlagadda wrote:
> Hi Serge,
> 
> Thanks for the review comment.
> 
> On 8/1/2024 12:25 PM, Serge Semin wrote:
> > On Tue, Jul 23, 2024 at 07:27:18PM -0700, Prudhvi Yarlagadda wrote:
> >> Both DBI and ATU physical base addresses are needed by pcie_qcom.c
> >> driver to program the location of DBI and ATU blocks in Qualcomm
> >> PCIe Controller specific PARF hardware block.
> >>
> >> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
> >> Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware.c | 2 ++
> >>  drivers/pci/controller/dwc/pcie-designware.h | 2 ++
> >>  2 files changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> >> index 1b5aba1f0c92..bc3a5d6b0177 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >> @@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> >>  		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
> >>  		if (IS_ERR(pci->dbi_base))
> >>  			return PTR_ERR(pci->dbi_base);
> >> +		pci->dbi_phys_addr = res->start;
> >>  	}
> >>  
> >>  	/* DBI2 is mainly useful for the endpoint controller */
> >> @@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
> >>  			pci->atu_base = devm_ioremap_resource(pci->dev, res);
> >>  			if (IS_ERR(pci->atu_base))
> >>  				return PTR_ERR(pci->atu_base);
> >> +			pci->atu_phys_addr = res->start;
> >>  		} else {
> >>  			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> >>  		}
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> >> index 53c4c8f399c8..efc72989330c 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.h
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> >> @@ -407,8 +407,10 @@ struct dw_pcie_ops {
> >>  struct dw_pcie {
> >>  	struct device		*dev;
> >>  	void __iomem		*dbi_base;
> > 
> >> +	phys_addr_t		dbi_phys_addr;
> >>  	void __iomem		*dbi_base2;
> >>  	void __iomem		*atu_base;
> >> +	phys_addr_t		atu_phys_addr;
> > 
> > What's the point in adding these fields to the generic DW PCIe private
> > data if they are going to be used in the Qcom glue driver only?
> > 
> > What about moving them to the qcom_pcie structure and initializing the
> > fields in some place of the pcie-qcom.c driver?
> > 
> > -Serge(y)
> > 
> 

> These fields were in pcie-qcom.c driver in the v1 patch[1] and
> Manivannan suggested to move these fields to 'struct dw_pcie' so that duplication
> of resource fetching code 'platform_get_resource_byname()' can be avoided.
> 
> [1] https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/#mf9843386d57e9003de983e24e17de4d54314ff73

Em, polluting the core driver structure with data not being used by
the core driver but by the glue-code doesn't seem like a better
alternative to additional platform_get_resource_byname() call in the
glue-driver. I would have got back v1 version so to keep the core
driver simpler. Bjorn?

-Serge(y)

> 
> Thanks,
> Prudhvi
> >>  	size_t			atu_size;
> >>  	u32			num_ib_windows;
> >>  	u32			num_ob_windows;
> >> -- 
> >> 2.25.1
> >>
> >>

