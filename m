Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FFB773CF3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjHHQLw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjHHQJv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:09:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2807AA5;
        Tue,  8 Aug 2023 08:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5b6JCCTYj2XbLXRos+oRhy7cl3JZjso7ZeWU73x03NQZLh5vVFG/BIBcOzG8CNSjsBPV/EXHaj+XhB7Ua//fKxldrxditWnv+GLX5qpeYxLGWQWxMdkjV+gWnfmEYKkYs9YgZdo7b1xRAImsl4l9i6H8y7OuM0bt1cQWgPJ3wIBXnaYS3nlKDKk5UcDiUcDPqdyH65NyNV7t8QCebxwAYfCMzEdDA0cIgKEfs8VdzPl9sKBwzaynEI+OvzX859CJctIpnP5UpWIiA4DfFK/7sVjKvH1A5uxyaKqPuhWZ5rjXTGEmFZWo/ppwNCka+AQSgUVvyMvAMsfJDYgkQ1y4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/XtOdK1cN94ZGDenCkzhRELyei+cDJFICHTKbwW70M=;
 b=Oedk7AWVW7w/9PosfXL8Zgpa4Iqi9l05hsABOy1aHWkoKPSzDRSA00BlkZL7a2F6JYkHju2sTZkLGSb1lqCINWvwkw4YuXuDPw1oU6N1fJ0TUmyZkLVRp+u96OScfw35LxhTz7lJ8iHGb/FPswCdR+o42/iXo3MClklYA57mnFitiK74aWFLz/b6gNAMtEzkyVZ8nhp5HnN7KIJJkXe5k8j23rIQMcuQlbZcYsMZc4OwXTjN7CyUQzFLeWJoQ4DOa7/wnVBnmTQu2TAzque+xCb3de7vH8CCj5zFn5GOKalLSCu/KhhC2tCT9LXWc5p1r/B0JPSOrfUSvOlsu4Osug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/XtOdK1cN94ZGDenCkzhRELyei+cDJFICHTKbwW70M=;
 b=O1zUpMYA1Id6JneT95ImnkHbFX1fJJFQBHQK63fT2/lb3j8yN/zBKBKzOyO41s20FZycrNzzdtVg+5T2VF1MlMXAS+ptOUnM2J3uv7+Qia8K8n54pyinS5Y+c0tQeuIsVqnZ5RV3wWck+5yOHQ7Xe3VP/QnKYcssCnhyrin/Fes=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by MW4PR12MB7215.namprd12.prod.outlook.com (2603:10b6:303:228::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:37:16 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::2525:9c2a:5446:7605%6]) with mapi id 15.20.6652.025; Tue, 8 Aug 2023
 10:37:16 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and
 remove unnecessary code.
Thread-Topic: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and
 remove unnecessary code.
Thread-Index: AQHZyR9k3YX556aszEm+kE+St9Sx46/fWJEAgADdhZA=
Date:   Tue, 8 Aug 2023 10:37:15 +0000
Message-ID: <SN7PR12MB72017A6EBBDCED5121CE9C658B0DA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230807110733.77364-2-thippeswamy.havalige@amd.com>
 <20230807212328.GA272179@bhelgaas>
