Return-Path: <linux-pci+bounces-1726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E752D825DB0
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 02:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5570DB22BF2
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEFF110B;
	Sat,  6 Jan 2024 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wh6I0uMr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D1137B;
	Sat,  6 Jan 2024 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40614CG8003495;
	Sat, 6 Jan 2024 01:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oWitCKqXUaDDi3zunueHiXdcn5X8/zJTddcKiUW5ozY=; b=Wh
	6I0uMrdc4AKX2usKrQjmzWWFCPtJuwPgMUxWyivmDfGGRVRGs1bd3MmQTUzah93S
	3s62ibT/RB+oNeMbtIvoBvJ0BHs8JUJ5kVJ511Q9DtM8hLiRzf5orMAayxZArPIv
	ltaa3OY2E3WiOOk6ftIb/Us/x1/lM25RvEAg7IIfIUG56OQmqWohlVnQuTP/0PdX
	lnkQwgTYcvVJbpWTf3OOvJiMI3O7B13dLeTEcfVx5bsTTpauLoqLGRL2iStX8HAp
	D8ozE6cMjmtR36Dh411vJvZyBfofQzasdztpBo4melJ9EHgjgUWJwgY4XcZ6vEvD
	VRGcKmNMaTPubKMGQLUQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve96wtn5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 01:31:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4061Vopm022965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Jan 2024 01:31:50 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 17:31:48 -0800
Message-ID: <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com>
Date: Fri, 5 Jan 2024 17:31:47 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
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
 <20240104130123.37115-9-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240104130123.37115-9-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x8eAyU-ARJVubGws4bgKS1PljaWgyNho
X-Proofpoint-ORIG-GUID: x8eAyU-ARJVubGws4bgKS1PljaWgyNho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=920 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401060006

On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrseq/Kconfig
> index 010e31f432c9..f9fe555b8506 100644
> --- a/drivers/pci/pcie/pwrseq/Kconfig
> +++ b/drivers/pci/pcie/pwrseq/Kconfig
> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
>  	help
>  	  Say yes here to enable support for PCIe power sequencing
>  	  drivers.
> +
> +if PCIE_PWRSEQ
> +
> +config PCIE_PWRSEQ_QCA6390
> +	tristate "PCIe Power Sequencing driver for QCA6390"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  Enable support for the PCIe power sequencing driver for the
> +	  ath11k module of the QCA6390 WLAN/BT chip.
> +
> +endif

As I mentioned in the 5/9 patch I'm concerned that the current
definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively hide
the fact that QCA6390 may need additional configuration since the menu
item will only show up if you have already enabled PCIE_PWRSEQ.
Yes I see that these are set in the defconfig in 9/9 but I'm concerned
about the more generic case.

I'm wondering if there should be a separate config QCA6390 within ath11k
which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390

/jeff


