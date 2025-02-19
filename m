Return-Path: <linux-pci+bounces-21794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEFAA3B2DC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 08:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84953AF54E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD21C5485;
	Wed, 19 Feb 2025 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHJBZIai"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383421C3C11
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951741; cv=none; b=RKXDMuo5HhNjNOYmTqBS242Kme1OE7i7G+eXbo1VWr1VBzsJgH8s+g3+m68PLXwIaUhHJoBa0JswVe9drweFv7T2ewiYDgwVvbg3z33YOa2bVzmQY0kwMYEOMYacNPACzxhqoKiHp5HX+Uoo17gyC8M8jdB0WJ1OkCgv95c3vUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951741; c=relaxed/simple;
	bh=ss6647Vq7Cy6U+GNIlcy6ezE7ATXTzSydGRry2X6VVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elsvX0oSd1yXviE+ZkYA97qf1YhMtnrvSxzYmQ5UWqao8MJAlX/qlsD3WOXomnvk9/XSBvvp0rE8hXg6V6Am9sLtSYlqVhF84r3+ViFVN/QeRxYg4I3PFR6ykkHEWORt2tV/+5DFTtie1QV2VTrpMG5HlIyUScioCzfpCOoL0oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHJBZIai; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-221050f3f00so75586125ad.2
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 23:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739951739; x=1740556539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KQ8YbWKKN0JUEDEyejcT43K2AZBg1IVNzkk5e0M7RQ0=;
        b=fHJBZIaiB+bzCM0QcuUFSBATA7NHiXJ+fGEharNp8aR62bTJmJ/Tz37czbMa/HpchK
         5UVI3B2zuwdLMWOz2CmrdWgRG/WrPSC1sx+9uLlibXj7NEwa3utt9X9+d7qpfUWXoDo5
         KMlpJVPX8KFIeBL5BIvLtdPqlPiqGU1aMnv7VHIExx2ggdCGaTyJGLfRyPxzwPRsMstL
         CtE4w4qv7H9Np+7UHhB86MbHKgBTujhgecBVx1SSIbMCzqbvDnWqKGxR3IvYhOn/hNVB
         y+8NRreta6VijmITbN09iIFZkXafyqNUsfaoqKnhiY8ixx2U3/VQC+uoRrmH0Pk9fhgQ
         zHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951739; x=1740556539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQ8YbWKKN0JUEDEyejcT43K2AZBg1IVNzkk5e0M7RQ0=;
        b=RVmod/cFBi7YPolsqvTfJSiyOuLdzYkzqlZLDI22lNoe4dJtmQnEcgyZLy9bDO7vJ1
         jH7/eNwBZbj5WK1rFH6AucVW9G4Bs0QzUxVEdPNL0aea01ypu/gTFNZ5f2q4aCMzy6N6
         WSPMBySMFiBMv5vxWRZ39FiY+EnaPT26iCiQUFFwbzEz4+eHOkbei9951oauDHpBq5rG
         Y7EjHlYSfakOOG+fP8Fx46es23+V5Gi2zhDkhS7IswOXrfIE3HJz6JWe9aKWsoJLMzMB
         h+eRdC483s22m//V93QDdFknvAUSAE4mSvqT2nYqEPvgENMD0psg+CV9JQxyFGGjTssE
         CvPw==
X-Forwarded-Encrypted: i=1; AJvYcCUjJPBdHTsEcUNWex0kDVP+s6nmmgcJSQ8KzEdZcjS+0Qu7uZtFxPVOBw6g0m/VwvpNupPY3nbZzsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywXKQqX5Wr9NeAv3e9oGPl95/EAU3AQo66cGlqv3qOYURb4mNr
	6KO4fyGpfTKsrlY7kz/cf0mylPtMqmIzvabZQ9sbLOjf5GRhKz+rTVZ39QY4pw==
X-Gm-Gg: ASbGncvjs7uFMp5sX/1lXN6ZIgpRy4W3b6myVhF5nzS+117l/jvpTP9VkzBMcgkgAPi
	QpFbC3gekbqIFMkYHWSblQMQ6MP5gkeKWGArpxAAzSdaKWsmi+iOOC9kcovOzLGLTS4hRaEUvh2
	9jGCx8w23DtV/WbMzZdCTFU/nPbnEErdUHGzCxPViL45XAiDGNSJgDwifCUXkOZQ9Cr7QvAVFPL
	Lsa31F8NlQp9JoWdhain8gNP+v5oC+hRY4SH4VYhnzPotKgf6+PVv5A5l5QsMS9T2z8/chM5tfC
	pNHghCmAz/4z+1naBle1KX8cmsA=
