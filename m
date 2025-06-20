Return-Path: <linux-pci+bounces-30221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0516AE115D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4C13BF052
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47599189912;
	Fri, 20 Jun 2025 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EIdpvdw2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4C1B87F2;
	Fri, 20 Jun 2025 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387958; cv=fail; b=Pl2nZMixqjPDiEOl4m1xd7MTvYQ5Gb7TAdBsjFHm3eDh5L0AqvUMhN3w5uTwBfauKLbVxJa3mfLqzZwhNTNEiiUGmLMSjYtS58EFpCvPv68AIGPhQAftipIIPwV9GD/ltdwybTY5Jr/NByJ4z7qOVUb1iCaom1CBGmIPUmDhhf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387958; c=relaxed/simple;
	bh=ZxXmrcC95CnsqdGCdg0TCyrOr4W6rfW7wCeJk0l55lA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jd8lSUjXpCFpzRRGUiYHq/puevp70JRz2/KkseT9DPL/CUQehi1EM7qqfiixs7CPyF+WFJq2fC4yIrXi6AfSbkLIdb3B1l/QShd8o1OwpyUxBCwddAJ1f3F9K2HWICoFCCw/TdM+kjfbEluEzZC14/X6yTVD5IsS28KNVa8CDtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EIdpvdw2; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIFQnHu5KczcUrLajAC+gYhXwQShu39ZAcXAJw9yRIT7r91UQpcHtJpbCE10uNAy4sY3Nxje8cGbH0lkVwWLJ5DB7Tm9V4QisriIEyZh17aCo1VESfIdN9Q28CWU/8p8IZK9p2rOuEwhEj1uCn1a2kDikGbfJ2MjpJgMPRCeyvH6YdNhhY0TQydNF/OFYrY7ZsNddO6ZzKJVkag+R7c/Sor5JSHTtTeRFrGzmXrRdvH1kyx9/+YO/WwP3CfCSVfpJpz3dsSdRNoriCqCdRfrrXyXDjrxvFb58EEYSh7Mx8qObfHCgy5xlAfOHlV/3mpjgXz8R2M8LoEfVGyXJdeYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybi6O2JQC+F+g7ztsTc98CtmzDIKgIxtU6T3Vkn0dWc=;
 b=RJlmbwmg+iG32r0ITNK+gLTS2VJHIwllG7jsTRBwWvYDuDKM8nb5wX9GvXM9sGnzEruJ/WhpAA6Jyzwneqo5fgEx5H5Xf20TbgSLwhd9SPGC1Wex9oKuLJRpBEgp0mcfGmeYLzZoO4SkppTh2hMOyuQ8n88wxAyi4hGqnHYE5kwmISX8QmdRleCQjyCSd0caVVzD8TFldBW049MjPyzEfjNs5nuW4YLsIEoYP/35TS9t/9kPtkT7SY30trfcm6EIYFMndc6mEwZkKpJnviLAmAJsASy2uE3ECvj37oAdta0drwZVpJhKGV7cZAH2CD6r6fltIQGqL/OnAqhPCQbtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybi6O2JQC+F+g7ztsTc98CtmzDIKgIxtU6T3Vkn0dWc=;
 b=EIdpvdw2ssYGE+8b5CxUClEJxdf/aj8JgolFqmKnyl1njNYwVEjUBW5fNQ5tcJkxxFqKE3oZoHOkmF87yMX5R7BwzHWZyD/1qAUzCT35uZwBXfPeZ4fVa+2XsoCyp9SVYb7ULNq0Uue3f/aj1LplxFiJ99n67+ARlwiTKgI9W2k=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 02:52:33 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%3]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 02:52:33 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, Manivannan Sadhasivam
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>, "Havalige, Thippeswamy"
	<thippeswamy.havalige@amd.com>
Subject: RE: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Thread-Topic: [RESEND PATCH v7 2/2] PCI: xilinx-cpm: Add support for PCIe RP
 PERST# signal
Thread-Index: AQHbrOylgtMytwVisU+l4ovrQWRiO7QAWL+AgAtiv8A=
Date: Fri, 20 Jun 2025 02:52:33 +0000
Message-ID:
 <DM4PR12MB6158AD426CB1E5A7A0101917CD7CA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250414032304.862779-3-sai.krishna.musham@amd.com>
 <20250612203347.GA926120@bhelgaas>
