Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D005155C3C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFYXYJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 19:24:09 -0400
Received: from gate.crashing.org ([63.228.1.57]:42277 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFYXYJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 19:24:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5PNMcZX001246;
        Tue, 25 Jun 2019 18:22:40 -0500
Message-ID: <df2650789c67f6c89d12bd698c9aef14c949a795.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 26 Jun 2019 09:22:38 +1000
In-Reply-To: <20190625120455.GF2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
         <20190622210310.180905-3-helgaas@kernel.org>
         <20190624112449.GJ2640@lahna.fi.intel.com>
         <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
         <20190625100534.GZ2640@lahna.fi.intel.com>
         <c4daf43a302eeb1c507b9cf4a353200669e04ad8.camel@kernel.crashing.org>
         <20190625120455.GF2640@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-25 at 15:04 +0300, Mika Westerberg wrote:
> > What's your experience in that area ? How (well) do they handle it in
> > the boot firmware ? at least on arm64, boot firmwares are rather
> > catastrophic when it comes to PCI, and on other embedded devices they
> > are basically non-existent.
> 
> Well my experience is quite limited to recent Macs and PCs which usually
> handle the initial resource allocation just fine. In case of Thunderbolt
> some "older" PCs handle everything in firmware, even the runtime
> resource allocation via SMI handler accompanied with ACPI hotplug.

So I'm tempted to toy a bit with the "realloc everything" platforms
(all non-x86 embedded basically) use
pci_bus_distribute_available_resources on the PCIe root ports
unconditionally.

I don't think it will be a problem with SR-IOV as I very much doubt
you'll end up with a setup where we have under the root port SR-IOV
devices that are *siblings* with a switch. If that ever becomes the
case, SR-IOV should be hanlded somewhat as part of the add_list of the
bus sizing anyway.

I might do that as a test patch or behind a test config option, see how
it goes, after I've consolidated all those platforms to go through the
same generic code path, it will be a lot easier.

I'm keen to limit that to PCIe root ports though, old stuff can stay as
it is and die happily :)

Cheers,
Ben.


