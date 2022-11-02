Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38E615DAF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 09:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKBIbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 04:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKBIbS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 04:31:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD66248C2
        for <linux-pci@vger.kernel.org>; Wed,  2 Nov 2022 01:31:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d26so43238681eje.10
        for <linux-pci@vger.kernel.org>; Wed, 02 Nov 2022 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDm9tTOGqq33c/OJ9p8krRntRWFT8P4+dZq4i09Xj6A=;
        b=iokDAwOEKIbW970m7zGF/56C0wURNahX2Sdi9RmCTYE/2LpdXu8WhVWx5Nalm6yf/8
         FDA8B/kVWDQSFpIO+p3nVDeqPU3xM7msp/vNuB7hzm9GoZ8sf7ZCJmQ8ST8LtjlhlL5j
         ytuNEjEqn9K4Dj7drdcAETo/1VCOCHBf53RhRgZEeK0R3VYxh336X8WblI3m+jtPHGrC
         HeSrE98l4enROXQwWcnPu/KBVR9kV1nzVPm61YOhbSM/09fa3KFwpqDdWso5aIScBKiy
         a/mLMD5pjB/j4+M+4LXHbJy+BsvuRZjBpTf0lq5ZGksOsXNEDHAgYb57Mbc5kUR0y+tG
         hyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDm9tTOGqq33c/OJ9p8krRntRWFT8P4+dZq4i09Xj6A=;
        b=C/xorClBUlOP1GAOPXoWmW7W4QEGwAphHBQwJoO/TXllETDbwIeV5OAcpPuMyG0T/r
         2bCJwKmHAx1c22uW7l2Inyao6PS1jBAH/x+PGjIhuZsxEV0jNMvRWNv4hzvObYK8Gzup
         8V66b61L4IzrO/i7BWxvN2SjXMnQK6xUwG154qQpYbqbPTDzVnstC3x0k7XcdZXzDSsr
         29F2+G5ICs90t3hsCYYT0EEBIBd92zOAVknoskzsRHnWeCTkoDzYF1GBYek695kgiZBd
         yrkGfG3g7lXQFczccAzOzBHf4syVYmpVzNbfPqLMqNUUXAEG1QtQYoQp72nLDdr8XGQK
         dI0Q==
X-Gm-Message-State: ACrzQf2js/UR+Ow1o4E+MOecowpR9JG39VRIXjSYl2HQVBBrH+6PEBod
        CaZ5CfnpnEp8N6z4q38LvRhGtZQMn7GWMjh7WEy1zgeVpR42xw==
X-Google-Smtp-Source: AMsMyM4Wlkgm63ReSpBURV3XOq+44U6tTaT4EEuKQKgeYwwcmG/mJs4ovHvGEioWWSqKZPC8e4foGrIbZ2s0dXuBd90=
X-Received: by 2002:a17:907:3c81:b0:77a:327a:815f with SMTP id
 gl1-20020a1709073c8100b0077a327a815fmr22874433ejc.422.1667377875641; Wed, 02
 Nov 2022 01:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220602065544.2552771-1-nathan@nathanrossi.com> <20221002175648.jzxcvka46vylbs2d@pali>
In-Reply-To: <20221002175648.jzxcvka46vylbs2d@pali>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Wed, 2 Nov 2022 18:31:04 +1000
Message-ID: <CA+aJhH2kbAFYOSkDpxO4_1ZPfJmd11v6tmz2yAL-PO2irQWZ0w@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
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

On Mon, 3 Oct 2022 at 03:56, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> On Thursday 02 June 2022 06:55:44 Nathan Rossi wrote:
> > From: Nathan Rossi <nathan.rossi@digi.com>
> >
> > When retraining the link either the child or the parent device may have
> > the data link layer state machine of the respective devices move out of
> > the active state despite the physical link training being completed.
> > Depending on how long is takes for the devices to return to the active
> > state, the device may not be ready and any further reads/writes to the
> > device can fail.
> >
> > This issue is present with the pci-mvebu controller paired with a devic=
e
> > supporting ASPM but without advertising the Slot Clock, where during
> > boot the pcie_aspm_cap_init call would cause common clocks to be made
> > consistent and then retrain the link. However the data link layer would
> > not be active before any device initialization (e.g. ASPM capability
> > queries, BAR configuration) causing improper configuration of the devic=
e
> > without error.
>
> There is the known issue in marvell pcie controllers. They completely
> drop the link for PCIe GEN1 cards when Target Link Speed (Link Control2)
> in Root Port is configured to 5.0 GT/s or higher value and OS issues
> Retrain Link (Link Control).

In the configuration we are having issues with, the downstream device
is indeed a 2.5GT downstream, and the upstream is configured to
support 2.5GT and 5GT (Armada 385). So it does make sense that this
known issue would apply. I tested setting the target speed to 2.5GT
within mvebu_pcie_setup_hw before the retraining occurs, and it does
resolve the retraining delay/link drop. So this issue is indeed the
problem we are having. Is this behaviour mentioned in any errata?

>
> I think the proper way should be to workaround root of this issue by
> programming Target Link Speed in Link Control2 register to required
> value, instead of hacking couple of other places which are just
> implication of that issue...

By programming the Target Link Speed, are you referring to programming
the value like other controller drivers do with dtb configuration?
Relying on this would be problematic for our design (mixed downstream
link speed variants). Does it make more sense to set the Target Link
Speed when the retrain bit is being set in Link Control (e.g. in the
mvebu_pci_bridge_emul_pcie_conf_write function) essentially preventing
the retraining from causing the link to drop only when the issue is
expected to present itself (Link Status at 2.5GT)?

Thanks,
Nathan

>
> I can reproduce it for example with Qualcomm Atheros ath9k/ath10k wifi
> cards which have another issue that they go into "broken" state when
> in-band reset (e.g. pcie hot reset or pcie link down) is issues multiple
> times without longer delay.
>
> These two bugs (first in marvell pcie controller and second in wifi
> card) cause that setting kernel ASPM cause disappearing card from bus
> until cpu/board reset (or pcie warm reset; if board supports it at
> runtime without going to POR).
>
> I guess you are just observing result of this issue here.
>
> > To ensure the child device is accessible, after the link retraining use
> > pcie_wait_for_link to perform the associated state checks and any neede=
d
> > delays.
> >
> > Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b7424c9..4b8a1810be 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct=
 pcie_link_state *link)
> >               reg16 &=3D ~PCI_EXP_LNKCTL_CCC;
> >       pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> >
> > -     if (pcie_retrain_link(link))
> > +     /* Retrain link and then wait for the link to become active */
> > +     if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
> >               return;
> >
> >       /* Training failed. Restore common clock configurations */
> > ---
> > 2.36.1
