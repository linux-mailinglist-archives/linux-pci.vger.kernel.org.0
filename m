Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC4CDC03A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 10:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632753AbfJRIrY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 04:47:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:47270 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730669AbfJRIrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 04:47:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 01:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="371406161"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2019 01:47:21 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iLNur-0008Rg-CS; Fri, 18 Oct 2019 11:47:21 +0300
Date:   Fri, 18 Oct 2019 11:47:21 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [RESEND PATCH v3] PCI/AER: Save and restore AER config state
Message-ID: <20191018084721.GS32742@smile.fi.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28479AE1486@IRSMSX101.ger.corp.intel.com>
 <20191017230908.GA75151@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017230908.GA75151@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 06:09:08PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2019 at 05:22:34PM +0000, Patel, Mayurkumar wrote:
> > This patch provides AER config save and restore capabilities. After system
> > resume AER config registers settings are lost. Not restoring AER root error
> > command register bits on root port if they were set, disables generation
> > of an AER interrupt reported by function as described in PCIe spec r4.0,
> > sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> > also required to maintain same state prior to system suspend to maintain
> > AER interrupts behavior.

> Can you send this as plain text?  The patch seems to be a
> quoted-printable attachment, and I can't figure out how to decode it
> in a way "patch" will understand.

I understand that it changes your workflow and probably you won't like,
though you can use patchwork (either thru web, or directly thru client(s)
like git pw): https://patchwork.ozlabs.org/patch/1173439/

-- 
With Best Regards,
Andy Shevchenko


