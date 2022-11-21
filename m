Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7518632236
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKUMei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiKUMeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:34:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2A6AFE65;
        Mon, 21 Nov 2022 04:34:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBB3461149;
        Mon, 21 Nov 2022 12:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30172C433D6;
        Mon, 21 Nov 2022 12:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669034044;
        bh=ZwT+dnfKh4H9gTwAC+BKBYdBZ8TmrMahu5H8qVC6lZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oCWuS3JGmuHudj46cpvkJxWaiSA+U33wiAPA25Qf/3ZqAEF//DV1n3X7QvucNZlZv
         RDoV4QsXb2DRY12LD3tCnxpMGsVRRaZPn5m9NrmJ+tbzLmrpmGZy4duU2DLD0JoIUN
         EWI2AW+Wvik+JhETIYIJCXhFbbwTxPMBMwIJq1AT0nci57KknzyDiIt4tTCwxq+sXI
         Tb2ahXPPwU5arGAlpp1ElTtiI5dWACBP8hXXKwYJ+SzUWhTZgCorFUSX0EtYEa6jjD
         k2wRJKHq4Delqipwlk1g7/1hkt04FN5hgpwXabTYRBhiQ9qrhHVNNUSIxGmfWIcFm3
         Vt+g5taNoojUQ==
Date:   Mon, 21 Nov 2022 06:34:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, linux-doc@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PCI/MSI: api: Use bullet lists in kernel-doc comments
Message-ID: <20221121123402.GA100653@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121101245.23544-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bagas,

If you have opportunity, please update the subject line to remove
"api: " to match previous history:

  PCI/MSI: Correct 'can_mask' test in msi_add_msi_desc()
  PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
  PCI/MSI: Prevent UAF in error path
  PCI/MSI: Unbreak pci_irq_get_affinity()
  PCI/MSI: Use msi_on_each_desc()
  PCI/MSI: Let core code free MSI descriptors
  PCI/MSI: Use msi_add_msi_desc()
  PCI/MSI: Protect MSI operations
  PCI/MSI: Simplify pci_irq_get_affinity()
  ...

On Mon, Nov 21, 2022 at 05:12:45PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reported htmldocs warnings when merging tip tree:
> 
> Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:148: ERROR: Unexpected indentation.
> Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:149: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:236: ERROR: Unexpected indentation.
> Documentation/PCI/msi-howto:380: drivers/pci/msi/api.c:259: ERROR: Unexpected indentation.
> 
> Use bullet lists syntax for pci_disable_msix flags and interrupt mode lists
> to fix these warnings.
> 
> Link: https://lore.kernel.org/linux-next/20221121184100.0974cc35@canb.auug.org.au/
> Fixes: 5c0997dc33ac24 ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
> Fixes: 017239c8db2093 ("PCI/MSI: Move pci_irq_vector() to api.c")
> Fixes: be37b8428b7b77 ("PCI/MSI: Move pci_irq_get_affinity() to api.c")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
