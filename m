Return-Path: <linux-pci+bounces-25462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A2A7F175
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 01:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94333B8098
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6D322A7F0;
	Mon,  7 Apr 2025 23:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVJEgsAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090022A810;
	Mon,  7 Apr 2025 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069528; cv=fail; b=dwJOLsM9WXUtwBZjpDfnHro/6DCuK5C6iyBT/LXNPxgzXxf7lVC3JJTJqEQjiLOjY2Ed7BfKglrlVQp8Kw/cJfK0DZ/Wqrp1yYpLYliqm4tCMvScGy/H7sjq+QzipGm6xmUPEcnGW2JMzJD12yWN8iSh9ZYrm2q6mtXFcRUmo3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069528; c=relaxed/simple;
	bh=SbDjhcgBQm+Nlp5wiKV0qr6tSy7bkD39IuzLNwTRp50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cUJR9YOhZmXTjrMnxNLZT1PLyZUhW/bUzE8vYKYXKYYir+WS+y7ZU1qtPRkyjZjsIf0b3dOKXT4pZJUeQhJnencSAfcdtFDbtgabKJl8akQ1sTDg2TNHeZ9OxLr9NxTd+I0Nek136Szn3xxIpjvKF/P4SWPWN0QscoDgFBdF6+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVJEgsAB; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDrsQBJ9XKFoZvqYvKJanXkpmmY6CjjFLHlQjmXC3ILRsWg6U+IvOspDCA+xC/+3lzanFA4VTASZyzeyNlq9B9d0fHPxIte2s5sktL3ILI7y0ps9yt3VfCABv60s1FjP1kyWG2XFyacXZmG+UmF7lzouHnkWPVO/kQp6QFIQ8abe2AbelWNn1UPchdogrQGn1/bRDoHOw+tPT+Youh01rQaed2XhM5HUppCJ477XmVZp9C8Gdu8ag8WUrKz/+4tkIqjPAo5Jq3LoXoU9I4xqiDyW2nCk6ZGmTM787kza632Xu5v0U8t88oznyucQmw49ss5lyeW+FG0U8d8c/rdEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P2tMfz/dVf6rFG1KOWcZWSJx3Po/r/vLx1bNkwMypo=;
 b=iuxznExcn3nYHsukq28/PkFl3NjpNua6tjIUvCZb3qjhq0JUJhG87Y0fKfUSIMYxdQ0qLGFFgpb4pKyk67eWH8HA8QdjIwCMHuROEcIvbmFBk0rFAfs4iGPlm/LUyS/2uXxnUWX5tbQWnqq2hCPFE/vn+3tL4AemVDoY834OuV+5qrQgepUsg/e9u3vr4viLbqHGng1MlOWEqpMH8ASmWkDqXvyruSt5bPrmtoyUxs/+ckbdE715nqs36FfSbfnzEZmfjuzhHHTRtGljz0CFBVvMvgvj33G3m3xml98tIqxq0KmatS6MwZkzIC/MaA5FH1WI/SwElBEXpNNM2XfRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P2tMfz/dVf6rFG1KOWcZWSJx3Po/r/vLx1bNkwMypo=;
 b=UVJEgsAB55R015+FsFRsv4nvD+opz+Bu2D2TX+3ukdIgOZCovz8jWQ6RPZLQN8wexHXsKX+8562ow8LdP7xb5wQZ1/N/mCTU1Q2j3ADtdrDWuvNuWgVnqhFvP9w1S1G10xQpcOaeasHFj+H7LMZys2GG4bDDytwU7ExPYIxph2WttT2SsKFB+gLCsEErzZ7Eu3w/8ZSB3GcNB+tjNmmmf9TYX8XMYgywlBnJkx/GOHGdXQQmHPOnVTPQtHvBOggNUXrt9pwNjBX31nMOnevNbjp/qrT2A81uvhgTXmJ9PhjtfjvfHQuTji9AMvID54g9F0wPD8Qqx2Rq8Zbd51CaPg==
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 23:45:23 +0000
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85]) by SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85%3]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 23:45:23 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Alejandro Lucero <alucerop@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Zhi Wang <zhiw@nvidia.com>, Vishal Aslot
	<vaslot@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
