Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD9C121885
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfLPSo1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 13:44:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbfLPR6f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 12:58:35 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 640C12166E;
        Mon, 16 Dec 2019 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519114;
        bh=JkhuHAUQRkEIKQ+4MLQKW2y4Nw1JR4A+qSwRQ1OhiHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YhU9DWlZ/xvS2FFi/J3lltPtqmK1KJkS9iht/21UMlFy9N1a7bLrsatYpRlMfWZnw
         KravF4b94W4j4l9P0kNXEN0ECVfdWZuoqF23nFCCgFZTdtVcLVpq+9ogFIP7DbdETa
         qLVQpJ8HEGmGWfpQtb3bT2AQnBrldQ9f+ab96G70=
Date:   Mon, 16 Dec 2019 11:58:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [Patch]PCI:AER:Notify which device has no error_detected callback
Message-ID: <20191216175832.GA206621@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b3a6aa-e4c1-ee09-6302-9c4f25471a1c@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Mon, Dec 16, 2019 at 06:30:11PM +0800, Yicong Yang wrote:
> On 2019/12/14 6:57, Bjorn Helgaas wrote:
> > On Fri, Dec 13, 2019 at 07:44:34PM +0800, Yicong Yang wrote:
> >> The PCI error recovery will fail if any device under
> >> root port doesn't have an error_detected callback.
> >> Currently only failure result is printed, which is
> >> not enough to determine which device leads to the
> >> failure and the detailed failure reason.
> >>
> >> Add print information if certain device under root
> >> port has no error_detected callback.
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > Applied to pci/aer for v5.6, thanks!
> >
> > I also added a trivial follow-on patch to factor out the "AER: "
> > prefix (attached below).  This code is now used by DPC as well as AER,
> > so "AER: " might not be exactly the correct prefix, but I didn't try
> > to untangle that.
> >
> >> ---
> >>  drivers/pci/pcie/err.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> >> index b0e6048..ec37c33 100644
> >> --- a/drivers/pci/pcie/err.c
> >> +++ b/drivers/pci/pcie/err.c
> >> @@ -61,8 +61,10 @@ static int report_error_detected(struct pci_dev *dev,
> >>  		 * error callbacks of "any" device in the subtree, and will
> >>  		 * exit in the disconnected error state.
> >>  		 */
> >> -		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> >> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> >>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> >> +			pci_info(dev, "AER: Device has no error_detected callback\n");
> >> +		}
> >>  		else
> >>  			vote = PCI_ERS_RESULT_NONE;
> >>  	} else {
> >> --
> >> 2.8.1
> >>
> > commit 9694ef043ea4 ("PCI/AER: Factor message prefixes with dev_fmt()")
> > Author: Bjorn Helgaas <bhelgaas@google.com>
> > Date:   Fri Dec 13 16:46:05 2019 -0600
> >
> >     PCI/AER: Factor message prefixes with dev_fmt()
> >     
> >     Define dev_fmt() with the common prefix of log messages so we don't have to
> >     repeat it in every printk.  No functional change intended.
> >     
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > index abde5e000f5d..747ef8b41d1f 100644
> > --- a/drivers/pci/pcie/err.c
> > +++ b/drivers/pci/pcie/err.c
> > @@ -10,6 +10,8 @@
> >   *	Zhang Yanmin (yanmin.zhang@intel.com)
> >   */
> >  
> > +#define dev_fmt(fmt) "AER: " fmt
> > +
> >  #include <linux/pci.h>
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> > @@ -64,7 +66,7 @@ static int report_error_detected(struct pci_dev *dev,
> >  		 */
> >  		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> >  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > -			pci_info(dev, "AER: Driver has no error_detected callback\n");
> > +			pci_info(dev, "driver has no error_detected callback\n");
> 
> I think use "device" here is more proper. Sometimes the device is
> even not bind to the driver, which will also lead to the recovery
> failure.

Hmmm, maybe so, although the error_detected callback is definitely a
property of the *driver*, not the device.  What would you think of
something like this?

  pci_info(dev, dev->driver ? "driver not capable of error recovery\n" :
                              "no driver\n");

I am curious about the larger question of why we fail if the device
has no driver.  I understand why we fail the recovery for a device
with a driver that has no err_handlers: we can't just reset the device
out from under the driver.

But why do we fail if a device has no driver at all?  Shouldn't it be
safe to reset such a device?  The commit log of 918b4053184c
("PCI/AER: Report success only when every device has AER-aware
driver") suggests that it has something to do with KVM and the
pci-stub driver, but I don't understand it.

> >  		} else {
> >  			vote = PCI_ERS_RESULT_NONE;
> >  		}
> > @@ -236,12 +238,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> >  
> >  	pci_aer_clear_device_status(dev);
> >  	pci_cleanup_aer_uncorrect_error_status(dev);
> > -	pci_info(dev, "AER: Device recovery successful\n");
> > +	pci_info(dev, "device recovery successful\n");
> >  	return;
> >  
> >  failed:
> >  	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> >  
> >  	/* TODO: Should kernel panic here? */
> > -	pci_info(dev, "AER: Device recovery failed\n");
> > +	pci_info(dev, "device recovery failed\n");
> >  }
