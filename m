Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CA198E0F
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCaION (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 04:14:13 -0400
Received: from verein.lst.de ([213.95.11.211]:37304 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaION (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 31 Mar 2020 04:14:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B07368C4E; Tue, 31 Mar 2020 10:14:10 +0200 (CEST)
Date:   Tue, 31 Mar 2020 10:14:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Haeuptle, Michael" <michael.haeuptle@hpe.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "michaelhaeuptle@gmail.com" <michaelhaeuptle@gmail.com>
Subject: Re: Deadlock during PCIe hot remove
Message-ID: <20200331081410.GA24780@lst.de>
References: <CS1PR8401MB0728FC6FDAB8A35C22BD90EC95F10@CS1PR8401MB0728.NAMPRD84.PROD.OUTLOOK.COM> <20200324161534.b2u6ag6oecvcthqd@wunner.de> <20200325104018.GA30853@lst.de> <20200329130420.hggbkgx57qqvu6om@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329130420.hggbkgx57qqvu6om@wunner.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 29, 2020 at 03:04:20PM +0200, Lukas Wunner wrote:
> Sure, you need to hold the driver in place while you're invoking one of
> its callbacks.  But is it really necessary to hold the device lock while
> performing the actual reset?  That locking seems awfully coarse-grained.
> 
> Do you see any potential problem in pushing down the pci_dev_lock() and
> pci_dev_unlock() calls into pci_dev_save_and_disable() and
> pci_dev_restore()?  I.e, acquire the lock for the invocation of
> ->reset_prepare() and ->reset_done() and release it immediately
> afterwards?
> 
> That would seem to fix the deadlock Michael reported.
> 
> Of course that could result in ->reset_prepare() being invoked but
> ->reset_done() being not invoked if the driver is no longer bound.
> Or in ->reset_done() being called for a different driver if the
> device was rebound in the meantime.  Would this cause issues?

And at least the driver I'm familiar with (nvme) will be broken
by that, as it the state machine expects them to pair.
