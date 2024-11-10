Return-Path: <linux-pci+bounces-16377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC369C3024
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 01:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86341F2181E
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F4E4A32;
	Sun, 10 Nov 2024 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pHjQfAnI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397D139B;
	Sun, 10 Nov 2024 00:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731197757; cv=none; b=YDdNLwVj6a3O2lqOefQuYeUEtXPWeCWd2XKChNt0818mUZG9Pe8VazWqhYTBovNOnlop9I2uECVvFU3XNYFW3AzpEmyXryGJuhC8yznIAwdHsCJXfgIFRAazwCGFFXnxr3o17Aq9Edlnm6vRepIvUZ6UqbNmjVwCAlJA/dmsN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731197757; c=relaxed/simple;
	bh=Rb8SiGYOX43++2/BqPnrgCCSzHRP+Qz05NJ1JzZ5Ukc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KpFFAlP/Q69TbqDxpQ6ZNlXxs8+FAJO68J2c40ue0yxephSkswYKNfPoBQI/9ux2MbZ4Tu93Ps/1g9hQNtA0YNk0pHibrYJmhyom4ZQTvDyzN0C5QExTfLEbXDrHQjqAwT03AqXBFN00XsB+7bHgfWyivpUzmQ8GCd0GRs35aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pHjQfAnI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA00vxk008738;
	Sun, 10 Nov 2024 00:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0R1LwNN6Jg7sQ4eONRG8zvoQUl0N1Po3ICzKDF5OXQ0=; b=pHjQfAnISj7pMSDN
	YRQulXbAkn0/XdFn2S/pg1QKQ7IY0MrH/0JEFqmfnZgziydnmec984q1ZRntkgFB
	snGNzaVtHbXsEDrUemcMuX5tgQwLXtpYlYbODGcpIZctpTGShLpOsKd06Zuxhr8J
	+Zj8jriiN/Y+e73wPhDNV9dLT3vB7T6GQ/jD0aDXkQxzR+3bXTeit1hFA7VEo4wM
	0Akz/WMZcVgJa0wU/0F1L2uTrOz22q3bTMOlxNovWR/6dHfzksPyB2VoQq+KGATH
	ItaZ9t5m5x/My7cZKM5lzGaifW7suVdQOItGhnT67UbYBNyl2EJ19FegTXrd+1IG
	0Ai+uQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t118188v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 00:10:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AA0AHMr015043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 00:10:17 GMT
Received: from [10.216.56.133] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 9 Nov 2024
 16:10:13 -0800
Message-ID: <b5f56ec9-9b5f-5369-52ed-bcf0c8012dbb@quicinc.com>
Date: Sun, 10 Nov 2024 05:40:08 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: Richard Zhu <hongxing.zhu@nxp.com>, <jingoohan1@gmail.com>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <frank.li@nxp.com>, <imx@lists.linux.dev>,
        <kernel@pengutronix.de>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241108002425.GA1631063@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241108002425.GA1631063@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cv0K1P0V45jW6BqOaeNPerbxNVQSxtJ6
X-Proofpoint-GUID: cv0K1P0V45jW6BqOaeNPerbxNVQSxtJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411090210



On 11/8/2024 5:54 AM, Bjorn Helgaas wrote:
> On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
>> On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
>>> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
>>> safe to send PME_TURN_OFF message regardless of whether the link
>>> is up or down. So, there would be no need to test the LTSSM stat
>>> before sending PME_TURN_OFF message.
>>
>> What is the incentive to send PME_Turn_Off when link is not up?
> 
> There's no need to send PME_Turn_Off when link is not up.
> 
> But a link-up check is inherently racy because the link may go down
> between the check and the PME_Turn_Off.  Since it's impossible for
> software to guarantee the link is up, the Root Port should be able to
> tolerate attempts to send PME_Turn_Off when the link is down.
> 
> So IMO there's no need to check whether the link is up, and checking
> gives the misleading impression that "we know the link is up and
> therefore sending PME_Turn_Off is safe."
> 
Hi Bjorn,

I agree that link-up check is racy but once link is up and link has
gone down due to some reason the ltssm state will not move detect quiet
or detect act, it will go to pre detect quiet (i.e value 0f 0x5).
we can assume if the link is up LTSSM state will greater than detect act
even if the link was down.

- Krishna Chaitanya.
>>> Remove the L2 poll too, after the PME_TURN_OFF message is sent
>>> out.  Because the re-initialization would be done in
>>> dw_pcie_resume_noirq().
>>
>> As Krishna explained, host needs to wait until the endpoint acks the
>> message (just to give it some time to do cleanups). Then only the
>> host can initiate D3Cold. It matters when the device supports L2.
> 
> The important thing here is to be clear about the *reason* to poll for
> L2 and the *event* that must wait for L2.
> 
> I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
> waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
> for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
> 5.2, fig 5-1).
> 
> L2 and L3 are states where main power to the downstream component is
> off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
> no link in those states.
> 
> The PME_Turn_Off handshake is part of the process to put the
> downstream component in D3cold.  I think the reason for this handshake
> is to allow an orderly shutdown of that component before main power is
> removed.
> 
> When the downstream component receives PME_Turn_Off, it will stop
> scheduling new TLPs, but it may already have TLPs scheduled but not
> yet sent.  If power were removed immediately, they would be lost.  My
> understanding is that the link will not enter L2/L3 Ready until the
> components on both ends have completed whatever needs to be done with
> those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
> PCIe book; I haven't found clear spec citations for all of it.)
> 
> I think waiting for L2/L3 Ready is to keep us from turning off main
> power when the components are still trying to dispose of those TLPs.
> 
> So I think every controller that turns off main power needs to wait
> for L2/L3 Ready.
> 
> There's also a requirement that software wait at least 100 ns after
> L2/L3 Ready before turning off refclock and main power (sec
> 5.3.3.2.1).
> 
> Bjorn
> 

