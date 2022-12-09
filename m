Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFA648893
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLISnS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 13:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLISnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 13:43:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC4A5B849;
        Fri,  9 Dec 2022 10:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670611393; x=1702147393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nyaa70FbHCVdCRkH/xew841oiCfSftn0b7eTcZYuN4I=;
  b=NFS1Kt8sa4m4aEMvf0Yq+RAZWvxoNVyqkzNlbk/wPHH431vOgCoUZPBK
   5biNHYCJbuD4abLfFhO6Q8EECqi0SMx4Sa/kjnRyK8QzwBqJYr6Eq47bT
   uZ8+wqOVmPLmBsz2w4J2Bk/h1lfkppazet0Dz5Cq/AMQR0dntVdyJixkI
   oUlKTLx0xGK7I3CaY8aJsqy0CeqN7YBG0WUOwpOXhsA2S9fFAMrM9N0CN
   e8OxOcHRYr1F64rPJUfQy3BRKsJufEitxPwuL1mV9xVhOzlFCrSHkvYNC
   QU3oJokU/KlqRJEmHXMCz5eOee68wcQU/BZUvFRrDm3sXd5Hwt2i9aym7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297877869"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="297877869"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 10:43:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="680014911"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="680014911"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2022 10:43:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1p3iKw-0077oM-1P;
        Fri, 09 Dec 2022 20:43:06 +0200
Date:   Fri, 9 Dec 2022 20:43:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 4/4] x86/PCI: Fix log message typo
Message-ID: <Y5OBupWBghHfvG/h@smile.fi.intel.com>
References: <20221208190341.1560157-1-helgaas@kernel.org>
 <20221208190341.1560157-5-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208190341.1560157-5-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 08, 2022 at 01:03:41PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add missing word in the log message:
> 
>   - ... so future kernels can this automatically
>   + ... so future kernels can do this automatically

...

>  	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
>  	       pci_use_e820 ? "Using" : "Ignoring");
>  	if (pci_probe & (PCI_NO_E820 | PCI_USE_E820))
> -		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can this automatically\n");
> +		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");

Wondering if we can change printk(KERN_LVL) to pr_lvl() in this file.

-- 
With Best Regards,
Andy Shevchenko


