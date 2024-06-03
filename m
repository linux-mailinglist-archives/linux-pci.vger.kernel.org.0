Return-Path: <linux-pci+bounces-8181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E18D7CD7
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 09:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0D12811D4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B974EB30;
	Mon,  3 Jun 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MjH12fu8"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C76BB4E;
	Mon,  3 Jun 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401183; cv=fail; b=scXa6NFETKPWsicjk7MmalGRMM+TRYSmyX7vE70uwM4SRNxlH09LB93LacC9OiwtIOUel0SxjOH/wWpPRWetQj+iWeMgkgJ4/dGy5V30ZShH8WkwfvZoGrYec1++YUqpU79yfVuLvTnRxW/0Yf/KJ1SC9k4wKg/tMSaWMepOh84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401183; c=relaxed/simple;
	bh=s9c8o07BOeQzgsdd+8w/4cFojNUt++pEWrTBO53fpZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tbT8f/0bT2KbQ555r/vMZQMwoZhOqVtY1t/OfVPSBcyq46G0FTZVyaK6ouMbRelAgKHgOtO3gaCzABTM099W5glYKZbFGfXpzsyGlDXgtv8J4DKZwHb4gcw5BOjj13sepqwlo5sSJ+KgE47slA+oqZ33ojyXWHy7cgV05E4cFyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MjH12fu8; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MW7kjG5dBaH9FTCg9CBtr8RsZeo37R2tXOZmysVpAzDHLZm7llCZgsGk+v1WJSHsgUgaGi7wjRthH0VESecrzrXrtXMcBPigq6aXVBKOjUlxlGLdxJ2K7yH9+//cNHWMJV1Mc/bRpdhLS+hfhlmxwyPF6MLYzmMsbdMmgZpufYoqeFPcURzlcyx71rNhxCUFcsV8XbQEASnOQd6FdWwA/76t+ZRaCPC9VjgArKfTjCLQ2ODPovwMzoL3WIwZ1jjnqe+JflJ21AOGAIcUvgIqS3QSbN/9yZxZDdkQ13zOMkjyeOSQdC9R4j7ZoUQIfrs0zoead1CXXw7St+9qR+e2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGSPdTuE87TTSvIOBV26ElmtH7B+kkWNajplHI+HIpU=;
 b=LydB/PHl9Uig5CzrXeSMZs0xPL7LkloRDRlhvwcYO6sWB3CjaGCeDj3OfZ0izpuKta4HpOPX2CmiUWloe3eCVtQy+11jXYXBpYFC1haFIySnQMJrQlE+4ZqS2oG66yMCUQKVFG4f+XddCjVU2JG0fJ3mn5umEQUAgnQasYFRdMs2ZqtrMIvZ0oNQWOQttUx2z/su3vYrSlqtUCWSfHafwKBTxxtPJxA68IrdulGAKWSWihLTrYh4W97LsRYutHP759oVakDDakpbb5RPkWpiyuclbmrR9xAbFGlL1VEFTVT24sl43RFxwdthwfkFTqI34JbptIbSaS317grcRYg4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGSPdTuE87TTSvIOBV26ElmtH7B+kkWNajplHI+HIpU=;
 b=MjH12fu8jQdZYlKvn1fZZA9wspzqtGAmVzctlV65bKV2tiCszQRFlPlQaiwHrY/EGds1hWMbi3eYIzD/rIe4Vb+5OKM8q4SRye3HXOfrTsjevs1Atnz653Pz1PcwcvHSfuKfBlQNDpvuRO1z7Y2tmWHyudGUk6V7CZxU2SC29HNnEMK79EB5sm0yYc8KbOoVaK+BM8qilqqSsTfXUJkJ9UBSf/QIHy4Yy7/ziQAJr7XG5AYLnaiuU6qjBhC2XRpV0bzVjgF01pRnNyAl01dNDNk1yS5GAn3ymYBZq3ADMrTJHNZc0+zc0cEoPSY3uqN6WYDNu4GbVKich4KT8UVr/g==
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 07:52:58 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::780:77f6:e0af:5b5c%5]) with mapi id 15.20.7611.025; Mon, 3 Jun 2024
 07:52:58 +0000
From: Vidya Sagar <vidyas@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "frowand.list@gmail.com"
	<frowand.list@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Thierry Reding <treding@nvidia.com>, Jon Hunter
	<jonathanh@nvidia.com>, Krishna Thota <kthota@nvidia.com>, Manikanta
 Maddireddy <mmaddireddy@nvidia.com>, "sagar.tv@gmail.com"
	<sagar.tv@gmail.com>
