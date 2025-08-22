Return-Path: <linux-pci+bounces-34549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F446B314E5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA77AC12F1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E446629BD82;
	Fri, 22 Aug 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3XEZYApX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946322DF9E;
	Fri, 22 Aug 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857482; cv=fail; b=B9gpEZB7MC3j304ExwoD9BKFJPwIbumVFGKA9JB1g5Yr91KF0BVzledqrTvCIdLUecK8kTbXiBRjWizR5FMK8AX7CP/VEe3/h3OjfeMevfei+TgAYGzArhZup3t2eZbdzAh9wwfjnGGd2/ol9iY85OAuI4feMBRthiMry7F7N78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857482; c=relaxed/simple;
	bh=GWihUWcNu+mnpgxlbhhuBih22fqGtcxu4Wf5d0fAzJM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OXk3GP7S4IW31ofVCjHRjh1PjvJkIus9c29zojrrnYIVQO+39iQNfDiyjdrALEOJUxxtJCyt+93zjC+Ofv1HYbZ4R5o0TqUgF5s2eISLOI4sR2CBa3ne0xE7XImbXzBHvPmw+fOWdiTOkphIOOvevao7iK9bhE3Ao2GtcBoFeyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3XEZYApX; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxJEU4u0joJTzPgDd8RsWsf66aEVmnr7BXJyRC8ASSGXGt4ixtEB+RoDbnOYh0Yf6zKY1wbULr1ExMVRQO86RtTyma3dkEy/E6JwlvMAHbDnOSj63BLFxDvcAMAclFi8ONOFCV+q7PhM/IwAZtzn88Q7Nb37FB0d6pRg/qd+UZRxUcu9Z0LnwHkMpfDiXdS6iCiHWfFC+1bh0JuY0GGo/Ybr0LryqsMReEnbXNDJUx0dJgFatLQ+FU+r2vwHCX/uwrRgOvDw7Cffsz4wKY3guMmnx1iZ9+NUQpV8j3tNiWMSG8AjqxLrjHURTUpqXcTtOlxV1haIsnQy1j8VD6Pc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKYJO/SNAhz/YsAwtcW4p8a4J2g1pzoM4Zs7/Lvhxac=;
 b=OP7FY3spd85SjK6/BkQP1kXnow+tL4dArCQFlQDwT1MFeg9pHjdA0JepvCvD5OP4o00Wec4FIvO8ToHxP23ME8rE6+S7LYqonuVoKlVRw8LKznGj8W/He+iBZrIMPW8dkiGNF6685S3uzMtqVG5fkx5IA2xR+wpBkaKpy3HcJBnjXOL37o+kOcyNdzMKUK303iYHgjvnQzkba4tva8M9O03dqAGyEo75rWFSIMqYQyZD/vdkIlJv2941yKXnTvfLlo+NXo5M6ociCzVPp0ML9Nimhkry363cehWHKOB0dalMnESIm6DC0hjNCC3KT9sUjgFJkVViolOEEAoerlD+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKYJO/SNAhz/YsAwtcW4p8a4J2g1pzoM4Zs7/Lvhxac=;
 b=3XEZYApXKPBS3rcPGPfLkCtzIPIESRjto5ASaJdh6cvC2qLM0SXAenI0mkXv/zg/3qvp88HRu/quOyDFK3UXRySwCkZPSUuupSaWsmbMV2mW0Dq4sm/H45fwHKQx46U78n8VMWQfpHoWCtdRSvjQNHVl7JWO7krIq31z59+h8s8=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.17; Fri, 22 Aug 2025 10:11:16 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%6]) with mapi id 15.20.9052.017; Fri, 22 Aug 2025
 10:11:16 +0000
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
Thread-Index: AQHcB26ZvUF4V0XCuUS3aC3lVOW8NLRfc0GAgA8VSHA=
Date: Fri, 22 Aug 2025 10:11:16 +0000
Message-ID:
 <DM4PR12MB6158961BAA5D9A3F56102901CD3DA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20250807074019.811672-3-sai.krishna.musham@amd.com>
 <20250812194113.GA199940@bhelgaas>
