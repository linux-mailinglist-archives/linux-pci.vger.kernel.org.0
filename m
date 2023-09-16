Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B050C7A2F49
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 12:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjIPKmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Sep 2023 06:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIPKmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Sep 2023 06:42:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA705C7;
        Sat, 16 Sep 2023 03:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694860927; x=1726396927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E1ZWsG3yhjCVQFM0cAQVsfHBzlJHbot5FxPJHCpxOpQ=;
  b=QznFnuXZI/slRWUOlles9v2LjchQ12XFAZR0c6j//2VcrCnqwrPKaZLE
   IWAJU3LbLYeFCo1hdbiNzW5V79/NqvedKCU+mn5evebnHJOSqgDk9hfow
   DS0Pxrrei2KbMsox8KR1eJAMGMq50uSaLDcbDR8zhUj83VdTiBUtCFZ4n
   CByFAAKo64ZbjU+mczOF9VPHgfTrBQWHk1XzQ8Jghzl1FpkyuIYhHtciD
   Pz6uUj4XbXJ6yCU7yesEUesDKYsMRbdJscih916rUKpOdmZHTiF9+1QHC
   wV5nI67UtCv0LynJmSRhlHs1u5QIdr8ktS9CwG+eXaNnTk4P/Pre/LCRn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359653523"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="359653523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 03:42:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="780392440"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="780392440"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 03:42:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qhSkS-0000000Fdqv-0pXU;
        Sat, 16 Sep 2023 13:42:00 +0300
Date:   Sat, 16 Sep 2023 13:41:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/1] PCI: mediatek: Correct type for virt_to_phys()
Message-ID: <ZQWGd/RyKaUBRhUY@smile.fi.intel.com>
References: <20230914192324.672997-1-andriy.shevchenko@linux.intel.com>
 <20230914203146.GA77870@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914203146.GA77870@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 14, 2023 at 03:31:46PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 14, 2023 at 10:23:24PM +0300, Andy Shevchenko wrote:

...

> > -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> > +	addr = virt_to_phys((__force void *)port->base + PCIE_MSI_VECTOR);
> 
> Lots of these drivers use either virt_to_phys() or
> platform_get_resource_byname() to get a physical address that they
> then use as the MSI target.
> 
> But I don't think that's quite right -- the MSI is a DMA transaction
> on PCI, and in general there's no guarantee that bus addresses are
> identical to CPU physical addresses, so shouldn't we use a dma_addr_t
> obtained from the DMA API?
> 
> dw_pcie_msi_host_init() has a complicated version of this that uses
> dmam_alloc_coherent().

Fair enough. I leave it to you then to get it fixed properly.
Consider this as just a heads up for the old report.

-- 
With Best Regards,
Andy Shevchenko


