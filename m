Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93F1264FB
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 15:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbfEVNs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 09:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbfEVNs7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 09:48:59 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CECFA20863;
        Wed, 22 May 2019 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558532938;
        bh=VL1cWoi3o+m733pzCk2d2Spvfc4+4jsPeFAkOJZnOvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ViBMoAV32tgv4QXzlSEfzwtCXlXXw5VoD70SdXSPyjysHMR+JVgoj4LfTDoy3bW2g
         R8dtdE6YclyxkLu4stqMit1B3iejU/zTj916/I4VhRtjZXnSoKTdOkbhZexa7rUzoh
         JogO2MgAiuU/C906sgK4cQTeo6gPMtT66RpCyHIc=
Date:   Wed, 22 May 2019 08:48:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] PCI / PM: Don't runtime suspend when device only
 supports wakeup from D0
Message-ID: <20190522134854.GA79339@google.com>
References: <20190521163104.15759-1-kai.heng.feng@canonical.com>
 <20190521222300.GG57618@google.com>
 <AE3B21D0-5BD9-40A5-B5A1-3E9A8B8E1327@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AE3B21D0-5BD9-40A5-B5A1-3E9A8B8E1327@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 11:42:14AM +0800, Kai Heng Feng wrote:
> at 6:23 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, May 22, 2019 at 12:31:04AM +0800, Kai-Heng Feng wrote:
> > > There's an xHC device that doesn't wake when a USB device gets plugged
> > > to its USB port. The driver's own runtime suspend callback was called,
> > > PME signaling was enabled, but it stays at PCI D0.
> > 
> > This looks like it's fixing a bug?  If so, please include a link to
> > the bug report, and make sure the bug report has "lspci -vv" output
> > attached to it.

I see your bug report (https://bugzilla.kernel.org/show_bug.cgi?id=203673)
but it doesn't say anything about what this looks like to a user.
Presumably somebody complained about something not working.  The bug
report should include that information about what isn't working.
Ideally, a user experiencing a problem should be able to google for
the symptoms and find the bug report.

> > > A PCI device can be runtime suspended to D0 when it supports D0 PME and
> > > its _S0W reports D0. Theoratically this should work, but as [1]
> > > specifies, D0 doesn't have wakeup capability.
> > 
> > What does "runtime suspended to D0" mean?

If I understand correctly, Linux normally clears PME-Enable while
devices are in D0, but sets PME-Enable if a device is "runtime
suspended to D0".

I'm not sure I'd describe that as "suspended", since the power
management state is exactly D0 and the only difference is that a PME
interrupt is enabled.  It sounds to me like the xHCI controller is
basically using PME as a hotplug interrupt to say "something happened
on my secondary (USB) interface".  But that's more a question for
Rafael.

And I guess this patch basically means we wouldn't call the driver's
suspend callback if we're merely going to stay at D0, so the driver
would have no idea anything happened.  That might match
Documentation/power/pci.txt better, because it suggests that the
suspend callback is related to putting a device in a low-power state,
and D0 is not a low-power state.

Maybe we should also update Documentation/power/pci.txt to say "PCI
devices ... can be programmed to generate PMEs while in any state
(D0-D3)" instead of "a low-power state (D1-D3)".

Anyway, this is all Rafael's area, so I'll defer to him.

> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/pci-driver.c | 5 +++++
> > >  drivers/pci/pci.c        | 2 +-
> > >  include/linux/pci.h      | 3 +++
> > >  3 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index cae630fe6387..15a6310c5d7b 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -1251,6 +1251,11 @@ static int pci_pm_runtime_suspend(struct
> > > device *dev)
> > >  		return 0;
> > >  	}
> > > 
> > > +	if (pci_target_state(pci_dev, device_can_wakeup(dev)) == PCI_D0) {
> > > +		dev_dbg(dev, "D0 doesn't have wakeup capability\n");
> > > +		return -EBUSY;
> > > +	}
> > > +
> > >  	pci_dev->state_saved = false;
> > >  	if (pm && pm->runtime_suspend) {
> > >  		error = pm->runtime_suspend(dev);
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 8abc843b1615..ceee6efbbcfe 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2294,7 +2294,7 @@ EXPORT_SYMBOL(pci_wake_from_d3);
> > >   * If the platform can't manage @dev, return the deepest state from which it
> > >   * can generate wake events, based on any available PME info.
> > >   */
> > > -static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > > +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > >  {
> > >  	pci_power_t target_state = PCI_D3hot;
> > > 
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > index 4a5a84d7bdd4..91e8dc4d04aa 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1188,6 +1188,7 @@ bool pci_pme_capable(struct pci_dev *dev,
> > > pci_power_t state);
> > >  void pci_pme_active(struct pci_dev *dev, bool enable);
> > >  int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable);
> > >  int pci_wake_from_d3(struct pci_dev *dev, bool enable);
> > > +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup);
> > >  int pci_prepare_to_sleep(struct pci_dev *dev);
> > >  int pci_back_from_sleep(struct pci_dev *dev);
> > >  bool pci_dev_run_wake(struct pci_dev *dev);
> > > @@ -1672,6 +1673,8 @@ static inline int pci_set_power_state(struct
> > > pci_dev *dev, pci_power_t state)
> > >  { return 0; }
> > >  static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
> > >  { return 0; }
> > > +pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
> > > +{ return PCI_D0; }
> > >  static inline pci_power_t pci_choose_state(struct pci_dev *dev,
> > >  					   pm_message_t state)
> > >  { return PCI_D0; }
> > > -- 
> > > 2.17.1
> 
> 
