Return-Path: <linux-pci+bounces-1929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F004D82876E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105E91C236E6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77A38FB6;
	Tue,  9 Jan 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XhXWJNRd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jinpMGQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDB438FB0;
	Tue,  9 Jan 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704808350; x=1736344350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QXK9ltosaRePE6mojpoR2l1Db3EU/FL05cltdBojeL4=;
  b=XhXWJNRdvKoDmF9JukS67hgXGNR8kdhGUkBHj0s2jqe79KkRO9Foezi1
   1cFAzyyitdgZePUgyNja+CTz0XdI3vDZDW0V8RqpT0sZOSC0bqhhv9BpO
   IkZqOsC2/NyJNIynSXrruDyNsXR5p/kZBa0v0b/w687f1E/+ju0Q8dUTI
   4h0QC/gLJtM8dHm2QGcLUmEo+HhMfC+zBXr0gxlJ6iNDFVCFU4Sz703iO
   hWjLmxvsCnn89uP36Vd2UmcX2gpLXNjE4/XEf14fCVH2cimTdAseR82ZZ
   GPpOcF9u13eg1QsX3VIFnJ2SzcwptnyNx2W94L5628MDfxXkoiCID1Dk6
   w==;
X-CSE-ConnectionGUID: 29RuwwzPQAOx9G0dewh60Q==
X-CSE-MsgGUID: W9jXFwq7R5uv+tDaeTWwNg==
X-IronPort-AV: E=Sophos;i="6.04,183,1695657600"; 
   d="scan'208";a="6246673"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2024 21:52:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0ZYg2JfBFV/IsZv5VtWxuHYijiD7mDeSTFYl5wIHzSIaVTZ/K599hVTCLRWftA39ip7xELFZ3FfmcbZ81vRQSy70eI7NE//Ppmjw5Y+EJbBS0CQFVETDNXzVF7aKQOuMO5HFjUSxCoLqILOcV37vzWmSeMV/t2qNamJSM9rd1wSDbRH5pkoGRNXgGjEtjdu8yEhD4nzoxs00CoM2TiVQRijGW/B0k2/Knt8SyRrjPtfaslzjxGt5e3v2yXTetkhKUVcXsF+8hZ4iwn5rg4PkW7Gk9jh+rucfmq6XGrcn1N3eDdXe4EVIc/A31YnH4Q8F0FbQXxxihFD8HVhn96DUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy1tA1GlMLd1Uyp9ZbSTDxRRm1dF7dm+ZEbK0tmBn6E=;
 b=YG+4Xs2wRoFwfWjcm1W82frrnekuXCn+w25Tvp8d+XCesp+1RR5WfohdkweVx2t/oWpxC1lXSolgHlFdjuDote5X1gvNCyP3pjMt8d/BJQvHLnlWZLNxsj9eqIrYthIwg2++6izV/mcCgI1ZEk1N6ky1FrMdTroe1EUJZU1sg/NyuWuj4t60lxRf9EKff96duvWlrMDwodarCxxtcBgP9ptdRb3ljMJBcWXcr5tdFvsOsVTFPbodV94M6JvnTG4jtbpwslc3zFhMp4OIPjMIqoTisod0YQ8/gqs5QswIf0hyOwaSBKrtV4mp4iyabIKbifG5I0XUVumNNnTYKvCDEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy1tA1GlMLd1Uyp9ZbSTDxRRm1dF7dm+ZEbK0tmBn6E=;
 b=jinpMGQ3XYWTHsOmVpSKWQlM+8VcnUxC7JTYhAmNpgmfpST54cDWVyN/OD2sMcqZ/eTJ++6qsp49Fv34kr2b0gicqBv9kro5K1ajC5/MU4v7QqBuuvoToSIkZiIhHEel58Q5kI7Hqtb9aBxW7MJb1xNi3/4W0c1MoHK2gr9hiEw=
