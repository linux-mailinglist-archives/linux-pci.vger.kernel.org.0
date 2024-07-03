Return-Path: <linux-pci+bounces-9704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BDC9256AD
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 11:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC13281F6D
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF2F13D524;
	Wed,  3 Jul 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oe2cRC9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12613B592;
	Wed,  3 Jul 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998729; cv=none; b=aVXjQuR1Phj3XnWFO63o/5xRJxOHeNPsiu4RoNKHsQHb8IbPsHaDsdo9d08Ln4rUxKoKxtjK+uqkCc+QhPXIZ2r7587v47HXIfC4Er8s7zEp4DSwtxeXFhsEugN8TWM7kq5mcBiDk2UvlbFQHpqnPc/1C3+jglkiXrfnv7JEoZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998729; c=relaxed/simple;
	bh=yHi/W05KtGps9FCz0/UywsRMv24OU50aXsjHAR4YmrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NRMX3UVYyq2QfTDEUOCYJLOhxePEXuFa78AJQt5083AxbiYauKPVu5QV6tPgTyir5qICCdxict4s7DEr2U5MT9rm96HHBR9L+CQ+ZJhtqcE7ijVRAjcSZ2G+8fOF4w8lRIGrZWhpLivd4CboMGMWerqUYb33KyEIYcXjtbniQl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oe2cRC9o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4635J5OC023311;
	Wed, 3 Jul 2024 09:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NhWuFqAPuEIZttAM2h+ngzLqj84AMotQeV7cBgLDekI=; b=Oe2cRC9oUcmZXNcW
	hM3w/0u5nLB0Cx5k+dKOSTo08Bic13lHg4TYTCcdLxKFEKRi/0rsrn94Fv9iOUEt
	QfGED7rITsH1a5n9umtbWCS2jiC/JnQQvm5LbiK0tAmrOx/oAMoX6xYDOINMy0yg
	axaSv6uQvKmFIprMlyD0JQq5RC5kaFDxGiI4W/f12i6EakqOh1K6N392FGzTuTwH
	IIdppbm37Qm6/0eUlRTEsjn8ZqW2SHKz7E6D7/IeAecYk7jfzVUcSonLFvi7IImV
	MJNvKIzVl3hvD9D674f9Be5xEGzMh1Uqp10dnBgethkZ9qm5oh7h6AygfaPmgXWE
	+9RWTg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4050cy8k8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jul 2024 09:23:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4639NV8c020645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jul 2024 09:23:31 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 02:23:10 -0700
Message-ID: <bc135b67-a2e4-4b17-96c0-767bcb94d876@quicinc.com>
Date: Wed, 3 Jul 2024 17:23:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/47] arm64: dts: qcom: qcs9100: Introduce QCS9100 SoC
 dtsi
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
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
        <quic_tdas@quicinc.com>, <robin.murphy@arm.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <quic_rjendra@quicinc.com>,
        <ulf.hansson@linaro.org>, <quic_sibis@quicinc.com>,
        <otto.pflueger@abscue.de>, <luca@z3ntu.xyz>,
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
        <linux-riscv@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <kernel@quicinc.com>
References: <20240703025850.2172008-1-quic_tengfan@quicinc.com>
 <20240703025850.2172008-3-quic_tengfan@quicinc.com>
 <8593db2e-8a69-418f-b00e-8fafe434dd30@kernel.org>
From: Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <8593db2e-8a69-418f-b00e-8fafe434dd30@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jA8I-qqzAQ-FOzamwuZ3_GO9PajOhc6b
X-Proofpoint-ORIG-GUID: jA8I-qqzAQ-FOzamwuZ3_GO9PajOhc6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=901 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407030069



