Return-Path: <linux-pci+bounces-13468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1E8985126
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD11284FD1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE761487D6;
	Wed, 25 Sep 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PejG4cKq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAA2132124;
	Wed, 25 Sep 2024 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233262; cv=fail; b=beAl2KP4BAVUK7tXcWjB1Ic8pve1AjrNFwl7NjCJB4a6N+3DZg7IHzFc2/vNKztf2q7Tb3uXkv3zfHsf2B1ExHJpWr/0nbhshJ12wAzMB/hLmfl8YRmN41bYjXEyy9AsWfNYtgpSaKFWNxhtYej9O7sMiGd5aEn7M2nxcR1KRkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233262; c=relaxed/simple;
	bh=HCy9fITUl9KYGoMJU4leOG4Hwj1ynwPFPUwth2KiQe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lMPLkevSPwyhRMr7l3xKp3XbLYe7pnwPasFGA5iKR2prFg4ERQKEfwVQJ3Tz9Noo4cJm4t1HT1EoExxOCEQspCC/C8iN6bkvb3pjBY4jyMTvrD90eGd/mCxipzlnOxiIOfKSWTACzMqwfu2jjp7IRbHCLc+l3X2YQG4PsgxrqFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PejG4cKq; arc=fail smtp.client-ip=40.107.241.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cq3rx9+IaCfsHmdgW90rbbVYKCtwoXZ7Bxm0GMLMOxa1Z/iehNVNBn03t4AK00Buc7Sn7ri5qMCUnIdViVa2IdhgihRGGzyFVYqHlwVvkKydtZXR7BcylB5p2LopCKZBdqDVo8iSWvgzen20jtoUYwCT52mMFtAuU98LYGUAfV4SiwVDfUUA/b0BSLgvn+OdljE9s5b/xRnqopKLGBBPQIcUGu5rp5KrVdUB7GVObHdnW0gB480/yRdwn5bMXRr2hTqNO+lIxmodJjiJysowVoUaatb74DCF5U3PSwqFR9BKRgOnQTldcCGxR2nYEmhHy+rUxLvJf4bqKgi0wLqh5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCy9fITUl9KYGoMJU4leOG4Hwj1ynwPFPUwth2KiQe0=;
 b=QVAoQ4FJnKEWEsm3cFlbS8GGv/j669pxRXW65vi37lPci/x9it9FEAAXTtnrsk5YectFKghG91ml457xGvkGjV0Pb4nZp06EBY4vpTQZnkJV8sA86RLskhVcT0NhPybY1PYEiRhyZSu/ujtc+oWf575sjKXBwZKl5cBJ4X3PSK2n+uagJefCM2k3U53bk+S3+DvUB1gse9JlFAaNwyxFRhZjRczKkcWSreZ1iFeXxp9AbxnuP39WHm/6nYyU+KmGVeUfhRsA1ZwK+q2PSIGIXbhX/hlIiUacX7HtbAQIpP8AwL46CRtfCbygAiiPINzQhgyXirpTjYHSXGlJiGYZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCy9fITUl9KYGoMJU4leOG4Hwj1ynwPFPUwth2KiQe0=;
 b=PejG4cKqkimyjdYIy6miq4XZnly1oApsZ+eDRtQJrApocNHKILZ+t65+V7o1T7WH1eSIC7FcPX1pcroZgihSKS8qDeyuZXsZGCic9dV2kfBCW2t4s7pMl/H06SNXJqECD9Dk1O1PwiR8D8JOaT8Y8ho8xo31C9fiCskFWXGje2XBwCGuLT951O+KdL6D4f76G/o38ODow7qWF+J0FIjtRgn3zmAbdPCZoW5zF72+nvTX3JATApKij5iiq9C2IDrDkBfdvjI5pnH2j0Snsos2mES1oy6Ct9FdUyPCMfAxmLXdsTwraCs+MwhPD2vG8ztzBtdqFiTr27SQVBgnBhIyAQ==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 03:00:56 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 03:00:56 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Lucas Stach
	<l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH 3/3] PCI: imx6: Remove cpu_addr_fixup()
