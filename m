Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29726E3969
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439877AbfJXRLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439855AbfJXRLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:11:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4FC20650;
        Thu, 24 Oct 2019 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571937064;
        bh=50LiASavYQZLbe6nfO7wdHLLLfE3YL2HyvzWd+ySzPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qtbTWnH9LA3tbkJFClj5FPXT3Mtrc4X0jALff5Ub3dJQBOsMB9ZTw5xWY6LnRIT1K
         DshfISJ7KzW+Ubkjy5thaBOIiRSFSEC/CxfvkfZtPfvzDzpw4YMQP+D0Rz4BiCbtJq
         kIZ8ib0J215lecEYJkXFVeeKcJ6aULHrnG+QixvI=
Date:   Thu, 24 Oct 2019 12:11:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20191024171102.GA147451@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024093803.GU2819@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 24, 2019 at 12:38:03PM +0300, Mika Westerberg wrote:
> On Wed, Oct 23, 2019 at 10:52:53AM +0300, Mika Westerberg wrote:
> > > Shouldn't we check for slot_status being an error response (~0)
> > > instead of looking for PCIBIOS_DEVICE_NOT_FOUND?  There are 7 RsvdP
> > > bits in Slot Status, so ~0 is not a valid value for the register.
> > > 
> > > All 16 bits of Link Status are defined, but ~0 is still an invalid
> > > value because the Current Link Speed and Negotiated Link Width fields
> > > only define a few valid encodings.
> > 
> > Indeed that's a good point. I'll try that.
> 
> Just checking if I understand correctly what you are suggesting.
> 
> Currently we use pcie_capability_read_word() and check the return value.
> If the device is gone it returns an error and resets *val to 0. That
> only works if pci_dev_is_disconnected() is true so we would need to do
> something like below.
> 
> pciehp_check_link_active():
> 
> 	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> 	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> 		return -ENODEV;

Yes, I guess this is what you'd have to do.

> Or you mean that we check only for ~0 in which case we either need to
> use pci_read_config_word() directly here or modify pcie_capability_read_word()
> return ~0 instead of clearing it?

I *would* like to explore removing the "*val = 0" code from
pci_capability_read*(), but not in the context of this issue.
