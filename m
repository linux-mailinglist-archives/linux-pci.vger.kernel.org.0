Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715F69CD63
	for <lists+linux-pci@lfdr.de>; Mon, 20 Feb 2023 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjBTNs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 08:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjBTNs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 08:48:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFAF40C4;
        Mon, 20 Feb 2023 05:48:44 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KCEMj2006715;
        Mon, 20 Feb 2023 13:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ORSU/Kgrr5YXCnp8lyw5sWPwL7mXbpJ3GoH/DEN7i44=;
 b=p3qOn7D/rpccX+D2Qv2gOgr2XXdtpcSFzBTGi6gTa1/Tz5BN7ZYnE/yKhBMuJ1QjY0Hb
 CXxikNM0i54V2SOq2XHhzphBiFWrgEWyw9+99ZSPPyKN2NGl5NLTrNo3P3OcuZcmDnBW
 LSgAzzCfCzG9S74ey0RCmfCiJg/lkHVC03jnR99i24zlZ6jIamNu7Fv7O8/aqOiQjUil
 3T0O2PpKtplWxiZPhMVfOui0kU68I8EOcDsp4a5pTkx/fVYJbMp6VXY44Fb8JVlZdJot
 VNC5nTmscRuHo6uXCeFXYoqfA7M09z802f8QrOLz6t5gT0gZ8K6jutCAzXgnD1RoxT2Q mQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ntp98d916-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:48:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31KDmWXQ014742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 13:48:32 GMT
Received: from [10.216.11.20] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Feb
 2023 05:48:24 -0800
Message-ID: <989e460a-b92c-e056-75e5-4e2d36885ac3@quicinc.com>
Date:   Mon, 20 Feb 2023 19:18:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/7] Add PCIe support for IPQ9574
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <a987fc17-3924-7ece-59e2-3fa1d000afc1@quicinc.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <a987fc17-3924-7ece-59e2-3fa1d000afc1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RcJZbM2r-nlb2Q96w9jR_KwfenFL0kh4
X-Proofpoint-ORIG-GUID: RcJZbM2r-nlb2Q96w9jR_KwfenFL0kh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_11,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=755 mlxscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/17/2023 2:18 PM, Sricharan Ramabadhran wrote:
> 
> 
> On 2/14/2023 10:11 PM, Devi Priya wrote:
>> PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> are found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane
>> Gen3 host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> This series adds support for enabling the same
>>
> 
> 
> <svarbanov@mm-sol.com>  --> This is bouncing, please remove it
> 
Sure, okay

> Regards,
>   Sricharan

Best Regards,
Devi Priya
