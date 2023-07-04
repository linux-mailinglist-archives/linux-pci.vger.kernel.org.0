Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05A7468DD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 07:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjGDFWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jul 2023 01:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjGDFWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2023 01:22:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2112.outbound.protection.outlook.com [40.107.114.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00692BD;
        Mon,  3 Jul 2023 22:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuYUzB/20RBW6y+/CajBXkEe4C4hUGcM6I9lhpT5z+NcM39KocWziuoCnzBPp+E+5/sXQGg8nUOLvxC7Jtb67VNe2KP6/HQrohD+HoNaeZDwovq7okyhiGuPF87UF3VdmmjVx/RjDrb51/GICH6V5kDlVRXB0boPYNbiYK5P9NbUNBKOgsiwmX1a8VaYTDVrOdSM8TKwhiCm94t/pFJE71lTZcEOylLxSZMq9dXuqXVyhIacc12EuCRMPpApeV8FObih5Oul+9gv4JNF1YMj+VI9aACy8Ur5ksbWjiOm2F0HuVWb8ySajrZhl48SFDjoewW1rEHsga4ZlUIBgcYdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWL4bfxIcqHrZF4mvNqlS/RUpVxCMO8+STfWX6YJz3E=;
 b=j0CsU41Gjllg2iF7N72ww7AfmGP9Nmo4Uu1Q0lqRcJ46RGB+KspQ3UAP16o5p/1DGyfz7vo/qmI0P8U9qri2UZRlaBcALQyXZqbpiPgWzjEtYFl8ibHNO6TacBMdHTmnlsTVjbQ+/am2rkUDwqU0GMO4wFQz5Bn4HQOsrZqGoESkq0Vn4Zh+Ohr0OYjf8V/Jay6/hO5FGwHmkrHbkf+HYnUK0aN1/jraFDlPo5tPZDaOFl3Sjpo/LEvpMGfMIqBwAUkt+3MhyUNSW1pLk7P4iLaFpaF2LZHMN9xpp2t/nSsuEQgjUiRfsVT6T1OiPeoeVl4xaFajOVv+kqTVWqlXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWL4bfxIcqHrZF4mvNqlS/RUpVxCMO8+STfWX6YJz3E=;
 b=FrcWM6DdHGZWm/tE4vOrZPI0ZxZaHhK+wDhHSAMscqTZ66VMX4gz9bf5SNJ1tHkrSfW6yf2DU+ChstneXkPcKlVXeM+upzGGqA6VI/h/c+mz990qqs7Bh1/uEARTBUe4uXeu4a29tyjM71tw0tBRXguShEYGFSOpzZFvdHSul7o=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TY3PR01MB10142.jpnprd01.prod.outlook.com (2603:1096:400:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 05:22:18 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::3b0c:473f:654a:ac11]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::3b0c:473f:654a:ac11%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 05:22:18 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16 07/22] PCI: dwc: Add outbound MSG TLPs support
Thread-Topic: [PATCH v16 07/22] PCI: dwc: Add outbound MSG TLPs support
Thread-Index: AQHZgwfSPYZaj5FHAkmyyykV3aweKq97f7iAgC3oS0A=
Date:   Tue, 4 Jul 2023 05:22:18 +0000
Message-ID: <OSYPR01MB533460C1575F468D07C22362D82EA@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230510062234.201499-1-yoshihiro.shimoda.uh@renesas.com>
 <20230510062234.201499-8-yoshihiro.shimoda.uh@renesas.com>
 <20230605001553.dqblit4jxyupee35@mobilestation>
