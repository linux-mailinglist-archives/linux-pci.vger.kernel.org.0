Return-Path: <linux-pci+bounces-11032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0FF942576
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 06:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75E228413F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 04:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDD18AF9;
	Wed, 31 Jul 2024 04:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aAcQmm0M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFB52905;
	Wed, 31 Jul 2024 04:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400333; cv=none; b=OFRbTTZn8LpUKhxeFFNiyrvk7HZ1qw4Y+4NK4wZ83LdNsoJA0urN8A2Q4EVbIIvvL16/TZ/ksj4Vnd1TvwkqxJdbdeHaOxHCQW3iLGZdvhvV3RbZPMlnKom4XVVc1waSf8Z8GX0hfPYK9KopqQ71SsmmVtL8G0tjlmNkSbfUQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400333; c=relaxed/simple;
	bh=h44KVnerduX9inrmeDUbCf9NxZrv1J7MvZZmRpuKDzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k19aQ372bFNULzwTAk79itZMZ2rpi/Oik5khUJRw6tK4oPh407oAeWRKJbZqUKcfjgam0whCXE1GgRBQ5Fcl4Q426Jg5OaL41v2irEaIeEsIDsmoRvuL4kk8eN2PrjZy0ATvN2fNOWcOCqCAbQXLJ+nhcCXtMEJkPHqvMQbTFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aAcQmm0M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V3niD7018574;
	Wed, 31 Jul 2024 04:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eOw1SfT+lwxVj64zgTKra3HRzXSeZVXKizDkw6U7rVA=; b=aAcQmm0MxOrNe19l
	GAfj2nsvcNCd9IlwFQxg6PCOegL3HwFPM6LShVo6lF3nfHoBKhkeU9MFY7VmN6lk
	FjeHgMyvrfUsN+xBaxeJHZcrgOIPUxTymGgX/uautjVzi2WSYRUcz+ZEEXX2DkgP
	IRTJTVw+n17pVbHeW+Yf1URNwSr/1BwLeCXgzuzjmMGDSkD2I8+A6N7eiQcDcFEa
	4Lqu5nS9PBmH6TRznduyZ1UKyqzpu4fgMVqeraCB564ekWi7/cYuEUpYalAk7xV5
	uM2A7Cl/JWehjyS+lwxAHc4p49uAIfgSJzedD3fqhX5m/w2eP/UUbLUQgvvOESZh
	59dhMw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms96sy9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 04:32:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46V4W1qN014387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 04:32:01 GMT
Received: from [10.216.9.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 21:31:59 -0700
Message-ID: <ea5e7343-af67-ceeb-3448-5fd7dee495e3@quicinc.com>
Date: Wed, 31 Jul 2024 10:01:55 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>
 <98264d15-fb30-32e0-7eba-72b3a50347e0@quicinc.com>
 <20240729135547.GA35559@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240729135547.GA35559@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gQ6wWUIaVwIJw2oXYbROFUUIntJ2aJp-
X-Proofpoint-GUID: gQ6wWUIaVwIJw2oXYbROFUUIntJ2aJp-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_01,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310032



On 7/29/2024 7:25 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 29, 2024 at 05:58:31PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/29/2024 5:52 PM, Manivannan Sadhasivam wrote:
>>> Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
>>> deinit notify function pci_epc_deinit_notify() are called during the
>>> execution of qcom_pcie_perst_assert() i.e., when the host has asserted
>>> PERST#. But quickly after this step, refclk will also be disabled by the
>>> host.
>>>
>>> All of the Qcom endpoint SoCs supported as of now depend on the refclk from
>>> the host for keeping the controller operational. Due to this limitation,
>>> any access to the hardware registers in the absence of refclk will result
>>> in a whole endpoint crash. Unfortunately, most of the controller cleanups
>>> require accessing the hardware registers (like eDMA cleanup performed in
>>> dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
>>> functions are currently causing the crash in the endpoint SoC once host
>>> asserts PERST#.
>>>
>>> One way to address this issue is by generating the refclk in the endpoint
>>> itself and not depending on the host. But that is not always possible as
>>> some of the endpoint designs do require the endpoint to consume refclk from
>>> the host (as I was told by the Qcom engineers).
>>>
>>> So let's fix this crash by moving the controller cleanups to the start of
>>> the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
>>> called whenever the host has deasserted PERST# and it is guaranteed that
>>> the refclk would be active at this point. So at the start of this function,
>>> the controller cleanup can be performed. Once finished, rest of the code
>>> execution for PERST# deassert can continue as usual.
>>>
>> How about doing the cleanup as part of pme turnoff message.
>> As host waits for L23 ready from the device side. we can use that time
>> to cleanup the host before sending L23 ready.
>>
> 
> Yes, but that's only applicable if the host properly powers down the device. But
> it won't work in the case of host crash or host abrupt poweroff.
> 
> - Mani
> 
Ack.

- Krishna Chaitanya.
>> - Krishna Chaitanya.
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>    drivers/pci/controller/dwc/pcie-qcom-ep.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> index 2319ff2ae9f6..e024b4dcd76d 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>> @@ -186,6 +186,8 @@ struct qcom_pcie_ep_cfg {
>>>     * @link_status: PCIe Link status
>>>     * @global_irq: Qualcomm PCIe specific Global IRQ
>>>     * @perst_irq: PERST# IRQ
>>> + * @cleanup_pending: Cleanup is pending for the controller (because refclk is
>>> + *                   needed for cleanup)
>>>     */
>>>    struct qcom_pcie_ep {
>>>    	struct dw_pcie pci;
>>> @@ -214,6 +216,7 @@ struct qcom_pcie_ep {
>>>    	enum qcom_pcie_ep_link_status link_status;
>>>    	int global_irq;
>>>    	int perst_irq;
>>> +	bool cleanup_pending;
>>>    };
>>>    static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
>>> @@ -389,6 +392,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>>>    		return ret;
>>>    	}
>>> +	if (pcie_ep->cleanup_pending) {
>>> +		pci_epc_deinit_notify(pci->ep.epc);
>>> +		dw_pcie_ep_cleanup(&pci->ep);
>>> +		pcie_ep->cleanup_pending = false;
>>> +	}
>>> +
>>>    	/* Assert WAKE# to RC to indicate device is ready */
>>>    	gpiod_set_value_cansleep(pcie_ep->wake, 1);
>>>    	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
>>> @@ -522,10 +531,9 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>>>    {
>>>    	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
>>> -	pci_epc_deinit_notify(pci->ep.epc);
>>> -	dw_pcie_ep_cleanup(&pci->ep);
>>>    	qcom_pcie_disable_resources(pcie_ep);
>>>    	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
>>> +	pcie_ep->cleanup_pending = true;
>>>    }
>>>    /* Common DWC controller ops */
> 

