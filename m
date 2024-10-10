Return-Path: <linux-pci+bounces-14117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D7997A50
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550181F23E6E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA7B33CD2;
	Thu, 10 Oct 2024 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ba0P8D/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7D314293;
	Thu, 10 Oct 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525646; cv=fail; b=pGEjRzPZhbw9ldy0p/AqvhSz8yT6prjynXh9pw5ua959FYxRe3LSiNK+nTHEHhvdAzEw8M3sZWDxGqDJzDHUHy33HK84QOLAxt63f7O+CFeWfBMpGvrMkIRKeGmoWvu6yAEu5I8S5eVJNtwk0x45czmQfeFvjIwz06qut2HQUOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525646; c=relaxed/simple;
	bh=quU50nzl/3oRR9cHEz3DBD8RjtuNMKLeVaPEpF7iNNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ed2FZ73dAJo4CV4mPhLanZDXCFHF9mDdqfHyAGSFXcA1jiRwSHKvZIE/yUYUh4RLXSjwfXTzK8oXl0YnWNm8aVgopADj5Wq/5aqXAcRaZ184ZQeZBJgq9QT0Uwc8c6ZYqQQDAo4CcGtdnLkCfX4Dw6PRKLVlos/VgoWn5A4E29s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ba0P8D/h; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpcbPVbfVHt3LQk7shoyWeu9VyMinymfk3sEWJzMwGEwxzGs4xptNBaIsXOBD0K6wsaD8JVNOcazphOUAZvKO7osMC+6zTncZEory9uqGPrlJ6Q43fE7Xzics84UTUO9TjMxEvVDmPYxuFAYynztcV6nKMMd+sJm/J3ZjX0VMIClm1mgxMhaC/B5dusiBBLilcLbl9wP5147SCE5CodZhMTG26TosOk8F8uhmVt4Oc6iElAsGGMzG3qE5y0kPRNaDOwDSooRPMNVEZ59aUXddCwGYrRAY31lHWs7mVhKyFrjWp4SYmb3T7SJ/Ob6CvNlYVOJsVC4wTsR/SrCT9yRyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quU50nzl/3oRR9cHEz3DBD8RjtuNMKLeVaPEpF7iNNo=;
 b=oxE0bbMP7XAP3qh8f7ckkbKy5506o2VSctBSx9EmogFRdYYTkTJrgKuhFzuuyAxmKdYNP3YUSmC6zTUrYCeo/2aSJGHF9zOB014FlqBOgKPGtzujOr9JxthLLjkm2ZBH6wkSCPXCfh9rz+9kEwPrsL+9pxgkmAXoDbslm1Mmnpuf7YTMjtyWoPFJDm9dw8ZKgyH8h16XuAlXHz7K3mmuy0gUlaf3dhB43NPg9dnUvb526KkFRmUQ0sYhPxqReE+vnaaOWCJu2zkt+dJHBTdOnUFDfULdodbzMfkm3oni2TgUD9sP7Sfdpmyu4I9f6LBOI8yuWzyqwORURV+jh0223g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quU50nzl/3oRR9cHEz3DBD8RjtuNMKLeVaPEpF7iNNo=;
 b=ba0P8D/hxT2e3CzHdKAQMvhnEWeEh0Ui/fCAL9wmC1RkA+ew/oq0stbRN9SL+TDs854tb/ZJNE3Q62zstGc56CXB3UC/0a1Oaxk8VI4FapAn5b4DPj1HaYggfU37xoVR/UfIlIm/1KtmoPwuSFpvAmwwiq0EJ/KPOSxJIf375HeyO541hjvcwvICesZg7eTSUUj1RIQjHo0mstdo/aaWMTXb6E78ypvSW2A5gwfxa6TIufmiQRnVuloWDB7WuDDrUi75VRTK7uAm+PhUjyx3zo0m7ScsHNPxx8dC8a7CKox2He721aNtq4IMF6zbd5+VzPJyD99riZKzP2Y6XoipXw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 02:00:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 02:00:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC support
