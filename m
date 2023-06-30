Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6C3743412
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjF3FYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjF3FYD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 01:24:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E863582;
        Thu, 29 Jun 2023 22:24:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U3dKNq012758;
        Fri, 30 Jun 2023 05:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mj6wX2KA43uAPJblUQsVcowVMD/0UB1oOGxjrxVozck=;
 b=TDw1Zv+NIQx1eT7lWOCrmL2UkSEAqcLYGyLw3wcHNNJPr2jfOIji4ShDJCaePs0v2iIn
 S8TJ4LtKgxYzo5MBp612Npxni8vnwXLI6aTTwV5MipEau+XG9EwRvcNC8badVQtfExZZ
 l1p6gqlWlUdCzyclHIAev5kbU9h+QQJ0c0OXOftdAhj0TIvMrMzwdIC4sVvrjbsM9bHy
 o+fe6oZaeubXFphj+GX1tw9EUEMr/Rem5HsKeqpQtuyX/0hxHhTePUTil+GWtUt/t4nT
 Eqmbe6HFO4vcaAZqoncQa0a2S7h1wp1RItAX0foUu+O8etqZqkcTAJK1G22U2CkS6F3k Tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh4y6adk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:23:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U5Nsw7014005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 05:23:54 GMT
Received: from [10.216.50.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Thu, 29 Jun
 2023 22:23:49 -0700
Message-ID: <80fb4e0e-565e-4a75-9602-5867e5c7a40a@quicinc.com>
Date:   Fri, 30 Jun 2023 10:53:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/4] IPQ8074 pcie/wcss fixes
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
References: <20230623093445.3977772-1-quic_srichara@quicinc.com>
 <20230624063401.GG5611@thinkpad>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230624063401.GG5611@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PzowPYiIRUEzpdLjEgHc5AT0BeLOcHRa
X-Proofpoint-ORIG-GUID: PzowPYiIRUEzpdLjEgHc5AT0BeLOcHRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=654 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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



On 6/24/2023 12:04 PM, Manivannan Sadhasivam wrote:
> On Fri, Jun 23, 2023 at 03:04:41PM +0530, Sricharan Ramabadhran wrote:
>> These are required to have pcie/wcss working on IPQ8074 based
>> boards. Pcie was broken recently, first patch fixes that and
>> next 2 are for adding WCSS reset and 1 for adding reserved region
>> for NSS.
>>
>> Will be following this up with few more dts updates and pcie
>> fixes.
>>
> 
> Since there is no direct relation between pcie and clk patches, these should've
> been submitted separately.
> 

  ok, just grouped them as a miscellaneous. Will post the pcie fix
  separately.

Regards,
  Sricharan
