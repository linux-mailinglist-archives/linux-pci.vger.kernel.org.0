Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3755A2BB2
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiHZPvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHZPvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 11:51:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BB95B7
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 08:51:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44CF8B82F84
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 15:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9ACC433D6;
        Fri, 26 Aug 2022 15:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661529081;
        bh=O/y28TF/cUc/1ZIQvc0DnYy+2d6TDwpxl4xZ14O/Wkk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xh+Xa5sfnMq9bcour0b1JBqGR8NAwLHqtPlON3ae1tBXbK3i3e5h//diO+JBaONtf
         TUZyVM2aB122aOut3vfLqJr0ROF8JDyJS6wcy9wf+BzrLZgV7yuS3ElUXzdnddbTWb
         DXUkVqN9Hl0JYG5EcN6HVmWvYWep4vJo9z6HJnK0fVfQ6F9NneiUmNQvGttmQSNKGl
         u7JF8WcU+pMTdX85ctPYJXYZQmFD0mzVPaf2H1k2oVPUhVe7nG5yieWeLtgRxGwAoh
         TH1PCejkt0bdebsOPhTYIamNq6U7epZT6tHpjfgnv1Kf03pLp/KGiKYk6W2sR5fCTw
         e7Qg4q4PMWH8g==
Date:   Fri, 26 Aug 2022 10:51:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Josef Johansson <josef@oderland.se>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
Message-ID: <20220826155119.GA2933552@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d818f9c9-a432-213e-4152-eaff3b7da52e@oderland.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 14, 2022 at 11:07:47AM +0100, Josef Johansson wrote:
> From: Josef Johansson <josef@oderland.se>
> 
> PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
>     
> Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
> the logic of checking msi_attrib.can_mask, without any reason.
>     
> This commits restores that logic.
> 
> Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
> Signed-off-by: Josef Johansson <josef@oderland.se>

Applied to pci/misc for v6.1 with commit log below, thanks!

  PCI/MSI: Correct 'can_mask' test in msi_add_msi_desc()

  71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") inadvertently reversed
  the sense of "msi_attrib.can_mask" in one use:

    - if (entry->pci.msi_attrib.can_mask) {
    -         addr = pci_msix_desc_addr(entry);
    -         entry->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
    + if (!desc.pci.msi_attrib.can_mask) {
    +         addr = pci_msix_desc_addr(&desc);
    +         desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);

  Restore the original test.

> ---
> v2: Changing subject line to fit earlier commits.
> 
> Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
> which ironically was what my last MSI patch resulted into.
> 
> I don't see any reason why this logic was change, and it did not break anything
> correcting the logic.
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
> 
