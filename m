Return-Path: <linux-pci+bounces-13028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E5974C68
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 10:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF9B25877
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A587215F3F9;
	Wed, 11 Sep 2024 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MzT0Zbnh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8814EC56;
	Wed, 11 Sep 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042682; cv=none; b=PwiQ7V691Xq0wRdm8B540aQHz4sOSuxv6dACQMsNLbxDfxiU0lIpzshwb3bp6wdfhXOg2TJw8hDVVNfSwQiUKBh02VV2l2gWcfCH1Eo+JwC91fa5OLM97MQVVAmiVM8mJvhyksugUvQ6TGqWaTxWbo0zb+1hKna2seO0RIghJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042682; c=relaxed/simple;
	bh=+lKWuuq9BeYQI/ZzHVoEooPClCjm//jxv9aWZgaxH3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d0mykjVmUngCy5WxiWS6YOXBfsVptEEl1kZO2m5514hpQnJAU1q5TiO4XaW55VxqZBAUFf+Z8D8cHGV3PdFxe24FLUGFu1x115gehTBoJNLipMsAfD2e1/pgWMoA9KriV+EKXPbfsIYMRXJTQOv5pIdtCdvo4m3Lav1JucOpEbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MzT0Zbnh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B3bYgc026723;
	Wed, 11 Sep 2024 08:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xtFklBpz11AJvrufQKKYnZ86yF9hL02EOkaQvIZNkDI=; b=MzT0ZbnhVh/LK44U
	OfZDGJj9x6cEO/YPwqOV+4NT/0FqXKKp5Neq3jVRdE/mxpZWFCUr8JeF43APYN4I
	URDv9hZ+dMGlKedGgzB4GZsvvlv+xFTowBqdugryjQ5uJmyQ/aW7K6RhbTatf/WH
	6ho+L13takL+YwucGQhifc02DKec2urp01n0UixHWd/aOFQDwZH1xKRT74RsUXPt
	UdhxFXAG0E9njTUDQz77TZwM9NlRuEgtTnxGQwFg/oX+M0HQs0Jd5e02DiaSj5Ny
	Lek9DB6gFqb8jsO49TGVprAtDIHknccXv/i30n362lr91OWxBsYDKyOvGV4N+9FT
	vYY2Yg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6e8sh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:17:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B8HmhF021058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:17:48 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 01:17:43 -0700
Message-ID: <26f2845f-2e29-4887-9f33-0b5b2a06adb6@quicinc.com>
Date: Wed, 11 Sep 2024 16:17:41 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <abel.vesa@linaro.org>, <quic_msarkar@quicinc.com>,
        <quic_devipriy@quicinc.com>, <kw@linux.com>, <lpieralisi@kernel.org>,
        <neil.armstrong@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
 <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
 <20240827165826.moe6cnemeheos6jn@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240827165826.moe6cnemeheos6jn@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ijbW-f1D4liPaX-mPUGTaLhfU_ebnCX2
X-Proofpoint-ORIG-GUID: ijbW-f1D4liPaX-mPUGTaLhfU_ebnCX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110062


On 8/28/2024 12:58 AM, Manivannan Sadhasivam wrote:
> On Tue, Aug 27, 2024 at 02:44:09PM +0300, Dmitry Baryshkov wrote:
>> On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
>>> On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
>>> support to use 3.3v, 3.3v aux and 12v regulators.
>> First of all, I don't see corresponding bindings change.
>>
>> Second, these supplies power up the slot, not the host controller
>> itself. As such these supplies do not belong to the host controller
>> entry. Please consider using the pwrseq framework instead.
>>
> Indeed. For legacy reasons, slot power supplies were populated in the host
> bridge node itself until recently Rob started objecting it [1]. And it makes
> real sense to put these supplies in the root port node and handle them in the
> relevant driver.
>
> I'm still evaluating whether the handling should be done in the portdrv or
> pwrctl driver, but haven't reached the conclusion. Pwrctl seems to be the ideal
> choice, but I see a few issues related to handling the OF node for the root
> port.
>
> Hope I'll come to a conclusion in the next few days and will update this thread.
>
> - Mani
>
> [1] https://lore.kernel.org/lkml/20240604235806.GA1903493-robh@kernel.org/
Hi Mani, do you have any updates?

