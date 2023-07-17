Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D449E7569F4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGQRQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGQRQB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 13:16:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6249819F;
        Mon, 17 Jul 2023 10:16:00 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HGvqJp030261;
        Mon, 17 Jul 2023 17:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3tPIZA9DnySEarrlQU8wHxA+hbKEZ2uIUFPiISS7alg=;
 b=RYfKAh0zxDHpCBiTu4PdPp4rlN9EVyUJWD7fdmk9wBUiqtft/nfvr9VHibbkeecE+y3C
 EIVWl0DC5huUe5C0mKjsRHZm7tKpPCZRjXboawfk9/Ti0cKbESKa7u020igZmL5qzK+J
 rN4XUEFtH8vFJwGwcx4jtLBC+ZziFJiZfG/wZfolzXZSBuaSFH8hsQ6zI4GaG8N8aJah
 e6etSzn0iIv1oUGu/OhOzViy00G3Vu1mxd/o7w0UeR8GVGuOQu05aLz3TGQPZpx8yxy5
 0oSQrME4QBGpchiPWBtd716BemZfw1xQ9ceKSxyaZTDO/gS6U1Su4RK9zRNtj+5Wvqer OA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rw289s82w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 17:15:50 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36HHFoNK011739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 17:15:50 GMT
Received: from [10.216.47.191] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 17 Jul
 2023 10:15:46 -0700
Message-ID: <2fc238aa-82c1-383a-9dca-72f979ee3c07@quicinc.com>
Date:   Mon, 17 Jul 2023 22:45:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V4] PCI: qcom: Fixing broken pcie bring up for 2_3_3
 configs ops
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh@kernel.org>, <mani@kernel.org>,
        <lpieralisi@kernel.org>, <bhelgaas@google.com>, <kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230717065535.2065582-1-quic_srichara@quicinc.com>
 <2023071729-shamrock-evidence-b698@gregkh>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <2023071729-shamrock-evidence-b698@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zh38zpLXZ1BNI7moZ8bAuc7kOwjinL_J
X-Proofpoint-GUID: zh38zpLXZ1BNI7moZ8bAuc7kOwjinL_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=677
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170159
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/17/2023 7:09 PM, Greg KH wrote:
> On Mon, Jul 17, 2023 at 12:25:35PM +0530, Sricharan Ramabadhran wrote:
>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3 macro is used for IPQ8074
>> 2_3_3 post_init ops. PCIe slave addr size was initially set
>> to 0x358, but was wrongly changed to 0x168 as a part of
>> commit 39171b33f652 ("PCI: qcom: Remove PCIE20_ prefix from
>> register definitions"). Fixing it, by using the right macro
>> PARF_SLV_ADDR_SPACE_SIZE and remove the unused
>> PARF_SLV_ADDR_SPACE_SIZE_2_3_3.
> 
> Note, you do have a full 72 columns to use, no need to make it smaller.

  ok sure

> 
>> Without this pcie bring up on IPQ8074 is broken now.
> 
> I do not understand, something that used to work now breaks, or this is
> preventing a new chip from being "brought up"?
> 

  yes, ipq8074 pcie which was previously working is broken now.
  This patch fixes it.


Regards,
  Sricharan
