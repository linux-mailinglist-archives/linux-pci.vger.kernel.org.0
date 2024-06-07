Return-Path: <linux-pci+bounces-8434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6085F8FFE2E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CC81C229C9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784615443A;
	Fri,  7 Jun 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FA8KycUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7615B0E1;
	Fri,  7 Jun 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749730; cv=fail; b=P/BiuNcW/lfTXOL93o3UPpKnByg5dDE2EXusu1IdNutCLduNUmfNw2wPoM+XTfh3/pyeYHn5Qm52rQDNbgBaBMcrRYd6so6O59AZqFSrgY/ZlFpHfl9rqn5JovK8PZtTiKLu1nFG+saoA3757WyUkOmdUyvcUN9X3smmXD30Rpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749730; c=relaxed/simple;
	bh=ceiyZZAA8e4U3896TqrtxkxAcE659xTR9fpVaPjFicM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f9p1aJMqUeZB3PqSSJw7KeGCPPK5eZYV2uLh0MdECe8/9F/HZeMqYiKwGDa0Se0PFW5kEvLIE3VoTMje+EeXzMw36NMtWMmCeCVWNq5Ot/h0sbsHcSN7KUhZiV5ZaX07UuxoQ+3wAuPB7Gq/eIFg/qIfpPDwU9ooJGvA8mDU/Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FA8KycUg; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDhpbadSP1X9uSIGai6+dZT4KQWSBpoMz0QrYrShhDQjCDEhNgvFcgOqbe2SJHiHa0PDo9W7XBU/80bJ1xV1ifqDvQWaNVFuD2ZzukKzjEoJSRuQ1Bw06spbjN8ZJQrkBId/ULiOPyJafOoPbbyMg0+lUm2wEUYRYm5kSmuZtMXuWrkPhwHe26mraEKesA32t5VTheDmndv7rZ/UlF0n2Jy8s5IIO69QiIVMT3zwbAZN0M4aH+r0d89lvs4UHUjcjOwe7m6IuVKAELzAbxAk16jxW0NkzTYuY513Jg2aEYdHW+qJK9ZjtHnY39oAFhvVg98/OYBEFG/y36ijQxIlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7WjDWJw4KYPaisSCtVs5aQ95PyK+GqEjvtUQFamVTs=;
 b=YM7fPgGVjSvo/f3I1hv/xLmG+9UwqOPDR89oJ+6o0f3I8k0H7VCX16cDjx8uucumfrhze0TogEYDY3jL1w9QPBHxvKJBgxvsp3MylRJs9QRttrzc9OZh9lv1VOMxlPKvqBhaDKCZhAzMXP40JM+6j5GrCspi7Vi4FImDfO9dmzKseBYU+t4omkacRUxhslab0Ff+evajj6R5Ae5WRxlNWE9ypAetS9onguL02pUgTQ7h8JLdpSdG14H1ZoaWduSm1vlkUqSD5/6F/K3irCv8XEN4XLE4uSTyG8X5FflRokdVioneR7CSKr3f3d0XwO9qRIiU49lNf/Z/KoNc9iOm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7WjDWJw4KYPaisSCtVs5aQ95PyK+GqEjvtUQFamVTs=;
 b=FA8KycUgpxTLuz88BzDjiJuUvLHsXvSB+milGfNd9KVCteFQUh3HEgsgZzhxJJhXlUhAOz93WIuXcOTPMM4/jed3U1mpH9hd6y3W01U8MQr5R9Rie0PmhoYMnUMZtY+FouKaCATwVoIlRVM/A9KEKLwjY7jNH49Y0WIEzGJ2/so=
Received: from DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) by
 PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Fri, 7 Jun 2024 08:42:05 +0000
Received: from DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::bfe4:f407:e431:d81f]) by DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::bfe4:f407:e431:d81f%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 08:42:05 +0000
From: "Chang, HaiJun" <HaiJun.Chang@amd.com>
To: "Shi, Lianjie" <Lianjie.Shi@amd.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
CC: "Jiang, Jerry (SW)" <Jerry.Jiang@amd.com>, "Zhang, Andy"
	<Andy.Zhang@amd.com>, "Shi, Lianjie" <Lianjie.Shi@amd.com>
Subject: RE: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Thread-Topic: [PATCH 1/1][v2] PCI: Support VF resizable BAR
Thread-Index: AQHarOcBtJrIjaBLckq6krqO8/wYQbGwyquggAtIcSA=
Date: Fri, 7 Jun 2024 08:42:05 +0000
Message-ID:
 <DM6PR12MB49584B9866498A33D79EFEC881FB2@DM6PR12MB4958.namprd12.prod.outlook.com>