In-Reply-To: <20250612203347.GA926120@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-20T02:26:04.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|MN6PR12MB8589:EE_
x-ms-office365-filtering-correlation-id: bbe08382-f720-4ce4-acd5-08ddafa581a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zMWSRXkHqB/RO/rQ9dKY6gog+2FJvJk2rIYCUkIifjAlB3xuzdXzIilTg31X?=
 =?us-ascii?Q?we6EnW7IEIwhk3saybb19t2tXWO/BTMDo9nhvoAQqWA5P4L+3AkWMFL6ODNj?=
 =?us-ascii?Q?FD/oZHPcFxFIwrgO18zgojsoNMdSdMPDHVmKqKcHtQHHeIeAF6PnYAOVxVvV?=
 =?us-ascii?Q?96/rQWI7eCDiMx+gXS/5Qsy18e/iJjmjXA/NJbeMHgu/Mr2JKW9Ctgdl73VF?=
 =?us-ascii?Q?4+UKvcWeMpsMSeWQQ5m4rQvpAAdmp6qrOIp+yr4WJQBEAu/C0rIcY6R67v8Y?=
 =?us-ascii?Q?vXzOv34lqI8snsZyxL4vLG5z0JmBdBOhdYARqQzo5TTXzD8grl8QVz4GdwYq?=
 =?us-ascii?Q?kky9k2pu7nGq6NTl0fd5AYpp0/3PRGJGk7DKfezWnq8NCRcvn1abpbtJAZvs?=
 =?us-ascii?Q?lcDzlEBYs04GaOZlXJXXgub2nkeHNmhMkCJBPGNv5NCDoMyc24vLWPDdEk35?=
 =?us-ascii?Q?1MZWgE9MAIq4N6WNDY3+lkOgofGthymxKB3TJdx/HifYNH4m91vHHI5bu2C/?=
 =?us-ascii?Q?plW06xwfeO0ectelslfkgMi6MSAQzo2eJpVR6nqEGWCCmuPZ38zlEO158hSz?=
 =?us-ascii?Q?Hwn8MCFSUwhNmAq6iTiTfy7YbndElERAXQiUl/gGD1n7J+wskdU5qhhmDfIn?=
 =?us-ascii?Q?khyJTx9S7mEf+quNQzFB2NJf8QGYINAONm9AoTJOHKxqezy42O6QbLaJs+7i?=
 =?us-ascii?Q?qFsGH8Ifd5DTSrz2BT4iZWV9xvHFxq6hdQ4X6bjxHNE6e31by4XVQi1lTESf?=
 =?us-ascii?Q?iVHR5orDX0POR3q3YNEIwepYiD3WbEttw48BYYjfeboaJcj+YlCBhrDfr99t?=
 =?us-ascii?Q?K2AKRrdUP9VnBteK8n+UkVya0UOBwjPViXyKVpUZTLCFBUXsHlsCkvkFO/Fr?=
 =?us-ascii?Q?jBYfssSOJ8YqdezvqPG+tNcvaA7ZO05t9S4H2N+sru8SHk2St4rCfhUZqa4Y?=
 =?us-ascii?Q?Ie8+VevyKwy1OrR5BY/PIT6ZXxOaDVf0WU/lfKdbzASw7c1XFX+Rh+frtQyI?=
 =?us-ascii?Q?xxhDydTVJuaRf+y0thS/JKD00aG3X/xGPr3uyotIOOvku0ER8VPB1KInoGBr?=
 =?us-ascii?Q?NIme7g+Fk1HmAP7lWqM5x7sOEfgoMzBtc8IJ3wOx8EVtB1rv044XprYWjR+5?=
 =?us-ascii?Q?YmE9tlTOAv75tKjxQdui+uc52I9wgvhwLy0v6TCBg6avvWq8scDlLqqEm8+d?=
 =?us-ascii?Q?ypBIxMqc+lBuHsbDD992/IdTggaw7DNTjry9r8K4bgFTLFlV+qbB9XLA4mKt?=
 =?us-ascii?Q?ORb2DOHUw7h+LrHGqHOq8KogOIjcRUtV4p3992sRVgrsIK5qAWuOM50jfaa1?=
 =?us-ascii?Q?GGIKy3ZLJrSfUcrscStYfioQ5zkis3tTwwzuKJ39gMGwSTbT2mtKsd+LUmRx?=
 =?us-ascii?Q?U0UQIrGppE/FjG411JOMF52YYeTbP961KUds2U6FZMCoJcNdocj4epArq4AI?=
 =?us-ascii?Q?IRN48x+6oEe429hG2+TMeBtc9uEW9Y7MYop2GKCneQUkbJIOaNARC1XP0l19?=
 =?us-ascii?Q?maVkm8r9hAOurzA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/ScrmomqqzIt0z+igyUyBbI1RE4AbbVzkCTbH44avV+P/mEEjBBXfHnC14Nx?=
 =?us-ascii?Q?WZe1NYBMtD26TaiIXZRRSO9Zdu8EuoDNRwWwWiSuk/tgvcZFdlay7e/ZXCEK?=
 =?us-ascii?Q?bRt6lK0pmb7hYSjYmsExIrCYLnPTc6d9t7TfLB/l1xW4VDzRL3SRxZeAuRPa?=
 =?us-ascii?Q?VdddP3ahEcefOqaDtNJdHGWw7+3Nu2Dc9e92tEuBdL0N40n2FfpQLr6Zja0E?=
 =?us-ascii?Q?E0UiDkE4MZyDMYsG1emM/RY9KG+2FP7gXH275lwpgsTOdeEQkBddoY9kFgiD?=
 =?us-ascii?Q?KZv2TV59Oi/hQlWDjgqiyUqgNNMuhScFQ0EZrRl922Qs37WYrsrv7qnLNYFN?=
 =?us-ascii?Q?vP04XT7NT51/jD+9S1iUvbgiqOyzF9bxjcbETQwsAm4tWA/gPVFlU3ousD19?=
 =?us-ascii?Q?QEx3Vw28QwX+o4r6ii1fVhWRD85s50I1kIXS3IcXX4MoaH6ObcVbnq+MLpK0?=
 =?us-ascii?Q?+SslU/FqWd+E8kHHO/E9TSxMp5vHqdRbQlQmAgkHXLZLSqClR9Vb5BmL4Mhw?=
 =?us-ascii?Q?1M7zg03GKjvhugP9iifMVJvFyAn0OxZCvRZKaScbs6eDqGSDZChTG1vJZXLA?=
 =?us-ascii?Q?HnJnZwlHoScgGYzQ9ei4k2CFS5ZqvWEJv4EP1YtQ7uZGWDF223ExY5xtPXIP?=
 =?us-ascii?Q?dodJO+R4VEEIETZOX0oQtBB85wK3EN+icMYFAzV6JIE4sRKpDoOOL6d3S3w5?=
 =?us-ascii?Q?DrK/b5vKkqdohnILueS8MkigRybXjr0OzIa7vYMdcIvo/N7ARMMuUnxb97ya?=
 =?us-ascii?Q?HKu+7lwCJVaKq3u2BO/NPVvxJX6u6JxPbNiA8ms+VuiwhW6TCQnb6kNWkzST?=
 =?us-ascii?Q?OLvOtiom3w2iNfSS1J8B2fOeW5K+7h9WGzTvShds1JcHAAg2DJ0XxVgxT9vn?=
 =?us-ascii?Q?X2EVfmLkYAZlPi2unvzSwctmo4RJ7EzWxUexHpBBqejsDlcnhVkvUkRMXi3v?=
 =?us-ascii?Q?GLu4FBxudW/IuuijehqUB5qrL/6EbCmEcoptzwxCnHdTg96IOFrl3y4NGrek?=
 =?us-ascii?Q?L1WLkEyPT5Ubnqc1p5xQn7YICA3eTwYcw3/jFuoN3RUPOBWG55VTjGpOnooi?=
 =?us-ascii?Q?g/8k79+qpmPdOEm1AMhdp0+sl3put27liS1fGXorSUFDfkSxcnjTquCh6wjM?=
 =?us-ascii?Q?zvv20FHSPA/m+sVbiZyldJXB2d+CF3FdLzNNsLr6c2+I4uV8ZdG44vgSe4fo?=
 =?us-ascii?Q?iKhn5d3Hg0gw0Jd5QZORZRyf2tDyf0t6LKDf9nlrBx0Cn4r0SVeG2KX0jCZe?=
 =?us-ascii?Q?+/cKkgvzbU4QvZlMrIGIqurYSI9kioFpeHA78jYo03LJRif2UxZrX19BKsf8?=
 =?us-ascii?Q?p3lGipYVmU3NLFJHkhO3KDWD8Z9MXuZ4jza5tATXyhueSQ+mcndAE2gXem2n?=
 =?us-ascii?Q?t1KEsYRM/UtfM0oeRN7mVj7c90I+2KoWUojnbp4d9GFE8NwBXgKj04UmfvgK?=
 =?us-ascii?Q?PC2dFQ1Dj2g4039yin/nRmnalzwesy9frs7X3lyheIGFk/EFK9hU7DtB8QE3?=
 =?us-ascii?Q?Fz0iE3UlJRy6utHKMiLzGzZ5r1eFBqCVtU+vRYh9mITdGBjDB9xDiy1v8x14?=
 =?us-ascii?Q?YJeCAJR5rdV4T5TKDS8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe08382-f720-4ce4-acd5-08ddafa581a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 02:52:33.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBIDQt6peF3CqoYx6xrLx87QRQkgawMfwpPFsoanVhclhCd9x97buLvWrooZk/gqmHcYGRI7wcfSaX10htRr1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

