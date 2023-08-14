Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6777BA9E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Aug 2023 15:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHNNxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Aug 2023 09:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjHNNxX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Aug 2023 09:53:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D610DD;
        Mon, 14 Aug 2023 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692021203; x=1723557203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0KD1L1RDnuKAhdqbw1tkprSQp/H4jNSydLSzkdaZqk=;
  b=gntor0doiKPsEiVBitZUx6h9vxsqbiu1vWjfXl9ojktPILkWDM2xtBbG
   AuntiDFTqWceSmJFp7F35sh0bxqzD8nz3JYEya9SvmJlvbTebASBQSlki
   eP9p2Ifo3tzSp2xy74afQhYUfta5nPM9A3htOYQTVhOozMaxpy4kn9sIn
   MT69z2cYi7KgyUABSR9pvcDG3JOWUmm5lgUcvVFAgekP4GE53QmS3njiY
   qYqAHfp2uA8ChrHsAnzh7Ec7x91iFd0TSmXPnkomulopUEaHG3svn694h
   wCgPpr5Sww8vZOa3MBCtxvnvm+4f+dmAK2+ShLTfOCURGCub4MZbc8ld5
   A==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="asc'?scan'208";a="225313785"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Aug 2023 06:53:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 14 Aug 2023 06:52:47 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 14 Aug 2023 06:52:44 -0700
Date:   Mon, 14 Aug 2023 14:52:05 +0100
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
Subject: Re: [PATCH v3 06/11] PCI: plda: Add event interrupt codes and IRQ
 domain ops
Message-ID: <20230814-episode-untidy-c66107a33ea0@wendy>
References: <20230814082016.104181-1-minda.chen@starfivetech.com>
 <20230814082016.104181-7-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y4kxwzWfSP8ufxW9"
Content-Disposition: inline
In-Reply-To: <20230814082016.104181-7-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Y4kxwzWfSP8ufxW9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:20:11PM +0800, Minda Chen wrote:
> For PolarFire implements non-PLDA local interrupt events, most of
> event interrupt process codes can not be re-used. PLDA implements
> new codes and IRQ domain ops like PolarFire.
>=20
> plda_handle_event adds a new IRQ num to event num mapping codes for
> PLDA local event except DMA engine interrupt events. The DMA engine
> interrupt events are implemented by vendors.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../pci/controller/plda/pcie-microchip-host.c | 29 +++---
>  drivers/pci/controller/plda/pcie-plda-host.c  | 99 +++++++++++++++++++
>  drivers/pci/controller/plda/pcie-plda.h       | 19 ++++
>  3 files changed, 133 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/=
pci/controller/plda/pcie-microchip-host.c
> index c28840315019..b42f1aac3ec3 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -96,20 +96,21 @@
>  #define EVENT_LOCAL_DMA_END_ENGINE_1		12
>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
>  #define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
> -#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
> -#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
> -#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
> -#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
> -#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
> -#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
> -#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
> -#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
> -#define EVENT_LOCAL_PM_MSI_INT_INTX		23
> -#define EVENT_LOCAL_PM_MSI_INT_MSI		24
> -#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
> -#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
> -#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
> -#define NUM_EVENTS				28
> +#define NUM_MC_EVENTS				15
> +#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + EVENT_A_ATR_EVT=
_POST_ERR)
> +#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + EVENT_A_ATR_EV=
T_FETCH_ERR)
> +#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + EVENT_A_ATR_E=
VT_DISCARD_ERR)
> +#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + EVENT_A_ATR_EVT=
_DOORBELL)
> +#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		(NUM_MC_EVENTS + EVENT_P_ATR_EVT=
_POST_ERR)
> +#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		(NUM_MC_EVENTS + EVENT_P_ATR_EV=
T_FETCH_ERR)
> +#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	(NUM_MC_EVENTS + EVENT_P_ATR_E=
VT_DISCARD_ERR)
> +#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		(NUM_MC_EVENTS + EVENT_P_ATR_EVT=
_DOORBELL)
> +#define EVENT_LOCAL_PM_MSI_INT_INTX		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_I=
NTX)
> +#define EVENT_LOCAL_PM_MSI_INT_MSI		(NUM_MC_EVENTS + EVENT_PM_MSI_INT_MS=
I)
> +#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		(NUM_MC_EVENTS + EVENT_PM_MSI_IN=
T_AER_EVT)
> +#define EVENT_LOCAL_PM_MSI_INT_EVENTS		(NUM_MC_EVENTS + EVENT_PM_MSI_INT=
_EVENTS)
> +#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		(NUM_MC_EVENTS + EVENT_PM_MSI_IN=
T_SYS_ERR)
> +#define NUM_EVENTS				(NUM_MC_EVENTS + NUM_PLDA_EVENTS)

Is this change not in the wrong patch & should be changed alongside the
movement of defines?=20

--Y4kxwzWfSP8ufxW9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNoxhQAKCRB4tDGHoIJi
0i9LAP4sQcKHRQUviJH9x11dE7n8ONwvAzh2QWhHwntrCc2kcAD+KQ0V/O4R1C50
8jAkUvBTjG95nhERLU8N++0omqA4Fw4=
=J6we
-----END PGP SIGNATURE-----

--Y4kxwzWfSP8ufxW9--