References: <20240523071114.2930804-1-Lianjie.Shi@amd.com>
 <20240523071114.2930804-2-Lianjie.Shi@amd.com>
 <DM6PR12MB49588A7576D6DBE281A4340F81FC2@DM6PR12MB4958.namprd12.prod.outlook.com>
In-Reply-To:
 <DM6PR12MB49588A7576D6DBE281A4340F81FC2@DM6PR12MB4958.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ee765cb3-d738-44a1-859e-4f5a2733d7ec;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-31T04:23:06Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4958:EE_|PH8PR12MB7158:EE_
x-ms-office365-filtering-correlation-id: f1fe0656-9191-4d30-d89c-08dc86cdb58f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4saaZTfA7B3uqK1mXl4EcSB9tv0V1k4+c3A3PgsuRtOzZNQ641MX2CLAsazx?=
 =?us-ascii?Q?II/OXTMT8Jz0RZuJalCxJRKLjlpInb7vdUAIj4/xAvcPyVZguY2ArkOTCgYI?=
 =?us-ascii?Q?YiwE0LZdYlGHha+yzzfwXg2hM7Hub7OhsXMN6GLfnGXxs4sAck47wMuzXzbw?=
 =?us-ascii?Q?ZH9KHeEWYKAAHnQGWjMOlUjE2FxEsMbElMctPsdRIm3VrkJAIyhfIcvSYpJM?=
 =?us-ascii?Q?5l9bPIOKYoDEda4zdnTDhnQykRTHLJdG/3Dhi+JeGQtdUs+fNCDlzHoqx1nE?=
 =?us-ascii?Q?Q6MUYmlnxuejYwykslVx8EE71p2RkHdHemUpJdVitkYhKGlgwZ8+7+FW04zm?=
 =?us-ascii?Q?nVE4seVCpbblZe9JCDMC5erLAeStJz5O1yLDjWJiLrW68tYd+8/F6G3fJLR0?=
 =?us-ascii?Q?N8lCNizm4FlNnUSpdIL18wtFN1TWOL3ZBY2XmyWRu5g4ZeDoxe6pdADjEk4a?=
 =?us-ascii?Q?hqXsJp7aTLULKhw9YEl9flV/nETLprOLEtn7Lameia6i0+qOrk9xKkIAzg+V?=
 =?us-ascii?Q?+b8G5+wZWF+y3LG3psqyUGHsFclnHTqRCZh7NBXo6tX9th2kS2Lc9ISnSCgv?=
 =?us-ascii?Q?Sp16vm+2k08XEi9qraZqPpHnv3kgKc4zC7RFoLLxszzHAkXLWb6qf+EbMSur?=
 =?us-ascii?Q?aJLu+Mgw8RJrGDNTEmlvinYLEPG6Fla+UoajOVIlXx/80pP0A5i+WkFu8eqm?=
 =?us-ascii?Q?yNP0j7w2WNItzG2y4kizq3P4i+OwzYpnryEwf9SSlUISMLYbsDwsinn8RSBf?=
 =?us-ascii?Q?5VnM7M+HuWAa9tx7Hiz8qTqxqgmQ/HuopvffYQKJKVWLSIYZebBzn/xGLJ1r?=
 =?us-ascii?Q?IL2NJ5aQkKP/L6uLjddJG7HMjRhSa0jcLdeYqyHY+KwCH94ER1Thqdw79EIb?=
 =?us-ascii?Q?HF7iPEvObpFE6cWjo7h9OMJIYqzOiygm8s/tcSfCR21WRoVI/oKe49CKD1p9?=
 =?us-ascii?Q?mgBIdfCZoUXLoxEq/aMDZ+lDUaPHtVPw1kwzWBIv1Rv2aYuIFpLtHGq+MFBz?=
 =?us-ascii?Q?8wPabLka9m7PgJa+L35pBlLa8YvZru18rQwymFsTmbXoTBePIzoV3ALJO1ft?=
 =?us-ascii?Q?TtcYzhv3qqFGzbUvgVQB35FOPdEy8ZJE+oACDU/VKV5zETOI/WxHeD7rdQVJ?=
 =?us-ascii?Q?dB0z+zVIWlqp/lekXB81PADP+Q19/mnvDJA/zobthZvTYgaGWjjfEnPNeL0r?=
 =?us-ascii?Q?orR5QZq+jqt4mmrWZwj5FVGnjpdz3w2SYNnQb9Qex9zd4fUQ3bmjq7dx/puR?=
 =?us-ascii?Q?M38JLd/qfRRvASGM6GSNZVTFOJehl4eiOPdud9A3YVbvf2HCE+SCXfd1F6wX?=
 =?us-ascii?Q?115jmL8vZnRHr95++HgfppaV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4958.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ydOPy7wc5o47hoY2u13cl8eumiSHymTwGieomLPAQ5uYUNCCUpnvDJFTjbj?=
 =?us-ascii?Q?PVf0FNudlqEselB36pC3WFyNcEhWVgkQ9eY2eLzVVGZnieaLLVYTelwwF/ic?=
 =?us-ascii?Q?0ZF9Pg+0+VBRVVf2iCOE0Nid37p5lNumh2hCluoWk713CQQhbndbsWKFAETt?=
 =?us-ascii?Q?yWxpm6yzB1P4PulsenQiHgKs3o8k9el0r0hwCufF//ywC/DuSPyT7N736t6D?=
 =?us-ascii?Q?P3iy37ICmQThjDptuTwLkYPmOL0ZJ7RaFKApqXWTxNnwxOTtR3ShV8ptKDBQ?=
 =?us-ascii?Q?7Dl6wqbg7sAV8J3Eq36TPgZIuBWcjzbKKE3AaYnLC3+3rAt0c7K8IrImJTjQ?=
 =?us-ascii?Q?KkDTRCUpcRLcTFSwvTny/tJFkcMw3lriMpYdiiOMhgoj+TUhJ0XISy3YRUmH?=
 =?us-ascii?Q?j6qRKtI5FGeadEifzb4x9ClgB+7P1e6QW/E0ybl0XwQm4zqzf2J/F9dIlrE3?=
 =?us-ascii?Q?YS7o0CDsMeHCJgT3fazOmokf9UWPE1xvf4tGlq8ezV5sEVrXGSD6SygTcd2k?=
 =?us-ascii?Q?A7ZfrOb2/2b2DcqEkjuqU5lMjVyfuEpyXs7XsHikIStiUHNv5N4nIulVBWzX?=
 =?us-ascii?Q?BrwFa1xhzzBVyi/grOK4QgwHjulrDE4hn7s8QzP4O9UH1tWO63tr7B5Fdz1X?=
 =?us-ascii?Q?zh41GckLYWM9A+AEQr13+1ym4jHD7VRm+eB7nmwo7FI38C5WAEcF3vzjqUCA?=
 =?us-ascii?Q?gpD69QaxUb7QhGNdasqJv+h4mndDkEqTWK3xEx5f8w2vRnokGND0ILdeMRwe?=
 =?us-ascii?Q?Fo35yVSifLSUsNK4SkMdmtf6ctB87tPjm6+ijjsRblYu+itlTxxbjSwkJVPL?=
 =?us-ascii?Q?34Wq53xzDynefvaL2q6WF8gIvTG51jPwDOkWEbv8IzLogolNnY4o4WKero8i?=
 =?us-ascii?Q?xEsW7edP0G2b+qfeeeHl8eZ3In1bfGtgtTQjtVkV+mEMOR8annqeNRsb8mSW?=
 =?us-ascii?Q?QwVumuRVriTZM+hSRNbiSM5p5ZWT8YhcVOO+EFn+GDypijDDIdRMzeYmvazV?=
 =?us-ascii?Q?thLg7GPvjtEk8/ObE34pdhYacy0Et4Qi6v0gyG2uOGI4VxFyxBH3Ie99rlax?=
 =?us-ascii?Q?4/YACcN4Ruu4RWpCe+hhwl2YqVxZ3vklR5hsRlTJMu2ut83iNbYZMHLVft57?=
 =?us-ascii?Q?SoPwZQHl25sYt506X1sIH2SKRt7/+z6KH3XjM4x4afgy88b0x++UTKC5C8zp?=
 =?us-ascii?Q?UCPZU4hKn0B+ev81ZTa9y/xcgx53kpNgg9LE/9LOkt9Qoabw9iWXp4abEhU7?=
 =?us-ascii?Q?XoXYr0+1DUgVDAOa357mwkQ4K7Ptgy2U/SYSL+P41uru8hzXJlMCw/DXx+v1?=
 =?us-ascii?Q?bZ/EdrLvQrfTfTQRy/kycbFLrAnMv+p4CRM/ISUqiTlDkgcYLjbT+bsRfIVX?=
 =?us-ascii?Q?xFZ/jjBGESxGlgSUb51w75XO/y+qnDGmiwNZrBtLjPYTmRFTWZbvexDy9rtq?=
 =?us-ascii?Q?/0ldCFajbxWDgQ+NsIA3W4tYkgulph6FUMnUVmVwMVQFvgr25C4AKJdY24lr?=
 =?us-ascii?Q?49vP9l9hOhm0EAKKDtuaE8EFvW5UP2nQYuQJ9lmU+UPhgD+Z7FoHI86NuP/K?=
 =?us-ascii?Q?DS0QGiHjGq4QBTN8iNQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe0656-9191-4d30-d89c-08dc86cdb58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 08:42:05.2237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zh0dVdXf3lecJDcHq1ZrVa7G6MEQMjsyuqizzzkwis8DhIYB+6xa2jd+9SOyUarD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

