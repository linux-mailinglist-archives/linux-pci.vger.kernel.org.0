Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B114F4723
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbiDEVAO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Apr 2022 17:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457547AbiDEQKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Apr 2022 12:10:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F6025CD;
        Tue,  5 Apr 2022 09:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A1B0B81B13;
        Tue,  5 Apr 2022 16:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9524EC385A0;
        Tue,  5 Apr 2022 16:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649174881;
        bh=AoQfSTw72a5g3VVtNzddJxgTV8CHG8MijsAxNddLzcM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Rvy2MyaS/ZPWOuRNjBC+N85V1Wd9YOS+7DkIESmc76SW7ds7bScLypq4XmbROFeFV
         Vt0Kf7sBAH7ncizQ+q+wMrJEE4IGtZpMl7cDoStPiigR+qwKiRs9D9wJ0u9tAF0zRd
         S755OJbnfXqP2UCubJlvAGKCKmCCiJ+DVrhFHejYnVl0Ej+uaVfUwZ/L8XhgycgKyO
         EpRB5HzyFqO6SDVDvDleSt6EOGt24w908Wkh2kBH6OfgZyCIhRvd04A/iwEH4LxVNn
         8Nkbz4cLxpKqOdQKnCN0tiRQHnwBgmsByBnIolMol/U5hXodx06K2wGpP8CiZ2fQbd
         rzXojXTMhQ/Tw==
Date:   Tue, 5 Apr 2022 11:08:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org
Subject: Re: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME
 bit
Message-ID: <20220405160800.GA69953@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 08, 2022 at 12:29:09AM +0530, Prasad Malisetty wrote:
> Update LTR threshold scale and value based on LTRME (Latency
> Tolenrance Reporting Mechanism) from device capabilities.

s/Tolenrance/Tolerance/

I'm not familiar with "LTRME" and it doesn't appear in the PCI spec.
Please use the PCIe terminology whenever possible.

> In ASPM driver, LTR threshold scale and value is updating
> based on tcommon_mode and t_poweron values. In kioxia NVMe,
> L1.2 is failing due to LTR threshold scale and value is
> greater values than max snoop/non snoop value.
> 
> In general, updated LTR threshold scale and value should be
> less than max snoop/non snoop value to enter the device
> into L1.2 state.

This affects all PCIe devices, so please include the PCIe spec
citation that leads to this change.

Please wrap the commit log to fill 75 columns.

Thanks a lot for looking at this!  L1.2 and LTR is real problem area,
and it would be great if we could get it all sorted out.

> Signed-off-by: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> ---
> Changes since v1:
> 	- Added missing variable declaration in v1 patch.
> ---
>  drivers/pci/pcie/aspm.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b742..a67746c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -463,6 +463,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	u32 val1, val2, scale1, scale2;
>  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>  	u32 ctl1 = 0, ctl2 = 0;
> +	u32 cap;
>  	u32 pctl1, pctl2, cctl1, cctl2;
>  	u32 pl1_2_enables, cl1_2_enables;
>  
> @@ -499,9 +500,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	 * Table 5-11.  T(POWER_OFF) is at most 2us and T(L1.2) is at
>  	 * least 4us.
>  	 */
> -	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> -	encode_l12_threshold(l1_2_threshold, &scale, &value);
> -	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> +	pcie_capability_read_dword(child, PCI_EXP_DEVCAP2, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP2_LTR)) {
> +		l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> +		encode_l12_threshold(l1_2_threshold, &scale, &value);
> +		ctl1 |= scale << 29 | value << 16;
> +	}
> +
> +	ctl1 |= t_common_mode;
>  
>  	/* Some broken devices only support dword access to L1 SS */
>  	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
