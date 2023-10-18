Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDA17CE332
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 18:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjJRQwf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 12:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRQwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 12:52:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA07F7;
        Wed, 18 Oct 2023 09:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF27C433C8;
        Wed, 18 Oct 2023 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697647952;
        bh=SsGg2JqeewKiiSWRS7ZexJq3uiXt0rUFI1EQnbTVJAY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cd5ply3z+r3w/NRCWPDxJ7JGivJSePVUFTojZ2T9UrwCvpSDPfOKq8rlamVobPWA/
         klQ8zxpqNwjRrXvaR07x2D3NqvpLbe8kZUFTeqyx2Sm2cPXy5d8CHfFG9vgCvgZzH9
         5DzuCcGUWtlvdg6638VTE9nkOuDYZxFeKstMq7SYaNJ6QU8vQJ9i4FcDXeHJtx5aK3
         4hH/qy3FvyoyLfB/wooOd4aAvB3857LhuNOxquutLG+4KxHDz0yQTmwhbVkI7AygCQ
         2e6n4HG4jVZKvK9rQwI4Q9gOH9EG5xUmJdGBdslWgLYMAGDP89zY5q0gC7y+MIuz/l
         uZ6sWIdoAFWLQ==
Date:   Wed, 18 Oct 2023 11:52:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, tglx@linutronix.de, kevin.tian@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] PCI/MSI: Provide stubs for IMS functions
Message-ID: <20231018165231.GA1365828@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018164351.GA1365452@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 11:43:51AM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 17, 2023 at 10:56:38AM -0700, Reinette Chatre wrote:
> > The IMS related functions (pci_create_ims_domain(),
> > pci_ims_alloc_irq(), and pci_ims_free_irq()) are not declared
> > when CONFIG_PCI_MSI is disabled.
> > 
> > Provide definitions of these functions for use when callers
> > are compiled with CONFIG_PCI_MSI disabled.
> > 
> > Fixes: 0194425af0c8 ("PCI/MSI: Provide IMS (Interrupt Message Store) support")
> > Fixes: c9e5bea27383 ("PCI/MSI: Provide pci_ims_alloc/free_irq()")
> > Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> > Cc: stable@vger.kernel.org      # v6.2+
> 
> Applied to pci/misc for v6.7, thanks!

And dropped, since Thomas applied it via -tip:
https://git.kernel.org/tip/41efa431244f6498833ff8ee8dde28c4924c5479

> > ---
> > 
> > This is a preparatory patch for the first caller of these
> > functions (VFIO) for which work is in progress:
> > https://lore.kernel.org/lkml/cover.1696609476.git.reinette.chatre@intel.com/
> > 
> > checkpatch.pl complains about the usage of ENOSYS but
> > it does appear to be the custom.
> > 
> >  include/linux/pci.h | 34 ++++++++++++++++++++++++++--------
> >  1 file changed, 26 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 8c7c2c3c6c65..b56417276042 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1624,6 +1624,8 @@ struct msix_entry {
> >  	u16	entry;	/* Driver uses to specify entry, OS writes */
> >  };
> >  
> > +struct msi_domain_template;
> > +
> >  #ifdef CONFIG_PCI_MSI
> >  int pci_msi_vec_count(struct pci_dev *dev);
> >  void pci_disable_msi(struct pci_dev *dev);
> > @@ -1656,6 +1658,11 @@ void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
> >  void pci_free_irq_vectors(struct pci_dev *dev);
> >  int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
> >  const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
> > +bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
> > +			   unsigned int hwsize, void *data);
> > +struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
> > +				 const struct irq_affinity_desc *affdesc);
> > +void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
> >  
> >  #else
> >  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
> > @@ -1719,6 +1726,25 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
> >  {
> >  	return cpu_possible_mask;
> >  }
> > +
> > +static inline bool pci_create_ims_domain(struct pci_dev *pdev,
> > +					 const struct msi_domain_template *template,
> > +					 unsigned int hwsize, void *data)
> > +{ return false; }
> > +
> > +static inline struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev,
> > +					       union msi_instance_cookie *icookie,
> > +					       const struct irq_affinity_desc *affdesc)
> > +{
> > +	struct msi_map map = { .index = -ENOSYS, };
> > +
> > +	return map;
> > +}
> > +
> > +static inline void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map)
> > +{
> > +}
> > +
> >  #endif
> >  
> >  /**
> > @@ -2616,14 +2642,6 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
> >  void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> >  #endif
> >  
> > -struct msi_domain_template;
> > -
> > -bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
> > -			   unsigned int hwsize, void *data);
> > -struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_instance_cookie *icookie,
> > -				 const struct irq_affinity_desc *affdesc);
> > -void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
> > -
> >  #include <linux/dma-mapping.h>
> >  
> >  #define pci_printk(level, pdev, fmt, arg...) \
> > -- 
> > 2.34.1
> > 
