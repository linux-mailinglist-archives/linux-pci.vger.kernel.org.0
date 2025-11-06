Return-Path: <linux-pci+bounces-40447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB00C3920C
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 06:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCAC734C427
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 05:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177618DB2A;
	Thu,  6 Nov 2025 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fN2DOnbK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7jN9jgJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAD28E5
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762405254; cv=none; b=j6Be6YG+9BWEzdfV2Ab0fV31p0A56NAwG8Nu2uwCGjrKdGe1d1PXC8gmmPqSQPaCUokLIL8X6xSIWIvg/14g7tKQkxvQZYitSHBlT2hYFgx6Clz4Pirh9pmwJ9/5d7B6Xu8RVJcrnIUzv5YnsR4B+IxUssjv4SsguVAC1Ths+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762405254; c=relaxed/simple;
	bh=XRjGtf1Knh3hgzogzHExgaV4xgq+KvChXNiYIl0g/c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzfPf/Pn+QA98sLLl/MOyMP+EOeZuMSbwtKqKwzJ09bwlevrclaUPYpQ4RwJuN0OYr/mifInUNb0ofclAicx8RTm1ZIquOld0K0aupkr6tKR8yKCT4Xfr2t/uYOHXZgJcGCQT8cjDRMQLmtQphy87d1jPwXp/cBNE0jn2oOeKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fN2DOnbK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7jN9jgJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KEp5q1784492
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 05:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7VcUQ37bTN6AllIXQSzVCUA/2pHn6xqb/TkBAa8Q0CI=; b=fN2DOnbKlk18IDdZ
	JRzOJqy4w4y6+I+1DfSz5x5TtGgU3/dtCYnYNe/rF35V1R6oOUw4q0c9jGL97io6
	kTwx14la8sv72w7TfflGhSpukAckXn+2muBMWJi9kAMi31KLp6Og6Z7cBv2Tj507
	2MtZPiBZq1CoRt3vZBfG2Kv1csFPA0HXqA4bLJtJozkRDKg38kVNsotjUtdiajmy
	0z4nWe+yUT8qMaEIN7UknmBTU6TVjVoHzR27VlcINCKQYPKIF3/byXr5YaXIHeHZ
	JR4TI9Pc+Uw1KfWmavDNw0AvmtckjXTZcbK+t1a4o/IQzgb4AKF4Yn+uT4emctJc
	RjBgeg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8amx9tj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 05:00:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aa9f595688so82949b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 21:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762405251; x=1763010051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VcUQ37bTN6AllIXQSzVCUA/2pHn6xqb/TkBAa8Q0CI=;
        b=D7jN9jgJKh64hq3oyO7whil7ekreY+mLoOhVydP2hsKVdIxQdvOMnLbb8uUbXh8+b0
         YGtWKwKU6OqiZCzhxQQF03bIZW9iSxd1AclolhwB5y+s/RfCyPMWYnn/6loqGi5iFiPE
         mcKBwVRamn6gUj7iTRtW1lvuIfMV3ejt6LTj85qazP5ZcJBRAOWEmVK4K0a9X/uMTr6H
         DzETnUb2IKaK7MfUqu+3QjZKjoDxtULx+2i/EtLbNUzeUz7uv9SsIbTME/IvveXc2Ujz
         nfzT2kiN4MJw/6iDA4C4BrJJJtqar727C5pMirGlT0SO7S0oyp1kqDYfb9Fynr9Jf0l3
         +JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762405251; x=1763010051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VcUQ37bTN6AllIXQSzVCUA/2pHn6xqb/TkBAa8Q0CI=;
        b=I+k/KQ7STRhf+xS5QHJUCPwPuR1PZ5432C6x/Q8D+rmMnG4LGIzRhL4VcKZFMY4ODV
         0WLKX6JsnXiw7ZwCtBKDg0SAT+WCFVSdkVmskHMKVemsWD6fqC1bs4FCic+Tm3ple43F
         GrlplC+xRo+rFdoj5HR38lvXEpo2QstMRU/6Vs2+ZANIrGjaM2UdDRtIdbSZ+JiqSL5A
         xtlpjVxCbMcATunE6Obu02Vv08Nwy+4notRK4iayVKPWaY2JCLVFP88+eL0qcgCyVc09
         eVq5xnUEuKDQIkXPJD/o4leUaJHCTCHRn8X56UHpf6LCYkVQuJj8d9BI3AXa+rDaE0Ck
         DEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUlao+OrvmlvQiePSONP5JyM8ncMqNy9Zic5fvvmUNilBDPr8TthSjHqLrrQe9l8yZmw5AphR1jdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwulphZ4peZPlG3Rgprf4+fNfMq9hM8sHi40IyQ6uujS3Ir0JR2
	vVQq7IMGyUTXgo8MAV/FazZ/2cOkbalT6Wn7/h4rSZnxqO2BRaek0vgh0gG1QPMuXRIZsOGeSS/
	SVHrZ7WKwqGe1N/CVgyfV8WjVTQ2OHPF210UWzz2ibM4bhgHyVhP661fwVNRiucU=
X-Gm-Gg: ASbGncup66EmwuTazmwaIG5Yv1nCtpAmIZRQ232j1jG9M0kucTWP2Tl2IzL7KGXPkrp
	jY0AzN1n97oqR+40PBthpGqLzaFbgkdGoChyDgkzftzZpOAJslcYBCOKtCbfrbZW260FLmKOSoS
	3jld0I3cwaTjXXBl/Tx6PN2rcqW7zS8MTF2lJ29ovMRo0dDVHKRGDVDb9CXPSecoPlehVZ+2neM
	l3ZVcc9HfZwnB73kSQ7UTnknTeJzwIUWtPOyDarXlPh9npWYCGCb93g4muUWWz1DFw29v3YaF4C
	7yJU7silMgHIJqumcaFPKBl6RQkxJ/+ByiRU+I7hil4FCBHk7dxI0CHFewrlBgnclROHSxgwdL8
	963PHWGKTbDBc+T5BU1bp3h6avD2ocOk=
