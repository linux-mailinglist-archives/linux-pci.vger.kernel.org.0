Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF175AB83
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 11:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjGTJzq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjGTJzn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 05:55:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72663189;
        Thu, 20 Jul 2023 02:55:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K6wSsM016618;
        Thu, 20 Jul 2023 09:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XJxwtEiFZYX7CF+CV/wE/e2ibf8vhO0A+NXvjImgOcc=;
 b=CE8qbrETYpTqOoegH+XPxzEyfUF+QaY7OUa+kzs2bGnsnFqSqKfi6Ofws6eUe5nxF/xl
 WM6oVmeXLOYRk8uEnsuBGiqHt4PDL24tGHt3Jsm3Vl9+Hl19Ms+xKdmR+Q3CzCBBeGmy
 XyZz0yn5Q+Xtj0q9EmenhUPV15N08crwO2yyIpGWebD79P3Y2fN8c1mpKXGAlwRZ3Efy
 W/Ew0up9H9q1Q3ZiooQs9crW2abVTn1Y2Tu/ZI/Tk0/jPYu1+SGLVyDimvOkrOZwt/a7
 DvLRVT/0jlc6SNFkJ80qapy776QFTBBBdKtLFrKVqOj1X84xpZDPnMt/UV/CEmGck6tp Zg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxummrtdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 09:55:30 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K9tTBK003341
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 09:55:29 GMT
Received: from [10.201.3.182] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 02:55:25 -0700
Message-ID: <8194aa14-6465-5b4d-1b13-72c6af818f82@quicinc.com>
Date:   Thu, 20 Jul 2023 15:25:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V4] PCI: qcom: Fixing broken pcie bring up for 2_3_3
 configs ops
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Greg KH <gregkh@linuxfoundation.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh@kernel.org>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <bhelgaas@google.com>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230717065535.2065582-1-quic_srichara@quicinc.com>
 <2023071729-shamrock-evidence-b698@gregkh>
 <2fc238aa-82c1-383a-9dca-72f979ee3c07@quicinc.com>
 <CAA8EJpoB6Q5c27-D5HF42+OS7S7bPBGWi_Po0orMxaQ7yx3=1A@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAA8EJpoB6Q5c27-D5HF42+OS7S7bPBGWi_Po0orMxaQ7yx3=1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rr1XJxaMVM1MYVkl0a43KMKaCFQg7qMd
X-Proofpoint-GUID: rr1XJxaMVM1MYVkl0a43KMKaCFQg7qMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_03,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=705
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200082
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/17/2023 11:23 PM, Dmitry Baryshkov wrote:
> On Mon, 17 Jul 2023 at 20:16, Sricharan Ramabadhran
> <quic_srichara@quicinc.com> wrote:
>>
>>
>>
>> On 7/17/2023 7:09 PM, Greg KH wrote:
>>> On Mon, Jul 17, 2023 at 12:25:35PM +0530, Sricharan Ramabadhran wrote:
>>>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
>>>> 2_3_3 post_init ops. PCIe slave addr size was initially set
>>>> to 0x358, but was wrongly changed to 0x168 as a part of
>>>> commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
>>>> register definitions"). Fixing it, by using the right macro
>>>> PARF_SLV_ADDR_SPACE_SIZE and remove the unused
>>>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
>>>
>>> Note, you do have a full 72 columns to use, no need to make it smaller.
>>
>>    ok sure
>>
>>>
>>>> Without this pcie bring up on IPQ8074 is broken now.
>>>
>>> I do not understand, something that used to work now breaks, or this is
>>> preventing a new chip from being "brought up"?
>>>
>>
>>    yes, ipq8074 pcie which was previously working is broken now.
>>    This patch fixes it.
> 
> So, you need to describe what is broken and why. Mere "it is broken,
> fix it" is not enough.

  ok sure, will change the subject and explicitly state in commit log
  how pcie enumeration is broken up.


Regards,
  Sricharan

