Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7BF450292
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhKOKhB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 05:37:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:23036 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237118AbhKOKgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 05:36:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220627158"
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="220627158"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:33:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="592055183"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 02:33:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mmZJ6-0071pa-1Q;
        Mon, 15 Nov 2021 12:33:48 +0200
Date:   Mon, 15 Nov 2021 12:33:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <YZI3iyo6qM8MnT5f@smile.fi.intel.com>
References: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
 <20211114062231.GA10937@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211114062231.GA10937@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 14, 2021 at 07:22:31AM +0100, Lukas Wunner wrote:
> On Tue, Nov 09, 2021 at 05:16:04PM +0200, Andy Shevchenko wrote:

...

> > -		/* Is the device part of a Thunderbolt controller? */
> 
> Could you preserve that code comment please so that an uninitiated
> reader knows what the is_thunderbolt flag is about?

Sure!

-- 
With Best Regards,
Andy Shevchenko


