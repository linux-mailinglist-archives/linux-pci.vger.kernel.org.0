Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E7B6F9ED3
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 06:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjEHEzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 00:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHEzl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 00:55:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2120.outbound.protection.outlook.com [40.107.114.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDB57AA1;
        Sun,  7 May 2023 21:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQIgpaa1sFUuseBbyKy637PpzC3TnCJzku59ULqJgVOBHnzIL9KIoN0aq7kF+IUHWSSjb9QIHVe+t1HAM3ZiKiGctuW9dHEa65JQ72VyWz+9EkWPp9gO6VMZytMiu+DOp2qcgrD3oaPhOQXVt1aSm0SQlBN6y0upS71+vUAcici5UAirknXbdm2WnX/FCNYXsdxKCLbFp2Nhi7OA8fVnt9TTAt8ClzzQpvXBujoAes0I2Mzpjzu1rVfNkCBsVykd1iFXRch9ao845gCAP9qLx852Yv/otA1JEofAvqvW38TaBctIDBPIUnyQ7uL7PRkjCgB9f6cNdfY7tzX924R6xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSH2THgbmc5fctr91VNFe18IIdN+U85NPYMLMghAUYg=;
 b=SCoXt1Fn7RUzHvosRKqdLjL/m6Fgzxvu7gc1qaB7LhnNzEfU849idL87ArFTBCbgv89L+WEpZGQbCW/IJ9wGMxwgq/PEseFqN+rNV7rJUviZb0dQI58z3PPWhzd52wPxg5QmacjBvY7EGinG2laZlEDWcW85itLlwDeHifm1cTcC62qpEHgxYacqX8mO+uNFKY7XwpqD3HRKwjpFQCPNXxK4rxYm+pXw7yH6EMarvF5yTzenRjyljSy+Tmy0Zz1vRAFEx8O6uyCc4J3WmNDBw2F/jKUE5QjUv8dG1Xba+A4bxcmTkaskgneNqZ/cdngfMStNMB55APKbP5vBflOKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSH2THgbmc5fctr91VNFe18IIdN+U85NPYMLMghAUYg=;
 b=VuJoMAUZ5NPnJQz1v3dQa4FQe8MazmCQlL8T4i4pARi7y8Di9e+HcXytoKXi2KiFNfVFQqRryYCbgvNZ8EHI3eUHkHZYQKCmdKv59qEQ6JgasIJZi2/k1AzxECSVicpbmyGFyi3bvHvs9qZjR90aDyhNtugQfvwVLwlI8gfmAxA=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB6028.jpnprd01.prod.outlook.com
 (2603:1096:402:35::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 04:55:35 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 04:55:35 +0000
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
Subject: RE: [PATCH v14 06/21] PCI: dwc: Change arguments of
 dw_pcie_prog_ep_outbound_atu()
Thread-Topic: [PATCH v14 06/21] PCI: dwc: Change arguments of
 dw_pcie_prog_ep_outbound_atu()
Thread-Index: AQHZd/tpZybyaUTX00a3iipgujTYea9FzeOAgAoQgrA=
Date:   Mon, 8 May 2023 04:55:35 +0000
Message-ID: <TYBPR01MB53416B39491E8238814D976FD8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-7-yoshihiro.shimoda.uh@renesas.com>
 <20230501185833.mcunpdtvc3qjl72w@mobilestation>
In-Reply-To: <20230501185833.mcunpdtvc3qjl72w@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB6028:EE_
x-ms-office365-filtering-correlation-id: 2fde6819-1b49-4eec-d720-08db4f8075ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h+O/shxFdsYnejdqsA5decL8ZAD+dg4eU6808df7zpCu52rljSS/7iKsRaCyBCCL5I0a/zRtuq9oRP9Gjk85HPmZ6A1pbfkSiF00Pn4GjPQzPm10k2xTOugaM3/IMYWG7zH6FJlGEXimTH0TOHYwy+iKUnqbSRbQKJn2ENAH5kionK4469O/K+eRzmJ88nk+je5WlNDVyheV5gBXa9Q2gRa8DOhw0KcooToKbcboYodyOOWFQvKXJ3J+ng3T3Aq4ku+9N6pV4zGcryWOydLwv5YwvwcnZAM/whf3zqszgoqdUjUaWcSlPE3EDD598/5uH9Vflc9xCwB/be3LNApD3mmr5zIKQEPKB3dkHlsnWsJuwKlQc073s41jAL9PBnsxU1YSkLMg0CopZFA3iZR/Z8wEjYEfdkin8U8EVtJA7dQojtpiZ8m++MinTD2S22SZv379wy9853CTjPHV49huImd4Vfjz4/tuzKOxpzxuNsxS/e0sRnG6HwxoZzX3BsrJHyITyzWhwrBrWcUcS7nMZDGOVGmZBNipZKSeEyjngAAVnuP1g7xFMsYVqxzhzJD/pXjD3wBeBHcvZKd+osz8IQ55uy0Z/gEFB2hQ11HYqMas2E37j+tAe+thtsVQGD57
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(76116006)(7416002)(64756008)(6916009)(5660300002)(66446008)(4326008)(478600001)(8936002)(8676002)(66476007)(54906003)(66946007)(30864003)(2906002)(66556008)(71200400001)(316002)(41300700001)(52536014)(7696005)(9686003)(6506007)(186003)(55016003)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aA0P5CI3oGK2q6drZO5jiKGDFd5QDV8rvsrROKltfeHsk+k+W2cbsMs2JuX0?=
 =?us-ascii?Q?/cPs15ak1UCOpTRnQ82iPiyLBOu6hNp4k600DWEA/fiUahXpWXAR0KkWQaTt?=
 =?us-ascii?Q?p1nzvMWQcaZzMYERcdBeO9nRqn88UdEqlSraBfsyRnL+8M8yfKMlwHZtNSGH?=
 =?us-ascii?Q?KzmIcsGWOF77CUSz0V0YIb0XDNW9/8rnM4+/utwCPwO+03KZzjphP/sRv0NC?=
 =?us-ascii?Q?Hs0rFIyy9K1Lp5Su+Ko9AIWib3D5d4NLVsApbu7sJmFI7gnm2AAo7k4GTqB/?=
 =?us-ascii?Q?xpzQyaN0Rijg3QrrlSwN9PU3gGYvSKWniW5ZIToE+RJwSBfQxglqUE425fvv?=
 =?us-ascii?Q?qIa8ONYkaYTuAxwQjtwwL+2ROKxoStJI+NKJZOJbSdAb0HQZa6GJ+GvvP9m8?=
 =?us-ascii?Q?giuC8Dyy+RxGORXr9ZkZWMQS4ugXV96XwxwvD+ERcH9Fb6OlL0QeHUHa8k2r?=
 =?us-ascii?Q?nMNmfFuTR3VOc31qikcF+c+F5jF2uCvKqNEmYpgS5p14shOqCZvmDeSIbN/j?=
 =?us-ascii?Q?Dnh7+EAVnE4BmGK53iUSG3OtWNkz/Yvj+MmEoWwYuEqk8LpdMUyQPIeQqiBl?=
 =?us-ascii?Q?r+l5YVptIu92SQ21q+kwnhmusDNpjyGOOIOFc+eTr6WqQlcgQxqEn3iTD7nm?=
 =?us-ascii?Q?izDFECsBYE99Vh0qE8Rv1Eslmo95qpj+lMX3cZ9Qi3PhR5pqBu6raZOHY609?=
 =?us-ascii?Q?rdusic+MRdx9MDNQbB3h99GkrS3jkB0nIYKYM9k2wfCM648Ji8JeDtx5lQWY?=
 =?us-ascii?Q?trnboTc9DUCS8wd8OxtrKiv+Ig9xzwbtjvphEE5zZH9NgJQ28sBSkaNj3utM?=
 =?us-ascii?Q?Ua7UYajBrNftClZABL+fyL8qTXQpcMBlY4eV4zcr2FfFDWobCcsjXJ3mpQ37?=
 =?us-ascii?Q?/NZRbV+qa/rBxNczSa3PhVrp8LGC/AAj1ELnLUtACZcP2ukGx45/5OfxjV8l?=
 =?us-ascii?Q?4yPNhLrq6hs3cZNM1wBZjljmGCUYeqVEE55hCOKAdtO6ZXAPJqgBX5KgZd3e?=
 =?us-ascii?Q?9hHTOTQZWgAB46Si763kBFswGcSqpEmw3XBY9AFV4xjFW3rYmn8/xpwDOPRW?=
 =?us-ascii?Q?TqHaNUy5aoyZmZ7hdEj8kDIsRNIgbTPK2WO4QShdcU7picQE30vNNCTDRtJx?=
 =?us-ascii?Q?zZPEhdbhnD915jGt4/NbSP5v1xVAyUsU6fS/+JezliNXT1h6I6xAgr5253r1?=
 =?us-ascii?Q?/QyexbCX8HNJhdeHv9rxTaWt4fvqDUQJHvm+r9ZceHGC1bw0EK14hsq4E+sH?=
 =?us-ascii?Q?4Ua30VkuvxSsNy65wUnQcwm7ReIEbyiEfPlxg56Q+NuWn8bhDGFqIOB+Oklu?=
 =?us-ascii?Q?w1IM9OmHPq/DKSUnLZ7qNHCUyEOQp2EZR+9/3NR2kZ+XbyGY3SbH5NhjxZ6S?=
 =?us-ascii?Q?swQ7APz0FY4REMYoo+7RQoi+u223r9mF+kFbMctBciPTBuj60fnTzgekgG6O?=
 =?us-ascii?Q?OEBTYcES77HIkPAejSqCtdqzBt/uNsSzb5TKyhMG0DtROOrwaczo/sOMNQBd?=
 =?us-ascii?Q?eeD3yc7PCsj1ZJUNkmLjI1gnhK0ta6yJYU8hEmHQHZU7LN35wDBjoPGFH9wf?=
 =?us-ascii?Q?qJqBwsiswEo6zQhgeNuwnZbFwn14DfSK3UJCVr6ZKdo8+MuKtg6+7d7/cg+S?=
 =?us-ascii?Q?PhtJAo5AvZiMr/DLoSW/fd4BZaGIVJh40kJV7ul4mSN96ZaapAobobvX7jXw?=
 =?us-ascii?Q?vPSLYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fde6819-1b49-4eec-d720-08db4f8075ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 04:55:35.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2vK+vgj5zn20Tdc5uBmyGy5ipt+sRwR/nWiE7DM0AYZluFX99riRv2evGPsFq4IuHYvd+ug8dCKPHqFZYxOby+pFNHCB8QZMxucwge+44i47BW8dCqcdEc1FoOMvz8J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 3:59 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:42PM +0900, Yoshihiro Shimoda wrote:
> > To add more arguments to the dw_pcie_prog_ep_outbound_atu() in
> > the future, introduce struct dw_pcie_outbound_atu and change
> > the argument. No behavior changes.
>=20
> The change now looks much more coherent than before. Though it still look=
s
> as an incomplete measure. The core driver still have two global outbound
> ATU windows config methods which basically cause the same update
> (performed by the same backend function), but which prototypes are
> completely different. What about dropping the separate
> dw_pcie_prog_outbound_atu() and dw_pcie_prog_outbound_atu() methods,
> convert __dw_pcie_prog_outbound_atu() to dw_pcie_prog_outbound_atu(pci, a=
tu)
> and use it in both RP and EP drivers instead?
>=20
> As a result we would have got a single outbound ATUs config method with
> the next prototype:
> int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, struct dw_pcie_ob_atu_=
cfg *atu);
> Thus we would have reduced a number of the globally defined methods,
> would have got a more unified outbound ATU setup interface which
> by its nature would imply that the OB ATU entries setup is almost the
> same for both RP and EP platforms.

Thank you for your comments! I understood it. I'll modify this patch on v15=
.

> Please see a few more comments below.
>=20
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 21 ++++---
> >  drivers/pci/controller/dwc/pcie-designware.c  | 63 ++++++++++---------
> >  drivers/pci/controller/dwc/pcie-designware.h  | 13 +++-
> >  3 files changed, 57 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index a80b9fd03638..96375b0aba82 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -183,9 +183,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep=
 *ep, u8 func_no, int type,
> >  	return 0;
> >  }
> >
> > -static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
> > -				   phys_addr_t phys_addr,
> > -				   u64 pci_addr, size_t size)
> > +static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
> > +				   struct dw_pcie_outbound_atu *atu)
> >  {
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >  	u32 free_win;
> > @@ -197,13 +196,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie=
_ep *ep, u8 func_no,
> >  		return -EINVAL;
> >  	}
> >
> > -	ret =3D dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU=
_TYPE_MEM,
> > -					   phys_addr, pci_addr, size);
> > +	atu->index =3D free_win;
> > +	ret =3D dw_pcie_prog_ep_outbound_atu(pci, atu);
> >  	if (ret)
> >  		return ret;
> >
> >  	set_bit(free_win, ep->ob_window_map);
> > -	ep->outbound_addr[free_win] =3D phys_addr;
> > +	ep->outbound_addr[free_win] =3D atu->cpu_addr;
> >
> >  	return 0;
> >  }
> > @@ -306,8 +305,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >  	int ret;
> >  	struct dw_pcie_ep *ep =3D epc_get_drvdata(epc);
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > -
> > -	ret =3D dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
> > +	struct dw_pcie_outbound_atu atu =3D { 0 };
> > +
> > +	atu.func_no =3D func_no;
> > +	atu.type =3D PCIE_ATU_TYPE_MEM;
> > +	atu.cpu_addr =3D addr;
> > +	atu.pci_addr =3D pci_addr;
> > +	atu.size =3D size;
> > +	ret =3D dw_pcie_ep_outbound_atu(ep, &atu);
> >  	if (ret) {
> >  		dev_err(pci->dev, "Failed to enable address\n");
> >  		return ret;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index ede166645289..782c4b34d0a3 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -464,56 +464,55 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
> >  	return val | PCIE_ATU_TD;
> >  }
> >
>=20
> > -static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no=
,
> > -				       int index, int type, u64 cpu_addr,
> > -				       u64 pci_addr, u64 size)
> > +static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> > +				       struct dw_pcie_outbound_atu *atu)
> >  {
> >  	u32 retries, val;
> >  	u64 limit_addr;
> >
> >  	if (pci->ops && pci->ops->cpu_addr_fixup)
> > -		cpu_addr =3D pci->ops->cpu_addr_fixup(pci, cpu_addr);
> > +		atu->cpu_addr =3D pci->ops->cpu_addr_fixup(pci, atu->cpu_addr);
>=20
> This changes the method semantic a bit. The passed structure will be
> updated meanwhile the former semantic implies the locally defined
> variable modification. Please define a local var "cpu_addr" initialized
> with the atu->cpu_addr field by default.

I'll fix it.

> >
> > -	limit_addr =3D cpu_addr + size - 1;
> > +	limit_addr =3D atu->cpu_addr + atu->size - 1;
> >
> > -	if ((limit_addr & ~pci->region_limit) !=3D (cpu_addr & ~pci->region_l=
imit) ||
> > -	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
> > -	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
> > +	if ((limit_addr & ~pci->region_limit) !=3D (atu->cpu_addr & ~pci->reg=
ion_limit) ||
> > +	    !IS_ALIGNED(atu->cpu_addr, pci->region_align) ||
> > +	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
> >  		return -EINVAL;
> >  	}
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
> > -			      lower_32_bits(cpu_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
> > -			      upper_32_bits(cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
> > +			      lower_32_bits(atu->cpu_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
> > +			      upper_32_bits(atu->cpu_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
> >  			      lower_32_bits(limit_addr));
> >  	if (dw_pcie_ver_is_ge(pci, 460A))
> > -		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
> > +		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
> >  				      upper_32_bits(limit_addr));
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
> > -			      lower_32_bits(pci_addr));
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
> > -			      upper_32_bits(pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
> > +			      lower_32_bits(atu->pci_addr));
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> > +			      upper_32_bits(atu->pci_addr));
> >
> > -	val =3D type | PCIE_ATU_FUNC_NUM(func_no);
> > -	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> > +	val =3D atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	if (upper_32_bits(limit_addr) > upper_32_bits(atu->cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |=3D PCIE_ATU_INCREASE_REGION_SIZE;
> >  	if (dw_pcie_ver_is(pci, 490A))
> >  		val =3D dw_pcie_enable_ecrc(val);
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> >
> > -	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENA=
BLE);
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_AT=
U_ENABLE);
> >
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> >  	 * and I/O accesses.
> >  	 */
> >  	for (retries =3D 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) =
{
> > -		val =3D dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
> > +		val =3D dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2)=
;
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >
> > @@ -528,16 +527,20 @@ static int __dw_pcie_prog_outbound_atu(struct dw_=
pcie *pci, u8 func_no,
>=20
> >  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	struct dw_pcie_outbound_atu atu =3D { 0 };
> > +
> > +	atu.index =3D index;
> > +	atu.type =3D type;
> > +	atu.cpu_addr =3D cpu_addr;
> > +	atu.pci_addr =3D pci_addr;
> > +	atu.size =3D size;
> > +	return __dw_pcie_prog_outbound_atu(pci, &atu);
> >  }
> >
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr,
> > -				 u64 size)
> > +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
> > +				 struct dw_pcie_outbound_atu *atu)
> >  {
> > -	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
> > -					   cpu_addr, pci_addr, size);
> > +	return __dw_pcie_prog_outbound_atu(pci, atu);
> >  }
>=20
> This could have been dropped if you got to implement what I suggested in
> the head of the message.

