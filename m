Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7506B79814F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 06:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjIHEoH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 00:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237356AbjIHEoG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 00:44:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAF1BEE;
        Thu,  7 Sep 2023 21:44:03 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3884SDtx028600;
        Fri, 8 Sep 2023 04:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BeXNx2m+RalPKr5T5JDz0rOonoHJ7rmMXq+TIhOvIBs=;
 b=VSXHUdZ2FMzhNCDoXPPIoh+btNYi8hE1rsL+2X8o61+cxgZXoZm8CorRItFQFLs0+quP
 JgeaUoD6xPwl66nlQ6kzVwC7W7xb64WVsCABCWWzVYctu5W35NhxHUv5NNKup1Y10+XT
 ZY2d7heQTSQ0Z/Tx4a55xTagugwCD66A6/+ytIyeD5s3u5zC+TFGqjZExJwGMkbJfSVY
 PiJbSoG45fr9EfypRLpWRSQeud6QzkjUx4PedYP87+d1xVW3tcJbNewFWSpGqkAb15Cn
 OSIJie6+5UHiKZoY1cTwi0OipQGF5VC0SraXjsjO/SDk5iWFAyJVhNl4bAPfrQY/xxGk 0w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy951jmhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 04:43:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3884hl8l005676
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 04:43:47 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 7 Sep
 2023 21:43:41 -0700
Message-ID: <78225d7f-5c2d-1cc3-8132-79a703b3b565@quicinc.com>
Date:   Fri, 8 Sep 2023 10:13:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 3/4] PCI: qcom-ep: Update the D-state log
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230803175819.GA103913@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230803175819.GA103913@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IjU26VGRnbzzkbxB4EwhiOArorros19c
X-Proofpoint-ORIG-GUID: IjU26VGRnbzzkbxB4EwhiOArorros19c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=881 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080042
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/3/2023 11:28 PM, Bjorn Helgaas wrote:
> In subject:
>
>    PCI: qcom-ep: Print D-state name to distinguish D3hot/D3cold
>
> ("Update" doesn't give any hint about what the change does.)
I will update it as suggested.
> On Wed, Aug 02, 2023 at 09:21:20AM +0530, Krishna chaitanya chundru wrote:
>> Now that the state event is stored as pci_power_t, let's use the PCI helper
>> pci_power_name() to print the state event.
> s/let's use/use/
>
> The main change is this, right?
>
>    D3 -> D3hot
>    D4 -> D3cold
Yes this is the main change.
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> index 22545ff..0c69a61 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
>> @@ -583,7 +583,6 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   	} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
>>   		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
>>   					   DBI_CON_STATUS_POWER_STATE_MASK;
>> -		dev_dbg(dev, "Received D%d state event\n", dstate);
>>   		state = dstate;
>>   		if (dstate == 3) {
> Can this check for "state == PCI_D3hot" to be clearer?
I will modify this.
>
>>   			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
>> @@ -594,6 +593,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
>>   			if (gpiod_get_value(pcie_ep->reset))
>>   				state = PCI_D3cold;
>>   		}
>> +		dev_dbg(dev, "Received %s event\n", pci_power_name(state));
> Not really sure why this needs to be moved (the diff would be clearer
> if it stayed in the same spot), but it doesn't look like it really
> matters.

As we know if the link is in D3hot or D3cold moving the log here so that 
we can log correct Dstate.

- KC

>>   		pci_epc_dstate_notify(pci->ep.epc, state);
>>   	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
>>   		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
>> -- 
>> 2.7.4
>>
