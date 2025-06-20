Return-Path: <linux-pci+bounces-30232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A029AE12E8
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCFA3BE39F
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FEF1DC997;
	Fri, 20 Jun 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="LGAVFgri"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023122.outbound.protection.outlook.com [52.101.127.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7078F39;
	Fri, 20 Jun 2025 05:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397276; cv=fail; b=Zoyr3smfpl7TthzigwhFHF24zTriYO+dwiHN0hLzAtQEgLFM/R8VUHsDkGN9ffO6Z83R/TOkCMUF4UBm7Z2GHJPk6NzoFY26dJEeDUdnB6Xfq+A71fiRpeDMsTE14YVY8FWlkByliv2dGw4DR946bK1ngomTRyEd/qoIuL6TTVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397276; c=relaxed/simple;
	bh=Qjp/6MU5HrdKytFmRs6SJekVpomeJ3MDxEZBsUVvqlA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ppSUBzoSjrxaAkCZ7REZ+wKhM/9+Vd+iaBYcdBPEznioBU5WjrUUiTav1BgkaBLIVdUS1LiIzj6mcvqRAsL3zVpsbdR4OAflXifcX/lFQTH5ouon+pfsnwYy1esxX0Bu9PnSjmf8lJGTsI5YTePhNTMIAYMKnYE6r3LHyr+M+sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=LGAVFgri; arc=fail smtp.client-ip=52.101.127.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sngjfv6er/DRkB0MZL+ORA8sOw69pHdfG51P2wLp98jtGnHK0TIZRidDY+wgRuuBwr4+BHSijL5cOoO27xbom3Zn9sPzWYIUJgA4W7Ioi2zkKQJcy57sZJsZoq1erUyuqLtJ40kZ62uGsscfLd0Kwl6CPzC+zQ83/+PdJdcd/YFzuScKirlYtY6eOb3qMJqXyr9MEQQ+PVN+McAgT/LrgiDtjKVoXpPUbKi7kvRkmOVD3S37vQoS32fYfDCOaKO3uwxkfCZfCrPCPWfkVp/OyvS32ZFDjHdGUzbP3fXWjCkftomwuRg+XG267Fj75wtkPD1mOUFz5omZE1tz9vlBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LjxTJwOL1uBc9UFlDBB7iWH9Jv4F6OiMkd0iF5tBIM=;
 b=cwyt88m3bTDVTRaUHkVzy/xlfLqYkr2p73aq7g9RZ/QJwXlJE2v+j+w4MvnQUukBdZE+1UNiwL3PCrtHzrrhhUSwRUl+Y33BeHGAn9tZB3JwjRdaGr/Z1jbJpCdYBa/L3NIM3jQGSWac7oAMhHqEMhYeNq8P9PGTYx9RvT8Gyl0taFPwdOYyJr2kwbMyimCzPVSLGy+6S7LK9TAF6Md+Sa+ZqzMijzySW2OXZjy8DLoimKsTnp+F914kZjEj0/i5cV4g7ceh20gVMHYfwooDcJQrhAdj9k1JN5XnbYELUgJsD5mOEsr0BJYsFkAtFQx4B3j2oZW6ZvgvYeWLRe5lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LjxTJwOL1uBc9UFlDBB7iWH9Jv4F6OiMkd0iF5tBIM=;
 b=LGAVFgri5M4TkFMjGf2l44pUqcu29uA59UxRjh30tlJvxG39XWgVtyiOPnFyHkipPRWRWM0SlStFq91+nE1cDycxeDQyo8mpp6zbuBkhIWTI6Y9oqiyohhUlNPX5uK4Vvm0B/VbHezgkXCtuiCwt1WxutZwR37zOYxWj+1oiBuS0kN2uNhkswIntem6gJ/x0BYJag7ZJoRkrkRGIzAnPfdGCSphY9XbTfkyC+LTGU3gQcO7HLJdv+pNcvYuAVmet5TnOAgh4mTDw5mKNPeB7zRv3BNOrRegzy8nGyOe+AzI83yKsLhB1vxbEAH7h5mvAU+KZ0uH/xaOgkBoqzCj0Rg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by KL1PR06MB5881.apcprd06.prod.outlook.com (2603:1096:820:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Fri, 20 Jun
 2025 05:27:42 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 05:27:41 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "elbadrym@google.com" <elbadrym@google.com>,
	"romlem@google.com" <romlem@google.com>, "anhphan@google.com"
	<anhphan@google.com>, "wak@google.com" <wak@google.com>,
	"yuxiaozhang@google.com" <yuxiaozhang@google.com>, BMC-SW
	<BMC-SW@aspeedtech.com>
Subject: [PATCH 2/7] dt-bindings: pci: Add document for ASPEED PCIe Config
Thread-Topic: [PATCH 2/7] dt-bindings: pci: Add document for ASPEED PCIe
 Config
Thread-Index: AQHb3BN3Xr1cWRFQV0ue0ayv7Ceu3LQBP/eAgApPtOA=
Date: Fri, 20 Jun 2025 05:27:41 +0000
Message-ID:
 <SEYPR06MB51349FCA8538C96CE41027649D7CA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250613033001.3153637-3-jacky_chou@aspeedtech.com>
 <20250613155853.GA962329@bhelgaas>
In-Reply-To: <20250613155853.GA962329@bhelgaas>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|KL1PR06MB5881:EE_
x-ms-office365-filtering-correlation-id: d4dd4758-2dda-4162-b3ef-08ddafbb2dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yKhW/kHWRQ2AL9fj9MoZfivA1dE1jDtw7DIbUutERZHwYL4LBKYQB/AHUfiY?=
 =?us-ascii?Q?m8I7Kr95VRKAfkGBzzYzn1HooV/tYWTg3d2yc3HXs2ZV7S4B5BWEtQbrdkyP?=
 =?us-ascii?Q?HyrS1YsRNSriWBncxtz3HDmH7CebjeehhT8dqmZ9StaY39EnT9efYMKOzXts?=
 =?us-ascii?Q?3OkC8ttbLlvzwaAQDY7pAVUy7nYmhwuqgALJKB3+vaO7jrBoIF1wbBRkotV4?=
 =?us-ascii?Q?dmcFZjcIH3Is5BndxTv6FHtfV5r26I7qdOHorWXXqlboJW+8aTmbHeBz1B3/?=
 =?us-ascii?Q?6U9eiYiHJarokWOSQOPgaWa7faCnjExeCzcX/2yKEMm5xF6TlpixBCVMvq4N?=
 =?us-ascii?Q?GwJ6b5bX5pqucNC1MbYuk0UeHrCjAsKRyUOJCx+lojPPcqujTJcU5eaPy7Ya?=
 =?us-ascii?Q?CGuU8gcsUlxu+A3V2Ceq1zQN5dHSgfnwf+CvKYoVq5726reeQwrr6roF3hYU?=
 =?us-ascii?Q?36DlA35z7GFtfdEu+Dl5IHxEgKe2P0fhESHNikbH/y02r0SmN+f0Vl80qbCl?=
 =?us-ascii?Q?dDua8OhAS9K974y9wlAQn5cTD1r7+hHJY3+7q4IO8lDKDfbPCekTZ4VAgvla?=
 =?us-ascii?Q?tLtN6x2HMJ8ima9nqvOCJ/em4xpYgb4WhbELg9xqCxc0g4G8HZyZzG8d6RjB?=
 =?us-ascii?Q?sovxg9lK1w9BgRC1G/QDj349Ezm93+JM8vmLnHkvQvJFfKppbudP2TlNR9T2?=
 =?us-ascii?Q?QqwWa3X+KATvgeDR1+gsMRSMnTH2wibjUnMeTX+OvNZn4jS0e+S3az5yzQIy?=
 =?us-ascii?Q?QP+ZNqECx1l0Wog6zPijk/IBhJnBJ3JOeF2V41svpiYjXhSw4plP3Ng75Yl8?=
 =?us-ascii?Q?nsRYKG2T/SbSTN3pFCL6+iJ6PGo+mCldbOn03+ReBm78fWXmewY19rXUmzwe?=
 =?us-ascii?Q?7RBBd/YpBx3A0nEo1m38v7wOkE35DJDyVjcYIoXSzxjS3PfEzKmDFnkxdhuo?=
 =?us-ascii?Q?hyY0rEAxzsUb7h4Vh5QJQ9gDhRLGnMTisQhD3IBWpR3pxtiGc5TX0pNjIdm1?=
 =?us-ascii?Q?UkrM+sAc/0O/foL2KguIUXFJjhvhkLMW0Tzjs2kAuNhnBRS+RDxtxyYun+Wj?=
 =?us-ascii?Q?bjblR4Z80advavhgV+/hJ5OyvglC9IAnyauqfmo3OsUJV2aUcclD2ZpmkUUa?=
 =?us-ascii?Q?V4AJAoXDvBCl8aNO6VZ8meu9+6KcCotU05seRyCt4ZxIf0TJMPthcezzPjmH?=
 =?us-ascii?Q?WpMdgbNiCN/Q1TMTiiEvPSuyBOCKNEjnt2ZyaiR14Wy6DnUugYlB2PQBAajJ?=
 =?us-ascii?Q?Wd2rS1cQzH2vbMDWOA7UnpkEkh5hmYTo1PkLLvpGM8pHxJymk45+xO3yhABl?=
 =?us-ascii?Q?RGceazg3HVOQoDMPeF7TmLjmJK1YuAHcUBEdymm6P7YVdZhFsW8Poo4fPZF1?=
 =?us-ascii?Q?RuO439C/ado9fJLxboAQ0LXM2Cq6CHOpwYTOfwppxNlOPfcxwzbfvPrc85bw?=
 =?us-ascii?Q?R7GzWR+eWWtR7yY1L3ON5YKbjnSiCeC2EatP1tM2iBiZwuAQmMzf6ZnqWdsx?=
 =?us-ascii?Q?xQtlHcS25yCKI9A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EkaFj9pTmf8T+yvN+QD+xDvWhiWp45BX5YdOzCuB7N5djLP4fB/SCeR5DGDf?=
 =?us-ascii?Q?dx9Hv8sL+PhW9ZX2M9aFLhk88mNJJIFqnMydW748biyc7wvMw4zi76s2aI4u?=
 =?us-ascii?Q?Y0Vb1gcaVBryqO5fc0HHHTAjRF0Hl7mWlVxTJcIBH2MfPwhZAfCEWYiUSMAm?=
 =?us-ascii?Q?ZBx5RbBY0at1AJw18HGL5ajZuOstlEx/14Zkn0Fshy4CPld7VYxV349ijR1t?=
 =?us-ascii?Q?dW0W+UvJJCHyPFTOijaAi3m6ibLrbXLrbm5W6yanBYKhgxd+9Y2hvZtuBiaS?=
 =?us-ascii?Q?6/2B1nKdWqlWI/ap5jZ5NCYyOTK8nXtJJ90AjsNoq1d8qEy+mhh5NKSo7C6K?=
 =?us-ascii?Q?8jIbTCf6AT38qxBqFED/qD2Tsld6bLX91zlwBZNtiSmApExP7SA4GO+eWmAv?=
 =?us-ascii?Q?8jmhVQZtlPNF3/qF5XfbH18Zk7iZY+tB8PKIBVRE6hE/0s1V8U5JIcG9WgkQ?=
 =?us-ascii?Q?obIRTqp+6LePF1ILyk/P+f3AjyPCZTuQREyjpeb/j9CaJUdyEHPSKeFAOlTZ?=
 =?us-ascii?Q?DcG3m8asRoVfhBNSsZZSl6AA9KUNGJppALJBJgFl5SEPfkdQGx7j+1rpyKq+?=
 =?us-ascii?Q?dgREkyssslfUpgHQ+yBrauksUZuG7fxyMRfL6/SEtLdcfMfM9Ub4ILex53Q7?=
 =?us-ascii?Q?gBk/M/H7LcAyy6EkU6o9dnr7CBMdOsaXSpjJERZyNIZkjZfijW9zGUtKfglx?=
 =?us-ascii?Q?fUwsxEHsQI1udU7SaOK3sdtcWjsHNg9/0P39wvCDLKrOOXcQEnzkKgTL8gsD?=
 =?us-ascii?Q?sk6P+bYxX2rDgsN0uGBb+W7zx/wRu2ldSf8Il334XWZvqytVIbRvGiOftNnp?=
 =?us-ascii?Q?v5l36DnXWU5w3wRJ6dsvz7OBQr70aDpYHaWZD/8LCfFc3NV2xxHcp/bEGA0x?=
 =?us-ascii?Q?+dHdm/OLYT/4sK6r+0vRINtZt3s+hQbi5Y0Q9OZnv9Z9hBtojeqVuyd33Vqt?=
 =?us-ascii?Q?UrQnAEzaoYP5rvTRfC4pCYP+kdfcCYY74rGViTXrOOtsM1h6ON8n7w4NabZY?=
 =?us-ascii?Q?6GZFl8aqmdimC0Wd+Im7U1nrQP/bh3yb4P4X1A0G2dVKoRWRt7EQFeJ7rs4N?=
 =?us-ascii?Q?rtE8Cj3cefyghkJSDZuSM692gYmJ8GkLp5BKUQqL+iVi9LPETKOYUTLrCQ0W?=
 =?us-ascii?Q?I3Wh5sRRD3Zm5V62bBiyrfR0Cx8GCRTTq8oHaaidNOcbsRP/4DIQ+PLqoL7/?=
 =?us-ascii?Q?SZVcMPUMAj0ZSXOvcxIaih0uaMbiQcjNulDXM+GhpIsERTStXwjT+xBLUEjN?=
 =?us-ascii?Q?tDimeClCEcOU4RirC7vB2OCPP8zdMp6mMDOlgwf1RWKQFov7dB6PeHUl7922?=
 =?us-ascii?Q?vDFoagv/C7qxAYsjOFC/wkGMmGY68+DB/7tJL/fEwPggHH9O4DHTfwrOD0bp?=
 =?us-ascii?Q?/GL4bg0LMPMQMAzJcKOGY/mqJuXe+4S5vMkJqI5oOJFOE6NtyjM48BWo6sfl?=
 =?us-ascii?Q?ZuBWpZqc+t5gtkqtvpdCou2fr2hvbGq5bKSGuwnDIWiHk4giF5ZU3XZ4H9ME?=
 =?us-ascii?Q?nHb1F7zGsU4k/6uuc5CfBdTR3/aOlcAtFVjZrZhTdIBthM1yGLcK1UW4nHOh?=
 =?us-ascii?Q?r+H3Bl4Xa4gcN2Y+tuuertCynvDx1HqndqOl253i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4dd4758-2dda-4162-b3ef-08ddafbb2dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 05:27:41.8227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYe0m821RqO0afDF4KROnUSHaPh188219mQyx/8Qocyy0vQrOSor1XEEt7iqwtvOwH9JmZp2kNYpld3t1zBugbUneBurT2J6H6K6aHNZJU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5881

> > Add device tree binding documentation for the ASPEED AST2600/AST2700
> > PCIe configuration syscon block. This shared register space is used by
> > multiple PCIe-related devices to coordinate and manage common PCIe
> settings.
> > The binding describes the required compatible strings and register
> > space for the configuration node.
>=20
> Make your subject match style of:
>=20
>   git log --oneline Documentation/devicetree/bindings/pci/
>=20
> s/Add document for/Add/

Agreed.

Thanks,
Jacky

