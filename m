Return-Path: <linux-pci+bounces-29837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB5ADA9ED
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9053216989D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866111F0E2F;
	Mon, 16 Jun 2025 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dSClPA9k"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D701DF759;
	Mon, 16 Jun 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750060493; cv=fail; b=eLo0ZCDEHtIb/ZIxtNTnkmqDM0K9EUXjgRQlian/aEuJfd/M9yulwtrsie6ndodgflj/4fyETUvAmPbdzfSrBlJuiSiSS+Fbr/Zx1bV26ulbhTU7POBB008Uq7hn9qhzUcFMntO6fYwc5LwAliPsCblFfuQR07weLiEcACY+22s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750060493; c=relaxed/simple;
	bh=+/8DVDviqHU1XxwzkSvyQ7s4QkRaF8PurL+YbwCg8rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZGDtfHwfQM7xnvjcl1gZGKt7rk6nmHCGPeLBLIrS5++YWoCxKXDw1uc0OlD4XpAe30OYc2uZ09KF05h3l9TINf1PNJxctr4T2OYlMLt7imvSZFTbGKFzXChOene8Jspas6ZRaCHA46uEdq4pummShU36X/JSt+iUyr9u2H0/CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dSClPA9k; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fwefb3guRuhJlPSKRIFySijGm5TCCF4ulI0uZ5aGOpLBAiYWXkKai5bj1KylqGINflo1jPAJ+p69IqqqV2FtaTypCfDYwC8hykwF+J2beo+wJHjgrXF3pkF7ddhURyltr/SagPLo6HXSmadcSUhH4zySKeEic6QJ0Vh64GOUjXZM25il1MFCDCIWp9C45w60qZeGKkaCynO82ETc8zmNoAesO+dZhzl9HV+UnW84YcWP0pn2RLcO4+RIaTp2QGZqIfzmiMzOkLQ44PMV7+UXTz1wDPj/xyPa9v4HVspTCD8loSs0DlAk5AXLlfzk6P48FxQ79lRBZwwHYSJGrYCoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/8DVDviqHU1XxwzkSvyQ7s4QkRaF8PurL+YbwCg8rE=;
 b=PLXBVW0ABui6FFk7WQP56c2EAnMwn0cME6n5ke0W50VNB6GD6aQJpftIYw5pjkMhwmIb2DQ/ziij8D3/7XQkcG6UGPjy5YukdA3CJ0H2k+sHMnv7SLjhrvrKwfYi6EmYzxyaOqW5Ju13QqQFYwbv1XQnsaYedDAtIG0tgPQ2ZQAfnNuvQexpY0xhCuqCJbrRi6T5mTQ19MuYfC43/X9sLi9Fa1Itndo0nBf/50ZJQAZJn31ahim7+sacqMuEomPMSONFlbbdq4hebxb+SePTF9QQSASmJ+ieYo2bR9cp24dVmZzZUBtrnzQJteMjH2K6PXjAU327naHQAUtLzeEXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/8DVDviqHU1XxwzkSvyQ7s4QkRaF8PurL+YbwCg8rE=;
 b=dSClPA9kH+NujgAlcYfk4n+ozKr+W+5IpCC5YfIEHrHdznLd+00SVKFcdUfYI5tg5RX3WrvyORX4etbb5pIuPheNd5Si9ebSa1pLmi5D+Qp09hxmdES5RIvB0w/i9gu0pgQDXfnNn6R6LF8g4XQQiRntyDLa9XVipbq9GB6Ul+jIeaTwadgVKXgNV39F6xDm03VLCHk9aCtvrlngcBhmriztPNBzG28lMAkSwpJUX7pN8XYxJtFKgnZbmev/RsiGpY002vYy1dhM77362dyrg5qmFHCxtRrrw/OkywDPqZFNs7DZYD9odcQATJAuiHB/c5xTS76HEv1lVgG5A2AuvQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10555.eurprd04.prod.outlook.com (2603:10a6:102:48d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 07:54:48 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:54:47 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, Krishna Chaitanya Chundru
	<quic_krichai@quicinc.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll
 of suspend
Thread-Topic: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll
 of suspend
Thread-Index: AQHbqFMD+NNlos4dREitFgMxw9LKubOZ3McAgAC11LCAUsTTgIAYeFJQ
Date: Mon, 16 Jun 2025 07:54:47 +0000
Message-ID:
 <AS8PR04MB86764EDD427DD58911FC08CA8C70A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250408065221.1941928-2-hongxing.zhu@nxp.com>
 <20250408145840.GA231894@bhelgaas>
 <AS8PR04MB86766063C3A9E969234779EB8CB42@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <tv67nul5owjqywhqmekb2cf5q2acyb3jpcfvz6k62jd6sxd5gv@izy7uomaakei>
In-Reply-To: <tv67nul5owjqywhqmekb2cf5q2acyb3jpcfvz6k62jd6sxd5gv@izy7uomaakei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA1PR04MB10555:EE_
x-ms-office365-filtering-correlation-id: 55a857eb-d83a-452f-026c-08ddacab10d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkxaM0hhV1RMUlJBRTR0WjVOMUV0YnROQ2Fqa0ZCY2tFcDJ3VnVNK0Zhbk5h?=
 =?utf-8?B?WDlvUEJiK0ZmaHRIQTY2ZldmQVNXWnJQY2dWckNVYkVocDFpclcrTXlkTWtC?=
 =?utf-8?B?MHFyQzBudy9sRVNJc29wWmZENVVMMjhqVnRSMVBjQTBEWklmbEVpWVhJZlJQ?=
 =?utf-8?B?VTRHUjFvRVNVcWMxd2Q0UGxyNHBJZUZGNnhxRmFJcDV3b2FHcURVTjRLRkZa?=
 =?utf-8?B?dHNPN2swQjVFQXJPV3g2QVRlRG9OelcxYlptMTlZclJNWDRhN1J6MlRWZkdy?=
 =?utf-8?B?dHlpNjhOK1dRbWNTNk9Ed2RkOTNqNDZEZ0MrRXE4b0ZsbzZ4TWUzOXNlQVNI?=
 =?utf-8?B?SkhqQW9KVUp2S3RqeWZpOUNXdURjSUtyWUwzV1JkWlJ0ZmZYYVNjQ0NuSlo3?=
 =?utf-8?B?K08vVXg1elpTOWdBSDJyTisvOG1oL2FNMnd5dElnOWI3V1pEc3Q1YlNoYTB4?=
 =?utf-8?B?NktVUEpHK1p5OU1mREJYai8rWmlkUmNTT0VzbE51UkFSOCtPQmV1NlNkd0xz?=
 =?utf-8?B?L21Bem5HY1VqWDlOOFZsNkkwSGFUMUp2U3Z3Z1RSQ3RCY1ZXU095NmZ4TGd2?=
 =?utf-8?B?N2VlMmhBai9QdTNQZ0xkVFJCMElmR0xnSG5UZ0VRaHc5eDQySWhpSmlRMG91?=
 =?utf-8?B?NExJRTZIdTVLZ2swTm9zcFl4bTl6U2RBUldQeDkreHNqajByWnlJelRkRWVM?=
 =?utf-8?B?SEI3SnRlb1NXZjd3cnRYRytDMnVUZUpFcCtjTDlNTGlJVUZ1MHNWUlRvZndl?=
 =?utf-8?B?WWxEY3l4c3U2b2FjRm1rNDI1bkNNQWNQL0FzaHdydUJERUVUb09ubGhNZjFS?=
 =?utf-8?B?UzU5V01YdEFaWHAvWC9HSU14STBKREJORUljb21tZ1d3S0Z5UlVCdmwxa001?=
 =?utf-8?B?a0o2Yi9rczIrcmorSFp1dUFvcDM2NlNtVVY1eEpFRFZCS0ZYakVOdlk5L01G?=
 =?utf-8?B?T0M3RWdmdkJrMitPdjZUU1ZVbTVleUZhdmtGUVBUdjlvNmdYOWVzc3pzZ0VZ?=
 =?utf-8?B?VkdSckhINlViVnZ3MHZ2QnUrOTdLQS9PZ3J4bXorc2JMci9iSDJkak9uaTJM?=
 =?utf-8?B?dktmRi9HYjJDN3o1Sy9TaTRmRTZlcVorNUVkeTBiaTVNY2liUjRFL3J3UEkx?=
 =?utf-8?B?N1htaXNnbWZ0WEtFUGZUQUVQUDRRbm5hdTJ6OGVSdkRwVGlzaTBkMjVQQXNz?=
 =?utf-8?B?cHgxZGlmTTNMOWQwcGs4Z0FMOTBuK1JhRVEyTHVrb2hmYUhucUVFZlNFaU1T?=
 =?utf-8?B?bmZkcWFEc1NLYUhKRVBlV0UrSit6SjlXOFpDd1lHaDlXV3dkUXo2OUhHQ29D?=
 =?utf-8?B?S0YyMStVN1gzVVNxZkNQVzNydnZlc2JiR3ByS1VHQlZqS2wwTjZkTzNDUy94?=
 =?utf-8?B?OWdRMm5XUzNhMHAxd09vaUVLNWZYY3htRVFGdmc4bkhLSnpMeTBHaWRsRXdq?=
 =?utf-8?B?L011N1B3SlJrTGhQWDlvd0FhRGxTempmWTVzdlBSeTJnUlJSYVU2Q1ZaRlhl?=
 =?utf-8?B?TnlZdldpTDY4Ym1YUTZnSWNueUd2OHFvdXhKdXNrblpRZ2h5c1JSM0JoSHV5?=
 =?utf-8?B?dzduVDQxc1llL2tzK3VKdytScllkdTl5ZHZMUjc5MDU2cU54dFdIa1FVMm83?=
 =?utf-8?B?KzJCN0JKRWNJakdGRW5nWVg0cTVVdERnRHM2UmVHc2RLdFZWUFB6ZHBwTzhq?=
 =?utf-8?B?SUk1ZHRKem54aHd4ZmxZTjZhd3U3RHlaeDNsbWcxL3pxejhVTmhuVWVVRE1T?=
 =?utf-8?B?dFB2NXp0NWx3cDI5WjdnbTlOQTVTQk1jUTVWbzhKaEtqbHIrLzNVM01CSUF5?=
 =?utf-8?B?VWEvWnI0cUgzS3orb0hZVHE2S2VKb2Iza1dvTE5TdTIrYjRKQ2dWaUpkemFB?=
 =?utf-8?B?Q294MUZJSWxIbThma2J4SC95NTZFTC9pMmJEbFVMd2xoT0ZJb0pwU0tNTTQw?=
 =?utf-8?B?K05kbEdWZi9tMmtEdVBoUEVFUzN4aXdmcE1YUjhxdmpNS3BYZEl5M3ZjRDc4?=
 =?utf-8?B?SENwSDhJNGZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bjkxTFJOdjdnODE1KzVxcEJBVmRldHRWZGNNU2o4R2RXL21icTFEUXNYSTB4?=
 =?utf-8?B?SVo5bEVtVHhHWTdDUmlZV3llNkI2RnpCV2d0dnQ2YkNyMDVLSUxVV3Vwa0dG?=
 =?utf-8?B?Y3lNRGVaSFBnUWp6YWRWMTBWSUV6K2RKNDlmbE9MeWh3T2NWcEdmTG1DYTRO?=
 =?utf-8?B?cUFOc0VrazlxVlNWcFpYNzVKTEs3R0g1QUFBbFJyQUJkQzI5bUVJRHVyclg3?=
 =?utf-8?B?WjBGbEhaOFBSOFBCMStoYXhaRDdBYlBQTlNZY0swcHVSRVNudXNXTVdoN2hq?=
 =?utf-8?B?SGRodC9GUVBVUXBlMlJQOGVIVGJGM3p4b0Y3VHF3SUZlUk1ONm12eUdDUHZa?=
 =?utf-8?B?WHUxSVZ1OUtqZWEzMzVwMkRFSkxDQVhSRjNKTTNQN3VLVDd6bVUxZkJEY0w0?=
 =?utf-8?B?aGo0Tm9YU3d2NzhleGF0WFd6QU44MjNQeHMrUmhhTFZ0a2ZMM2J0MzFvaHBz?=
 =?utf-8?B?ckFNb2N0bzNzNlZOejA3Rzk0T1E4VDNiRVcxa0hwbUw2Q1ljalQ5cDh4Zy9Z?=
 =?utf-8?B?c3JiWE9CUnhseCs3YTZ3LzBySUNUdHBaUHI3RHVVRlZsTnQvR2pUUE9WUFlw?=
 =?utf-8?B?REVBQjdYVFhFOExuMUFnM25QNm5vUkFTYTF3Zm1TcEhON0dub2tUcldyYTRC?=
 =?utf-8?B?c0YrWFFxK0o2YWlYbTY5YzZqaWw0TTc3d1EvaC9iak11WDB5MlBOWU43OVR5?=
 =?utf-8?B?OUtRQU5hck9zbkNFSzdPa1MzVy9UWFZ5aERtY1UzOENRbloyWWlBZkNCUWhm?=
 =?utf-8?B?MmR4bklwM1pBbHR5Tk5XdWd4V3NNbU96WlU5U1NTYXpxTGU4TjZxbVRJdjkw?=
 =?utf-8?B?WllKeVhTc2I5bUtYNDRIWEdYMDB3Syt6eis3NTJQRWNxeStlVGpEZWNJT28r?=
 =?utf-8?B?bmwvbWFtTmpqVFJNQnhUUTFOd1ZVZG44aVd3bzROVkhhTG52cXJDbEhSS2tl?=
 =?utf-8?B?eURQdEpFWDIwTk5sZXc0ZGtaUHdFK2xMbzFLSmRBZXJ2WDd6TVp2KzJycGph?=
 =?utf-8?B?aVhjWDBtbU1mSjVFMWtVSkM0UUIyRTI0VnBHRzFxeGNxYWF0Zmsvci9ucWk5?=
 =?utf-8?B?N0F0M0xkcVRHREl1aUtqRGJuTWgycVVrY1ZmdndqSjYvUmpsNFU2MDlwVHRB?=
 =?utf-8?B?empXOWRYM1A4T1JTM3ovOU1oMEJXemJORkdja2hmNTAxUU5HR0FGc3BrWFpT?=
 =?utf-8?B?RFV3aDFIaVRVdUpkVUdLU1grOGtjazFteWdPK050V2VMZ01Ld0t5MHRRejNP?=
 =?utf-8?B?em1hTVNmMlZVc3FhQSt6YzBiS0JKMklmMzlzQ0czR2V6MmU5bnFRTkIxZXVD?=
 =?utf-8?B?dHZXN3VmWTFlaWgwdVhMUlIyWms0a2J4SEl1eUgzQmt4cTV3U0dCRXRZQkY1?=
 =?utf-8?B?eEFUMzhVN2RVQXhrM0ZNOHhtd2U0VzdJeG5UcmlHZ0k5NHlXc2dPQU9YWlZh?=
 =?utf-8?B?aG9nL0NDMy8weU0vQXA1aXlDdlVsY3BCZHlkYzNGUDg4TjVwUzZUZFVZeGJJ?=
 =?utf-8?B?a0VPYldkRnFFSzREb2VyZzA2bDMrcTcyeHpkMWtQYktoWkVQOG1aRURoRGM4?=
 =?utf-8?B?VTBzYVJpMVlLUThrTHd2OFpwc2kybFhBNmFNOFRIVDR0Ym9mVnNwbVFVZGI3?=
 =?utf-8?B?bW9VUWgzdXExMzlTQTVHd1VDMllCTVo1ZjZIbUV1RkNqbkpDbHNQMlY4VVh3?=
 =?utf-8?B?MVZvaEx4NGNGcU9DRXlHbncwYmN6S3kvVWY5NzJsZHVOcW5ITHo3NzNlSzBn?=
 =?utf-8?B?VmNjQ1RTcFJCYlo3WitRRmd0K3RYNVFiMjZkbHdSRk5VMTNQWkFNOUU4WVZj?=
 =?utf-8?B?T0h0dXJIcjI0KzF0NGpvM3VMWGRGY28yeHRjdVdreGt0eVh2anZwTTRodkhm?=
 =?utf-8?B?REpZNmpadjhzQTV0cVdMdDhWUTBHWGxiU1BISFhKY0p6M1VRc2YrbGc2UWk4?=
 =?utf-8?B?ZG96bHdaWnVrUzdIKyt1Nlc0bDA0N2E4Z01kcTBtazdUajhISjZxcERhTTYv?=
 =?utf-8?B?b000bGU1RzBPN3ZZNDZoc2JBVUNsOUxZaURYQmQ4aGtsRW1PdG9WRm9qSlZZ?=
 =?utf-8?B?TmhyQ1RUNjNHZFR2ZEpKUGlidDFCQm0yNHd3LzYzWDFucHZLYjBsQlA3djBC?=
 =?utf-8?Q?dhwxsZ+3ryNCLrtueWFjoAx0C?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a857eb-d83a-452f-026c-08ddacab10d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 07:54:47.8403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hpsI92c1+vTC4JxUlFEhLdn+AOlZYdmN4hLYbQhBmeYqqrjR0sQud0NGARGII2emQi+gE/87+dvnErQqzk3gEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10555

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBtYW5pdmFubmFuLnNhZGhhc2l2
YW1AbGluYXJvLm9yZw0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IFNl
bnQ6IDIwMjXlubQ25pyIMeaXpSAxOjQ3DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiBDYzogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPjsgS3Jp
c2huYSBDaGFpdGFueWEgQ2h1bmRydQ0KPiA8cXVpY19rcmljaGFpQHF1aWNpbmMuY29tPjsgamlu
Z29vaGFuMUBnbWFpbC5jb207IEZyYW5rIExpDQo+IDxmcmFuay5saUBueHAuY29tPjsgbC5zdGFj
aEBwZW5ndXRyb25peC5kZTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd0BsaW51eC5jb207
IHJvYmhAa2VybmVsLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gc2hhd25ndW9Aa2VybmVs
Lm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBm
ZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvNF0g
UENJOiBkd2M6IEFkZCBxdWlyayB0byBmaXggaGFuZyBpc3N1ZSBpbiBMMiBwb2xsIG9mDQo+IHN1
c3BlbmQNCj4gDQo+IE9uIFdlZCwgQXByIDA5LCAyMDI1IGF0IDAyOjMxOjIyQU0gKzAwMDAsIEhv
bmd4aW5nIFpodSB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAy
MDI15bm0NOaciDjml6UgMjI6NTkNCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPg0KPiA+ID4gQ2M6IGppbmdvb2hhbjFAZ21haWwuY29tOyBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT47DQo+ID4gPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNp
QGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsNCj4gPiA+IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBs
aW5hcm8ub3JnOyByb2JoQGtlcm5lbC5vcmc7DQo+ID4gPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBz
aGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4g
PiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvNF0gUENJOiBkd2M6IEFkZCBxdWlyayB0byBmaXgg
aGFuZyBpc3N1ZSBpbg0KPiA+ID4gTDIgcG9sbCBvZiBzdXNwZW5kDQo+ID4gPg0KPiA+ID4gT24g
VHVlLCBBcHIgMDgsIDIwMjUgYXQgMDI6NTI6MThQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gPiA+IGkuTVg2UVAgUENJZSBpcyBoYW5nIGluIEwyIHBvbGwgZHVyaW5nIHN1c3BlbmQg
d2hlbiBvbmUgZW5kcG9pbnQNCj4gPiA+ID4gZGV2aWNlIGlzIGNvbm5lY3RlZCwgZm9yIGV4YW1w
bGUgdGhlIEludGVsIGUxMDAwZSBuZXR3b3JrIGNhcmQuDQo+ID4gPiA+DQo+ID4gPiA+IFJlZmVy
IHRvIEZpZ3VyZTUtMSBMaW5rIFBvd2VyIE1hbmFnZW1lbnQgU3RhdGUgRmxvdyBEaWFncmFtIG9m
IFBDSQ0KPiA+ID4gPiBFeHByZXNzIEJhc2UgU3BlYyBSZXY2LjAuIEwwIGNhbiBiZSB0cmFuc2Zl
cnJlZCB0byBMRG4gZGlyZWN0bHkuDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGluY2x1ZGUgdGhlIHNl
Y3Rpb24gbnVtYmVyLiAgU2VjdGlvbiBudW1iZXJzIGFyZSBlYXN5IHRvIGZpbmQNCj4gPiA+IGJl
Y2F1c2UgdGhleSdyZSBpbiB0aGUgc3BlYyBQREYgY29udGVudHMsIGJ1dCBmaWd1cmVzIGFyZSBu
b3QuDQo+ID4gPiBFLmcuLCAiUENJZSByNi4wLCBzZWMgNS4yLCBmaWcgNS0xIg0KPiA+ID4NCj4g
PiBPa2F5LCB3b3VsZCBhZGQgdGhlbSBsYXRlci4NCj4gPg0KPiA+ID4gPiBJdCdzIGhhcm1sZXNz
IHRvIGxldCBkd19wY2llX3N1c3BlbmRfbm9pcnEoKSBwcm9jZWVkIHN1c3BlbmQgYWZ0ZXINCj4g
PiA+ID4gdGhlIFBNRV9UdXJuX09mZiBpcyBzZW50IG91dCwgd2hhdGV2ZXIgdGhlIGx0c3NtIHN0
YXRlIGlzIGluIEwyIG9yDQo+ID4gPiA+IEwzIG9uIHNvbWUgUE1FX1R1cm5fT2ZmIGhhbmRzaGFr
ZSBicm9rZW4gcGxhdGZvcm1zLg0KPiA+ID4NCj4gPiA+IE1heWJlIHdlIGRvbid0IG5lZWQgdG8g
cG9sbCBmb3IgdGhlc2UgTFRTU00gc3RhdGVzIG9uICphbnkqDQo+ID4gPiBwbGF0Zm9ybSwgYW5k
IHdlIGNvdWxkIGp1c3QgcmVtb3ZlIHRoZSBwb2xsIGFuZCB0aW1lb3V0IGNvbXBsZXRlbHk/DQo+
ID4gPg0KPiA+IFllcywgSSB1c2VkIHRvIHN1Z2dlc3QgcmVtb3ZlIHRoZSBMMiBwb2xsIGFuZCB0
aW1lb3V0IGluIHRoZSBmb2xsb3dpbmcNCj4gPiBkaXNjdXNzaW9uLg0KPiA+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxr
bWwNCj4gPiAub3JnJTJGbGttbCUyRjIwMjQlMkYxMSUyRjE4JTJGMjAwJmRhdGE9MDUlN0MwMiU3
Q2hvbmd4aW5nLnpodQ0KPiAlNDBueHAuYw0KPiA+DQo+IG9tJTdDNTlkY2JmMjYzMmIzNDBlNzQ4
YmIwOGRkYTA2YjM0ZTElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWMNCj4gNWMzMDE2DQo+ID4N
Cj4gMzUlN0MwJTdDMCU3QzYzODg0MzEwNDQ5OTY4MjkyOCU3Q1Vua25vd24lN0NUV0ZwYkdac2Iz
ZDhleUpGYg0KPiBYQjBlVTFoY0cNCj4gPg0KPiBraU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01D
SXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95DQo+ID4NCj4gZlElM0Ql
M0QlN0MwJTdDJTdDJTdDJnNkYXRhPWVFWFNkMTRvNlhZSEMwd3cwNk5hRkgyTDdQciUyRmdUDQo+
IFAyRHhyNzd4ZDUNCj4gPiBacDAlM0QmcmVzZXJ2ZWQ9MA0KPiA+IEhpIEtyaXNobmE6DQo+ID4g
SXMgaXQgZmVhc2libGUgdG8gZWxpbWluYXRlIHRoZSBMMiBwb2xsIGFuZCB0aW1lb3V0IGluIHRo
aXMgY29udGV4dD8NCj4gPg0KPiANCj4gU3BlYyByNi4wLCBzZWMgNS4yIG1hbmRhdGVzIEwyL0wz
IFJlYWR5IHN0YXRlOg0KPiANCj4gIkwyL0wzIFJlYWR5IHRyYW5zaXRpb24gcHJvdG9jb2wgc3Vw
cG9ydCBpcyByZXF1aXJlZC4iDQo+IA0KPiBBbHNvIGluIG1hbnkgcGxhY2VzLCBpdCBzdWdnZXN0
cyB3YWl0aW5nIGZvciBMMi9MMyBSZWFkeSBzdGF0ZSBiZWZvcmUgcG93ZXJpbmcNCj4gZG93biB0
aGUgZGV2aWNlLiBTbyBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCBqdXN0IHJlbW92ZSB0aGUgcG9s
bCBmb3IgYWxsDQo+IHBsYXRmb3Jtcy4NCj4gDQpIaSBNYW5pOg0KVGhhbmtzIGZvciB5b3VyIHJl
dmlldy4gDQpGb3Igc29tZSBMMiBQT0xMIGJyb2tlbiBwbGF0Zm9ybXMgKGUueCBpLk1YNlFQIFBD
SWUpLiBDYW4gd2UganVzdCB3YWl0DQogZm9yIGEgZW5vdWdoIGxvbmcgdGltZSBoZXJlIHdpdGhv
dXQgdGhlIEwyL0wzIHN0YXRlIHBvbGxpbmc/DQpCZWNhdXNlIHRoYXQgYSByZWNvbW1lbmRlZCAx
MG1zIG1heCB3YWl0IHJlZmVyIHRvIFBDSWUgcjYuMCwgc2VjIDUuMy4zLjIuMQ0KIFBNRSBTeW5j
aHJvbml6YXRpb24uDQoNCj4gPiA+IElmIG5vdCwgd2UgbmVlZCB0byBleHBsYWluIHdoeSBpdCBp
cyBzYWZlIHRvIHNraXAgdGhlIHBvbGwgb24gc29tZSBwbGF0Zm9ybXMuDQo+ID4gPiAiU2tpcHBp
bmcgdGhlIHBvbGwgYXZvaWRzIGEgaGFuZyIgaXMgbm90IGEgc3VmZmljaWVudCBleHBsYW5hdGlv
bi4NCj4gPiA+DQo+IA0KPiBTbyB0aGUgaXNzdWUgaXMgdGhhdCB0aGUgZGV2aWNlIGRvZXNuJ3Qg
dHJhbnNpdGlvbiB0byBMMi9MMyBSZWFkeSBzdGF0ZSBhbmQgdGhlDQo+IGhvc3QgcGxhdGZvcm0g
anVzdCAnaGFuZ3MnPyBEbyB3ZSBrbm93IHdoeSB0aGUgaGFuZyBoYXBwZW5zPw0KPiANCkkgY2Fu
4oCZdCBmaW5kIHRoZSBleGFjdCByb290IGNhdXNlIG9mIGhhbmQgYWZ0ZXIgSSBsb29rZWQgdGhy
b3VnaCB0aGUNCiB0cmFjZSBsb2cgY2FwdHVyZWQgYnkgdGhlIHByb3RvY29sIGFuYWx5emVyLiBX
aXRob3V0IHRoZSBMMiBwb2xsIGJ5IFNXLA0KIHRoZSBQTV9FbnRlcl9MMjMgRExMUChSPC0pIGFu
ZCBQTV9SZXF1ZXN0X0FjayAgRExMUCAoUi0+KSBjYW4gYmUNCiBjYXB0dXJlZCBhZnRlciBQTUVf
VHVybl9PZmYgaXMga2lja2VkIG9mZiwgYW5kIFBNRV9UT19BY2sgaXMgcmVjZWl2ZWQuDQoNClNp
bmNlIHRoZSBkZXNpZ25lciBvZiB0aGUgaS5NWDZRIFBDSWUgY2FuJ3QgYmUgY29udGFjdGVkIGFu
eW1vcmUuIEkgZG9uJ3QNCmtvbncgd2hhdCdzIGdvaW5nIG9uIHdoZW4gZG8gdGhlIEwyIFBPTEwu
IEkgc3VzcGVjdCB0aGF0IHRoZSBMVFNTTV9TVEFURSANCnJlZ2lzdGVycyBhcmUgbm90IGFjY2Vz
c2libGUgYW55bW9yZSBhZnRlciB0aGUgUE1fRW50ZXJfTDIzL1BNX1JlcXVlc3RfQWNrDQogaGFu
ZHNoYWtlIG9uIGkuTVg2USBQQ0llLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+ID4g
PiBzL2x0c3NtL0xUU1NNLw0KPiA+IE9rYXkuDQo+ID4gPg0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gPiA+IEBAIC05
NDcsNyArOTQ3LDcgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAq
cGNpKQ0KPiB7DQo+ID4gPiA+ICAJdTggb2Zmc2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHko
cGNpLCBQQ0lfQ0FQX0lEX0VYUCk7DQo+ID4gPiA+ICAJdTMyIHZhbDsNCj4gPiA+ID4gLQlpbnQg
cmV0Ow0KPiA+ID4gPiArCWludCByZXQgPSAwOw0KPiA+ID4gPg0KPiA+ID4gPiAgCS8qDQo+ID4g
PiA+ICAJICogSWYgTDFTUyBpcyBzdXBwb3J0ZWQsIHRoZW4gZG8gbm90IHB1dCB0aGUgbGluayBp
bnRvIEwyIGFzDQo+ID4gPiA+IHNvbWUgQEANCj4gPiA+ID4gLTk2NCwxNSArOTY0LDE3IEBAIGlu
dCBkd19wY2llX3N1c3BlbmRfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiA+ID4gIAkJ
CXJldHVybiByZXQ7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPg0KPiA+ID4gPiAtCXJldCA9IHJlYWRf
cG9sbF90aW1lb3V0KGR3X3BjaWVfZ2V0X2x0c3NtLCB2YWwsDQo+ID4gPiA+IC0JCQkJdmFsID09
IERXX1BDSUVfTFRTU01fTDJfSURMRSB8fA0KPiA+ID4gPiAtCQkJCXZhbCA8PSBEV19QQ0lFX0xU
U1NNX0RFVEVDVF9XQUlULA0KPiA+ID4gPiAtCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMv
MTAsDQo+ID4gPiA+IC0JCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7
DQo+ID4gPiA+IC0JaWYgKHJldCkgew0KPiA+ID4gPiAtCQkvKiBPbmx5IGxvZyBtZXNzYWdlIHdo
ZW4gTFRTU00gaXNuJ3QgaW4gREVURUNUIG9yIFBPTEwgKi8NCj4gPiA+ID4gLQkJZGV2X2Vycihw
Y2ktPmRldiwgIlRpbWVvdXQgd2FpdGluZyBmb3IgTDIgZW50cnkhIExUU1NNOg0KPiAweCV4XG4i
LA0KPiA+ID4gdmFsKTsNCj4gPiA+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiA+ID4gKwlpZiAoIWR3
Y19jaGVja19xdWlyayhwY2ksIFFVSVJLX05PTDJQT0xMX0lOX1BNKSkgew0KPiA+ID4gPiArCQly
ZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLA0KPiA+ID4gPiAr
CQkJCQl2YWwgPT0gRFdfUENJRV9MVFNTTV9MMl9JRExFIHx8DQo+ID4gPiA+ICsJCQkJCXZhbCA8
PSBEV19QQ0lFX0xUU1NNX0RFVEVDVF9XQUlULA0KPiA+ID4gPiArCQkJCQlQQ0lFX1BNRV9UT19M
Ml9USU1FT1VUX1VTLzEwLA0KPiA+ID4gPiArCQkJCQlQQ0lFX1BNRV9UT19MMl9USU1FT1VUX1VT
LCBmYWxzZSwgcGNpKTsNCj4gPiA+ID4gKwkJaWYgKHJldCkgew0KPiA+ID4gPiArCQkJLyogT25s
eSBsb2cgbWVzc2FnZSB3aGVuIExUU1NNIGlzbid0IGluIERFVEVDVCBvciBQT0xMICovDQo+ID4g
PiA+ICsJCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEg
TFRTU006DQo+ID4gPiAweCV4XG4iLCB2YWwpOw0KPiA+ID4gPiArCQkJcmV0dXJuIHJldDsNCj4g
PiA+ID4gKwkJfQ0KPiA+ID4gPiAgCX0NCj4gPiA+ID4NCj4gPiA+ID4gIAkvKg0KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgN
Cj4gPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0K
PiA+ID4gPiBpbmRleCA1NmFhZmRiY2RhY2EuLjA1ZmU2NTRkNzc2MSAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiA+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4g
PiA+ID4gQEAgLTI4Miw2ICsyODIsOSBAQA0KPiA+ID4gPiAgLyogRGVmYXVsdCBlRE1BIExMUCBt
ZW1vcnkgc2l6ZSAqLw0KPiA+ID4gPiAgI2RlZmluZSBETUFfTExQX01FTV9TSVpFCQlQQUdFX1NJ
WkUNCj4gPiA+ID4NCj4gPiA+ID4gKyNkZWZpbmUgUVVJUktfTk9MMlBPTExfSU5fUE0JCUJJVCgw
KQ0KPiA+ID4gPiArI2RlZmluZSBkd2NfY2hlY2tfcXVpcmsocGNpLCB2YWwpCShwY2ktPnF1aXJr
X2ZsYWcgJiB2YWwpDQo+ID4gPg0KPiA+ID4gTWF5YmUganVzdCBteSBwZXJzb25hbCBwcmVmZXJl
bmNlLCBidXQgSSBkb24ndCBsaWtlIHRoaW5ncyBuYW1lZCAiY2hlY2siDQo+ID4gPiBiZWNhdXNl
IHRoYXQganVzdCBtZWFucyAibG9vayBhdCI7IGl0IGRvZXNuJ3QgZ2l2ZSBhbnkgaGludCBhYm91
dA0KPiA+ID4gaG93IHRvIGludGVycHJldCB0aGUgcmVzdWx0IG9mIGxvb2tpbmcgYXQgaXQuDQo+
ID4gPg0KPiA+IEhvdyBhYm91dCBkd2NfbWF0Y2hfcXVpcmsocGNpLCB2YWwpIChwY2ktPnF1aXJr
X2ZsYWcgJiB2YWwpPw0KPiA+DQo+IA0KPiBNYXliZSBqdXN0IGR3Y19xdWlyaygpPw0KPiANCj4g
LSBNYW5pDQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+
4K6a4K6/4K614K6u4K+NDQo=