[AMD Official Use Only - AMD Internal Distribution Only]

+ Christian to review the VF resizable BAR patch.

-----Original Message-----
From: Chang, HaiJun
Sent: Friday, May 31, 2024 12:26 PM
To: Lianjie Shi <Lianjie.Shi@amd.com>; linux-pci@vger.kernel.org; linux-ker=
nel@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang, Jerry (SW) <Jerry.Jiang@amd.com>; Zhang, Andy <Andy.Zhang@amd.co=
m>; Shi, Lianjie <Lianjie.Shi@amd.com>
Subject: RE: [PATCH 1/1][v2] PCI: Support VF resizable BAR

Hi, Bjorn and pci driver maintainers

Could you review the VF resizable BAR patch?

Thanks,
HaiJun

-----Original Message-----
From: Lianjie Shi <Lianjie.Shi@amd.com>
Sent: Thursday, May 23, 2024 3:11 PM
To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Bjorn Helgaas =
<bhelgaas@google.com>
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Jiang, Jerry (SW) <Jerry.Jiang@am=
d.com>; Zhang, Andy <Andy.Zhang@amd.com>; Shi, Lianjie <Lianjie.Shi@amd.com=
>
Subject: [PATCH 1/1][v2] PCI: Support VF resizable BAR

Add support for VF resizable BAR PCI extended cap.
Similar to regular BAR, drivers can use pci_resize_resource() to resize an =
IOV BAR. For each VF, dev->sriov->barsz of the IOV BAR is resized, but the =
total resource size of the IOV resource should not exceed its original size=
 upon init.

