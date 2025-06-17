Return-Path: <linux-pci+bounces-29941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E6ADD362
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 17:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEFA1165931
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 15:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660162ECE8F;
	Tue, 17 Jun 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J50HglKG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A043528E8;
	Tue, 17 Jun 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175388; cv=fail; b=DJcj0GDvF9OYO/mXi4y2nfg4aLCQzsdFm97ymuigVSHzCkI6iT59o98KXZ79uQLJu8DgE1PaWVks2IwzvtsFV28Rp21arCaEQPBVNaDNtKavgi1jqzxNqqGeD5/nhYQoxaWk9hLx6wKqqVfp0/LzPyhjmqpHeyi8NsrvsqKaomM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175388; c=relaxed/simple;
	bh=HA3Oiy703/vxDtTrMUq20YvYE6JtQfSiQ78abrhZbN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXza9i1/JyPpAkOUEEQam3wf3L+Tds7hcOnGHgLzxonQ7+9kcGU7JZlk8KQHDf6j+u9oOo8mgip6Cln3yrm5L8gc0n89J6BHtk7DkD/aOnWP6JuvHWNXOC2LpsaIGAKrMHPUjepkWhFIWgnGrd0+vzg2bkVYYcBJ1/3zYeSqbwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J50HglKG; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu4znCuKkKMRQ6/RlJ4s+ZuNg5Io/ID2EYlLrmiiiZGqWBmCWLvigkHr48cnl1Er8AtsRxKLGMK+DQSx2KHdus8lUV1NDhLT0QHEisJEQuVUEfYGqcOasJDGFj9aZ6sHrufo1y9W+gWKoI6lGeB1cXg4Kt1BrZRMWtwon5/5E4lNBygf3I7ywHfWGJN/jj/l7h9c2LvQ4rP4jMZbnS40wrqLhHcivCnGkr8WfvaOZQTqaTWtfZ753LHrcZZ/4dTz9NspGZUOTC078soxRcdvvan2PmZvFoINXE9To+iys+Tual+zE4AFJYA+6uCtvNhG1R8jj0qbgrfQnedZL7tQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0g9o/w8RFnGwfEva01l0q/HX4y0DPbIID9AfYYZnRjk=;
 b=OH4DzP+drwJ7MYrVxwcG8xW7xHmAEOgHgVO3spgbtU3anS80rlMhf7oH5iIclFWjsoe8oFYCHKrRbIjtpWuvgN3ljQwwTLyzQl4XLtN8VMTMAeZYQHaukPOkbXhxsYLX55gBsJCc118OD8oF2i/vu7RGtt06/mECZAaem2Ldjadtqo/GiNGpr7ro0p4HKAVPuicnLo6jaQXVf8DGwyLCMqE8BeTD3jUCFr6cSK49+S0qIivYAQxNoGKmnQ59GCDVu1kvywMN40Yb018T9guswiDJVLXS6hdT8YgdlEBLAnAc9vo2S/A1UG/RLpf1viYspzx24v2nloXeq47mFA5gDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0g9o/w8RFnGwfEva01l0q/HX4y0DPbIID9AfYYZnRjk=;
 b=J50HglKGaiPtJkFK2SQt0kZeL4OQAob4dxsEmWPAGobYSiq1DQSRRLDgW2jS1KHaZxzoz5RNSmuvh4YBRDEn7OPjzngm4mkj2wKb29JGYniiigRRFgS2WlKsMWkTrT+ImV9z7mQf4D08Sc1WBbs00HbiAG9sFEi1vnO+LAM6X+A=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 SA3PR12MB7923.namprd12.prod.outlook.com (2603:10b6:806:317::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Tue, 17 Jun 2025 15:49:41 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%3]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:49:41 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Manivannan Sadhasivam <mani@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cassel@kernel.org" <cassel@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Thread-Topic: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Thread-Index: AQHbrOylgtMytwVisU+l4ovrQWRiO7QAInCAgAb67JCAALYgAIAAED7w
Date: Tue, 17 Jun 2025 15:49:41 +0000
Message-ID:
 <DM4PR12MB6158A154D1186EFDBFD92BC1CD73A@DM4PR12MB6158.namprd12.prod.outlook.com>
References:
 <DM4PR12MB615826495B1A4F7DBADCEEF2CD73A@DM4PR12MB6158.namprd12.prod.outlook.com>
 <20250617144654.GA1135267@bhelgaas>
