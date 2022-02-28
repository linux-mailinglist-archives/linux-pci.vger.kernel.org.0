Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560194C7160
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237135AbiB1QLs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 11:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiB1QLr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 11:11:47 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251A8565D;
        Mon, 28 Feb 2022 08:11:04 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BC8051C000B;
        Mon, 28 Feb 2022 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646064662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsRzRoAaLpHY0fxOVpMA6s3Oa6DZiUQyKn9vN7ceT1Y=;
        b=VIUWnD2RvZ4DPwtXXa6fm1PhnHV0YLG2B7/Bu5GETiK9spUhMufNObNNaUacgKYiSHGhNX
        kxPJ3G2uyvMeaxeH2b9ykLkkt0BgqcedniR3Gfles+hl2lZuEPzIICak/TDvCdftW4bumY
        L3qb3xVsP6NImgKn1UmTTLfMkb2itMdwJhgX0lVm0GdHQyONQa/7zIcknWdBCjbRNE8rJE
        37XAL7UE7BHQu3oyzrNEbXKudc9GLzMTPECH7f1ptolQ0MMyWGFZRG45mGktaWTvUBjZln
        pgH//xJFs1+EW7PlPtMYF8jZWZyAzD5cK4fgvXiAFeVMLslctCNOXpDCIdq8+g==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v4 00/12] PCI: mvebu: subsystem ids, AER and INTx
In-Reply-To: <20220222161854.7oot5v6xlw2wzmsc@pali>
References: <20220222155030.988-1-pali@kernel.org>
 <164554589988.5595.5091384618177225445.b4-ty@arm.com>
 <20220222161143.6ryghgtfmhnmhpmz@pali> <20220222161539.GA20114@lpieralisi>
 <20220222161854.7oot5v6xlw2wzmsc@pali>
Date:   Mon, 28 Feb 2022 17:11:01 +0100
Message-ID: <87h78j0y5m.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> + Gregory
>
> On Tuesday 22 February 2022 16:15:39 Lorenzo Pieralisi wrote:
>> On Tue, Feb 22, 2022 at 05:11:43PM +0100, Pali Roh=C3=A1r wrote:
>> > On Tuesday 22 February 2022 16:06:20 Lorenzo Pieralisi wrote:
>> > > On Tue, 22 Feb 2022 16:50:18 +0100, Pali Roh=C3=A1r wrote:
>> > > > This patch series extends pci-bridge-emul.c driver to emulate PCI =
Subsystem
>> > > > Vendor ID capability and PCIe extended capabilities. And then impl=
ement
>> > > > in pci-mvebu.c driver support for PCI Subsystem Vendor IDs, PCIe A=
ER
>> > > > registers, support for legacy INTx interrupts, configuration for X=
1/X4
>> > > > mode and usage of new PCI child_ops API.
>> > > >=20
>> > > > Changes in v4:
>> > > > * rebased on c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
>> > > >=20
>> > > > [...]
>> > >=20
>> > > I can't apply dts changes, patch 12 should go via the arm-soc tree.
>> >=20
>> > Gregory already wrote about this dts change:
>> > https://lore.kernel.org/linux-pci/87tud1jwpr.fsf@BL-laptop/
>> > "So the easier is to let merge it through the PCI subsystem with the
>> > other patches from this series."
>> >=20
>> > Are there any issues with applying this dts change via pci tree?
>>=20
>> I don't usually take dts changes through the PCI tree since they
>> can conflict with arm-soc, that's the issue - dts changes should
>> be managed by platform maintainers.
>
> Gregory, could you please take patch 12/12?
> https://lore.kernel.org/linux-pci/20220222155030.988-13-pali@kernel.org/
> You have already Acked-by (see above previous link)


Applied on mvebu/dt

let's hope the PCI branch will be merged before the ARM branch.

Thanks,

Gregory


>
>> Thanks,
>> Lorenzo
>>=20
>> > > Applied the others to pci/mvebu, thanks.
>> > >=20
>> > > [01/12] PCI: pci-bridge-emul: Re-arrange register tests
>> > >         https://git.kernel.org/lpieralisi/pci/c/c453bf6f9b
>> > > [02/12] PCI: pci-bridge-emul: Add support for PCIe extended capabili=
ties
>> > >         https://git.kernel.org/lpieralisi/pci/c/c0bd419732
>> > > [03/12] PCI: pci-bridge-emul: Add support for PCI Bridge Subsystem V=
endor ID capability
>> > >         https://git.kernel.org/lpieralisi/pci/c/3767a90242
>> > > [04/12] dt-bindings: PCI: mvebu: Add num-lanes property
>> > >         https://git.kernel.org/lpieralisi/pci/c/26b982ca83
>> > > [05/12] PCI: mvebu: Correctly configure x1/x4 mode
>> > >         https://git.kernel.org/lpieralisi/pci/c/2a81dd9fd9
>> > > [06/12] PCI: mvebu: Add support for PCI Bridge Subsystem Vendor ID o=
n emulated bridge
>> > >         https://git.kernel.org/lpieralisi/pci/c/e3e13c9135
>> > > [07/12] PCI: mvebu: Add support for Advanced Error Reporting registe=
rs on emulated bridge
>> > >         https://git.kernel.org/lpieralisi/pci/c/2b6ee04c0a
>> > > [08/12] PCI: mvebu: Use child_ops API
>> > >         https://git.kernel.org/lpieralisi/pci/c/c099c2a761
>> > > [09/12] dt-bindings: PCI: mvebu: Update information about intx inter=
rupts
>> > >         https://git.kernel.org/lpieralisi/pci/c/0124989220
>> > > [10/12] PCI: mvebu: Fix macro names and comments about legacy interr=
upts
>> > >         https://git.kernel.org/lpieralisi/pci/c/d00ea94e62
>> > > [11/12] PCI: mvebu: Implement support for legacy INTx interrupts
>> > >         https://git.kernel.org/lpieralisi/pci/c/ec07526264
>> > >=20
>> > > Thanks,
>> > > Lorenzo

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
