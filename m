Return-Path: <linux-pci+bounces-32581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7BB0AD83
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 04:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E502A565923
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 02:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B018B47D;
	Sat, 19 Jul 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vPYOfbcz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3212E36E0;
	Sat, 19 Jul 2025 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752893987; cv=fail; b=KvgJ67qQrn5jyVV7mys36nzUMto/7wO50qxlV3PI0upBjzWdt8pKZUfWLQ+Ncs0H96byHDmldc7PeACy65lykKyUWw1lFZIU/13ng3KqL8wKEQYGEdc90QJWVcnA/uZPN13l0JlcgcnE9gPVPoBLUO/+NJ7dnWDcnIoWd8u6zxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752893987; c=relaxed/simple;
	bh=QTpbRxH5GyIYgkdGafbjOiuBukYPYCjSel/WtptccAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G0Da+BwPJVmwgXxppca0Vz0gDCUrBPeDGyU6ZZ8W/IPHMmdJwQgCt4I2EGQO9DjXMaCO8B2OHLq3qwZ3Y9efLJ/5Hjjj6t8+WERyc/OXVqR48LAqpkT7Meuk/71uriLmo1kkpBny2Znx5aoIG0uBOCGbt44WobUdVhGvc38Unu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vPYOfbcz; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrJKMXtioVlKWLPeU2lCCo+YNk8KmRb+rDWCfbmdAbvHWOHS7CsOOWrlpV0bR8i0XkcRko6Ycv5hK77MQEW7ZzuLHJAgANVEimZNOxIjV9yQ4QEfaxvzRXijU4j2YnpFMDRoOuoLVEBU0HH/Pg6opQobPYWXZX9cKW/cL1j0vnImy9oH0A55WHLIk91kzXm7Q6zKuz9B1wNG7nQ6Sb57TD89TgLfkezMlJwh7Q19UwfjTSb5mBe46F59sTRmi3wnE5BbJ8uMYvp/yKWqV/hy18vEN/S5/n4M/H359jZhyEwQ62hoAs4Zp+fNu1dL5XXCWBCCUqbE0v56EQgrI3fcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBE2kadrUtpsKhpTqXaHkj/5KWauMK6B9bFxPtyWWPQ=;
 b=P0iUOF+0TLa81LC+Fh1CnQ7xmdAJRh2EgBsXv0BD+pxRKDDuhZ8GlgTeV67EJOqnt4PQaymU2p5sxgYWn3JL3OtCRAwtRfFL15rIweOY3pe2JiXOTiVrE2JFRwuaMJm+4CXMMwVHbZ4+RK9TiyAqh6MPEuRjzNIIS1JqaGsjKUFLP8MlXZ9AvfgZ92izfwTT8eal0l2J2qM+TSmQpCSBCh/Fv0ph3y9MnGPBgNVsbhIwy+FBrYaq/q9k2vNtmu3ZE2YcGvcitnYZqtFcsjVnUfJ+508IF33ICFMR02KC5leG3/3m/oLe0G28mu1n1G/I2rckoh37UWi712yunfMxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBE2kadrUtpsKhpTqXaHkj/5KWauMK6B9bFxPtyWWPQ=;
 b=vPYOfbcz5vdcn5jAocrkw0HnUXSUkf1fu/xDCDZ8FIs8XOiDkh8SG9rNOwJQY9kCkJ3Xji7ig3g/IyP/pFZJQEu5+GOaPtbRUES5n6I9/Mr4HlVyVd52U0VL/Nkd/ypZuWFJT/HZyO/cxLIOKAvkNbeXf1T2cJdwwx7+kqT2Epc=
Received: from IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Sat, 19 Jul
 2025 02:59:42 +0000
