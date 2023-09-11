Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2179B033
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjIKVha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbjIKU5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 16:57:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD13C17;
        Mon, 11 Sep 2023 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694465537; x=1726001537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74b3SgpPHonhG4WHBUjAVxMA0p2luRUXXNpPdJQ6VmM=;
  b=ZD4CtUBMMEDFKYmZfGaxg2zC7KIvLz9IlKK9Umv3V9jMuNGVYJ31uW73
   0/LiwocYMGaEGTy23kyH/UVRkHjQeBeKCnmAXol4OsN8WeaRJbiI2Z/SN
   KGrjRlT6+avAMSpOMpI5g7B6p+taGwV9+CIbMttvpoAZTgJENGQWPBRKt
   xoRfjN7EAiWuzKKrv0vhIyXKGrWHGY42UbL63Xb5qXYe6l8YgM4KioQnD
   WOuWQ1l5p3gf5UEaH3CdR6JSty+nqQCbNJ+WfINEF04pELNiC2OitVJ15
   qylip/jEy6sagpDcjS0UStWwsZjZYp1/O6ADZK+LUa829L1Zvc/C6pS7z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368455909"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="368455909"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720125738"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="720125738"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 13:48:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qfnpO-008Q8E-01;
        Mon, 11 Sep 2023 23:48:14 +0300
Date:   Mon, 11 Sep 2023 23:48:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Subject: Re: [PATCH V13 1/5] of: dynamic: Add interfaces for creating device
 node dynamically
Message-ID: <ZP99DdtruXfI6L/L@smile.fi.intel.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-2-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692120000-46900-2-git-send-email-lizhi.hou@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 10:19:56AM -0700, Lizhi Hou wrote:
> of_changeset_create_node() creates device node dynamically and attaches
> the newly created node to a changeset.
> 
> Expand of_changeset APIs to handle specific types of properties.
>     of_changeset_add_prop_string()
>     of_changeset_add_prop_string_array()
>     of_changeset_add_prop_u32_array()

...

> +/**
> + * of_changeset_add_prop_string - Add a string property to a changeset
> + *
> + * @ocs:	changeset pointer
> + * @np:		device node pointer
> + * @prop_name:	name of the property to be added
> + * @str:	pointer to null terminated string
> + *
> + * Create a string property and add it to a changeset.
> + *
> + * Return: 0 on success, a negative error value in case of an error.
> + */
> +int of_changeset_add_prop_string(struct of_changeset *ocs,
> +				 struct device_node *np,
> +				 const char *prop_name, const char *str)
> +{
> +	struct property prop;
> +
> +	prop.name = (char *)prop_name;

This looks not nice. You dropped const qualifier, which is a bit worrying.
Can  you fix underneath APIs/data types so we can avoid this?

> +	prop.length = strlen(str) + 1;

> +	prop.value = (void *)str;

Do you need this casting?

Okay, seems also related to the const qualifier. I would accept this in a form
of const void *, but it will probably look a bit weird. What about to have a value
to be a union?

> +	return of_changeset_add_prop_helper(ocs, np, &prop);
> +}

...

> +	prop.name = (char *)prop_name;

Same comment as per above.

...

> +	prop.length = 0;
> +	for (i = 0; i < sz; i++)
> +		prop.length += strlen(str_array[i]) + 1;
> +
> +	prop.value = kmalloc(prop.length, GFP_KERNEL);
> +	if (!prop.value)
> +		return -ENOMEM;
> +
> +	vp = prop.value;
> +	for (i = 0; i < sz; i++) {
> +		vp += snprintf(vp, (char *)prop.value + prop.length - vp, "%s",
> +			       str_array[i]) + 1;
> +	}

Is all this kinda of reinventing kasprintf()? Perhaps you can somehow utilize
kasprintf_strarray()? It might require to get a common denominator that takes
a formatting string as a parameter.

> +	ret = of_changeset_add_prop_helper(ocs, np, &prop);
> +	kfree(prop.value);

...

> +	for (i = 0; i < sz; i++)
> +		val[i] = cpu_to_be32(array[i]);

NIH cpu_to_be32_array()

...

> +	prop.name = (char *)prop_name;
> +	prop.length = sizeof(u32) * sz;
> +	prop.value = (void *)val;

Do you need this casting?

-- 
With Best Regards,
Andy Shevchenko


