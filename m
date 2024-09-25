Return-Path: <linux-pci+bounces-13474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A94C985197
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F07B22D7C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F020E6;
	Wed, 25 Sep 2024 03:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hx5YCoRB"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6E139579;
	Wed, 25 Sep 2024 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235917; cv=fail; b=FaU2SaBA3IilubB09/D1kA4+YWF2oQokpXBn8MeKo0M8jCJjHW6qxpURpTQ3U4UZl+XNvpz8jCQeEwGcSmJ9+7eNTbP+Hz44QkU4e64AY8Y2aP10vhq6SSLOR5A5cqjndoR8f7kqDc/ej1YHckf8Gs7Zo9AW95Y7ZBowCZFI1MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235917; c=relaxed/simple;
	bh=b9ipcEDJhsHRSkWmv/11VNkfPDXQToUy7BhWmmsQbrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4VqNUeISEehMvy7KjPqh9YsCkAybPACl0+sHPvVnJLZa5AhU6nVkargN2SIL4sm47enQTL15WgE43Os6ePmSuNwnoxSWy/bVregbWuJ50mkrT5hNMNpuZioZRPnpO+uN+O7nqrl0WsbJHhh0FPf9Q3F8cfB0S8NX1XKVKoNPGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hx5YCoRB; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNvfygmXbavga8D8RvWWgNg8cfDmFEoF9ASr7BZ265lu2+RlAOuY+vMTekR1nSPe38QLGjRMnXChw9K9CiFvTcTEMGep6JHa3UiC375UOomNJ+GGkSmyWajHHcLyPxjo/4h+DOYhem7C3TVC7FXWjdUsGsgNKm2K078p5x1elb6Fdkv5zgKauQl3jnaaxGoPqsVVlMD6P8pxnRKL0OLcCjr4uzcV7FENJyY+5yvR2egulMu9WUNQuz3esGkuqxKzQNpvhGq6Mm8cIuS2qHZvlfrXrllXlSP1mkZHoidUzVs/q5KExNuNjhiek6KUVdhRLfKsAzTirs5qu8OHHdxK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9ipcEDJhsHRSkWmv/11VNkfPDXQToUy7BhWmmsQbrk=;
 b=LKRlEN15iXHfXlcQArzL0YjUEJR8BlFKZXD+R8FEAa8/tT72xbUvsGC1lSCWo2VrDCzjtBWeq6QaIxlCUgcxF7X1Sg1D6zeUp4sx34ebgQQRqSR9jQjV6EauDBizEV//GfhZaYZ0jnhtMiD/52ciwxZ6U1Vt4kDacdnsoJgBDhbzYRpNvqcsj7NsLiTx2TUYEx8Y47H+qpf1wXrjB4fkILW3K6YdSe8nrPkam1t9Pt6DsJjXcpITD6uY/hc87p6CXYxMuMno4jUPKaQrdE+pQMpOteGXyZsZBw5UMJLzBmzp6gNKxmhZpX4eOYm8FcRZ8wuruZpaxzwN4P0Rf7Te5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9ipcEDJhsHRSkWmv/11VNkfPDXQToUy7BhWmmsQbrk=;
 b=hx5YCoRBgrJxV1o3OOsyBKgdi8OorbY237+Q23KyoJKSf7Us7TArlhBWoQoqshp/xMlbr4Bf5RaER2A4tVPonL0pN64tMH0cGWoaaTped2D9SqbTTLweHwW9qf+SSf9PT4md5miLCCNSYtI+z90N74V3WEgQaK0xy+/t+eDqLoA76aYDj8S4EoC8/tFQekDif7hQiNe+Am+0O01HbAZ6hgdPfkLuYtmYcy2wBlC6GYfqmbOP0zvBkf9HWwZ5b/2HIPe6xNFzNQ5JQfTsd+dmefk8GBc+tWZcv+mSNokLyGeWoOEU3ht7hCNygrloIYvkr+dI/S8gc5ZluPF8696lIg==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by GVXPR04MB10684.eurprd04.prod.outlook.com (2603:10a6:150:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 03:45:06 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 03:45:06 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Topic: [PATCH v5 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Index: AQHa7VchMMLSKbpmfky4pqFpd8TS8LJBcW0AgAYQTQCAB1ZI8IAZR5QQ
Date: Wed, 25 Sep 2024 03:45:06 +0000
Message-ID:
 <DU2PR04MB867747824326F27C397FFEFD8C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <ZtMUbpBJscWlgkhW@dragon> <ZtgqmCbkD1ruZr4U@dragon>
 <PAXPR04MB86884911B9D2B379246C00278C992@PAXPR04MB8688.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB86884911B9D2B379246C00278C992@PAXPR04MB8688.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|GVXPR04MB10684:EE_
x-ms-office365-filtering-correlation-id: 0401d514-a6b1-41c2-eb48-08dcdd14723d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?U2czMnhzNmtCcUJjOXI3djUzd3YvZnZzSFI0MW9MbDQrRThDR3VTakZXenlo?=
 =?gb2312?B?ZWQyRzlndWYzYWtSejhBV0FNa2M2Ritrb1duUW9nS0xKeFB6TzdBM0RKc3hE?=
 =?gb2312?B?QXNlQ21PSVlIQWV2NUhUcW9vazA5MUZ1NmpNNC9jMUUyWmNnU3pNMzljdUs3?=
 =?gb2312?B?SVh1cHRpbW5pSTJhWTFoRys5TFcwdDByMkp2eHVhcy9VbFZKWGN2K0FOMEJr?=
 =?gb2312?B?dC9WMDFHTmozVDF4SFI0MmZyZS84Mk9EcHZWbmVvOU42TC9Za2J4bHhJNm5V?=
 =?gb2312?B?VUJkQkhUN3gwWDExalBmQ0hJQUxLclN0MFQvNzB2eVNNRUpHeFBmWlcwQWtB?=
 =?gb2312?B?di9kd0FTYk5oN0duNWR3OUNzNUxyOHhWVE9xZkRlQVZDSXFXNkh5NXpuZCtL?=
 =?gb2312?B?TXVVdTdacU94WTQ1K2kydmIyc3pQSkNmMTFVZHZNcVVNZXg2YUx5VVBHVjJs?=
 =?gb2312?B?eCt4SG1oZzNlaStWUTFpVWJ4TzBZaUdUdkx1Y2dzRWNoT0hyUmozWUhCODhn?=
 =?gb2312?B?SnovWkptWnM5bi9NMzJyQkhJYWJPNC95dzNlM2o2Qk84OENMdTgyQVVEU0Jx?=
 =?gb2312?B?YjJmSzlpd3Q5RFVYME5HN3JEWUtqYkpKMU9YMGhRdGJFKzM5RE1KY1B5Q1A2?=
 =?gb2312?B?YmIrRkRaL1kzOG40Q3hlSjY0M3dxL254ZDFzNTJUa2o2RFg4R1Z2a05QYkNl?=
 =?gb2312?B?WlYwTHdURk9TMkVBZ0szTHpFL1ZiZkVFTDN4WXAyVHQ4alJrekFtR1RNcU1V?=
 =?gb2312?B?ZnRZTHlJa3M4ODhRc2FVWGNYaU5CYXc2UU13VExiR2tOcjdjeWZIazZPOGNL?=
 =?gb2312?B?dC9kZ0RRb1hKbjdwU3k0Q1d1UjB6SVJnQUREb3cwN2hwUStLcFJPNXkxdjNM?=
 =?gb2312?B?Y2NrYW43bUhVbUlTWEFUb3hEUHpnaFZ5eVNqbzNSYWN3M2U1a1VPcXRDZFFD?=
 =?gb2312?B?Y0prV2laVmZGUi83eXpLT1lpZldQK3BoRWFOT1dFejFwcUJITmhrblhRZUVZ?=
 =?gb2312?B?ZlR3M1hPQjZHK2lwaUd2eE05Z0hjTVFDSFZMOXBqQW9LNC8wOXlRdStqY3NW?=
 =?gb2312?B?cFFLVGU3NjFReFhsMTl2LzZ4Ui9xWnVCMXE1UnJlOC9jLy9zMUx5a01uY3Jk?=
 =?gb2312?B?MUorM0hzblRkbXQvYU5BNzQra2U2bHRrVGxPUWlLVTVIQ2Y1enhiUEFnSDV4?=
 =?gb2312?B?ZEgyMldEL3QyWEFXL0VDQlAxS2tpU2prWWJxT3BIZVhzRDlvdzgxODFVYXQ0?=
 =?gb2312?B?OEpHT0VTYjRielhPb1RPV1pseGx4aWVCc1A4WG82UjNLVWY4dDFZcS9yVndI?=
 =?gb2312?B?bDg4T1NIUEhtMVBwV3p5alUvbmwxQlFBOVVyUFpsN0ZjbXVYM1YxRzZ3S0tl?=
 =?gb2312?B?L1BNS1UzbHhybXd3dXlxZTdHdW13ZStVWjlMcS8raDJqN08veUxxY1JLeCsz?=
 =?gb2312?B?THA2bG5qTGFPbmVtYUxIKyt6SWxEc1dXd3BKdisyUXl5K0REdWxxbnRUNHpF?=
 =?gb2312?B?OTZqTVFSVUxIMkN2Yy9SeHJ2SzVoTTg2YlFBQ3pTdzZGR0NJQ0svS2VtdDBq?=
 =?gb2312?B?U3labFBaNExLNWZuQXB1S0RzRXJ0eDYxQnRZUVRtVE80K0NQbHl2cy9oMTFE?=
 =?gb2312?B?eFhXTE1yNDNPcDZDeXBGKzZYMmtnNWlRMFNlQUU1UXhSclhpdUZha0syeFFz?=
 =?gb2312?B?VE1sS0FsUlcwa1lxWkxRWnh4Z2lhZVRrQjhyalk4bklHaHQwRllzNVRHTjUv?=
 =?gb2312?B?NWZjVHREaTVwYlU0TE1kbUZ6MHVBYnFSYmwvQ0kxdXB6WDhtSkNtVGVVN1pL?=
 =?gb2312?B?Qjk5NnRTcXVEaGpuUTVxRHdHOXRtc0tDOFJQYlE5TGh5YUdSODIzM1ZqaEx6?=
 =?gb2312?B?SCtoMWtyNTR6TkRXNEJjMTA1bE1iY2VwSnVsQXNQWkZTN3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?R0w1RXpLRGZjbUxtNjBDYWJlc2p1dlAzdkFPeVQycmRoMkFKRHJkK3pKZnBM?=
 =?gb2312?B?clZJYk9vMitrUllmemdmZFhZY2tpTDBySXV6SjIyak9Ia3VCbk80M210Z0wy?=
 =?gb2312?B?WGlvR0RrVzhIM25hckJ1RThFRU5EK1BKZFAwb0F2dUtlVUovUzZCRm9WcHFq?=
 =?gb2312?B?LzV6QmR2Z1NyQ0lMVjg3SmlRN1NXN0x3UHRiWTk5N1FHNTFRby96bHhUUjVQ?=
 =?gb2312?B?eERoUzRQaUpsS0NDai84eURqYk0rM2Jpa2ZydWVNNG1sckVYdlhDdk5UdWlH?=
 =?gb2312?B?S2Z1TzN6Y21GdGsvK2VyeENzY2k1dHMwNzNVbWNEMkdtdzk1L0crc3k3NU5P?=
 =?gb2312?B?ZlBlREtsQW4vVE54eXAxSGFNU09TRjczdnFxVzZjMDJVLzhxRGlQSll5MHhN?=
 =?gb2312?B?VzMrUDVmSVJrcGZVYm1rMzE1QTdmZExFWHB3ZFVNMExXSEphbWtqREJDRmtI?=
 =?gb2312?B?dVN2NDhBdDB1SGVDcVZCTStXZDg4cm5xZkMxSysxV2FwTDIvQmdpNFdXNGpz?=
 =?gb2312?B?RkQySEtDcFZNUmt1a2hOdTVEc1NPSU9PbGpEVkFPVVR4Uk5FOTVjdHZjUVo2?=
 =?gb2312?B?cEEyOGc5RGNCUWU1dEJYU001WUVYR3dRZGZST3N6RWFQcXZaZS9DeFo4QnRy?=
 =?gb2312?B?ZzRCSFk3UjJidVRiRy9obkQrZWFCV2hYVHZBbHduaDlGdGlVOTZzcEZ0YTZM?=
 =?gb2312?B?aHFtYzlETVNsMWswVEdiSGFtOTl3UGJSM3hpVVNTUkRYWml4ckgzZzBQRjBL?=
 =?gb2312?B?QXhOSVNSZyt0TTFZWkJXOEZxaHZBamhYQTlsL213OW5JUWJnSlFyOTQwQUZm?=
 =?gb2312?B?TlBIWmtYSG1oSmhtZmo0Z0dveTcwY2ozZGVnSVZkSXdsamxuQnlhbmdrSS9U?=
 =?gb2312?B?NU9nZ2ZlNitUNk9EK0d4RHl2M0NhbmRJbkYwcXdFOFM2OExaMXFMek51Zzli?=
 =?gb2312?B?QTEvWHV6QnMvZFJIZmN5dlhOMEpVbDlmMmdnVDBQdmRLU0llWWVJYXF6dE5B?=
 =?gb2312?B?c0Z1dGVPem9QN0wzVnRHTHhHUERqY05wUWVGTUFBT0pOVm9yZ3oxRUNSUUtz?=
 =?gb2312?B?ZjE2aUZkczJ4ZUY0eGgwOVBEQ0tqVG9wQjl5ekU5Rys1SjhVajJrazRnNHkx?=
 =?gb2312?B?c2ZGeTkvK2ZOR2lvOUhZenpzNWlBMUJZdEVyQzRvUDlkZEhEcGwwQTZRYkYz?=
 =?gb2312?B?ZGJKcG50K2tZbGRHcHNzQzJCR2orZlFrWXgrYXhLRkxnbDBTcGdpM2FOVjEw?=
 =?gb2312?B?ZkFZTmRiNm9Fd2QxbXAwTjJ1aDRWa3JhR1J5UmJwdFRQZnlkSUtMTmpncTdz?=
 =?gb2312?B?U2VvMmttMFVmUS9OaDdQbDZXeE1xcDkxQThsZTBoMjV1WFhsR1c2TlVHVlVU?=
 =?gb2312?B?SFU2aEw0eXN1R2hpMzhMd21RY2RyWG9ZeFhDUWh3S1N3NmZxR2JqQWdKRG9O?=
 =?gb2312?B?M1hKQXg1Q3pMTWtZanlKN0pMMEFKR2wvQ2Q1TmFXUE4wWXpFYUlnSGVoU1Nx?=
 =?gb2312?B?RGtsVjVZODY0T3poOGhiZVc4N2g4TjlMT0s0eEFCcU44VnJTVS9WRFloem1I?=
 =?gb2312?B?NDIxUkhzTnJVcktSK3dmNW4xbHBPVUx6cW1GZmJqNW13UVp5eE1PeWdab2d0?=
 =?gb2312?B?d2dmK041MjB2U2kyVms0OVVmRnp6NXZrSUVvVEJSbUVjVHNYRTB4S0tRekhF?=
 =?gb2312?B?a25xSXVKdklVZEFIT1ZkamdSck9BK2EzY0l6T0RvQXNZc2srTDJQTzFwalJT?=
 =?gb2312?B?N3E3d0pFdFJHNWdBc1JPanFUSnhRTmZyeFQ2N0wzSmd1RFhGSDJ5SjVheXRn?=
 =?gb2312?B?TnV2TERvLzBUdEVGSXdmRjU2dWpBYUxHNFR6UlBoLzl2S00zTTlUalBrUnpL?=
 =?gb2312?B?aVlJaG9hYmtaempleS90OEFEYURNNzI4VUpNRDR2YmpkbmtkY2ZmSURyb0xu?=
 =?gb2312?B?OUZqeEcweWtKQXpwNG5ydFNSSmNxTnV3eU8zdlgwdTYzNWVZUWlLeEpISHFt?=
 =?gb2312?B?YXpZa09oNEJtREJvQnRrUXVTMUZCb3haWnRseEtaUUJWdFJOVitsOU5jMDdq?=
 =?gb2312?B?TEVvY21yMGlCRDB5WkgyZXdyKzhwVEhsdjJ3QktoSWdQUDVWejNPNVNKSlEv?=
 =?gb2312?Q?mxees01GHLSFUJyBfuQ/iCPUn?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0401d514-a6b1-41c2-eb48-08dcdd14723d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 03:45:06.5414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfJWFXrZMP1Xd4mLLezueIz2UITgT1JgC8WRCD8sN8QSXvVbd8OWTA2/Vl8u0SZLTBMtAPQrGEfKoIEdThFxhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10684

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyNMTqOdTCOcjVIDk6NDQNCj4gVG86IFNoYXduIEd1byA8c2hhd25ndW8yQHllYWgubmV0
Pg0KPiBDYzogcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtl
cm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgaW14QGxpc3RzLmxpbnV4LmRl
dg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY1IDAvNF0gQWRkIGRiaTIgYW5kIGF0dSBmb3IgaS5N
WDhNIFBDSWUgRVANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBTaGF3biBHdW8gPHNoYXduZ3VvMkB5ZWFoLm5ldD4NCj4gPiBTZW50OiAyMDI0xOo51MI0yNUg
MTc6MzkNCj4gPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBD
Yzogcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5v
cmc7DQo+ID4gc2hhd25ndW9Aa2VybmVsLm9yZzsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsN
Cj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+IGlteEBsaXN0
cy5saW51eC5kZXYNCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvNF0gQWRkIGRiaTIgYW5k
IGF0dSBmb3IgaS5NWDhNIFBDSWUgRVANCj4gPg0KPiA+IE9uIFNhdCwgQXVnIDMxLCAyMDI0IGF0
IDA5OjAyOjM4UE0gKzA4MDAsIFNoYXduIEd1byB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXVnIDEz
LCAyMDI0IGF0IDAzOjQyOjE5UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gPiB2
NSBjaGFuZ2VzOg0KPiA+ID4gPiAtIENvcnJlY3Qgc3ViamVjdCBwcmVmaXguDQo+ID4gPiA+DQo+
ID4gPiA+IHY0IGNoYW5nZXM6DQo+ID4gPiA+IC0gQWRkIEZyYW5rJ3MgcmV2aWV3ZWQgdGFnLCBh
bmQgcmUtZm9ybWF0IHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4NCj4gPiA+ID4gdjMgY2hh
bmdlczoNCj4gPiA+ID4gLSBSZWZpbmUgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbnMuDQo+ID4gPiA+
DQo+ID4gPiA+IHYyIGNoYW5nZXM6DQo+ID4gPiA+IFRoYW5rcyBmb3IgQ29ub3IncyBjb21tZW50
cy4NCj4gPiA+ID4gLSBQbGFjZSB0aGUgbmV3IGFkZGVkIHByb3BlcnRpZXMgYXQgdGhlIGVuZC4N
Cj4gPiA+ID4NCj4gPiA+ID4gSWRlYWxseSwgZGJpMiBhbmQgYXR1IGJhc2UgYWRkcmVzc2VzIHNo
b3VsZCBiZSBmZXRjaGVkIGZyb20gRFQuDQo+ID4gPiA+IEFkZCBkYmkyIGFuZCBhdHUgYmFzZSBh
ZGRyZXNzZXMgZm9yIGkuTVg4TSBQQ0llIEVQIGhlcmUuDQo+ID4gPiA+DQo+ID4gPiA+IFtQQVRD
SCB2NSAxLzRdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgcmVnLW5hbWUgImRiaTIiIGFu
ZCAiYXR1Ig0KPiA+ID4gPiBbUEFUQ0ggdjUgMi80XSBhcm02NDogZHRzOiBpbXg4bXE6IEFkZCBk
YmkyIGFuZCBhdHUgcmVnIGZvcg0KPiA+ID4gPiBpLk1YOE1RIFtQQVRDSCB2NSAzLzRdIGFybTY0
OiBkdHM6IGlteDhtcDogQWRkIGRiaTIgYW5kIGF0dSByZWcNCj4gPiA+ID4gZm9yIGkuTVg4TVAg
W1BBVENIIHY1IDQvNF0gYXJtNjQ6IGR0czogaW14OG1tOiBBZGQgZGJpMiBhbmQgYXR1DQo+ID4g
PiA+IHJlZyBmb3IgaS5NWDhNTQ0KPiA+ID4NCj4gPiA+IEFwcGxpZWQgMyBEVFMgcGF0Y2hlcywg
dGhhbmtzIQ0KPiA+DQo+ID4gSSBoYXZlIHRvIHRha2UgdGhlbSBvdXQgZnJvbSBteSBicmFuY2gg
Zm9yIG5vdy4gIFBpbmcgbWUgd2hlbiBiaW5kaW5ncw0KPiA+IGNoYW5nZSBnZXRzIGFwcGxpZWQu
DQo+IA0KPiBIaSBTaGF3bjoNCj4gVGhlIGR0cyBiaW5kaW5ncyBjaGFuZ2UgaGFkIGJlZW4gbWVy
Z2VkIGJ5IEtyenlzenRvZiBXaWxjenmovXNraS4NCj4gQ2FuIHlvdSBoZWxwIHRvIG1lcmdlIHRo
ZSBvdGhlcnM/DQo+IFRoYW5rcyBpbiBhZHZhbmNlZC4NCj4gDQpEb24ndCBrbm93IHdoeSBjYW4n
dCBzZW5kIHRoZSBlbWFpbCBvdXQgc3VjY2Vzc2Z1bGx5Lg0KUmVtb3ZlIHRoZSB1cmwsIHJlLXNl
bmQgYWdhaW4uDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gQmVzdCBSZWdh
cmRzDQo+IFJpY2hhcmQgWmh1DQo+ID4NCj4gPiBTaGF3bg0KDQo=

