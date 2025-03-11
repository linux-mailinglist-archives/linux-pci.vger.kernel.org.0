Return-Path: <linux-pci+bounces-23415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52690A5BCF9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 10:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6821885A7B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C490F22F169;
	Tue, 11 Mar 2025 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YE+MXy+H"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5222E415;
	Tue, 11 Mar 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687128; cv=fail; b=RqG/zzJhOIgszV00iogUGbcQOkyKpGiEV8Y+vS/jNkZSwRfmW/GPtbygqvv2Rrhc8ZqejNgCzTfhVTaVb6RKg6CZ0GKNS2p6Olw2taQGsRieac24NEyytiiOvAUMwkQ6Pvrh0FYsc6xVnYsHRLpidQRcP46MorGAqq/zYSwwWZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687128; c=relaxed/simple;
	bh=V/7UDhCo/+AOJAlADH+bfVHiGMUUydF5q6G9D28m1kw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ORDtJywkZZEwF5TQZA1MHkiHMJzHlZOd7dHrc7aOS0KFPkuo40kahuZJI1e9vZG83b40QNQhp9jnPSq9gI52hoBLeEafV2DnfBVmQEjgAya+l52dhk7GkO64c+YglJEHHrc9DZ48H/PolfydMawcgDVO2B2mMUBnpS5WW2zZqks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YE+MXy+H; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSr3RAwHW380ifQgYkiwVIQisPgVR51XAHP4FeXA9o30hB0qkLAF3GZDRZ+YooS1qj8huGgCsMzpKfbJKOWRdmV8K7vEObhgv+DgePtXihEODjZtN9IN7hBiUm0VbEl74+wKeo9v/+aryb2+1iVPAtyiJrggx0J/qwHonIZIfRgj2S+ImPh/QPHbiENKsq1lXER4pSXSG9Z5Y7xwSlBJfTlUvO2VJE0+xh+DvDm9lmUrWFSmGDkVcm4ozq+WiB3ReOzvxg6xw392M6FYFF1Y4Tq9HQs/f+ECYdY1VSkph7wa7y1OAtg5SNxM4dnZmeOAVQJ3heuNAPTk+b/4bWzdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D3ajupwf87Rog8wwXYt+SvbhZSn5EmajZ2DeQyjOFA=;
 b=GvFZLfAczQo/sq82vBA+RQUMZppQANqzngJkM08w1/bnGoUe5RFlf71Daw+hWJLxpdmttR4tnkP8eeiy+wEdznIEgoRMV/JeeXfYAerlY++h0kNfgrakind+/UG+ARXnocXaMbMM/KfH8qjGRvk3DGjp6dwe5vxt8OrN/p3Bj6s49XoJ1ouqxzQQZRZ6Q2lfCmWNGPfcwR4j0V3Oo0JftQ6nCjz7P5nsrFYMTtSKCguQweeviXPkJaKk5uL6i28gqL50k8DO+7jOL5naNdzDskL8UCh2mI0KqLwQN4Mi8DUU8krFwiSCJsYy2ntnKHbcWXGsMSJ9QbswPzb7i2QS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D3ajupwf87Rog8wwXYt+SvbhZSn5EmajZ2DeQyjOFA=;
 b=YE+MXy+HWAOQcx2/kEuzbSUd5jYivCHoQxF86or29BC6o4QbzLTRcKaHT/y6QeqCKmz59WR3v2lTw40M7t2XaewJYviz+MIcW/nOABAer1QJi9EmWS7YsuG7utlQei5cfxXhN3QuTY9BGD561yLEdNLi9cGMBP5IVAn8zZCRKxU=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:58:44 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:58:44 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH] PCI: xilinx-cpm: Fix incorrect version check in init_port
Thread-Topic: [PATCH] PCI: xilinx-cpm: Fix incorrect version check in
 init_port
Thread-Index: AQHbklaWJoDg7ejAvUKNDyKVdBuXUrNtiXIAgAAqHBA=
Date: Tue, 11 Mar 2025 09:58:44 +0000
Message-ID:
 <SN7PR12MB720164A0B40D1EB3DE4822AF8BD12@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250311072402.1049990-1-thippeswamy.havalige@amd.com>
 <20250311072736.GB277060@rocinante>
