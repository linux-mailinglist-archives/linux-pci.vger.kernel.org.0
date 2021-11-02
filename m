Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8544383C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 23:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhKBWK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 18:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhKBWK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 18:10:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11F0560FC2;
        Tue,  2 Nov 2021 22:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635890901;
        bh=2a+lyYPUaEcrjjg8k0Av2b+AMGjDBJKVWu/NqoemEOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfimlBtriqzUYflzNWg5DRXRw7oKN3y28RiALiHogHyRAzcqphl/ryXMO1RwLVK7Q
         rmkWugWiGXZAOOTDuhHkymiwuikz0Mld/s0TT2sRfnUMu4hb2xxlZNka3pbx6r8Kz0
         ptCfQFpvnNkH3zXpwQYyekGZr71WdRSWgGYRP1VIZLRhFzpQH3mECMyzm9u2C/7M2Z
         9dlaHbBIt5MZdoqTt8Fe/woV4Agou2Xtzw6MOIXWaPffUOFyKe2zxgo3Yrlx3AGoS6
         R5n0M9cshLQKpMy3KyKRPlSyfCqODkcHm2NZjllRtTR2CmEfg4kQ36Uf4spgylKqzV
         iu8mEQ/INkpyg==
Received: by pali.im (Postfix)
        id B3489A41; Tue,  2 Nov 2021 23:08:18 +0100 (CET)
Date:   Tue, 2 Nov 2021 23:08:18 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v15 04/13] PCI: kirin: Add support for bridge slot DT
 schema
Message-ID: <20211102220818.rtdzad2bz5yiqiim@pali>
References: <bb391a0e0f0863b66e645048315fab1a4f63f277.1634812676.git.mchehab+huawei@kernel.org>
 <20211102160612.GA612467@bhelgaas>
 <20211102174415.58cd3d4f@sal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102174415.58cd3d4f@sal.lan>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 02 November 2021 17:44:15 Mauro Carvalho Chehab wrote:
> Hi Bjorn,
> 
> Em Tue, 2 Nov 2021 11:06:12 -0500
> Bjorn Helgaas <helgaas@kernel.org> escreveu:
> 
> > > +
> > > +	/* Per-slot clkreq */
> > > +	int		n_gpio_clkreq;
> > > +	int		gpio_id_clkreq[MAX_PCI_SLOTS];
> > > +	const char	*clkreq_names[MAX_PCI_SLOTS];  
> >
> > I think there's been previous discussion about this, but I didn't
> > follow it, so I'm just double-checking that this is what we want here.
> > 
> > IIUC, this (MAX_PCI_SLOTS, "hisilicon,clken-gpios") applies to an
> > external PEX 8606 bridge, which seems a little strange to be
> > hard-coded into the kirin driver this way.
> > 
> > I see that "hisilicon,clken-gpios" is optional, but what if some
> > platform connects all 6 lanes?  What if there's a different bridge
> > altogether?
> > 
> > I'll assume this is actually the way we want thing unless I hear
> > otherwise.

I proposed alternative approach how to define it:
https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/

Reason for a my new proposal is that currently there is lot of
duplicated code in every native pcie controller driver and every driver
is solving same issues by ad-doc code which is not related to host
bridge / controller itself. Like configuration of devices (e.g. PCIe
switch) to the host bridge itself. That is why I send also another RFC:
https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/

I would be happy if we can discuss on them for future drivers. At least
if my proposals make sense or completely not.

> Yes, there was past discussions about that with Rob, with regards
> to how the DT would represent it, which got reflected at the code.
> At the end, it was decided to just add a single property inside PCIe:
> 
> 
> 		pcie@f4000000 {
>                         compatible = "hisilicon,kirin970-pcie";
> ...
>                         hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
>                                                 <&gpio20 6 0>;
> 
> I don't think this is a problem, as, if some day another bridge would
> need a larger number of slots, it is just a matter of changing the
> number at the MAX_PCI_SLOTS, as this controls only the size of the array
> (and the check for array overflow when parsing the properties).

It is not a problem for this particular pcie controller. And really
MAX macro can be increased in this driver if there is need for a larger
number of slots. It should work fine.


But if there are going to be added more boards with different hw
topology or even with different pcie controllers then there would be new
issues. E.g. how to figure out which gpio belongs to which slot? Or even
hot-plugging support? Port belongs to either Root Port device or to
Downstream device, which does not have to be at root level. It creates
tree topology and therefore it is not possible to represent GPIOs in
simple list, like it is for kirin DTS. Generally you cannot say to which
slot belongs second GPIO defined in reset-gpios list.

That is why I'm saying it needs some better structure and prepare pci
core code for it. So native pci controller drivers do not have to invent
ad-hoc solutions for specific board setups.

I really think that information about PCIe switch topology should be in
DTS and it should work independently of PCIe controller driver, without
need for board-specific or PCIe-switch-specific ad-hoc hooks in host
bridge drivers, like it is currently.

Bjorn, what do you think?