In-Reply-To: <20250812194113.GA199940@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-22T10:01:16.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|DS0PR12MB8525:EE_
x-ms-office365-filtering-correlation-id: eaedaa3e-b1e9-4168-4233-08dde1643b80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?em/BQF5MjQ6nvi50PJHqDiQrW+9q/oc/D+3IGnWON01EA4Wuy3pkLliuh8lG?=
 =?us-ascii?Q?rGTZSoDlH9q4anATuMYnB77E0SPzC3SZn+sOLI1WhRcagKZrlc3i485fUK2t?=
 =?us-ascii?Q?moU0LOJ698tSwt7klLls/wP6VaNAdbZDoQCQxrBF+YJRMdRwq4c639K96djX?=
 =?us-ascii?Q?Nwqj8SyDE0H+aH8K1UGWBPXeEwxRDjuLtQH/VNKwvnxJRy5jvt6jd1oNJ6Mw?=
 =?us-ascii?Q?26epJDIT0bJ5N48EwSVhN/gwsSo+Z5iv6DOaO/3Z/JiYc1rtcquZ/T54quU+?=
 =?us-ascii?Q?pgWGPV1NO5SciCyFE6nfuz6ZbUKgCHTmWdLZc86qNx3rhOdzJ9QpOLXQs+ZI?=
 =?us-ascii?Q?LHUn3SosdBdN/QidlEGLizgsL1NVB3CUlmj9I5v2fKzpPQaBife4+llCol3L?=
 =?us-ascii?Q?H1aSs/hDS+Ha5olGqsDpprIFGyzlbUpf+BoLsTXOHpraI5mvTYAmhDmGZtIe?=
 =?us-ascii?Q?A6pixVALKXqTS38WIaI+r9l4CeYQ8AYGP8tuFKVakuftleDp3oy4ccaTMa6v?=
 =?us-ascii?Q?ej6YawdhPX6/59JaCZkkjGgJ9rvWExTXONLl5LOSKwnV0R+2cMyX9Z51qvLu?=
 =?us-ascii?Q?x62+DC+AJeXIWxs4mLrvEStCq9DWrGGqK+r42EsMVsT4esHA/PIrxxq2VdEw?=
 =?us-ascii?Q?MlHaul00+DfynpwaHsQY+spg6eCSyUxE5TnvzBy/YhA0bL+pzX1ljaNTNNYl?=
 =?us-ascii?Q?Oz//SeefzzcDw0jeSCihBlFcQUTUgNODND0KQx+to/raNLszdEnBAzrsmn2I?=
 =?us-ascii?Q?kqDRRXYm6EmoAbQkp+BtsHRqeuoIe5DumXJX6Wec5GB1tQdMpOcT/9dKp197?=
 =?us-ascii?Q?t9SkmCwr/+KzDJLSh1Z4GsrTRVoOon7CWszINWXdGFOLHvd4M9snZUP/GNAT?=
 =?us-ascii?Q?UylLiSTxsXolnv4Whsc3nob1vbRVsDEcJ7GiUf+RqQf+JNlGg9vN95o4BE9I?=
 =?us-ascii?Q?J7B1hip/TFeDgGbDylPFU0hp5e12FW+Ln4lru59JYy4c05l/w88y1x/kX/gp?=
 =?us-ascii?Q?j3Vv9vl4YbDFLQCQp6BM9ISPJ4yADvZHA2MkO7mi6ZznrOS+iTiuM+RJjiWv?=
 =?us-ascii?Q?lWTL9fFZNbIkMwQuk3y0UwO/RU1IbogZSswBJndrB8RVUzPUHfnqHRAloMy3?=
 =?us-ascii?Q?5BaVc1RpT3+5hi/017wm68O3ZSX4NK9aEe4JUY6g8AAmy1ax7SIY8ENOgtef?=
 =?us-ascii?Q?GxBpDNfzsG8htpoXzYj8QmmcZEyfrJX3xzqo1F/UjP2nUFUM1mrovkmOw0Ki?=
 =?us-ascii?Q?g6GJgWHEKVD2PO43aT82Zlgx+/vPr/G1XqlzP6m9cpdyNQCKFFhn/zNQjjNn?=
 =?us-ascii?Q?q4L2y5x3zS74sn6efSMlX+9lkhL4bYo/TA2VUO92S6gA5uQiis0aLMHhOF2P?=
 =?us-ascii?Q?S9+wevWSOTbPlTO/oqGiNh+O+u0X3YjgKesfNmFqkqUHbn1JwcnV2SeBcXXy?=
 =?us-ascii?Q?PSzGqhao3jpTJ4wvY30HVYmh4s0vX2SUbpW223hgOazccXycF55Smm+kIT2X?=
 =?us-ascii?Q?NBi+yyc0hnnHc7Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xDJ6CdMhVYizmQFxhwwy3B7Fik1fTTrz4OeNrG8qz0oeQt3gUseJxhSmoUoC?=
 =?us-ascii?Q?TSSAnAD2YDCfxIE6d99VZZtMzJ83QlwtLSKZS6gq5BGSW3FnzCp1t88trPv3?=
 =?us-ascii?Q?osNV1sw7kfZjY+lR6QHJuU9vihUlmI2eoCkfezzYwOmtu5/N78IdHqKntnOd?=
 =?us-ascii?Q?/wK6HB7EZtWOGe/F6L+zUWWOeVa2Wu9yYMJlNRofYpMQ8rtvC1ZzQc62bD+C?=
 =?us-ascii?Q?22GeW6L9ct3Twn+hBWO/77MJXsrsL2CvynlN0mbjsJ7vjA+/UoVrmdbgVrKy?=
 =?us-ascii?Q?8+T7w11e1wH/CVTi2j3tbnA3lfjJz72cUnQan7eiOFVpvnaQPcSaH2oY8CTr?=
 =?us-ascii?Q?u8M7QP0E43FgrjilSBPuIrBErO04DFGHrcbq2mJUbH4Fj7OFd1sFpKsLM0L8?=
 =?us-ascii?Q?EWFMBU2y+JgkUoDIxixyJn+D/5lz2MJn7Tj531lqEYqdJE1lqHjjtX59vr3t?=
 =?us-ascii?Q?YzD0MGcpA13iAlm5vFbUHrELtTvJU3BGsTq3UPZmF628QEX+QYqMFwgCaieP?=
 =?us-ascii?Q?zQdIeYsNM/nGRBho3VwiVhuyOghsfyizfE1jr5kR5clQ6UBNYSAil0juc6it?=
 =?us-ascii?Q?ZPLB/TDL5jwkt6he9uszNMVedycz4NuFkTsEdMFUo3fOlcnly15+U2Do6WcV?=
 =?us-ascii?Q?MYSW7ZUiFovDVtWhG/MlwYcV5zQBPl2p7+xSq3E8pefLaFQsIx96jvu5unxl?=
 =?us-ascii?Q?hRqoc9CXXGDHma4Y7ytL+Xhp5MrI9zLH85GKNoMyYZsX9VpN+5AJXYf6rLBl?=
 =?us-ascii?Q?lIfEuSlhGkpFRTSJfxjdBSMyaf84YEvwws59OYjcX91n54Bn2YamFl+UVeW1?=
 =?us-ascii?Q?4fFMwvl+uR4cSpejglDF3YJWNajOG3UYrpRPYmUOT2+u+AWrFcWacvWS88d3?=
 =?us-ascii?Q?Zpq+KQ6Gs0ZFiS/hqTdKhvk3gMAuoaCs4W71ECTGYRYz8QccWPS3h+1NvdIV?=
 =?us-ascii?Q?Msd48mCd5xlY19es9XOh7FPCplEgEWu8f7aG2saf83IWIQ24PjQ1rNZtS7AB?=
 =?us-ascii?Q?ic3ne2N+8uBtvpJB3zmpvKSvoM1W5l/a22wxNLgjGtU8BdQ7nz3i9tvTVuVV?=
 =?us-ascii?Q?xrqzrxbT3eEBSPAf7exfaRACYu34g8taNQpJI8G0BIu/ziUTavXt0P/JmsPQ?=
 =?us-ascii?Q?YYJMntBsBoZRHWiUVwEA65pRETZ2Sk2Lirvj59yUbtPBdbQmyxrd6CQFMkYd?=
 =?us-ascii?Q?G2oOpDDGNE28ltnJ4tq04oc0MyYgtKweAXrmFnlczfCFUWm4MXs6s/gJigD+?=
 =?us-ascii?Q?D6nPIo1+LgCLl+0l1OHhOVtL5ywt+zaBDxMEVgNezz4d1gzoNaB7ndafavUy?=
 =?us-ascii?Q?LJPiuDkvHGJ+Oa4ElUhiCDIBOrWOHDugoB/Zqwk1aZeBMLECQzmzy15ZGJ31?=
 =?us-ascii?Q?wFOCQAgcEFoDIy5CiehM+PY7twoT/GvdPnuZVzMzLNJkJHoB3sNUJ38ggf23?=
 =?us-ascii?Q?DRJHN+SP8KCRKSdFBO3hAijhd+eOd7cdER9S0Otb4/bfl/l/7X51d7CHz6su?=
 =?us-ascii?Q?7lWOSUqy7Miv2/WpCDSCjAP2gPWJW5mwo5mpeGbfwKT811hgmj4eqmGLVw53?=
 =?us-ascii?Q?ONSj6fOBBILE+2Fl+Pw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eaedaa3e-b1e9-4168-4233-08dde1643b80
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:11:16.7502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ve/mZXWBns++uHSv056QLJJies6bUycaLoaOsyYfY7I8vGQfNxIjVr1Lc63RwLdLeM/xZz5kgu2s3u5b0cEOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, August 13, 2025 1:11 AM
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
> On Thu, Aug 07, 2025 at 01:10:19PM +0530, Sai Krishna Musham wrote:
> > Add support for handling the AMD Versal Gen 2 MDB PCIe Root Port PERST#
> > signal via a GPIO by parsing the new PCIe bridge node to acquire the
> > reset GPIO. If the bridge node is not found, fall back to acquiring it
> > from the PCIe host bridge node.
> >
> > As part of this, update the interrupt controller node parsing to use
> > of_get_child_by_name() instead of of_get_next_child(), since the PCIe
> > host bridge node now has multiple children. This ensures the correct
> > node is selected during initialization.
> >
> > Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> > ---
> > Changes in v7:
> > - Use for_each_child_of_node_with_prefix() to iterate through PCIe
> >   Bridge nodes.
> >
> > Changes in v6:
> > - Simplified error checking condition logic.
> > - Removed unnecessary fallback message.
> >
> > Changes in v5:
> > - Add fall back mechanism to acquire reset GPIO from PCIe node when PCI=
e
> Bridge
> > node is not present.
> >
> > Changes in v4:
> > - Resolve kernel test robot warning.
> > https://lore.kernel.org/oe-kbuild-all/202506241020.rPD1a2Vr-lkp@intel.c=
om/
> > - Update commit message.
> >
> > Changes in v3:
> > - Implement amd_mdb_parse_pcie_port to parse bridge node for reset-gpio=
s
> property.
> >
> > Changes in v2:
> > - Change delay to PCIE_T_PVPERL_MS
> >
> > v6 https://lore.kernel.org/all/20250719030951.3616385-1-
> sai.krishna.musham@amd.com/
> > v5 https://lore.kernel.org/all/20250711052357.3859719-1-
> sai.krishna.musham@amd.com/
> > v4 https://lore.kernel.org/all/20250626054906.3277029-1-
> sai.krishna.musham@amd.com/
> > v3 https://lore.kernel.org/r/20250618080931.2472366-1-
> sai.krishna.musham@amd.com/
> > v2 https://lore.kernel.org/r/20250429090046.1512000-1-
> sai.krishna.musham@amd.com/
> > v1 https://lore.kernel.org/r/20250326041507.98232-1-
> sai.krishna.musham@amd.com/
> > ---
> >  drivers/pci/controller/dwc/pcie-amd-mdb.c | 52 ++++++++++++++++++++++-
> >  1 file changed, 51 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > index 9f7251a16d32..3c6e837465bb 100644
> > --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/resource.h>
> >  #include <linux/types.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define AMD_MDB_TLP_IR_STATUS_MISC           0x4C0
> > @@ -56,6 +57,7 @@
> >   * @slcr: MDB System Level Control and Status Register (SLCR) base
> >   * @intx_domain: INTx IRQ domain pointer
> >   * @mdb_domain: MDB IRQ domain pointer
> > + * @perst_gpio: GPIO descriptor for PERST# signal handling
> >   * @intx_irq: INTx IRQ interrupt number
> >   */
> >  struct amd_mdb_pcie {
> > @@ -63,6 +65,7 @@ struct amd_mdb_pcie {
> >       void __iomem                    *slcr;
> >       struct irq_domain               *intx_domain;
> >       struct irq_domain               *mdb_domain;
> > +     struct gpio_desc                *perst_gpio;
> >       int                             intx_irq;
> >  };
> >
> > @@ -284,7 +287,7 @@ static int amd_mdb_pcie_init_irq_domains(struct
> amd_mdb_pcie *pcie,
> >       struct device_node *pcie_intc_node;
> >       int err;
> >
> > -     pcie_intc_node =3D of_get_next_child(node, NULL);
> > +     pcie_intc_node =3D of_get_child_by_name(node, "interrupt-controll=
er");
> >       if (!pcie_intc_node) {
> >               dev_err(dev, "No PCIe Intc node found\n");
> >               return -ENODEV;
> > @@ -402,6 +405,28 @@ static int amd_mdb_setup_irq(struct amd_mdb_pcie
> *pcie,
> >       return 0;
> >  }
> >
> > +static int amd_mdb_parse_pcie_port(struct amd_mdb_pcie *pcie)
> > +{
> > +     struct device *dev =3D pcie->pci.dev;
> > +     struct device_node *pcie_port_node __maybe_unused;
> > +
> > +     /*
> > +      * This platform currently supports only one Root Port, so the lo=
op
> > +      * will execute only once.
> > +      * TODO: Enhance the driver to handle multiple Root Ports in the =
future.
> > +      */
> > +     for_each_child_of_node_with_prefix(dev->of_node, pcie_port_node, =
"pcie") {
>
> This is only the second user of for_each_child_of_node_with_prefix()
> in the whole tree.  Also the only use of "__maybe_unused" in
> drivers/pci/controller/.
>
> Most of the PCI controller drivers use
> for_each_available_child_of_node_scoped(); can we do the same here?
>
> The apple, kirin, mt7621, mtk, and qcom drivers are examples.  I think
> the qcom structure is pretty good, and it has a similar fallback path
> for DTs without Root Port nodes (qcom_pcie_parse_legacy_binding()):
>
>   qcom_pcie_probe
>     ret =3D qcom_pcie_parse_ports
>       for_each_available_child_of_node_scoped(dev->of_node, of_port)
>         qcom_pcie_parse_port(of_port)
>           reset =3D devm_fwnode_gpiod_get(..., "reset", ...)
>     if (ret)
>       qcom_pcie_parse_legacy_binding
>
> IIUC the current amd-mdb hardware only supports a single Root Port, so
> I don't think you need a TODO, since there's no point in that
> enhancement until hardware supports multiple RPs.
>
> But I probably *would* add a check here so that if we run the current
> driver on future hardware that does have multiple Root Ports with
> separate resets for each RP, there's at least a chance that the first
> RP will work.  E.g.,
>
>   amd_mdb_parse_pcie_port(...)
>   {
>     if (pcie->perst_gpio) {
>       dev_warn("Ignoring extra Root Port\n");
>       return 0;
>     }
>
>     pcie->perst_gpio =3D devm_fwnode_gpiod_get(...);
>

Thanks for the feedback. I'll switch to using for_each_available_child_of_n=
ode_scoped()
and send it as a separate patch.

> > +             pcie->perst_gpio =3D devm_fwnode_gpiod_get(dev,
> of_fwnode_handle(pcie_port_node),
> > +                                                      "reset", GPIOD_O=
UT_HIGH, NULL);
> > +             if (IS_ERR(pcie->perst_gpio))
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +             return 0;
> > +     }
> > +
> > +     return -ENODEV;
> > +}
> > +
> >  static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
> >                                struct platform_device *pdev)
> >  {
> > @@ -426,6 +451,12 @@ static int amd_mdb_add_pcie_port(struct
> amd_mdb_pcie *pcie,
> >
> >       pp->ops =3D &amd_mdb_pcie_host_ops;
> >
> > +     if (pcie->perst_gpio) {
> > +             mdelay(PCIE_T_PVPERL_MS);
> > +             gpiod_set_value_cansleep(pcie->perst_gpio, 0);
> > +             mdelay(PCIE_RESET_CONFIG_WAIT_MS);
> > +     }
> > +
> >       err =3D dw_pcie_host_init(pp);
> >       if (err) {
> >               dev_err(dev, "Failed to initialize host, err=3D%d\n", err=
);
> > @@ -444,6 +475,7 @@ static int amd_mdb_pcie_probe(struct platform_devic=
e
> *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct amd_mdb_pcie *pcie;
> >       struct dw_pcie *pci;
> > +     int ret;
> >
> >       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> >       if (!pcie)
> > @@ -454,6 +486,24 @@ static int amd_mdb_pcie_probe(struct platform_devi=
ce
> *pdev)
> >
> >       platform_set_drvdata(pdev, pcie);
> >
> > +     ret =3D amd_mdb_parse_pcie_port(pcie);
> > +     /*
> > +      * If amd_mdb_parse_pcie_port returns -ENODEV, it indicates that =
the
> > +      * PCIe Bridge node was not found in the device tree. This is not
> > +      * considered a fatal error and will trigger a fallback where the
> > +      * reset GPIO is acquired directly from the PCIe Host Bridge node=
.
> > +      */
> > +     if (ret) {
> > +             if (ret !=3D -ENODEV)
> > +                     return ret;
> > +
> > +             pcie->perst_gpio =3D devm_gpiod_get_optional(dev, "reset"=
,
> > +                                                        GPIOD_OUT_HIGH=
);
> > +             if (IS_ERR(pcie->perst_gpio))
> > +                     return dev_err_probe(dev, PTR_ERR(pcie->perst_gpi=
o),
> > +                                          "Failed to request reset GPI=
O\n");
> > +     }
> > +
> >       return amd_mdb_add_pcie_port(pcie, pdev);
> >  }
> >
> > --
> > 2.43.0
> >

