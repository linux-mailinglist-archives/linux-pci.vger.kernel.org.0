Return-Path: <linux-pci+bounces-32863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C589B0FF22
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 05:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029B7AC23A6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 03:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486021DED5F;
	Thu, 24 Jul 2025 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O/Dcemyh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312A11DE2BF;
	Thu, 24 Jul 2025 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753327505; cv=none; b=QAbweQ9MKb/DT8qTpmmfcJyZtJAuxXAdUxDJtjghjJ4QcqfdUUcg8pdwRSWJhlMkfQM2n71yKgeL7bF3ZfwPsW48TMESz3KJhYhu06kmeErhRmK9/ca+eBjmf6cr5JiXdkNo1dNtT70Rt7ISCoA+47Kyj0mJAtiO5Lygbw1UQQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753327505; c=relaxed/simple;
	bh=i/9vDgTh5joxaC1nwzinKmMTrMiORl7M60KtL9oTrMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItDVXKVbR7ET112UOQiZuW1UAUwqWsvJl5F1YFpReufLM7xnimeL2itLh5qZ3L49s34Sdp10xcbmFm094w5+ldbLV3jgg2bo4TPPgm00SIDW3CeiRwd6tefd/ooPntKPNJhdG78NqM4eKiO1zPA4SwOKWoDrWcfkA7zDymEVW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O/Dcemyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXMsq010365;
	Thu, 24 Jul 2025 03:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/n12LK2l2hjpse6betBd89TM4om6AmTfe97KpCt4gBU=; b=O/DcemyhRnXMMiJr
	KL/lz2p/+qJ7RsS8o4PXiI0hk/GpVtuJk+uCnaXfkDS6kJQ8H/4Wdb6B6BG37RRE
	F7Hx3YxukJ83piXwP8r7/e5zTfn6JqHD2HLvLMBjR1GDtxT+X8y664S3CrlrPF8q
	R2++cF/+QRchIU6l4hX1susT7WxqCz5A3BYoRUUJPrrszgDXCDcFzoXaRZSfSKRI
	G1TnM2PfED71iLs55cikXcRbSTx6PGpdc6zT1ozaTj6orUgDd7foUERHr40Dynnz
	mqca3YPqVQxw2VxVM4VjFIVzLdy38H3jIOL0USxd7bjWZHmJ3QjKvF2yeHO8+Tgr
	Vw6ozg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w8ds7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:24:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O3OoS4014726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 03:24:50 GMT
Received: from [10.239.28.138] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Jul
 2025 20:24:45 -0700
Message-ID: <e0b1eb69-f2ba-4bdd-b6ce-c561a1311149@quicinc.com>
Date: Thu, 24 Jul 2025 11:24:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI: dwc: enable PCI Power Control Slot driver for
 QCOM
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <sfr@canb.auug.org.au>,
        <qiang.yu@oss.qualcomm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <krishna.chundru@oss.qualcomm.com>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>, <quic_cang@quicinc.com>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
 <20250722091151.1423332-2-quic_wenbyao@quicinc.com>
 <g4vti733clyly7uludeypp55s2s3ajznw4g3mjgo3segah3zdm@uixreuvty7px>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
In-Reply-To: <g4vti733clyly7uludeypp55s2s3ajznw4g3mjgo3segah3zdm@uixreuvty7px>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6881a782 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=dyWBFaKGwv1Yg5mhNCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAxOCBTYWx0ZWRfX+T2UKKLYf+F6
 y3iyD0Niq9oujoeEI1MDA/KU+kWv2MldN39AsQib8gAQoKSK4gfVQ9z13hKiHcppI4JPQO6TDk2
 uWLoI6pRQ3bfbUWczbPcxOKiM5DtoHpZxTM8NEpaDr0b5D4lr5U6Kb0lQa4EuO9IqEdTbnqSoEu
 JOlYyfEGsgsOqSPiA36yT8bLJdE+lmusp+rEu8BGyZfv51Ma5oZWYNkJthwZGZ/EZQhKSDOTxbF
 dY3crODgwlrhgX1uVCUUgG2hJKikKt/paSOq7s5GfsteEhBXgsAWRpVoSzds51gWnL+DApPbHPN
 VHE9qFtc/dY6R9yJSQsZlWaZNy0kipPrOB0hNYD2EfcOpY63Df/kNOqHkznYYQNcR9TY00tG0tg
 dXN0QzzZGmx8+dKphx4rcKALlLGXWDdJCTMchi9OdP6jXyWMh/jXPtvV4cNgMbtomDRgs2FC
X-Proofpoint-ORIG-GUID: RP746ekg0f1M0W8IA2ZSnlYKhw9iCfvo
X-Proofpoint-GUID: RP746ekg0f1M0W8IA2ZSnlYKhw9iCfvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=870 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240018

On 7/23/2025 10:34 PM, Manivannan Sadhasivam wrote:
> On Tue, Jul 22, 2025 at 05:11:49PM GMT, Wenbin Yao wrote:
>> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
>>
>> Enable the pwrctrl driver, which is utilized to manage the power supplies
>> of the devices connected to the PCI slots. This ensures that the voltage
>> rails of the standard PCI slots on some platforms eg. X1E80100-QCP can be
>> correctly turned on/off if they are described under PCIe port device tree
>> node.
>>
>> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
>> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index ff6b6d9e1..deafc512b 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -298,6 +298,7 @@ config PCIE_QCOM
>>   	select CRC8
>>   	select PCIE_QCOM_COMMON
>>   	select PCI_HOST_COMMON
>> +	select PCI_PWRCTRL_SLOT
> I guess you also need 'if HAVE_PWRCTRL'
>
> - Mani

PCIE_QCOM depends on PCI and (ARCH_QCOM  || COMPILE_TEST), ARCH_QCOM
selects HAVE_PWRCTRL.

>
-- 
With best wishes
Wenbin


