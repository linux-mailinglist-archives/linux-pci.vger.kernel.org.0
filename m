Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE022017D
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfEPIpM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 04:45:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:36135 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfEPIpM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 May 2019 04:45:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 01:45:11 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2019 01:45:08 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hRC0h-0000b7-0h; Thu, 16 May 2019 11:45:07 +0300
Date:   Thu, 16 May 2019 11:45:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     bjorn@helgaas.com
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        AceLan Kao <acelan@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Fwd: [Bug 203485] New: PCI can't map correct memory resource if
 the BAR is 64-bit and then leads to system hang during booting up
Message-ID: <20190516084507.GW9224@smile.fi.intel.com>
References: <bug-203485-193951@https.bugzilla.kernel.org/>
 <CABhMZUWcS0x+E42T3dqzio72wea32pr2GuULXc=+62T+rLAgmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABhMZUWcS0x+E42T3dqzio72wea32pr2GuULXc=+62T+rLAgmQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 15, 2019 at 02:26:13PM -0500, Bjorn Helgaas wrote:
> I should have forwarded this to the list earlier.  Maybe somebody
> wants to work on this?
> 
> I *think* the problem is:
> 
>   - BIOS sets MTRR for 0x40_00000000-0x5f_ffffffff to be write-combining (WC)
>   - That covers part of this PCI aperture: root bus resource [mem
> 0x40_00000000-0x7f_ffffffff window]
>   - That aperture includes a frame buffer: pci 0000:00:02.0: reg 0x18:
> [mem 0x40_00000000-0x40_0fffffff 64bit pref]
>   - Linux assigned an LPSS BAR to the WC area: pci 0000:00:15.0: BAR
> 0: assigned [mem 0x40_10000000-0x40_10000fff 64bit]
>   - The LPSS device doesn't work if MMIO accesses to it are combined via WC
> 
> I'm not an x86/MTRR/PAT expert, but I think we should be able to make
> this work correctly by changing that MTRR from WC to UC (I don't know
> if there are BIOS/OS interface implications with this), or maybe using
> PAT to override the MTRR WC setting to be UC for part or all of that
> aperture.  The frame buffer driver should be smart enough to request
> WC if it wants it.

The window for the PCI resources, provided by PCI Root Bridge, may be split to
many parts as described by _CRS in ACPI, and BIOS should be consistent in
providing both.

I believe there is no issue with Linux in current state. Be "smart" here might
give a downside(s) like reducing coverage to test exactly something as above
BIOS issue.

My 2 cents.

-- 
With Best Regards,
Andy Shevchenko


