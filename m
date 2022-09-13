Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897ED5B76EF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiIMQ4u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiIMQ4d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 12:56:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E9086C20;
        Tue, 13 Sep 2022 08:48:58 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DDwhlK031872;
        Tue, 13 Sep 2022 14:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oZuTYfSKuWLPhQfx15PFAjHvu5GjtwPRUCgR7aNtZKM=;
 b=Phbqg/C/M1oLodY6EaENf/gm7ZstxWJoMsxdNWiZvehXqk+6+LSm7xW086AU07dMn3Ef
 QGDFkylX7+ke11O4pPodhJ0MnaIzyGLCiUN4/Jpoaaz9nuTdfDpI4RoJObn8AfHm7bxZ
 OvTl7BgQ69upltFiNM8dTRM3VmUdYdGZBV5fXHtGcvs1UkHUafgF9uSnUmPrpjX37K5r
 UhYWKHqtzuJMzjxrbHxSiTEWC5qOw/BmZ09KPvNd5GAKzDfLS4nCevpIXvOw5bxlg77h
 EQvc30WUDsrSeP5qkFM8l4S9Zg4XhFtpMbTY9mCJ6qM92B7q1E/Z37U6Qzt015wC7YvB dA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjhu3t5jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 14:24:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DEOY9u027615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 14:24:34 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 07:24:27 -0700
Message-ID: <e9c5d29a-f1a7-46c8-a456-6c75c129876f@quicinc.com>
Date:   Tue, 13 Sep 2022 19:54:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/5] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220909195000.GA310621@bhelgaas>
 <7310fc0c-5f87-87a6-4484-d60970ce3285@quicinc.com>
 <20220912173346.GB25849@workstation>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220912173346.GB25849@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bkOYVhQlOq40KZWW-_OmK2t1eLlIaBDi
X-Proofpoint-GUID: bkOYVhQlOq40KZWW-_OmK2t1eLlIaBDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_06,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130065
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/12/2022 11:03 PM, Manivannan Sadhasivam wrote:
> On Mon, Sep 12, 2022 at 09:39:36PM +0530, Krishna Chaitanya Chundru wrote:
>> On 9/10/2022 1:20 AM, Bjorn Helgaas wrote:
>>> On Fri, Sep 09, 2022 at 02:14:41PM +0530, Krishna chaitanya chundru wrote:
>>>> Some specific devices are taking time to settle the link in L1ss.
>>>> So added a retry logic before returning from the suspend op.
>>> "L1ss" is not a state.  If you mean "L1.1" or "L1.2", say that.  Also
>>> in code comments below.
>> Yes L1ss means L1.2 and L1.2 We will update it next patch
>>> s/So added a/Add/
>>>
>>> What are these specific devices?  Is this a qcom controller defect?
>>> An endpoint defect that should be addressed via some kind of generic
>>> quirk?
>> This is depending up on the endpoint devices and it varies to device to
>> device.
>>
> Can we identify the source of the traffic? Is the NVMe driver not
> flushing it's queues correctly?

We found that it is not from nvme data, we are seeing some physical 
layer activity on the

protocol analyzer.

>
>> We are thinking this is not a defect if there is some traffic in the link
>> the link will
>>
>> not go to L1ss .
>>
> Is this hack still required even after switching to syscore ops?
>
> Thanks,
> Mani

Yes, mani it is still required. And just before this sycore ops there 
will be a pci transaction to

mask msix interrupts.

>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
>>>>    1 file changed, 25 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> index 6e04d0d..15c2067 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>>>> @@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>>>    static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
>>>>    {
>>>>    	u32 val;
>>>> +	ktime_t timeout, start;
>>>>    	struct dw_pcie *pci = pcie->pci;
>>>>    	struct device *dev = pci->dev;
>>>>    	if (!pcie->cfg->supports_system_suspend)
>>>>    		return 0;
>>>> -	/* if the link is not active turn off clocks */
>>>> -	if (!dw_pcie_link_up(pci)) {
>>>> -		dev_info(dev, "Link is not active\n");
>>>> -		goto suspend;
>>>> -	}
>>>> +	start = ktime_get();
>>>> +	/* Wait max 200 ms */
>>>> +	timeout = ktime_add_ms(start, 200);
>>>> -	/* if the link is not in l1ss don't turn off clocks */
>>>> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>>>> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>>>> -		dev_warn(dev, "Link is not in L1ss\n");
>>>> -		return 0;
>>>> +	while (1) {
>>>> +
>>>> +		if (!dw_pcie_link_up(pci)) {
>>>> +			dev_warn(dev, "Link is not active\n");
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		/* if the link is not in l1ss don't turn off clocks */
>>>> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>>>> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>>>> +			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
>>>> +					ktime_to_ms(ktime_get() - start));
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		if (ktime_after(ktime_get(), timeout)) {
>>>> +			dev_warn(dev, "Link is not in L1ss\n");
>>>> +			return 0;
>>>> +		}
>>>> +
>>>> +		udelay(1000);
>>>>    	}
>>>> -suspend:
>>>>    	if (pcie->cfg->ops->suspend)
>>>>    		pcie->cfg->ops->suspend(pcie);
>>>> -- 
>>>> 2.7.4
>>>>