Received: from BL0PR04MB4850.namprd04.prod.outlook.com (2603:10b6:208:5f::14)
 by CH3PR04MB8925.namprd04.prod.outlook.com (2603:10b6:610:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:52:16 +0000
Received: from BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa]) by BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 13:52:15 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.li@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, "open list:PCI DRIVER
 FOR SYNOPSYS DESIGNWARE" <linux-pci@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Thread-Topic: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root
 complex reinit endpoint
Thread-Index: AQHaMja1NResTHTkFE6//FhBs62b57CwYdiAgABGuYCAAAUWgIAg9AaA
Date: Tue, 9 Jan 2024 13:52:15 +0000
Message-ID: <ZZ1Pj3MvhQNMnP8M@x1-carbon>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon> <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
 <ZYGq6RdCfdhXFF/9@x1-carbon>
In-Reply-To: <ZYGq6RdCfdhXFF/9@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB4850:EE_|CH3PR04MB8925:EE_
x-ms-office365-filtering-correlation-id: d4b3a9d8-f187-40a0-d19e-08dc111a3069
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FKv7x5bbuTTEsEOW8dbGuJIGEEiDI+QE5I2Bt1H8EnLhq78DcGF7/Pjsxcjy/Pn1sDDyMVmeiA8wFsyfmE89DSn3F1TyNJTU0MsDXo03lHtlOVZw+ab/1KyVK5QnGgYr+pvOZDtKnSYIp/so7izapJ5mg//ktD39KOSEjY3sz57XGhLucWExswW8JGHRFPJc92X9BEZMk99Y4AzooEAZOhhnORFZZl2LBnSLvjuvzIaK0Xn0vqOZE79F2TAYj7O/g5OtVeBY8f9+TB9WHdqP3CnC2NJABM/1hpe5C0Ey23o7vahfUF/eWH466pboNyvUlUtf7kiKc1ps/q2NNAL5zgRgSRok8PGTg12+dgseTJeOtJmAncaXlb/0l4o313+ZGrfbxPfNr9KBWb/iD+1ojrarAbqIJGrcuABeKsq/RUIBvzqmK9lAHlf+m3wcyHPu3AEGOscl5VcY/ZwvWvGs8QeRU/FYfp2bxDz7w6pjHcbvAttK46AOLin2cXBCvNyT1LJErgE0LYd7BlRDgLQGatPA801w2AuD7QfKiiXmnFXQSJpPWC5APecwBf7qK5rmDJGHVcg3Tc1jmVZEtOjZmpb6nowY1YkxPgeFopGMzqg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB4850.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(2906002)(6486002)(26005)(76116006)(64756008)(66946007)(38070700009)(66446008)(66556008)(66476007)(41300700001)(122000001)(86362001)(91956017)(82960400001)(33716001)(5660300002)(4326008)(6506007)(54906003)(83380400001)(9686003)(71200400001)(6512007)(478600001)(966005)(6916009)(8936002)(316002)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?QBHlkld7oW8MS8LovCvzmulxmtfhtvWqPib14t+Fwzm3er/T39FMsp7KGS?=
 =?iso-8859-2?Q?h4zUDZoKiaNYP4wSgwxginNZuLOOTtUTGiJAL4AlDA65LLtnM4N/9gv0VZ?=
 =?iso-8859-2?Q?dFBMPErV+wOoCkmPHTI2/toqx5C7n2/CFAfbChRPlel4UZ/U5B/wi6fqpv?=
 =?iso-8859-2?Q?aDFTpjIw+klsnRR4Nyx1etmcvyJFb8Nk5Ki6zBtb6iJ1TlwsFMEdktUkWx?=
 =?iso-8859-2?Q?4Tyn+un4N30KIKrHa9oFL0QrefarUGNA0F7PEm2U/h6w21Je0Tog4lgait?=
 =?iso-8859-2?Q?7myZTLfE/peHErkv5eaZymwjz3erHWVgNq3VLEEP+kpO7NWIo/ocMzQeWB?=
 =?iso-8859-2?Q?7i16iiVHZ6o1Or8XXct/4Ao5VbIe35Y832jvQnTiblMzX2fnjMQmG5xR9K?=
 =?iso-8859-2?Q?owfThT4gH8+HoEcqpNkXglUa1YeNFoO8UKu+IKb4m6qx46IXBMaTRO5eh5?=
 =?iso-8859-2?Q?O8QlAr4h7zfmHbILnIh9KxxNGjgzMs9hc6UBGSC1utvYTUzKSkUpkAxQJo?=
 =?iso-8859-2?Q?Dy+XyWcLwZ8bxRfUdu9dojgjg7A7Ap5nUW81hcYxA0R6oDlAjLDjb7N6K7?=
 =?iso-8859-2?Q?mjvP9LTqZdTelfdamN9Q78yaOtiKIev2AdwxzXZu+2afPQ27N6qLWLaCE3?=
 =?iso-8859-2?Q?DTBVvRxqs/hkAz/LyN3wjU3ijvN+Gvy2aFuUgEj1UCYvDdNLS16C+N+amZ?=
 =?iso-8859-2?Q?bjS9Z3037TkEX0iefkkBeTE41apTnzX5z/Ye2e4whdAOhh6Spe3VMkS8Mq?=
 =?iso-8859-2?Q?/pQE2XvWqUtRlbqXcAYnWt5YzEzDDoOCHxj1kyJO3P+dzsKzPzPClKkJ3i?=
 =?iso-8859-2?Q?eKlXuSBmKKOtS/73UA8M6xDZWixWV0TIThOfgfA7qxXxJSt5p4N+rHyUXC?=
 =?iso-8859-2?Q?OLEQv4DvEJBVzcJ4VeDBhophcv6QLnmmad6tT1NW5vXQSi+qL1xpX6iPlq?=
 =?iso-8859-2?Q?P5Q4x7aT5+BSjfsq3U0UhH2YeWfFZB/ljtQQh6Mc/Wpzazsiv37zRVhSR+?=
 =?iso-8859-2?Q?hqRuKYZb6G51oWhRLNNyu7VKtmv1cInUdamN08x679b28DiaoqssFIJoIU?=
 =?iso-8859-2?Q?WivoUEqyvlo7cymkYO5+bKVutKzbKBMHHj5vX+7LrMtJiOKq5ka8dNDw3o?=
 =?iso-8859-2?Q?YN9nNlM8Ulvu/umo1dd9hDseJsoGA2PZUzZpiryoHqVYQ38kwmz/y9DnxV?=
 =?iso-8859-2?Q?6ynZIhL60gl+rfGCfx0Th2c0qscIf0Lmn8r77V2z/7uiWlM9gR4eJcHfez?=
 =?iso-8859-2?Q?FIAn9fNc9EfrbMC6d1gC5cb6iY1Zss/ILskLfvTD271YDr0VNs+GTIcFba?=
 =?iso-8859-2?Q?0ODilIDnaChgceW8lXBU5UObB5m/Z/vM09+f8GbE3lepPqgsTq1c7NyoVU?=
 =?iso-8859-2?Q?PSChNm7HVnGtY9Yl2iAv0dYnUxNzNzslywOJ9G3jP2ZPwLQggcKmS60M7i?=
 =?iso-8859-2?Q?+dJhlNAWOiqj7OT+GYx6k6jHu+HJFrXcYopC4l3LIhE6El3pe53/d9gjel?=
 =?iso-8859-2?Q?H4gM3BRMQCXdIN8CDoDDLchOs0dsq7IbWVD/Uam0y5OqayKOI6xt6G4HSM?=
 =?iso-8859-2?Q?e6M+mjuKYnO3sfq83uXyfxSpVbtMp9MCRsFqwXulFMX9herHWSfqHIYnAM?=
 =?iso-8859-2?Q?NMfvZlw5604G1cMXXEcGkwoeec1ft+dWcu/DiVFXMXzFwzc6WIDzrkfw?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <B924B9DB8537DB4FA7ECCB6C7A492DC0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/EJSEnrmtCSdSOip64UxF+5+m8RWFLlObs0gqjOAlngrDOGNFXYoBHWvKB042xiIdE7Teaiy/fw8Q/GsFUB8PW4ZFr+vfrK+Nz9jhIMFw8ibluJtcxL20KzBal0wrzksm7QxH/wNxL7QrS59t2p8Pu0QOc0+5MBliUWPStKziUodwauWa3VCbVfa6GPmyWTt3u7N3ZCtoNLNGdvFusCcj5KeDJn/vb2cWZgNMwSdHDfM/ridxbUJTnv9Uys+YKkvvp4EyUVDNeBex0/n4ef+Uq9P1Fst0KtDcTiMMFO1UVN6Z8psBl64u2QNNnLKeduYwY+4Qnk+jrFjcTh5yfcTbkRFDNrLDtoo3nizz9+Jf9t/jvKBvYnD/mrmVhe6EmM6LAgA2yaG/7NTr5GRGH2pWqlgkDaah7gKzigh+DwBZp067x5lWCqyY9wjEXVspRsl3lE52FVBne9auLqpXrcHriPKs+hGyjRVL0w423map4ml/NfSynHDlrBIcjJf+Z0JIvrbj7pjmbw45bb2N+MMdalHlDj/DX6TvP05GUNrjB/AoRH1wAuPjwrUPLC2FmTrSJb7k7iIaYy+7/QdALKwhMt5yaRCAZwBY3PSrX1Mdh45xggv9XZCXir+E7/JxcJ4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB4850.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b3a9d8-f187-40a0-d19e-08dc111a3069
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 13:52:15.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBOPT2WJX56KB8wS0tG4Rl7sK79pSR9ByKxUufDe174sArhD3n5r+BOfvylNBmUMa3MLhJmEXTK9XBbAqqBEwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8925

