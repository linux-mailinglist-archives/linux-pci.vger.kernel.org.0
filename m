Return-Path: <linux-pci+bounces-1171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0570818A3A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 15:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0D928CD8C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D1A1BDCD;
	Tue, 19 Dec 2023 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BmWfoBj2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JPiZAxiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283B51CAB0;
	Tue, 19 Dec 2023 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702996779; x=1734532779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DYkcDSlbCuxdJBZ5vHL/CA1Rqo7BhrCGvTmen7I4FeA=;
  b=BmWfoBj2KMb4nXEik7+wibnEbjZYTLqNxcFvI04J8kNWAX/4SUh0MmQA
   FaFJZGyOGLnwukHurz7IlLCa9JDlJRo4Tm74FKeqEysH57nUxCImA0ksK
   xCvrofdfZoAsUPdRd6NVFk1wjV1YYsTZILEirMNkrq/IUVssnvDTBsKfw
   tXIuSHYMylH5+ycXGGAKL9kGECNGMcj8U5TkTFo7qT6MWNbT/jWu0+aBj
   xDtS5cJ7qHTEIEjL1hFTZUC1yd7sWBoSowg1Db+mF4chhUfvv4OizDzr5
   tRxBJG42H8fwpHjGX0AdlnrNGUabPFyZDuQLnIBOModlWz+e70JjpKlVo
   w==;
X-CSE-ConnectionGUID: /bpEv/9pTYWbuQqxt6jSqg==
X-CSE-MsgGUID: H1YUJLVCTri2MZ1XjaLbQQ==
X-IronPort-AV: E=Sophos;i="6.04,288,1695657600"; 
   d="scan'208";a="5300551"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2023 22:39:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfzZHieSyTKWb4Kc+4W7sgcfkRNMSvj0gYmcsRHVy9mKgKfeux7m/UBBc5CHHn4IMX1zc8MU4pZ4rZV0VIPsvWBNXu3ShxbYHZVYi7CyAgPHjo49YUBVkECTcpJS9jOjZLZn7TAy8zCIiBObANMIvo0mj70o+eWZCva0MPHOuXoQcQzbH5aG6i2+xCkS6sTWq0i5xsrNWyjuYEGmqujI4ZE0tWXtF6iaKYOQdhhKVKCEoiu8P/DbYOrGVVXORKlH7vQK5XQMJHgRwSSSpnmh8x4f7cbzZc6sLGHjELLTrjlPjmrjrtLf2nw6VlXYqtwRsJGhK9vYsaoVTNox8gateA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SW1gcShZ7RP0yfJyVRk5vdUV1Zf4zA/gdPrn7q51U9M=;
 b=mO7gLQPeCXWyT6FCR2H1zolcCt1G2M4Qn9y9DCCvc0zbjeGmTL/WXc9H8DAUj7tpyq0YD4gr4BwKDW22/oBUYs0p//3nsHoY1Cnc6RklX091L4u4vdflzGTMsgaTuYrhHqrkbbb3UrXJuW6LALdoPyU0K78xOuwd+6jm+/zWvsLKnrEIax+rKiQCatn26ZBFJ5f069JqzitrY2ouuv8mB90AA4L7IUfEYqnmd5IKBvhswz2/AyiJ0+kghZ9hY3rfogFyRDINrHpooWUs1zUwzQlHmGr3TmswcHrrEs9RbwOWGibPOyaaynYrKs0lsV9hG32FQscI1/Q47xVk8ufSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SW1gcShZ7RP0yfJyVRk5vdUV1Zf4zA/gdPrn7q51U9M=;
 b=JPiZAxiXkT+yQdT/SAAhYqcoxHG0cDEp3WBBg128uAonWUWDHwXWNsSP41mPTnpF7usfEfO0hZqXqd//3eBAF7vFmO2iypHn72pdPxOLAc2yt02yqL6RwRTdvXHQjPuauF+UEGSogpUaZsMEZmVujG4zoIAdudMvZk9CLFcd3M4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MN2PR04MB6301.namprd04.prod.outlook.com (2603:10b6:208:1a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:38:35 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ffca:609a:2e2:8fa0%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:38:35 +0000
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
Thread-Index: AQHaMja1NResTHTkFE6//FhBs62b57CwYdiAgABGuYCAAAUWgA==
Date: Tue, 19 Dec 2023 14:38:34 +0000
Message-ID: <ZYGq6RdCfdhXFF/9@x1-carbon>
References: <20231219044844.1195294-1-Frank.Li@nxp.com>
 <ZYFrUWM7JXdv7rtb@x1-carbon> <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
