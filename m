Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6DF105935
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKUSPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 13:15:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:53426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSPC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 13:15:02 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F07206CB;
        Thu, 21 Nov 2019 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360101;
        bh=ijyd7cvmLy8JKNJbgtDDlfBXxuIHmN+a8yLmCNyGDqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VgwLmUNzZRbIdTmWHbDI8KdQQ+ScwxNVOV7pkZGey2MAv2Ut5eFUXXTW67vDabEOV
         RHtsfLKq8QC+/GnTC3C0fo9kMAqptOayz2c1bZmnXLhoIdEEcn/zAk22QVqBcSuHCI
         kM/dv9vzFnnBE3Ix/ZmKNfzQenYhqT4eob4P/E1s=
Date:   Thu, 21 Nov 2019 12:15:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com,
        linux@endlessm.com, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191121181500.GA55996@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120002836.GA247344@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 06:28:36PM -0600, Bjorn Helgaas wrote:
> On Mon, Oct 14, 2019 at 02:13:55PM +0800, Daniel Drake wrote:
> > On Asus laptops with AMD Ryzen7 3700U and AMD Ryzen5 3500U,
> 
> Can you include specific models here in case we revisit this or find a
> generic solution that needs to be tested to make sure we don't regress
> these platforms?
> 
> Maybe a bugzilla with complete "lspci -vvnn" and dmesg logs?
> 
> > the XHCI controller fails to resume from runtime suspend or s2idle,
> > and USB becomes unusable from that point.
> > 
> > xhci_hcd 0000:03:00.4: Refused to change power state, currently in D3
> > xhci_hcd 0000:03:00.4: enabling device (0000 -> 0002)
> > xhci_hcd 0000:03:00.4: WARN: xHC restore state timeout
> > xhci_hcd 0000:03:00.4: PCI post-resume error -110!
> > xhci_hcd 0000:03:00.4: HC died; cleaning up
> > 
> > The D3-to-D0 transition is successful if the D3 delay is increased
> > to 20ms. Add an appropriate quirk for the affected hardware.
> 
> IIUC, we're doing a D3cold-to-D0 transition in this path:
> 
>   pci_pm_default_resume_early
>     pci_power_up
>       platform_pci_set_power_state(PCI_D0)    # turn on via ACPI
>       pci_raw_set_power_state(PCI_D0)
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr)
>         # pmcsr says device is in D3hot
>         pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, pmcsr)
>         # sets to D0
>         pci_dev_d3_sleep                      # <-- need more time here
> 
> I would sort of expect that ACPI would be putting the device in D0,
> not leaving it in D3hot, but maybe that's just my ignorance.

I definitely was not understanding this correctly.  There is no path
for a D3cold -> D3hot transition.  Per spec (PCIe r5.0, sec 5.8), the
only legal exit from D3cold is to D0uninitialized.

I know you tried a debug patch to call pci_dev_wait(), and it didn't
work, but I'm not sure exactly where it was called.  I have these
patches on my pci/pm branch for v5.5:

  bae26849372b ("PCI/PM: Move pci_dev_wait() definition earlier")
  395f121e6199 ("PCI/PM: Wait for device to become ready after power-on")

The latter adds the wait just before we call
pci_raw_set_power_state().  If the device is responding with CRS
status, that should be the point where we'd see it.  If you have a
chance to try it, I'd be interested in the results.  Here's the
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/pm&id=395f121e61994bc135bb669eb35325d5457d669d
