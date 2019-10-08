Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E1FCFBCE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfJHOBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 10:01:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:54067 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJHOBW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 10:01:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 07:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="277102188"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 08 Oct 2019 07:01:20 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHq3D-0002Fy-RY; Tue, 08 Oct 2019 17:01:19 +0300
Date:   Tue, 8 Oct 2019 17:01:19 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH v3] PCI/AER: Save and restore AER config state
Message-ID: <20191008140119.GM32742@smile.fi.intel.com>
References: <92EBB4272BF81E4089A7126EC1E7B28479AE1393@IRSMSX101.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92EBB4272BF81E4089A7126EC1E7B28479AE1393@IRSMSX101.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, Oct 08, 2019 at 08:07:47AM +0000, Patel, Mayurkumar wrote:
> This patch provides AER config save and restore capabilities. After system
> 
> resume AER config registers settings are lost. Not restoring AER root error
> 
> command register bits on root port if they were set, disables generation
> 
> of an AER interrupt reported by function as described in PCIe spec r4.0,
> 
> sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
> 
> also required to maintain same state prior to system suspend to maintain
> 
> AER interrupts behavior.

This mail is broken since it has HTML part.
Use standard tool to send patches, i.e. git-send-email.

-- 
With Best Regards,
Andy Shevchenko


