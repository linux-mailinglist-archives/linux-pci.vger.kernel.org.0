Return-Path: <linux-pci+bounces-16216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D89C01EF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 11:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D5C1F2280B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996E1EABA1;
	Thu,  7 Nov 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hQqbUVZv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FDF1E7C21;
	Thu,  7 Nov 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974226; cv=none; b=pp2z9DVzhQBY7YL93edlT/TXcqkpTJiCzh2V5T6nCt/kPW5RQf0m/Y6f0haIG7tOTxzfCFcPaVCh8b08BXirQKK0Ew0AGyPbp1g5LJv0T/jqmFSHju0kuDNastnVCwRY2BQQuxwBPfPG8yv1VA2uY+vcmlAOLFcAmslwA/QXmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974226; c=relaxed/simple;
	bh=msc86oRzL9FywZHqS0FL90gtHxzg49aOeCnhOGI+pXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KYhLR8ISUbeH/QHW+QgRM1BaTABCvn+Y8C0bR9IIox5fKl72tfQ7mrRkpTNYCkOJsD3GyoPNeV0RsjqgiBC4mtmKzKxSPvTyMUMSQtH+CtFyJaGQuxpRMU2crqePZBMz97iJus8gF+Gry9VKSyPtdAd743H0sX2keLlOapHjljY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hQqbUVZv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7A1hcf003908;
	Thu, 7 Nov 2024 10:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yKRbTpsOlrQFMGwumFxHCmnCrDbJmLnmHs587Xaf1rs=; b=hQqbUVZvt4gnRIo9
	hSf34TNlBb5VLPuKN2QUfO51sVgJA6QQ0oa5YSwBbfo7OJ/41H8NVemCEAnywAWf
	w4EUDh7JDvEaJdzawNgx/UJBLaVoR4N8wrVZr1E5D/QXg0RPVpaGCPqxi8mkbpgd
	NIv6G+W8sPn/vDSv0K4RxVe9Y6+ZKmPkD9rWyVc6WrqdgJqv0geDMmyIzNXmW2Yb
	3jCsDY7vzMhEnJghf3iCvJo+0TCZR7LInILkJJPcPhDIe5MxFtGRLfe1QB8VE6zk
	hEUqsw8rF8L2YVRb9inh/aISn5UHYlUJzXIeHbYswKnEmjAm/7BeVc8MK50Geu2b
	qpiagw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qfdx74m3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 10:09:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A7A9epm031791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:09:40 GMT
Received: from [10.216.52.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 7 Nov 2024
 02:09:36 -0800
Message-ID: <94ed3622-a46e-a593-43f1-4ed7b0eba10a@quicinc.com>
Date: Thu, 7 Nov 2024 15:39:33 +0530
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
To: Richard Zhu <hongxing.zhu@nxp.com>, <jingoohan1@gmail.com>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <frank.li@nxp.com>
CC: <imx@lists.linux.dev>, <kernel@pengutronix.de>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241107084455.3623576-1-hongxing.zhu@nxp.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20241107084455.3623576-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3sjGHSqe2sd3aWp7NgWGYs3-YIPy0BkB
X-Proofpoint-ORIG-GUID: 3sjGHSqe2sd3aWp7NgWGYs3-YIPy0BkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070078



On 11/7/2024 2:14 PM, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM stat before sending
> PME_TURN_OFF message.
> 
> Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
> Because the re-initialization would be done in dw_pcie_resume_noirq().
>
we should not remove the poll here, it is required for the endpoint
to go gracefully in to L2. Some endpoints can have some cleanups needs
to be done before entering into L2 or L3. For the PME turnoff message,
the endpoints needs to send L23 ack which indicates endpoint is
ready to L2 without that it will not be gracefull D3cold sequence.

-Krishna Chaitanya.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 20 ++++---------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f86347452026..64c49adf81d2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -917,7 +917,6 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>   int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>   {
>   	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u32 val;
>   	int ret = 0;
>   
>   	/*
> @@ -927,23 +926,12 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
> +	if (pci->pp.ops->pme_turn_off) {
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	} else {
> +		ret = dw_pcie_pme_turn_off(pci);
>   		if (ret)
>   			return ret;
> -
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret; > -		}>   	}
>   
>   	dw_pcie_stop_link(pci);

