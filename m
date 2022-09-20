Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804945BE290
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiITKAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiITKAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:00:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE6ADF13;
        Tue, 20 Sep 2022 03:00:09 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xi2Q013764;
        Tue, 20 Sep 2022 10:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=e+Mjuh5gg+qCqPNY3CWaWhGM9M/UVXbWGlTVwOxGB3k=;
 b=NQUQMa4corel2l/91rbA435gqIz45nQD2IhHv1UkZbZXemmP5KPyxf3w1J3oif2nIYxp
 2s5O6bbwi0zE7qmHVRpBKt0Akl8QNlXV5vRELrrQFK+s8ZfNoLGomihkQcK19ljzuq3n
 zNycduep2EbDAYwGmXpgNm/D+iAUjpKj0c24UFUeeK3auJwKqb40K6DibMMeLxw/UmsG
 t01QZ7btD4XRYybsBvOtaSZYg5khO6JBzmySvWyyqifx9RAM4J2j6ScqBwE2li8wgKda
 enPmkOTVoEIbG2qppKrBrnW2XG0cIA01SDNARR2fRqbh724nsEOvVb8oI08FfYgvMge+ Jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq4r09byk-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:00:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28K9fCno028326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 09:41:12 GMT
Received: from [10.216.24.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 02:41:07 -0700
Message-ID: <48c560ef-67fd-8903-a7c0-2fd7a9bd6b19@quicinc.com>
Date:   Tue, 20 Sep 2022 15:11:04 +0530
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
 <87138bc9-2fc0-39fb-89c1-d3826e28594e@quicinc.com>
 <bd6fc826-94b9-f539-a37e-820ab49b9d14@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <bd6fc826-94b9-f539-a37e-820ab49b9d14@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9dhGy6_L9UqGlSWt1h6AUQAw-scBXFcn
X-Proofpoint-GUID: 9dhGy6_L9UqGlSWt1h6AUQAw-scBXFcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=899
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200060
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/19/2022 10:59 PM, Dmitry Baryshkov wrote:
> On 14/09/2022 17:50, Krishna Chaitanya Chundru wrote:
>>
>> On 9/9/2022 2:34 PM, Dmitry Baryshkov wrote:
>>> On Fri, 9 Sept 2022 at 11:45, Krishna chaitanya chundru
>>> <quic_krichai@quicinc.com> wrote:
>>>> Introducing phy power down/up callbacks for allowing to park the
>>>> link-state in L1ss without holding any PCIe resources during
>>>> system suspend.
>>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>   drivers/phy/phy-core.c  | 30 ++++++++++++++++++++++++++++++
>>>>   include/linux/phy/phy.h | 20 ++++++++++++++++++++
>>>>   2 files changed, 50 insertions(+)
>>>>
>>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>>> index d93ddf1..1b0b757 100644
>>>> --- a/drivers/phy/phy-core.c
>>>> +++ b/drivers/phy/phy-core.c
>>>> @@ -441,6 +441,36 @@ int phy_set_speed(struct phy *phy, int speed)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(phy_set_speed);
>>>>
>>>> +int phy_power_down(struct phy *phy)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       if (!phy || !phy->ops->power_down)
>>>> +               return 0;
>>>> +
>>>> +       mutex_lock(&phy->mutex);
>>>> +       ret = phy->ops->power_down(phy);
>>>> +       mutex_unlock(&phy->mutex);
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(phy_power_down);
>>>> +
>>>> +int phy_power_up(struct phy *phy)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       if (!phy || !phy->ops->power_up)
>>>> +               return 0;
>>>> +
>>>> +       mutex_lock(&phy->mutex);
>>>> +       ret = phy->ops->power_up(phy);
>>>> +       mutex_unlock(&phy->mutex);
>>>> +
>>>> +       return ret;
>>>> +}
>>> As it can be seen from the phy_power_off(), the PHY can be a shared
>>> resource, with the power_count counting the number of users that
>>> requested the PHY to be powered up. By introducing suc calls you break
>>> directly into this by allowing a single user to power down the PHY, no
>>> matter how many other users have requested the PHY to stay alive.
>>
>> can we use same power_count in this function also here and restrict 
>> the single user to
>>
>> power down the PHY same like phy_power_off?.
>
> What is the difference between power_off() and power_down()?

In power_off  we are turning off PCIe PHY-specific clocks, and also 
resetting the PHY due to this PCIe link
also will go down. To retain, the PCIe link state in l1ss with PHY 
clocks turned off, we need
park PCIe PHY in the power-down state and skip the resets of the PHY so 
that it can maintain the link state in l1ss
with the help of the always-on power domain aka MX).

To support this PHY Power-down state PHY driver has been updated with 
new interface APIs.

Initially we added phy_suspend & phy_resume to phy but as this API's are 
already used by drivers/net/phy/phy_device.c we are getting compilation 
errors.

So we used these power_down & power up.

As power_off & power_down is confusing we will change new api's 
power_down & power_up to phy_pm_suspend & phy_pm_resume in

the next patch series.
>
>
