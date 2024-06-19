Return-Path: <linux-pci+bounces-8986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6990F099
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA00B2509D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F16F1E492;
	Wed, 19 Jun 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aazhs2cs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA21F934;
	Wed, 19 Jun 2024 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807496; cv=none; b=KAHrUKHpxvRJYRY1uEELCXdKrGyXLUXZ2YbT85ANbrFFJlo5BFg0hEnqTUeYSZ/2fxcmK1lJmDgmxANpUNpbRAlVIRVM/sO/eu425g0koMA2zxYBPiID/xxw3P139lCvQr9kT89GqD2FZE6w+A1HIaxps9fyGxs5j2z9G/JE6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807496; c=relaxed/simple;
	bh=K/s9nUtJuD0MesvSHYBvTTnfha4lS02lOilVao9hFVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=li+oyeydlkLktnBxcua7Jc/zLajrwn6ETmfGvTougCtJ3c2tHHm5MSCwIFfaK1D9nKB0cj7mDP0Zm3oA+p79RiVnPcWEKqgl0351I0UqAmO/dtbuKNLf6q4abayj8eKXVBhY9r22y+fByRiyuOPrUUt3dNb99RXF/Dhkf+POQss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aazhs2cs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J99VCp027906;
	Wed, 19 Jun 2024 14:31:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/3x0+fw4XMuD1kYUOrDfeygenAwP7QZLSyRF/0+KWhc=; b=aazhs2csLvMT521V
	XoI7W8Sv23MF5mj0sV4jujVFehrTHx9T2c7/S4kXWWHIKtr4tlHhZS8Xm9bs7eAj
	dRyyv+g7iA6BVJxS7a6ptRRm5v9TFseWL0WPDwHTyRY2NopXXNkZFoBhNzlokqSy
	uUChFNxDbmh25golhgKX2ptxG4xogdVWbs50j9prxetQ1nO2wfnMSjy/xmF8C8Rb
	6Ko9UrmtTHRHOoafROGltq15yEulT7a8gzIEAxE/KNxc02wfqvum3gO+WQI05OA5
	Hp1F/jUMjewUmVg4jDqPKVzocktUGHCwISh+9YNE4ZhxNLXO46wONx80tBSG/f+y
	Kl3biQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9yt0h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:31:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JEVHCj010629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 14:31:18 GMT
Received: from [10.216.5.74] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Jun
 2024 07:31:08 -0700
Message-ID: <650a391a-cb2b-7570-5e0b-adaf7f20151e@quicinc.com>
Date: Wed, 19 Jun 2024 20:01:04 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v14 4/4] PCI: qcom: Add OPP support to scale performance
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com>
 <20240609-opp_support-v14-4-801cff862b5a@quicinc.com>
 <04e7e509-9911-d5b2-619c-e7b87ed0ef50@linux.intel.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <04e7e509-9911-d5b2-619c-e7b87ed0ef50@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1NdQMcCbDRYx7VFeZ6ieW8tyR7oiFKno
X-Proofpoint-GUID: 1NdQMcCbDRYx7VFeZ6ieW8tyR7oiFKno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190109



On 6/14/2024 6:12 PM, Ilpo Järvinen wrote:
> On Sun, 9 Jun 2024, Krishna chaitanya chundru wrote:
> 
>> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
>> maintains hardware state of a regulator by performing max aggregation of
>> the requests made by all of the clients.
>>
>> PCIe controller can operate on different RPMh performance state of power
>> domain based on the speed of the link. And this performance state varies
>> from target to target, like some controllers support GEN3 in NOM (Nominal)
>> voltage corner, while some other supports GEN3 in low SVS (static voltage
>> scaling).
>>
>> The SoC can be more power efficient if we scale the performance state
>> based on the aggregate PCIe link bandwidth.
>>
>> Add Operating Performance Points (OPP) support to vote for RPMh state based
>> on the aggregate link bandwidth.
>>
>> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
>> framework if OPP entries are present.
>>
>> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
>> is supported.
>>
>> Before PCIe link is initialized vote for highest OPP in the OPP table,
>> so that we are voting for maximum voltage corner for the link to come up
>> in maximum supported speed.
>>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 93 +++++++++++++++++++++++++++-------
>>   1 file changed, 75 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index ff1d891c8b9a..296e2d5036f6 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/init.h>
>>   #include <linux/of.h>
>>   #include <linux/pci.h>
>> +#include <linux/pm_opp.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/pcie.h>
>> @@ -1404,15 +1405,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>   	return 0;
>>   }
>>   
>> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>>   {
>> +	int speed, width, ret, freq_mbps;
>>   	struct dw_pcie *pci = pcie->pci;
>> +	unsigned long freq_kbps;
>> +	struct dev_pm_opp *opp;
>>   	u32 offset, status;
>> -	int speed, width;
>> -	int ret;
>> -
>> -	if (!pcie->icc_mem)
>> -		return;
>>   
>>   	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>>   	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> @@ -1424,10 +1423,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>>   	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>>   	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>>   
>> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> -	if (ret) {
>> -		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>> -			ret);
>> +	if (pcie->icc_mem) {
>> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
>> +		if (ret) {
>> +			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>> +				ret);
>> +		}
>> +	} else {
>> +		freq_mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
>> +		if (freq_mbps < 0)
>> +			return;
>> +
>> +		freq_kbps = freq_mbps * 1000;
> 
> Use define from units.h instead of literal.
> 
>> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width, true);
>> +		if (!IS_ERR(opp)) {
>> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
>> +			if (ret)
>> +				dev_err(pci->dev, "Failed to set OPP for freq (%ld): %d\n",
>> +					freq_kbps * width, ret);
> 
> Make width unsigned and use %lu ?
> 
Ack to all comments. I will update them in next patch series.

- Krishna chaitanya

