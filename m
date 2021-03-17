Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D133EDE9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 11:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhCQKD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 06:03:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:36068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhCQKDG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 06:03:06 -0400
IronPort-SDR: g896kbeENddyzL2K10byCum2y6BRviAoIM62P8wmj7vtclsr7ghZr3/RFRVRQ1yNMCT96TKGiG
 q+dwLw3q/dzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="176562401"
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="176562401"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 03:03:05 -0700
IronPort-SDR: iqCEgAM5vKX1cI4CyzlvjVLZGpGhIl64UTyUWyugrhvvbM03gLJrzJTGhJQxPs/1cOZX1GYBhg
 zAnWx6RKhOQw==
X-IronPort-AV: E=Sophos;i="5.81,255,1610438400"; 
   d="scan'208";a="372290793"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 03:03:02 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 17 Mar 2021 12:02:59 +0200
Date:   Wed, 17 Mar 2021 12:02:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] PCI: PM: Do not read power state in
 pci_enable_device_flags()
Message-ID: <20210317100259.GZ2542@lahna.fi.intel.com>
References: <3219454.74lMxhSOWB@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3219454.74lMxhSOWB@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 16, 2021 at 04:51:40PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It should not be necessary to update the current_state field of
> struct pci_dev in pci_enable_device_flags() before calling
> do_pci_enable_device() for the device, because none of the
> code between that point and the pci_set_power_state() call in
> do_pci_enable_device() invoked later depends on it.
> 
> Moreover, doing that is actively harmful in some cases.  For example,
> if the given PCI device depends on an ACPI power resource whose _STA
> method initially returns 0 ("off"), but the config space of the PCI
> device is accessible and the power state retrieved from the
> PCI_PM_CTRL register is D0, the current_state field in the struct
> pci_dev representing that device will get out of sync with the
> power.state of its ACPI companion object and that will lead to
> power management issues going forward.
> 
> To avoid such issues it is better to leave the current_state value
> as is until it is changed to PCI_D0 by do_pci_enable_device() as
> appropriate.  However, the power state of the device is not changed
> to PCI_D0 if it is already enabled when pci_enable_device_flags()
> gets called for it, so update its current_state in that case, but
> use pci_update_current_state() covering platform PM too for that.
> 
> Link: https://lore.kernel.org/lkml/20210314000439.3138941-1-luzmaximilian@gmail.com/
> Reported-by: Maximilian Luz <luzmaximilian@gmail.com>
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
