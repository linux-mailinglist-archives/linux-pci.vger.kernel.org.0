Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8213DA48E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 15:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbhG2NoT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 09:44:19 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:44956 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhG2NoS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 09:44:18 -0400
Received: by mail-oi1-f175.google.com with SMTP id w6so8481328oiv.11;
        Thu, 29 Jul 2021 06:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4MUJTLQyNBDUmaLrQznI2p58A4zdIyxdbFZC77QNdA=;
        b=RAqmNQYUX3VS5yxdHG1TGRh7pke1ns8iFpuG60cD9EbfCSlxGoadSE0qL4fGCVLhO1
         BbACLpHxId2Oj0Le2amTvTKqbWnC2EBdw9pPnGEg6JmdFmsE9vGHkYohmFmOzCeJ2zxG
         eJVOW+K4S2exjetZe2OQb46idsNb47ArxRwmOsfei8Y3AJ0qlIChUWsfclUZ6RfPVMzn
         E4gWzeK/+Fwv7KbAbSQ6ZHmZvdJrF6/rmUFN69S/kkgQHE40WIXvt7UIE9lVsyWLOJbT
         53DJ15hGfOodNC21WAi5xDpwqdQoVmov4bS6NEuTiqUmN6ZleDRVBXKVCzhscwEbXAnB
         1HCw==
X-Gm-Message-State: AOAM532+7k/+AN37Fhwp+r+wimj9+YYECQiDzaBkhGuz3FTfW2WjxpSX
        L8Oz/5T1Br6RuajDHW8WfGy4vWAQoSt3ivoiirc=
X-Google-Smtp-Source: ABdhPJxew3Nr58iygpTRNLBs3zllyLSEpX9PFZm5rv36vU203cUij2xZEDuMW04KbaviIkCwf/ICxVNZbzPvShYsJ0I=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr1129391oib.71.1627566255112;
 Thu, 29 Jul 2021 06:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <3149540.aeNJFYEL58@kreacher> <YQKruWMmSXeH3GL6@lahna>
In-Reply-To: <YQKruWMmSXeH3GL6@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jul 2021 15:44:04 +0200
Message-ID: <CAJZ5v0gUQHV_3A_nFR23M6K8sW6vdVzM3PgTT5yFY9jGUxm2RA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: PM: Add special case handling for PCIe device wakeup
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Koba Ko <koba.ko@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mika,

On Thu, Jul 29, 2021 at 3:23 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Jul 28, 2021 at 07:25:04PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some PCIe devices only support PME (Power Management Event) from
> > D3cold.  One example is the ASMedia xHCI controller:
> >
> >  11:00.0 USB controller: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller (prog-if 30 [XHCI])
> >    ...
> >    Capabilities: [78] Power Management version 3
> >        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
> >        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> >
> > In those cases, if the device is expected to generate wakeup events
> > from its final power state, pci_target_state() returns D0, which
> > prevents the PCIe hierarchy above the device from entering any
> > low-power states too, but the device cannot signal PME from D0
> > either.  However, if the device were allowed to go into D3hot, its
> > parent PCIe port and its ancestors would also be able to go into D3
> > and if any of them goes into D3cold, the device would end up in
> > D3cold too (as per the PCI PM spec v1.2, Table 6-1), in which case
> > it would be able to signal PME.
> >
> > This means that the system could be put into a lower-power
> > configuration while meeting the requirement to enable the device to
> > generate PME from the final state (which is not the case if the
> > device stays in D0 along with the entire hierarchy above it).
> >
> > In order to avoid missing that opportunity, extend pci_pme_capable()
> > to return 'true' in the special case when the target state is D3hot
> > and the device can only signal PME from D3cold and update
> > pci_target_state() to return the current target state if
> > pci_pme_capable() returns 'true' for it.
> >
> > This change can be regarded as a pci_target_state() fix, because that
> > function should ignore its 'wakeup' argument if signaling PME from
> > any power states shallower than the current candidate one (including
> > D0) is not supported.
> >
> > Link: https://lore.kernel.org/linux-pm/20210617123653.58640-1-mika.westerberg@linux.intel.com
> > Fixes: 666ff6f83e1d ("PCI/PM: Avoid using device_may_wakeup() for runtime PM")
> > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
> > Reported-by: Koba Ko <koba.ko@canonical.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Tried this now and it fixes the issue! Also checked with another device
> that actually supports PME from other states than D3cold and it also
> works (as expected).
>
> Feel free to add my,
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thank you!

However, after giving some more consideration to this, I've realized
that it may still not be the cleanest way to address the issue at
hand.

Namely, there are two things we want to happen: (1) pci_target_state()
should return the original candidate target state if 'wakeup' is true,
but the device cannot signal PME from any states shallower than the
original one (including D0) and (2) __pci_enable_wake() should call
pci_pme_active() for devices that support signaling PME from D3cold
regardless of whether or not they support signaling PME from the power
state passed to it (because a device may end up in D3cold as a result
of a transition of the hierarchy above it and PME should be signaled
then).  They are only related to each other because the PME signaling
capability is taken into account in both places, but in fact (1) has
nothing to do with D3cold (and making it effectively depend on whether
or not the device can signal PME from D3cold is somewhat artificial)
and (2) has nothing to do with what the target power state of the
device is.  And so each of these two things should be covered by a
separate patch.

Let me post an alternative patch series in accordance with the above.
