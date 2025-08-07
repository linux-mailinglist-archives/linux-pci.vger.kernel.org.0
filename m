Return-Path: <linux-pci+bounces-33526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FFB1D375
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB317AC9B5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7B226CEB;
	Thu,  7 Aug 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IdVorEXg"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6FF1A8F97;
	Thu,  7 Aug 2025 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754552292; cv=fail; b=ZAhfOK5BvpFkJZY5OHhSvTOlTiGIt/1AgZU2tD9kLSWZCXjYSAPZp3SgIf0ryHh4VCSwYPz8VDGog+YzQL0UzGNvtfRfdQ0RA9ku/AfVSda9eJ5JiGCyX8W/WQnQvwNm96LMKAF/dK7LLT3Quavn3k7v3nDUGZv8CFT77Ph17Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754552292; c=relaxed/simple;
	bh=GsAbo/Wl1cLVmg59XSau/F+KiIg7/k54uOUlULK5e8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+3bExSUPXtYs4zmtSUwTVc3VTfpe1UTBTHyutZSgkioC5AhVzCRkVHor2P9Pyn5lN7rleZppwNAp7lUF3p/Bied+5PEW5nm0drYOQQt5zKESOKbzfCSl9qAFoJsbFDVeoSg04PzVbRUXhyUipFGXVICJiX7GoMjNKlsNv6zAVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IdVorEXg; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROpWifB8B7k0K1iND4VH5QWAVxWuvSQ/wr3yFzV9ir+nrw6wAjmXoSAEN1US1j7Tl4WdzmsO2MzZnIXwjASR12tQcU749EPDAWcm1DwDDWF1yv66rFs2hGixNcaFY4GYpTsUfyF2YlmmDJN3Sra4tji5Tbvl/N/OG2ut/PXCX7X97IhFgeSCo32Cp6NfausZMphaY5tqfs9GTxx/slG4hM22qcEcniy797lKfoLcDgHAhexuxopxXo3pYSuQ0DaCIRTaf5PRCXYF4v4R6PvW84+JX6M+Gz1XvzkmuL5rDvGvefGxTPhfeT/1X47nrMaZ6oLWsBkPVb/4uXfXRBNLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsAbo/Wl1cLVmg59XSau/F+KiIg7/k54uOUlULK5e8g=;
 b=PJeQp0yPMMKplYRptxK+4dRkhHMgD4ABVyR66RwiTYO62KZrWyLQIQyUQOHOUOS9pKNJzVDeTyoWCuURd2Qe2D1JpNS9r0KKdyiZQwCbNoJAQ+YYg9OPFsgfB6TUVcplVxz7gUnVazMWVQUaIVyoiTckjcMn9/1NbCeiUE0Pz0XUMMVAmA/GcJKZDiqKksUZ+K/VoEKIN0DblbEg0kX7R1fMXRsSlmUSjueisfvkjeWa0VDxARKF95hAc+Z7xHxbrlc8BB92hg+IsJNCW7JApN3ejePURxn18HTw9PxLe4Y9y7EZyF2LwlXO/rrTyRt7GXP40TbTY8C4r6Q+d7t00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsAbo/Wl1cLVmg59XSau/F+KiIg7/k54uOUlULK5e8g=;
 b=IdVorEXg3pPo+fGovJbAvmpi2rYJYGKhCrgB5fXtm8ClphRJ6KWLOjCpw0pB58kAPZbDu/WDblDy9UNDW54NsN8GEXTIEsRXw5u7hVIY4bho2TzxRvSW4K1xfF8qfrlBDNGapxOtI3MbVDJ9SPVGlDGRGolDCMi+n8W2iOHwqQEQweMN2nuc+6P81kQ7bjmcOeyHAOBbzaB/Wrwl2ITv1TcMl+O2wuQONkbj8UAzg39xJislJMzp28UMt798IrZB6NJASuGjK3X5BrKsUg3wPRFaYzWEdYNiemkdngrNMeFWKEsbEsUY5qt7BB/9hiwtZibkXhFT+exsVWoROfTYPg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB9PR04MB9402.eurprd04.prod.outlook.com (2603:10a6:10:36a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 07:38:06 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 07:38:06 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Hans Zhang <hans.zhang@cixtech.com>, Frank Li <frank.li@nxp.com>, "Z.Q.
 Hou" <zhiqiang.hou@nxp.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"Jonthan.Cameron@huawei.com" <Jonthan.Cameron@huawei.com>, "lukas@wunner.de"
	<lukas@wunner.de>, "feng.tang@linux.alibaba.com"
	<feng.tang@linux.alibaba.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters
Thread-Topic: [PATCH v1 2/2] PCI: dwc: Fetch dedicated AER/PME interrupters
Thread-Index: AQHcB2pKprxJTiM62Ee14OVUoCoEAbRWyNKAgAABbqA=
Date: Thu, 7 Aug 2025 07:38:06 +0000
Message-ID:
 <AS8PR04MB88331790CE4783BC0856A82A8C2CA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
 <20250807070917.2245463-3-hongxing.zhu@nxp.com>
 <b721ecf5-5da6-4ab1-b352-b7ce19d1b13a@cixtech.com>
In-Reply-To: <b721ecf5-5da6-4ab1-b352-b7ce19d1b13a@cixtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|DB9PR04MB9402:EE_
x-ms-office365-filtering-correlation-id: 001ac48d-c442-4837-3af8-08ddd5855999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|19092799006|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z3ZhbmVtZ01Nd1AyL3ZWcmRUQzFocWx4Q3hUR2VhTC90SHZiTDFpZlF1Mkp0?=
 =?utf-8?B?aERVWWZoRFpXUWNnZzlJdmNyNFVwRGxacG9RaWZ4UmR4WitCU091MU9rZDNI?=
 =?utf-8?B?bk9ZeWRzM3dIWk9VQ3A4QjVFLzE1bmx4MUVhWGhxWGltZFNDUmtQeUhQTk5M?=
 =?utf-8?B?QkJJSWFmZ0UzWDk4SCtrV2ZMU3pkNy9GU2tXTGNkVU5hQUxESDVGV2dtR2ZB?=
 =?utf-8?B?cEt6ejlMRURxdXU5UXVoNzMrOFpKRklvV0xEYWZLTlkzU25mUEFIcXlQWDJT?=
 =?utf-8?B?NWk1elh5Mm10RUlXY0M2SlNzTEpmVlpqamExVGdxQnQxR0lFUnlJTWgzcjl2?=
 =?utf-8?B?cmlyNGpIOXE4TWhnRGlUTjZvK3M1V1VtbHZmcWhleFM4ZFdMUTJ2MFdzT1d5?=
 =?utf-8?B?dDM2Q1drYUdKaEV2MG4yK21uRElSUEdOU1dZSDJENkNYZ1BoU3pMWXBCaFRD?=
 =?utf-8?B?aDd1NkhGSlU0amVlaEh5U3VzYVJ2S3grTjN4Q1MrcW51RGhBdWY2OEFoSHlS?=
 =?utf-8?B?Y3ExUzNVRWw5NVRoWTNvNzNXSE5JZXFQQ2NBWFdYMlNDSU9VaWU2Wkg2U0ZO?=
 =?utf-8?B?K2xMS0pPZEpnQXlaTjQ5bzN1RlZpcDlRL1FJY0VtNzRRUjF0MGxjejdXaHBw?=
 =?utf-8?B?RFUvWUg0N1dvbjBHQ0dVTHZ2Z29PWDlQcVdDL2dGWWdwOVJBSEZUZnlzMEZG?=
 =?utf-8?B?WUZlVmdMWHZDS1Fub0ZLcDE2djRZQzN0dWZSeVhDY3R3dXNrY1pBUkhaWWZ5?=
 =?utf-8?B?bU1KZTFyMDdQOW50NnNzak90a09wQzh4VFBoc2Q5WWlRcjZseXlsMWNMQWc3?=
 =?utf-8?B?V2FkR3JnZ0RweFc3a0hsQzVBSCs2WmdxUnFwUy9seDZCcnRSSDNRalBELzdT?=
 =?utf-8?B?eDBwaWNPOWZZY1RJWlVnYUplOXlhdGhVUDY5Z2Y5aFdJSFdnL04rT0MxanI0?=
 =?utf-8?B?Q3gxRHpCTU1HajBFOUE4dy9SY3pCNVVna3lFOEFkMkxtb1daUnoybzEvUG5X?=
 =?utf-8?B?QU5XdWg0WFYwUmFsWVVFZ2VNbkR4SFVRMGlPUUxxMitJMzVQT3AwTThWZ2Zn?=
 =?utf-8?B?ZncwemxyNFlCNHVmcnNiMnRXZFBUNGRreVMwNUNiamp5YjJPQjZPRzVVeW9H?=
 =?utf-8?B?K0F3VTg2MHMzRFhkZDBFODdtamNvWFFuOEwvUmhJZCtBajMrSWwxZnlCWERZ?=
 =?utf-8?B?azIrZDJPelhWU1ZFZS9DNW0xczVlSnc4QzNjVVMrelJ0NStGTmxGREh5aEQy?=
 =?utf-8?B?SUhmeEllRU9sOTk4OUxPclJPdlJFVElCekZPZVZrL0trY2pCSmIzSm85a3gx?=
 =?utf-8?B?Rk1vQnliaGhhQXIxQ1VsNFI3a1doZFF4OXpFT3ZTUUhxbHpxS0RXTXU0ajNL?=
 =?utf-8?B?VjBXOVJWMDAwdzUxVmRPYVMveExkQm1kMEdhU0lsSWZBRkdwQlVjWGJGbXJH?=
 =?utf-8?B?NnNkbG1FcksyQzZCbEZ2WEVlZE1IQWh1VVo3eUtpVXVhMmp1S0ZBcjkvcW5k?=
 =?utf-8?B?S09xOGlkMFZsWEVRZ2U3ZDFqa2ZFS3lYUlR4dUlvQVFRYVYxV1Q1L0NGd0Fq?=
 =?utf-8?B?eWIxRnlveXdzSGpIc1dzcm1USTVTQW5GbTIxRkpBZU5zZldkS3k1QXl1RDYr?=
 =?utf-8?B?ZFBiYnhPUU5EekNzL0laYzUxb0E3dmFhUnhoSWhVdjhoUWU0Zk1xdnV5elhz?=
 =?utf-8?B?cllQVks0WExFTzRTNkdFRTdFdFZJWmJ4bk5TUkJiSkFJRE54M3hUc2U1akkv?=
 =?utf-8?B?dFVEMXFDYU03Z3RCeVpicXg0MVhWVWhqYnE1eTRjdkU2d1I5NTgwNVZCYlMr?=
 =?utf-8?B?Z3pYTXRRWnJxd0MrTTJibVJJcVBnUnA2NmQ5T2xIUkR4cWtpREswZW9uSHZO?=
 =?utf-8?B?d3hST2ZNOUZxWFM5dkp5bXFBNlBVbHViZTlWVHBmT08vTDA5WUxTVEUycVA5?=
 =?utf-8?B?c2RtYUFjcndwVlo0QVFKdWdpQjZaOWx1QkVPcDhtOERJTDNiVmhmQ2VsMUVn?=
 =?utf-8?Q?BnoCYewmeKGAHewbNAthida1eGkAXc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(19092799006)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzBYc0tOekdYd240b0NrTkowbmdqS1BXblVLNDNFZnJKYzRXTnFzK2JTbXlT?=
 =?utf-8?B?ZkdOZFpnL1dIYTdFTFVLaExFc1p0V2R3am1lcUNmUUw2enFLeUNpcWFCM1hE?=
 =?utf-8?B?Ykh5UHA4ZURnMEJEMStOTzA3SDk3SFQxN0JpRWdzN0tBYjJnUmdWbG4yOExj?=
 =?utf-8?B?OG9OZjA0dWxTNG82L0J2RG5ZVWFWTlFxNjBGb3Y0Ti9vc2l6QnVvdy9IL2x3?=
 =?utf-8?B?Z3MwRjREK0dXcmxCUWxESllRalNSaG5WbHoyQW5nT2VoV0ZDRk9VR1ZQcjV1?=
 =?utf-8?B?dngrZ1BPRWsrUFBMUDdWanBrRHJTNDFxblZpSHp6SnFqb3VjZnh3ZUFpZjRk?=
 =?utf-8?B?T29TOTFYVWlId0REWDdweWdYb1dUcVVoWmtmYlZPL1FIQWx3aERlZ0tlS1ZD?=
 =?utf-8?B?UlBSMzJMblV4cVQ3Y3YzSXZzQUVKcm5KZzRjSzVKK3lYd3dRZitNUjVNd0lQ?=
 =?utf-8?B?YU9vK2dCZVA3L1FnZHBSNW9lRmhJVzlqNnhuWS9lYndMTnBHOXlvZzNMQmc1?=
 =?utf-8?B?b1BHMFFSSnVTWFV0M25SNnlmemx2STIwUUlaMGhRZnprSGZLQ2pyRFpTckp4?=
 =?utf-8?B?SDNnZXhoeEhpc0pDY1VHcXF4ZnphRWZLUWZnVkdSaVNEVEc0ekFrMGNsTHE1?=
 =?utf-8?B?TFZxejNVK2JHV3FWcWdTS1NDcnAraFJSd0dNKy9lYnZWN1VJc3p0TVhUUmd0?=
 =?utf-8?B?UGlsS252SFVJek5XUGpVclVYTWc1c3BPVXl5ZHRkK3ZHSHZpdDg2eTJxY2N2?=
 =?utf-8?B?TkR6OFZXZHpaVGNRVCszZldlNFBlT0xXdkZKTFFHcXpmTGFTMDhDMDFVY25j?=
 =?utf-8?B?R2JmY25hT2pBc1lJMTNFcVA5ZHVBblovejZZUUgveHBHMDZEaHFFNFZ4bktp?=
 =?utf-8?B?cVRydjhPUEIxcU9oK0Q2Q0c5T0NpNnh2cTBGWGVVZzVWaFZHWGYrNzBnYnhh?=
 =?utf-8?B?clNkdk9DcnVGbXN5YTBSaTdFYk9ibEo3RWFjUDQ5TGR5eTlhTDY0UnBkcEJT?=
 =?utf-8?B?d3Z5Sml1WG5KYi9XK2JBN0daNFhQeVozUGQ3SkFtWXQxR3hTMUE5c0JyTWlW?=
 =?utf-8?B?U2lzZFk1bmlUT3Z4L0tEcUIrVThsTDM5azZWSmZSNmZOdnZiaTYzNHU5VzVx?=
 =?utf-8?B?QnBkeGRsM0hFZ3R2ckgvOFFpcUJIVk8rQmtJUmRXSjVJSTBPWXpYMFJhdDZY?=
 =?utf-8?B?N0poK3hDMmFDR1B1L1NVT2FXcW95anZ3aEplM2w3SzhabGlValVIRlpsTGc4?=
 =?utf-8?B?cXdibkxNYnlQY0J3V3ZFQ2FqS2djY0k4eFhLZ1FDeFdGT2tkZXVIclBVNWk2?=
 =?utf-8?B?VjF2cmZKM0VWWm1kRWF2SXdaZnIrb2cvaXpxK1JsWlI0UmZXY1lNRzN5YUVo?=
 =?utf-8?B?bjRIb21BdHdHaC9HNnNmV2hTTmhlalRJTm9ET2tnaXpWTzRPQ1IxS3djOTdF?=
 =?utf-8?B?OVZYUHJjK3F1anBucFp5OXRhSzZQZ3VFMHlLN3RnODZwQmR5RitHaWtFeGFq?=
 =?utf-8?B?b3RoYWZzdHhUTVljYkpkclVxWVN4bDloODM0a2JzOEFVSkU4RjB5Q3JsRmtI?=
 =?utf-8?B?cE5jU1BXaU5WNGx5ZjAvN2VjNEhCMXJpb3loQlpPdjU0RzB2VHBYS043MytX?=
 =?utf-8?B?STRkWlprNnlsZlM1bW1uTGJnQTZyaDFRSmFrUkNidnh2YlFTaEo0eklnR3VS?=
 =?utf-8?B?L0NHWHZ4c21wN1R1NG5KTzIvc0hrWkF4c0VjUmdSaGZBdEhOS0lNWXp0dGYv?=
 =?utf-8?B?ZE5zWG9oalhCWG5MRVpDbitLRzh2NmlIR0FjY2l2bWplN3pqRlM1THo5dDA4?=
 =?utf-8?B?cXBER0xSbUp3NDhySkdaUy9wc1dUenJ1cXI4NDFvY1hiWDFwYkRQR3pkR3dj?=
 =?utf-8?B?NEJWdEtLUFdKQ2VsSGJldm1jY3BOUGUrOGgvRGlsMCtwVjhDeFhtRVBqMkNG?=
 =?utf-8?B?b1hqU1RTM2RHa2tUVklnbjhYY00rZmtpZGt2THd1L2lRTE55YWJGclJjVnRq?=
 =?utf-8?B?b0h0MERHdit1Z1JtbWZGQkxIUWJWYUxzRktBR1pJUVgvTExwSnNNK0xUNDBC?=
 =?utf-8?B?TGkvZ2U3RUZlRkg4SzV2TEJRejJlcS96d0ZDWk1taFEzOGhpTzJmU3lVbkNO?=
 =?utf-8?Q?sub8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ac48d-c442-4837-3af8-08ddd5855999
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 07:38:06.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tP0/L6AdLr1UwYy79hd/FjH3hnLC3s/tBGUe1wdo/nt9tNvMfvD94b9dMSQz75A9jQ/uv1hnuDy+a8fMdCGj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9402

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFpoYW5nIDxoYW5zLnpo
YW5nQGNpeHRlY2guY29tPg0KPiBTZW50OiAyMDI15bm0OOaciDfml6UgMTU6MjENCj4gVG86IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhw
LmNvbT47DQo+IFouUS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2ds
ZS5jb207DQo+IGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tOyBKb250aGFuLkNhbWVyb25A
aHVhd2VpLmNvbTsNCj4gbHVrYXNAd3VubmVyLmRlOyBmZW5nLnRhbmdAbGludXguYWxpYmFiYS5j
b207IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBtYW5pQGtlcm5lbC5vcmc7IGxwaWVyYWxpc2lA
a2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwub3JnDQo+
IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8y
XSBQQ0k6IGR3YzogRmV0Y2ggZGVkaWNhdGVkIEFFUi9QTUUgaW50ZXJydXB0ZXJzDQo+IA0KPiAN
Cj4gDQo+IE9uIDIwMjUvOC83IDE1OjA5LCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBFWFRFUk5B
TCBFTUFJTA0KPiA+DQo+ID4gU29tZSBQQ0kgaG9zdCBicmlkZ2VzIGhhdmUgbGltaXRhdGlvbiB0
aGF0IEFFUi9QTUUgY2FuJ3Qgd29yayBvdmVyIE1TSS4NCj4gPiBWZW5kb3JzIHJvdXRlIHRoZSBB
RVIvUE1FIHZpYSB0aGUgZGVkaWNhdGVkIFNQSSBpbnRlcnJ1cHRlciB3aGljaCBpcw0KPiA+IG9u
bHkgaGFuZGxlZCBieSB0aGUgY29udHJvbGxlciBkcml2ZXIuDQo+ID4NCj4gPiBCZWNhdXNlIHRo
YXQgYWVyIGFuZCBwbWUgaGFkIGJlZW4gZGVmaW5lZCBpbiB0aGUgc25wcyxkdy1wY2llLnlhbWwN
Cj4gPiBkb2N1bWVudC4gRmV0Y2ggdGhlIHZlbmRvciBzcGVjaWZpYyBBRVIvUE1FIGludGVycnVw
dGVycyBpZiB0aGV5IGFyZQ0KPiA+IGRlZmluZWQgaW4gdGhlIGZkdCBmaWxlIGJ5IGdlbmVyaWMg
YnJpZGdlLT5nZXRfc2VydmljZV9pcnFzIGhvb2suDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
aWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gICAuLi4vcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgfCAzMg0KPiArKysrKysrKysr
KysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1ob3N0LmMNCj4gPiBpbmRleCA5MDYyNzdmOWZmYWY3Li45MzkzZGM5OWRmODFmIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0
LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUt
aG9zdC5jDQo+ID4gQEAgLTEzLDExICsxMywxMyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2ly
cWRvbWFpbi5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21zaS5oPg0KPiA+ICAgI2luY2x1ZGUg
PGxpbnV4L29mX2FkZHJlc3MuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KPiA+
ICAgI2luY2x1ZGUgPGxpbnV4L29mX3BjaS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaV9y
ZWdzLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4NCj4g
PiAgICNpbmNsdWRlICIuLi8uLi9wY2kuaCINCj4gPiArI2luY2x1ZGUgIi4uLy4uL3BjaWUvcG9y
dGRydi5oIg0KPiA+ICAgI2luY2x1ZGUgInBjaWUtZGVzaWdud2FyZS5oIg0KPiA+DQo+ID4gICBz
dGF0aWMgc3RydWN0IHBjaV9vcHMgZHdfcGNpZV9vcHM7DQo+ID4gQEAgLTQ2MSw2ICs0NjMsMzUg
QEAgc3RhdGljIGludCBkd19wY2llX2hvc3RfZ2V0X3Jlc291cmNlcyhzdHJ1Y3QNCj4gZHdfcGNp
ZV9ycCAqcHApDQo+ID4gICAgICAgICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiArc3Rh
dGljIGludCBkd19wY2llX2dldF9zZXJ2aWNlX2lycXMoc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAq
YnJpZGdlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCAqaXJx
cywgaW50IG1hc2spIHsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGJyaWRnZS0+
ZGV2LnBhcmVudDsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9m
X25vZGU7DQo+ID4gKyAgICAgICBpbnQgcmV0LCBjb3VudCA9IDA7DQo+ID4gKw0KPiA+ICsgICAg
ICAgaWYgKCFucCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsg
ICAgICAgaWYgKG1hc2sgJiBQQ0lFX1BPUlRfU0VSVklDRV9BRVIpIHsNCj4gPiArICAgICAgICAg
ICAgICAgcmV0ID0gb2ZfaXJxX2dldF9ieW5hbWUobnAsICJhZXIiKTsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKHJldCA+IDApIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpcnFzW1BD
SUVfUE9SVF9TRVJWSUNFX0FFUl9TSElGVF0gPSByZXQ7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgY291bnQrKzsNCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChtYXNrICYgUENJRV9QT1JUX1NFUlZJQ0VfUE1FKSB7DQo+ID4g
KyAgICAgICAgICAgICAgIHJldCA9IG9mX2lycV9nZXRfYnluYW1lKG5wLCAicG1lIik7DQo+ID4g
KyAgICAgICAgICAgICAgIGlmIChyZXQgPiAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaXJxc1tQQ0lFX1BPUlRfU0VSVklDRV9QTUVfU0hJRlRdID0gcmV0Ow0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGNvdW50Kys7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArICAg
ICAgIH0NCj4gPiArDQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gQXMgZmFyIGFzIEkga25vdywg
c29tZSBTb0NzIGRpcmVjdGx5IHVzZSB0aGUgbWlzYyBTUEkgaW50ZXJydXB0IGRlcml2ZWQgZnJv
bQ0KPiBTeW5vcHN5cyBQQ0llIElQLiBUaGlzIGluY2x1ZGVzIFBNRSwgQUVSIGFuZCBvdGhlciBp
bnRlcnJ1cHRzLiBTbyBoZXJlLCBjYW4NCj4gd2UgYXNzaWduIHRoZSBpbnRlcnJ1cHQgbnVtYmVy
IG91cnNlbHZlcz8NCj4NCltSaWNoYXJkIFpodV0gWWVzLCB0aGV5IGNhbiBiZSBhc3NpZ25lZCBi
eSB2ZW5kb3IgdGhlbXNlbHZlcy4gVGhlDQogZGlmZmVyZW50IFBNRSwgQUVSIG9yIG90aGVyIGlu
dGVycnVwdHMgY2FuIGJlIGRlZmluZWQgaW4gdGhlIGNoaXANCiBzcGVjaWZpYyBkdHMgZmlsZXMu
DQo+IEFsc28sIHdoZXRoZXIgdG8gdHJpZ2dlciB0aGUgQUVSL1BNRSBpbnRlcnJ1cHQgaW4gYSBz
aW1pbGFyIHdheS4NCj4gKGdlbmVyaWNfaGFuZGxlX2RvbWFpbl9pcnEpDQpbUmljaGFyZCBaaHVd
IFRoaXMgcGF0Y2gtc2V0IGlzIGp1c3QgZmV0Y2ggdGhlIGRlZGljYXRlZCBBRVIvUE1FDQppbnRl
cnJ1cHQgZm9yIHBvcnRkcnYgaW4gbm9uZSBNU0kvTVNJLXgvSU5UeCBtb2RlLiBUaGUgdHJpZ2dl
ciBvZg0KIEFFUi9QTUUgd291bGQgYmUgaGFuZGxlZCBpbiBwb3J0ZHJ2Lg0KPiBCZWNhdXNlIHRo
ZXJlIG1heSBiZSBhIG1pc2MgU1BJIGludGVycnVwdCB0aGF0IHJlcXVpcmVzIGEgY2xlYXIgcmVs
YXRlZCBzdGF0ZSwNCj4gd2hhdCBpcyByZWZlcnJlZCB0byBoZXJlIGlzIG5vdCB0aGUgQUVSL1BN
RSBzdGF0ZS4NCltSaWNoYXJkIFpodV1Ib3cgYWJvdXQgdG8gZG8gdGhlIG90aGVyIG1pc2MgU1BJ
IGludGVycnVwdHMgcmVsYXRlZCBzdGF0ZQ0KIGNsZWFyIGluIHZlbmRvciBsb2NhbCBkcml2ZXI/
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gSGFu
cw0KPiANCj4gDQo+ID4gKyAgICAgICByZXR1cm4gY291bnQ7DQo+ID4gK30NCj4gPiArDQo+ID4g
ICBpbnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQ0KPiA+ICAgew0K
PiA+ICAgICAgICAgIHN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fcHAocHAp
OyBAQCAtNDc2LDYNCj4gPiArNTA3LDcgQEAgaW50IGR3X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBk
d19wY2llX3JwICpwcCkNCj4gPiAgICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+
DQo+ID4gICAgICAgICAgcHAtPmJyaWRnZSA9IGJyaWRnZTsNCj4gPiArICAgICAgIHBwLT5icmlk
Z2UtPmdldF9zZXJ2aWNlX2lycXMgPSBkd19wY2llX2dldF9zZXJ2aWNlX2lycXM7DQo+ID4NCj4g
PiAgICAgICAgICByZXQgPSBkd19wY2llX2hvc3RfZ2V0X3Jlc291cmNlcyhwcCk7DQo+ID4gICAg
ICAgICAgaWYgKHJldCkNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+ID4NCg==