In-Reply-To: <ZYGmpaf18pJgM/qj@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MN2PR04MB6301:EE_
x-ms-office365-filtering-correlation-id: fce85d47-d1e2-4ec4-dae1-08dc00a02e35
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HI5OElo7cOPP/kqa5FIKEXXvC9+oV0xlrvNsKY/PkEBBhtppDbRlYD+T+9LpeckhQGrmGWc/7Ss1fu9YjgH/jieqZ5SzVpsGUp5qT41nkQdtVwfGgCn3tp+Fa/evS82tmMvtzQbvYi/OsKluay7BRwypVe1thMhXSwztqs9qmQWvQfpW8Fw4705x86jV6yY15zBWjUKDfC97+aGJtITrGJszauSoOueAPC6AxZ3Tr1vQtByzH5lGB+oeInbLzcj0Kn/SelCs8mezyrmGZlea2F2Bz9akoALCBsIkwQ6CpuBaWpnnRpKLGWQmCFXFbE7Lz7bKQOLYvv/3+ZmUC27Gd+QRN4UcY3O1lOPVF3nrzmnbmA7JBE1LMPQsllWWjIFicDFtK8QFCM0mphy8y/9oiO/EKiMQwEpIEUUWtbPE1EEuGJx6NcVzRNYCjuGOEl2JvULv4NB3uZevXHF9ADz1sYJ9PPJb+1JOYqdj+lX19gQ8WlPJbeqH9m7qdEKMNOpM8GLTfQZJhobFu3PYvvMPozwvff2Yn8XlXayYT6pD12rQFSnGXwZIDoxLkcCYbZTHyBVV9HObvTxGi6ztfhXJtyHi1uw+XIcPnYCjWxlBFMI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(122000001)(86362001)(2906002)(71200400001)(4326008)(8936002)(8676002)(54906003)(64756008)(66476007)(66446008)(5660300002)(66946007)(7416002)(66556008)(6916009)(316002)(91956017)(38100700002)(76116006)(966005)(478600001)(82960400001)(6486002)(9686003)(6512007)(41300700001)(26005)(38070700009)(83380400001)(6506007)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?o+yuFT5qQdxtjcXN7NM/vTFgu/mn/cP+lr0bArLpuRQBFKhcfnLLQSnJD2?=
 =?iso-8859-2?Q?gCje6VXFUyj1ueZRhHK/nvdP4pjan3qGXbDF4VtTIwxdLscwE/lVq7IvXQ?=
 =?iso-8859-2?Q?ASToi0FmzRmlpIS2eIad3N66d44avKIY49T7jSe/1gFj2jhW5RUJR2hDeE?=
 =?iso-8859-2?Q?FkJWazDZ2YnNZsBPLtfC58S5k7TZ08RnAV2P96ugW2k/VVuVyq98AeqXJP?=
 =?iso-8859-2?Q?kR2snJDsMMqr1g8QYtwVp/SjLm56ajuHpzCCGyLof/pK7r/+uz/XBzhdiU?=
 =?iso-8859-2?Q?imom1lnmIgnOzRDymds2voBKwbD+dDvRhaPQGftngueqW69Z9IMaqvrF6P?=
 =?iso-8859-2?Q?uyUlTDIo9Yc/xs+eLt2PRvJvkjN6aEbQoezu7A+Tr00UayqmfQYDSETv4V?=
 =?iso-8859-2?Q?Y4KKu7OC8EPnjKbImUaYIP6H/4lz2PH32GDWgrviieSu5N4yXEVWJBklH7?=
 =?iso-8859-2?Q?LiqZqNbkviyIbuHGC35hVFR+soIDmpho9bRzqF5Pv8w2etjQLcTrhXq6sc?=
 =?iso-8859-2?Q?l+FqVdvGD/Pw27R6rdSYyocgcSgfMibxjieak1GAJXts2aJpKne/VN0Vv5?=
 =?iso-8859-2?Q?oQiLO6fMFTCMeoClYgpiS0Cfr0IYmGZvR4TWbYd/jDG2cHE6IwY1cITLij?=
 =?iso-8859-2?Q?P28dLyqIMWqdBrZ81IKwE0JKW4yRuWAkLbuEKkPCag0dZGD5UKibOQxS6D?=
 =?iso-8859-2?Q?YqnMP4EAXot4+PtXuRcKxKLOxIPzrqZFJ1TCx5BMYKV/oOogmQPxu8DK/s?=
 =?iso-8859-2?Q?hyNql43zf43MvjmdoacTqaeajX+V/ix4D8yYqjtnqHo1E7hFRFYHEh5iV6?=
 =?iso-8859-2?Q?94iChVpzxqgcsG7KWbalRzF53V0iCGVfONOuiSl7DJDVPi6aE4yDBUFyFp?=
 =?iso-8859-2?Q?EuZvetCdabbAjjbEECSWb5ab/+FBdpBzEAI9FqblXPvJBEcPql+eKqkPxB?=
 =?iso-8859-2?Q?94riM4XAoFgdXXmz6dn+QJ1Aby6ooL+OSHW7W1GMSuujx/pS/esSsuwXSY?=
 =?iso-8859-2?Q?ophlvU23Mp6XuMHd/x2l8JVx7R6FyU4XnjHOTh/rz2WzZGbtbbsGfcnQkM?=
 =?iso-8859-2?Q?zjv2J6pm9/VOd5yJkh0KngGaLkb/c9o4IyiLu+MfUKvm0i0bItOvyxWQrK?=
 =?iso-8859-2?Q?Dy/CvaqTnIvl7lZsHCIR+MaIp9/z2gnYT630/o5So7Rnqd+Fk1S3LK45g2?=
 =?iso-8859-2?Q?ySnkz5vNh2Q5dNlLFtI3qJvAngYBZORzZ8ONXYasTH5S1msG+7JmF1Tejk?=
 =?iso-8859-2?Q?GgOGXhh07iNpR1lfYpQ7H0id0HUSb4l/ZBMBVg174Iq6M2HCK5AUDSIRPz?=
 =?iso-8859-2?Q?t7VCQnRZfBon/gsHsGUQhMg+haqK9urJmv87ff9OLrk7ImQJjjwmUb0Ofm?=
 =?iso-8859-2?Q?7+PpLQPFv8h39BkjXIGpOWlBlsEGoqi3jXGwIez2kwoSmWciMYXeXlxS3r?=
 =?iso-8859-2?Q?xvMDyF1EQF0x87hcPg4Q5c5+HFFVWJGMVl4xmj6cQsAxPXeVWVd/cDbORH?=
 =?iso-8859-2?Q?iMIPtaIIG2IXPzVfuC3kOBHY8HkljCpMhduyr9A6gwEtVZMkTqX1bhVFUu?=
 =?iso-8859-2?Q?MZlDaXnQ1boVYzXPP8DddE3p6QMhUitiHAu5k12RzIyWepu0NqwaTFvjCP?=
 =?iso-8859-2?Q?6u52EEkk3JACOJN6JYhgskeFoxO2ZiGESBlx1l0QMH29R81hDPce53JA?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <53AAACE1FC9C464697DE0F7228A4727A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SI1vh3gANpiOiK/ZFuM9H+i1U/HfsjG85U0bgtpLU3kUBSKOYLerJREN4YBbOz5c6HGqC8gKkBt0A8Z602gJ3OwxHrM5PS1bsirTsg0K5PNYdv7QzYORgE69yrnbjthh/kYVsBhCwjLQQdibDmgJxUSuffEU6U/g34HQ7eAUkInXaSURs37a0CDaZW7pJZO3XsP1JTMCcYc7Bdb7RRNRr9ldYBNalaqhAOBD1hxkrIs494Qn4+xsPeihHCclPX9fhsJcpniLVYe2wIsR7rFz0KQ5KU5/sQzwo8oUeW4uRF31LXC9R0vzTHO3E5Ap0HaFu1XkxoprthHctwceATWfXVCk0xg3avKVDumw0VcUFEt5Emkb3ObUY6e7W7qXpK3k/Mv6jbdqwxF3m+rYnqGDpFvYdRzKYDwCLGNDhvWX00XKY6VHIHIuetfb8NXhrd1Qr82r9h0uf8KqdxuBppyh+jLPdKcCJyYtSwM/2p4EuaMd8ZCFnR5cvK7eRvb9tImmcdN+Z4c9IhZb5SBmufv3qO2obiZbpR3wSgwQ4FknVpRgl0CAJlIxwsghtnW1nqfp0BK1HbPNclHh/C1+XIeAt/dXKxp/tmAMZWIumABLQAUyyXb83aNsryL9PCgntGnK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce85d47-d1e2-4ec4-dae1-08dc00a02e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 14:38:34.9216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +27xxZ3TBrL10QOWLpmtMT037KyPav4eRFE2I+0DeSczq4mGsQpTxZp0vaYrj59QmmlpVQ0/vbeJIOfzNGltMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6301

