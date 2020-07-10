Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5671921BF00
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGJVHZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJVHZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:07:25 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0DDD20748;
        Fri, 10 Jul 2020 21:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594415244;
        bh=prIJu7Nfrz+JgHutqJ5X3omRvEUNLOJ1CmZ+pqztTEA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pXk8jGF6w7azt3wKQbJjQ+dWPfTM1ngRNoPIMHjUEfkXGf4XlhMjFtcU0EacIUyB+
         WAgGzMCxej6URkX7+S6JWmPclFHtFtA5QX1ERqZeYO6ViSD1HMg0yTDnejL5bP9eXH
         xsOdSx6P8jNwK9ef5uPxBkEWre5eRvPmcgVXIMmI=
Date:   Fri, 10 Jul 2020 16:07:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "sbobroff@linux.ibm.com" <sbobroff@linux.ibm.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: ERR: Don't override the status returned by
 error_detect()
Message-ID: <20200710210722.GA80765@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0402MB3371231EDD66A938F650269584830@HE1PR0402MB3371.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 10, 2020 at 04:07:35AM +0000, Z.q. Hou wrote:
> Hi Kuppuswamy,
> 
> Thanks a lot for your comments and sorry for my late response!
> 
> > -----Original Message-----
> > From: Kuppuswamy, Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Sent: 2020年5月29日 12:25
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org; ruscur@russell.cc; sbobroff@linux.ibm.com;
> > oohall@gmail.com; bhelgaas@google.com
> > Subject: Re: [PATCH] PCI: ERR: Don't override the status returned by
> > error_detect()
> > 
> > 
> > 
> > On 5/28/20 9:04 PM, Z.q. Hou wrote:
> > > Hi Kuppuswamy,
> > >
> > >> -----Original Message-----
> > >> From: Kuppuswamy, Sathyanarayanan
> > >> <sathyanarayanan.kuppuswamy@linux.intel.com>
> > >> Sent: 2020年5月29日 5:19
> > >> To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org;
> > >> linux-kernel@vger.kernel.org; ruscur@russell.cc;
> > >> sbobroff@linux.ibm.com; oohall@gmail.com; bhelgaas@google.com
> > >> Subject: Re: [PATCH] PCI: ERR: Don't override the status returned by
> > >> error_detect()
> > >>
> > >> Hi,
> > >>
> > >> On 5/27/20 1:31 AM, Zhiqiang Hou wrote:
> > >>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >>>
> > >>> The commit 6d2c89441571 ("PCI/ERR: Update error status after
> > >>> reset_link()") overrode the 'status' returned by the error_detect()
> > >>> call back function, which is depended on by the next step. This
> > >>> overriding makes the Endpoint driver's required info (kept in the
> > >>> var
> > >>> status) lost, so it results in the fatal errors' recovery failed and
> > >>> then kernel
> > >> panic.
> > >> Can you explain why updating status affects the recovery ?
> > >
> > > Take the e1000e as an example:
> > > Once a fatal error is reported by e1000e, the e1000e's error_detect()
> > > will be called and it will return PCI_ERS_RESULT_NEED_RESET to request
> > > a slot reset, the return value is stored in the '&status' of the
> > > calling pci_walk_bus(bus,report_frozen_detected, &status).
> > > If you update the 'status' with the reset_link()'s return value
> > > (PCI_ERS_RESULT_RECOVERED if the reset link succeed), then the
> > > 'status' has the value PCI_ERS_RESULT_RECOVERED and e1000e's request
> > > PCI_ERS_RESULT_NEED_RESET lost, then e1000e's callback function
> > > .slot_reset() will be skipped and directly call the .resume().
> > I believe you are working with non hotplug capable device. If yes, then this
> > issue will be addressed by the following patch.
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> > %2Flkml%2F2020%2F5%2F6%2F1545&amp;data=02%7C01%7Czhiqiang.hou%4
> > 0nxp.com%7C4f0ad836e4384f40400f08d80388383c%7C686ea1d3bc2b4c6fa92
> > cd99c5c301635%7C0%7C1%7C637263230875781678&amp;sdata=ap0PUMzse
> > xIuCnOpBCFPW%2BrUEwMWgAYzT7yxGP8pjio%3D&amp;reserved=0
> 
> I'll try this patch, seems it also override the 'status' in the pci_channel_io_frozen
> Case but it make sense for me.

I'm not sure what the resolution of this was.  Please repost this
patch if it's still needed.