Thread-Topic: [PATCH 3/3] PCI: imx6: Remove cpu_addr_fixup()
Thread-Index: AQHbDsxjRY5TS4G6wE24DNUDcOjXkLJn0Avw
Date: Wed, 25 Sep 2024 03:00:56 +0000
Message-ID:
 <DU2PR04MB867738A0CD64CA3B4FDA76D78C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com>
 <20240924-pci_fixup_addr-v1-3-57d14a91ec4f@nxp.com>
In-Reply-To: <20240924-pci_fixup_addr-v1-3-57d14a91ec4f@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|DB9PR04MB9452:EE_
x-ms-office365-filtering-correlation-id: a88807c1-94a3-4c29-1196-08dcdd0e467c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmYyeHU3cWVJdmxINHFhNkV5Wkt4aG55czVqRU5FNGhoZ2srZ25tLzVrVGMr?=
 =?utf-8?B?aXlablVMVmE5aEhHMFEyeXdzenFmbWV5dXJvYm1HY0NFcEpqL1M2SFdQc3ZL?=
 =?utf-8?B?bUR3WEtBeEx2akxQTW52VWE5M3Y2Q09qQkl0NFVpZnJneGlyRUE1VW1rWHh4?=
 =?utf-8?B?Sld3ckVNcjErK2VFczZBaUNDTVlOQkNLV0pSQWl1TVFadGJYRDFaMitjd1c1?=
 =?utf-8?B?ZWg5T3IrdUNlMVVpZGpBRW93UFprSVl2U29sTkZIdXFUbjJYSGhCdTNzbmVy?=
 =?utf-8?B?eHFRS1QzaUk2OFlRalA2a0RpQlZFZ095dGk2K29mRExjbUxhSGk2c255bkdE?=
 =?utf-8?B?L21tcWNSVEJUZjlCeENlOEZqMHU1WUdsL0dDbGFtbG03YTUycXpZb2hMQWpu?=
 =?utf-8?B?Ujl6aDBUTWJIeW9mSU1BZTBPTU5YSnphRWt4aDlsc3VGc2hlUXRnc1o5T1Bm?=
 =?utf-8?B?S3FjWHo4dkV3ZktkTDFBeVZDZUwyRm1BVXg3YnBUUGNPMWExLzEzNzFMOFgy?=
 =?utf-8?B?MFN6RERGOFp4SUkyTEZEamlocG4xNmFDN2lBdkVkQ202RDlLYVJzdG0vQ282?=
 =?utf-8?B?TksycmsxRmhaMXVvVC84MlpzL2NvdFRqeXI0WEFSUGV1MEl0ZmU5TkRBSDRv?=
 =?utf-8?B?Mk1YUUdMRDJQeGI0aGV3dkt1aGZ0cEIwSmZlQmNPWHBoQmExY0hvYlVQb0ZS?=
 =?utf-8?B?VXFxS1dNbGtFYzlseUlieDJab0pRU3dhRFJZVW1EbU0zdWVwUmZiT0VvbG02?=
 =?utf-8?B?RHJmZkdBbWFZZkxIZnNsZ0NwQ0hVaitoMzhIbEZSQzhJa2pZVGRxQS9WdXMy?=
 =?utf-8?B?RjBDR1hWeEp2KzBGVGRjc0tKM3EzMlRYTzJFVE5raitMNlBjRVdyL0JGUU5s?=
 =?utf-8?B?a2Q4bGJiMDRvSStDRE1uWStYMnUzSHFWZUhXV0hMYytZV1NRNkd3ck1DczZu?=
 =?utf-8?B?WkROU2ZtdHFiSE9Nb3kvTnFVcC9rT0V2YWhldHhtSVFkNlpGOFBZQUtKMnNN?=
 =?utf-8?B?aUNtdTUyZmU3TWJNN1hGNzhPOC9SVndKMkdxYlZnWnpHaW5BNllpaWxwckdh?=
 =?utf-8?B?T2szZzdKcVY2bHZJVE5KT0RvblIwUG1VOUFCbWFBNnk3cE5IaWYzQkxLdzJy?=
 =?utf-8?B?dUNCdTBnUndSSFMzazg0M0wrYmNMOVhzdFhjenFlMWt3Umo1cEREQ1g5QkhL?=
 =?utf-8?B?Z0FkUmE4WURZWnBwQmJLcTZ6VElBVkRaVUd1OEU2YTdxQ1VXQy9ibk5XQnR0?=
 =?utf-8?B?Y1RsUnZTNitwTU5EMkpxV2swek5ZSUdGeHVXTElxM3I1TVFzaEJYU0FvaSt0?=
 =?utf-8?B?eWU0T1lLSTI1N2MzU2NicUNJYWFja1hMWW9lQlNYOXQxbHVZS0wrY2EvVnhv?=
 =?utf-8?B?NkpqMlJJb1U5dERNUkdBMWhSNldQRFVaZDJzZDN4eXNvOFBGb0NGNzlzSXNI?=
 =?utf-8?B?Mm9BTUVmSFRLNEhHUnloaVM3NWt0TmcwNGFrbW9kcm1QSHNFZFVJMEdLZzZM?=
 =?utf-8?B?VzVHKzVJU2VvWkxyYm1lVGVvYnZOejFMWHNzT25rcDdXeGRHeHk1eXAyV0hr?=
 =?utf-8?B?UzRPSkhxWUI3Zm4zam1TSWVialFkS1puSjFzb2hPdmpHNm9xdzNaOEpPcmJH?=
 =?utf-8?B?M0RZNWRSb2JzZ0kyVk91VVVZM1pjc25jVi96WVhIOHo5TUs2WEluaVdoMTVy?=
 =?utf-8?B?SG1odnFHelhDNnpOemtIZjhNVkhvRHQ0WmVJRlBYdFV3YUF2VUVYNndLdFEx?=
 =?utf-8?B?OVBsd2JSUHJrZHJ2Z0Z5MTZJdjJEeHZqYnpCall3SmpIa1FPdDVwdDM3dzEz?=
 =?utf-8?Q?AwDBouGGtAuSpMPT19Q9gqDw7899EXcxhngr8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0VBMFQzcEtPZml3bWU4Z29jYU1VOHlkaFEvRktoRmNaMjJyakp3L2NkdGg1?=
 =?utf-8?B?cmxoKzkveUJjTkY3bUVtNXBzSU9VYlQzRVVTM1NJS3FvaUhydEpOUjZ0dWxh?=
 =?utf-8?B?UmRoREl4eFNYN3Q0SzQrdUxiZ3diZlFlelZqRm56SDVMNHlTVlFodUNjNC9L?=
 =?utf-8?B?dTdyakl3aXFTcUJidEN4WmNPbEJXTEZ0RUJ0TU8xWmFld2VMRWZZNWU5MjE3?=
 =?utf-8?B?eDZITFF1MkZRSE5nRHFVYnFHZ25MSVc0cEpLRit1SmZmcEQveUFFc095NWpz?=
 =?utf-8?B?T3pwSEY3YTdGanBVZ3ZTTGFhZTYyR21LWnFtOUdOSXpOais2QTZtMlVWbk9R?=
 =?utf-8?B?akFwanM5M2trcS9WNXJOMkFxb2dRZmFHeHlkdWN1aVZXQmxqM0h1SHpmOUhS?=
 =?utf-8?B?cXhjZnJtTmYyS3dDZ2JqT0s4KzUrK1ZRUThGczk2RmpFblgvVGZqZmExM3o4?=
 =?utf-8?B?SE9PZ0U5VTVKZzdzK3hvSU9rYjQ3WW4xMEtlSGo3VmlDUnNqbS80TkpJbklU?=
 =?utf-8?B?NUJCVzB3bm9LYVZjREFGS3B1Z0dxK2tpVGR1cnIzZXR0dW1iSXlJVU5JeWpq?=
 =?utf-8?B?V0YyZlo0Z3RETkR1N0owRU9EbzFSN2ppT3Z5c3R0ZC94MHdlRnVyOVlmS1dz?=
 =?utf-8?B?bERuK1hKazFrQytFbXI2TW1CWjFJOGNDTG1Da1JJQ0pONTNoYnN0Y2lJemgr?=
 =?utf-8?B?NzZkd2FkMHpYc1J1TzdaR2ppS0VIL1V6WmovUmMwcHVzNXJHNVR4WkdUMEpO?=
 =?utf-8?B?NHg0QXNnSXFKcytaTmREK3Mxb3BQNFZmTE95NkVvWDB3YldZdnJHWE1sdEJD?=
 =?utf-8?B?bTBxaUhTdWtpbExma2hITnd4bG5pOXVQcWtWeEhZU3draVJ3dFdFYzhHRHRz?=
 =?utf-8?B?NHV3aDVBRVhWVDlBWnFzZ3dBaHV2MFlXWGhiNlJjdjVVczdsUEZIV2RIQTJ5?=
 =?utf-8?B?YlZGREFoOTZUWEk5TGZCaHp5M2U2U0labXhVZVNMMmd2NW5MSUREN29IVG82?=
 =?utf-8?B?bEsyOFE1M3lMOEN2RU5QOHg0ajUrOWlHdlJPdE5FdG9RMS9NZU5kSVRpNnhI?=
 =?utf-8?B?V1RtQkpCUlp1c292dWV2cFp1TkhPeGZNQUJBTDJLL1NXN2UybHIwSXF1M3di?=
 =?utf-8?B?QnM4ZmRVMGV2eVZBQzJzSVh6L3FxajF2NWxOd0ZqcmFzVDJpTGI2UWJCQk4y?=
 =?utf-8?B?bXMyR2w0djFCMFIrVFBHNXJ1UGRwQlV2UUpJNXcrZDhQZVNRMWNvMTRTVXlv?=
 =?utf-8?B?RldtSzRvTTM2ZC9LbVpxZUVxVktiTUh6cERUUTB4QXJoQ2ZBcW1xNnExVHJt?=
 =?utf-8?B?dEVyMlBMemYwMmh0V25kODJRNG9hSXMyd2ZtditBMVRmWTBRTjNSL0VoSTVr?=
 =?utf-8?B?ZTVtUnVjdEdtYUZkYjJ6THJRUXcydmZoZGQ3Z0p1ZW9ic3lTcjQwZDVNRVVu?=
 =?utf-8?B?MDlDcjF3cVNwdmQ0dGRJa3RzZzZBYVZndGhmZGx0UXp5VlNNbkVPNVBSdnpJ?=
 =?utf-8?B?RzBCVlVXdjdValhROFlnQ1lwYVV3VElITHZHeG9RWWUyUGRSRm1sdk9mNWNL?=
 =?utf-8?B?WkpIekdXUmxBSFBsczl0dnFyRlpWZUFiRUttbVV5R2Uwb1RPNzJsSTZBSHJT?=
 =?utf-8?B?dnJkajJPbGpxOHAxaDMyTzBJNCtyZ2EvR3UrVjdYSlJMUTg0QkJ4bHBFOE9T?=
 =?utf-8?B?QVo2TENJMTFNbVhNc1ZLMHJrbU5CNkRIaWt6U3FaZmY5ZXVKNkFaeHZnNVQ0?=
 =?utf-8?B?M1VkT3pRd0dySkVSandwSzdGN0dMYnd5L1p1WnhNMVBWSXBXSVRaaUZiZi9k?=
 =?utf-8?B?Q05yYTlzVjdlVEd3ckhFelUwZDBjd3ZqMGkxaUVaOWZQZGVDamNlUDJVOFlm?=
 =?utf-8?B?VjRjNGMvczVWd1lzL1ZkRVlzaWFqMFRURHhTdXFXRUpwSUpaUUFKQ0Jhdy9y?=
 =?utf-8?B?RzBncDZSY0hmYzFKYmtURnlicHhubENwOUtNWHIwU0xGazdMd0dFWWt0N1hV?=
 =?utf-8?B?NTV4dUp5KzBkM3g5SjNRUVpKK1RLVXozN1Y3dE9VR1IveWJ1b3RZUmsxanNx?=
 =?utf-8?B?WXJaZWVSZVp5elZpakEwWjdORlBwZCs3RVdkMUo0Q2MzaWwzQThsMC9jWU1z?=
 =?utf-8?Q?KBxWbnLLILweVj7D28+X2kzOH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88807c1-94a3-4c29-1196-08dcdd0e467c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 03:00:56.1154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WLNC5UwQj+WsLfKhe5IblLzPcp0q1QRcN9kv7NouSHog0EQ1XCbjZkbFKcXZSM0ryzPlfefDIb7NHAudRW7pIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDnmnIgyNeaXpSA1OjU0DQo+IFRvOiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPjsgU2FyYXZhbmEgS2FubmFuDQo+IDxzYXJhdmFuYWtAZ29vZ2xl
