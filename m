Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCB476F9C6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjHDGCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 02:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDGA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 02:00:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A02708;
        Thu,  3 Aug 2023 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691128857; x=1722664857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SAvcwaw2V/Hs8D65jgLxC2s97VzPceMveowD167hosQ=;
  b=KANJQQQ4k0fSDtxjUANjqRnr57v5DXAhKwav/zIDgkCGNJ304xoGNi90
   /Mc9zkJWuTlWnLlE+JXJ9h24jRTYhDh+jFq14hfd8t/MJ40RL3omMEA5e
   hM71oOgtVSMwswZTYQvelYJ7g7VPaM5UUHsYPb3o0I6/ktsrZovUUJW//
   f2f2lGx/H7V78q2z1PPHA9AEaoQTVL0Z7Hk1MWqizntbRPcREzjwFX12d
   qKJSYevfxxYkq7tNM14qVo8nMNf4a9m4LGl0aHnLqS1DRaY5g3ywo1mKa
   Oj9O5ex4xPkUFTBR/9RLYbHUzuhNJH1+O6iqtPag5+hSFgMWai4Ql55Nc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367536838"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="367536838"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="853584925"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="853584925"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 03 Aug 2023 23:00:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRnrh-00CegX-2B;
        Fri, 04 Aug 2023 09:00:45 +0300
Date:   Fri, 4 Aug 2023 09:00:45 +0300
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
Subject: Re: [RFC PATCH v1 08/21] RISC-V: ACPI: RHCT: Add function to get CBO
 block sizes
Message-ID: <ZMyUDZE0SxoOC696@smile.fi.intel.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-9-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-9-sunilvl@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 11:29:03PM +0530, Sunil V L wrote:
> CBO related block size in ACPI is provided by RHCT. Add
> support to read the CMO node in RHCT to get this information.

...

> +	if (!table) {

Why not positive conditional?

> +		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
> +		if (!rhct)
> +			return -ENOENT;
> +	} else {
> +		rhct = (struct acpi_table_rhct *)table;
> +	}

...

> +	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);

> +

Blank line here is not needed.

> +	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
> +	     node < end;
> +	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {

> +			for (int i = 0; i < hart_info->num_offsets; i++) {
> +				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
> +							rhct, hart_info_node_offset[i]);
> +				if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
> +					cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
> +								ref_node, size_hdr);
> +					if (cbom_size)
> +						*cbom_size = 1 << cmo_node->cbom_size;
> +
> +					if (cboz_size)
> +						*cboz_size = 1 << cmo_node->cboz_size;
> +
> +					if (cbop_size)
> +						*cbop_size = 1 << cmo_node->cbop_size;

BIT() in all three cases?

But how you guarantee it will not overflow? I mean who prevents cboX_size to be
bigger than 30 (note also that 31 in your case is Undefined Behaviour in
accordance with the C standard).

> +					return 0;
> +				}
> +			}

> +	}

-- 
With Best Regards,
Andy Shevchenko


