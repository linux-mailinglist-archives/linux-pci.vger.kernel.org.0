Return-Path: <linux-pci+bounces-12258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6DC96027E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 08:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9761B21A57
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 06:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D80D154452;
	Tue, 27 Aug 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YpeLoDgW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACD3A1C4;
	Tue, 27 Aug 2024 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741541; cv=none; b=fB7g0zVdgYdUhfh2TO2bjFr/2nRmzcQ4qFsrNjquUAUYJKOAd7MWehJxgmreSipypFhc/fkp6M+htrRfhznu0NUMg0sJzzgkNsTdm5SCFZMYa+WnwKJfbq01oncuMV7q/KuWtgzfMpkpFtqbA+mxDRNxckD1VtVfzaf9OW5+Qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741541; c=relaxed/simple;
	bh=zRly3KYX6kc4bx/O3lSkmmF80MxFntB5Kc/Tg5R1emM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y44QdpqeEBu6cA8AQIXVTuoNebsINsmW5IiLdqJrFMiA1cPEtXfJU7CRo2wAljFLuDkT6EIR33h9Cac3IgEqmlOamO8nPxgRAE/CprxqxSNA3FzSyBrOBSTsMFi4i7Dg8XOhKkutbbyh8DMl+iTMhh1MUJ2PcYrzLD6xhOQK7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YpeLoDgW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R6gsgZ025889;
	Tue, 27 Aug 2024 06:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qH99Ppugc09b9ggJmb2hMn6JmwiBCCwPmQ/4GpxjvyE=; b=YpeLoDgWq7wN6f9c
	T+mV0/+qsLwjcaGNK4I705UUimLx4qOud5GoyMj3rtOzeV8WJAhSuXxMyn8De/S+
	dvlo3NOXVbQ5n1T5bvm2yYQwIEWJGsKuEd/DcHL5oulBlpcNa6SkHwwKb8vqCl9B
	08JDPFba9ieev1iCLnr05CpP+UFfh7LpKGnWao9uXiANXWaTeHSWaJ4aqZWUbxHj
	BTgq3lhbLkoI+D36NfTmqf5ISJYlSxomTxgAzTXseN7qC/aOYLhsraMkfoRISB0j
	rLPf5NvQ465Mj5xjuL14xO0Hn3WyGWv4+v/2zmqeQhic0UPFzxquSdyLTUH8sI01
	vfdJVA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4199s880q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:52:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R6q47D022130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 06:52:04 GMT
Received: from [10.50.9.183] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 Aug
 2024 23:51:56 -0700
Message-ID: <20d38311-ce10-4d4e-996b-24f79c051f69@quicinc.com>
Date: Tue, 27 Aug 2024 12:21:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/6] phy: qcom: Introduce PCIe UNIPHY 28LP driver
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
 <20240827045757.1101194-4-quic_srichara@quicinc.com>
 <svraqyrvmyfvezj6zuzsoc5cy3lqklwxkmjdloquj2v4r5ik72@xnbaoigiikeu>
Content-Language: en-US
From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <svraqyrvmyfvezj6zuzsoc5cy3lqklwxkmjdloquj2v4r5ik72@xnbaoigiikeu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DO3zQ6_OdhKrrDFWrEU9781YgY0wg5b0
X-Proofpoint-GUID: DO3zQ6_OdhKrrDFWrEU9781YgY0wg5b0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_04,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=776 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408270050



On 8/27/2024 11:55 AM, Krzysztof Kozlowski wrote:
> On Tue, Aug 27, 2024 at 10:27:54AM +0530, Sricharan R wrote:
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Add Qualcomm PCIe UNIPHY 28LP driver support present
>> in Qualcomm IPQ5018 SoC and the phy init sequence.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> ...
> 
>> +static int qcom_uniphy_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct qcom_uniphy_pcie *phy;
>> +	int ret;
>> +	struct phy *generic_phy;
>> +	struct phy_provider *phy_provider;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = of_node_get(dev->of_node);
>> +
>> +	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, phy);
>> +	phy->dev = &pdev->dev;
>> +
>> +	phy->data = of_device_get_match_data(dev);
>> +	if (!phy->data)
>> +		return -EINVAL;
>> +
>> +	ret = qcom_uniphy_pcie_get_resources(pdev, phy);
>> +	if (ret < 0)
>> +		dev_err_probe(&pdev->dev, ret, "Failed to get resources:\n");
> 
> What the hell happened here? Read my review one more time and then git
> grep for usage of dev_err_probe.
> 
  Ho ok, understood, missed it, will fix and resend.

Regards,
   Sricharan

> NAK.
> 
> Best regards,
> Krzysztof
> 
> 