Received: from IA1PR12MB6140.namprd12.prod.outlook.com
 ([fe80::92c9:cc21:f1dd:abec]) by IA1PR12MB6140.namprd12.prod.outlook.com
 ([fe80::92c9:cc21:f1dd:abec%6]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 02:59:41 +0000
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
Subject: RE: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Topic: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
 signal handling
Thread-Index: AQHb8iQRia+LCHEfhkup0319RPtRobQtj/EAgAjHjwCAAcckAIAAqjkg
Date: Sat, 19 Jul 2025 02:59:41 +0000
Message-ID:
 <IA1PR12MB614051F6617C327B6306CC1CCD53A@IA1PR12MB6140.namprd12.prod.outlook.com>
References:
 <DM4PR12MB6158DFAD4351A17E3523CA58CD50A@DM4PR12MB6158.namprd12.prod.outlook.com>
 <20250718163150.GA2700763@bhelgaas>
In-Reply-To: <20250718163150.GA2700763@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-19T02:41:05.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6140:EE_|CYXPR12MB9388:EE_
x-ms-office365-filtering-correlation-id: fdddadf4-844a-4d88-3eef-08ddc6704ea2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YMTKifF45J6g7vvyu9t592S7VnmYAFKfC+Yi5HINjdCszqWZjx+K5RvcoEXl?=
 =?us-ascii?Q?aNozTS9kIwzABlUdWvZIlJ5K+W/3oxvk4neL88zUaWWsAvAFqcS4FM5b41yG?=
 =?us-ascii?Q?cQlSdFtINi+AyChwMwL+DmhtPL+4VLft/gnHUUVYUbDassSZ3wWUBmguUKEe?=
 =?us-ascii?Q?lhgEr4SkXJTaydG2HcAzB3OMzhNzZyZYURk85dWMuThbVRX14Z6tIDw/4tNJ?=
 =?us-ascii?Q?hwQY73NVVPbEOh9s5j0fF6tpwOpRocA5SrMYoZPzMkVlNo/bgTruHBT+Isfq?=
 =?us-ascii?Q?2aTBqUl9VwJoQHxSqpibVWvu2raonMkgLc+HRnSCuvZWoN7gna/zROEZ2bae?=
 =?us-ascii?Q?YSp9YLy1CROvALgm4fJcqOXAsn2BcBxnHgAY6PacSxIvOxzildDF02//+TS4?=
 =?us-ascii?Q?c8R4C/X5swX4sAE6Tm3T7cZ4kzT4FvQEqpaaSREw3q884vG0ky5fA2PTCGOQ?=
 =?us-ascii?Q?tvyXlIJzYkO1/aCQ1V1H7T1lZExUkarQrgzMwJ0WD4k/d+c3Z+oQbsg/B/Bl?=
 =?us-ascii?Q?3oXkb7WUWLkgUpCEQtb/DxrsQX3tC0zK2tiv+29io0dJqMjiL+9zugkFdpPc?=
 =?us-ascii?Q?AjsJivgHRkHFpVIpjpfwHbUGWWDU6MRTuPi2z5f7t4wP92hMUAtVGfNOX8Uh?=
 =?us-ascii?Q?imDsKC6HtueigbdyAWcIDx781+KoI5PkfX23b7MdG31lXhn7VMPmwy2jmlbQ?=
 =?us-ascii?Q?Jn6y7o/8yP2FfOWTZjtBp5EpXUCjwWR27meC//k5NXI4yuRVoeas6jhn/RJQ?=
 =?us-ascii?Q?j8ClphWrGDcACwDHgpXxXCdGAQMMkaMO1msqbOvw7Vfv+TrvRhPW2CqFzDHP?=
 =?us-ascii?Q?f3lIfP+Q9NtX68JscKLd9YEiMqwcbBWQzuoMMbFBD0zmBMoUz2FVXNMoChyE?=
 =?us-ascii?Q?0dzOA0xx22ccbWxuEsN/JZ1UHgmTrD/6CIHFmOehMzi9ZgVWTFW2OUCLXVUP?=
 =?us-ascii?Q?e1u2tZ5cB8y9OU1Oifj69h1rHN2u/CXDHMyZau+roviFpFu65K1cGDzuStWo?=
 =?us-ascii?Q?hveY9xSeD1+AOPscaM8P5yzsQ3SDsLgjXDbGRwq+uwEHb3xgxSOufxzVbmM+?=
 =?us-ascii?Q?Kxujo8j6ytGULDm6lreScCdetUbaohuOvQi2U6u5KqOENoF40IpHExiHCxiG?=
 =?us-ascii?Q?nNJzjsexe8ZbA/37+gBjP0PUDiQUKJrwlfgKxlfj50mJKfuoBFjgQHgoHGFw?=
 =?us-ascii?Q?W1Cjd8/ccnFrROYnA6FsGmzNsw7zkyk3gXxkAJ4+DmcIA2FAt65w3v2BS5qH?=
 =?us-ascii?Q?tRHbJFQbLTfVzE0/Av/wxiGRJMk/ctrion8b6kTURShFw2M+rPho8t9g6ENW?=
 =?us-ascii?Q?HrZaG6pr00sgmGYmSg7E3mYCPjw25c3mvOPqE7QpjuY61eQqkXgNYMyJjPj9?=
 =?us-ascii?Q?2W1rTSLbiV1bTVI3xFs7EPPzLBCbpXRXibNN1acNdldK/eBMg0UV7OmaeQb4?=
 =?us-ascii?Q?x0Pt3ortnH32kLRTXfu45uy6K8ZdTwPunGNHancHhci8ZPWwamYqkf9TU3ps?=
 =?us-ascii?Q?6z2La+C9Cs/FvFY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1bZMQ2vCjQcruOtA7zZS+vfAyBgBlXUP2jsqojbM5jp3ZcQfReW45CsDIzaw?=
 =?us-ascii?Q?ZGoE/daJJyXIKbvgLDj+WcHbd+b+RnBwK2fKFOSN2Fd/YaLuZGIUXrBv8lmK?=
 =?us-ascii?Q?ZQAK4ZOW7in72osBjy+lbnVVuKAoRKdtWLMsLp5hlO+SDTIwj7H1JMU0c1s2?=
 =?us-ascii?Q?tUzcPzbsNKKbz1o9LZPcn/poRaMLf1Jdc4ixh72KW2MkYokL+0dBzooDcxwH?=
 =?us-ascii?Q?ucVtq42putL2U8PtscNf51lMzGmMHeVxTIX8AzelaVAd9xZbpL2pHXWZ+gYu?=
 =?us-ascii?Q?pyOGxqoR7LRau7eZQzJk/HWbYnpsAif3nlSonjhLVz2obgsZWptWf9M9oku2?=
 =?us-ascii?Q?G3BbSilPWMBBaXyrpNvRCgYgqJIMudf2lKOFdyuk8wcXL49sgsORW5X4Vud9?=
 =?us-ascii?Q?zdmYN0GNPPRJn5XZifKjWkXPLxntYamHpzKT2vpusnS/lNFLBehsRtZijdvt?=
 =?us-ascii?Q?2yjtJTA3cTsEo9LziDtU0AMvW6K+EFewR8zoBkpK+JBtdH/BOX5SgOpAhcA6?=
 =?us-ascii?Q?5X72k8sGVZMtXGtMu4Sw+fPLZ6cz2pWB1YMNXwRQosk51ziJWQ92UkY9BHGo?=
 =?us-ascii?Q?X+0NuCYjFNSJf+wEJiq4U2cd8BUuajI7mM8ftk2e/d/7alhB8BGkzwiWLnFe?=
 =?us-ascii?Q?zX8LmqJySQPE5KTYNjqO0MXxBW04AGzdEgcMdiAi67YsaqGfwsPDL5KLhn+/?=
 =?us-ascii?Q?zKaBJrOnZYSizQi/zOh1XvLlLxneGHxfukh7vSwQTbFGojocJeAabvFPaBvl?=
 =?us-ascii?Q?9Ckl0vB7OK4YKVxEqIxX89ZVKXuSjITPe0zLw5m7AG6OFeA4pKED2iv7RwbL?=
 =?us-ascii?Q?8R4A2p+yL1oWIPNiR33e9S3HJeS+R13sDjtzOWw/aP+0KyHnrpSEteCPWRis?=
 =?us-ascii?Q?8mxxU47bsX8dxug1eP96Elyaxi/WRMOtT1SeV/6Dlzm4bdzA3FBOSmUu+mkY?=
 =?us-ascii?Q?seDDs0rdLsJtlyyKo+u4b8aQE00cFgyst8NRqIDI7MV9L46wCkMi51jBhKut?=
 =?us-ascii?Q?L5Cv5vQ/PxAyn819neXAL/wEzL5tUra1nhO9cmDpYdP2ONtUCJS7svL0BJiU?=
 =?us-ascii?Q?GS6OEDbgOCOEEwn7jQf58C1DmW4RFEP9HLjYmtdwSjENfE4H6AaznbYsfIra?=
 =?us-ascii?Q?v4OEaZAYlBvYAB51UMCMem+0FSF6wkcAOB1i93DNqPmZ9LADPMeSjmecTRaR?=
 =?us-ascii?Q?U2MzNBhJZM0GL61Xkef6niBuasfx4ClAQAOVFF3k+7e4MTUq+QQ3dZCbR5ZB?=
 =?us-ascii?Q?9QeBTnnnwKiN7mCgkE7PAO6qKjnNki+JUWVh/yz9gSANqxFn+4THguHeOznG?=
 =?us-ascii?Q?SbLaEhh/X6FX/RpUBza98mP/V12aYu/5t1VbNnrTN6k1vL9i8BXD6Bebs23i?=
 =?us-ascii?Q?ZRoE6BEtUYsCnVyZlQv9bS/VxzZA6hho1uUX/27YO7PefHWDG/NCUNcEiJPV?=
 =?us-ascii?Q?f9xXXZwb4sps0k2Dr0l6aQmTkQwlqDN1UK+gNXQRxDEsqBR5N+GqTqZtnaBx?=
 =?us-ascii?Q?HChno8LS2o+YRghPd07V2UmuSkgBkkFEkDfgz4Y2pZUbqxvjPLrfm884va9s?=
 =?us-ascii?Q?rpYJ/fH095FjrKQzPHg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdddadf4-844a-4d88-3eef-08ddc6704ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2025 02:59:41.3760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JibCIbc7sJM0g9R5y51KqYKWJ9B6El56b0pthuq6LdzwIa/xjgBO0Pvk3Qvudhi+Jri3n40SOgdooCuQhSOTKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, July 18, 2025 10:02 PM
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
> Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PERST#
> signal handling
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Jul 18, 2025 at 04:30:32AM +0000, Musham, Sai Krishna wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Bjorn,
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Saturday, July 12, 2025 4:49 AM
> > > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> mani@kernel.org;
> > > robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kern=
el.org;
> > > linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada,
> Bharat
> > > Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> > > <thippeswamy.havalige@amd.com>
> > > Subject: Re: [PATCH v5 2/2] PCI: amd-mdb: Add support for PCIe RP PER=
ST#
> > > signal handling
> > >
> > > Caution: This message originated from an External Source. Use proper =
caution
> > > when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Fri, Jul 11, 2025 at 10:53:57AM +0530, Sai Krishna Musham wrote:
> > > > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PE=
RST#
> > > > signal via a GPIO by parsing the new PCIe bridge node to acquire th=
e
> > > > reset GPIO. If the bridge node is not found, fall back to acquiring=
 it
> > > > from the PCIe node.
> > > >
> > > > As part of this, update the interrupt controller node parsing to us=
e
> > > > of_get_child_by_name() instead of of_get_next_child(), since the PC=
Ie
> > > > node now has multiple children. This ensures the correct node is
> > > > selected during initialization.
>
> > > > +      * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates t=
hat the
> > > > +      * PCIe Bridge node was not found in the device tree. This is=
 not
> > > > +      * considered a fatal error and will trigger a fallback where=
 the
> > > > +      * reset GPIO is acquired directly from the PCIe node.
> > > > +      */
> > > > +     if (ret && ret !=3D -ENODEV) {
> > > > +             return ret;
> > > > +     } else if (ret =3D=3D -ENODEV) {
> > >
> > > The "ret" checking seems unnecessarily complicated.
> > >
> > > > +             dev_info(dev, "Falling back to acquire reset GPIO fro=
m PCIe
> node\n");
> > >
> > > I don't think this is worthy of a message.  If there are DTs in the
> > > field that were valid once, they continue to be valid forever, and
> > > there's no point in complaining about them.
> > >
> > > https://lore.kernel.org/all/20250702-perst-v5-2-
> 920b3d1f6ee1@qti.qualcomm.com/
> > > has a good example of how to this fallback nicely.
> > >
> > > Otherwise looks good to me.
> >
> > Thanks for the feedback. I've removed the fallback message and simplifi=
ed the
> "ret"
> > checking. Could you please confirm if this looks good for v6?
> >
> >         if (ret =3D=3D -ENODEV) {
> >
> >                 /* Request the GPIO for PCIe reset signal and assert */
> >                 pcie->perst_gpio =3D devm_gpiod_get_optional(dev, "rese=
t",
> >                                                            GPIOD_OUT_HI=
GH);
> >                 if (IS_ERR(pcie->perst_gpio))
> >                         return dev_err_probe(dev, PTR_ERR(pcie->perst_g=
pio),
> >                                              "Failed to request reset G=
PIO\n");
> >         } else if (ret) {
> >                 return ret;
> >         }
>
> Looks good to me.  It's important to note that this -ENODEV fallback
> uses the PERST# GPIO described in the host bridge, not in a Root Port,
> but I think your comment above includes this.
>

Thanks for the confirmation. Yes, you're correct - the fallback uses the
PERST# GPIO described in the host bridge.

I will submit v6 with the simplified error handling.

> Bjorn

Regards,
Sai Krishna

