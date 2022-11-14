Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDC62751B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 05:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiKNEAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Nov 2022 23:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiKNEAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Nov 2022 23:00:13 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6612AFD
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 20:00:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id e13so6556160edj.7
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 20:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t32Vju5XIgtrJ4jgA9bvoDKcNVYN0sL+9zOrih8YQXY=;
        b=CMA5IyCyGJHr/SsizAbheGNFPyx9JCmnZqxdXIktai3oYWi5BkddRDpuDHV2etUgLZ
         b/RqScmBCWFae1tZja4l50ohZVPHtyTC9X2N37rzguLHL8PRT96Jqs8HT9rF2CWUISbN
         ZJtkcz+Xh06JRi0ndmcnEkN8gk+1wYE+DCQF/T2Db9h128kPVCPsHwowMPpMS/t3Days
         Up1WZRTWb6fC8Wu/ZEbGJhCH3HRSSq4lUDMRqiR4926bgi2lltptBiw68lodAGyLJPKZ
         gh2Lr1ptl5XDE/7GObR3Hp3S4gs8r0WmK4sXrHR/DuneK1hNa2VRY8cMGDj9XkXimx45
         Ap+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t32Vju5XIgtrJ4jgA9bvoDKcNVYN0sL+9zOrih8YQXY=;
        b=b8b0cPy0GRgMFH5tdk6lD5YMpFQPs/YxgMlxuU+x8WwylqSEAOeBSw+EbZ9kc61KkL
         KU+2RM2HRCoDGdC9P024dhfQzn/+o1TH8HpZZ3C6jPUSuzc7TSr/uXhF38Mhpbm0L2HV
         pOomlwIDVpD4kEFkCIMo5QlBQbJXIb5l2e6c1qWT1Qpl08TqJ1j3s1HVAT585lCjdiGz
         6Kgnv9QAsocsGC2FwVaEqnxXylryHu31+Mw2EfSQNH2t3aNSyXQRPy9xj8mRwnj5J69S
         ziV5tHfVzScjUCyO52Sa0stHXte6MWb5PIUDT8N517M00oPBJrJRpeorrhWx8l0gKlQo
         3g6w==
X-Gm-Message-State: ANoB5pkihfBUk19Q6FTAEOV6hE6D+URO6x+WsNVcXnBAw7ddGZWiChpc
        43lX08n1leLvNbbaz2Z+XHVW0QaLKyTV+Xj3X4980w==
X-Google-Smtp-Source: AA0mqf49FgaOQeHHb4SP9TWrnK2IZIiBDuO6awnQb988Y/hSJ9phcAa7GbZQcewAyTneCWB7a+mVnYTxAH6NEg6LVMc=
X-Received: by 2002:a50:d485:0:b0:461:af68:9bcd with SMTP id
 s5-20020a50d485000000b00461af689bcdmr10222403edi.67.1668398408026; Sun, 13
 Nov 2022 20:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20221108222944.GA504625@bhelgaas> <20221109173454.GA567052@bhelgaas>
