Return-Path: <linux-pci+bounces-2722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767048407E7
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA031C21875
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E72657C3;
	Mon, 29 Jan 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hj2zh2wY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333C657AF;
	Mon, 29 Jan 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537447; cv=none; b=p4OXla4e7tBstybes6YbY3NbHxsItqCc/jYF4BHxAkqZ3BnwG/4bKWhg0gGRl/Blnwk02NBoUX61V2Q8tDf/4Ojk+ZWvYce2zduhVVZWOqcyTt6ycOx1V+TqWHesic6DB168qIwBoVJg94E5zeYEuGsbfKBjG7tAXLympytjrTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537447; c=relaxed/simple;
	bh=cpIteSb46C7vMPSZyBEbfueXL51jR4Onxer+aqnEGgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O5OGVWdk3gpkZnlRrYt1xpHIgNDJ8hkCfyg23QTNRtk72HB81J3qu0kfNI5pNU2KDeRWbb6itI1JsdwjoJOSFLh5wRZeIu8DPy+1tnDge2+FxNadB30s8/fs8SBjmcGJjSHiAKRrBNprGpyAuZNBsSqAbj+2JXB/6gZqEMaPKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hj2zh2wY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TBccn5003188;
	Mon, 29 Jan 2024 14:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AobKpWswbqzb3U1KiN/ccc5Pg0YoZC3EQk3XnnWFgbE=; b=Hj
	2zh2wYurC8clzcltNifz9pQeuPrYPwWXNo9Vb/e/iUOIT1vo4+9+ot3o0WohSFee
	5YyzzdpfmLKkLxoFC1PBacj8d4vqj7ZMmGIE1XeINHdpO742f/JT1tJsRRFw5p8X
	5QQM9W7eyrX4CYAj6lxIQ7pyv1mscK74w0AB9xUtbYrAZfvLnb93BLzmE93rBmZg
	bIQshIq6jb6orGfjylzIxI28bZJ5nRcq1QHDG83FhN3FZE2P3sp1bYoYRAVsUkQA
	yzIGt/UAoDsg04xcAZgSnRoic141cU6xutXoFwr92hiZoCwqtMnrcycjHy1ftyz2
	4Jq4fqMTOGXprDIYMAsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvqhmv7ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 14:10:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TEAUpu026646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 14:10:30 GMT
Received: from [10.216.42.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 06:10:22 -0800
Message-ID: <8eb63c69-b769-3623-fd34-b1df959ba7b1@quicinc.com>
Date: Mon, 29 Jan 2024 19:40:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v6 3/6] PCI: qcom: Add missing icc bandwidth vote for cpu
 to PCIe path
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Johan
 Hovold" <johan+linaro@kernel.org>,
        Brian Masney <bmasney@redhat.com>,
        "Georgi
 Djakov" <djakov@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240112-opp_support-v6-0-77bbf7d0cc37@quicinc.com>
 <20240112-opp_support-v6-3-77bbf7d0cc37@quicinc.com>
 <CAA8EJprq1s42hkbXXKtXTGnyYePQN98t+gmFoHDOGMWJH4Ot3g@mail.gmail.com>
 <2bc92420-b3b9-047d-e5e4-22a19b4d07d3@quicinc.com>
 <20240117063938.GC8708@thinkpad>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240117063938.GC8708@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UMNi7JRKp41clxxn5vu224Uw6Lk23tS1
X-Proofpoint-ORIG-GUID: UMNi7JRKp41clxxn5vu224Uw6Lk23tS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290104



