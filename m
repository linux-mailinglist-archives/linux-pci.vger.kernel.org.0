Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82086770672
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 18:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjHDQ4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjHDQ4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 12:56:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A31994;
        Fri,  4 Aug 2023 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691168197; x=1722704197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gpDidnsvALbETLwYUDIaqkBOrRmLDkWhHtFiUIEPsrc=;
  b=nVAj6Ki+r/HOcAoZl0tVkX9yVOmFL5BwoY+SdflYbP2ebK9ZRyGrXPZh
   RfbKMEZq/ugTq+c0ZNTRmaUxXtqX1UKQEUdcV32RgNgC8Yf83AaP1GL8j
   AysF0YJXaxTD5IL+bLG+cv8YSXOXz5z9QDKTJgCUV6zae6V3fbDEeD8n3
   AUsrfCG9K5ziIqYePqtB8fiCLqul/dBUPxiEWasTqcdDcoGayXVm4T/Zn
   rJtUHHEfX+ZlWR783UV+MoDwcAnWo+7yXzJfxjQCe9wgL1rQRNQy7h37P
   zZBDRqk+nspXIDyCzN7ndZh+OlYrRaqRasaUysLRwsyzVPHG5IUnkbjCD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="401156666"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="401156666"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 09:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="723705867"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="723705867"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 04 Aug 2023 09:56:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRy6E-00HEmR-1a;
        Fri, 04 Aug 2023 19:56:26 +0300
Date:   Fri, 4 Aug 2023 19:56:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <ZM0tuv5mdgHLdrsr@smile.fi.intel.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-10-sunilvl@ventanamicro.com>
 <ZMyTDcffqXYT29JX@smile.fi.intel.com>
 <ZMzC4nHOJOfp0vaa@sunil-laptop>
 <ZM0SZwL9SXrEuFMT@smile.fi.intel.com>
 <20230804-dreamy-unharmed-a502d02af35a@spud>
 <ZM0s6GrfXqx4fu+l@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM0s6GrfXqx4fu+l@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 04, 2023 at 07:52:56PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 04, 2023 at 04:19:27PM +0100, Conor Dooley wrote:
> > On Fri, Aug 04, 2023 at 05:59:51PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 04, 2023 at 02:50:34PM +0530, Sunil V L wrote:
> > > > On Fri, Aug 04, 2023 at 08:56:29AM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Aug 03, 2023 at 11:29:04PM +0530, Sunil V L wrote:

...

> > > > > > +#include <asm/acpi.h>
> > > > > 
> > > > > What do you need this for?
> > > > > 
> > > > > >  #include <asm/cacheflush.h>
> > > > > 
> > > > When CONFIG_ACPI is disabled, this include is required to get
> > > > acpi_get_cbo_block_size().
> > > 
> > > How is it useful without ACPI being enabled?
> > 
> > It is not, as evidenced by the `return -EINVAL;`.
> > 
> > > If it's indeed
> > > (in which I do not believe), better to make sure you have it
> > > avaiable independently on CONFIG_ACPI. Otherwise, just put
> > > #ifdef CONFIG_ACPI around the call.
> > 
> > Let's not litter the code with ifdeffery please where it can be easily
> > avoided.
> 
> Including asm/acpi.h looks to me as a "let's avoid it with a hack that it
> is uglier than ifdeffery". Sorry, but ifdeffery for ACPI, with all my full
> agreement with the statement that it's not good, is the correct way to fix
> this.

On the other hand this is an arch code and I see precedents of using the
headers together, alas, it seems not better to me that ugly ifdeffery.

So, I leave it to the respective maintainers to decide.

-- 
With Best Regards,
Andy Shevchenko


