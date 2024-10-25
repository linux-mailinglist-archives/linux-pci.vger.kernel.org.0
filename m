Return-Path: <linux-pci+bounces-15266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB109AFACC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFB71F21E61
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 07:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD89C1B393B;
	Fri, 25 Oct 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OMBOZx5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14282166F1B;
	Fri, 25 Oct 2024 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840513; cv=fail; b=o7Y6aNQNrLu+ucvjTxHWPBiqCZPRxSK5XTD/2gArybwAtotWoFv/niDci4ajkmWA/zpjod07YnduWdNBn5m4pqYvwwk92RRmvGl4DEAscAE1OFy79vzzjIdAVwr6v2lTjebqWLGb44KtxPNsKlYk6DyW6+ClvQxsn77RMsG3gHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840513; c=relaxed/simple;
	bh=3fsGuMZS3V1INg6klUi+iBG3pQL/oFGqYy12QqOvAo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pcmztCwc6Q75YBEl63ZXtljuIIGJMfWdOMjfO7mUn4WuSx//RXcaKkoLKClO5FBsa+wl6EkUT/sYbpD7udjNxVxhQptDUxg0C6N9pbaFMbR622dvSTl8CvEJrUtBQd9P3txKJrn1D8SktJ/vYZgFxjRgjwOj2gFsnagxvZmD43g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OMBOZx5t; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HS5fPRU4tUCafxgQs8kMWuBP0Bwdgbe6+FXcyHwpb9dGSqMKQICx/Uv9eWpiF669OgMdmwOvgofyRQB2LXkNXGVoC8MY8I0TAM7fYr/y3kxPI682jpeV3ZkBqDhZDCCxpMEUoQUSlY+CRhcV++kwd87FZa/CfuDglrEdafOZW4Sink5Zn6zmR30RDSxLbIjvqgjW7/C+K6OJLFu1m1p+MMg4V/6qZyYFgVdg/R8NkPhuk1mkwcsaU57qNPWgxeDJiWuWxDfXHsnKZeyDLtcIUpHvEOtIT+Ma8nnL4MtG4+HpSX4xWV72WoeKT9zf3LbUnjzcok/Vk3Lx8GL3V0NchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fsGuMZS3V1INg6klUi+iBG3pQL/oFGqYy12QqOvAo4=;
 b=FHEX42ANyLOs+z/yQXR7iX1cURwbNFDcSjlhktCzokqKqIeiQI8pzCutNQbiejoMCarWIpdrwDTabthOUMXtIKLr9qltVoWhLyJWylmSCGWZmG5nqldmkY6pu+P8CbcA7iLIl4e6keLhDCE2M83956vyVH8Fhx/H54v5COnD5B7lRupzpQE9Sht2o7b6Z9dK3z/5nXdD8Sx/EU1n7YJlYiMRglZymMBnhHQ/gNTOVfrret2p46OblkOLhQ9SmwKVlPXmj5fN2QQ1Iov/YSnMnkival+fLwGXicgs98ETnH3lbVvzM5AUBLWsEpGN2q7wS9RmCh3WFIbYIWxFW3UiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fsGuMZS3V1INg6klUi+iBG3pQL/oFGqYy12QqOvAo4=;
 b=OMBOZx5t26O+3X5fRKV9i8HDozaCd+gxDjLN3khaS2h8O0zCutz1OzRxJWeBIEQiLfHAG3LsSoXuACi1S3wr4HBQgtBB/bNmpKFO70Qx2/8UGLaL8m88WhzlUMHSFeNDljJ3KeUEKz0eTJANVa06U+oxrf0M9pLq9w1RGWzOEP+pCW8Apo0FgBsPIMw++22biP3EBAJNXJvQs/iTwZeRWxtnvkxEFdnYx9eB9pkOfnW32GrWO5fpdvOKbBiAHnAgXEa3qxrKKjZoo8Phqdv6jrD6Owu5n/6z/KtC0KN1L2xVCYeeuVVP+HmkDpV4shp+N3BXf7iUxeGKyGHgpgU+RA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9206.eurprd04.prod.outlook.com (2603:10a6:20b:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 25 Oct
 2024 07:15:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 07:15:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index:
 AQHbJEi1opWCvzFL8kS18Y10TWXurLKT6McAgAAQObCAABEvAIAAEJ5AgAHNioCAASmHQA==
Date: Fri, 25 Oct 2024 07:15:07 +0000
Message-ID:
 <PAXPR04MB85108DAF7FA67BC1B36CB6FF884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <f7064783-983a-44bd-a9db-fd20f4e50e33@kernel.org>
 <PAXPR04MB85101A3DFF08F8C8DD7513F8884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <a1528ced-930c-4e5d-91e6-6be5f5363e8d@kernel.org>
In-Reply-To: <a1528ced-930c-4e5d-91e6-6be5f5363e8d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB9206:EE_
x-ms-office365-filtering-correlation-id: 459a02b0-9530-4cf1-3dd9-08dcf4c4c18d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RDF6ME1vU2ZvZWcyK1pMLzI3ckJjUWlHVS96V1o2TFpKeWNwVkUvNjNMZkZQ?=
 =?utf-8?B?WW1rbkNXQXBJcVdxb2JTNGlMb2F2WU1XR2RIYnh2U1dPUjF6bXgvWnpTVW9y?=
 =?utf-8?B?Vit6Zk8yS0dGQ3Z1VUlDY0trYUcydm0yRjNobnIwSXFZVnBJWElkeVYwODVQ?=
 =?utf-8?B?WjhRZFpKWXo5WFFGaFZ2dzlVM053dlNtRTEzR3BDV0lKS3Z0Y1kxY1BJdk41?=
 =?utf-8?B?TExGNnlGdzByQXFpUmlqSTdnZC96ZnpQUmM3d3Y4ei90Z3N0T0JZZC9DM1c1?=
 =?utf-8?B?NURYZXdiam42cnZHcnhtWi9xeDd3QkowL1lmc01GMUxSSXp5ejlId2Y5U01s?=
 =?utf-8?B?cTI4Y1hBVHFSREl1NmhldDBJUWJFL0FIRG5vQURmN21tc01lN3JOOUhkLzZ4?=
 =?utf-8?B?aFRvaVdDMkcxWngrUE1RWEZIL0dXTTNNSThLdVpCbE5qd2FLQnNIUlNOYklo?=
 =?utf-8?B?MkVrZ3F0eFdvbm5pOTQ4TzM2MUhBMTlCeTJNUVdmMVdjS3JBUU1rTmFVY0Yy?=
 =?utf-8?B?cmZSd0wydmtienMrNDl2cUxHbFVROWdmbnhOWDRBbVQ1NDNWdm1ycXBxTGFR?=
 =?utf-8?B?V3dHVUh2VjI1R09POHE3Unc0Wkh5Ymd2aDVKbDc2UmZIU3g1a1FLMjY5N0FU?=
 =?utf-8?B?UVNYOVVqYlFIOTl1ZEpvQ1pGSEQxTlpjMEkrOVZGR0JNL1BLM3Fkc2NiUkxo?=
 =?utf-8?B?S3lkSVp2ODRLcXNIWEU5OHEvbWUxamp1TGlnbmFINVlFNlFZaDdQWUVMM3Np?=
 =?utf-8?B?WXZ0dURibUJHOUY2VHBUcHkyTnh0MU90V3pBQ2QzUTg0aEIvK3c2Z1B1dVJI?=
 =?utf-8?B?N1N1TjhZOXRWelRwVS81emxLeFB2UEN0MERnVWphUTVHbXUwMXFQT3lGekZD?=
 =?utf-8?B?dGZxN3FXQTVwK2Ixc2JoUFZMc0tsM29OMWRxUzhpa2VjTXJZcmtoaHg4RFM1?=
 =?utf-8?B?eFZ0UnQvZUNrZ0VQVCtsVzkzVi9ZNjlQZ1BVeU9jSTNJOVpPcDdmcnI3K1hH?=
 =?utf-8?B?NCtHWHVqcUpXM3hRNWJra2JIVnhpNU1kSS9vNEdjeVBHbzRrTW5TS2s1UWov?=
 =?utf-8?B?MnBBd1NoMGFsRkNkMllCSkpUU3B0RXUzcGhqdTlFUDBNNklkVU5BNEVVL1Ft?=
 =?utf-8?B?Vnd5dzZOdDJUSDFkU1hHVFlFVzhlUHdDa0Z4N0JQaDd3c2tvM3BNQzRrUGpv?=
 =?utf-8?B?cko2eHQwQ05valIzYjIzWTRkeTFXT1B1ZlppcWNXNEdCV2FXTG44SE81aUtT?=
 =?utf-8?B?UkhsR1k5alV5UGZ5YWRNeENTc2FWSVY0bTF1NTlPak1YSVRmVFpBNFJ2OW1Q?=
 =?utf-8?B?RGdmdkJjTmlMSkxiUFVUdFc2VXhIYjZtTDJVd0hwVnR1R01tbCs4YUl4djEw?=
 =?utf-8?B?ZHA5NzRhQnNXUG8wRGRIZnh5YVF4bUJPckR1ZVBIM2s2aTZaNWJ3cUt4THJE?=
 =?utf-8?B?cGdNZVZpOTJpejFpam9Ta3lkYkhqYnZJcUdwbENyS09nZlVobHhaZ1MwTDhu?=
 =?utf-8?B?VzVVSm53Vy9ydFllSGFYZzdHYU9SQmVVMnVmc0kySGh6UWRWd1ZNbm1VcG1R?=
 =?utf-8?B?VGl4emlSY1E4TTJWSENmYWErQXRpT3F2cWQ5cUtyT2djK3BKTFkxS3N3cDNn?=
 =?utf-8?B?WlVPMW9ONFdGWWViWUpFZHVTQ29BaDJPcmNpSzAvb0hBbVVNbnZoYzdteEpz?=
 =?utf-8?B?YllBRzlmK0FKZmVFeThmS3RrcG5oZmRWdDNXMy9lLzUweS9vcEYwN2tEenc2?=
 =?utf-8?B?T2FPYnRGWWVtSzdKTzc5TU5xOVZNUldlZnZ1R04wUE5kM2VVOTVycTJURHlW?=
 =?utf-8?Q?oFJkRA1pUSWX4wnA2z82uI9MEYKvHqxnkFGoM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGROSEtSQkZKclYxTXZyMjVFajJBNXErWDNUZG5wWTJNZzl3bXg0M0MrOGdv?=
 =?utf-8?B?TmtXU0xTTEpVLzc1dkJBaHlpWGtRWmFsc3FEaXRla0NqZktKT3lkUFhRZjRw?=
 =?utf-8?B?cmx0a2pqWkVGMjJTenF4V2NGNXo0c2V4Wm1QalBjZVhncDhpVE4rMFh2U0JS?=
 =?utf-8?B?c2FpMzlnamcyN3lZQVVkaWhSaGFvbzR5bTRJcCtvMTY1dFN1OU9YQ00wczdp?=
 =?utf-8?B?U2E0TDdySjlqdVVzUVNTVVNna2JxS2MzL2RaaWE4VWcvWjZGSUhBaFlmK05y?=
 =?utf-8?B?aW5oc0VSMlpMK0ZaK2tEOHFsaWxGR0I2Nk5YZ1lyOUlYTnprSTRlaTRuUXFC?=
 =?utf-8?B?MlNsWlhvU3VNa0I5b1dhYUJicUM2c0hsaVI1VWtOUmNSRTZKSUhjOWNKY2pO?=
 =?utf-8?B?K2I1dUlGS05CT1V4aTF6dkJoMlhoamxHSVlWT1FaTzdxZEd4bFZ3QzRGRTl6?=
 =?utf-8?B?TGZHNjdhbnFJZGNBWEZrTjBJSVQvWC92dzZqWldvTHA2ejVXblI2SnZSMVEr?=
 =?utf-8?B?Zm1SZm80WFV5V0ZWSFhZaFJINnppUnpYNkg5YTRFdWFEaXBudGZZYUtncjE2?=
 =?utf-8?B?elplSHdBRVNrZ2REOG5FandRQURMYmR2TTd1NDlmVXFSV0ZPcEx4emVuMVJt?=
 =?utf-8?B?VWxhZHpHamRQS0t1TDhXeEw3MzByTlBQSTZlemVqSUJmRU5JcmNmNmZyRldp?=
 =?utf-8?B?TnVTNG9BUUlqRWJUVFhDbDluRm9YVnFhTEpwSnhrWVp0SmZ5UEVIVGNVSlQr?=
 =?utf-8?B?UTlQYUVvRHpTY1ZwQXErVU9qb29IWVVOQUgrSm1nQnVXbUZpQmJWc0xvTXpo?=
 =?utf-8?B?dE85ZktDaW1nb3NTZ1NYZ3BsL2dIWHIveXR0c3o1UUxpV0JTL2E3V2RtdlFv?=
 =?utf-8?B?MDE0b01mU0FpV0Y3VXY2cHE3Sy84TXB1UGNwallYQ3VmNllkdVM3cTNpbWV4?=
 =?utf-8?B?ZmVsOWlncUhxNG91bzdXRk9NWFRRdTlDM0FwalV5QWkyT0RLdno5V21jZUM3?=
 =?utf-8?B?WHY4Q3VZN2N3UTV2bkRnaDBpeE1idjZHcW1vdDZ4a3QyY0Y4R1ptZE9DQ0xq?=
 =?utf-8?B?UXdmK3hRQ2ZEdG9LTDBwdkcwNzMxbDJaNG1jbFdhUEpwZzdxNnhzZmNhTm9t?=
 =?utf-8?B?SEVtVk9hajBrUGVnYlVKRjMrYmZaNExNU3ZLSkgvRlNXZVh1K0p2dU1ocXBL?=
 =?utf-8?B?WEQzZHBlZGFrU21rcElmMzFIZ1BXRkN4RUUxczYwbTBLYy90TkoveXkzSFZN?=
 =?utf-8?B?aWJvc2hnQjRvanVOTjNGYTZ3dmVZSFdMMGZ2Nm1sNmR4VXRCbHJ0UFZ0T1Vn?=
 =?utf-8?B?STlJNXQ2eGdqZllLdHRzQTIzTjFYdXlUSXZIZjkzZ3p0VEZyTnF6NUF2ZVNN?=
 =?utf-8?B?cGdWVGozbHhBVlRXSjVPTkRVTE12L2hodmFKbVJzV2ttZzcvckswVFI0UFh0?=
 =?utf-8?B?dEJWT1FrSGtoUDFPbVpoUVVwRFQ3YkhobkxWbGo5UlpROWlMeWJ1WWtHcDBh?=
 =?utf-8?B?WmJhRm9aUHpFdExxcjV3UjBTQnFKRTFrL0pRc0EwUjdjRkVadTRQbTJ0Mk1y?=
 =?utf-8?B?UldBUDk1SlAwdWExYzBQQjBUaC8yUDJkUUgzN0xMS1hnU3Zaa2lpcVlEVUNE?=
 =?utf-8?B?ekFTeXU0UGM0RkxlNE9xM2wvczIyNm9NaERqTVk5bUd5bUZPTUVYQ0pYSkdk?=
 =?utf-8?B?aHBVVW1mVUNJWHpiZ3VhWlNrMTBUaTF2WE40QnlZNmZyZ055dHhlNkxHZmVJ?=
 =?utf-8?B?SlY2Zk40c215UlFoeXR1Q1A0RzdZWHNLZERiTURQY0pCenJ4WHVYby80K3VZ?=
 =?utf-8?B?YThWcENXOGI1Wm5TUzBrbWxsUCt5Q096WDJCQVF4cFd2aXFkdW1qRXdjdmNu?=
 =?utf-8?B?VFBMOGdJUzdzaldienpPd0NxWFhod3hkNjZ3cFZ0QVRIMjNXdE4yNG5VdElr?=
 =?utf-8?B?RGxGQysyNWd4MjBGNmdTWDJ1U0UxelZQc2NBbC9JZlJDdzFYbEZBdFJjZEpM?=
 =?utf-8?B?djlyQldsWEhlYlpWNG9LMStneDZWRVhoYlV4bDFnSCtJdStwME1PV3VCMFRP?=
 =?utf-8?B?bjM2eUJwL0ExK0JQMUVtN1J5dktQbEJJdm1VVkt3MVdROEw3aW92S1Q0dlNn?=
 =?utf-8?Q?PdN8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459a02b0-9530-4cf1-3dd9-08dcf4c4c18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 07:15:07.7571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74dbWR81vWqGqugmsjmZ1octLqPzOaPIalVJWHItVf1RQS2gzRNvil+uK3x9bcYv8qinCsNoOa8oYeuS8T+ffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9206

PiBPbiAyMy8xMC8yMDI0IDEyOjAzLCBXZWkgRmFuZyB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJu
ZWwub3JnPg0KPiA+PiBTZW50OiAyMDI05bm0MTDmnIgyM+aXpSAxNjo1Ng0KPiA+PiBUbzogV2Vp
IEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBl
ZHVtYXpldEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+ID4+IHBhYmVuaUByZWRoYXQu
Y29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gPj4gY29ub3IrZHRA
a2VybmVsLm9yZzsgVmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47DQo+
ID4+IGNvbm9yK0NsYXVkaXUNCj4gPj4gTWFub2lsIDxjbGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsg
Q2xhcmsgV2FuZw0KPiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsNCj4gPj4gRnJhbmsgTGkgPGZy
YW5rLmxpQG54cC5jb20+OyBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7DQo+ID4+IGxpbnV4
QGFybWxpbnV4Lm9yZy51azsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgaG9ybXNAa2VybmVsLm9yZzsN
Cj4gPj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsNCj4gPj4g
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGFsZXhhbmRlci5zdGVpbkBldy50cS1n
cm91cC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCBuZXQtbmV4dCAwMy8xM10gZHQt
YmluZGluZ3M6IG5ldDogYWRkIGJpbmRpbmdzDQo+ID4+IGZvciBORVRDIGJsb2NrcyBjb250cm9s
DQo+ID4+DQo+ID4+IE9uIDIzLzEwLzIwMjQgMTA6MTgsIFdlaSBGYW5nIHdyb3RlOg0KPiA+Pj4+
PiArbWFpbnRhaW5lcnM6DQo+ID4+Pj4+ICsgIC0gV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+
DQo+ID4+Pj4+ICsgIC0gQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0KPiA+Pj4+
PiArDQo+ID4+Pj4+ICtwcm9wZXJ0aWVzOg0KPiA+Pj4+PiArICBjb21wYXRpYmxlOg0KPiA+Pj4+
PiArICAgIGVudW06DQo+ID4+Pj4+ICsgICAgICAtIG54cCxpbXg5NS1uZXRjLWJsay1jdHJsDQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gKyAgcmVnOg0KPiA+Pj4+PiArICAgIG1pbkl0ZW1zOiAyDQo+ID4+
Pj4+ICsgICAgbWF4SXRlbXM6IDMNCj4gPj4+Pg0KPiA+Pj4+IFlvdSBoYXZlIG9uZSBkZXZpY2Us
IHdoeSB0aGlzIGlzIGZsZXhpYmxlPyBEZXZpY2UgZWl0aGVyIGhhcw0KPiA+Pj4+IGV4YWN0bHkN
Cj4gPj4+PiAyIG9yIGV4YWN0bHkgMyBJTyBzcGFjZXMsIG5vdCBib3RoIGRlcGVuZGluZyBvbiB0
aGUgY29udGV4dC4NCj4gPj4+Pg0KPiA+Pj4NCj4gPj4+IFRoZXJlIGFyZSB0aHJlZSByZWdpc3Rl
ciBibG9ja3MsIElFUkIgYW5kIFBSQiBhcmUgaW5zaWRlIE5FVEMgSVAsDQo+ID4+PiBidXQgTkVU
Q01JWCBpcyBvdXRzaWRlIE5FVEMuIFRoZXJlIGFyZSBkZXBlbmRlbmNpZXMgYmV0d2VlbiB0aGVz
ZQ0KPiA+Pj4gdGhyZWUgYmxvY2tzLCBzbyBpdCBpcyBiZXR0ZXIgdG8gY29uZmlndXJlIHRoZW0g
aW4gb25lIGRyaXZlci4gQnV0DQo+ID4+PiBmb3Igb3RoZXIgcGxhdGZvcm1zIGxpa2UgUzMyLCBp
dCBkb2VzIG5vdCBoYXZlIE5FVENNSVgsIHNvIE5FVENNSVggaXMNCj4gb3B0aW9uYWwuDQo+ID4+
DQo+ID4+IEJ1dCBob3cgczMyIGlzIHJlbGF0ZWQgaGVyZT8gVGhhdCdzIGEgZGlmZmVyZW50IGRl
dmljZS4NCj4gPj4NCj4gPg0KPiA+IFRoZSBTMzIgU29DIGFsc28gdXNlcyB0aGUgTkVUQyBJUCwg
c28gdGhpcyBZQU1MIHNob3VsZCBiZSBjb21wYXRpYmxlDQo+ID4gd2l0aA0KPiA+IFMzMiBTb0Mu
DQo+IA0KPiBXaGF0PyBIb3c/IFdoZXJlIGlzIHRoaXMgY29tcGF0aWJsZSBkb2N1bWVudGVkPw0K
PiANCg0KWWVzLCBpdCBpcyBub3QgYWRkZWQgeWV0LCBzbyB0aGF0IGlzIHdoeSBJIGFza2VkIHRo
ZSBiZWxvdyBxdWVzdGlvbi4gSSBzaG91bGQNCm9ubHkgZm9jdXMgb24gaS5NWDk1Lg0KDQoNCj4g
PiBPciBkbyB5b3UgbWVhbiB3aGVuIFMzMiBORVRDIGlzIHN1cHBvcnRlZCwgd2UgdGhlbiBhZGQg
cmVzdHJpY3Rpb25zIHRvDQo+ID4gdGhlIHJlZyBwcm9wZXJ0eSBmb3IgUzMyPw0KPiANCj4gSSBk
b24ndCBrbm93IHdoYXQgeW91IGFyZSBjcmVhdGluZyBoZXJlLiBUaGF0J3MgYSBiaW5kaW5nIGZv
ciBvbmUgc3BlY2lmaWMgZGV2aWNlDQo+IChzZWUgd3JpdGluZyBiaW5kaW5ncyBndWlkZWxpbmUp
Lg0KPiANCg0K

