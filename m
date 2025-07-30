Return-Path: <linux-pci+bounces-33147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89946B15720
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 03:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FB456049E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 01:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2008119CD13;
	Wed, 30 Jul 2025 01:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkI+Qx8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE72C19A2A3
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840301; cv=none; b=kBPkB8MnnG1jG/vrkhFdjO/AsKBYUpElEGpE02aQLpWphxwO4lQK0k/aF2lVas1RsokIZWvxqF0FpW3XvexZj9/fGFXLfHcPSEROGn+X3ftLmyYsabwi7F2i1blXM8r0xZHQ3I17ZWJvsf8TxMsUfYoYA2iH4QllLzUPcZR5VUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840301; c=relaxed/simple;
	bh=QRGK7T0rnihApOShy1dGGdyvxViRwDlM1P9dzMVht+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9HrRj2g2L5/lICwCfcYex5ILsQjupZNdv1/5mzB6GjHJXnNjtjcRoHNk+GW+MkF9WygNBvfVS08/bgof0GW42BsQForgLAlYctwXES1EnAPqLgqekdtJy2wJS915PP4ec8FysMhHuyRblYi+S9ZHbcUOJyboNns6fn1tzBH4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkI+Qx8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A8BC19422
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 01:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753840300;
	bh=QRGK7T0rnihApOShy1dGGdyvxViRwDlM1P9dzMVht+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZkI+Qx8kmVmtT+ZbzAbPlNSlmbbrIWtFY1iNHmpQ1Z0/wKc0WPvtdlK3q1fqYy58N
	 o+GBSzyGh0uusgNkx5nBSVezLNf/dgH4Jn4K4hPVyaFHaeM5d5oA/OJXdNVNrFmQ6C
	 pCAsPRyp0VHBkJz8gGPGs1vs4rjHc4auqBXReWdM0zkSRGOsRAshwb0Yy4I4ygffSz
	 KcM4Tr5q8BzeSral8oJRIftjEn/gyEUP2kDS5MSvXYkLkRHYkU15YQSp5X7gXpbR6c
	 pwta5PFs8eeYmk5/LenihHKO5jLqowUEj5Cp/WcidKA+YuMXxIZd+DW/9NBhecMe6A
	 bKxdz4ykEpsvw==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561b43de62so44685e9.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 18:51:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpBR40Zi2Ct0EruOS534KFZOwO/7wRTrinxesB9xD8UV9MtQzPyDGKUuZMuKLCCEiRRW9E/AqpMuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3VMndNQihhvNmNihTn0P31HwAIhAXGDIw6Bu43oBoX4Il/Uu
	+8lhhuMlvGFsxy60uY8Mf+bNWJGdgd9a91O0Trs+zhnJxe4DB3gEz7bn62/dLRXQsBMtcKmEqsq
	N825XWwSKbhkBr2Gr6scxDJsvXAu/QDUHNg38Dglu
X-Google-Smtp-Source: AGHT+IFVJ4GRdwU6HSu4lkllSKQtOadwGBHwmdTT/hu2qK6/C0k3KNPt9SkIOIBodqDTqZxgb0MOEu1Ov1wNUBRa96Y=
X-Received: by 2002:a05:600c:681:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45893a5f51emr520475e9.2.1753840298732; Tue, 29 Jul 2025
 18:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org> <87zfconsaw.ffs@tglx>
In-Reply-To: <87zfconsaw.ffs@tglx>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 29 Jul 2025 18:51:27 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
X-Gm-Features: Ac12FXxnjSA_5g1BiBGXIvXEzdwU-zqT35zbMfT82ZSWhkngdOqj32BeUVz077Y
Message-ID: <CAF8kJuOM=2oEFP20xWtQ==ECwF_vNB032Os3-N12zY1xVau-yw@mail.gmail.com>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at boot
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Mon, Jul 28, 2025 at 10:23=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Mon, Jul 28 2025 at 01:24, Chris Li wrote:
> > The liveupdate devices are already initialized by the kernel before the
> > kexec. During the kexec the device is still running. Avoid write to the
> > liveupdate devices during the new kernel boot up.
>
> This change log is way too meager for this kind of change.

I agree with you. I mention it in the cover letter, I do expect this
part of change to be controversial. This RFC series is just to kick
off the discussion for PCI device liveupdate.

>  1) You want to explain in detail how this works.
>     "initialized by the kernel before the kexec" is as vague as it gets.

Agree. Sorry I haven't included more documents in this series. Working on i=
t.

>
>  2) Avoid write ....
>
>     Again this lacks any information how this is supposed to work correct=
ly.

I guess I haven't presented the big picture of how liveupdate works
with a PCI device.

