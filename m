Return-Path: <linux-pci+bounces-4891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B287FC84
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 12:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2812A1F22DC6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1916D64CEF;
	Tue, 19 Mar 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dmInOBrl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC1864CE8;
	Tue, 19 Mar 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846454; cv=none; b=BN1NlCTeL7mYGnOL5vTeZ4Pz1lUlpTScM4130+TNMsILQ03Hd+ujqJsrZfen+t4S1qEWkV/AED2r2i6MCjrCTKAdXNspcRGAnrws65y3brqVJDbHwSRaqbdNBA5MOPFC3gHrEH4TDAiqMcJGzXkvuaSxNz+slTpR5J9esWO1QRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846454; c=relaxed/simple;
	bh=pWUlgTn6nHX3bdnZ9hOiOeopJLOgtZrnwrOe1BUeat4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZahHNIC1pXmHNQe7AgSvQnbpAOOVT3LxCKct39xhKkrhFPPOA0pETbtzwX/9K7otpcoJsTgv399yplolwt2/JdOi94w3fyZDxaTJq9TNTN7v6adZuH8FfQUROoOAJGrBUq6DSqb+4tS/SEXEgGOP1FjLBI2lSVk55sj84/8bneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dmInOBrl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J3JXQf016132;
	Tue, 19 Mar 2024 11:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s6prlzbdg7THi44K6pB0anmZEUrHlNA21RkUbYyl6f4=; b=dm
	InOBrlljudKxx9rKF5chn5g6OXVkZKW6syeItdrC1nQPWW3NDtuv0cyUr5M8ZuLB
	MNAKlvmaZjG3LQ263IO/RicYLnKI0WV8wpKiQuGYb6mropYkKf3DoDl+n95sdvcy
	l2HYs8OpwJezEAHcbi9fG+I10I4vWr1q1VAie9r9ooPLMgfDWvKgAcqkpx+d6tAx
	yY9XixjPMTQhD5P56VJ5WlwrvwvSInLoZ112ThMzMN+pZ9f2sMgp2CC/Cxsgyuyb
	51AE8uBvxA3WFzkt7e5gepOKyWRrqOHIsbRM3UdiY6BX8eO+qLfMUOjJ7O1HY5Uy
	40E/9NyeAYlSLcFka8bg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2e9gyb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 11:07:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JB7E9g011442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 11:07:14 GMT
Received: from [10.81.25.230] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 04:07:14 -0700
Message-ID: <6eafdda1-76e1-49af-ae4b-ffe7b26097ca@quicinc.com>
Date: Tue, 19 Mar 2024 04:07:13 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/3] PCI: dwc: add equalization settings for gen4
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org"
	<andersson@kernel.org>,
        "konrad.dybcio@linaro.org"
	<konrad.dybcio@linaro.org>,
        "mani@kernel.org" <mani@kernel.org>,
        "Mrinmay
 Sarkar (QUIC)" <quic_msarkar@quicinc.com>,
        "Aravind Ramakrishnaiah (QUIC)"
	<quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "Serge
 Semin" <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>
References: <20240301200041.GA405674@bhelgaas>
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
In-Reply-To: <20240301200041.GA405674@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CkVqNtX-GBpxlL74-lxp7Gfa2UQ6sN5W
X-Proofpoint-ORIG-GUID: CkVqNtX-GBpxlL74-lxp7Gfa2UQ6sN5W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190085


On 3/1/24 12:00, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 09:11:35PM -0800, Shashank Babu Chinta Venkata wrote:
>> GEN3_RELATED_OFFSET is being used as shadow register for generation4 and
>> generation5 data rates based on rate select mask settings on this register.
>> Select relevant mask and equalization settings for generation4 operation.
> 
> Please capitalize subject lines to match history ("PCI: qcom: Add ...")
> 
> s/GEN3_RELATED_OFFSET/GEN3_RELATED_OFF/ (I think?)
> 
> I wish these "GEN3_RELATED" things were named with the data rate
> instead of "GEN3".  The PCIe spec defines these things based on the
> data rate (8GT/s, 16GT/s, etc), not the revision of the spec they
> appeared in (gen3/gen4/etc).
I have kept it consistent with nomenclature followed in pcie designware
documentation for these registers. For function names and constraint to 
apply these, I will fall back to data rates rather than generation.

> Using "GEN3" means we have to first look up the "gen -> rate" mapping
> before finding the relevant spec info.
> 
> Applies to the subject line, commit log, #defines, function names,
> etc.
> 
>> +void qcom_pcie_cmn_set_gen4_eq_settings(struct dw_pcie *pci)
>> +{
>> +	u32 reg;
>> +
>> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> 
> Warrants a one-line comment about using "GEN3_..." in a function named
> "..._gen4_..."  (But ideally both would be renamed based on the data
> rate instead.)
> 
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.h
>> @@ -9,10 +9,29 @@
>>   #include "../../pci.h"
>>   #include "pcie-designware.h"
>>   
>> +#define GEN3_EQ_CONTROL_OFF			0x8a8
>> +#define GEN3_EQ_CONTROL_OFF_FB_MODE_MASK        GENMASK(3, 0)
>> +#define GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE   BIT(4)
>> +#define GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK	GENMASK(23, 8)
>> +#define GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL	BIT(24)
> 
> Are these qcom-specific registers, or should they be added alongside
> GEN3_RELATED_OFF in pcie-designware.h?
yes, these are designware register offsets. Will move them to designware 
header file. However, the settings are vendor specific.I will park
settings for these in QCOM specific files.
> 
>> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
>> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_VAL   0x5
>> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_VAL  0x5
>> +#define GEN3_EQ_FMDC_N_EVALS_VAL          0xD
>> +#define GEN3_EQ_FMDC_T_MIN_PHASE23_MASK         GENMASK(4, 0)
>> +#define GEN3_EQ_FMDC_N_EVALS_MASK               GENMASK(9, 5)
>> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK  GENMASK(13, 10)
>> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK	GENMASK(17, 14)
>> +#define GEN3_EQ_FMDC_N_EVALS_SHIFT			5
>> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
>> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14
> 
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -438,6 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>>   		goto err_disable_resources;
>>   	}
>>   
>> +	/* set Gen4 equalization settings */
> 
> Pointless comment.
> 
>> +	if (pci->link_gen == 4)
>> +		qcom_pcie_cmn_set_gen4_eq_settings(pci);
> 
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -263,6 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>>   {
>>   	struct qcom_pcie *pcie = to_qcom_pcie(pci);
>>   
>> +	/* set Gen4 equalization settings */
> 
> Pointless comment.
> 
>> +	if (pci->link_gen == 4)
>> +		qcom_pcie_cmn_set_gen4_eq_settings(pci);

