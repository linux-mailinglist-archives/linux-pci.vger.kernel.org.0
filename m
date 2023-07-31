Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F07768B39
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 07:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGaFhl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 01:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjGaFhl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 01:37:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3465DE68;
        Sun, 30 Jul 2023 22:37:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36V4uD1P012327;
        Mon, 31 Jul 2023 05:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LOdUw4qNFn1nUTqsoEBuwGPQSo7xeN13kiNxu0hiQ70=;
 b=Hi1n5l6r7WGMfflzPQXmjoq/Hl67+VWzJRAINNYe13iwaTKhCYBt3vmP3kDnf9/dFHQB
 ATNVjO6flbiaO4DhNeHWphyAu8MZVapyLVhcqGLgJiPTJuxj7BDj2utlCrl2gkNHyokW
 MYhUNCnkjMRbOJq//AU6LoRN+rmZKGB9DKwGY1yyVaKjnBlh2jRr3fTmQFua1+/hWMQh
 IhyNXtjo8xyYZPAIKkkbAWbBo3fck2h4ErTuwqzKt1nOx4MMUmGUdGlQLm2dZW2mgF5f
 uaUymPxa+az6jTLREf/tatqxShSkObOFVoxrgrNu9ZD5/npyqqQqB/+hG37tpy+Ct8A6 pg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4ueujq7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:37:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36V5bWx8013854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 05:37:32 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 30 Jul
 2023 22:37:27 -0700
Message-ID: <27541444-9da2-78de-6174-ba22fcabe08f@quicinc.com>
Date:   Mon, 31 Jul 2023 11:07:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 9/9] bus: mhi: ep: wake up host if the MHI state is in
 M3
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
References: <1689232218-28265-1-git-send-email-quic_krichai@quicinc.com>
 <1689232218-28265-10-git-send-email-quic_krichai@quicinc.com>
 <1399c766-791b-486d-90d5-a00999eb15fb@kadam.mountain>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1399c766-791b-486d-90d5-a00999eb15fb@kadam.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Eq7XhRvqzwE04tMKcRXThNMMNt8Zb5Ui
X-Proofpoint-ORIG-GUID: Eq7XhRvqzwE04tMKcRXThNMMNt8Zb5Ui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=894
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310050
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/28/2023 11:21 AM, Dan Carpenter wrote:
> On Thu, Jul 13, 2023 at 12:40:18PM +0530, Krishna chaitanya chundru wrote:
>> @@ -464,6 +484,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
>>   	buf_left = skb->len;
>>   	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
>>   
>> +	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
>> +		if (mhi_ep_wake_host(mhi_cntrl)) {
>> +			dev_err(dev, "Failed to wakeup host\n");
>> +			return -ENODEV;
>> +		}
> Since you're going to be redoing this patch anyway could you please
> propage the error code:
>
> 		ret = mhi_ep_wake_host(mhi_cntrl);
> 		if (ret) {
> 			dev_err(dev, "Failed to wakeup host\n");
> 			return ret;
> 		}
>
> regards,
> dan carpenter

I will add this in next series.

- KC

>
