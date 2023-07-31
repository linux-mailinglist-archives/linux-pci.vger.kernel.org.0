Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3D768B4A
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 07:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGaFio (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 01:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGaFin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 01:38:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F42199B;
        Sun, 30 Jul 2023 22:38:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V2K9i5008476;
        Mon, 31 Jul 2023 05:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XnRedSNdLIy2U5CPTQIase5ATOdy3by+d5UvM6ptBJw=;
 b=k3r9uPsHGn8BF25HLLWjUn3L1SnCTcBYO31HyKX9PkaUKVqf2t0nSrYOe3rWKRE++7Ti
 WjYHd0lasKrb43mBb/T6txOWl5EWBw3DN4ztyZ+RG5YNoz7DNVMsZIMWWVH2QNNZyhyz
 h9gem0bJ3YpffC06RWNDcIavJTttvwygRggTKWWyP1c5AlCoRBTyrdeoKKi7JSScoAwH
 tZkQFNr+IWT0BXVAlHewOcT3vi1ag13P/VxrWl+xkSs//GdzDkR9ZizGn3TDSHuRs3cd
 OF47rtuNJ+l/d6HGPnd71WW4WC8h0XqbCf8bgS4s5BDASX6wp3gfwJHXPVHSj3BvPG90 nA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ugsaqq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:38:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5c3BN004580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:38:03 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:37:58 -0700
Message-ID: <1ac2154c-e74c-ebec-90d1-11ddf9b3ba1a@quicinc.com>
Date:   Mon, 31 Jul 2023 11:07:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 9/9] bus: mhi: ep: wake up host if the MHI state is in
 M3
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
 <20230728043452.GI4433@thinkpad>
 <15a19a2d-d6e8-4fbc-a31d-561cff00b01a@kadam.mountain>
 <20230728153555.GA9129@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230728153555.GA9129@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JfpkhWHcEX-ES-ZAM7CeEE3vRcPdrZXf
X-Proofpoint-GUID: JfpkhWHcEX-ES-ZAM7CeEE3vRcPdrZXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=936 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 9:05 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 28, 2023 at 08:50:55AM +0300, Dan Carpenter wrote:
>> On Fri, Jul 28, 2023 at 10:04:52AM +0530, Manivannan Sadhasivam wrote:
>>>> @@ -464,6 +484,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
>>>>   	buf_left = skb->len;
>>>>   	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
>>>>   
>>>> +	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
>>>> +		if (mhi_ep_wake_host(mhi_cntrl)) {
>>> Don't you need lock here in the case of multiple queue requests?
>>>
>>> - Mani
>>>
>>>> +			dev_err(dev, "Failed to wakeup host\n");
>>>> +			return -ENODEV;
>>>> +		}
>>>> +	}
>>>> +
>>>>   	mutex_lock(&mhi_chan->lock);
>>          ^^^^^^^^^^^^^^^^^^^^^^^^^^
>> This lock isn't enough?
>>
> The position of this lock won't prevent cocurrent access to mhi_ep_wake_host().
>
> - Mani
I will add the lock in the next series.
>> regards,
>> dan carpenter
