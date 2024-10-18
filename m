Return-Path: <linux-pci+bounces-14835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97A9A31F6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 03:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5CD284647
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931C13D0C5;
	Fri, 18 Oct 2024 01:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b5m8sMzu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B028399;
	Fri, 18 Oct 2024 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214530; cv=fail; b=kGnG0SQhQiMRd/xQvKXpyeegge7jqH/r+mM9Cq7l0XCgd3H/SqUHMPxQDkn+JqKQ/Vav1wvwwUtyidQGyq7+ixnECB7Nj4eLSkjZUw0yIzJQfYZiDcF7UkPw851o4ILaz5yfTbwk3wjBIzMnE5gDvmA/6V4LwZlbE8TeJ/GfaeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214530; c=relaxed/simple;
	bh=utW+TQv9iS+MrmdgOmssAdw4gk19tSaei0f10jrqrsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChkQDZ8E6NyjLSDK3lc9/oVdrBduN/kTxH7pNM9SZjtVs1HupKpnQvLAKcpF3Oq4yPQuTk2hr++MWrG7RbpttKPWzHXA+zWuWCyGokLiRsX3nTWjR90/3+HUcGla/l1UIFQKS8lwAP2Scsqp2uQ5ziNA4XQqvy8/Q0M8sxE12rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b5m8sMzu; arc=fail smtp.client-ip=40.107.249.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6eEV1YymdsALJ0SLitEwT1QtCdSyKUX7Ln0mh7FCs+wNg2CL3ftK8A4SSbXj4+nLMgQkgIy/l2BZzm4T6UxwYcuEU7lKGloGkF8H43bVTub8p5y35Cx/svSYlx1RFZ5k63xZ7Q7qilN4J3j0xINuf3DbtwlfGi1thS9kJ/9VoK9MQqugdX7ltwO0DOeoL9i+cMZGY36v8F71Q7t3p1izU7Swsx370YBJ+lxQbLzJqHR5RvI4YGHMJm5vvV49gGkUzP7EljBQFEQwi7l5GcuBIB5HvBj2vOxwvlCabOuBjiaVtlmkj4gksd+CHxjFIDc46nfUhrmHyKXV+4PPSQVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utW+TQv9iS+MrmdgOmssAdw4gk19tSaei0f10jrqrsw=;
 b=Q+fGmZrUjx3HorkEcrwaFSCubVIM3/4jqeiV8hdroH9uwpIstFTwAifkK3L2qr9rcu+q9vjcy3lBa0gYL1dVxTKiHaeAFWF2nUpvDvMBA4IVhfW7EhR0JAos12KzXfcD+ftvvG3bVLNGTvFe/S62gSBqc9FLwpLowzaOdGmFNFZ6WZmCbLEoK46/FN6HdPRYiPJbHg7lyGGcaGrXv+1Iz+kjBdiIXfyNEVMqXC8PU3QUvUerOHV0AcO1YnWXYNn+ExSCOkEWHgR7QKlcXX94T03UrPmmEUE35MWw3Kf6rdP5DkFm/j3VP3vBONHhHJbXISu0QooI/98Ys2Mbfew5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utW+TQv9iS+MrmdgOmssAdw4gk19tSaei0f10jrqrsw=;
 b=b5m8sMzujJWwG3IDdVTDvprI3kLHG4/M72iJFoMveFGjXuklqWpj9f51fWlpmKU0vNnFNfEkyuDhAEfhSOsntoxQS7eRuS3M/nw9KC29BFSNIU1rqiDcx/i4qB1oiwcp7Lqnne5v8/koqRVRHI9D5R8gYrhW7dHXKcXNOX291DP8XmACSAFcXzuNXJia1Iu3PUtsFZFnvb9jcF/IZWt/VfyD4j3oeTVnUR5x4HLi/xIKSy28vaALEM1Zaz/UDzGCzN1VrXwX/TYo6ykmrvmbpG6N7F1fprd5hxKjW6W/ls8bab/yQJbKTEnXMbVYQuXPv6JqAcOwA/bjlt74yPFnBg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8935.eurprd04.prod.outlook.com (2603:10a6:10:2e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 18 Oct
 2024 01:22:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 01:22:05 +0000
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
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v3 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbIGrYdFXURb+VOE2nPP80MdYGyLKLIiWAgACVJXA=
Date: Fri, 18 Oct 2024 01:22:05 +0000
Message-ID:
 <PAXPR04MB8510B4D6822C3A1AF463C9C988402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-4-wei.fang@nxp.com>
 <ZxE6/3enXdTngDRU@lizhi-Precision-Tower-5810>
In-Reply-To: <ZxE6/3enXdTngDRU@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8935:EE_
x-ms-office365-filtering-correlation-id: 7b190898-f7bb-43db-717e-08dcef13471c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?c09nWE1jeWVNd2FvM29EdC9MTHZPdXFsMXdkeko5SEgxeHJHdHBhSHdCbjE5?=
 =?gb2312?B?K2xBM0tuYXp2Q1VHS2ZudHkxU1VUbWFWNWJDenAwY1dzd0drd0JtZkpvMVkw?=
 =?gb2312?B?b0U3N1IxUDBJMTE4VXpuMjhGRU96cFJ2QnlNTVhOdHVFdXNzMTk3b2xnY1R4?=
 =?gb2312?B?U0g4T2V0ZGV6MWR5T2V0YWFSZTF4cE9vbDlzY3JmMWRJN0ZUWG9IZjhYcDFz?=
 =?gb2312?B?SE90ZUtzdHpQdnJTT2l6NDlVMExVdTUzYnlEd3R6MWd1WlZxbERUWk8wbHFV?=
 =?gb2312?B?KzRzM1V1dUMrdEEyeFFZOG51TWwxUDByNGVRc0Yzb3hVVWVFUFJwWS9wQ3pv?=
 =?gb2312?B?ZC9YS0NhZzlHUzZiZjJvZStzL3ZMMERoS1V0Q2VjSXpJa1kwRVhlbnp3bEpq?=
 =?gb2312?B?Q3gwNGZmellZcC9rQ1VnR2pueHcvQ2xmV1pwQVpFMUVWemlPdlkvVkNZcVMw?=
 =?gb2312?B?bWxvNWxKTXlqNXJBczFxRVExNXlZMWsxRzBlUm1lQm81YlRJZ3FuL0ZwN1lS?=
 =?gb2312?B?ZVFzS1BmR0l0bTJSVHFEVUlkK09iMmk5NU9sd2hvbWhZVlVadE54dk9zOW83?=
 =?gb2312?B?TVVEeDFFUFZvZll3c29kOE4xRFFVVkE1OUlyc1dsUExZT2R2NjZxa0I2ZG9S?=
 =?gb2312?B?OGJlVVBDMTNzcUZDaVFlQndBQk1iWjRNWExaZG1rWlZ1Z0oweWI0QytFeDJP?=
 =?gb2312?B?Z2haSS9XK2Y4U3lZVTRGV3JmY3k0c2F0dm80b2NOV2VncjIwMmhIZFVxbnln?=
 =?gb2312?B?Q2dqUEM2UEljaFVvMHMrZHpxemxydWhOY0JrTG8zN2FLeGxCaGcrUXRtbzFL?=
 =?gb2312?B?eUxaaVpTL3V3bWNGeWRicTF4M2xxL0VGZU5lL0EvWko4bzZJYWlyVGlUaUVo?=
 =?gb2312?B?NEVLRHU3ZDdhNGtFUHd0OGJHeSt2MmgvemdJSC82YTNTVE5JcWNXTTQ3cnEz?=
 =?gb2312?B?akd0UmF1Tnp6bElOYklZV21xY3czMG1lTWJHOGtLOGo3b0JLR3NnUy9FeG0v?=
 =?gb2312?B?S01aVTh3SVk0QnRtK2JFdTFvOVp2Zy9sVTVGSGVQclNtcFNFaGpWSWFVRzdo?=
 =?gb2312?B?TTBsOGFrUk1NN1N2S1ByNUNUUHlvYnJUTjVEYXZRVjJvTDBYQnA3S3ZIVzJE?=
 =?gb2312?B?T01kemVNbUJRZktxSUJXeDdld2d0YVFkdHhSMnRGaS8rQThwZTBMWXBCWjNt?=
 =?gb2312?B?bEJlWk1Pd2drVzRqWUVwVTAxWjBKVWtFRTNUSWpuTmRsUlFBV1hSWnpOdUtM?=
 =?gb2312?B?OEErMW0wNW9XNFVDeTE1MDVOQjdLUkhIY0tkQkk0djFhRXMwZW9DV2ZwMm5D?=
 =?gb2312?B?Q1N1b1c5SHpEK3puOHJSQUFlVjBkT1dCMEhVRTZOYXM1TDVmUVlvWEZlK0F1?=
 =?gb2312?B?WHJnUSt2YlZ4OEp3RGwxZDFCN00wSWwvcW51ODFiMlQrVWhJNHhBb09EWm9H?=
 =?gb2312?B?UUUxN25IamRBTDNWM3RRalY2c0hJNnVhRXFGdC9NVEdvMktqZFR4WjAwV1hF?=
 =?gb2312?B?b2FTRUxXSFpobDVZNHFLMmtjQ1RJa0wvd0VKbS9Nc2ZlNlhwc2NwVlhSOFVZ?=
 =?gb2312?B?K3dwOHpmeXU3eDBPbmFnTFhOSUhsLzB5ekQ5d0VacmkwRmhXd2FyaFR4QjRw?=
 =?gb2312?B?Ykp3TWJQSm5iczVReWRvZ1lJZHFiVjZsUS82WHRKZElzQmlibUx1SHlVMDNM?=
 =?gb2312?B?OHczTjhVemNtRXlLdzZKeHJPblA0bTRDSk03Nit5T3o4bEJUTzRrYURTeE0v?=
 =?gb2312?Q?gp7A9KcbnPUjvHfmGH7bJnIIkcNVGAgsEYXdGOb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eU9DajV5NTJ2ZVo3Wm0zdTg5eUdmZFJSY3grL2lXTDBMc0J2K1NXeHEyN2Nn?=
 =?gb2312?B?T05jcXhtazlPT2Z0cWNpcTNhZ0p4cEpTM1J1OEZQdTNERmxhR0xHdHlRNEdD?=
 =?gb2312?B?UHY2Qzlma29RRG80ZGUzTDlMTVlpVE5VSVNWd0tXVjZMYS9mVWlWaVdjUmd3?=
 =?gb2312?B?ZGtQTGloWFFjVXo3bkJtYlpKYUtDbWZ4ZzJ0SktqYU5FeGJuMlYwZHVyM0FE?=
 =?gb2312?B?c29pSU1qRXkzcWtadHFZZUFWRlQ0dEhNVUdFOGExUEFHYnZRd2Z4M2hDYWZ3?=
 =?gb2312?B?aTNycmk1TkdMMTRhazJiZFFTMzhEalk2YkpxTzVZK2Y5RDVwak5VdlpTVHpy?=
 =?gb2312?B?VjZvRGk3eW9Wc2pQYW9FcWZCZThOWG9SakhDejFPVktJNnlyMHlHZ0F3K2JN?=
 =?gb2312?B?dWVGdlVIcmFDN3g0b2MxUHo2ZWdCTUxUY3czb1c2Mm1sV3lFRlFXL3pGWmN3?=
 =?gb2312?B?ZTBuQzE2SmI4NURzRG5zV0twRjE3NTRzN1oxS05BZFFieWJSZndsaUVuWU9p?=
 =?gb2312?B?U01lY2lWNFk5bmVWZCtab0k4UHUvcm00VTFPRVlUaVl2clVEWnJwUGFzV0lW?=
 =?gb2312?B?dUZsaHFTV3JVSEFUeXFWTUhhbmlyY2QwUXJLMEdPTUlSNDFQbEQ2eUJjVFVj?=
 =?gb2312?B?N3I3Wi9Qa01NWnFCWFl2NlBqRkc0eGF1VW1GZUhqaW5YbjBaRnhHT3JDYjhj?=
 =?gb2312?B?UTZjZW1yYlhPMURMTE5mdzY1S1RzbUdqbGZaV0NISVRkTU1XQzlhTEd4RFk1?=
 =?gb2312?B?cFBWd1VtR2psS1lpM1MvZUNvZEN2MFZVaEM5aTE1eUhlM21zZjNUUVF6cFRI?=
 =?gb2312?B?NnN3UFljMFZmWFJPemljbzZURFVSWUN3Tm02bk9kS1l2cU0rT0tSTEhoTXFE?=
 =?gb2312?B?T3hTV1RKdXF6V05kN1FnVnRTS2dKRDBvV3U0bWdBTnZrUEdKMnZTRXpTQUhh?=
 =?gb2312?B?VFlGdFRtWEtqSmR5ZkR5eGJEKzQ2THUrUjZ6OW1jRitWNzBBWGlDSlV2Rnhz?=
 =?gb2312?B?ZnU1TGlPdkd1SjNZWjkyT1lUbUdNR1ZRaHE2UkVjQkk5WDR1aVdJRjZPQnAw?=
 =?gb2312?B?TTE3K2dDMkZ6MjF5b3dvZStFT2QyK0VneTJ5aG14cVkraTJ6UnphYnQ5WmM1?=
 =?gb2312?B?NzdrTFFmcXYrME1yQld1SVlDazd5MTdwN0dZTXFaSDB0MittT1ZvTXAxSHhy?=
 =?gb2312?B?Um4zNGhKaGNxaUtRd0t6SFRKR3lOekFYWi9EbE5vSjdBTndoWUliSFdXKzdz?=
 =?gb2312?B?WmxZY1JDMVA2QTFpS21QRWxJWWEvbU1hMjc5V2lxbVRVaTRiYzkyRDluTTZv?=
 =?gb2312?B?RldFWEkrQ2hjWkZtdjVqNGFON1M2bllETjkwMityRGlDZUJZd2V4aDdLOS9C?=
 =?gb2312?B?Zjgyc2toVjZXdHA2TU1wYkd6WTFVRSsxWXhxdzJRZTJvMVViUUtRenl5S21s?=
 =?gb2312?B?bGdRUnljVUVIMFJBZ2x1MXQ4VG5xWUxFay95bmZ0Uzh1Y2M5K1YyUFNEWHJK?=
 =?gb2312?B?VHdyOU5YQ1R4VGFoVUNVcHdGVFhQNW92dVFYUFVST0ZTbUd1WGhmbGdHOE1I?=
 =?gb2312?B?TFZmTVQyYXVtNitSbU90bWFwMGJDbHF6TXdpRHRBVnVhSjZKcExWeGYwd0dm?=
 =?gb2312?B?aTV4TlpvMWdPc1grc0svb3BNNEhLR083cjluajd0d25EZ09LUkFBanJSbDli?=
 =?gb2312?B?QzFFbzdGNmlnLzlSM2tjQjVKNzhNTDJCSWRmclhCV05IWWpFaVc4THVaMEE0?=
 =?gb2312?B?OHplUnVFc0Q3RVNoeFJSYW9EL2pOaUhwSDJNQThLVkcwWjZIZWxxQXZuV25T?=
 =?gb2312?B?OTdLcjZQQSsyaGpqWjVkUGpqdXJ3dXhWZTdTOHFVMmNROGdZd3NjOTdXNThG?=
 =?gb2312?B?S0FjRWJlL1VyRVVMWXMvcWxkZEhQMUhlZk9POU9QdDRKelREdzBTOXJrNzB3?=
 =?gb2312?B?akdOSDJrb0FSajdqZW5PdGlYQkVJcEVXUzdoOGlsTzVEbm5VMUpodW5NSFd0?=
 =?gb2312?B?cnplU0dJejgvM2RxOTQ5OFpjL3E4b2dUTDdYTUVHbjR5dE45UmVaR1hPZEww?=
 =?gb2312?B?ZU1uSzlKWUlhNFJmMnJZWlpaTGlHZll1NmlCMWJYd1ZrdGNaV3p6c1BYcjNt?=
 =?gb2312?Q?Y8wg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b190898-f7bb-43db-717e-08dcef13471c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 01:22:05.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utkPM1GhItzvHEs6Q/yAwBrg1/ERD4Fk2YcY3lmntbzu0763CYUZqTFYRT085dGxFf0W7k+XH+pNzf1Cb4e2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8935

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE4yNUgMDoyOA0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgbmV0LW5leHQgMDMvMTNdIGR0LWJpbmRp
bmdzOiBuZXQ6IGFkZCBiaW5kaW5ncyBmb3IgTkVUQw0KPiBibG9ja3MgY29udHJvbA0KPiANCj4g
T24gVGh1LCBPY3QgMTcsIDIwMjQgYXQgMDM6NDY6MjdQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6
DQo+ID4gQWRkIGJpbmRpbmdzIGZvciBOWFAgTkVUQyBibG9ja3MgY29udHJvbC4gVXN1YWxseSwg
TkVUQyBoYXMgMiBibG9ja3MNCj4gPiBvZiA2NEtCIHJlZ2lzdGVycywgaW50ZWdyYXRlZCBlbmRw
b2ludCByZWdpc3RlciBibG9jayAoSUVSQikgYW5kDQo+ID4gcHJpdmlsZWdlZCByZWdpc3RlciBi
bG9jayAoUFJCKS4gSUVSQiBpcyB1c2VkIGZvciBwcmUtYm9vdA0KPiA+IGluaXRpYWxpemF0aW9u
IGZvciBhbGwgTkVUQyBkZXZpY2VzLCBzdWNoIGFzIEVORVRDLCBUaW1lciwgRU1ESU8gYW5kDQo+
ID4gc28gb24uIEFuZCBQUkIgY29udHJvbHMgZ2xvYmFsIHJlc2V0IGFuZCBnbG9iYWwgZXJyb3Ig
aGFuZGxpbmcgZm9yDQo+ID4gTkVUQy4gTW9yZW92ZXIsIGZvciB0aGUgaS5NWCBwbGF0Zm9ybSwg
dGhlcmUgaXMgYWxzbyBhIE5FVENNSVggYmxvY2sNCj4gPiBmb3IgbGluayBjb25maWd1cmF0aW9u
LCBzdWNoIGFzIE1JSSBwcm90b2NvbCwgUENTIHByb3RvY29sLCBldGMuDQo+ID4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiB2MiBj
aGFuZ2VzOg0KPiA+IDEuIFJlcGhyYXNlIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiAyLiBDaGFu
Z2UgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzIHRvIGFkZGl0aW9uYWxQcm9wZXJ0aWVzLg0KPiA+IDMu
IFJlbW92ZSB0aGUgdXNlbGVzcyBsYWJsZXMgZnJvbSBleGFtcGxlcy4NCj4gPiB2MyBjaGFuZ2Vz
Og0KPiA+IDEuIFJlbW92ZSB0aGUgaXRlbXMgZnJvbSBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzLCBh
ZGQgbWF4SXRlbXMgdG8NCj4gPiBjbG9ja3MgYW5kIHJlbmFtZSB0aGUgY2xvY2suDQo+ID4gLS0t
DQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbCAgICAgICB8IDEw
NQ0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwNSBpbnNlcnRp
b25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+DQo+ID4gZGlmZiAt
LWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ueHAsbmV0
Yy1ibGstY3RybC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L254cCxuZXRjLWJsay1jdHJsLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uNWU2N2NjNmZmMGExDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxr
LWN0cmwueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTA1IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiAr
LS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbmV0L254cCxuZXRj
LWJsay1jdHJsLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE5FVEMgQmxvY2tzIENvbnRy
b2wNCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFVzdWFsbHksIE5FVEMgaGFzIDIg
YmxvY2tzIG9mIDY0S0IgcmVnaXN0ZXJzLCBpbnRlZ3JhdGVkIGVuZHBvaW50DQo+ID4gK3JlZ2lz
dGVyDQo+ID4gKyAgYmxvY2sgKElFUkIpIGFuZCBwcml2aWxlZ2VkIHJlZ2lzdGVyIGJsb2NrIChQ
UkIpLiBJRVJCIGlzIHVzZWQgZm9yDQo+ID4gK3ByZS1ib290DQo+ID4gKyAgaW5pdGlhbGl6YXRp
b24gZm9yIGFsbCBORVRDIGRldmljZXMsIHN1Y2ggYXMgRU5FVEMsIFRpbWVyLCBFTUlETyBhbmQg
c28NCj4gb24uDQo+ID4gKyAgQW5kIFBSQiBjb250cm9scyBnbG9iYWwgcmVzZXQgYW5kIGdsb2Jh
bCBlcnJvciBoYW5kbGluZyBmb3IgTkVUQy4NCj4gPiArTW9yZW92ZXIsDQo+ID4gKyAgZm9yIHRo
ZSBpLk1YIHBsYXRmb3JtLCB0aGVyZSBpcyBhbHNvIGEgTkVUQ01JWCBibG9jayBmb3IgbGluaw0K
PiA+ICtjb25maWd1cmF0aW9uLA0KPiA+ICsgIHN1Y2ggYXMgTUlJIHByb3RvY29sLCBQQ1MgcHJv
dG9jb2wsIGV0Yy4NCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gV2VpIEZhbmcg
PHdlaS5mYW5nQG54cC5jb20+DQo+ID4gKyAgLSBDbGFyayBXYW5nIDx4aWFvbmluZy53YW5nQG54
cC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4g
KyAgICBlbnVtOg0KPiA+ICsgICAgICAtIG54cCxpbXg5NS1uZXRjLWJsay1jdHJsDQo+ID4gKw0K
PiA+ICsgIHJlZzoNCj4gPiArICAgIG1pbkl0ZW1zOiAyDQo+ID4gKyAgICBtYXhJdGVtczogMw0K
PiA+ICsNCj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+ICsgICAg
aXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IGllcmINCj4gPiArICAgICAgLSBjb25zdDogcHJi
DQo+ID4gKyAgICAgIC0gY29uc3Q6IG5ldGNtaXgNCj4gPiArDQo+ID4gKyAgIiNhZGRyZXNzLWNl
bGxzIjoNCj4gPiArICAgIGNvbnN0OiAyDQo+ID4gKw0KPiA+ICsgICIjc2l6ZS1jZWxscyI6DQo+
ID4gKyAgICBjb25zdDogMg0KPiA+ICsNCj4gPiArICByYW5nZXM6IHRydWUNCj4gPiArDQo+ID4g
KyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2stbmFt
ZXM6DQo+ID4gKyAgICBjb25zdDogaXBnDQo+ID4gKw0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+
ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4g
KyAgIl5wY2llQFswLTlhLWZdKyQiOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvcGNpL2hvc3Qt
Z2VuZXJpYy1wY2kueWFtbCMNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gIiNhZGRyZXNzLWNlbGxzIg0KPiA+ICsgIC0gIiNzaXplLWNlbGxzIg0K
PiA+ICsgIC0gcmVnDQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAtIHJhbmdlcw0KPiANCj4g
Tml0OiBuZWVkIGtlZXAgdGhlIHNhbWUgb3JkZXIgYXMgYWJvdmUNCj4gLSBjb21wYXRpYmxlDQo+
IC0gcmVnDQo+IC0gcmVnLW5hbWVzDQo+IC0gIiNhZGRyZXNzLWNlbGxzIg0KPiAtICIjc2l6ZS1j
ZWxscyINCj4gDQoNCk9rYXksIGxldCBtZSBhZGp1c3QgdGhlIG9yZGVyIGluIG5leHQgdmVyc2lv
bi4NCg0KPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+IA0KPiA+
ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxl
czoNCj4gPiArICAtIHwNCj4gPiArICAgIGJ1cyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8Mj47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsg
ICAgICAgIG5ldGMtYmxrLWN0cmxANGNkZTAwMDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRp
YmxlID0gIm54cCxpbXg5NS1uZXRjLWJsay1jdHJsIjsNCj4gPiArICAgICAgICAgICAgcmVnID0g
PDB4MCAweDRjZGUwMDAwIDB4MCAweDEwMDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4
MCAweDRjZGYwMDAwIDB4MCAweDEwMDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MCAw
eDRjODEwMDBjIDB4MCAweDE4PjsNCj4gPiArICAgICAgICAgICAgcmVnLW5hbWVzID0gImllcmIi
LCAicHJiIiwgIm5ldGNtaXgiOw0KPiA+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwy
PjsNCj4gPiArICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAg
IHJhbmdlczsNCj4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZzY21pX2NsayA5OD47DQo+ID4g
KyAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gImlwZyI7DQo+ID4gKyAgICAgICAgICAgIHBvd2Vy
LWRvbWFpbnMgPSA8JnNjbWlfZGV2cGQgMTg+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgcGNp
ZUA0Y2IwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInBjaS1ob3N0
LWVjYW0tZ2VuZXJpYyI7DQo+ID4gKyAgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4NGNiMDAw
MDAgMHgwIDB4MTAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0g
PDM+Ow0KPiA+ICsgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAg
ICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsgICAgICAgICAgICAgICAgYnVz
LXJhbmdlID0gPDB4MSAweDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4ODIw
MDAwMDAgMHgwIDB4NGNjZTAwMDAgIDB4MA0KPiAweDRjY2UwMDAwICAweDAgMHgyMDAwMA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgIDB4YzIwMDAwMDAgMHgwIDB4NGNkMTAwMDAgIDB4
MA0KPiAweDRjZDEwMDAwDQo+ID4gKyAweDAgMHgxMDAwMD47DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICAgbWRpb0AwLDAgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAicGNpMTEzMSxlZTAwIjsNCj4gPiArICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMTAw
MDAgMCAwIDAgMD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAg
ICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgIH07DQo+
ID4gKyAgICB9Ow0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==

