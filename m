Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10F32FF62C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jan 2021 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbhAUUmw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jan 2021 15:42:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:44895 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727459AbhAUUmc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jan 2021 15:42:32 -0500
IronPort-SDR: qrHyRx6+hj5fDanU5FnnpNj00RWHfpsXgXukbWNiZ+QERAMke/QyqEX39oXilcAQxubQ32qeeW
 w5fsBAisw6zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="243416471"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="243416471"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:40:37 -0800
IronPort-SDR: Rr4DoKevT+g5dZ6hx/wrxwD3LZ+q52T4F7qD4my6qpHZrNVVOPwbSDuqjLIrLCj6ugxQ1kmQNQ
 g7OoXfoBK0Vw==
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="351587401"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 12:40:34 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2gls-007zQL-NK; Thu, 21 Jan 2021 22:41:36 +0200
Date:   Thu, 21 Jan 2021 22:41:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     srikanth.thokala@intel.com, bhelgaas@google.com,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <YAnnALx/ZHJ+Euhq@smile.fi.intel.com>
References: <20210122032610.4958-3-srikanth.thokala@intel.com>
 <20210121195206.GA2678455@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121195206.GA2678455@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 01:52:06PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 22, 2021 at 08:56:10AM +0530, srikanth.thokala@intel.com wrote:

> > Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>

This list seems strange. Shouldn't be your SoB last?

...

> <checks MAINTAINERS> ... yep, all previous entries are in alphabetical
> order.  This new one just got dropped at the end.
> 
> I feel like a broken record, but please, please, take a look at the
> surrounding code/text/whatever, and MAKE YOUR NEW STUFF MATCH THE
> EXISTING STYLE.  We want the whole thing to be reasonably consistent
> so readers can make sense of it without being confused by the
> idiosyncrasies of every contributor.

I guess even checkpatch.pl should complain about this these days.

-- 
With Best Regards,
Andy Shevchenko


