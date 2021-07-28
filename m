Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A33D9436
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhG1RYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhG1RYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 13:24:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F04C161037;
        Wed, 28 Jul 2021 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627493048;
        bh=3SS3nFiND2iFM+2T1HAsagKAWl7P4KCrhfWet+mqRIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OCuGJYbVyXmtHauhcVxYCcwnMgAMVM/lLZ22bXdi+1Xfu9zROHduBse/LUcjv46Mh
         8apgZyJnQ2dLIeSQStZFdM1qqeiVsR6dAFdWZ1fD3gIbvIjQqX3SJHNOavTzz6XqCB
         whPbGi+H3ey4ObpxW9Pfrs0ziY+9sDiocmAQZzgyy18Sn0pk7PAik33WQAd2gqquIN
         DQenO5pgNq4rbyjLuA60Ipnh92xTTZUwZu3SUMlCW7qyDDT78/XVLGsqDNIfxGonHV
         GrNta7bAlnkZ7erU0ilFglr2GWPa5cJp9UkQ1i/tOdYeUrVAoG71ai25ol6t0vdRxI
         wtoDBKmd8o7VA==
Date:   Wed, 28 Jul 2021 12:24:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v12 0/8] PCI: Expose and manage PCI device reset
Message-ID: <20210728172406.GA832360@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716151946.690-1-sdonthineni@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 16, 2021 at 10:19:38AM -0500, Shanker Donthineni wrote:
> PCI and PCIe devices may support a number of possible reset mechanisms
> for example Function Level Reset (FLR) provided via Advanced Feature or
> PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> Currently the PCI subsystem creates a policy prioritizing these reset methods
> which provides neither visibility nor control to userspace.
> 
> Expose the reset methods available per device to userspace, via sysfs
> and allow an administrative user or device owner to have ability to
> manage per device reset method priorities or exclusions.
> This feature aims to allow greater control of a device for use cases
> as device assignment, where specific device or platform issues may
> interact poorly with a given reset method, and for which device specific
> quirks have not been developed.
> 
> Changes in v12:
>         - Corrected subject in 0/8 (cover letter).
> 
> Changes in v11:
>         - Alex's suggestion fallback back to other resets if the ACPI RST
>           fails. Fix "s/-EINVAL/-ENOTTY/" in 7/8 patch.

Sorry I missed the fact that you posted the v12 of this series when I
looked at the v10 from Amey yesterday.  But the only code change from
v10 to v12 is the pci_dev_acpi_reset() return value change, so my
comments should all apply to this v12.