In-Reply-To: <20250311072736.GB277060@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=dddedab5-4866-446b-bc65-d92ca0dab9b4;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-11T09:58:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS0PR12MB7655:EE_
x-ms-office365-filtering-correlation-id: 0afaece5-77f3-426d-89cf-08dd60834f5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?5VEhHp29PLGO4+LdOz+gJPzE38yQCR9Tbpgjm9N+lvKgdy0NAra4iRWnUm?=
 =?iso-8859-2?Q?50LDZQ7KsVAlx1yhe+IyPI/nI9sITjj67IbflbScrBTAnhCWNWuwthi5/k?=
 =?iso-8859-2?Q?4DZDyK9SG9nJeMjF8Gv6Duar6lxKRsiVn65rOF0MfDMEwASXcoKyps0sVK?=
 =?iso-8859-2?Q?/ve+C31rmukgHqVEPkYIkN/QJpHhRpS3MheIaf2NjAPQ06ZmCuMRbeULNk?=
 =?iso-8859-2?Q?/EA9I4UhB/UMJmas42+Ouqgffrz3S+OImSae5j3AxV2NCezwTSiW0vNXIY?=
 =?iso-8859-2?Q?y8tbFMbIBs0s+F6M+9hq4nl8uyRFLsmYJiVc2XWduwzs4IkGn3m1dMT9AL?=
 =?iso-8859-2?Q?lk8mTkKd/lm/X/sqn1QrzbfygKpfpranxENHVbGFmzhGvnJ5yEtKidYkKA?=
 =?iso-8859-2?Q?OZ0kLGoPlSi9aLtZNOG9vrWxpvbIBxwyL9bCcyJASxI1aTgijYJbqHd9je?=
 =?iso-8859-2?Q?mIkz20V5ppgElARGxuwImk/gAuEBCS2MA47alw8qrovAxmQ4qdIAEaxCvh?=
 =?iso-8859-2?Q?2i7Lz4ZQTr2jQ9Y/X1DXSVlomzYS9dhm5JpqYJHh06ktThI9rM0LclNC5m?=
 =?iso-8859-2?Q?8Syj4Z8qKdiPmm58mF7qL6d8kho8nD2XAZf6lc2nkGc/dm4S+bJlCF87iB?=
 =?iso-8859-2?Q?7EGR0jw1bMLWCyv9tI7fOLJOrY3051AWmq1wUfEveKQ4cecFtou3DGnslD?=
 =?iso-8859-2?Q?5iDw0TYWpgFlY9U8sgK+Cbr+aiahKydHUJQy+LPBpoH2sKNUdH3wttsiwN?=
 =?iso-8859-2?Q?Y01EdzQqTS8xBVdSIBw8sNnMjzplkOEMkNbpiL3lpGG4ckQrsYhEIZQBL0?=
 =?iso-8859-2?Q?kmNrmq4Eh65HzI0U59H0kAzKYGJkEJcOYdOj5sK+5FnC6//cuECfFXK5KI?=
 =?iso-8859-2?Q?j2HJOiKsbgs2Q8OwLjWW6YgJj+DRbXJ2zqLS8p7yY/yFrF7ejAL9NcOPIZ?=
 =?iso-8859-2?Q?vhBaqZglqA+r7POwPKYXgEHgBnPR9Ke+rpWxucy/heWCnG2c8DE+oivejG?=
 =?iso-8859-2?Q?o6JxlsHXZO3QuYqzyPZetwV5CLuEZ61DWIRmLbdITJG0j+vbNfNk38fhSh?=
 =?iso-8859-2?Q?gOJ3SGLXpBFVyhxdn4X9Iuj70erAoSkL8o6GRuiEuIF0gK1+kzDpItevvX?=
 =?iso-8859-2?Q?BS6rz0v7TDe4AZQ0Siq93b147z85s4fXv7OHLtTl5WmsjNsxExmBEd950u?=
 =?iso-8859-2?Q?qyZgemLfCoAHiWu7DGTtBVuteP/1B02MPye2B3QmgpJEQVzHbvsXkz1vd/?=
 =?iso-8859-2?Q?kNELmsGuOG6jIJVPQ96t428t2iCi6WkFbYkBbqUd8U0raczyekubgxuZkt?=
 =?iso-8859-2?Q?zVHYvyjkLJ//cE99maZwp+GLsQdudGEKzEP9Wu/E9vR0/M+iqohEnZvrW/?=
 =?iso-8859-2?Q?n672AVRTGTZ3cQW60U/crdLTt93VKtni10RakInelCW9Zzi9nhgZlxB7F3?=
 =?iso-8859-2?Q?RiR217Ms0iYZl7lPO1YgkMHQfCr7RtJ3WYBxMnID33Bv6Cz7qZ5HRc8qWy?=
 =?iso-8859-2?Q?uxvHOtMW/KzjBO/umXGHfw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?cZo1i+2u01dGeCBp7PJcxYfZLg7LIQLCpk5XMYVcOhCmgyl9r2sN+lvkr2?=
 =?iso-8859-2?Q?QI0SfwhPZitvZOLgRvzycfANdHXrAiXS+xvrxBHzuhPzA4xb8ICSr2UXdB?=
 =?iso-8859-2?Q?lad/sYCOlPBy929EviXog18ulujMFhJalrYmMw7IuUR/esTqg5STgaFpZS?=
 =?iso-8859-2?Q?VRknONB1volv6X24XAsu9BqAv5u+qSqO0ByDzH5qHsDCS0dJpMbXJDi0mk?=
 =?iso-8859-2?Q?Ggm/yH9fA8/MXfIedNJEZxtl7m2+EDZYEpsQB7JGKosiraT6GuLzqlNESg?=
 =?iso-8859-2?Q?61XWJW+HVtM4g3h+bXILbTs5r9ip3+cPDGjIAEbNHoU/tc6T+14pbkyjEz?=
 =?iso-8859-2?Q?K+f/6qTUE19QW8eT4IkmUeJ29JKcqc2VR32pZ7aKzSbFQ8O+i7/fR82+ys?=
 =?iso-8859-2?Q?9aaUMwYF3W/w7p2+x32ML9GfyzSkCGkf4UE3dpklh4WIzP/rn+8eMBkzx/?=
 =?iso-8859-2?Q?Y+S/KCvbqCelWHqWWk0Mkyti4iUn7OgybdzkNsK4lk0MB55NW0kBCBDjdk?=
 =?iso-8859-2?Q?+jDN0KNTe6E5Ln2wg1iWvjQ8I/UeUehGom4mSklNnoOAGI3f9vr4so6WSU?=
 =?iso-8859-2?Q?cQNn/Rr6gZjkeYzdfmCQn2eq6YqJmR8D1tlonlZ+fKHJpgK9g6mjQ/G49L?=
 =?iso-8859-2?Q?NH6tQIGr1Gi+MxG1txEPr2tM5IaIUrPNRi9EuMrJM//6hYB6iM5t7rP7sU?=
 =?iso-8859-2?Q?+xk2K0OgmYC2aE9Jf0Enp50qeP4bSP0ot4XRHLcw0f3m4JVyrHfDOQIO7I?=
 =?iso-8859-2?Q?rnAQQIBkip+KN0NkNegX5QDrPTGQ+YzZN3fb2yQSV9FYsrOivBg87paqL+?=
 =?iso-8859-2?Q?7LDjCNBnBiINKAMtP80m0q2tYabZWBUCkn0OangqOzOh9A438nbwuu3uH0?=
 =?iso-8859-2?Q?UiVXsxOZq1U1ylEFfaz1KvYUGIupZ0IMiQG2pwTFSP0l4GhMcgxO6/ymz5?=
 =?iso-8859-2?Q?9cj1VNviN/O8+PWubXOeE+yS7+zWHMNqUJtVMtg1Q0c1pH23mKZwAxWBr2?=
 =?iso-8859-2?Q?1XpQedHJTBttC/nyoPuiEVmcQUC3P7hlnWOWAE8NQ4pu6SFIZQcIHT2bhL?=
 =?iso-8859-2?Q?L9YObpZYCl8j142NR8Q8L1EFR/wR3eO+zWPvDxtq1Tss39VKk1RZt+DhYh?=
 =?iso-8859-2?Q?bbeK4hn2n9oBYbBPCHfWpeLQ8pySJWeJWvrxU2VdMmEzpZOc+bSV3KzUHu?=
 =?iso-8859-2?Q?l1HSvf7+le4epT1uiQBDcwbvRFSpNXsLbAUSVAf7UfAmMPdu6zY3xm4Ajd?=
 =?iso-8859-2?Q?5eqF0eN1l98KJwS41Fo54U5DnkWDyc1ii3NvbXofABFE/imQ/Rt1+8DPdE?=
 =?iso-8859-2?Q?Qf6yJ1IWRhi+E0ndmL3H16IucMhpAPfccp593g2RaFtPvK0DJOmT6Z+fDl?=
 =?iso-8859-2?Q?sLBQnvlXhBPP5pB16L5l4t5XUhZlG9EJLrSnz1gLTzBxZm0YOzW4Cr/8Db?=
 =?iso-8859-2?Q?INYjz0gs/dz5PnDq274kOiAQDaONLs9LyNW2k3BZXXum+4/o2FSLO5Z8L/?=
 =?iso-8859-2?Q?8av9BYLGOuBwrVPnWKAAjFaGF8oT9qMWMuTNMEgqP2zQshklWSGq8GJa+A?=
 =?iso-8859-2?Q?YLoLBrR5XFJWL+FmN/Jy8mBgI1FMwtxQVrE/fWk65d/ccOKqLNGIoKH+dh?=
 =?iso-8859-2?Q?lgFhCxieW489Q=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afaece5-77f3-426d-89cf-08dd60834f5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 09:58:44.4459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnH3dWE51ZWyQuBeKVOlk7v6f9PmrjnjMGHtQXvVTM6Ig8Iz8RylkY7CbiERGTY2ZqucU+LhExtZ8x31rpKcvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

[AMD Official Use Only - AMD Internal Distribution Only]

Hello,

Thank you.

Regards,
Thippeswamy H

> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Tuesday, March 11, 2025 12:58 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH] PCI: xilinx-cpm: Fix incorrect version check in init=
_port
>
> Hello,
>
> > Fix an incorrect conditional check in xilinx_cpm_pcie_init_port().
> >
> > The previous condition mistakenly skipped initialization for all
> > versions except CPM5NC_HOST. This is now corrected to ensure that only
> > the CPM5NC_HOST is skipped while other versions proceed with
> > initialization.
>
> [...]
> >  {
> >     const struct xilinx_cpm_variant *variant =3D port->variant;
> >
> > -   if (variant->version !=3D CPM5NC_HOST)
> > +   if (variant->version =3D=3D CPM5NC_HOST)
> >             return;
> >
> >     if (cpm_pcie_link_up(port))
>
> Ouch!  Nice catch.
>
> I will pull and squash this against the existing code directly on the bra=
nch.
>
> Thank you!
>
>       Krzysztof

