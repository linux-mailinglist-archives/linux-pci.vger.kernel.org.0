Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F43DAE01
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 23:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhG2VG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 17:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhG2VGZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 17:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 099D96024A;
        Thu, 29 Jul 2021 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627592782;
        bh=eEnm/a5qy4eTENAVQT5rcKsyxyRjCuIi5W6UMN2QzOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nkCvIgWXDHZlBZoYCLfVUdZnttlRL2miRLKTlBtEB8uWPhX4LvDZoJqrWOnzu6XsL
         jBLuRwHAtlB+8j9gkVvSaiq67WK557OVBLm1gyTm6L7X/jBubCuobS+2qNGKqpvrkf
         E4rx9jNxP5u5+atErR8EjXvbPqJcsSr9grBU7bZM6SnGDiXLKLW6rvw33JX3Yq0FXW
         qXHRzKcuXPRyTTxcYYayTUkTlEz9la2t8d35rxUcg25MvqI/1NCYkzH+jrX9HijCti
         YkjSwNJyK6JIwrWDA4Jw9KyrMvqbdCr12ZYZQGAn5LyDhcd3+VUrsJidpsEKUo2bAS
         1DHBy6CxKuT9w==
Date:   Thu, 29 Jul 2021 16:06:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Marcin Bachry <hegel666@gmail.com>,
        prike.liang@amd.com, shyam-sundar.s-k@amd.com
Subject: Re: [PATCH] PCI: quirks: Quirk PCI d3hot delay for AMD xhci
Message-ID: <20210729210620.GA990816@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6c6fad-8cda-537a-2178-f5e22e565e8c@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 03:42:58PM -0500, Limonciello, Mario wrote:
> On 7/29/2021 15:39, Bjorn Helgaas wrote:
> > On Wed, Jul 21, 2021 at 10:58:58PM -0400, Alex Deucher wrote:
> > > From: Marcin Bachry <hegel666@gmail.com>
> > > 
> > > Renoir needs a similar delay.
> > > 
> > > [Alex: I talked to the AMD USB hardware team and the
> > >   AMD windows team and they are not aware of any HW
> > >   errata or specific issues.  The HW works fine in
> > >   windows.  I was told windows uses a rather generous
> > >   default delay of 100ms for PCI state transitions.]
> > > 
> > > Signed-off-by: Marcin Bachry <hegel666@gmail.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > 
> > Added stable tag and applied to pci/pm for v5.15, thanks!
> 
> Thanks Bjorn!
> 
> Given how small/harmless this is and 5.14 isn't cut yet, any chance this
> could still make one of the -rcX rather than wait for 5.14.1 instead?

Done.

What's the rest of the story here?  Aare we working around a defect in
these XHCI controllers?  A defect in Linux?  Obviously nobody wants to
have to add a quirk for every new Device ID.  It's not like this
should be hard to figure out for your hardware guys in the lab, and if
it turns out to be a Linux problem, we should fix it so everybody
benefits.

> > > Cc: mario.limonciello@amd.com
> > > Cc: prike.liang@amd.com
> > > Cc: shyam-sundar.s-k@amd.com
> > > ---
> > > 
> > > Bjorn,
> > > 
> > > With the above comment in mind, would you consider this patch
> > > or would you prefer to increase the default timeout on Linux?
> > > 100ms seems a bit long and most devices seems to work within
> > > that limit.  Additionally, this patch doesn't seem to be
> > > required on all AMD platforms with the affected USB controller,
> > > so I suspect the current timeout on Linux is probably about
> > > right.  Increasing it seems to fix some of the marginal cases.
> > > 
> > > Alex
> > > 
> > >   drivers/pci/quirks.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 22b2bb1109c9..dea10d62d5b9 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -1899,6 +1899,7 @@ static void quirk_ryzen_xhci_d3hot(struct pci_dev *dev)
> > >   }
> > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0, quirk_ryzen_xhci_d3hot);
> > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e1, quirk_ryzen_xhci_d3hot);
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1639, quirk_ryzen_xhci_d3hot);
> > >   #ifdef CONFIG_X86_IO_APIC
> > >   static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> > > -- 
> > > 2.31.1
> > > 
> 
