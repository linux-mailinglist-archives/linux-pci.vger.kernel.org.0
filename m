Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77253425325
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 14:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbhJGMfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 08:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241431AbhJGMfo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 08:35:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12CC76103C;
        Thu,  7 Oct 2021 12:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633610030;
        bh=061pwN+B3Fs8fpWyiAnqwrFT5ypfVPQKBYvN61xbSAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DszOQJMf1urtBTOpBdBk6XgndBKvvAK0y1H11wGOiFbJi6/cZjF9ZiKqlcegkWAGe
         JNdtDEpoSLQ6mIMjcXHWeMOyykL43qL07wjMWADq6AdsjWyXu2DGSfsjJnF4s9oobR
         EMCBDXIHCrILxjuXLtEoI9lkN89a3YlmChM1XQ4rlkg6RHAClnSOcp8/zwUJGF26fM
         9/bqjtffHdL2VdP4HrIlemHkqr4QK8O3RiC0STJ9Nzbwo35OqCEH1A5N6se3qdfihA
         SwzzsAfcVx3o+HnMmAgWhw5LerENfyBUcnxpEy0dFJpT/pFDOPBkwLiv/MR3bHjv7M
         Ep/t/227mGWyQ==
Date:   Thu, 7 Oct 2021 14:33:47 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v2 11/13] PCI: aardvark: Fix link training
Message-ID: <20211007143347.46d6e78c@thinkpad>
In-Reply-To: <20211007115522.GB19256@lpieralisi>
References: <20211005180952.6812-1-kabel@kernel.org>
        <20211005180952.6812-12-kabel@kernel.org>
        <20211007115522.GB19256@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 7 Oct 2021 12:55:22 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Tue, Oct 05, 2021 at 08:09:50PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Fix multiple link training issues in aardvark driver. The main reason of