> > > So this is how the update of 'status' break the handshake between RC's
> > > AER driver and the Endpoint's protocol driver error_handlers, then result in
> > the recovery failure.
> > >
> > >>>
> > >>> In the e1000e case, the error logs:
> > >>> pcieport 0002:00:00.0: AER: Uncorrected (Fatal) error received:
> > >>> 0002:01:00.0 e1000e 0002:01:00.0: AER: PCIe Bus Error:
> > >>> severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent
> > >>> ID) pcieport 0002:00:00.0: AER: Root Port link has been reset
> > >> As per above commit log, it looks like link is reset correctly.
> > >
> > > Yes, see my comments above.
> > >
> > > Thanks,
> > > Zhiqiang
> > >
> > >>> SError Interrupt on CPU0, code 0xbf000002 -- SError
> > >>> CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted
> > >>> 5.7.0-rc7-next-20200526 #8 Hardware name: LS1046A RDB Board (DT)
> > >>> pstate: 80000005 (Nzcv daif -PAN -UAO BTYPE=--) pc :
> > >>> __pci_enable_msix_range+0x4c8/0x5b8
> > >>> lr : __pci_enable_msix_range+0x480/0x5b8
> > >>> sp : ffff80001116bb30
> > >>> x29: ffff80001116bb30 x28: 0000000000000003
> > >>> x27: 0000000000000003 x26: 0000000000000000
> > >>> x25: ffff00097243e0a8 x24: 0000000000000001
> > >>> x23: ffff00097243e2d8 x22: 0000000000000000
> > >>> x21: 0000000000000003 x20: ffff00095bd46080
> > >>> x19: ffff00097243e000 x18: ffffffffffffffff
> > >>> x17: 0000000000000000 x16: 0000000000000000
> > >>> x15: ffffb958fa0e9948 x14: ffff00095bd46303
> > >>> x13: ffff00095bd46302 x12: 0000000000000038
> > >>> x11: 0000000000000040 x10: ffffb958fa101e68
> > >>> x9 : ffffb958fa101e60 x8 : 0000000000000908
> > >>> x7 : 0000000000000908 x6 : ffff800011600000
> > >>> x5 : ffff00095bd46800 x4 : ffff00096e7f6080
> > >>> x3 : 0000000000000000 x2 : 0000000000000000
> > >>> x1 : 0000000000000000 x0 : 0000000000000000 Kernel panic - not
> > >>> syncing: Asynchronous SError Interrupt
> > >>> CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted
> > >>> 5.7.0-rc7-next-20200526 #8
> > >>>
> > >>> I think it's the expected result that "if the initial value of error
> > >>> status is PCI_ERS_RESULT_DISCONNECT or
> > >> PCI_ERS_RESULT_NO_AER_DRIVER
> > >>> then even after successful recovery (using reset_link())
> > >>> pcie_do_recovery() will report the recovery result as failure" which
> > >>> is described in commit 6d2c89441571 ("PCI/ERR: Update error status
> > >>> after
> > >> reset_link()").
> > >>>
> > >>> Refer to the Documentation/PCI/pci-error-recovery.rst.
> > >>> As the error_detect() is mandatory callback if the pci_err_handlers
> > >>> is implemented, if it return the PCI_ERS_RESULT_DISCONNECT, it means
> > >>> the driver doesn't want to recover at all; For the case
> > >>> PCI_ERS_RESULT_NO_AER_DRIVER, if the pci_err_handlers is not
> > >>> implemented, the failure is more expected.
> > >>>
> > >>> Fixes: commit 6d2c89441571 ("PCI/ERR: Update error status after
> > >>> reset_link()")
> > >>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >>> ---
> > >>>    drivers/pci/pcie/err.c | 3 +--
> > >>>    1 file changed, 1 insertion(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index
> > >>> 14bb8f54723e..84f72342259c 100644
> > >>> --- a/drivers/pci/pcie/err.c
> > >>> +++ b/drivers/pci/pcie/err.c
> > >>> @@ -165,8 +165,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev
> > >> *dev,
> > >>>    	pci_dbg(dev, "broadcast error_detected message\n");
> > >>>    	if (state == pci_channel_io_frozen) {
> > >>>    		pci_walk_bus(bus, report_frozen_detected, &status);
> > >>> -		status = reset_link(dev);
> > >>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> > >>> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
> > >>>    			pci_warn(dev, "link reset failed\n");
> > >>>    			goto failed;
> > >>>    		}
> > >>>
> > >>
> > >> --
> > >> Sathyanarayanan Kuppuswamy
> > >> Linux Kernel Developer
> > 
> > --
> > Sathyanarayanan Kuppuswamy
> > Linux Kernel Developer
