Return-Path: <linux-pci+bounces-22771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98CA4CA54
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76623BA90E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839D214A80;
	Mon,  3 Mar 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHRGWsgJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E81C84A0;
	Mon,  3 Mar 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022387; cv=none; b=gfq//pgMTLqjvZbBsaw6zSTVh+a3T6g8itL5CPvmDjQnFVmGmDUEk7PwEpfQz703Wo4eVJj0RuRwj2aB4oKjZM4GIiGhpPCT9DbRb4ooEyQknl16upXwDXl0qA/5CHtkS8ldkuTQifJjSWUNxts0UWb4/zgzmHRU2APmr0IEgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022387; c=relaxed/simple;
	bh=pcJq6VhwCjfaynCr86urxIunhUrIjpzsnVvjguFK+6A=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWdWw+3j0zcUtRO8JnV8gwlA4B54/yNmRhqia1dIfRfUC5cGrjtkWHgnBuBMvL000IbWKbvRbvTFhlZPmu/ozCm7p+MDgOFGyVg7m2Lo8jvSL8leB+kKjx5NjQCRKkRFZ0pSSrn3gvPxgxl/DxmJJmQo4HHymi3KV45kG+PX0AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHRGWsgJ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso79089916d6.2;
        Mon, 03 Mar 2025 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741022385; x=1741627185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRLgSxdqlBvInXl2DZuy/8p0+JAmavEVWC8IUWE/7IY=;
        b=OHRGWsgJz6902CqePRbBJMqqUunL55qU+AQ4z2l1ZiS5UHizMvxtAJQ/79ScAb8J6x
         0OVs/3adYeQLgVWaPE9ZbAlBnBLKAqwxj06wxNyTXE3qP7kwMU3fpMeMKK8cVheFlARf
         lDdwwg3vee0d7QMIeI9zvHFoFDytMKrU4hMT874TbWUSbWwKQQJOj95RdjgCetlzfmCu
         j6kGXQTrWNdmhCbbVa1AuV8FyC5WZsm0YcbBiqAOEzlj7oEDH6Wqy/aiprXrFegJ4h1N
         LduJc7D5qGVdetbdgMh7wdrn0DXhIP2HPl4lztDbr+77VyAkrX8FEFK3u115KuEfTgLx
         uo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022385; x=1741627185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRLgSxdqlBvInXl2DZuy/8p0+JAmavEVWC8IUWE/7IY=;
        b=cZ2ROyngppwt09wVz8OTSGfe03mWZyxRtwjd9DNazmWgtSaRmmxKotGqT5rrCDj5lT
         MJ1ZqWJQ5Rxv0ast2MHf+7sDg8BXORGP0wVuN1mnvXvyVpcdfFTzXl1asPxAvbawuuN9
         4U9Gm3Y+bGFVMEfc7hcoaXQakoKvQm7KFUQQ0ZNuukbl3GKv0owcuR5ANtJMTfY1j9IZ
         cU9Y9SraMbrh3OiSTVGp3UcvwtN82MGQmQRBlw4qqBoDSKIrjXYohJOIw0vYEu4ktQke
         GTG7hNNGo1pYEYAwrZ7uyps1vGVvHLbbov5k8rs3Hh5FSzsYvqt2b02vG4fqPwVXtU2i
         VTGg==
X-Forwarded-Encrypted: i=1; AJvYcCW8yQ9g7ARwpZxhrje3R1slYPThwtWVshw4ErOw5RcOdiqAfmBrNn4D6HPxVG0o8Ar07RddtDMnVBghfv/gW68Oyw==@vger.kernel.org, AJvYcCWdRZKjwEvDmksQn4j1688iaSya3YJYF6JiMkzdwixOdONy3vBt8jZEEnyViOPvkXi6Edgp+gvZ1Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAKV9s2/dWjEtWkeDTmIM4EOrV/JBa+KO0HSG9iiqX1pyu/TCN
	2lkliEFGOKrcWN7jFAq0IYNoTovh0KyMTUuRUnHzqWUaz3+ZbTvL
X-Gm-Gg: ASbGnct1hcC520Nl5HnjnI1aDT5nT2nIA1kER1xaURBnhD+LngcBlaStifxF7bpy6aI
	0CAWuYJ3gxi+7XEGhQ0TGusaU7x40Z/hXOL1InzfJlY7gAP2GwrTysw5VhVtigvnmpN7E4DOmtq
	QJjh6aR+SFJlG2ulv7prLHFxH50T4yarnp637dgFliaMEyg2dQYX5mruxVmrlZUW8nEMl3WXp5n
	RRZlsbjWQybSJyvJii4EyH8CIvx24/lvXPR9UvZBb8wgzSzDsTMEAcbDafKpuer8P65/gTN22bD
	34yn56TLSKgKxS1LFh62JEtx5X9R9P7MU0dPiGOM
