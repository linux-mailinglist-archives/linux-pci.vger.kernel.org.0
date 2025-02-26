Return-Path: <linux-pci+bounces-22397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C03A45275
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F130A3A3A41
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FAE17B506;
	Wed, 26 Feb 2025 01:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dw8z0bBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72902EBE;
	Wed, 26 Feb 2025 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534952; cv=none; b=t1oW0UR1SShhWvJolEpFa1iNEXT+qmPIYV82zb5u/gGwJlOzwJUdN4kqES6a3s2MJNLwkWbTDUuGLTu0HZVl9rsvPujHM9Vyw35VUV64sfzGrWPduA1+rykDzCqbSjhcy+UkNeT9RhuXPQls+hUjau0djqbii4beMkW3FBP/hZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534952; c=relaxed/simple;
	bh=hpo8SdVEcKI6pEDAOsFUUwXI4aD7oAd5zuM5+KJpZsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRmB3bMSLF4399HT+gARNNwEGDyy610MaG8TI1gAm7ijMuUY9RbnB2uMqcPD6MoOR/XwRFSN4/Nxp8OWdLz2BiUJUi6SCGgjoHqPspqIkSZ17M0tqxedrPdTvF1XpMbWQXXCBqyUIqcBSxxtYACNPRAVT8SMD54wTma398NIjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dw8z0bBs; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740534940; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SYGXr6ObxBCz/rMlq9BwzU4N8B+1nvlSFrvEr4NdUT8=;
	b=dw8z0bBsxUhOZMmHzHYtDeeO/j2jLAMVUXVXhxEjqNYE9YRkzPf7d/qty8zCitUGUcshbJP+GFz8MBXx/ubsquf0fOvy6RzrI22HBHtScSSadwJPAQ8ihtye8xrdLXDhb0VlsqEM8ZWL9jEi0lEAssEMFcg70ak6tyCJ8+5iPFo=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQGACDe_1740534937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Feb 2025 09:55:38 +0800
Message-ID: <855b4178-cbd5-4d95-a2eb-32c5ee0e5894@linux.alibaba.com>
Date: Wed, 26 Feb 2025 09:55:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] perf/dwc_pcie: Move common DWC struct definitions
 to 'pcie-dwc.h'
To: Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
Cc: manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 Jonathan.Cameron@Huawei.com, fan.ni@samsung.com, nifan.cxl@gmail.com,
 a.manzanares@samsung.com, pankaj.dubey@samsung.com, cassel@kernel.org,
 18255117159@163.com, renyu.zj@linux.alibaba.com, will@kernel.org,
 mark.rutland@arm.com
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132024epcas5p13d6e617805e4ef0c081227b08119871b@epcas5p1.samsung.com>
 <20250221131548.59616-2-shradha.t@samsung.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250221131548.59616-2-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/21 21:15, Shradha Todi 写道:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Since these are common to all Desginware PCIe IPs, move them to a new
> header 'pcie-dwc.h', so that other drivers like debugfs, perf and sysfs
> could make use of them.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>   MAINTAINERS                 |  1 +
>   drivers/perf/dwc_pcie_pmu.c | 25 +++----------------------
>   include/linux/pcie-dwc.h    | 34 ++++++++++++++++++++++++++++++++++
>   3 files changed, 38 insertions(+), 22 deletions(-)
>   create mode 100644 include/linux/pcie-dwc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3864d473f52f..6474a2d83de4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18167,6 +18167,7 @@ S:	Maintained
>   F:	Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml
>   F:	Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
>   F:	drivers/pci/controller/dwc/*designware*
> +F:	include/linux/pcie-dwc.h
>   
>   PCI DRIVER FOR TI DRA7XX/J721E
>   M:	Vignesh Raghavendra <vigneshr@ti.com>
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index cccecae9823f..da30f2c2d674 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -13,6 +13,7 @@
>   #include <linux/errno.h>
>   #include <linux/kernel.h>
>   #include <linux/list.h>
> +#include <linux/pcie-dwc.h>
>   #include <linux/perf_event.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
> @@ -99,26 +100,6 @@ struct dwc_pcie_dev_info {
>   	struct list_head dev_node;
>   };
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
>   static ssize_t cpumask_show(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
> @@ -529,14 +510,14 @@ static void dwc_pcie_unregister_pmu(void *data)
>   
>   static u16 dwc_pcie_des_cap(struct pci_dev *pdev)
>   {
> -	const struct dwc_pcie_pmu_vsec_id *vid;
> +	const struct dwc_pcie_vsec_id *vid;
>   	u16 vsec;
>   	u32 val;
>   
>   	if (!pci_is_pcie(pdev) || !(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>   		return 0;
>   
> -	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {
> +	for (vid = dwc_pcie_rasdes_vsec_ids; vid->vendor_id; vid++) {
>   		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
>   						vid->vsec_id);
>   		if (vsec) {
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

LGTM. Thanks.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Shuai

