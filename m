Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F5A7D5F1F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjJYAie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 20:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYAie (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 20:38:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292C2D7D
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 17:38:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B50CC433C8;
        Wed, 25 Oct 2023 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698194311;
        bh=NJlg0+AFHDbmiGrTD3dEoX4XlCtwh1G4ooLZA8rP+JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=messqTFtDl/1ictocBSgaMBv4GReDv4zuwCu3ojr4tw6oMWP3KeP2xeuRLspJXfVt
         XWUtn4nXoDhAjpHjwYrKiL/j5w0XXP3AlpGbi4Z8dLOVYGk5ZxdXOdmk/1qbGr6kWM
         98qLx3FaBxOf4bKeEDFMSOV8BipMVwKFegQ+2AJONF+1j5IXrucSYGnXcnTkqqS1Be
         TlZORthd1EPTct6gYvk5F+69tZ0LLgfvhL68suPMt0RybiFsIAAIpvahqN+GwXCIfo
         6M0b8OT9SAt6Mrdwe26lIvtdOTyGJLmVZ7HrtKslYVrnPmBM6IPomQ1ke21JLKrgL7
         RixBSI4CHfzqg==
Date:   Tue, 24 Oct 2023 19:38:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/ASPM: Fix L1 sub-state handling in
 aspm_attr_store_common
Message-ID: <20231025003829.GA1705553@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ba7dd79-9cfe-4ed0-a002-d99cb842f361@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 11, 2023 at 09:46:45AM +0200, Heiner Kallweit wrote:
> So far we may see an unexpected behavior regard L1 sub-states.
> Following scenario:
> 
> Write 0 to "l1_aspm" to disable L1
> Write 1 to "l1_1_aspm" to enable L1.1
> 
> Intention of step 1 is to implicitly disable also L1.1 and L1.2.
> However after step 2 L1.2 is unexpectedly enabled.
> 
> Fix this by explicitly disabling L1 sub-states when disabling L1.
> 
> Fixes: 72ea91afbfb0 ("PCI/ASPM: Add sysfs attributes for controlling ASPM link states")
> Link: https://lore.kernel.org/linux-pci/20231002151452.GA560499@bhelgaas/
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/aspm for v6.7, thanks again.

> ---
> Splitted-out part of original patch according to linked discussion.
> ---
>  drivers/pci/pcie/aspm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 530c3bb5708c..fc18e42f0a6e 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1248,6 +1248,8 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  			link->aspm_disable &= ~ASPM_STATE_L1;
>  	} else {
>  		link->aspm_disable |= state;
> +		if (state & ASPM_STATE_L1)
> +			link->aspm_disable |= ASPM_STATE_L1SS;
>  	}
>  
>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> -- 
> 2.42.0
> 
