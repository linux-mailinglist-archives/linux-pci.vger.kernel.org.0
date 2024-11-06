Return-Path: <linux-pci+bounces-16099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C729BDEBF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 07:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA027286064
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 06:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414ED1925AC;
	Wed,  6 Nov 2024 06:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PBBunqc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE6192D65;
	Wed,  6 Nov 2024 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873912; cv=fail; b=hGFICrgXI2bSw5EhVy/eyjcZppF8ZZJWxD9mGfdWQPoUlNxO0ePhTxx06EEij8REKBJOjyrf/dn/8EftQ+qfm+NoLCLMTkMzKPQlzJRxhZsbiS2Z+fYm4B6xIltNInWasxUB86ETpgCdLy/7NbXV3gCP2dQD+sG+e51NLN+/mzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873912; c=relaxed/simple;
	bh=6bPchJhllR775OGnFP7XwIxgM0rvfta+iVqvr2lAyUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lAJOZcd6aT6obEn6gtuk/SCnRbIAJmqomzebDjueiVC+0NVJdpvkzs9fpAyZXrTUt0fCJHpy2CS0xFns+U8nknAH4xfRgrit5Rx6L11em8grPku5RYtMCfDBeJhF/rDHuUVhATkA7wEmRNcZAspUt1wekMiQnM6iN9OqwJtgF1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PBBunqc2; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+CLFEjL7gaEbHu8X7T33tx3VGg1TYXKbf17tk1zhh5TBCr2jjAgkutZUrkQeXskH72XMzb+3pZcjq7bcMckWiCJc6uZ8IcGAC4qGP9diludlqHssYe3J3HeHtHOksY1Yu+PHePUiMoeqoBcuJ3crKcgi6f79VhMiGdhNuFcaRuqFjD8u9qye+SnlzbUGJ4+RQsOCDZyd+pAv0skVGTNPuHGOX6N9LwZi1guKOCUKZq7dLxJY+kvV4/G0YmdgAyfpoQ2nQBWVaahDi7Sy86cByaPIeF4TQ7X4WE/fjV+6xxntTq1HpiMKaL4aZZeCkJYNeQ1dnvj37mL5dHClflsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bPchJhllR775OGnFP7XwIxgM0rvfta+iVqvr2lAyUw=;
 b=RNqd+ceAMNM/X9AAiGsT6NG36CiU9ORbHzrryY1yxlnV0snY8NjMXxRBjnZCs4c5B29xhSxJ2EtPzxvb3dI/KWUJpGecJRp5iombZ380RyMJmJy3WrIE6biXOeBFgGhwhSufCeuZqotE+CNaVV++AuUs15MnEqxQsSRorQOzm1xkYP4DONziP6BwsO5XnAc7m/p9cHtMopXadtKkJH+0iVW9j64jVZ4cPYGWFyF6HHUlYa6Sj08ETmKAsI4c1j2Q9dH+1HiAQc/pufZT5wx0mmxVtyauM6tZd2Ul5QfPaPNuZ/jv5yUwIdZNjSDUiyUkpcFQZku6zbVARkSKcJW6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bPchJhllR775OGnFP7XwIxgM0rvfta+iVqvr2lAyUw=;
 b=PBBunqc2jazj5bIEAfDKREw1vkhIPjWIMKP87j4h0aSmntGdg+d4ptEGk105FrvhaosD5e30C9Y5h4iKYEM3EbJy6mxcE1SBePXh9TYJk4Pvm9ieSweirKJRiiPzxRJiOLjJ+ufS36bisPRZh6Gh+o0E3xjyudmWu/IzXqtOeKmPwyxvr1D5VIvgiI6P+Io2icot5lEGYCG/ks2C2+LQTHh6A3UGTjF6VECqJgfc2xXWM08qR8EfTH0xNh6sJkmABrMdvbeHV4QZ9Hx+MZU4Fu8bLhl+II7AFYQpC7b6CWSmQq0lL9e1INkb3iRIe715b5Z3w4ZgljiBfhM+snDG0A==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 06:18:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 06:18:24 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kwilczynski@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index: AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKmrdaAgAPAQkA=
