Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BB76088C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 06:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjGYEaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 00:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjGYE3q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 00:29:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4DA270F;
        Mon, 24 Jul 2023 21:24:58 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P4HtR2000477;
        Tue, 25 Jul 2023 04:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UPh8BX8GNtNMoS2mWq7N34bq+EwRiLK3K8GGBoaD1fc=;
 b=mXEd2HyKmpjbFUdQKiOU9Y7J4bdhugvIafUhHboX3w9fyxAE3T2XBXExKk280Wg3XcuN
 JTR06npba7I2HCv7pMMG335t4C6NkR0tnBnJAqpgPRXI+T9iguhyG1kaFQ+diunL3Y5t
 ZDMoRzrFuQc1CJPAycD/5Yr7oAUEQ9xMyXEFLOFfbrSoZEdf/wuZc2SNKUXnsHhWfsGr
 ofmizxdamYsChdORSpSYOHvLRp0RckHGA+LLPRfJO3seTKEDJppn22Ws1AHZbzqAZEC2
 /b23hBH5hHKsGOAwreS3hM+zv6z08X1KonQITJqXQ3IuDTos9JC/GO/Bbb6iVEg2Vren UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1qast1re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 04:24:51 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P4OoG4008415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 04:24:50 GMT
Received: from [10.216.17.203] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 21:24:45 -0700
Message-ID: <3f715e25-2b7c-3af4-028e-941393e5a927@quicinc.com>
Date:   Tue, 25 Jul 2023 09:54:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/1] Set may payload size for IPQ9574
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <mani@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
 <5f707d2e-f944-d991-2c0d-5ea9d02f7572@linaro.org>
Content-Language: en-US
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <5f707d2e-f944-d991-2c0d-5ea9d02f7572@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GRRdqw7a83RSA0YXkZUo29b1Kgvhr6FG
X-Proofpoint-GUID: GRRdqw7a83RSA0YXkZUo29b1Kgvhr6FG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_01,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=474 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250038
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/24/2023 6:20 PM, Konrad Dybcio wrote:
> On 24.07.2023 14:47, Praveenkumar I wrote:
>> IPQ9574 supports 256 bytes of payload size and setting the max will allow
>> to use it when capable partner is connected.
>>
> It's not necessary to send a (bogus) cover letter with a single patch.
>
> Please consider using the b4 tool, which takes care of almost all sending-
> related complaints:
>
> https://b4.docs.kernel.org/en/latest/index.html
Sure, will take care hence forth.

- Praveenkumar
> Konrad
