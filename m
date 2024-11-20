Return-Path: <linux-pci+bounces-17111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30279D3E74
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 16:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63021285315
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95CE1BD509;
	Wed, 20 Nov 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bpyIR0Ng"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B071714CD;
	Wed, 20 Nov 2024 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114528; cv=none; b=CxLh2uRlbHJDc0yjbuMS1ibUOasF5zPyTGO2ip3Hcr0mYNZjSqlNoqSuTiELQw0pE07jmcJGzd/RZvBY+k85nxJB/vB9VA9xbLQPQgu3Vfg+QuDwahkU1AMc4bp0JKPzm0C75h7OpYwCdBm5WUYM08NshIWVah6UUdMx9SGiuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114528; c=relaxed/simple;
	bh=DycnefkIl3vmED20SiUj4Da2wruBCyCSjcCyItlN4KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bWwT9Ku8KW/Y/HU0xjjr26hlQzmvU7/UQRBlj4k4anMhLzN2TJHTW5k9XOHnBGu+ngRmHmmZBtRrwiF/olXVJY7lQDS6Sin8d2o5w4H21KNo8DUX8K7k+qK/0na8abT7tmm6lOazyDB4yNrYDIBXG3j8xIXhhNVXPfLzKsEukY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bpyIR0Ng; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK9FIXg019239;
	Wed, 20 Nov 2024 14:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7c+Gc2YJ0ZXrfOntRroLVvAoJrbU+KPCNzU9bfv1j50=; b=bpyIR0NgQ/rDQtXm
	jSzoLktWNao1xlBGLuUIacp9W4Wdekz3EbWSRFW6XmwsNCOrbCjENgfzYFAQykZW
	+ekhPVni+OYCheSwAlT0+ltWHCvtn4aHQJOtXEZKwbfFZvSriqXF2qLtIyZl/YL7
	it5AFajAGr/TZCbT+IhnyPTKRoIsN0U9URE9DbQc4WEZRluCF53zYm9AWLDPfY1m
	t9+oVoAGquNiW28wi4uGgXaIcYBnR7K7Wl0yWKLc/vHNTzwpsUmJLkJihF/JrJXr
	Fj5yAh8JZnfeoMUkuRDNsLeox4XlqkQIYCXGCio56RtQkY+rf8d+SNGl/Xla+tD8
	QHG6zw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431c7hh0ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:55:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AKEtAsf008053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 14:55:10 GMT
Received: from [10.216.30.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 06:55:06 -0800
Message-ID: <acff673f-3c6c-36c8-516a-1476b9a8fb60@quicinc.com>
Date: Wed, 20 Nov 2024 20:24:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Content-Language: en-US
To: Hongxing Zhu <hongxing.zhu@nxp.com>,
        "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de"
	<kernel@pengutronix.de>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
 <118e87ef-3852-8c07-7de7-d97e885cfdd6@quicinc.com>
 <AS8PR04MB867619836B0F30C2663AB9418C202@AS8PR04MB8676.eurprd04.prod.outlook.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <AS8PR04MB867619836B0F30C2663AB9418C202@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vwkeWJAgPs8ML3y7whbOoi8X1x4L3AZz
X-Proofpoint-GUID: vwkeWJAgPs8ML3y7whbOoi8X1x4L3AZz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200099



On 11/19/2024 2:18 PM, Hongxing Zhu wrote:
>> -----Original Message-----
>> From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
>> Sent: 2024年11月18日 14:57
>> To: Hongxing Zhu <hongxing.zhu@nxp.com>; jingoohan1@gmail.com;
>> bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
>> manivannan.sadhasivam@linaro.org; robh@kernel.org; Frank Li
>> <frank.li@nxp.com>
>> Cc: imx@lists.linux.dev; kernel@pengutronix.de; linux-pci@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in
>> dw_pcie_suspend_noirq()
>>
>>
>>
>> On 11/18/2024 11:14 AM, Richard Zhu wrote:
>>> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's
>>> safe to send PME_TURN_OFF message regardless of whether the link is up
>>> or down. So, there would be no need to test the LTSSM state before
>>> sending PME_TURN_OFF message.
>>>
>>> Only print the message when ltssm_stat is not in DETECT and POLL.
>>> In the other words, there isn't an error message when no endpoint is
>>> connected at all.
>>>
>>> Also, when the endpoint is connected and PME_TURN_OFF is sent, do not
>>> return error if the link doesn't enter L2. Just print a warning and
>>> continue with the suspend as the link will be recovered in
>> dw_pcie_resume_noirq().
>>>
>>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
>>> ---
>>> v3 changes:
>>> - Refine the commit message refer to Manivannan's comments.
>>> - Regarding Frank's comments, avoid 10ms wait when no link up.
>>> v2 changes:
>>> - Don't remove L2 poll check.
>>> - Add one 1us delay after L2 entry.
>>> - No error return when L2 entry is timeout
>>> - Don't print message when no link up.
>>> ---
>>>    .../pci/controller/dwc/pcie-designware-host.c | 40 ++++++++++---------
>>>    drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>>>    2 files changed, 23 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 24e89b66b772..68fbc16199e8 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -927,24 +927,28 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>>>    	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) &
>> PCI_EXP_LNKCTL_ASPM_L1)
>>>    		return 0;
>>>
>>> -	/* Only send out PME_TURN_OFF when PCIE link is up */
>>> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
>>> -		if (pci->pp.ops->pme_turn_off)
>>> -			pci->pp.ops->pme_turn_off(&pci->pp);
>>> -		else
>>> -			ret = dw_pcie_pme_turn_off(pci);
>>> -
>>> -		if (ret)
>>> -			return ret;
>>> +	if (pci->pp.ops->pme_turn_off)
>>> +		pci->pp.ops->pme_turn_off(&pci->pp);
>>> +	else
>>> +		ret = dw_pcie_pme_turn_off(pci);
>>> +	if (ret)
>>> +		return ret;
>>>
>>> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val ==
>> DW_PCIE_LTSSM_L2_IDLE,
>>> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
>>> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
>>> -		if (ret) {
>>> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM:
>> 0x%x\n", val);
>>> -			return ret;
>>> -		}
>>> -	}
>>> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
>>> +				val == DW_PCIE_LTSSM_L2_IDLE ||
>>> +				val <= DW_PCIE_LTSSM_DETECT_WAIT,
>>> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
>>> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
>>> +	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))
>>> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
>>> +		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n",
>>> +val);
>> we need to return ret here in case we fail to enter L2 when the endpoint is
>> connected.
>>
> Hi Krishna:
> I used encounter the following error, when some NVME devices are used.
> For example, the "Sandisk SN720 256G NVME SSD disk".
> "imx6q-pcie 4c300000.pcie: Timeout waiting for L2 entry! LTSSM: 0x19"
> LTSSM:0x19 means S_DISABLED. Is this an error actually or something else?
> BTW, without the error return. The NVME disk can be functional again after
>   resume back. Otherwise, system is hang in suspend.
> To my knowledge I know two cases which might have happen here.

