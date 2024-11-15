Return-Path: <linux-pci+bounces-16926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21329CF3FC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B482898C9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742FE186E56;
	Fri, 15 Nov 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Su2F9OOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FADB183088;
	Fri, 15 Nov 2024 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695492; cv=none; b=AKGDvei2XPhfkl4cfiBHXTBJU1YcARRn71UkFJBvH5h03HD65EwtK7HmTgZkyuRzXRMcg/cCBpERLTiJ/oyw/WqGn7jYqjzrZ2iBeMWVRjU5Gy+HM5zkRmhl5s/zrQYwd0GHmy1i+gQu4Tkde7+63FoPvJlIBCwEmD5LPM1GoNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695492; c=relaxed/simple;
	bh=T7owxCrmzL9B2p4ropXht/ugb0EmftLWvXL/zuJ4ZCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bpras6NA04WBM3YogWQ5BkeA2O7+qCths2q94D9SXscLwOqWtLOev2At+5ohu4HCa7Cbcmi71bHYPxCRLmR57f0t5rbeEvvrssoXNYISzCvbYcBqEVPyUgaYEOxjitQsBzvio39TPJVr5ZbBHn/9YaYSyRDH457CLnKLs2haAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Su2F9OOx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFHoTLO018983;
	Fri, 15 Nov 2024 18:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eC/JeM9/eX7GjpRqMmFKay7Cio3ltqUn4yMJhvyMtqM=; b=Su2F9OOx0tB27Lvz
	J9zb/XXsr6/zEWz9rcbUcH+Al4pTlha96ay7PO8Y3v2TkKSzss/F/Q1pLEKei5ZA
	f7ItdbHxzAGrlxFErFtvzyLzazISbnoC7LHygRJjBtdxIwnR2Y9lZ9QdX3vX0GFV
	lZFep/buT5ApKq2ThiO0TOJwL/uBNMJ2SxZqtlXnmhqYosqGWzX++QGXYlnfHxHO
	MyciJWFl34FIyytCSFJHwTZuDDkHTTIFv1mxLKrfdSnlMoF7RlpIgt9/uQekPGZJ
	PsfUshICXbZnw2mii0HAkdQcIiAqnMVbxMiSJzsEyodeDAcPZi8VCu9ZQJe+osOu
	OW6Jfg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wex8w11u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:31:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFIVJ2X004593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:31:19 GMT
Received: from [10.110.68.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 10:31:18 -0800
Message-ID: <6e9db73e-0441-453c-978c-961f308f8a11@quicinc.com>
Date: Fri, 15 Nov 2024 10:31:17 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add Qualcomm SA8255p based firmware managed PCIe
 root complex
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <jingoohan1@gmail.com>, <will@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_krichai@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
 <20241115112802.66xoxj4z5wsg4idl@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241115112802.66xoxj4z5wsg4idl@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Fq6JurJ4csMT-KotEN90S8nT27D7wtg9
X-Proofpoint-ORIG-GUID: Fq6JurJ4csMT-KotEN90S8nT27D7wtg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=946 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411150156



On 11/15/2024 3:28 AM, Manivannan Sadhasivam wrote:
> On Wed, Nov 06, 2024 at 02:13:37PM -0800, Mayank Rana wrote:
>> Based on received feedback, this patch series adds support with existing
>> Linux qcom-pcie.c driver to get PCIe host root complex functionality on
>> Qualcomm SA8255P auto platform.
>>
>> 1. Interface to allow requesting firmware to manage system resources and
>> performing PCIe Link up (devicetree binding in terms of power domain and
>> runtime PM APIs is used in driver)
>>
>> 2. SA8255P is using Synopsys Designware PCIe controller which supports MSI
>> controller. Using existing MSI controller based functionality by exporting
>> important pcie dwc core driver based MSI APIs, and using those from
>> pcie-qcom.c driver.
>>
>> Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
>> compliant PCIe controller based functionality. Here firmware VM based PCIe
>> driver takes care of resource management and performing PCIe link related
>> handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
>> request firmware VM to perform these operations using SCMI interface.
>> --------------------
>>
>>
>>                                     ┌────────────────────────┐
>>                                     │                        │
>>    ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐
>>    │     Firmware VM      │         │                        │            │         Linux VM         │
>>    │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │
>>    │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE Qcom    │    │
>>    │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │    driver      │    │
>>    │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │
>>    │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │
>>    │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │
>>    │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │
>>    │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │
>>    │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │
>>    │               │  │   │         │                        │            │       │          │       │
>>    └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘
>>                    │  │             │                        │                    │          │
>>                    │  │             └────────────────────────┘                    │          │
>>                    │  │                                                           │          │
>>                    │  │                                                           │          │
>>                    │  │                                                           │          │
>>                    │  │                                                           │IRQ       │HVC
>>                IRQ │  │HVC                                                        │          │
>>                    │  │                                                           │          │
>>                    │  │                                                           │          │
>>                    │  │                                                           │          │
>> ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
>> │                                                                                                          │
>> │                                                                                                          │
>> │                                      HYPERVISOR                                                          │
>> │                                                                                                          │
>> │                                                                                                          │
>> │                                                                                                          │
>> └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
>>                                                                                                              
>>    ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐
>>    │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │
>>    │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │
>>    └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘
>>                                                                                                              
> 
> Thanks a lot for working on this Mayank! This version looks good to me. I've
> left some comments, nothing alarming though.
Thanks for reviewing change. I would address those in next patchset.

> But I do want to hold up this series until we finalize the SCMI based design.
ok. I want to send these changes which are prepared based on previously 
provided feedback, to see if we have any major concern here in terms of 
getting functionality.

Regards,
Mayank
> - Mani
> 
>> ----------
>> Changes in V3:
>> - Drop usage of PCIE host generic driver usage, and splitting of MSI functionality
>> - Modified existing pcie-qcom.c driver to add support for getting ECAM compliant and firmware managed
>> PCIe root complex functionality
>> Link to v2: https://lore.kernel.org/linux-arm-kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/
>>
>> Changes in V2:
>> - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
>> - Add power domain based functionality within existing ECAM driver
>> Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
>>
>> Tested:
>> - Validated NVME functionality with PCIe0 on SA8255P-RIDE platform
>>
>> Mayank Rana (3):
>>    PCI: dwc: Export dwc MSI controller related APIs
>>    PCI: qcom: Add firmware managed ECAM compliant PCIe root complex
>>      functionality
>>    dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
>>      complex
>>
>>   .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml | 100 +++++++++++++++++++++
>>   drivers/pci/controller/dwc/Kconfig                 |   1 +
>>   drivers/pci/controller/dwc/pcie-designware-host.c  |  38 ++++----
>>   drivers/pci/controller/dwc/pcie-designware.h       |  14 +++
>>   drivers/pci/controller/dwc/pcie-qcom.c             |  69 ++++++++++++--
>>   5 files changed, 199 insertions(+), 23 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
>>
>> -- 
>> 2.7.4
>>
> 

