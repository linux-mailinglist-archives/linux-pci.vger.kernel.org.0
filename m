Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC176F9DE
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 08:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjHDGK7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 02:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjHDGK6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 02:10:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CFB2708;
        Thu,  3 Aug 2023 23:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691129457; x=1722665457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+G9GSNfDAvX+Kh/QKq5xmMGn8Ir1PIpjRkZ3yB2HDaQ=;
  b=DDTsdovFGfE13fCAxXybncmShsYRZerR0OhkDOCDFdN9L7EY1pEQpp7F
   KEoPyQSjJY7D+bljCOBQmOo/93TzTdQC1qU0vDvGvriefssRDwv5Haw7g
   GeqDI/M0NTRiUxVh8qu8EDlT6eqi5dtGvJhwKs8mnCBGaySsDc9KHmVv0
   cR+VRj4sCKoxQEgp7qWPM3ES9SKgXvJh1e+xIFEdLkjA9GIAY3IKDFPg1
   puwi2lNOEAQLnOOp2wSv4F/GMzrH9fWlfnlIMXF5zc4IkhrTaTzbDPahf
   h8vEI0noMdnCtPOsGKHh88+yACwj0Y6vG+HX9yKLx3nqFAmPoMQ8576A4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433927389"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="433927389"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:09:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873237868"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 23:09:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRnzw-00Cx13-2f;
        Fri, 04 Aug 2023 09:09:16 +0300
Date:   Fri, 4 Aug 2023 09:09:16 +0300
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
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: [RFC PATCH v1 11/21] swnode: Add support to create early during
 boot
Message-ID: <ZMyWDDD6Lw8REd1r@smile.fi.intel.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-12-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-12-sunilvl@ventanamicro.com>
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

On Thu, Aug 03, 2023 at 11:29:06PM +0530, Sunil V L wrote:
> From: Anup Patel <apatel@ventanamicro.com>
> 
> swnode framework can be used to create fwnode for interrupt
> controllers.

Why? What is this for?
Can you elaborate? This commit message is poorly written...

And why firmware node is not enough for ACPI case?
I assume the fwnode in DT case is already provided by OF.

> This helps in keeping the drivers same for both
> DT and ACPI. To enable this, enhance the swnode framework so
> that it can be created early during boot without dependency
> on sysfs.

...

> -	swnode->kobj.kset = swnode_kset;
> +	swnode->kobj.kset = (!early) ? swnode_kset : NULL;

Too many unneeded characters. Why parentheses? Why negative check?

...

> +	if (early) {
> +		ret = 0;
> +		kobject_init(&swnode->kobj, &software_node_type_early);
> +		swnode->kobj.parent = parent ? &parent->kobj : NULL;
> +		if (node->name)
> +			ret = kobject_set_name(&swnode->kobj,
> +					       "%s", node->name);
> +		else
> +			ret = kobject_set_name(&swnode->kobj,
> +					       "node%d", swnode->id);
> +		if (!ret) {
> +			spin_lock(&swnode_early_lock);
> +			list_add_tail(&swnode->early, &swnode_early_list);
> +			spin_unlock(&swnode_early_lock);
> +		}
> +	} else {
> +		if (node->name)
> +			ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> +						   parent ? &parent->kobj : NULL,

This looks like have a duplication.

> +						   "%s", node->name);
> +		else
> +			ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> +						   parent ? &parent->kobj : NULL,
> +						   "node%d", swnode->id);
> +	}

Maybe it's possible to refactor this piece to be more compact?

...

> -	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0));
> +	return PTR_ERR_OR_ZERO(swnode_register(node, parent, 0, 0));

In one case you use boolean, here is unsigned int for early flag, why is the
inconsistency added?

...

> -struct fwnode_handle *
> -fwnode_create_software_node(const struct property_entry *properties,
> -			    const struct fwnode_handle *parent)
> +static struct fwnode_handle *
> +fwnode_create_software_node_common(const struct property_entry *properties,
> +				   const struct fwnode_handle *parent,
> +				   bool early)

Why would you need this API in early stages?

-- 
With Best Regards,
Andy Shevchenko


