Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF654B196
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 14:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiFNMuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiFNMuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 08:50:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62B1FE4;
        Tue, 14 Jun 2022 05:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655211015; x=1686747015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sR2aaiB57VBS6yP/4uYGc/RGXat3SP2yOhau17DVZ0=;
  b=ChwOytZo5Eog5WrBdVaYwZSHHCu/3wpy+kS3HlerFUakp4SG3ZEy81WG
   RW2R+FjAYu9+pzsyErcPqVDGAb8Ahe/dWANnO2yRmVnzZ0blh0RiXbqay
   srJq3ZBWZ9pI49TXP82cKZ8shNLCI4ZorGva7ohnL4w5NCQQO1tHBa+h5
   rSgdHVfggX2Zv7+dWii6KSbCVvdMuhESys0/C9ilgGm4pM1vWPYPNnWOS
   A9K+wK4T2puFdraMZm4XWLs2Mj+VBStQj557FEY9AdAl8O2hqdLxMePl7
   o6WPy9ypYMmSweEyRVIjheEKZ9AyBN9VF78vGXlCg1NxsSQ1KCiA+fGF9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267291524"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="267291524"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:50:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="652018782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:50:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o15zl-000cMV-0w;
        Tue, 14 Jun 2022 15:50:09 +0300
Date:   Tue, 14 Jun 2022 15:50:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource
 allocation
Message-ID: <YqiEAN68MP0l4Mw6@smile.fi.intel.com>
References: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
 <45d458f5-4f4e-9ebd-cb51-1a7b784248ec@redhat.com>
 <Yqh/UJQphSFvxX74@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqh/UJQphSFvxX74@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 03:30:08PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 13, 2022 at 10:31:39PM +0200, Hans de Goede wrote:
> > On 6/13/22 22:16, Andy Shevchenko wrote:
> > > The resource management improve for PCI on x86 broke booting of Intel MID
> > > platforms. It seems that the current code removes all available resources
> > > from the list and none of the PCI device may be initialized. Restore the
> > > old behaviour by force disabling the e820 usage for the resource allocation.
> > > 
> > > Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> > > Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Andy, thank you for the patch. Commit 4c5e242d3e93 has also been causing
> > issues for other platforms, so I've submitted a revert of it here:
> > 
> > https://lore.kernel.org/linux-pci/20220612144325.85366-1-hdegoede@redhat.com/T/#u
> > 
> > can you please give the revert a try, and confirm that that fixes
> > the Intel MID platform issue too ?
> 
> Nope, it doesn't fix. The problem is in flags checking as far as I can see.
> My patch is needed either we have yours or not.

Hold on, it seems I have tried to build something that is not what I develop.
Lemme retest.

-- 
With Best Regards,
Andy Shevchenko


