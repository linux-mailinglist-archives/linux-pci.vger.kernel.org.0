Return-Path: <linux-pci+bounces-15184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF0D9ADDFF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FDE282CF4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6961AB508;
	Thu, 24 Oct 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxVZHL4m"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E31AAE3F;
	Thu, 24 Oct 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755786; cv=fail; b=qK1Ki4P97A0AeObURmtqX2AJ8+N79C5wd+l7fjQDoMl9d8hF0+BoCYR83VLO2lsVmldsueJIDkXgQoIUUGl1NqwMsBwdYyqeiEyWk9NTAzLSoh1RO9wk/Fs/5qtVi+wWwNdMiUNmIr1re4hLuhPJBatH4Vo4yVqo2r8F80uzeRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755786; c=relaxed/simple;
	bh=OFHVZrAfF4MUaXp9cIWX9b1xp5XDvtmKkcbahfMscDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uGmme7QtzGUiEq7Q5CwdgAaxCOx3YFuV+/XACv6QdcHpCdQajN1fBCWSkfMTGiSEptJ9S1pXhCgEb3jzDYBt7rhSAHUSK40v99hE682OBethaY2T5YMB7czO5SR6tD9JNQn9YBNinDvhOw7JN2P2nPAewoneLOAXXZEU5GfI4Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxVZHL4m; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abi4HUK/d9bZ6YT1RFEsUMwYmuKYuetie4TA3IfGWrZImQSSEFnwLFKiRJMThzzx4Ph1LbjmLnPFUmQIpVacYKQIhh8r0g1+fJpLaEaNMiT3G6ZYOaszVVRKoTyDMTl09Q3qaL91X+CLerDFMUalHV0bj7vTWz5+nv75JpfKfbwWorSKSb5X/EuY/gp7mfKl8+qk2IfV2niiC9T4oJkz476Q7UUwyVzbZXoPcrADcgCC2Glg8pCEUTFLXK3XXS1hWp2MprIq8TTmyte8g5JuEKxehyAlMDGP9HXb3kX+shdfp4ka9NvCuQZyqe4zH0LueweWeY+eUe/UbMvrOyfWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFHVZrAfF4MUaXp9cIWX9b1xp5XDvtmKkcbahfMscDg=;
 b=vEpkSS7N5bt1Z4vGkkQyh4gJVE0YRe19sMi4KchO6tcPt6+qbEj16jNWeej6pzh0AeWFEciSyahQ9mPEm82q2i47/HAwpKCqIxnP4selnG62OMVtaJBIF5kHP/VB2/Obv5W8d5nPPWPyZC2vDI095fg9CIRezTGKqxIWkGXTV8GXGW5UHYPMPuG1Kc9aD8OkYTVMJach6FzPTBwfKv8usfPSivdUx+o1Btzmk+yXucRDMOrJba0CUjD4xfZ4DmFfdFZZqGwceOOK3lfDgG6+8rYBWxdCLbgfUfjK22zxSQSzlvBv365Kv6wL4Q8BDp3ZpF4ZPTRggyrPUXq1a346BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFHVZrAfF4MUaXp9cIWX9b1xp5XDvtmKkcbahfMscDg=;
 b=UxVZHL4mpa5GK+LFrHZa7IO+CHjyAcxQrBEIqp1yyH3HV5YrRG8TzuFHFdxJ306PaQBfndcDR4nN57wOC0rWndbDk4WbRmv8CqUp4shQaj4Sk9cZezMkfvrq6O6junT3wQ6MtfqGPeWbh0Wt9mwgBXLBQemo+eU4OqI1RaXnwf54oVk8UiYJyR5CARAMwFgRAdsLWAFL4G5r4+5yzjqijjGE2fQ7WLV1ghIsRFTVBVo0Lyuxsde71otVD+YzhHlfGe3izdeWNOqCOXNXmoeVpn9O6Yfj+Ff4Klo9Bk79Czs2JzzdY4fUTN0o2fRVFL/KW4OvN8mZ9pC7EPKvJwCAzQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 07:42:57 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 07:42:56 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, Frank
 Li <frank.li@nxp.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Topic: [PATCH v4 2/9] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Index: AQHbHuBCGH4wCkW6dUWOyoTGMcyIAbKTBgKAgAIXEEA=