Date: Wed, 6 Nov 2024 06:18:24 +0000
Message-ID:
 <AS8PR04MB8676B83C73ABBA45A34C58DB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721628913-1449-1-git-send-email-hongxing.zhu@nxp.com>
 <20241103205659.GI237624@rocinante>
In-Reply-To: <20241103205659.GI237624@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GVXPR04MB10384:EE_
x-ms-office365-filtering-correlation-id: 8c40f459-1ce2-484d-9250-08dcfe2ad23e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Sm5kMS9SNEpNblRaSHRRYUNwYklvcVQyUG9tMjdDSndqTE1vVldOMHZmVVFT?=
 =?gb2312?B?cHJqNzUzNCs0UGIrZGZyQ0Z3RjMxemxOV09XSEZXR0U3cFVTdTduT3NveVU0?=
 =?gb2312?B?T0xnMWMzNUcreWlGd1BRcm95MVpwQkl4QlZtdnN1RmIrczVmdlhWSFdacGZM?=
 =?gb2312?B?N2RnZHozTTRJckNjamMzSUdrcWk2RWNlRDNxUFZBem5VZ0JQNkRIL1kxc3Z4?=
 =?gb2312?B?b2RyUS8zRDl5WjhkYS9ZZ3B2ejZROE9jUlRUcXNYZTNNOHl1Qk9aUXlUazZ4?=
 =?gb2312?B?d3dhbHRCcHJCR2d6ZHo1d2hCaUdyQlFrKzcxM0hna1hEYys1VFJaUndTcWNJ?=
 =?gb2312?B?MU5EVEhwRHcvdW1MWFFOSDdJcXBuK3BQVGVuSHVyUitPZ25jdmVLelVTNmhP?=
 =?gb2312?B?Q1luSHpZVGdMU3dZWjdmZGsrTXFNVHR1aTFHSjFNODBHRlJ5aXdERllsSmhH?=
 =?gb2312?B?WFg4VzB5OTJhRGFmZUlheHFxcmVlSVdSamtsTExEWW9PVWFVOUZoTTFOQ1Fa?=
 =?gb2312?B?UnNtanRwQkV6Vm05b2lpRDNaWFhPaStsMTRGTDNoaFRUVFpVdnNsSzA2eTBJ?=
 =?gb2312?B?NG1kTklmWlUraC9LcnRPWmtOVjhtOElOTFArd1JRWWZBTUxLdE4xTGlzRStm?=
 =?gb2312?B?TjIwUk1MaTlvTC84MzlFV3RYaGlEVGlKTmw3YVorRm1uU2FXM0Y5Y3FodzhZ?=
 =?gb2312?B?QkxtKzFNd1M2NE9HT0M4RWhDdS9vUzA3c3lBUHAwL1RkTFpFSHNDakd3N2xk?=
 =?gb2312?B?bTFRdXVDa3dBcTkycmhqWWVkVzNNcHgxZGZyOVJzYnNqV3ZjVnRwSHIwMDNt?=
 =?gb2312?B?Vmk5Z0dhb3hKZ010MUpRRnFVdFBQT0l4ZFZESEQ1TkIzcDVYa1FSVUk2VlZv?=
 =?gb2312?B?OFE5dWdaaERwWDZidCt5Mko0NnArQVNFa0pXaGdrdVJyMFpnYzZwRjhjNVU2?=
 =?gb2312?B?UFp3ZkJmU3p0OXZ6cVNVSlVWeVM4bXplcUZtOVlpUkhoSThLZzlvZi9zS3py?=
 =?gb2312?B?VUZQcjdCOEpPVnlWRzB3TlFDQ2RtOEZTNkJZYzI4MjdCZ2UxaXlBbmRJOUgz?=
 =?gb2312?B?dkh0VTZEYWEzY3kxRHd1UFp0SHVrbkdBMEQ2OU1GZTY3T2xjZWFyV29SYXNE?=
 =?gb2312?B?WEt4NXhvcFgwQ09XVWl2azBhNGwyRVZ2K0FQN0ZyVzBydEpXbEI1V2xVVVZG?=
 =?gb2312?B?clF5dHJzeUt3WTBna3U2RnY3M1RGNkIwd20xSTZkN3BVUG0raHBNTEtEYXVP?=
 =?gb2312?B?YjNkTys2ZWZCZGU5VENYOXdBL1U1YXFTTGZsa0lSQXNZZEVrcnhyR1NZT0d4?=
 =?gb2312?B?K01tUW85cFF6d0g2N25vQnBsRzQ5dnJEK2gvaTBjTkxXdUQzUm40cFR5bHds?=
 =?gb2312?B?cW5LeDlQL3JCNmcwM0JHQVVpdis2cHlJZmxuVVZURjIyV2dQZk9IbXlWUkZs?=
 =?gb2312?B?TlNXd29MWlBUU0VHNklFdzluUTg3MmFSSXgwQXNDWTltTWI3aS95T200U0lu?=
 =?gb2312?B?MU53emdRaWhrTnFIYU5QbkRKMWRZQmx6SWY1aFZCWk5SM1YzeVN0aTdFSG0r?=
 =?gb2312?B?LzZ1U1hMSUNkVTJhSnlPaERuVHV3RzE1dEtaVDJ6bW1WNjNxZkNMMm9CNGFh?=
 =?gb2312?B?V3ZrNFg4UUJzQUVHZXA3MnJLa2NrOTV2bHJyN2hITXNROHRqL2t3TXpZVFVo?=
 =?gb2312?B?dytBOC9CcXREYzhLQWRNNHQ5VXZaTGtyMkYvVTRNeWI2U2hpT3FTTTRZc3dC?=
 =?gb2312?Q?0nVLykDv4GGkVEFYHQkYmCf/71RDKSMwJNUj6Zu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OFZpc3FtOGJzNzNxQlpsSUxsTE1tcGlTMXJPd3J3YzZjdVRDRmJXYzFuN3pE?=
 =?gb2312?B?Z21GWnhQMHdXc1duQXpKMHlrd2lreTdQUU5jVU12ck9NMUo5NExHbWdGQWto?=
 =?gb2312?B?dituODRmQmhRQ1VnUndyOG8yL2Y2eGdSTEJtTktXVTlXWUJqMC9qSFdoZ1RY?=
 =?gb2312?B?YXdOUHdSZDdyL2VFRzQ5a2kySXpSZTJpMkRCcHl5QmZvTW0vTklTNVZ2OXdN?=
 =?gb2312?B?ZWkzQVh1TnFqQVFQTGh0ODZlTmFKalZEUStUSG9OL0pNSHAwOHpyL3dCQTJJ?=
 =?gb2312?B?WU12K1ZMQjR6OFN6azVwd2dhQVB0WDQ1UWMxNUtDL0E1OTljWEJoWUQwZzJQ?=
 =?gb2312?B?UWtONUFUTzE1QnVlakp6VXpoVmF2SEJNMjcvUW5ZMHNIYloxWmE4QysrMXA0?=
 =?gb2312?B?blhNL3g0dFdkdlh5U09obHNPMUdQV3oyWkpjZzJTbkJDWmNYYlNoSUp5Mmpp?=
 =?gb2312?B?TTNlajJVRmFmZ1lEQzlwQWJnbTdyN1QrUWJVTWNrZjg4VmJZVWFMYkpMclV1?=
 =?gb2312?B?YjUvemxWL2M2WHIrSlFiaEVCcG1OTG9VampSbTgxWFZReUozS29rcWNwQmFq?=
 =?gb2312?B?cHJYNFVOSWRIWnVFb0lBb2l0b29ld2JnWEg3cTRDNjlmc2U2TllaMDJ6N21n?=
 =?gb2312?B?elk5b29pLzNtLzk2S0VxSExGTTh3VWczRFdYS2JTS0hjY0NFN1M5K0FDVUZI?=
 =?gb2312?B?YWVQRHJUTWt1a0dkTHZrNWVEQTdrd0VMQ3RMSXZzdmM4akluOS9PV21laFFH?=
 =?gb2312?B?SGZuaUtsUFBGNzRSLzZOZyt2cWQwTDNtYXVJbUpxV2x6NlhYbXhnZ29CL3dp?=
 =?gb2312?B?UzhrTGdMQy9IU0tMVXNYYmxDcXVwNS9yemxxbzlDQi9ZdzZLU2dKanBVZ2M4?=
 =?gb2312?B?T1lPb3B3SURHWW9ZZUhWT25mWkt5ejcxbCs0VythckRQVlBiTFVVYi9XZGxD?=
 =?gb2312?B?VWIyVHJPNzdPaWFOMUY2MDQrRnhwak9LdW5sRUxEMUwvQUV3M1U5MWE3ZDhD?=
 =?gb2312?B?ZlJPajcyenA5ZnlJM1pFT0tOejJFMGx0aUhBV211b0ZDWlRPZU1iQ0xtSU85?=
 =?gb2312?B?dXN1QVloTVVBQ1Njamh4SDlKVDZLeVFKNHo1TmI5VUEzU0UxTERSZFVtenpm?=
 =?gb2312?B?eTVyTkxLUlZwS1laOC9kZU5iNG9JN2VZUE1wSmdFZ1pFQk5UUlJKS0xHaTlp?=
 =?gb2312?B?TTQ4a3RFRWpqcWxUU0t5MVh1Uk1BRmxrbml3ZUpNVVlHTFF6T0VvTUo1RUNC?=
 =?gb2312?B?ZE5ibWxZaXZGQUJGR2NucjYzM1RleE5xaHo5d2JlWVpuc2hrb0o0Mm5YU0hV?=
 =?gb2312?B?MVBpWmtrTnZMRmNab245TmRJdUY5alEwSnRlQnM5elRLUkRMYVY3RXVvQmtT?=
 =?gb2312?B?cUtSMlJTSlhIaTdHNXNlNmhYVVROcFdiQjhCd3p0KzhKMGVBZDFGVWFodVZI?=
 =?gb2312?B?QWQyWTYxVHRWL3c0cVBvNUNadHpjOGFXL0RESGt6RjV4SjMzblh1U0RFb215?=
 =?gb2312?B?T1YxaTMwMEpwRUhvMkZaMXBNMytpYnFDdTB5S0xYS1hhaUpmMzJqczlXSHZo?=
 =?gb2312?B?TGNaRWlXOEdFZ3J6YnZtbGZjYTQrQkZNc0FheFFMM1YzR0ZLMkZZZ2pQN3ZJ?=
 =?gb2312?B?dGFpZzMxV0NjZThOc2I0eUZSeEpZUjAwTVVyUHpreWthQUZucXpJc2pNOWFW?=
 =?gb2312?B?SDh5MUc5U2NjUWZ4L0VzWlVoemh3R1Q0SWRORTZxNG4wUVRHM1M1MXRKenA3?=
 =?gb2312?B?cjY4UDZhRHphalU1eVFxemtnZXBhTTA3T3hmbkc3QjdMQldiSDNRZWhkZHpM?=
 =?gb2312?B?NFV2TkhQMHk2NXVZMXhUWk4yVG8xTnZWRzlCR2syOFNzVGMxMjhPV241Q0xT?=
 =?gb2312?B?QUY4MTdWQXpBVU94bnBqeGpreEJBUnE4R3FEZm5GSG8wc0tNTzdqbkx2TGVL?=
 =?gb2312?B?V2NsQytaYVlqUXlpTGtkbisyY3lzSm1SSE5oQ2drWTBCT2xLdy9CL3h6WGZt?=
 =?gb2312?B?SEZTZk5la2ZPak5YUjdvMnowcjhmbS8xb0k2cEM3cFZKS1YxRHF2RzRFbGQ5?=
 =?gb2312?B?L2wyVHRjNjB2T1VLRWJxNVIvZzlDUkZqSDBBK25xWUp3UWlOVHBOOXV1K1h1?=
 =?gb2312?Q?10Y1lagF8+n9dYc3yxSgwHmWQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c40f459-1ce2-484d-9250-08dcfe2ad23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 06:18:24.8759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rul6mT5A6LCZQ8IsBFJKpMI9wWaK5upY4yhovBG3QroIobQEtY7ScgDBeB6I0R1sB4bb1/kTzKtCRYHjVHtFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5qL1z
