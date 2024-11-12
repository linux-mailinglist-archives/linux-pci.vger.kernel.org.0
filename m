Return-Path: <linux-pci+bounces-16505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA919C4F59
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 08:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45254B21E53
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E3207A35;
	Tue, 12 Nov 2024 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k8TQ1YUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BB20A5EB;
	Tue, 12 Nov 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396262; cv=none; b=M7KxInFBDWpED7YZQeHQmxqALMWsLDazV3WX0r8Qk0JL6OqwqrD4wc7uejoxTRIqSPvjAndBn52FMksgQ8pDnvJbBsC1kfrvEuLM/2PMdluf8mI8sSuN4g62TmQPTD33QjWAAZHtX0DPseMjQ0gX3Epx0rHW/f4i0EVCMeBE2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396262; c=relaxed/simple;
	bh=AmKKDwOqZfPgxQ71wPS/jT+BiPX5ic7MGRFRRuksVSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a/eihmb+e5I+gHWMTw8IIIfC8sLxXe6zmhUM3RL0Gzu5ljSKMhpUNAct8crWwJoD2gsrXEGNCmC12N4hsgWaNdcEiwDqaNSb2BoC2MMj0diprvyBgHovJMv1l+Lz0aA41LjHe+WL5b2BT+H1iQhPci50JZbkWM3KjfrssWiKfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k8TQ1YUh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC3frYA019134;
	Tue, 12 Nov 2024 07:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tzjf94MXs8BvObqrZx+eUlU3ZPS4ZV90CozDAWrbMrw=; b=k8TQ1YUhaSKWma4C
	t2qbJAq/xHxBUUxzhag6ChbbyoA08kYQRoO1H3iqTDCwWZ7zw5DCZ/Ez5G8xw8tW
	UwV0VXNY4ObY9HUFaukdoSJloksTnfHJ4KZFf67/XlF/vrHnjJB0d94u8modqanZ
	gK+Js3AI/xq7jMtK+sMUhwYgUe0/HADEI/q540onESGTSD6RyaMh14qkxXkBk911
	uWcQjEGBy+KU0WnAGHFKeJng6HIv7IE6dHoZqIgyaaxOAW4FXXVvj3e8U2oZd3gd
	lg8LicU0jm2m+oZb3za94OjBF+Nwtp6Yuit9zc54fg2uMhMzVeARdcbYcE/SzE2v
	B+0GgA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t0gkxcs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:18:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AC7IQ53007141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 07:18:26 GMT
Received: from [10.253.13.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 11 Nov
 2024 23:18:22 -0800
Message-ID: <e35d1541-8bd7-447d-b544-e8fb8cce287a@quicinc.com>
Date: Tue, 12 Nov 2024 15:18:19 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Fix API pci_epc_destroy() releasing
 domain_nr ID faults
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham
 I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li
	<Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jingoo Han
	<jingoohan1@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin
	<shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, <stable@vger.kernel.org>
References: <20241107-epc_rfc-v2-0-da5b6a99a66f@quicinc.com>
 <20241107-epc_rfc-v2-1-da5b6a99a66f@quicinc.com>
 <20241112070339.ivgjqctoxaf2xqxr@thinkpad>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20241112070339.ivgjqctoxaf2xqxr@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bkmDRW36247srH1YjhAQvCp6Xvg9L36p
X-Proofpoint-GUID: bkmDRW36247srH1YjhAQvCp6Xvg9L36p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1011 mlxscore=0 mlxlogscore=653 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120059

On 11/12/2024 3:03 PM, Manivannan Sadhasivam wrote:
> On Thu, Nov 07, 2024 at 08:53:08AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> pci_epc_destroy() invokes pci_bus_release_domain_nr() to release domain_nr
>> ID, but the invocation has below 2 faults:
>>
>> - The later accesses device @epc->dev which has been kfree()ed by previous
>>   device_unregister(), namely, it is a UAF issue.
>>
>> - The later frees the domain_nr ID into @epc->dev, but the ID is actually
>>   allocated from @epc->dev.parent, so it will destroy domain_nr IDA.
>>
>> Fix by freeing the ID to @epc->dev.parent before unregistering @epc->dev.
>>
>> The file(s) affected are shown below since they indirectly use the API.
>> drivers/pci/controller/cadence/pcie-cadence-ep.c
>> drivers/pci/controller/dwc/pcie-designware-ep.c
>> drivers/pci/controller/pcie-rockchip-ep.c
>> drivers/pci/controller/pcie-rcar-ep.c
> 
> No need to mention the callers.
> 

thank you Manivannan for code review.
good suggestions, i will take them for further similar patches.(^^)

>>
>> Fixes: 0328947c5032 ("PCI: endpoint: Assign PCI domain number for endpoint controllers")
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: Shawn Lin <shawn.lin@rock-chips.com>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Good catch! (not sure how I messed up in first place).
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
>> ---

[snip]

>>
> 