Let's start with the background why we want to do this. We want to
upgrade a host kernel, which has a VM running with a GPU device
attached to the VM via vfio_pci. We want the host kernel upgrade in a
way that the VM can continue without shutting down and restarting the
VM. The VM will pause during the host kernel kexec. The GPU device
will continue running and DMA without pausing. VM will not be able to
run the interrupt until the new kernel is finished booting and resume
the VM.

Pasha's LUO series already have designs on the liveupdate state, with
callback associated with the state.

https://lore.kernel.org/lkml/20250515182322.117840-1-pasha.tatashin@soleen.=
com/

I copy paste some of Pasha's LUO state here:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dquote=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
LUO State Machine and Events:

NORMAL:   Default operational state.
PREPARED: Initial preparation complete after LIVEUPDATE_PREPARE
          event. Subsystems have saved initial state.
FROZEN:   Final "blackout window" state after LIVEUPDATE_FREEZE
          event, just before kexec. Workloads must be suspended.
UPDATED:  Next kernel has booted via live update. Awaiting restoration
          and LIVEUPDATE_FINISH.

Events:
LIVEUPDATE_PREPARE: Prepare for reboot, serialize state.
LIVEUPDATE_FREEZE:  Final opportunity to save state before kexec.
LIVEUPDATE_FINISH:  Post-reboot cleanup in the next kernel.
LIVEUPDATE_CANCEL:  Abort prepare or freeze, revert changes.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dquote ends =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The PCI core register will register as a subsystem to LUO and
participate in the LUO callbacks.
1) In NORMAL state:
The PCI device will register to the PCI subsystem by setting the
pci_dev->dev.lu.requested flag.

2) PREPARE callback. The PCI subsystem will build the list of the PCI
devices using the PCI device dependency. VF depends on PF, PCI devices
depend on the parent bridge.

The PCI subsystem will save the struct pci_dev part of the pci device
state. Then forward the prepare callback to the PCI devices to
serialize the PCI devices driver state. The VM  is still running but
with some limitations. e.g. can't create new DMA mapping. can't attach
to an additional new vfio_pci device.

3) FREEZE callback: VM is paused. Last change for PCI device to
serialize the device state.

4) kexec booting up the new kernel.

5) PCI device enumeration and probing. Find the PCI device in the
serialized preserved device list, restore the device serialized data
pointer for PCI device. PF device probe(), restores the number of  VF
and creates the VF, the VF device probe()

6) VM re-attach to the requested PCI device via vfio_pci.

7) FINISH callback. PCI subsystem and PCI devices free their preserved
serialized data. System go back to NORMAL state.

8) VM resume running.

>
> >  drivers/pci/ats.c            |  7 ++--
> >  drivers/pci/iov.c            | 58 ++++++++++++++++++------------
> >  drivers/pci/msi/msi.c        | 32 ++++++++++++-----
> >  drivers/pci/msi/pcidev_msi.c |  4 +--
> >  drivers/pci/pci-acpi.c       |  3 ++
> >  drivers/pci/pci.c            | 85 +++++++++++++++++++++++++++++-------=
--------
> >  drivers/pci/pci.h            |  9 ++++-
> >  drivers/pci/pcie/aspm.c      |  7 ++--
> >  drivers/pci/pcie/pme.c       | 11 ++++--
> >  drivers/pci/probe.c          | 43 +++++++++++++++-------
> >  drivers/pci/setup-bus.c      | 10 +++++-
>
> Then you sprinkle this stuff into files, which have completely different
> purposes, without any explanation for the particular instances why they
> are supposed to be correct and how this works.

They follow a pattern that the original kernel needs to write to the
device and change the device state. The liveupdate device needs to
maintain the previous state not changed, therefore needs to prevent
such write initialization in liveupdate case.

I can certainly split it into more patches and group them by functions
in the later series.
This patch does it in a whole sale just to demonstrate what needs to
happen to make a device live update.

>
> I'm just looking at the MSI parts, as I have no expertise with the rest.

Thank you for your feedback, that is very helpful.

