Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7314B5B7EAB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 03:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiINBsx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 21:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiINBsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 21:48:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E86DFB5;
        Tue, 13 Sep 2022 18:48:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E0vYIB004764;
        Wed, 14 Sep 2022 01:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AnD8zG5EexPMoRYMrIEs798ifwPJnxwt5mBmLeK1BDk=;
 b=lsFznRVWyfIbHhNmIWTVXbHbnTp59oI0+vIKba3W88Aq7I0We8NQz+Cx4y0ZSDZ+ppQ/
 L66S8mLuUGjIE1foxGAKwOqPXwFOH71Juga9XXd6/D/JNzjZEGB2Wdpq9k7sY4mAnXsm
 AUkpx21zJw1Qovjw3f1L9IQxg1d3iX+Zhwox5M08E6JwYj21KjyD3q7fSIg0kf6IuE4U
 5CoG4vXZy/JnxcGVBRzEhSYxvC8forZvNX1m8F5JhbkBGqp9mu/jZThzDw9ylnJHh5Gx
 R0ocMgJAXCrCMC+1bahWu9s0s2f8zLXbitE1mB8QXYmry2xXoBpw4U/8mhCjosuNevEF OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy06gnsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 01:48:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E1mhmF011512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 01:48:43 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 18:48:35 -0700
Message-ID: <847a3838-90b4-7368-9632-223bbd2468cc@quicinc.com>
Date:   Wed, 14 Sep 2022 07:18:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 5/5] clk: qcom: Alwaya on pcie gdsc
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <quic_rjendra@quicinc.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <20220913163424.GA602259@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220913163424.GA602259@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SGsqD8RfEsjDjXsE12JNmUG-xY_FQ856
X-Proofpoint-ORIG-GUID: SGsqD8RfEsjDjXsE12JNmUG-xY_FQ856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 spamscore=0 mlxlogscore=958 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140006
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/13/2022 10:04 PM, Bjorn Helgaas wrote:
> On Mon, Sep 12, 2022 at 10:34:37PM +0530, Manivannan Sadhasivam wrote:
>> + Rajendra
>>
>> On Fri, Sep 09, 2022 at 02:14:44PM +0530, Krishna chaitanya chundru wrote:
>>> Make GDSC always on to ensure controller and its dependent clocks
>>> won't go down during system suspend.
>> You need to mention the SoC name in subject, otherwise one cannot know for
>> which platform this patch applies to.
> Also:
>
> s/Alwaya/Always/
> s/pcie/PCIe/
> s/gdsc/GDSC/ as you did in commit log
>
> I might use "ALWAYS_ON" in the subject to make clear this refers to a
> specific flag, not a change in the code logic, e.g.,
>
>    clk: qcom: gcc-sc7280: Mark PCIe GDSC clock ALWAYS_ON
ok I will update the subject in next patch.
