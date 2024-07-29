Return-Path: <linux-pci+bounces-10948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDBB93F563
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 14:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BC61C220E5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F2146D41;
	Mon, 29 Jul 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kiFaHVi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49741145A01;
	Mon, 29 Jul 2024 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256131; cv=none; b=kcctLwkTdJIVrQ/Saqr/rYUst1dvgpXjg/Ti0Jiw96BUPMujXc9c9tYid8HjF3FVpLhQyDV2h2jqvOE4CqOOBiQslHWjYvEiqycJ/hkkYoe8NHaD97/RsGptTesrytd750UYzc70L64L3L4LFEipZ92b/rg3gjsg10bR7SPIzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256131; c=relaxed/simple;
	bh=IRqd+oo1mq+g4LO1zPcPaDVg+dznO3Layv/JAbNPjyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uM0epPq4FqmSuuFZh6nx6KODH4h3QOk4ZLWKLFOhRfFyUT2zsnspZKfDZx5V2IJ0vq2D8cqyw2YKTyTPE6ImjdOoMeu/M9WD5Ze/kPte7Ssa9b3xHlTG7VaAM6boNWjsmUFROLd9futgAMEiIdqAtphK+OZ2H3a/WCSZ6sG+rVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kiFaHVi3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TATHpO023650;
	Mon, 29 Jul 2024 12:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3DEt+ZdHR6AdfF8Av7/wPvcvAXWbOzS3yxyQqXgfbBU=; b=kiFaHVi3YnH1RT5p
	3Yz06r5IHwNEUpLRnw1m8NCxdFPi053RGAlsVONmwbjxhDuBkiC4hiy/WXDS/j/c
	8OFNJhKaxdhH9iSfGbt03imuEGYeWbQjD8SqVBNhq223HFmLCXfLNbnGs9dWn9DP
	iJAdiLkxbWEGzhLkIvvbPcJh7BVa9igN9B24pzYRzpJo6vMiCHmZK4CUTJoWWNiK
	WxRlkRw+gMHWuLGTqqbTQ/2LhBG1rD5GIgBzUsAObAWENacBMTJZ6f7rh4UkH6zq
	u/azpv+PyMm5ecvWSvnht5Porv7GMs7QXFnTutxTtNAHEBd0mr3bSt6mdbP6xjHr
	oysgXg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mt68m4ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:28:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46TCSbuU018418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 12:28:37 GMT
Received: from [10.216.48.244] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 05:28:34 -0700
Message-ID: <98264d15-fb30-32e0-7eba-72b3a50347e0@quicinc.com>
Date: Mon, 29 Jul 2024 17:58:31 +0530
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>
CC: <robh@kernel.org>, <bhelgaas@google.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20240729122245.33410-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i_B38skPQuLZgVvanh0FB5a8iG_rSYiV
X-Proofpoint-GUID: i_B38skPQuLZgVvanh0FB5a8iG_rSYiV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290084



On 7/29/2024 5:52 PM, Manivannan Sadhasivam wrote:
> Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> deinit notify function pci_epc_deinit_notify() are called during the
> execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> PERST#. But quickly after this step, refclk will also be disabled by the
> host.
> 
> All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> the host for keeping the controller operational. Due to this limitation,
> any access to the hardware registers in the absence of refclk will result
> in a whole endpoint crash. Unfortunately, most of the controller cleanups
> require accessing the hardware registers (like eDMA cleanup performed in
> dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> functions are currently causing the crash in the endpoint SoC once host
> asserts PERST#.
> 
> One way to address this issue is by generating the refclk in the endpoint
> itself and not depending on the host. But that is not always possible as
> some of the endpoint designs do require the endpoint to consume refclk from
> the host (as I was told by the Qcom engineers).
> 
> So let's fix this crash by moving the controller cleanups to the start of
> the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> called whenever the host has deasserted PERST# and it is guaranteed that
> the refclk would be active at this point. So at the start of this function,
> the controller cleanup can be performed. Once finished, rest of the code
> execution for PERST# deassert can continue as usual.
> 
How about doing the cleanup as part of pme turnoff message.
As host waits for L23 ready from the device side. we can use that time
to cleanup the host before sending L23 ready.

- Krishna Chaitanya.
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2319ff2ae9f6..e024b4dcd76d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -186,6 +186,8 @@ struct qcom_pcie_ep_cfg {
>    * @link_status: PCIe Link status
>    * @global_irq: Qualcomm PCIe specific Global IRQ
>    * @perst_irq: PERST# IRQ
> + * @cleanup_pending: Cleanup is pending for the controller (because refclk is
> + *                   needed for cleanup)
>    */
>   struct qcom_pcie_ep {
>   	struct dw_pcie pci;
> @@ -214,6 +216,7 @@ struct qcom_pcie_ep {
>   	enum qcom_pcie_ep_link_status link_status;
>   	int global_irq;
>   	int perst_irq;
> +	bool cleanup_pending;
>   };
>   
>   static int qcom_pcie_ep_core_reset(struct qcom_pcie_ep *pcie_ep)
> @@ -389,6 +392,12 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>   		return ret;
>   	}
>   
> +	if (pcie_ep->cleanup_pending) {
> +		pci_epc_deinit_notify(pci->ep.epc);
> +		dw_pcie_ep_cleanup(&pci->ep);
> +		pcie_ep->cleanup_pending = false;
> +	}
> +
>   	/* Assert WAKE# to RC to indicate device is ready */
>   	gpiod_set_value_cansleep(pcie_ep->wake, 1);
>   	usleep_range(WAKE_DELAY_US, WAKE_DELAY_US + 500);
> @@ -522,10 +531,9 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>   {
>   	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
>   
> -	pci_epc_deinit_notify(pci->ep.epc);
> -	dw_pcie_ep_cleanup(&pci->ep);
>   	qcom_pcie_disable_resources(pcie_ep);
>   	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
> +	pcie_ep->cleanup_pending = true;
>   }
>   
>   /* Common DWC controller ops */

