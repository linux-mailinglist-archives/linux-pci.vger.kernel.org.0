Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D08A4235D8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 04:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhJFCfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 22:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229908AbhJFCfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 22:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F2B461152;
        Wed,  6 Oct 2021 02:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633487592;
        bh=xMrW1ly2Sm6Ajt6rB4kO3MZtmUnPmt5PMPQsyET6Jqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pbuoI3kQpqT8tE4qDlLATOC2ne232fDjBSE1iRkh4A8HBKUTt7IxZ+5QJt+F1720P
         FNiVlv0AKEHsbyV8t8rHuzGTt7W/RqlPCNrONoQFmrCf9E+DmV0Gbhy3HwSnNsiqYr
         +0CYuyRGSbqMjRc8+vtrxzCHu+oyYUOvQl9pZ2VujmAzIgm+vifCKLnCsk+uxeXdZn
         U9l/PvhFe07b2YoxoyyBJgrFSYjwXX5NATyejYFGP7GEO/P6j4/jsgs/gmJ6KqConZ
         J1S7LVRW45zVD+x2WMhdUZ5hRIL/KuDP0GBP4j0tZX0hddajcNAmBpK6s57cxHmoju
         JauIvqCgJBTlA==
Date:   Tue, 5 Oct 2021 21:33:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelvin.Cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kelvincao@outlook.com,
        logang@deltatee.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Message-ID: <20211006023310.GA1137022@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7654b51f2a28e033200c6de9c0a2d9c53c646d3.camel@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 06, 2021 at 12:37:02AM +0000, Kelvin.Cao@microchip.com wrote:
> On Tue, 2021-10-05 at 15:11 -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 04, 2021 at 08:51:06PM +0000, Kelvin.Cao@microchip.com
> > wrote:
> > > On Sat, 2021-10-02 at 10:11 -0500, Bjorn Helgaas wrote:

> > > > I *thought* the problem was that the PCIe Memory Read failed
> > > > and the Root Complex fabricated ~0 data to complete the CPU
> > > > read.  But now I'm not sure, because it sounds like it might
> > > > be that the PCIe transaction succeeds, but it reads data that
> > > > hasn't been updated by the firmware, i.e., it reads 'in
> > > > progress' because firmware hasn't updated it to 'done'.
> > > 
> > > The original message was sort of misleading. After a firmware
> > > reset, CPU getting ~0 for the PCIe Memory Read doesn't explain
> > > the hang.  In a MRPC execution (DMA MRPC mode), the MRPC status
> > > which is located in the host memory, gets initialized by the CPU
> > > and updated/finalized by the firmware. In the situation of a
> > > firmware reset, any MRPC initiated afterwards will not get the
> > > status updated by the firmware per the reason you pointed out
> > > above (or similar, to my understanding, firmware can no longer
> > > DMA data to host memory in such cases), therefore the MRPC
> > > execution will never end.
> > 
> > I'm glad this makes sense to you, because it still doesn't to me.
> > 
> > check_access() does an MMIO read to something in BAR0.  If that
> > read returns ~0, it means either the PCIe Memory Read was
> > successful and the Switchtec device supplied ~0 data (maybe
> > because firmware has not initialized that part of the BAR) or the
> > PCIe Memory Read failed and the root complex fabricated the ~0
> > data.
> > 
> > I'd like to know which one is happening so we can clarify the
> > commit log text about "MRPC command executions hang indefinitely"
> > and "host wil fail all GAS reads."  It's not clear whether these
> > are PCIe protocol issues or driver/firmware interaction issues.
> 
> I think it's the latter case, the ~0 data was fabricated by the root
> complex, as the MMIO read in check_access() always returns ~0 until
> a reboot or a rescan happens. 

If the root complex fabricates ~0, that means a PCIe transaction
failed, i.e., the device didn't respond.  Rescan only does config
reads and writes.  Why should that cause the PCIe transactions to
magically start working?
