Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B073E37D2
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 03:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhHHBmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 Aug 2021 21:42:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51571 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhHHBmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 Aug 2021 21:42:09 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 000835C00B0;
        Sat,  7 Aug 2021 21:41:50 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute2.internal (MEProxy); Sat, 07 Aug 2021 21:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=F96tM
        Wj2xtLgP3+Yu+6pP+OueHUggM2jfq+yApxhj4Y=; b=lMsAQgW/EBndX0U76cjn2
        jKXOX+9qt/nipvdhyhsx/11gM0zOGRDK4mrnCfelaua3p5n0gMnn4DuVxrcjpVIj
        hxfxCxgmQ1UbSmoMYzSotcCkruynSwgqevN0ztMVQ7ZwHR4pAx4I4Jm3gjh12x9J
        SbPr0EOQSmvH2J2yrdgmVEFmJN/e8ORsdlx55EhuY7r9feR1F6pm/hM0YoTooYxC
        TRenqW3Imlzc+u9n2V5Q9QEEWeiQ+4++Zg5TNO4jwpt7WOUV/NcCXjwSNNHxgp4/
        sUicB/f37gf3deIfQEq0WXxbH3Mj4B0uod5tQE2QcT1eHLx1FnFr7bNbdRaa5I/i
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=F96tMWj2xtLgP3+Yu+6pP+OueHUggM2jfq+yApxhj
        4Y=; b=RSOFPHeXJajQkY1o4JJDlT6sOMqXtuh4pDiOSVqRfo4oUnPFwo8DNU7/2
        SKPkDfQuMH3s+YQK92Q6+Y0ya1fS9c1P8tbbQ34PGnX9NE0/L61nKDDuAvLy6W0W
        GHoWez8Ys5fHlg4stjD6MIk/BwrzhN6N4KKkJO3JT+lHD2zRePEyZTSUz4ufy5+h
        G1vZtijthobDPsgorcvsQqUm3kG42tiTGhDJBJibDY1VU9ziAE4Mg5LutSF+fHWc
        6XwsIunU6IYDVrC0jhdH62jAcQuGSbp4HEBy2UoTAhwKAdsCR3Cpg6Hh8vo8Ja25
        r2Cd9Ve38fU5RsoceOcmlcqVoGIjA==
X-ME-Sender: <xms:XjYPYQPxL7hO5t8OCJEpj-9J17oC8sqh8uVgUD5EOujT3fE4FpKYlQ>
    <xme:XjYPYW9srI9PCMkaCmtGGRayQLDwnHF-V-6nHid1NTpSMsdYN2BL01N-zAqeNj1YN
    yGKeIFXXNcM8rX_5Fs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeeggdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdflihgr
    gihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeefteegkeevfeethffgudehgedvueduvdeifedvvdelhfef
    heekteefueektdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:XjYPYXQ9ikWIkhz_5kAw1Hrz9dBGCxjXaUZHa5xFWFmyOOhxStN_nQ>
    <xmx:XjYPYYvO5VKDaxPWMR0fm46n4EKM4vGVwV4xjAZmTVGVmfXtAOAK7g>
    <xmx:XjYPYYeX0fENrMgBepPZK_mexFzZR65vgUEbB4ORC6zoTYhT8MsYSw>
    <xmx:XjYPYWvwVYhBrYK2tOMjNidl85gAnDCilaMj1wFH4WJTDs8srDpJuw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 211E7FA0AA5; Sat,  7 Aug 2021 21:41:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-552-g2afffd2709-fm-20210805.001-g2afffd27
Mime-Version: 1.0
Message-Id: <7f0d48a6-d4ae-4e8d-aaa8-4b0bb4ad8e35@www.fastmail.com>
In-Reply-To: <20210807072409.9018-3-sergio.paracuellos@gmail.com>
References: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
 <20210807072409.9018-3-sergio.paracuellos@gmail.com>
Date:   Sun, 08 Aug 2021 09:41:29 +0800
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "Bjorn Helgaas" <bhelgaas@google.com>, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_2/3]_PCI:_of:_avoid_'devm=5Fpci=5Fremap=5Fiospace'_?=
 =?UTF-8?Q?if_PCI=5FIOBASE_is_not_defined?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



