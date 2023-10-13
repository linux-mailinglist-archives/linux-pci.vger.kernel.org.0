Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5627C8659
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 15:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjJMNEP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjJMNEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 09:04:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87206CF;
        Fri, 13 Oct 2023 06:04:10 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DBll0m007023;
        Fri, 13 Oct 2023 13:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gk42qaoLNddKysFeceY+W12+6tch9B+vp6mMXDw5XcY=;
 b=lqekpmIPmIjNViKyYq9S2NHvzVBTdyFJFllgqu5xgZdvkTNxICokE5aNVBeyju7zZIk9
 WBVoq9Abr7BDLfVXRzwo4QjFo3ARSgf+Tby/uqce7nW3Eh1oaFJaQEiJPFwT2RnlkOve
 aGLC30MWJIki3yNxDyMXHHydu/l+kGmJEaHuiqER9cLd8/2mUMkTA4q8ieNJDYs99SS/
 BsFcfI8gtitc+NSqbN4pv85CfKLCiOvhu5ciquivhw6P7fqJXZogFc26phrFowu51KdH
 QoMs/NYQFsV+X+vSKmpS0YWzjgo63Iy75p5j2KPca58njqp/yEcdQO/mJTg0HEBCU9Tl MQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tpt11hqns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:03:51 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39DD3of5028742
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Oct 2023 13:03:50 GMT
Received: from [10.216.5.96] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 13 Oct
 2023 06:03:42 -0700
Message-ID: <4aba3ad7-c1b0-cac6-9f02-ac1258b27dee@quicinc.com>
Date:   Fri, 13 Oct 2023 18:33:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 2/5] PCI: qcom-ep: Add support for SA8775P SoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mani@kernel.org>
CC:     <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_parass@quicinc.com>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-phy@lists.infradead.org>
References: <1695218113-31198-1-git-send-email-quic_msarkar@quicinc.com>
 <1695218113-31198-3-git-send-email-quic_msarkar@quicinc.com>
 <4b20d3bb-d2d2-0864-013f-104e26ae558c@linaro.org>
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <4b20d3bb-d2d2-0864-013f-104e26ae558c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BUHS7wb-AyXwb10BhMuVb9rCZHwk2m0v
X-Proofpoint-ORIG-GUID: BUHS7wb-AyXwb10BhMuVb9rCZHwk2m0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_04,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=852 impostorscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130108
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/20/2023 7:54 PM, Konrad Dybcio wrote:
>
>
> On 9/20/23 15:55, Mrinmay Sarkar wrote:
>> Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
>> driver.
>>
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
> This compatible does not bring anything new to the table
> on its own. Please create a fallback compatible, document it
> in the bindings and use that. See [1] and [2] for example.
>
> Konrad
>
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml?h=next-20230920
>
> [2] 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/qcom/pm7550ba.dtsi?h=next-20230920#n65

Hi Konrad,

yes as of now this compatible does not bring anything new to the table.
recently we got additional feature regarding cache coherency for sa8775p
for that we need to add change only for sa8775p.
that's why we need to add the compatible for sa8775p.
and I will be uploading patch for that in some days.

Thanks,
Mrinmay
