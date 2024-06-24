Return-Path: <linux-pci+bounces-9201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F3F9154FB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 19:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70FB1F2165A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CDA19D086;
	Mon, 24 Jun 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HxJWtwEl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C413E024;
	Mon, 24 Jun 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248700; cv=none; b=OGcpy7zowANNLtcBkVykn1XRTeBqNJJmKNXLJtDTugkfZPa8hNX631dcBSx6BvqjVi6D4lWpwaIskRfhNLrh+PeVbncR1MwxQtKSCW4XOUPLCDc2vJa7L7VqmcYNvyUYPrwTPcvTT4VjekPqSTQDHvksJk0+bpfReKvHCT63HvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248700; c=relaxed/simple;
	bh=s4iuFFIT6/bTvstEiFk3M1OXg4LY5fkxalRWxbMSH/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HdU2zPjuGrisU3ENegooR7O96t8VxjQZm0pLYLTR2CIyMtCLvVqte/Ew9+ahPRZQzbfEKLavjEjS8PcWYqduH24VWfBTdDvfqs/f2Nd2Nh9cVWkF2T7D5L4kDU1YPWIVXQAzJjYIlDY10bYoixsnovbhHdSunN9Tcf+1EiaanHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HxJWtwEl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8Z0jp008003;
	Mon, 24 Jun 2024 17:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GZzwMo2y8jk+T+3cS1833xk8zuToTgWMeI214HZz4hs=; b=HxJWtwElVO0QQz/X
	qQvgrl0F+XF6NSo34gicZ6Kj1cc/xg3gupR4NC6In3RgS03vS0J3ojDi3vyAeI56
	KCjhixQbS0CdSSY87yt5gpqjHnc4c7W8TMQjlGI0kaMRO0l7kcCscjusmgX0YnbC
	AL8kBBKf8O6C6auWs/un4MIdJa8bgxHZbn0dEWMB0m87/TVp3iN0mSOmtkTUhCnb
	aHA3P8EpJ6DRcaM4fZRwRBmTKtzk/SwO0I8iMe8BfS9kQoKN1q3f91R2Y/sF3yET
	/XCYMBZz44we3Uy8pG4kGWHNVEsiqNyCoSJT0hWZK2V3OdxrPosghGwx/eYkPJpo
	X73Guw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnjrvcbf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 17:04:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45OH4p0c030543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 17:04:51 GMT