X-Google-Smtp-Source: AGHT+IG0zVy7lg60mYfgSImCsh74mBuzqU36VHUksDzxDuyNJ/s3ohxIrUrwvRq5twPzh4X1lLXSdA==
X-Received: by 2002:ad4:5ec9:0:b0:6d4:c6d:17fe with SMTP id 6a1803df08f44-6e8a0d066f7mr250591406d6.25.1741022384595;
        Mon, 03 Mar 2025 09:19:44 -0800 (PST)
Received: from debian ([2607:fb90:8e63:c2b3:5405:c8bf:c1d1:41d5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378da08f2sm617957485a.81.2025.03.03.09.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:19:44 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 3 Mar 2025 09:19:38 -0800
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 1/5] perf/dwc_pcie: Move common DWC struct definitions
 to 'pcie-dwc.h'
Message-ID: <Z8XkqnQir1CfilvM@debian>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132024epcas5p13d6e617805e4ef0c081227b08119871b@epcas5p1.samsung.com>
 <20250221131548.59616-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-2-shradha.t@samsung.com>

On Fri, Feb 21, 2025 at 06:45:44PM +0530, Shradha Todi wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Since these are common to all Desginware PCIe IPs, move them to a new
> header 'pcie-dwc.h', so that other drivers like debugfs, perf and sysfs
> could make use of them.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  MAINTAINERS                 |  1 +
>  drivers/perf/dwc_pcie_pmu.c | 25 +++----------------------
>  include/linux/pcie-dwc.h    | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/pcie-dwc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3864d473f52f..6474a2d83de4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18167,6 +18167,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
>  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>  F:	drivers/pci/controller/dwc/*designware*
> +F:	include/linux/pcie-dwc.h
>  
>  PCI DRIVER FOR TI DRA7XX/J721E
>  M:	Vignesh Raghavendra <vigneshr@ti.com>
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..da30f2c2d674 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -13,6 +13,7 @@
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> +#include <linux/pcie-dwc.h>
>  #include <linux/perf_event.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> @@ -99,26 +100,6 @@ struct dwc_pcie_dev_info {
>  	struct list_head dev_node;
>  };
>  
> -struct dwc_pcie_pmu_vsec_id {
> -	u16 vendor_id;
> -	u16 vsec_id;
> -	u8 vsec_rev;
> -};
> -
> -/*
> - * VSEC IDs are allocated by the vendor, so a given ID may mean different
> - * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> - */
> -static const struct dwc_pcie_pmu_vsec_id dwc_pcie_pmu_vsec_ids[] = {
> -	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> -	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> -	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> -	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> -	{} /* terminator */
> -};
> -
>  static ssize_t cpumask_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
> @@ -529,14 +510,14 @@ static void dwc_pcie_unregister_pmu(void *data)
>  
>  static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>  {
> -	const struct dwc_pcie_pmu_vsec_id *vid;
> +	const struct dwc_pcie_vsec_id *vid;
>  	u16 vsec;
>  	u32 val;
>  
>  	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>  		return 0;
>  
> -	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {
> +	for (vid = dwc_pcie_rasdes_vsec_ids; vid->vendor_id; vid++) {
>  		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
>  						vid->vsec_id);
>  		if (vsec) {
> diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
> new file mode 100644
> index 000000000000..40f3545731c8
> --- /dev/null
> +++ b/include/linux/pcie-dwc.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021-2023 Alibaba Inc.
> + *
> + * Copyright 2025 Linaro Ltd.
> + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> + */
> +
> +#ifndef LINUX_PCIE_DWC_H
> +#define LINUX_PCIE_DWC_H
> +
> +#include <linux/pci_ids.h>
> +
> +struct dwc_pcie_vsec_id {
> +	u16 vendor_id;
> +	u16 vsec_id;
> +	u8 vsec_rev;
> +};
> +
> +/*
> + * VSEC IDs are allocated by the vendor, so a given ID may mean different
> + * things to different vendors.  See PCIe r6.0, sec 7.9.5.2.
> + */
> +static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
> +	{ .vendor_id = PCI_VENDOR_ID_ALIBABA,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{ .vendor_id = PCI_VENDOR_ID_QCOM,
> +	  .vsec_id = 0x02, .vsec_rev = 0x4 },
> +	{} /* terminator */
> +};
> +
> +#endif /* LINUX_PCIE_DWC_H */
> -- 
> 2.17.1
> 

