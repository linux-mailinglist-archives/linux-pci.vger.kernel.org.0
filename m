Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD56DA051
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbjDFStg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbjDFStX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CABB47A;
        Thu,  6 Apr 2023 11:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B829560DD3;
        Thu,  6 Apr 2023 18:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA31C433EF;
        Thu,  6 Apr 2023 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806901;
        bh=pl57oZSe0jdCMT2RcmKFvtRgHAztuw1b3LYiVrGLo1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QrjN0P04y167ErdLcmrfdZi9m+PVvpY+NzG4FbaVDNQy4pOq0eRKDFUmekp2dc9Sw
         766jRVRlaP0+w5GumM7tHcLFzk4zBP3VbFaaZ8gmmw6cf4pFlp1YbcPaY5i5cWI/PQ
         /b2t69beJjuqCjdCD7gQJ9g0hW0TIh1GLIpNepqYJaTq8zpCmZd4oYKGT00/jR3MBa
         qXRs/zdejMp7iK5GVA7s7ulqlLE3104zbX12THwUXOuSLhrWmllmDc6xP3M1B1t2S9
         4EzClRHoBwg2U0CbBkKTSDOr/dQTokGUpTAAJua96kt8/D8RAcKSVZgHQUB21OyB73
         xayIgNDU0iIMQ==
Date:   Thu, 6 Apr 2023 13:48:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, tglx@linutronix.de, darwi@linutronix.de,
        kevin.tian@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        Shay Drory <shayd@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Eli Cohen <elic@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH] PCI/MSI: Provide missing stub for
 pci_msix_can_alloc_dyn()
Message-ID: <20230406184819.GA3722907@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <310ecc4815dae4174031062f525245f0755c70e2.1680119924.git.reinette.chatre@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc folks from Arnd's similar patch]

On Wed, Mar 29, 2023 at 01:13:11PM -0700, Reinette Chatre wrote:
> pci_msix_can_alloc_dyn() is not declared when CONFIG_PCI_MSI
> is disabled.
> 
> There is no existing user of pci_msix_can_alloc_dyn() but
> work is in progress to change this. This work encounters
> the following error when CONFIG_PCI_MSI is disabled:
> 
> drivers/vfio/pci/vfio_pci_intrs.c:427:21: error: implicit declaration \
> 	of function 'pci_msix_can_alloc_dyn' \
> 	[-Werror=implicit-function-declaration]
> 
> Provide definition for pci_msix_can_alloc_dyn() in preparation
> for users that need to compile when CONFIG_PCI_MSI is disabled.
> 
> Fixes: 34026364df8e ("PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303291000.PWFqGCxH-lkp@intel.com/
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Applied with Sathy's reviewed-by to for-linus for v6.3, thanks!

I also added the Fixes: line for mlx5 from Arnd's patch.

> ---
> I missed this one in my previous fix. After this all the functions
> in pci.h's #ifdef CONFIG_PCI_MSI portion have stubs when
> CONFIG_PCI_MSI is disabled.
> 
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index b50e5c79f7e3..a5dda515fcd1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1624,6 +1624,8 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  					      flags, NULL);
>  }
>  
> +static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
> +{ return false; }
>  static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
>  						   const struct irq_affinity_desc *affdesc)
>  {
> -- 
> 2.34.1
> 
