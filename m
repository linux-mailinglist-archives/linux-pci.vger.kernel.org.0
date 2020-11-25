Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2574D2C3A79
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 09:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgKYIHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 03:07:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:65092 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgKYIHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 03:07:08 -0500
IronPort-SDR: 0LxcttN07aAYUtUiTtigLEC5/gAp+Rnp2NTYdQl4Vw+7WFFTURcle6pL7aauFFPoS89Ve8/vtA
 6Tl569TnMDyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172244065"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="172244065"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 00:07:05 -0800
IronPort-SDR: i8smOXMHi2IWQtJp5vzRd/iYtOun9bTO172CUBgV17TJhR9iQnXIDS5/Zc/5MhBzDdn62x/UR4
 j3oauEfYsRoQ==
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="332892300"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 00:07:02 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 25 Nov 2020 10:06:59 +0200
Date:   Wed, 25 Nov 2020 10:06:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 1/2] PM: ACPI: PCI: Drop acpi_pm_set_bridge_wakeup()
Message-ID: <20201125080659.GB2532@lahna.fi.intel.com>
References: <27714988.CF3CpBaniU@kreacher>
 <2261308.G18gbxz5ee@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2261308.G18gbxz5ee@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24, 2020 at 08:44:00PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The idea behind acpi_pm_set_bridge_wakeup() was to allow bridges to
> be reference counted for wakeup enabling, because they may be enabled
> to signal wakeup on behalf of their subordinate devices and that
> may happen for multiple times in a row, whereas for the other devices
> it only makes sense to enable wakeup signaling once.
> 
> However, this becomes problematic if the bridge itself is suspended,
> because it is treated as a "regular" device in that case and the
> reference counting doesn't work.
> 
> For instance, suppose that there are two devices below a bridge and
> they both can signal wakeup.  Every time one of them is suspended,
> wakeup signaling is enabled for the bridge, so when they both have
> been suspended, the bridge's wakeup reference counter value is 2.
> 
> Say that the bridge is suspended subsequently and acpi_pci_wakeup()
> is called for it.  Because the bridge can signal wakeup, that
> function will invoke acpi_pm_set_device_wakeup() to configure it
> and __acpi_pm_set_device_wakeup() will be called with the last
> argument equal to 1.  This causes __acpi_device_wakeup_enable()
> invoked by it to omit the reference counting, because the reference
> counter of the target device (the bridge) is 2 at that time.
> 
> Now say that the bridge resumes and one of the device below it
> resumes too, so the bridge's reference counter becomes 0 and
> wakeup signaling is disabled for it, but there is still the other
> suspended device which may need the bridge to signal wakeup on its
> behalf and that is not going to work.
> 
> To address this scenario, use wakeup enable reference counting for
> all devices, not just for bridges, so drop the last argument from
> __acpi_device_wakeup_enable() and __acpi_pm_set_device_wakeup(),
> which causes acpi_pm_set_device_wakeup() and
> acpi_pm_set_bridge_wakeup() to become identical, so drop the latter
> and use the former instead of it everywhere.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