On Tue, Dec 19, 2023 at 09:20:21AM -0500, Frank Li wrote:
> On Tue, Dec 19, 2023 at 10:07:14AM +0000, Niklas Cassel wrote:
> > On Mon, Dec 18, 2023 at 11:48:43PM -0500, Frank Li wrote:
> > > dw_pcie_ep_inbound_atu()
> > > {
> > > 	...
> > > 	if (!ep->bar_to_atu[bar])
> > > 		free_win =3D find_first_zero_bit(ep->ib_window_map, pci->num_ib_win=
dows);
> > > 	else
> > > 		free_win =3D ep->bar_to_atu[bar];
> > > 	...
> > > }
> > >=20
> > > The atu index 0 is valid case for atu number. The find_first_zero_bit=
()
> > > will return 6 when second time call into this function if atu is 0. S=
uppose
> > > it should use branch 'free_win =3D ep->bar_to_atu[bar]'.
> > >=20
> > > Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it=
 have
> > > not allocate atu to the bar.
> > >=20
> > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T=
/#u
> > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() upd=
ate inbound map address")
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >=20
> > > Notes:
> > >     @Niklas:
> > >     	I have not test your case. I should be equal to previous's fix i=
n
> > >     mail list.
> >=20
> > Hello Frank,
> >=20
> > Thank you for sending a proper fix for this!
> >=20
> > Personally, I slightly prefer your fix that saves the iatu index + 1, a=
nd
> > keeps 0 to mean unused. That way, you don't need the memset, and you do=
n't
> > need to change the type to signed, but either way is fine by me, so:
>=20
> index + 1 don't match hardware iATU index. It will be confused because
> other parts is 0 based.
>=20
> So I choose "-1" as free iATU.

A s8 can hold a max value of 127.
CX_ATU_NUM_OUTBOUND_REGIONS seems to be 0-255.

Since the DWC code can be synthesized with 256 iATUs,
your code will not work on systems with 128 or more iATUs.

If we continue to use a u8, and offset the saved value by one,
we will at least be able to support 255-1 =3D=3D 254 iATUs.


Kind regards,
Niklas=

