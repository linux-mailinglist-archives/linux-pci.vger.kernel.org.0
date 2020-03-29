Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF5196D91
	for <lists+linux-pci@lfdr.de>; Sun, 29 Mar 2020 15:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgC2NEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Mar 2020 09:04:22 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:54703 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgC2NEW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Mar 2020 09:04:22 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 6A38A2800BD87;
        Sun, 29 Mar 2020 15:04:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 24B1342C68; Sun, 29 Mar 2020 15:04:20 +0200 (CEST)
Date:   Sun, 29 Mar 2020 15:04:20 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20200329130420.hggbkgx57qqvu6om@wunner.de>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM>
 <20200324161534.b2u6ag6oecvcthqd@wunner.de>
 <20200325104018.GA30853@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325104018.GA30853@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 25, 2020 at 11:40:18AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 24, 2020 at 05:15:34PM +0100, Lukas Wunner wrote:
> > The pci_dev_trylock() in pci_try_reset_function() looks questionable
> > to me.  It was added by commit b014e96d1abb ("PCI: Protect
> > pci_error_handlers->reset_notify() usage with device_lock()")
> > with the following rationale:
> > 
> >     Every method in struct device_driver or structures derived from it like
> >     struct pci_driver MUST provide exclusion vs the driver's ->remove()
> >     method, usually by using device_lock().
> >     [...]
> >     Without this, ->reset_notify() may race with ->remove() calls, which
> >     can be easily triggered in NVMe.
> > 
> > The intersection of drivers defining a ->reset_notify() hook and files
> > invoking pci_try_reset_function() appears to be empty.  So I don't quite
> > understand the problem the commit sought to address.  What am I missing?
> 
> No driver defines ->reset_notify as that has been split into
> ->reset_prepare and ->reset_done a while ago, and plenty of drivers
> define those.  And we can't call into drivers unless we know the driver
> actually still is bound to the device, which is why we need the locking.

Sure, you need to hold the driver in place while you're invoking one of
its callbacks.  But is it really necessary to hold the device lock while
performing the actual reset?  That locking seems awfully coarse-grained.

Do you see any potential problem in pushing down the pci_dev_lock() and
pci_dev_unlock() calls into pci_dev_save_and_disable() and
pci_dev_restore()?  I.e, acquire the lock for the invocation of
->reset_prepare() and ->reset_done() and release it immediately
afterwards?

That would seem to fix the deadlock Michael reported.

Of course that could result in ->reset_prepare() being invoked but
->reset_done() being not invoked if the driver is no longer bound.
Or in ->reset_done() being called for a different driver if the
device was rebound in the meantime.  Would this cause issues?

Thanks,

Lukas
