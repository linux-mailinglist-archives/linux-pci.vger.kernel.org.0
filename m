Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FBA576070
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 13:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiGOL3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 07:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiGOL3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 07:29:20 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8668B8AB12;
        Fri, 15 Jul 2022 04:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657884499; x=1689420499;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ZB7lqxV4Y4LrAA0zUOAfQ/EcK4SUphXxPGyRWxI6Ec=;
  b=yKJdX73YDUC15zUgdh/23BxB12J04EOWTqmEKU/nLZJLUUCnzlkMNi7M
   o1ocTVNk+/rPVFsWsrhsG3+fnOF3zXcC2aoGW9ZyFhLFBWNN6NHPjbklM
   hhzvc3s5izKBtpD6doV+58/jQsSClRnVScBaOsBvnRUmONIFwGzaipaa4
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jul 2022 04:28:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 04:28:18 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 04:28:18 -0700
Received: from [10.216.15.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 04:28:09 -0700
Message-ID: <d7827b02-fa9c-ee16-734c-168c12516006@quicinc.com>
Date:   Fri, 15 Jul 2022 16:58:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] PCI/ASPM: Update LTR threshold based upon reported max
 latencies
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <swboyd@chromium.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <helgaas@kernel.org>
References: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
 <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
 <20f88022-e9b1-53b3-8832-85edc713ef6a@quicinc.com>
 <20220715082852.GC12197@workstation>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220715082852.GC12197@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/15/2022 1:58 PM, Manivannan Sadhasivam wrote:
> On Wed, Jun 15, 2022 at 06:53:18PM +0530, Krishna Chaitanya Chundru wrote:
>> A Gentle remainder please review it.
>>
>> On 6/10/2022 10:38 AM, Krishna chaitanya chundru wrote:
>>> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
>>>
>>> In ASPM driver, LTR threshold scale and value are updated based on
>>> tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
>>> LTR threshold scale and value are greater values than max snoop/non-snoop
>>> value.
>>>
>>> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
>>> reported snoop/no-snoop values is greather than or equal to
>>> LTR_L1.2_THRESHOLD value.
>>>
>>> Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> As Stephen noted in previous verison, you should sent the newer versions
> separately and not as a reply to previous ones. So please sent v6 with
> my tag as well.
>
> Thanks,
> Mani

ok mani I will send the v6 as you suggested.


Thanks

Krishna chaitanya.

>
>>> ---
>>>
>>> I am taking this patch forward as prasad is no more working with our org.
>>> Changes since v4:
>>> 	- Replaced conditional statements with min and max.
>>> changes since v3:
>>> 	- Changed the logic to include this condition "snoop/nosnoop
>>> 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
>>> Changes since v2:
>>> 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
>>> Changes since v1:
>>> 	- Added missing variable declaration in v1 patch
>>> ---
>>>    drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
>>>    1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index a96b742..676c03e 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>    {
>>>    	struct pci_dev *child = link->downstream, *parent = link->pdev;
>>>    	u32 val1, val2, scale1, scale2;
>>> +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>>>    	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>>>    	u32 ctl1 = 0, ctl2 = 0;
>>>    	u32 pctl1, pctl2, cctl1, cctl2;
>>>    	u32 pl1_2_enables, cl1_2_enables;
>>> +	u16 ltr;
>>> +	u16 max_snoop_lat, max_nosnoop_lat;
>>>    	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>>>    		return;
>>> +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
>>> +	if (!ltr)
>>> +		return;
>>> +
>>> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
>>> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
>>> +
>>> +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
>>> +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
>>> +
>>> +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
>>> +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
>>> +
>>> +	/* choose the greater max scale value between snoop and no snoop value*/
>>> +	max_scale = max(max_snp_scale, max_nsnp_scale);
>>> +
>>> +	/* choose the greater max value between snoop and no snoop scales */
>>> +	max_val = max(max_snp_val, max_nsnp_val);
>>> +
>>>    	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>>>    	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>>>    	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>>> @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>    	 */
>>>    	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>>>    	encode_l12_threshold(l1_2_threshold, &scale, &value);
>>> +
>>> +	/*
>>> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
>>> +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
>>> +	 */
>>> +	scale = min(scale, max_scale);
>>> +	value = min(value, max_val);
>>> +
>>>    	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>>>    	/* Some broken devices only support dword access to L1 SS */
