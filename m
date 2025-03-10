Return-Path: <linux-pci+bounces-23266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AEAA58B85
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 06:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6A53AA520
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF261BD9C9;
	Mon, 10 Mar 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zvtBbFcU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840323A0;
	Mon, 10 Mar 2025 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583305; cv=fail; b=SX0KAsOcSuJU7iqNgcMm0FtHnzqXxqtR9ixEc5thDnYkOfBjb3tW7amA8y3GEIlbltNO5VxCeQrqW6D6KHZWWT4CWfmO+yke9tPSV9JYUkxd1P950lp3aB4HM/BgK0VzbHwwMiwPjx6fDhEpyRIs2XPVqKn7WfslrUdffEAygsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583305; c=relaxed/simple;
	bh=ePwgGEZFsoArUncls8kDm9YA1ejdjFQXMfOe+A9Z1sY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ufNKZIiDccsM50R11t5R9ZNvN39mjiyyUqiw79+A856+IK30a+Ntm+uUo74lixQMhlw8sKEOdLw9X/TSSdQOKcoYWbPC4EORMSxUbKnj8VEvVvg7o50WRgAFMHrpSK22nTPsUscvw08pZX4jWBvTA5llvlC8lfehocrjeb855zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zvtBbFcU; arc=fail smtp.client-ip=40.107.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAXTBt0D4+CRtv8+Wi+JKJM21pr10/mh37Svm+/60WAIOWg4aHeoqyPq9jlo2ncQBbl/o05hgLsyKIYokPVtUeDbjKLq6+MXJwGiwcgKGkPC9B5Iyg1i3e0l6DjrOgu/nTqvQUKrvl3alRQIFEiSf66zUdI8vjR1QPFPMTH/y270YcELGapRo2UfyoO6e9VmC01Us/5Ds3OPHlZqLij92nPrbX2MBJy0IzdmNGiZ3Gzl0nTU3CP4Cavgeok/4mvUcMvdc58na82M+hBYBhHs2U+TJcypWu4JkRhszOUdRaMQ62fow/5DKpZ8DiHWH3v7r4IFlzeFPd4Gf2wqavTF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiYd4rY5ceUVy95MT2OECv/Bam9GEnrfToUGDGhPj5w=;
 b=K0ZWE+4ebTmzuqT5h1yVe+VAieqBpnVJO5/TUouZJQ+50mA/8SVEEm4W0mcLpB7sf4qHlhUTcLvlZUzqnUxkRlakvvPSC5Wq+2bCyUTkiMWwOEzDEyDKe2aVAxcdZvdIu1ia+MBRakR0YM4RA1CJesDar69Vb0buukc82+Z522pbQRuLOcnopXcOXEJkNjdE1rgXUMYg3jHucuWCnd9MeW7R5bVf/MeJEaafFVINAngDUTJ9VdrzQsu5TlbxYe0bBMbJLtWx1W55m6NGwD2Nbzpz9fZJ+ejoYXH8UIEKD3joJ3aWo74HigmJ5F9AZPivC0yGXBLndjVCd9WuNtkGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiYd4rY5ceUVy95MT2OECv/Bam9GEnrfToUGDGhPj5w=;
 b=zvtBbFcUCvk4RJWMzfcdsUzmwRLq71BlUfXp7ZDyE/IeSCqcOKi2/637KzGE/pYygyk+zmGk52zE055FZRpHkYsu/JyZCTI7v+Zi+CX/iv/Fa9pOb5yr7rfAPAy7Mttx3PyKK8mm3A2WzBC19b/9HPLk9bp2DrBgn2H/aCn154Y=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 05:08:21 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 05:08:21 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error path
 of probe.
Thread-Topic: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error
 path of probe.
Thread-Index: AQHbhtPisuw1fWm8k0ij7RwCnpLSZbNjK28AgAf6F4CAAMGJkA==
Date: Mon, 10 Mar 2025 05:08:21 +0000
Message-ID:
 <SN7PR12MB7201524B9B94B9EA439B3EB78BD62@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224155025.782179-1-thippeswamy.havalige@amd.com>
 <20250224155025.782179-2-thippeswamy.havalige@amd.com>
 <20250304154608.5nmg4afotcp6hfym@thinkpad>
 <20250309173503.GB2564088@rocinante>
