Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7854875F8FA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 15:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjGXNzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGXNy5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 09:54:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22322526D;
        Mon, 24 Jul 2023 06:52:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ODYnus027616;
        Mon, 24 Jul 2023 13:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TooVBwAIA3xzgpS1Zg854+i1r43v/oLL+XANBssgrKw=;
 b=oDqTCFcKv2GI8EhWtbpHEZbOqoXDShNi+eDFnx5/2FSCCvrwaC7SZl6fMjw74XjGZ67T
 eeKA9ApvAc/reS1RLXTO0NNA2T58rr36HMAZxz4inHwa7iUY77dCR2WhtfEwezO1gcdN
 bH9X34dB3q8AmHMt8MOQM8MoCU7uIRrl6Kx6eOiXrPCrXEun0jKXtts3xe1DVWAgyKOI
 UOUj8MJynLqrv1MV4GFX39uEwyTZxEAtTufF6eDO0XoDWqeCHU+ZnxTBEh6aCjOGOp+n
 9Dra1sJdQT3+/cPjpXB44FY8mSBw3jf+RB8dx3DgjxTcD2R9iUeq7Sjvr8H3wzxRbXlo aQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qasrd5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 13:52:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36ODpwQE016069
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 13:51:58 GMT
Received: from [10.216.38.70] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 06:51:53 -0700
Message-ID: <b9424d44-82bf-8863-a269-ab68fde232e7@quicinc.com>
Date:   Mon, 24 Jul 2023 19:21:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload
 size for IPQ9574
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <mani@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
 <20230724124711.2346886-2-quic_ipkumar@quicinc.com>
 <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <af7d1db2-8bbe-e078-6b17-7f841fb7f475@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AFDz2SOrtO_jqUcW5vn75PxOWGcadxZf
X-Proofpoint-GUID: AFDz2SOrtO_jqUcW5vn75PxOWGcadxZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240123
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/24/2023 6:23 PM, Konrad Dybcio wrote:
> On 24.07.2023 14:47, Praveenkumar I wrote:
>> Set 256 bytes as payload size for IPQ9574 via early fixup. This allows
>> PCIe RC to use the max payload size when a capable link partner is
>> connected.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
> [...]
>
>> +static void qcom_fixup_mps_256(struct pci_dev *dev)
>> +{
>> +	pcie_set_mps(dev, 256);
> Looks like setting "dev->pcie_mpss = 1" here would make the PCIe generic
> code take care of this.
Yes, but that is not helping as the generic code pci_configure_mps() has 
a check for,
/         if (!bridge || !pci_is_pcie(bridge))/
/            return;/
/Here it is returning and mps is not set to new 256 bytes./
>
> Konrad
--
Thanks,
Praveenkumar
