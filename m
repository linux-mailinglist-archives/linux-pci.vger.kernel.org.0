Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6786971A5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjBNXOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBNXOq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:14:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F9BBDF5;
        Tue, 14 Feb 2023 15:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C85B761950;
        Tue, 14 Feb 2023 23:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB375C433D2;
        Tue, 14 Feb 2023 23:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676416484;
        bh=QxRvHCc4hNpKceDWnG8FvxV1/ORxy2IaUSraycNiIXQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hRiTy58XFryg1aPWVrylH3Lr4IJmqI8PabkgW5YYEOIUfqZpCj5j2+s5CcksutF+Q
         GnlCRxMsY6oO57yk8m+ZNkQg+4bPD0En9zAZoU1oGwkxJkuHKBKdfYAhu6sZ8GkUoJ
         LqMkIbsk9LvySN1cpGS3eVTk8zKBBH+bbeiVTodeDE8+eNLu9f4gRyYaQUlBCASU/G
         m4DRRJCIQa2FsA5DUXSC0/pPNjOeu6P046n/pEGVc9qoXoifaQSOqMiJu59I8MKKPM
         w6yhy1dnN7EqRQWKWin/VBK01Mj8eLtAM3Qi+3bpeyqLPzVZTUMBJnSxgGDelI+PKz
         A2t64EZtCTbqQ==
Date:   Tue, 14 Feb 2023 17:14:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, bhelgaas@google.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kevin.tian@intel.com, darwi@linutronix.de
Subject: Re: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
Message-ID: <20230214231442.GA3094409@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8k3rgue.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:02:17AM +0100, Thomas Gleixner wrote:
> On Tue, Feb 14 2023 at 16:24, Bjorn Helgaas wrote:
> >> Provide definitions for pci_msix_alloc_irq_at() and pci_msix_free_irq() in
> >> preparation for users that need to compile when CONFIG_PCI_MSI is
> >> disabled.
> >
> > I think this should have a "Fixes:" tag to connect it with the commit
> > that added pci_msix_alloc_irq_at() and pci_msix_free_irq().
> >
> > Looks like 34026364df8e ("PCI/MSI: Provide post-enable dynamic
> > allocation interfaces for MSI-X").
> >
> > Thomas merged 34026364df8e, so it would be best if he took the fixup
> > as well.
> 
> I did and miserably failed to Cc you on the notification. Sorry about that.
> 
>   https://lore.kernel.org/r/167628749774.4906.17069524905880641563.tip-bot2@tip-bot2

No worries, thank you!
