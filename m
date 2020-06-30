Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D5720F522
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgF3Mw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 08:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbgF3Mw3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 08:52:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEE7F2068F;
        Tue, 30 Jun 2020 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593521548;
        bh=amRiArINE+WmUf9ax03q1U0lMCq5RfbQ8ZbzfLKtgBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cco5bmoE3CYrLezNHfqq54eRM1tMJ5en4y7SfP5cJBqVoWy+6hyFiZoMrl5If688Q
         iHXnPPiWjE71DMWEPgc/X55d6wcP3bFRxgl/rA8Bgdd6OcGvEgtjZrriH+yojQTv2N
         lIpeYVA0bUibyUSq9F9UorQk1+FI/P3N3dvYQ+DU=
Date:   Tue, 30 Jun 2020 14:52:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200630125216.GA1109228@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
 <20200630104948.GC856968@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630104948.GC856968@kuha.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 30, 2020 at 01:49:48PM +0300, Heikki Krogerus wrote:
> On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> > Add a new (optional) field to denote the physical location of a device
> > in the system, and expose it in sysfs. This was discussed here:
> > https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> > 
> > (The primary choice for attribute name i.e. "location" is already
> > exposed as an ABI elsewhere, so settled for "site"). Individual buses
> > that want to support this new attribute can opt-in by setting a flag in
> > bus_type, and then populating the location of device while enumerating
> > it.
> 
> So why not just call it "physical_location"?

That's better, and will allow us to put "3rd blue plug from the left,
4th row down" in there someday :)

All of this is "relative" to the CPU, right?  But what CPU?  Again, how
are the systems with drawers of PCI and CPUs and memory that can be
added/removed at any point in time being handled here?  What is
"internal" and "external" for them?

What exactly is the physical boundry here that is attempting to be
described?

thanks,

greg "not all the world is your laptop" k-h
