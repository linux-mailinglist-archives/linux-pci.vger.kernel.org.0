Return-Path: <linux-pci+bounces-4179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0C86AFD4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EEA1C250D9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A005314C58D;
	Wed, 28 Feb 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cJ6K9TXw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7F14F995;
	Wed, 28 Feb 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125472; cv=none; b=S3KjFWmNazvmiHBGPJIjgCAncORVZK16bvuZJWUX1Jhf3DLSWbn2eDfAQLx2XVFxory77anOFLRYkH0+YnTX4UUPWB3+G9Dhpw8lFLGeYRuSceh/BQ4j1G9/xG2OcxCri/iTruLTLov3MO66zMGjb2y8xjE/9MAYGWiX31Xk9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125472; c=relaxed/simple;
	bh=Zo7mkUyO1e4cRV15WZDLmxJqSFduroQP9BwBqR01+xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q9Jogqtgrtslwc4d3yQOdqB91kAgu0twWOxEsb7VuHT2ytyo/4v6yN1uHCzKNItyzu0dp21RDAoiV+XW8I9Fm0fCQkrRDVEGOe3777+hPA/G6qBo0itsWa9ukKisyo6dBUv8LCMuTAME+h4wObk1U8YaVhm7uuxoG05K21MMDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cJ6K9TXw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S5ffZ0000321;
	Wed, 28 Feb 2024 13:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=P7hLoMtk/Gsil4liN6dyNFOkcj9EO+K0QVhEgrDthSk=; b=cJ
	6K9TXwSqqeW8/IGr0Jp3AVqRqJXN6BLGzXpXpcte5AT7GQWYe2uyxYdFk+skllGk
	D3AWNEPTsBr8r+KsIieVCTgyNuknQXsCJR0XIGF+bIXH7MFZsrKTHuuEYOZiQ3zQ
	sXqpg2VzzfLgyjkctbYTKSNHn5XEWFNJ95QHTl+2kOijDIZJlIoDqewvRoBuskJY
	jHPbDcF8rlUOeiTFdlt3bPZrYg8emyjhS5SGABgmXiNhd1YBjMtA+/roggw59zIh
	1ZDLxSA0mnSRHKlhGgDIyy8GBxjFlxlzkhVO09tKeKVCXHb8s9aZoFYROqHgA5Fj
	GbxaeelCqOkDCNtTeZhg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whv1fs7qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:04:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SD4Lli010461
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 13:04:21 GMT
Received: from [10.218.10.86] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 05:04:15 -0800
Message-ID: <02e44f17-39cd-46ec-b236-bc4f502d705e@quicinc.com>
Date: Wed, 28 Feb 2024 18:34:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
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
References: <20240223225425.GA103870@bhelgaas>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <20240223225425.GA103870@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3bA6z9D2GJzgOFx3Fy3RLpMuP9flMF6Y
X-Proofpoint-ORIG-GUID: 3bA6z9D2GJzgOFx3Fy3RLpMuP9flMF6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280103


On 2/24/2024 4:24 AM, Bjorn Helgaas wrote:
> On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:
>> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
>> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
>> the requester is indicating that there no cache coherency issues exit
>> for the addressed memory on the host i.e., memory is not cached. But
>> in reality, requester cannot assume this unless there is a complete
>> control/visibility over the addressed memory on the host.
> s/that there no/that no/
> s/exit/exist/
>
> Forgive my ignorance here.  It sounds like the cache coherency issue
> would refer to system memory, so the relevant No Snoop attribute would
> be in DMA transactions, i.e., Memory Reads or Writes initiated by PCIe
> Endpoints.  But it looks like this patch would affect TLPs initiated
> by the Root Complex, not those from Endpoints, so I'm confused about
> how this works.
>
> If this were in the qcom-ep driver, it would make sense that setting
> No Snoop in the TLPs initiated by the Endpoint could be a problem, but
> that doesn't seem to be what this patch is concerned with.
I think in multiprocessor system cache coherency issue might occur.
and RC as well needs to snoop cache to avoid coherency as it is not
enable by default.

and we are enabling this feature for qcom-ep driver as well.
it is in patch2.

Thanks
Mrinmay

>> And worst case, if the memory is cached on the host, it may lead to
>> memory corruption issues. It should be noted that the caching of memory
>> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
>>
>> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
>> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
>> needed for other upstream supported platforms since they do not set
>> NO_SNOOP attribute by default.
>>
>> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
>> platform. Assign enable_cache_snoop flag into struct qcom_pcie_cfg and
>> set it true in cfg_1_34_0 and enable cache snooping if this particular
>> flag is true.
> s/intruduce/introduce/
>
> Bjorn

