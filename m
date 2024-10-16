Return-Path: <linux-pci+bounces-14608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8431199FE9D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 04:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA72B210B8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A113BAE2;
	Wed, 16 Oct 2024 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ahOZR53l"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767321E3C7;
	Wed, 16 Oct 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044186; cv=fail; b=k01cVDeU5wRsbTpRDd0waO8h+8pAOK+bP+T9ig1iBVwff/bAelHvQccq8arr3y3TdgsOG3iceosytWW2CZmxyYQsE4M8S5aDTErAF4UN+Npd9kBB9ATsxP2fcgHQA16PcbwHYhc+A9sRUqoxkFgJiGsO9hnoTY8WGgKN8tBh4Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044186; c=relaxed/simple;
	bh=4eB5WU+x+lPDH/GFObWfhNOTtJrOluiyjg6YovttpoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qEP7UrazbrNxsHmxWo9LRR+fT1vMS5Sj68buZA19/9+8CBxpNAymN/CArGRhwCJgM9AGM6QxwDTujgtvpjoeliHnWSg2jdANj5s6/t/fCEjG2nZlHWXbzL9w+rmpV6Kb2/Amm39Y9yWiydMGLzDXlAurrYiSZMjpiP9V1ActyHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ahOZR53l; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjCysVRpr/sp9K8bKMy01QCPlRpYw0nfS9tks4MOh2Fjhv8xQzrTizLUPiaVc2tYeBwKJiUX/lQlLyOiE43zA35ZYUnhkjW0YWe/ubfbKObWs7Rh5rEc0oeu0R8LHtjVycAII6h3Ou/phx+W/uXnN80PYmg0mimoW2qEqy+sCTXZoqAFgeQ7YmkkWwAjwmEwa5W1bOOcxhyhsgMUbOkMvXQH5y+ivtxgiC0jVUUnrkVVbFQjC2OkLGaQK5eouGpbEiU2dlFfc9THEfXq6ryyYFOMtlPEcuZC2PTsQSuDASIDZrg+uWZFZTTIhvCSHsEGNBxwwxnPOVrfUT3LoooNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eB5WU+x+lPDH/GFObWfhNOTtJrOluiyjg6YovttpoA=;
 b=TLTqeKUZwi79xPOcPu52IxZXS2v6SRH+a7hSO+kSPCugWB2BEcgKo+WniFkMsFbN81h1OUKIPp2Y15wVkIl6BoG704zbBqJFc0F3U0efsEXLb1CKs6IPK6xTvZvbltCtDrogl0lbMWwXC8alH86Ukr/s/XgeDvDO6Dxs/7BabUpdMm+zazVdWU6LkA22cndI6z7EGm4BKmk8SQBsvvFvGVY2k/6dbSBiZpA7pK1w6Fc47j8WT719ViTAsfDd027yR2Hx2fihLsJjLwa5LAv2DAyfV1UqQmaS6Ai3RpMkM5965gP4kI5J0ZkbT9tzNfY7WZhAPyivCMfYnOvRTLy7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eB5WU+x+lPDH/GFObWfhNOTtJrOluiyjg6YovttpoA=;
 b=ahOZR53lDT3mOwiCDePPX3JtCYL0SqCNBGLg8bFU6FMVkJ4exF3UNtfILLlM/qjkRsnVCUaZIpa94b7fyDGZfIrBmD+5RIffKqDQZ0gMa3u+Y1xk/eRI3rjJOo5xsh/LLHBdNJGMciCQfUznmwb7grtCYudbq4MtQlIzw6vikAurTJkN7i4B7GuKYchxABrheFcOaAZcx7VPoja9fS0pLbDc7HbrNT3cBT8Nsu2RSMtXKLxNHXyhihEQawZrNeZ4uMWC7+7FcUFfZCBZUHhiw/IZ9E2IjjjDzRyndAcIjZUkQhYsnUEe9xtiaTjpANUsE9pu3hu3EiXFDrJgwsK/kA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:03:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:03:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v2 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbHwQTwv6rid1NsUWySy5OdGop9LKIXfAAgABCz0A=