Based on following patch series:
Link: https://lore.kernel.org/lkml/YbqGplTKl5i%2F1%2FkY@rocinante/T/

Signed-off-by: Lianjie Shi <Lianjie.Shi@amd.com>
---
 drivers/pci/pci.c             | 47 ++++++++++++++++++++++++++++++++++-
 drivers/pci/setup-res.c       | 45 +++++++++++++++++++++++++++------
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c index e5f243dd4..12f86e0=
0a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1867,6 +1867,42 @@ static void pci_restore_rebar_state(struct pci_dev *=
pdev)
        }
 }

+static void pci_restore_vf_rebar_state(struct pci_dev *pdev) { #ifdef
+CONFIG_PCI_IOV
+       unsigned int pos, nbars, i;
+       u32 ctrl;
+       u16 total;
+
+       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_VF_REBAR);
+       if (!pos)
+               return;
+
+       pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+       nbars =3D FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
+
+       for (i =3D 0; i < nbars; i++, pos +=3D 8) {
+               struct resource *res;
+               int bar_idx, size;
+               u64 tmp;
+
+               pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+               bar_idx =3D ctrl & PCI_REBAR_CTRL_BAR_IDX;
+               total =3D pdev->sriov->total_VFs;
+               if (!total)
+                       return;
+
+               res =3D pdev->resource + bar_idx + PCI_IOV_RESOURCES;
+               tmp =3D resource_size(res);
+               do_div(tmp, total);
+               size =3D pci_rebar_bytes_to_size(tmp);
+               ctrl &=3D ~PCI_REBAR_CTRL_BAR_SIZE;
+               ctrl |=3D FIELD_PREP(PCI_REBAR_CTRL_BAR_SIZE, size);
+               pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
+       }
+#endif
+}
+
 /**
  * pci_restore_state - Restore the saved state of a PCI device
  * @dev: PCI device that we're dealing with @@ -1882,6 +1918,7 @@ void pci=
_restore_state(struct pci_dev *dev)
        pci_restore_ats_state(dev);
        pci_restore_vc_state(dev);
        pci_restore_rebar_state(dev);
+       pci_restore_vf_rebar_state(dev);
        pci_restore_dpc_state(dev);
        pci_restore_ptm_state(dev);

@@ -3677,10 +3714,18 @@ void pci_acs_init(struct pci_dev *dev)
  */
 static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)  {
+       int cap =3D PCI_EXT_CAP_ID_REBAR;
        unsigned int pos, nbars, i;
        u32 ctrl;

-       pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+#ifdef CONFIG_PCI_IOV
+       if (bar >=3D PCI_IOV_RESOURCES) {
+               cap =3D PCI_EXT_CAP_ID_VF_REBAR;
+               bar -=3D PCI_IOV_RESOURCES;
+       }
+#endif
+
+       pos =3D pci_find_ext_capability(pdev, cap);
        if (!pos)
                return -ENOTSUPP;

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c index c6d933=
ddf..d978a2ccf 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -427,13 +427,32 @@ void pci_release_resource(struct pci_dev *dev, int re=
sno)  }  EXPORT_SYMBOL(pci_release_resource);

