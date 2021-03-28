Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56C34BBE3
	for <lists+linux-pci@lfdr.de>; Sun, 28 Mar 2021 12:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC1Jxx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Mar 2021 05:53:53 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:57801 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhC1Jxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Mar 2021 05:53:34 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E27652800B3E0;
        Sun, 28 Mar 2021 11:53:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D6C861EEC7; Sun, 28 Mar 2021 11:53:32 +0200 (CEST)
Date:   Sun, 28 Mar 2021 11:53:32 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210328095332.GA8657@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
 <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
 <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
 <CAC41dw_BJBMdwyccdvWNZsdAzzh7ko=q4oSpQXo-jJDTfQGkZw@mail.gmail.com>
 <20210317190151.GA27146@wunner.de>
 <0a020128-80e8-76a7-6b94-e165d3c6f778@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a020128-80e8-76a7-6b94-e165d3c6f778@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 17, 2021 at 01:02:07PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 3/17/21 12:01 PM, Lukas Wunner wrote:
> > If the events are ignored, the driver of the device in the hotplug slot
> > is not unbound and rebound.  So the driver must be able to cope with
> > loss of TLPs during DPC recovery and it must be able to cope with
> > whatever state the endpoint device is in after DPC recovery.
> > Is this really safe?  How does the nvme driver deal with it?
> 
> During DPC recovery, in pcie_do_recovery() function, we use
> report_frozen_detected() to notify all devices attached to the port
> about the fatal error. After this notification, we expect all
> affected devices to halt its IO transactions.
> 
> Regarding state restoration, after successful recovery, we use
> report_slot_reset() to notify about the slot/link reset. So device
> drivers are expected to restore the device to working state after this
> notification.

Thanks a lot for the explanation.


> I am not sure how pure firmware DPC recovery works. Is there a platform
> which uses this combination? For firmware DPC model, spec does not clarify
> following points.
> 
> 1. Who will notify the affected device drivers to halt the IO transactions.
> 2. Who is responsible to restore the state of the device after link reset.
> 
> IMO, pure firmware DPC does not support seamless recovery. I think after it
> clears the DPC trigger status, it might expect hotplug handler be responsible
> for device recovery.
> 
> I don't want to add fix to the code path that I don't understand. This is the
> reason for extending this logic to pure firmware DPC case.

I agree, let's just declare synchronization of pciehp with
pure firmware DPC recovery as unsupported for now.


I've just submitted a refined version of my patch to the list:
https://lore.kernel.org/linux-pci/b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de/

If you could give this new version a whirl I'd be grateful.

This version contains more code comments and kernel-doc.

There's now a check in dpc_completed() whether the DPC Status
register contains "all ones", which can happen when a DPC-capable
hotplug port is hot-removed, i.e. for cascaded DPC-capable hotplug
ports.

I've also realized that the previous version was prone to races
which are theoretical but should nonetheless be avoided:
E.g., previously the DLLSC event was only removed from "events"
if the link is still up after DPC recovery.  However if DPC
triggers and recovers multiple times in a row, the link may
happen to be up but a new DLLSC event may have been picked up
in "pending_events" which should be ignored.  I've solved this
by inverting the logic such that DLLSC is *always* removed from
"events", and if the link is unexpectedly *down* after successful
recovery, a DLLSC event is synthesized.

Thanks,

Lukas