In-Reply-To: <20230605001553.dqblit4jxyupee35@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TY3PR01MB10142:EE_
x-ms-office365-filtering-correlation-id: 1c56ae77-70c6-46c6-fb7c-08db7c4ea2a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vneiTGrp0D+rKOtffVpYuPIlL3HjWlLjgUvARx6vbMsooJ1VtI3QY0CUi4MlHLwo2YK6loNo4vBMZ0mVaG1O5lDMokCFC6WkG1HlTvz5VxZuW/gBBelyONWuNfblcc9/bElP+ouOzsKKXXoH6VgVNUGJf9bnLcTCJgjC3QMJDXBq2lq7cpiFbzue7laq0Px+3jgLVj3kISC9r/zkBod/zkEQ79MRnupoYEbTC6zEb1cjQYYY14SuU63GGrMZ9czAz7XzbX6RlUMaObG0WgO66ksOOqpQx4oEwPJSqF2YH8xC+c4QVvlSNV6avpejukvinaEw+qA9vDqGAg6Vl32+Miw1oMwvzzeu6ERj9S+N+KeNzqld4d1p62dy+LfP0vcmACgni2rLWysGK2Jsu8IftvosymcnAhuLtJdEYRg1vlSDxj8NT6NtCQ3GJ0HKjYvY+0O52i06SKpt5hUMTMZGIlAvYSHNoLbMib5AvpHxneqt22MqqZNESW3fi5yLCpLCXogzQC3+avevDN7cX9P0fWYQIWau+umNqX5f9wuYO08p3AtbAaJoh0cEydKv7itybImnmiw0Rlsm4AtDbRZbihIbV7P+ueaHJV1HVGUJuxbhEvPRUrcCeNacsE1ITFI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(38070700005)(2906002)(66899021)(41300700001)(5660300002)(8676002)(8936002)(52536014)(7416002)(33656002)(55016003)(86362001)(186003)(478600001)(6506007)(9686003)(71200400001)(7696005)(76116006)(122000001)(316002)(66446008)(6916009)(4326008)(66476007)(66946007)(64756008)(66556008)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b+45WJlYCET41KW59zwu4tXksOVta5foWPFlx+gqhxRnZhQp4/OpbNOnM/hu?=
 =?us-ascii?Q?5nLEDhftVF7pi8PwlFgulaK0p+bhNk7jNYDw/F3f0FdCOQh7uHZpKkHy7fl8?=
 =?us-ascii?Q?kkFhltl/rjarXHte4H/4QqMP8TCX2ftsEPZ1urmXPYKCsOtBcp3kqT2DBQGW?=
 =?us-ascii?Q?wQdZ+2PHeuhzq/XKJ91E3Z7gu5XWSPv81WdqDXb5n/XcUW/jh0Za6SjDpk1P?=
 =?us-ascii?Q?4MmI6XfnF8tcXBiT1T7oK/iYmzELLEfMDTRNYwXG8Tt4O1CzIhgLUJEOKLsV?=
 =?us-ascii?Q?aT6MsyIEChSSb6nVk21IE21P5oJ6GuBn4duJQmFnOzJsS/mhveZl7tOtUR8X?=
 =?us-ascii?Q?aR0zPQkV5fDekkfuefRRZO5wwNrnMqhWaIXU0ex0HghuIQ2kr6xD0SUyZNkX?=
 =?us-ascii?Q?FzyprgS1L0B0ZIfBb6heVCLFucESHOzCZ/vOe2ibRjs6hT3xIZBN3xCcAkg5?=
 =?us-ascii?Q?+ARSoV4/lnVbf3GfoN7L3FvzE+i1swzI7ee6DlT+ZKVlcBLiSzygnO58iH8h?=
 =?us-ascii?Q?08dhVBzXsTINQm28M7XxSD8peAZdJStJ2vzJM1EAamXnbU6ULZXk5xwsF6Mz?=
 =?us-ascii?Q?U99MRHm5OP9lZnWU/YTPG3LXdH9EJpUGFXC7ca38LdxCyUBa3ftyqTxoDRbD?=
 =?us-ascii?Q?jZPysr4CSo+OPrO3Cjnz5Aq1ReW4/rrmNaBWMHJ84lqWuwWcXpBKLt2vE6Mk?=
 =?us-ascii?Q?ZwdpWVu/3jsopIG3At9oyKPlXuxkWw297/uLmCYbDpm9idYlRMrcLMgED7Cz?=
 =?us-ascii?Q?eSXTWr6TYsw/nsYw0CVtLGMhtFxqBz5hv9QY6gRz7FFZYusBFGj24auxz58n?=
 =?us-ascii?Q?EoRobpsEkwtfZNpAPhPMDeobFm5bS3DkSEAR/+zrvR5hvanwrAHHynmuNw4a?=
 =?us-ascii?Q?b4XcY7uVY4FUCgR5LR4zfWolk5/TnEant+6N1+umP1cZTGTKkbgaUGYPSE2Y?=
 =?us-ascii?Q?lcSXPtckULxqkjip9btV5pXYO9Tpugzh4vmc7Jt/MjJe21o15UW/iZH61IIC?=
 =?us-ascii?Q?61coBJHRjwQ4lVOh9u0y+P65WBWzTv5C/BjFiQKplCBpcsamnMot9hFNahGP?=
 =?us-ascii?Q?er+2hlN8ocj0jaZt+cgg3x8UEDjq0PyLJRJs+KB857xyGt5hSCAqNDmZakwc?=
 =?us-ascii?Q?nWiXXlafTXM9gKM/CXZVGB/iZB6CKDdhGQxPbPv8tpTwtSu6POCK4LmL/+Lt?=
 =?us-ascii?Q?voJmhbHJk6q+PNGHVM+4tNXNInLt7hxL6YWH+5VTwVzmP42PbLy8YlS8+mK/?=
 =?us-ascii?Q?NsLpJWP1OgA8++7vVhMNkZN9CfMDCrrd0Al6gyl4ns4yiyGLFw6i5rmvoVzt?=
 =?us-ascii?Q?Qz/bhqxILrLCc63yA/HXVVrnfJVfvPMBzp71k6NCY3JfylqELvVnrwEG48JG?=
 =?us-ascii?Q?6T4+MOjYTEyZ/O99M2KgJpSroHHRON8s/Gn6++9jAFNwJ2DDdyTmpgEUig9S?=
 =?us-ascii?Q?/TRFpi39BMs1qBlXY2tUSFblliFOnj3/VqYnQEDZTQWrtaeUyd0U9VDkAc/9?=
 =?us-ascii?Q?tcyQ1aCf2+3PDlb1zHcbMMStkppCzTK94wglBQrVMgV+BNZ1pT/DaFfmeTLj?=
 =?us-ascii?Q?tpStvc3TdVFlBhnfmUU0ZWDV/FpTAQRWSOXK4MgE8SOSoo6fE5fy/bCTNdib?=
 =?us-ascii?Q?VcDM4fVO8Fo5hzC0HzOubWNeyZ9SY1qTSqP9zj/ofaDklI5LxsjE/6DdrAwR?=
 =?us-ascii?Q?dEgj6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c56ae77-70c6-46c6-fb7c-08db7c4ea2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 05:22:18.1198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /k/ehOmURLDzPLtnLnGMUqBieYiREPYzfmpeE7qJSvjil5H76phQgVzZVxRu+dpp5p3qcfI/ewr0KHJIvkLJ+oVPA3sxP/QzSvAC0sZw+ehT+GjJOnBssrOngCtbTUwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Monday, June 5, 2023 9:16 AM
