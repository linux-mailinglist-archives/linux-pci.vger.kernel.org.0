Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE297D5F1C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 02:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJYAiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 20:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJYAiH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 20:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAC610E4
        for <linux-pci@vger.kernel.org>; Tue, 24 Oct 2023 17:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89979C433C7;
        Wed, 25 Oct 2023 00:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698194284;
        bh=tohlVcHay0GDD1HyYQEY1YJ08dwtgZfb+1GeFnhwTm4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ls1T0bLk9bHXYu4Q3ZKGkTwXAMrtYsSitnf/ln8+xLWRaKiTGFtZY+zCEYmjFnExt
         J7ylApa7ZuHhXc2su1VYSw8sC+sN+EL20TVNcB7QUNUc1IcITYwks9vVf7q439py9O
         krFRUIEFxm7VcXq/EC9VOEuiFH3K0l/BLADa3sFLuIJ3Wz486dTzxp/aysgJkIsz1D
         t7U93erwrrB7tTxczTLF7KCKFXJrC+SIEHR1KHAxReaa9tJgbprIHlzvFg/Dc+hrJn
         /r9Vl1Z0koc5eRKxhUlGqBu/ZTT0ME0hv0FvuE0yQyz96vEJ+8CWcIRGTtqaEdCAfE
         khk3AJ/NRJlRA==
Date:   Tue, 24 Oct 2023 19:38:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ajay Agarwal <ajayagarwal@google.com>
Subject: Re: [PATCH] Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when
 driver, disables L1"
Message-ID: <20231025003802.GA1705474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75931ac-7208-4200-9ca1-821629cf5e28@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 11, 2023 at 09:36:40AM +0200, Heiner Kallweit wrote:
> This reverts commit fb097dcd5a28c0a2325632405c76a66777a6bed9.
> 
> After the referenced commit we may see L1 sub-states being active
> unexpectedly. Following scenario as an example:
> r8169 disables L1 because of known hardware issues on a number of
> systems. Implicitly L1.1 and L1.2 are disabled too.
> On my system L1 and L1.1 work fine, but L1.2 causes missed
> rx packets. Therefore I write 1 to aspm_l1_1.
> This removes ASPM_STATE_L1 from the disabled modes and therefore
> unexpectedly enables also L1.2. So return to the old behavior.
> 
> Link: https://lore.kernel.org/linux-pci/20231002151452.GA560499@bhelgaas/
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied to pci/aspm for v6.7, thanks, Heiner!

> ---
> Splitted the first version of the patch according to the linked discussion.
> ---
>  drivers/pci/pcie/aspm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 1bf630059264..530c3bb5708c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1059,7 +1059,8 @@ static int __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (state & PCIE_LINK_STATE_L0S)
>  		link->aspm_disable |= ASPM_STATE_L0S;
>  	if (state & PCIE_LINK_STATE_L1)
> -		link->aspm_disable |= ASPM_STATE_L1;
> +		/* L1 PM substates require L1 */
> +		link->aspm_disable |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
>  	if (state & PCIE_LINK_STATE_L1_1)
>  		link->aspm_disable |= ASPM_STATE_L1_1;
>  	if (state & PCIE_LINK_STATE_L1_2)
> -- 
> 2.42.0
> 
