Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D964D3DA3F4
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbhG2NXi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 09:23:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:26503 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237688AbhG2NXQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 09:23:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="210996468"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="210996468"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 06:23:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="581334914"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 06:23:08 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 29 Jul 2021 16:23:05 +0300
Date:   Thu, 29 Jul 2021 16:23:05 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Subject: Re: [PATCH v2] PCI: PM: Add special case handling for PCIe device
 wakeup
Message-ID: <YQKruWMmSXeH3GL6@lahna>
References: <3149540.aeNJFYEL58@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3149540.aeNJFYEL58@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rafael,

On Wed, Jul 28, 2021 at 07:25:04PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some PCIe devices only support PME (Power Management Event) from
> D3cold.  One example is the ASMedia xHCI controller:
> 
>  11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
>    ...
>    Capabilities: [78] Power Management version 3
>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> In those cases, if the device is expected to generate wakeup events
> from its final power state, pci_target_state() returns D0, which
> prevents the PCIe hierarchy above the device from entering any
> low-power states too, but the device cannot signal PME from D0
> either.  However, if the device were allowed to go into D3hot, its
> parent PCIe port and its ancestors would also be able to go into D3
> and if any of them goes into D3cold, the device would end up in
> D3cold too (as per the PCI PM spec v1.2, Table 6-1), in which case
> it would be able to signal PME.
> 
> This means that the system could be put into a lower-power
> configuration while meeting the requirement to enable the device to
> generate PME from the final state (which is not the case if the
> device stays in D0 along with the entire hierarchy above it).
> 
> In order to avoid missing that opportunity, extend pci_pme_capable()
> to return 'true' in the special case when the target state is D3hot
> and the device can only signal PME from D3cold and update
> pci_target_state() to return the current target state if
> pci_pme_capable() returns 'true' for it.
> 
> This change can be regarded as a pci_target_state() fix, because that
> function should ignore its 'wakeup' argument if signaling PME from
> any power states shallower than the current candidate one (including
> D0) is not supported.
> 
> Link: https://lore.kernel.org/linux-pm/20210617123653.58640-1-mika.westerberg@linux.intel.com
> Fixes: 666ff6f83e1d ("PCI/PM: Avoid using device_may_wakeup() for runtime PM")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tried this now and it fixes the issue! Also checked with another device
that actually supports PME from other states than D3cold and it also
works (as expected).

Feel free to add my,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