Date: Wed, 16 Oct 2024 02:03:00 +0000
Message-ID:
 <PAXPR04MB8510E14D804DE54E6E2AB8A888462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-4-wei.fang@nxp.com>
 <20241015220254.GA2025619-robh@kernel.org>
In-Reply-To: <20241015220254.GA2025619-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7819:EE_
x-ms-office365-filtering-correlation-id: 11ae7045-9886-4afb-d674-08dced86a99b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?bkp2TU1OSmFqdmRLVTRVbEhaR0czb21vSU8zNWlhaWg5ejJEV1h4Z1RISjhO?=
 =?gb2312?B?Q0ZsWktrR2NEcktJTC8vOW1RM1JIRGlhRWh5ci9rK0MrQldoRi9jaDhSYnBW?=
 =?gb2312?B?UmN1TWl5QWtkRU0zc0JCNGhFWjNRR3lXbzB1MithcVdkNWFFTHA0Y1NNc01r?=
 =?gb2312?B?QUU5RG03Y3k0SkZJdWhZQ0pKdUVqVTExS3JDSmR1VndoZHovdXJCUG9TZ1Y0?=
 =?gb2312?B?UzQweHZuNEt4U1F3ak4yU20wVWNHV0RRd25icWgzU3M0TUF6M3YvL0p6azFi?=
 =?gb2312?B?bUdOUVE0Qk90YWFwWDMzVEhMWk40WkdVbVRZaUxxMGljYlhYTjBiMlJQZFFj?=
 =?gb2312?B?eXZQdUZEaVdsNGN2REJiWnhuODVYZ2U4R3UxcVZaN0QxdGNvYkV4MEJPYWtq?=
 =?gb2312?B?amNwWENDNkdIUmcycFZ4RFp3dVNvWjR1dmJ4YWl4MHhXK2ZCM3NCZTlYbHla?=
 =?gb2312?B?bXhhOG9TUkxGaStITm5HZ28vVjlUVzhBalpUTzJtN0JCZDJjWnUvaHJiTFJy?=
 =?gb2312?B?cTR2aGV3bE9SQ1Fla1NxRXM5d1E5bWQrUEhRTnVwaGVBRm9TZHpvTFJRQ2tZ?=
 =?gb2312?B?OEgwVjBTY2dsNFdJd2VkQ3NzRHphaTBLN0RQdHBNTU5GenB2SUhGdDdhc1JR?=
 =?gb2312?B?My9PQmpLd1ZiZWJnNzZHVzA5R3IzTXdELzI1eW1oUEZqQmprdHhVU2YyYW1E?=
 =?gb2312?B?NWNtajNoNDN3TkI2QUlrYVFVWW5uYnpQY3JKaDJFa2JydVc3UDdaUGFUeEEw?=
 =?gb2312?B?ZEkvMkpGWDIrbVRtUmpoUjNTNnhqTDBpRStYcHVodS90M3loMCtpQXIyUFIr?=
 =?gb2312?B?ajY1cWdwM0p1UFFWMTRWbGVkcjcxeGV2WlBCNmJjNXAzeHZnaGgxQ3NyNHFV?=
 =?gb2312?B?OUtIVU9aWlhaUVkvZHZKTG5Oc0tybVQyNGNkT2ppZzQzNVVSMnIwcnFkNGRs?=
 =?gb2312?B?K3RaNmFmZklybGs2UERtNnc0R0N6Ly9reFN2Z2JEVU5VRXROYlY1U2NYSW83?=
 =?gb2312?B?WWNNK0thNkY4VFI5dk5GMDdmc3VHcmt2TU1LUjNlWWlwR2dKZ29qSHVKWFdo?=
 =?gb2312?B?SGVVQ3JFVUZwTEk2R2ZIT3FMT1lJVmR0NStQUlBtNVB1SGpWOG1lek41Sk1J?=
 =?gb2312?B?cUo3OVRub0lrTitCbjhUOFRtcXU3em44WnEvUkNCL1U1TGZZZ2FBTWRnalh4?=
 =?gb2312?B?WHVjQjNaTGhwQWVQK0l1N1BocWx1Z3JpS2p6RUVUbEgzU0MvRkM4UGZDemhM?=
 =?gb2312?B?bzVsOHViYXVjN2gvejhXNkpXNkttTXlnNHM2bC80Qk5wZXV6ajAxUHA0TTIz?=
 =?gb2312?B?T2ZJTm9lS3djVUlVdDRDaWpKK1JFa25CNHRqTnB0OStUdXo0dXJMeHkvN3JC?=
 =?gb2312?B?U3J0aGdwYXpPeGYyU3BucXRkYmtzR3dyZ1dycDViMStPS0hUbThSR2JoMHMw?=
 =?gb2312?B?WHh2T3I3bnNmZkRMQTMzMEY3Y25ScWZBY0xGek5HbXhiNzVRSmNJWFdKWE5H?=
 =?gb2312?B?WXoxSEhsRldncks4MmloVnZGNEpSSXhlaENzSWhvbGFGTm9rd010U1F1WXND?=
 =?gb2312?B?NVp4K1BnNVo3RjNNSjdxVjdKSzVac0JWTFl5em9lQStpOUtnNk1uUHdQR0tk?=
 =?gb2312?B?b3VQYUFDK0lHS3R0ZmtIT0lVU0JBVnBPNzZnV2xiYk01Ym9qczZleS9XOUVV?=
 =?gb2312?B?QUdOSFFmdENieW1QQklKY0pxdmlXZWdEZGhhcTYzc1g4ME5RL2tNUERCdHJs?=
 =?gb2312?B?U0hWTnZXWTlIOHdsWTEvNGpUR1VpMnNaaHRaU01ZYmpkTUx0RkY4c053NHF3?=
 =?gb2312?B?TlNXSnV0YjNRMzV3Uy9xUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?K1ZhMlZwSmI0VGdSeEx2T081WFJIK01WL0pnSWIwL1Z3SlJXckg2ODQyZVZn?=
 =?gb2312?B?TjIwVlJNK0w1SUYwTEVKODB3SWNqRDdheExxQVJKSWtTQ1NGcE1TTmdwWmtv?=
 =?gb2312?B?V05PME1HdEZOK1pTUXBOOHZzeXhoNmRDWE9BYkVjWWNoZDBIMWUyV0YyRlk5?=
 =?gb2312?B?VHYrU0NEUkx6ZE9WMktXdGlTcUlYalZhTTBUM2xoNjQ1YXpsbGMycnFhc2Vo?=
 =?gb2312?B?VVQ2Wjk5V09qOERxVDRLc0JWQXY5aUpIeVFmTXVZZ2J5WUdXaHdVU0FNOVh5?=
 =?gb2312?B?V3lJMXlkc0NlcEFuMTE3RXlkQm9ySnpCSExLK0l6c3F6bStVejdQUkhlYWww?=
 =?gb2312?B?NUdZZnZud1dyYTc3VUJqYjh4c3BCUGVCOTlVMlg0SEk0Y09WZjJhaDBobnpq?=
 =?gb2312?B?VEI1OVhiMU5Gb2VKR1NKQ0JxVjhtQXpUMkllMHpmUzhJc0dNTExleXpSaSs4?=
 =?gb2312?B?Szc4SXFkYmgxRDJMS3BjSlE5WVl0UjJRTDNadWxYZTg0Tm9mM0xYeVM4QmtG?=
 =?gb2312?B?OXMzbVJTWlJXcGFNTTJjOVBTWG1FY29ENm4vTFBRNnRyZ2p0ZkdiSy9VTWdu?=
 =?gb2312?B?dnF4M09EalhxbkxGUnZoTVJ6KzViZmlGdXNVYTJRQmZINUljZThvRGQ5YmVN?=
 =?gb2312?B?ZnF5NDVRS3E1VTBpYm04U2Y1aDRnS05LZFh6eWQ4S0t0ejZtQTZnM2MyZFJo?=
 =?gb2312?B?OERPQWtwaUxtVUVGWEk2V2NRK3M3QkFIdngzZmVLMlVKSU1oZkF2UFNyMzR4?=
 =?gb2312?B?cHg3bTZCMzlkV2g5d0dra3BhdU9hd2hIYko0cGpGRnl3SWo3VFI2b1IwcTlk?=
 =?gb2312?B?V0pxVHp6ZHlyemJPbnptMHBpWWxlQ281TTNxOUhLYS9SSm9xOU9JR1N5Unk2?=
 =?gb2312?B?VTA3Q05oejJBQ3lLUjF6TkFYK1NlNnpJQzl6SzFKT3RheEtkRm5UL3JHMC83?=
 =?gb2312?B?eWFNT0gvQ2tDY2lNR2Noc0l6OUJVeHRLd2dxMVNnSlV1Mks2VnpVS0wwUXpI?=
 =?gb2312?B?bGdTWjJZSVdocDVLTmx4dGtUcGErZjlTeTkzSXk5aDBEU1FPcW1WRCszL2I4?=
 =?gb2312?B?UjJsVnhWbnMzVXFsSUVlNlNVczNYenZ1S2VsK3NjaU95WllnQjhkcVhnSm04?=
 =?gb2312?B?SE13SDlKaUx5V255VWg3Q3lJMm9KeDMrQ0lxbDRpdTYrMHFoSTRCdFN0TjVE?=
 =?gb2312?B?TzFpTlNveWhGNWcrTEl3bzR4SHNaL1BLSERRNTNoZDU2ZklwRit0RWtNVmp5?=
 =?gb2312?B?VjNUSHorQU5KalhZcEJyUU1QdTNoSExPUFN0UHc0QitMSU52L012ZTlmQ0FO?=
 =?gb2312?B?M3ZyR3FCQW1pMzVSTjNaeHlNMkZoQ0dHK0lwd2ZXMHRwUnJINkFhOStVY3F2?=
 =?gb2312?B?d0ZFTGZOQVdaRjFyZE1ZQjVIK1lyZ3hRSm9VNXZiOXRqdTNhNUJEcVNUb0dQ?=
 =?gb2312?B?STFwYVlRaGhiTjNtWWVJZDUvWlA5b1NURnJzVHlaZGdEdTRjaHlXNmlYcUx0?=
 =?gb2312?B?UnRPQStWRUtPVFRiOHhFVlZNRWZkY2tJWjdvaWV2cmxMTjhJOVUxVitESy9R?=
 =?gb2312?B?VWM3WFNUdVVmR3d6ZE83MUFMVDluek0wU2N0M1R0NWNMRStQc1UxamVnMzhz?=
 =?gb2312?B?czk1N2lCRGxiNlJpMXlnN3ZzdlRiR0ZnVUJUV1p3UTlYcG8wQ3hoWDJWckZn?=
 =?gb2312?B?QnpZcXR2WU51YXNscnlNNkdwN1VTZE1KY0syZ0Z5MTFSc1ZNSHZwK1V0aFhP?=
 =?gb2312?B?WGlTTXUyNlJOMkxMcmZwZUJvOUNST1h6YkhVNXBPRzN5Tm1PYzRzS3VZMHR6?=
 =?gb2312?B?TUFSMXBTM295YWJ4b2lNd0hwZEdWd2JUcGVkSEczdktyZ3UwMGswUlZ3UFlB?=
 =?gb2312?B?eDFvUzNmT0EwbEMyQXJrWmlsNW45Tm1MSzFPMjhkMnNlNHdaZTBpMENiZUdE?=
 =?gb2312?B?S29RMEo0V3N3dEp3SVU3V1MrUWdNenBaNUNqanhZMmhiajhpZUNySHlNN2wy?=
 =?gb2312?B?T2hWNUR2K2F4QzdpQVpTUXpmOVM0TWpLeWVsa2dicGJBNTVydmJxaTFSUmNR?=
 =?gb2312?B?ZlU4U2pXd1ZpQmpMSnZ4YU1kajBHUHZaTTBoN3dvREVudXhaUFZaVWRVcktH?=
 =?gb2312?Q?mktQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ae7045-9886-4afb-d674-08dced86a99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:03:00.6334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLaJA3jn5VpVvcvPksMs9q+UicaSmBf4Zxm5aUV15rmjMtQ8eWig8p2g+ygE9e/+9gEVn/eTQ/XM+45PRGDITA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMNTCMTbI1SA2OjAzDQo+IFRvOiBXZWkgRmFuZyA8
