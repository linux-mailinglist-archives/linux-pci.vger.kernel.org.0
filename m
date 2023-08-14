Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0A77BA26
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 15:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjHNNeN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjHNNeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 09:34:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A17E54;
        Mon, 14 Aug 2023 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692020036; x=1723556036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NIMp+ZZfE39NoCAF9Svzx2/G3vPfQ0zl1WOS3daH1Ec=;
  b=sHOOYNpQa64FZisOBFPZn3GdXFiSHeZOKybyL6Ye0z4qYLxVqRxOU3/w
   K9rGalZuiy0GiYFjZW/xewW/GcViWCsy5BRSMfJtAOB3UXD5BiIh15v6I
   gde2A2TaIIF/zQincArTA2IWDa8MMtewgq8nbIesZdTn4YmlhDZh3kW02
   MvcZK0vvJ6EksoaT+DCCEdlLUhUpsVe+4LJonCH3l8DZK+YCp5cNuEfHY
   tieNkyYcgsrG4pd+InccRJkUBFy8u7CJh671QphotC9tvrNM+HnK71QSR
   JIcO1TxR6n6WdA4GV1qhUyNETOy1Bdi0k8601DdYq0AjkXeNUVLWyMStU
   g==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="225309921"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 06:33:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 06:33:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 06:33:47 -0700
Date:   Mon, 14 Aug 2023 14:33:08 +0100
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v3 02/11] PCI: microchip: Move pcie-microchip-host.c to
 plda directory
Message-ID: <20230814-cytoplast-appliance-05c53cd612e7@wendy>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-3-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qb2FqRletKnkxHF6"
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-3-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Qb2FqRletKnkxHF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:20:07PM +0800, Minda Chen wrote:
> For Microchip Polarfire PCIe host is PLDA XpressRich IP,
> move to plda directory. Prepare for refactor the codes.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Qb2FqRletKnkxHF6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNotFAAKCRB4tDGHoIJi
0ocNAQCtStJgaZKQR6TWeuB8t1Tqmw7kv40909tqPHtcIosgBAD/cPslhEpUXgI/
MEr0ZSstM04GiNSgOOPaFIBo3mNU7A8=
=NbEH
-----END PGP SIGNATURE-----

--Qb2FqRletKnkxHF6--
