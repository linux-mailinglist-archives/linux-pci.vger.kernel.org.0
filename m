Return-Path: <linux-pci+bounces-34550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A98B314DD
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A379318972A4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB703393DDC;
	Fri, 22 Aug 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rqpxk2MI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5A2C0288;
	Fri, 22 Aug 2025 10:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857649; cv=fail; b=YdvmNt6+Qyc84d/11XsgCTzq04HCQm2jCBv8F8Ye5kYbiAx25xaO3NL6+OuAF1kYsVTS9hVfgqQmGF6k6OTOPwtTXwWULUWYuCdbS+U4pFbHqBJrJxif442clhDLXn7TTfAkkUdeE0VuOb7C1UwsExsYxOflpcwqjK+zKvMnO58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857649; c=relaxed/simple;
	bh=beOfH4sVtYm300QmSVS3a6KFIkg5LgjnBizf4zEfRz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dJIA3vupXtAZRaVE3R10ocuKHpFW1blILfgegFa5ecKZshCIQBzUmUKN4dD58zY+LP+umLTz33YNfwHmDMeaRFioqajQQa2oYKQkvrM8cbkJKrTksuKJcHLaUZrWJAZr5dHgLn64n0ifXqv3DdPGBWPf9PyY/eGQYXQ6E2A7FFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rqpxk2MI; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc6+ulBhchjtkYYrTpx256KDt6vMwJJx6Ji20C4aljI2DVIdi9w9ErwRYg+H3J7bMxfeRqpG6SIz/jRId39+RcNtUBky8k6d4Vw67vnGXj+9lXTN3KUA1iKMjPWrUuFkH3N6DQegQ5pZOflaJA5jeYCm6sdf1z6H3BHCGPmUYPzK2bXAo6DuqHIlsDDF1uQmQoUQYEcR4Iuo+8yNJ5M3CC2LgzRDh3BKfSPIzxEJl3ec8mKl+h/lo16r1JvMq6MBbDHr56xcgyzECs0A9toBwD30cG/p7vgpCEShUYt7daedv8N6zTOQYmEPPB7yfe9vSL/OULUUAFbFZinWL1mpeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8kcxDt+/dTtEm2wjZQDXDSr3LizWphsYSqkKyQtbSg=;
 b=k7rS+11/oWF5tOTUW9paRVgjVkIuE83vlAUZ6CdHua+GM0ftjKlXxBXclkSNeEsXCikN+ER1tpp+Vdyouvogz4HfETMm6neQ3e9PfN5CHSt8s1Eaq++vP2TXBGFiNEyNLX5rQSuufTTKAb2v4PNfwLcc2adNKSDzLR7Bwb4DHmCsSFcAUjRSSejrVqo/K+lo5Sf4lga89lHpgiBd6NDdUwk4HZ6gKp2OfydAT0f1nrgi5NGhIta/3HmN3aPvuwFfMdMCQ6O+lMS0qio888CI6guGW5bO70Uty7XAfuRFuEPrvuzFTB9Mm/eR+Ql52ONOfHl0GHus8JB+eGuBZq08DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8kcxDt+/dTtEm2wjZQDXDSr3LizWphsYSqkKyQtbSg=;
 b=rqpxk2MIACG7aXW5pfbbcS5+HpvMoWYpqeKNY0/BF/XEA2urwkXOpDY1m5XzDcHy6jkoYUYxDKPyVP/CDgJEUxVoRR7OXO9WJm8OhpBYz/eCn1Dez8fhu7eD2uZbfMOVp2hE6KGipW20OctxY8gJUxMLyOqE27vbpAZO74s1s1Q=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.17; Fri, 22 Aug 2025 10:14:05 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.9052.017; Fri, 22 Aug 2025
 10:14:05 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [PATCH v7 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Topic: [PATCH v7 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Index: AQHcB26ZvUF4V0XCuUS3aC3lVOW8NLRfc0GAgAA34ACADtu/IA==
Date: Fri, 22 Aug 2025 10:14:05 +0000
Message-ID:
 <DM4PR12MB61589E5E068830E754187382CD3DA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250812194113.GA199940@bhelgaas>
 <20250812230112.GA202387@bhelgaas>
In-Reply-To: <20250812230112.GA202387@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-22T09:55:20.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DS0PR12MB8525:EE_
x-ms-office365-filtering-correlation-id: 9eb0804c-aea7-4691-02fb-08dde1649ff9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cKYDOqeRnM6dQ8Wc9mx1g4mQD+hYpiG+lCcTbqbezgHrgduYt2SbAIOpzMTP?=
 =?us-ascii?Q?ok9jDgpKU0a3abksEW8nisAOKhShkw+3xGZe/bBtiJ6Q0QSsvg6nGf75QVBK?=
 =?us-ascii?Q?e4xL0lZHKb71eYZNlZV6UqY6QInr7N5TH9GeHaACXd5BwRqKPz6xVGCaLNtK?=
 =?us-ascii?Q?2D58TLB7F5/UuZ/PrjNhTbnvNJ7v0xQajifrnMwJbM+0c5MO1opS4HMbf+wo?=
 =?us-ascii?Q?fYB5OjFQYP+A71UeaMtr/MF8DWWlaZUWKpjmbCXnunXJWxMjyDnGYp/EiIQZ?=
 =?us-ascii?Q?5Gpka14jw0qOpp7k/AmyEaJ+RRQuo3qXpRfkMV+KjToObhTStA7+47O0tdfo?=
 =?us-ascii?Q?VXSwvksp+HrS/y+huhDBttaNK3mgDrAVmnTOet/f6yWjsvM0ud9UDd13Eiqx?=
 =?us-ascii?Q?Cm/mcKdUz23MV/pcrGG7GdaORFaKhAz6re+9drC8l23z6TacV8dxUeVQIk3L?=
 =?us-ascii?Q?NLXUW/FwdJjnOsaqsQ0kMq6cBpUloqeM74mbTJoq/e7G4R/UbP6+qKV5ZjB4?=
 =?us-ascii?Q?PQ/R48oqPoP+LMxCTqpiJwgs2vNEtQIvDVRZuskDdHkLNmyjWszq4H5BTOTJ?=
 =?us-ascii?Q?Fubhi0Im1Vzeb3ACI8DR3DNYhs0d8zxyhLrUotvjA3fipZd56c5DkI7Zx+kg?=
 =?us-ascii?Q?9mhQzsGLdLXz/mDluLaC2TAHjiunqYhqoPAoDiQxq7igVA/Sv9wKx6h461Lr?=
 =?us-ascii?Q?VufCvUdZ2L+pQs+nKqdJ/Mky3LzFv2Yn5B05gEeVqqaD8C8/rXxaCSk9fPmN?=
 =?us-ascii?Q?x89pbYUl4O/rS+ajYRIQQltZXwr9f0nhv/IEwZc+IpuFl73ULXRgFyhsLOao?=
 =?us-ascii?Q?1vN9Vybk6vDlGWLoaJqOS2a6pE4GVZroXj++KXXj4/8uqbxgaq3d8EPsAetr?=
 =?us-ascii?Q?LJ4U714Pnema9pST9gQmBLHd0vhXpcCA1TK1qpwSL7TRu1mBQHIml2CGzGMQ?=
 =?us-ascii?Q?B6blXV5oAHCGZBtIFL/KxPjy8jiU2wYvjG7P4+Wrmdn8En5t+ay5US9trynu?=
 =?us-ascii?Q?acQmO67VARQ/IVlZ6wx92nYmRReLiyAAnYiJxb0tXus5X87giJiKks6LTxF0?=
 =?us-ascii?Q?5K048yV6mLtwmy5GBJwikREG26JuG1WvHXM8ol9r20nM5wcAFMJASu6xYi9c?=
 =?us-ascii?Q?rrWDzW6x7GGLLsvYb1jWLQ4a1ZQi8Ptv6y3ElH3JJI4kxUX92VXG82KijI9p?=
 =?us-ascii?Q?UgQRLOS4JrUdXrJchgjv1bkSEKcJAt/CMs7nwRBVe0YDwhtV26g0wl9O4iPK?=
 =?us-ascii?Q?RLyiLrY8i5xWZ34k/L09YXwwDxFv+n3poloeNR5a/0rp3oU18y3yeo0V1VmS?=
 =?us-ascii?Q?X4oBzogw/FEUcAA9rd3rzCCHMA4ZtfSzeO8SGFYMdhq+KnGtAKOa8QpfeGNe?=
 =?us-ascii?Q?z2LDpXJVWdUeqdoi27GUUrCa/T7Evs9O7/ABOAd0febwfV3cEPrErg9fWAra?=
 =?us-ascii?Q?Ehh7ObuSnO4c708FFpdNTdqtUgJJZhYoPpSnMexzxHo9im5IqMkHGwT2kNxb?=
 =?us-ascii?Q?huzyhwYEhdlrhcQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LGq4JWCGByaKgmWamWD9sqAHlhNTf4yDztX26LnB5DZmgpYC8+dEt3Lmw7Y7?=
 =?us-ascii?Q?8UVr7TRnwTzzBT5EdT9q9SRVJqmOZFFMsAaBGCGJS6PEmOU2tFoPhygWVSXY?=
 =?us-ascii?Q?MmjlRAofgqPKmwyxwR8rNSwwz9PGp1rOSVIywvylB0m8UjBu95Pxy6RV6vm9?=
 =?us-ascii?Q?PJ2nitrE1pKX5AYusG+84nxxzDy7MPIb5V/SLhyb7GfboyuWcyEPcRYqoeEe?=
 =?us-ascii?Q?TTjmPKuTUygpvH+Rj135w/wGTsJUIQYDGdlZWio8rJRjIBqZTSOjvxzHwuD3?=
 =?us-ascii?Q?tKahLuVXh/4gmQStVxziA5z/h0jCubF/6etUtt+XOR7YCWokkx8pPO9Nfqns?=
 =?us-ascii?Q?HNRIABRWxYId8uWm4k0j/ePcsANRYULKT/Mu4xtuVS3YokgVnJglGUJu78gi?=
 =?us-ascii?Q?CCpO8+fhxnxUavwMLkB6WPXgWOT0uzN3PLXcx6+SQjN4RPMSyiyb61NIMmwj?=
 =?us-ascii?Q?pHXt6TmLRbVl73WHEfw7FMP9p6li6jA7iH3/iF+hDKgLAeMlIO+Os6A+I6hb?=
 =?us-ascii?Q?Xbu50NPwJ18NMWedPGPDBPdRdoNyEP+ZOLzm5c9UvpCLRe0BKQxYGXkFN+hn?=
 =?us-ascii?Q?o4cLDoeaaQbyDxPtFeFNf5RVC8qW/PuI+qVN9G3ttZVcZIZqXdWSZ2MytwUb?=
 =?us-ascii?Q?s5GEjOb5XjQ/OYMgw79YFIjp+q44ZpcY+IGfVpXTGTnLwVupwK1tIHCtSW5w?=
 =?us-ascii?Q?kfNWXe1hX+RsezGBAHj1UtGO0xA9VgD7nH72g/2aQhjAhXq/dUFk3t3R4Vbk?=
 =?us-ascii?Q?6M0fMbh2gWk2BJAgKOMjERNnrVfFZWtD/bKy4FwnyE8rIif5RaAKIn7xcuo8?=
 =?us-ascii?Q?m6vGvL/WsYh5wkKk7aYNcVNUwdjDYGqZ9psZoGya9X+8ozOASkyQOAqDPWMb?=
 =?us-ascii?Q?ubtAWNsgoH3QieNRFlslDLfK/mtdHiPsUl5RT5MRdLxk09LwxUWTbV7q40m0?=
 =?us-ascii?Q?c4a/XnYkeypcMLnHlKsUsdrBqSrttxQFLn0XXch31ysVVuvKpZxHOD0bn8Wg?=
 =?us-ascii?Q?N9YmeDI/MfNJcEkZmpPpM6tNWe2bg7s58gWcTom2OGx2fSf4m0DT0+/RRl0F?=
 =?us-ascii?Q?u5/e1nbKRD5GwJnD3V7ktEYfMDKi/y6e/ioKpmdF/NFf2c43HsHT942nWn0d?=
 =?us-ascii?Q?STQWApf51Fz61vfdTLCjVDlAMnusZ86RPQt4HxUv8wDvtT4OPCvdRtyh+x7J?=
 =?us-ascii?Q?S9nZXoEUv6wa4FaLE79SlkC0Z7LxBWd/o/b4PKa0yHVyaP03bB74gZf6SegJ?=
 =?us-ascii?Q?A3d6sILzFMUoa3gfxFAA8yDXKqF/YKiODJhPGgG6LIPMkmE62hTQVKGoBsRN?=
 =?us-ascii?Q?BriZJ2PSrFArbqgb2Tk6dKi5R/YhJPg03EiLezZFHyw4N+v7Ns6oay4LzAI7?=
 =?us-ascii?Q?sotQ0c/MoZiFC64pAzPnNgdnMoJ1jzNg8Ya6x+267xOrKkvEaQ/vdSx+fHBI?=
 =?us-ascii?Q?0TotgljVGoaSGSqNINPLHhqxaDlVwC943aB4W0dPIyYma32RZWGuUaedXyVN?=
 =?us-ascii?Q?HcjkyhmoZShWvtRZWKS1jb3K/6Eo6el/EgEREBDLq6uMjamYjMRQxCac6vSj?=
 =?us-ascii?Q?rrmw66drf9v5xzEaU3M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb0804c-aea7-4691-02fb-08dde1649ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:14:05.3007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pujAwfAo+5vT7kkkqcCbSN2Cgh/8RTx8Qs7TBmefLng5SOiGHU8okh1xXi9YtC4Qhk5+X7ITWB5qKjPCkQqWzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, August 13, 2025 4:31 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com; mani@kernel=
.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [PATCH v7 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> signal handling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Aug 12, 2025 at 02:41:15PM -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 07, 2025 at 01:10:19PM +0530, Sai Krishna Musham wrote:
> > > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERS=
T#
> > > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > > reset GPIO. If the bridge node is not found, fall back to acquiring i=
t
> > > from the PCIe host bridge node.
> > >
> > > As part of this, update the interrupt controller node parsing to use
> > > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > > host bridge node now has multiple children. This ensures the correct
> > > node is selected during initialization.
> > ...
>
> > >   * @slcr: MDB System Level Control and Status Register (SLCR) base
> > >   * @intx_domain: INTx IRQ domain pointer
> > >   * @mdb_domain: MDB IRQ domain pointer
> > > + * @perst_gpio: GPIO descriptor for PERST# signal handling
> > >   * @intx_irq: INTx IRQ interrupt number
> > >   */
> > >  struct amd_mdb_pcie {
> > > @@ -63,6 +65,7 @@ struct amd_mdb_pcie {
> > >     void __iomem                    *slcr;
> > >     struct irq_domain               *intx_domain;
> > >     struct irq_domain               *mdb_domain;
> > > +   struct gpio_desc                *perst_gpio;
> > >     int                             intx_irq;
> > >  };
> > >
> > > @@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct
> amd_mdb_pcie *pcie,
> > >     struct device_node *pcie_intc_node;
> > >     int err;
> > >
> > > -   pcie_intc_node =3D of_get_next_child(node, NULL);
> > > +   pcie_intc_node =3D of_get_child_by_name(node, "interrupt-controll=
er");
> > >     if (!pcie_intc_node) {
> > >             dev_err(dev, "No PCIe Intc node found\n");
> > >             return -ENODEV;
> > > @@ -402,6 +405,28 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie
> *pcie,
> > >     return 0;
> > >  }
> > >
> > > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > > +{
> > > +   struct device *dev =3D pcie->pci.dev;
> > > +   struct device_node *pcie_port_node __maybe_unused;
> > > +
> > > +   /*
> > > +    * This platform currently supports only one Root Port, so the lo=
op
> > > +    * will execute only once.
> > > +    * TODO: Enhance the driver to handle multiple Root Ports in the =
future.
> > > +    */
> > > +   for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, =
"pcie") {
> >
> > This is only the second user of for_each_child_of_node_with_prefix()
> > in the whole tree.  Also the only use of "__maybe_unused" in
> > drivers/pci/controller/.
> >
> > Most of the PCI controller drivers use
> > for_each_available_child_of_node_scoped(); can we do the same here?
>
> I suppose you used for_each_child_of_node_with_prefix() because, as
> you mentioned in the commit log, there may be multiple children
> (interrupt controller and Root Port(s))?
>
> I think of_irq_parse_and_map_pci() takes care of much of the INTx
> setup based on interrupt-map, so many drivers don't contain any
> explicit INTx stuff.  But amd-mdb must be an exception for some
> reason.
>
> Most bindings don't include an interrupt-controller child in the pcie@
> stanza.  I don't know enough about device tree to understand why
> amd-mdb needs it.
>

Thanks Bjorn for pointing out the of_irq_parse_and_map_pci() API. I'll upda=
te the driver
to use it for INTx setup based on the interrupt-map, and will explore remov=
ing the
interrupt-controller node if it's no longer needed.

> Bjorn

Regards,
Sai Krishna

