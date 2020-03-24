Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE71915EA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 17:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCXQPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 12:15:36 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:45211 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCXQPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 12:15:36 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 8F7B1100FBFE8;
        Tue, 24 Mar 2020 17:15:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2D1741B36FD; Tue, 24 Mar 2020 17:15:34 +0100 (CET)
Date:   Tue, 24 Mar 2020 17:15:34 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20200324161534.b2u6ag6oecvcthqd@wunner.de>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Christoph]

On Tue, Mar 24, 2020 at 03:21:52PM +0000, Haeuptle, Michael wrote:
> I'm running into a deadlock scenario between the hotplug, pcie and
> vfio_pci driver when removing multiple devices in parallel.
> This is happening on CentOS8 (4.18) with SPDK (spdk.io). I'm using the
> latest pciehp code, the rest is all 4.18.
> 
> The sequence that leads to the deadlock is as follows:
> 
> The pciehp_ist() takes the reset_lock early in its processing. While
> the pciehp_ist processing is progressing, vfio_pci calls
> pci_try_reset_function() as part of vfio_pci_release or open.
> The pci_try_reset_function() takes the device lock.
> 
> Eventually, pci_try_reset_function() calls pci_reset_hotplug_slot()
> which calls pciehp_reset_slot(). The pciehp_reset_slot() tries to take
> the reset_lock but has to wait since it is already taken by pciehp_ist().
> 
> Eventually pciehp_ist calls pcie_stop_device() which calls
> device_release_driver_internal(). This function also tries to take
> device_lock causing the dead lock.

The pci_dev_trylock() in pci_try_reset_function() looks questionable
to me.  It was added by commit b014e96d1abb ("PCI: Protect
pci_error_handlers->reset_notify() usage with device_lock()")
with the following rationale:

    Every method in struct device_driver or structures derived from it like
    struct pci_driver MUST provide exclusion vs the driver's ->remove()
    method, usually by using device_lock().
    [...]
    Without this, ->reset_notify() may race with ->remove() calls, which
    can be easily triggered in NVMe.

The intersection of drivers defining a ->reset_notify() hook and files
invoking pci_try_reset_function() appears to be empty.  So I don't quite
understand the problem the commit sought to address.  What am I missing?

Thanks,

Lukas