Thanks for the review.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, June 13, 2025 2:04 AM
> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; cassel@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
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
> On Mon, Apr 14, 2025 at 08:53:04AM +0530, Sai Krishna Musham wrote:
> > Add support for handling the PCIe Root Port (RP) PERST# signal using
> > the GPIO framework, along with the PCIe IP reset. This reset is
> > managed by the driver and occurs after the Initial Power Up sequence
> > (PCIe CEM r6.0, 2.2.1) is handled in hardware before the driver's probe
> > function is called.
>
> Please say something specific here about what this does.  I *think* it
> asserts both the PCIe IP reset (which I assume resets the host
> controller) and PERST# (which resets any devices connected to the Root
> Port), but only for devices that implement the CPM Clock and Reset
> Control Registers AND describe the address of those registers via
> DT "cpm_crx" AND describe a GPIO connected to PERST# via DT "reset".
>

Yes, in Hardware logic both PCIe IP reset and PERST# are reset for CPM
devices. I will include this in commit message.

> > This reset mechanism is particularly useful in warm reset scenarios,
> > where the power rails remain stable and only PERST# signal is toggled
> > through the driver. Applying both the PCIe IP reset and the PERST#
> > improves the reliability of the reset process by ensuring that both
> > the Root Port controller and the Endpoint are reset synchronously
> > and avoid lane errors.
> >
> > Adapt the implementation to use the GPIO framework for reset signal
> > handling and make this reset handling optional, along with the
> > `cpm_crx` property, to maintain backward compatibility with existing
> > device tree binaries (DTBs).
>
> > Additionally, clear Firewall after the link reset for CPM5NC to allow
> > further PCIe transactions.
>
> > -static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> > +static int xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie *port)
> >  {
> >       const struct xilinx_cpm_variant *variant =3D port->variant;
> > +     struct device *dev =3D port->dev;
> > +     struct gpio_desc *reset_gpio;
> > +     bool do_reset =3D false;
> > +
> > +     if (port->crx_base && (variant->version < CPM5NC_HOST ||
> > +                            (variant->version =3D=3D CPM5NC_HOST &&
> > +                             port->cpm5nc_fw_base))) {
>
> Would be nicer if you could simply test for the feature, not the
> specific variants, e.g.,
>
>   if (port->crx_base && port->perst_gpio) {
>     writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rst);
>     udelay(100);
>     writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rst);
>     gpiod_set_value(port->perst_gpio, 0);
>     mdelay(PCIE_T_RRS_READY_MS);
>   }
>
>   if (port->firewall_base) {
>     /* Clear Firewall */
>   }
>

