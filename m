Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1EF2317A
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2019 12:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfETKkB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 May 2019 06:40:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:54204 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfETKkB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 May 2019 06:40:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 03:40:00 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 20 May 2019 03:39:58 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 20 May 2019 13:39:57 +0300
Date:   Mon, 20 May 2019 13:39:57 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] PCI: PM: Avoid possible suspend-to-idle issue
Message-ID: <20190520103957.GL2781@lahna.fi.intel.com>
References: <2315917.ZGeXE6pBFC@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2315917.ZGeXE6pBFC@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 17, 2019 at 11:08:50AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a PCI driver leaves the device handled by it in D0 and calls
> pci_save_state() on the device in its ->suspend() or ->suspend_late()
> callback, it can expect the device to stay in D0 over the whole
> s2idle cycle.  However, that may not be the case if there is a
> spurious wakeup while the system is suspended, because in that case
> pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
> which calls pci_restore_state(), via pci_pm_default_resume_early(),
> so state_saved is cleared and the second iteration of
> pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
> may change the power state of the device.
> 
> To avoid that, add a new internal flag, skip_bus_pm, that will be set
> by pci_pm_suspend_noirq() when it runs for the first time during the
> given system suspend-resume cycle if the state of the device has
> been saved already and the device is still in D0.  Setting that flag
> will cause the next iterations of pci_pm_suspend_noirq() to set
> state_saved for pci_pm_resume_noirq(), so that it always restores the
> device state from the originally saved data, and avoid calling
> pci_prepare_to_sleep() for the device.
> 
> Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from suspend-to-idle")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
