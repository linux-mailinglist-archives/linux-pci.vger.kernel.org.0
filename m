Return-Path: <linux-pci+bounces-15083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F29ABB1D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 03:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C96F228440E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56122067;
	Wed, 23 Oct 2024 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VqSKZ1mq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B31798C;
	Wed, 23 Oct 2024 01:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648017; cv=fail; b=My8/ahLRX9iibU1CCEjfj9UlxZZ+mGrmTVxKE/LgjBszczt23YvckZGYukdJjn/2rJHp2jXixLGUQW1djlGo8AtRyfrv3YbtXfG4W0VO+itidQoa2w7RANqAOfWiORE2LvYiii9lFTp6IHx/+8twjL2tPaqQjAIK8Xb6T+xrDmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648017; c=relaxed/simple;
	bh=kl9SAoGL9rDJxkxFIBPaUvBi8yoZkydvIFaXpImt/Pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U6nrjGe54QblD1//ZNz3che4Sdl0qORCu1T11eU/DkpiNAgpOvXJsiYdTGTPiwERo9+xDHpnpR2p8e/LuFmQWOp1ebjDLFsJ9ZazEgE70ADtWJZ1ULzIw5NhmBuLiOyTZVRX6TlgOVy25K1nYen3sH+UpVEn71X054IedV/x1Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VqSKZ1mq; arc=fail smtp.client-ip=40.107.241.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9hNU+51AXtDtHhcQa/DZP56vuMf6kETo2ZSsdEJX3ahStCykLiuixxt90XJeIvAYHj4/7A//m9VCYpjfhT1hMRWiPnoTDlemeqGE147cRpJ7igYGTqag/dj/5zpiThje/Q1lkjvlzj/7B8V7L6T83Ui9zSU7B+A1i2h8jynS4ZF6opZQvpHG+FO1tlxPpF90tvtZaTiThjx+Q8KsmjxQPznAPv0ZnNaspgQQlMMxk8Mj8eocR+cOnhGpzukyptorRwlaluBjwu9Tpr4E9s0N90c51kke5mBysA8+ZUwAX2XJ6D/mSNbNH8pAK8A9lPEfwYPeurRWVfqDJaF0YgFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl9SAoGL9rDJxkxFIBPaUvBi8yoZkydvIFaXpImt/Pw=;
 b=gPYC/pCMDqXFrIF72Bn24Wdm3UXaGt4EJhUAqLcedJ0X+FEEA5NMuw+RiZZ/6fSXLfjcldy595TXdJJgjxt7s2N537wQJ5dc6O6cdp+P6h+WPiLQ6ueH7QwVM45vUt3XpR3LUciP8Dbm/smE7secGGR791ygRIo25aID0gZAH2TI9MlgYpOID7HVrCEVKDCVOV9qmz1HLNIT2MifJ1qjIKyL5tPJnK8tZoyEAQtvD2KNr7vXBh2WWVizO9Uz26SWtjYFPX3iYY1V7EevEaNxzOBO07eOE1hXTnIBo5nH/v8mv94XIIW0GBH3pKf0wPAEUCp/imliBGzToHxANERwMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl9SAoGL9rDJxkxFIBPaUvBi8yoZkydvIFaXpImt/Pw=;
 b=VqSKZ1mq0XkcfJUaTqkQtkReycUiAFD1rGHTp3yRUZ4vDhUETyUBzLrlvXrb/IOSMkxNwLDHaoAcBda2eUhqEOwnW+WfXjOWeURYIsuw40t6r9Y1hLByOEoW2MCNQYkguEWe50PYXiNIpjKA3iFWr2pZ/pqaVrXnATBJ/gBs1ya2J61ML+/Z/6/4N6wzNo4dQyFMB7Ov9eaSPN1l/Ix9VVzUAioq85RhoOEeKmXXyUGdvQhGo1StV/UJLpZBOxKd6se4uF/ID+SMAqllNmbmWYmU1mx+qrd+BRaIrL8cO5nbvOq0AsWVuh5wf1DjTFI8IXEolnu6xfIrA48AP0EnJA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10293.eurprd04.prod.outlook.com (2603:10a6:102:450::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 01:46:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 01:46:51 +0000
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
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbJEi1opWCvzFL8kS18Y10TWXurLKS8z4AgACdUEA=
Date: Wed, 23 Oct 2024 01:46:51 +0000
Message-ID:
 <PAXPR04MB85106A7BBAD6970B0C4E8844884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <ZxfQIKg1w1mhZ2yH@lizhi-Precision-Tower-5810>
In-Reply-To: <ZxfQIKg1w1mhZ2yH@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10293:EE_
x-ms-office365-filtering-correlation-id: 83f92ca1-c0c2-452a-651c-08dcf3049112
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?S0NkemhPTFIwUTlwc3l2MU9VaEIweEFSKzdDL1c2aldxa3F4V2VBcVhFWkQr?=
 =?gb2312?B?MUkySW9yMFY4N1I0RWkzbWNUTDErL1hVTGxDVG9oTzErbVpNeTZGeENwZTdH?=
 =?gb2312?B?S0RPU21ieEs0OVFSRk9Ra0NMVjlESHF6bzZmS0plSFFvQjdsMzlaTThGNWoz?=
 =?gb2312?B?OXUvS3RPRVdjS1hQenhhWHNGZkR1dHpwdlJBS2lML3V5OFU1emNtdDdxZzEx?=
 =?gb2312?B?aXFtbEJGdVFlOC81eEVaN2tveE80Wit4M244bTJpd2N5RDRJYmNDTDFYQjhI?=
 =?gb2312?B?NzBEbndkay91WGVHM3FoQm8zTkU1WmxDT0t2ci9YbE1pZWhwRTFqWkZsUzUy?=
 =?gb2312?B?N0Y5VGhObFlsZG5OZ2VEeXRBd3g3a2pRNU9WYzR6RS8wcllVZmhkK0RZYUJC?=
 =?gb2312?B?Y1NoTW9UZ0x0RXZOVVNTQ2ZUbXpzbDhHd1Y2d0JNTnE1Z0w1b3lKNDFLQTM4?=
 =?gb2312?B?YWFVYnhYcXhGdGQ2Vm1xQUd3OGo4TFJzV3NmTUhXb0IxaldHWk1wRiszNHIw?=
 =?gb2312?B?VnNhYWZvRCs0SkhCTUEvVU85cjlzZzVaem5JZjhzRkxiY0J0UGozSW9Kd0ZN?=
 =?gb2312?B?ZlEvUnI0L0Q4dDRNYzVoM1VINWxZM0plY1VoUzBCTHFwM1JoR29hMFhVTFVL?=
 =?gb2312?B?Vi9qZTJ3aG9wV1ZkODFiSXBNcllBWDgwc2dHZnlRMU5ZalJrWmpoV0Z5aUxu?=
 =?gb2312?B?dGpGekV5QndoS3ZadGFYVHN1Z09tWkh2NzVFbG5HZTBXREh6dFZWbTZMWlZ2?=
 =?gb2312?B?dk1KZ0pQSkdNV0RpTnJSTDNqU3ZjKzBTbVpidGhaTU9xOWUyeTJNemFCUnJV?=
 =?gb2312?B?M1ZmWmpNOTdkQ0VJQW14UG96UFlxaGhxU1Z6aWpRUGY3SUNnSmh3Z0YrMFZZ?=
 =?gb2312?B?RWFndzZhMFF4SFJaTHF3MjV4WXdsUnRUc3pPbDRSMHVSM0tTTGZJNDRsbzVp?=
 =?gb2312?B?TCtNdjVrcXBROVJxcFdqV0ZRMlBVbUJxRjBIVTBCWUZkNWRNVGQ4NWpPMUg2?=
 =?gb2312?B?UW5SaEQzd2hNZFYrU0Z0em5tY0psdU1ndW9LeXJLem9LYUZ4S0JaUWU0am9L?=
 =?gb2312?B?QnlCVE5xNXQreHlvaytHaTVnWG5jRDZsM1FsMW1aeWVQa0JWcGtoeHhvbXpQ?=
 =?gb2312?B?Y1U1RkVvSVBicjcxdlhkYkdPU05NTXlsVytMazVwTGd0VTNMWE1KUDdaa0l0?=
 =?gb2312?B?VmNaWEREMkZkTWFpRnFJd3h2eTdldEwvWS9GU1RkSFpUMlhUQ0ovOWZaMmJu?=
 =?gb2312?B?RDcxaW9vWStSemh6SXlqNTFXbkZtZEVwZ3ErRllnTjBUMFcrNUdWcmdwckds?=
 =?gb2312?B?ekFXWEdzVVByajY1SGxWL3dDRUZFMVhJWlBDU04xdllRV0tBTE9jQVhPKysy?=
 =?gb2312?B?bjRhdUpqRElJelA1SUdHZjNxTnJkZVZSMGkrZ1V3Z0lVd1NEZVZVNXV4aldS?=
 =?gb2312?B?K3l6eHRCU1lVcHh0TGxRQlNqSXZNcU1pMkdwRGRNdzhEalpIZW41emROdXFk?=
 =?gb2312?B?UmRiOTNjOVltUnJPb2JiWEdSR0lSWUEwT04yejNLOW8vRTQ0MG1XZy9VMjJu?=
 =?gb2312?B?TUI1K1htY0JVVUxsY3g0ZTRLbU9lbmkzZHpSTG9TRzg0VmJyWDhMZVBHQXQz?=
 =?gb2312?B?bGtLdUIzY0pqN3lWV1pVQ2lqZ1YvbnJzRVNJbURDcC9waFpHakZZR0NLUlNQ?=
 =?gb2312?B?bW84eWNnKzNjeTdQSzBJejVGVFJqN0hSRmg0SlIzWVFxZ0paUk9Felk0SlVu?=
 =?gb2312?Q?MUjz8a9JAr9us8d2jmi6nImnvp7Ah6T+TW2kojm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?V2RQZG9aQU9YZVI1T0JxaGsvZGRmSm1PNzI3SkZhVDFJYm44WjkxSDlYT0Ro?=
 =?gb2312?B?M3pkNDlUWGZDMXk1S3lRQnNWYzlqalpxT3cveTVpUkQ3NVRTMkRGVWJFdjQw?=
 =?gb2312?B?Nzl6b0xxOUN3Yys3aUJqeUREWHh0NEkvNjdtcndhK2xUb0JWajBDNDFSWlNE?=
 =?gb2312?B?allvbXhDeEVkTzI4VSsxY2ZaQ2pIbzZwWk5hTEtINCt1VmN3NnBPWlZTdm1q?=
 =?gb2312?B?SDVibDEyTW5aeUpiMVNlSlRnYXduWkhnQzRaSCtUMzkzWkZHQk5DZ1lRYWRm?=
 =?gb2312?B?NUd6TFgrT3VHK2hLM3ZPekhFN3VyQW1lRW1KdHBRZkd4Z1ZGcXRMV0dWZkI1?=
 =?gb2312?B?bitDYXRlWnFtOXZzamRJbVNxenNvTzZIais1cStVMTh1Y1UzbXVycW1GbE1a?=
 =?gb2312?B?UnVpY0FsQzVGODRlY1FZY0E0UlJFQXlKWjBQSGZzeWRNL3RMS3pQMC9zdUpR?=
 =?gb2312?B?Qzl0em9aMzBqalk0d3c4ZGdRa0phMUs0N2k4VmVIcUxkbFhUeHlnQ25nUnh2?=
 =?gb2312?B?T215Nm9pY1BHZlU3SS93dW4xMm40cVlFY1FtOFo4SitEYzM5enc4MDRYdGlm?=
 =?gb2312?B?VXR3T0pMRTN6TmttVE41aUpLZ3pJU3ZpcXppY3REMDdYdm9jRWhhV3NXU0pt?=
 =?gb2312?B?cGhsZXRTV1NHSUdqYm1BTG5KRFp4cDd3YXJhRndRdHJTSEdGNlY4bnYwVnpv?=
 =?gb2312?B?R0k3K3ZLdWxmbUU3VkRrS3Z3dWxtQmFIdUtnbEFLaWFpWUx1bTAxeTk1dk54?=
 =?gb2312?B?MzhzcHNtd3NFOC93V2ovSkR2TnRtTCtoam1OS2VYaStCNlFybjc3SzRwQUpr?=
 =?gb2312?B?WlFwd2w4Sis2VE55ZlQ1Njk0OXJXNjFvZitXRk9NaWNYVDQ4eVFORUYyVjRo?=
 =?gb2312?B?MWRzNkZBaHZpNTd4WmdLa05RQmZyZVFGbmt4SVh4TXVlVmJUeVBKWnJiaEdF?=
 =?gb2312?B?NExqeVQwei96NEVtcXVXb3NvQzJnMG1oTCtSSXBQQTB3RW5qaEVBMXdpMWJv?=
 =?gb2312?B?RjJjcUdjQXprdmU1dmlzeHFIeCthLzBLVXpOWVloSDJldGxNM3hyWm4yeW0x?=
 =?gb2312?B?c0R6MmROU0hoMEtrR2VTU1NRNyt6NUxOZkNKYkVmT3hmZ25EaDJlcTZsWjB3?=
 =?gb2312?B?bldRMC9NSFNTUzdpSGNCNVIxTklZczJHV29jZWlwazBBTVF5OHZPN3JhbnpZ?=
 =?gb2312?B?dWsxVXpZbVJ1ZHJ6ZXJob1Bad2txMytHRTJVNm9zSkFUSDVNWXU0YlBqeGdj?=
 =?gb2312?B?Y2luZ2pXeFkrdGxYVk1QSFk2ejFUVzJvZXBJR29JMGVNZ1JLb2xrUTBhV2xj?=
 =?gb2312?B?UmsyQUUwZ0ZLWjFFd3VPR2Q0SUozY3hYV2xsT29CQWJRREZQMHFaZ0ovWVdK?=
 =?gb2312?B?SGU2THlnKzF3bGxsdGFubGRvaC9yK3JIN0Nzb1RlUUE3c1RFbllDRFdTVk55?=
 =?gb2312?B?RHZWNXRnNzJ1Rzc0NGlPcndoRWxUQVRvOWhPSDhhM3dKcjZPemNzZEE4eDFL?=
 =?gb2312?B?bmhrejNuWFg1TmFXcXZUL3pBU252SkZld3JCNUNpWkRQR0xuREJCV1p1Y3ZY?=
 =?gb2312?B?SzlkL2xoSEV6cUFGYk45TUxBVlBMZ1lMdjJlSWRIbkwzbHhIS2VtY3dyZEg3?=
 =?gb2312?B?bmk3S3ByUXRqS3BRWC95U3FyMGV3L0xGQ1FWbGEyQWVVY1hiMVZtSWJMQlNs?=
 =?gb2312?B?U2o2SGd6d1NoMC83Q2hpcmdKaTZwRlRmYUtZc2tzUjh2QUkrMTFrVXR2MlRM?=
 =?gb2312?B?VXhMNXladkRUcEsrOXJUZ0p1NVpqSjNnM3hCemQvYmN2NHhObUQvRkhjOU9s?=
 =?gb2312?B?WkV2a0pGTGFJV0JodFc3NVFtcXZMbE5RTHM1dW12R2hrelc2NDJFUnN1V0pk?=
 =?gb2312?B?NW5TZjZJVTRUMXJOaXg4ZDBkekF6dEtVU2VnQWxtbTVJQUxuNklmN0dEYzJF?=
 =?gb2312?B?STl5b1pVWStINm55OFFrNkJaMW9HcEY5cTl1eG9heHoxMmtIWnVTU0hwY1BT?=
 =?gb2312?B?d05LTWNUS3VhcklpVGVjV20rL1IxOGpnMU0yQkhFWGJVOTNON3lYTHI5bWU3?=
 =?gb2312?B?TjEyUjJtNytIREZab1RmVEJPN29DZlNQNUVRTTBVZ1JKNmMzOGJUeDNaOEtD?=
 =?gb2312?Q?x1Zk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f92ca1-c0c2-452a-651c-08dcf3049112
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 01:46:51.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RzCNrzKHy478p21ArPGmNvQ/DdE+KE6BP1ti9Tde9yB1uBKeTmhEi8tv4BOr3Sch3cW0/pxLg/JqN4/jfcdDxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10293

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjIzyNUgMDoxOA0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgbmV0LW5leHQgMDMvMTNdIGR0LWJpbmRpbmdzOiBuZXQ6IGFkZCBiaW5kaW5ncyBm
b3IgTkVUQw0KPiBibG9ja3MgY29udHJvbA0KPiANCj4gT24gVHVlLCBPY3QgMjIsIDIwMjQgYXQg
MDE6NTI6MTNQTSArMDgwMCwgV2VpIEZhbmcgd3JvdGU6DQo+ID4gQWRkIGJpbmRpbmdzIGZvciBO
WFAgTkVUQyBibG9ja3MgY29udHJvbC4gVXN1YWxseSwgTkVUQyBoYXMgMiBibG9ja3MNCj4gPiBv
ZiA2NEtCIHJlZ2lzdGVycywgaW50ZWdyYXRlZCBlbmRwb2ludCByZWdpc3RlciBibG9jayAoSUVS
QikgYW5kDQo+ID4gcHJpdmlsZWdlZCByZWdpc3RlciBibG9jayAoUFJCKS4gSUVSQiBpcyB1c2Vk
IGZvciBwcmUtYm9vdA0KPiA+IGluaXRpYWxpemF0aW9uIGZvciBhbGwgTkVUQyBkZXZpY2VzLCBz
dWNoIGFzIEVORVRDLCBUaW1lciwgRU1ESU8gYW5kDQo+ID4gc28gb24uIEFuZCBQUkIgY29udHJv
bHMgZ2xvYmFsIHJlc2V0IGFuZCBnbG9iYWwgZXJyb3IgaGFuZGxpbmcgZm9yDQo+ID4gTkVUQy4g
TW9yZW92ZXIsIGZvciB0aGUgaS5NWCBwbGF0Zm9ybSwgdGhlcmUgaXMgYWxzbyBhIE5FVENNSVgg
YmxvY2sNCj4gPiBmb3IgbGluayBjb25maWd1cmF0aW9uLCBzdWNoIGFzIE1JSSBwcm90b2NvbCwg
UENTIHByb3RvY29sLCBldGMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2Vp
LmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiB2MiBjaGFuZ2VzOg0KPiA+IDEuIFJlcGhyYXNl
IHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiAyLiBDaGFuZ2UgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVz
IHRvIGFkZGl0aW9uYWxQcm9wZXJ0aWVzLg0KPiA+IDMuIFJlbW92ZSB0aGUgdXNlbGVzcyBsYWJs
ZXMgZnJvbSBleGFtcGxlcy4NCj4gPiB2MyBjaGFuZ2VzOg0KPiA+IDEuIFJlbW92ZSB0aGUgaXRl
bXMgZnJvbSBjbG9ja3MgYW5kIGNsb2NrLW5hbWVzLCBhZGQgbWF4SXRlbXMgdG8NCj4gPiBjbG9j
a3MgYW5kIHJlbmFtZSB0aGUgY2xvY2suDQo+ID4gdjQgY2hhbmdlczoNCj4gPiAxLiBSZW9yZGVy
IHRoZSByZXF1aXJlZCBwcm9wZXJ0aWVzLg0KPiA+IDIuIEFkZCBhc3NpZ25lZC1jbG9ja3MsIGFz
c2lnbmVkLWNsb2NrLXBhcmVudHMgYW5kIGFzc2lnbmVkLWNsb2NrLXJhdGVzLg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYmluZGluZ3MvbmV0L254cCxuZXRjLWJsay1jdHJsLnlhbWwgICAgICAgfCAxMTEg
KysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygr
KQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbmV0L254cCxuZXRjLWJsay1jdHJsLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQN
Cj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvbnhwLG5ldGMtYmxr
LWN0cmwueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9u
eHAsbmV0Yy1ibGstY3RybC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjBiN2ZkMmM1ZTBkOA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L254cCxuZXRjLWJsay1jdHJs
LnlhbWwNCj4gPiBAQCAtMCwwICsxLDExMSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0K
PiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL25ldC9ueHAsbmV0Yy1ibGst
Y3RybC55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBORVRDIEJsb2NrcyBDb250cm9sDQo+
ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArICBVc3VhbGx5LCBORVRDIGhhcyAyIGJsb2Nr
cyBvZiA2NEtCIHJlZ2lzdGVycywgaW50ZWdyYXRlZCBlbmRwb2ludA0KPiA+ICtyZWdpc3Rlcg0K
PiA+ICsgIGJsb2NrIChJRVJCKSBhbmQgcHJpdmlsZWdlZCByZWdpc3RlciBibG9jayAoUFJCKS4g
SUVSQiBpcyB1c2VkIGZvcg0KPiA+ICtwcmUtYm9vdA0KPiA+ICsgIGluaXRpYWxpemF0aW9uIGZv
ciBhbGwgTkVUQyBkZXZpY2VzLCBzdWNoIGFzIEVORVRDLCBUaW1lciwgRU1JRE8gYW5kIHNvIG9u
Lg0KPiA+ICsgIEFuZCBQUkIgY29udHJvbHMgZ2xvYmFsIHJlc2V0IGFuZCBnbG9iYWwgZXJyb3Ig
aGFuZGxpbmcgZm9yIE5FVEMuDQo+ID4gK01vcmVvdmVyLA0KPiA+ICsgIGZvciB0aGUgaS5NWCBw
bGF0Zm9ybSwgdGhlcmUgaXMgYWxzbyBhIE5FVENNSVggYmxvY2sgZm9yIGxpbmsNCj4gPiArY29u
ZmlndXJhdGlvbiwNCj4gPiArICBzdWNoIGFzIE1JSSBwcm90b2NvbCwgUENTIHByb3RvY29sLCBl
dGMuDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFdlaSBGYW5nIDx3ZWkuZmFu
Z0BueHAuY29tPg0KPiA+ICsgIC0gQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29tPg0K
PiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgZW51
bToNCj4gPiArICAgICAgLSBueHAsaW14OTUtbmV0Yy1ibGstY3RybA0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtaW5JdGVtczogMg0KPiA+ICsgICAgbWF4SXRlbXM6IDMNCj4gPiArDQo+
ID4gKyAgcmVnLW5hbWVzOg0KPiA+ICsgICAgbWluSXRlbXM6IDINCj4gPiArICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAtIGNvbnN0OiBpZXJiDQo+ID4gKyAgICAgIC0gY29uc3Q6IHByYg0KPiA+ICsg
ICAgICAtIGNvbnN0OiBuZXRjbWl4DQo+ID4gKw0KPiA+ICsgICIjYWRkcmVzcy1jZWxscyI6DQo+
ID4gKyAgICBjb25zdDogMg0KPiA+ICsNCj4gPiArICAiI3NpemUtY2VsbHMiOg0KPiA+ICsgICAg
Y29uc3Q6IDINCj4gPiArDQo+ID4gKyAgcmFuZ2VzOiB0cnVlDQo+ID4gKyAgYXNzaWduZWQtY2xv
Y2tzOiB0cnVlDQo+ID4gKyAgYXNzaWduZWQtY2xvY2stcGFyZW50czogdHJ1ZQ0KPiA+ICsgIGFz
c2lnbmVkLWNsb2NrLXJhdGVzOiB0cnVlDQo+IA0KPiBJIGFtIG5vdCBzdXJlIGlmIGl0IG5lY2Vz
c2FyeS4gQnV0IGlmIGFkZCByZXN0cmljdGlvbiwgaXQgc2hvdWxkIGJlDQo+IA0KPiBhc3NpZ25l
ZC1jbG9ja3M6DQo+ICAgbWF4SXRlbXM6IDINCj4gDQoNClRoZXJlIGlzIG5vIG5lZWQgdG8gYWRk
IHJlc3RyaWN0aW9ucyBoZXJlLCBkaWZmZXJlbnQgU29DcyBoYXZlIGRpZmZlcmVudA0KY2xvY2tz
IHRoYXQgbmVlZCB0byBiZSBjb25maWd1cmVkLiBGb3IgZXhhbXBsZSwgdGhlIHVwY29taW5nIFNv
QyBoYXMNCm1vcmUgY2xvY2tzIHRvIGJlIGNvbmZpZ3VyZWQuDQoNCj4gPiArDQo+ID4gKyAgY2xv
Y2tzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+
ID4gKyAgICBjb25zdDogaXBnDQo+ID4gKw0KPiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgIl5w
Y2llQFswLTlhLWZdKyQiOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvcGNpL2hvc3QtZ2VuZXJp
Yy1wY2kueWFtbCMNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0K
PiA+ICsgIC0gcmVnDQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAtICIjYWRkcmVzcy1jZWxs
cyINCj4gPiArICAtICIjc2l6ZS1jZWxscyINCj4gPiArICAtIHJhbmdlcw0KPiA+ICsNCj4gPiAr
YWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiAr
ICAtIHwNCj4gPiArICAgIGJ1cyB7DQo+ID4gKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47
DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgIG5l
dGMtYmxrLWN0cmxANGNkZTAwMDAgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54
cCxpbXg5NS1uZXRjLWJsay1jdHJsIjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDB4MCAweDRj
ZGUwMDAwIDB4MCAweDEwMDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MCAweDRjZGYw
MDAwIDB4MCAweDEwMDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgPDB4MCAweDRjODEwMDBj
IDB4MCAweDE4PjsNCj4gPiArICAgICAgICAgICAgcmVnLW5hbWVzID0gImllcmIiLCAicHJiIiwg
Im5ldGNtaXgiOw0KPiA+ICsgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiAr
ICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgIHJhbmdlczsN
Cj4gPiArICAgICAgICAgICAgYXNzaWduZWQtY2xvY2tzID0gPCZzY21pX2NsayA5OD4sIDwmc2Nt
aV9jbGsgMTAyPjsNCj4gPiArICAgICAgICAgICAgYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwm
c2NtaV9jbGsgMTI+LCA8JnNjbWlfY2xrIDY+Ow0KPiA+ICsgICAgICAgICAgICBhc3NpZ25lZC1j
bG9jay1yYXRlcyA9IDw2NjY2NjY2NjY+LCA8MjUwMDAwMDAwPjsNCj4gPiArICAgICAgICAgICAg
Y2xvY2tzID0gPCZzY21pX2NsayA5OD47DQo+ID4gKyAgICAgICAgICAgIGNsb2NrLW5hbWVzID0g
ImlwZyI7DQo+ID4gKyAgICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnNjbWlfZGV2cGQgMTg+
Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgcGNpZUA0Y2IwMDAwMCB7DQo+ID4gKyAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gInBjaS1ob3N0LWVjYW0tZ2VuZXJpYyI7DQo+ID4gKyAgICAg
ICAgICAgICAgICByZWcgPSA8MHgwIDB4NGNiMDAwMDAgMHgwIDB4MTAwMDAwPjsNCj4gPiArICAg
ICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
I3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJw
Y2kiOw0KPiA+ICsgICAgICAgICAgICAgICAgYnVzLXJhbmdlID0gPDB4MSAweDE+Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4ODIwMDAwMDAgMHgwIDB4NGNjZTAwMDAgIDB4MA0K
PiAweDRjY2UwMDAwICAweDAgMHgyMDAwMA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
IDB4YzIwMDAwMDAgMHgwIDB4NGNkMTAwMDAgIDB4MA0KPiAweDRjZDEwMDAwDQo+ID4gKyAweDAg
MHgxMDAwMD47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgbWRpb0AwLDAgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicGNpMTEzMSxlZTAwIjsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHgwMTAwMDAgMCAwIDAgMD47DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAg
ICAgICAgICB9Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9Ow0KPiA+IC0tDQo+ID4gMi4z
NC4xDQo+ID4NCg==

