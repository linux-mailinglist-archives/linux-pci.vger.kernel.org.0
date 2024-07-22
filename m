Return-Path: <linux-pci+bounces-10622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0968F9395AE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 23:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B74B21506
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 21:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8123A1BA;
	Mon, 22 Jul 2024 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CWXMh9YC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B31849;
	Mon, 22 Jul 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684836; cv=none; b=cez0J0T3/G/eoo5bZ+onyiiPcuNnyg1MnvccxGfO3gwKlCrT9oXYwgNp2OjF1y5e2Ah99NVSp8B/W4nwo7C9Q4Iot/Ln1m6lcReysIan9N9oLKHEYBvx/0mpRwDMKpe17WPczhKhY35QS0Ob6bpvJLrkrngIzFEe1jkJjfhJ8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684836; c=relaxed/simple;
	bh=JR+SY+2nPNlWy8HptYjfhNO/uli1R6DEjcPvFVCbSeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YIcFnlypRJLxe+lLetv9t3ZUMEyTFmblJDaI3BM4LJT2bUo0MmsOTo9aHRp1A3BnwsoSSxnJjFYSrI1CCojLUr/VANQedoyoQC8fFa6kKgX0M50rEHWGVoe2Jk+kbDw9yMM8f/rpehWT6cBLb8sO7sO0Z/ZptFz9Y+F4JrWFUY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CWXMh9YC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MJNjZ7014036;
	Mon, 22 Jul 2024 21:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qs/JP/ZIxvYyiw9RdROCi9EzriMnBVyMayND9ThSpWU=; b=CWXMh9YCViqFve5l
	MUehGau6ajxT/Vs3d1pPBmWd6Cc8fSTSylOIEYUeGyqbP358ivXhsahexCe7Zd2r
	+HG/IeTjvvTZ0GsbG3CUaeuOC+QuiQys5o018j+OUwJfjn2XnUZT4AF2I8o820j1
	6Rwhc4dk6R2M49/NMf9nEN26ZWuHHcETFF2EyMbqDqxzCrZb9iQIG5fTtsHhD13B
	z6kfsE7YL0ZmoUkLBnVuEij6Z+qCZRoBX5j4SnMXI66q/cT/Kkb7Fpvnvm9caa5w
	nLxtrSc+opT+5jIr0cv8SU7LytBSbyWQcoGD+0c04qS3N0jtGHJ8S3+rl2fbQzNL
	nWF/tg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m6vynr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 21:47:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46MLl4at006331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jul 2024 21:47:04 GMT
Received: from [10.110.63.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Jul
 2024 14:47:03 -0700
Message-ID: <3c740b28-cb14-4d5d-ba0f-d8c658380ef7@quicinc.com>
Date: Mon, 22 Jul 2024 14:47:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Use OPP only if the platform supports it
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>
CC: <robh@kernel.org>, <bhelgaas@google.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: es4YjzH_eq1RZucgzmMOdH5sgQ-0r7rK
X-Proofpoint-ORIG-GUID: es4YjzH_eq1RZucgzmMOdH5sgQ-0r7rK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_15,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407220162

Hi Mani

On 7/22/2024 6:11 AM, Manivannan Sadhasivam wrote:
> With commit 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale
> performance"), OPP was used to control the interconnect and power domains
> if the platform supported OPP. Also to maintain the backward compatibility
> with platforms not supporting OPP but just ICC, the above mentioned commit
> assumed that if ICC was not available on the platform, it would resort to
> OPP.
> 
> Unfortunately, some old platforms don't support either ICC or OPP. So on
> those platforms, resorting to OPP in the absence of ICC throws below errors
> from OPP core during suspend and resume:
> 
> qcom-pcie 1c08000.pcie: dev_pm_opp_set_opp: device opp doesn't exist
> qcom-pcie 1c08000.pcie: _find_key: OPP table not found (-19)
> 
> Also, it doesn't make sense to invoke the OPP APIs when OPP is not
> supported by the platform at all. So let's use a flag to identify whether
> OPP is supported by the platform or not and use it to control invoking the
> OPP APIs.
> 
> Fixes: 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale performance")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..6f953e32d990 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -261,6 +261,7 @@ struct qcom_pcie {
>   	const struct qcom_pcie_cfg *cfg;
>   	struct dentry *debugfs;
>   	bool suspended;
> +	bool use_pm_opp;
>   };
>   
>   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> @@ -1433,7 +1434,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>   			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
>   				ret);
>   		}
> -	} else {
> +	} else if (pcie->use_pm_opp) {
>   		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
>   		if (freq_mbps < 0)
>   			return;
> @@ -1592,6 +1593,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>   				      max_freq);
>   			goto err_pm_runtime_put;
>   		}
> +
> +		pcie->use_pm_opp = true;
>   	} else {
>   		/* Skip ICC init if OPP is supported as it is handled by OPP */
>   		ret = qcom_pcie_icc_init(pcie);
> @@ -1683,7 +1686,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>   		if (ret)
>   			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
>   
> -		if (!pcie->icc_mem)
> +		if (pcie->use_pm_opp)
>   			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
>   	}
>   	return ret;
 >
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>

Regards,
Mayank

