Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8395B8B06
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiINOuz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiINOul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 10:50:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7679B2FFFB;
        Wed, 14 Sep 2022 07:50:39 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EEH6KY003237;
        Wed, 14 Sep 2022 14:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OTY8GuPkdqdk8EUNrFn83pUuir/JISykGcAd92LluLU=;
 b=ZgqFrSOyeyafAKKJaxkUO0G0rd1BuwpZHgTjwNsIyQtfT31waUuVjql+Q/fFuUdKrgP8
 nlTgi7coDbrtKB43GU4JOHlSVRUTecjcjsYhubS7z8qYDAg/JZLTNH6HWL/Ijv/EfJDU
 RisOl2t0JhVAMDUmiAqF33x6eaR0WFLt1X3ywbIFosueIyVvpei/LoOs0k78Y77ihbZP
 KAi1YAAtopNDYWSWOY7n2Tiy/xhieBYF3kikdny/FF6IvLsJK76QTocjOwhaRmt+m2v5
 HE/COrUeoyzxm5MsduQETvOelocutOFztqCjW/TNhLzxsBFlaTvFqTEpnlXVpeIAIGGJ mg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0gje8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:50:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28EEoNc7025556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:50:23 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 14 Sep
 2022 07:50:18 -0700
Message-ID: <87138bc9-2fc0-39fb-89c1-d3826e28594e@quicinc.com>
Date:   Wed, 14 Sep 2022 20:20:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 3/5] phy: core: Add support for phy power down & power
 up
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
 <1662713084-8106-4-git-send-email-quic_krichai@quicinc.com>
 <CAA8EJppgaAuEDU44ePOt+ZWK0_rNsXHnE3WOEc9F-n=VE=3aVQ@mail.gmail.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAA8EJppgaAuEDU44ePOt+ZWK0_rNsXHnE3WOEc9F-n=VE=3aVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TU-05IkEFPn5b2aXCDOWOP7oMH83nch1
X-Proofpoint-GUID: TU-05IkEFPn5b2aXCDOWOP7oMH83nch1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140071
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/9/2022 2:34 PM, Dmitry Baryshkov wrote:
> On Fri, 9 Sept 2022 at 11:45, Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
>> Introducing phy power down/up callbacks for allowing to park the
>> link-state in L1ss without holding any PCIe resources during
>> system suspend.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
>>   include/linux/phy/phy.h | 20 ++++++++++++++++++++
>>   2 files changed, 50 insertions(+)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index d93ddf1..1b0b757 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -441,6 +441,36 @@ int phy_set_speed(struct phy *phy, int speed)
>>   }
>>   EXPORT_SYMBOL_GPL(phy_set_speed);
>>
>> +int phy_power_down(struct phy *phy)
>> +{
>> +       int ret;
>> +
>> +       if (!phy || !phy->ops->power_down)
>> +               return 0;
>> +
>> +       mutex_lock(&phy->mutex);
>> +       ret = phy->ops->power_down(phy);
>> +       mutex_unlock(&phy->mutex);
>> +
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(phy_power_down);
>> +
>> +int phy_power_up(struct phy *phy)
>> +{
>> +       int ret;
>> +
>> +       if (!phy || !phy->ops->power_up)
>> +               return 0;
>> +
>> +       mutex_lock(&phy->mutex);
>> +       ret = phy->ops->power_up(phy);
>> +       mutex_unlock(&phy->mutex);
>> +
>> +       return ret;
>> +}
> As it can be seen from the phy_power_off(), the PHY can be a shared
> resource, with the power_count counting the number of users that
> requested the PHY to be powered up. By introducing suc calls you break
> directly into this by allowing a single user to power down the PHY, no
> matter how many other users have requested the PHY to stay alive.

can we use same power_count in this function also here and restrict the 
single user to

power down the PHY same like phy_power_off?.

>> +EXPORT_SYMBOL_GPL(phy_power_up);
>> +
>>   int phy_reset(struct phy *phy)
>>   {
>>          int ret;
>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
>> index b141375..3a45f4d 100644
>> --- a/include/linux/phy/phy.h
>> +++ b/include/linux/phy/phy.h
>> @@ -76,6 +76,8 @@ union phy_configure_opts {
>>    * @set_mode: set the mode of the phy
>>    * @set_media: set the media type of the phy (optional)
>>    * @set_speed: set the speed of the phy (optional)
>> + * @power_down: parking the phy in power down state
>> + * @power_up: pulling back the phy from power down
>>    * @reset: resetting the phy
>>    * @calibrate: calibrate the phy
>>    * @release: ops to be performed while the consumer relinquishes the PHY
>> @@ -89,6 +91,8 @@ struct phy_ops {
>>          int     (*set_mode)(struct phy *phy, enum phy_mode mode, int submode);
>>          int     (*set_media)(struct phy *phy, enum phy_media media);
>>          int     (*set_speed)(struct phy *phy, int speed);
>> +       int     (*power_down)(struct phy *phy);
>> +       int     (*power_up)(struct phy *phy);
>>
>>          /**
>>           * @configure:
>> @@ -226,6 +230,8 @@ int phy_init(struct phy *phy);
>>   int phy_exit(struct phy *phy);
>>   int phy_power_on(struct phy *phy);
>>   int phy_power_off(struct phy *phy);
>> +int phy_power_down(struct phy *phy);
>> +int phy_power_up(struct phy *phy);
>>   int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode);
>>   #define phy_set_mode(phy, mode) \
>>          phy_set_mode_ext(phy, mode, 0)
>> @@ -349,6 +355,20 @@ static inline int phy_power_off(struct phy *phy)
>>          return -ENOSYS;
>>   }
>>
>> +static inline int phy_power_down(struct phy *phy)
>> +{
>> +       if (!phy)
>> +               return 0;
>> +       return -ENOSYS;
>> +}
>> +
>> +static inline int phy_power_up(struct phy *phy)
>> +{
>> +       if (!phy)
>> +               return 0;
>> +       return -ENOSYS;
>> +}
>> +
>>   static inline int phy_set_mode_ext(struct phy *phy, enum phy_mode mode,
>>                                     int submode)
>>   {
>> --
>> 2.7.4
>>
>
