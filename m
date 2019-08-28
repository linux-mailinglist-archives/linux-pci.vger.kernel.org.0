Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771439FF1A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfH1KHm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 06:07:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:39882 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfH1KHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 06:07:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 03:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="210115035"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 03:07:40 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i2urb-0006RD-2L; Wed, 28 Aug 2019 13:07:39 +0300
Date:   Wed, 28 Aug 2019 13:07:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI/AER: Update parameter descriptions to satisfy
 kernel-doc validator
Message-ID: <20190828100739.GJ2680@smile.fi.intel.com>
References: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
 <20190827151823.75312-2-andriy.shevchenko@linux.intel.com>
 <71eb8108-61a7-2815-4082-75c21f8bbf03@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71eb8108-61a7-2815-4082-75c21f8bbf03@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 10:06:54AM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> On 8/27/19 8:18 AM, Andy Shevchenko wrote:
> > Kernel-doc validator complains:
> > 
> > aer.c:207: warning: Function parameter or member 'str' not described in 'pcie_ecrc_get_policy'
> > aer.c:1209: warning: Function parameter or member 'irq' not described in 'aer_isr'
> > aer.c:1209: warning: Function parameter or member 'context' not described in 'aer_isr'
> > aer.c:1209: warning: Excess function parameter 'work' description in 'aer_isr'
> > 
> > Fix the above accordingly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks!
JFYI: Keep your tag on one line. Some bots require this IIRC (patchwork).

-- 
With Best Regards,
Andy Shevchenko


