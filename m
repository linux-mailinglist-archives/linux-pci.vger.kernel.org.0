Return-Path: <linux-pci+bounces-25230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62D4A7A0B5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 12:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9774A3B5780
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69624500A;
	Thu,  3 Apr 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JrpYDDl8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D61494D8;
	Thu,  3 Apr 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743675215; cv=none; b=qqQ4GjqCfZY8bi8mfd2Fw3DVJhgudK/br/sKFzNuopKL7CASWdzhUjh1GuQ4wziKcbCI9z38xAba5F9EFeQSgOIzjAk1F4+4ngtYKRrApURozHPd3CzJfsWI1gj5Jqun/JMNHXwtmREEodJfakVleY36un6ya/bykW3g+5WF4AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743675215; c=relaxed/simple;
	bh=01MeoMdgRxAVrAckVIAvBLc/gYcrfZ7ucXaVfCHHKug=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O62yehQUIMNOrRueKmPKvXlwDypEnT1JCuMah+j2dvvlh45gSitsz9/M3hMV104f9YXkna9uem9bndI8y4spyqnSInfLjWOEVh7d49NmbwpDm0oaMeB5uJ/45efZhqliYMVqgdlNEpyVGANI09ZxiAdglj8j31wcYDd/7KNV7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JrpYDDl8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5339rw6f021462;
	Thu, 3 Apr 2025 10:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+1tIqhAWCJvJ3CMT+y5CBlACyfbXSMkpcdM6/ucOvxU=; b=JrpYDDl8YNsCAZvc
	gtCR8T7s2hvDqcMg6HzHwahmSP/aQWu7BMthXYHZHW4Y9uVnlbLt0lKEj86vHEaE
	ieZApWzKyp36/eMKR2eMhtm1ojwsWT9JSSsgu2KQVNeLV8puf36Q2+vcwVqoMEvO
	OmD3LVvXtyV+zgzf8Sg9FZ8Xo2/87f4rnCmeMg39noD1MaTakSOJclGgmXflwbB6
	uJf9zlpg3+lk3tCkeNCDCrtGKrCRIGkulbLBTHTwOcGgiZOsx9dolrU6RT53nKPX
	W5FpRpKBxOGRCoUYZqivdTheIsKvJ64Z2BddVoXHTzZ2G9bW9NtL+IFhnI9II1ch
	YYONqg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45sbxy1qrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 10:13:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 533ADCIq003801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Apr 2025 10:13:12 GMT
Received: from [10.133.33.118] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 3 Apr 2025
 03:13:08 -0700
Message-ID: <94dac340-2f92-40a3-be56-ba8bd2298328@quicinc.com>
Date: Thu, 3 Apr 2025 18:13:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: Remove pcim_iounmap_regions()
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown
	<broonie@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Philipp Stanner
	<pstanner@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Yang Yingliang
	<yangyingliang@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Al Viro
	<viro@zeniv.linux.org.uk>,
        Li Zetao <lizetao1@huawei.com>, Anuj Gupta
	<anuj20.g@samsung.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20250327110707.20025-2-phasta@kernel.org>
 <20250327110707.20025-4-phasta@kernel.org>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <20250327110707.20025-4-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3W9z93NkZwxm7a7kjWSLINJPYXmxd6Gc
X-Proofpoint-ORIG-GUID: 3W9z93NkZwxm7a7kjWSLINJPYXmxd6Gc
X-Authority-Analysis: v=2.4 cv=PNAP+eqC c=1 sm=1 tr=0 ts=67ee5f39 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=COk6AnOGAAAA:8 a=YDoAUpYN6iqzQeISu80A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_04,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504030036

On 3/27/2025 7:07 PM, Philipp Stanner wrote:
> From: Philipp Stanner <pstanner@redhat.com>
> 
> All users of the deprecated function pcim_iounmap_regions() have been
> ported by now. Remove it.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  .../driver-api/driver-model/devres.rst        |  1 -
>  drivers/pci/devres.c                          | 24 -------------------
>  include/linux/pci.h                           |  1 -
>  3 files changed, 26 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index d75728eb05f8..601f1a74d34d 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -396,7 +396,6 @@ PCI
>    pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
>    pcim_iomap_table()		: array of mapped addresses indexed by BAR
>    pcim_iounmap()		: do iounmap() on a single BAR
> -  pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
>    pcim_pin_device()		: keep PCI device enabled after release
>    pcim_set_mwi()		: enable Memory-Write-Invalidate PCI transaction
>  
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3431a7df3e0d..c60441555758 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -946,30 +946,6 @@ int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
>  }
>  EXPORT_SYMBOL(pcim_request_all_regions);
>  
> -/**
> - * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
> - * @pdev: PCI device to map IO resources for
> - * @mask: Mask of BARs to unmap and release
> - *
> - * Unmap and release regions specified by @mask.
> - *
> - * This function is DEPRECATED. Do not use it in new code.
> - * Use pcim_iounmap_region() instead.
> - */
> -void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
> -{
> -	int i;
> -
> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> -		if (!mask_contains_bar(mask, i))
> -			continue;
> -
> -		pcim_iounmap_region(pdev, i);
> -		pcim_remove_bar_from_legacy_table(pdev, i);
> -	}
> -}
> -EXPORT_SYMBOL(pcim_iounmap_regions);
> -
>  /**
>   * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
>   * @pdev: PCI device to map IO resources for
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..7661f10913ca 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2323,7 +2323,6 @@ void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
>  void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
>  int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
>  int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
> -void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
>  void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
>  				unsigned long offset, unsigned long len);
>  

Reviewed-by: Zijun Hu <quic_zijuhu@quicinc.com>

