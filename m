Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0850F59BDAC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 12:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiHVKhT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 06:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiHVKhT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 06:37:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F802FFC0
        for <linux-pci@vger.kernel.org>; Mon, 22 Aug 2022 03:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93678B81014
        for <linux-pci@vger.kernel.org>; Mon, 22 Aug 2022 10:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF61C433D6;
        Mon, 22 Aug 2022 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661164635;
        bh=JrfXDin8nwR7I+erzg9qgAqZDGtE50sM8ODJ231ieO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=myPmnpl1Z70yXCl2pS5+rZhgfrvI7XGa4tddDWm31vw3tgwIblKgrqK0/1V9TS0Jf
         D2gR/H/os2H5tMS5ugaPLC8MjPlOW8g25uc/lfswkNaEmzRshXjQnL8FTv1QR/iXMR
         sJLvD3fi8vv1PJbdwL832wyrgJWmgxp1K7kXuPrTyEtH7rerSSOEEUFAfDEn+XLqUk
         OOHPtOVBHzsNH93FVE1Vmm08ti5xfysqx9Abx/Zj0ZJG+bEwZ2gnfQlr7JoC4Bv2R8
         Jq4Ke1BeX1ZXTfYyGEnEYohb7Jdr1MIr2eS1Uz5Hosrm7/KU+WzhR4uSUbDmadiKcN
         NuNd4YSuo3HwA==
Date:   Mon, 22 Aug 2022 12:37:09 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] PCI: pciehp: Enable DLLSC interrupt only if
 supported
Message-ID: <20220822123709.5a014034@thinkpad>
In-Reply-To: <20220821124621.GA23239@wunner.de>
References: <20220818135140.5996-1-kabel@kernel.org>
        <20220818135140.5996-2-kabel@kernel.org>
        <20220821124621.GA23239@wunner.de>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 21 Aug 2022 14:46:21 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Thu, Aug 18, 2022 at 03:51:30PM +0200, Marek Beh=C3=BAn wrote:
> > Don't enable Data Link Layer State Changed interrupt if it isn't
> > supported.
> >=20
> > Data Link Layer Link Active Reporting Capable bit in Link Capabilities
> > register indicates if Data Link Layer State Changed Enable is supported.
> >=20
> > Although Lukas Wunner says [1]
> >   According to PCIe r6.0, sec. 7.5.3.6, "For a hot-plug capable
> >   Downstream Port [...], this bit must be hardwired to 1b."
> > the reason we want this is because of the pci-bridge-emul driver, which
> > emulates a bridge, but does not support asynchronous operations (since
> > implementing them is unneeded and would require massive changes to the
> > whole driver). Therefore enabling DLLSC unconditionally makes the
> > corresponding bit set only in the emulated configuration space of the
> > pci-bridge-emul driver, which
> > - results in confusing information when dumping the config space (it
> >   says that the interrupt is not supported but enabled), which may
> >   confuse developers when debugging PCIe issues,
> > - may cause bugs in the future if someone adds code that checks whether
> >   DLLSC is enabled and then waits for the interrupt. =20
>=20
> Honestly I'm not sure this change adds value or is necessary:
>=20
> advk_pci_bridge_emul_pcie_conf_read() unconditionally sets the DLLLARC
> bit, so the change doesn't have any effect for aardvark.

This is the status now, but it wasn't always so. The support for
that was added in one of the previous batches of aardvark's changes.

> Same for mvebu_pci_bridge_emul_pcie_conf_read().
> There are no other drivers using pci-bridge-emul.

But there may be future users which won't support it and we were just
thinking this could spare some confusion to the developers, since Pali
spent nontrivial time on this when developing/debuggin aardvark last
year.

