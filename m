Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495424B19E8
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 00:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbiBJX5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 18:57:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243325AbiBJX5I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 18:57:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76675F7C
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 15:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FEA7B823B5
        for <linux-pci@vger.kernel.org>; Thu, 10 Feb 2022 23:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71C8C004E1;
        Thu, 10 Feb 2022 23:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644537426;
        bh=r005aX85VIhDDr1Vqtro622BMgk7L0dZNprygCBXBaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ieJwcqB/SocXJkHqDl6ii25zQfJdPS1CH6V0MJRmm5a7EtPbpR/iwICaNqH7yoB5J
         kjxIfWDDzZ3526HKJV/BztmIQYGRVJf05AbLJA0YNR9o5Swxth8bsRNlGFkBHNTAOB
         et653UQpCnGnmAHvGDVnSkaujlx/ickOWgmtVKJlC6i4VUp1SNJtPlyEKIboPy1Kan
         ro3nuRE4zTWHDfvDY9yntUt5hmY3TWk66+grZkOsgCJJVNyzT4XEn+HICXpoyqtuMo
         eoEJrI0OicU/PeSMGEvp+9IOBVFICoVyGtxfhgiraKyc1W2Rv0ydHEsvab04RO7t9H
         C90CwbjvFzNug==
Date:   Thu, 10 Feb 2022 17:55:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Josef Johansson <josef@oderland.se>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] PCI/MSI: msix_setup_msi_descs: Restore logic for
 msi_attrib.can_mask
Message-ID: <20220210235532.GA663996@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a224ee-b72f-7053-6030-b6c4d8a29be9@oderland.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jason, since you reviewed the original commit]

On Sat, Jan 22, 2022 at 02:10:01AM +0100, Josef Johansson wrote:
> From: Josef Johansson <josef@oderland.se>
> 
> PCI/MSI: msix_setup_msi_descs: Restore logic for msi_attrib.can_mask

Please match the form and style of previous subject lines (in
particular, omit "msix_setup_msi_descs:").

> Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
> the logic of checking msi_attrib.can_mask, without any reason.
>     
> This commits restores that logic.

I agree, this looks like a typo in 71020a3c0dff4, but I might be
missing something, so Thomas should take a look, and I added Jason
since he reviewed it.

Since it was merged by Thomas, I'll let him take care of this, too.
If it *is* a typo, the fix looks like v5.17 material.

Before: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/msi/msi.c?id=71020a3c0dff4%5E#n522
After:  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/msi/msi.c?id=71020a3c0dff4#n520

> Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
> Signed-off-by: Josef Johansson <josef@oderland.se>
> 
> ---
> Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
> which ironically was what my last MSI patch resulted into.
> 
> I don't see any reason why this logic was change, nor do I have the possibility
> to see if anything works with my patch or without, since the kernel crashes
> in other places.
> 
> As such this is still untested, but as far as I can tell it should restore
> functionality.
> 
> Re-sending since it was rejected by linux-pci@vger.kernel.org due to HTML contents.
> Sorry about that.
> 
> CC xen-devel since it very much relates to Xen kernel (via pci_msi_ignore_mask).
> ---
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index c19c7ca58186..146e7b9a01cc 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -526,7 +526,7 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
>  		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
>  					       !desc.pci.msi_attrib.is_virtual;
>  
> -		if (!desc.pci.msi_attrib.can_mask) {
> +		if (desc.pci.msi_attrib.can_mask) {
>  			addr = pci_msix_desc_addr(&desc);
>  			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  		}
> 
> --
> 2.31.1
> 
