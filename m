Return-Path: <linux-pci+bounces-13113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B900E976ADE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB6328352C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02471A7248;
	Thu, 12 Sep 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cdzhJ1Ae"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132D187334;
	Thu, 12 Sep 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148405; cv=none; b=npTA1LvunhOmeKeMPhN+NGcCn5rU5xsM9JwiAZu6VbbIFLCAAf9jJW1nyO5Ld9j2j0cqz97Or2iciJlAWgnNexzaMvll8gz91e8b4HWHWgTQ6S2Mmii7ZLPOiE/7f2TF3mlv+DMxxWl0stj9opnkrvXQUw1iL7PqaSixgmLatR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148405; c=relaxed/simple;
	bh=VabAcpqZ+Q+DhX2Qd4nqKaqJdD/SpAdTInijiMKI+94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VGP/21HbzBo1xUcS4a+SIQLTk+pkNsmctj/7AXorwvLWPk4375T3S0hnzTs4NrEcj05e6H4eDUyXdR0JTxq9s8qScBLu1l7/Wmg9nuquQGtlhLBGHHzzdW8WBKG1H1C4/oV2qLTIp4jVBzWAPMRexR94h/i9TUNXYAk+nbVgnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cdzhJ1Ae; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCDX7J008535;
	Thu, 12 Sep 2024 13:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Aa6+bQLRYyqWajbCu2qsPnsRVrEkV4p/ueSyTyh2JRE=; b=cdzhJ1AeGaBdU8cc
	XySgrcaZFzgyNigYEmaFdkrCwC0eg3qa+czEZY18Dm09IRTIRfWhUfU/7VQ6cBi0
	l2jSz+caU2jbEGcVE+yEbebPNvqhxejZojsPTeB5NxQ5MB8TER6VFSuvkY+HfP6d
	Jg6uPxJKKZkAjZpygfEinm8Ok1cufoNca4ZDpK2oHq8nt4TKBOi+wsrY6Nn1dnMr
	6LlsqATouUAQXkqS6qPcJWxYLbyAJMMDVxXAuZEDgBhrasT1dli9CTJXo6GXnICx
	NOsFTBgjrRes6G5oKXIG2/4AS+9WS0CoIP862hOlc7PAJxhUwTXnySxXHisi3e//
	5Gax2g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41j6gn1n3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 13:39:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48CDdrI3028430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 13:39:53 GMT
Received: from [10.253.13.69] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Sep
 2024 06:39:48 -0700
Message-ID: <9222ef18-2eef-4ba3-95aa-fae540c06925@quicinc.com>
Date: Thu, 12 Sep 2024 21:39:44 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <abel.vesa@linaro.org>,
        <quic_msarkar@quicinc.com>, <quic_devipriy@quicinc.com>,
        <kw@linux.com>, <lpieralisi@kernel.org>, <neil.armstrong@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
 <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
 <20240827165826.moe6cnemeheos6jn@thinkpad>
 <26f2845f-2e29-4887-9f33-0b5b2a06adb6@quicinc.com>
 <20240911153228.7ajcqicxnu2afhbp@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240911153228.7ajcqicxnu2afhbp@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NLJRrRe3U1E6MJVZB1ufqd-FX3yRHmOp
X-Proofpoint-GUID: NLJRrRe3U1E6MJVZB1ufqd-FX3yRHmOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120099


On 9/11/2024 11:32 PM, Manivannan Sadhasivam wrote:
> On Wed, Sep 11, 2024 at 04:17:41PM +0800, Qiang Yu wrote:
>> On 8/28/2024 12:58 AM, Manivannan Sadhasivam wrote:
>>> On Tue, Aug 27, 2024 at 02:44:09PM +0300, Dmitry Baryshkov wrote:
>>>> On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
>>>>> On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
>>>>> support to use 3.3v, 3.3v aux and 12v regulators.
>>>> First of all, I don't see corresponding bindings change.
>>>>
>>>> Second, these supplies power up the slot, not the host controller
>>>> itself. As such these supplies do not belong to the host controller
>>>> entry. Please consider using the pwrseq framework instead.
>>>>
>>> Indeed. For legacy reasons, slot power supplies were populated in the host
>>> bridge node itself until recently Rob started objecting it [1]. And it makes
>>> real sense to put these supplies in the root port node and handle them in the
>>> relevant driver.
>>>
>>> I'm still evaluating whether the handling should be done in the portdrv or
>>> pwrctl driver, but haven't reached the conclusion. Pwrctl seems to be the ideal
>>> choice, but I see a few issues related to handling the OF node for the root
>>> port.
>>>
>>> Hope I'll come to a conclusion in the next few days and will update this thread.
>>>
>>> - Mani
>>>
>>> [1] https://lore.kernel.org/lkml/20240604235806.GA1903493-robh@kernel.org/
>> Hi Mani, do you have any updates?
>>
> I'm working with Bartosz to add a new pwrctl driver for rootports. And we are
> debugging an issue currently. Unfortunately, the progress is very slow as I'm on
> vacation still.
>
> Will post the patches once it got resolved.
>
> - Mani
OK, thanks for your update.

