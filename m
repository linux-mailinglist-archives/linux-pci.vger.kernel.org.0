Return-Path: <linux-pci+bounces-4181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA086AFE7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3A62878AC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 13:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7291474D8;
	Wed, 28 Feb 2024 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VBBHyHKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCD145341;
	Wed, 28 Feb 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125640; cv=none; b=bfOQj3ZevTDpouFaQyMmMvdRzJKmW2lpdOou1C8vpldHT57rqnCHhnV3ucrsHZzc515Wi4ILg0j18w3duNEINWGSBxSh0p66rYuNvmPkWP6ghrmpAkp2fUIqvrAm/nUOsoTHN3ucHWPDeXh9WvhOO0FHhev3LjZyQUtLCGF6bDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125640; c=relaxed/simple;
	bh=RvzJ4l2yqF8ezySL48DF5MT1sZ9IXKITdWB7P32EZZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZiBYrj+MgKJBFeTwodFFYX6anLAGxcyZRtMOTeQvA1yAkgLY5k2j/XUAZhTRxbadO0+pPhwFpUTn/PVHlAHZXwTtF75W6oMy5qlrRm4REQ2F9613c/kvrfCC+knunzC6PfvUzxZqvTsCzHqlMfz1ygVN14sbOtOMJh0jUbbM5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VBBHyHKJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41SAuLrK012787;
	Wed, 28 Feb 2024 13:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RvzJ4l2yqF8ezySL48DF5MT1sZ9IXKITdWB7P32EZZg=; b=VB
	BHyHKJi2WVlqSq1uK1IIrm98ZUntr3LfPyoXRSgRe7hd3Aux452/InroG32kFLxm
	OdcAKdx+8cnTx5jfqv3rUaW1OnloWsHC5bKEH5RX+Hbw/FNzxtxE4mGVr1OVHOel
	PmS8mT2IUztuUZ1W/2W9xfBQK30Xoif01ueFuUpPSsr7jTI2xk3CIZeEGoUgFn9I
	Ef/4bUmQrpkGC+O4niibJwP5kTKImRK9808yklUAkjsUFhGqkx8ucU4cz5E8cjBI
	OtQfFS+Y2FHgj1crKRH4Rk/sUcBIP65WSOpgLR4vjBjhFPiZMNGTctrdUsoD4bIj
	JW4Jn50wke+N4egMVOjQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whtbw9d2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:07:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SD7B9i026071
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:07:11 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 05:07:04 -0800
Message-ID: <7cd328e2-6847-973f-c38b-93d1e64d3771@quicinc.com>
Date: Wed, 28 Feb 2024 18:37:01 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 0/3] arm64: qcom: sa8775p: add cache coherency support
 for SA8775P
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>
CC: <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <quic_krichai@quicinc.com>,
        <quic_vbadigan@quicinc.com>, <quic_schintav@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
 <866ea7ee-54c3-4a89-981e-64d6d3b46497@linaro.org>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <866ea7ee-54c3-4a89-981e-64d6d3b46497@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HCcCySSSp6hMcYQVt0MSg1qXLvCNmev2
X-Proofpoint-ORIG-GUID: HCcCySSSp6hMcYQVt0MSg1qXLvCNmev2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_06,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxlogscore=954 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280103


On 2/24/2024 3:49 PM, Krzysztof Kozlowski wrote:
> On 23/02/2024 15:03, Mrinmay Sarkar wrote:
>> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
>> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
>> the requester is indicating that there no cache coherency issues exit
>> for the addressed memory on the host i.e., memory is not cached. But
>> in reality, requester cannot assume this unless there is a complete
>> control/visibility over the addressed memory on the host.
>>
>> And worst case, if the memory is cached on the host, it may lead to
>> memory corruption issues. It should be noted that the caching of memory
>> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
>>
>> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
>> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
>> needed for other upstream supported platforms since they do not set
>> NO_SNOOP attribute by default.
>>
>> This series is to enable cache snooping logic in both RC and EP driver
>> and add the "dma-coherent" property in dtsi to support cache coherency
>> in SA8775P platform.
> Please confirm that your patchset passes 100% dtbs_check.
>
> Best regards,
> Krzysztof

I have run dtbs_check and it is passing.

Thanks
Mrinmay

>

