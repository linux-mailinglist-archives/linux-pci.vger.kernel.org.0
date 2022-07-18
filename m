Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C765578805
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiGRRFe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRRFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 13:05:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D032B622;
        Mon, 18 Jul 2022 10:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A022B815EB;
        Mon, 18 Jul 2022 17:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D44C341C0;
        Mon, 18 Jul 2022 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658163930;
        bh=NpNHG6pmchwQ409hpbZwAVUVi/yVIIYsl+KgN+lpnlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AE38lBIHjYZUAcQjGP65ivuC3zFT70BRn55zJRJLO+EDqJWv6XvD2Aln3csyBv2yj
         ALPdR3ZWOthySxaF3vXDNZkC1+EtUdGVw5iN1p9tp/hy+oujtxakaOUPnZ7izPhVdZ
         gyU51VqfZkG3ukwoLt8aHK/ZrlKuynUidMW2w9n9z9fQ77Tx9rfkXrm4wKemYtzyjs
         41fialOYtviXGgdOS7MgCD6BpYl3FpWYHS4HBXWfdtXyzysCC5Z1rI3Q8OZhzX1kEk
         PaUj43SnrdYpqAAMyuYmYpw8bCEau106BLimuubh1X7OfJW5IeoBNup4wyLSyGYdLU
         hl/M49kndjenQ==
Date:   Mon, 18 Jul 2022 12:05:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] PCI: brcmstb: Split brcm_pcie_setup() into two
 funcs
Message-ID: <20220718170528.GA1426959@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwKDYzJ2F5ns-EKV0pMvYwUzPhzzmb7mA0pNp2k1UWMzw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 18, 2022 at 09:37:08AM -0400, Jim Quinlan wrote:
> On Mon, Jul 18, 2022 at 9:11 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > Hello!
> >
> > On Saturday 16 July 2022 18:24:49 Jim Quinlan wrote:
> > > @@ -948,6 +941,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > >       if (pcie->gen)
> > >               brcm_pcie_set_gen(pcie, pcie->gen);
> > >
> > > +     /* Don't advertise L0s capability if 'aspm-no-l0s' */
> > > +     aspm_support = PCIE_LINK_STATE_L1;
> > > +     if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> > > +             aspm_support |= PCIE_LINK_STATE_L0S;
> > > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > +     u32p_replace_bits(&tmp, aspm_support,
> > > +             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > +
> > > +     /*
> > > +      * For config space accesses on the RC, show the right class for
> > > +      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > > +      */
> > > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > +     u32p_replace_bits(&tmp, 0x060400,
> >
> > There is already macro PCI_CLASS_BRIDGE_PCI_NORMAL, so please use it
> > instead of magic constant.
> 
> Will do, thanks.

I can fix that up locally.

> > I introduced it recently in commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=904b10fb189cc15376e9bfce1ef0282e68b0b004
> >
> > > +                       PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> > > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > +
> > > +     return 0;
> > > +}



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

