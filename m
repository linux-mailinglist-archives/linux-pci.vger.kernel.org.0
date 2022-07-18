Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1612A578923
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiGRSCH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbiGRSCG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 14:02:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE952E9F6;
        Mon, 18 Jul 2022 11:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 502AAB816ED;
        Mon, 18 Jul 2022 18:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914E7C341C0;
        Mon, 18 Jul 2022 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658167323;
        bh=JmgzQ4GBBNdx5oxKuBYu/AkqxPX3wUd1Yb7MhLqzvMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxvKwN2xYu23esvDDqWRMNKYrajgfy+LP3noFTgVD3zCILBb6RrCDw6eJo1S/uLD0
         0mvF8Ax7SSuMOdKdO/fMlkYJeq5RbA20ZmU3GwstPBy+LKpJzW9B0YMnbNSvq5PcsP
         wujN/63fJbsTzQeVqMG5Haw8vbUfuhRgGpfjLvsCOd/SE9c9R8H3zr6qqoa0JjeSrg
         0EMyVCWCZQ0loDpH+bsDc7M9HbSIQs8132Pq1RmjfAqfowzvf7h6c/EMbq0a4qyJyQ
         UvQ+UdrW7t3UTslly0LBooN4BuOZM7VoMcRqgR/DjkpDkQjyT27zn7xpPkV/8bfHvx
         BnwgRZSks61Og==
Received: by pali.im (Postfix)
        id 8012311AA; Mon, 18 Jul 2022 20:01:59 +0200 (CEST)
Date:   Mon, 18 Jul 2022 20:01:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
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
Message-ID: <20220718180159.feglhlmu7a75axgv@pali>
References: <CA+-6iNwKDYzJ2F5ns-EKV0pMvYwUzPhzzmb7mA0pNp2k1UWMzw@mail.gmail.com>
 <20220718170528.GA1426959@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220718170528.GA1426959@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 18 July 2022 12:05:28 Bjorn Helgaas wrote:
> On Mon, Jul 18, 2022 at 09:37:08AM -0400, Jim Quinlan wrote:
> > On Mon, Jul 18, 2022 at 9:11 AM Pali Rohár <pali@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > On Saturday 16 July 2022 18:24:49 Jim Quinlan wrote:
> > > > @@ -948,6 +941,40 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
> > > >       if (pcie->gen)
> > > >               brcm_pcie_set_gen(pcie, pcie->gen);
> > > >
> > > > +     /* Don't advertise L0s capability if 'aspm-no-l0s' */
> > > > +     aspm_support = PCIE_LINK_STATE_L1;
> > > > +     if (!of_property_read_bool(pcie->np, "aspm-no-l0s"))
> > > > +             aspm_support |= PCIE_LINK_STATE_L0S;
> > > > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > > +     u32p_replace_bits(&tmp, aspm_support,
> > > > +             PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> > > > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> > > > +
> > > > +     /*
> > > > +      * For config space accesses on the RC, show the right class for
> > > > +      * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > > > +      */
> > > > +     tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > > +     u32p_replace_bits(&tmp, 0x060400,
> > >
> > > There is already macro PCI_CLASS_BRIDGE_PCI_NORMAL, so please use it
> > > instead of magic constant.
> > 
> > Will do, thanks.
> 
> I can fix that up locally.

Great!

I did git grep on recent master branch and found another candidates with
magic numbers which refers to PCI_CLASS_BRIDGE_PCI_NORMAL:

arch/mips/pci/pci-mt7620.c:     pcie_w32(0x06040001, RALINK_PCI0_CLASS);
arch/mips/pci/pci-rt3883.c:     rt3883_pci_w32(rpc, 0x06040001, RT3883_PCI_REG_CLASS(1));
arch/powerpc/platforms/4xx/pci.c:               out_le32(mbase + 0x208, 0x06040001);
drivers/pci/controller/pcie-brcmstb.c:  u32p_replace_bits(&tmp, 0x060400,

(class code is stored in upper 24 bits of 32-bit register, so it makes
sense that on lowest 8 bits is something more - 0x01)

What do you think? Does it make sense to send patch which replace above
hex numbers by macros?

> > > I introduced it recently in commit:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=904b10fb189cc15376e9bfce1ef0282e68b0b004
> > >
> > > > +                       PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
> > > > +     writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
> > > > +
> > > > +     return 0;
> > > > +}
> 
> 
> 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
