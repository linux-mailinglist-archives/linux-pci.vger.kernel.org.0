Return-Path: <linux-pci+bounces-4506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59190871900
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3861F23523
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01819524C9;
	Tue,  5 Mar 2024 09:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fv/dUPFb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eM/R4vpW"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1C150279;
	Tue,  5 Mar 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629564; cv=fail; b=Fa10o0Ua0/0KnkjmBLhnqvNcpTMSxfk3gHgHMlSjO53zogJRvzJW2GP9uIamkDJn9RjEEROj59bpoUJZ1tigCKn8+yEJHoqBshgTQpAf0RlVuSBJHk2fNyYGiHX3ZoPkihEqmX9pOg3eTrp9B/GlFXwUsaQIl6Z/iCNQviiSBYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629564; c=relaxed/simple;
	bh=XpOLsLt6q4iQ7fNBP87AVNIDlrn4o4gqxhEkQViEDQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pAl7zZ2P8lYFAYUrkNF2IQuNGeHDL1IFaMj0PvPC1rUbWU7+IheHeDHnT/MLoqcZXThWeSdW8TafG03QMuASJnm9WE0T5iHr7vD6EK25PxbQGMuykbDaOYi0mvwMjDi/K+ybupPScd6MinrnDJ4VCzuAT0YbpxI8fipqT3acBnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fv/dUPFb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=eM/R4vpW; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709629562; x=1741165562;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XpOLsLt6q4iQ7fNBP87AVNIDlrn4o4gqxhEkQViEDQE=;
  b=fv/dUPFbR/nnn7nVcul+d3w0RzLROY9u2jHg5u6Rkt8nYPjux2ysA/dP
   2LOIAZwEk537JhDlta7t5xjLouGEaxYE9U29xDk2rE1egcYYAnJCsY3dk
   E1Dl6vcDXjPYBjyOHtk9Vp96Iruf7mKD2GyaFKlQfFYeKR/gsK3dZTj6M
   EwK01wiULUwdWAYSRTkXvqN8j0KfGvo6IW21Orl6icbX62XthZL4BuubH
   TO1nQ7ROZasFUd6Qgg/pfq75CWPHKBcRcZ/UcFTHZuePNrHdvDBtEJGsA
   xfwXimeuk91JBUrNjZ+TmUAhy8SDv5IK4QgRjLiGvOqjgKb63cEkK9PKE
   g==;
X-CSE-ConnectionGUID: fzyN7pzdSVCgDwN3CUkb1Q==
X-CSE-MsgGUID: jeQfxnGiQq2CWluHvjDgvA==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10678836"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 17:06:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImRqGHCp15J01DK1i23YjrS9HGA0J8x91+zZTFr6fozmULoXr7kcTvaBflcR2PCPTPXh1hFqRs14qgReU1frkGBJyzewb+18oMQUtkZaizihUNpiaJHWVOTWwIoMRS/BjXVmUs1CxqSwxjDwLAlFL7FrK+8gyVhVm72UPjcih7Zt56J4IJs00dDAtYv0Rp4CJlHzd8iTiGHc9tDTvn734zbYfj/h15J2XtqdzpBPv65w7OMqVhPQbxdb4vwmzoXpfjHH+h3kDF/AJMvAQ8WBm3B33X45GBhttWiq01g3G1MEMAyaQHgsCaVWgZNSC6D1VsOEzenqv6RjNt9Z2oAVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXiyvmPS20EXCIWexOzh75hJTf2bD6vxFty8gpKqsKk=;
 b=EqVGK/yys/m0pU7KKd1kflnzRWdfrjexofJcYEp39plWU1bl6RVWq84I7Taopvysr+fDzfJsQCso6z6XN4wzjHWjO86o14bADgBAPb995f7EnSccfw4ddI8wIeOAGyUWfx0WP096JmuPSo35vLyGotxCA4R51GUOztEbeXhcOcqUZd44jWB9If+P7V83oZQOngBmuZDVDeZv01Tw0ym91EcF9ECCpwtH21d2byrb0QQecZZuxMB/+S5ZU+s74RKpyh422gzEZJWQ0v0CdfQVfSc9c2CSbNUH8zxifKRl9JypysAHBMKDRcNDl9h97NM71Kop3WFi6OdalmLrkGqjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXiyvmPS20EXCIWexOzh75hJTf2bD6vxFty8gpKqsKk=;
 b=eM/R4vpWNIcrolz/o4iWN2LpylLNLDIjd8mMm3RZEML0tI1wtdMJ9OK7aSPLtH9GLX6ZNgI2bQKL7lweoAFftliXPu14STHzJjzMtR6yHuSpFHTwfZN/W18XPqV6V1T6BRIx8cPZuDZS903YCOD+jmEPf09CCy4IC0KnLpd7ags=
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com (2603:10b6:a03:3db::16)
 by SA1PR04MB8468.namprd04.prod.outlook.com (2603:10b6:806:33d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 09:05:59 +0000
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::a115:b72e:ac9:d144]) by SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::a115:b72e:ac9:d144%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:05:59 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "jdmason@kudzu.us"
	<jdmason@kudzu.us>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"kw@linux.com" <kw@linux.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Thread-Topic: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Thread-Index: AQHaboXQLML6t2DiAku/eXc/Po9wGLEo26AA