Subject: RE: [PATCH V7 0/4] PCI: Add support for preserving boot configuration
Thread-Topic: [PATCH V7 0/4] PCI: Add support for preserving boot
 configuration
Thread-Index: AQHaoW8O6T9QgBu4DUGMsjcflgWlrrGa9G9ggBrenNA=
Date: Mon, 3 Jun 2024 07:52:58 +0000
Message-ID:
 <PH8PR12MB66741EEDF5CEF80F44973A02B8FF2@PH8PR12MB6674.namprd12.prod.outlook.com>
References: <20240508174138.3630283-1-vidyas@nvidia.com>
 <PH8PR12MB667485001077FF106E728320B8EE2@PH8PR12MB6674.namprd12.prod.outlook.com>
In-Reply-To:
 <PH8PR12MB667485001077FF106E728320B8EE2@PH8PR12MB6674.namprd12.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6674:EE_|SA0PR12MB4432:EE_
x-ms-office365-filtering-correlation-id: a395bde8-a53f-4616-287f-08dc83a22fa5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UpNxaTrtPvMrC8y6nFg7NpYEUFm8tpVhUxTdIVSIpsS82KkbeviiR6VeFDad?=
 =?us-ascii?Q?4QLBz+JE2nbC8+2XYQQtVCtMe3e08wrhubOq5QhqTlFFFMncY0JiBv5fFrZx?=
 =?us-ascii?Q?MXoF7GDnkLq9a+4nNA4iZH6NwrIkLv75y3jRYuaXtCG9TYg9vdSY2GDilewT?=
 =?us-ascii?Q?jUBr/Lh30Tsg5ruyZ6rj+0qM+Rozh8lrK2OsFgyZsnwM850JE9jx6GaXS0aQ?=
 =?us-ascii?Q?cFpMRaHYSpuegNzuDYfx7/fbL7aw9yV2WwqSUyV2iHYwsnCdQhWx70iMxBDK?=
 =?us-ascii?Q?Hg613weAaBmxM3ATV7uCwdCPn72GHV6DZgZ5oR2VDGoDGWufOW/2NZtWjsRp?=
 =?us-ascii?Q?ZLeBk/hvB+G3Zy5enZCIf1TL4ER3z43U/7JT01GV4Qj/DkxUrdvrXFtwh+Qm?=
 =?us-ascii?Q?bIV8TiQ8ii4EVnRTbNqKqct2bZUvL162MeNfsE7qGXrLr7pd9ztu0M/NWS28?=
 =?us-ascii?Q?pCFppTtVtaUFVQgQuzCO7BlHi4mzBXkHFEe2kfmo4thb5C9lUy91MTBPnwbg?=
 =?us-ascii?Q?1WNhrriT7Zpvf0hU79TbGPnjA3h+gpP8Db8T7wdX/jP/zXhvXKLexwv0DPW4?=
 =?us-ascii?Q?/hcPn6i4Qa4Ws1RUiUiFjWNfR5pnSqxJXXJw88LjVGYwPs3gbEDHSY8ry1MR?=
 =?us-ascii?Q?wvo7l3LmQuOtOBt9e4dZ/BZetoHdttEZg1+8JYNzPTpZx2pPE3MKg27FfxtX?=
 =?us-ascii?Q?wyYvB4xs2H3FEBKV+hJZFXJoReMk4C2KQ/9owx9vpPYoyuIcC3F9MenGJ/Re?=
 =?us-ascii?Q?zOzssBksWq4RIlW4HJ0mHVfRbVsBosUNxNtJydKNQB4XiABKTiuKsSBQwRxi?=
 =?us-ascii?Q?M76XLtPHj3x/RIDqwp1/W4RKKSz2DBW3VPRCXhMlY8u6TdyXUWRJ5SSQMaRg?=
 =?us-ascii?Q?phhYd4Hu6NWShfhAUw5WOxcTMUmFnLsPyIOtMyUFFGGkU06ClrhLE6GM3Ava?=
 =?us-ascii?Q?VwMci+Wkbv1gL08xoTvHSqMs7QOLGpZeF8J9fOToO8TRRz5uJIEEsllebN61?=
 =?us-ascii?Q?XE8qxvTmkG+TKZEOFSdRg0hDXMrmRFOArzx0jIrUSrw6uHdg9ojynoTfStvc?=
 =?us-ascii?Q?bO6MmOGZx7jNQ/MrAMePQ2Oo3cS2KpNgRmEXyd8lMWA+LymT7XywGRcrkQcC?=
 =?us-ascii?Q?JmHFq4bosiS3TIYZIO8Xnt6HJH+Zgnq9ALDial5fvV4ntE9PTU6iqROiKazt?=
 =?us-ascii?Q?KZ9PdfVpiWL60YyFlTiKPmTIQ5cmMmGHghJ6lF2LL2tr2CnwVi3DzxCwKlQa?=
 =?us-ascii?Q?jsQUzjauybsd9RArNfoB+cBTOT5qJYLys5iJPvrVLi0yd8ioEdiKR2lkUu5g?=
 =?us-ascii?Q?CUEUzUN068heQCP7cwx+7Xu39B++9IEBUnv+MMrKbhaV7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lekQr3ysjubWA3u1rcYq3ySn3DCFPsO7Gh0KGauDRtJQI1WEjAqa6RqBfj/e?=
 =?us-ascii?Q?KyzEItWNi4+u/ixFFoxMz90Chpq/iAVCGlAmbr0AFRYjsBUjargQYC160uEz?=
 =?us-ascii?Q?vKIsZcFU1FBL7BqMQ9MVTdYRDIZ7ynvvteSxRUqJB7OuMbDp+99wqUiA8Oqt?=
 =?us-ascii?Q?uddE+QrozEkJPN8rnGmN8NdL2Ml/1SrKDb4rENIi7TmjNkOFnc1aYQlb0XQj?=
 =?us-ascii?Q?rTj49oy6yN58iqd94J0nIXMWFH73Q6fnCbU3PW/OvOPpvo4BUabo+ObdjlyF?=
 =?us-ascii?Q?f46USfsM5i6ehZ0oOz5qQI8CSQIU4iZT2xIgSkY+Xcu72Qv8yBFYYDoWWAHy?=
 =?us-ascii?Q?WPTr2Gag6hIiZ+6qN2SN3Ax6wE4oLgQoFZwmFaS2eUz1Fu9X6y/wG5ZGAnfp?=
 =?us-ascii?Q?HvDGspVI9YHaQX/HtdtzaXCrPdItlhPBVVfchl3JXhDDPeCJ4PEPLYPthulq?=
 =?us-ascii?Q?I3YybouJNnESF6kl5VNds7PRNF5rIaNFBucoDuNb0Cx3wmBifShHZ57mnMFK?=
 =?us-ascii?Q?XT24yclhwIXIKdzCMNUeNM3J9IUYM91hoWUV2dhV3so+TAUSx1L0F75oUxf0?=
 =?us-ascii?Q?HLxozKd8rkRjfQ6FKBqpVdbC7Tr3ns+by0Kr3PpOh1U6H1kFZNalpT//Yt9k?=
 =?us-ascii?Q?Tig1kSaMYE3XYaPOi3MzmBIWBiLs6TWuTgYgMU7oxqySiIAsjNfduCQDepuB?=
 =?us-ascii?Q?B9Q4WIUezVh9bVAWP10gAeiBRRKVnCTlNYKFJKbxd/xGgngmS9whpSeVvOKW?=
 =?us-ascii?Q?I/9fJN+k+2rKr3zjLcJa0In1TBU3Q9c6VtxrIedD8fRhQqOYMNSNxoW/jZQd?=
 =?us-ascii?Q?23f2c5ObFIM3Knf5j5zM8bEC2HWiSaP0yvS2h+m+XZj1cH9c+6b+qSkTHDdd?=
 =?us-ascii?Q?afJeQbjs3TFuRudfWw4/dsK5Qy69WACuItvHRJCOWlFoH/GnA8FHFF1Cia48?=
 =?us-ascii?Q?eAtHoP0AWzZMRabnNJ6g6y5T0ewRabaq44JiwVSDX+zG7h1myG8jlJLSf+ip?=
 =?us-ascii?Q?105r+jISwkevDujgxgMkYREm0tBkH6HdAW9Sx2hA4dt6hGqMK7teCtr1VLN+?=
 =?us-ascii?Q?NohvnpDI7XIgH2ekkrOl6/t23kPD74PfWiOcytMZ+DYQkWXPPorV7ARyZc28?=
 =?us-ascii?Q?RBpg91glX34xnkQe+0iygDx0xOutZ23pGXhp9Co7Fvlc1xXcjC4ZcNiTYGFV?=
 =?us-ascii?Q?+QHhwbhblmBlyKlEmW8n8BJk5hzUgynTXFTU+Dg26DQwZbgCQyAmXx+k7Z9s?=
 =?us-ascii?Q?HXNrawm7mGFHN/FGllnOCfWuylhvDKCV9MzmOo8bPkgbnFosQjtWhqtolOl9?=
 =?us-ascii?Q?Poeybh2j9jas7C4b+S8JYcH5uhYaxWexxRq4jum2/3swp7GHscXBHOG80uQH?=
 =?us-ascii?Q?wN15fWIzc65GcklZyeT0LuzhVU14zDn2rk071gYSysJdYVC3pAMgiKgwtMCf?=
 =?us-ascii?Q?h088V1V0svCdx1p6ja6XIKFOnzLBQ9zwD33nFGDk3wUaESP+W0IX+Xjm7yUr?=
 =?us-ascii?Q?wMlh5IHtYmr4ICE3M9ksXw/pmwshEV6i93PPCSLxeBGph4nM8nx96aXLFUi1?=
 =?us-ascii?Q?YxMkPmuy6i4Ls8fGoqE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a395bde8-a53f-4616-287f-08dc83a22fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 07:52:58.6617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CaoCJCkFTDgBRhmdbMIaBlEyySBemH0+Q76jSvfBwpMdkkRbrFWKWsJXgQQ44zaTlKXR4T3k6xIG8cGf0j8gww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

