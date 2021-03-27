Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B2134B64E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhC0Kq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 06:46:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhC0Kqx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Mar 2021 06:46:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DE8D61984;
        Sat, 27 Mar 2021 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616842013;
        bh=Jcgotmr3iERSwz1nNcEMv4ajNTb/7UPlLDvxvPZRwfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ni1dbeTbERmIaaVmWzBzbeZViIiOD/zLbWQYUhLHfj2rK/YJxqMYdVJk7YUopNp+o
         Cvmch4GV0wZ5vBLNmvwp4lsGcKhxX3od9qRQH2AVUlwfsjcRbjOSru7SwbIAof/0/z
         RpTyOrTzC8CkAJgVbUg9lqX9nHYKBVUTrAlFAVKE=
Date:   Sat, 27 Mar 2021 11:46:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PCI: Allow drivers to claim exclusive access to config
 regions
Message-ID: <YF8NGeGv9vYcMfTV@kroah.com>
References: <161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210326161247.GA819704@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326161247.GA819704@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 11:12:47AM -0500, Bjorn Helgaas wrote:
> [+cc Christoph]
> 
> On Wed, Mar 24, 2021 at 06:23:54PM -0700, Dan Williams wrote:
> > The PCIE Data Object Exchange (DOE) mailbox is a protocol run over
> > configuration cycles. It assumes one initiator at a time is
> > reading/writing the data registers. If userspace reads from the response
> > data payload it may steal data that a kernel driver was expecting to
> > read. If userspace writes to the request payload it may corrupt the
> > request a driver was trying to send.
> 
> IIUC the problem we're talking about is that userspace config access,
> e.g., via "lspci" or "setpci" may interfere with kernel usage of DOE.
> I attached what I think are the relevant bits from the spec.
> 
> It looks to me like config *reads* should not be a problem: A read of
> Write Data Mailbox always returns 0 and looks innocuous.  A userspace
> read of Read Data Mailbox may return a DW of the data object, but it
> doesn't advance the cursor, so it shouldn't interfere with a kernel
> read.  
> 
> A write to Write Data Mailbox could obviously corrupt an object being
> written to the device.  A config write to Read Data Mailbox *does*
> advance the cursor, so that would definitely interfere with a kernel
> user.  
> 
> So I think we're really talking about an issue with "setpci" and I
> don't expect "lspci" to be a problem.  "setpci" is a valuable tool,
> and the fact that it can hose your system is not really news.  I don't
> know how hard we should work to protect against that.

Thanks for looking this up and letting us know.

So this should be fine, reads are ok, it's not as crazy of a protocol
design as Dan alluded to, so the kernel should be ok.  No need to add
additional "protection" here at all, if you run setpci from userspace,
you get what you asked for :)

thanks,

greg k-h
