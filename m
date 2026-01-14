Return-Path: <linux-pci+bounces-44781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE7FD2059E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FD9830E56AF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22F3A63F4;
	Wed, 14 Jan 2026 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="IYZzsFm0"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011060.outbound.protection.outlook.com [40.107.74.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775FE11CBA;
	Wed, 14 Jan 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409430; cv=fail; b=SZDAc5ZYjmBpx5FEVKA7swYMTeg0Zrc7yLUzZUlN4MbhjR31CKBbgAnJeEqeEXRXLPHiM8KUxTiR8mmtuQ2sn5DbFnEjHZHlHTVEj+dMjsWmO9SoRbOoJMdnhTTloeWk2R4suutSDiDoE0Zz6qjyJTXHXPC5wskatAKYhhUTwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409430; c=relaxed/simple;
	bh=JP8vkL+B112T93klHHjC/mWbZAu7QFxzceP6fQLpbdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=grKAqMZ8EfSJlbC5uhZzWwEL1Kmge91L6MDd2Uzd7WyMJQL+JGjENQnkNAk7HJ7BpKZbVJ9NUOQ1bm+EL8BQsORsw7fWR99bb4YaYxUxJ66IyymlryngKJWLfC0wft6cd0IqjSqqP2dk6nfMgjFS6glck1x1j0b82hTE1c2n7BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=IYZzsFm0; arc=fail smtp.client-ip=40.107.74.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkBKeT1cA3L0R9Xlq+NYbmq90V6IX6QY+SK8hvp0G3o4kyIYoUgjK1G6+oRIBGe0wgvvgcmGwScXlqRrZ8U70L9SEXgnLvwFIhDpyeBQKLmKU3mIxVTj/+lEOt7W1lcJVr4KxFzXHCxh5GPKUiO0ITguhjllHaVX5rnrR30Jq6lWa6hlFlmtpD8WfUt6sKDHcq+YGvJdOwUFQQgf/+Zln8Upn683ReQTzIIaLEhEa5Wndy3+kOcXNt+Fxnw0/XXzUoLvsq3IBn6LM2Kq7SIBWSr4aU33UdKIsyTaeKLs9L05VzMAOdfiqQWnahoQFoKgMOWJangjzmQsqI9k2HkwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/qA9zVWU7uUb1oPTA2lW/jhONe5Ns1LddWVJXS8upg=;
 b=FdBhMlf2rOK5DtFKC0xn6k8ghuUDDqhyCwR0i4oFuDexY+Olzd+9p036laW2uivjrJYLaM/W1SMUOrikSK+XINwWb+Wim3qvlU+E3RNtSgU+/QOC+ZOEcgisyO9IY/XdC15XCA0D6mh0ILDghT3wPYgBYHx4lj4HR7wOXNHp0+CKK0DzY3f3JQoCk8weZHD4nsfE7IbWiwPBlgxA9fvDZcLU87n+zrAtA1wWdgIcMsMj3f49r2FFpWU222V2b6r3s+8hPrbzb0o0MNAHi5KIhos8GHxmuk+IR1luU4kPD/xgd4c8aLdy0GsSiSyzeEDggp5pnZa1EDmRK+j+fXLgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/qA9zVWU7uUb1oPTA2lW/jhONe5Ns1LddWVJXS8upg=;
 b=IYZzsFm07fGQT/2SArTbrJR/wsaS0mWtbCIw6pn7QIbxwBUz3J4wHTBUWLIz/GEydduyQqIOy9dC1rVGRMMsXLSlW2ZUOk5dh6WhOpyuso/3RLC555VARHVBkkFKpZGUZr0tydCbRCvWXwFo2apOXDJ+aV+0bXROCo/lNS6XsSY=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY7PR01MB17079.jpnprd01.prod.outlook.com (2603:1096:405:32b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 16:50:22 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:50:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 PCIe
Thread-Topic: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 PCIe
Thread-Index: AQHchWur9/nIdtd5C06yYiYnWalkELVR1xQggAAFaICAAAN4oA==
Date: Wed, 14 Jan 2026 16:50:21 +0000
Message-ID:
 <TY3PR01MB11346C084AC2534C52822BC8B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-17-john.madieu.xa@bp.renesas.com>
 <TY3PR01MB11346AE1205D35A8D8BC90B9B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY6PR01MB1737773DEF65ABEBEF11D2E96FF8FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY6PR01MB1737773DEF65ABEBEF11D2E96FF8FA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY7PR01MB17079:EE_
x-ms-office365-filtering-correlation-id: d7bd3ada-76c2-4238-0ad4-08de538d019f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F2MUi4iadbxzzwuyEz0yFzP6CN/wwwxmmDSmMOu8hrmzLlgGhSyWrmc7urET?=
 =?us-ascii?Q?zDHULhFuYTFmaO2BBCl8R9kSeA/19HucQJTU08bl9XhPQj9zd+6Cys1+WqdB?=
 =?us-ascii?Q?RuBgzMT4gxI0bxgmrvlMeFBxMkZ8lb63UGDts11/Pb7GnMjfCRa+Il8OaYZC?=
 =?us-ascii?Q?7ErA4vfHMh0ZDW0B5MWTNiLK0FfZaJ7KC99UMxlTSVemuzYpUw0AfukYxw0I?=
 =?us-ascii?Q?DG+scLTB+SBKeNLdtsO8Sh7F59H4a7qxOyFu5Z5+z1OP/V770xtRfAUuyvCB?=
 =?us-ascii?Q?8uRpU2IlzEL6pmsfH/0Omg8A5z7ON/2aU9u1Cuh3DbErYV8Fxz87xNBELIY7?=
 =?us-ascii?Q?ixCCk53kKP+q1J77WO462Et5dvFBN1BJqyb/CcxJeS1R1It05PK2Sw64Nner?=
 =?us-ascii?Q?Wem9UBGoJJ/5kPHU5KyFsXIAI6wBS1X6gLW8XMrE4GREzhV+EbtdN2cE6bg1?=
 =?us-ascii?Q?7yz6q1scd8qUNLqYOiDIKN7YgcDC0rDXiS0nVCFJXaTpLvaVLe0g51aXtNCo?=
 =?us-ascii?Q?XeeF58NxqtkLSAcGjjYH89sSZm5eWghJflC5Bskfeb9Hwlkkno/ae3vHIP6r?=
 =?us-ascii?Q?Sp53zI5REIPSlsvqx38Wp2PCXFqrrkucBTA/KHQY7t0F9OcGIyz131hyNkVf?=
 =?us-ascii?Q?CcmLw+mihfVd/3NfDHcrP0mMkw9JlfWnsllw4SaOstiiz6fWstlqEViV/haC?=
 =?us-ascii?Q?ONL2/l7qOXpVOVPCul+jT4aHgRoh/u+2aFWRqAwYmfD1kW2CWi9dTtqbCxDW?=
 =?us-ascii?Q?wunYAxdtRbf+DXZh6XIRL7qQY18gcl4oEMyaunhyTWaFLVTBjKLiLnqkAEE/?=
 =?us-ascii?Q?EqfO1XEUASQKvGqDnnpFjhb2WkDuAgHuFRir+V/edgB9tBZ2u2fc1+s7zXJI?=
 =?us-ascii?Q?LGbJLhOhu7aTYSXrCG8g6GscF76cQ9mzCRjfXLwnUWvlYwld6wdeOx0YnnOa?=
 =?us-ascii?Q?6UZOFU7Z/3xk4zngN7hK7eOxF7d8l/QST1HZr6Zf5t5W/caGUCVUrhJUR2pO?=
 =?us-ascii?Q?Q2WGIABTF0fgqQHlasaPMzYbtR8Sz0A2HAh1Zrz5yDoUJ8QSb8O7eDGyxx+L?=
 =?us-ascii?Q?tR3qy/okn2/wJv/TSQzutCvXenjTVdqZndlKQly7UH79ZGwuJRjAUvewwN4f?=
 =?us-ascii?Q?BPdLMSddSk4THOq/nCXI12LAY4f71KOx15rrTy9+To5O/4cSZqM2rK4GvjBS?=
 =?us-ascii?Q?VcwceteWD0/GMFPM5xdqx2MGfK+fvlqauxETfBiRfueHzsv+AATdz07+wf6t?=
 =?us-ascii?Q?KaN1FEcYPRfalL8EervTAY37iiKxXtxkZ7eyT39s0jQoq2VrBWuVdyX9atES?=
 =?us-ascii?Q?H/9BJC/KB9lcF7pzCy4TYcK5ZiDq7POo5/cLm4chrwWHLRAztb+dtw0b6DAN?=
 =?us-ascii?Q?8X8Jw+qJ3kJv2v0da15IgGJ5In1BtVOZ/WJvERrF4XsXJHsb2vad+hTgtb9/?=
 =?us-ascii?Q?aJQ/7llWalGHyxAiAhSMtCksPxZaA1uXT8ywkTCsKUkeI9n52+xrlVW4zJZG?=
 =?us-ascii?Q?uK+/CxHTZfC0cudCh+T+G6fmFOIBQxWa31+6icLcAobmXhFQRjP/3+9pTYHV?=
 =?us-ascii?Q?d695P4RQuM/gPk/0l2tAHzexc7ynYsLjFmghxkv5BnVX1BCPWlWBjlL+wwFH?=
 =?us-ascii?Q?kNLnB1XOUZntPxejvZXYEEM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d+5qC0fhduVhOnH/6aro7MiFvuv+tfmqoR0AaZRAFcxpSExTXMW2HJvcaZiA?=
 =?us-ascii?Q?7XAC7dQzHxNBAAyjfkQVWxs/7oTwDlRabqcu15VyFGD5i+9Ept23d4XOk+5o?=
 =?us-ascii?Q?YOc4/0grYXi13vLgAm2FENL/b05cm7gzgRfsNL5bp2J+ESIKGaeEZkCdGyQO?=
 =?us-ascii?Q?iV/TQ2PHPGbZoDi6B+OGq0prXVjWN4JYEIqTFmg3io7t7JgZxdQtpb5cczh8?=
 =?us-ascii?Q?SZgJ+i18+MI8bF2GwIKeeFW03eTihnZbj66lfXAZ14VKiSvaFcPXee0yQBZ6?=
 =?us-ascii?Q?s2+N/gMzflFzs+Ld3sC2WtfeDSmlImGqTLXaaFh3A62i72Y0NhbrOlx3eG4t?=
 =?us-ascii?Q?KxIFEb/m2JMeJ666r7MC0w39u7yGvS4r26NEkelwOmoyLqNaYOCgGfwP05Ad?=
 =?us-ascii?Q?Nw5okAlUEN9bCVQU8RI/HUrPr5hOIUEQlFUQ2rIxDpk9cu7eLWmUOu1/f4Lm?=
 =?us-ascii?Q?fj2iv/fguhYY+1bNIxgxLrqZyak7xo/GV/vNtLhd0ctcEH32i9WOkilxT78y?=
 =?us-ascii?Q?RzUVW8AAEF7oxeePs+Ipnv2d/ei9O3J+dWOuQyhDx6i60fk6vG1dY3eF8OB6?=
 =?us-ascii?Q?rH91XpKzH+hoB8HpY2sVtAb8S4ul1ea+tHUJHjBPD71ywvJqmcxLLZhJqsxd?=
 =?us-ascii?Q?kv0Eq2BaG8PTEdh6gg1irsmJduTlTgzyghpjvj7HQpSX9wLLhmTwo/AlSD1I?=
 =?us-ascii?Q?b4pI7H7bC288DcuOpidvQehHJmVvE+0GqqmT/i/RmDNQDXs2J4iJHaYhEj5r?=
 =?us-ascii?Q?vvHTkc7qixebwZetJRc49n69eeOovY26qQpCYVqeZliPzbK26dYHzH7YnVZm?=
 =?us-ascii?Q?RDPj54qaU7fHWCoEqFv1Wrwm9nIpMKOGyoGySlFwspbJCfM5uMwPAPFj8NMT?=
 =?us-ascii?Q?jKxBZtx1bVyKm6tXIGlD5XZH3bsyQjDdbY0Fus4ADotNjRZMp3iZ0kaiHHsx?=
 =?us-ascii?Q?SE58q4yKAFFU217ofXrUlWn/tR5iPNfn++b8cPPfOAJzSMHg4eCmbBuu79Rd?=
 =?us-ascii?Q?4o5lD6MjSlgXGMoIP7ClRoGUC3Ll19ERLOmn+WX+tjQO+pJY8f4x9gRzKVkH?=
 =?us-ascii?Q?BMW1uGaBTZAVeGB8dy3h28kXGOfWP4am9EihxOIyv+EAb5JfJmlaFkd5Pn7d?=
 =?us-ascii?Q?G4p/xsnGEh68h0ut0P+ZuF0bwEZUi4UOhQDePOsVLhZ7cQCwv79vHE/CfJp/?=
 =?us-ascii?Q?ikGcFOxRbq1UKPkCwhyeQadRuFKpmp/Vsokv4k0I+/PA9b91+AEQMkmF0I52?=
 =?us-ascii?Q?zkyPOtpv8BTnillUgxRvlOpbwSac1oZGN0xdDczXWIiFqDYZJdT5tEVgeHZq?=
 =?us-ascii?Q?bhKV8gMdyhw30we1fcfkV0v8IFbSrRkbYOao11HuNCHx91HVqdUPcA3lMRsB?=
 =?us-ascii?Q?G+j8EHpuqrVwppb2owSgyQ8rZ8yz2e55FEWDm6nKhCKssCfVT5GuffUPkjbe?=
 =?us-ascii?Q?MgmZBL+UvweAkr8xZHAC+jz2q5bASWwgJYa/MyQ9VeMR7lgeIX0kDOpNxmYG?=
 =?us-ascii?Q?moaiI2bOFkIeXWha2HzSBLD5xmipIkuqjdZp6uhP3R/sxlWiZbCP4pK+QpSx?=
 =?us-ascii?Q?2vnxp7adKN3yxQrtwMr4GpwByGoHCCzMqPd4ftnlcCJ5GNe0z/NANkMA34zK?=
 =?us-ascii?Q?G4gKYA8HtiLnIc1ckvARCg8qjfBZaEV9WrSQ/d39o2T5OoCY7fTTP1uVUv4g?=
 =?us-ascii?Q?d47vuMljXG1Vm/Y4uCCEvskdrqRs8jIElBf7GjDPGPU84P6UwHOg3t2MQIqD?=
 =?us-ascii?Q?r32sKnYiQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bd3ada-76c2-4238-0ad4-08de538d019f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 16:50:21.5479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CagUWvJ/gk2hQGXu1q9hDFgaJ9ItvZeEUmGxpMv2FLG0f5BFnfPN8kdwtA0X+r7U0xoy0g3+QbMHHS8DTjMLEKD/VNkyZTA6BLRrr/L7fa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17079



> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 14 January 2026 16:35
> To: Biju Das <biju.das.jz@bp.renesas.com>; Claudiu Beznea <claudiu.beznea=
.uj@bp.renesas.com>;
> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org; geert+ren=
esas@glider.be;
> krzk+dt@kernel.org
> Cc: robh@kernel.org; bhelgaas@google.com; conor+dt@kernel.org; magnus.dam=
m <magnus.damm@gmail.com>;
> linux-pci@vger.kernel.org; linux-renesas-soc@vger.kernel.org; devicetree@=
vger.kernel.org; linux-
> clk@vger.kernel.org; john.madieu@gmail.com
> Subject: RE: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enabl=
e PCIe
>=20
> Hi Biju,
>=20
> Thanks for the feedback.
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Wednesday, January 14, 2026 5:20 PM
> > To: John Madieu <john.madieu.xa@bp.renesas.com>; Claudiu Beznea
> > <claudiu.beznea.uj@bp.renesas.com>; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; mani@kernel.org; geert+renesas@glider.be;
> > krzk+dt@kernel.org
> > Subject: RE: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc:
> > Enable PCIe
> >
> > Hi John Madieu,
> >
> > Thanks for the patch.
> >
> > > -----Original Message-----
> > > From: John Madieu <john.madieu.xa@bp.renesas.com>
> > > Sent: 14 January 2026 15:34
> > > Subject: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc:
> > > Enable PCIe
> > >
> > > The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
> > > Enable PCIe support.
> > >
> > > Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> > > ---
> > >  arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > b/arch/arm64/boot/dts/renesas/renesas-
> > > smarc2.dtsi
> > > index b607b5d6c259..3db7d31be2b2 100644
> > > --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> > > @@ -96,6 +96,13 @@ &i2c0 {
> > >  	clock-frequency =3D <400000>;
> > >  };
> > >
> > > +&pcie {
> > > +	dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
> >
> > This entry to be only in SoC dtsi like RZ/G3S.
> >
> > > +	pinctrl-0 =3D <&pcie_pins>;
> > > +	pinctrl-names =3D "default";
> >
> > The pinctrl entries to be moved to board specific file as it will be
> > used by RZ/G3S, RZ/G3E and Upcoming SoC in future.
> >
>=20
> To summarize, you suggest me to keep only the dma-ranges update in this f=
ile and move pinctrl
> assignment into r9a09g047e57-smarc.dts right ?

Just "status" should be sufficient. Drop dma-ranges and move the pinctrl en=
tries to board dts.

Cheers,
Biju




