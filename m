Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F674AF4F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jul 2023 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjGGLCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jul 2023 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGGLCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jul 2023 07:02:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EA68F;
        Fri,  7 Jul 2023 04:02:00 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3678Q0gZ012151;
        Fri, 7 Jul 2023 11:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DtA01CgRgJ2w20JkUthPOkWS6JWsr9kzeTZI10pqTcY=;
 b=S4DZ47WCux2cOGkY5SJHmfjUd2FSilFz6a2FekOvS4QZvjMtZZS9u2wGbEL28Y0iJm2w
 RW+gK/ntK9CU7xcaWSzEUGdbwoP6w+SVlN9SLO6A1pd+52okRzIbSHThJpGQkToA0QWj
 6eS2UIR/1H5hLMAGtKLQXfBqJrIiguEO3CLmzjBVW2TlHT9/+1JW1JTEdsJVNumTkKL9
 cLCQ+plz7301p8L7uR7iw3poYxuQm8gpegwuqCX41kBmQFMdnXzBxF7dn6Huam4z8b82
 ELwNhlrkjhN/F6Cvl/cO7FbZu+/vL1FmgBox7Q2eWtQTdCbSiBqRsKCgPYG5e0JVigUK uA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rpf6kgf9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 11:01:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 367B1jPE018519
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Jul 2023 11:01:45 GMT
Received: from [10.216.29.164] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 7 Jul
 2023 04:01:39 -0700
Message-ID: <6bad572c-1448-99ea-9af0-ca8ed063ec3f@quicinc.com>
Date:   Fri, 7 Jul 2023 16:31:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 8/8] bus: mhi: ep: wake up host is the MHI state is in
 M3
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <krzysztof.kozlowski@linaro.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Dan Carpenter" <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bo Liu <liubo03@inspur.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
 <1688122331-25478-9-git-send-email-quic_krichai@quicinc.com>
 <20230707062031.GG6001@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707062031.GG6001@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n5QGfxxsetsgTiKatcF41qdrFLfUFX7n
X-Proofpoint-GUID: n5QGfxxsetsgTiKatcF41qdrFLfUFX7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=956 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070102
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 11:50 AM, Manivannan Sadhasivam wrote:
> On Fri, Jun 30, 2023 at 04:22:11PM +0530, Krishna chaitanya chundru wrote:
>> If the MHI state is in M3 then the most probably the host kept the
>> device in D3 hot or D3 cold, due to that endpoint transctions will not
>> be read by the host, so endpoint needs to bring the host to D0 which
>> eventually bring back the MHI state to M0.
>>
> Endpoint cannot bring the host to D0, it can only wake up the host and the host
> will bring the device to D0.
>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/bus/mhi/ep/main.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
>> index 6008818..42d3791 100644
>> --- a/drivers/bus/mhi/ep/main.c
>> +++ b/drivers/bus/mhi/ep/main.c
>> @@ -451,12 +451,14 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
>>   	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
>>   	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
>>   	struct device *dev = &mhi_chan->mhi_dev->dev;
>> +	u32 buf_left, read_offset, count = 0;
>>   	struct mhi_ring_element *el;
>> -	u32 buf_left, read_offset;
>>   	struct mhi_ep_ring *ring;
>>   	enum mhi_ev_ccs code;
>> +	enum mhi_state state;
>>   	void *read_addr;
>>   	u64 write_addr;
>> +	bool mhi_reset;
>>   	size_t tr_len;
>>   	u32 tre_len;
>>   	int ret;
>> @@ -464,6 +466,18 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
>>   	buf_left = skb->len;
>>   	ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
>>   
>> +	if (mhi_cntrl->mhi_state == MHI_STATE_M3) {
>> +		dev_dbg(dev, "wake up by ch id %x\n", mhi_chan->chan);
> This is not needed.
>
>> +		mhi_cntrl->wakeup_host(mhi_cntrl);
>> +	}
>> +
>> +	/* Wait for Host to set the M0 state */
>> +	do {
>> +		msleep(M0_WAIT_DELAY_MS);
>> +		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
>> +		count++;
>> +	} while (state != MHI_STATE_M0 && count < M0_WAIT_COUNT);
>> +
> Move this change to a function like mhi_ep_wake_host().
>
> - Mani

Sure I will change it in next patch.

- KC

>
>>   	mutex_lock(&mhi_chan->lock);
>>   
>>   	do {
>> -- 
>> 2.7.4
>>
