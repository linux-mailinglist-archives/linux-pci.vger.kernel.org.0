Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6C65B5DF3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiILQPN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 12:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiILQPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 12:15:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA5120A8;
        Mon, 12 Sep 2022 09:15:05 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CFjM07004503;
        Mon, 12 Sep 2022 16:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ro+Fjj+7Cak0MPPAH1Ssc08ecwC85l7FkuflGu23Q5c=;
 b=Po2fwSONt4hKmYF/1r5aXLf9hI0XijjQj9acYOqccVXqKCCagIfx9erhKyA9p9N4i44o
 KNzSzp3Pc5kwhqMkMOrEt9pZanztFMvkQQy66T9vkhAHOh3DDAD27BBjf7K+CUjOofhZ
 fIlKOS8o2oWciGBuTZ8XSpXfC9zFZfQDb11/sxJ/mJ2UyYHKKxDVz4y1IPaFrOX+KuUj
 IUKGcsxD8VhQL+Vq3HH6h92zb0pdPDadgSyCsVndYKmuC3jv/8137qPNlyOaYb+UUJ0j
 baEHC2qkuBmIDYFcQzXhbmoIobqG7YZG3kOx1ebyyAWjPyI7kE01JOB5Hpe9tl01hTM+ 7Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jj6wh87tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 16:14:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CG9mY3003518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 16:09:48 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 09:09:40 -0700
Message-ID: <7310fc0c-5f87-87a6-4484-d60970ce3285@quicinc.com>
Date:   Mon, 12 Sep 2022 21:39:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/5] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220909195000.GA310621@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220909195000.GA310621@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _3qMKv_UlUIjb59dOM4EBtLY39Y1SFgt
X-Proofpoint-GUID: _3qMKv_UlUIjb59dOM4EBtLY39Y1SFgt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_11,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120055
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/10/2022 1:20 AM, Bjorn Helgaas wrote:
> On Fri, Sep 09, 2022 at 02:14:41PM +0530, Krishna chaitanya chundru wrote:
>> Some specific devices are taking time to settle the link in L1ss.
>> So added a retry logic before returning from the suspend op.
> "L1ss" is not a state.  If you mean "L1.1" or "L1.2", say that.  Also
> in code comments below.
Yes L1ss means L1.2 and L1.2 We will update it next patch
> s/So added a/Add/
>
> What are these specific devices?  Is this a qcom controller defect?
> An endpoint defect that should be addressed via some kind of generic
> quirk?

This is depending up on the endpoint devices and it varies to device to 
device.

We are thinking this is not a defect if there is some traffic in the 
link the link will

not go to L1ss .

>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
>>   1 file changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 6e04d0d..15c2067 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
>>   {
>>   	u32 val;
>> +	ktime_t timeout, start;
>>   	struct dw_pcie *pci = pcie->pci;
>>   	struct device *dev = pci->dev;
>>   
>>   	if (!pcie->cfg->supports_system_suspend)
>>   		return 0;
>>   
>> -	/* if the link is not active turn off clocks */
>> -	if (!dw_pcie_link_up(pci)) {
>> -		dev_info(dev, "Link is not active\n");
>> -		goto suspend;
>> -	}
>> +	start = ktime_get();
>> +	/* Wait max 200 ms */
>> +	timeout = ktime_add_ms(start, 200);
>>   
>> -	/* if the link is not in l1ss don't turn off clocks */
>> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> -		dev_warn(dev, "Link is not in L1ss\n");
>> -		return 0;
>> +	while (1) {
>> +
>> +		if (!dw_pcie_link_up(pci)) {
>> +			dev_warn(dev, "Link is not active\n");
>> +			break;
>> +		}
>> +
>> +		/* if the link is not in l1ss don't turn off clocks */
>> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> +			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
>> +					ktime_to_ms(ktime_get() - start));
>> +			break;
>> +		}
>> +
>> +		if (ktime_after(ktime_get(), timeout)) {
>> +			dev_warn(dev, "Link is not in L1ss\n");
>> +			return 0;
>> +		}
>> +
>> +		udelay(1000);
>>   	}
>>   
>> -suspend:
>>   	if (pcie->cfg->ops->suspend)
>>   		pcie->cfg->ops->suspend(pcie);
>>   
>> -- 
>> 2.7.4
>>
