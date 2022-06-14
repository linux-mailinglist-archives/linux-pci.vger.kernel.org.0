Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00CA54B0D8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbiFNMdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 08:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiFNMb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 08:31:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A94AE21;
        Tue, 14 Jun 2022 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655209832; x=1686745832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=umN/+tNtTu1lyfbNWcYjSL326rns/NU6j6UQjyCfMA8=;
  b=Zn53Pvo5Bq1HfcT9DzIALAWZDDJ7qEbnVwO021wlpuKUkJgupNqpiUkd
   RbKVXClWoq4Gwp3r4uBmDkYQrQUoe9OIxRg1VP4BjsPJSZvUpRUyqJrSf
   qHxswwjaJyhXBQ5PS1otbM6VWoOs9zd5DqWQ41WJgZh8JoUT5wUNmeZps
   pdQgxS7kOZnbfm11prueT2V8YTtCfcx4CQbatedlZlHWLuLmQB2x69NvC
   OH+QXb1HPwBj9X7zUztS7oPTFEhCwcPozrrzEVh5AyR141cvgLJ1L7row
   7A/ertaGLaA9lx4R3n1/nwgubns6BKzLoDxeQF/a7JTC7piIVseOrDWUv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="278641663"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278641663"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:30:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588438787"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:30:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o15gO-000cLO-7K;
        Tue, 14 Jun 2022 15:30:08 +0300
Date:   Tue, 14 Jun 2022 15:30:08 +0300
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
Message-ID: <Yqh/UJQphSFvxX74@smile.fi.intel.com>
References: <20220613201641.67640-1-andriy.shevchenko@linux.intel.com>
 <45d458f5-4f4e-9ebd-cb51-1a7b784248ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d458f5-4f4e-9ebd-cb51-1a7b784248ec@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 10:31:39PM +0200, Hans de Goede wrote:
> On 6/13/22 22:16, Andy Shevchenko wrote:
> > The resource management improve for PCI on x86 broke booting of Intel MID
> > platforms. It seems that the current code removes all available resources
> > from the list and none of the PCI device may be initialized. Restore the
> > old behaviour by force disabling the e820 usage for the resource allocation.
> > 
> > Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> > Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Andy, thank you for the patch. Commit 4c5e242d3e93 has also been causing
> issues for other platforms, so I've submitted a revert of it here:
> 
> https://lore.kernel.org/linux-pci/20220612144325.85366-1-hdegoede@redhat.com/T/#u
> 
> can you please give the revert a try, and confirm that that fixes
> the Intel MID platform issue too ?

Nope, it doesn't fix. The problem is in flags checking as far as I can see.
My patch is needed either we have yours or not.

-- 
With Best Regards,
Andy Shevchenko


