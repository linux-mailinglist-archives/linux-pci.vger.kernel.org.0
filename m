Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C577C4209
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 23:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjJJVIA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJJVH7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 17:07:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CB94;
        Tue, 10 Oct 2023 14:07:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B931C433C8;
        Tue, 10 Oct 2023 21:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696972077;
        bh=WOQLnp9OZimnlVYwjQ9u/FUvuftBKb+9EfbOzORuj5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=isUiRpRBAalueHWgAzUMeK9hXTvNBRQ35JqxsC6/jNn4Ri8feBR8mdhQeAujMWoX1
         Cim4okGhyTHy3cLYOeiTE/y/DnoFXxzOdxLxYC+I3qkbvwTOsTYMGmEDv9J2DOl/K4
         dn9cbrd7xH1Ouy2rgthPkwu0NNnESEG7Ll8Gv8lCd2ueWbjP3TBAt7R1tf2awdO0Qz
         +Ilpk5kZpFGAO51TMnEGhtIGPVkm2BV0cEHmH4m7nktZUZsweQgmGZZpyMYRLOhxxx
         q95cnf9hnZMve5qAUdgx0wm8t6i3ACASdpkFqDjWMF2JHvK7KuyGJeJh4cd2G9h8q4
         DkLA8KPlysymA==
Date:   Tue, 10 Oct 2023 16:07:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 03/10] PCI/ASPM: Use FIELD_GET()
Message-ID: <20231010210755.GA1001553@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010204436.1000644-4-helgaas@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 10, 2023 at 03:44:29PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add #defines for T_POWER_ON in the L1 PM Substates Capability and use
> FIELD_PREP() and FIELD_GET() when possible.  These remove the need for
> explicit shifts.  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I see this is identical to your patch at
https://lore.kernel.org/r/20230915155752.84640-3-ilpo.jarvinen@linux.intel.com,
Ilpo, so I'll drop this one.

> ---
>  drivers/pci/pcie/aspm.c       | 31 ++++++++++++++++++-------------
>  include/uapi/linux/pci_regs.h |  2 ++
>  2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 1bf630059264..06f175d8dee5 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -7,6 +7,7 @@
>   * Copyright (C) Shaohua Li (shaohua.li@intel.com)
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> @@ -267,7 +268,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  /* Convert L0s latency encoding to ns */
>  static u32 calc_l0s_latency(u32 lnkcap)
>  {
> -	u32 encoding = (lnkcap & PCI_EXP_LNKCAP_L0SEL) >> 12;
> +	u32 encoding = FIELD_GET(PCI_EXP_LNKCAP_L0SEL, lnkcap);
>  
>  	if (encoding == 0x7)
>  		return (5 * 1000);	/* > 4us */
> @@ -285,7 +286,7 @@ static u32 calc_l0s_acceptable(u32 encoding)
>  /* Convert L1 latency encoding to ns */
>  static u32 calc_l1_latency(u32 lnkcap)
>  {
> -	u32 encoding = (lnkcap & PCI_EXP_LNKCAP_L1EL) >> 15;
> +	u32 encoding = FIELD_GET(PCI_EXP_LNKCAP_L1EL, lnkcap);
>  
>  	if (encoding == 0x7)
>  		return (65 * 1000);	/* > 64us */
> @@ -371,11 +372,11 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  	link = endpoint->bus->self->link_state;
>  
>  	/* Calculate endpoint L0s acceptable latency */
> -	encoding = (endpoint->devcap & PCI_EXP_DEVCAP_L0S) >> 6;
> +	encoding = FIELD_GET(PCI_EXP_DEVCAP_L0S, endpoint->devcap);
>  	acceptable_l0s = calc_l0s_acceptable(encoding);
>  
>  	/* Calculate endpoint L1 acceptable latency */
> -	encoding = (endpoint->devcap & PCI_EXP_DEVCAP_L1) >> 9;
> +	encoding = FIELD_GET(PCI_EXP_DEVCAP_L1, endpoint->devcap);
>  	acceptable_l1 = calc_l1_acceptable(encoding);
>  
>  	while (link) {
> @@ -446,22 +447,24 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
>  	u32 pl1_2_enables, cl1_2_enables;
>  
>  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> -	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> -	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> +	val1 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, parent_l1ss_cap);
> +	val2 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, child_l1ss_cap);
>  	t_common_mode = max(val1, val2);
>  
>  	/* Choose the greater of the two Port T_POWER_ON times */
> -	val1   = (parent_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
> -	scale1 = (parent_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
> -	val2   = (child_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_VALUE) >> 19;
> -	scale2 = (child_l1ss_cap & PCI_L1SS_CAP_P_PWR_ON_SCALE) >> 16;
> +	val1   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, parent_l1ss_cap);
> +	scale1 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, parent_l1ss_cap);
> +	val2   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, child_l1ss_cap);
> +	scale2 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, child_l1ss_cap);
>  
>  	if (calc_l12_pwron(parent, scale1, val1) >
>  	    calc_l12_pwron(child, scale2, val2)) {
> -		ctl2 |= scale1 | (val1 << 3);
> +		ctl2 |= FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_SCALE, scale1) |
> +			FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_VALUE, val1);
>  		t_power_on = calc_l12_pwron(parent, scale1, val1);
>  	} else {
> -		ctl2 |= scale2 | (val2 << 3);
> +		ctl2 |= FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_SCALE, scale2) |
> +			FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_VALUE, val2);
>  		t_power_on = calc_l12_pwron(child, scale2, val2);
>  	}
>  
> @@ -477,7 +480,9 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
>  	 */
>  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> -	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> +	ctl1 |= FIELD_PREP(PCI_L1SS_CTL1_CM_RESTORE_TIME, t_common_mode) |
> +		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_VALUE, value) |
> +		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_SCALE, scale);
>  
>  	/* Some broken devices only support dword access to L1 SS */
>  	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e5f558d96493..34bf037993f3 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1088,6 +1088,8 @@
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_VALUE	0x03ff0000  /* LTR_L1.2_THRESHOLD_Value */
>  #define  PCI_L1SS_CTL1_LTR_L12_TH_SCALE	0xe0000000  /* LTR_L1.2_THRESHOLD_Scale */
>  #define PCI_L1SS_CTL2		0x0c	/* Control 2 Register */
> +#define  PCI_L1SS_CTL2_T_PWR_ON_SCALE   0x00000003  /* T_POWER_ON Scale */
> +#define  PCI_L1SS_CTL2_T_PWR_ON_VALUE   0x000000f8  /* T_POWER_ON Value */
>  
>  /* Designated Vendor-Specific (DVSEC, PCI_EXT_CAP_ID_DVSEC) */
>  #define PCI_DVSEC_HEADER1		0x4 /* Designated Vendor-Specific Header1 */
> -- 
> 2.34.1
> 
