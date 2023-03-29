Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C296CF502
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 23:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC2VIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 17:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjC2VIL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 17:08:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378535FD4;
        Wed, 29 Mar 2023 14:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680124086; x=1711660086;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0WbHcAshlB1DzsXUrQf8jEaAyPq5dNotVV1y6M7Emps=;
  b=QoEXuGB0sIt/SEO0hJbwdWm8tgKtSoVZR1ccMwPgxa27+fDVCIX2E7Kn
   6Kh4OOW/DbpJt619+/WlUNq8chsjwYU4nwOa6DXjDgAwq9sRyDVLTuDt8
   G4INFZcdl6N3Z3+sDtNbZTW8g5xFq9YVev8bJSfLqoq/WYw3DWPsGdO5g
   KhoyXSl2QerAhEXnqYfyzpx485Sf0QdrYydkVAIQhHb00hMWosp0rQiyV
   VEulLMzn08Bjgg4Dav9sabIf1edNKta4fP7Zv9iAIccOhWoYAB46gYawS
   xZdj4XPAJVim7bgb2w3pt8bPWu+GMWRMddt2A9N24QeK7OvhRiyFXTSOV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="341017779"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="341017779"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:08:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="684441300"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="684441300"
Received: from tinabao-mobl1.amr.corp.intel.com (HELO [10.209.80.72]) ([10.209.80.72])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:08:05 -0700
Message-ID: <e7657d91-38a8-9ee6-43eb-985d6545a0d1@linux.intel.com>
Date:   Wed, 29 Mar 2023 14:08:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] PCI/MSI: Provide missing stub for
 pci_msix_can_alloc_dyn()
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, bhelgaas@google.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        tglx@linutronix.de
Cc:     darwi@linutronix.de, kevin.tian@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <310ecc4815dae4174031062f525245f0755c70e2.1680119924.git.reinette.chatre@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <310ecc4815dae4174031062f525245f0755c70e2.1680119924.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/29/23 1:13 PM, Reinette Chatre wrote:
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
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
