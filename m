Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940956D968F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjDFL6S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbjDFL5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 07:57:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F21997;
        Thu,  6 Apr 2023 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680782105; x=1712318105;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VIF3RAwyUACMZc/6Udu1lMbe/9hsVoCd5YuEoegFWzg=;
  b=qfF0dsvFkK2QoU6OPgTGGPzNZ29N7jl2TSub201zTmrDd0fbbuOhUrSK
   bJcXPYju3nsGvxVwinR9inUN9pTqIKcuTebbCDtBWOqeZDjp2Rr2gVHTF
   VuFoUtWbzv19TlvhaUntmSf+kYgfO32s32hnz+5lFWtLlM0buonJpw5xU
   A1vn72B+kHNm+mO9gT2d4wdS7KK6iJyuh6BUQysflFAPWH1Jd2AtAQ9yS
   haf3a656/OA8Q6dmOfOnf7yd+6NDt9XmHqQ20Z1CqS5QtkrqBtcTyBoQ4
   RjyUP9E4NXZrAtWU7XBtvfWMnwTYJKwCzBX6vBQEJtobT10koc5qlMjez
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,323,1673938800"; 
   d="asc'?scan'208";a="208441740"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2023 04:54:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 04:54:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Apr 2023 04:54:38 -0700
Date:   Thu, 6 Apr 2023 12:54:23 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        <daire.mcnamara@microchip.com>
Subject: Re: [PATCH v1 0/3] Add JH7110 PCIe driver support
Message-ID: <20230406-coming-stuffed-26f89610959c@wendy>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406-quench-unharmed-2c11b2617e9f@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6DiB+R8lixX5OYkj"
Content-Disposition: inline
In-Reply-To: <20230406-quench-unharmed-2c11b2617e9f@wendy>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--6DiB+R8lixX5OYkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Gah, I never actually CCed Daire. Apologies for the additional email.

On Thu, Apr 06, 2023 at 12:47:41PM +0100, Conor Dooley wrote:
> +CC Daire
>=20
> Hey Minda,
>=20
> On Thu, Apr 06, 2023 at 07:11:39PM +0800, Minda Chen wrote:
> > This patchset adds PCIe driver for the StarFive JH7110 SoC.
> > The patch has been tested on the VisionFive 2 board. The test
> > devices include M.2 NVMe SSD and Realtek 8169 Ethernet adapter.
>=20
> I was talking with Daire last week about some changes he's working on
> for the microchip driver, and we seemed to recall an off-list email
> sent to Daire & Bjorn about extracting the common PLDA bits from the
> pcie-microchip-host driver to be used with an (at that point)
> unreleased SoC. Perhaps Bjorn has this in his mailbox somewhere still,
> our corporate mail policy scrubs things from over a year ago & I could
> not find it.
>=20
> I realised that that may actually have been StarFive, and the driver on
> your GitHub [1] certainly felt very familiar to Daire (he said it was
> very similar to his earlier revisions of his driver).
>=20
> I've not looked at a diff between this and the version you ship on
> GitHub, but first a quick inspection it mostly just looks like you
> did s/plda/sifive/ on the file.
>=20
> I'm obviously not a PCI maintainer, but if there are common bits between
> the two drivers, extracting common bits seems like a good idea to me...
>=20
> https://github.com/starfive-tech/linux/blob/JH7110_VisionFive2_devel/driv=
ers/pci/controller/pcie-plda.c
> >=20
> > This patchset should be applied after the patchset [1], [2], [3] and[4]:
> > [1] https://patchwork.kernel.org/project/linux-riscv/cover/202303141244=
04.117592-1-xingyu.wu@starfivetech.com/
> > [2] https://lore.kernel.org/all/20230315055813.94740-1-william.qiu@star=
fivetech.com/
> > [3] https://patchwork.kernel.org/project/linux-phy/cover/20230315100421=
=2E133428-1-changhuang.liang@starfivetech.com/
> > [4] https://patchwork.kernel.org/project/linux-usb/cover/20230406015216=
=2E27034-1-minda.chen@starfivetech.com/
>=20
> How many of the dependencies here are compiletime for the driver & how
> many of them are just for the dts patch?
>=20
> Cheers,
> Conor.



--6DiB+R8lixX5OYkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC6y7wAKCRB4tDGHoIJi
0gN3AQCtoXaVDJRLbEBtu9kNuP3j5MOEWWrcn+EJ7QXQ61DrzgEAmV93dIZ7fkyt
SbO/ObfnUTym32MCPLClZQbRxcez2Qc=
=l66h
-----END PGP SIGNATURE-----

--6DiB+R8lixX5OYkj--
