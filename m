Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32C85EFFD3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 00:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiI2WAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 18:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2WAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 18:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871F2D58A1;
        Thu, 29 Sep 2022 15:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08DFA621C1;
        Thu, 29 Sep 2022 22:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDC9C4347C;
        Thu, 29 Sep 2022 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664488820;
        bh=WtkC37Gy/WTEiwuFHzLPNkA8qv8vtULh3URNp4L7KrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RiycpSO/A50KTcqwqIadnTsvse61MYmoU9k10P+Rt1osFPIwLjYVBa+jxVpZNlEFu
         5SCs59qFmc6/Ua8y3G1B4+poUSqf+ixy4+Qo6G5R6i/sSqWx6sR0MTqglYNCfOC4I1
         AUzGJntxu0x59s2bJMpJhJdAGJv1zkoG8XjkCJUIScmxlNZuEVMklRow5I7Cq6+OKf
         pWLWDuZDJKS78bQ4LPsOlpstjGyZ0HpiOK1Jt6wO8kcXwuMHaP40J8l8QTbEwal0Eo
         JRJT51rW1T5qaj/Cgvo/XcptYtrySKVih8UxW0cZirISAHiu3fQf4u6dj95i7+b2be
         zBLUrFbNBrAHw==
Date:   Thu, 29 Sep 2022 17:00:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        refactormyself@gmail.com, kw@linux.com, rajatja@google.com,
        kenny@panix.com, kai.heng.feng@canonical.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH V4 1/2] PCI/ASPM: Refactor ASPM L1SS control register
 programming
Message-ID: <20220929220018.GA1927153@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913131822.16557-2-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krishna]

On Tue, Sep 13, 2022 at 06:48:21PM +0530, Vidya Sagar wrote:
> Refactor the code to extract the command code out to program
> Control Registers-1 & 2 of L1 Sub-States capability to a new function
> aspm_program_l1ss() and call it for both parent and child devices.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * New patch in this series
> 
>  drivers/pci/pcie/aspm.c | 63 +++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a8aec190986c..ecbe3af4188d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -455,6 +455,31 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
>  	pci_write_config_dword(pdev, pos, val);
>  }
>  
> +static void aspm_program_l1ss(struct pci_dev *dev, u32 ctl1, u32 ctl2)
> +{
> +	u16 l1ss = dev->l1ss;
> +	u32 l1_2_enable;
> +
> +	/*
> +	 * Per PCIe r6.0, sec 5.5.4, T_POWER_ON in PCI_L1SS_CTL2 must be
> +	 * programmed prior to setting the L1.2 enable bits in PCI_L1SS_CTL1.
> +	 */
> +	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL2, ctl2);
> +
> +	/*
> +	 * In addition, Common_Mode_Restore_Time and LTR_L1.2_THRESHOLD in
> +	 * PCI_L1SS_CTL1 must be programmed *before* setting the L1.2
> +	 * enable bits, even though they're all in PCI_L1SS_CTL1.
> +	 */
> +	l1_2_enable = ctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> +	ctl1 &= ~PCI_L1SS_CTL1_L1_2_MASK;
> +
> +	pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1, ctl1);
> +	if (l1_2_enable)
> +		pci_write_config_dword(dev, l1ss + PCI_L1SS_CTL1,
> +				       ctl1 | l1_2_enable);
> +}
> +
>  /* Calculate L1.2 PM substate timing parameters */
>  static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  				u32 parent_l1ss_cap, u32 child_l1ss_cap)
> @@ -464,7 +489,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>  	u32 ctl1 = 0, ctl2 = 0;
>  	u32 pctl1, pctl2, cctl1, cctl2;
> -	u32 pl1_2_enables, cl1_2_enables;
>  
>  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>  		return;
> @@ -513,39 +537,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	    ctl2 == pctl2 && ctl2 == cctl2)
>  		return;
>  
> -	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
> -	pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> -	cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
> -
> -	if (pl1_2_enables || cl1_2_enables) {
> -		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> -					PCI_L1SS_CTL1_L1_2_MASK, 0);
> -		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> -					PCI_L1SS_CTL1_L1_2_MASK, 0);
> -	}
> -
> -	/* Program T_POWER_ON times in both ports */
> -	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
> -	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
> -
> -	/* Program Common_Mode_Restore_Time in upstream device */
> -	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> -				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
> -
> -	/* Program LTR_L1.2_THRESHOLD time in both ports */
> -	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
> -				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> -				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
> -	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> -				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> -				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
> -
> -	if (pl1_2_enables || cl1_2_enables) {
> -		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
> -					pl1_2_enables);
> -		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
> -					cl1_2_enables);
> -	}
> +	aspm_program_l1ss(parent,
> +			  ctl1 | (pctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);
> +	aspm_program_l1ss(child,
> +			  ctl1 | (cctl1 & PCI_L1SS_CTL1_L1_2_MASK), ctl2);

This doesn't seem right to me.  I think the intent is to update
LTR_L1.2_THRESHOLD and Common_Mode_Restore_Time, which are encoded in
"ctl1".  It does do that, but it looks like it *also* clears
everything except PCI_L1SS_CTL1_L1_2_MASK, i.e., the L1.1 Enable bits,
the Link Activation bits, and the RsvdP bits, which I don't think we
should be clearing.  Am I missing something?

Bjorn
