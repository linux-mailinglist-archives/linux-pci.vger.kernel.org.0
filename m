Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E05BEF7E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiITV6m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiITV6e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 17:58:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E66B675;
        Tue, 20 Sep 2022 14:58:33 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KL37E9004797;
        Tue, 20 Sep 2022 21:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VSBeGUDtdisVLROlfXirpoYpORUqwXu1rcQth9DasoM=;
 b=b0u4IuTS1VbYcIqowZKXN7stF45MFMI/Sq6q/dIQZ8Xmri+odkNausNWf9/4zYedB4lU
 iMZpMBOJGoRMVzYmxrCb/WjWQiR1iTxgEIhCqlHpUvgfmKxSr2CYk1MwP/jSWQUdoWt8
 ICLiGNkANemHSlcvsf8c/NX05zbaIXyrvnQWBUFkXFoLVytt0ld/2fsTEjMSStw6TSeA
 uDYlwIDf9D4sQC3s5byuYtoFMsKw35qXIvwJGK3obdNo+4BbaeGw5RF1Pvmv7MEYWZJt
 dHNfCPgNZcCyuY2pyL6hzaf0lyIzfEMSS3RoADVLHkuhJaR26VatfDlQ5fdl8aZSlHj4 Hg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq8fw2b49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 21:58:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KLwE4j015808
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 21:58:14 GMT
Received: from [10.110.44.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 14:58:11 -0700
Message-ID: <57eedb21-649b-88a2-b757-06bd05e13fd1@quicinc.com>
Date:   Tue, 20 Sep 2022 14:58:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 1/5] PCI: qcom: Add system suspend and resume support
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        <svarbanov@mm-sol.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@somainline.org>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-phy@lists.infradead.org>,
        <vkoul@kernel.org>, <kishon@ti.com>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
 <1663669347-29308-2-git-send-email-quic_krichai@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1663669347-29308-2-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XadFRIHuUjt_yzIMNHXVNLRNaYLYbSCw
X-Proofpoint-ORIG-GUID: XadFRIHuUjt_yzIMNHXVNLRNaYLYbSCw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_10,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200133
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/2022 3:22 AM, Krishna chaitanya chundru wrote:
> Add suspend and resume syscore ops.
> 
> Few PCIe endpoints like NVMe and WLANs are always expecting the device
> to be in D0 state and the link to be active (or in l1ss) all the time
> (including in S3 state).
> 
> In qcom platform PCIe resources( clocks, phy etc..) can released

can *be* released... ??

> when the link is in L1ss to reduce the power consumption. So if the link
> is in L1ss, release the PCIe resources. And when the system resumes,
> enable the PCIe resources if they released in the suspend path.

if they *were* released... ??

> 
> is_suspended flag indicates if the PCIe resources are released or not
> in the suspend path.
> 
> Its observed that access to Ep PCIe space to mask MSI/MSIX is happening

s/Its/It's/

> at the very late stage of suspend path (access by affinity changes while
> making CPUs offline during suspend, this will happen after devices are
> suspended (after all phases of suspend ops)). If we turn off clocks in

All those parenthesis, thought I was reading Lisp.
Can you rewrite in conversational English?

