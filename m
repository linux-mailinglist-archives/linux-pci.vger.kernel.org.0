Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13FABA9206
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbfIDSpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 14:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732798AbfIDSpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 14:45:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3145D2077B;
        Wed,  4 Sep 2019 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567622740;
        bh=4ayV0ZK7/gnUuB1eJ6I6aCRk4tV24nhjprhkcptmwNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clKMoHf4f+cqeoN2lRe+nXQJ55QFAC7eIIXFhRk37MSPC2Jlpa+itQHz66dFnA/HL
         XFHAQfV9adz0Vc0sKI91K9iD51rA2E0njbmYkgIgXKNuSxD7Nhmo0jR/rUhypbVslc
         Pe3Tc1dxzwH/mcO7C38BHiSU9x0to6ZxXW6ySvb0=
Date:   Wed, 4 Sep 2019 13:45:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Carolyn Wyborny <carolyn.wyborny@intel.com>
Subject: Re: [PATCH 2/2] PCI: Unify pci_dev_is_disconnected() and
 pci_dev_is_inaccessible()
Message-ID: <20190904184538.GC103977@google.com>
References: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
 <20190904043633.65026-3-skunberg.kelsey@gmail.com>
 <20190904053523.7lmuoo5zempxtsdq@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904053523.7lmuoo5zempxtsdq@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Carolyn, author of 17a402a0075c]

On Wed, Sep 04, 2019 at 07:35:23AM +0200, Lukas Wunner wrote:
> On Tue, Sep 03, 2019 at 10:36:35PM -0600, Kelsey Skunberg wrote:
> > Change pci_dev_is_disconnected() call inside pci_dev_is_inaccessible() to:
> > 
> > 	pdev->error_state == pci_channel_io_perm_failure
> > 
> > Change remaining pci_dev_is_disconnected() calls to
> > pci_dev_is_inaccessible() calls.
> 
> I don't think that's a good idea because it introduces a config space read
> (for the vendor ID) in places where we don't want that.  E.g., after the
> check of pdev->error_state, a regular config space read may take place and
> if that returns all ones, we may already be able to determine that the
> device is inaccessible, obviating the need for a vendor ID check.

Oh, I think I see what you mean: Previously pci_read_config_byte() et
al called pci_dev_is_disconnected(), which only checked
dev->error_state.

If we applied this patch, those sites would call
pci_dev_is_inaccessible(), which would check error_state and then (in
the common case where we haven't set error_state) do a config read of
the vendor ID.

So we would basically double the config access overhead because we'd
be doing an extra read of the vendor ID before every access.  That
indeed doesn't seem practical.

I think what we need to figure out is whether we really need two
interfaces (one that looks only at dev->error_state and a second that
looks at dev->error_state and also reads the vendor ID).  If we do
need both, then I think we need a little guidance in the function
comments about when to use one vs the other.

There are only a few uses of pci_device_is_present() (which looks at
dev->error_state and also reads the vendor ID) and they were added
here:

  8496e85c20e7 ("PCI / tg3: Give up chip reset and carrier loss handling if PCI device is not present")
  17a402a0075c ("igb: Fixes needed for surprise removal support")
  6db28eda2660 ("nvme/pci: Disable on removal when disconnected")
  b8a62d540240 ("ACPI / hotplug / PCI: Use pci_device_is_present()")
  4ebe34503baa ("ACPI / hotplug / PCI: Check for new devices on enabled slots")
  a6a64026c0cd ("PCI: Recognize D3cold in pci_update_current_state()")

The ACPI and PCI core uses are basically enumeration-type things so
that mostly makes sense to me.

I'm not so sure about the driver uses though.  I wonder if those could
be better handled by having the drivers check for ~0 error response
data from MMIO and config reads.

Bjorn
