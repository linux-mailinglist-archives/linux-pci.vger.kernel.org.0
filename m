Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE45749544
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 08:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbjGFGDk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jul 2023 02:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjGFGDf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2023 02:03:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1943F2107;
        Wed,  5 Jul 2023 23:03:11 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3664YMGC017089;
        Thu, 6 Jul 2023 06:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7eShGAsi2/ikgnytOID04GiQ7zzCpoBj+hlMet0+2Kw=;
 b=dh2DM45eMfri5H4Y77Wlxlhsm5K2+/5xg4cCiXUl3ndEYcjnhzvAtcU+R3uFchd9dmTj
 6rYLJWseGGNj0Z7tYRsGKMl3+Qw/Yxhqg96MnK4FFAtespjV2saGPBabQtcCwHde92hq
 f8woDb1EQxiYt+7VVuoYsLYoMdRQE3NOPz/nxh7y8vPtwvBdXYqeJjAazUSZvVd9fkxr
 LNit17BRjVw9hyksyLpOlWXoOl5PSEuUO2Iw8b7I2m4XYBOetASTZZkLwOxvO0tnOLJy
 Jwy0fmRxOHi0fpOuFcX9m63PKy8lmDxu51SrVKtPzSSoIpZBMdJefSMfBFEdpiBU8YeD 8Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2cpap9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 06:02:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36662w1n014230
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 06:02:58 GMT
Received: from [10.216.0.90] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 23:02:52 -0700
Message-ID: <3c028852-4278-5e72-4488-5179707cd3b6@quicinc.com>
Date:   Thu, 6 Jul 2023 11:32:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] PCI: qcom: Use PARF_SLV_ADDR_SPACE_SIZE for ops_2_3_3
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230703175757.2425540-1-quic_srichara@quicinc.com>
 <20230705084454.GE11854@thinkpad>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230705084454.GE11854@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _3LqhERdLyqYSdOPOUwJpOvA0e5wgEDJ
X-Proofpoint-ORIG-GUID: _3LqhERdLyqYSdOPOUwJpOvA0e5wgEDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_02,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060052
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/5/2023 2:14 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 03, 2023 at 11:27:57PM +0530, Sricharan Ramabadhran wrote:
>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
>> 2_3_3 post_init ops. pcie slave addr size was initially set
> 
> PCIe
> 
>> to 0x358, but was wrongly changed to 0x168 as a part of
> 
> commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
> 

  ok.

>> "PCI: qcom: Remove PCIE20_ prefix from register definitions"
>> Fixing it, by using the right macro PARF_SLV_ADDR_SPACE_SIZE
>> and removing the unused PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
>>
> 
> Commit message should be imperative.

  ok, will send v3.

> 
>> Without this pcie bring up on IPQ8074 is broken now.
>>
>> Fixes: 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from register definitions")
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> ---
>>   [V2] Fixed the 'fixes tag' correctly, subject, right macro usage
>>
>>   drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 4ab30892f6ef..1689d072fe86 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -43,7 +43,6 @@
>>   #define PARF_PHY_REFCLK				0x4c
>>   #define PARF_CONFIG_BITS			0x50
>>   #define PARF_DBI_BASE_ADDR			0x168
>> -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16c /* Register offset specific to IP ver 2.3.3 */
>>   #define PARF_MHI_CLOCK_RESET_CTRL		0x174
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
>>   #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>> @@ -811,7 +810,7 @@ static int qcom_pcie_post_init_2_3_3(struct qcom_pcie *pcie)
>>   	u32 val;
>>   
>>   	writel(SLV_ADDR_SPACE_SZ,
>> -		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE_2_3_3);
>> +		pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> 
> This could be wrapped in the above line itself.

  sure, will post v3

Regards,
  Sricharan
