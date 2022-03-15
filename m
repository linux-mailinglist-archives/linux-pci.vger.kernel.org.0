Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB14D986B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 11:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346974AbiCOKLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 06:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbiCOKLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 06:11:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227224FC63;
        Tue, 15 Mar 2022 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647338991; x=1678874991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQdJwp3QYFB6RzA76W+Kf3fw3JbIyIWnKEdmFYEY0Rc=;
  b=cnSZxhNOVfO8ZVqouCPZc6Krbti2zEcWE3Y8TUFAH5jLzE/lmosyvi2K
   t9yyxC18zihIJnT3+phK+hM5dpzHwJgzM4kaFy8B1zr8Ef1JGnbmTFvB2
   QxSqTOwiC5ndqAnDcrM7TQu2Go93QJGE3XOhXNnP5y0ALExKArqY/F3qh
   gmhmlAtAc3nVIJa0+lzq+fUE0h/M1Rm0L15T+yksKh2UkqOWZPzfszmZ0
   uuUYkDqLNEwFMur7PxrshDeIDDT/SunWTjQc6MQJy1+CH7IQ3kB9pSOTy
   6Mlzz6keo+bpJsZMkUyJ4nC/LkLejKh7tVl+pknUiRt8sY5pWbOPFE8rB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253822133"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="253822133"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:09:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="515807284"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 03:09:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nU472-000CDY-QY;
        Tue, 15 Mar 2022 12:09:08 +0200
Date:   Tue, 15 Mar 2022 12:09:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, micklorain@protonmail.com
Subject: Re: [PATCH v1 1/1] PCI: Enable INTx quirk for ATI PCIe-USB adapter
Message-ID: <YjBlxOi0ljZVUb/D@smile.fi.intel.com>
References: <20220314101448.90074-1-andriy.shevchenko@linux.intel.com>
 <20220314194253.GA515821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314194253.GA515821@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 14, 2022 at 02:42:53PM -0500, Bjorn Helgaas wrote:
> On Mon, Mar 14, 2022 at 12:14:48PM +0200, Andy Shevchenko wrote:
> > ATI PCIe-USB adapter advertises MSI, but it doesn't work if INTx is disabled.
> > Enable the respective quirk as it's done for other ATI devices on this chipset,
> > 
> > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> 
> This is interesting because there must be a TON of these AMD/ATI SB600
> USB devices in the field, and 306c54d0edb6 was merged in July 2020 and
> appeared in v5.9.
> 
> So why would we only get a report now, in February 2022?  Is there
> some change more recent than 306c54d0edb6 that exposed this problem?

I think it's a rhetorical question. To me it's as simple as the latency
between getting the change into the kernel.

However, I'm a bit worried that in case of ATI there are not so many
platforms that are kept up-to-dated.

-- 
With Best Regards,
Andy Shevchenko


