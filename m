Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57367530A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 12:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjATLHw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 06:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjATLHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 06:07:51 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222C808BD;
        Fri, 20 Jan 2023 03:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674212870; x=1705748870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tddhBs+s6Mm/9EWouBm1BqAaL6YzSOYT4DgxKFbeOzE=;
  b=T4X/wuSlYvjuO8vIAvvrjKEj9wHixGn9Tyk6trG6STWL8qc0YIA5zz6N
   NBOqDC4tDgGOYfv6qoqWaDbwz2//HPSHAa7YGj6vVrlS3EEnIg+N8OnaA
   IQQ4J3IprbG1oh7fj0SSWU5tGrPpKxSbnmYvHZFiU9WjKBtvo0uyKumf6
   kPD4YLh/Ga0+lTEZadrpMUsin6GdNNmSrDtaAIZiT/nErkjcXY+95VN0D
   qHzRjqW1eQExjU5vJmu9vRXptJPWHMQQhdaFOIOlC66r4l1RQ48raOgFt
   n1GTKQaspJlqDpVMm8vZkqZLSMDu+Q0rTTG+zBxzXUc4CKqa/HTUYsoQ0
   A==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="asc'?scan'208";a="133267851"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 04:07:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 04:07:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 04:07:45 -0700
Date:   Fri, 20 Jan 2023 11:07:22 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <daire.mcnamara@microchip.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 00/11] PCI: microchip: Partition address translations
Message-ID: <Y8p16kaddL+Ot2Oa@wendy>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nx5WSvkbl8tPQo8f"
Content-Disposition: inline
In-Reply-To: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--nx5WSvkbl8tPQo8f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Bjorn, Lorenzo,

On Wed, Jan 11, 2023 at 12:53:12PM +0000, daire.mcnamara@microchip.com wrot=
e:
> From: Daire McNamara <daire.mcnamara@microchip.com>

> I expect Conor will take the dts patch via the soc tree once the PCIe par=
ts
> of the series are accepted.
>=20
> Conor Dooley (1):
>   riscv: dts: microchip: add parent ranges and dma-ranges for IKRD
>     v2022.09

I don't want to take this patch just yet as it needs to be sequenced
with some other dts changes, so please don't wait to hear anything on
that patch from me in terms of the rest of the series!

Thanks,
Conor.

> Daire McNamara (10):
>   PCI: microchip: Correct the DED and SEC interrupt bit offsets
>   PCI: microchip: Remove cast warning for devm_add_action_or_reset() arg
>   PCI: microchip: enable building this driver as a module
>   PCI: microchip: Align register, offset, and mask names with hw docs
>   PCI: microchip: Enable event handlers to access bridge and ctrl ptrs
>   PCI: microchip: Clean up initialisation of interrupts
>   PCI: microchip: Gather MSI information from hardware config registers
>   PCI: microchip: Re-partition code between probe() and init()
>   PCI: microchip: Partition outbound address translation
>   PCI: microchip: Partition inbound address translation
>=20
>  .../dts/microchip/mpfs-icicle-kit-fabric.dtsi |  62 +-
>  drivers/pci/controller/Kconfig                |   2 +-
>  drivers/pci/controller/pcie-microchip-host.c  | 688 +++++++++++++-----
>  3 files changed, 533 insertions(+), 219 deletions(-)


--nx5WSvkbl8tPQo8f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8p16gAKCRB4tDGHoIJi
0kvUAQDhU9O835lZt9HbL0FEwtohVT3iiFZvKHnxEBL9CcpaqgEAuphEfww5Lg3z
F4LF1DiXm4CRt329OoQPMWHD0RPDJww=
=hfRX
-----END PGP SIGNATURE-----

--nx5WSvkbl8tPQo8f--
