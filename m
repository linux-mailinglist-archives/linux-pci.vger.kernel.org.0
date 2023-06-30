Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A71743421
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 07:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjF3FY6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 01:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjF3FY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 01:24:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF542D70;
        Thu, 29 Jun 2023 22:24:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4L35P012603;
        Fri, 30 Jun 2023 05:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0PvjLWZkJVUlHOsogPX7P1QpEsycVpuatunQZLk7zEo=;
 b=KLgWDbGo+Z55/10xdudcRkFBCIaHustbtl1eU3Xj1dw/PDjTh2JvoLsToxSonpxL0E0N
 7AOm98FcBhZ5aVcoUN2D+v5FRELpbtKgTI+0qd9JD6IywaRzXTQqQ9uGGoKgtdXFn8pZ
 PTl6xI7UMpFURvx3hIcM1xalX8Q6hyWmi6MMDFuNUVePEtBWjcTJstC0JUc8a8v69PBU
 p0uXznDiq/EFlBO37kTuzPq0lnFU992EshLRh1GFDuovNAfEDDXtx8HG8v3DXp7nr/8d
 3RiwlI6luGVG4SJeeL473RNkOL9FXtVdyoauKSOPAx+jjdmDnNLxfo/gSzHKHL/goQxf mg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7s2t4jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:24:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U5Ol23015934
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:24:47 GMT
Received: from [10.216.50.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Thu, 29 Jun
 2023 22:24:42 -0700
Message-ID: <398591b7-51ad-e358-1b55-4fcff0abdf52@quicinc.com>
Date:   Fri, 30 Jun 2023 10:54:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/4] pcie: qcom: Fix the macro
 PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20230623093445.3977772-1-quic_srichara@quicinc.com>
 <20230623093445.3977772-2-quic_srichara@quicinc.com>
 <20230624063215.GF5611@thinkpad>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230624063215.GF5611@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D5DzlJOa2DpQNV20R59AR3ZR_9nZW9e8
X-Proofpoint-ORIG-GUID: D5DzlJOa2DpQNV20R59AR3ZR_9nZW9e8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300046
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/24/2023 12:02 PM, Manivannan Sadhasivam wrote:
> On Fri, Jun 23, 2023 at 03:04:42PM +0530, Sricharan Ramabadhran wrote:
>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
>> pcie slave addr size was initially set to 0x358, but
>> was wrongly changed to 0x168 as a part of
>> 'PCI: qcom: Sort and group registers and bitfield definitions'
>> Fixing it back to right value here.
>>
>> Without this pcie bring up on IPQ8074 is broken now.
>>
> 
> Subject prefix should be: "PCI: qcom: "
> 
>> Fixes: 769e49d87b15 ("PCI: qcom: Sort and group registers and bitfield definitions")
> 
> Fixes tag is referring to a wrong commit. Correct one is:
> 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> 

  ok.

>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 4ab30892f6ef..59823beed13f 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -43,7 +43,7 @@
>>   #define PARF_PHY_REFCLK				0x4c
>>   #define PARF_CONFIG_BITS			0x50
>>   #define PARF_DBI_BASE_ADDR			0x168
>> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
>> +#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x358 /* Register offset specific to IP ver 2.3.3 */
> 
> You should just remove PARF_SLV_ADDR_SPACE_SIZE_2_3_3 and use
> PARF_SLV_ADDR_SPACE_SIZE which already has the value of 0x358.
> 

  ok

Regards,
  Sricharan
