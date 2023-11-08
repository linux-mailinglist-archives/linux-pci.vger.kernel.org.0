Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63B7E4EF2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 03:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjKHCcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 21:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKHCco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 21:32:44 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E2A10F8;
        Tue,  7 Nov 2023 18:32:42 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A828BBl008611;
        Wed, 8 Nov 2023 02:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=g4Cv5ypflLdXhHFj4Pj/RaVxQ6QZsT6ZxFVJnc4pP1c=;
 b=XFBb1Ga/BlR9EWzRmIeehfQNpy6scDDk2zhmDMAzsclD9tPZPtLMJL4TH389oiX/qZ1Y
 nDAWOtPnJabiKUCFb8g2elk4EZBMFY+NPtws2AtRZR54tpdqC//m6AXbSZj9E79mODur
 Q1SyXfgkXK6sNnXWNyKXgnFz7FDojcJXWEHX7he+0QGeSPm1PwSShkoXA6ketOypluVz
 Ls8GZ4HG4O682Wjl0dcuB0WHCCYtkBMKxiNcJR5dMaVWB6ePrDcPG+NusRy8dYWZ7R0B
 ht4Nu7mB/zPoMkB0EryduOLj6ZwnKRhd3wemjpmgw0Hppii8E+17tmxsqHcnEjDguMLM Vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7w2cgfqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 02:32:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A82WYHd028868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Nov 2023 02:32:34 GMT
Received: from [10.216.1.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 7 Nov
 2023 18:32:23 -0800
Message-ID: <15a98ec0-214b-218b-1e3c-c09f770fce2e@quicinc.com>
Date:   Wed, 8 Nov 2023 08:02:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 5/5] PCI: qcom: Add OPP support to scale performance
 state of power domain
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <vireshk@kernel.org>, <nm@ti.com>,
        <sboyd@kernel.org>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <rafael@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_parass@quicinc.com>
References: <20231102053013.7yt7pxin5awlu7w7@vireshk-i7>
 <20231102120950.GA115288@bhelgaas>
 <20231103051247.u4cnckzstcvs4lf5@vireshk-i7>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20231103051247.u4cnckzstcvs4lf5@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2-gJotlcQ3gh9-6L_23Y87F28GMFBywc
X-Proofpoint-ORIG-GUID: 2-gJotlcQ3gh9-6L_23Y87F28GMFBywc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0
 bulkscore=0 mlxlogscore=850 suspectscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080019
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/3/2023 10:42 AM, Viresh Kumar wrote:
> On 02-11-23, 07:09, Bjorn Helgaas wrote:
>> On Thu, Nov 02, 2023 at 11:00:13AM +0530, Viresh Kumar wrote:
>>> On 01-11-23, 17:17, Bjorn Helgaas wrote:
>>>> Can you expand "OPP" somewhere so we know what it stands for?  I'm
>>>> sure everybody knows except me :)
>>> It is "Operating Performance Points", defined here:
>>>
>>> Documentation/power/opp.rst
>> Thanks; I meant in the subject or commit log of the next revision, of
>> course.
> Yeah, I understood that. Krishna shall do it in next version I believe.
>
Hi All,

I will do this in my next patch both commit message and ICC voting 
through OPP

got stuck in some other work, will try to send new series as soon as 
possible.

- Krishna Chaitanya.

