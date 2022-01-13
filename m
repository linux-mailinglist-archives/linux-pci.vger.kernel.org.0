Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6979548DD16
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 18:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbiAMRpO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 12:45:14 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55727 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbiAMRpN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 12:45:13 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 009FC580316;
        Thu, 13 Jan 2022 12:45:13 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Thu, 13 Jan 2022 12:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=1CIEC
        p+ZznhrnPza5jhu/RiuRksajhZP6I88iKtpDs8=; b=ckDv9HlADf8bSd7kIPFX4
        v1DpASlU5OWs9X7OqaHrXPGFI4ugegImfIeT9TyFeeCf4nm5OAK6GacUdAgoY7b6
        ot8gpXBdAQ+kFJtKjSdPkmQBHumcBNdaWfaih1oTj58WK8aEfSyab54cUWN8XRqb
        xYK8hYE8tUDs7qrYrFCWDPMP/3cjTGMUk1y+v2HlDCjcbIO8+MIddxSgNRhOAnwL
        3vNo9cocl9ojFSjWBjDayTuFQbEx6/b4Qz527PGvHgLB6TUU5Qlv0WMb/0pw9fdm
        TxMA1rVjP67tPxBHZ2l0oZsrXqHNx/FGlC/9VPgqNRTZYNj8boGdhEjn8EdnBhTT
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=1CIECp+ZznhrnPza5jhu/RiuRksajhZP6I88iKtpD
        s8=; b=JbkQa3BiNsDyIduXJv8N45YVNw2HcCJlKmd66SdKxHBnti0dT+Y7xvhXH
        CbAhvKB4+La8kB+XpcWjl394mssqkc/NITqvnu4HHOorEv90ts/TR7HystW9Ynb/
        O5NZIPKcFe33+x1PDusIisW6xI6eWTMjNajUB4brz8rA/lr6IaxfIwe3egDDwmxf
        y0HnUoJtyhBxvUEX4XsQdD9VsksUJbiTvpm3iYut5OAw9mnybgKwK212G3ck7Ma/
        9V4QLSMbDGm4oCVQBEv3lOIsxgLd9zEvppTcvIQAx38YCVox6UjgiXAqSgQstpet
        I6HKOV6dN8ud36K9ri4ppF8auZ9Kg==
X-ME-Sender: <xms:KGXgYaUJkp385IA7sIN4uh_yX1Qwj9tJsk_FqQstF5jIzeJBwSHx6w>
    <xme:KGXgYWl16o1aZZW848uxc1hI8w3zco_0fq2QJn7WOfKDKLbZGM4mcRs9XS1hFwkJY
    GQaZBYs972iHh4KxJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtdefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:KGXgYearfFR55hwYe2Wb4-7AcEeJLRnOROP3shtJTds_HIA8drbaxw>
    <xmx:KGXgYRVBcSxSXHrndaXwDNQ67reKHzlSCNntW6O_9poWDgTyJ02mxA>
    <xmx:KGXgYUlYUR47QXwG7WdQquC6t3iUZMMinCe6fn6UivUDEJAOvkvH5A>
    <xmx:KGXgYecDrqi3RDyKnFE20IMPq9cYhn393OL23yFc2ofseF6xjtgQgQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 67B55FA0AA7; Thu, 13 Jan 2022 12:45:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <a660ca71-b7ed-4348-93ca-c05b0e5b1697@www.fastmail.com>
In-Reply-To: <20220112211039.GA281591@bhelgaas>
References: <20220112211039.GA281591@bhelgaas>
Date:   Thu, 13 Jan 2022 17:44:50 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Rob Herring" <robh@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Ray Jui" <rjui@broadcom.com>,
        "Scott Branden" <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default functions
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82022=E5=B9=B41=E6=9C=8812=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=E5=
=8D=889:10=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Jan 12, 2022 at 08:08:45PM +0000, Jiaxun Yang wrote:
>> =E5=9C=A82022=E5=B9=B41=E6=9C=8812=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=
=E5=8D=883:19=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
>> > On Wed, Jan 12, 2022 at 12:57:44PM +0000, Jiaxun Yang wrote:
>> >> =E5=9C=A82022=E5=B9=B41=E6=9C=8811=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=
=8B=E5=8D=889:46=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
>> >> > [-cc many, +cc iproc, loongson, tegra maintainers]
>> [...]
>> > I see these:
>> >
>> >   Documentation/devicetree/bindings/pci/loongson.yaml
>> >   arch/mips/boot/dts/loongson/rs780e-pch.dtsi
>> >
>> > which makes me think there are Loongson systems with DT.  Are there
>> > some Loongson systems with DT and some legacy ones without?
>>=20
>> Actually all present MIPS/Loongson systems are legacy and we just
>> built-in DTs in kernel and select which one to use at boot time.=20
>
> So I guess you know enough about what platform it is to select which
> DT to use, but you don't know enough to know the I8259 routing?
>
> If you *could* select a DT that described the I8259 routing, I guess
> maybe you could select a matching DT or update a DT in-place?
>
>> > The only driver I see is drivers/pci/controller/pci-loongson.c.
>> > Is that used for all Loongson system?  It unconditionally uses
>> > ->map_irq =3D loongson_map_irq().
>>=20
>> Yes, it's used among all Loongson systems.  For system using LS7A
>> PCH the IRQ mapping is fixed so we just programmed it in DT. For
>> RS780E we use this routine to read PCI_INTERRUPT_LINE to select
>> which I8259 IRQ to use.
>>=20
>> > loongson_map_irq() reads PCI_INTERRUPT_LINE; I think that depends
>> > on firmware having previously programmed it, right?
>>=20
>> I'm unclear about what did firmware do but as AMD RS780E is used in
>> x86 PCs as well it should be the same way.
>
> PCI devices don't use the value in PCI_INTERRUPT_LINE, and the spec
> doesn't define a default value.  It's only for use by software.
>
> I'm pretty sure that on ACPI x86, we don't depend on
> PCI_INTERRUPT_LINE except for things like quirks.
>
> I think the ACPI MADT and _PRT are supposed to contain all the INTx
> routing information we need.  Obviously this isn't an ACPI system.
> I'm just making the point that it *should* be possible to remove this
> dependency on firmware if we can identify the specific platform (which
> determines the I8259 routing).

Hi,

Thanks for the information, I had send a enquire to Loongson to ask about
those details.

Patching DT at boot time should be possible :-)

Thanks.

>
> Bjorn

--=20
- Jiaxun
