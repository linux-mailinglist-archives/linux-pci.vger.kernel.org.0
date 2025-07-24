Return-Path: <linux-pci+bounces-32862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E5B0FEF3
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 04:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E170586F00
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jul 2025 02:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A71A08A3;
	Thu, 24 Jul 2025 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MircXLAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9622097;
	Thu, 24 Jul 2025 02:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325553; cv=none; b=chY5mlOpYZdWuwZZ9ObnF8pH3YlSnm7EmuMPybFBuF78rU8mWAvVyDSEKORCVVKxrfRScx4v/4RMfI3EE73qoV/dIyNbc4JvaLsCjQJiTpGMrWVSXok6vpKnCxxFyvXvRdMm8tl0cvdoywxG4e3DWbm6KAZbdXaAqDeWmycOztw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325553; c=relaxed/simple;
	bh=4QVJ/0N+hI1nN5rWg92dSQR7a9Fnlh9gu5pJAGEWXac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lm8Ru0cDUzm4aYRJF530clEbCojKQ8+d2f01W8yvUuQSRi7QzlNPWUJgwre0f7Tlmx7/QQHx+Qcl/2M9YkTZynd7p+YP3Jw/rzZje2cf3u353PaJedXyzrIFanFDn4KdLpv0r7wryRfomOOnRwYxhCpJI4wOXyLbyjVY+7MP+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MircXLAJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXH6G028536;
	Thu, 24 Jul 2025 02:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AW2TVBieUbKEWXfhJiRsoeOWM+aGCqVAyDsOOnSEl44=; b=MircXLAJgUinlDB1
	1cCkDGFZYgr4esb2K5pFraoTDdHzq3ImOa47dZPddpP/lnnU5wla82Eo4WrvrgE9
	8RB9WwcYrKJFUl992OUIGpwh+0v/RNpH+HvOXeoeKm4BVNjK972spYxPYVRmSl2Y
	QFYdTUn8+3Tnv9EUayR0i8bGvAnV4qER/DOwRkH5HFCqtXPY7f/ljynQf1alpZyJ
	eC7O1C9+3liA2RzdAPzgeOBLQH5ncW9arU7NFOXNe9T2GJVsE4gxIqJV08eF2VJR
	mIvNSGHGCdfSkVXxnG16N7qN3HtSDxSWtXdoFvc+HqBIIsHsiKNyHWvWSdsp9qcu
	QMcQsg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1eghf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 02:52:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56O2qGfm028925
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 02:52:16 GMT
Received: from [10.239.28.138] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 23 Jul
 2025 19:52:12 -0700
Message-ID: <a243dc20-6b48-425f-ae43-786d347b2458@quicinc.com>
Date: Thu, 24 Jul 2025 10:52:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI: dwc: enable PCI Power Control Slot driver for
 QCOM
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <sfr@canb.auug.org.au>,
        <qiang.yu@oss.qualcomm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <krishna.chundru@oss.qualcomm.com>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>, <quic_cang@quicinc.com>
References: <20250722232255.GA2864066@bhelgaas>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
In-Reply-To: <20250722232255.GA2864066@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PT-JvnAfEGjKqM4JdLK2ytAkzZMGm4GY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDAxNCBTYWx0ZWRfX7OFoLUmqJxVw
 ri4X+YJXDzThNKpNMd+gfM2mTfilmzS1HqIvKyo2Cdu1FY+JrhBtACKtelzegO7pK+QWt9Ms3hj
 JojetP85QtbTJzRkcRH4GKx1f+ndcZfg5JWFe25Di671w1gj+59yjJZCGBrXjuYe4tkMTYV4hQ5
 aNN+SqzNDp3bYWni8FuhR9NWXiSU8LU0jSpr0x+HjE+ZXO1bZr0eRV37JyY4HTrqDhWyPsxonnY
 JfBfdWS/beNF9pCoZVyPUDgUbWdaoeaauyEaU07sbFVvEBBqIPMCltdp5M04hL6U++zWVK0Fs7+
 kB8oM2a5gM/oYYfau9dKM29vrvKqf2UG7E0DHsuwDkqq7cM4MdSVTuJ3VhduQFYPnVXKhuc+uZa
 H8hT1ZoJecljkpaneRtUdHdIml6V3ISLlKbxLwTbrYZUT+oGzK3bprmnzIzj3h650WSGOjYc
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=68819fe1 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=dyWBFaKGwv1Yg5mhNCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PT-JvnAfEGjKqM4JdLK2ytAkzZMGm4GY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1011 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240014

On 7/23/2025 7:22 AM, Bjorn Helgaas wrote:
> In subject:
>
>    PCI: qcom: Enable PCI Power Control Slot driver
>
> This is not a generic dwc change; it's specific to qcom, so I want the
> subject to reflect that.
>
> We can fix this when applying unless other changes are needed.

OK， will fix it.

>
> On Tue, Jul 22, 2025 at 05:11:49PM +0800, Wenbin Yao wrote:
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
>>   	help
>>   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
>>   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
>> -- 
>> 2.34.1
>>
-- 
With best wishes
Wenbin


