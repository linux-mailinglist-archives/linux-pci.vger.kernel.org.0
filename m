Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D93215636
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 13:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGFLTC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 07:19:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:4224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgGFLTC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 07:19:02 -0400
IronPort-SDR: fVbjt2e/FxMgvifC0Q+pNdksXPXhJ2FSLyGnD+NkWQnqzRJvRkGy1V4mBeZxm3yKgSsnisnUVC
 pKQMFIas0yEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="208906252"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="208906252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 04:18:59 -0700
IronPort-SDR: CkvcnafcAq0wj1NOWXdNnYlEaDH+C6gumbNDNNlxdxLRxjC60QYE/XJk4TFBqMrIuzIK4of9WP
 cIzl/8N39+7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="315136144"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2020 04:18:57 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jsP9G-000IhX-E3; Mon, 06 Jul 2020 14:18:58 +0300
Date:   Mon, 6 Jul 2020 14:18:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Message-ID: <20200706111858.GT3703480@smile.fi.intel.com>
References: <20200630163332.GA3437879@bjorn-Precision-5520>
 <873664syw0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873664syw0.fsf@nanos.tec.linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 12:47:59PM +0200, Thomas Gleixner wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Tue, Jun 30, 2020 at 12:39:08PM +0300, Andy Shevchenko wrote:
> >> The problem here is in the original patch which relies on the
> >> knowledge that fwnode is (was) not used anyhow specifically for ACPI
> >> case. That said, it makes fwnode a dangling pointer which I
> >> personally consider as a mine left for others. That's why the Fixes
> >> refers to the initial commit. The latter just has been blasted on
> >> that mine.
> 
> No. The original patch did not create a dangling pointer because fwnode
> was not stored for IRQCHIP_FWNODE_NAMED and IRQCHIP_FWNODE_NAMED_ID type
> nodes.
> 
> The fail was introduced in:
> 
> 711419e504eb ("irqdomain: Add the missing assignment of domain->fwnode for named fwnode")

Ah, sorry for missing that and thank you for pointing out.

-- 
With Best Regards,
Andy Shevchenko


