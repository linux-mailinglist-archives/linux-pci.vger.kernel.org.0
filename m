Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8661925F0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 11:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCYKkV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 06:40:21 -0400
Received: from verein.lst.de ([213.95.11.211]:40182 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgCYKkV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Mar 2020 06:40:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CBF5368C4E; Wed, 25 Mar 2020 11:40:18 +0100 (CET)
Date:   Wed, 25 Mar 2020 11:40:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20200325104018.GA30853@lst.de>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM> <20200324161534.b2u6ag6oecvcthqd@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324161534.b2u6ag6oecvcthqd@wunner.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 05:15:34PM +0100, Lukas Wunner wrote:
> The pci_dev_trylock() in pci_try_reset_function() looks questionable
> to me.  It was added by commit b014e96d1abb ("PCI: Protect
> pci_error_handlers->reset_notify() usage with device_lock()")
> with the following rationale:
> 
>     Every method in struct device_driver or structures derived from it like
>     struct pci_driver MUST provide exclusion vs the driver's ->remove()
>     method, usually by using device_lock().
>     [...]
>     Without this, ->reset_notify() may race with ->remove() calls, which
>     can be easily triggered in NVMe.
> 
> The intersection of drivers defining a ->reset_notify() hook and files
> invoking pci_try_reset_function() appears to be empty.  So I don't quite
> understand the problem the commit sought to address.  What am I missing?

No driver defines ->reset_notify as that has been split into
->reset_prepare and ->reset_done a while ago, and plenty of drivers
define those.  And we can't call into drivers unless we know the driver
actually still is bound to the device, which is why we need the locking.