Received: from [10.110.88.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Jun
 2024 10:04:50 -0700
Message-ID: <9d4cea0c-16be-4341-9b48-2b32a92b75f4@quicinc.com>
Date: Mon, 24 Jun 2024 10:04:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI: qcom: Avoid DBI and ATU register space mirror to
 BAR/MMIO region
To: Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <bhelgaas@google.com>, <robh@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240622174152.GA1432494@bhelgaas>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240622174152.GA1432494@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eMnuISu32k1cWZqCX1cxLL4h_EtUVROz
X-Proofpoint-ORIG-GUID: eMnuISu32k1cWZqCX1cxLL4h_EtUVROz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_13,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240136



On 6/22/2024 10:41 AM, Bjorn Helgaas wrote:
> On Sat, Jun 22, 2024 at 09:24:44AM +0530, Manivannan Sadhasivam wrote:
>> On Thu, Jun 20, 2024 at 02:34:05PM -0700, Prudhvi Yarlagadda wrote:
>>> PARF hardware block which is a wrapper on top of DWC PCIe controller
>>> mirrors the DBI and ATU register space. It uses PARF_SLV_ADDR_SPACE_SIZE
>>> register to get the size of the memory block to be mirrored and uses
>>> PARF_DBI_BASE_ADDR, PARF_ATU_BASE_ADDR registers to determine the base
>>> address of DBI and ATU space inside the memory block that is being
>>> mirrored.
>>
>> This PARF_SLV_ADDR_SPACE register is a mystery to me. I tried getting to the
>> bottom of it, but nobody could explain it to me clearly. Looks like you know
>> more about it...
>>
>>  From your description, it seems like this register specifies the size of the
>> mirroring region (ATU + DBI), but the response from your colleague indicates
>> something different [1].
>>
>> [1] https://lore.kernel.org/linux-pci/f42559f5-9d4c-4667-bf0e-7abfd9983c36@quicinc.com/
>>
>>> When a memory region which is located above the SLV_ADDR_SPACE_SIZE
>>> boundary is used for BAR region then there could be an overlap of DBI and
>>> ATU address space that is getting mirrored and the BAR region. This
>>> results in DBI and ATU address space contents getting updated when a PCIe
>>> function driver tries updating the BAR/MMIO memory region. Reference
>>> memory map of the PCIe memory region with DBI and ATU address space
>>> overlapping BAR region is as below.
>>>
>>> 			|---------------|
>>> 			|		|
>>> 			|		|
>>> 	-------	--------|---------------|
>>> 	   |	   |	|---------------|
>>> 	   |	   |	|	DBI	|
>>> 	   |	   |	|---------------|---->DBI_BASE_ADDR
>>> 	   |	   |	|		|
>>> 	   |	   |	|		|
>>> 	   |	PCIe	|		|---->2*SLV_ADDR_SPACE_SIZE
>>> 	   |	BAR/MMIO|---------------|
>>> 	   |	Region	|	ATU	|
>>> 	   |	   |	|---------------|---->ATU_BASE_ADDR
>>> 	   |	   |	|		|
>>> 	PCIe	   |	|---------------|
>>> 	Memory	   |	|	DBI	|
>>> 	Region	   |	|---------------|---->DBI_BASE_ADDR
>>> 	   |	   |	|		|
>>> 	   |	--------|		|
>>> 	   |		|		|---->SLV_ADDR_SPACE_SIZE
>>> 	   |		|---------------|
>>> 	   |		|	ATU	|
>>> 	   |		|---------------|---->ATU_BASE_ADDR
>>> 	   |		|		|
>>> 	   |		|---------------|
>>> 	   |		|	DBI	|
>>> 	   |		|---------------|---->DBI_BASE_ADDR
>>> 	   |		|		|
>>> 	   |		|		|
>>> 	----------------|---------------|
>>> 			|		|
>>> 			|		|
>>> 			|		|
>>> 			|---------------|
>>>
>>> Currently memory region beyond the SLV_ADDR_SPACE_SIZE boundary is
>>> not used for BAR region which is why the above mentioned issue is
>>> not encountered. This issue is discovered as part of internal
>>> testing when we tried moving the BAR region beyond the
>>> SLV_ADDR_SPACE_SIZE boundary. Hence we are trying to fix this.
>>
>> I don't quite understand this. PoR value of SLV_ADDR_SPACE_SIZE is
>> 16MB and most of the platforms have the size of whole PCIe region
>> defined in DT as 512MB (registers + I/O + MEM). So the range is
>> already crossing the SLV_ADDR_SPACE_SIZE boundary.
>>
>> Ironically, the patch I pointed out above changes the value of this
>> register as 128MB, and the PCIe region size of that platform is also
>> 128MB. The author of that patch pointed out that if the
>> SLV_ADDR_SPACE_SIZE is set to 256MB, then they are seeing
>> enumeration failures. If we go by your description of that register,
>> the SLV_ADDR_SPACE_SIZE of 256MB should be > PCIe region size of
>> 128MB. So they should not see any issues, right?
>>
>>> As PARF hardware block mirrors DBI and ATU register space after
>>> every PARF_SLV_ADDR_SPACE_SIZE (default 0x1000000) boundary
>>> multiple, write U64_MAX to PARF_SLV_ADDR_SPACE_SIZE register to
>>> avoid mirroring DBI and ATU to BAR/MMIO region.
>>
>> Looks like you are trying to avoid this mirroring on a whole. First
>> of all, what is the reasoning behind this mirroring?
> 
> This sounds like what we usually call "aliasing" that happens when
> some upper address bits are ignored.
Yes, here we are trying to disable altogether aliasing (mirroring of 
DBI/ATU) address space).

Regards,
Mayank

