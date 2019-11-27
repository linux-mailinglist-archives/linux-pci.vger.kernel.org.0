Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC510AEFF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0LvA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 06:51:00 -0500
Received: from mga06.intel.com ([134.134.136.31]:52599 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfK0LvA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Nov 2019 06:51:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 03:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="217370957"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 27 Nov 2019 03:50:56 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 27 Nov 2019 13:50:55 +0200
Date:   Wed, 27 Nov 2019 13:50:55 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux@endlessm.com,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: increase D3 delay for AMD Ryzen5/7 XHCI
 controllers
Message-ID: <20191127115055.GB11621@lahna.fi.intel.com>
References: <20191127053836.31624-1-drake@endlessm.com>
 <20191127053836.31624-2-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127053836.31624-2-drake@endlessm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 27, 2019 at 01:38:36PM +0800, Daniel Drake wrote:
> On Asus UX434DA (AMD Ryzen7 3700U) and Asus X512DK (AMD Ryzen5 3500U),
> the XHCI controller fails to resume from runtime suspend or s2idle,
> and USB becomes unusable from that point.
> 
> xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
> xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)
> xhci_hcd 0000:03:00.4: WARN: xHC restore state timeout
> xhci_hcd 0000:03:00.4: PCI post-resume error -110!
> xhci_hcd 0000:03:00.4: HC died; cleaning up
> 
> During suspend, a transition to D3cold is attempted, however the affected
> platforms do not seem to cut the power to the PCI device when in this
> state, so the device stays in D3hot.
> 
> Upon resume, the D3hot-to-D0 transition is successful only if the D3 delay
> is increased to 20ms. The transition failure does not appear to be
> detectable as a CRS condition. Add a PCI quirk to increase the delay on the
> affected hardware.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205587
> Link: http://lkml.kernel.org/r/CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
