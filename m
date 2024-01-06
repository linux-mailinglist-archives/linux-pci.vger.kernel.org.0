Return-Path: <linux-pci+bounces-1724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD99825D8C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 02:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE631F232A1
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 01:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04401106;
	Sat,  6 Jan 2024 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DwKi5PTB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E710E3;
	Sat,  6 Jan 2024 01:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4060ZQ0H007481;
	Sat, 6 Jan 2024 01:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RPeLB2A5lpM4pmuGC+qyMezlYubWLHlX5CvjWhDmlfI=; b=Dw
	Ki5PTBJebOhduf1QeQfwuqSVUX32eEUUVyj2IaWQF799PK2/YOts2oXszfTlZNyN
	n3W17GOXRE8TJk0UCf5AYM6khCAjF0Z2iM4a++/xvl+Se32zu/QtZb0KF/l3Fb1u
	an9MtuXBup8q9vm74NfjHZee2t0vd14pYUBr1oDINOtfm1aQPK8EExJ5dFkahMi2
	f/8zfTnAiPvpGkSVC332qFquWwO5Z31ix0siQxDfYYLBf7XiW+s3Z/PVU9kLjPQa
	bF34z9I9rurJzm44UVI0z3e0U6oPSymxwlGXSc3dGXlt+AlxXCF/FXagQd7IDUVU
	Ni5rWAxKHPeK7Aof6tXA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve94rap5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 01:06:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40615x0a026831
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Jan 2024 01:05:59 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 17:05:57 -0800
Message-ID: <390499d5-6a55-4fd2-b0ad-7cd656309cbf@quicinc.com>
Date: Fri, 5 Jan 2024 17:05:55 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>,
        "David
 S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner
	<heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chris Morgan
	<macromorgan@hotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peng Fan <peng.fan@nxp.com>, Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Terry Bowman
	<terry.bowman@amd.com>,
        Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>,
        Huacai Chen <chenhuacai@kernel.org>, Alex
 Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
References: <20240104130123.37115-1-brgl@bgdev.pl>
 <20240104130123.37115-4-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240104130123.37115-4-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UF94WA6SpyZVSwQUMC-GghsZfCeqVLrd
X-Proofpoint-GUID: UF94WA6SpyZVSwQUMC-GghsZfCeqVLrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=952 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401060003

On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to introduce PCIe power-sequencing, we need to create platform
> devices for child nodes of the port driver node. They will get matched
> against the pwrseq drivers (if one exists) and then the actuak PCIe

nit if you re-spin: s/actuak /actual /

> device will reuse the node once it's detected on the bus.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/pci/pcie/portdrv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..401fb731009d 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -13,6 +13,7 @@
>  #include <linux/pci.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
> +#include <linux/of_platform.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/string.h>
> @@ -715,7 +716,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  		pm_runtime_allow(&dev->dev);
>  	}
>  
> -	return 0;
> +	return devm_of_platform_populate(&dev->dev);
>  }
>  
>  static void pcie_portdrv_remove(struct pci_dev *dev)


