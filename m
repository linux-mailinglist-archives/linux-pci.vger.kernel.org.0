Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0D7DB9D2
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJ3MXO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 08:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjJ3MXN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 08:23:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303AAA2;
        Mon, 30 Oct 2023 05:23:09 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UC9HLj019344;
        Mon, 30 Oct 2023 12:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4YHkGWLw2OrwpyiXVjdHQGX9PojhBUm/xhT+uiXYKv4=;
 b=QIX6WJrfeCvVkY16KN53YjBpGw24uUBr6daw16f9Yn9h7OzZ+x0AJ+9Oo2pewJ9UynVO
 TuqkcOixz1IuRWcGoZxIjOjk8rqAoacUOeBuLZqB4hwTI4lYNBNwWlGqrlCaSUXb/46e
 A6ymWCL0KLbcTYiFdW/n4sK0iMcQwZW6Vu/iArbuEYTMtWsrzdKINZBuQ+7MjmQS3ZKn
 AFRIib/AU7mStpY3fLlDMEvwx2fUmew57ufNQLF4FgWbZN1iVII2VGmDD27RJjGjd46S
 0k0GxSbBciwQzZEiDS166CcVA3H5ioPI8bZE+X9wQ+eJGAstq8qctiGzQse/9pt2rsI1 Ng== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0u2qkm94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 12:23:00 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39UCMxZi030283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 12:22:59 GMT
Received: from [10.216.34.48] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 05:22:51 -0700
Message-ID: <05ce4dc9-4c73-823d-d2ea-d01848516916@quicinc.com>
Date:   Mon, 30 Oct 2023 17:52:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/4] dt-bindings: PCI: qcom-ep: Add support for SA8775P
 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <mani@kernel.org>
CC:     <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <robh@kernel.org>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_schintav@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>
References: <1698413592-26523-1-git-send-email-quic_msarkar@quicinc.com>
 <1698413592-26523-2-git-send-email-quic_msarkar@quicinc.com>
 <45b8f4e1-b915-42f2-aa03-03cc9d1be9f7@linaro.org>
 <4ea52adf-9f64-7aa3-1d88-e90ce1d9ff4d@quicinc.com>
 <fc0e791d-96a5-4557-9963-ec02318b60fb@linaro.org>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <fc0e791d-96a5-4557-9963-ec02318b60fb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G9zukxRlQvEr1NHvT7z2uclVohXF9kTi
X-Proofpoint-GUID: G9zukxRlQvEr1NHvT7z2uclVohXF9kTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300094
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/30/2023 4:20 PM, Krzysztof Kozlowski wrote:
> On 30/10/2023 11:19, Mrinmay Sarkar wrote:
>> On 10/27/2023 7:20 PM, Krzysztof Kozlowski wrote:
>>> On 27/10/2023 15:33, Mrinmay Sarkar wrote:
>>>> Add devicetree bindings support for SA8775P SoC. It has DMA register
>>>> space and dma interrupt to support HDMA.
>>>>
>>>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>>> Unfortunately I do not see any of my comment addressed. :(
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my or other reviewer's previous comments were not fully
>>> addressed. Maybe the feedback got lost between the quotes, maybe you
>>> just forgot to apply it. Please go back to the previous discussion and
>>> either implement all requested changes or keep discussing them.
>>>
>>> Thank you.
>>>
>>> Best regards,
>>> Krzysztof
>> Thanks Krzysztof for your review and patience.
>> Sorry I missed your previous comment.
> Multiple comments. Also from Mani and maybe from others?
I have discussed and addressed all the comments from others.
As per the discussions. Updated commit messages and made
necessary changes in dtsi node.

please correct me otherwise.

>> If I understand correctly by constraining IO space/interrupt,
>> you mean to add maxItems for reg and interrupt for other variants.
>> If so, I verified adding maxItems for these properties and dtb check
>> seems to be good. I will post the same in the next patch series.
>>
>> Thanks,
>> Mrinmay
> Best regards,
> Krzysztof
Thanks,
Mrinmay
>
