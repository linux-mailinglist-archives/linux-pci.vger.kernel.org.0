Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BABB5A44C6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 10:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiH2IO4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 04:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH2IOw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 04:14:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1BD10548;
        Mon, 29 Aug 2022 01:14:43 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T7KXR6031734;
        Mon, 29 Aug 2022 08:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zJjzDt7XPu/PMn4l+tK2qZnVJ2yvHbcPZMeuF+7G6Es=;
 b=HrnvxxfhYTEXo/YLpEPxwcnL6HLwlOIEEcCm+JHYR5KJpf4EJYQRJGpvho/40sPP1u2M
 A7lg2XKXMIAU2vvi39V3Z5x0uMK7bdc/Ub94gnR9d1DSD6kix4ujrGdke9KkwfOIs1g2
 TQ3zpqx/epznQyGcBJzD140cKo1vTgIQYyZQ4/A7f84gdj2hwoM9ZebGNyxLB+ccz65G
 2kZM4fcdrkDQAR9T11QZOvOqxuqP+SXQwCpmxc2SGXKAs2QMgSoMCWtEfrjRSgkpzoiS
 RuY4LaJ1KPy49kMBenG7z0D/QG8/LAFt4a9dxqvTej4ATVFv+cFcge2l3N9EV3UfqOWr ZQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7av7ccns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 08:14:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27T8EVXm022379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 08:14:31 GMT
Received: from [10.216.51.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 29 Aug
 2022 01:14:25 -0700
Message-ID: <b5675a83-c12c-1f10-2ca2-66e4ee672fe6@quicinc.com>
Date:   Mon, 29 Aug 2022 13:44:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6] PCI/ASPM: Update LTR threshold based upon reported max
 latencies
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <swboyd@chromium.org>,
        <dmitry.baryshkov@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <1657886421-779-1-git-send-email-quic_krichai@quicinc.com>
 <20220726074954.GB5522@workstation> <YwctiEJpydiFdIds@google.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <YwctiEJpydiFdIds@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gDLqpx1QvbBQ9M6aVXu9UPgSvaQzLPZ8
X-Proofpoint-ORIG-GUID: gDLqpx1QvbBQ9M6aVXu9UPgSvaQzLPZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/25/2022 1:36 PM, Matthias Kaehlcke wrote:
> On Tue, Jul 26, 2022 at 01:19:54PM +0530, Manivannan Sadhasivam wrote:
>> On Fri, Jul 15, 2022 at 05:30:12PM +0530, Krishna chaitanya chundru wrote:
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
>>> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> Bjorn, any update on this patch?
> ping: can this be landed or are any further changes needed?

Hi Bjorn,

Can you help us to review this patch. It was untouched from july 15. If 
you have

any comments we will try to address them.


Thanks & Regards,

Krishna Chaitanya.

>> Thanks,
>> Mani
>>
>>> ---
>>>
>>> I am taking this patch forward as prasad is no more working with our org.
>>> changes since v5:
>>> 	- no changes, just reposting as standalone patch instead of reply to
>>> 	  previous patch.
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
>>>   drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
>>>   1 file changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>> index a96b742..676c03e 100644
>>> --- a/drivers/pci/pcie/aspm.c
>>> +++ b/drivers/pci/pcie/aspm.c
>>> @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>   {
>>>   	struct pci_dev *child = link->downstream, *parent = link->pdev;
>>>   	u32 val1, val2, scale1, scale2;
>>> +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>>>   	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>>>   	u32 ctl1 = 0, ctl2 = 0;
>>>   	u32 pctl1, pctl2, cctl1, cctl2;
>>>   	u32 pl1_2_enables, cl1_2_enables;
>>> +	u16 ltr;
>>> +	u16 max_snoop_lat, max_nosnoop_lat;
>>>   
>>>   	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>>>   		return;
>>>   
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
>>>   	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>>>   	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>>>   	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>>> @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>>>   	 */
>>>   	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>>>   	encode_l12_threshold(l1_2_threshold, &scale, &value);
>>> +
>>> +	/*
>>> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
>>> +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
>>> +	 */
>>> +	scale = min(scale, max_scale);
>>> +	value = min(value, max_val);
>>> +
>>>   	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>>>   
>>>   	/* Some broken devices only support dword access to L1 SS */
>>> -- 
>>> 2.7.4
>>>
