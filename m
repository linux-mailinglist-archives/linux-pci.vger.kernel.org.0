Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D01591A5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgBKOOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 09:14:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgBKOOq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 09:14:46 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1422082F;
        Tue, 11 Feb 2020 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581430485;
        bh=ImQCi1v7maiTIR8+b83HWMHPm3dLtKEqJrkpu6xs4jM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=w096pgbKJkZdOA14XsLiddZNc8uNNBZmCjsI5N8VYLdFMThN+jYPMiMM7U+nZo78G
         0prTCurhPmyVZWB/nUQr2OFGBeIoUepArVPfHnA/SVOz0JNabFPh7TJfr9yJ9lulUK
         p0wXV7yh7Qz/G0h6hnD0fG+iAGS+n+5q9V9ldzjQ=
Date:   Tue, 11 Feb 2020 08:14:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Libor Pechacek <lpechacek@suse.cz>
Subject: Re: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence
 comes up after link
Message-ID: <20200211141443.GA204966@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211044940.72z4vcgbgxwbc7po@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 05:49:40AM +0100, Lukas Wunner wrote:
> On Mon, Feb 10, 2020 at 06:08:16PM -0600, Bjorn Helgaas wrote:
> > used ctrl_info() instead of pci_info() (I would actually like to change
> > the whole driver to use pci_info(), but better to be consistent for now)
> 
> Most of the ctrl_info() calls prepend "Slot(%s): " to the message.
> However that prefix can only be used once pci_hp_initialize() has
> been called.
> 
> It would probably make sense to change ctrl_info() to always
> include the prefix and change those invocations of ctrl_info()
> which happen when the slot is not yet or no longer registered,
> to pci_info().

Ouch, my tweaks were definitely half-baked.

I really like your idea of hoisting the "Slot(%s)" text up into
ctrl_*().  I might rename ctrl_*() to slot_*() or similar to connect
it more with the slot registration.

I'm a little confused about why pci_hp_initialize()/
__pci_hp_initialize()/pci_hp_register()/__pci_hp_register() is such a
rat's nest with hotplug drivers using a mix of them.  I wonder if
that could be rationalized and maybe done earlier so all hotplug-
related messages could use the same ctrl_*() logging.

But this is all outside the scope of this patch.  I'll look at the
pcie_wait_for_presence() situation and revert to pci_info() if
if can be called when the slot is not registered.

> > @@ -930,7 +940,7 @@ struct controller *pcie_init(struct pcie_device *dev)
> >  		PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_CC |
> >  		PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC);
> >  
> > -	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c LLActRep%c%s\n",
> > +	ctrl_info(ctrl, "Slot #%d AttnBtn%c PwrCtrl%c MRL%c AttnInd%c PwrInd%c HotPlug%c Surprise%c Interlock%c NoCompl%c IbPresDis%c LLActRep%c%s\n",
> >  		(slot_cap & PCI_EXP_SLTCAP_PSN) >> 19,
> >  		FLAG(slot_cap, PCI_EXP_SLTCAP_ABP),
> >  		FLAG(slot_cap, PCI_EXP_SLTCAP_PCP),
> > @@ -941,19 +951,10 @@ struct controller *pcie_init(struct pcie_device *dev)
> >  		FLAG(slot_cap, PCI_EXP_SLTCAP_HPS),
> >  		FLAG(slot_cap, PCI_EXP_SLTCAP_EIP),
> >  		FLAG(slot_cap, PCI_EXP_SLTCAP_NCCS),
> > +		ctrl->inband_presence_disabled,
> >  		FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
> >  		pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
> 
> I've just reviewed the resulting commits on pci/hotplug once more and
> think there's a small issue here:  If ctrl->inband_presence_disabled is 0,
> the string will contain ASCII character 0 (end of string) and if it's 1
> it will contain ASCII character 1 (start of header).  A possible solution
> would be FLAG(ctrl->inband_presence_disabled, 1).

Definitely broken, sorry about that.  Feels like sort of a
double-negative situation, too.  Obviously the hardware bit has to be
"1 means disabled" to be compatible with previous spec versions, but
the code is usually easier to read if we test for something being
*enabled*.  I'll try to figure out something.

Bjorn
