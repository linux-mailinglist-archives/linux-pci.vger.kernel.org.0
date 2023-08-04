Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBC276F9AA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 07:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjHDFsG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 01:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHDFsE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 01:48:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F6A30D5;
        Thu,  3 Aug 2023 22:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691128083; x=1722664083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qUPFpNRJFHWbyQNHSkm00uWou7NNHfy0yV5vWVrDgkE=;
  b=DDN0LdeS37yCyHDxF5U+I0WCrQW2m4PxQs7JpvV5jp7LEPpcPJhBqv1B
   tQgFTHML1SjrrxCUtdG+g3oSJn9syVt1gev7l2q9Iou2MNy37Ld+p7qUj
   x15py7lFaUxiHG1vLFe+1MXfgtX3c8lFYLc4ldag1MFldfmJooSSsokEG
   zlmnYokoe7zyLry6brvPxL+fgLoQ5iYfN4WsP1JTeJr9G/MU5wdlslPay
   ktawGe+puWVtTSon1qcHsLbS1iPG9EGLqnfwffFVA10BE/MVckPsluaz1
   e1ExOe0U9g3TNPfKBns6at49d8jPAhM+JIpOsGrlO3LHM4kBwt5VwLflk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349664475"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349664475"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060595126"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="1060595126"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 22:47:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRnfF-00CEBQ-0v;
        Fri, 04 Aug 2023 08:47:53 +0300
Date:   Fri, 4 Aug 2023 08:47:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [RFC PATCH v1 04/21] RISC-V: ACPI: Enhance acpi_os_ioremap with
 MMIO remapping
Message-ID: <ZMyRCRRkTnR/sK0u@smile.fi.intel.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-5-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-5-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 11:28:59PM +0530, Sunil V L wrote:
> Enhance the acpi_os_ioremap() to support opregions in MMIO
> space. Also, have strict checks using EFI memory map
> to allow remapping the RAM similar to arm64.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>

You may use --cc to the command line when forming patches.

Also we usually consider Cc: as a part of the tag block, meaning no blank line
should be here.

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

...

>  #include <linux/io.h>
>  #include <linux/pci.h>
>  #include <linux/efi.h>
> +#include <linux/memblock.h>

Can you squeeze it to have some order, like to be after io.h (taking into
account given context)?

...

> +			if (memblock_is_map_memory(phys) ||
> +			    !memblock_is_region_memory(phys, size)) {
> +				pr_warn(FW_BUG "requested region covers kernel memory @ %p\n",
> +					&phys);

How %p can be useful here (it's mangled), but also wouldn't this give a hint to
an attacker about the kernel memory location and diminish the KASLR protection?
(IIRC after boot we always have the same salt for the mangling the pointers when
 printing, so at least theoretically it might be possible to bruteforce the
 printing algo to give a clue about the kernel address.)

> +				return NULL;
> +			}

-- 
With Best Regards,
Andy Shevchenko