Hi Bjorn,
Sorry to bug you.
Please let me know if you need more information for this series.

Thanks,
Vidya Sagar

> -----Original Message-----
> From: Vidya Sagar <vidyas@nvidia.com>
> Sent: Friday, May 17, 2024 11:05 AM
> To: bhelgaas@google.com; rafael@kernel.org; lenb@kernel.org; will@kernel.=
org;
> lpieralisi@kernel.org; kw@linux.com; robh@kernel.org; frowand.list@gmail.=
com
> Cc: linux-pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jon Hunt=
er
> <jonathanh@nvidia.com>; Krishna Thota <kthota@nvidia.com>; Manikanta
> Maddireddy <mmaddireddy@nvidia.com>; sagar.tv@gmail.com
> Subject: RE: [PATCH V7 0/4] PCI: Add support for preserving boot configur=
ation
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> Hi Bjorn,
> Thanks for reviewing and refactoring V6 patch.
> Could you please review this V7 series as well?
>=20
> Thanks,
> Vidya Sagar
>=20
> > -----Original Message-----
> > From: Vidya Sagar <vidyas@nvidia.com>
> > Sent: Wednesday, May 8, 2024 11:12 PM
> > To: bhelgaas@google.com; rafael@kernel.org; lenb@kernel.org;
> > will@kernel.org; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > frowand.list@gmail.com
> > Cc: linux-pci@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jon
> > Hunter <jonathanh@nvidia.com>; Krishna Thota <kthota@nvidia.com>;
> > Manikanta Maddireddy <mmaddireddy@nvidia.com>; Vidya Sagar
> > <vidyas@nvidia.com>; sagar.tv@gmail.com
> > Subject: [PATCH V7 0/4] PCI: Add support for preserving boot
> > configuration
> >
> > Add support for preserving the boot configuration done by the platform
> > firmware per host bridge basis, based on the presence of
> > 'linux,pci-probe-only' property in the respective PCI host bridge
> > device-tree node. It also unifies the ACPI and DT based boot flows in t=
his regard.
> >
> > This patch series is a complete version of the incomplete series (
> > https://lore.kernel.org/linux-pci/20240421190914.374399-1-
> > helgaas@kernel.org/ ) posted by Bjorn which in turn was an attempted
> > split work of the single V6 patch ( https://lore.kernel.org/linux-
> > pci/20240418174043.3750240-1-vidyas@nvidia.com/ ) posted by me.
> >
> > Vidya Sagar (4):
> >   PCI: Move PRESERVE_BOOT_CONFIG _DSM evaluation to
> >     pci_register_host_bridge()
> >   PCI: of: Add of_pci_preserve_config() for per-host bridge support
> >   PCI: Unify ACPI and DT 'preserve config' support
> >   PCI: Use preserve_config in place of pci_flags
> >
> >  drivers/acpi/pci_root.c                  | 12 ------
> >  drivers/pci/controller/pci-host-common.c |  4 --
> >  drivers/pci/of.c                         | 54 +++++++++++++++++++-----
> >  drivers/pci/pci-acpi.c                   | 22 ++++++++++
> >  drivers/pci/pci.h                        | 12 ++++++
> >  drivers/pci/probe.c                      | 34 ++++++++++-----
> >  6 files changed, 101 insertions(+), 37 deletions(-)
> >
> > --
> > 2.25.1
>=20