Thanks,
Qiang
>> Thanks,
>> Qiang
>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>>> ---
>>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
>>>>>    1 file changed, 50 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> index 6f953e32d990..59fb415dfeeb 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>>> @@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
>>>>>           bool no_l0s;
>>>>>    };
>>>>>
>>>>> +#define QCOM_PCIE_SLOT_MAX_SUPPLIES                    3
>>>>> +
>>>>>    struct qcom_pcie {
>>>>>           struct dw_pcie *pci;
>>>>>           void __iomem *parf;                     /* DT parf */
>>>>> @@ -260,6 +262,7 @@ struct qcom_pcie {
>>>>>           struct icc_path *icc_cpu;
>>>>>           const struct qcom_pcie_cfg *cfg;
>>>>>           struct dentry *debugfs;
>>>>> +       struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
>>>>>           bool suspended;
>>>>>           bool use_pm_opp;
>>>>>    };
>>>>> @@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
>>>>>           return !!(val & PCI_EXP_LNKSTA_DLLLA);
>>>>>    }
>>>>>
>>>>> +static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
>>>>> +{
>>>>> +       struct dw_pcie *pci = pcie->pci;
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
>>>>> +                                   pcie->slot_supplies);
>>>>> +       if (ret < 0)
>>>>> +               dev_err(pci->dev, "Failed to enable slot regulators\n");
>>>>> +
>>>>> +       return ret;
>>>>> +}
>>>>> +
>>>>> +static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
>>>>> +{
>>>>> +       regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
>>>>> +                              pcie->slot_supplies);
>>>>> +}
>>>>> +
>>>>> +static int qcom_pcie_get_slot_supplies(struct qcom_pcie *pcie)
>>>>> +{
>>>>> +       struct dw_pcie *pci = pcie->pci;
>>>>> +       int ret;
>>>>> +
>>>>> +       pcie->slot_supplies[0].supply = "vpcie12v";
>>>>> +       pcie->slot_supplies[1].supply = "vpcie3v3";
>>>>> +       pcie->slot_supplies[2].supply = "vpcie3v3aux";
>>>>> +       ret = devm_regulator_bulk_get(pci->dev, ARRAY_SIZE(pcie->slot_supplies),
>>>>> +                                     pcie->slot_supplies);
>>>>> +       if (ret < 0)
>>>>> +               dev_err(pci->dev, "Failed to get slot regulators\n");
>>>>> +
>>>>> +       return ret;
>>>>> +}
>>>>> +
>>>>>    static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>    {
>>>>>           struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>> @@ -1182,10 +1220,14 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>
>>>>>           qcom_ep_reset_assert(pcie);
>>>>>
>>>>> -       ret = pcie->cfg->ops->init(pcie);
>>>>> +       ret = qcom_pcie_enable_slot_supplies(pcie);
>>>>>           if (ret)
>>>>>                   return ret;
>>>>>
>>>>> +       ret = pcie->cfg->ops->init(pcie);
>>>>> +       if (ret)
>>>>> +               goto err_disable_slot;
>>>>> +
>>>>>           ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>>>>>           if (ret)
>>>>>                   goto err_deinit;
>>>>> @@ -1216,7 +1258,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>>>           phy_power_off(pcie->phy);
>>>>>    err_deinit:
>>>>>           pcie->cfg->ops->deinit(pcie);
>>>>> -
>>>>> +err_disable_slot:
>>>>> +       qcom_pcie_disable_slot_supplies(pcie);
>>>>>           return ret;
>>>>>    }
>>>>>
>>>>> @@ -1228,6 +1271,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>>>>>           qcom_ep_reset_assert(pcie);
>>>>>           phy_power_off(pcie->phy);
>>>>>           pcie->cfg->ops->deinit(pcie);
>>>>> +       qcom_pcie_disable_slot_supplies(pcie);
>>>>>    }
>>>>>
>>>>>    static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
>>>>> @@ -1602,6 +1646,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>>>                           goto err_pm_runtime_put;
>>>>>           }
>>>>>
>>>>> +       ret = qcom_pcie_get_slot_supplies(pcie);
>>>>> +       if (ret)
>>>>> +               goto err_pm_runtime_put;
>>>>> +
>>>>>           ret = pcie->cfg->ops->get_resources(pcie);
>>>>>           if (ret)
>>>>>                   goto err_pm_runtime_put;
>>>>> --
>>>>> 2.34.1
>>>>>
>>>> -- 
>>>> With best wishes
>>>> Dmitry