LTSSM state can also enter disabled state if the disable bit in the link
control register is set but I don't think that is the case here.

Other case might be if DPC is enabled and hardware detects any error in
the link can you check if DPC is enabled. IF it is enabled you can try
if disabling helps here or not.

- Krishna Chaitanya.
> Logs with error return when LTSSM is 0x19(v4 patch).
> rtcwakeup.out: wakeup from "mem" using rtc0 at Fri Jan  2 00:01:02 1970
> [   31.014728] PM: suspend entry (deep)
> ...
> [   31.636729] imx6q-pcie 4c300000.pcie: Timeout waiting for L2 entry! LTSSM: 0x19
> [   31.644191] imx6q-pcie 4c300000.pcie: PM: dpm_run_callback(): genpd_suspend_noirq returns -110
> [   31.652936] imx6q-pcie 4c300000.pcie: PM: failed to suspend noirq: error -110
> 
> Logs without error return when LTSSM is 0x19(this v3 patch).
> rtcwakeup.out: wakeup from "mem" using rtc0 at Fri Jan  2 00:01:02 1970
> [   31.079868] PM: suspend entry (deep)
> ...
> [   31.732253] imx6q-pcie 4c300000.pcie: Timeout waiting for L2 entry! LTSSM: 0x19
> [   31.758051] Disabling non-boot CPUs ...
> ...
> [   31.799148] psci: CPU1 killed (polled 4 ms)
> [   31.806229] Enabling non-boot CPUs ...
> [   31.810690] Detected VIPT I-cache on CPU1
> [   31.810766] GICv3: CPU1: found redistributor 100 region 0:0x0000000048080000
> [   31.810844] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
> [   31.812365] CPU1 is up
> ...
> 
> Best Regards
> Richard Zhu
>   
>> - Krishna Chaitanya.
>>> +	else
>>> +		/*
>>> +		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
>>> +		 * 100ns after L2/L3 Ready before turning off refclock and
>>> +		 * main power. It's harmless too when no endpoint connected.
>>> +		 */
>>> +		udelay(1);
>>>
>>>    	dw_pcie_stop_link(pci);
>>>    	if (pci->pp.ops->deinit)
>>> @@ -952,7 +956,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>>>
>>>    	pci->suspended = true;
>>>
>>> -	return ret;
>>> +	return 0;
>>>    }
>>>    EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
>>> b/drivers/pci/controller/dwc/pcie-designware.h
>>> index 347ab74ac35a..bf036e66717e 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
>>>    	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>>>    	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>>>    	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
>>> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
>>>    	DW_PCIE_LTSSM_L0 = 0x11,
>>>    	DW_PCIE_LTSSM_L2_IDLE = 0x15,
>>>

