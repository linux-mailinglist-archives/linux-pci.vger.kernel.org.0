Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B82B76F9B3
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjHDFx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjHDFx0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 01:53:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B841AB;
        Thu,  3 Aug 2023 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691128405; x=1722664405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GC04UQtSW++hkGap/aB0IJ6PsV2/5cD7Mz2fax7+c4=;
  b=gCUEgQ+T5B+QtlodNByxErn0XNwZfl2Mxn4xRJeIqxzNMp7AWV1WkZg4
   pTyO518E2E4gfiK7vUrgZJK/GhHO7qF2a/drWzLOHP9P6lIQPxH6GOIfX
   7A9YBknPmoT4YDmmgKki6TuZliz//EdwgBTx424DGMaZTkbqCTzxgvo9B
   O0RT9hEQhB2yIAyYqC4NvumkEi3TBPSshmyni4usC6zEci6jYKfcFzJMD
   fcjQt9A72ABOhEUAh+ic7E/7AQMjrqeYn9/ZcQw3sVbcsEaLNjS9I3738
   QyCv51GCIywNs5qGD60aZ6zf3mhwpqRvHY+L3Rka9qSuxWxXWnOiYRzkq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368977378"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="368977378"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819973553"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="819973553"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2023 22:53:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRnkQ-00CPJc-2v;
        Fri, 04 Aug 2023 08:53:14 +0300
Date:   Fri, 4 Aug 2023 08:53:14 +0300
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
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [RFC PATCH v1 05/21] arm64: PCI: Migrate ACPI related functions
 to pci-acpi.c
Message-ID: <ZMySSmy0sNl7Q+rh@smile.fi.intel.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-6-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-6-sunilvl@ventanamicro.com>
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

On Thu, Aug 03, 2023 at 11:29:00PM +0530, Sunil V L wrote:
> The functions defined in arm64 for ACPI support are required
> for RISC-V also. To avoid duplication, copy these functions
> to common location.

...

>  }
> +

Stray change.

>  arch_initcall(acpi_pci_init);
> +
> +#if defined(CONFIG_ARM64)

...

> +	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
> +	if (IS_ERR(cfg)) {
> +		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
> +			PTR_ERR(cfg));
> +		return NULL;
> +	}
> +
> +	return cfg;

Can be

	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
	ret = PTR_ERR_OR_ZERO(cfg);
	if (ret) {
		dev_err(dev, "%04x:%pR error %d mapping ECAM\n", seg, bus_res, ret);

but as far as I understand this is in the original code like this, so consider
as a suggestion for further cleanups.

-- 
With Best Regards,
Andy Shevchenko


