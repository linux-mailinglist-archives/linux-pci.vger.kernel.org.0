Return-Path: <linux-pci+bounces-13704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6624598CA62
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 03:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29707283367
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0E51C2E;
	Wed,  2 Oct 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eKFMauVS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A917423CE;
	Wed,  2 Oct 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831429; cv=none; b=Y255p+D8KiAHl2gWiUKuSTLpiU/Xppn6Y0P+E9wlzxBf8fxb5jNbnpQKzbE4WcSn5RX804YgYfruZX7toilmAJqUC6ng/IYPNuXBQf4gA7/sNAHgWd+T6mKCTn1pAYEVzEzN1Xp6jpN54o3P4a/lJOnLWgPgIyU3tlDDmmLwspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831429; c=relaxed/simple;
	bh=tdtBC4eH823jJH4vb+iNz8YvRJM6x3+6nYLgNQ+l4Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EkTDLZVZEXQhEo0sHngI8DiaMfKMLxK3yzJNLORlpWoRjK0/pjl70HeUzuScpKNR0V843i7XzsGU8ZA02h4K7Pw1bdNPufF7xM51RxUe4TZ/hMcllmTwoitAojeeuqMizanvnIW3kRPsARkMYGFVkdNZYEJzVdS1C9th0tWZc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eKFMauVS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491N6kHC010163;
	Wed, 2 Oct 2024 01:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIvvku1ejh0YucQTjyVnCCSyOsahvKP6xOzrL1mcUAk=; b=eKFMauVSDZwr6Cob
	vEojSw2TZhniG+x84nxsq1iEELo5l1Sy8QqH/dZJ3wYaiTsY9l1HvNTvDOQOFQu2
	gF7WSSsWwP/0aUPD2xC2uDz6Yub6uQ/64bdrnUnoVbZUg0chfnrA1wRXBGCqUslU
	nxxMBW8YnF3cCVqjdoCX19pIxdfdxMqhQAHYZpqyIar5CTfzS8kh1LQeQGJ4sBsS
	hLqjj1Tgq8fX3Xq/iRcbH7c9WvjMJAXiyWqdAbBJOpXohmal1nHH9g7Ql91IVa4a
	BnKvdzfRu1FERI74YRci/3y4jEDBjvf4eNM/JkREOV8Bok/sJCmolo+pUdqhjMT0
	EeWfPQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x7geaejk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Oct 2024 01:10:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4921AILq026868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 2 Oct 2024 01:10:18 GMT
Received: from [10.253.11.231] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 18:10:16 -0700
Message-ID: <4a4860d0-3ec9-438f-b984-c9987743076f@quicinc.com>
Date: Wed, 2 Oct 2024 09:10:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Enable MSI interrupts together with Link up if
 global IRQ is supported
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>
CC: <robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Konrad
 Dybcio <konradybcio@kernel.org>
References: <20240930134409.168494-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240930134409.168494-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JcxjokOBwxeNBTras8nvHCYQvGQEq0FK
X-Proofpoint-GUID: JcxjokOBwxeNBTras8nvHCYQvGQEq0FK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=874 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410020007


On 9/30/2024 9:44 PM, Manivannan Sadhasivam wrote:
> Currently, if global IRQ is supported by the platform, only the Link up
> interrupt is enabled in the PARF_INT_ALL_MASK register. But on some Qcom
> platforms like SM8250, and X1E80100, MSIs are getting masked due to this.
> They require enabling the MSI interrupt bits in the register to unmask
> (enable) the MSIs.
>
> Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
> described as 'diagnostic' interrupts in the internal documentation,
> disabling them masks MSI on these platforms. Due to this, MSIs were not
> reported to be received these platforms while supporting global IRQ.
>
> So enable the MSI interrupts along with the Link up interrupt in the
> PARF_INT_ALL_MASK register if global IRQ is supported. This ensures that
> the MSIs continue to work and also the driver is able to catch the Link
> up interrupt for enumerating endpoint devices.
>
> Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Qiang Yu <quic_qianyu@quicinc.com>

Thanks,
Qiang
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..2b33d03ed054 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -133,6 +133,7 @@
>   
>   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
>   #define PARF_INT_ALL_LINK_UP			BIT(13)
> +#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
>   
>   /* PARF_NO_SNOOP_OVERIDE register fields */
>   #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> @@ -1716,7 +1717,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   			goto err_host_deinit;
>   		}
>   
> -		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
> +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> +			       pcie->parf + PARF_INT_ALL_MASK);
>   	}
>   
>   	qcom_pcie_icc_opp_update(pcie);

