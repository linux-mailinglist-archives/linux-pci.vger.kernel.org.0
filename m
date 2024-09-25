Return-Path: <linux-pci+bounces-13489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11B985301
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E17F1F249F4
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EF15532A;
	Wed, 25 Sep 2024 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XOtCx1jD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8F1487FF;
	Wed, 25 Sep 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246286; cv=none; b=mAJn46JQeRPlloSG7WA59fB1CFNpw3Tm/WzYqRJzpc3qlhSvz4NiSchLcVJFo9gn8N9U7SkFn8CvdRuvBjuDHvn93jkm290FoMNqlAM9TT2Vb+NfNJ2E4JRFaGbvnZHekKxtC5Bj8ZkuNYJLGWZknEumU/2WGUkObQOD0+ByzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246286; c=relaxed/simple;
	bh=5zYZGAHbR5ox8nsDoXowsKYTIt7yVorK3J8cavTV0P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JvkpQC+ZoB8zYgcNrwBk7QqbNcgDpSFwVJeUFCgFyyWs53+EotFNAawTpVDs9g3IOs2kSj+bW/SBShClsACQ5i39XNGCbEk95E+fK57evPTJlqAzrc4tBG3PM6AYlaiq41p5BCQf1NXyAEhqPlQN5crk076gB6wDLB439+Ch3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XOtCx1jD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OIDiDF014189;
	Wed, 25 Sep 2024 06:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dml4l8YTdpSXN3fvjDeknbMZkf62ADsnaczED9FK9e4=; b=XOtCx1jDy9mjdhL5
	N7gTxQK5JV8rZYG2h+vxmyXkej+KSosUkUE8jGEGyiAl4xX6tWFzyNKMZ2/ip2OD
	aFPlEQYyZW0+aCGNf85gSa4THD2Izp+p1e51j+LTjBqJEVwfePiqwsgWKFgrOBaY
	PuHBcEcGr8s1nhv+LgDZyz3762xjhKvdpdTACMRlrOg1/pZc1mVjtYspTW480oUf
	jxnvTNLoXZQvRtXBYE67NGeeRvMsA0Ok1GC6Et9FBH65qIHB9ImfxWbUhOMSBF5H
	jLWsiALDjPjWRNBAMS8KlA9+RYg6+0+AFZ9ZD43MSH6KSL7+hI79+OQI1lemn6BQ
	54NpaA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sn3sb09g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 06:37:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48P6bnef003840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 06:37:49 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Sep
 2024 23:37:43 -0700
Message-ID: <ee32742d-9daf-4bff-948b-cf2e705bc73f@quicinc.com>
Date: Wed, 25 Sep 2024 14:37:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Johan Hovold <johan@kernel.org>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <ZvLQFSjwR-TvHbm_@hovoldconsulting.com>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <ZvLQFSjwR-TvHbm_@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mpKWqdM3dO_f5WcpP9YB-8ZxXYKPRcS_
X-Proofpoint-ORIG-GUID: mpKWqdM3dO_f5WcpP9YB-8ZxXYKPRcS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=966 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250046


On 9/24/2024 10:43 PM, Johan Hovold wrote:
> On Tue, Sep 24, 2024 at 03:14:44AM -0700, Qiang Yu wrote:
>> Describe PCIe3 controller and PHY. Also add required system resources like
>> regulators, clocks, interrupts and registers configuration for PCIe3.
>> @@ -2907,6 +2907,208 @@ mmss_noc: interconnect@1780000 {
>>   			#interconnect-cells = <2>;
>>   		};
>>   
>> +		pcie3: pcie@1bd0000 {
>> +			device_type = "pci";
>> +			compatible = "qcom,pcie-x1e80100";
>> +			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0",
>> +					  "msi1",
>> +					  "msi2",
>> +					  "msi3",
>> +					  "msi4",
>> +					  "msi5",
>> +					  "msi6",
>> +					  "msi7",
>> +					  "global";
> This ninth "global" interrupt is not described by the bindings, which
> would also need to be updated. What is it used for?

As of now, the global interrupts is mainly used to get link up event so
that the device driver can enumerate the PCIe endpoint devices without
user intervention. You can refer to
https://lore.kernel.org/linux-pci/20240828-pci-qcom-hotplug-v4-11-263a385fbbcb@linaro.org.

I see this global interrupts has been documented in qcom,pcie-sm8450.yaml.
Do I need to move it to qcom,pcie-common.yaml?

Thanks,
Qiang
>
> Johan

