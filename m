Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEEE6F3543
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjEARzZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjEARzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 13:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770661701
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 10:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF812611E3
        for <linux-pci@vger.kernel.org>; Mon,  1 May 2023 17:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F3C433D2;
        Mon,  1 May 2023 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682963720;
        bh=S7wfqtYXKR7At+EHVoMaubAI7xiscHqCnZzvkwMn/EU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R7e427R8boEBJ3VGYP8EX61ao8F99p3ZM/Myz2UJTkMRSsnW71U3I1cNXx5WHXscP
         t7RTPPE/zCr1DohcSrvfOISoYPX5FOlwwsVrxEYSNWTzdbE+PJhG7z0vSrqfOolbs6
         85WpMrqAln+fsr9pY14gBvnwvFlHLqSJ1dQ91hATIlUO/2b/42/20M+n/wJwKQ7Ble
         EX1XeM/E6r9hi/gBTCRvkv+1pt0kpWNDwDTVjRMlF6X+5Zv2nKDS7/v4TrFAWHI4AS
         TAXfl2n5Dto92rWy4XO8Pid4aWkUpNSMot3MSsZAxOUN566fly1EGaYlR9L4vcEMaK
         oM9ET9pqpr43A==
Date:   Mon, 1 May 2023 12:55:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Agarwal <ajayagarwal@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Nikhil Devshatwar <nikhilnd@google.com>,
        Manu Gautam <manugautam@google.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI/ASPM: Remove unnecessary ASPM_STATE_L1SS check
Message-ID: <20230501175518.GA594484@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411111034.1473044-4-ajayagarwal@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 04:40:34PM +0530, Ajay Agarwal wrote:
> Currently the driver checks if ASPM_STATE_L1SS is supported
> before calling aspm_calc_l1ss_info(), only for this function to
> return if ASPM_STATE_L1_2_MASK is not supported. Simplify the
> logic by directly checking for L1.2 mask.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7c9935f331f1..8c45835e8016 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -481,9 +481,6 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	u32 pctl1, pctl2, cctl1, cctl2;
>  	u32 pl1_2_enables, cl1_2_enables;
>  
> -	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> -		return;
> -
>  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> @@ -616,7 +613,7 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
>  	if (parent_l1ss_ctl1 & child_l1ss_ctl1 & PCI_L1SS_CTL1_PCIPM_L1_2)
>  		link->aspm_enabled |= ASPM_STATE_L1_2_PCIPM;
>  
> -	if (link->aspm_support & ASPM_STATE_L1SS)
> +	if (link->aspm_support & ASPM_STATE_L1_2_MASK)
>  		aspm_calc_l1ss_info(link, parent_l1ss_cap, child_l1ss_cap);

I think the reason it was this way is because several of the relevant
names use "l1ss":

  ASPM_STATE_L1SS
  aspm_calc_l1ss_info
  calc_l1ss_pwron

But everything in aspm_calc_l1ss_info() is L1.2-specific, so I think
it would make sense to use your patch, and at the same time, rename
aspm_calc_l1ss_info() and calc_l1ss_pwron() to aspm_calc_l12_info()
and calc_l12_pwron() to match.

Bjorn
