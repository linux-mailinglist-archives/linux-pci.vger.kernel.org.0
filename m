Return-Path: <linux-pci+bounces-10946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D193F4DF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531261C21D7A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767D146A9B;
	Mon, 29 Jul 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQAOB/ix"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB43F146A7A;
	Mon, 29 Jul 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254961; cv=none; b=Y0ezKhdBSP7dKjDoxWcgndIEOOgbFsRwlVcuE9BcvfcREJONkMo6ZdHFtTbsEPiqFXNFD8sV9LE/j/dPL+7LOH8GtFMpsyIJScL0/UFKv7udSLZjfFp3+2hXK+rW5e0IYRRhxgyx+Gma8cONk2ZJztogaF5GEUnuWYIYA7sDxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254961; c=relaxed/simple;
	bh=LoVudDo8zgjRoSSoWDd0Q66VlmVsXWeKDSdQXYU7Ogg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=caP9mal7Aazjod2QitJUuOjTZZNO0tRyjHcBQCd4hVymFZmIWjbw+dD/fmMFinruAemO2V+V5TESG9BDzcfIhpx6Wg/ju+V8kVPvJ0bvq2cS2tiywWIkcHKQbsDdaerGm9z/m0CBalBzhAGjGnX0MMEo0Mo2lJUzaoSzi2pEF20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQAOB/ix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAENev017247;
	Mon, 29 Jul 2024 12:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+LtnkQYKPqwyNkDNQjheET71CL/67jvh+i4upFihUAA=; b=LQAOB/ixPAU9XJMN
	6YVsjx+lV9Vh8dPv7QPlYaNizUHtae7AZkH+ylpXIOF8mM4bgNKixjBbB4rzUx2a
	lYBcqLBrxIalc0BGUWNMQ6gKcrLXiB9OQNIMvWA8CWw2s/Hip+YP31DyBfCNj6Si
	8cCecchz3qYiF3LbizHzUAOx/M+slflNlonSfdkYwP0XDbEHvs9nBJiX8VJ4wWva
	srYpuxPtA0VJdoNsZJ0amRAW/NNWz/CBicCbBx3HWmCNf7aaByg2O50CpflM5474
	rWg4ARTgp6QWA8lnBdixGCDalcd1zM/libVfztOQ4l1XIFm83uPZ+rnRaRnXEFgT
	EjKY8g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrytv793-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:09:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TC8wes004776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:08:58 GMT
Received: from [10.216.48.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 05:08:52 -0700
Message-ID: <593b2c5e-0add-b6eb-5f2e-bbc832a1b0f2@quicinc.com>
Date: Mon, 29 Jul 2024 17:38:49 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 2/4] PCI: qcom-ep: Add support for D-state change
 notification
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>, Manivannan Sadhasivam
	<mani@kernel.org>
References: <20240711184842.GA285502@bhelgaas>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240711184842.GA285502@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BOVJUMJcVrPtEzQ8uQoLJrOhfrjJo6Of
X-Proofpoint-GUID: BOVJUMJcVrPtEzQ8uQoLJrOhfrjJo6Of
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290081



On 7/12/2024 12:18 AM, Bjorn Helgaas wrote:
> On Thu, Jul 11, 2024 at 11:57:35AM +0530, Krishna Chaitanya Chundru wrote:
>> On 7/10/2024 5:41 PM, Bjorn Helgaas wrote:
>>> On Wed, Jul 10, 2024 at 04:38:15PM +0530, Krishna chaitanya chundru wrote:
>>>> Add support to pass D-state change notification to Endpoint
>>>> function driver.
>> ...
> 
>>> I don't understand the connection between PERST# state and the device
>>> D state.  D3cold is defined to mean main power is absent.  Is the
>>> endpoint firmware still running when main power is absent?
>>
>> Host as part of its d3cold sequence will assert the perst. so we are
>> reading perst to know the link the state.
> 
> I think it's true that when the device is in D3cold, PERST# will be
> asserted (PCIe CEM r5.0, sec 2.2.3, fig 2-6).
> 
> But I don't think it's necessarily true that when PERST# is asserted,
> the device is in D3cold.  For example, PCIe Mini CEM r2.1, sec
> 3.2.5.3, says "The system may also use PERST# to cause a warm reset of
> the add-in card."  In a warm reset, the component remains powered up,
> i.e., it is not in D3cold (PCIe r6.0, sec 6.6.1).
> 
> I would think the endpoint firmware would be able to directly read the
> state of main power or the LTSSM state of the link, without having to
> use PERST# to infer it.
>
Ack, we will use LTSSM state to know the link state.

> I guess the ultimate point of figuring out D3hot vs D3cold is to
> figure out whether to use PME or WAKE#?  I'm a little bit dubious
> about that being racy, as I mentioned elsewhere.  If there were a way
> to attempt PME and fall back to WAKE# if you can determine that PME
> failed, maybe that would be safer and obviate the need for the D-state
> tracking?
> 
We don't have a way to know that PME is received by the host.

We can add logic to send pme in d3hot and wait for sometime for the
state to move to D0. if it doesn't move to D0 for that period, the we
can check the LTSSM state to see if it in D3cold(L2/L3) then we can use
WAKE# else return with failure.

- Krishna Chaitanya.
>> Qcom devices are drawing power from the PCIe, so even when PCIe is in
>> D3cold endpoint firmware can still run.
>>
>> - Krishna Chaitanya.
>>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>>> index 236229f66c80..817fad805c51 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>>>> @@ -648,6 +648,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>>>    	struct device *dev = pci->dev;
>>>>    	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
>>>>    	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
>>>> +	pci_power_t state;
>>>>    	u32 dstate, val;
>>>>    	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
>>>> @@ -671,11 +672,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>>>    		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>>>>    					   DBI_CON_STATUS_POWER_STATE_MASK;
>>>>    		dev_dbg(dev, "Received D%d state event\n", dstate);
>>>> -		if (dstate == 3) {
>>>> +		state = dstate;
>>>> +		if (dstate == PCI_D3hot) {
>>>>    			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>>>>    			val |= PARF_PM_CTRL_REQ_EXIT_L1;
>>>>    			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
>>>> +
>>>> +			if (gpiod_get_value(pcie_ep->reset))
>>>> +				state = PCI_D3cold;
>>>>    		}
>>>> +		pci_epc_dstate_notify(pci->ep.epc, state);
>>>>    	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>>>>    		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>>>>    		dw_pcie_ep_linkup(&pci->ep);
>>>>
>>>> -- 
>>>> 2.42.0
>>>>

