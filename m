Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E948CCE1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357284AbiALUKK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 15:10:10 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56117 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357523AbiALUJL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 15:09:11 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59A585803FD;
        Wed, 12 Jan 2022 15:09:08 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 12 Jan 2022 15:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=c+//V
        qTNq33a+q+Ilj21uHHB+OVujfnv7Q6chVbNRJo=; b=ySwXXEYfFlw08wIAbNXRk
        NAg9hjRu3z+2hGg92I0JLSMzMvLwCD+Jke20A/PxA9e27htTxz7f7ZjiGuNEojvO
        fmstdRfclVWfafBQdl6DvOpZc95YNNgUSKGmhB1DZ2cns2aHJNrbVdjd5k0g7bXf
        s1omhnEr21S3BslZvJXBRDhjQInIKOA0gQup48yIUBDHceDjY55AvvKFNFBmUfgI
        Qb6/I5dVekA/Skls0lZEFEBrgYF0ujsEyhN7dqw5uEdrg4RNxc1bF7kBgkzHjIrS
        REBRouj/6I+tBcnJatg+6cvZEjruu9OnappNbpkq20P7dNnHC8TQopS8ib0cblup
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=c+//VqTNq33a+q+Ilj21uHHB+OVujfnv7Q6chVbNR
        Jo=; b=SFJN9DkxqXN+phpNaHt3pTn6yeptuqTDhlXJTKxpOjsVXSLmnl/h54Khf
        WMBGEWAF+J9TNt3KV3IfjyQZxCswzo+M1KxxieqjqWld55lnJu68cqj6uRpZoxj6
        9POPto8Lalbfb2PAEO93Hdu75PY25UUi/pwXNKU8WKXqzPVHaDORIX558qU4hHgp
        mmFFAgpMlCgCvMO+lSvzo+0P1zgzhOZTB3SCmUEKRDTxWj36GiKgAnYDAPKAn/k8
        YkL/OdzsnozakrySXTZ7yomOSw+qgaOhBnWeVc1Pb5kqpyTHxByugAOJIwsb8RwQ
        JPtQMTWZJQW4C7apkZ8pj26w/W+gw==
X-ME-Sender: <xms:YzXfYfc3gnNjQH1O-GDPkCjvPij7hD-BqQX8XZy7wMbC7-PMjr7-BQ>
    <xme:YzXfYVPaYz6NNr7iyQEF1xkEmz7Illnmxh4QLTSgUy8FhovUr0naKAywFyVQW9yYC
    Rj7s4Ktf2GeRsSRUtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YzXfYYjfjnx7yeWV6NO1R-uxjjz4tiF9SwtazlwNgk128kmIf307Mg>
    <xmx:YzXfYQ_J7KuhE4a6MFvNY6ItVPhJ_IhmpvRwpkvoVZQekZd-xvlJug>
    <xmx:YzXfYbvZjIgUtzqXTklvVZDrypktNvlXHwZVSSOur9uBcy_PGU_5WQ>
    <xmx:ZDXfYfEDpsFbIxYmoPB1M_WvYH6PueN7vqZrpS_WEctWY0M4Dt9E6g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7C9E6FA0AA6; Wed, 12 Jan 2022 15:09:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4569-g891f756243-fm-20220111.001-g891f7562
Mime-Version: 1.0
Message-Id: <84d849b5-9386-4db5-87fe-34de3d6c487b@www.fastmail.com>
In-Reply-To: <20220112151903.GA257550@bhelgaas>
References: <20220112151903.GA257550@bhelgaas>
Date:   Wed, 12 Jan 2022 20:08:45 +0000
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
=8D=883:19=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, Jan 12, 2022 at 12:57:44PM +0000, Jiaxun Yang wrote:
>> =E5=9C=A82022=E5=B9=B41=E6=9C=8811=E6=97=A5=E4=B8=80=E6=9C=88 =E4=B8=8B=
=E5=8D=889:46=EF=BC=8CBjorn Helgaas=E5=86=99=E9=81=93=EF=BC=9A
>> > [-cc many, +cc iproc, loongson, tegra maintainers]
[...]
> I see these:
>
>   Documentation/devicetree/bindings/pci/loongson.yaml
>   arch/mips/boot/dts/loongson/rs780e-pch.dtsi
>
> which makes me think there are Loongson systems with DT.  Are there
> some Loongson systems with DT and some legacy ones without?

Actually all present MIPS/Loongson systems are legacy and we just built-=
in
DTs in kernel and select which one to use at boot time.=20

>
> The only driver I see is drivers/pci/controller/pci-loongson.c.  Is
> that used for all Loongson system?  It unconditionally uses ->map_irq
> =3D loongson_map_irq().

Yes, it's used among all Loongson systems.
For system using LS7A PCH the IRQ mapping is fixed so we just programed
it in DT. For RS780E we use this rountine to read PCI_INTERRUPT_LINE to
select which I8259 IRQ to use.

>
> loongson_map_irq() reads PCI_INTERRUPT_LINE; I think that depends on
> firmware having previously programmed it, right?

I'm unclear about what did firmware do but as AMD RS780E is used in x86
PCs as well it should be the same way.

Thanks.

>
> Bjorn

--=20
- Jiaxun
