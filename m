Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55A281DB9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 23:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBViA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 17:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJBViA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 17:38:00 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF844206DC;
        Fri,  2 Oct 2020 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601674679;
        bh=2wUdEhOpFAzuGlqi1DcVIiKuTKGFfto/06HTJ2Vk+hU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AjQdrKVifpCWu4O1GUNo0hg0cxeLf1MaR20DjS9j7JojAk/TlCImJvbDoRd2O4rzu
         vGfSJ1AXJWYm5/FOVmLSSIv0CTpYMfKF3PxJLvclf0QUSu32KRix3OmkORBWEZoaXv
         J7jftYLWG9y5NUov+kCwDzV3/AugSFWcq/Z1FsUQ=
Date:   Fri, 2 Oct 2020 16:37:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Toan Le <toan@os.amperecomputing.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v3] PCI: Unify ECAM constants in native PCI Express
 drivers
Message-ID: <20201002213757.GA2827924@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201002202017.GA95575@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 02, 2020 at 10:20:17PM +0200, Krzysztof Wilczyński wrote:
> Hi Rob,
> 
> [...]
> > What about vmd which I mentioned? I also found iproc and brcmstb are
> > ECAM (well, same shifts, but indirect addressing).
> [...]
> 
> I wanted to cover these (and some others I also found) in a separate
> patch, especially since some of the drivers don't explicitly claim to
> support ECAM - but I will include these changes in the v4. 
>  
> > > +/
> > > + * Enhanced Configuration Access Mechanism (ECAM)
> > > + *
> > > + * N.B. This is a non-standard platform-specific ECAM bus shift value.  For
> > > + * standard values defined in the PCI Express Base Specification see
> > > + * include/linux/pci-ecam.h.
> > > + */
> > > +#define XGENE_PCIE_ECAM_BUS_SHIFT      16
> > 
> > Isn't this just CAM? Though perhaps CAM on PCIe is not standard...
> > 
> > For CAM, there's also tegra, ftpci100, mvebu, and versatile. I think
> > I'd drop CAM from this patch and do all of those in a separate patch.
> 
> Will do.
> 
> Bjorn was also not convinced about referring to things as "CAM" since
> the specification (the one I quoted in the patch) does not name it as
> such, and rather refers to it as Type 1 access of the PCI bus
> configuration space.

"Type 1" has two specific meanings in PCI, and neither is quite this
config access mechanism:

  1) "Type 0 Functions" have a "Type 0 Configuration Space Header" --
     these are basically endpoint devices.  "Type 1" Functions have
     Type 1 headers and are PCI-to-PCI bridges (Root Ports, Switches,
     Bridges in PCIe).

  2) "Type 0" config transactions target a device on the current bus,
     i.e., the recipient does not need to decode the bus number in the
     transaction.  A "Type 1" config transaction needs to be routed
     through one or more bridges.  The last bridge, where the bus
     number in the transaction matches the bridge's secondary bus
     number, converts the transaction to a Type 0 transaction on its
     secondary bus.

The "CAM" devices that use a 16-bit shift for the bus number are sort
of similar to the "Configuration Mechanism #1" description in PCI
r3.0, sec 3.2.2.3.2, but it's not really a good match because they
don't implement the x86-specific parts like I/O port registers at
0xcf8 and 0xcfc.  Also, that mechanism only allows access to the first
256 bytes of config space, and some/all of these extend the address
format so they can address extended config space (offsets
0x100-0xfff).

Bjorn