In-Reply-To: <20221109173454.GA567052@bhelgaas>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Mon, 14 Nov 2022 13:59:56 +1000
Message-ID: <CA+aJhH2EEE_n5T0PAcOr5RQbfOzEKF67ckcWMTbP_NesQ5ggtw@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Nov 2022 at 03:34, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Maciej for similar retrain issue]
>
> On Tue, Nov 08, 2022 at 04:29:44PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jun 02, 2022 at 06:55:44AM +0000, Nathan Rossi wrote:
> > > From: Nathan Rossi <nathan.rossi@digi.com>
> > >
> > > When retraining the link either the child or the parent device may ha=
ve
> > > the data link layer state machine of the respective devices move out =
of
> > > the active state despite the physical link training being completed.
> > > Depending on how long is takes for the devices to return to the activ=
e
> > > state, the device may not be ready and any further reads/writes to th=
e
> > > device can fail.
> > >
> > > This issue is present with the pci-mvebu controller paired with a dev=
ice
> > > supporting ASPM but without advertising the Slot Clock, where during
> > > boot the pcie_aspm_cap_init call would cause common clocks to be made
> > > consistent and then retrain the link. However the data link layer wou=
ld
> > > not be active before any device initialization (e.g. ASPM capability
> > > queries, BAR configuration) causing improper configuration of the dev=
ice
> > > without error.
> > >
> > > To ensure the child device is accessible, after the link retraining u=
se
> > > pcie_wait_for_link to perform the associated state checks and any nee=
ded
> > > delays.
> > >
> > > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> > > ---
> > >  drivers/pci/pcie/aspm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index a96b7424c9..4b8a1810be 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(stru=
ct pcie_link_state *link)
> > >             reg16 &=3D ~PCI_EXP_LNKCTL_CCC;
> > >     pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> > >
> > > -   if (pcie_retrain_link(link))
> > > +   /* Retrain link and then wait for the link to become active */
> > > +   if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
> >
> > pcie_retrain_link() waits for PCI_EXP_LNKSTA_LT (Link Training) to be
> > cleared, which means the LTSSM has exited the Configuration/Recovery
> > state.  pcie_wait_for_link() waits for PCI_EXP_LNKSTA_DLLLA (Data Link
> > Layer Link Active) to be set, which means the link is in DL_Active.
> >
> > I don't see an explicit procedure in the spec for determining when
> > a link retrain is complete, but from PCIe r6.0, sec 6.2.11 (DPC):
> >
> >   After software releases the Downstream Port from DPC, the Port=E2=80=
=99s
> >   LTSSM must transition to the Detect state, where the Link will
> >   attempt to retrain. Software can use Data Link Layer State Changed
> >   interrupts, DL_ACTIVE ERR_COR signaling, or both, to signal when the
> >   Link reaches the DL_Active state again.
> >
> > and sec 6.6:
> >
> >   On the completion of Link Training (entering the DL_Active state,
> >   see Section 3.2), a component must be able to receive and process
> >   TLPs and DLLPs.
> >
> > The only use mentioned in the spec for the Link Training bit is the
> > implementation note in sec 7.5.3.7 about avoiding race conditions when
> > using the Retrain Link bit, where software should poll Link Training
> > until it returns to zero before setting the Retrain Link bit to change
> > link parameters.
> >
> > And I think you're absolutely right that what we *want* here is the
> > data link layer DL_Active state, not just the link layer L0 state.
> >
> > This all makes me think that checking the Link Training bit might be
> > the wrong thing to begin with.
> >
> > Of course, the Data Link Layer Link Active bit wasn't added until PCIe
> > r1.1, and even now it's optional.  Without it, I don't know if there's
> > a way to make sure the link is in DL_Active.

My understanding is there is no way to check for the DL_Active state
on these devices. Which is why pcie_wait_for_link_delay uses a fixed
delay in that case.

> >
> > Maybe pcie_retrain_link() should wait for Data Link Layer Link Active
> > if it is supported, and use the existing behavior of waiting for Link
> > Training to be cleared otherwise?

I think it still makes sense for pcie_retrain_link to wait for the
Link Training bit, since it is typical for the retraining to never go
to a LTSSM state where the LinkUp is 0 (e.g. Recovery ->
Configuration), thus the Data Link Layer will stay in DL_Active. But
it is still important to wait for the link training to complete in
that case, but also because the training may not cause the Data Link
state to change immediately.

However since DLLLA reporting is optional, it is probably ideal if the
pcie_retrain_link only calls pcie_wait_for_link if reporting is
available? This would avoid the fixed delay of 1s upon link retraining
for devices without reporting, which is unnecessary in the majority of
cases.

Thanks,
Nathan


>
> Nathan, I meant to cc you on this thread, which is doing something
> very similar.  Just FYI:
>
> https://lore.kernel.org/all/alpine.DEB.2.21.2209130050380.60554@angie.orc=
am.me.uk/
