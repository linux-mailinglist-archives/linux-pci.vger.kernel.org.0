Return-Path: <linux-pci+bounces-1725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EA3825DA2
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 02:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CC41C23B2A
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371871374;
	Sat,  6 Jan 2024 01:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nCmdR2iP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067E10E6;
	Sat,  6 Jan 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4061A1J4016035;
	Sat, 6 Jan 2024 01:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sZ0M91xzoxHthsWUFUQNJs4RTh8cCxAMRlkqvgwdmDo=; b=nC
	mdR2iPLceqqxiQViLDCrSHRPAxJCufFSfkYwki/Cakg0JikmFeMNolnwGVzorrW7
	S/riKNdr+8TCZ1N05W2ORg8jORgzMDnVmYpoKbrw8I7TEqQMkqf3ppJeR/9ZWRo7
	xarpP/Kl+Ug118TnaZZzWuFfWrqVvHzxaLcbb0+vE5u8cL6KpYkHZiwEwvg76YmB
	ZEiYP4Nau2HFmGpZPLlhVQGwJwX4MKW5y2hCRV43TSky2kNfRexDJuIQ2/8vRRHK
	XbXoahvRDPNUjQ2PdgMIlGZdvQNw6s6+f3gExQ/cgKwrMi5WjA/mYTuepZFiFQnL
	xTNKIfYLuuHjLy5OgbGA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ve94rapxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 01:25:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4061P7j0012092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Jan 2024 01:25:07 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 17:25:05 -0800
Message-ID: <6c9f087d-ac1f-4601-91f0-d84fb77b3989@quicinc.com>
Date: Fri, 5 Jan 2024 17:25:04 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/9] PCI/pwrseq: add pwrseq core code
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
 <20240104130123.37115-6-brgl@bgdev.pl>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240104130123.37115-6-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _m5tdcl3MxwGGxAp0Gpf_2hIa6-ygr-_
X-Proofpoint-GUID: _m5tdcl3MxwGGxAp0Gpf_2hIa6-ygr-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=918 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401060005

On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
...
> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrseq/Kconfig
> new file mode 100644
> index 000000000000..010e31f432c9
> --- /dev/null
> +++ b/drivers/pci/pcie/pwrseq/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menuconfig PCIE_PWRSEQ
> +	bool "PCIe Power Sequencing support"
> +	depends on PCIEPORTBUS
> +	help
> +	  Say yes here to enable support for PCIe power sequencing
> +	  drivers.

Do we really need this configuration? I'm concerned about how do we let
the end user know when this needs to be enabled. Speaking specifically
about ath11k, almost all ath11k devices will not require this, but it
then becomes a support issue that if you are using QCA6390 then you need
to enable it.

I see that in [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
there is an option to enable config PCIE_PWRSEQ_QCA6390 if PCIE_PWRSEQ
is enabled, but you then have the menuconfig dilemma that you won't know
that you need to enable PCIE_PWRSEQ if you are using QCA6390.

Let me speak more to that in my review of that patch.

/jeff