Date: Thu, 24 Oct 2024 07:42:55 +0000
Message-ID:
 <AS8PR04MB8676112C7752009DE7833BE68C4E2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-3-git-send-email-hongxing.zhu@nxp.com>
 <20241022164603.gndz4vgbm2sgwtfj@thinkpad>
In-Reply-To: <20241022164603.gndz4vgbm2sgwtfj@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VE1PR04MB7342:EE_
x-ms-office365-filtering-correlation-id: c4f84b9c-fe24-4fae-6126-08dcf3ff797c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QUJqamg3bVJBMUdpcWh1ZEE2QWE2M3dya0I0SlpDWmxacnQ4RzF2QXBqempZ?=
 =?utf-8?B?SE5aaGFYZStRQjloNDFHanBubDVpWkdaaVhCOWVhY2Mzb2taZWp5VkFDQXc2?=
 =?utf-8?B?dnFXS3NCb0t6ZlRhQzVJK2Y2WHpJdGF2R0dsWVFoVXMxSHphRXZ1N3A3cTBO?=
 =?utf-8?B?WlZES29qekg1YnF5cDlPYkZodTBYMzBnN0t5K3FkNDFYVUFPeGhRcHdFSDll?=
 =?utf-8?B?YjR2ZkNyb0o3M3NoS25SdE9scjFEMlFpc1ZOa2tKZWlWb3RSTVQ3TUo5elo5?=
 =?utf-8?B?QVl3aFBhUE9TYXVFVVhzWDQzcXJHK0pnaElCdVRNWE5mdW96dVRWbWNXdlRH?=
 =?utf-8?B?dTQvNG5KNVF5VDBqcCtBU3RLSTlLdXZ1N3NzbWFrTTRleEx3cUQyY2tuNFBh?=
 =?utf-8?B?THpBV1pkMTRTZXYzaDlKL0s5anl6aFlhM1BKc3hRRGlrYktFNDRKQ3RIQ01N?=
 =?utf-8?B?MVlQRitFblFoY0NhVSt2K2wyUkRjUUE4QXNrNzFBd2Z0SFFsSVBVejFMUFFv?=
 =?utf-8?B?M3diVlVXemIwN1hVSWtFbjI1cGFBelFBU2RMc3hCRlFDUDFHdmhrMDNjTmR2?=
 =?utf-8?B?NHRNQndHYUdPMDk5UnhMMjg3dlI1emdtWlJZd05kTldIcEFIVVFXOEcrWjRG?=
 =?utf-8?B?ekNkQkZpNWEyTFFmVDdtSUNqcExqY3dFaERyOHVCazY1SmkxZDcyU05rWThx?=
 =?utf-8?B?ZStjaXp5VnlnVU9OQ3ZFaytnVis2d01nZTgwaW9zU1pkTFdxVDVqNXJEajg0?=
 =?utf-8?B?UVNtRFFmRXN3OHg5N0QybmdqRGxFMGxoSXJzQllhcWZoUEZVU09QSmN3c0ZF?=
 =?utf-8?B?QU96YzlOV2ZzMzZ4bmR1MmFBRTNpWE5aTHVocXovaGZKRWF6REQvZmFFcjdr?=
 =?utf-8?B?Y0MxZXU4dmFaWHlVQ0VUZWVJbjN1bmpoMTAwTVk3WGt0QkY2clNhRlkxSVJY?=
 =?utf-8?B?M1o1VHE5RjFjWEZ5R1dHVGxHemR1OTdPajJVUkQvblpDTlZKWFN5VS9FdU1u?=
 =?utf-8?B?OUI4d2YxK21BV3FBNHB6b29aV2w3WWZ1YXN3WkY3M2llUjY5NURFbmlSMkVK?=
 =?utf-8?B?djYxTVlhV0dDSnhIdWxTWnB5L1REVmE1VjRqcnVWY2tmOXdNdjh3emZkNUxh?=
 =?utf-8?B?VDVZM00rZDlnOHRHY3I5L2ZqbGt4TG9STjFLVS9kUGc1Qzd3dFpJc0QxYkNF?=
 =?utf-8?B?SGw3NzhtQ3czYkVwcW5WTURrWGJId1poL3IvMUU5a1djdzdjbURFOEEybzRu?=
 =?utf-8?B?ajk5cjJZbFNlTWcyaGpvQTl6UmpBaG44ZVlLN1V3eWVPT0VkNzJobDJZMVZh?=
 =?utf-8?B?cDRWdlVMTnFqRmJEMnZUQzFiQnUyUW1LZzhnR2NEajNkMWVsdzBNWDlUZEVu?=
 =?utf-8?B?T3dBVWI2aE1KbG9rSDV3UmpvVm9xNWNsZXkxQlc3L1p6ai9mVkl4OGh4emxu?=
 =?utf-8?B?UncrTy9kSzhTdlhYV200SUhIbGxnYkltdUVjdXc0OEhMdlNhQWFVUU9SWXMr?=
 =?utf-8?B?cmJRN2VXNFFtbUI5RFNCU2g0c0svOHQ1UUhSekF0RmUxL3d6L0tjcU5vb3Y2?=
 =?utf-8?B?Y2hnbUpkbStjaDE1TzJ5WThTdTlLU3ZIbkU0RFFkZHlUL1QwMm9udk5tTlMx?=
 =?utf-8?B?RnhldSs4Y3puNmVxSTJtQ2hJZ1d5MlV4Q21YK01lTUpzYlNIY3pFN3B1ZEZB?=
 =?utf-8?B?c1gzd2hYUElRU1NpaHFKbm1ZL0VKdFE3ZzdzRkdqeU44Y29GQVJHeWV4UEVs?=
 =?utf-8?B?RXRwazlZSmV6eVNUcDdaTkpZSkhYOENuOEtZc3VOak1Sd2M2OWFzK1EyUVN6?=
 =?utf-8?Q?u7GFrOKoAVV23aoUT5gmg2/5J99B+q4RBZlH0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzB6QUtEaUJmMFVoaEZGU0phdWMreXFWaUhZTy9uK2xFNXpMUitEWlUrR1Zo?=
 =?utf-8?B?N0NWNHY5cWV0TFZCdUI5MkptQy9DcjlSbjZ1UTl4RXNPcTI4aFdQQlBwUmF6?=
 =?utf-8?B?cnM0ejBnVGNMd2xKVmdjak84SUhnMlBIc3AweXN5b3J2eExSQVUwNXdwcTFt?=
 =?utf-8?B?S092VnZOdXdzZktVUzk1WDV5UVdGeVdwR0krY0cxTE0zUmdtcXQ3WTNVREVC?=
 =?utf-8?B?dXRrMFJ1WWtyL3hyMVAxRkdmcWw1Y0RlUldWOGY4bjI4NWlDYmVjZndHUDg0?=
 =?utf-8?B?M055M1JMNTFlUGJPV21JQnhtVTF6Z0xOZ1h6a3J3VmIzWW9Yb3lvQ1djM1hx?=
 =?utf-8?B?cUN0UDNtU1ZoMk5VUVllc1ZWMXUxUmF5eFZvaUh0cE5ZRHM4WkNTNlp5U2tW?=
 =?utf-8?B?NVcyd1kxOVdROXdSWDgyRllUWWQ3K0ZRa2hCclFsMFZUa0MzV2svdW5ITXMy?=
 =?utf-8?B?TkNiQU5mUU5CYlpCUys3UVBaSXFoT2JHUUJ3WFFnOXEyZzcyb2NsL0JraFIw?=
 =?utf-8?B?TmZGUTd3MGJSZFB2ajR5cXVnUHBBWnpyTVgvSWxjT0ZFWGdEcjBXSEMzMXRa?=
 =?utf-8?B?aXlSNXp2U3pQQk5lVURtNm9HY2twYjUxRi9yd1B0OXpteWF6RHl2cWdWcFcw?=
 =?utf-8?B?aHE0VWxuM2lLNlBMMTVxM0hhbVhGZ0RRRTRCTExyOThndWpsc1l3UVg4K0k4?=
 =?utf-8?B?TkFJL2toa3k0Z1RQMUVmaHBKeUNMeTJnSlV0ZHVOVU1TanlIckNWcTJleGI0?=
 =?utf-8?B?ZUdoM1NlR1VCS3dTNmt5NGJGZnRMbmRSUER4NlhGVzRjZGxYaGtYS1BGWW8y?=
 =?utf-8?B?dzFpcG9DOGN3bkMvY2tWeVpYWUpEc1orOXozNHJPNUNuSjIzSjJGb1l0RUdL?=
 =?utf-8?B?cW5CQy9wZW94OUdNS1VnbDZCeGRoMXdTVFZTWDFQK1Y1S1VsNSt2R1VVcjIx?=
 =?utf-8?B?ZzJmdUppVVdMNDhXdnBjNElDOGFGbVc4UnUzVVhETFI1aG4rcXFURW5LOTBM?=
 =?utf-8?B?a3ZqdGJzV3FQd1BDeTVsT0M2QWg5bEcyQVJhWWZVWUVIQ3l2N0h0N0s3YzBJ?=
 =?utf-8?B?eHJpZkhmcFRSajNYVk5Ca0NHTVg5UWs0T1RncW1wQTJLQWU3cU5aY25telVV?=
 =?utf-8?B?V1ZKd29FSzEwU1hSYzFCV1lmaWJLenlzcEN1Vkl3a0tSem1hTDIvTHdZbFBP?=
 =?utf-8?B?Y3RVdGY5NUlnTEhJc0dUTE1EcVNSZjQ4OGxoVmc2aG1TeERXeWtMVEtLZnJP?=
 =?utf-8?B?bUozM2xSbDNKMlZkZjk5ZngrZ1psWEhTS2hCTXR1aURoa3VtTVl5Z2F2SFNC?=
 =?utf-8?B?bzlWMm1FVU9NVHJadXFxWHRHTTg5VitIS0xjOTF3SUVNbkxER2dkb0ZvWG9q?=
 =?utf-8?B?TzVJZ1ZMQWk1cDRLYlhrNGdWZWt0TjlJUU1rTDJLUjRhMG50MVhHNDhVU2xK?=
 =?utf-8?B?UUk4YUIrUkhndlZ1NkxtNEdsZ0RBQVNGb2R0Sm1XSEZ1bmZGSHVIYnZlNktv?=
 =?utf-8?B?VjdJRzd2U0tBRkhXM0dKcm5EdVF4MWJsdVE3MjlzbDJIQjA3UnlWT0dwOFNU?=
 =?utf-8?B?bWlrS1F6VjhkSDRGOHRyNHZ5QnlYNC9MTG9Sd3d3L1Uza2syV3oyQkVxbDRW?=
 =?utf-8?B?T2pQNHNPdER4K1h3SkNYeDJnT1dSZzdYdGNtYllyR3NuR3pwMEpaSjRBbGNj?=
 =?utf-8?B?dCt6MzhYalo0T0hKTUw2QnhUVGR6Z3FQSjgvOWxFVkhEd1AwUUhvdlhWNHJX?=
 =?utf-8?B?Ry9DaDZmb3ZnTjNUQVpQS1Nid08zZjhYM2I3OVZHcms2NFYraDk5WWxkQXBO?=
 =?utf-8?B?UjBiU3hwL1doMStWK1lNMVpLVTdhU3JHVEFSVzJuZVZJNnNQbGovYlpoVW1a?=
 =?utf-8?B?aDV0bDV4Z2xNV0Q4NWUrRkFXd3FXbFJoelFlaktCNE4wMEYwNE84OE1uZldq?=
 =?utf-8?B?M3VkYXB5cnBXTEdzVlVuN2VpTElDcmU3cXZrM0wvRUxjOWJ1R0RTeGRmbk01?=
 =?utf-8?B?eUdKZTlPelp4c1cySnFiRlBZclRnUjlJMnA1cU1kcm5uZ00wcm9xZS9HRmJW?=
 =?utf-8?B?RUh1U1F0S0R0MVZRSVdMUzdYalIxVkV6YzlyTkVqaW1QWDFUK1FsWnpWMG9Q?=
 =?utf-8?Q?cscn7o+li30G5gUAA4QM4Bt/d?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f84b9c-fe24-4fae-6126-08dcf3ff797c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 07:42:55.9845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvPYjTHqrpf5yeovThxLXp30lfKuIzAkP9uCADkAPlSmO/NZCJuweE2A97cHYtwe+hIhno2eCCoJvQak8a+fag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjTlubQx
MOaciDIz5pelIDA6NDYNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQo+IENjOiBrd0BsaW51eC5jb207IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgZmVz
dGV2YW1AZ21haWwuY29tOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAyLzldIFBDSTogaW14NjogQWRkIHJlZiBjbG9jayBmb3IgaS5NWDk1IFBD
SWUNCj4gDQo+IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDA0OjMzOjI2UE0gKzA4MDAsIFJpY2hh
cmQgWmh1IHdyb3RlOg0KPiA+IEFkZCAicmVmIiBjbG9jayB0byBlbmFibGUgcmVmZXJlbmNlIGNs
b2NrLg0KPiA+DQo+ID4gSWYgdXNlIGV4dGVybmFsIGNsb2NrLCByZWYgY2xvY2sgc2hvdWxkIHBv
aW50IHRvIGV4dGVybmFsIHJlZmVyZW5jZS4NCj4gPg0KPiA+IElmIHVzZSBpbnRlcm5hbCBjbG9j
aywgQ1JFRl9FTiBpbiBMQVNUX1RPX1JFRyBjb250cm9scyByZWZlcmVuY2UNCj4gPiBvdXRwdXQs
IHdoaWNoIGltcGxlbWVudCBpbiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDk1LWJsay1jdGwuYy4N
Cj4gPg0KPiANCj4gU28gdGhpcyBtZWFucyB0aGUgZHJpdmVyIHdvbid0IHdvcmsgd2l0aCBvbGQg
ZGV2aWNldHJlZXMuIEFtIEkgcmlnaHQ/IFRoZW4NCj4geW91IGFyZSBicmVha2luZyB0aGUgRFQg
Y29tcGF0aWJpbGl0eS4NCj4gDQo+IFlvdSBzaG91bGQgbWFrZSB0aGUgY2xvY2sgb3B0aW9uYWwg
aW4gdGhlIGRyaXZlci4NCkFueXdheSwgb2xkIERUQnMgY2FuJ3Qgd29yayBldmVuIHByb2JlIGlz
IGNvbXBsZXRlIHN1Y2Nlc3NmdWxseS4gU2luY2UgdGhpcw0KIGJpdCB3b3VsZCBiZSBnYXRlZCBv
ZmYgYnkgcmVsZWFzZWQgYm9vdCBmaXJtd2FyZS4NCg0KaS5NWDk1IGlzIGEgcHJldHR5IG5ldyBj
aGlwLCBpdCdzIG15IGZhdWx0IHRoYXQgSSBkaWRuJ3QgZmlndXJlIG91dCB0aGlzIGJpdA0KY2Fu
IGdhdGUgdGhlIGNsb2NrIG91dCB3aGVuIGludGVybmFsIFBMTCBpcyB1c2VkIGFzIHJlZmVyZW5j
ZSBjbG9jayBpbiB0aGUNCmluaXRpYWwgaS5NWDk1IFBDSWUgc3VwcG9ydCB1cHN0cmVhbS4NCiAN
ClNvLCB0aGVyZSBpcyBubyBkaWZmZXJlbnQgcmVzdWx0cyB3aGF0ZXZlciB0aGlzIGNvbW1pdCBp
cyBhcHBsaWVkIG9yIG5vdCwgd2hlbg0Kb2xkIERUQnMgYXJlIHVzZWQuDQogDQpIb3cgYWJvdXQg
anVzdCBrZWVwIHRoaXMgY29tbWl0Pw0KU2luY2UgdGhlIHJlZiBjbG9jayBpcyBub3Qgb3B0aW9u
YWwgZm9yIGkuTVg5NSBQQ0llIGZyb20gSFcgdmlldyBhY3R1YWxseS4NCg0KQXQgZW5kLCB0aGUg
Y29tbWl0IG9mIHRoaXMgcGF0Y2ggaXMgdXBkYXRlZCBhcyBiZWxvdy4NCiINClBDSTogaW14Njog
QWRkIHJlZiBjbG9jayBzdXBwb3J0IGZvciBpLk1YOTUgUENJZQ0KIA0KQWRkICJyZWYiIGNsb2Nr
IHRvIGVuYWJsZSB0aGUgUENJZSByZWZlcmVuY2UgY2xvY2sgb24gaS5NWDk1LCBkZXNwaXRlIGJy
ZWFraW5nDQpEVCBjb21wYXRpYmlsaXR5LiBUaGlzIGNoYW5nZSBhZGRyZXNzZXMgaXNzdWVzIHdp
dGggb2xkZXIgRFRCcywgd2hpY2ggd291bGQgbm90IA0Kd29yayBldmVuIGlmIHByb2Jpbmcgd2Fz
IHN1Y2Nlc3NmdWwsIGFzIHRoZSByZWZlcmVuY2UgY2xvY2sgYml0IGlzIGdhdGVkIG9mZiBieSAN
CnRoZSBwcm9kdWN0aW9uIGJvb3QgZmlybXdhcmUuDQogDQpGb3Igc3lzdGVtcyB1c2luZyBhbiBl
eHRlcm5hbCBjbG9jaywgdGhlIHJlZiBjbG9jayBzaG91bGQgcG9pbnQgdG8gdGhlIGV4dGVybmFs
IA0KcmVmZXJlbmNlLiBGb3Igc3lzdGVtcyB1c2luZyB0aGUgaW50ZXJuYWwgY2xvY2ssIHRoZSBD
UkVGX0VOIGJpdCBpbiBMQVNUX1RPX1JFRyANCndpbGwgY29udHJvbCB0aGUgcmVmZXJlbmNlIG91
dHB1dCwgd2hpY2ggaXMgaW1wbGVtZW50ZWQgaW4gdGhlIA0KZHJpdmVycy9jbGsvaW14L2Nsay1p
bXg5NS1ibGstY3RsLmMgZHJpdmVyLg0KIg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiAN
Cj4gLSBNYW5pDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA1
ICsrKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+
IGluZGV4IDgwOGQxZjEwNTQxNy4uNTJhOGIyZGM4MjhhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTE0ODAsNiArMTQ4MCw3IEBAIHN0YXRp
YyBjb25zdCBjaGFyICogY29uc3QgaW14OG1tX2Nsa3NbXSA9DQo+ID4geyJwY2llX2J1cyIsICJw
Y2llIiwgInBjaWVfYXV4In07ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0DQo+ID4gaW14OG1x
X2Nsa3NbXSA9IHsicGNpZV9idXMiLCAicGNpZSIsICJwY2llX3BoeSIsICJwY2llX2F1eCJ9OyAg
c3RhdGljDQo+ID4gY29uc3QgY2hhciAqIGNvbnN0IGlteDZzeF9jbGtzW10gPSB7InBjaWVfYnVz
IiwgInBjaWUiLCAicGNpZV9waHkiLA0KPiA+ICJwY2llX2luYm91bmRfYXhpIn07ICBzdGF0aWMg
Y29uc3QgY2hhciAqIGNvbnN0IGlteDhxX2Nsa3NbXSA9DQo+ID4geyJtc3RyIiwgInNsdiIsICJk
YmkifTsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg5NV9jbGtzW10gPSB7InBj
aWVfYnVzIiwgInBjaWUiLA0KPiA+ICsicGNpZV9waHkiLCAicGNpZV9hdXgiLCAicmVmIn07DQo+
ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9
IHsNCj4gPiAgCVtJTVg2UV0gPSB7DQo+ID4gQEAgLTE1OTMsOCArMTU5NCw4IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaW14X3BjaWVfZHJ2ZGF0YSBkcnZkYXRhW10gPSB7DQo+ID4gIAlbSU1YOTVd
ID0gew0KPiA+ICAJCS52YXJpYW50ID0gSU1YOTUsDQo+ID4gIAkJLmZsYWdzID0gSU1YX1BDSUVf
RkxBR19IQVNfU0VSREVTLA0KPiA+IC0JCS5jbGtfbmFtZXMgPSBpbXg4bXFfY2xrcywNCj4gPiAt
CQkuY2xrc19jbnQgPSBBUlJBWV9TSVpFKGlteDhtcV9jbGtzKSwNCj4gPiArCQkuY2xrX25hbWVz
ID0gaW14OTVfY2xrcywNCj4gPiArCQkuY2xrc19jbnQgPSBBUlJBWV9TSVpFKGlteDk1X2Nsa3Mp
LA0KPiA+ICAJCS5sdHNzbV9vZmYgPSBJTVg5NV9QRTBfR0VOX0NUUkxfMywNCj4gPiAgCQkubHRz
c21fbWFzayA9IElNWDk1X1BDSUVfTFRTU01fRU4sDQo+ID4gIAkJLm1vZGVfb2ZmWzBdICA9IElN
WDk1X1BFMF9HRU5fQ1RSTF8xLA0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+ID4NCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