> > these issues was misunderstanding of what certain registers do, since t=
heir
> > names and comments were misleading: before commit 96be36dbffac ("PCI:
> > aardvark: Replace custom macros by standard linux/pci_regs.h macros"), =
the
> > pci-aardvark.c driver used custom macros for accessing standard PCIe Ro=
ot
> > Bridge registers, and misleading comments did not help to understand wh=
at
> > the code was really doing.
> >=20
> > After doing more tests and experiments I've come to the conclusion that=
 the
> > SPEED_GEN register in aardvark sets the PCIe revision / generation
> > compliance and forces maximal link speed. Both GEN3 and GEN2 values set=
 the
> > read-only PCI_EXP_FLAGS_VERS bits (PCIe capabilities version of Root
> > Bridge) to value 2, while GEN1 value sets PCI_EXP_FLAGS_VERS to 1, which
> > matches with PCI Express specifications revisions 3, 2 and 1 respective=
ly.
> > Changing SPEED_GEN also sets the read-only bits PCI_EXP_LNKCAP_SLS and
> > PCI_EXP_LNKCAP2_SLS to corresponding speed.
> >=20
> > (Note that PCI Express rev 1 specification does not define PCI_EXP_LNKC=
AP2
> >  and PCI_EXP_LNKCTL2 registers and when SPEED_GEN is set to GEN1 (which
> >  also sets PCI_EXP_FLAGS_VERS set to 1), lspci cannot access
> >  PCI_EXP_LNKCAP2 and PCI_EXP_LNKCTL2 registers.)
> >=20
> > Changing PCIe link speed can be done via PCI_EXP_LNKCTL2_TLS bits of
> > PCI_EXP_LNKCTL2 register. Armada 3700 Functional Specifications says th=
at
> > the default value of PCI_EXP_LNKCTL2_TLS is based on SPEED_GEN value, b=
ut
> > tests showed that the default value is always 8.0 GT/s, independently of
> > speed set by SPEED_GEN. So after setting SPEED_GEN, we must also set va=
lue
> > in PCI_EXP_LNKCTL2 register via PCI_EXP_LNKCTL2_TLS bits.
> >=20
> > Triggering PCI_EXP_LNKCTL_RL bit immediately after setting LINK_TRAININ=
G_EN
> > bit actually doesn't do anything. Tests have shown that a delay is need=
ed
> > after enabling LINK_TRAINING_EN bit. As triggering PCI_EXP_LNKCTL_RL
> > currently does nothing, remove it.
> >=20
> > Commit 43fc679ced18 ("PCI: aardvark: Improve link training") introduced
> > code which sets SPEED_GEN register based on negotiated link speed from
> > PCI_EXP_LNKSTA_CLS bits of PCI_EXP_LNKSTA register. This code was added=
 to
> > fix detection of Compex WLE900VX (Atheros QCA9880) WiFi GEN1 PCIe cards=
, as
> > otherwise these cards were "invisible" on PCIe bus (probably because th=
ey
> > crashed). But apparently more people reported the same issues with these
> > cards also with other PCIe controllers [1] and I was able to reproduce =
this
> > issue also with other "noname" WiFi cards based on Atheros QCA9890 chip
> > (with the same PCI vendor/device ids as Atheros QCA9880). So this is no=
t an
> > issue in aardvark but rather an issue in Atheros QCA98xx chips. Also, t=
his
> > issue only exists if the kernel is compiled with PCIe ASPM support, and=
 a
> > generic workaround for this is to change PCIe Bridge to 2.5 GT/s link s=
peed
> > via PCI_EXP_LNKCTL2_TLS_2_5GT bits in PCI_EXP_LNKCTL2 register [2], bef=
ore
> > triggering PCI_EXP_LNKCTL_RL bit. This workaround also works when SPEED=
_GEN
> > is set to value GEN2 (5 GT/s). So remove this hack completely in the
> > aardvark driver and always set SPEED_GEN to value from 'max-link-speed'=
 DT
> > property. Fix for Atheros QCA98xx chips is handled separately by patch =
[2].
> >=20
> > These two things (code for triggering PCI_EXP_LNKCTL_RL bit and changing
> > SPEED_GEN value) also explain why commit 6964494582f5 ("PCI: aardvark:
> > Train link immediately after enabling training") somehow fixed detectio=
n of
> > those problematic Compex cards with Atheros chips: if triggering link
> > retraining (via PCI_EXP_LNKCTL_RL bit) was done immediately after enabl=
ing
> > link training (via LINK_TRAINING_EN), it did nothing. If there was a
> > specific delay, aardvark HW already initialized PCIe link and therefore
> > triggering link retraining caused the above issue. Compex cards trigger=
ed
> > link down event and disappeared from the PCIe bus.
> >=20
> > Commit f4c7d053d7f7 ("PCI: aardvark: Wait for endpoint to be ready befo=
re
> > training link") added 100ms sleep before calling 'Start link training'
> > command and explained that it is a requirement of PCI Express
> > specification. But the code after this 100ms sleep was not doing 'Start
> > link training', rather it triggered PCI_EXP_LNKCTL_RL bit via PCIe Root
> > Bridge to put link into Recovery state.
> >=20
> > The required delay after fundamental reset is already done in function
> > advk_pcie_wait_for_link() which also checks whether PCIe link is up.
> > So after removing the code which triggers PCI_EXP_LNKCTL_RL bit on PCIe
> > Root Bridge, there is no need to wait 100ms again. Remove the extra
> > msleep() call and update comment about the delay required by the PCI
> > Express specification.
> >=20
> > According to Marvell Armada 3700 Functional Specifications, Link traini=
ng
> > should be enabled via aardvark register LINK_TRAINING_EN after selecting
> > PCIe generation and x1 lane. There is no need to disable it prior reset=
ting
> > card via PERST# signal. This disabling code was introduced in commit
> > 5169a9851daa ("PCI: aardvark: Issue PERST via GPIO") as a workaround for
> > some Atheros cards. It turns out that this also is Atheros specific iss=
ue
> > and affects any PCIe controller, not only aardvark. Moreover this Ather=
os
> > issue was triggered by juggling with PCI_EXP_LNKCTL_RL, LINK_TRAINING_EN
> > and SPEED_GEN bits interleaved with sleeps. Now, after removing trigger=
ing
> > PCI_EXP_LNKCTL_RL, there is no need to explicitly disable LINK_TRAINING=
_EN
> > bit. So remove this code too. The problematic Compex cards described in
> > previous git commits are correctly detected in advk_pcie_train_link()
> > function even after applying all these changes.
> >=20
> > Note that with this patch, and also prior this patch, some NVMe disks w=
hich
> > support PCIe GEN3 with 8 GT/s speed are negotiated only at the lowest l=
ink
> > speed 2.5 GT/s, independently of SPEED_GEN value. After manually trigge=
ring
> > PCI_EXP_LNKCTL_RL bit (e.g. from userspace via setpci), these NVMe disks
> > change link speed to 5 GT/s when SPEED_GEN was configured to GEN2. This
> > issue first needs to be properly investigated. I will send a fix in the
> > future.
> >=20
> > On the other hand, some other GEN2 PCIe cards with 5 GT/s speed are
> > autonomously by HW autonegotiated at full 5 GT/s speed without need of =
any
> > software interaction.
> >=20
> > Armada 3700 Functional Specifications describes the following steps for
> > link training: set SPEED_GEN to GEN2, enable LINK_TRAINING_EN, poll unt=
il
> > link training is complete, trigger PCI_EXP_LNKCTL_RL, poll until signal
> > rate is 5 GT/s, poll until link training is complete, enable ASPM L0s.
> >=20
> > The requirement for triggering PCI_EXP_LNKCTL_RL can be explained by the
> > need to achieve 5 GT/s speed (as changing link speed is done by throw to
> > recovery state entered by PCI_EXP_LNKCTL_RL) or maybe as a part of enab=
ling
> > ASPM L0s (but in this case ASPM L0s should have been enabled prior
> > PCI_EXP_LNKCTL_RL).
> >=20
> > It is unknown why the original pci-aardvark.c driver was triggering
> > PCI_EXP_LNKCTL_RL bit before waiting for the link to be up. This does n=
ot
> > align with neither PCIe base specifications nor with Armada 3700 Functi=
onal
> > Specification. (Note that in older versions of aardvark, this bit was
> > called incorrectly PCIE_CORE_LINK_TRAINING, so this may be the reason.)
> >=20
> > It is also unknown why Armada 3700 Functional Specification says that i=
t is
> > needed to trigger PCI_EXP_LNKCTL_RL for GEN2 mode, as according to PCIe
> > base specification 5 GT/s speed negotiation is supposed to be entirely
> > autonomous, even if initial speed is 2.5 GT/s.
> >=20
> > [1] - https://lore.kernel.org/linux-pci/87h7l8axqp.fsf@toke.dk/
> > [2] - https://lore.kernel.org/linux-pci/20210326124326.21163-1-pali@ker=
nel.org/
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Cc: stable@vger.kernel.org # f4c7d053d7f7 ("PCI: aardvark: Wait for end=
point to be ready before training link")
> > Cc: stable@vger.kernel.org # 6964494582f5 ("PCI: aardvark: Train link i=
mmediately after enabling training")
> > Cc: stable@vger.kernel.org # 43fc679ced18 ("PCI: aardvark: Improve link=
 training")
> > Cc: stable@vger.kernel.org # 5169a9851daa ("PCI: aardvark: Issue PERST =
via GPIO")
> > Cc: stable@vger.kernel.org # 96be36dbffac ("PCI: aardvark: Replace cust=
om macros by standard linux/pci_regs.h macros")
> > Cc: stable@vger.kernel.org # d0c6a3475b03 ("PCI: aardvark: Move PCIe re=
set card code to advk_pcie_train_link()")
> > Cc: stable@vger.kernel.org # 1d1cd163d0de ("PCI: aardvark: Update comme=
nt about disabling link training")
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 117 ++++++++------------------
> >  1 file changed, 34 insertions(+), 83 deletions(-) =20
>=20
> This is a very convoluted fix; it is well explained but the number
> of patches going into stable and the complexity of it make me ask
> how confident you are this won't trigger any regressions.
>=20
> It is just a heads-up to make you think whether it is better to
> hold the stable tags till we are confident enough.
>=20
> Please let me know.

Lorenzo,

you are probably right here. It would be better to have this in upstream
for some time and let people test it, and only afterward send it into
stable.

Let's remove the Fixes tag. We will send this into stable after it is a
little tested.

Marek