>
> > diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> > index 6ede55a7c5e652c80b51b10e58f0290eb6556430..7c40fde1ba0f89ad1d72064=
ac9e80696faeab426 100644
> > --- a/drivers/pci/msi/msi.c
> > +++ b/drivers/pci/msi/msi.c
> > @@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *de=
v)
> >
> >  void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
> >  {
> > -     raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
> > +     struct pci_dev *pci_dev =3D to_pci_dev(desc->dev);
> > +     raw_spinlock_t *lock =3D &pci_dev->msi_lock;
> >       unsigned long flags;
> >
> >       if (!desc->pci.msi_attrib.can_mask)
> > @@ -122,8 +123,9 @@ void pci_msi_update_mask(struct msi_desc *desc, u32=
 clear, u32 set)
> >       raw_spin_lock_irqsave(lock, flags);
> >       desc->pci.msi_mask &=3D ~clear;
> >       desc->pci.msi_mask |=3D set;
> > -     pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_=
pos,
> > -                            desc->pci.msi_mask);
> > +     if (!pci_lu_adopt(pci_dev))
> > +             pci_write_config_dword(pci_dev, desc->pci.mask_pos,
> > +                                    desc->pci.msi_mask);
>
> This results in inconsistent state, which is a bad idea to begin
> with. How is cached software state and hardware state going to be
> brought in sync at some point?

Yes, to make the interrupt fully working we need to tell the new
kernel about the previous kernel's interrupt descriptor in IOMMU etc.
As it is, the liveupdate device interrupt is not fully working yet.
David is working on the interrupt and later there will be an interrupt
series to make interrupt working with liveupdate devices. This is just
the first baby step.

>
> If you analyzed all places, which actually depend on hardware state and
> make decisions based on it, for correctness, then you failed to provide
> that analysis. If not, no comment.

Let me clarify. This avoid writing to devices only applies to
liveupdate devices. Only between FREEZE and FINISH. After the LUO
finish(), LUO is back to normal state again. The device can be
writable again as normal, most likely by the VM. We don't want the
device state to change between FREEZE and FINISH.

>
> >       raw_spin_unlock_irqrestore(lock, flags);
> >  }
> >
> > @@ -190,6 +192,9 @@ static inline void pci_write_msg_msi(struct pci_dev=
 *dev, struct msi_desc *desc,
> >       int pos =3D dev->msi_cap;
> >       u16 msgctl;
> >
> > +     if (pci_lu_adopt(dev))
> > +             return;
> > +
> >       pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
> >       msgctl &=3D ~PCI_MSI_FLAGS_QSIZE;
> >       msgctl |=3D FIELD_PREP(PCI_MSI_FLAGS_QSIZE, desc->pci.msi_attrib.=
multiple);
> > @@ -214,6 +219,8 @@ static inline void pci_write_msg_msix(struct msi_de=
sc *desc, struct msi_msg *msg
> >
> >       if (desc->pci.msi_attrib.is_virtual)
> >               return;
> > +     if (pci_lu_adopt(to_pci_dev(desc->dev)))
> > +             return;
>
> So you don't allow the new kernel to write the MSI message, but the
> interrupt subsystem has this new message and there are places which
> utilize that cached message. How is this supposed to work?

We don't allow the PCI subsystem or driver to write the MSI message
before FINISH.
There are two possible ways. 1) Have someone save the incoming MSI
message somehow, and re-deliver them after the FINISH call. 2) Don't
save the MSI message between FREEZE and FINISH. At finish, deliver one
spurious interrupt to the device driver, so the device driver can have
a chance to check if there is any pending work that needs to be done.
It is possible that no MSI has been dropped, the driver finds out
there is nothing that needs to be done. We expect the driver can
tolerate such one time spurious interruptions. Because spurious
interruptions can happen for other reasons, that should be fine? Let
me know if there is a case where this kind of spurious interrupt can
cause a problem, we are very interested to know.

>
> >       /*
> >        * The specification mandates that the entry is masked
> >        * when the message is modified:
> > @@ -279,7 +286,8 @@ static void pci_msi_set_enable(struct pci_dev *dev,=
 int enable)
> >       control &=3D ~PCI_MSI_FLAGS_ENABLE;
> >       if (enable)
> >               control |=3D PCI_MSI_FLAGS_ENABLE;
> > -     pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control)=
;
> > +     if (!pci_lu_adopt(dev))
> > +             pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, =
control);
>
> The placement of these conditionals is arbitrary. Some are the begin of
> a function, others just block the write. Is that based on some logic or
> were the places selected by shabby AI queries?
They all can be converted to the pattern as:
if (!pci_luo_adopt(dev))
      pci_write_config_xxx().

Sometimes I choose to return early if there is multiple write but not
data stored in struct pci_dev. Mostly just try to reduce the number of
if (!pci_luo_adopt(dev)). I am not satisfied with this change yet. The
goal of this patch is to show what effect needs to happen, we can
discuss better ways to do it.

>
> >  static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
> > @@ -553,6 +561,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_=
dev *dev, u16 clear, u16 set)
> >  {
> >       u16 ctrl;
> >
> > +     BUG_ON(pci_lu_adopt(dev));
>
> Not going to happen. BUG() is only appropriate when there is absolutely
> no way to handle a situation. This is as undocumented as everything else
> here.

Agree. This is some developing/debug stuff left over. I haven't
encountered msix_clear_and_set_ctrl() in my test. I will remove the
bug in the next version.

>
> >       pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> >       ctrl &=3D ~clear;
> >       ctrl |=3D set;
> > @@ -720,8 +729,9 @@ static int msix_capability_init(struct pci_dev *dev=
, struct msix_entry *entries,
> >        * registers can be accessed.  Mask all the vectors to prevent
> >        * interrupts coming in before they're fully set up.
> >        */
> > -     pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
> > -                                 PCI_MSIX_FLAGS_ENABLE);
> > +     if (!pci_lu_adopt(dev))
> > +             pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKAL=
L |
> > +                                         PCI_MSIX_FLAGS_ENABLE);
>
> And for enhanced annoyance you sprinkle this condition everywhere into
> the code and then BUG() when you missed an instance. Because putting it
> into the function which is invoked a gazillion of times would be too
> obvious, right? That would at least be tasteful, but that's not the
> primary problem of all this.
>
> Sprinkling these conditionals all over the place is absolutely
> unmaintainable, error prone and burdens everyone with this insanity and
> the related hard to chase bugs.

