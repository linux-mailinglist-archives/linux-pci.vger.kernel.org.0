Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E167C2B4BA8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgKPQvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:51:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:38338 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbgKPQvA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 11:51:00 -0500
IronPort-SDR: cOBdZD25TsHyqCduGK+3OpkXUAdc4HLro18lvp0scdlbaC5lxj9XVq5TaxBZ5LRobgHeNooxw8
 to6Ax0JGnrlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="157801204"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="157801204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 08:50:59 -0800
IronPort-SDR: 3EBLUqO2lAiC7jtYzawjBY+G6ESr3YKN+5Bmt4d3ZZ7AedS2aNQXMorgOdxk5hUPDIUS6UkQLX
 2Bisr+WReLag==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="533477258"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 08:50:56 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kehjT-0077HE-3X; Mon, 16 Nov 2020 18:51:59 +0200
Date:   Mon, 16 Nov 2020 18:51:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/7] resource: introduce union(), intersection() API
Message-ID: <20201116165159.GE4077@smile.fi.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 03, 2020 at 10:45:03PM +0200, Andy Shevchenko wrote:
> Some users may want to use resource library to manage their own resources,
> besides existing users that open code union() and intersection()
> implementations.
> 
> Provide a generic API for wider use.

Greg, Rafael, if there is no further comments, can it be applied?

> Changelog v6:
> - added missed tags
> 
> Changelog v5:
> - added test cases (Greg)
> 
> Changelog v4:
> - added Rb tag (Rafael)
> - Cc'ed to LKML and Greg (Rafael)
> 
> Changelog v3:
> - rebased on top of v5.10-rc1
> - dropped upstreamed dependencies
> - added Rb tag to the last patch (Mika)

-- 
With Best Regards,
Andy Shevchenko


