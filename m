Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B41644AE0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLFSKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 13:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLFSKA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 13:10:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C23B9EB;
        Tue,  6 Dec 2022 10:09:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CCF161831;
        Tue,  6 Dec 2022 18:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A501CC433C1;
        Tue,  6 Dec 2022 18:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350197;
        bh=opSBu2zzyIqLHG9zK6v0tzpsie4Ks4lyGVD5qH9u17M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qJhJSixfltLB0oBCKJDghRSl7IVmh4HXcgQJGmWhGODjMUHawruvRWPCXBKtm6naZ
         qC27p50XL4bkKUNiQIZOrmqqer/5Vt3PQhp7ehZfa7F2VeS4N2ululacIJ2tESCLI0
         15O4ML+g6PGJPTAwfh4Zx3i3CxvaZyMYGFX0R2jlgEYVFAZqiCl2ZxIZyRvyQeXbD5
         vk85Hpg/5UWJWSHvBZWOOjx6kPQqH9uXTwvpWRTShbrdsHjDiuGIZ7n/5n4QeXCkyZ
         wz8z7KBqwQQdO/9ykDIXoKg5EYW2o5t3N6UDIoPuuJtT4XPMoegYkA/WNEwg2Tpr3e
         Ju5MTnrhk3BIQ==
Date:   Tue, 6 Dec 2022 12:09:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Zhuo Chen <chenzhuo.1@bytedance.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 3/9] NTB: Remove pci_aer_clear_nonfatal_status() call
Message-ID: <20221206180956.GA1361309@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928110355.emf2nucmdmpb3vbu@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 02:03:55PM +0300, Serge Semin wrote:
> On Wed, Sep 28, 2022 at 06:59:40PM +0800, Zhuo Chen wrote:
> > There is no need to clear error status during init code, so remove it.
> 
> Why do you think there isn't? Justify in more details.

Thanks for taking a look, Sergey!  I agree we should leave it or add
the rationale here.

> > Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> > ---
> >  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > index 0ed6f809ff2e..fed03217289d 100644
> > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > @@ -2657,8 +2657,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
> >  	ret = pci_enable_pcie_error_reporting(pdev);
> >  	if (ret != 0)
> >  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> > -	else /* Cleanup nonfatal error status before getting to init */
> > -		pci_aer_clear_nonfatal_status(pdev);

I do think drivers should not need to clear errors; I think the PCI
core should be responsible for that.

And I think the core *does* do that in this path:

  pci_init_capabilities
    pci_aer_init
      pci_aer_clear_status
        pci_aer_raw_clear_status
          pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS)
          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS)

pci_aer_clear_nonfatal_status() clears only non-fatal uncorrectable
errors, while pci_aer_init() clears all correctable and all
uncorrectable errors, so the PCI core is already doing more than
idt_init_pci() does.

So I think this change is good because it removes some work from the
driver, but let me know if you think otherwise.

> >  
> >  	/* First enable the PCI device */
> >  	ret = pcim_enable_device(pdev);
> > -- 
> > 2.30.1 (Apple Git-130)
> > 
