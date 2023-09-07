Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2847975C0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 17:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjIGPyf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 11:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244679AbjIGPup (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 11:50:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25615FEA;
        Thu,  7 Sep 2023 08:41:26 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3871w8RI009983;
        Thu, 7 Sep 2023 06:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FrKioFJnJmZEzBViRh3NVayzX7hDwVyAOzYyYCeCBeg=;
 b=dk11p3GCJlbOboJmvA2Ff+OmH8752KJC7YM+lAXfjuiq1TaQ1ctiFdl0G8F7tyLmgOhT
 9z5mDI+OS1849DZ0wrrUD63va2ueShZMRvoGkPi/DKo153mDWLN62H2HhvC3I/ELDdW8
 8A+BOwSsHIzQETH9xsUM05GimhzHHx5jzN0+s13Ur0ns5bG7rOs7vCxK0woKgFHo50aa
 yPFKIAWR9l41+/isrIYRtaUDyjuqp077DVWFQlEFaC/OFp0tPx9XUOHD8UHZaPM/nHT1
 7OjsNgsxBNSnBCoOUFbyKx9uTAAQZlG7U+zlcD+bdrISRidPrEhhfs84N+J0sNfAN5VH +A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxpt02m9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:01:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38761rY3029945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 06:01:53 GMT
Received: from [10.216.2.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 23:01:45 -0700
Message-ID: <0e54ca7e-0416-8969-d9ba-c476ae2f6c5b@quicinc.com>
Date:   Thu, 7 Sep 2023 11:31:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 1/4] dt-bindings: pci: qcom: Add opp table
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
 <1692717141-32743-2-git-send-email-quic_krichai@quicinc.com>
 <0d99dab6-492e-4cd8-9a1d-ab084db304b5@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <0d99dab6-492e-4cd8-9a1d-ab084db304b5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W0w-LDAS6gEmv0QcJf8SPy-1Ml2PLv_c
X-Proofpoint-GUID: W0w-LDAS6gEmv0QcJf8SPy-1Ml2PLv_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=573
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070052
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/22/2023 9:36 PM, Konrad Dybcio wrote:
> On 22.08.2023 17:12, Krishna chaitanya chundru wrote:
>> PCIe needs to choose the appropriate performance state of RPMH power
>> domain based upon the PCIe gen speed.
>>
>> Adding the Operating Performance Points table allows to adjust power domain
>> performance state, depending on the PCIe gen speed.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> I only got patches 1, 2 and 4 of this series.
>
> Please consider using the b4 tool [1], which takes care of
> all of the sending shenanigans for you.
>
> Konrad
>
> [1] https://b4.docs.kernel.org/en/latest/index.html
Sorry, for late reply I have taken care of this in next patch series.
