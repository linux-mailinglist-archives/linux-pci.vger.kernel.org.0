Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371CD52AE25
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 00:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiEQW24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 18:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiEQW2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 18:28:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A02252E56;
        Tue, 17 May 2022 15:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E2DEB81CA8;
        Tue, 17 May 2022 22:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C17C385B8;
        Tue, 17 May 2022 22:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652826532;
        bh=qVAlvmeQlhu1YZJFufPFz1VtxpX4m7jT2Rh3w53ctKU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IyMMjg5hPEBP2Jmo+GjF51uM92OIvbH6Q3C8C91C6uQuRiuebTZ7WiIBZBKVYyvfg
         U5SlB1hNbffYdgVFgO9Yue4sAiylnTd7T6fNGfB/d2iKwGusrRmgQ9NkimEJHp9R5X
         lOjX7AoREotjGFTZEsOwnN05E0m6U+IDEsNJ7uYnY/2mIW9P3z1zhEeZ/7fibNHqK/
         CHVrNKMenpSFpUJJBntAoRyu/wZRowkRJJxf1gBDutpnsMRu48g0DZpqxlSp8jnWSw
         IHVrJJaASVQMd5itvpL+8DNI2gVI6VGyQ869CXfl1mrRuyBZGBFfiVxUD9x/TYoVZ8
         67L+/jmOqpDCg==
Date:   Tue, 17 May 2022 17:28:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver OHalloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220517222849.GA1113887@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ab824c-44a9-239a-9380-2f051f26a079@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 05:29:45PM -0700, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 5/11/22 4:40 PM, Bjorn Helgaas wrote:
> > On Mon, Apr 18, 2022 at 03:02:37PM +0000, Kuppuswamy Sathyanarayanan wrote:
> > > Currently the aer_irq() handler returns IRQ_NONE for cases without bits
> > > PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
> > > assumption is incorrect.
> > > 
> > > Consider a scenario where aer_irq() is triggered for a correctable
> > > error, and while we process the error and before we clear the error
> > > status in "Root Error Status" register, if the same kind of error
> > > is triggered again, since aer_irq() only clears events it saw, the
> > > multi-bit error is left in tact. This will cause the interrupt to fire
> > > again, resulting in entering aer_irq() with just the multi-bit error
> > > logged in the "Root Error Status" register.
> > > 
> > > Repeated AER recovery test has revealed this condition does happen
> > > and this prevents any new interrupt from being triggered. Allow to
> > > process interrupt even if only multi-correctable (BIT 1) or
> > > multi-uncorrectable bit (BIT 3) is set.
> > > 
> > > Also note that, for cases with only multi-bit error is set, since this
> > > is not the first occurrence of the error, PCI_ERR_ROOT_ERR_SRC may have
> > > zero or some junk value. So we cannot cleanly process this error
> > > information using aer_isr_one_error(). All we are attempting with this
> > > fix is to make sure error interrupt processing can continue in this
> > > scenario.
> > > 
> > > This error can be reproduced by making following changes to the
> > > aer_irq() function and by executing the given test commands.
> > > 
> > >   static irqreturn_t aer_irq(int irq, void *context)
> > >           struct aer_err_source e_src = {};
> > > 
> > >           pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS,
> > > 				&e_src.status);
> > >   +       pci_dbg(pdev->port, "Root Error Status: %04x\n",
> > >   +		e_src.status);
> > >           if (!(e_src.status & AER_ERR_STATUS_MASK))
> > 
> > Do you mean
> > 
> >    if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
> > 
> > here?  AER_ERR_STATUS_MASK would be after this fix.
> 
> Yes. You are correct. Do you want me to update it and Fixes tag
> and send next version?

I moved the repro details to a bugzilla, updated the commit log as
below, and applied to pci/error for v5.19, thanks!


commit 203926da2bff ("PCI/AER: Clear MULTI_ERR_COR/UNCOR_RCV bits")
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Mon Apr 18 15:02:37 2022 +0000

    PCI/AER: Clear MULTI_ERR_COR/UNCOR_RCV bits
    
    When a Root Port or Root Complex Event Collector receives an error Message
    e.g., ERR_COR, it sets PCI_ERR_ROOT_COR_RCV in the Root Error Status
    register and logs the Requester ID in the Error Source Identification
    register.  If it receives a second ERR_COR Message before software clears
    PCI_ERR_ROOT_COR_RCV, hardware sets PCI_ERR_ROOT_MULTI_COR_RCV and the
    Requester ID is lost.
    
    In the following scenario, PCI_ERR_ROOT_MULTI_COR_RCV was never cleared:
    
      - hardware receives ERR_COR message
      - hardware sets PCI_ERR_ROOT_COR_RCV
      - aer_irq() entered
      - aer_irq(): status = pci_read_config_dword(PCI_ERR_ROOT_STATUS)
      - aer_irq(): now status == PCI_ERR_ROOT_COR_RCV
      - hardware receives second ERR_COR message
      - hardware sets PCI_ERR_ROOT_MULTI_COR_RCV
      - aer_irq(): pci_write_config_dword(PCI_ERR_ROOT_STATUS, status)
      - PCI_ERR_ROOT_COR_RCV is cleared; PCI_ERR_ROOT_MULTI_COR_RCV is set
      - aer_irq() entered again
      - aer_irq(): status = pci_read_config_dword(PCI_ERR_ROOT_STATUS)
      - aer_irq(): now status == PCI_ERR_ROOT_MULTI_COR_RCV
      - aer_irq() exits because PCI_ERR_ROOT_COR_RCV not set
      - PCI_ERR_ROOT_MULTI_COR_RCV is still set
    
    The same problem occurred with ERR_NONFATAL/ERR_FATAL Messages and
    PCI_ERR_ROOT_UNCOR_RCV and PCI_ERR_ROOT_MULTI_UNCOR_RCV.
    
    Fix the problem by queueing an AER event and clearing the Root Error Status
    bits when any of these bits are set:
    
      PCI_ERR_ROOT_COR_RCV
      PCI_ERR_ROOT_UNCOR_RCV
      PCI_ERR_ROOT_MULTI_COR_RCV
      PCI_ERR_ROOT_MULTI_UNCOR_RCV
    
    See the bugzilla link for details from Eric about how to reproduce this
    problem.
    
    [bhelgaas: commit log, move repro details to bugzilla]
    Fixes: e167bfcaa4cd ("PCI: aerdrv: remove magical ROOT_ERR_STATUS_MASKS")
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=215992
    Link: https://lore.kernel.org/r/20220418150237.1021519-1-sathyanarayanan.kuppuswamy@linux.intel.com
    Reported-by: Eric Badger <ebadger@purestorage.com>
    Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Ashok Raj <ashok.raj@intel.com>
