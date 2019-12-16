Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC73121653
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 19:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfLPS2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 13:28:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21145 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731534AbfLPS2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 13:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576520886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yk3qA4OoxV2F8Mf7PLm/0H6yG7AvmPhkjMzYtw03MCw=;
        b=DyCg2GuSPwX7pId3uegmBkJzHRTF+fNGHxo09bFHa9TYkmqdxesUOGWuC0HRvqC2LOVCTd
        uhujp7FylWkA9Bz7VMBd16DT7FD7+BeYs0Rqh1AcVDJKZ9/LqrnvZyhJR1T+h3PcTlAomm
        jj2WSpvM2lcY4qJYVBLUKiSRF3k57Lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-MqezDw-eOGSSkn5AQrujtQ-1; Mon, 16 Dec 2019 13:28:02 -0500
X-MC-Unique: MqezDw-eOGSSkn5AQrujtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B15107ACE3;
        Mon, 16 Dec 2019 18:28:00 +0000 (UTC)
Received: from x1.home (ovpn-116-53.phx2.redhat.com [10.3.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6937C819;
        Mon, 16 Dec 2019 18:28:00 +0000 (UTC)
Date:   Mon, 16 Dec 2019 11:28:00 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org
Subject: Re: [Patch]PCI:AER:Notify which device has no error_detected
 callback
Message-ID: <20191216112800.44d76017@x1.home>
In-Reply-To: <20191216175832.GA206621@google.com>
References: <31b3a6aa-e4c1-ee09-6302-9c4f25471a1c@hisilicon.com>
        <20191216175832.GA206621@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 16 Dec 2019 11:58:32 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Alex]
> 
> On Mon, Dec 16, 2019 at 06:30:11PM +0800, Yicong Yang wrote:
> > On 2019/12/14 6:57, Bjorn Helgaas wrote:  
> > > On Fri, Dec 13, 2019 at 07:44:34PM +0800, Yicong Yang wrote:  
> > >> The PCI error recovery will fail if any device under
> > >> root port doesn't have an error_detected callback.
> > >> Currently only failure result is printed, which is
> > >> not enough to determine which device leads to the
> > >> failure and the detailed failure reason.
> > >>
> > >> Add print information if certain device under root
> > >> port has no error_detected callback.
> > >>
> > >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>  
> > > Applied to pci/aer for v5.6, thanks!
> > >
> > > I also added a trivial follow-on patch to factor out the "AER: "
> > > prefix (attached below).  This code is now used by DPC as well as AER,
> > > so "AER: " might not be exactly the correct prefix, but I didn't try
> > > to untangle that.
> > >  
> > >> ---
> > >>  drivers/pci/pcie/err.c | 4 +++-
> > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > >> index b0e6048..ec37c33 100644
> > >> --- a/drivers/pci/pcie/err.c
> > >> +++ b/drivers/pci/pcie/err.c
> > >> @@ -61,8 +61,10 @@ static int report_error_detected(struct pci_dev *dev,
> > >>  		 * error callbacks of "any" device in the subtree, and will
> > >>  		 * exit in the disconnected error state.
> > >>  		 */
> > >> -		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
> > >> +		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > >>  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > >> +			pci_info(dev, "AER: Device has no error_detected callback\n");
> > >> +		}
> > >>  		else
> > >>  			vote = PCI_ERS_RESULT_NONE;
> > >>  	} else {
> > >> --
> > >> 2.8.1
> > >>  
> > > commit 9694ef043ea4 ("PCI/AER: Factor message prefixes with dev_fmt()")
> > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > Date:   Fri Dec 13 16:46:05 2019 -0600
> > >
> > >     PCI/AER: Factor message prefixes with dev_fmt()
> > >     
> > >     Define dev_fmt() with the common prefix of log messages so we don't have to
> > >     repeat it in every printk.  No functional change intended.
> > >     
> > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> > > index abde5e000f5d..747ef8b41d1f 100644
> > > --- a/drivers/pci/pcie/err.c
> > > +++ b/drivers/pci/pcie/err.c
> > > @@ -10,6 +10,8 @@
> > >   *	Zhang Yanmin (yanmin.zhang@intel.com)
> > >   */
> > >  
> > > +#define dev_fmt(fmt) "AER: " fmt
> > > +
> > >  #include <linux/pci.h>
> > >  #include <linux/module.h>
> > >  #include <linux/kernel.h>
> > > @@ -64,7 +66,7 @@ static int report_error_detected(struct pci_dev *dev,
> > >  		 */
> > >  		if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE) {
> > >  			vote = PCI_ERS_RESULT_NO_AER_DRIVER;
> > > -			pci_info(dev, "AER: Driver has no error_detected callback\n");
> > > +			pci_info(dev, "driver has no error_detected callback\n");  
> > 
> > I think use "device" here is more proper. Sometimes the device is
> > even not bind to the driver, which will also lead to the recovery
> > failure.  
> 
> Hmmm, maybe so, although the error_detected callback is definitely a
> property of the *driver*, not the device.  What would you think of
> something like this?
> 
>   pci_info(dev, dev->driver ? "driver not capable of error recovery\n" :
>                               "no driver\n");
> 
> I am curious about the larger question of why we fail if the device
> has no driver.  I understand why we fail the recovery for a device
> with a driver that has no err_handlers: we can't just reset the device
> out from under the driver.
> 
> But why do we fail if a device has no driver at all?  Shouldn't it be
> safe to reset such a device?  The commit log of 918b4053184c
> ("PCI/AER: Report success only when every device has AER-aware
> driver") suggests that it has something to do with KVM and the
> pci-stub driver, but I don't understand it.

That commit is from 2012, when legacy KVM device assignment existed in
the kernel and was able to drive a device without really binding to it
as a driver.  Sane users of this mechanism would at least bind the
device to pci-stub to prevent it from being used by both a host driver
and KVM simultaneously.  In any case, legacy KVM device assignment no
longer exists in the kernel, so if that was the justification to not
reset driver-less devices, we can probably fill that gap now.  Thanks,

Alex

