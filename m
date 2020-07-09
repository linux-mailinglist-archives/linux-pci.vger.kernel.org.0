Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EFA21A606
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 19:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgGIRmf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 13:42:35 -0400
Received: from smtp5.emailarray.com ([65.39.216.39]:49208 "EHLO
        smtp5.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgGIRmf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 13:42:35 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jul 2020 13:42:35 EDT
Received: (qmail 55519 invoked by uid 89); 9 Jul 2020 17:35:53 -0000
Received: from unknown (HELO localhost) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuMw==) (POLARISLOCAL)  
  by smtp5.emailarray.com with SMTP; 9 Jul 2020 17:35:53 -0000
Date:   Thu, 9 Jul 2020 10:35:50 -0700
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Aya Levin <ayal@mellanox.com>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        saeedm@mellanox.com, mkubecek@suse.cz, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, tariqt@mellanox.com,
        alexander.h.duyck@linux.intel.com
Subject: Re: [net-next 10/10] net/mlx5e: Add support for PCI relaxed ordering
Message-ID: <20200709173550.skza6igm72xrkw4w@bsd-mbp.dhcp.thefacebook.com>
References: <0506f0aa-f35e-09c7-5ba0-b74cd9eb1384@mellanox.com>
 <20200708231630.GA472767@bjorn-Precision-5520>
 <20200708232602.GO23676@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708232602.GO23676@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 08:26:02PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 08, 2020 at 06:16:30PM -0500, Bjorn Helgaas wrote:
> >     I suspect there may be device-specific controls, too, because [1]
> >     claims to enable/disable Relaxed Ordering but doesn't touch the
> >     PCIe Device Control register.  Device-specific controls are
> >     certainly allowed, but of course it would be up to the driver, and
> >     the device cannot generate TLPs with Relaxed Ordering unless the
> >     architected PCIe Enable Relaxed Ordering bit is *also* set.
> 
> Yes, at least on RDMA relaxed ordering can be set on a per transaction
> basis and is something userspace can choose to use or not at a fine
> granularity. This is because we have to support historical
> applications that make assumptions that data arrives in certain
> orders.
> 
> I've been thinking of doing the same as this patch but for RDMA kernel
> ULPs and just globally turn it on if the PCI CAP is enabled as none of
> our in-kernel uses have the legacy data ordering problem.

If I'm following this correctly - there are two different controls being
discussed here:

    1) having the driver request PCI relaxed ordering, which may or may
       not be granted, based on other system settings, and

    2) having the driver set RO on the transactions it initiates, which
       are honored iff the PCI bit is set.

It seems that in addition to the PCI core changes, there still is a need
for driver controls?  Unless the driver always enables RO if it's capable?
-- 
Jonathan
