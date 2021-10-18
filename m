Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF35B43294C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 23:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJRVxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 17:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhJRVxB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 17:53:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66F5E6108E;
        Mon, 18 Oct 2021 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634593849;
        bh=dt3MSeiRt5AB2vSPHXjLfcp5bM2lLSUVx63oQi8vToQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VeuvmacIvYL9IMSRGYDE1FBQuwvFqvBnTCajrHldlrgBzL1sXsAH+9uhPE2pHG487
         NvYriGozxDhha+VKANql+j0andbbkgb91zmIdSlKsyC1Pt3y6dlvdcLuL//Baz82fj
         Qr3gq3ip6xLkDigfAvySsJvPH/McfT0qy2zOsTW/+Iml7/qLIMHA6N6wvcTbB6W+Ai
         wxxAoUw5gCd/OLU77uVvG3KOP+N4YMUsGdssjtePDHVUR81TQoIO+RdXYG480M0+9e
         Rp/1USfHd1YXRlRTBWize16a3J4ZelsYCYxrEF2PY9r2Jrn1zQsRBaobmR3eFryZtY
         DUSul52ithVhw==
Date:   Mon, 18 Oct 2021 16:50:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     bhelgaas@google.com, maz@kernel.org, tglx@linutronix.de,
        Jonathan.Cameron@huawei.com, bilbao@vt.edu, corbet@lwn.net,
        gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        intel-wired-lan@lists.osuosl.org,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 0/3] PCI/MSI: Clarify the IRQ sysfs ABI for PCI devices
Message-ID: <20211018215047.GA2265015@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825102636.52757-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 06:26:33PM +0800, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> 
> /sys/bus/pci/devices/.../irq has been there for many years but it has never
> been documented. This patchset is trying to clarify it.
> 
> -v3:
>   - Don't attempt to modify the current behaviour of IRQ ABI for MSI-X
>   - Make MSI IRQ ABI more explicit(return 1st IRQ of the IRQ vector)
>   - Add Marc's patch of removing default_irq from the previous comment to
>     the series.
>   Note patch 3/3 indirectly changed the code of pci_restore_msi_state(),
>   drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c is the only driver
>   calling this API. I would appreciate testing done from this driver's
>   maintainers.
> 
> -v2:
>   - split into two patches according to Bjorn's comments;
>   - Add Greg's Acked-by, thanks for reviewing!
>   https://lore.kernel.org/lkml/20210820223744.8439-1-21cnbao@gmail.com/
> 
> -v1:
>   https://lore.kernel.org/lkml/20210813122650.25764-1-21cnbao@gmail.com/#t
> 
> Barry Song (2):
>   Documentation: ABI: sysfs-bus-pci: Add description for IRQ entry
>   PCI/sysfs: Don't depend on pci_dev.irq for IRQ entry

I applied the first two (above) to pci/msi for v5.16, thanks!

As far as I can tell from the discussion so far, they should be safe
and should preserve all existing behavior.  The second patch should
remove the sysfs dependency on the PCI core to swap the INTx and first
MSI IRQ values in dev->irq.

Marc's patch below is certainly desirable but my understanding is that
it requires some driver updates first.

> Marc Zyngier (1):
>   PCI/MSI: remove msi_attrib.default_irq in msi_desc
> 
>  Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
>  drivers/pci/msi.c                       | 12 +++++-------
>  drivers/pci/pci-sysfs.c                 | 23 ++++++++++++++++++++++-
>  include/linux/msi.h                     |  2 --
>  4 files changed, 37 insertions(+), 10 deletions(-)
> 
> -- 
> 1.8.3.1
> 
