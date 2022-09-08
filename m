Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310555B14C2
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIHGhU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIHGhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 02:37:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAE0C0BF9;
        Wed,  7 Sep 2022 23:37:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2885iNxf013094;
        Thu, 8 Sep 2022 06:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nXVYlg3xTpD+OOFGG59ExVDCnz5VM9+NKgHes4yM1z0=;
 b=ksbYRtEWVUmevEIKeYZCM5umOkz+X2GAYlUEtMhRezk2RxGT/h9XlFLIgVwidmKR4a7N
 tCncaA/vP0fSkBL2zkxPW/G5Ni5zjSM+FNOfdU2swhcQPFphx1Agk43w9mNFrxNBXOuV
 xdUuPIcqkw2DowdjPtGnGKU18sO8n4XFwRGc/dYQUWowuh4LOCzXwhVjOjKl+uqUXxw9
 GhLBUBiIFWVaK2WsHcTng4oP76hnZsp8ggeVEek9QYg4d/zEXYsnLfYGfzKjChFIewJR
 INk/pYYBqdMKboqiLa4CuR2YVYW5Aj0t1gDiSCJ4UZEuhRwqGUb2Dxup0t2CSoZbN/q0 qw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jerdpbma3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 06:37:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2886b1ON025512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 06:37:01 GMT
Received: from [10.216.34.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 7 Sep 2022
 23:36:54 -0700
Message-ID: <723916b2-7939-a41d-2b0f-421868c581dd@quicinc.com>
Date:   Thu, 8 Sep 2022 12:06:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/3] PCI: qcom: Add sc7280 aggre0, aggre1 and ddr sf
 tbu clocks in PCIe driver
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220907184437.GA137711@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220907184437.GA137711@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5vHG0CipMuQfHpCVmSqwsMesmrqkPRUb
X-Proofpoint-ORIG-GUID: 5vHG0CipMuQfHpCVmSqwsMesmrqkPRUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_04,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=870 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080023
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/8/2022 12:14 AM, Bjorn Helgaas wrote:
> On Sat, Sep 03, 2022 at 07:43:02AM +0530, Krishna chaitanya chundru wrote:
>> Add missing aggre0, aggre1 and ddrs sf tbu clocks in PCIe driver.
>>
>> If these clocks are not presenti, the PCIe link goes down in system suspend
>> and resume.
> s/presenti/present/
>
> But the hardware clocks are present regardless of this driver change.
>
> I suspect the point of this is really that if the driver doesn't
> clk_get() these clocks to increase the reference count, we don't know
> that the clocks are in use, and since they appear unused, they get
> turned off during suspend.

Yes, these are present in the hardware. As we are not voting for these 
clocks from

our driver in the system suspend these clocks can be turn off.

>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 2ea1375..a7202f0 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1548,7 +1548,10 @@ static const struct qcom_pcie_cfg sm8450_pcie1_cfg = {
>>   static const struct qcom_pcie_cfg sc7280_cfg = {
>>   	.ops = &ops_1_9_0,
>>   	.has_tbu_clk = true,
>> +	.has_ddrss_sf_tbu_clk = true,
>>   	.pipe_clk_need_muxing = true,
>> +	.has_aggre0_clk = true,
>> +	.has_aggre1_clk = true,
>>   };
>>   
>>   static const struct qcom_pcie_cfg sc8180x_cfg = {
>> -- 
>> 2.7.4
>>