X-Google-Smtp-Source: AGHT+IG4njE0mVfhwsbo461mQskQTrTqKLJp04nKx1lPyB6/OYKMHkjA+8znL3Lf5HXh3/3N1AgKoQ==
X-Received: by 2002:a17:903:283:b0:215:ae3d:1dd7 with SMTP id d9443c01a7336-221040269bbmr278400085ad.19.1739951739441;
        Tue, 18 Feb 2025 23:55:39 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53491ecsm99383825ad.9.2025.02.18.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:55:39 -0800 (PST)
Date: Wed, 19 Feb 2025 13:25:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions to
 'pcie-dwc.h'
Message-ID: <20250219075533.dqj4rqeskilg76lj@thinkpad>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
 <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>
 <4nnikepf7ay4ml3audn34gmq5jttjcfz3syfnxeowmjb4no2cj@lyawl4saa3sa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4nnikepf7ay4ml3audn34gmq5jttjcfz3syfnxeowmjb4no2cj@lyawl4saa3sa>

On Tue, Feb 18, 2025 at 06:31:02PM +0200, Dmitry Baryshkov wrote:
> On Tue, Feb 18, 2025 at 08:06:40PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Since these are common to all Desginware PCIe IPs, move them to a new
> > header, 'pcie-dwc.h' so that other drivers could make use of them.
> 
> Which drivers are going to use it? Please provide an explanation.
> 

I can certainly add reference as 'upcoming pcie-designware-sysfs' driver.

> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS                 |  1 +
> >  drivers/perf/dwc_pcie_pmu.c | 23 ++---------------------
> >  include/linux/pcie-dwc.h    | 34 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 37 insertions(+), 21 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 896a307fa065..b4d09d52a750 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18123,6 +18123,7 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
> >  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> >  F:	drivers/pci/controller/dwc/*designware*
> > +F:	include/linux/pcie-dwc.h
> >  
> >  PCI DRIVER FOR TI DRA7XX/J721E
> >  M:	Vignesh Raghavendra <vigneshr@ti.com>
> > diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> > index cccecae9823f..05b37ea7cf16 100644
> > --- a/drivers/perf/dwc_pcie_pmu.c
> > +++ b/drivers/perf/dwc_pcie_pmu.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> > +#include <linux/pcie-dwc.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/pci.h>
> >  #include <linux/platform_device.h>
> > @@ -99,26 +100,6 @@ struct dwc_pcie_dev_info {
> >  	struct list_head dev_node;
> >  };
> >  
> > -struct dwc_pcie_pmu_vsec_id {
> > -	u16 vendor_id;
> > -	u16 vsec_id;
> > -	u8 vsec_rev;
> > -};
> > -
> > -/*
> > - * VSEC IDs are allocated by the vendor, so a given ID may mean different
> > - * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> > - */
> > -static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> > -	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> > -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> > -	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> > -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> > -	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> > -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> > -	{} /* terminator */
> > -};
> > -
> >  static ssize_t cpumask_show(struct device *dev,
> >  					 struct device_attribute *attr,
> >  					 char *buf)
> > @@ -529,7 +510,7 @@ static void dwc_pcie_unregister_pmu(void *data)
> >  
> >  static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
> >  {
> > -	const struct dwc_pcie_pmu_vsec_id *vid;
> > +	const struct dwc_pcie_vsec_id *vid;
> >  	u16 vsec;
> >  	u32 val;
> >  
> > diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> > new file mode 100644
> > index 000000000000..261ae11d75a4
> > --- /dev/null
> > +++ b/include/linux/pcie-dwc.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2021-2023 Alibaba Inc.
> > + *
> > + * Copyright 2025 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + */
> > +
> > +#ifndef LINUX_PCIE_DWC_H
> > +#define LINUX_PCIE_DWC_H
> > +
> > +#include <linux/pci_ids.h>
> > +
> > +struct dwc_pcie_vsec_id {
> > +	u16 vendor_id;
> > +	u16 vsec_id;
> > +	u8 vsec_rev;
> > +};
> > +
> > +/*
> > + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> > + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> > + */
> > +static const struct dwc_pcie_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> 
> Having it in the header means that there are going to be several
> copies of this data. Is that expected?
> 

Yes. I wanted to consolidate these ids in a single file to make it easy to track
them. Otherwise, these are spread across different subsystems, making it harder
to maintain.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