Thanks for the suggestion, I will change the test condition as per above.

> If you need to check the variants vs "cpm_crx", I think that should go
> in xilinx_cpm_pcie_parse_dt().
>

As per suggestion from Manivannan Sadasivam, I will be moving 'reset-gpios'
to PCIe bridge node, so test with variants will be removed. Thanks.
https://lore.kernel.org/all/ph5rby7y3jnu4fnbhiojesu6dsnre63vc4hmsjyasajrvur=
j6g@g6eo7lvjtuax/

> > +             /* Request the GPIO for PCIe reset signal and assert */
> > +             reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> GPIOD_OUT_HIGH);
> > +             if (IS_ERR(reset_gpio))
> > +                     return dev_err_probe(dev, PTR_ERR(reset_gpio),
> > +                                          "Failed to request reset GPI=
O\n");
> > +             if (reset_gpio)
> > +                     do_reset =3D true;
> > +     }
>
> Maybe the devm_gpiod_get_optional() could go in
> xilinx_cpm_pcie_parse_dt() along with other DT stuff, as is done in
> starfive_pcie_parse_dt()/starfive_pcie_host_init()?
>
> You'd have to save the port->reset_gpio pointer so we could use it
> here, but wouldn't have to return error from
> xilinx_cpm_pcie_init_port().
>

