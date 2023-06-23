Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF373B59E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFWKmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFWKmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 06:42:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC36E6D;
        Fri, 23 Jun 2023 03:42:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NAAaLq004834;
        Fri, 23 Jun 2023 10:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=d1LF1mJaWIXY2wqgqwNTTbh1aJxpIYjRmC7iKI93Vck=;
 b=R9MYf7rT70TVlvHWvooT4Q7wR6meXXx880hRn+PxOaZQQ0NTgKUEFmMLNDWJ4HJ9cNJr
 nF+9/H5/qPB3wc1WJGvSqFG7gF8nsz0lVUrvgS6kAe7jJQRIuloRbu0jRzObsLp/86WR
 hLQUmTYPSjsOK66b0zAwN9c5TQd5tGCNrwxcgWzBeHgxlUkinBfoNMMGacqrWR1GmhFk
 7GNDSvWPjE2oYm62KIHxggViKw9frCYlaWMGwaC6DuGEh9+zC4ITsjwWkObpsht8YTis
 znbqj4Ukv/9+NeGKR9hF7THx1mJYS19ZvuMIZPbnQ3iC+dzzAiJJCw/GuwOJsgh95mEy Rg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rckn2u3xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:42:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NAg772023100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 10:42:07 GMT
Received: from [10.216.15.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 03:42:02 -0700
Message-ID: <1d814c12-6749-b670-42a5-326757f77ca8@quicinc.com>
Date:   Fri, 23 Jun 2023 16:11:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/4] pcie: qcom: Fix the macro
 PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20230623094403.3978838-1-quic_srichara@quicinc.com>
 <20230623094403.3978838-2-quic_srichara@quicinc.com>
 <b3a1bca2-1867-aa4d-47c7-63c5f9df868f@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <b3a1bca2-1867-aa4d-47c7-63c5f9df868f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dOf4SboSho_n8HLzfczfvRItm1-Zp-qv
X-Proofpoint-ORIG-GUID: dOf4SboSho_n8HLzfczfvRItm1-Zp-qv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_04,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230096
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/23/2023 3:52 PM, Konrad Dybcio wrote:
> On 23.06.2023 11:44, Sricharan Ramabadhran wrote:
>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
>> pcie slave addr size was initially set to 0x358, but
>> was wrongly changed to 0x168 as a part of
>> 'PCI: qcom: Sort and group registers and bitfield definitions'
> Surely not, this commit only moved the definition containing 0x358 up.
> 

   Oops, infact it was the one just below, this one which changed it.

    "PCI: qcom: Remove PCIE20_ prefix from register definitions"

  Will fix this in V2.

Regards,
  Sricharan

> Konrad
>> Fixing it back to right value here.
>>
>> Without this pcie bring up on IPQ8074 is broken now.
>>
>> Fixes: 769e49d87b15 ("PCI: qcom: Sort and group registers and bitfield definitions")
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
>>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