I got it. I'll modify this patch on v15.

> >
> >  static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index,=
 u32 reg)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 9acf6c40d252..81c7558a4718 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -291,6 +291,15 @@ enum dw_pcie_core_rst {
> >  	DW_PCIE_NUM_CORE_RSTS
> >  };
> >
>=20
> > +struct dw_pcie_outbound_atu {
>=20
> what about using the name "dw_pcie_ob_atu_cfg" instead?

It looks better than dw_pcie_outbound_atu. I'll change the name.

> > +	u64 cpu_addr;
> > +	u64 pci_addr;
> > +	u64 size;
> > +	int index;
> > +	int type;
> > +	u8 func_no;
>=20
> The structure will be padded by 7 bytes anyway. Let's move the "index",
> "type" and "func_no" group to the head of the structure declaration.

I got it.

> > +};
> > +
> >  struct dw_pcie_host_ops {
> >  	int (*host_init)(struct dw_pcie_rp *pp);
> >  	void (*host_deinit)(struct dw_pcie_rp *pp);
> > @@ -421,8 +430,8 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>=20
> >  int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type=
,
> >  			      u64 cpu_addr, u64 pci_addr, u64 size);
> > -int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int =
index,
> > -				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
> > +int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci,
> > +				 struct dw_pcie_outbound_atu *atu);
>=20
> What about converting it to just a single:
> dw_pcie_prog_outbound_atu(struct dw_pcie *pci, const struct dw_pcie_ob_at=
u_cfg *atu);
> ?

I got it. I will use dw_pcie_prog_outbound_atu() only. I also think that us=
ing
"const struct dw_pcie_ob_atu_cfg *atu" is better.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
> >  			     u64 cpu_addr, u64 pci_addr, u64 size);
> >  int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int i=
ndex,
> > --
> > 2.25.1
> >
