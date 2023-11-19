Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EBF7F094F
	for <lists+linux-pci@lfdr.de>; Sun, 19 Nov 2023 23:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjKSWLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Nov 2023 17:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjKSWLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Nov 2023 17:11:04 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01999137;
        Sun, 19 Nov 2023 14:11:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E9D3232002E2;
        Sun, 19 Nov 2023 17:10:59 -0500 (EST)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Sun, 19 Nov 2023 17:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1700431859; x=1700518259; bh=A9ugAPXlwNX2ESqtZP+JDEUovE61/ifsaS4
        nh+mFpeA=; b=jzbVeP0AFo3F6HydOyhsIfsFmDRPArALoAK33LsHIk/6fGL1lOy
        7GEsnKS6o6U2OAY5AEbanGVvC7btBSvPP+PIGiXkJJQOFBMLHsqPd6/YT/WYhoqg
        MSInyiV2UKv0AtAgb/4pc4HawwND/a6JkBq/814Y8nGl/A8rGLGzuDHgEjflu4yH
        ZaUQxLeBalTFHZINO2JGW5n5N4A+Ff9NORYM1CjI8BZcwtf1sXb2/qU3HQLjR8HW
        9GkKRJJ3jRiD56fvDVkuHyz/XcTBi5vDcg2UutewWvP9IQKZyoiAa6RGFA2oOME8
        FfN/0XBwkAB4op88gliFsFZNRpeWdCrFY9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700431859; x=1700518259; bh=A9ugAPXlwNX2ESqtZP+JDEUovE61/ifsaS4
        nh+mFpeA=; b=cP8dG7BqYCUNgybL5OrhzU7RiPZgi4DlV8O9jFg5W/I/xydKup4
        rJoVsMQohmA6e4eVZxWJsAcDwb7iq8fOnNyAfT2j19dvlfg/2cQo1URNXFWE6NYt
        QoBb+B8Od2ZZT59+ftnhBnR190YSSiHh+z0Y/en9yygfb8/rXunFysEvqry3gXzR
        Z0xtAdFX5HZNy8bReGk3pvYVaWMW2XUAF5tDVOn+CUCtbM8N19POA2KJ8TpWdu+C
        VjxKOVbagcsTOgRQwkcD3X7J5Bb8cKqe2F8Qc1fLrG2TrOZTa1pzpN5uaeUUUdcg
        iWBynos6bs+U/nDEfULo7ku+gYL+nU4dQrA==
X-ME-Sender: <xms:84daZVGYJJdAGSf5IZm5pJOc3vw1QJCdoIJxQc8KXiYw4vgVqmfILw>
    <xme:84daZaW8DyxPO1u5DUzOils-mtAN-soTlQpPdZuFSrcw5AlSj381kso7SCKAfQiDv
    7f9PBcoexKGP4vW_-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeggedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtg
    homheqnecuggftrfgrthhtvghrnhepkeelveffhedtiefgkeefhffftdduffdvueevtdff
    teehueeihffgteelkeelkeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdr
    higrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:84daZXLoq9uMZ5u5IjyWRVBNcnqxQ7Lq8GMwX4VoHkk8WYAVlZ9iyQ>
    <xmx:84daZbHQA2UCBh5cJCuj6uzTmPuHu21nbJ6uL7wySoQUuaQEa2GSXA>
    <xmx:84daZbWljo0AwqVWirdmvqVEbZN3daQ1mzzHJ0N9BnF3v8KZIfCtGg>
    <xmx:84daZRyNtlkxZRVkvP52j7upgSWlsFBl3M1lMqkxfh3PNy-38AkRhg>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2762536A0075; Sun, 19 Nov 2023 17:10:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <7d094389-64ff-40d5-8918-b79ef4f62986@app.fastmail.com>
In-Reply-To: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
References: <20231119215635.52810-1-jiaxun.yang@flygoat.com>
Date:   Sun, 19 Nov 2023 22:10:39 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     linux-pci <linux-pci@vger.kernel.org>
Cc:     "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Rob Herring" <robh@kernel.org>, linux-kernel@vger.kernel.org,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] pci: loongson: Workaround MIPS firmware MRRS settings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=E5=9C=A82023=E5=B9=B411=E6=9C=8819=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =
=E4=B8=8B=E5=8D=889:56=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> This is a partial revert of commit 8b3517f88ff2 ("PCI:
> loongson: Prevent LS7A MRRS increases") for MIPS based Loongson.
>
> There are many MIPS based Loongson systems in wild that
> shipped with firmware which does not set maximum MRRS properly.
>
> Limiting MRRS to 256 for all as MIPS Loongson comes with higher
> MRRS support is considered rare.
>
> It must be done at device enablement stage because MRRS setting
> may get lost if the parent bridge lost PCI_COMMAND_MASTER, and
> we are only sure parent bridge is enabled at this point.
>
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217680
> Fixes: 8b3517f88ff2 ("PCI: loongson: Prevent LS7A MRRS increases")
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v4: Improve commit message
> v5:
> 	- Improve commit message and comments.
> 	- Style fix from Huacai's off-list input.
> ---
>  drivers/pci/controller/pci-loongson.c | 47 ++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-loongson.c=20
> b/drivers/pci/controller/pci-loongson.c
> index d45e7b8dc530..128cc95b236f 100644
> --- a/drivers/pci/controller/pci-loongson.c
> +++ b/drivers/pci/controller/pci-loongson.c
> @@ -80,13 +80,50 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
>  			DEV_LS7A_LPC, system_bus_quirk);
>=20
> +/*
> + * Some Loongson PCIe ports have h/w limitations of maximum read
> + * request size. They can't handle anything larger than this.
> + * Sane firmware will set proper MRRS at boot, so we only need
> + * no_inc_mrrs for bridges. However, some MIPS Loongson firmware
> + * won't set MRRS properly, and we have to enforce maximum safe
> + * MRRS, which is 256 bytes.
> + */
> +#ifdef CONFIG_MIPS
> +static void loongson_set_min_mrrs_quirk(struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus =3D pdev->bus;
> +	struct pci_dev *bridge;
> +	static const struct pci_device_id bridge_devids[] =3D {
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS2K_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT0) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT1) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT2) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT3) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT4) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT5) },
> +		{ PCI_VDEVICE(LOONGSON, DEV_LS7A_PCIE_PORT6) },
> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		bridge =3D bus->self;
> +		bus =3D bus->parent;
> +
> +		if (pci_match_id(bridge_devids, bridge)) {
> +			if (pcie_get_readrq(pdev) > 256) {
> +				pci_info(pdev, "limiting MRRS to 256\n");
> +				pcie_set_readrq(pdev, 256);
> +			}
> +			break;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk_=
old);
                                                     ^ Oops sed issue.
Will fix in next version if everybody is happy with the implementation.

Thanks
--=20
- Jiaxun
