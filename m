Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB179DD84
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 03:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjIMBYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 21:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIMBYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 21:24:34 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D3C10E6;
        Tue, 12 Sep 2023 18:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjpM+t/W4+ydNHSpsbuWRs4oNG19fGsZnhrNwgFC7V9NvswY5epbxPwt7z6h3glf2oKrSsfV2eEEJCPBaebH7BxdLkbTY5Tda8pJs3Z1qOa3c+5iOowg6dsRdJguAm5VXA3HGyB7W8qjPldWb/OkJ/aBbSOP9x/qcUEvVOB3JL3ssx1URbhE9yCE1uC854XwEzqUR5Pc4EGqB9NV403K0ARmsANdFHGcnOIjvfD4G1SJQD+smPlwMxFgYG/8bAhyGhxhc1Yknj0ONs3Ba2mIE+z8/pWn0Su/udS9Q1HoQCmR8WophBwt1siBQVKGzGfX4FarK4GIyhmNF40XgrMVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEN7jBNS2ItPpPurSXuw84UUdxus0EVK7if9NjznfS8=;
 b=awWW7yM7GaFG45A9spkdLwMcuelYV7dc8VOQ3V1ZA4xMsnV/nppywDItXHct+BTQSpcyv2kr2phTph62gsqdn+IMMtlqbu24xnyCO5m2wz//F9oK1j5orLVWvNWQxkkmNOTTqi2/HvwgzD/zpOR6DjW3LwGQvbZurQLQ25jYnQAFFU7J0h4o2lr62xvaQ13+qUzZYKXo++rBAvF3jICICdPloOD13ONcWfmBopw1IEJQcmWUp2zd3kl2g5ue0n3iLzq+r0gN87LFRrjUaLHYpCc+JslBddCa0SoBt21W3DUgoOriCnkJ0i16TwYi3HpBQwCos078rFT7gItulESrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEN7jBNS2ItPpPurSXuw84UUdxus0EVK7if9NjznfS8=;
 b=ORBaKBF/CH3tv94BRIrfHBN+8HYvIVgE5ChkognefaRUtP1ddMtpnmP6lixj+CVRmeMWvLiQYlnbvwr5h9ilSPpOFPPv+z8d4ECx1lkT/2O0LYkuh9ChkD6A+uY0atwlAUOPRXuPiZUQAXeAhS/gHXkiosuGn2cRt1xap3I07vM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBAPR04MB7221.eurprd04.prod.outlook.com (2603:10a6:10:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 01:24:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 01:24:27 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Topic: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Index: AQHZzxhuyRkzZgDao0KEaKWaunEMhbAX8PmAgAAxQqA=
Date:   Wed, 13 Sep 2023 01:24:26 +0000
Message-ID: <DU0PR04MB9417E04B52A553984D83540188F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230815013744.45652-1-peng.fan@oss.nxp.com>
 <20230912222215.GA412293@bhelgaas>
In-Reply-To: <20230912222215.GA412293@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DBAPR04MB7221:EE_
x-ms-office365-filtering-correlation-id: 358e17a2-2f43-4c4c-f2fc-08dbb3f82bcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yzmw8yKqEWw5SPthgGPoqwiSgk4AM6SCDPrBmc2Z6sacGlfX57GCVzKtXxrdyh88J63t9o5ZyW7hnvyPxmWlVLH81VN/fGKMTn1IJC4hoMrTE2k7tfSzZSSAFP1Q8aWL9P1HzjgYNVRQCtUI+a1BokfgW0uy9gD5PV5KR5v40GYEs7UrybWKS3MG4FtiQVeJTIXXd8Qv8IVobqu630iNxp87kNLWR8Qdd5X/AzNCUkGHNOka1MHjoI5+C10EWdzuta9TY7PRP2QPfopVNNP3kJ8elR2nEYSMZDLRqiELjWG649QEge7VxDR7skIzP5QnU1lKat1Y7guGl+FgY4XzGXoIlKsoSYkqoTNSUv+IDg61sTcKgmujyHZUEz/+K3f9ngLEH5J9AQPkRPxxl81Vqn2VH6+5dUU6zYdtq3LP7DbIT2+JY/gOBrgzypY5yU5fD3obyqz12DRruPM+eHQBwrHSqplhaV8+OlyFWdLJUwpVUdDcCUC0mEnxIokBkx/eu/Vk2BHtUNGpNx0wkJJpOZjgcDGeSmVNSdWIaDDydekSLcyTywbYJy2ccogvWoGRuwmEyXTayHvxI7PnTM4X7La9CuEDdcMTw8+W+uMrEJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(110136005)(316002)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(64756008)(26005)(83380400001)(71200400001)(9686003)(6506007)(7696005)(33656002)(38100700002)(86362001)(38070700005)(122000001)(55016003)(478600001)(966005)(2906002)(8676002)(4326008)(8936002)(52536014)(41300700001)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OI2L4JtDDnqGPM81zKq1tcxVCaMCmb/h6+S/t8ODvRyOs7UObbLb+Mb1miOq?=
 =?us-ascii?Q?R52fPXIP1EPgrP7Ksf2+68vusi5klYy0laoXwUq1AZ4aE6zdoRqBndI6LiHD?=
 =?us-ascii?Q?mTj9MPxnt5NLHElLlBiII674NiGVIyLZy7wUsVwAJogfrxzZTDGEc3WT64Kv?=
 =?us-ascii?Q?2DrhGS5F5X8G+GrjfiiMPTa0XulwapLv8uTJdp6LSsw9jEfzZE4LlrrRsjZm?=
 =?us-ascii?Q?gU0aR69cNrj1oXrNqGNBveNqFkDmjMD4V+V4JG1TuKBODVGt3FoEx8/xs7TC?=
 =?us-ascii?Q?1VJoGPkrOQSpXM0UWTrP3XaMra6ZOeyVzFvGhSJ+hcpJDTSADh7wUhB1Olxw?=
 =?us-ascii?Q?hywlIM26PFzxKb00P3JbZupUghxbSm1f+9tu3JKe0KnfIPxLnhWplrSZoGhf?=
 =?us-ascii?Q?m3hFwdJR8XTuch/Wsv42fg4XpaPQm3AqOBeZsz5ctO5/denmwRRJEtMb3y8M?=
 =?us-ascii?Q?zRLTC4smKeZczekcBI8d2CU9yd281SFdiJ3+Bgj39+pNi5ZgGLqPL3Zaq1WA?=
 =?us-ascii?Q?VjyJMB8NLbl0VjvLaZp0etQgsFBbjX8iyO7iQGIUAtLkty6YbVpCBMTSA7KY?=
 =?us-ascii?Q?4jabuSC/UOkLXj8x6oM5BdUIs7m47nA/8pwaq3Q7S0avzjJ2DmRTPbULmcGe?=
 =?us-ascii?Q?RKRzZHFQkCpgWVlDXvMv8x0s67jRLt/DB4WArv5qw5BuUOVxtPWKd2LEmbZW?=
 =?us-ascii?Q?+y9FDVN0BAY9r7Vewgs4drPwm3Zm5F2BAX62RM3nz4/1S4kR1vXqHFB0yL89?=
 =?us-ascii?Q?m68ym9HHzZIukYE3hdsfQyFhrsBclWUNk3o0YuOBiE9mYucHiyH5XrZROzsD?=
 =?us-ascii?Q?xR5oT8yOCaK+LLrO8SEd3Sk7YUbp/ifHzES1xDE4W9VXKtshDZKbTIMf/TXm?=
 =?us-ascii?Q?COWSfY+11FTQonCEXwKjVXtJCf7xPAqqev4qedqC9fEOlHhZhHZRju7uBgOs?=
 =?us-ascii?Q?cPWr/OIeJbKdXfzog9bL6w1ei3U56hOhh3QZkaH10mObDJgVNINfzCSuBKYv?=
 =?us-ascii?Q?I8N1076LP0lcj6FVA54Kd9uYBdrqT2EE6CqcutoO5TMix+ilGuRKnXfKC4wj?=
 =?us-ascii?Q?I4KS85jFKkxRmqHRBDmmJOszXuw2qnrM1ehTsVfhFXZom3VWNBQE1g73NIrk?=
 =?us-ascii?Q?NoJsPKeSOTr/olt0mTxWU+pqaWzAN/eQZUva0+KsPxPIPHasEz+HVJS2+COD?=
 =?us-ascii?Q?sFQHcdkAlDDFyLD9gZNZYkbaeCSvM8//05ctgyogv+r6NFxspd2PpFQQjhbI?=
 =?us-ascii?Q?+PGcA70VhVhk8b+3qDmEx3YKTtkCU/wWltmCiH8wid/69IEPS0DWafFY8Ls3?=
 =?us-ascii?Q?DzQwDuMFq8UEGeQY1BEqAvFekswo92rNPYxgZVNlwc6uCHMx1Y3r9+ayFqmS?=
 =?us-ascii?Q?F0BKxvA5/Gn59rmTBvxm/PoQrteQI4YDG3rqjz6MjsMNkRsSlNrQKMGutrOG?=
 =?us-ascii?Q?ibdiE+4UrGIwglMOjy76pjPtVKUMFT/GgL2EWkPir39kFCDH3kJn+ljkZNgk?=
 =?us-ascii?Q?nDqpo7arbAfUm+Y/L3z2CR91oPkkeoUvJAfdDwmBsodc08XtzYqWga32Fp0S?=
 =?us-ascii?Q?sS8FsSfOmW+XTkw+vW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358e17a2-2f43-4c4c-f2fc-08dbb3f82bcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 01:24:27.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jDy6evGUk5CUQvjY0dTBlDtxOvRDgczRqdBrOXA7U4M0zZfJ/lRU0kOtVec6eFiH8Ll5cWFSHhVHcTej4RRcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7221
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr fr=
om
> which IDA
>=20
> On Tue, Aug 15, 2023 at 09:37:44AM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When PCI node was created using an overlay and the overlay is
> > reverted/destroyed, the "linux,pci-domain" property no longer exists,
> > so of_get_pci_domain_nr will return failure.
>=20
> I'm not familiar with how overlays work.  What's the call path where the
> overlay is removed?  I see an of_overlay_remove(), but I don't see any ca=
llers
> except test cases.

We are using an out of tree hypervisor driver:
https://github.com/siemens/jailhouse/blob/master/driver/pci.c#L483
>=20
> I guess the problem happens in a PCI host bridge remove path, e.g.,
>=20
>   pci_host_common_remove
>     pci_remove_root_bus
>       pci_bus_release_domain_nr
>         of_pci_bus_release_domain_nr
>=20
> But I don't know how that's related to the overlay removal.
When the overlay node got removed, the device removal will be invoked and
the domain number indicated by linux,pci-domain should also get freed.

But actually the domain number not got freed because of bug as this patch
shows. "of_pci_bus_release_domain_nr will actually use the dynamic IDA,
even if the IDA was allocated in static IDA."

So after the overlay node got destroyed and our test recreate the overlay n=
ode
with same domain number, issue triggered, the device could not be
created.

>=20
> Is this an ordering issue?  It seems possibly problematic that the OF ove=
rlay is
> destroyed before the device it describes (e.g., the host

No. it is " of_pci_bus_release_domain_nr will actually use the dynamic IDA,
even if the IDA was allocated in static IDA "

Thanks,
Peng.
=20
> bridge) is removed.  I would expect the device to be removed before the
> description of the device is removed.
>=20
> > Then of_pci_bus_release_domain_nr will actually use the dynamic IDA,
> > even if the IDA was allocated in static IDA.
> >
> > Introduce a static_nr field in pci_bus to indicate whether the IDA is
> > a dynamic or static in order to free the correct one.
> >
> > Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  Update commit message
> >  Move static_nr:1 to stay besides others :1 fields.
> >
> >  drivers/pci/pci.c   | 22 ++++++++++++++--------
> >  include/linux/pci.h |  1 +
> >  2 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index
> > 60230da957e0..5c98502bcda6 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6881,10 +6881,10 @@ static void
> of_pci_reserve_static_domain_nr(void)
> >  	}
> >  }
> >
> > -static int of_pci_bus_find_domain_nr(struct device *parent)
> > +static int of_pci_bus_find_domain_nr(struct pci_bus *bus, struct
> > +device *parent)
> >  {
> >  	static bool static_domains_reserved =3D false;
> > -	int domain_nr;
> > +	int domain_nr, ret;
> >
> >  	/* On the first call scan device tree for static allocations. */
> >  	if (!static_domains_reserved) {
> > @@ -6892,6 +6892,8 @@ static int of_pci_bus_find_domain_nr(struct
> device *parent)
> >  		static_domains_reserved =3D true;
> >  	}
> >
> > +	bus->static_nr =3D 0;
> > +
> >  	if (parent) {
> >  		/*
> >  		 * If domain is in DT, allocate it in static IDA.  This @@ -
> 6899,10
> > +6901,14 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
> >  		 * in DT.
> >  		 */
> >  		domain_nr =3D of_get_pci_domain_nr(parent->of_node);
> > -		if (domain_nr >=3D 0)
> > -			return ida_alloc_range(&pci_domain_nr_static_ida,
> > -					       domain_nr, domain_nr,
> > -					       GFP_KERNEL);
> > +		if (domain_nr >=3D 0) {
> > +			ret =3D ida_alloc_range(&pci_domain_nr_static_ida,
> > +					      domain_nr, domain_nr,
> GFP_KERNEL);
> > +			if (ret >=3D 0)
> > +				bus->static_nr =3D 1;
> > +
> > +			return ret;
> > +		}
> >  	}
> >
> >  	/*
> > @@ -6920,7 +6926,7 @@ static void of_pci_bus_release_domain_nr(struct
> pci_bus *bus, struct device *par
> >  		return;
> >
> >  	/* Release domain from IDA where it was allocated. */
> > -	if (of_get_pci_domain_nr(parent->of_node) =3D=3D bus->domain_nr)
> > +	if (bus->static_nr)
> >  		ida_free(&pci_domain_nr_static_ida, bus->domain_nr);
> >  	else
> >  		ida_free(&pci_domain_nr_dynamic_ida, bus->domain_nr);
> @@ -6928,7
> > +6934,7 @@ static void of_pci_bus_release_domain_nr(struct pci_bus
> > *bus, struct device *par
> >
> >  int pci_bus_find_domain_nr(struct pci_bus *bus, struct device
> > *parent)  {
> > -	return acpi_disabled ? of_pci_bus_find_domain_nr(parent) :
> > +	return acpi_disabled ? of_pci_bus_find_domain_nr(bus, parent) :
> >  			       acpi_pci_bus_find_domain_nr(bus);  }
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > eeb2e6f6130f..222a1729ea7e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -677,6 +677,7 @@ struct pci_bus {
> >  	struct bin_attribute	*legacy_mem;	/* Legacy mem */
> >  	unsigned int		is_added:1;
> >  	unsigned int		unsafe_warn:1;	/* warned about RW1C
> config write */
> > +	unsigned int		static_nr:1;
> >  };
> >
> >  #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
> > --
> > 2.37.1
> >
