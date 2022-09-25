Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADB05E90B1
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiIYBwt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIYBws (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 21:52:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A57367AB;
        Sat, 24 Sep 2022 18:52:47 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28P1plMe020063;
        Sun, 25 Sep 2022 01:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2XLMCWiZ/uHzrBuen69KJ5mt7Qkiu8uabLIpQRORwnw=;
 b=c0FRsiX/aiSUvifvxRM6T7eOIYiLHqssFKZvc9Go7Qp0yw4VABsgifdHErrivYEnyGDS
 mYD1f7XCw05Fisa/P3lF7MgHm4fp0OmiosH2YfYE3y1VctiWrTtKnoiljCZcfaRQVsM8
 2aGL9UWz5i9Lt9yLl86zZyVMkjnVZpSJ6Xqi5iiyVNcW0bV/tX0ccetL4E894K+mNVA9
 X7hRFK+vb0GBPKXh1Oc8CGjaJNgZzWjpdPj8oxk6Jspix2MAZvOd+Z8RYV5HU4tEqt3S
 axIyq9dcKl1TL9n/3ngcbr4PBkqQRhg2P1tL5O+3s1KGvaHdPUWmxMq2EhJEg8fLtGIi qg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jssg6s9f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Sep 2022 01:52:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28P1qCPv017128
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 25 Sep 2022 01:52:12 GMT
Received: from [10.216.45.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 24 Sep
 2022 18:52:02 -0700
Message-ID: <ccd8b282-107b-ea74-184b-34f72f07866f@quicinc.com>
Date:   Sun, 25 Sep 2022 07:21:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/5] PCI: qcom: Add retry logic for link to be stable
 in either L1.1 or L1.2
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <svarbanov@mm-sol.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <kw@linux.com>, <bhelgaas@google.com>,
        <linux-phy@lists.infradead.org>, <kishon@ti.com>,
        <mturquette@baylibre.com>, <linux-clk@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
 <1663669347-29308-3-git-send-email-quic_krichai@quicinc.com>
 <Yy6eJnXUMZk4i2PC@matsya>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <Yy6eJnXUMZk4i2PC@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pr3uE3PPZHW8fDFcmBdqOePEnd9E4Oia
X-Proofpoint-ORIG-GUID: Pr3uE3PPZHW8fDFcmBdqOePEnd9E4Oia
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-24_14,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 mlxlogscore=899 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209250010
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/24/2022 11:35 AM, Vinod Koul wrote:
> On 20-09-22, 15:52, Krishna chaitanya chundru wrote:
>> When link is in L1ss(L1.1 or L1.2), all the clocks will gate off and there
>> will be no activity on the link. At that point clocks and phy
>> can be turned off. If clocks got disabled before link enters
>> L1ss the PCIe link goes down.
>>
>> Few endpoints are taking time more time to settle the link in L1 substates.
>> When we check the traffic in protocol analyzer, we see some DLLP packets
>> going on still. So Wait for max time of 200ms for the link to be stable in
>> L1 substates.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>> changes since v6:
>> 	- updated comments.
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 46 ++++++++++++++++++++++++++--------
>>   1 file changed, 35 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 3f5424a..7a6f69e 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1809,23 +1809,47 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>>   static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
>>   {
>>   	u32 val;
>> +	ktime_t timeout, start;
>>   	struct dw_pcie *pci = pcie->pci;
>>   	struct device *dev = pci->dev;
>>   
>> -	/* if the link is not active turn off clocks */
>> -	if (!dw_pcie_link_up(pci)) {
>> -		dev_dbg(dev, "Link is not active\n");
>> -		goto suspend;
>> -	}
>> +	/*
>> +	 * When link is in L1ss, all the clocks will gate off and
>> +	 * there will be no activity on the link. At that point clocks
>> +	 * and phy can be turned off. If clocks got disabled before
>> +	 * link enters L1ss the PCIe link goes down.
>> +	 *
>> +	 * Few endpoints are taking time more time to settle the link
>> +	 * in L1ss. Wait for max of 200ms for the link to be stable in
>> +	 * L1ss.
>> +	 */
>> +	start = ktime_get();
>> +	/* Wait max 200 ms */
>> +	timeout = ktime_add_ms(start, 200);
>> +
>> +	while (1) {
>> +		/* if the liink is not active turn off clocks */
>> +		if (!dw_pcie_link_up(pci)) {
>> +			dev_dbg(dev, "Link is not active\n");
>> +			break;
>> +		}
>>   
>> -	/* if the link is not in l1ss don't turn off clocks */
>> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> -		dev_warn(dev, "Link is not in L1ss\n");
>> -		return 0;
>> +		/* if the link is not in l1ss don't turn off clocks */
>> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> +			dev_dbg(dev, "Link enters L1ss after %lld  ms\n",
>> +					ktime_to_ms(ktime_get() - start));
>> +			break;
>> +		}
>> +
>> +		if (ktime_after(ktime_get(), timeout)) {
>> +			dev_warn(dev, "Link is not in L1ss\n");
>> +			return 0;
>> +		}
>> +
> ugh, why not use readl_poll_timeout()?
As this is called from the syscore ops, all the interrupts will be 
disabled by the time the execution reaches here.
readl_poll_timeout uses interrupt internally and cause some issues.

So we are using this method instead of readl_poll_timeout.
>
>> +		udelay(1000);
>>   	}
>>   
>> -suspend:
>>   	if (pcie->cfg->ops->suspend)
>>   		pcie->cfg->ops->suspend(pcie);
>>   
>> -- 
>> 2.7.4