In-Reply-To: <20250617144654.GA1135267@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-17T15:45:01.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|SA3PR12MB7923:EE_
x-ms-office365-filtering-correlation-id: ff21e03a-c2e7-4819-15f3-08ddadb692f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xoxaCBQq9Qm13FN2SG76yowWgdqE5oN0IYbShy2OOH3tFCZlbKwBAyRFaRNg?=
 =?us-ascii?Q?zlZcpRb1HGyZcjIrPIoG/bjfeknyE9HZX0EysWDdVN6diRYAqluuh/LCa/4W?=
 =?us-ascii?Q?xIvySlm1MjPwztDdOFBvMVggPzjhIfZA3QOfYC8U9q38Bhv2/y53wqeqgMmr?=
 =?us-ascii?Q?faVjx3c8EnR3H1XenSASMPfRuJybCsQ6CkvDQaJpmN60EuTBqLur+5SmvoGu?=
 =?us-ascii?Q?+TGuKS4w20qp/i0+woc6W6f6oBLKqCaKvgHjCxVH6wKIPfTO95gbD8Q4nVmz?=
 =?us-ascii?Q?k0iaBaI2wKhIP4d29hq9q/2nP0Q4ShKMZnL+FOK7T6J2/OhGdhgVvKjtHAZa?=
 =?us-ascii?Q?hdaWbKG17Bq1K2cHibjYXV/ORd/2bYwWXAVTGBdxEBS1bJJZbKEWzrMPsCke?=
 =?us-ascii?Q?eyUJdCVNo6ttiBeM14sGwJO0hnGCP101doTZy79aAOiB/vJvr9My45HG2VHC?=
 =?us-ascii?Q?fHkMCV4gF+zALT36pUOeacZqLVIJNSpAqn+RXpHRfg0wWvbhd93srT00zHET?=
 =?us-ascii?Q?vovbnlpkhh3PtGU9XpC+OQwW8x3vbeni2TPZTzCysKwsSpnHHgPrP076LJ5g?=
 =?us-ascii?Q?MgNkRS4zWVJXjLExPsC1tQoGm5IcmrrejxltPtnw3CL91mjgS1+sWi2OIHel?=
 =?us-ascii?Q?NAQay4IJxHKFHMLuCLO8gw7A2fLd+T1jozw97tMdpyvWGPaELli7LYLbubqa?=
 =?us-ascii?Q?Gv41trBwJ0V42fa3x4D9Q5Ehp6Tvrk8iShfiuvFTMwoAadiOApBiNNq4Tz34?=
 =?us-ascii?Q?l2FTVFt8zIN+WRWRQxUQxxuhGPI3bi/OpcFIF8Zvjlm+ExpRxwaM5iwM7fNn?=
 =?us-ascii?Q?SxJ28PIBg6CDgkvp0n/Rz2K+9JF1PjJ7ueU6/HCn10+ZBVK8b1ClNy8Nj9gq?=
 =?us-ascii?Q?uyHN30PNuc1/9mFLYLqQzlFQ662PKprpqnK8VqD7JvF/FNqFpQlrpvTVZMmK?=
 =?us-ascii?Q?LFpZvcgEA3/LHoCi46OUXqJIZeaTfLk2XSQ8BEhIH6RZ3xDH39Cx+nQPzJ/K?=
 =?us-ascii?Q?poQd0CzdoK4iRqVAgjq4csLahlX9hNqsQtRl3+T1emRWMFHnkXoJhgK9fuiy?=
 =?us-ascii?Q?L+XRTYrKJwJ5qYVEXv3jTIV/W+nGBNf3G6PXb2XKw850uKfFjaycncjqs75r?=
 =?us-ascii?Q?+q+eNQTfFY5N/IyhBGLVUd5tN2UyplqetLKSAwINsi5FghyY0kBzXKxMvRVG?=
 =?us-ascii?Q?eIUV+kIOsae+VCYm//lsMTm7QQtUX1NUfuhnOcAxW8a7kSCZ89I4c4pomo1i?=
 =?us-ascii?Q?6U5Emwb7r7TwP1oE1eDohEQ6nh1M6sknDYAmVqT8gsBAioBudHfAStElRszv?=
 =?us-ascii?Q?J7HkYf/Lb6v8TfXsltngXShUfcubT8VV528UXn2rrXvwJvWskzD3vZFqFPCD?=
 =?us-ascii?Q?g1GxBzydm/SX8EWi5LQaIMrHO7HFGMrrGQlrdpD/yf14ETPMKmC47xTUaXON?=
 =?us-ascii?Q?EHFQtAR4Np1dCKt42F8xvwYlPFLQ3J6um7XmR5f1vckElM/AxuVt3g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UBWEGUfBy/g9BllKM9JMHfOxfVvO4WUXhapwjuieXyH/aVr02xnk6C2M6/oh?=
 =?us-ascii?Q?vFI671tX7nZfVn9Q94qQbMMyS0fRNX6XJRz8SI7ILhnFEKkkTJDdcnpw3vWR?=
 =?us-ascii?Q?2FVd6utHXeJPilB268Mi+8PAhI3eSvqTxRjFObHqsFufQgv68I4ETE1xuXbf?=
 =?us-ascii?Q?XOq8Rlzvnh6Bc/MQtgfZeY8K/YRdwCa/SXmYggZ/chgZp8NsLJgJfeCyh/NH?=
 =?us-ascii?Q?OjHfcSM3JkfTAwXCh0ct7R1ZXKFCkV9Yz3N4rWEZxfSSDQ70thN6Dl/72YaO?=
 =?us-ascii?Q?iegiqDtgpbvc8eGTPIO5nmagOyKR9tSOPrKzhm52kOo/34qGCjggWwbah7gw?=
 =?us-ascii?Q?7AQq/JqxbNZOUkaalHAnT11GDULTuQ+m+BrchmX8i1zPVklOStoT9pTh4Zcf?=
 =?us-ascii?Q?/WoXoWFwO/S6h0KTTcHQsdTX99luppl4BWD7CkInjZM2AbK6H64XKizdcPN8?=
 =?us-ascii?Q?GNq7NIO0hzu7liZlehMsp3+YN+Ed3xAHkvIQnRBa2K7rkW86RDz3IWiuqHav?=
 =?us-ascii?Q?URT6iyXVxgThgFKBZlC9CAf63fU0utuVzqgtGfTSuE+gDBo0KmluA9DkLgpQ?=
 =?us-ascii?Q?d0aQVP/4rIL/sXkbZZn6Sd3IUohLquL0G31yyDCkfe2P/Y3G+OVvRGh/s6ZO?=
 =?us-ascii?Q?uXfQyUdWHeA03MUZB9Y8GiE/4RM4hPdE6TFXZRVIsr5WzJXmuh5bJRrd6ELx?=
 =?us-ascii?Q?k3X35CxY5qApL4cigG7MOpGcufgeTu/Ie+2zDig3rit80Rhz5NwOIy9fv91f?=
 =?us-ascii?Q?wDNpKNbhohWpg6TIXXagKvazEJM1bFzqTJUeBzn1l3cB2afdpBW1/HnHNzWB?=
 =?us-ascii?Q?SGnQ1dge2Zvl4nxEgvj0NVSzOp+X2iHE6MOp2ogKZ/ER1uCOGJdBve9c3mMR?=
 =?us-ascii?Q?sLYmVgUvo5nJG2YqHZSSXWexMw3P4zOiQJ6DY3R+K/LAkfW0wKy/sIYZ7zXb?=
 =?us-ascii?Q?xfyWw/j8NsGlnj0ygqr5BTAfGgYbsv1i5YNY+WfHW2qMGyoeNmBrE9XkQoa+?=
 =?us-ascii?Q?C62DYeHqBs096BjBSnORbrZjmd7wrih2kzpEP1FwLrRPws8EhiLy4k9GKxgR?=
 =?us-ascii?Q?Da5evmVIy8DCOrO7bZM8wM4IQJRoFUX1ZREEdiId++WLkZJFxLY3he2XNGAQ?=
 =?us-ascii?Q?nP8TesddQEZWyEgwbxCdOYwnw9sFZ3LXy6bCSfQCHVtjaCf8OayUC7t2KKWK?=
 =?us-ascii?Q?yR+5t5HVLp3jGD2kzXNcQUvWmb56VOVfOxxYtRcYapNHQ2EdONsN0/hB1GeE?=
 =?us-ascii?Q?RdheabgZdVCRiLJGQo5wpdOBCsoE7bqdmzI0Nf4pV5R+qqneZSme5neUgtte?=
 =?us-ascii?Q?V87oyTOHoUyBsgbxeKHYg+G8CmuU7w1syQDWkJYgjcgH27c/Ncih6nnQ5RlS?=
 =?us-ascii?Q?gtASD/9C6P6Sbhon7roMNc5S9YxD8N2XVD4nYoaYWoi6YP5iL4EDTyHbroEB?=
 =?us-ascii?Q?YHOdImyu0ZBu3PYQJkzDAw6eKsH4IjpTawRmGT/pvzuNeRj4k8u68arSib2w?=
 =?us-ascii?Q?IZNVGHs3qQ/gAJLatMzVfiquvWtyTz03R56wtaoXsuVNtNR741t762+cwW8y?=
 =?us-ascii?Q?sDloD28cHDki4Ftsans=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff21e03a-c2e7-4819-15f3-08ddadb692f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:49:41.7091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcVSaB/6SYBkx+p7oc2bY7ZeltIs6QnMrAtGj9uMnqUkj15HOrg4CZZBQ84mgQCop768ZobMhyy9J/EYhcYDpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7923

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, June 17, 2025 8:17 PM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>; bhelgaas@google.com;
> lpieralisi@kernel.org; kw@linux.com; manivannan.sadhasivam@linaro.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; cassel@kernel.o=
rg;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Gogada, Bha=
rat
> Kumar <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: Re: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe =
RP
> PERST# signal
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Tue, Jun 17, 2025 at 04:14:37AM +0000, Musham, Sai Krishna wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Manivannan,
> >
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam <mani@kernel.org>
> > > Sent: Thursday, June 12, 2025 10:49 PM
> > > To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> > > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > > manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org=
;
> > > conor+dt@kernel.org; cassel@kernel.org; linux-pci@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Mich=
al
> > > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > > <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> > > <thippeswamy.havalige@amd.com>
> > > Subject: Re: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for P=
CIe RP
> > > PERST# signal
> > >
> > > Caution: This message originated from an External Source. Use proper =
caution
> > > when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Mon, Apr 14, 2025 at 08:53:04AM +0530, Sai Krishna Musham wrote:
> > > > Add support for handling the PCIe Root Port (RP) PERST# signal usin=
g
> > > > the GPIO framework, along with the PCIe IP reset. This reset is
> > > > managed by the driver and occurs after the Initial Power Up sequenc=
e
> > > > (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's p=
robe
> > > > function is called.
>
> > > > +     if (do_reset) {
> > > > +             /* Assert the PCIe IP reset */
> > > > +             writel_relaxed(0x1, port->crx_base + variant->cpm_pci=
e_rst);
> > > > +
> > > > +             /*
> > > > +              * "PERST# active time", as per Table 2-10: Power Seq=
uencing
> > > > +              * and Reset Signal Timings of the PCIe Electromechan=
ical
> > > > +              * Specification, Revision 6.0, symbol "T_PERST".
> > > > +              */
> > > > +             udelay(100);
> > >
> > > Are you sure that you need T_PERST here and not T_PVPERL? T_PERST
> > > is only valid while resuming from D3Cold i.e., after power up,
> > > while T_PVPERL is valid during the power up, which is usually the
> > > case when a controller driver probes. Is your driver relying on
> > > power being enabled by the bootloader and the driver just toggling
> > > PERST# to perform conventional reset of the endpoint?
> >
> > Thanks for pointing that out. Yes, the power-up sequence is handled
> > by the hardware, and the driver relies on power being enabled by it.
> > We're only toggling the PERST# signal in the driver to perform a
> > conventional reset of the endpoint. So, I'm confident that T_PERST
> > is the appropriate timing reference here, not T_PVPERL.
> >
> > Additionally, this delay was recommended by our hardware team, who
> > confirmed that the power-up sequence is managed in hardware logic,
> > and that T_PERST is the appropriate timing to apply in this context.
> >
> > I also checked pci.h but couldn't find a predefined macro for
> > T_PERST, so I used 100.  Please let me know if there's a preferred
> > macro I should be using instead.
>
> If we need a new macro, please add it.  Include a citation to the
> relevant section of the spec ("PCIe CEM r6.0, sec 2.11.2"; table
> numbers don't appear in the table of contents so they're hard to
> find), and include the units ("_US", I guess) in the macro name.
>
> Given a comment at the macro definition, you don't need to repeat it
> at all the uses.
>

Thanks for the review, sure I will add new macro and include a citation
to the relevant section of the PCIe spec.

> Bjorn

Thanks,
Sai Krishna

