Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD076FADA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjHDHNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjHDHNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 03:13:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB25535B7;
        Fri,  4 Aug 2023 00:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691133211; x=1722669211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SulP/xi0rkHTrAvRbGnkwJmzQ2rpZKJbL0YozafDyZc=;
  b=dF908F3oyFdLMo9mDIJ+akvhKNTt3IgIxgSbINmCpHVKVaSoZU+pvZJZ
   AuW2G5J6mFB3tGV1lAMCDf2gXy4Ehq4tfVcwxBeFOXrWEf/4wimKr4PZJ
   YbhlRgkjoOaLy+2PRfiqT5SwZLggx/pABqB6KUqqbyQTtSagiLTHkK2xG
   XLZrioh3dWqRUFV6eKs7KHiY6vL6VUvEFF/DVXe+jPQnFSkmz0SCuYNdM
   NalUQN9bV6XaMab8IThYvfuD42uchR0bCUqDVfeO6Bkk7b9MlIqCJGIcA
   gRAO62GutCefs1k/POWPeHGiTa43Lwn/oGjHjFst3s6ROXitRdGjQajIr
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="asc'?scan'208";a="164817496"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2023 00:13:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 4 Aug 2023 00:13:00 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 4 Aug 2023 00:12:57 -0700
Date:   Fri, 4 Aug 2023 08:12:21 +0100
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
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
Message-ID: <20230804-hurried-elixir-b77578ddae35@wendy>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-2-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aHambHD2gXVm6iiL"
Content-Disposition: inline
In-Reply-To: <20230727103949.26149-2-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--aHambHD2gXVm6iiL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 06:39:46PM +0800, Minda Chen wrote:
> Add PLDA XpressRICH PCIe host common properties dt-binding doc.
> Microchip PolarFire PCIe host using PLDA IP.
> Move common properties from Microchip PolarFire PCIe host
> to PLDA files.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

This also seems okay to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--aHambHD2gXVm6iiL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMyk1QAKCRB4tDGHoIJi
0jo8AP9mp/DjIQodmIkimOoh1nEEG4St1B3D2r2kOSM7HBsN6gD/emM2HEumOU1C
vY6VwJDYX6/5r7sYLdZzNqydpNEG+Qg=
=zwjs
-----END PGP SIGNATURE-----

--aHambHD2gXVm6iiL--
