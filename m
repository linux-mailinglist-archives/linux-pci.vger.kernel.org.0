Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF210A8AC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfK0CTU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Nov 2019 21:19:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36578 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfK0CTU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Nov 2019 21:19:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id d13so18165811qko.3;
        Tue, 26 Nov 2019 18:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zCaW4s32eCFmlG1ler0djzq2X8fTYYScffmpk4IE40k=;
        b=rmzGwHgQ7HmSP+zwcqdUcD2LxC/T7MExNS4e6HwAll2bziRli2CmOpZUOHcGPuHQ3i
         1VdvM40jYHDPsrNLDSKwurijc7W8Hjh6WCykErqQNbIhy0gD6TBk/sjrqvTBlOeqBe7z
         RjpG4ejox01fDUaD76B0pa1PL6lTGOwWsJhTJNtyBZuhnw5x08+fD1MIaxp4VycVwZeG
         0POKzsQ5/xOMcEtlc/Rb3dYQx6HFAKFsCucy57VA+2MZXKcl4cxnPH56eCEcFdzswp0i
         RWYER8URpJviqY27lmhWPLGGuG8emE8CjGe/rD+vFtR7UHWPbNg1aGf9Q4L5Ix2nRXe/
         X7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCaW4s32eCFmlG1ler0djzq2X8fTYYScffmpk4IE40k=;
        b=Px3mdelPxtD1QxOknoOAjCwlR/8Wy3VhW6dneffhKfOSseXJesS0w2bVo69HtfSBMv
         iWk7mFKLO+XP6k4VrGJ02yh2OZGZjXmO0VhlQVq+MX+109VKygKNQrIhB7Z7sCNS9PDK
         9V3rj8PxlW2Ijzvkm1bNvMlzbsfVdPFXQ+/4iegA0JJGvxeThMpnZt4JwTL1N9kyhKyc
         zlQm1qQQFf+NTiNfzXObRxdFEtNgLA0zGADKGL/uS4yH+UqyO3sPCB1IAK+kVAAwA4Qc
         x8XpigSCuf6jgVMNIAFeC4tRg/I1PlMW+Vap5nTh02P9z6fQCgKVmDFRfnBd1uTGo0kw
         5buw==
X-Gm-Message-State: APjAAAW7H3Ze6qNXA9r4nO5+Nt/NkPE3TDGMDxpcUs+it4tClFO05Nkh
        kOladzyX0QZ7JxRrfg4uUOwI+N9DqJcG4H//ntQ=
X-Google-Smtp-Source: APXvYqyC2AGLu/+Ozlz+BFfQfnkq+kSifTUs2NsXRJqmsitgsiNMWroDD3OjetHeCrV+hNBLS7lwcMkxmNfQ6/qYEtA=
X-Received: by 2002:a37:dc44:: with SMTP id v65mr1878589qki.72.1574821158387;
 Tue, 26 Nov 2019 18:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20191025190047.38130-2-stuart.w.hayes@gmail.com> <20191127013613.GA233706@google.com>
In-Reply-To: <20191127013613.GA233706@google.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Date:   Tue, 26 Nov 2019 20:19:07 -0600
Message-ID: <CAL5oW00Lh4v2YpX2GcDoRS2fFJjvHRsdhNjtvyYGpWOpgL=TCg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for disabling in-band presence
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 26, 2019 at 7:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Oct 25, 2019 at 03:00:45PM -0400, Stuart Hayes wrote:
> > From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> >
> > The presence detect state (PDS) is normally a logical or of in-band and
> > out-of-band presence. As of PCIe 4.0, there is the option to disable
> > in-band presence so that the PDS bit always reflects the state of the
> > out-of-band presence.
> >
> > The recommendation of the PCIe spec is to disable in-band presence
> > whenever supported.
>
> I think I'm fine with this patch, but I would like to include the
> specific reference for this recommendation.  If you have it handy, I
> can just insert it.
>

The PCI Express Base Specification Revision 5.0, Version 1.0, in the
implementation note under Appendix I ("Async Hot-Plug Reference
Model"), it says "If OOB PD is being used and the associated DSP
supports In-Band PD Disable, it is recommended that the In-Band PD
Disable bit be Set, ..."


> > Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > ---
> >  drivers/pci/hotplug/pciehp.h     | 1 +
> >  drivers/pci/hotplug/pciehp_hpc.c | 9 ++++++++-
> >  include/uapi/linux/pci_regs.h    | 2 ++
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> > index 654c972b8ea0..27e4cd6529b0 100644
> > --- a/drivers/pci/hotplug/pciehp.h
> > +++ b/drivers/pci/hotplug/pciehp.h
> > @@ -83,6 +83,7 @@ struct controller {
> >       struct pcie_device *pcie;
> >
> >       u32 slot_cap;                           /* capabilities and quirks */
> > +     unsigned int inband_presence_disabled:1;
> >
> >       u16 slot_ctrl;                          /* control register access */
> >       struct mutex ctrl_lock;
> > diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> > index 1a522c1c4177..dc109d521f30 100644
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -811,7 +811,7 @@ static inline void dbg_ctrl(struct controller *ctrl)
> >  struct controller *pcie_init(struct pcie_device *dev)
> >  {
> >       struct controller *ctrl;
> > -     u32 slot_cap, link_cap;
> > +     u32 slot_cap, slot_cap2, link_cap;
> >       u8 poweron;
> >       struct pci_dev *pdev = dev->port;
> >       struct pci_bus *subordinate = pdev->subordinate;
> > @@ -869,6 +869,13 @@ struct controller *pcie_init(struct pcie_device *dev)
> >               FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
> >               pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
> >
> > +     pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
> > +     if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
> > +             pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
> > +                                   PCI_EXP_SLTCTL_IBPD_DISABLE);
> > +             ctrl->inband_presence_disabled = 1;
> > +     }
> > +
> >       /*
> >        * If empty slot's power status is on, turn power off.  The IRQ isn't
> >        * requested yet, so avoid triggering a notification with this command.
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index 29d6e93fd15e..ea1cf9546e4d 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -604,6 +604,7 @@
> >  #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
> >  #define  PCI_EXP_SLTCTL_EIC  0x0800  /* Electromechanical Interlock Control */
> >  #define  PCI_EXP_SLTCTL_DLLSCE       0x1000  /* Data Link Layer State Changed Enable */
> > +#define  PCI_EXP_SLTCTL_IBPD_DISABLE 0x4000 /* In-band PD disable */
> >  #define PCI_EXP_SLTSTA               26      /* Slot Status */
> >  #define  PCI_EXP_SLTSTA_ABP  0x0001  /* Attention Button Pressed */
> >  #define  PCI_EXP_SLTSTA_PFD  0x0002  /* Power Fault Detected */
> > @@ -676,6 +677,7 @@
> >  #define PCI_EXP_LNKSTA2              50      /* Link Status 2 */
> >  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2       52      /* v2 endpoints with link end here */
> >  #define PCI_EXP_SLTCAP2              52      /* Slot Capabilities 2 */
> > +#define  PCI_EXP_SLTCAP2_IBPD        0x0001  /* In-band PD Disable Supported */
> >  #define PCI_EXP_SLTCTL2              56      /* Slot Control 2 */
> >  #define PCI_EXP_SLTSTA2              58      /* Slot Status 2 */
> >
> > --
> > 2.18.1
> >
