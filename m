Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA67703C0
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjHDPAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDPAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 11:00:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57548AC;
        Fri,  4 Aug 2023 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691161217; x=1722697217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MpvATlDjjJZIna8broQzbePYRa5IYY2XnpYjRR2L2Mg=;
  b=P4DNPlDpOjaHrVRWn3Wy7sS/FpauNxNnHt/rvW/GEJOenPHBgPTkd+33
   q1oyJmJWz7jrfrU2JtmT7j4t4C971MxanetmfKXcZHTLlKenjXKL6B46N
   HwV8FpHQREKqOGYM+6LSCpFaWbge2BW4vu1IIIq2QXCBJu/TBSg4ldB6O
   /W5FSyogjIehq9Q9/6NnF0TvqlB8cpVEp+B6qsuRFHREVGi1eHDRX2zDy
   jqgO6Qg2+2fkK2+wLqQff9SbZEO9GfuNRrsKsv+geX3mvHEtVwmwDpRxJ
   NT79MCO7GxGVZAArn1uQ8KZC6HEo2CRS4Uk6AP2EjZnufAViAEUvGicXI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369070010"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="369070010"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 08:00:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="730091090"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="730091090"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2023 07:59:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRwHP-00DIKr-1l;
        Fri, 04 Aug 2023 17:59:51 +0300
Date:   Fri, 4 Aug 2023 17:59:51 +0300
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
Subject: Re: [RFC PATCH v1 09/21] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <ZM0SZwL9SXrEuFMT@smile.fi.intel.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-10-sunilvl@ventanamicro.com>
 <ZMyTDcffqXYT29JX@smile.fi.intel.com>
 <ZMzC4nHOJOfp0vaa@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMzC4nHOJOfp0vaa@sunil-laptop>
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

On Fri, Aug 04, 2023 at 02:50:34PM +0530, Sunil V L wrote:
> On Fri, Aug 04, 2023 at 08:56:29AM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 03, 2023 at 11:29:04PM +0530, Sunil V L wrote:
> > > Using new interface to get the CBO block size information in
> > > RHCT, initialize the variables on ACPI platforms.

...

> > > +#include <asm/acpi.h>
> > 
> > What do you need this for?
> > 
> > >  #include <asm/cacheflush.h>
> > 
> When CONFIG_ACPI is disabled, this include is required to get
> acpi_get_cbo_block_size().

How is it useful without ACPI being enabled?  If it's indeed
(in which I do not believe), better to make sure you have it
avaiable independently on CONFIG_ACPI. Otherwise, just put
#ifdef CONFIG_ACPI around the call.

-- 
With Best Regards,
Andy Shevchenko