In-Reply-To: <20250309173503.GB2564088@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=19ad47b1-dfe6-40a8-9e55-d0449e1238cf;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-10T05:07:44Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|IA1PR12MB8555:EE_
x-ms-office365-filtering-correlation-id: 8a9eb420-7322-4ceb-bf2e-08dd5f91941d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?NuHQH3BFQoZbkAVDP3I9LBRlHE0pylyTez3FeAqnWu5XwwdbUIueJRxFOY?=
 =?iso-8859-2?Q?xj/0nkUFMxEXhRkJnlSx8MsnuvfXMHvVIo8HV8ZClpmZUsGsAX5XBHFszr?=
 =?iso-8859-2?Q?fEC2hrcop/mqgNvp1wD5gAPcKSAE6eyh9oPgmniX0240qoxgMSW3EsNT4A?=
 =?iso-8859-2?Q?zwBvFhV7AtyPhOUWbOaK7JVXMwCN8cBeO1kUxIF1X9h1qhep8qhb417sxy?=
 =?iso-8859-2?Q?a4paaIhG5AK44va47Qn+UTpTSoFg4lCJ+TXl7pHHpDA3mbThjNrbyFhiRg?=
 =?iso-8859-2?Q?tdhrwU7GQLDbQPNilKhrdb282cpFLG4IJ24De8zwa37ZTEoLawsjAuRKjW?=
 =?iso-8859-2?Q?jbIXr9V/K/1xcngpyXQUCSR2MfhIqfaHXupRD9j4tPNyPT7Qw/RJlfLHmH?=
 =?iso-8859-2?Q?nweiEgOtJhcdnHrc3YpTheCNL46yRNMpopIzMIml/XjyynUecNr9M47kHk?=
 =?iso-8859-2?Q?kQmeXPVsskvg0136pBo5fNwDDA7ZUQGC8oDfTsl02lca8B8HfOjlCEOvzK?=
 =?iso-8859-2?Q?ROhnMsWTJBsAnjnTlU7nk7VrtDPTpEXniirHUbe37UnFtYo+Zx9bEqt8V0?=
 =?iso-8859-2?Q?URy6WbA2AJ5ZysBUray9Uh4D+KbCOAJL0vFTV5mwgRnQi8sAhKgTkEI1yB?=
 =?iso-8859-2?Q?iQEduFJsWbgVZVdzxYRjNLNIFOmJY8y+ne0TEA5kKBXkp1NTSluDacYJwP?=
 =?iso-8859-2?Q?02H2sIbpKb8j66cuSYWz1r811Z4eZJiA16OMlz5KLFHgmHV64HpLDUWr+M?=
 =?iso-8859-2?Q?ofsgaQfPDEGigX6HxJOmLzompiQpoXmjCej/G2cZlojxwojGTwqb/pFlE3?=
 =?iso-8859-2?Q?QA7XcWZKMxH4ofX1Q8+Q7JWVaeU59wsXmbMmC4uPmLEDpvwv5fgb3g5OER?=
 =?iso-8859-2?Q?1ZwwjSW+9msfJKxUWdWqLNUJtGLFuiSfUvQgufEAHpRkEhK7UJ2rtkMIgo?=
 =?iso-8859-2?Q?5HHm1CGQU9zJpsGQ+uhsiyDzwEZa+xj165HF4UQMLK0FiCapv+qbn3QBQ+?=
 =?iso-8859-2?Q?C2tgz9qML7oaW2YUFSLRxszwWx4ReN3R2KmZE7yEK/Bfbvj6Xdr6naINCR?=
 =?iso-8859-2?Q?TUwMya+jmA4/www4/KX7zfQfJ3nLgsyp6I28qAX+DH3ulZarnH9giXJkNG?=
 =?iso-8859-2?Q?hSs8vayhPid3vyxd1YPrNAmBvzelWIKqPuOWggtfBBQwKYjU2WdYnfcI+d?=
 =?iso-8859-2?Q?Qu83j9qMB9yejkoaAxTUzF06bG/R0QYGfSJxx7vrkUTTssXa+LymVxym70?=
 =?iso-8859-2?Q?HoF0jV9QOS97q7cv+hIxnbYGblKyfQbfLrxX4veDKNkBvG7B1V11viBPtQ?=
 =?iso-8859-2?Q?yFgWeZOLbcSDb1jPwGyZD2N5YeDn7KQj0scZn2XeuJx2l+JRbLxHA0dugU?=
 =?iso-8859-2?Q?z8PX1ztrO6Ss65WnrcoABMjeGeBTwzEx/I7IklRG/geXS8OhPbK4eJZ3Au?=
 =?iso-8859-2?Q?/ozK+Y4k2GzB4Px+yJ5SLQqxfmizLd9zvEZuAAJ3w8uAk4ov8B2HovAzwQ?=
 =?iso-8859-2?Q?0gEmhB7JYC5nlRmGay8Dxw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?wUjhEM1VVVI2y8yuvOG2C1gdLhcScmxf6g3RQnT3xu6hCBQV6Fuu1Wch1I?=
 =?iso-8859-2?Q?Z3FzEiBVs1WnxgxMIdi34NNQUqEMWhxApLSDR5I8CXMM4N/Wy/KTGYxlkL?=
 =?iso-8859-2?Q?UvCIQNMyO5CQJtC8ks/M4Xc+h06JXgBrZXr4GWntPiJTbooaDVebQ0Xjsm?=
 =?iso-8859-2?Q?zbxMeYFGJJ4D0mj8wBuoJ5ISAfY13L6EptXBV1K4Dm7ThnAR9D6L8nyLz2?=
 =?iso-8859-2?Q?RfZn/HSNpJLC2ayGjjN0bokZs/F2rN4BoELa08oKEiIEj6LLuNYQzPY8+/?=
 =?iso-8859-2?Q?aTes7jZyicBUtXPO6gvjQKrNLndlYK7eV9MbwWUzCacF9SylqwYLX9t0Mh?=
 =?iso-8859-2?Q?xn4hi4W+f7pGtnVuEmVnXkfyrK7eft5D5bqKWMkXwWVIn6IwtCB3aIbHTC?=
 =?iso-8859-2?Q?YghElJZ+rQYkkDuMLKFflnGcU7LniVQbdJZ2u7ozcau0cT7x9h59igcPlS?=
 =?iso-8859-2?Q?xghjkhMTS3YyjlamPgiKFAoWes/vxsG+6TvR7i5mLgdZTTozHEs7gaI60E?=
 =?iso-8859-2?Q?XhyrqfL7Da31Qd6oSsnVUuOzB36LBJJJjNGh8kB7T4VIXudSO90bKVSIZY?=
 =?iso-8859-2?Q?0tGBb73zt/+fpH+EvagNNLSpvvi3lFfcD2N150fOG0+7jHJyMkDlnLMwai?=
 =?iso-8859-2?Q?Ziuu+UDO3++iUZbG7EpJHpgyCJdscZh9ePU4CNi19eUUT4lakAAWs1d9cn?=
 =?iso-8859-2?Q?t/jVvrpSvxaZDBrY5KgWVbUzJ4WITmzVXcy48fhp6ytVVGRhEDMBC2J1mN?=
 =?iso-8859-2?Q?kJamf+pU7u83276LPu5xUKOodxzMQNk5wNmTTGfMMTNVwAiODR9ehUhcqB?=
 =?iso-8859-2?Q?/X53MfWES4Ezu5TXkwDQG1GwbpZkUvyeSrEaX40CwnFk+/KebvW2WziGNW?=
 =?iso-8859-2?Q?kfZtP45OF8Uly6IBV3KH3gy7pe4IWnuoDEUdhBTn8Pjoxu0o1E2A97XdBq?=
 =?iso-8859-2?Q?orKCF+Ew4RYVKDFbThd72PHgtUuM0oOUqTiZnjNbPQ6RAqRgfoBY/Ommo3?=
 =?iso-8859-2?Q?JKw5UZoKO47qrIJniojcFzAtGC7hn7L+3h9QmHKRg99HKV9F01Cq87/jZb?=
 =?iso-8859-2?Q?A8iAbmzupSYU/dBsDm95L3fClG9g5clPo1SjjBCRs00633upDeldLRehdy?=
 =?iso-8859-2?Q?T+6tqkiZ76sfDXHPvkyAbZMnML2mrIbm/F2yS9/2zNx7e8iMtdZ1yy22BE?=
 =?iso-8859-2?Q?VESHRF140OEywe6gvEk9IiKrkmeCb4sO+X5m+u6pTRyrZvyLID3spd9ZBl?=
 =?iso-8859-2?Q?C1GJ5fYmSW5etQ0g7o2KLqK5RB/L4Kwqeiz4ID22FcfdwTvOKbWDbQuVUI?=
 =?iso-8859-2?Q?rLNw1wPVMzr/eyoKm205BYN1woEFX5x9Eb88dCqydLleRSZtlEZ/8LYFmx?=
 =?iso-8859-2?Q?QYX73gjK9BdI8woB/1GNV4ADDG7dXHt8Idp+mFQUdbV7MxAUOUdBd1njSn?=
 =?iso-8859-2?Q?HOwxaH0dHcD9fEFcRdCaHlhTQeSVN51l+3igMs2C+Lzlh51MRAW3LWhBYJ?=
 =?iso-8859-2?Q?2oUeTA2xjyUrUMt6q4cxCxjyTvEx8TfgzO7aNQg/qcDvfMNNPQQIZ0uZDF?=
 =?iso-8859-2?Q?SVIaeu1rOyShy7B06gDTsFp1woPd8K2Jke/xD5w0i+/3vpYZfsLB8npFPK?=
 =?iso-8859-2?Q?SAUkFCTpbu9jY=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a9eb420-7322-4ceb-bf2e-08dd5f91941d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 05:08:21.6312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQvSnPr5eeY0MxsDzPhkbO2sJ5sxnX5NhbxpVhML/fZ5u+GYXDhL1tgxbdieQTKAB5u1Pp7+xq/fN8EWQnxaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Sunday, March 9, 2025 11:05 PM
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>;
> bhelgaas@google.com; lpieralisi@kernel.org; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v5 1/3] PCI: xilinx-cpm: Fix IRQ domain leak in error=
 path of