=E5=9C=A82021=E5=B9=B48=E6=9C=887=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=883:24=EF=BC=8CSergio Paracuellos=E5=86=99=E9=81=93=EF=BC=9A
> Defining PCI_IOBASE for MIPS ralink in expected addresses results in=20=

> PCI IO
> resources being assigned but the addresses generated for IO accesses=20=

> are wrong
> since the ioremap in the PCI core function=20
> 'pci_parse_request_of_pci_ranges'
> tries to remap to a fixed virtual address (PC_IOBASE) which can't work=
=20
> for KSEG1
> addresses. To get it working this way, we would need to put PCI_IOBASE=
=20
> somewhere
> into KSEG2 which will result in creating TLB entries for IO addresses,=
=20
> which most
> of the time isn't needed on MIPS because of access via KSEG1. To allow=
=20

It was designed to allow multiple PCI bridge with sparse IO space patter=
n.
So for ralink it's not going to happen?

Thanks.
- Jiaxun


> MIPS PCI
> drivers to properly use the PCI generic core we need to increase=20
> IO_SPACE_LIMIT
> since IO addresses are in addresses higher that 0xffff. We also need t=
o=20
> avoid
> the call 'devm_pci_remap_iospace' when=20
> 'pci_parse_request_of_pci_ranges' is
> called to avoid the following problem:
>=20
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+=
0x3c/0x54
> This architecture does not support memory mapped I/O
> Modules linked in:
> CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
> Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000=
 0000000b
>         00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40=
 7d06ddec
>         00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000=
 0000000a
>         203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000=
 807d0000
>         807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008=
 815e0008
>         ...
> Call Trace:
> [<80008efc>] show_stack+0x8c/0x130
> [<806e1674>] dump_stack+0x9c/0xc8
> [<80024a3c>] __warn+0xc0/0xe8
> [<80024ad0>] warn_slowpath_fmt+0x6c/0xbc
> [<80410ca8>] pci_remap_iospace+0x3c/0x54
> [<80410d20>] devm_pci_remap_iospace+0x58/0xa4
> [<8042019c>] devm_of_pci_bridge_init+0x4dc/0x55c
> [<80408de8>] devm_pci_alloc_host_bridge+0x78/0x88
> [<80424e44>] mt7621_pci_probe+0x68/0x9a4
> [<80464804>] platform_drv_probe+0x40/0x7c
> [<804628bc>] really_probe+0x2fc/0x4e4
> [<80463214>] device_driver_attach+0x4c/0x74
> [<80463384>] __driver_attach+0x148/0x150
> [<8046047c>] bus_for_each_dev+0x6c/0xb0
> [<804614dc>] bus_add_driver+0x1b4/0x1fc
> [<80463aa0>] driver_register+0xd0/0x110
> [<80001714>] do_one_initcall+0x84/0x1c0
> [<808e7fd0>] kernel_init_freeable+0x214/0x24c
> [<806e4164>] kernel_init+0x14/0x118
> [<80003358>] ret_from_kernel_thread+0x14/0x1c
>=20
> ---[ end trace 1c9d4412bd51b53c ]---
> mt7621-pci 1e140000.pcie: error -19: failed to map resource [io =20
> 0x1e160000-0x1e16ffff]
>=20
> Hence don't call 'devm_pci_remap_iospace' if PCI_IOBASE is not defined=
 to get
> a working PCI core APIs for MIPS ralink platforms.
>=20
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  drivers/pci/of.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index a143b02b2dcd..657aef39bf63 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struc=
t=20
> device *dev,
> =20
>  		switch (resource_type(res)) {
>  		case IORESOURCE_IO:
> +#ifdef PCI_IOBASE
>  			err =3D devm_pci_remap_iospace(dev, res, iobase);
>  			if (err) {
>  				dev_warn(dev, "error %d: failed to map resource %pR\n",
>  					 err, res);
>  				resource_list_destroy_entry(win);
>  			}
> +#endif
>  			break;
>  		case IORESOURCE_MEM:
>  			res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
> --=20
> 2.25.1
>=20
>=20


--=20
- Jiaxun
