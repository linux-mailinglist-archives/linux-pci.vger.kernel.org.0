Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19914A567
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgA0NuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 08:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgA0NuV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 08:50:21 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAFAB20716;
        Mon, 27 Jan 2020 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580133020;
        bh=atKi/hig5oa208QWZFD8TZszOxZ5B4cSJZX4YGxigSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ppwnn+C0bHwhyX5YuUuKPtr8x6i/aljl9+E29gLmAB9RItz+McXL26DzXO9ILhWqG
         hVG7tz8x3mV1sD90WcZUsdkvKcpVvnCCe66twlpkOXYlW3DuI7sh2afv1MmnVEL8H/
         OtaGynkdEJq1v9t/S5y7gZyKiQYz1X+eNG3/2bTM=
Date:   Mon, 27 Jan 2020 07:50:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v13 4/8] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
Message-ID: <20200127135017.GA260782@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125232500.GA112031@skuppusw-desk.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 25, 2020 at 03:25:00PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On Fri, Jan 24, 2020 at 09:04:50AM -0600, Bjorn Helgaas wrote:
> > On Sat, Jan 18, 2020 at 08:00:33PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > As per ACPI specification r6.3, sec 5.6.6, when firmware owns Downstream
> > > Port Containment (DPC), its expected to use the "Error Disconnect
> > > Recover" (EDR) notification to alert OSPM of a DPC event and if OS
> > > supports EDR, its expected to handle the software state invalidation and
> > > port recovery in OS, and also let firmware know the recovery status via
> > > _OST ACPI call. Related _OST status codes can be found in ACPI
> > > specification r6.3, sec 6.3.5.2.
> > > 
> > > Also, as per PCI firmware specification r3.2 Downstream Port Containment
> > > Related Enhancements ECN, sec 4.5.1, table 4-6, If DPC is controlled by
> > > firmware (firmware first mode), firmware is responsible for
> > > configuring the DPC and OS is responsible for error recovery. Also, OS
> > > is allowed to modify DPC registers only during the EDR notification
> > > window. So with EDR support, OS should provide DPC port services even in
> > > firmware first mode.
> ...

> > > +		acpi_status astatus;
> > > +
> > > +		dpc->adev = adev;
> > > +
> > > +		astatus = acpi_install_notify_handler(adev->handle,
> > > +						      ACPI_SYSTEM_NOTIFY,
> > > +						      edr_handle_event,
> > > +						      dpc);
> > 
> > I think there are a couple issues with the ECN here:
> > 
> >   - The ECN allows EDR notifications on host bridges (sec 4.5.1, table
> >     4-4), but it does not allow the "Locate" _DSM under host bridges
> >     (sec 4.6.13).
> > 
> >   - The ECN allows EDR notifications on root ports or switch ports
> >     that do not support DPC (sec 4.5.1), but it does not allow the
> >     "Locate" _DSM on those ports (sec 4.6.13).
> 
> Can you please give more details on where its mentioned? Following is
> the copy of "Locate" _DSM location related specification. All it says is,
> this object can be placed under any object representing root port or
> switch port. It does not seem to add any restrictions. Please let me  know
> your comments.
> 
> Location:
> This object can be placed under any object representing a DPC capable
> PCI Express Root Port or Switch Downstream Port. If a port implements
> this DSM, its child devices cannot instantiate this DSM function

You quoted it: "This object [the 'Locate' _DSM] can be placed under
any object representing a *DPC capable* PCI Express Root Port or Switch
Downstream Port."

If the intention was to allow the Locate _DSM for *any* root ports or
switch downstream ports, the spec should not include the "DPC capable"
restriction.

Bjorn