X-Received: by 2002:a05:6a21:3294:b0:341:a18c:dd80 with SMTP id adf61e73a8af0-34f839e02cdmr8281580637.4.1762405251005;
        Wed, 05 Nov 2025 21:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoZvD3PSRV3YeZCJj9DTySpLI8Sq4of4sBAy+31LPEveUTKkYFf/liRbgSaGeyzkkY9H6wag==
X-Received: by 2002:a05:6a21:3294:b0:341:a18c:dd80 with SMTP id adf61e73a8af0-34f839e02cdmr8281525637.4.1762405250453;
        Wed, 05 Nov 2025 21:00:50 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d098fdd7sm540915a91.0.2025.11.05.21.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 21:00:50 -0800 (PST)
Message-ID: <e459b4de-52f1-4c20-be84-07efdc9fed93@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 10:30:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251104175657.GA1861670@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251104175657.GA1861670@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Hc_eOfbhN-lVnwYpWlTDM3rwnTYhjTKQ
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=690c2b83 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wBt9fhMRhOodALO6grUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAzNyBTYWx0ZWRfX/Ogzk5prKfGB
 48yO26GcX/E0aUnqhEVEFdl/4IchOJQWO07+4WRL49YcAwGeDdHlx7NRnxlC71ebHifH8mXMd8/
 Pr02F5LiK1Mtm6lDgrNnWJXnpY0/KeHmyJej2vZRV7m5sV1O+UUVJOAXf/N+hO8TeujyTpmC7XW
 IOBgKVT9DwHfWtKbtRMetEARWU7U4BzY5osvt32Zu7ZRSVNBpk1j/+CxfimjEIQMch0hqrf393a
 FfZviUZihsnyYbYYPnFa4IFp89GzRd/2N6YamRxiU4TmuNyvEukxHP2Czx9YyGRaGGcI5qpWr5p
 PZeWUHiriLi3QHEg6CE1awbUrfrMqd2faWBFrCiQlzALc/66XeNLGhvy3vX69YnBTb7aN7Tbomo
 Ig0UQLi+MDwWrfmPG2mzlTvFebsm0g==
X-Proofpoint-ORIG-GUID: Hc_eOfbhN-lVnwYpWlTDM3rwnTYhjTKQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060037


On 11/4/2025 11:26 PM, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 05:42:45PM +0530, Krishna Chaitanya Chundru wrote:
>> The T_POWER_ON indicates the time (in μs) that a Port requires the port
>> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
>> asserted before actively driving the interface. This value is used by
>> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
>>
>> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
>> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
>> This can result in improper L1.2 exit behavior and can trigger AER's.
>>
>> To address this, program the T_POWER_ON value to 80us (scale = 1,
>> value = 8) in the PCI_L1SS_CAP register during host initialization. This
>> ensures that ASPM can take the root port's T_POWER_ON value into account
>> while calculating the LTR_L1.2_THRESHOLD value.
> I think the question is whether the value depends on the circuit
> design of a particular platform (and should therefore come from DT),
> or whether it depends solely on the qcom device.
Yes it depends on design.
> PCIe r7.0, sec 5.5.4, says:
>
>    The T_POWER_ON and Common_Mode_Restore_Time fields must be
>    programmed to the appropriate values based on the components and AC
>    coupling capacitors used in the connection linking the two
>    components. The determination of these values is design
>    implementation specific.
>
> That suggests to me that maybe there should be devicetree properties
> related to these.  Obviously these would not be qcom-specific since
> this is standard PCIe stuff.

Yes Bjorn these are PCIe stuff only, I can go to Device tree route if we 
have different values for each target, as of now we are using this same 
value in all targets as recommended by our HW team. If there is at least 
one more target or one more vendor who needs to program this we can take 
devicetree property route.

I am ok to go with devicetree way also if you insists. - Krishna Chaitanya.

> Use "μs" or "us" consistently; there's a mix above.
>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index c48a20602d7fa4c50056ccf6502d3b5bf0a8287f..52a3412bd2584c8bf5d281fa6a0ed22141ad1989 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1252,6 +1252,27 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
>>   	return val & PCI_EXP_LNKSTA_DLLLA;
>>   }
>>   
>> +static void qcom_pcie_program_t_pwr_on(struct dw_pcie *pci)
>> +{
>> +	u16 offset;
>> +	u32 val;
>> +
>> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
>> +	if (offset) {
>> +		dw_pcie_dbi_ro_wr_en(pci);
>> +
>> +		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
>> +		/* Program T power ON value to 80us */
>> +		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
>> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, 1);
>> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, 8);
>> +
>> +		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
>> +
>> +		dw_pcie_dbi_ro_wr_dis(pci);
>> +	}
>> +}
>> +
>>   static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
>>   {
>>   	struct qcom_pcie_port *port;
>> @@ -1302,6 +1323,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>   			goto err_disable_phy;
>>   	}
>>   
>> +	qcom_pcie_program_t_pwr_on(pci);
>> +
>>   	qcom_ep_reset_deassert(pcie);
>>   
>>   	if (pcie->cfg->ops->config_sid) {
>>
>> ---
>> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
>> change-id: 20251104-t_power_on_fux-70dc68377941
>>
>> Best regards,
>> -- 
>> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>

