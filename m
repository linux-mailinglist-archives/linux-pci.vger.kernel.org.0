Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95B298CEA
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 13:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775171AbgJZMdB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 08:33:01 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12651 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775169AbgJZMdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 08:33:01 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f96c1e80000>; Mon, 26 Oct 2020 05:32:40 -0700
Received: from localhost (10.124.1.5) by HQMAIL107.nvidia.com (172.20.187.13)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct 2020 12:32:59
 +0000
Date:   Mon, 26 Oct 2020 13:32:57 +0100
From:   Thierry Reding <treding@nvidia.com>
To:     Jingoo Han <jingoohan1@gmail.com>
CC:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH 0/3] Add support to handle prefetchable memory
Message-ID: <20201026123012.GA356750@ulmo>
References: <20201023195655.11242-1-vidyas@nvidia.com>
 <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <SLXP216MB04777D651A59246A60D036A8AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
X-NVConfidentiality: public
User-Agent: Mutt/1.14.7 (2020-08-29)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603715560; bh=sqQVLIGYKI42d425ac+GAGW1AQu2By70V9nvM0kyskI=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:X-NVConfidentiality:
         User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=ELTAHRjXw6NZhL3cmV/vOeItQwvz16wHR+EgQHN7Cn3RCK2FLjI6K1lO8yEmE5ft8
         xFFdKWLbdOk3fsWXLP/uS1MrvPrz4xRVVpKlRJCUxYhkVhHKzBK9NkxFOIopEBwTRX
         RadntGYS0L5jHi8yyx+6C3DoSvg7y/xnDPAHr7LcVvbz1xxhY5CcXOsouRB3kUXaWq
         60zAB2Q8twaRqYqqxxwBRDL0KC5M7Rh/JPZJVWZF2K8PrBrQzHGWQ5lVNVsWP6l7V/
         Wok+UGT5u0CVFvxb4Lw6gkVvR1imCvdCgiAwl6eTtjDt33WOz/e/mFjmgYs5GhK5Ur
         YPgDBo2aE574Q==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2020 at 04:03:41AM +0000, Jingoo Han wrote:
> On 10/23/20, 3:57 PM, Vidya Sagar wrote:
> >=20
> > This patch series adds support for configuring the DesignWare IP's ATU
> > region for prefetchable memory translations.
> > It first starts by flagging a warning if the size of non-prefetchable
> > aperture goes beyond 32-bit as PCIe spec doesn't allow it.
> > And then adds required support for programming the ATU to handle higher
> > (i.e. >4GB) sizes and then finally adds support for differentiating
> > between prefetchable and non-prefetchable regions and configuring one of
> > the ATU regions for prefetchable memory translations purpose.
> >
> > Vidya Sagar (3):
> >   PCI: of: Warn if non-prefetchable memory aperture size is > 32-bit
> >   PCI: dwc: Add support to program ATU for >4GB memory aperture sizes
> >   PCI: dwc: Add support to handle prefetchable memory mapping
>=20
> For 2nd & 3rd,
> Acked-by: Jingoo <jingoohan1@gmail.com>
> But, I still want someone to ack 1st patch, not me.
>=20
> To Vidya,
> If possible, can you ask your coworker to give 'Tested-by'? It will be ve=
ry helpful.
> Thank you.

On next-20201026 (but also going back quite a while) I'm seeing this
during boot on Jetson AGX Xavier (Tegra194):

[    3.493382] ahci 0001:01:00.0: version 3.0
[    3.493889] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
[    4.497706] ahci 0001:01:00.0: controller reset failed (0xffffffff)
[    4.498114] ahci: probe of 0001:01:00.0 failed with error -5

After applying this series, AHCI over PCI is back to normal:

[    3.543230] ahci 0001:01:00.0: AHCI 0001.0000 32 slots 1 ports 6 Gbps 0x=
1 impl SATA mode
[    3.550841] ahci 0001:01:00.0: flags: 64bit ncq sntf led only pmp fbs pi=
o slum part sxs
[    3.559747] scsi host0: ahci
[    3.561998] ata1: SATA max UDMA/133 abar m512@0x1230010000 port 0x123001=
0100 irq 63

So for the series:

Tested-by: Thierry Reding <treding@nvidia.com>

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+WwfkACgkQ3SOs138+
s6GSZw//dofmlmsswCqSTbKwBiInkH2EyVwdddtYg43ZSc8uCDAIKtUTPr9o1O4P
ae67pQ0Zwgr79ULbANWRr6KsgoAT+Pbd7qQoHT/X252IrvxmOG0mkgPCGvJcsZZa
vgZvoQRSPNXPehVlcJBH/JX33NKJm+T01B9MAG4OdHG4PLQqdc6LLj7rskibQeom
fIGkJsXQRvzMDyDxqYrqOop2V9ejV9EwAqbOrQpSTzNrfv1yy0HJVmL8S5qqWSRM
tgvtZ+wLAuCq0jwDgKYiTXHnpltO4C3QyCc6FteZB6ykeJlOm4eTIy58oGjv1AQU
XpHqOTRJs9SGxSIudrshjcvxyU09Ci9dGU/n/x/vznIl3z58FuK6Xp9eWgyVR4qg
NrDViohHrj5c1VHqWwERUCDnbQINYF+l+g51xDzMRdYP2C46sHrnOQ/e73CicGny
Ovs26S2H7UyYFwBNsYmDzA1f3SmkZLX490D8qM3vo65UENZ2cOsIFamBvGuiqn7C
Z4zunXfySLRE7QTAWJuX76pFclfzM4NeUwlehpogSR+32C/sn3sJQgfr/zZd4RRd
G456gCEA4Lg0W8TKkhqKDfbzS0EQ+6zvP/jvwU68IfH+Pmo94z0BsXu9+Ng7eXWZ
CtceVfJDFqw/kmT+lH8OgIfLxrzFjJbPNiCY3t3GFGrqpvpwCXc=
=JZ1w
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
