Return-Path: <linux-pci+bounces-22333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550BA43E36
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1FC3A5D2B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2E267F79;
	Tue, 25 Feb 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l+m3t37A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8C267F63;
	Tue, 25 Feb 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483973; cv=fail; b=pYUxzqNBKPzkYry/U0L4ybMIjn5SS0VJIm59zmdUUOfE4QYZCn7xubSswVSwNQ8HGOOJTWrHONdt3pml7Ja1eSHlB2Pv/UQAQPimPsjrwKzLkDwKaTzHOK/MbxdjA0zsiGnNvodSgjq6zf3gHkuExJwOrFIRv1fHhF+fw5snQys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483973; c=relaxed/simple;
	bh=K3ZBpbxoQTTJpaFIKzekoRMBKG2GfSLm+b+Nd2duVa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ilCSzEdwDuKeSPhhfnyYF+xkOrMThzk7czsbzxS2oX301xmtvXoJcEKPTTEnahKNtvBHG9i45yquX/7s465M6jg66OkjXTI9RnEeGLzBUmuue/GrbNPvpD0DCmIjvt9DYh9KBVqUQjGvG7n92NT0/Wg3hD0vZMo/6Db0XGGGrOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l+m3t37A; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9vzg1+Yyk/+YKb893lUkrJQn7WgOKGLhSIUq4m0yAy7qwj2DYPbonAKCZNoovByRgI+bKL6kZAj16Y5hMRUrvxBzwVOFVsX9wVP8GL0sj5ZixKFK+30NDOBI/bfcTEKxhog0UJIg+yHcdDJfcrf0sEywJUbleHPdyZREu8PinFpnMQgSvcezRqbVAJfjMZU3cHmHd4tJp625tGgQzOiIqrM28ycm2iZrlHCvZ73qp1BRSEO45gEJYBUGxa5pfuGygQigLHGoPqJIHP+BvnHyMzHUawRoCmJzyboobA9WmmreAp52zyzEvlv6Biin6O1roKiSYmV6ws7rgiwx+7iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFYZc4ghPUNm6HMeL2VxeH1G8zzbiz51kLD4fwzKHTw=;
 b=BeA7+g9+m/aUAwJiqlrTw0dYtOkemqzrutufCO3rcf+st70W9NpdQ4dgNQ0AMn9HfcKMYq69KOiRgKCsbS844BTVAzXKl92kleYA2h068qcWVKNM69e7tuGHnS/xqoQEIbMQ5z5BNL3450JY60IzXPETEN4K0+re4QtmDV0/HQGDQAj0IcsFU3BvOiu3SVjTaQVCZf70N9bl3S0OSuP9W4vvc932SqenOxRHAEJ2/4S2+EGxMdTxeD6owRsTsnNCEB2ilCOjHWdg5+KMIvBT0TlGTu7I55Ncexlm2e5YI20FW24eMOcGFVy3AoVFehjTjXqC4OI+gZqlXnlZbDGABg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFYZc4ghPUNm6HMeL2VxeH1G8zzbiz51kLD4fwzKHTw=;
 b=l+m3t37AD5Lq+2+30vJ6NOudAqwl/tIeYLnglS1/o/WsJS7WSmRJHQS3fA8HWRM/TV8bDV7vKhh5KNh8g9hmYxUkpD7sCU1Is791LliEEZHP4xR+VkVjWVlGpUNlt8EA4WUWXmHwxvkx+wqhD0PSM8Hfa96djUtgE537zykBWnc=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 11:46:08 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8466.015; Tue, 25 Feb 2025
 11:46:08 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>
Subject: RE: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbho4qtT5H5a0jEEuMfrxVGOqvCbNW4RqAgAEHRcA=
Date: Tue, 25 Feb 2025 11:46:08 +0000
Message-ID:
 <SN7PR12MB720126E2552B91A78CC9D9FA8BC32@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250224073117.767210-4-thippeswamy.havalige@amd.com>
 <20250224200301.GA465730@bhelgaas>
