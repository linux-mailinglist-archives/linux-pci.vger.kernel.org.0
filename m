Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0369074821F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 12:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGEK2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEK2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 06:28:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738EE57;
        Wed,  5 Jul 2023 03:28:01 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3658VJm9007062;
        Wed, 5 Jul 2023 10:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bV7rJNvmpJ5to4KOLcJiFcl78CQWcc4Ng42UCLOWyNo=;
 b=UNJetcpc21hYbbdPqXRZMpU/4tQI8zFwa8nmfv4o25uI0DMPrB+7592wgTnaubWNSY/M
 sv39zMIZvP4Kunfu0kvmqyCMpU2wmpilC9YjXugkqd4xv9uzSUtN3SgCE3horToGRRsZ
 vga5o4vRcR8kUoNWwyZkSrb7FMHjvjzRevpS9nMNAmE4BuU+G654I/eo8dggbt1znCEm
 BEdFQKO2kzz7wsh/sOLPD9y21TRYDcgRuc56AlbhOfcwt4fPeQedrpP4y9BFKD3eyIE8
 YQfPe2jZamUvG8vFoRInlxAj7ZpfxC0THkHUKc2U+ly3B6hOyIPyu+/LBXUSnKqofDuD pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn152gmg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 10:27:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365ARq4a001436
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 10:27:52 GMT
Received: from [10.216.2.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 5 Jul
 2023 03:27:17 -0700
Message-ID: <20b7d92d-c3b8-254d-82ec-37a857397e8b@quicinc.com>
Date:   Wed, 5 Jul 2023 15:57:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] PCI: qcom: configure the parf halt window size to 1GB
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230623045731.29397-1-quic_devipriy@quicinc.com>
 <20230624062344.GE5611@thinkpad>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <20230624062344.GE5611@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OgT5wYMFdpYAAaKq6n_uq9WN8uIHoAow
X-Proofpoint-ORIG-GUID: OgT5wYMFdpYAAaKq6n_uq9WN8uIHoAow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_01,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=781
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050090
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/24/2023 11:53 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 23, 2023 at 10:27:31AM +0530, Devi Priya wrote:
>> Configure the ADDR_BIT_INDEX of PARF_AXI_MSTR_WR_ADDR_HALT_V2 register with
>> 0x1E to increase the halt window size to 1GB so that, when new inbound
>> posted write transactions whose address crosses 1G address range, the
>> controller would halt all the incoming writes until all the previous AXI
>> responses are received.
>>
> 
> Can you explain how the value of 0x1e corresponds to 1GB window size?
2^30 (0x1e) = 1G
> 
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   This patch depends on the below series which adds support for PCIe
>>   controllers in IPQ9574
>>   https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/
>>
>>   drivers/pci/controller/dwc/pcie-qcom.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index c7579dfa5b1c..26c40e006120 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -116,6 +116,8 @@
>>   
>>   /* PARF_AXI_MSTR_WR_ADDR_HALT register fields */
>>   #define EN					BIT(31)
>> +#define ADDR_BIT_INDEX				(BIT(0) | BIT(1) | BIT(2) | \
>> +						BIT(3) | BIT(4) | BIT(5))
> 
> GENMASK(5, 0)
okay
> 
>>   
>>   /* PARF_LTSSM register fields */
>>   #define LTSSM_EN				BIT(8)
>> @@ -154,6 +156,8 @@
>>   
>>   #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
>>   
>> +#define PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE	0x1e
> 
> GENMASK(4, 1) as these are address bits.
okay

Thanks,
Devi Priya
> 
> - Mani
> 
>> +
>>   #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
>>   struct qcom_pcie_resources_1_0_0 {
>>   	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
>> @@ -1126,6 +1130,11 @@ static int qcom_pcie_post_init(struct qcom_pcie *pcie)
>>   
>>   	writel(0, pcie->parf + PARF_Q2A_FLUSH);
>>   
>> +	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>> +	val &= ~ADDR_BIT_INDEX;
>> +	writel(val | PARF_AXI_MSTR_WR_ADDR_HALT_WINDOW_SIZE, pcie->parf +
>> +			PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>> +
>>   	dw_pcie_dbi_ro_wr_en(pci);
>>   	writel(PCIE_CAP_SLOT_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>   
>> -- 
>> 2.17.1
>>
> 
