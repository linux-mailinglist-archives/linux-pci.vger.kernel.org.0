Return-Path: <linux-pci+bounces-6909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322688B8197
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 22:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCA7283A6E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 20:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6D8129E72;
	Tue, 30 Apr 2024 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fMjuTVxq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94296179B2;
	Tue, 30 Apr 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509510; cv=none; b=lLDd1hycp4gtCQFM1oQWjRqkPsKns/FW4bPypbzTPCBtYurBkGkcUh2lNbF3h1tBG211Ho4O3lWpKksX12idT3B6phfSPw8obSvd5+oQgqNqVZ4+jKLqcKG3lhwx8ddBSw5CpibO+GAxlnJhwiqxHDUvgxHgi2XaUQAE4aEFEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509510; c=relaxed/simple;
	bh=Ni5zDZRBMky6sXd4A6eaIuT8CFCwjShfDzSbS3rGePE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jYc4cEIAiP5OEZiTWI+BLOlIPaRrHoS8UfMfizTcOzUvUDT1l+XzqxHsc/pGB7arKROE0TgPZdM+/ZRKs2M2ijQnqmIkrwrcZt8OuPvB8MWgLFwT5v9q05CdC6mY7uVkHFjlK4V4vkbt761cu6TysSAvjOlKiZrZ6BjWqrRogxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fMjuTVxq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UKMKjJ017327;
	Tue, 30 Apr 2024 20:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+F0XxWcRl3pzs5YJTlWUL7aO6XfqDBPOHAdM2dx9HOE=; b=fM
	juTVxqNEs5pkud81T74MoGcLdrd7I/9iwXMkkyO4MAbqbnhPNtqC9NzPQxsYnR05
	ABgFiZXmRzGXyn5dTxY9ZJduVf8hBGkLDAoxgUDCC4rI48F2+f6wddC9d1Ybz2gb
	c/FW0ZJtYgUFtDgUGLUdupMGwgsTz8LWfiS4vLup9eYpAz8hAjV5GlNwjp3OUfi3
	IZmuZb8J1b2AgV/Gtq6HqHHvs4oQUU7PpwZbLikPXuSbDm35sP5Za3ndh5DcAxBv
	/yRv6F5sor3iC1BSkHK1zutF8bNR9kbAm+RQFEqKxWttxDfN151bAigZGI78/Vle
	EaLn9OzfCYBJJzNcWDYA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtw1hhv6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 20:38:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UKcCLY022623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 20:38:12 GMT
Received: from [10.81.25.230] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 13:38:12 -0700
Message-ID: <53c0e508-60fe-ee5d-cb2b-a5392c330377@quicinc.com>
Date: Tue, 30 Apr 2024 13:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] PCI: qcom: Add rx margining settings for 16GT/s
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
 <20240419001013.28788-4-quic_schintav@quicinc.com>
 <02ae9e6b-b652-433e-b36d-e6106d4fbcd1@linaro.org>
Content-Language: en-US
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
In-Reply-To: <02ae9e6b-b652-433e-b36d-e6106d4fbcd1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zmq2KtCfN41vITuEkBNrx0fHL7WwCvqz
X-Proofpoint-ORIG-GUID: zmq2KtCfN41vITuEkBNrx0fHL7WwCvqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_12,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300148



On 4/22/24 15:58, Konrad Dybcio wrote:
> 
> 
> On 4/19/24 02:09, Shashank Babu Chinta Venkata wrote:
>> Add rx lane margining settings for 16GT/s(GEN 4) data rate. These
>> settings improve link stability while operating at high date rates
>> and helps to improve signal quality.
>>
>> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware.h  | 18 ++++++++++++++
>>   drivers/pci/controller/dwc/pcie-qcom-common.c | 24 +++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 +++-
>>   drivers/pci/controller/dwc/pcie-qcom.c        |  4 +++-
>>   5 files changed, 49 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index ad771bb52d29..e8c48855143f 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -203,6 +203,24 @@
>>     #define PCIE_PL_CHK_REG_ERR_ADDR            0xB28
>>   +/*
>> + * GEN4 lane margining register definitions
>> + */
>> +#define GEN4_LANE_MARGINING_1_OFF        0xb80
>> +#define MARGINING_MAX_VOLTAGE_OFFSET(n)        FIELD_PREP(GENMASK(29, 24), n)
>> +#define MARGINING_NUM_VOLTAGE_STEPS(n)        FIELD_PREP(GENMASK(22, 16), n)
>> +#define MARGINING_MAX_TIMING_OFFSET(n)        FIELD_PREP(GENMASK(13, 8), n)
>> +#define MARGINING_NUM_TIMING_STEPS(n)        FIELD_PREP(GENMASK(5, 0), n)
>> +
>> +#define GEN4_LANE_MARGINING_2_OFF        0xb84
>> +#define MARGINING_IND_ERROR_SAMPLER(n)        FIELD_PREP(BIT(28), n)
>> +#define MARGINING_SAMPLE_REPORTING_METHOD(n)    FIELD_PREP(BIT(27), n)
>> +#define MARGINING_IND_LEFT_RIGHT_TIMING(n)    FIELD_PREP(BIT(26), n)
>> +#define MARGINING_IND_UP_DOWN_VOLTAGE(n)    FIELD_PREP(BIT(25), n)
>> +#define MARGINING_VOLTAGE_SUPPORTED(n)        FIELD_PREP(BIT(24), n)
>> +#define MARGINING_MAXLANES(n)            FIELD_PREP(GENMASK(20, 16), n)
>> +#define MARGINING_SAMPLE_RATE_TIMING(n)        FIELD_PREP(GENMASK(13, 8), n)
>> +#define MARGINING_SAMPLE_RATE_VOLTAGE(n)    FIELD_PREP(GENMASK(5, 0), n)
> 
> That's a.. rather unusual.. use of FIELD_/GENMASK.. Usually, the fields are
> defined with GENMASK and then referenced through FIELD_xyz(BITFIELD_NAME, val)
> 
> That said, I'm not entirely against this if Mani is ok with it
will fall back to conventional approach in my next series to avoid confusion.
> 
>>   /*
>>    * iATU Unroll-specific register definitions
>>    * From 4.80 core version the address translation will be made by unroll
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> index a6f3eb4c3ee6..3279314ae78c 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-common.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
>> @@ -46,6 +46,30 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
>>   +void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
>> +{
>> +    u32 reg;
>> +
>> +    reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
>> +    reg = MARGINING_MAX_VOLTAGE_OFFSET(0x24) |
>> +        MARGINING_NUM_VOLTAGE_STEPS(0x78) |
>> +        MARGINING_MAX_TIMING_OFFSET(0x32) |
>> +        MARGINING_NUM_TIMING_STEPS(0x10);
>> +    dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
> 
> Since this is DW-common, why is this inside the qcom driver?
Though this register space is in dw-common specific, these settings are purely vendor specific . These settings are determined by systems team on vendor hardware, as these settings are used as margin to compensate signal variance due to various physical factors(like connection length, retimers etc).
> 
> Konrad

