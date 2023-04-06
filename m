Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F1A6D965D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 13:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbjDFLw7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjDFLwp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 07:52:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D0AD3A;
        Thu,  6 Apr 2023 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680781753; x=1712317753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+UYC0tfkmmnRQ4kbRq5dBoEfB7CyXL08W8hMYkXxdM=;
  b=H7pkXnanS88oZmHoOsfiAVpLbcBiNmuTQx8jvvZ+q8MmVRCrhtYSVsQ8
   4EzQfm+AALhDxeAuSAHylbLOAVbzfqjwxRfplNBaqwNp6sTzzrLQjP8aF
   4xfOgIoTun9t3rOX3Enx4zblw41MaamOuILH3/OnbVNON+zEHlgRLQ5hE
   tzHop4ykT3rsv9nT7Lapv5rvDSC1qzpOvWBEjjMlcFbRtCzlf7hix/jsm
   0V8MnMW/tEkSO38mAz6eUKtIkigQcbavD4ctw/iDQcJLRcQmR+12P1sNp
   4FmbmeXiekyY0+ccZtPaJ5ui09AbNwD3U0rrjk3S/7+ZuX7jjoy7j728l
   w==;
X-IronPort-AV: E=Sophos;i="5.98,323,1673938800"; 
   d="asc'?scan'208";a="208441268"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2023 04:47:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 04:47:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Apr 2023 04:47:50 -0700
Date:   Thu, 6 Apr 2023 12:47:36 +0100
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
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 0/3] Add JH7110 PCIe driver support
Message-ID: <20230406-quench-unharmed-2c11b2617e9f@wendy>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pdoU8EknNFXRqqKf"
Content-Disposition: inline
In-Reply-To: <20230406111142.74410-1-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--pdoU8EknNFXRqqKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Daire

Hey Minda,

On Thu, Apr 06, 2023 at 07:11:39PM +0800, Minda Chen wrote:
> This patchset adds PCIe driver for the StarFive JH7110 SoC.
> The patch has been tested on the VisionFive 2 board. The test
> devices include M.2 NVMe SSD and Realtek 8169 Ethernet adapter.

I was talking with Daire last week about some changes he's working on
for the microchip driver, and we seemed to recall an off-list email
sent to Daire & Bjorn about extracting the common PLDA bits from the
pcie-microchip-host driver to be used with an (at that point)
unreleased SoC. Perhaps Bjorn has this in his mailbox somewhere still,
our corporate mail policy scrubs things from over a year ago & I could
not find it.

I realised that that may actually have been StarFive, and the driver on
your GitHub [1] certainly felt very familiar to Daire (he said it was
very similar to his earlier revisions of his driver).

I've not looked at a diff between this and the version you ship on
GitHub, but first a quick inspection it mostly just looks like you
did s/plda/sifive/ on the file.

I'm obviously not a PCI maintainer, but if there are common bits between
the two drivers, extracting common bits seems like a good idea to me...

https://github.com/starfive-tech/linux/blob/JH7110_VisionFive2_devel/driver=
s/pci/controller/pcie-plda.c
>=20
> This patchset should be applied after the patchset [1], [2], [3] and[4]:
> [1] https://patchwork.kernel.org/project/linux-riscv/cover/20230314124404=
=2E117592-1-xingyu.wu@starfivetech.com/
> [2] https://lore.kernel.org/all/20230315055813.94740-1-william.qiu@starfi=
vetech.com/
> [3] https://patchwork.kernel.org/project/linux-phy/cover/20230315100421.1=
33428-1-changhuang.liang@starfivetech.com/
> [4] https://patchwork.kernel.org/project/linux-usb/cover/20230406015216.2=
7034-1-minda.chen@starfivetech.com/

How many of the dependencies here are compiletime for the driver & how
many of them are just for the dts patch?

Cheers,
Conor.

--pdoU8EknNFXRqqKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC6xWAAKCRB4tDGHoIJi
0jhVAP9hS1vC8Hz2Ej8p78BoR9XtyvbMZlUphCIZh2iul1lqHAD+IvTQjBopn9vt
uyBVB9MXQ5t8DwGJ/nm7POC3aFb2/gA=
=PlsG
-----END PGP SIGNATURE-----

--pdoU8EknNFXRqqKf--