>=20
> On Wed, May 10, 2023 at 03:22:19PM +0900, Yoshihiro Shimoda wrote:
> > Add "code" and "routing" into struct dw_pcie_outbound_atu for
>=20
> structure name has been changed.

Oops. I'll fix it.

> > sending MSG by iATU in the PCIe endpoint mode in near the future.
> > PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> > MsgD.
>=20
> So your implementation implies the data-less messages only. This note
> should have been added at least to the commit log. Ideally it would be
> useful to have an in-situ comment above the code setting these flags.

I got it. I'll add such explanation at both the commit log and code.

> > PCIE_ATU_HEADER_SUB_ENABLE is set to issue the translated
> > TLP header by using PCIE_ATU_{LOW,UPP}ER_TARGET registers' values.
>=20
> Why is that needed? Please elaborate in the patch log.

Thank you for your comment. I confirmed that this was not needed. So,
I'll drop this comment and related code.

> Other than that the change looks good.

Thank you for your review!

Best regards,
Yoshihiro Shimoda

> * I'll get back to the series review tomorrow.
>=20
> -Serge(y)
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
> >  drivers/pci/controller/dwc/pcie-designware.h | 5 +++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index bd85a73d354b..a7c724ba7385 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -498,7 +498,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> >  			      upper_32_bits(atu->pci_addr));
> >
> > -	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	val =3D atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> > @@ -506,7 +506,10 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  		val =3D dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_AT=
U_ENABLE);
> > +	val =3D PCIE_ATU_ENABLE;
> > +	if (atu->type =3D=3D PCIE_ATU_TYPE_MSG)
> > +		val |=3D PCIE_ATU_INHIBIT_PAYLOAD | PCIE_ATU_HEADER_SUB_ENABLE | atu=
->code;
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index b8fa099bbed3..c83d1d176e62 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -150,11 +150,14 @@
> >  #define PCIE_ATU_TYPE_IO		0x2
> >  #define PCIE_ATU_TYPE_CFG0		0x4
> >  #define PCIE_ATU_TYPE_CFG1		0x5
> > +#define PCIE_ATU_TYPE_MSG		0x10
> >  #define PCIE_ATU_TD			BIT(8)
> >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> >  #define PCIE_ATU_REGION_CTRL2		0x004
> >  #define PCIE_ATU_ENABLE			BIT(31)
> >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> > +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> > +#define PCIE_ATU_HEADER_SUB_ENABLE	BIT(21)
> >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> >  #define PCIE_ATU_LOWER_BASE		0x008
> >  #define PCIE_ATU_UPPER_BASE		0x00C
> > @@ -295,6 +298,8 @@ struct dw_pcie_ob_atu_cfg {
> >  	int index;
> >  	int type;
> >  	u8 func_no;
> > +	u8 code;
> > +	u8 routing;
> >  	u64 cpu_addr;
> >  	u64 pci_addr;
> >  	u64 size;
> > --
> > 2.25.1
> >
