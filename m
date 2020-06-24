Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C65207EBD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgFXViA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 17:38:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403996AbgFXVh7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jun 2020 17:37:59 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B668D207E8;
        Wed, 24 Jun 2020 21:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593034679;
        bh=DwNy4a1dTP0cML/NqcYH/mc0n8ghiF4jwJVglyBIYl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ba9s7rmGgoLzByJn2FUikabBHUIk7ZVOD7zfHBPMMZBzqYC2iWKiTfku4gKCdXAEk
         Ep15zWtBl7na1pM4n1ksy6It7Sw2shsTNoYfL+d9riHKVqXlk0wTot4m0V5e/fZV3K
         FrYi8MBZSK0nSIUKaclGUgr+R5RV4kMYQxfQa9cg=
Date:   Wed, 24 Jun 2020 16:37:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Message-ID: <20200624213757.GA2591059@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612204820.20111-2-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 12, 2020 at 01:48:19PM -0700, David E. Box wrote:
> StorageD3Enable is a boolean property that indicates that the platform
> wants to use D3 for PCIe storage drives during suspend-to-idle. 

Is this something that should apply to plug-in drives, or does this
only apply to soldered-in things?

> It is a
> BIOS work around that is currently in use on shipping systems like some
> Intel Comet Lake platforms. 

What is this BIOS work around?  Is there a defect here that's being
worked around?  What's the defect?

> It is meant to change default driver policy for
> suspend that may cause higher power consumption.

I guess this means that by changing the driver policy from the
default, we can save some power?

> Add the DSD property for recognition by fwnode calls and provide an
> exported symbol for device drivers to use to read the property as needed.
> 
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro

There is surprisingly little information in this intro.  The whole
paragraph under "Modern Standby Power Management" is duplicated
immediately below in "D3 Support".  Maybe that's a copyediting error
that displaced useful information.

It says "drivers should go to the deepest appropriate state" so
"function drivers don't have to manage implementation details".  No
doubt "drivers" and "function drivers" is a meaningful distinction to
Windows cognoscenti, but it's not to me.

It talks about "enabling D3" without specifying D3hot or D3cold.

It talks about "D3 support for storage devices."  All PCI devices are
required to support both D3hot and D3cold, so this must be talking
about some other sort of support; I suppose maybe it's a hint about
whether a driver should *use* D3hot (or D3cold, I can't tell).

It says nothing about where to look for the _DSD: on a Root Port or on
the NVMe endpoint.

Bjorn