> Apart from that, it is legal to set the DLLSCE bit even on PCIe r1.0,
> which did not define Data Link Layer Link Active Reporting yet.
> (It defined the bit RsvdP.)  Thus there's no reason for developers
> to be confused.
>=20
> We're also never depending *exclusively* on DLLSC events in pciehp,
> we always react to either of PDC or DLLSC, whichever comes first.
> So I don't see enabling DLLSCE on unsupporting hardware as a
> potential source of error.
>=20
>=20
> > [1] https://www.spinics.net/lists/linux-pci/msg124727.html =20
>=20
> Please always use lore.kernel.org links as they will likely outlast
> 3rd party archives:
>=20
> https://lore.kernel.org/linux-pci/20220509034216.GA26780@wunner.de/

Will do.

> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c =20
> [...]
> > +	pcie_capability_read_dword(ctrl_dev(ctrl), PCI_EXP_LNKCAP, &link_cap);
> > + =20
>=20
> Unfortunately this new version of the patch does not address
> one of my comments on the previous version:
>=20
> "The Data Link Layer Link Active Reporting Capable bit is cached
> in ctrl_dev(ctrl)->link_active_reporting.  Please use that
> instead of re-reading it from the register."
>=20
> (Verbatim quote from the above-linked e-mail.)

Sorry, I forgot abbout this one.

> > --- a/drivers/pci/hotplug/pnv_php.c
> > +++ b/drivers/pci/hotplug/pnv_php.c
> > @@ -841,6 +841,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *p=
hp_slot, int irq)
> >  	struct pci_dev *pdev =3D php_slot->pdev;
> >  	u32 broken_pdc =3D 0;
> >  	u16 sts, ctrl;
> > +	u32 link_cap;
> >  	int ret;
> > =20
> >  	/* Allocate workqueue */
> > @@ -874,17 +875,21 @@ static void pnv_php_init_irq(struct pnv_php_slot =
*php_slot, int irq)
> >  		return;
> >  	}
> > =20
> > +	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
> > +
> >  	/* Enable the interrupts */
> >  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
> >  	if (php_slot->flags & PNV_PHP_FLAG_BROKEN_PDC) {
> >  		ctrl &=3D ~PCI_EXP_SLTCTL_PDCE;
> > -		ctrl |=3D (PCI_EXP_SLTCTL_HPIE |
> > -			 PCI_EXP_SLTCTL_DLLSCE);
> > +		ctrl |=3D PCI_EXP_SLTCTL_HPIE;
> >  	} else {
> >  		ctrl |=3D (PCI_EXP_SLTCTL_HPIE |
> > -			 PCI_EXP_SLTCTL_PDCE |
> > -			 PCI_EXP_SLTCTL_DLLSCE);
> > +			 PCI_EXP_SLTCTL_PDCE);
> >  	}
> > +	if (link_cap & PCI_EXP_LNKCAP_DLLLARC)
> > +		ctrl |=3D PCI_EXP_SLTCTL_DLLSCE;
> > +	else
> > +		ctrl &=3D ~PCI_EXP_SLTCTL_DLLSCE;
> >  	pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl); =20
>=20
> Note that the pnv_php.c driver is relying on DLLSC here if PDC
> is broken (see PNV_PHP_FLAG_BROKEN_PDC).  By not enabling DLLSC,
> you may break hotplug altogether.

But it would only break if those controllers did not report DLLLARC,
right?

> pnv_php.c is a PowerPC-specific hotplug controller, but you're not
> cc'ing the driver's maintainers, which are:
>=20
> $ scripts/get_maintainer.pl drivers/pci/hotplug/pnv_php.c
> Michael Ellerman <mpe@ellerman.id.au> (supporter:LINUX FOR POWERPC (32-BI=
T AND 64-BIT))
> Nicholas Piggin <npiggin@gmail.com> (reviewer:LINUX FOR POWERPC (32-BIT A=
ND 64-BIT))
> Christophe Leroy <christophe.leroy@csgroup.eu> (reviewer:LINUX FOR POWERP=
C (32-BIT AND 64-BIT))
> linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64=
-BIT))

Will do.

Anyway, Lorenzo, this patch can be skipped now, the other patches do
not depend on it.

Marek