Thanks,
Qiang
>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
>>>   1 file changed, 50 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>> index 6f953e32d990..59fb415dfeeb 100644
>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>> @@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
>>>          bool no_l0s;
>>>   };
>>>
>>> +#define QCOM_PCIE_SLOT_MAX_SUPPLIES                    3
>>> +
>>>   struct qcom_pcie {
>>>          struct dw_pcie *pci;
>>>          void __iomem *parf;                     /* DT parf */
>>> @@ -260,6 +262,7 @@ struct qcom_pcie {
>>>          struct icc_path *icc_cpu;
>>>          const struct qcom_pcie_cfg *cfg;
>>>          struct dentry *debugfs;
>>> +       struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
>>>          bool suspended;
>>>          bool use_pm_opp;
>>>   };
>>> @@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
>>>          return !!(val & PCI_EXP_LNKSTA_DLLLA);
>>>   }
>>>
>>> +static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
>>> +{
>>> +       struct dw_pcie *pci = pcie->pci;
>>> +       int ret;
>>> +
>>> +       ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
>>> +                                   pcie->slot_supplies);
>>> +       if (ret < 0)
>>> +               dev_err(pci->dev, "Failed to enable slot regulators\n");
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
>>> +{
>>> +       regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
>>> +                              pcie->slot_supplies);
>>> +}
>>> +
>>> +static int qcom_pcie_get_slot_supplies(struct qcom_pcie *pcie)
>>> +{
>>> +       struct dw_pcie *pci = pcie->pci;
>>> +       int ret;
>>> +
>>> +       pcie->slot_supplies[0].supply = "vpcie12v";
>>> +       pcie->slot_supplies[1].supply = "vpcie3v3";
>>> +       pcie->slot_supplies[2].supply = "vpcie3v3aux";
>>> +       ret = devm_regulator_bulk_get(pci->dev, ARRAY_SIZE(pcie->slot_supplies),
>>> +                                     pcie->slot_supplies);
>>> +       if (ret < 0)
>>> +               dev_err(pci->dev, "Failed to get slot regulators\n");
>>> +
>>> +       return ret;
>>> +}
>>> +
>>>   static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>   {
>>>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> @@ -1182,10 +1220,14 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>
>>>          qcom_ep_reset_assert(pcie);
>>>
>>> -       ret = pcie->cfg->ops->init(pcie);
>>> +       ret = qcom_pcie_enable_slot_supplies(pcie);
>>>          if (ret)
>>>                  return ret;
>>>
>>> +       ret = pcie->cfg->ops->init(pcie);
>>> +       if (ret)
>>> +               goto err_disable_slot;
>>> +
>>>          ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
>>>          if (ret)
>>>                  goto err_deinit;
>>> @@ -1216,7 +1258,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>>>          phy_power_off(pcie->phy);
>>>   err_deinit:
>>>          pcie->cfg->ops->deinit(pcie);
>>> -
>>> +err_disable_slot:
>>> +       qcom_pcie_disable_slot_supplies(pcie);
>>>          return ret;
>>>   }
>>>
>>> @@ -1228,6 +1271,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>>>          qcom_ep_reset_assert(pcie);
>>>          phy_power_off(pcie->phy);
>>>          pcie->cfg->ops->deinit(pcie);
>>> +       qcom_pcie_disable_slot_supplies(pcie);
>>>   }
>>>
>>>   static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
>>> @@ -1602,6 +1646,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>                          goto err_pm_runtime_put;
>>>          }
>>>
>>> +       ret = qcom_pcie_get_slot_supplies(pcie);
>>> +       if (ret)
>>> +               goto err_pm_runtime_put;
>>> +
>>>          ret = pcie->cfg->ops->get_resources(pcie);
>>>          if (ret)
>>>                  goto err_pm_runtime_put;
>>> --
>>> 2.34.1
>>>
>>
>> -- 
>> With best wishes
>> Dmitry