In-Reply-To: <20250224200301.GA465730@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e4184dc3-b219-48fd-9531-e45bb36fdab8;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T11:45:17Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS7PR12MB6093:EE_
x-ms-office365-filtering-correlation-id: bcdb0fc5-7312-431f-a2ef-08dd5591feb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4+e41AmKdbtCu45tJqnkDDQJgp8osWYr/xwd4EhAHZLWhxgG42195MHJCHLm?=
 =?us-ascii?Q?feoyeaIfS4Yskr2+Xq0oZoCAXVBnQC8vMcunPVdrIsdAey1hF8vt/Fod4XHi?=
 =?us-ascii?Q?M1OdP2BwkjFWmf/S6qPF9siY4ckH3bxhOpSHXJwGmGC4bhInH29PA/s3pkAF?=
 =?us-ascii?Q?2rrnCnMbBD80L0Ucyj0u7nfP3MZwBsBt+sKfcRSjuoCPseo7FtKLF0BvEAMH?=
 =?us-ascii?Q?RbPGTS5nDFCLa70QbPt/MqHgwkNiuLuDsLlBQ54N0Q/r08BefcFzkkdxjFCo?=
 =?us-ascii?Q?mBx/BD92Hnb28tDwWIZ2F5GlD5HCzofPpEenkB314nkXqzB5cWhW+Y/6cPGy?=
 =?us-ascii?Q?X5fLGaim8Z2wasHLf+U0eDQQP4OQPf87g29ZLcnlhVYmnqITdOo63py3mBFg?=
 =?us-ascii?Q?JtGcgZl4oNdt/3q0cKF0yN8C1NxKwzAKsdxiY0xhptfFuqfrm8C85mBqTHSh?=
 =?us-ascii?Q?n73UliaJw5cv6TlsJXEdyuMw+6UeRmevMnIM9aQ8KzchQ8Duqc+tyJU9UMo+?=
 =?us-ascii?Q?PbRt1dKrFXSxaUymVgpFzSSg+hnvzA6OX4XOSCZZjPLoh8s76SBGWweWRPZA?=
 =?us-ascii?Q?K8yXZf8XY4iAa2PC9BXX4PPLaIZecNwxxGVqnrsjBT4kREsbi168DTXnYMKw?=
 =?us-ascii?Q?sxDcZJXg4lxyeOb3B4wgxCetpjQHshdXKe61KTal7ewSk0aFKfw5M7eVZHHJ?=
 =?us-ascii?Q?78oKk+YugCC//HmfyIdkH/vrRSz11NRQBedqLH8eCuFDYhaFchLOUE3pSvO3?=
 =?us-ascii?Q?Rn+w9n4fhgNS+ZOO+HZ0jk88Zzw+FUxAzzFSg2LIdJ109Wf28J/sAjZd6OPs?=
 =?us-ascii?Q?G24GS4EUzR4mdSofhIKyCBr7DsWdCSXZ5pBu2UOOXOWFZKLcUaLBbwVAQ09n?=
 =?us-ascii?Q?82dOuvLIB7PTcXtL7pibNs3rhOLVUy/4+rwVMKEMhNb/bAimwr5lUzBUT9TK?=
 =?us-ascii?Q?N9sEJURXA7/X6syQ5GyLo41GGBFSzIXj0RlyB5w9mHrctq86X/Wo5gna38E/?=
 =?us-ascii?Q?wp1RxNv1FJLMLXgul8e9mYe/of13Ocq2H5jSY8bQ0fJi7//JhpcnJ0ds+sqT?=
 =?us-ascii?Q?NC1syHXSYjk7PjYvzCVjh6swjMeuhq4lPl3mvWSv4TwQ8FSKN8qgQ8JcURGj?=
 =?us-ascii?Q?LlSrTDjphhKv5gOscuBjuIeW4f9KkqwQlRok80X+zfz89+A3tsdSkY+s4Zvi?=
 =?us-ascii?Q?F3wfGODNU/MlMRFk42gaCIHs4KvEqjq3YlbK1UN402Oxr4PX7sgqtF6jiBHy?=
 =?us-ascii?Q?L7xy7+9vGUiUBeGu0rwJYjalb/qVEE1FPkOOEAeX+comfHAn6a2GNz3z3FCt?=
 =?us-ascii?Q?JIGq47feTIyQ28Kt+YaszNIhdb0UHQ8gqTTNiyWFssoxQ+xK2DW5HMLQvRMW?=
 =?us-ascii?Q?hl/5YIgkh4daLkbqyjRHdH5oIYBKapn/BUyu0a/nN6N9iDHWSrOfXxXMalO2?=
 =?us-ascii?Q?nEdpxLJzTx6OemzCP2ks+TmBhtWp1SXJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P1/j67yO0+krBkPMp5pcEygiSoCQ26x3y5a06U7E/mVq+y0Fl4+/8dcSPrVw?=
 =?us-ascii?Q?ybZBHSjiGvjbnigw3BKc6mu8gqjynhn/6/3bUBVrvtdQq9OTsBVre+vfm9mq?=
 =?us-ascii?Q?iX9Lrhpbv96SjuRyc5h117S7urifI5AF4Zh+9v5Gh/9EqSHLrGxmhOBQNb0X?=
 =?us-ascii?Q?zlkh5zEA5Jf8axC654LJyPTQtzFhk+fZOEQVuW0/mIGL+8PKgp7BxO/HGiVg?=
 =?us-ascii?Q?DP/cbwMWbkTf4iz2frfUcleiphaTwTPrOIYahx4DMI23/VGzyV5J56P33LYG?=
 =?us-ascii?Q?YPNM1vhdwOHcAdqNE5Iy/B0XndnrqXK0Tt5sQw3x3BmvMNuKvwybSg4Tqlm0?=
 =?us-ascii?Q?/cUVQ1Ld+yEMAabi82zWYGjgrmMz7htLNykz7kMKRanyUmJzFXx0k5Pjpaa0?=
 =?us-ascii?Q?VhhR4xnCzA/YS2LIQuhUO8VIEx7pZQ/Lht90HCF6RSjKqFjW62pbQIKlMLrY?=
 =?us-ascii?Q?0UotKh97ueFsDb6iyMo+j6kUhSK/WPjbuI4018UjxcYDq7nzZHHeMm/CEvNG?=
 =?us-ascii?Q?YW/B+IRn8WEMtagB75Zbb6fKARCabU3wWUeSj9s/gRXlOy1lURMPUnlABrAo?=
 =?us-ascii?Q?DI4Iqc1DOOhUMVDtIz1kff3sWSTy5L/H4NMmzJgcLNpNV95LrHY1i9kQ6sSD?=
 =?us-ascii?Q?9TQwer/xsrO4lmOhriuww2MMbEmuw2TGfT91b5iZY2JmsLmh8xCugvzBoeC9?=
 =?us-ascii?Q?k0W+uQKee5buCPDaLUQtwQqR+ubywPBRbyV3AF2QU4FIia9nXX26UUTBah2p?=
 =?us-ascii?Q?Boy3Goq13f7LR/enhezzy4uq5mcgrEdd/a2uIShBcqEH/3ZQ8/eQH103CFrD?=
 =?us-ascii?Q?x+EaeQ+lfQKAnjSN+DPzQequmyd5x7WW2PoUshqSfdJXy8u7X1KkVei2+oh4?=
 =?us-ascii?Q?1lCXVHQ25LHFa0qEXUBxORUfY4Vzs4pcHxY2B8sSL8GavVyOhGB9wcfMjEbo?=
 =?us-ascii?Q?ImSndAnLDdKJR5DhLKac/gI+8qW8NValVIFZXRxWPMYAX/OSSPKe9J65RcNq?=
 =?us-ascii?Q?POnh0UDIUgrW1wIWtcjxI/TGi4nQM5cbfqJScXeH+BttdoqJZdP2PZABDz18?=
 =?us-ascii?Q?IEkVH8nUvWScJyj1Z2tlCXXg80cgYC+hakVgFDNA6mdCvBLoDMlefKy66En6?=
 =?us-ascii?Q?Xk3ULoHQ3birMKI9uKmbk/VWlGmqKeb2siJIHVm9zI+YhucV9+kBjqqnZxOg?=
 =?us-ascii?Q?lsOu0HKur10ZiWNJrydX0mpHGvEh32h8um7THLx1QXWCuDwAqF1r520ZrCTi?=
 =?us-ascii?Q?oQ+A6RFJH9Ig0M9vQ1kAuKDjogbqyrUYgVB0ClE+1TJxkhjQGdyAODBDtz32?=
 =?us-ascii?Q?lA125T3Q7GQp9ko3e3gUorWN1q3nrJ2Q8cSmjHn8hs8rGKW2Ue/FXOPWIxJp?=
 =?us-ascii?Q?g0qVyvFw2mGeWAyNa92RZTYHlsj1REFjMT0o58miYzIItq31WXX8aHaggmY2?=
 =?us-ascii?Q?xOvJtMQ2dj/tU5Axawm+6S8vjjtu1qARNSrY5Zf0cgqRTTGNv1kQh7jgTvCr?=
 =?us-ascii?Q?EbnwLy/LaUZdF86oylgKyI/B/CgtUDdSPNs6BkGy3kryEZ5uctvx+HviAiOJ?=
 =?us-ascii?Q?s6jfB6vbY7qzzDU+2Og=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdb0fc5-7312-431f-a2ef-08dd5591feb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 11:46:08.7841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yuFIIuldz8qRrPgpD7PdAzgWspl/k7Z5vOJCBJaS+co58ErAm4H1lIDLwppADxgKCIwX25sdH2sB/zhG4HUcJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