LmNvbT47IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPjsgTWFuaXZhbm5hbg0KPiBT
YWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz47IExvcmVuem8gUGll
cmFsaXNpDQo+IDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgV2lsY3p5xYRza2kg
PGt3QGxpbnV4LmNvbT47IEJqb3JuIEhlbGdhYXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMNCj4gU3RhY2ggPGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNj
aGENCj4gSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwg
VGVhbQ0KPiA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgRnJh
bmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAzLzNdIFBDSTogaW14
NjogUmVtb3ZlIGNwdV9hZGRyX2ZpeHVwKCkNCj4gDQo+IFJlbW92ZSBjcHVfYWRkcl9maXh1cCgp
IGJlY2F1c2UgZHdjIGNvbW1vbiBkcml2ZXIgYWxyZWFkeSBoYW5kbGUgYWRkcmVzcw0KPiB0cmFu
c2xhdGUuDQpoYW5kbGUvcy9oYW5kbGVzIA0KdHJhbnNsYXRlL3MvdHJhbnNsYXRpb24NCg0KUmV2
aWV3ZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxp
QG54cC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
YyB8IDIxICstLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiBpbmRleCAxZTU4YzI0MTM3ZTdmLi43NjE3NGIzYTAzODhjIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gQEAgLTgyLDcgKzgyLDYgQEAg
ZW51bSBpbXhfcGNpZV92YXJpYW50cyB7DQo+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFTX1BI
WV9SRVNFVAkJQklUKDUpDQo+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFTX1NFUkRFUwkJQklU
KDYpDQo+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfU1VQUE9SVF82NEJJVAkJQklUKDcpDQo+IC0j
ZGVmaW5lIElNWF9QQ0lFX0ZMQUdfQ1BVX0FERFJfRklYVVAJCUJJVCg4KQ0KPiANCj4gICNkZWZp
bmUgaW14X2NoZWNrX2ZsYWcocGNpLCB2YWwpCShwY2ktPmRydmRhdGEtPmZsYWdzICYgdmFsKQ0K
PiANCj4gQEAgLTEwMTUsMjIgKzEwMTQsNiBAQCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9ob3N0X2V4
aXQoc3RydWN0IGR3X3BjaWVfcnANCj4gKnBwKQ0KPiAgCQlyZWd1bGF0b3JfZGlzYWJsZShpbXhf
cGNpZS0+dnBjaWUpOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyB1NjQgaW14X3BjaWVfY3B1X2FkZHJf
Zml4dXAoc3RydWN0IGR3X3BjaWUgKnBjaWUsIHU2NCBjcHVfYWRkcikgLXsNCj4gLQlzdHJ1Y3Qg
aW14X3BjaWUgKmlteF9wY2llID0gdG9faW14X3BjaWUocGNpZSk7DQo+IC0Jc3RydWN0IGR3X3Bj
aWVfcnAgKnBwID0gJnBjaWUtPnBwOw0KPiAtCXN0cnVjdCByZXNvdXJjZV9lbnRyeSAqZW50cnk7
DQo+IC0NCj4gLQlpZiAoIShpbXhfcGNpZS0+ZHJ2ZGF0YS0+ZmxhZ3MgJiBJTVhfUENJRV9GTEFH
X0NQVV9BRERSX0ZJWFVQKSkNCj4gLQkJcmV0dXJuIGNwdV9hZGRyOw0KPiAtDQo+IC0JZW50cnkg
PSByZXNvdXJjZV9saXN0X2ZpcnN0X3R5cGUoJnBwLT5icmlkZ2UtPndpbmRvd3MsDQo+IElPUkVT
T1VSQ0VfTUVNKTsNCj4gLQlpZiAoIWVudHJ5KQ0KPiAtCQlyZXR1cm4gY3B1X2FkZHI7DQo+IC0N
Cj4gLQlyZXR1cm4gY3B1X2FkZHIgLSBlbnRyeS0+b2Zmc2V0Ow0KPiAtfQ0KPiAtDQo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfaG9zdF9vcHMgaW14X3BjaWVfaG9zdF9vcHMgPSB7DQo+
ICAJLmluaXQgPSBpbXhfcGNpZV9ob3N0X2luaXQsDQo+ICAJLmRlaW5pdCA9IGlteF9wY2llX2hv
c3RfZXhpdCwNCj4gQEAgLTEwMzksNyArMTAyMiw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdf
cGNpZV9ob3N0X29wcw0KPiBpbXhfcGNpZV9ob3N0X29wcyA9IHsgIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZHdfcGNpZV9vcHMgZHdfcGNpZV9vcHMgPSB7DQo+ICAJLnN0YXJ0X2xpbmsgPSBpbXhfcGNp
ZV9zdGFydF9saW5rLA0KPiAgCS5zdG9wX2xpbmsgPSBpbXhfcGNpZV9zdG9wX2xpbmssDQo+IC0J
LmNwdV9hZGRyX2ZpeHVwID0gaW14X3BjaWVfY3B1X2FkZHJfZml4dXAsDQo+ICB9Ow0KPiANCj4g
IHN0YXRpYyB2b2lkIGlteF9wY2llX2VwX2luaXQoc3RydWN0IGR3X3BjaWVfZXAgKmVwKSBAQCAt
MTU5OCw4ICsxNTgwLDcNCj4gQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRh
IGRydmRhdGFbXSA9IHsNCj4gIAl9LA0KPiAgCVtJTVg4UV0gPSB7DQo+ICAJCS52YXJpYW50ID0g
SU1YOFEsDQo+IC0JCS5mbGFncyA9IElNWF9QQ0lFX0ZMQUdfSEFTX1BIWURSViB8DQo+IC0JCQkg
SU1YX1BDSUVfRkxBR19DUFVfQUREUl9GSVhVUCwNCj4gKwkJLmZsYWdzID0gSU1YX1BDSUVfRkxB
R19IQVNfUEhZRFJWLA0KPiAgCQkuY2xrX25hbWVzID0gaW14OHFfY2xrcywNCj4gIAkJLmNsa3Nf
Y250ID0gQVJSQVlfU0laRShpbXg4cV9jbGtzKSwNCj4gIAl9LA0KPiANCj4gLS0NCj4gMi4zNC4x
DQoNCg==