+static int pci_memory_decoding(struct pci_dev *dev, int resno) {
+       u16 cmd;
+
+#ifdef CONFIG_PCI_IOV
+       if (resno >=3D PCI_IOV_RESOURCES) {
+               pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL,=
 &cmd);
+               if (cmd & PCI_SRIOV_CTRL_MSE)
+                       return -EBUSY;
+               else
+                       return 0;
+       }
+#endif
+       pci_read_config_word(dev, PCI_COMMAND, &cmd);
+       if (cmd & PCI_COMMAND_MEMORY)
+               return -EBUSY;
+
+       return 0;
+}
+
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)  {
        struct resource *res =3D dev->resource + resno;
        struct pci_host_bridge *host;
        int old, ret;
        u32 sizes;
-       u16 cmd;

        /* Check if we must preserve the firmware's resource assignment */
        host =3D pci_find_host_bridge(dev->bus); @@ -444,9 +463,9 @@ int pc=
i_resize_resource(struct pci_dev *dev, int resno, int size)
        if (!(res->flags & IORESOURCE_UNSET))
                return -EBUSY;

-       pci_read_config_word(dev, PCI_COMMAND, &cmd);
-       if (cmd & PCI_COMMAND_MEMORY)
-               return -EBUSY;
+       ret =3D pci_memory_decoding(dev, resno);
+       if (ret)
+               return ret;

        sizes =3D pci_rebar_get_possible_sizes(dev, resno);
        if (!sizes)
@@ -463,19 +482,31 @@ int pci_resize_resource(struct pci_dev *dev, int resn=
o, int size)
        if (ret)
                return ret;

-       res->end =3D res->start + pci_rebar_size_to_bytes(size) - 1;
+#ifdef CONFIG_PCI_IOV
+       if (resno >=3D PCI_IOV_RESOURCES)
+               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] =3D pci_rebar_=
size_to_bytes(size);
+       else
+#endif
+               res->end =3D res->start + pci_rebar_size_to_bytes(size) - 1=
;

        /* Check if the new config works by trying to assign everything. */
        if (dev->bus->self) {
                ret =3D pci_reassign_bridge_resources(dev->bus->self, res->=
flags);
-               if (ret)
+               if (ret && ret !=3D -ENOENT)
                        goto error_resize;
        }
        return 0;

 error_resize:
        pci_rebar_set_size(dev, resno, old);
-       res->end =3D res->start + pci_rebar_size_to_bytes(old) - 1;
+
+#ifdef CONFIG_PCI_IOV
+       if (resno >=3D PCI_IOV_RESOURCES)
+               dev->sriov->barsz[resno - PCI_IOV_RESOURCES] =3D pci_rebar_=
size_to_bytes(old);
+       else
+#endif
+               res->end =3D res->start + pci_rebar_size_to_bytes(old) - 1;
+
        return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h =
index a39193213..a66b90982 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -738,6 +738,7 @@
 #define PCI_EXT_CAP_ID_L1SS    0x1E    /* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM     0x1F    /* Precision Time Measurement */
 #define PCI_EXT_CAP_ID_DVSEC   0x23    /* Designated Vendor-Specific */
+#define PCI_EXT_CAP_ID_VF_REBAR        0x24    /* VF Resizable BAR */
 #define PCI_EXT_CAP_ID_DLF     0x25    /* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT 0x26    /* Physical Layer 16.0 GT/s */
 #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
--
2.34.1