On 7/3/2024 12:40 PM, Krzysztof Kozlowski wrote:
> On 03/07/2024 04:58, Tengfei Fan wrote:
>> Introduce QCS9100 SoC dtsi, QCS9100 is mainly used in IoT products.
>> QCS9100 is drived from SA8775p.
>> The current QCS9100 SoC dtsi is directly renamed from the SA8775p SoC
>> dtsi.
>> The QCS9100 platform is currently in the early design stage. Currently,
>> Both the QCS9100 platform and SA8775p platform use non-SCMI resources,
>> In the future, the SA8775p platform will transition to using SCMI
>> resources and it will have new sa8775p-related device tree.
>> This QCS9100 SoC dtsi remains consistent with the current SA8775p SoC
>> dtsi, except for updating the following sa8775p-related compatible names
>> to the qcs9100-related compatible name:
>>    - qcom,sa8775p-clk-virt
>>    - qcom,sa8775p-mc-virt
>>    - qcom,sa8775p-adsp-pas
>>    - qcom,sa8775p-cdsp-pas
>>    - qcom,sa8775p-cdsp1-pas
>>    - qcom,sa8775p-gpdsp0-pas
>>    - qcom,sa8775p-gpdsp1-pas
>>    - qcom,sa8775p-gcc
>>    - qcom,sa8775p-ipcc
>>    - qcom,sa8775p-config-noc
>>    - qcom,sa8775p-system-noc
>>    - qcom,sa8775p-aggre1-noc
>>    - qcom,sa8775p-aggre2-noc
>>    - qcom,sa8775p-pcie-anoc
>>    - qcom,sa8775p-gpdsp-anoc
>>    - qcom,sa8775p-mmss-noc
>>    - qcom,sa8775p-trng
>>    - qcom,sa8775p-ufshc
>>    - qcom,sa8775p-qmp-ufs-phy
>>    - qcom,sa8775p-qce
>>    - qcom,sa8775p-lpass-ag-noc
>>    - qcom,sa8775p-usb-hs-phy
>>    - qcom,sa8775p-dc-noc
>>    - qcom,sa8775p-gem-noc
>>    - qcom,sa8775p-dwc3
>>    - qcom,sa8775p-qmp-usb3-uni-phy
>>    - qcom,sa8775p-gpucc
>>    - qcom,sa8775p-smmu-500
>>    - qcom,sa8775p-dwmac-sgmii-phy
>>    - qcom,sa8775p-llcc-bwmon
>>    - qcom,sa8775p-cpu-bwmon
>>    - qcom,sa8775p-llcc
>>    - qcom,sa8775p-videocc
>>    - qcom,sa8775p-camcc
>>    - qcom,sa8775p-dispcc0
>>    - qcom,sa8775p-pdc
>>    - qcom,sa8775p-aoss-qmp
>>    - qcom,sa8775p-tlmm
>>    - qcom,sa8775p-imem
>>    - qcom,sa8775p-smmu-500
>>    - qcom,sa8775p-rpmh-clk
>>    - qcom,sa8775p-rpmhpd
>>    - qcom,sa8775p-cpufreq-epss
>>    - qcom,sa8775p-dispcc1
>>    - qcom,sa8775p-ethqos
>>    - qcom,sa8775p-nspa-noc
>>    - qcom,sa8775p-nspb-noc
>>    - qcom,sa8775p-qmp-gen4x2-pcie-phy
>>    - qcom,sa8775p-qmp-gen4x4-pcie-phy
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   .../dts/qcom/{sa8775p.dtsi => qcs9100.dtsi}   | 112 +++++++++---------
>>   1 file changed, 56 insertions(+), 56 deletions(-)
>>   rename arch/arm64/boot/dts/qcom/{sa8775p.dtsi => qcs9100.dtsi} (97%)
>>
> 
> How do any things compile at this point? Please squash the patches. Your
> patchset must be bisectable at build level (dtschema validation does not
> have to).
> 
> Best regards,
> Krzysztof
> 

The compilation issue indeed arises when applying only this single 
patch. In the new version patch series, I plan to consolidate the three 
patches that rename sa8775p.dtsi to qcs9100.dtsi, sa8775p-pmics.dtsi to 
qcs9100-pmics.dtsi, and sa87750-ride.dts to qcs9100-ride.dts into a 
single patch.

-- 
Thx and BRs,
Tengfei Fan

