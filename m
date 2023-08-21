Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C3782D08
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbjHUPOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjHUPOu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 11:14:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90DEF3
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692630888; x=1724166888;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YYiB90jsq7wEvMTkprQhEoTUGbbROcEmPVfPI5uuIXY=;
  b=RiVga8KNBrVldK6S8tomVQhcvZhNP6leOXYkTXUmmHw5hU9+D38/3A67
   wBhMeSRshnbb/7V0V5iQmY2QTTsgYsr/zERzqP/MbygshupXVR0Tfr9t7
   SGc2y19YItOOV171gDnw6UwKlogW9uM0DAlA27JnpAAhDixogvVd+72O/
   34P9pu5EAoiMzTbc0hOhHJLc+jyc6clUGccJM58NaosFjU9FX879rAJfh
   Zi+rlruotGOIhiczSHe56tyut8dLfR7U8xZ6ROtA11cl/JUK/5uVByORv
   pr97DWLmkKWNF+jF58L8WlnJ4C6TOGQb0zJf+YUqAXul/jxaD91gBCqGw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353188821"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353188821"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="825955919"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="825955919"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.140.53]) ([10.209.140.53])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:14:36 -0700
Message-ID: <3ff1ae04-e514-4c46-ba42-4244a672bf3e@linux.intel.com>
Date:   Mon, 21 Aug 2023 08:14:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: vmd: Disable bridge window for domain reset
Content-Language: en-US
To:     linux-pci@vger.kernel.org
References: <20230810215029.1177379-1-nirmal.patel@linux.intel.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230810215029.1177379-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/10/2023 2:50 PM, Nirmal Patel wrote:
> During domain reset process vmd_domain_reset() clears PCI
> configuration space of VMD root ports. But certain platform
> has observed following errors and failed to boot.
>   ...
>   DMAR: VT-d detected Invalidation Queue Error: Reason f
>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
>   DMAR: Invalidation Time-out Error (ITE) cleared
>
> The root cause is that memset_io() clears prefetchable memory base/limit
> registers and prefetchable base/limit 32 bits registers sequentially.
> This seems to be enabling prefetchable memory if the device disabled
> prefetchable memory originally.
>
> Here is an example (before memset_io()):
>
>   PCI configuration space for 10000:00:00.0:
>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
>   ...
>
> So, prefetchable memory is ffffffff00000000-575000fffff, which is
> disabled. When memset_io() clears prefetchable base 32 bits register,
> the prefetchable memory becomes 0000000000000000-575000fffff, which is
> enabled and incorrect.
>
> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>
>   The Prefetchable Memory Limit register must be programmed to a smaller
>   value than the Prefetchable Memory Base register if there is no
>   prefetchable memory on the secondary side of the bridge.
>
> This is believed to be the reason for the failure and in addition the
> sequence of operation in vmd_domain_reset() is not following the PCIe
> specs.
>
> Disable the bridge window by executing a sequence of operations
> borrowed from pci_disable_bridge_window() and pci_setup_bridge_io(),
> that comply with the PCI specifications.
>
> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> ---
> v4->v5: Revome PCI_CAPABILITY_LIST from the reset.
> v3->v4: Following same operation as pci_setup_bridge_io.
> v2->v3: Add more information to commit description.
> v1->v2: Follow same chain of operation as pci_disable_bridge_window
>         and update commit log.
> ---
>  drivers/pci/controller/vmd.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 769eedeb8802..c5b1295ab208 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -526,8 +526,23 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>  				     PCI_CLASS_BRIDGE_PCI))
>  					continue;
>  
> -				memset_io(base + PCI_IO_BASE, 0,
> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
> +				/*
> +				 * Temporarily disable the I/O range before updating
> +				 * PCI_IO_BASE.
> +				 */
> +				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
> +				/* Update lower 16 bits of I/O base/limit */
> +				writew(0x00f0, base + PCI_IO_BASE);
> +				/* Update upper 16 bits of I/O base/limit */
> +				writel(0, base + PCI_IO_BASE_UPPER16);
> +
> +				/* MMIO Base/Limit */
> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
> +
> +				/* Prefetchable MMIO Base/Limit */
> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
>  			}
>  		}
>  	}

Gentle Ping

Thanks

