Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF47B25BE2B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgICJPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Sep 2020 05:15:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:11928 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgICJPa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Sep 2020 05:15:30 -0400
IronPort-SDR: ukH17gRd9vHc2+VsGS3TohXhgXyQl4VeTgeztOH6druTKRQI+EBvs7FIC81FEVpr6Kd9R+EXvp
 JbRMzW73/N5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="219097810"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="219097810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 02:15:28 -0700
IronPort-SDR: rFW+jbc8gBsn7equBPvkpsioGXQfvYEYdufcAcQMn/FHRK+C9m3/X4A0niB0QwR3JCSmFy2edj
 0AD4XprqLVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="405426988"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2020 02:15:23 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Sep 2020 12:15:22 +0300
Date:   Thu, 3 Sep 2020 12:15:22 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/19] thunderbolt: Power Management improvements
Message-ID: <20200903091522.GD1375436@lahna.fi.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 02:58:46PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> This series improves power management in the Thunderbolt driver. We already
> have a quite complete power management on systems where Firmware based
> Connection Manager is used (this is pretty much all non-Apple systems out
> there) so this series adds a couple of optimizations to make certain power
> transitions slightly faster, hopefully improving user experience.
> 
> Rest of the patches improve power management in the Software Connection
> manager side of the driver. USB4 spec covers power management for USB4
> hosts and devices, and also TBT3 compatible devices so these patches
> implement that. We also switch to use device links instead of PCI quirk to
> make sure the Thunderbolt/USB4 host controller is resumed before tunneled
> PCIe and USB 3.x ports (so that it gets the chance to restore the tunnels
> properly before). Tiger Lake systems with Software Connection Manager
> enabled describe these relationships using a new ACPI _DSD property that we
> parse in the driver and populate device links accordingly.
> 
> Mika Westerberg (17):
>   thunderbolt: Software CM only should set force power in Tiger Lake
>   thunderbolt: Use bit 31 to check if Firmware CM is running in Tiger Lake
>   thunderbolt: Do not program NFC buffers for USB4 router protocol adapters
>   thunderbolt: No need to log an error if tb_switch_lane_bonding_enable() fails
>   thunderbolt: Send reset only to first generation routers
>   thunderbolt: Tear down DP tunnels when suspending
>   thunderbolt: Initialize TMU again on resume
>   thunderbolt: Do not change default USB4 router notification timeout
>   thunderbolt: Configure link after lane bonding is enabled
>   thunderbolt: Set port configured for both ends of the link
>   thunderbolt: Configure port for XDomain
>   thunderbolt: Disable lane 1 for XDomain connection
>   thunderbolt: Enable wakes from system suspend
>   PCI / thunderbolt: Switch to use device links instead of PCI quirk
>   ACPI: Export acpi_get_first_physical_node() to modules
>   thunderbolt: Create device links from ACPI description
>   thunderbolt: Add runtime PM for Software CM
> 
> Rajmohan Mani (2):
>   thunderbolt: Optimize Force Power logic
>   thunderbolt: Optimize NHI LC mailbox command processing

All applied to thunderbolt.git/next.

@Rafael, I added your Acked-by to patches 17 and 18 as we discussed
offline.
