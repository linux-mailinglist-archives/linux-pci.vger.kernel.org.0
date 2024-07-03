Return-Path: <linux-pci+bounces-9719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB592586E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 12:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F35B263AA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 10:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C286158DB8;
	Wed,  3 Jul 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MPBGboiD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63C14430D;
	Wed,  3 Jul 2024 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002277; cv=none; b=M4JhlszjgQTMXkJORTSq6wzf2zjXd3CDp/kc8x9iyGgVTb2O1ktxuPYzkYOpRFZ1earhtccQl3kE6FtCe+ujQkpCZFJ01YVkgFsyLPWBg6ABV10PgSA8uVPl4xrxrbTO2V1n0SZa+KK8LdUZHdPqjQE3egu31YVxFDAl4eJ7I2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002277; c=relaxed/simple;
	bh=VlMke9/MAyPWh0km8onK0q3jYF77Mesj4vmu5K7fKAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KRQF7toUbIlVGhKba/G/V6duckny3hSBi7UHuHU8t7roR0MX3D4qbO3F6EzdAo9rnDlwI0eeBg77JTP1Zrc5RTCXUd452ClhGF7fyiPNHfcrZwZYzftEKwCByEzdjmQKURYVNuG+2OHcYfAaeqSCjAKoqZ6ZuOjvMF4FumromM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MPBGboiD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4634MZEL026763;
	Wed, 3 Jul 2024 10:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WJ4OnCz046UbEw8QxyCK0QrEWS4jubaPabe072kzd94=; b=MPBGboiDw+jAbje8
	y6LN10YkftB1qyXbDq26qKk2JNyro6pL4GWYFQI/bQ5Qy2c6nEjKu64WNazcJrkF
	JBm+GQB9jpLmaeQ1BCbsomrTBJRUQDSafJfwKlDoETUZ0h9CJpp+ujSwxjcvAYyr
	/txFWLk5oEhOeDakAEuYsT7z7K1sn+oXPPUTxyWYFwnwC59WxYFzRVEBOewtRHg/
	X3Lbz9LepgtMU3QBUFFCCZdvyCfmITPSinamwN52h4SI86SYU4l9xcW9j+ThQNGW
	K4jU8tI//niKqL7FG3GlC5Z+0T/kfOlVjDmfFVhaiUHVp1jFzcb7WMxtCb4Mekq6
	FqCI+A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yjhrspf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 10:22:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 463AMe3H007270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 10:22:40 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 03:22:19 -0700
Message-ID: <ac4830e3-2945-4021-9c2e-0819e26c8069@quicinc.com>
Date: Wed, 3 Jul 2024 18:22:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/47] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCS9100
 compatibles
To: Taniya Das <quic_tdas@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <djakov@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jassisinghbrar@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <manivannan.sadhasivam@linaro.org>, <will@kernel.org>,
        <joro@8bytes.org>, <conor@kernel.org>, <tglx@linutronix.de>,
        <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <linus.walleij@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <vkoul@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <mcoquelin.stm32@gmail.com>
CC: <robimarko@gmail.com>, <bartosz.golaszewski@linaro.org>,
        <kishon@kernel.org>, <quic_wcheng@quicinc.com>,
        <alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <bvanassche@acm.org>,
        <agross@kernel.org>, <gregkh@linuxfoundation.org>,
        <robin.murphy@arm.com>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>, <lukasz.luba@arm.com>,
        <quic_rjendra@quicinc.com>, <ulf.hansson@linaro.org>,
        <quic_sibis@quicinc.com>, <otto.pflueger@abscue.de>, <luca@z3ntu.xyz>,
        <neil.armstrong@linaro.org>, <abel.vesa@linaro.org>,
        <bhupesh.sharma@linaro.org>, <alexandre.torgue@foss.st.com>,
        <peppe.cavallaro@st.com>, <joabreu@synopsys.com>,
        <netdev@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <ahalaney@redhat.com>,
        <krzysztof.kozlowski@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <dmitry.baryshkov@linaro.org>, <quic_cang@quicinc.com>,
        <danila@jiaxyga.com>, <quic_nitirawa@quicinc.com>,
        <mantas@8devices.com>, <athierry@redhat.com>,
        <quic_kbajaj@quicinc.com>, <quic_bjorande@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_tsoni@quicinc.com>, <quic_rgottimu@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tingweiz@quicinc.com>, <quic_aiquny@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-crypto@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-gpio@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703035735.2182165-1-quic_tengfan@quicinc.com>
 <20240703035735.2182165-28-quic_tengfan@quicinc.com>
 <23303bc2-4fa2-4b28-af5d-2cadf6795b94@quicinc.com>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <23303bc2-4fa2-4b28-af5d-2cadf6795b94@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fmqj1c2QtSYfPoaxODgL9LrlxrCldNNV
X-Proofpoint-ORIG-GUID: fmqj1c2QtSYfPoaxODgL9LrlxrCldNNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=633 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407030076



On 7/3/2024 1:35 PM, Taniya Das wrote:
> 
> 
> On 7/3/2024 9:27 AM, Tengfei Fan wrote:
>> +              - qcom,qcs9100-cpufreq-epss
> 
> This is not required as we already have sa8775p bindings.

This is necessary. The reason is same as my reply in patch 41/47.

> 

-- 
Thx and BRs,
Tengfei Fan

