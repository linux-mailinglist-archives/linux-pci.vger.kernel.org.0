Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4A2C3A87
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 09:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgKYIJT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 03:09:19 -0500
Received: from mga14.intel.com ([192.55.52.115]:60172 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgKYIJT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 03:09:19 -0500
IronPort-SDR: SlnXGnSGkSdPCCEpHYOiEpvuLYvA0gXzSxps7l0KtTmV+7xriM3irRWbRDVh7HU5odNeUyGLbD
 8AEbZtt3BrPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="171308887"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="171308887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 00:09:18 -0800
IronPort-SDR: 86ykC7dgvOHKt2RYbLrc+JeVaxAzHUL73SvgE0Ig+dHLXnxBUW3yvpM2Bxo5qmUV1elo+vb50H
 B8z52QfRh9hA==
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="362239650"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 00:09:12 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 25 Nov 2020 10:09:10 +0200
Date:   Wed, 25 Nov 2020 10:09:10 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 2/2] PM: ACPI: Refresh wakeup device power
 configuration every time
Message-ID: <20201125080910.GC2532@lahna.fi.intel.com>
References: <27714988.CF3CpBaniU@kreacher>
 <1717218.WU8ttdIIEu@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717218.WU8ttdIIEu@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24, 2020 at 08:46:38PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> When wakeup signaling is enabled for a bridge for the second (or every
> next) time in a row, its existing device wakeup power configuration
> may not match the new conditions.  For example, some devices below
> it may have been put into low-power states and that changes the
> device wakeup power conditions or similar.  This causes functional
> problems to appear on some systems (for example,  because of it the
> Thunderbolt port on Dell Precision 5550 cannot detect devices plugged
> in after it has been suspended).
> 
> For this reason, modify __acpi_device_wakeup_enable() to refresh the
> device wakeup power configuration of the target device on every
> invocation, not just when it is called for that device first time
> in a row.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
