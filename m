Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2964E54C9AF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 15:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbiFONXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 09:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346897AbiFONX2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 09:23:28 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757143CFDB;
        Wed, 15 Jun 2022 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655299407; x=1686835407;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xH9eSLBMA6f5V0fAnNjbv3nOkA4KAVViQk/k61IHHIo=;
  b=cOj7f1BY09K9+6U59F7ktiSDbxzpGmU0ArP3wJpLgY3apSOWWfTFZ5y6
   eQCPbimvjFEgwgNMCkzsSYlWP6nulPeLRc/Wl9VaOqKmiaYQSBWtg9Uud
   snfV5WAs0osG9AW2d9UynVzNoOZtdphyo8NFXuWTHzwJnx5XsZ34HZ9Ke
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2022 06:23:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:23:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 15 Jun 2022 06:23:26 -0700
Received: from [10.216.37.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 06:23:21 -0700
Message-ID: <20f88022-e9b1-53b3-8832-85edc713ef6a@quicinc.com>
Date:   Wed, 15 Jun 2022 18:53:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5] PCI/ASPM: Update LTR threshold based upon reported max
 latencies
Content-Language: en-US
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <manivannan.sadhasivam@linaro.org>, <swboyd@chromium.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        <helgaas@kernel.org>
References: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
 <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A Gentle remainder please review it.

On 6/10/2022 10:38 AM, Krishna chaitanya chundru wrote:
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
>
> In ASPM driver, LTR threshold scale and value are updated based on
> tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> LTR threshold scale and value are greater values than max snoop/non-snoop
> value.
>
> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> reported snoop/no-snoop values is greather than or equal to
> LTR_L1.2_THRESHOLD value.
>
> Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>
> I am taking this patch forward as prasad is no more working with our org.
> Changes since v4:
> 	- Replaced conditional statements with min and max.
> changes since v3:
> 	- Changed the logic to include this condition "snoop/nosnoop
> 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> Changes since v2:
> 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> Changes since v1:
> 	- Added missing variable declaration in v1 patch
> ---
>   drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b742..676c03e 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>   {
>   	struct pci_dev *child = link->downstream, *parent = link->pdev;
>   	u32 val1, val2, scale1, scale2;
> +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>   	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>   	u32 ctl1 = 0, ctl2 = 0;
>   	u32 pctl1, pctl2, cctl1, cctl2;
>   	u32 pl1_2_enables, cl1_2_enables;
> +	u16 ltr;
> +	u16 max_snoop_lat, max_nosnoop_lat;
>   
>   	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>   		return;
>   
> +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return;
> +
> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> +
> +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
> +
> +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
> +
> +	/* choose the greater max scale value between snoop and no snoop value*/
> +	max_scale = max(max_snp_scale, max_nsnp_scale);
> +
> +	/* choose the greater max value between snoop and no snoop scales */
> +	max_val = max(max_snp_val, max_nsnp_val);
> +
>   	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>   	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>   	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>   	 */
>   	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>   	encode_l12_threshold(l1_2_threshold, &scale, &value);
> +
> +	/*
> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
> +	 */
> +	scale = min(scale, max_scale);
> +	value = min(value, max_val);
> +
>   	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>   
>   	/* Some broken devices only support dword access to L1 SS */
