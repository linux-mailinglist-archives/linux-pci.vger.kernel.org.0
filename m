Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A2777E0E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjHJQWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjHJQWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 12:22:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B65D2720;
        Thu, 10 Aug 2023 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691684520; x=1723220520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWq6dCf4cYGOwqVbu2yiUVYDMiHlk4tpUH4BbuUdCek=;
  b=bWlKhhBCJ2CJH5AzW67mLH6Bnfkh+yTzhREALbJTScrkExQadaDFjkFK
   fJkM+PWtB8whbivWLg4HMgo4XiX28oeOvPGIIGnf10O/bLSffZc2atSbp
   A5+UYwR6Z1YgIZ1u5EWHsTizH0FAINXMjYPkchI6sh70aSVV/XJOpmZaV
   eiyTsiKdj1AlK4sAwAnkgVGuOFpkC2ErdeF9YFCXv5sseT0Du1vOtNoBr
   G1g/jrItfwuyPZ7F8nDMyw/CS/rtFjsyaSxTxsF8XjzRQd+eH9YP/thNs
   mXN8qi+D5VvVF40NN1oZgdfm93F5KcPtyIMMbuZLy6ZjnVbm2GJkGIXC3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351055223"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="351055223"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 09:21:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709218140"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="709218140"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 09:21:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU8Q7-008ihS-2F;
        Thu, 10 Aug 2023 19:21:55 +0300
Date:   Thu, 10 Aug 2023 19:21:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v11 8/9] PCI: Split PME state selection into a local
 static function
Message-ID: <ZNUOo+OKEv6zfPSY@smile.fi.intel.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-9-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809185453.40916-9-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 09, 2023 at 01:54:52PM -0500, Mario Limonciello wrote:
> When a device is not power manageable by the platform, and not already
> in a low power state pci_target_state() will find the deepest state
> that PME is supported and use this to select the wakeup state.
> 
> Simplify this logic and split it out to a local function. No intended
> functional changes.

...

> +static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
> +{
> +	pci_power_t state = PCI_D3hot;
> +
> +	while (state && !(dev->pme_support & (1 << state)))
> +		state--;
> +
> +	return state;

Sparse won't be happy about this code (with CF=-D__CHECK_ENDIAN__).

Basically it's something like

	return (__force pci_power_t)fls(dev->pme_support & GENMASK(PCI_D3hot, 0));

(but double check and test the logic).

> +}

...

Yeah, I see that is the existing code, perhaps amend it first?

-- 
With Best Regards,
Andy Shevchenko


