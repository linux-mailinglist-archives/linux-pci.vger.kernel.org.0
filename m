Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B8555409
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732578AbfFYQJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 12:09:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:8904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbfFYQJW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 12:09:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 09:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="182917442"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 09:09:18 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 19:09:18 +0300
Date:   Tue, 25 Jun 2019 19:09:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: PM/ACPI: Refresh all stale power state data in
 pci_pm_complete()
Message-ID: <20190625160918.GK2640@lahna.fi.intel.com>
References: <6435024.1ODgWP2se3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6435024.1ODgWP2se3@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 02:09:12PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In pci_pm_complete() there are checks to decide whether or not to
> resume devices that were left in runtime-suspend during the preceding
> system-wide transition into a sleep state.  They involve checking the
> current power state of the device and comparing it with the power
> state of it set before the preceding system-wide transition, but the
> platform component of the device's power state is not handled
> correctly in there.
> 
> Namely, on platforms with ACPI, the device power state information
> needs to be updated with care, so that the reference counters of
> power resources used by the device (if any) are set to ensure that
> the refreshed power state of it will be maintained going forward.
> 
> To that end, introduce a new ->refresh_state() platform PM callback
> for PCI devices, for asking the platform to refresh the device power
> state data and ensure that the corresponding power state will be
> maintained going forward, make it invoke acpi_device_update_power()
> (for devices with ACPI PM) on platforms with ACPI and make
> pci_pm_complete() use it, through a new pci_refresh_power_state()
> wrapper function.
> 
> Fixes: a0d2a959d3da (PCI: Avoid unnecessary resume after direct-complete)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I also tested this on Ice Lake system and did not see any issues over
several suspend-to-ram cycles.
