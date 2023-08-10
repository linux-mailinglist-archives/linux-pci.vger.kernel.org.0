Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329CD776E79
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 05:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHJDYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 23:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbjHJDYs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 23:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64F1FCC
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 20:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A8EA64DDB
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 03:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFE1C433C8;
        Thu, 10 Aug 2023 03:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691637886;
        bh=jkWTlXhxGKRkYxI9RBR+av7cJTCSxa3GzMIJDIXKJgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=h/mPM2y4pDEThR+OzpeSWp/77EiKywyOlYTllk+u6labGQvfwH7WiLIV/giwWNreS
         4MJWlUwL4ge/SUMIKZbVF+nOxjHhMM7PIhY5vDqT6T6XURwPAWi7+9trvgP1vlQi8j
         VDraicxgINSXDrHhRDlyloYGe2JnCkxEcmNCp2UkX4gULH7HMcUU2hYpw+8dbjSR/2
         ygQkLruBucN8JDIf8HyurE/awGoTjxuZk4qfKlNTp7Qqu0L5plqG0KiHpUKPAoPF9k
         UlusPMoh0pCNtF2xYQO1zTL4xT1EIhWJ8arL0b0cqu505iaLxOs532FT8M/7vc9K04
         4iW3PSy6ZbVNw==
Date:   Wed, 9 Aug 2023 22:24:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Disable bridge window for domain reset
Message-ID: <20230810032444.GA16254@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5d53be-e735-496d-3a67-6f965982cef5@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 04:14:06PM -0700, Patel, Nirmal wrote:
> On 8/9/2023 3:00 PM, Bjorn Helgaas wrote:
> > On Wed, Aug 09, 2023 at 05:14:54PM -0400, Nirmal Patel wrote:
> >> During domain reset process vmd_domain_reset() clears PCI
> >> configuration space of VMD root ports. But certain platform
> >> has observed following errors and failed to boot.
> >>   ...
> >>   DMAR: VT-d detected Invalidation Queue Error: Reason f
> >>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
> >>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
> >>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
> >>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
> >>   DMAR: Invalidation Time-out Error (ITE) cleared
> >>
> >> The root cause is that memset_io() clears prefetchable memory base/limit
> >> registers and prefetchable base/limit 32 bits registers sequentially.
> >> This seems to be enabling prefetchable memory if the device disabled
> >> prefetchable memory originally.
> >>
> >> Here is an example (before memset_io()):
> >>
> >>   PCI configuration space for 10000:00:00.0:
> >>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
> >>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
> >>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
> >>   ...
> >>
> >> So, prefetchable memory is ffffffff00000000-575000fffff, which is
> >> disabled. When memset_io() clears prefetchable base 32 bits register,
> >> the prefetchable memory becomes 0000000000000000-575000fffff, which is
> >> enabled and incorrect.
> > It's not clear to me how this window config causes the VT-d errors.
> > But empirically it seems to be related, and maybe that's enough.
> >
> >> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
> >>
> >>   The Prefetchable Memory Limit register must be programmed to a smaller
> >>   value than the Prefetchable Memory Base register if there is no
> >>   prefetchable memory on the secondary side of the bridge.
> >>
> >> This is believed to be the reason for the failure and in addition the
> >> sequence of operation in vmd_domain_reset() is not following the PCIe
> >> specs.
> >>
> >> Disable the bridge window by executing a sequence of operations
> >> borrowed from pci_disable_bridge_window() and pci_setup_bridge_io(),
> >> that comply with the PCI specifications.
> >>
> >> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> >> ---
> >> v3->v4: Following same operation as pci_setup_bridge_io.
> >> v2->v3: Add more information to commit description.
> >> v1->v2: Follow same chain of operation as pci_disable_bridge_window
> >>         and update commit log.
> >> ---
> >>  drivers/pci/controller/vmd.c | 17 +++++++++++++++--
> >>  1 file changed, 15 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> >> index 769eedeb8802..ae5b4c1704e4 100644
> >> --- a/drivers/pci/controller/vmd.c
> >> +++ b/drivers/pci/controller/vmd.c
> >> @@ -526,8 +526,21 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
> >>  				     PCI_CLASS_BRIDGE_PCI))
> >>  					continue;
> >>  
> >> -				memset_io(base + PCI_IO_BASE, 0,
> >> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> >> +				/* Temporarily disable the I/O range before updating PCI_IO_BASE */
> >> +				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
> >> +				/* Update lower 16 bits of I/O base/limit */
> >> +				writew(0x00f0, base + PCI_IO_BASE);
> >> +				/* Update upper 16 bits of I/O base/limit */
> >> +				writel(0, base + PCI_IO_BASE_UPPER16);
> >> +
> >> +				/* MMIO Base/Limit */
> >> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
> >> +
> >> +				/* Prefetchable MMIO Base/Limit */
> >> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> >> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
> >> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
> >> +				writeb(0, base + PCI_CAPABILITY_LIST);
> > What's the purpose of this PCI_CAPABILITY_LIST write?  I guess you
> > don't want to find PM, MSI, MSI-X, PCIe, etc. capabilities?
> >
> > It's been there since the v1 patch, but the commit log only mentions
> > disabling bridge windows.
> 
> I added it since it was part of original memset_io range. However
> from your previous comment, I checked the lspci output for
> PCI_CAPABILITY_LIST with and without the change and it doesn't seem
> to make any difference.

Ah, I see.  My guess is that was a mistake in the original memset_io()
because I don't see a reason to clear PCI_CAPABILITY_LIST.

PCI_CAPABILITY_LIST is HwInit, so should be read-only in terms of
config accesses, and if lspci sees the same capability list before and
after writing a zero to it, it sounds like it *is* read-only.

Bjorn
