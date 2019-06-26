Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508BF569D5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfFZM4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:56:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:49873 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfFZM4K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 08:56:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 05:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="183165946"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 26 Jun 2019 05:56:07 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Jun 2019 15:56:05 +0300
Date:   Wed, 26 Jun 2019 15:56:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] PCI: PM: Avoid skipping bus-level PM on platforms
 without ACPI
Message-ID: <20190626125605.GT2640@lahna.fi.intel.com>
References: <14605632.7Eqku7tdey@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14605632.7Eqku7tdey@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 12:20:23AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There are platforms that do not call pm_set_suspend_via_firmware(),
> so pm_suspend_via_firmware() returns 'false' on them, but the power
> states of PCI devices (PCIe ports in particular) are changed as a
> result of powering down core platform components during system-wide
> suspend.  Thus the pm_suspend_via_firmware() checks in
> pci_pm_suspend_noirq() and pci_pm_resume_noirq() introduced by
> commit 3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-
> idle") are not sufficient to determine that devices left in D0
> during suspend will remain in D0 during resume and so the bus-level
> power management can be skipped for them.
> 
> For this reason, introduce a new global suspend flag,
> PM_SUSPEND_FLAG_NO_PLATFORM, set it for suspend-to-idle only
> and replace the pm_suspend_via_firmware() checks mentioned above
> with checks against this flag.
> 
> Fixes: 3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-idle")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I tested this patch on top of your (and mine) previous patches touching
the ACPI/PCI PM and did not see any issues over several suspend-to-idle
cycles with and without TBT device connected.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
