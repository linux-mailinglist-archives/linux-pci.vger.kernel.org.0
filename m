Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538D920E4D8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 00:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbgF2V3g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 17:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391228AbgF2V3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 17:29:35 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17289208DB;
        Mon, 29 Jun 2020 21:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593466174;
        bh=BkG+yGTjXZVHnFw4CzZ0K2Sg1A7LotTp1tk1WvurSIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Z49jyX8fGPzDFYBcQFcoyu+W8uRwpEm0+aaCH1NA5W2mwQMhM0qX7H5IHUPUUHi7j
         QsS/qbS0VhMLwWo/rELHE5LIejYWA3iOO/Cz0/RcGGsvivvMmnq2klCZssKF5kghoG
         IONltDBXInGlrUUEVKFJHB7VW4jAw5JtphSkiol8=
Date:   Mon, 29 Jun 2020 16:29:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: consolidate typing of
 pci_error_handlers::error_detected()
Message-ID: <20200629212928.GA3296753@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628161233.73079-1-luc.vanoostenryck@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 28, 2020 at 06:12:33PM +0200, Luc Van Oostenryck wrote:
> The method struct pci_error_handlers::error_detected() is defined and
> documented as taking an 'enum pci_channel_state' for the second
> argument but most drivers use 'pci_channel_state_t' instead.
> This 'pci_channel_state_t' is not a typedef for the enum but a typedef
> for a bitwise type in order to have better/stricter typechecking.
> 
> So, consolidate everything by using the restricted type in the
> method's definition, in the documentation and in the drivers not
> using 'pci_channel_state_t'.

  $ git grep "\<pci_channel_state\>"
  Documentation/PCI/pci-error-recovery.rst:	enum pci_channel_state {
  Documentation/PCI/pci-error-recovery.rst:pci_channel_state value of pci_channel_io_perm_failure.
  arch/powerpc/kernel/eeh_driver.c:static void eeh_set_channel_state(struct eeh_pe *root, enum pci_channel_state s)
  drivers/net/ethernet/intel/ice/ice_main.c:ice_pci_err_detected(struct pci_dev *pdev, enum pci_channel_state err)
  drivers/pci/pci.h:			enum pci_channel_state state,
  drivers/pci/pcie/err.c:				 enum pci_channel_state state,
  drivers/pci/pcie/err.c:			enum pci_channel_state state,

Should these be changed as well?  If not, why not?  Some of them look
analogous to the ones changed below.

> Note: Currently, from a typechecking point of view this patch change
>       nothing because only the constants defined by the enum
>       are bitwise, not the enum itself (sparse doesn't have
>       the notion of 'bitwise enum'). This may change in some
>       not too far future, hence the patch.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Documentation/PCI/pci-error-recovery.rst    | 2 +-
>  drivers/block/rsxx/core.c                   | 2 +-
>  drivers/dma/ioat/init.c                     | 2 +-
>  drivers/media/pci/ngene/ngene-cards.c       | 2 +-
>  drivers/misc/genwqe/card_base.c             | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 4 ++--
>  drivers/net/ethernet/sfc/efx.c              | 2 +-
>  drivers/net/ethernet/sfc/falcon/efx.c       | 2 +-
>  drivers/pci/pcie/portdrv_pci.c              | 2 +-
>  drivers/scsi/aacraid/linit.c                | 2 +-
>  drivers/scsi/sym53c8xx_2/sym_glue.c         | 2 +-
>  drivers/staging/qlge/qlge_main.c            | 2 +-
>  include/linux/pci.h                         | 2 +-
>  14 files changed, 15 insertions(+), 15 deletions(-)