Date: Tue, 5 Mar 2024 09:05:59 +0000
Message-ID: <ZebgdpKt7x2hDivM@fedora>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
In-Reply-To: <20240304224616.1238966-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8326:EE_|SA1PR04MB8468:EE_
x-ms-office365-filtering-correlation-id: f348b054-2e7b-4546-9558-08dc3cf37988
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 de6y2QSLcxyIMvy92y8Frw1DAO8NJDnHU4yNUiN0inb4w3hQACDq2pgzMdLN5/SrXHjznds/c/LJaiHBX+AlEegxKPNESmHgIb3ZEu9BLVzF/dKiM9FfAZAOMNYoeBjo/LfMFu65HDUiL2Y2+D8h8FCeUiVEerCGHqvqWYrVhahobUMBq0l+NtW/VMsnZBRo/kmUj+tb3aF4LF5OSbKbgtAwtpFb5eiT0kfV3h1+ASXbQyPUE/7BPR2Zpk0PzrpZLbn/ZhDMSsqemQd34LLnKeKmZpz9YYgTId+Ev2aUelTzm5wZV0EjK4CC0dTlavjdyOvCkjUBLVQVeVtt8qrSSr367XhkgnU6q54hKV6MDZiohx9a7ukLKO6fVa497E9Yay7p12jNlIXOxcqVlHMyj57H4O3h5gkyQ+xrqY3yyLdrUirtv/DUJlIFIorYzs04Z9azLOLjoO6CXJF3Jub3b/Vj2I3Z2tHJrsEEAPoDbUxzy3GfnH/oN13nVwuxwuk2riFahqoUhXjKm1w8TXD+jgXibStPtmSFyh0dBZnKGBn+jTe5lwM8EkqudENLl/P5+KcbcRvJxskXrVTovP27T8szTkQLJbSE+kkiOvr+vUbgV/I30/xSKSSBHKn4yEd+ZlbWbAm15koQhAClAo7koXiePJAnSALv6bcfuW1Coks=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8326.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ew+vcVImqH9fByCLeW16mrCzToVWfAs5sPxuT6RjNLZ11R8Ac7OWerrbjxy+?=
 =?us-ascii?Q?OcZJxRCsCCAbWtjtdPdWtglxkNG4GoS3VLlEcd5eYfsQ81fBDawTZAsZlVol?=
 =?us-ascii?Q?8LvOAxWkVlvV2pOlCVrfaj73JCscGbj7HdXvzHqmr4WrmYbDUEUCXRdmZolJ?=
 =?us-ascii?Q?DyUP8+XNf5Jc7vFA0/0rnjT2CLR3v2SgZnzJe6KqMMTwKguJZEfhRFreXfNl?=
 =?us-ascii?Q?KsNRwDR3pck4cnRRtAvODcvjCr5tuOaxes66bBJsa0sRz2K6VBPees5/O7Po?=
 =?us-ascii?Q?SRvCGbwLx+3jTKtEqyVWUr+wBRiTiwxN3jylJskPiNlvFnlm8HABJ1vdN9JY?=
 =?us-ascii?Q?aoav2v1jKwsgQ0X6llFQS8qv6GU2Hb5HDbWDA2WGYba15a9kc/iuCaWbvJix?=
 =?us-ascii?Q?NwjjtPphQ1BiVnkitnCkmvLXquDhOPlHPIy8ceOo08o4Os24H0DkfEC3i+yr?=
 =?us-ascii?Q?rqbE+FYHEYY2DEQSRlNEzrHhNzHGC4HVYl/9pO/RQoKWxhiebU8pLuZMQwHL?=
 =?us-ascii?Q?Iei8/I8KQ4xbZaQ0OxH0wAOzGID726q4rwXM/Jki81GpjG2oVpQyepKtbXlr?=
 =?us-ascii?Q?OFPJHogl9coiLCJAISh1WppQp0KqOt4ertob9PhJwClwDWhVoxe085kKgz5L?=
 =?us-ascii?Q?C/oJik3QUnoD+NS+8mUqXBng++eoAl/Ga401Q/Ea8HwTOwk4r6hrLWrYK1nM?=
 =?us-ascii?Q?oTBSJbkQjbppQgzVFqWaBsDgRXtCbJjw5xWWby73+xhOd4AH08rz7GjHAq+h?=
 =?us-ascii?Q?y1wiHrNZ5WX1UJMtjn4PR3W42h1uCdzsmrRZK40+SXvs98+Q+gVbpCP+NURW?=
 =?us-ascii?Q?0PvCJ9pXhDM6h9tzIndym5oZkNcTCRQZ8LE7ZCJCwFB6uybHaGFRJL+YSk7n?=
 =?us-ascii?Q?8xD9FS7ciaIBOaVzCVdRuBkn9sV+sxmyf7X+vg8NOD17MR0SaJrBCQF6ZJ0T?=
 =?us-ascii?Q?fcSbymhb+hw3i4c9ragCCFRgTw9vzf4ge0U9PaxNJOqHBCPGtEWBCQ4R/OGV?=
 =?us-ascii?Q?FvehQNlDoFHwGQIrko3oculdQl2d/J2KoZHd6vTkJAgoSx0DRRs0iaCeJkTL?=
 =?us-ascii?Q?dZwlMorlpniv2v4Khlk1JUXsh9EdaZg9+o2zpGWewTQnxGXaXE41YUcxkXWl?=
 =?us-ascii?Q?B/GHk/OFuk6VkNDIIQjgy/JBEYDM2Odza+2wrH4jdFx6ar9e28DSNNqsadQC?=
 =?us-ascii?Q?Xk/n3zeUwXqp84ItLjFHxNjup6xBGrkqpRyF0Cm5J7Vs+VHlouTwmSMisobJ?=
 =?us-ascii?Q?Jjm7i5L8gqeyQx3cX8GycvWFWZPQIJYlYeZbVBL45yl76g9kQJTncESGMcHK?=
 =?us-ascii?Q?1/Or6OUMD5I7lIZrk4jx+WREl3LBCMoFOstbmwSwNloNxBQuvJcZCbbhxecl?=
 =?us-ascii?Q?awtHEHm2vvbhs3A1fnuUtWBi43Xd4cQvFWlDHa8939nP9CytZtTgfKMGJtDe?=
 =?us-ascii?Q?caOE62+BaLsEmkV9JXIM9UyyVxme+jRRYF7CfPGdklCItaF9iswlDdvzugPp?=
 =?us-ascii?Q?cZcsOJs5OzKyOKLanU3C6/EsyRkRXiVpYfT9brb1jv15lFGiSesX43zDQMeC?=
 =?us-ascii?Q?O989Sp9VArUQqBIr2V0/5+Djjxt9KT2VQvG/WkUEHpgWBV+gsUhj68mES5oE?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BE3CC955A5F43A45BDA49CB7755821C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+hj82A5VwY8z1sJxXDv5GFroRZRcw2U+eNMF73G2Pb5UysfzHf+96rUpidD/u6YFFkcfSX76mppTMTrDD2H3f5d/folbEsYdLocM7KNAmYzHQp1LJBiGyIHqN+TjdgRcMWBYyjWLJjXSqoV8ggH6hnq8vjHDKvDpXZDKJqz06sBKdKhtH2su2rgKsfIBfmO1f6zPIuiuPtUIz0i+hrjVCA3rDWzLjMEIEEaoRiy5UsOmlqDjV12nbMejhwMrR+hbZe5isXPK22rs0+6e8FVkmJZ3dIRp1wcFpi5YnbTtEfWaZIA4fRPenaB4xJXBwKPBoBkU1k9SIfhCxQZ6Yc1z5cm2Nez+oCK2CMn3Jzfg/wjxeYTANpW86kQNkFJwX9VdIgVn5L5uFfANcrjmZ2NdNQHf19CrMk7uHzSTbrIRj9JWzQJNT1V6Io9Y7TpgWLhAL5SOouDO8BS4aX7iQK6zZ7jTDZPVk2qbPJynZKu55/HXTcLKwsT5tO/LN3iGq4wzXAysnDADIzduk+tqadYHEN+kLEJRrBrwXc2sT50kr/+kaYNwioQCNVBrpnKNj1vmP76beOBy/YfrKn6WblcfvPKs4EYaDTARovqFvqP4s3rsL7C54JIZvZ7bucRbE+ah
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8326.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f348b054-2e7b-4546-9558-08dc3cf37988
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 09:05:59.2925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/KycHTtgrJmreLFtG2dCEJB+BTc+QOJjlakE+z5FYm4hWZw0+ArVw6kDvZ9OeeFi4ALiMOzn7slSxjCG9cejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8468

On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> dw_pcie_ep_inbound_atu()
> {
> 	...
> 	if (!ep->bar_to_atu[bar])
> 		free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows=
);
> 	else
> 		free_win =3D ep->bar_to_atu[bar];
> 	...
> }
>=20
> The atu index 0 is valid case for atu number. The find_first_zero_bit()
> will return 6 when second time call into this function if atu is 0. Suppo=
se
> it should use branch 'free_win =3D ep->bar_to_atu[bar]'.
>=20
> Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indica=
te
> it have not allocate atu to the bar.
>=20
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update =
inbound map address")
> Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Tested-by: Niklas Cassel <niklas.cassel@wdc.com>=

