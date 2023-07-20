Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE575AE54
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGTM1o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 08:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjGTM1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 08:27:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F202681;
        Thu, 20 Jul 2023 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689856056; x=1721392056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ZGiXBA7knMeVbYBzBnYdJHrkPeF9rSCMSWxNZrS0q0=;
  b=RuuxtmR7clv93YDpjqpFEQW0pvzrkQUQpIMq5LgpIEdiKI1jXH1HiRCi
   cSRjBdtGl2k3aO2nRo4sRz32RkU1LtaieQDa2RRW4UY3HVOa3fCX6z1h0
   XtIKKiaGLsmEWw4K5N9GHWmK1INqq0CMVIGoUSdMtD8CRisoZfDWYeyxh
   pBIrhfRaUTemhaaWqZYWS+AEpwmXD1D1eU4mh5nZ5NWK/YpF4Wlrrj1Jk
   tPRJBmHuBQ1bMGN2ux4NOENjFVM5hm329VblTPMquq0+iivzlIYuitOmJ
   F754/PHqcrAXEzJ+nK81AkSVtSytg70/xRcdIrDxcLlMAWFuF0Z7mwE9r
   g==;
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="asc'?scan'208";a="224927705"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 05:27:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 05:27:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 20 Jul 2023 05:27:27 -0700
Date:   Thu, 20 Jul 2023 13:26:54 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 4/9] PCI: microchip: Move PCIe driver to PLDA directory
Message-ID: <20230720-exception-spectator-b48ecb9d4c39@wendy>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-5-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Lilo/J5IxQgX/2YQ"
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-5-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Lilo/J5IxQgX/2YQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda,

On Wed, Jul 19, 2023 at 06:20:52PM +0800, Minda Chen wrote:
> Move Microchip specific platform codes to PLDA directory.
> Including clock init, interrupt event handle and platform
> init codes.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Something else that I noticed, looking at what is not in the diff here,
but is everything under the "/* PCIe Controller Phy Regs */" comment
that remains in the microchip driver not also common to the plda IP?

Thanks,
Conor.

--Lilo/J5IxQgX/2YQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLkoDgAKCRB4tDGHoIJi
0vX+AQCNRNQvcPAT0vcVJXASNscuAioQvT52F/KhEUDLy/SoSAEA6U+2742WoaFO
H9PBHMPTzScdWPvpyEsWaGVXPs7Z+gc=
=rUDs
-----END PGP SIGNATURE-----

--Lilo/J5IxQgX/2YQ--
