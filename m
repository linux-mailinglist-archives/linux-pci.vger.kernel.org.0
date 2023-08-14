Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57D77BACF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjHNOAA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjHNN7m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 09:59:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7610E2;
        Mon, 14 Aug 2023 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692021554; x=1723557554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o+n2K2lC/+6MXVMwXpoXEhb4M3Ri9lMX3WQ4SO/crcU=;
  b=kyRy8v2oDO0TCrPMxq2f+5gnDTxP5am4IQzhpchov0tpGkHOpgu0G3NE
   AOXC+mASKamNI94rwlxRRUIgKfP2SqkuC8rjYfeT5mlfnn8wgukqmHywj
   Arb4c5jSLuZpuqgNvROWK/dyV/kEatibJmGRBam2Lv9DKlNdEzYLYJcDB
   zO6R9Vt+8MXR40TCmMOHJ9JyevsmvkBO5knCoJoCziMdQCvwZq59kF6YR
   Pesc69fYYqsqMQYDrLyNARkS7SgRJrzgrhV8RPEbuWTp3tyA0Ja10eyzk
   uDYe9iDuUhKnhchviMjKNAA59DBwEvt5HGhmxJceMKdgqnewNNrHXIbjV
   g==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="229722854"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 06:58:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 06:58:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 06:58:25 -0700
Date:   Mon, 14 Aug 2023 14:57:47 +0100
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
Subject: Re: [PATCH v3 08/11] PCI: microchip: Move IRQ init functions to
 pcie-plda-host.c
Message-ID: <20230814-everglade-nibble-af545e75b635@wendy>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-9-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BpOtXVbM9MWEU9jw"
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-9-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--BpOtXVbM9MWEU9jw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 04:20:13PM +0800, Minda Chen wrote:
> Move IRQ init functions to pcie-plda-host.c. mc_handle_event
> merge to plda_handle_event, Add get_events functions,
> PolarFire PCIe uses get_events function pointer to get
> their events num.

Just a nit, could you add the () when referring to functions in
changelogs please?
Other than the comment I left on the last patch, this looks fine to me,
but I'd definitely like Daire to take a look at these patches that
modify the interrupt handling.

--BpOtXVbM9MWEU9jw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNoy2wAKCRB4tDGHoIJi
0jyDAQC5T3NF7Lvf05u2gvpA5+0rWtaf3TGtB9uxGExJKF1mdAD/YgTff81PDmTT
8maYzHqwuLvlZxtbTEJunHGOgcs66Qo=
=otyL
-----END PGP SIGNATURE-----

--BpOtXVbM9MWEU9jw--