Thread-Topic: [PATCH v2 2/2] cxl: add support for cxl reset
Thread-Index: AQHbhBqnPPoZtRLRPUGO800vOXoEWrNRk10AgADhloCARpuDoA==
Date: Mon, 7 Apr 2025 23:45:22 +0000
Message-ID:
 <SJ2PR12MB79630812834531324D148DB8C3AA2@SJ2PR12MB7963.namprd12.prod.outlook.com>
References: <Z7hZZNT5NHYncZ3c@wunner.de> <20250222001321.GA374090@bhelgaas>
In-Reply-To: <20250222001321.GA374090@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7963:EE_|SA1PR12MB8598:EE_
x-ms-office365-filtering-correlation-id: 605fd705-6971-4b10-e82b-08dd762e437b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LgtkcIil6+R9iNn6K9NIotVOTQ2F/r+BxMIWBQLbc3COZHyceM5g0S2GD4?=
 =?iso-8859-1?Q?s3GEqptFdM/35gwYik8XaEREy7vnXlHdoI4/bRZmG/5d3GM3C+Jhh6ewj8?=
 =?iso-8859-1?Q?fb2sOqQOoH/xLHLbHyQajJ7bJNXowZZxbal4bLAglkLVi7fL3U3CIgGiM0?=
 =?iso-8859-1?Q?hP3GxjQVbh/3MsOKEiew2HPRJo45oZeSUTTcZjmWxiGB8lYPdQV23omenX?=
 =?iso-8859-1?Q?E3o/Vz93QpCKLa1NwrJcH8WY0n4rzj24e9PbHp0AcyKnfU0gHW6zTqI/nh?=
 =?iso-8859-1?Q?bIQerbuOv8cx/Jb9nlW3CXgpNpXIE/YtVvMqG/dtN8B8x3AT8prggFGnJs?=
 =?iso-8859-1?Q?N9Z1T/iVApw81GUASl07Co6gzoPvFmuzh4KQU7LAf8XwSsSE7E5jACbJ2L?=
 =?iso-8859-1?Q?nHNVHHpDvI7dSawtDeeBPt6EXHq1QN/VKrXWkfjYLPTOXdlffTkXEpWd6R?=
 =?iso-8859-1?Q?5Y6oue/kmSTNlrmW77yEwIF87+z2gbX6cGpoGdNTOscI5x+52MmcI9W20I?=
 =?iso-8859-1?Q?P/fBhRTkbMh4ZOI41mHM1GGFIU3vR5MXKcR/YtpQhWDyudNAwjMEl3TWxr?=
 =?iso-8859-1?Q?xJi2yhQvOlPPePkq/66KpnZjZcfyK4Mq+V2s8NeP0zEV8fleAgsnMsc4sP?=
 =?iso-8859-1?Q?hoLyNOcd/HekYXxdjsN0++ZHxUS0dQJTtdRdCaLLeBmKsszVZTVrQgFKyb?=
 =?iso-8859-1?Q?WS/Y82hUatYLMaH2TlYihY7CiWrnnp76ZoeeyBfchYeTxIfFp8V3aa0+zh?=
 =?iso-8859-1?Q?UN0FPtTdPZuCHrycD2AXFK/mebKixZMAh5j0F552bTHXmyU8+SOlk8jJOo?=
 =?iso-8859-1?Q?qNR1ynAHUhecQqvreHmGG2/sB7AlqlIc4cpIy6g0D9PfA8MadIDSnpi5/O?=
 =?iso-8859-1?Q?wv8wRyss4v11qu3gjJuFydbefi1AdDNXJ6LEOoXJ+MW1BuynLVVpeFFMdS?=
 =?iso-8859-1?Q?BXL3Zywn1p6fFERKq8hUI/zUauJR90XSNAQBvxXZJ6cmVRtvpSaYmNtQ+J?=
 =?iso-8859-1?Q?rUsNv8J6U94vdYPdRiczVczo9hsAwCTjcyr6T4NBVC/hVy7j2mnHlJJdfX?=
 =?iso-8859-1?Q?43/7KmSbgUEPowu/Pz6PAEcT2s7S1zhIe1SPyyNzflP4ov1ZABqeAmEFYw?=
 =?iso-8859-1?Q?JfxXzLYSqIBFqLyUkOdJgs/bIpm8KhWOmB4PrOFB7jPxfOuS68VAN8HIRL?=
 =?iso-8859-1?Q?QoaKDW3JJWgYONkjfwv5QFarXn8IMhFpTN5tvBpwTD2KCCnupM3zkkDPOH?=
 =?iso-8859-1?Q?JZm6/SFIs8sy0yRqNM6lF4hmE4xaIItiiFQ7RSfpF+lFXp9a66iNcfn2xr?=
 =?iso-8859-1?Q?Bab3xxjE3zQL1D2nIBjViQ6xovhp1sTGv2HpFEsZOxQv4QftPKBuHiBnlt?=
 =?iso-8859-1?Q?ZO3avp5OQfJuiqWjJspYmSsKsSrP9TEQQdnS6aMMYJL+c7aqV2h2mS9JjR?=
 =?iso-8859-1?Q?Dj5Pir81ReOT2yHOkMsWVRW6xQ/dA6CROAxyxi5fgkr1yPcUcm965zymyx?=
 =?iso-8859-1?Q?aAxVqwXOwh6/FNVMgzQL5r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7963.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ALd+poTaqEDS+NUO6UcXNnqdv+1sMBWNRdVWyRfAFUtnU3pLqpV6uv1ZGI?=
 =?iso-8859-1?Q?DxhmGX3YYIBgGPjSIOkvOLCV2qr+X/tSiQcvp7XyidpxXBqJdFXDUe/UEe?=
 =?iso-8859-1?Q?08Gl1WzCrTtPThkxXL1BPCBbScK7anslkS6ELGpYOpUpfd7/J2jZHJX25r?=
 =?iso-8859-1?Q?0vOp6a5mXq8wLAApYuPRuOsH0RUAQb4mACAUVx+fWHE1/FW8RpSoXH+W9p?=
 =?iso-8859-1?Q?diAUL57RMRmvVdLcufxJzkJLx9CiZgCXL5iwuOelZNfEYJeZ8lXuvH93yu?=
 =?iso-8859-1?Q?/kdR9AN2fean1Sbo2lLZ3zITVEvcouEP54KE+IOnwmxqSmKVRN/z41j3z6?=
 =?iso-8859-1?Q?KgxpXThdjA+nOkEWBqpRaCNgNe63WiV9Rp1VCPIqSSVgT4o3rzUGziNtsM?=
 =?iso-8859-1?Q?vHyLeKo53AHA28BYmke2c5m7tptNptlQriBT+ByVdIx88UwxADOz+n16Mx?=
 =?iso-8859-1?Q?DtsnYrK5zkR1+qIIM/yoS43kCcaSrI+0InOZ3BnSuXlO6+ykgjSRYlM8ZG?=
 =?iso-8859-1?Q?UDFUOiPiuiwo/Lndu+LuTmToS9Toask3wACvVvLxYz5007lU5hTkd9ovK6?=
 =?iso-8859-1?Q?mml3XG8HQ85I/Wirj3OalQAMz1aKWa3dQFgxf+kswSzNnwM3ayec8HeXft?=
 =?iso-8859-1?Q?pZKe8uA66OTPl4c4LevT4mc1qioA/BKG0bkAh9oAasQQZMcFM4s+157iRb?=
 =?iso-8859-1?Q?YklyQFCT0aQYui7Vh5POV3Lk6HLdq+UhORPFpzDWZT/tj4V5rnid2y1P0h?=
 =?iso-8859-1?Q?XSeWnCLZhpH9YyARQUqy7NSJrA67NkMXL66rGxzkTQDuBR4B6fMBRzhq8A?=
 =?iso-8859-1?Q?0FuksEQ1pWnoU45kKqASqaGb4TEWtPvSAYo6wgY/QyBjz/H2uYGvYy7ZjX?=
 =?iso-8859-1?Q?KT5v9yWgk4Mf1r2iRJPqOnA64FoA56RSrqmRiHIN2Gq+XNkNtbCPL55iZK?=
 =?iso-8859-1?Q?JLFdBMwwg75fOGPLS6CkoobweoARCyGZBl0Qv6FNJYQjDVdILbnNXG0Ax+?=
 =?iso-8859-1?Q?VDK3RtbHi0s+oSgUokDUsHtuJKGZ1fCOhK223ipltldMTmEkvwGEHlIYlo?=
 =?iso-8859-1?Q?P3pBrKn8gtG0h7Tr0P/0fdvoEkNpHAdfGc+jl+rDE262C618c/D5Ain9az?=
 =?iso-8859-1?Q?LMHxwBD/+K9lRrCgVxEiUJHTAQ/q9zrkfRI/NtC7KzEg3B1HDUpYtotT+l?=
 =?iso-8859-1?Q?U9yoEoxW98AE9eQBAs1C0hC6j6dqDLWwmnKyhCGPsRtwGmk+1vAifiS09Y?=
 =?iso-8859-1?Q?tS9NHuozgjIT3q87GlzFLbSzMI0y9+iL9NSbBzGK5f3XtMuUQplxL+IDPe?=
 =?iso-8859-1?Q?CtjjbTgofKrfLEwMrJJYNmSYIGQEj+guZn80/tDEzn5VXq1pkAYJkbdMZX?=
 =?iso-8859-1?Q?0gO96O/MiRVkxzitzNCjKCpEhWLciRO/4+8lPQZ5q9fPUiIn6AXpUsMdn4?=
 =?iso-8859-1?Q?27GL2zCOohnh6S2ioOcbMsgHZRTNXlco1cJJEQl6tVHxAtrZ0XXhHTljAK?=
 =?iso-8859-1?Q?9KEEv7+r01h8ByBvM7CAZPEGLYtPWzOiiibTEEbinZ/UuSiZZgbli1hqvs?=
 =?iso-8859-1?Q?jY3PsmuvAEmc5hNvDDmjQHnaDSf6CDjl5OQ5IeqDEZGV280w1CiqOV4vYs?=
 =?iso-8859-1?Q?IH0iEpRXHtAqxS9HqYRskBnWv0si1zN36y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605fd705-6971-4b10-e82b-08dd762e437b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 23:45:22.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AU6QCSCPK1rKlzoKHZSds4fVrVeeN92WxUitJ8STpWJlC9QEPEBmCuKAo/yfV0+5GntD+W4FNk3/gu2ljSFbeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

