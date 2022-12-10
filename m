Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185E6490C3
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 21:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJU4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Dec 2022 15:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLJU4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Dec 2022 15:56:06 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AD81705D;
        Sat, 10 Dec 2022 12:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670705761; x=1702241761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y7EY/fEnqd+axs7T9udq7qbX8oJHRputjPJmAXvmSEs=;
  b=XDgr22K4dhdQrjCmD2Rfj9jYh10CLQ4TILW5n8FrKh5MrFBIO5YNqIBu
   LzOnjJVdL2p2vCLA9HQ6bHXSrtHGX8go0pHobjIigIBzcjHtnlz2bpSHZ
   Tdz2jSTpiEwz4Y6RpRv8IrnjTmkDwKwcHbdQPKQr0VTTY8xvnJdtegIie
   NxPRzgT1dzM0GKkFA+6s3Eeywd8nIitMlQX3t0T1i+X3UsM10Hz1M5oHQ
   ajFR2SJR+ctS7hfD8GhN6YdbhYAy/z3wLcAJono1PL3BzYttq9Wp3EOkJ
   0HZu/aK0+A8lBbmQrN0Ya2OHhxos5GPhWuinQ564tQxQtc3DifzBmbdZb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="305293144"
X-IronPort-AV: E=Sophos;i="5.96,234,1665471600"; 
   d="scan'208";a="305293144"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2022 12:56:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="772185219"
X-IronPort-AV: E=Sophos;i="5.96,235,1665471600"; 
   d="scan'208";a="772185219"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2022 12:55:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p46sl-007g0s-37;
        Sat, 10 Dec 2022 22:55:39 +0200
Date:   Sat, 10 Dec 2022 22:55:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <Y5TyS2rNxQRIdL5C@smile.fi.intel.com>
References: <Y5OqPSV2RDdkAITE@smile.fi.intel.com>
 <20221209215211.GA1736471@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209215211.GA1736471@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 03:52:11PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 09, 2022 at 11:35:57PM +0200, Andy Shevchenko wrote:
> > On Fri, Dec 09, 2022 at 02:51:31PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Dec 09, 2022 at 08:43:06PM +0200, Andy Shevchenko wrote:

...

> > >     Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > I prefer @linux.intel.com.
> 
> Oops, sorry, I should have known that.  I had copied that from
> the From: line of your email
> (https://lore.kernel.org/r/Y5OBupWBghHfvG/h@smile.fi.intel.com)

I understand. It's not your fault.

-- 
With Best Regards,
Andy Shevchenko


