Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB177DEFB9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbjKBKRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346333AbjKBKRQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 06:17:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F062128;
        Thu,  2 Nov 2023 03:17:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A29L7Qn006445;
        Thu, 2 Nov 2023 10:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=62j8hy0jkDrjp09B7AE85jy2kVheEsLAkN5WotB2Ud4=;
 b=MFpRvSnZUTr5i7GPn+KLj42Lj1aq1nqK3dHppIXLPfcz0ne2nVIuG87BpdM4Xk797qD1
 FrB5Bt/9Ert920k7VFwbs67Cq/aHBbOFEugSCC1EFXLqZgFySerpjJBnLrb8Ux1miudl
 WrAK27Y8aMg7Lo3ZrgljdN0AjpC90ELv4Hi2p+ooPeNXZAQvxenbfD/e0A1mk7yc6xxw
 yN6Mkc08QOhopePpjrgOQeH/fQVHqQ8o0kYHT8yDrXtOijQ20wTVHX3SX59GPV4TZ5uX
 sgOSom0pv2LySt8X64JDC3umPNeRaLXjWBjCrw8xoY2K4foXNxpn2VsMVmSrx6f48xR1 5g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u430kgtb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Nov 2023 10:16:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A2AGuar027151
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Nov 2023 10:16:56 GMT
Received: from [10.216.33.58] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 2 Nov
 2023 03:16:48 -0700
Message-ID: <73a332db-14d3-a5b6-331a-d52ffb27ee63@quicinc.com>
Date:   Thu, 2 Nov 2023 15:46:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mani@kernel.org>, <robh+dt@kernel.org>
CC:     <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        <quic_shijjose@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
 <1698767186-5046-2-git-send-email-quic_msarkar@quicinc.com>
 <e5ee7051-d867-453f-98a7-3a8aea402607@linaro.org>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <e5ee7051-d867-453f-98a7-3a8aea402607@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GEcN-YQ0fpJJI2SDLdbjjwoFmr85ekY8
X-Proofpoint-ORIG-GUID: GEcN-YQ0fpJJI2SDLdbjjwoFmr85ekY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_23,2023-11-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020081
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/31/2023 10:20 PM, Konrad Dybcio wrote:
> On 31.10.2023 16:46, Mrinmay Sarkar wrote:
>> This change will enable cache snooping logic to support
>> cache coherency for SA8755P RC platform.
> 8775
>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 6902e97..6f240fc 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -51,6 +51,7 @@
>>   #define PARF_SID_OFFSET				0x234
>>   #define PARF_BDF_TRANSLATE_CFG			0x24c
>>   #define PARF_SLV_ADDR_SPACE_SIZE		0x358
>> +#define PCIE_PARF_NO_SNOOP_OVERIDE		0x3d4
>>   #define PARF_DEVICE_TYPE			0x1000
>>   #define PARF_BDF_TO_SID_TABLE_N			0x2000
>>   
>> @@ -117,6 +118,9 @@
>>   /* PARF_LTSSM register fields */
>>   #define LTSSM_EN				BIT(8)
>>   
>> +/* PARF_NO_SNOOP_OVERIDE register value */
> override
>> +#define NO_SNOOP_OVERIDE_EN			0xa
> is this actually some magic value and not BIT(1) | BIT(3)?
we need to set 1st and 3rd bit. yes, we can use BIT(1) | BIT(3).
>
>>   /* PARF_DEVICE_TYPE register fields */
>>   #define DEVICE_TYPE_RC				0x4
>>   
>> @@ -961,6 +965,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>>   
>>   static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>>   {
>> +	struct dw_pcie *pci = pcie->pci;
>> +	struct device *dev = pci->dev;
>> +
>> +	/* Enable cache snooping for SA8775P */
>> +	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))
>> +		writel(NO_SNOOP_OVERIDE_EN, pcie->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
> Why only for 8775 and not for other v2.7, or perhaps all other
> revisions?
yes this is only required for 8775 due to hw requirement we need to enable
cache snooping from the register level for 8775.
> Konrad
Thanks,
Mrinmay