On 1/17/2024 12:09 PM, Manivannan Sadhasivam wrote:
> On Tue, Jan 16, 2024 at 10:27:23AM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 1/12/2024 9:00 PM, Dmitry Baryshkov wrote:
>>> On Fri, 12 Jan 2024 at 16:24, Krishna chaitanya chundru
>>> <quic_krichai@quicinc.com> wrote:
>>>>
>>>> CPU-PCIe path consits for registers PCIe BAR space, config space.
>>>> As there is less access on this path compared to pcie to mem path
>>>> add minimum vote i.e GEN1x1 bandwidth always.
>>>
>>> Is this BW amount a real requirement or just a random number? I mean,
>>> the register space in my opinion consumes much less bandwidth compared
>>> to Gen1 memory access.
>>>
>> Not register space right the BAR space and config space access from CPU
>> goes through this path only. There is no recommended value we need to
>> vote for this path. Keeping BAR space and config space we tried to vote
>> for GEN1x1.
>>
>> Please suggest any recommended value, I will change that in the next
>> series.
>>
> 
> You should ask the HW folks on the recommended value to keep the reg access
> clocking. We cannot suggest a value here.
> 
> If they say, "there is no recommended value", then ask them what would the
> minimum value and use it here.
> 
> - Mani
> 
HW team suggested to use minimum value of 1Kbps for this path.
I will update the patches to use 1Kbps in the next series.

- Krishna Chaitanya.
>> - Krishna Chaitanya.
>>>>
>>>> In suspend remove the cpu vote after register space access is done.
>>>>
>>>> Fixes: c4860af88d0c ("PCI: qcom: Add basic interconnect support")
>>>> cc: stable@vger.kernel.org
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 31 +++++++++++++++++++++++++++++--
>>>>    1 file changed, 29 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 11c80555d975..035953f0b6d8 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -240,6 +240,7 @@ struct qcom_pcie {
>>>>           struct phy *phy;
>>>>           struct gpio_desc *reset;
>>>>           struct icc_path *icc_mem;
>>>> +       struct icc_path *icc_cpu;
>>>>           const struct qcom_pcie_cfg *cfg;
>>>>           struct dentry *debugfs;
>>>>           bool suspended;
>>>> @@ -1372,6 +1373,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>>>           if (IS_ERR(pcie->icc_mem))
>>>>                   return PTR_ERR(pcie->icc_mem);
>>>>
>>>> +       pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
>>>> +       if (IS_ERR(pcie->icc_cpu))
>>>> +               return PTR_ERR(pcie->icc_cpu);
>>>>           /*
>>>>            * Some Qualcomm platforms require interconnect bandwidth constraints
>>>>            * to be set before enabling interconnect clocks.
>>>> @@ -1381,7 +1385,18 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>>>>            */
>>>>           ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>>>           if (ret) {
>>>> -               dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>>>> +               dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
>>>> +                       ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * The config space, BAR space and registers goes through cpu-pcie path.
>>>> +        * Set peak bandwidth to single-lane Gen1 for this path all the time.
>>>> +        */
>>>> +       ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>>> +       if (ret) {
>>>> +               dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
>>>>                           ret);
>>>>                   return ret;
>>>>           }
>>>> @@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>>>            */
>>>>           ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
>>>>           if (ret) {
>>>> -               dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
>>>> +               dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
>>>>                   return ret;
>>>>           }
>>>>
>>>> @@ -1597,6 +1612,12 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>>>>                   pcie->suspended = true;
>>>>           }
>>>>
>>>> +       /* Remove cpu path vote after all the register access is done */
>>>> +       ret = icc_set_bw(pcie->icc_cpu, 0, 0);
>>>> +       if (ret) {
>>>> +               dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>>           return 0;
>>>>    }
>>>>
>>>> @@ -1605,6 +1626,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>>>>           struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>>>           int ret;
>>>>
>>>> +       ret = icc_set_bw(pcie->icc_cpu, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
>>>> +       if (ret) {
>>>> +               dev_err(dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>>           if (pcie->suspended) {
>>>>                   ret = qcom_pcie_host_init(&pcie->pci->pp);
>>>>                   if (ret)
>>>>
>>>> --
>>>> 2.42.0
>>>>
>>>>
>>>
>>>
>>
> 

