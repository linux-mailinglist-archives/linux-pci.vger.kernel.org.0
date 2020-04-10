Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967381A4AA4
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 21:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgDJTiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 15:38:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgDJTiD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Apr 2020 15:38:03 -0400
Received: from localhost (mobile-166-170-220-109.mycingular.net [166.170.220.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1CC20732;
        Fri, 10 Apr 2020 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586547482;
        bh=76FW6bsyi+GvI3cA1295vPvYzfcdLfIdfR/uMK0cqIM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f5aqyeY5H8P+Dg0VtR5VXhNEaIBxx4R/gGzchOa7w+V/JIMrsYuYNV7aLVSvrZntH
         WWv3dp0kGmlDxfECQgMchX8GExkaXAsoMWQhr1nrjc+24qlq2ngw+8X5Yw7mD9qxHN
         rCJAnLyi2B0qmE9qQBazZ/B4H3+CIp6g7so4MwFk=
Date:   Fri, 10 Apr 2020 14:38:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans De Goede <hdegoede@redhat.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        DRI-devel <dri-devel@lists.freedesktop.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH 5/7] PM: sleep: core: Rename DPM_FLAG_NEVER_SKIP
Message-ID: <20200410193800.GA5202@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5092680.jloV5Ae5OO@kreacher>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 05:56:13PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Rename DPM_FLAG_NEVER_SKIP to DPM_FLAG_NO_DIRECT_COMPLETE which
> matches its purpose more closely.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # for PCI parts

> ---
>  Documentation/driver-api/pm/devices.rst    |  6 +++---
>  Documentation/power/pci.rst                | 10 +++++-----
>  drivers/base/power/main.c                  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 +-
>  drivers/gpu/drm/i915/intel_runtime_pm.c    |  2 +-
>  drivers/gpu/drm/radeon/radeon_kms.c        |  2 +-
>  drivers/misc/mei/pci-me.c                  |  2 +-
>  drivers/misc/mei/pci-txe.c                 |  2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c |  2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c  |  2 +-
>  drivers/net/ethernet/intel/igc/igc_main.c  |  2 +-
>  drivers/pci/pcie/portdrv_pci.c             |  2 +-
>  include/linux/pm.h                         |  6 +++---
>  13 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/driver-api/pm/devices.rst b/Documentation/driver-api/pm/devices.rst
> index f66c7b9126ea..4ace0eba4506 100644
> --- a/Documentation/driver-api/pm/devices.rst
> +++ b/Documentation/driver-api/pm/devices.rst
> @@ -361,9 +361,9 @@ the phases are: ``prepare``, ``suspend``, ``suspend_late``, ``suspend_noirq``.
>  	runtime PM disabled.

Minor question about a preceding paragraph that ends:

  In that case, the ``->complete`` callback will be invoked directly
  after the ``->prepare`` callback and is entirely responsible for
  putting the device into a consistent state as appropriate.

What does" a consistent state as appropriate" mean?  I know this is
generic documentation at a high level, so maybe there's no good
explanation for "consistent state," but I don't know what to imagine
there.

And what does "as appropriate" mean?  Would it change the meaning to
drop those two words, or are there situations where it's not
appropriate to put the device into a consistent state?  Or maybe it's
just that the type of device determines what the consistent state is?

>  	This feature also can be controlled by device drivers by using the
> -	``DPM_FLAG_NEVER_SKIP`` and ``DPM_FLAG_SMART_PREPARE`` driver power
> -	management flags.  [Typically, they are set at the time the driver is
> -	probed against the device in question by passing them to the
> +	``DPM_FLAG_NO_DIRECT_COMPLETE`` and ``DPM_FLAG_SMART_PREPARE`` driver
> +	power management flags.  [Typically, they are set at the time the driver
> +	is probed against the device in question by passing them to the
>  	:c:func:`dev_pm_set_driver_flags` helper function.]  If the first of
>  	these flags is set, the PM core will not apply the direct-complete
>  	procedure described above to the given device and, consequenty, to any

s/consequenty/consequently/

Drive-by comment: I looked for a definition of "direct-complete".  The
closest I found is a couple paragraphs above this, where it says "Note
that this direct-complete procedure ...," but that leaves me to try to
reconstruct the definition from the preceding text.

AFAICT, going to freeze, standby, or memory sleep includes these
callbacks:

  ->prepare
  ->suspend
  ->suspend_late
  ->suspend_noirq
  ->complete         (not mentioned in the list of phases)

And "direct-complete" means we skip the suspend, suspend_late,
and suspend_noirq callbacks so we only use these:

  ->prepare
  ->complete

And apparently we skip those callbacks for device X if ->prepare() for
X and all its descendents returns a positive value AND they are all
runtime-suspended, except if a driver for X or a descendent sets
DPM_FLAG_NO_DIRECT_COMPLETE.

Bjorn