If you prefer, I can move them all into the pci_config_write. We
actually start with pci_config_write_xxx(). But that solution has its
own problem as well.  For starters, the function name does not reflect
what the function actually does any more. Also for the complicated
case, where liveupdate does need to write some config register but not
the other. e.g. From the live update point of view, PF devices
shouldn't write to SR-IOV related registers that change the VF devices
number. But PF devices should be able to tolerate some other config
space write, because the VM is not using the PF device. The PF device
state can be changed without impacting the VM.
It is going to be unmaintainable to make a complicated logic inside
pci_config_write_xxx(), depending on which caller and what state, what
is allowed and what is not.

I can discuss and try different approaches to address this problem. I
understand it is a hard problem. I don't have a perfect solution
without cons. This is just the first baby step to demonstrate what is
the resulting effect we want. Then we can shape the code to our
liking. I am happy to explore other approaches as well.

>
> Especially as there is no concept behind this and zero documentation how
> any of this should work or even be remotely correct.

I hope the above description can help you understand better why we
want to do it and the approach we take. I am happy to answer questions
if you have any. Mind you that I don't have all the answers. It is
part of the journey to find the best solution.
>
> Before you start the next hackery, please sit down and write up coherent
> explanations:
>
>   What is the general concept of this?

See above.

>
>   What is the exact state in which a device is left when the old kernel
>   jumps into the new kernel?

The device allows DMA to the mapping region during PREPARE and raise
interrupt. The interrupt handler will not be able to run during kexec
black out period (between freeze and finish). Other than the state
store in the device, there is also a PCI subsystem and device driver
state serialized in the preserved folio for the next kernel to
interrupt.

>   What is the state of the MSI[-X] or legacy PCI interrupts at this
>   point?

The current approach is that, just drop the interrupt during black out
period (between freeze and finish) then deliver a spurious interrupt
to the device at finish(), that gives the device driver a chance to
perform the interrupt handler action which can't happen in black out.

>
>   Can the device raise interrupts during the transition from the old to
>   the new kernel?

Yes, can raise interrupt but interrupt handle won't able to run during
black out.
After finish() it is business as usual.
>
>   How is the "live" state of the device reflected and restored
>   throughout the interrupt subsystem?

Those are very good questions. Current approach just drop them and use
the spurious interrupt to catch up in the end.
>
>   How is the device driver supposed to attach to the same interrupt
>   state as before?

We can't if we did not save the interrupt state changed during black
out. Current approach is just using a spurious interrupt to catch up
in finish().

>
>   How are the potentially different Linux interrupt numbers mapped to
>   the previous state?
The IRQ number will remain the state cross kexec. However the
interrupt descriptor address might have changed in the new kernel. We
need to save some of the interrupt descriptor and interrupt state into
the preserved folio for the next kernel to rebuild. To be continued in
the interrupt series. Not covered by this patch series yet.
>
> Before this materializes and is agreed on, this is not going anywhere.

Those are very good questions. Hopefully I have answered some of it.
Please let me know if you have more questions I can clarify.

Again this is just an RFC to show what was the resulting effect we
want to get from the PCI device livedupate. It is not complete nor
perfect. I am happy to explore different approaches.

Thanks for the questions. I still owe you a write up document for the
PCI device liveupdate. I will work on that.

Hope that helps explain some of the background and approach. It is not
a substitution of the document. I am working on that and will include
it in the next version.

Chris



Chris

