Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8621658ADBF
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiHEPzd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiHEPzR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 11:55:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095C79689
        for <linux-pci@vger.kernel.org>; Fri,  5 Aug 2022 08:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79263B82757
        for <linux-pci@vger.kernel.org>; Fri,  5 Aug 2022 15:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC75C433D6;
        Fri,  5 Aug 2022 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714819;
        bh=Se9SDt2ZRUYRFX0hcwxM1N0Mmp3ukORJJk2HQ8WaVaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XIJWkthvmMKa2TLp3F4zcXLYpo4kTFhJjk1H5JoWwig5ysxrTbTUIFl4lOjz5lUP3
         HOKDtG+GNhRRc2VIplQd1a8h3nNwWuY/pkKWPSFQ9L4a4j95cTxf2fU+nLe3OwbJUX
         /nB9iGBOEG8ocqYToPKrIo55C0rJdbhF0gyg+HfYpcjNBGEij9YJ/+OGf1p13Dp1Fc
         zm9+8b6z/AKORN2R15lbjBL77g0aPEpagxkDgrBKTD59Lk0XZeIZQ8pHPGbVxFM20N
         6Jp3xrphEXDwAziNP8EQcwFw1XtfnYeWzg4elHpU4+1TSPqapRsIyngI9YsQl+bmFR
         Q0bP+Smjg7XlQ==
Date:   Fri, 5 Aug 2022 10:53:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Josef Johansson <josef@oderland.se>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2] PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
Message-ID: <20220805155336.GA1005417@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu0IwZXyTIhdALMb@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 05, 2022 at 09:10:41AM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 05, 2022 at 12:03:15PM +0200, Josef Johansson wrote:
> > On 2/14/22 11:07, Josef Johansson wrote:
> > > From: Josef Johansson <josef@oderland.se>
> > > 
> > > PCI/MSI: Correct use of can_mask in msi_add_msi_desc()
> > > Commit 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") modifies
> > > the logic of checking msi_attrib.can_mask, without any reason.
> > > This commits restores that logic.
> > >
> > > Fixes: 71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()")
> > > Signed-off-by: Josef Johansson <josef@oderland.se>
> > > 
> > > ---
> > > v2: Changing subject line to fit earlier commits.
> > > 
> > > Trying to fix a NULL BUG in the NVMe MSIX implementation I stumbled upon this code,
> > > which ironically was what my last MSI patch resulted into.
> > > 
> > > I don't see any reason why this logic was change, and it did not break anything
> > > correcting the logic.
> > > 
> > > CC xen-devel since it very much relates to Xen kernel (via pci_msi_ignore_mask).
> > > ---
> > > 
> > > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > > index c19c7ca58186..146e7b9a01cc 100644
> > > --- a/drivers/pci/msi/msi.c
> > > +++ b/drivers/pci/msi/msi.c
> > > @@ -526,7 +526,7 @@ static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
> > >   		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
> > >   					       !desc.pci.msi_attrib.is_virtual;
> > > -		if (!desc.pci.msi_attrib.can_mask) {
> > > +		if (desc.pci.msi_attrib.can_mask) {
> > >   			addr = pci_msix_desc_addr(&desc);
> > >   			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> > >   		}
> > > 
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Bjorn, please take it?

Thanks for the ping.  Since 71020a3c0dff4 is by Thomas, and he merged
that along with a whole series of MSI work, I think I probably
expected him to take care of this.

This looks like a simple typo, so I think the commit log should be
reworded along that line, e.g., something like:

  71020a3c0dff4 ("PCI/MSI: Use msi_add_msi_desc()") inadvertently
  reversed the sense of "msi_attrib.can_mask" in one use:

    - if (entry->pci.msi_attrib.can_mask) {
    -         addr = pci_msix_desc_addr(entry);
    -         entry->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
    + if (!desc.pci.msi_attrib.can_mask) {
    +         addr = pci_msix_desc_addr(&desc);
    +         desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);

  Restore the original test.

Thomas, do you want to take this?  I'm happy to merge it, but would
like your reviewed-by or ack first.

Bjorn