Thanks for reviewing, will update all comments in next patch.

Regards,
Thippeswamy H
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, February 25, 2025 1:33 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> manivannan.sadhasivam@linaro.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; linux-pci@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>;
> Gogada, Bharat Kumar <bharat.kumar.gogada@amd.com>;
> jingoohan1@gmail.com
> Subject: Re: [PATCH v14 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
>
> On Mon, Feb 24, 2025 at 01:01:17PM +0530, Thippeswamy Havalige wrote:
> > Add support for AMD MDB (Multimedia DMA Bridge) IP core as Root Port.
> >
> > The Versal2 devices include MDB Module. The integrated block for MDB
> > along with the integrated bridge can function as PCIe Root Port
> > controller at
> > Gen5 32-Gb/s operation per lane.
> >
> > Bridge supports error and legacy interrupts and are handled using
> > platform specific interrupt line in Versal2.
>
> s/legacy/INTx/ (I assume that's what you mean here)
>
> > +config PCIE_AMD_MDB
> > +   bool "AMD MDB Versal2 PCIe Host controller"
> > +   depends on OF || COMPILE_TEST
> > +   depends on PCI && PCI_MSI
> > +   select PCIE_DW_HOST
> > +   help
> > +     Say Y here if you want to enable PCIe controller support on AMD
> > +     Versal2 SoCs. The AMD MDB Versal2 PCIe controller is based on
> > +     DesignWare IP and therefore the driver re-uses the Designware cor=
e
> > +     functions to implement the driver.
>
> s/Designware/DesignWare/
>
> > +static void amd_mdb_intx_irq_unmask(struct irq_data *data) {
> > +   struct amd_mdb_pcie *pcie =3D irq_data_get_irq_chip_data(data);
> > +   struct dw_pcie *pci =3D &pcie->pci;
> > +   struct dw_pcie_rp *port =3D &pci->pp;
> > +   unsigned long flags;
> > +   u32 val;
> > +
> > +   raw_spin_lock_irqsave(&port->lock, flags);
> > +   val =3D FIELD_PREP(AMD_MDB_TLP_PCIE_INTX_MASK,
> > +                    AMD_MDB_PCIE_INTR_INTX_ASSERT(data->hwirq));
> > +
> > +   /*
> > +    * Writing '1' to a bit in AMD_MDB_TLP_IR_ENABLE_MISC enables that
> interrupt.
> > +    * Writing '0' has no effect.
>
> Wrap to fit in 80 columns like the rest of the file.
>
> > +    */
> > +   pcie_write(pcie, val, AMD_MDB_TLP_IR_ENABLE_MISC);
> > +   raw_spin_unlock_irqrestore(&port->lock, flags); }

