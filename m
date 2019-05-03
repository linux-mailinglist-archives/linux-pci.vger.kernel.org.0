Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE3212C16
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfECLNI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:13:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34408 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfECLNI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 07:13:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id e9so7403638wrc.1;
        Fri, 03 May 2019 04:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VorhduCjm/PV7LIywmluOVllNVaujX/MK5dw8bcazaY=;
        b=DQJhiA9/d6Snr8rcYf11fSDkRsPn4eFH0pbGbeO3EYim9yz2xSYoxcKO8uWhGjLG/0
         YyPSP/s0ul2iyhFEta0KIGoKCYsvPceBXPQ8+3P93X7mrPjolezEUW5LsRqYbh/GnxBS
         fL5O/wQ2rx3M0ooHwDQnoA3rBfuqUP+9RKR0K3D7SuahieZ8JvQh70Tr7X72V1lMaWdN
         s6d18HmvK0j2BtgmSgXgTteuthc52BBw3m2NZXjBhAvmpmCIheumFpJAggJ6zXMou6VX
         9CtwlGsAeQXhsAl/mW75AcLYBaA03v8u6yqItMWGsXuuWlu2hwGwSSqyH98t1+cwaNG5
         2B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VorhduCjm/PV7LIywmluOVllNVaujX/MK5dw8bcazaY=;
        b=pFBBPSGJYA6b4Y1DszMM7cXDkLuADzNHqGiFdNS/FSf7NZpc+72uQl/2OT+4A+xCU5
         GEdIMdc2ERm8TSBrpMyHSubbU68XKobiwv2bukfObvJMsBfLOhtHZCgAloCwXEDz4bk5
         Zias806Z6zXSRlOpB3gHhXC7SEetdbQSwZVsR5K9CULlzmAJ81WE2W4HlHLZF45W7GYz
         kLfrB4y8diW5UI2l7hWA2LP7ZFXFfGVLUaHZyq/D3vYbZwAMyCTw6cd3RC4xBNlW9eqf
         8OEP5d9Btw1UUl/djin/IxpDRQ3KrwuegYzGRkHaky5FIWApohxiYt+KNv+miNRCodM1
         +LSw==
X-Gm-Message-State: APjAAAUIwYjGrpisE8eZW0BBmJ4hCwSM8lKn1QLVwMhDxhyPlSU8gBST
        Ynby2+T0igFr2HPeC4ASLe5ysUXgSEM=
X-Google-Smtp-Source: APXvYqzIoZM1WKmoSa+jqkolj1Wa5xAp4KxJNadWyadjysOMzw6Haf/w2JCSiYGbd4g8Uewe/f6klA==
X-Received: by 2002:a5d:6249:: with SMTP id m9mr6360592wrv.255.1556881986035;
        Fri, 03 May 2019 04:13:06 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id c10sm4139876wrd.69.2019.05.03.04.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:13:04 -0700 (PDT)
Date:   Fri, 3 May 2019 13:13:03 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 04/16] PCI: dwc: Perform dbi regs write lock towards
 the end
Message-ID: <20190503111303.GD32400@ulmo>
References: <20190424052004.6270-1-vidyas@nvidia.com>
 <20190424052004.6270-5-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20190424052004.6270-5-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 10:49:52AM +0530, Vidya Sagar wrote:
> Remove multiple write enable and disable sequences of dbi registers as
> Tegra194 implements writes to BAR-0 register (offset: 0x10) controlled by
> DBI write-lock enable bit thereby not allowing any further writes to BAR-0
> register in config space to take place. Hence disabling write permission
> only towards the end.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * None
>=20
> Changes since [v1]:
> * None
>=20
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 36fd3f5b48f6..e5e3571dd2fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -654,7 +654,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val &=3D 0xffff00ff;
>  	val |=3D 0x00000100;
>  	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> =20
>  	/* Setup bus numbers */
>  	val =3D dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
> @@ -686,8 +685,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> =20
>  	dw_pcie_wr_own_conf(pp, PCI_BASE_ADDRESS_0, 4, 0);
> =20
> -	/* Enable write permission for the DBI read-only register */
> -	dw_pcie_dbi_ro_wr_en(pci);
>  	/* Program correct class for RC */
>  	dw_pcie_wr_own_conf(pp, PCI_CLASS_DEVICE, 2, PCI_CLASS_BRIDGE_PCI);
>  	/* Better disable write permission right after the update */

Perhaps make this explicit by moving the write enable call to the
beginning of the function and the write disable call to the end?

Currently it's pretty difficult to see where it's being disabled. Also,
that would make it more resilient against instantiations that require a
different register to be programmed with writes enabled.

Thierry

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzMIj8ACgkQ3SOs138+
s6FFuRAAmiTyrtz2NxKwCwdtyyP/+itBnYe7MfDjSdUTPlZtSa1dFyCI+XHymBsB
X2sVKTo2/OgUkGwsMWvLqW/Na5Z5XHetXaP0+5zJqswFAfAS5JKZtwnU/7th3H9e
dlScRp776ngjkaAeAc8E1v36v7fYgfSn0fZu9Sk/i7pm/UZ0TkkSYSLaro44tQlW
+UzxntgV0w94wbfmQb6LzJbf2No1isVa9hz+NGEJGur0vPLso12PPe6kvtyO3eH4
hQTHqbQChqUAk0ic/s+SRsdiYNOGceoteCy2ysAf5vzvSqZULEFfVODLVo9xrAhe
DburhK/NF+w1wcTmTgOzJRTmtTlhiYYrMBlvipP2lYC8Ksyedo+Ku8FMbrfvOpRE
XU6NUL4VPAvl8ZKPOVc4Y6+rOB4VYjlYkgnpTEuJaSpplqaZ2GwD1fA1JjBX4J2o
jvQTocuTrx+N5J1OL43pBT9KnxGZa5UCvxrha1DD9C0KStb4z6qCKPQhWEnnAbXE
YfmoSwhHMu5zHCQmp7W/qm+wWwFnWbxw7s0CfGyoeGwz/oFNTFMCwA++tZp51B06
HOP1iEE/Z4jzxOQYiArz/bRUxQ1Nm7lrlalcoGwCgLhhD9Exp5to9JZkMKIwGllD
jOp84vWCp+stTczX8lt5NPbmChSpMWarJQn+c+c/tjhfq5Aa0To=
=EmOl
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