Thanks, I will move devm_gpiod_get_optional() to xilinx_cpm_pcie_parse_dt()=
,
save the port->reset_gpio and use it.

> > +
> > +     if (do_reset) {
> > +             /* Assert the PCIe IP reset */
> > +             writel_relaxed(0x1, port->crx_base + variant->cpm_pcie_rs=
t);
> > +
> > +             /*
> > +              * "PERST# active time", as per Table 2-10: Power Sequenc=
ing
> > +              * and Reset Signal Timings of the PCIe Electromechanical
> > +              * Specification, Revision 6.0, symbol "T_PERST".
> > +              */
> > +             udelay(100);
>
> Whatever we need here, this should be a #define from drivers/pci/pci.h
> instead of 100.
>

Thanks, as per your suggestion, I will add new macro and include a citation
to the relevant section of the PCIe spec.

> > +
> > +             /* Deassert the PCIe IP reset */
> > +             writel_relaxed(0x0, port->crx_base + variant->cpm_pcie_rs=
t);
> > +
> > +             /* Deassert the reset signal */
> > +             gpiod_set_value(reset_gpio, 0);
>
> I think reset_gpio controls PERST#.  If so, it would be nice to have
> "perst" in the name to make it less ambiguous.
>

Sure, I will rename variable to "perst_gpio".

> > +             mdelay(PCIE_T_RRS_READY_MS);
>
> We only wait PCIE_T_RRS_READY_MS for certain variants and only when
> the optional "cpm_crx" and "reset" properties are present.
>
> What about the other cases?  Unless there's something that guarantees
> a delay after the link comes up before we call pci_host_probe(), that
> sounds like a bug in the existing driver.  If it is a bug, you should
> fix it in its own separate patch.
>

The PCIe IP reset and PERST# signals are reset in the hardware logic.
In the driver, we are just toggling the PERST# and PCIe IP reset bits to as=
sert
and deassert these resets.

In our current setup, the PCIe link comes up successfully even without the
"cpm_crx" and "reset" Device Tree properties.

This is not a bug, the reset handling in driver will be useful during warm =
reboot
where hardware logic will be not be reprogrammed again.

> > +             if (variant->version =3D=3D CPM5NC_HOST &&
> > +                 port->cpm5nc_fw_base) {
>
> Unnecessary to test both variant->version and port->cpm5nc_fw_base
> here, since only CPM5NC_HOST sets cpm5nc_fw_base.
>
> The function of the "Firewall" should be explained in the commit log,
> and it seems like the sort of thing that's likely to appear in future
> variants, so "cpm5nc_" seems like it might be unnecessarily specific.
> Maybe consider naming these "firewall_base" and "firewall_reset" so
> the test and the writes wouldn't have to change for future variants.
>

We're currently discussing internally the possibility of handling the
CPM5NC firewall control in firmware. If that approach proves viable,
I may be able to drop Firewall from the driver-side handling altogether.

If firmware-based handling doesn't work out, I'll revise the implementation
accordingly, including renaming the fields to something more generic like
"firewall_base" and "firewall_reset", as you suggested, to better support
future variants.

> > +                     /* Clear Firewall */
> > +                     writel_relaxed(0x00, port->cpm5nc_fw_base +
> > +                                    variant->cpm5nc_fw_rst);
> > +                     writel_relaxed(0x01, port->cpm5nc_fw_base +
> > +                                    variant->cpm5nc_fw_rst);
> > +                     writel_relaxed(0x00, port->cpm5nc_fw_base +
> > +                                    variant->cpm5nc_fw_rst);
> > +             }
> > +     }
> >
> >       if (variant->version =3D=3D CPM5NC_HOST)
>
> You didn't change this test, but it would be better if you could test
> for a *feature* instead of a specific variant.  Then you can avoid
> changes when future chips have the same feature.
>

At present, CPM5NC doesn't have Error interrupts and will be added in the
coming patches, so this condition check will be removed soon. Thanks.

> > -             return;
> > +             return 0;
> >
> >       if (cpm_pcie_link_up(port))
> >               dev_info(port->dev, "PCIe Link is UP\n");
> > @@ -512,6 +574,8 @@ static void xilinx_cpm_pcie_init_port(struct
> xilinx_cpm_pcie *port)
> >       pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> >                  XILINX_CPM_PCIE_REG_RPSC_BEN,
> >                  XILINX_CPM_PCIE_REG_RPSC);
> > +
> > +     return 0;
> >  }

