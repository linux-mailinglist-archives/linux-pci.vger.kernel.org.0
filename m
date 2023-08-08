Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232D9774488
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 20:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjHHSVp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjHHSVT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 14:21:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2748DCE7;
        Tue,  8 Aug 2023 10:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691515904; x=1723051904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZvqL6gMp+MCmbuOfROmsCakRiUiVbzabkm79pxLHYV4=;
  b=KOOadlZU+zHvKhA5u8C+ylDVQByPZQJX/h0IpTgB+ORbZPNNCpHItzeP
   Sj3rIL1UepglzWNVswzb2oBhetgQsheXyXz23NgG4CFOa2cniinjALB3q
   ODt9MRU5oUaSqIHs2iZcKxH2xqQOckIy9eBAkZL2LpJnOrLGcoOcdYMLZ
   +LbPlWo8gNEShP8DUZf9YG7iPZNFTebIAQwZtOb6gSYrg9D+hLcqAJTM7
   NikicuG4YMLTJTJjj/0uNa2eivkKsmIZqtiitYSCD9vBxZseHoP//yKDY
   vtgiOJaP7WNVI2icJXUtpJI/FueUX/QqumkCyzBD/fgJsjjYAe08MWGJC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434668210"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="434668210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="845472710"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="845472710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 08 Aug 2023 06:11:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMV2-009CPF-28;
        Tue, 08 Aug 2023 16:11:48 +0300
Date:   Tue, 8 Aug 2023 16:11:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-doc@vger.kernel.org,
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
Subject: Re: [RFC PATCH v1 05/21] arm64: PCI: Migrate ACPI related functions
 to pci-acpi.c
Message-ID: <ZNI/FEkj4VJnZqrF@smile.fi.intel.com>
References: <20230803175916.3174453-6-sunilvl@ventanamicro.com>
 <20230807224152.GA274647@bhelgaas>
 <ZNHJ+lO21c+0P4WN@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNHJ+lO21c+0P4WN@sunil-laptop>
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

On Tue, Aug 08, 2023 at 10:22:10AM +0530, Sunil V L wrote:
> On Mon, Aug 07, 2023 at 05:41:52PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 03, 2023 at 11:29:00PM +0530, Sunil V L wrote:
> > > The functions defined in arm64 for ACPI support are required
> > > for RISC-V also. To avoid duplication, copy these functions
> > > to common location.
> > 
> > I assume this is a "move" (not a copy) and the code being moved isn't
> > being changed.
> 
> Thank you very much for the review!. Yes, it is a move as is. Let me
> update the commit message in next version.

Try to play with -M -C

-- 
With Best Regards,
Andy Shevchenko


