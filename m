Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030362014D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Nov 2022 22:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKGVhn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 16:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiKGVhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 16:37:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A8D9;
        Mon,  7 Nov 2022 13:37:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBF78612D5;
        Mon,  7 Nov 2022 21:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC7C433D6;
        Mon,  7 Nov 2022 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667857061;
        bh=T2Ymb2x245aa2ScFXcWkFua5HIUae1DGKTKUll+OBec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HdhozuACVbWX6bKTRIioUFaE5L3ZgEt4f5bqfJPjfhUL/TkWVTdFN8DBM9WwppI9m
         TXQLUZkj7BjVHq36fHM+6D3+Q+VNAABtzQ0jCbkQ5XvvMIkUw957s2HOLXhsC4Rmuq
         tJx0Bk2meKFUDRhTxpPOT5+gABL5tfBkAU0Oz/c7PuGPeEpPKrrGUpKPzgMRLQb2Wf
         MIXx2qqEnOHnUIpRt4mAer3Rln01RG+rMGKcOW28zGs1Po482XYwBMCutR6QhgvoX2
         jBWgY3uyK7whMZG+Z8XaAW/6+2EVrlLFVXy6k+QEuIscQMDZ5SQcGzmMmpZ2FHGjWq
         4UXbGnuzlbuFA==
Date:   Mon, 7 Nov 2022 15:37:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Christophe Fergeau <cfergeau@redhat.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Clear PCI_STATUS when setting up the device
Message-ID: <20221107213739.GA422107@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104155339.GA95864@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 04, 2022 at 10:53:39AM -0500, Bjorn Helgaas wrote:
> On Tue, May 17, 2022 at 12:37:38PM +0800, Kai-Heng Feng wrote:
> > We are seeing Master Abort bit is set on Intel I350 ethernet device and its
> > root port right after boot, probably happened during BIOS phase:
> > 
> > 00:06.0 PCI bridge [0604]: Intel Corporation Device [8086:464d] (rev 05) (prog-if 00 [Normal decode])
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > 
> > 6e:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
> >         Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > 
> > 6e:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Network Connection [8086:1521] (rev 01)
> >         Subsystem: Intel Corporation Ethernet Server Adapter I350-T2 [8086:00a2]
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
> > 
> > And the Master Abort bit is cleared after S3.
> > 
> > Since there's no functional impact found, clear the PCI_STATUS to treat
> > it anew at setting up.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215989
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> This patch appeared in v6.0 as 6cd514e58f12 ("PCI: Clear PCI_STATUS
> when setting up device").  Christophe reported in the bugzilla that it
> causes boot failures:
> 
> > --- Comment #3 from Christophe Fergeau (cfergeau@redhat.com) ---
> > This commit
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c
> > d514e58f12b211d638dbf6f791fa18d854f09c
> > references this issue.
> > This commit causes boot failures when trying to start linux guests with Apple's
> > hypervisor framework (for example using https://github.com/evansm7/vftool ).
> > After reverting it, I can successfully boot 6.1-rc kernels on my macOS12 x86_64
> > macbook. With this commit, the VM fails to start, additional details in
> > https://bugzilla.redhat.com/show_bug.cgi?id=2137803

I queued up a revert for v6.2.  Obviously I would prefer if we could
figure out how to clear PCI_STATUS while still letting the guests
boot, but I have no idea how to debug the boot failures.

  commit 44e985938e85 ("Revert "PCI: Clear PCI_STATUS when setting up device"")
  Author: Bjorn Helgaas <bhelgaas@google.com>
  Date:   Mon Nov 7 15:31:08 2022 -0600

      Revert "PCI: Clear PCI_STATUS when setting up device"
      
      This reverts commit 6cd514e58f12b211d638dbf6f791fa18d854f09c.
      
      Christophe Fergeau reported that 6cd514e58f12 ("PCI: Clear PCI_STATUS when
      setting up device") causes boot failures when trying to start linux guests
      with Apple's virtualization framework (for example using
      https://developer.apple.com/documentation/virtualization/running_linux_in_a_virtual_machine?language=objc)
      
      6cd514e58f12 only solved a cosmetic problem, so revert it to fix the boot
      failures.
      
      Link: https://bugzilla.redhat.com/show_bug.cgi?id=2137803
      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

  diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
  index b66fa42c4b1f..1d6f7b502020 100644
  --- a/drivers/pci/probe.c
  +++ b/drivers/pci/probe.c
  @@ -1891,9 +1891,6 @@ int pci_setup_device(struct pci_dev *dev)
   
	  dev->broken_intx_masking = pci_intx_mask_broken(dev);
   
  -	/* Clear errors left from system firmware */
  -	pci_write_config_word(dev, PCI_STATUS, 0xffff);
  -
	  switch (dev->hdr_type) {		    /* header type */
	  case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
		  if (class == PCI_CLASS_BRIDGE_PCI)

> > ---
> >  drivers/pci/probe.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 17a969942d370..414f659dc8735 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1890,6 +1890,9 @@ int pci_setup_device(struct pci_dev *dev)
> >  
> >  	dev->broken_intx_masking = pci_intx_mask_broken(dev);
> >  
> > +	/* Clear errors left from system firmware */
> > +	pci_write_config_word(dev, PCI_STATUS, 0xffff);
> > +
> >  	switch (dev->hdr_type) {		    /* header type */
> >  	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
> >  		if (class == PCI_CLASS_BRIDGE_PCI)
> > -- 
> > 2.34.1
> > 
