Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666CE6990D9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBPKPm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBPKPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:15:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D80CAD3A
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:15:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B96EF61F35
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA413C433EF;
        Thu, 16 Feb 2023 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676542540;
        bh=XKur9k4LKnQWUvdvydbwY+yqyxw0LYwQFSHrjcbPxQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEr+P3JkMgt581zeGl9Hli3xMafG6McSJIqbDv+cC7OwNSAz4AM86t76fhAYBkHey
         DKJeuYNKT6tAlLpNq10hiyMBFHF0eqRVJcBtjQmiCYPRrGE/MLOS5vf8+d7MUNg7w5
         K45W90uakoIYySbGwQCCIYPgAW0kGz9t2bLgB0WDQu8VNfkoCsa+DUOEvtyNysKsoD
         VY5nMcWNZIYfgRbi72WfMuNLzEYjjJO33+q+qFQIRq2TRWK/osaNAE/wt7ggciymJL
         yehbmII6H5Q70dTGXCNNUK1vgtWYEyQdSH6WUr89o5dTCO4Ku79wsIxnNG7XE3lIws
         GcKikEHXX8j4g==
Date:   Thu, 16 Feb 2023 15:45:26 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 02/12] pci: endpoint: do not export pci_epf_type_add_cfs()
Message-ID: <20230216101526.GD2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-3-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-3-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:45PM +0900, Damien Le Moal wrote:
> pci_epf_type_add_cfs() is called only from pci_ep_cfs_add_type_group()
> in drivers/pci/endpoint/pci-ep-cfs.c, so there is no need to export it
> and function drivers should not call this function directly.
> 

Where is the pci_ep_cfs_add_type_group() function defined?

> Remove the export for this function and move its declaration to the
> internal header file drivers/pci/endpoint/pci-epf.h.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c   |  3 ++-
>  drivers/pci/endpoint/pci-epf-core.c | 12 +++++-------
>  drivers/pci/endpoint/pci-epf.h      | 14 ++++++++++++++
>  include/linux/pci-epf.h             |  2 --
>  4 files changed, 21 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/endpoint/pci-epf.h
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 1fb31f07199f..62b3b9e306fa 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -11,9 +11,10 @@
>  #include <linux/slab.h>
>  
>  #include <linux/pci-epc.h>
> -#include <linux/pci-epf.h>
>  #include <linux/pci-ep-cfs.h>
>  
> +#include "pci-epf.h"
> +
>  static DEFINE_IDR(functions_idr);
>  static DEFINE_MUTEX(functions_mutex);
>  static struct config_group *functions_group;
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 9ed556936f48..db121a58a586 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -12,24 +12,23 @@
>  #include <linux/module.h>
>  
>  #include <linux/pci-epc.h>
> -#include <linux/pci-epf.h>
>  #include <linux/pci-ep-cfs.h>
>  
> +#include "pci-epf.h"
> +
>  static DEFINE_MUTEX(pci_epf_mutex);
>  
>  static struct bus_type pci_epf_bus_type;
>  static const struct device_type pci_epf_type;
>  
>  /**
> - * pci_epf_type_add_cfs() - Help function drivers to expose function specific
> - *                          attributes in configfs
> + * pci_epf_type_add_cfs() - Get a function driver specific attribute group.
>   * @epf: the EPF device that has to be configured using configfs
>   * @group: the parent configfs group (corresponding to entries in
>   *         pci_epf_device_id)
>   *
> - * Invoke to expose function specific attributes in configfs. If the function
> - * driver does not have anything to expose (attributes configured by user),
> - * return NULL.
> + * Called from pci_ep_cfs_add_type_group() when the function is created.
> + * If the function driver does not have anything to expose, return NULL.
>   */
>  struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>  					  struct config_group *group)
> @@ -50,7 +49,6 @@ struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>  
>  	return epf_type_group;
>  }
> -EXPORT_SYMBOL_GPL(pci_epf_type_add_cfs);
>  
>  /**
>   * pci_epf_unbind() - Notify the function driver that the binding between the
> diff --git a/drivers/pci/endpoint/pci-epf.h b/drivers/pci/endpoint/pci-epf.h
> new file mode 100644
> index 000000000000..b2f351afd623
> --- /dev/null
> +++ b/drivers/pci/endpoint/pci-epf.h

When there is already a pci-epf.h header available, creating one more even
under different location will create ambiguity. Please rename it as internal.h
or something relevant.

Thanks,
Mani

> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCI Endpoint *Function* (EPF) internal header file
> + */
> +
> +#ifndef PCI_EPF_H
> +#define PCI_EPF_H
> +
> +#include <linux/pci-epf.h>
> +
> +struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
> +					  struct config_group *group);
> +
> +#endif /* PCI_EPF_H */
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 009a07147c61..b89cd8515073 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -209,8 +209,6 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
>  int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
> -struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
> -					  struct config_group *group);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>  #endif /* __LINUX_PCI_EPF_H */
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
