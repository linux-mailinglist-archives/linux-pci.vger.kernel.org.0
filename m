Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C1076F9FF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 08:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjHDGYM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 02:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjHDGYF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 02:24:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF32E70;
        Thu,  3 Aug 2023 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691130243; x=1722666243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y1vnWgRBnOFQHq3VPq4hPs+zL/03MjtEuWXM4W/y58E=;
  b=CMgmJpdjfVwAb3jJbr6K8DWyICbn3Hu14/CONezdwsShvhAAMMT4Ds56
   uJAK+XWtCXfQbJLLQ2bVCxmxZike967UoISe2sjSbEmisik28lAz1Puty
   k8Sx0BVkZqEziiqlP1CsbhEv24ZyKIpcw3KR8SsThUsc86qot0xYKOdPq
   tuYjjQa4ZerKXLAy+HXXpP4gwSQewVOnNtbHwYicYlTPW97jAAkP+/mKf
   2XCF892EuICrXBrL0KtPuoW3BQgY2tgWRTb2dknkkollD7KtnOrJWf/1V
   9kROCm5nlBVMb+wmN8C4E8uCrclmpkn3Jg54wPCgBgB9NnePWUjsSoZ2w
   w==;
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="asc'?scan'208";a="228143618"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 23:24:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 23:23:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 23:23:51 -0700
Date:   Fri, 4 Aug 2023 07:23:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v2 0/4] Refactoring Microchip PCIe driver and add
 StarFive PCIe
Message-ID: <20230804-trustless-syrup-cb96c0722045@wendy>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <0b93ffcb-a236-99c0-1cf5-ad584b80c0ab@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3XOO7rkxHIO3qKO"
Content-Disposition: inline
In-Reply-To: <0b93ffcb-a236-99c0-1cf5-ad584b80c0ab@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--t3XOO7rkxHIO3qKO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda,

On Fri, Aug 04, 2023 at 09:46:30AM +0800, Minda Chen wrote:
> On 2023/7/27 18:39, Minda Chen wrote:
> > This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> > JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> > same IP and have commit their codes, which are mixed with PLDA
> > controller codes and Microchip platform codes.
> >=20
> > For re-use the PLDA controller codes, I request refactoring microchip
> > codes, move PLDA common codes to PLDA files.
> > Desigware and Cadence is good example for refactoring codes.
> >=20
> > So first step is extract the PLDA common codes from microchip, and
> > refactoring the microchip codes.(patch1 - 2)
> > Then, add Starfive codes. (patch3 - 4)
> >=20
> > This patchset is base on v6.5-rc1
> >=20
> > patch1 is move PLDA XpressRICH PCIe host common properties dt-binding
> >        docs from microchip,pcie-host.yaml
> > patch2 is extracting the PLDA common codes from microchip Polarfire PCIe
> >        codes. The change list in the commit message.
> > patch3 is add StarFive JH7110 PCIe dt-binding doc.
> > patch4 is add StarFive JH7110 Soc PCIe codes.
> >

> Hi Rob, Krzysztof(K.K) and Conor

>   Do you have any comments for dts-binding doc patch? (patch 1 and patch3=
) Thanks. =20

Yeah, I do intend looking at this! I think, because I am wearing more
than one hat for this series, it ended up not in my dt-binding review
queue. I'll make sure to have a look today.

--t3XOO7rkxHIO3qKO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMyZSAAKCRB4tDGHoIJi
0ktKAPsGbreW17r3DGJav2hsyIM5VqCfWopcweEvLYh35ZDDUwEAtefA+w/qXTxC
VetBJ4d+qooyWLN5nA5jcX1+tTj2xwY=
=JIKw
-----END PGP SIGNATURE-----

--t3XOO7rkxHIO3qKO--