Thread-Topic: [PATCH net-next 02/11] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbGjLp/l9Es9i+jUim/i4c8s01WLJ+nI6AgACa32A=
Date: Thu, 10 Oct 2024 02:00:41 +0000
Message-ID:
 <PAXPR04MB8510894EE369CF8520E4FC8888782@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-3-wei.fang@nxp.com>
 <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwavhfKthzaOR2R9@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8946:EE_
x-ms-office365-filtering-correlation-id: 55264128-f87a-4212-98e9-08dce8cf5834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?azZlU1NFY2J5OHM5MXd2TlhaN1VjVnl3YzBuemdUekV2dDhDUGN5bm9LQlZi?=
 =?gb2312?B?YW9hMk9yaGx6SG9DN0pIQUk2K2dVamhXRUhQMUs2ekJ1ODU4dXJlN2FTeGxE?=
 =?gb2312?B?L3NsQkcxNk9SZWFhbWp3ZGxkZUl5dWZ2ZmIzb2t3ZFhoNDhSM3BXVmI3cmh1?=
 =?gb2312?B?ZmNVd2lEbGFBbzRiQU44TXh4UGRRZnFDRnVIS2xuQlRyY2dUK2tQODg2bWxi?=
 =?gb2312?B?bWVDSDZSRHpHOGpscDFvMWRBcmFQZzhEWHlqTmxIRTh2L0FPNGJVNFhQTFNj?=
 =?gb2312?B?WTZnUk1rdzBCeklvQms4SHV3ZUN0STE4Tzg2anE5N0FnTHd1bkt6dVRWU010?=
 =?gb2312?B?UEtMRWwwL0g3eFJqRUVpQWtZSGVwSTBpdVNVbHRZakVrRmFubVh2V0EzNUpm?=
 =?gb2312?B?djFhUzJjZTcrZjNBTyt4WGVldkxOZjUrNGp1WHl6emVRNmx1clcwSmhGQXRT?=
 =?gb2312?B?T1BBZnJJcXVtbjlrNmNvVU5LVnBQeU00RXR1UVhQVXBSZmd2UndXSzFMMXhm?=
 =?gb2312?B?VjFnN3hZb0VicVpUTFpjalR1U3ZEYVBldUgrY1Q5Sm1uNnRsSndqWGxSNHV4?=
 =?gb2312?B?Y0JEQktXZUNuZTNkM0phK3BkWmJTSllyVXFob3l2UnNtY1NGUGxRYTc0amtH?=
 =?gb2312?B?TUdxeGNLV1c3N0xBeWdlVHJTa2Y5VU5IcmpPdXRnOGl0ZWVoS3g5Y2FvZy9t?=
 =?gb2312?B?M1lWU2Y5WGhrSWo0U1RmSWp5cW5oVmVDNkZrR2VKd0xqZFVFY1Y0UkZaYzho?=
 =?gb2312?B?Vmk2UzEvZHVodGlwbjRKd2pHcE1JMGhkVTZsVmRDWFBxZ2xMZEhJNWVaT2p2?=
 =?gb2312?B?TmlrK3ZaRWtNQTdqT2E5VGxRcHZoczQrUnhLNUswYlhncmFGc1lLTGJpVTNL?=
 =?gb2312?B?eVBvNEtjZVhnVjhRdFJ3SkxpeGk2Q3RKZE42U2lKVHhmd2dHaVVPZ2szT01K?=
 =?gb2312?B?NzRXZVM0aVpsbmd6UFRIb1hZVEJmQTQreUZGc2xqaFUwVjlRRTI5V1JDc2hn?=
 =?gb2312?B?TDJzalFGOFFkRVpXblpnZUNrTDR2RHpHaU1WSENMc1JMamVzZURhQi9pcmlJ?=
 =?gb2312?B?UFBxY1lxVWlwaFMwMUtuUTZvek42N0R4VFo1aW5FOWxvbmhMMHhWempTZnNI?=
 =?gb2312?B?eFZiRzIwS3FMTmVjK0VUSnA2VFpUTi9YcUp5d01sUVJUM2UyUVZnWC9jUEJ2?=
 =?gb2312?B?Rm9xWkJQR1dTWkZlTjZJejlZYmR4bEZ6WlVhM2JQbnRhMndTcGcwSThQWEpx?=
 =?gb2312?B?UWsxSWVnVHBnWDJ5ak9LeUgxSVV4NVdhL1BzNU0vMjZuSmZYN08zOFBXaDV1?=
 =?gb2312?B?YkZYZ1p5ekxPUDZ2Q2FHNHJGNFZSTmdtc1I1NExPWS9rbXR5TlNBN2E3Q2J6?=
 =?gb2312?B?dEM2ODdNSW1ZejhNSGtuQmxvM1VGZno3MFFGSjN5MXpPRm01TWlEajhjUzl1?=
 =?gb2312?B?ZUpvaUZtdVJNUzRsc1F1Tm1UeXVYMVY1U3M4S1BTN29Mcm9lTTBPMFV4bVo2?=
 =?gb2312?B?bWxVQ0dyRitZVXFMUjNTRGFwOHZqM3lLenZ1M1AzTWgzbnBleGZBT0h3eWRI?=
 =?gb2312?B?akwydGNvdE4xRTUrZDNmWmNOZ1FCcndTSHNyRDZ6eFVUYTMyYVZXREs4WEVC?=
 =?gb2312?B?WWp3ZkNWcmd2clFPUG1ZWjBNUVUxdXNkYktlaU1OZnQwU1d2T2l3SERDWVFm?=
 =?gb2312?B?amZnMUxtTFF1RFNpRVJGUHM1NG8rL2pwelJnQlU5V1ZpREw4Uzc5WTdjK2k4?=
 =?gb2312?B?cGdnMGp0M1cyQS9xRTNkYnA1RTErNlJ5NmlOeUFmRm1UdmFiM2dnMFFRVFNm?=
 =?gb2312?B?bVNGeTRnOC9GQUk5Y2FIUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?amc0bms4TnQ1eWZkUHYvbGtudWd5RnFsSnZXSWlFWlRiZm1xTFVsZVlONHRo?=
 =?gb2312?B?TUFhUUw1OXgzdGFJU1JLNEJLVUd4YzRFZi94S3FuNXpzMW1kNWZVRFhlTWR1?=
 =?gb2312?B?YUM2Ti9MeEhTZ1d0QzdsSGZNWlhmbE9tejJNcjlQYmpCV29kL0NlcTBTVE55?=
 =?gb2312?B?V0dDaDZPZjNGaTlqS3pCZzFQYjVsU3VMVDJraUJ0WFlNWmQ5TG9WbEE3a1E0?=
 =?gb2312?B?Q29QWjExbE02OFhJVU5rU0gvQllGVDNYellHY0RTcys3ZlQ1SXhkYlo1aWw3?=
 =?gb2312?B?NWFxN0JveENtVGh4VElWdGdndFkwZ3FPaFg0M0t2RUxzTEVtQ3NPZ29rVUpp?=
 =?gb2312?B?VG13bXYwRXBCUU96MDRVcXdYcmNTUTJHOGNBTm4vZ3lFdzNIZGhoMVBpWGxO?=
 =?gb2312?B?Q0pUdjJSbXJnamE4WElwWmR0L2xkbWFyM2g4Mk5vSGgyYTU5cHNSa2JJYVNK?=
 =?gb2312?B?TlBWUmxZR015MHlsSm9ycHo3UTNBMC9BNkM1TUt6YjdpWVlLSWVvVk1ocEg2?=
 =?gb2312?B?aEZNYjZrVVJkd1Q5QnZHUVJUT0hCQ3pnRXA4bWNyYU9qQmFTbzhPc2hWVjhY?=
 =?gb2312?B?a0pxVzNYZ2hQbWNLazZMSW8yZUlsbTZZQ0FvZ1RYdjFZNy9neTcya0xiclNi?=
 =?gb2312?B?aHhMUVdmRnA3T0JNWmwrYS9lOHZDdVpWUEE0TjE4N04rSDlpQXV3ZmhmYzdw?=
 =?gb2312?B?bzBZbVJRR3UzQVZUSG9IZ3hWY1dWQk1xQjNIcmJnK3R5MXVPbmtQWmRLV3hY?=
 =?gb2312?B?QmRRYXFITXhoY0pzNml0K3hiV3pPN1dlQU1zUUdTazVTRDhXSHhUVU1QZSsw?=
 =?gb2312?B?bWQzdENjR1NlenlCT1I0WXZ1NGp5Z3J0RzVFK1VBNGpmbnVmbnVYM2tJaFhR?=
 =?gb2312?B?OHUxNUZwT3NqRGZIRHNYNnQyUVArb2JyVFN3Vk14OFBhcHFYdHlXaGNJWFZx?=
 =?gb2312?B?UEtyZjlyc3VtVkJNUnRzbXlsNEpBZTV0MkUzQUFnUlBTc25XeWxPNi8vRHNR?=
 =?gb2312?B?OXRCdHF5S0xZaUR6dU1hSWx5bDd5ek0vdksrVGFkVjg3QlF3Y1FuZTFmYzRh?=
 =?gb2312?B?WE9iT3N5aUp6Z05QUnphVkFjSTBGU0JRSnE3MUtuV1NuZWxHT3o1Vng2TS9m?=
 =?gb2312?B?ZXJQM1ZRMEwwR2JKWmk1V2E4eCtTUG9Id2Rsa1RwYmdEdUIwZW9DcWxCUHpR?=
 =?gb2312?B?eE1teWdKTWdmU0wwRlA0RlNaVGwvbWNiL2VpNUMveHlLN3VUb2oyNnFmVkx1?=
 =?gb2312?B?YXU2bzdDMjhwYjlUWkcyVUxtaXoyV3V5NzloWitTTnIxTDZLcStzOWtxbE1O?=
 =?gb2312?B?L205UEczMDlnMWY2TGZpQzVhN2w0ZFo4aVllWjFTUUptaTJxWi9jWkYwaXBz?=
 =?gb2312?B?dldNWmc3TDFGdEMyZkZWRXNaZ0Uzc2RWWFM3dmpTcVdxSU5TdWRNN1hXQ0ZO?=
 =?gb2312?B?Wm5GYlA5b3hteWZQbDlVb0dZOXRyL2psWWpsdm0xcG1iM0VpTE0wa1QyRDF1?=
 =?gb2312?B?NDJOREtBdEdHNU5PQ0RWM1d1MzNhWDVuZi9qaG96ZG1Mekw4Q21tdm9YTkFz?=
 =?gb2312?B?YmxTTHZkVDlQcEt2Z0grZ0RaWG03YkZCeG5qdGI5Qk5aVDF1VmVzeENpbDlt?=
 =?gb2312?B?SXFVSWwzMWJxbFo2Mm0yaVZ2b05WT2pDcjRaa0JicDJwUWFmNmxjOXRhZkpT?=
 =?gb2312?B?VkFrUXRnU2syd3llNWtJOWl4U0FVQXU3UnVmUnBpcG5ZbW5JT01aMGc1Szd6?=
 =?gb2312?B?YnI3ajlkazI2bDY0TzBTcjBaN0I1TE9EZTJqR0tZZmE2cXBCcVpBOUNZOTlu?=
 =?gb2312?B?UDRZOEtTdkxHbFJNMmVVYmF3M3RBTy94NFhwZHJRQTFqdjl5VWI3Y0xrY3lR?=
 =?gb2312?B?Znk2ZlJ0N3dYdERucGlWclZHSWNqY0lrQ1dXTUdyOFkwZDJVTnRCQWYzUllh?=
 =?gb2312?B?aXlid0I2MnBiOFhtNVZscURVWHdQYytBeWVnVWR0aElaV2VXYVBBakc5L01q?=
 =?gb2312?B?b2ROazBaaHliMWRjemg4bUU0SU5SVjFxUUR4ZHd2NU92TWRpNkpaaG0ybmUy?=
 =?gb2312?B?YU9oZFhPVU9kditUUGlOaUpGK0x1RWRhQUIvaDFueldxMDVjRzZyYXlzNy9G?=
 =?gb2312?Q?pIF0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55264128-f87a-4212-98e9-08dce8cf5834
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 02:00:41.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRr5jiCW4SlfprH6/jA5S/sje34SsdJtE8/WkezEcICsSfrhqqEwxj6S2sfj9LcXbossTzED9jHt89Scgr2crQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8946

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjEwyNUgMDozMA0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0LW5leHQgMDIvMTFdIGR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBpLk1YOTUgRU5F
VEMgc3VwcG9ydA0KPiANCj4gT24gV2VkLCBPY3QgMDksIDIwMjQgYXQgMDU6NTE6MDdQTSArMDgw
MCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gVGhlIEVORVRDIG9mIGkuTVg5NSBoYXMgYmVlbiB1cGdy
YWRlZCB0byByZXZpc2lvbiA0LjEsIGFuZCB0aGUgdmVuZG9yDQo+ID4gSUQgYW5kIGRldmljZSBJ
RCBoYXZlIGFsc28gY2hhbmdlZCwgc28gYWRkIHRoZSBuZXcgY29tcGF0aWJsZSBzdHJpbmdzDQo+
ID4gZm9yIGkuTVg5NSBFTkVUQy4gSW4gYWRkaXRpb24sIGkuTVg5NSBzdXBwb3J0cyBjb25maWd1
cmF0aW9uIG9mIFJHTUlJDQo+ID4gb3IgUk1JSSByZWZlcmVuY2UgY2xvY2suDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sICAgIHwgMjMgKysrKysr
KysrKysrKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L2ZzbCxlbmV0Yy55YW1sDQo+ID4gaW5kZXggZTE1MmM5Mzk5OGZl
Li4xYTY2ODViYjcyMzAgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9mc2wsZW5ldGMueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvZnNsLGVuZXRjLnlhbWwNCj4gPiBAQCAtMjAsMTQgKzIwLDI5
IEBAIG1haW50YWluZXJzOg0KPiA+DQo+ID4gIHByb3BlcnRpZXM6DQo+ID4gICAgY29tcGF0aWJs
ZToNCj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGVudW06DQo+ID4gLSAgICAgICAgICAt
IHBjaTE5NTcsZTEwMA0KPiA+IC0gICAgICAtIGNvbnN0OiBmc2wsZW5ldGMNCj4gPiArICAgIG9u
ZU9mOg0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+ICsg
ICAgICAgICAgICAgIC0gcGNpMTk1NyxlMTAwDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBmc2ws
ZW5ldGMNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHBjaTEx
MzEsZTEwMQ0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVtOg0KPiA+
ICsgICAgICAgICAgICAgIC0gbnhwLGlteDk1LWVuZXRjDQo+ID4gKyAgICAgICAgICAtIGNvbnN0
OiBwY2kxMTMxLGUxMDENCj4gDQo+ICAgICBvbmVPZjoNCj4gICAgICAgLSBpdGVtczoNCj4gICAg
ICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgICAtIHBjaTE5NTcsZTEwMA0KPiAgICAgICAg
ICAgLSBjb25zdDogZnNsLGVuZXRjDQo+ICAgICAgIC0gaXRlbXM6DQo+ICAgICAgICAgICAtIGNv
bnN0OiBwY2kxMTMxLGUxMDENCj4gICAgICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgICAt
IG54cCxpbXg5NS1lbmV0Yw0KPiAgICAgICAgICAgbWluSXRlbXM6IDENCj4gDQo+IGtlZXAgY29u
c2lzdGVudCwgcGlkL2RpZCBhcyBmaXJzdCBvbmUuDQo+IA0KDQpJIHRoaW5rIGl0J3MgYmV0dGVy
IHRvIHB1dCBlbnVtIGJlZm9yZSBjb25zdCwgYW5kIG1pbkl0ZW1zDQpkb2VzIG5vdCBzZWVtIHRv
IGJlIHBsYWNlZCBoZXJlLg0KDQo+IA0KPiA+DQo+ID4gICAgcmVnOg0KPiA+ICAgICAgbWF4SXRl
bXM6IDENCj4gPg0KPiA+ICsgIGNsb2NrczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBNQUMgdHJhbnNtaXQvcmVjZWl2ZXIgcmVmZXJlbmNlIGNsb2NrDQo+ID4g
Kw0KPiA+ICsgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29u
c3Q6IGVuZXRfcmVmX2Nsaw0KPiA+ICsNCj4gPiAgICBtZGlvOg0KPiA+ICAgICAgJHJlZjogbWRp
by55YW1sDQo+ID4gICAgICB1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gLS0NCj4g
PiAyLjM0LjENCj4gPg0K

