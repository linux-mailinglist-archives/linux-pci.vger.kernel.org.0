Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03A4B2145B
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 09:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfEQHcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 03:32:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:54642 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbfEQHcT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 May 2019 03:32:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 May 2019 00:32:18 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 17 May 2019 00:32:15 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 17 May 2019 10:32:14 +0300
Date:   Fri, 17 May 2019 10:32:14 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] ACPI/PCI: PM: Add missing wakeup.flags.valid checks
Message-ID: <20190517073214.GA2781@lahna.fi.intel.com>
References: <2091978.9z20bSIm3T@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2091978.9z20bSIm3T@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 16, 2019 at 12:42:20PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both acpi_pci_need_resume() and acpi_dev_needs_resume() check if the
> current ACPI wakeup configuration of the device matches what is
> expected as far as system wakeup from sleep states is concerned, as
> reflected by the device_may_wakeup() return value for the device.
> 
> However, they only should do that if wakeup.flags.valid is set for
> the device's ACPI companion, because otherwise the wakeup.prepare_count
> value for it is meaningless.
> 
> Add the missing wakeup.flags.valid checks to these functions.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
