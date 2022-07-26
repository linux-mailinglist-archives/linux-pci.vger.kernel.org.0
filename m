Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7D580E3E
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jul 2022 09:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbiGZHuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jul 2022 03:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238384AbiGZHuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jul 2022 03:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED1E22;
        Tue, 26 Jul 2022 00:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F9361425;
        Tue, 26 Jul 2022 07:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF63C341C0;
        Tue, 26 Jul 2022 07:49:59 +0000 (UTC)
Date:   Tue, 26 Jul 2022 13:19:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v6] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20220726074954.GB5522@workstation>
References: <1657886421-779-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657886421-779-1-git-send-email-quic_krichai@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 05:30:12PM +0530, Krishna chaitanya chundru wrote:
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
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Bjorn, any update on this patch?

Thanks,
Mani

> ---
> 
> I am taking this patch forward as prasad is no more working with our org.
> changes since v5:
> 	- no changes, just reposting as standalone patch instead of reply to
> 	  previous patch.
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
>  drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b742..676c03e 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  	u32 val1, val2, scale1, scale2;
> +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>  	u32 ctl1 = 0, ctl2 = 0;
>  	u32 pctl1, pctl2, cctl1, cctl2;
>  	u32 pl1_2_enables, cl1_2_enables;
> +	u16 ltr;
> +	u16 max_snoop_lat, max_nosnoop_lat;
>  
>  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>  		return;
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
>  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	 */
>  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> +
> +	/*
> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
> +	 */
> +	scale = min(scale, max_scale);
> +	value = min(value, max_val);
> +
>  	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>  
>  	/* Some broken devices only support dword access to L1 SS */
> -- 
> 2.7.4
> 