> probe.
>
> Hello,
>
> [...]
> > > The IRQ domain allocated for the PCIe controller is not freed if
> > > resource_list_first_type returns NULL, leading to a resource leak.
> > >
> > > This fix ensures properly cleaning up the allocated IRQ domain in
> > > the error path.
> > >
> >
> > Missing Fixes tag.
>
> Done.
>
> > > Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > ---
> > >  drivers/pci/controller/pcie-xilinx-cpm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c
> > > b/drivers/pci/controller/pcie-xilinx-cpm.c
> > > index 81e8bfae53d0..660b12fc4631 100644
> > > --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> > > +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> > > @@ -583,8 +583,10 @@ static int xilinx_cpm_pcie_probe(struct
> platform_device *pdev)
> > >           return err;
> > >
> > >   bus =3D resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> > > - if (!bus)
> > > + if (!bus) {
> > > +         xilinx_cpm_free_irq_domains(port);
> >
> > Why can't you use existing 'err_parse_dt' label? If the reason is the
> > name, just change it to actual error case. Like, 'err_free_irq_domains'=
.
>
> Done.
>
> I took care of the review feedback and added missing "Fixes:" tag, and ch=
anged
> the code to use an existing goto label.  Both changes are already on the =
branch.
>
> Thank you!
Thank you, Krzysztof for making changes & applying patches.
>
>       Krzysztof

