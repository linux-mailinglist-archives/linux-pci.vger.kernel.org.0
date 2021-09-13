Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957D7409977
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbhIMQkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 12:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238336AbhIMQkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 12:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02B4460E8B;
        Mon, 13 Sep 2021 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631551129;
        bh=AUEyRDJgyMq2t1rioCfOWWwTjuqM7/i5dWb0hVpxMRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ttlu7r2p76SUQ+mb9YL47+2thtgxFGpOlfeXOHYa83wB5m43VExqRLhHt4OzTGhol
         xzho2CieHSSqEQ3B7SfmDPbHxFhd6qBXHKM2xNAX1+gooHans8grDQ652Oyj9DOKNG
         IrEGh2Sij/6XQ//2xbLw9FVZA9p3LyjCZtPjDfR3Ih4tI17WT1Oz6vh+EU7dDsVGQY
         Q3xpmEYwzZd4jBQn1OfTbq29GFmgVPk+HVOtEPDBa+3ND/xZm6sM7CvGX96faL7qhX
         kKgmYu1FdU3WhIp2fpAWhxC6dr7OUGLnnshaWAkkVgtiRVyKy7tpDvvarKIOJJF64v
         W2wojIsKQXw4Q==
Date:   Mon, 13 Sep 2021 11:38:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Spassov, Stanislav" <stanspas@amazon.de>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?Sch=F6nherr=2C_Jan_H=2E?= <jschoenh@amazon.de>,
        "rajatja@google.com" <rajatja@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Message-ID: <20210913163847.GA1335093@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44cac41a02d0fd104b171e9a87b4699197224de4.camel@amazon.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 04:29:51PM +0000, Spassov, Stanislav wrote:
> On Sat, 2021-09-11 at 09:03 -0500, Bjorn Helgaas wrote:
> 
> > I think the Root Complex may eventually complete the transaction as
> > failed *regardless* of whether CRS SV is enabled.  This is unclear in
> > PCIe r5.0, sec 2.3.2, because the text formatting was broken between
> > r4.0 and r5.0.  [...]
> >
> >   A Root Complex implementation may choose to limit the number of
> >   Configuration Request/CRS Completion Status loops before determining
> >   that something is wrong with the target of the Request and taking
> >   appropriate action, e.g., complete the Request to the host as a
> >   failed transaction.
> 
> I can provide a bit more background:
> 
> The issue that prompted me to implement this patch involved a device that
> used CRS Completions to signal post-reset (non-)readiness. In some cases,
> the device would get stuck and continue issuing CRS Completions for all
> requests indefinitely.
> 
> The device was attached directly to a Root Port on a server-grade Intel CPU,
> and CRS SV was enabled on that Root Port. The original pci_dev_wait()
> implementation, by virtue of polling the Command register rather than the
> Vendor ID, would always cause a TOR timeout and associated host crash.
> 
> I later understood the specific CPU did have a proprietary register for
> "limiting the number of loops" that the PCIe spec talks about, and indeed
> that register was set to "no limit". Coupled with the stuck device, these
> indefinite retries eventually triggered TOR timeout.

"No limit" sounds like a pretty bad choice, given that it means the
CPU will essentially hang forever because of a defective I/O device.
There should be a timeout so software can recover (the *device* may
never recover, but that's no reason why the kernel must crash).

> Granted, there are surely Root Complexes that behave differently, since the
> PCIe spec leaves this up to the implementation. Still, this patch increases
> robustness by polling the safer Vendor ID register, which is safer at least
> in some situations, and not any less safe generally. However, it is not a
> simple matter of switching which register is polled due to the SR-IOV
> considerations that require a fallback to Command.

Yes.
