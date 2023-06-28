Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E580B740842
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 04:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjF1CWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 22:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjF1CV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 22:21:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4AB358A;
        Tue, 27 Jun 2023 19:21:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S0bx90031228;
        Wed, 28 Jun 2023 02:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RRMyOnApldKWEBwHoWHXvDCCH6QPx0r7URZKy/MXQbY=;
 b=bulQxrVOSYSstgCrWXqo3zml7zGOZbFDdDsB1m1u4iTtvRyHisP1hgj4g4+AqJEaQSoB
 K4THNTXlXh1FDHHpiU1IEm5asmHCGf+mRUZyMl0o/cDL86ELiRg6H5tFmr6LuTxgUzpA
 AXjQio8ccuNvStudbniJB4TbgbJE9ien3X2ndIpPUJgbjpe8F9xMV5WX8DF2xXbexLYS
 +nImM0TJHpjhf1Qd3HMPEoyhNW+bqvDiXs4K3iyN/6PWE5zfTdZMH6VkAHS+SSOGreKs
 O5SVCWA3tUlmiC3mQsXBEhff8+d0k8ePr+1jZ9mNxizjxG2uChLCJ900k0HZOagfBCp2 +g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfrdtahdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:21:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S2LWPU018642
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:21:32 GMT
Received: from [10.216.43.155] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 27 Jun
 2023 19:21:26 -0700
Message-ID: <18ff366c-767c-fee8-7ce8-847e5e4954a8@quicinc.com>
Date:   Wed, 28 Jun 2023 07:51:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 3/3] PCI: qcom-ep: Add ICC bandwidth voting support
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
 <1687827692-6181-4-git-send-email-quic_krichai@quicinc.com>
 <bdce0719-4f12-4e75-a8e7-1b38d269ac15@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <bdce0719-4f12-4e75-a8e7-1b38d269ac15@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hEc8lT75T697hGL5zH4ngTaBNgVGKurb
X-Proofpoint-GUID: hEc8lT75T697hGL5zH4ngTaBNgVGKurb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 mlxlogscore=861
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280020
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/27/2023 12:05 PM, Pavan Kondeti wrote:
> On Tue, Jun 27, 2023 at 06:31:31AM +0530, Krishna chaitanya chundru wrote:
>> +static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
>> +{
>> +	struct dw_pcie *pci = &pcie_ep->pci;
>> +	u32 offset, status, bw;
>> +	int speed, width;
>> +	int ret;
>> +
>> +	if (!pcie_ep->icc_mem)
>> +		return;
>> +
> Is this check needed? interconnect is added as required property and
> probe is failed if interconnect get fails. qcom_pcie_enable_resources()
> which gets called before enabling this interrupt is assuming that
> interconnect available.
>
>
>> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>> +
>> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>> +
>> +	switch (speed) {
>> +	case 1:
>> +		bw = MBps_to_icc(PCIE_GEN1_BW_MBPS);
>> +		break;
>> +	case 2:
>> +		bw = MBps_to_icc(PCIE_GEN2_BW_MBPS);
>> +		break;
>> +	case 3:
>> +		bw = MBps_to_icc(PCIE_GEN3_BW_MBPS);
>> +		break;
>> +	default:
>> +		dev_warn(pci->dev, "using default GEN4 bandwidth\n");
>> +		fallthrough;
>> +	case 4:
>> +		bw = MBps_to_icc(PCIE_GEN4_BW_MBPS);
>> +		break;
>> +	}
>> +
>> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * bw);
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
>> +	}
> Are you not seeing the below warning from checkpatch?
>
> WARNING: braces {} are not necessary for single statement blocks

checkpatch is not giving warnings for this.

I removed the braces.

-KC

>> +}
>> +
>>   static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>>   {
>>   	int ret;
>> +	struct dw_pcie *pci = &pcie_ep->pci;
>>   
>>   	ret = clk_bulk_prepare_enable(pcie_ep->num_clks, pcie_ep->clks);
>>   	if (ret)
>> @@ -277,6 +331,20 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
>>   	if (ret)
>>   		goto err_phy_exit;
>>   
>> +	/*
>> +	 * Some Qualcomm platforms require interconnect bandwidth constraints
>> +	 * to be set before enabling interconnect clocks.
>> +	 *
>> +	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
>> +	 * for the pcie-mem path.
>> +	 */
>> +	ret = icc_set_bw(pcie_ep->icc_mem, 0, MBps_to_icc(PCIE_GEN1_BW_MBPS));
>> +	if (ret) {
>> +		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
>> +			ret);
>> +		goto err_phy_exit;
>> +	}
>> +
>>   	return 0;
> Thanks,
> Pavan
