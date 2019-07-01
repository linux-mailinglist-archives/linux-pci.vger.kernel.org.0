Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB7C05C103
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfGAQUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 12:20:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:41787 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfGAQUW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 12:20:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jul 2019 09:20:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,440,1557212400"; 
   d="scan'208";a="184280416"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2019 09:20:18 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 01 Jul 2019 19:20:17 +0300
Date:   Mon, 1 Jul 2019 19:20:17 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        "Robert R. Howell" <RHowell@uwyo.edu>
Subject: Re: [PATCH v2 0/5] PM: PCI/ACPI: Hibernation handling fixes
Message-ID: <20190701162017.GB2640@lahna.fi.intel.com>
References: <4976412.ihyb9sT5jY@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4976412.ihyb9sT5jY@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 12:42:14PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series of patches addresses a few issues related to the handling of
> hibernation in the PCI bus type and the ACPI PM domain and ACPI LPSS driver.
> 
> The v2 addresses Hans' concerns regarding the LPSS changes.
> 
> First of all, all of the runtime-suspended PCI devices and devices in the ACPI PM and LPSS
> PM domains will be resumed during hibernation (first patch).  This appears to be the
> only way to avoid weird corner cases and the benefit from avoiding to resume those
> devices during hibernation is questionable.
> 
> That change allows the the hibernation callbacks in all of the involved subsystems to be
> simplified (patches 2 and 3).
> 
> Moreover, reusing bus-level suspend callbacks for the "poweroff" transition during
> hibernation (which is the case for the ACPI PM domain and LPSS) is incorrect, so patch 4
> fixes that.
> 
> Finally, there are some leftover items in linux/acpi.h that can be dropped (patch 5).

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
