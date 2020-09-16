Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9C26CF16
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIPWtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIPWto (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 18:49:44 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D5521D7D;
        Wed, 16 Sep 2020 22:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600296584;
        bh=RtnALUsgvrvWQLqClUZrqNctB+3lZ1evOkvlS2taoeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=crGCSZ641vZjegrvb8M2mpC05dKgMtjPNTQfnLXJoDAF2BZATSoOlh+NZMlpYc351
         J2z1uKB5ICQimkGVWDYnECXGdfHFTerm4HQgwdJihxCJFl53CP/OxwqHjGUVtyoEs5
         HaL0DRKgE4heTkaqA7d3qQCFBVUv7kwJR/7cg4Q8=
Date:   Wed, 16 Sep 2020 17:49:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, sathyanarayanan.kuppuswamy@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Message-ID: <20200916224942.GA1594177@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7B04CA9A-7332-4001-963B-E56642044F5D@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 14, 2020 at 09:55:53AM -0700, Sean V Kelley wrote:
> On 11 Sep 2020, at 17:50, Bjorn Helgaas wrote:
> > On Fri, Sep 11, 2020 at 04:16:03PM -0700, Sean V Kelley wrote:

> > > I’ve done some experimenting with this approach, and I think
> > > there may be a problem of just walking the busses during
> > > enumeration pci_init_capabilities(). One problem is where one
> > > has an RCEC on a root bus: 6a(00.4) and an RCiEP on another root
> > > bus: 6b(00.0).  They will never find each other in this approach
> > > through a normal pci_bus_walk() call using their respective
> > > root_bus.
> > > 
> > > >  +-[0000:6b]-+-00.0
> > > >  |           +-00.1
> > > >  |           +-00.2
> > > >  |           \-00.3
> > > >  +-[0000:6a]-+-00.0
> > > >  |           +-00.1
> > > >  |           +-00.2
> > > >  |           \-00.4
> > 
> > Wow, is that even allowed?
> > 
> > There's no bridge from 0000:6a to 0000:6b, so we will not scan 0000:6b
> > unless we find a host bridge with _CRS where 6b is the first bus
> > number below the bridge.  I think that means this would have to be
> > described in ACPI as two separate root bridges:
> > 
> >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 6a])
> >   ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 6b])
> 
> Otherwise, the RCEC Associated Endpoint Extended Capabilities would have to
> have explicitly mentioned a bridge?

I just meant that the enumeration algorithm starts with a PNP0A03
device and searches the root bus from its _CRS, descending under any
bridges it finds.  There's no PCI-to-PCI bridge from 6a to 6b (if
there *were* such a bridge, 6b would not be a root bridge).

> > I *guess* maybe it's allowed by the PCIe spec to have an RCEC and
> > associated RCiEPs on separate root buses?  It seems awfully strange
> > and not in character for PCIe, but I guess I can't point to language
> > that prohibits it.
> 
> Yes, it should be possible.

Ugh :)
