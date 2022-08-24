Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3459F21A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 05:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbiHXDi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 23:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXDiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 23:38:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E25185FE3;
        Tue, 23 Aug 2022 20:38:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O1s7eP027641;
        Wed, 24 Aug 2022 03:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KZsDBZSEb3xvcwG3jwL4w18dH1+pwuI8k8BPzIish9M=;
 b=biep5alvzWGO0T5RypPiAKmJwix253KnrilrA3byUq3rTDr2Wf9nRmiyOKzDBtNEWVX9
 Xa7tyJ7es0OOG4AtGXfPhh5FACK+7vud52d3Nn3bBz0mbV9LwMXOESVcgaIqL2FQa6fZ
 GpSc4wpKRdfCKI59ebKdgRoCxKDWJ1+YTtuDlxRbZrJwANXxbGAZTIiUWp2y/9TBeZUN
 n8/MBcPyFHj7ta5Ip9XpjWBI9MyKU1FNIx68OXTjgf60ggV/SaMogIK6q/SqGxWK7O77
 j2Nu4+s3cQZQmow/KrJwTSoAXb5ypOScmjMxodjwtABlr15opk2Cb5jx/55OmcPhNH13 Cw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pk9tbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 03:38:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27O3cBiS015815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 03:38:11 GMT
Received: from [10.216.7.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 20:38:03 -0700
Message-ID: <3d052733-3600-b6eb-baf3-d8806a150af3@quicinc.com>
Date:   Wed, 24 Aug 2022 09:07:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/3] PCI: qcom: Restrict pci transactions after pci
 suspend
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <dmitry.baryshkov@linaro.org>, Jingoo Han <jingoohan1@gmail.com>,
        "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-3-git-send-email-quic_krichai@quicinc.com>
 <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAE-0n500y-n+ZjasYQRAa3JgamQG1c+Aqn0YiX-i0L-w6C4dbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cXMSa4OdJ5IgAjnCWR0QU13Pfw7L4H8N
X-Proofpoint-ORIG-GUID: cXMSa4OdJ5IgAjnCWR0QU13Pfw7L4H8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_02,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/9/2022 12:42 AM, Stephen Boyd wrote:
> Quoting Krishna chaitanya chundru (2022-08-03 04:28:53)
>> If the endpoint device state is D0 and irq's are not freed, then
>> kernel try to mask interrupts in system suspend path by writing
>> in to the vector table (for MSIX interrupts) and config space (for MSI's).
>>
>> These transactions are initiated in the pm suspend after pcie clocks got
>> disabled as part of platform driver pm  suspend call. Due to it, these
>> transactions are resulting in un-clocked access and eventually to crashes.
> Why are the platform driver pm suspend calls disabling clks that early?
> Can they disable clks in noirq phase, or even later, so that we don't
> have to check if the device is clocking in the irq poking functions?
> It's best to keep irq operations fast, so that irq control is fast given
> that these functions are called from irq flow handlers.

We are registering the pcie pm suspend ops as noirq ops only. And this 
msix and config

access is coming at the later point of time that is reason we added that 
check.

