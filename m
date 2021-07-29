Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434483DAE5A
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 23:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhG2Vac (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 17:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233372AbhG2Vac (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 17:30:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C24D60C51;
        Thu, 29 Jul 2021 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627594228;
        bh=JACPWM08p9Bl7Q6C0kW80dOOBlK4TierlVOYfbIIRK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JLJnVXJ9UO1GTvEnH7Xsn284nT/eWr2nOyU4nmg5HuPQa+aBfH8Gl8OaDi87d+aWP
         LmNlTroEQoU+O77uqrXYelUZD8Qd6k5f40A/H4td0ALtpFxMfr1Xg83+RenxB/+cCN
         txqqg0QE1MgfyMo7s/FsO+zhC0mXbG53aj/jB2o9Gd7ePFc0jgbwollYYdmI1UlHTk
         ndJQvWuL2n0bwVryN4guzzYBbRismwAzTNsHsCOsgh91upbRPH5Vwm0vmzV+fYfMob
         K1LXQ8+koRswwWLE+H5a/yr8sDYKVHGVQTH3n92kflHWziB9ThvnHjvYOzREl+oPjL
         +70qjvZ6A74dQ==
Date:   Thu, 29 Jul 2021 16:30:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Marcin Bachry <hegel666@gmail.com>,
        prike.liang@amd.com, shyam-sundar.s-k@amd.com
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Message-ID: <20210729213026.GA992249@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad2a6e91-47f2-fc1c-13ef-0cf23805bd75@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 04:09:50PM -0500, Limonciello, Mario wrote:
> On 7/29/2021 16:06, Bjorn Helgaas wrote:
> > On Thu, Jul 29, 2021 at 03:42:58PM -0500, Limonciello, Mario wrote:
> > > On 7/29/2021 15:39, Bjorn Helgaas wrote:
> > > > On Wed, Jul 21, 2021 at 10:58:58PM -0400, Alex Deucher wrote:
> > > > > From: Marcin Bachry <hegel666@gmail.com>
> > > > > 
> > > > > Renoir needs a similar delay.
> > > > > 
> > > > > [Alex: I talked to the AMD USB hardware team and the
> > > > >    AMD windows team and they are not aware of any HW
> > > > >    errata or specific issues.  The HW works fine in
> > > > >    windows.  I was told windows uses a rather generous
> > > > >    default delay of 100ms for PCI state transitions.]
> > > > > 
> > > > > Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > 
> > > > Added stable tag and applied to pci/pm for v5.15, thanks!
> > > 
> > > Thanks Bjorn!
> > > 
> > > Given how small/harmless this is and 5.14 isn't cut yet, any chance this
> > > could still make one of the -rcX rather than wait for 5.14.1 instead?
> > 
> > Done.
> 
> Thanks!
> 
> > What's the rest of the story here?  Aare we working around a defect in
> > these XHCI controllers?  A defect in Linux?  Obviously nobody wants to
> > have to add a quirk for every new Device ID.  It's not like this
> > should be hard to figure out for your hardware guys in the lab, and if
> > it turns out to be a Linux problem, we should fix it so everybody
> > benefits.
> 
> Maybe you missed the embedded message from Alex above.  We had a discussion
> with our internal team that works with Windows on this, and they told us the
> default delay is significantly more generous on Windows.

I did see Alex's message, but it didn't answer the question of whether
this is a hardware defect or a Linux defect.  "It works fine in
Windows" doesn't mean the hardware conforms to the spec.

PCIe r5.0, sec 5.3.1.4 says "... System Software must allow a minimum
recovery time following a D3Hot → D0 transition of at least 10 ms (see
Section 7.9.17), prior to accessing the Function."

If the hardware isn't ready in 10ms, I'd claim that's a hardware
defect.

If Linux isn't waiting the 10ms, I'd claim that's a Linux defect.

If things work by waiting 100ms, that's nice, but what's the point of
specs if we have to increase the time and penalize everybody just to
accommodate some oddball device?

> > > > > Cc: mario.limonciello@amd.com
> > > > > Cc: prike.liang@amd.com
> > > > > Cc: shyam-sundar.s-k@amd.com
> > > > > ---
> > > > > 
> > > > > Bjorn,
> > > > > 
> > > > > With the above comment in mind, would you consider this patch
> > > > > or would you prefer to increase the default timeout on Linux?
> > > > > 100ms seems a bit long and most devices seems to work within
> > > > > that limit.  Additionally, this patch doesn't seem to be
> > > > > required on all AMD platforms with the affected USB controller,
> > > > > so I suspect the current timeout on Linux is probably about
> > > > > right.  Increasing it seems to fix some of the marginal cases.
> > > > > 
> > > > > Alex
> > > > > 
> > > > >    drivers/pci/quirks.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > > 
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index 22b2bb1109c9..dea10d62d5b9 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -1899,6 +1899,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
> > > > >    }
> > > > >    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
> > > > >    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> > > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
> > > > >    #ifdef CONFIG_X86_IO_APIC
> > > > >    static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> > > > > -- 
> > > > > 2.31.1
> > > > > 
> > > 
> 