a2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jEx1MI0yNUgNDo1Nw0K
PiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGJoZWxnYWFz
QGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IEZyYW5rIExpDQo+IDxmcmFu
ay5saUBueHAuY29tPjsgbWFuaUBrZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgaW14QGxpc3RzLmxpbnV4
LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBQQ0k6IGR3YzogRml4IHJlc3VtZSBmYWls
dXJlIGlmIG5vIEVQIGlzIGNvbm5lY3RlZCBhdA0KPiBzb21lIHBsYXRmb3Jtcw0KPg0KPiBIZWxs
bywNCj4NCj4gPiBUaGUgZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkgZnVuY3Rpb24gY3VycmVudGx5
IHJldHVybnMgc3VjY2Vzcw0KPiA+IGRpcmVjdGx5IGlmIG5vIGVuZHBvaW50IChFUCkgZGV2aWNl
IGlzIGNvbm5lY3RlZC4gSG93ZXZlciwgb24gc29tZQ0KPiA+IHBsYXRmb3JtcywgcG93ZXIgbG9z
cyBvY2N1cnMgZHVyaW5nIHN1c3BlbmQsIGNhdXNpbmcgZHdfcmVzdW1lKCkgdG8gZG8NCj4gbm90
aGluZyBpbiB0aGlzIGNhc2UuDQo+ID4gVGhpcyByZXN1bHRzIGluIGEgc3lzdGVtIGhhbHQgYmVj
YXVzZSB0aGUgRFdDIGNvbnRyb2xsZXIgaXMgbm90DQo+ID4gaW5pdGlhbGl6ZWQgYWZ0ZXIgcG93
ZXItb24gZHVyaW5nIHJlc3VtZS4NCj4gPg0KPiA+IENoYW5nZSBjYWxsIHRvIGRlaW5pdCgpIGlu
IHN1c3BlbmQgYW5kIGluaXQoKSBhdCByZXN1bWUgcmVnYXJkbGVzcyBvZg0KPiA+IHdoZXRoZXIg
dGhlcmUgYXJlIEVQIGRldmljZSBjb25uZWN0aW9ucyBvciBub3QuIEl0IGlzIG5vdCBoYXJtZnVs
IHRvDQo+ID4gcGVyZm9ybSBkZWluaXQoKSBhbmQgaW5pdCgpIGFnYWluIGZvciB0aGUgbm8gcG93
ZXItb2ZmIGNhc2UsIGFuZCBpdA0KPiA+IGtlZXBzIHRoZSBjb2RlIHNpbXBsZSBhbmQgY29uc2lz
dGVudCBpbiBsb2dpYy4NCj4NCj4gQXBwbGllZCB0byBjb250cm9sbGVyL2R3YywgdGhhbmsgeW91
IQ0KPg0KPiBbMDEvMDFdIFBDSTogZHdjOiBGaXggcmVzdW1lIGZhaWx1cmUgaWYgbm8gRVAgaXMg
Y29ubmVjdGVkIGF0IHNvbWUgcGxhdGZvcm1zDQoNCkhpIEtyenlzenRvZjoNClRoYW5rcyBmb3Ig
eW91ciBwaWNrIHVwLg0KSSBjb21iaW5lIHRoaXMgZHdjIGJ1ZyBmaXggd2l0aCB0aGUgb3RoZXIg
b25lLg0KQ2FuIHlvdSBoZWxwIHRvIHJlcGxhY2UgdGhpcyBjb21taXQgYnkgdGhlIGZvbGxvd2lu
ZyBzZXJpZXM/DQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAyNC8xMC8xMC8yNDANCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+DQo+IGh0dHBzOi8vZ2l0Lmtlci8NCj4gbmVsLm9yZyUy
RnBjaSUyRnBjaSUyRmMlMkZlYzAwOGM0OTNjMjUmZGF0YT0wNSU3QzAyJTdDaG9uZ3hpbmcueg0K
PiBodSU0MG54cC5jb20lN0M5OTYxMmMyNjRlNzA0ZGVlZjNmNTA4ZGNmYzRhMTIwNSU3QzY4NmVh
MWQzYmMyYg0KPiA0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM4NjYyNjQyMjY3NDE5
NTMxJTdDVW5rbm93bg0KPiAlN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhDQo+IFd3aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3QyU3
QyZzZGF0YT1ybElqVjJnWldubnJ1VVI4RHluVHF5VQ0KPiB2bk8lMkIlMkJ4dnp4aUNEdyUyRm5l
b1FNdyUzRCZyZXNlcnZlZD0wDQo+DQo+ICAgICAgIEtyenlzenRvZg0K

