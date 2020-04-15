Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45741A944A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 09:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbgDOHbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 03:31:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:34449 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408042AbgDOHaL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 03:30:11 -0400
IronPort-SDR: /oKs/UbPK4325ELVukbPySSTekBJIGBNwwS6jlU6SuGF+McYZ3EGcV8x6bUuNk+c2HO0sbnMac
 Qiw2CS06dYBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 00:29:10 -0700
IronPort-SDR: KVCB7M5H4JsEemWSm75DimYacBXeYdJneS1W8cr8ilfn/1KzPxmQkypfkqaDCgcAJqrv8ZXYoK
 /TVsASPy9NOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="363600609"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 15 Apr 2020 00:29:07 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 15 Apr 2020 10:29:06 +0300
Date:   Wed, 15 Apr 2020 10:29:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/PM: Call .bridge_d3() hook only if non-NULL
Message-ID: <20200415072906.GS2586@lahna.fi.intel.com>
References: <20200415000635.144283-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415000635.144283-1-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 07:06:35PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports") added
> the struct pci_platform_pm_ops.bridge_d3() function pointer and
> platform_pci_bridge_d3() to use it.
> 
> The .bridge_d3() op is implemented by acpi_pci_platform_pm, but not by
> mid_pci_platform_pm.  We don't expect platform_pci_bridge_d3() to be called
> on Intel MID platforms, but nothing in the code itself would prevent that.
> 
> Check the .bridge_d3() pointer for NULL before calling it.
> 
> Fixes: 26ad34d510a8 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
