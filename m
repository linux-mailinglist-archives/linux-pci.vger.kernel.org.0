Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB6ECA8B
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2019 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKAVxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Nov 2019 17:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfKAVxU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Nov 2019 17:53:20 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4152220679;
        Fri,  1 Nov 2019 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572645199;
        bh=/iOA+Sioe9lM4Vpd9/sJS35r/FemrhKKYlv25BofLuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=neYROtqq93+xY3xh540I6yf3ZLAoAXCQbSMc3dWys/knDxSJ29/m8mi9NVfhS3WFp
         uhRVXXa3ripb+8YDqVaWi9ACPjNexQOzwZNCLo8zOxO2Eb0Osm0kDNgxfDJwmPFSqq
         0pmqM40gmjfKuXjqQIq8GQhsBDOZZndoRVVvm5l8=
Date:   Fri, 1 Nov 2019 16:53:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Message-ID: <20191101215302.GA217821@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571245488-3549-3-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Andrew]

On Wed, Oct 16, 2019 at 11:04:47AM -0600, Jon Derrick wrote:
> When some VMDs are enabled and others are not, it's difficult to
> determine which IIO stack corresponds to the enabled VMD.
> 
> To assist userspace with management tasks, VMD BIOS will write the VMD
> instance number and socket number into the first enabled root port's IO
> Base/Limit registers prior to OS handoff. VMD driver can capture this
> information and expose it to userspace.

Hmmm, I'm not sure I understand this, but it sounds possibly fragile.
Are these Root Ports visible to the generic PCI core device
enumeration?  If so, it will find them and read these I/O window
registers.  Maybe today the PCI core doesn't change them, but I'm not
sure we should rely on them always being preserved until the vmd
driver can claim the device.

But I guess you're using a special config accessor (vmd_cfg_read()),
so these are probably invisible to the generic enumeration?

> + * for_each_vmd_root_port - iterate over all enabled VMD Root Ports
> + * @vmd: &struct vmd_dev VMD device descriptor
> + * @rp: int iterator cursor
> + * @temp: u32 temporary value for config read
> + *
> + * VMD Root Ports are located in the VMD PCIe Domain at 00:[0-3].0, and config
> + * space can be determinately accessed through the VMD Config BAR. Because VMD

I'm not sure how to parse "determinately accessed".  Maybe this config
space can *only* be accessed via the VMD Config BAR?

> + * Root Ports can be individually disabled, it's important to iterate for the
> + * first enabled Root Port as determined by reading the Vendor/Device register.
> + */
> +#define for_each_vmd_root_port(vmd, rp, temp)				\
> +	for (rp = 0; rp < 4; rp++)					\
> +		if (vmd_cfg_read(vmd, 0, PCI_DEVFN(root_port, 0),	\
> +				 PCI_VENDOR_ID, 4, &temp) ||		\
> +		    temp == 0xffffffff) {} else
