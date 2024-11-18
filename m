Return-Path: <linux-pci+bounces-17027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB09D09EA
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 07:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C6AB212E5
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52714B976;
	Mon, 18 Nov 2024 06:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lJ7aCb0G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E4C14A60A;
	Mon, 18 Nov 2024 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731913049; cv=none; b=u/VHxi4IuaZ6BZifuMaPMNpVEtQh3KjAEtnZVv+0DyqTZXQG9Gz3YUHVLkrJqRxdhzflv1lEGU5Kd5OIGpXqXrf2grjboJ4T+gm34zl4INn2u7CWM9a0wMVa299IjfJycP1OERdKpLmuVewRuyzwgEX+hgwE0uKJJ+B2x4gDJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731913049; c=relaxed/simple;
	bh=CTrzTU4OD3fv4pym3PXF4HLdOcQLSqsGuZ/5aGmhI4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tJy6o6ymdiw2Ak0EnLdMqTz74BLoDDxR00BjPAem3OWggYXBwqQE/EJYDXJHe7cNk0+EazXOCrO5vfL7rir7R1E5+ezQPBubX2YdHhG0Ji/pFx7dqKktppACdfaEM2fZDV+7Ab53y917FouViChrlWDj4YOwEDImvjGBLQdHjp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lJ7aCb0G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI5ReGQ020080;
	Mon, 18 Nov 2024 06:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z1JnNDDztqYMt7D8JQnIhD21/IbCa7x8Z8oDqLkCoxE=; b=lJ7aCb0GGAIIPbAc
	X/dxfPuiIcHXm+hSyW5EFNVvmfvvQwBsMe4sirFzDqr8fCc1to3LYMhoCj+AxpOF
	xP8JeXEoXxubjBf42QND7v4ps7R3zqHimH6cd1SlzcwAk3g3Q2zHOlVAPM7Babxc
	wFE9gcvoR+/5pO2Gep+M4m9S7+fJOWlAQ1hA/Sk0/AiiN3j0YFL7e565hkf8EJ2f
	eMXn6cqYnuvdHS9knjzc/CYTMMXqcRt+1oajr7GxLeCutzX+RWYqWOQwtZAEsmcp
	Du7rnMtOTDzbwcFtM1EvuzyyUSaMdSFPHJzMWAwF225waHFrapxsR3uScultzI0Z
	1hwxpw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xksqkpgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 06:57:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AI6v8kV020799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 06:57:08 GMT
Received: from [10.216.4.59] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 17 Nov
 2024 22:57:05 -0800
Message-ID: <118e87ef-3852-8c07-7de7-d97e885cfdd6@quicinc.com>
Date: Mon, 18 Nov 2024 12:27:01 +0530
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
To: Richard Zhu <hongxing.zhu@nxp.com>, <jingoohan1@gmail.com>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <frank.li@nxp.com>
CC: <imx@lists.linux.dev>, <kernel@pengutronix.de>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: w0y_Gew9iuOQrc_BiIhHt2TSv_mk9b_1
X-Proofpoint-ORIG-GUID: w0y_Gew9iuOQrc_BiIhHt2TSv_mk9b_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180057



On 11/18/2024 11:14 AM, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM state before sending
> PME_TURN_OFF message.
> 
> Only print the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't an error message when no endpoint is
> connected at all.
> 
> Also, when the endpoint is connected and PME_TURN_OFF is sent, do not return
> error if the link doesn't enter L2. Just print a warning and continue with the
> suspend as the link will be recovered in dw_pcie_resume_noirq().
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
> v3 changes:
> - Refine the commit message refer to Manivannan's comments.
> - Regarding Frank's comments, avoid 10ms wait when no link up.
> v2 changes:
> - Don't remove L2 poll check.
> - Add one 1us delay after L2 entry.
> - No error return when L2 entry is timeout
> - Don't print message when no link up.
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 40 ++++++++++---------
>   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>   2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 24e89b66b772..68fbc16199e8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -927,24 +927,28 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>   		return 0;
>   
> -	/* Only send out PME_TURN_OFF when PCIE link is up */
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> -		if (pci->pp.ops->pme_turn_off)
> -			pci->pp.ops->pme_turn_off(&pci->pp);
> -		else
> -			ret = dw_pcie_pme_turn_off(pci);
> -
> -		if (ret)
> -			return ret;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
> +	if (ret)
> +		return ret;
>   
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret;
> -		}
> -	}
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +				val == DW_PCIE_LTSSM_L2_IDLE ||
> +				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))
> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
we need to return ret here in case we fail to enter L2 when the endpoint 
is connected.

- Krishna Chaitanya.
> +	else
> +		/*
> +		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +		 * 100ns after L2/L3 Ready before turning off refclock and
> +		 * main power. It's harmless too when no endpoint connected.
> +		 */
> +		udelay(1);
>   
>   	dw_pcie_stop_link(pci);
>   	if (pci->pp.ops->deinit)
> @@ -952,7 +956,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   
>   	pci->suspended = true;
>   
> -	return ret;
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>   
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..bf036e66717e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
>   	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>   	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>   	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
>   	DW_PCIE_LTSSM_L0 = 0x11,
>   	DW_PCIE_LTSSM_L2_IDLE = 0x15,
>   