In-Reply-To: <20230807212328.GA272179@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|MW4PR12MB7215:EE_
x-ms-office365-filtering-correlation-id: 4c2cb6ad-2056-46f2-5eb1-08db97fb6f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nmhrDLGdBV2+fE7TIxRh4TSeVPcza8yf9OM3ET5EhMK0+O0ubuffEbgBsw1q8Pj/1AGtZx0Dx/bSK5kxZLP7PYkqwGuqtxRFJbhmvxdLHqfUqKYTl8hqaHURo0i9w+cBfnWlkt83MqZ8AMzSQ0tUSOzl0sIaLtyRCX7Qv7db58zcS1XDCW919nRrZoj/cnAMFCsUqgCipWjhmlAkmyigProVRrv815aXJrQjVfFh16hHKCHyKcC5eAqCl8rs5tMZ3ARiNXMsJ4xpDwU3RIYpTV21tun6Hz+AMHXcBR6t7JWKxaEvJ/gf1YZbd5f6UMB1j4CfXpKWDn3q5+TRb4f8IewWKfp6N4YU5uvN0kJ2Ln3qhAuFR2Nh6TH2phkjNucg+nEbZg5+1wFRsV+TT4lV2KKj/tNeWvS4CRXlSynHt4TeYEoQ+GiwoduCBZIUvrKUY0h1OMseukFLDDkOPKX5qhx5o8B+51dTDmFlWv0PasNdkYzp4qDIsvRzw0bX0cyQ7UmF6BtAMTdHDzKITj86rPNpa378hOkE4dPsZ40WLVARzPQnIDmcbMpXvE3HOElvtpRybWQx19VDYnAtC8yhu7atk7PQgdZBRNjTN+NdJho=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(186006)(1800799003)(66899021)(316002)(83380400001)(2906002)(15650500001)(122000001)(8676002)(26005)(38100700002)(53546011)(6506007)(5660300002)(7696005)(52536014)(66446008)(76116006)(6916009)(41300700001)(55016003)(66556008)(66476007)(64756008)(66946007)(4326008)(478600001)(54906003)(33656002)(86362001)(71200400001)(9686003)(38070700005)(8936002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d3gtx9KXNz8Ctz92MBj7+UWicGOOc6Hl/BBoQydTSi0o9GNrQVk1BQSGSrT0?=
 =?us-ascii?Q?0xPNxm6rb/tE4gK5jfjjZ5nC3UR1WIoeoF8NiiI9m5/MVxyrkcTruRn1yq72?=
 =?us-ascii?Q?5v8zqTzFLE4J0QAtBLNweLjuYYF7yAYlCuGl2Vly6LC3SIbPbJ1eDzGZippr?=
 =?us-ascii?Q?A0w6R6TGf0s8wYwBl92s2plftioWeWcvVT+N+1fkxyP1dv81RSjSOnGW69q1?=
 =?us-ascii?Q?o/hMaU7hkOeEHNlkzHqx2X/GD5j+szEV/WklCFsNNYPcdjhK1/c27y2cEzOP?=
 =?us-ascii?Q?A3k4zKeXyMx6/3GwBcTdPlrwCuoelwnMx9bVAo/4WXF2ItED66nlX8tvkB/u?=
 =?us-ascii?Q?K8D6LlTnMRLyykru/lCzKbXbCep4hmfKkZ0Of/JkGmIrCx7FQEL/9aGeVyMw?=
 =?us-ascii?Q?B/e5jNbKS9njb1tEw6ybWJs6gQy7FoqYACTlQLrBgOqKJfRPTJQfDUk7JlLM?=
 =?us-ascii?Q?bJ+uZpW1eBaEcGcW6mpJLlxQRIU1h+Q4k83H46VdCB3lp/rMoATqaAbOpNu6?=
 =?us-ascii?Q?2Iqj5WQIvVQTieJK7/HVGQBZEnPv9YZAm6HfG+CDE3caE8hqsvoN8w7GV1iS?=
 =?us-ascii?Q?8e3MpIZ0FirGC52DfQZd/z0Iz7RRvl8hFcmnuA4WYqbW3DuQ/Ay2dhZLg4ww?=
 =?us-ascii?Q?2YJi/KWS50fs82R7jEuemWzlzWccO0g8xlEXXr98Wj6rhJu6rXYA4DEqHb9R?=
 =?us-ascii?Q?tA4WOr31947hRktCMJe4HAjj0a6M0gUzvZE/S0VEMKwKIuJs5aT9nYAQ2fqc?=
 =?us-ascii?Q?xWv3NzPZhPZVJ4F0OjgRvLNa7ZWz2ZTSHBEITM0uvYx3CKWDgLkvIREn4e8I?=
 =?us-ascii?Q?aQgnI3C89/UwQeTVwtMMGZ2OuOJBo14elz+NJGSA5FysYIa5l8HOl/N+toYR?=
 =?us-ascii?Q?O42c6Y8aeB0MOWjlrlDD0gJ4Vg3j1qpi2ajGPyj0bbyc35DVtsZLfIFT9U5t?=
 =?us-ascii?Q?pBpoyZUgmuuDh3ibwPJ09fmEYU49ppM/TwfTMzF+Rwea5kxJOuNlFNSPSFBm?=
 =?us-ascii?Q?VDciGu4BdrrLJxczfYU1R7nfXAGOkp6jj74CPcwAIkQpVLkblopIDxIdvHtk?=
 =?us-ascii?Q?icnLWdHNUi6keNL1cO3YV+EyNs1QzDj9gapiRdbbAS2Y50O5urACThD2eneL?=
 =?us-ascii?Q?pGXkhKSoFxJdol5flOqfIwAS4J7EDeiaKCMYhgzZiiwpBS3JwoOQrnmow0aC?=
 =?us-ascii?Q?nXAqWejXPMA2TEPQWvoh5Ih/mOJ56djFbdQPyXzdQ/uz/qD9+WAxiOCea9R1?=
 =?us-ascii?Q?gl9yboqbQ2TKDjd5UhFjfKTsqCmsRYyKPj38xMDzw7ZhhQYoAJYbcMW9krcE?=
 =?us-ascii?Q?folYvKD2EW8wUAupkYT1r3XOdnHln1mBZL8/ifHyC69fCnpE8keD/mbHs5vA?=
 =?us-ascii?Q?WkSTrkGFdDMs7iYOzLsTb6qjc+QpN3Qg3njPTZR0EcZM89KF5v3ueyCWdWyC?=
 =?us-ascii?Q?HuamSMzBduwf727F1Wb4bAO7vFnfr9OBntDMDnvKTwCsErI/8jqpi7F2qz6o?=
 =?us-ascii?Q?HYxqdJjp0uti6hmxXQmKIcewQRFXZbVdS/st7ndK4WE5MM2yShgOPVnPdzCH?=
 =?us-ascii?Q?Mh98H6cWvCTIVEk4wN0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2cb6ad-2056-46f2-5eb1-08db97fb6f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 10:37:15.9405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdISUOTq08UXgxp9PBu0J9CQ3tGnsilrVlVFz/mkjuqMGDVvTLHFOffLa7pAxS6nLUuplWOCvgQ7CMQKMVJBhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7215
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, August 8, 2023 2:53 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> bhelgaas@google.com; krzysztof.kozlowski@linaro.org; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; lpieralisi@kernel.org;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>; Simek, Michal
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value an=
d
> remove unnecessary code.
>=20
> Ideally the subject would include useful information about *why* you're
> changing the ECAM value.  Drop the period at the end of the subject.  E.g=
.,
> something like:
>=20
>   PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
- Agreed, I ll update in next patch.
> On Mon, Aug 07, 2023 at 04:37:32PM +0530, Thippeswamy Havalige wrote:
> > Our controller is expecting ECAM size to be programmed by software.
> > By programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access
> up
> > to 16MB ECAM region which is used to detect 16 buses, so by updating
> > "NWL_ECAM_VALUE_DEFAULT " to 16 so that controller can access up to
> > 256MB ECAM region to detect 256 buses.
> Rob needs to ack this because it sounds like this change might make the
> driver incompatible with DTs in the field, i.e., the user might be forced=
 to
> update the DT at the same time as picking up this driver change.
>=20
> > E_ECAM_CONTROL register from bit 16 to 20 uses this value as input to
> > calculate ECAM Size.
> >
> > The primary,secondary and sub-ordinate bus number registers are
> > updated by Linux PCI core, so removing code which is updating
> > primary,secondary and sub-ordinate bus numbers of type 1 header 18th
> offset of ECAM.
>=20
> This code removal sounds like a separate logical change that could be a
> separate patch.
>=20
> s/primary,secondary/primary, secondary/ (twice) s/removing/remove/
- Agreed, I ll update in next patch.
> > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > ---
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes:
> > | https://lore.kernel.org/oe-kbuild-all/202308040330.eMTjX3tF-lkp@intel=
.
> > | com/
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++---------------
> >  1 file changed, 3 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 176686b..b515019 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -126,7 +126,7 @@
> >  #define E_ECAM_CR_ENABLE		BIT(0)
> >  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
> >  #define E_ECAM_SIZE_SHIFT		16
> > -#define NWL_ECAM_VALUE_DEFAULT		12
> > +#define NWL_ECAM_VALUE_DEFAULT		16
> >
> >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> >  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> > @@ -165,8 +165,6 @@ struct nwl_pcie {
> >  	u32 ecam_size;
> >  	int irq_intx;
> >  	int irq_misc;
> > -	u32 ecam_value;
> > -	u8 last_busno;
> >  	struct nwl_msi msi;
> >  	struct irq_domain *legacy_irq_domain;
> >  	struct clk *clk;
> > @@ -625,7 +623,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> > *pcie)  {
> >  	struct device *dev =3D pcie->dev;
> >  	struct platform_device *pdev =3D to_platform_device(dev);
> > -	u32 breg_val, ecam_val, first_busno =3D 0;
> > +	u32 breg_val, ecam_val;
> >  	int err;
> >
> >  	breg_val =3D nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) &
> > BREG_PRESENT; @@ -675,7 +673,7 @@ static int
> nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> >  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
> >
> >  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> > -			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> > +			  (NWL_ECAM_VALUE_DEFAULT <<
> E_ECAM_SIZE_SHIFT),
> >  			  E_ECAM_CONTROL);
> >
> >  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
> > @@ -683,15 +681,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> *pcie)
> >  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
> >  			  E_ECAM_BASE_HI);
> >
> > -	/* Get bus range */
> > -	ecam_val =3D nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> > -	pcie->last_busno =3D (ecam_val & E_ECAM_SIZE_LOC) >>
> E_ECAM_SIZE_SHIFT;
> > -	/* Write primary, secondary and subordinate bus numbers */
> > -	ecam_val =3D first_busno;
> > -	ecam_val |=3D (first_busno + 1) << 8;
> > -	ecam_val |=3D (pcie->last_busno << E_ECAM_SIZE_SHIFT);
> > -	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
> > -
> >  	if (nwl_pcie_link_up(pcie))
> >  		dev_info(dev, "Link is UP\n");
> >  	else
> > @@ -792,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device
> *pdev)
> >  	pcie =3D pci_host_bridge_priv(bridge);
> >
> >  	pcie->dev =3D dev;
> > -	pcie->ecam_value =3D NWL_ECAM_VALUE_DEFAULT;
> >
> >  	err =3D nwl_pcie_parse_dt(pcie, pdev);
> >  	if (err) {
> > --
> > 1.8.3.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
