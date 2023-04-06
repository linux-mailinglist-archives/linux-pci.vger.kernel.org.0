Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD516D9BD3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbjDFPIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239740AbjDFPIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 11:08:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC39AD02;
        Thu,  6 Apr 2023 08:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E036475A;
        Thu,  6 Apr 2023 15:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA4EC433EF;
        Thu,  6 Apr 2023 15:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680793664;
        bh=OIXmtld0kktBtt+ixhIcfzJGo+xmE4/emKtVcSQ4DYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZM39NWtSV+VlTvcygJBJlLcz1AwerO+mbEwhI3vZ/37nKu57sUJblwHU6skNPiP1n
         fZxjc2A3lr05rZ2pgm+mh+iA9IunjuXdUAwyKcKBaWbFvow53hDe9hj+O0gwjk2Vw5
         4jikgPS/ZGUl2eqYVSpU7voXDD5dDj56l0qZRpD4epLfSLQsXzfnKNk0VdauHHcYgj
         FYagd8alm9j187dl284EP1w1VDjBySV6pSjhK4mw11Krac7d2OTpCbQAEL+R17KdzG
         54wExrqB6kVaYZtgsBjB71tubVYa2I2Ig5AjegvP4+kCLojsbJ7EMBeqzt+cv6EnYY
         RTSZnuXK4xxjA==
Date:   Thu, 6 Apr 2023 10:07:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
Message-ID: <20230406150742.GA3703273@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci, regressions]

On Thu, Apr 06, 2023 at 11:05:14AM +0000, David Laight wrote:
> The change in bab65e48cb064 breaks pci_enable_msix_range().
> The intent is to optimise the sanity checks, but it is
> somewhat overenthusiastic.
> 
> The interface allows you to ask for a lot of vectors and
> returns the number that were allocated.
> However, after the change, you can't request a vector
> that is higher than the largest the hardware supports.
> Which makes that rather pointless.
> 
> So code like:
> 	for (i = 0; i < 16; i++)
> 		msix_tbl[i].entry = i;
> 	nvec = pci_enable_msix_range(dev, msix_tbl, 1, 16);
> Now returns -22 if the hardware only supports 8 interrupts.
> 
> Previously it returned 8.
> 
> I can fix my driver, but I suspect that any code that relies
> on a smaller number of vectors being returned is now broken.

Thanks for the report!  bab65e48cb06 ("PCI/MSI: Sanitize MSI-X
checks") appeared in v6.2-rc1, so this is a recent regression and it
would be good to fix it for v6.3.

bab65e48cb06 only touches drivers/pci/msi/msi.c, but since it didn't
go through the PCI tree, I'll let Thomas handle any revert (or better,
an improvement to pci_msix_validate_entries()) since he wrote and
applied the original.

Bjorn
