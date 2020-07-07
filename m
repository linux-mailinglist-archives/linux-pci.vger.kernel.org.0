Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54186217AEA
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 00:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgGGWRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 18:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgGGWRK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 18:17:10 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E84920720;
        Tue,  7 Jul 2020 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594160230;
        bh=igRw/elAJpmXW1QKqDLoTjdA6cufEesoAiQ9X3RKU98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BoMX280eZ6j8c0uOMxf7N8F68APr7FNfRfBWmRG8kE/UF2+Ea/a2QAPbPTrtXkOVA
         xH2jXglyK3hKURat5vSMKtHPYw0UE/TZ6xIKvmWcBlulRQygeyGsY4NbH+k9CQcv/r
         QQzd+jaGi93ARw7lHyK+DiNmw5aMyiFQXU94vrIs=
Date:   Tue, 7 Jul 2020 17:17:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] pci: enforce usage of 'pci_channel_state_t'
Message-ID: <20200707221708.GA390968@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702162651.49526-1-luc.vanoostenryck@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 02, 2020 at 06:26:48PM +0200, Luc Van Oostenryck wrote:
> The definition of pci_channel_io_normal and friends is relatively
> complicated and ugly:
> 	typedef unsigned int __bitwise pci_channel_state_t;
> 	enum pci_channel_state {
> 		pci_channel_io_normal = (__force pci_channel_state_t) 1,
> 		...
> 	};
> 
> This is clearly motivated by a desire to have some strong typing
> for this constants but:
> * in C enums are weakly typed (they're essentially the same as 'int')
> * sparse only allow to define bitwise ints, not bitwise enums.
> 
> This series is a preparation step to introduce bitwise enums.
> This would allow to define these constant without having to use
> the force cast:
> 	enum __bitwise pci_channel_state {
> 		pci_channel_io_normal = 1,
> 		...
> 	};
> or, equivalently:
> 	typedef enum __bitwise {
> 		pci_channel_io_normal = 1,
> 		...
> 	} pci_channel_state_t;
> 
> 
> Note: the first patch is, I think, uncontroversial, the other ones
>       less so but can be safely dropped.
> 
> 
> Changes since v1:
> * add missing conversion
> * try to avoid using 'enum pci_channel_state' in include/linux/pci.h
> * try to avoid using 'enum pci_channel_state' in the documentation
> 
> 
> Luc Van Oostenryck (3):
>   pci: use 'pci_channel_state_t' instead of 'enum pci_channel_state'
>   pci: use anonymous 'enum' instead of 'enum pci_channel_state'
>   pci: update to doc to use 'pci_channel_state_t'
> 
>  Documentation/PCI/pci-error-recovery.rst    | 8 ++++----
>  arch/powerpc/kernel/eeh_driver.c            | 2 +-
>  drivers/block/rsxx/core.c                   | 2 +-
>  drivers/dma/ioat/init.c                     | 2 +-
>  drivers/media/pci/ngene/ngene-cards.c       | 2 +-
>  drivers/misc/genwqe/card_base.c             | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c   | 2 +-
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 4 ++--
>  drivers/net/ethernet/sfc/efx.c              | 2 +-
>  drivers/net/ethernet/sfc/falcon/efx.c       | 2 +-
>  drivers/pci/pci.h                           | 2 +-
>  drivers/pci/pcie/err.c                      | 4 ++--
>  drivers/pci/pcie/portdrv_pci.c              | 2 +-
>  drivers/scsi/aacraid/linit.c                | 2 +-
>  drivers/scsi/sym53c8xx_2/sym_glue.c         | 2 +-
>  drivers/staging/qlge/qlge_main.c            | 2 +-
>  include/linux/pci.h                         | 4 ++--
>  18 files changed, 24 insertions(+), 24 deletions(-)

Since it's all basically "use pci_channel_state_t instead of enum
pci_channel_state", I squashed these all together and applied the
result to pci/error for v5.8, thanks!
