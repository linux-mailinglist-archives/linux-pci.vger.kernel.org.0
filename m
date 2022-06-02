Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44DE53B679
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiFBKAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 06:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiFBJ76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 05:59:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E6DF18;
        Thu,  2 Jun 2022 02:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654163997; x=1685699997;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oEEj+A9pnUduVQQjYXMOUSV+bJSw2QHxm5LpK0OWpF4=;
  b=U0+MVRABFrmkQqRavbv2D5myiZNr0mugBWWsXDt3hAx201obnhGJtZtc
   e7H6I1zfwODWJg/ysxcfecQNRahm25HrjmmIvFzvCZj/Q3TG9z7Qm/0YB
   tyuicJDuhYz/9H+f09d5foKKa6B3evbHhESibM+9yyt7aNYQhE+aayMka
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 02:59:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 02:59:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 02:59:55 -0700
Received: from [10.216.21.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 02:59:50 -0700
Message-ID: <47d89a85-5f10-ebf9-1d62-fb886319b2c4@quicinc.com>
Date:   Thu, 2 Jun 2022 15:29:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3] PCI/ASPM: Update LTR threshold based upon reported max
 latencies
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <swboyd@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>, <vidyas@nvidia.com>,
        <kenny@panix.com>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
 <1654086232-17055-1-git-send-email-quic_krichai@quicinc.com>
 <91b75542-8e4c-5b91-bbfd-38ffc456c12e@quicinc.com>
 <20220602082938.GA4936@thinkpad>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220602082938.GA4936@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/2/2022 1:59 PM, Manivannan Sadhasivam wrote:
> On Wed, Jun 01, 2022 at 05:57:53PM +0530, Krishna Chaitanya Chundru wrote:
>> [+cc kenny, vidya]
>>
>> On 6/1/2022 5:53 PM, Krishna chaitanya chundru wrote:
>>> In ASPM driver, LTR threshold scale and value is updating based on
> s/is/are
>
> s/updating/updated
>
>>> tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
>>> LTR threshold scale and value is greater values than max snoop/non-snoop
> s/is/are
>
>>> value.
>>>
>>> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
>>> reported snoop/no-snoop values is greather than or equal to
>>> LTR_L1.2_THRESHOLD value.
>>>
>>> Suggested-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> If you are inheriting the patch from Prasad, then you should still give the
> authorship to him (unless the patch has changed significantly). You can add
> your S-o-b tag to convey that you are carrying the patch from him.
Thanks mani for pointing this, I will modify this in next patch.
>>> ---
>>>
>>> I am takking this patch forward as prasad is no more working with our org.
>>>
>>> Changes since v2:
>>> 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
>>> Changes since v1:
>>> 	- Added missing variable declaration in v1 patch
>>> ---
>>>    drivers/pci/pcie/aspm.c | 22 +++++++++++++++++++++-
>>>    1 file changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index a96b742..4a15e50 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -465,10 +465,19 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>    	u32 ctl1 = 0, ctl2 = 0;
>>>    	u32 pctl1, pctl2, cctl1, cctl2;
>>>    	u32 pl1_2_enables, cl1_2_enables;
>>> +	int ltr;
> This could be u16 too.
Will change in the next patch
>>> +	u16 max_snoop_lat = 0, max_nosnoop_lat = 0;
> No need to initialize these variables.
I will update these in next patch.
>>>    	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>>>    		return;
>>> +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
>>> +	if (!ltr)
>>> +		return;
> Is this capability implemented always?

Based up on spec 4.1, sec 5.5 Ports that support the L1.2 substate for 
ASPM L1 must support this.

And there is already a check in this function  if there is no L1.2 
support the function is returning.

>>> +
>>> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
>>> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
>>> +
>>>    	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>>>    	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>>>    	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>>> @@ -501,7 +510,18 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>    	 */
>>>    	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>>>    	encode_l12_threshold(l1_2_threshold, &scale, &value);
>>> -	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>>> +
>>> +	/*
>>> +	 * If the max snoop and no snoop latencies are '0', then avoid updating scale
>>> +	 * and value.
>>> +	 *
> This looks fine but...
>
>>> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
>>> +	 * snoop/no-snoop values is greather than or equal to LTR_L1.2_THRESHOLD value.
> s/is/are
>
> What about this? What if the snoop/nosnoop latencies are not equal to zero and
> lower than LTR_L1.2_THRESHOLD?
>
> Thanks,
> Mani

Will address this in next patch.

Thanks,

Krishna Chaitanya.

>>> +	 */
>>> +	if ((max_snoop_lat == 0) && (max_nosnoop_lat == 0))
>>> +		ctl1 |= t_common_mode << 8;
>>> +	else
>>> +		ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>>>    	/* Some broken devices only support dword access to L1 SS */
>>>    	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