d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdv
b2dsZS5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGtyemsrZHRA
a2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGltaXINCj4gT2x0ZWFuIDx2bGFk
aW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUgTWFub2lsDQo+IDxjbGF1ZGl1Lm1hbm9pbEBu
eHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgRnJhbmsgTGkNCj4g
PGZyYW5rLmxpQG54cC5jb20+OyBjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU7IGxpbnV4QGFy
bWxpbnV4Lm9yZy51azsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgaG9ybXNAa2VybmVsLm9yZzsg
aW14QGxpc3RzLmxpbnV4LmRldjsNCj4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiBuZXQtbmV4dCAw
My8xM10gZHQtYmluZGluZ3M6IG5ldDogYWRkIGJpbmRpbmdzIGZvciBORVRDDQo+IGJsb2NrcyBj
b250cm9sDQo+IA0KPiBPbiBUdWUsIE9jdCAxNSwgMjAyNCBhdCAwODo1ODozMVBNICswODAwLCBX
ZWkgRmFuZyB3cm90ZToNCj4gPiBBZGQgYmluZGluZ3MgZm9yIE5YUCBORVRDIGJsb2NrcyBjb250
cm9sLiBVc3VhbGx5LCBORVRDIGhhcyAyIGJsb2Nrcw0KPiA+IG9mIDY0S0IgcmVnaXN0ZXJzLCBp
bnRlZ3JhdGVkIGVuZHBvaW50IHJlZ2lzdGVyIGJsb2NrIChJRVJCKSBhbmQNCj4gPiBwcml2aWxl
Z2VkIHJlZ2lzdGVyIGJsb2NrIChQUkIpLiBJRVJCIGlzIHVzZWQgZm9yIHByZS1ib290DQo+ID4g
aW5pdGlhbGl6YXRpb24gZm9yIGFsbCBORVRDIGRldmljZXMsIHN1Y2ggYXMgRU5FVEMsIFRpbWVy
LCBFTUlETyBhbmQNCj4gPiBzbyBvbi4gQW5kIFBSQiBjb250cm9scw0KPiANCj4gRU1JRE8gb3Ig
RU1ESU8/DQoNClNvcnJ5LCBpdCBzaG91bGQgYmUgRU1ESU8uDQo+IA0KPiA+IGdsb2JhbCByZXNl
dCBhbmQgZ2xvYmFsIGVycm9yIGhhbmRsaW5nIGZvciBORVRDLiBNb3Jlb3ZlciwgZm9yIHRoZQ0K
PiA+IGkuTVggcGxhdGZvcm0sIHRoZXJlIGlzIGFsc28gYSBORVRDTUlYIGJsb2NrIGZvciBsaW5r
IGNvbmZpZ3VyYXRpb24sDQo+ID4gc3VjaCBhcyBNSUkgcHJvdG9jb2wsIFBDUyBwcm90b2NvbCwg
ZXRjLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+
DQo+ID4gLS0tDQo+ID4gdjIgY2hhbmdlczoNCj4gPiAxLiBSZXBocmFzZSB0aGUgY29tbWl0IG1l
c3NhZ2UuDQo+ID4gMi4gQ2hhbmdlIHVuZXZhbHVhdGVkUHJvcGVydGllcyB0byBhZGRpdGlvbmFs
UHJvcGVydGllcy4NCj4gPiAzLiBSZW1vdmUgdGhlIHVzZWxlc3MgbGFibGVzIGZyb20gZXhhbXBs
ZXMuDQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFt
bCAgICAgICB8IDEwNw0KPiArKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEwNyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L25ldC9ueHAsbmV0Yy1ibGstY3RybC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L254cCxuZXRjLWJsay1jdHJsLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMThhNmNjZjZiYzJlDQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQv
bnhwLG5ldGMtYmxrLWN0cmwueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTA3IEBADQo+ID4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAlWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDoNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBpdGVt
czoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogTkVUQyBzeXN0ZW0gY2xvY2sNCj4gDQo+IEp1
c3QgJ21heEl0ZW1zOiAxJyBpcyBlbm91Z2guIFRoZSBkZXNjcmlwdGlvbiBkb2Vzbid0IGFkZCBt
dWNoLg0KDQpPa2F5LCB0aGFua3MuDQoNCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4g
KyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogaXBnX2Nsaw0KPiANCj4gSnVzdCAnaXBn
Jw0KPiANCg0KU3VyZSwgSSB3aWxsIGNoYW5nZSBpdC4NCg0KPiA+ICsNCj4gPiArICBwb3dlci1k
b21haW5zOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0
aWVzOg0KPiA+ICsgICJecGNpZUBbMC05YS1mXSskIjoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFz
L3BjaS9ob3N0LWdlbmVyaWMtcGNpLnlhbWwjDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiAr
ICAtIGNvbXBhdGlibGUNCj4gPiArICAtICIjYWRkcmVzcy1jZWxscyINCj4gPiArICAtICIjc2l6
ZS1jZWxscyINCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gcmVnLW5hbWVzDQo+ID4gKyAgLSByYW5n
ZXMNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiAr
ZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBidXMgew0KPiA+ICsgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsN
Cj4gPiArICAgICAgICBuZXRjLWJsay1jdHJsQDRjZGUwMDAwIHsNCj4gPiArICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJueHAsaW14OTUtbmV0Yy1ibGstY3RybCI7DQo+ID4gKyAgICAgICAgICAg
IHJlZyA9IDwweDAgMHg0Y2RlMDAwMCAweDAgMHgxMDAwMD4sDQo+ID4gKyAgICAgICAgICAgICAg
ICAgIDwweDAgMHg0Y2RmMDAwMCAweDAgMHgxMDAwMD4sDQo+ID4gKyAgICAgICAgICAgICAgICAg
IDwweDAgMHg0YzgxMDAwYyAweDAgMHgxOD47DQo+ID4gKyAgICAgICAgICAgIHJlZy1uYW1lcyA9
ICJpZXJiIiwgInByYiIsICJuZXRjbWl4IjsNCj4gPiArICAgICAgICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAg
ICAgICAgICByYW5nZXM7DQo+ID4gKyAgICAgICAgICAgIGNsb2NrcyA9IDwmc2NtaV9jbGsgOTg+
Ow0KPiA+ICsgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJpcGdfY2xrIjsNCj4gPiArICAgICAg
ICAgICAgcG93ZXItZG9tYWlucyA9IDwmc2NtaV9kZXZwZCAxOD47DQo+ID4gKw0KPiA+ICsgICAg
ICAgICAgICBwY2llQDRjYjAwMDAwIHsNCj4gPiArICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAicGNpLWhvc3QtZWNhbS1nZW5lcmljIjsNCj4gPiArICAgICAgICAgICAgICAgIHJlZyA9IDww
eDAgMHg0Y2IwMDAwMCAweDAgMHgxMDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICAgI2FkZHJl
c3MtY2VsbHMgPSA8Mz47DQo+ID4gKyAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsN
Cj4gPiArICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKyAgICAgICAg
ICAgICAgICBidXMtcmFuZ2UgPSA8MHgxIDB4MT47DQo+ID4gKyAgICAgICAgICAgICAgICByYW5n
ZXMgPSA8MHg4MjAwMDAwMCAweDAgMHg0Y2NlMDAwMCAgMHgwDQo+IDB4NGNjZTAwMDAgIDB4MCAw
eDIwMDAwDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgMHhjMjAwMDAwMCAweDAgMHg0
Y2QxMDAwMCAgMHgwDQo+IDB4NGNkMTAwMDANCj4gPiArIDB4MCAweDEwMDAwPjsNCj4gPiArDQo+
ID4gKyAgICAgICAgICAgICAgICBtZGlvQDAsMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJwY2kxMTMxLGVlMDAiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIHJl
ZyA9IDwweDAxMDAwMCAwIDAgMCAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDww
PjsNCj4gPiArICAgICAgICAgICAgICAgIH07DQo+ID4gKyAgICAgICAgICAgIH07DQo+ID4gKyAg
ICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K