Hello Frank,

On Tue, Dec 19, 2023 at 03:38:33PM +0100, Niklas Cassel wrote:
> On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> > On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > > dw_pcie_ep_inbound_atu()
> > > > {
> > > > 	...
> > > > 	if (!ep->bar_to_atu[bar])
> > > > 		free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_w=
indows);
> > > > 	else
> > > > 		free_win =3D ep->bar_to_atu[bar];
> > > > 	...
> > > > }
> > > >=20
> > > > The atu index 0 is valid case for atu number. The find_first_zero_b=
it()
> > > > will return 6 when second time call into this function if atu is 0.=
 Suppose
> > > > it should use branch 'free_win =3D ep->bar_to_atu[bar]'.
> > > >=20
> > > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate =
it have
> > > > not allocate atu to the bar.
> > > >=20
> > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon=
/T/#u
> > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() u=
pdate inbound map address")
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >=20
> > > > Notes:
> > > >     @Niklas:
> > > >     	I have not test your case. I should be equal to previous's fix=
 in
> > > >     mail list.
> > >=20
> > > Hello Frank,
> > >=20
> > > Thank you for sending a proper fix for this!
> > >=20
> > > Personally, I slightly prefer your fix that saves the iatu index + 1,=
 and
> > > keeps 0 to mean unused. That way, you don't need the memset, and you =
don't
> > > need to change the type to signed, but either way is fine by me, so:
> >=20
> > index + 1 don't match hardware iATU index. It will be confused because
> > other parts is 0 based.
> >=20
> > So I choose "-1" as free iATU.
>=20
> A s8 can hold a max value of 127.
> CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.
>=20
> Since the DWC code can be synthesized with 256 iATUs,
> your code will not work on systems with 128 or more iATUs.
>=20
> If we continue to use a u8, and offset the saved value by one,
> we will at least be able to support 255-1 =3D=3D 254 iATUs.

Do you plan to send out a v2?


Kind regards,
Niklas=

