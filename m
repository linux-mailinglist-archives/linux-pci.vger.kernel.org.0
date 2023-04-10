Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2526DC393
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 08:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjDJGe5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 02:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDJGez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 02:34:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF11840E0;
        Sun,  9 Apr 2023 23:34:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A5tI9C012895;
        Mon, 10 Apr 2023 06:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Hclue6ug/7B1tehPsDnrLRVAC5+IwS28gpXRNRQ59eY=;
 b=L4SWaNAtgyzPMgy2W/nju2PEwQdLPkIgDEu3gTr0/13wEdHpZVcMzwQ1jTLcf2zxIPeN
 Couofl3KKCcL0nPUSjLk0Bqpt+AGEafqm+T2M48ZZECHO5zrqMwVrGSoGpaXNJrFcPdh
 m8AVrAjwGjzJg+7mO+WA3/9fwIRYNRxHlcEcTZhDvaKcVNaVN/olRlWlFZtHKStHiHKS
 NNNTtukVDwR8huJB7SZ4z/F4KDtE7q+fsDklIj+8aAfCfxaXL23AC4lT5abHDM5jv0IP
 brbWcxh/lnaAyyPepe7VijPf8f7DT32E1yagKT6jSfT+E2E5xP6kE9ITX6+alExOgJmV HQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pu0c32bhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 06:34:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33A6YaVq022406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 06:34:36 GMT
Received: from [10.216.3.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 9 Apr 2023
 23:34:26 -0700
Message-ID: <858e8459-75bb-c507-5cbb-146d56e1ad27@quicinc.com>
Date:   Mon, 10 Apr 2023 12:04:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 6/9] dt-bindings: pinctrl: qcom: Add few missing
 functions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-7-quic_devipriy@quicinc.com>
 <445ed49a-9ea6-0851-b0c5-bdd1d420689e@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <445ed49a-9ea6-0851-b0c5-bdd1d420689e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DaHnYsZOODC7SRrBMg0JxUu9a5NB5J05
X-Proofpoint-ORIG-GUID: DaHnYsZOODC7SRrBMg0JxUu9a5NB5J05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_03,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=580 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100055
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/5/2023 12:28 PM, Krzysztof Kozlowski wrote:
> On 04/04/2023 18:48, Devi Priya wrote:
>> Added the missing functions cri_trng2, gpio and removed the
>> duplicate entry qdss_tracedata_b
>>
>> Fixes: 5b63ccb69ee8 ("dt-bindings: pinctrl: qcom: Add support for IPQ9574")
> 
> Fixes are either separate patches or sent as first in the series. This
> is not really related to PCI, so it should be separate patchset.
Got it, will post it as a separate patch
> 
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V2:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thanks!
> 
> Best regards,
> Krzysztof
> 
Best Regards,
Devi Priya