Thank you so much for the comments Alejandro, Lukas and Bjorn.=0A=
My apologies for the late response. I was out of office for a few weeks.=0A=
I am picking up this patch again and adding my responses.=0A=
=0A=
> I think cxl_reset_start after the *_prepare call makes more sense here.=
=0A=
=0A=
@Alejandro, Just for clarity, =0A=
do you mean I should rename the cxl_reset_init -> cxl_reset_start?=0A=
=0A=
> I do not know how safe is this. IMO, this needs to be synchronized by=0A=
> the accel driver which could imply to tell user space first. In our case=
=0A=
> it would imply to stop rx queues in the netdev for CXL.cache, and tx=0A=
> queues for CXL.mem. Doing it unconditionally could make current CXL=0A=
> transactions to stall ... although it could be argued the reset event=0A=
> implies something is broken, but let's try to do it properly if there is=
=0A=
> a chance of the system not unreliable.=0A=
=0A=
Regarding this, we feel that the reset framework already=0A=
has a *reset_prepare and is called by the Linux kernel, before initiating t=
he steps=0A=
for acutal CXL reset. During this reset prepare is when the accel driver sh=
ould =0A=
quiesce its device. In this case, that would imply stopping the rx & tx and=
=0A=
draining the queues. Is there any particular reason this wouldn't work/be s=
ufficient?=0A=
=0A=
> One thing this does not cover, and I do not know if it should, is the=0A=
> fact that the device CXL regs will be reset, so the question is if the=0A=
> old values should be restored or the device/driver should go through the=
=0A=
> same initialization, if a hotplug device, or do it specifically if=0A=
> already present at boot time and the BIOS doing that first=0A=
> initialization. In one case the restoration needs to happen, in the=0A=
> other the old values/objects need to be removed. I think the second case=
=0A=
> is more problematic because this is likely involving CXL root complex=0A=
> configuration performed by the BIOS ... Not trivial at all IMO.=0A=
=0A=
Here again, we think that the accel driver is the one that should be doing =
this.=0A=
In our case, when the reset done call is made, the driver before making the=
 device=0A=
