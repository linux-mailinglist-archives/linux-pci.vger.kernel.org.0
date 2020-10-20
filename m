Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6557E293F6F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Oct 2020 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408647AbgJTPUI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Oct 2020 11:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408646AbgJTPUI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 11:20:08 -0400
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F52420757;
        Tue, 20 Oct 2020 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603207208;
        bh=yxjZLTL9G0GiWhcCxam1MP9Mr+loAoklnAmAo3SCEj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G9+59JztDbdsj4eCvFkRhf0Mg5w6NuvCUjVykcs2EzrCyONDCIAvL9wZWI/Gawn0g
         seMiadmLoIbxzxS0S47/0lQNq1SX4pDlcyG64pWPlT3SzIEC67lkA4jxC8qw/nYOgF
         5+4p3D1ba98725eJrWr9cP5SoKDpFf2WGfakP4b0=
Date:   Tue, 20 Oct 2020 08:20:05 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Jian-Hong Pan <jhp@endlessos.org>
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        You-Sheng Yang <vicamo.yang@canonical.com>, linux@endlessm.com
Subject: Re: [PATCH] PCI: vmd: Add AHCI to fast interrupt list
Message-ID: <20201020152005.GA1437971@dhcp-10-100-145-180.wdc.com>
References: <20200904171325.64959-1-jonathan.derrick@intel.com>
 <20201019093734.4091-1-jhp@endlessos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019093734.4091-1-jhp@endlessos.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 05:37:35PM +0800, Jian-Hong Pan wrote:
> >On 2020-09-05 01:13, Jon Derrick wrote:
> >> Some platforms have an AHCI controller behind VMD. These platforms are
> >> working correctly except for a case when the AHCI MSI is programmed with
> >> VMD IRQ vector 0 (0xfee00000). When programmed with any other interrupt
> >> (0xfeeNN000), the MSI is routed correctly and is handled by VMD. Placing
> >> the AHCI MSI(s) in the fast-interrupt allow list solves the issue.
> >> 
> >> This also requires that VMD allocate more than one MSI/X vector and
> >> changes the minimum MSI/X vectors allocated to two.
> >> 
> >> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> >
> > Verified two platforms with such configuration. Thank you.
> >
> > You-Sheng Yang
> 
> We have some laptops equipped with Tiger Lake chips and such configuration that
> hit the same issue, too.  They all could be fixed by this patch.  Thank you
> 
> Tested-by: Jian-Hong Pan <jhp@endlessos.org>

Please use the v3 instead:

  https://patchwork.kernel.org/project/linux-pci/patch/20200914190128.5114-1-jonathan.derrick@intel.com/

I'm not sure if there's anything remaining that's gating inclusion,
though.
