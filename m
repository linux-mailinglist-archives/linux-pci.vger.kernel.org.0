Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC34FEAC9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 01:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiDLXYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 19:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiDLXYK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 19:24:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C2A8EEB;
        Tue, 12 Apr 2022 15:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90F5AB82050;
        Tue, 12 Apr 2022 22:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C897DC385A1;
        Tue, 12 Apr 2022 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649803609;
        bh=ffZYKwatNc5nZJyZ3dD5dRgf2cNxyz6TOXNBsJ+l5EE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jlyaLcuIIGFUt/+a3KrMJBXgJ5vFHdz1jIZgvJP/jtrm24Idy+ad2Wp1E2RgdFkjf
         JjZ4eSQy92doGD8tiWLYBiCNGYnSvKlt9nbObLDbJtI3VykyUCnLTfh/S6F4e95xAX
         N0xEgS18DuWSzyqLgNCX8SHooE7keCmHfrqdTODH4D4jlpfR0zHgaZZQ6C63q+hXJz
         UsluBF4mqLNc3pR2gw46PmJewRrMODQD3O7L7boPy03byZZHPD5T0ppH9CEF0/9BFD
         XStz96DwmJe2W3yqTBqRQHdLZ8HSApZxOS3zRfoFeCoUHzrWOGvx+EA0HvEjfnu9XO
         Uchx1ty/MLoGg==
Date:   Tue, 12 Apr 2022 17:46:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Prasad Malisetty <quic_pmaliset@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rajatja@google.com, refactormyself@gmail.com,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        manivannan.sadhasivam@linaro.org, swboyd@chromium.org,
        Vidya Sagar <vidyas@nvidia.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH v2] [RFC PATCH] PCI: Update LTR threshold based on LTRME
 bit
Message-ID: <20220412224647.GA639905@bhelgaas>
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

[+cc Vidya, Kenny]

On Tue, Mar 08, 2022 at 12:29:09AM +0530, Prasad Malisetty wrote:
> Update LTR threshold scale and value based on LTRME (Latency
> Tolenrance Reporting Mechanism) from device capabilities.
> 
> In ASPM driver, LTR threshold scale and value is updating
> based on tcommon_mode and t_poweron values. In kioxia NVMe,
> L1.2 is failing due to LTR threshold scale and value is
> greater values than max snoop/non snoop value.
> 
> In general, updated LTR threshold scale and value should be
> less than max snoop/non snoop value to enter the device
> into L1.2 state.

Interesting that you mention an L1.2 issue on a KIOXIA NVMe device.

Kenny also reported an L1 Substates issue related to a KIOXIA NVMe
device at [1].  That issue happened when saving/restoring the L1 SS
state for suspend/resume.

We ended up reverting 4257f7e008ea to avoid the problem, but when he
tested that commit later, the issue did not occur [2].

I don't know if there's a connection here, so this is just a heads-up
in case there is.

[1] https://lore.kernel.org/r/20201228040513.GA611645@bjorn-Precision-5520
[2] https://lore.kernel.org/r/3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com

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
