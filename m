Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F77399F7F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 13:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFCLII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 07:08:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:12730 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhFCLII (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 07:08:08 -0400
IronPort-SDR: nsIBv/uyF7cgLTuZSTN1A8neRaNu72u1gX99nlqBtBekRBP7UFJT6t2DEMNeeQPS+toHkZ9TBJ
 9ovKO9eJ7vYg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="289649229"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="289649229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:06:22 -0700
IronPort-SDR: Zwk4n1u2Lp+9UNvKqBN2LdbTy0mhfqycav/H6/lfzFNUqHIKrVAvX8lCW5VLOMMWimCe34usUI
 j4t480D+wJHA==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="446250520"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 04:06:18 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 03 Jun 2021 14:06:16 +0300
Date:   Thu, 3 Jun 2021 14:06:16 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/PM: Target PM state is D3cold if the upstream
 bridge is power manageable
Message-ID: <YLi3qI1xEM7jT2B8@lahna.fi.intel.com>
References: <20210531133435.53259-1-mika.westerberg@linux.intel.com>
 <4650685.31r3eYUQgx@kreacher>
 <YLXlzLG199IuVb/G@lahna.fi.intel.com>
 <1792040.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1792040.tdWV9SEqCh@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 02, 2021 at 08:02:38PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 1, 2021 9:46:20 AM CEST Mika Westerberg wrote:
> > Hi Rafael,
> > 
> > On Mon, May 31, 2021 at 07:37:45PM +0200, Rafael J. Wysocki wrote:
> > > On Monday, May 31, 2021 3:34:35 PM CEST Mika Westerberg wrote:
> > > > Some PCIe devices only support PME (Power Management Event) from D3cold.
> > > > One example is ASMedia xHCI controller:
> > > > 
> > > > 11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> > > >   ...
> > > >   Capabilities: [78] Power Management version 3
> > > >   	  Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> > > > 	  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> > > > 
> > > > With such devices, if it has wake enabled, the kernel selects lowest
> > > > possible power state to be D0 in pci_target_state(). This is problematic
> > > > because it prevents the root port it is connected to enter low power
> > > > state too which makes the system consume more energy than necessary.
> > > 
> > > But this is not the only case affected by the patch AFAICS.
> > 
> > Right.
> > 
> > > > The problem in pci_target_state() is that it only accounts the "current"
> > > > device state, so when the bridge above it (a root port for instance) is
> > > > transitioned into D3hot the device transitions into D3cold.
> > > 
> > > Well, as designed, pci_target_state() is about states the the device can
> > > be programmed into, which cannot be D3cold if the device has not platform PM.
> > 
> > Fair enough but the device itself does not need to have platform PM. It
> > is enough that the root port far up in the hierarchy has it.
> > 
> > > > This is because when the root port is first transitioned into D3hot then the
> > > > ACPI power resource is turned off which puts the PCIe link to L2/L3 (and
> > > > the root port and the device are in D3cold). If the root port is kept in
> > > > D3hot it still means that the device below it is still effectively in
> > > > D3cold as no configuration messages pass through. Furthermore the
> > > > implementation note of PCIe 5.0 sec 5.3.1.4 says that the device should
> > > > expect to be transitioned into D3cold soon after its link transitions
> > > > into L2/L3 Ready state.
> > > 
> > > That's true, but the prerequisite is to put the endpoint device into D3hot
> > > and not to attempt to put it into D3cold.
> > 
> > Okay.
> > 
> > > > Taking the above into consideration, instead of forcing the device stay
> > > > in D0 we look at the upstream bridge and whether it is allowed to enter
> > > > D3 (hot/cold). If this is the case we conclude that the actual target
> > > > state of the device is D3cold. This also follows the logic in
> > > > pci_set_power_state() that sets power state of the subordinate devices
> > > > to D3cold after the bridge itself is transitioned into D3cold.
> > > 
> > > IMO what needs to be fixed is what happens when the "wakeup" argument is "true"
> > > and that simply needs to special-case D3hot.
> > > 
> > > Namely, if wakeup from D3hot is not supported, D3hot should still be returned
> > > if wakeup from D3cold is supported and the upstream bridge supports D3cold.
> > 
> > This sounds like a good solution except that we probably need to look
> > further up then to see if any of the bridges above support D3cold,
> > right? For instance if the device is part of TBT topology there may be
> > multiple bridges (PCIe upstream ports, downstream ports) between it and
> > the root port that has the platform PM "support".
> 
> Moreover, pci_enable_wake() would need to be modified to also enable PME if the
> target state is D3hot and only wakeup from D3cold is supported.
> 
> But if pci_enable_wake() is modified this way, we don't need to worry about the
> upstream bridges.  Worst-case wakeup will not work (even though enabled) if the
> device stays in D3hot.
> 
> So pci_target_state() should return D3hot even if wakeup from D3hot itself is
> not supported, but wakeup from D3cold is supported, regardless of what the
> upstream bridges can do (with the assumption that power will get removed from
> the device via an upstream bridge) and pci_enable_wake() should be modified to
> enable PME if the target state is D3hot, but the device can only signal wakeup
> from D3cold.

OK thanks. Let me try this in v3.

> IMO, allowing PME support from D3cold only without providing any means to put
> the device into D3cold is not a valid configuration and it need not be taken
> into account here.

AFAIK you don't need the device to have any other means than that it
responds to the L2/3 handshake properly according to the spec (so that
the link can be put to L2). I think this is perfectly valid configuration :)