available to be reopened and used, needs to restore the config space/DVSEC =
etc. to=0A=
their prior state. During the reset_prepare stage these need to be saved. S=
ince this=0A=
is how SBR is handled currently even in the PCIe world, (for ex. AER/EEH ha=
ndling framework)=0A=
where driver is responsible for save and restore of the regs, and it is als=
o not possible=0A=
for the kernel to know exactly what to save and restore for each specific t=
ype 2 devices,=0A=
it seems logical to do the same here.=0A=
=0A=
> +1  The reset-related content in drivers/pci/pci.c has been growing=0A=
> recently.  Maybe we should consider moving it all to a reset.c file.=0A=
=0A=
This makes sense. I'll prepare a patch to move the reset code and=0A=
compile out CXL specific parts while making any changes for the next versio=
n.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Srirangan.=0A=
________________________________________=0A=
From: Bjorn Helgaas <helgaas@kernel.org>=0A=
Sent: Friday, February 21, 2025 4:13 PM=0A=
To: Lukas Wunner=0A=
Cc: Srirangan Madhavan; Davidlohr Bueso; Jonathan Cameron; Dave Jiang; Alis=
on Schofield; Vishal Verma; Ira Weiny; Dan Williams; Zhi Wang; Vishal Aslot=
; Shanker Donthineni; linux-cxl@vger.kernel.org; Bjorn Helgaas; linux-pci@v=
ger.kernel.org=0A=
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
On Fri, Feb 21, 2025 at 11:45:56AM +0100, Lukas Wunner wrote:=0A=
> On Thu, Feb 20, 2025 at 08:39:06PM -0800, Srirangan Madhavan wrote:=0A=
> > Type 2 devices are being introduced and will require finer-grained=0A=
> > reset mechanisms beyond bus-wide reset methods.=0A=
> >=0A=
> > Add support for CXL reset per CXL v3.2 Section 9.6/9.7=0A=
> >=0A=
> > Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
> > ---=0A=
> >  drivers/pci/pci.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>=0A=
> drivers/pci/pci.c is basically a catch-all for anything that doesn't fit=
=0A=
> in one of the other .c files in drivers/pci.  I'm slightly worried that=
=0A=
> this (otherwise legitimate) patch increases the clutter in pci.c further,=
=0A=
> rendering it unmaintainable in the long term.=0A=
=0A=
+1  The reset-related content in drivers/pci/pci.c has been growing=0A=
recently.  Maybe we should consider moving it all to a reset.c file.=0A=
=0A=
> At the very least, I'm wondering if this can be #ifdef'ed to=0A=
> CONFIG_CXL_PCI?=0A=
>=0A=
> One idea would be to move this newly added reset method, as well as the=
=0A=
> existing cxl_reset_bus_function(), to a new drivers/pci/cxl.c file.=0A=
>=0A=
> I guess moving it to drivers/cxl/ isn't an option because cxl can be=0A=
> modular.=0A=
>=0A=
> Another idea would be to move all the reset handling (which makes up=0A=
> a significant portion of pci.c) to a separate drivers/pci/reset.c.=0A=
> This might be beyond the scope of your patch, but in the interim,=0A=
> maybe at least an #ifdef can be added because the PCI core is also=0A=
> used e.g. on memory-constrained wifi routers which don't care about=0A=
> CXL at all.=0A=
=0A=
Agree, we'll need some way to make this optional.=0A=
=0A=
Bjorn=0A=

