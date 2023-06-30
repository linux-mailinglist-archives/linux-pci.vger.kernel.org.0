Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A448874340A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 07:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF3FWg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 01:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjF3FWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 01:22:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06D2D69;
        Thu, 29 Jun 2023 22:22:34 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4XWVx017861;
        Fri, 30 Jun 2023 05:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gKsS/01MXpL4I+QnaLU3C0pJ34xWCicExHRxGvK3uU8=;
 b=cAqLqMl9Y7PN9Hi0in9e1CTqweO1B3PtUtl9VGECSS/HumOPpop/JT6XaZtFwGyFM+1d
 MNbadG9JkZc6itr7lph24qhw4N8g9K4tQ822nN2yA+8dUt67AW5pLNg0QeYlcRFGLwpQ
 6/7YV616iF7pivqsdd3e+IhL0J3LgABC8ojoreN+0fAbchOks3QUKPryeeAIbMlbhJWX
 UnBJ4O/xbFNGvkNzQHa+c6kPmq7WiGsyPDLgHDbwQwmudY17Wrtbpky1oIt1DjHUYJQ2
 DbJX8G3Wn2vVu1tlZoQC6MHyV95F7etJWGRCXXUYWUOz1A4S/vUqd2knvm08rHeyzM4k bQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgy1tjxn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:22:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U5MOmf004591
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:22:24 GMT
Received: from [10.216.50.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Thu, 29 Jun
 2023 22:22:19 -0700
Message-ID: <c226d063-a8e9-d9b8-e070-bc15f7c7ec47@quicinc.com>
Date:   Fri, 30 Jun 2023 10:52:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/4] pcie: qcom: Fix the macro
 PARF_SLV_ADDR_SPACE_SIZE_2_3_3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20230623180026.GA181743@bhelgaas>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230623180026.GA181743@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RZxAVXWhfyM6WiiZ-h3zv8OhuurrW3Ej
X-Proofpoint-GUID: RZxAVXWhfyM6WiiZ-h3zv8OhuurrW3Ej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=877 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300046
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 6/23/2023 11:30 PM, Bjorn Helgaas wrote:
> On Fri, Jun 23, 2023 at 03:04:42PM +0530, Sricharan Ramabadhran wrote:
>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro used for IPQ8074
>> pcie slave addr size was initially set to 0x358, but
>> was wrongly changed to 0x168 as a part of
>> 'PCI: qcom: Sort and group registers and bitfield definitions'
>> Fixing it back to right value here.
> 
> 1) Make your subject line match the history.  For example, you're
> fixing 769e49d87b15 ("PCI: qcom: Sort and group registers ..."), so
> your subject line should start with "PCI: qcom: ...".
> 

  ok, will fix.

> 2) It doesn't look like 769e49d87b15 changed
> PARF_SLV_ADDR_SPACE_SIZE_2_3_3:
> 
>    $ git show 769e49d87b15 | grep PARF_SLV_ADDR_SPACE_SIZE_2_3_3
>    +#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP ver 2.3.3 */
>    -#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP rev 2.3.3 */
> 
> What am I missing here?  Do you have another out-of-tree patch that
> broke this?

  39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
                register definitions") broke it. Will change and post .

Regards,
  Sricharan
