Return-Path: <linux-pci+bounces-12588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3955E967DAD
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 04:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9842812E0
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 02:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4909282F7;
	Mon,  2 Sep 2024 02:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gwDW4pN6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA1125DB;
	Mon,  2 Sep 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242892; cv=fail; b=NOiexV9rq9j45A7qwvS2Rg2hsMqfQRVfxlXo/H0rxo8x/NAlHWwN0ztJn1to12UiuwDH4kGfmM+tcDNb4H2VaFvLERMuEbwh0rOavgtkRcI4Qw/Ln3T18aq9k4nxnRkihdFCaV/iCT3jC975D5e5oBaC57mFHO0+MJYmkHUX9Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242892; c=relaxed/simple;
	bh=PX25FyMu+FZdf23ey7YsevekPuwUeY12PEkmrTZP4xk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PH8qGBz2UkGF3SCTj17jV4cDbLuJ4KAW3lk0Dy34KE6+Gw7PrhCzOSv28OUCo9/BbwNodslVZ1mcI/bO38aEIBQgVkoho4KNuNYaQPJk9wiUigWjt8eAZPvwiE3R84oqeiHHC5hmi+bFprmX8pYXB9D3oEOiWjFqmA6zlEQfdU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gwDW4pN6; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3UFFuxWHdllgQOj+xV43cBunslVSeoTXNinEiEQYyQ5iX5ujCAyRWDObgqZ+59gaDVI7pa+3ClEwfR6Vc0wSb3B024io1Drnw++70O0HrX01KaVtfLsO8AOtH94cc7P3brXbRODLqFfsZDUnz1OUG5yDveVWqnkaVNCh05r7bWJP59F+DbVIXIWggG/WB3lChzUr1WlHKgRTcLJLflhdfHNKoQ/1kCV7PvXKPzUX6a/1EhZPLTVXo931LvodSEAZBhZneuM3qpibvgYq840t1fzc7a3IR+z9+jQ7Wn4+ukqs0J4/8j2WzRXd9leBMAH6em7bnbbYjz3ENjp2n9rvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX25FyMu+FZdf23ey7YsevekPuwUeY12PEkmrTZP4xk=;
 b=B79tA7sQIwbMOod1oT/QBQCXrkvKka7IwOXxC5vngBDvV/z7Hod3MKRK8p5NeF0E8UkdyfJs5VHWOX8PuDP0TqKMaAYPU9P96pbanFr7YyZKC9k79IU1LS6BiPA46F6jpKM64sjVRaXLT/uHO5Xpdo7IqNr81oUJVByKPuYEDdxTaMebF+KK5oE4LvwZaXWk5XXDINkzgIjW5SjhM7XwY4x4X9h0jhUDzhx4rHfqu9NvkuqQh3552i2fHZweWk1Ap8ks9Bqsb5ZjBaWuJIAjY6OMw3mzGkfVbqUS4GfFe0EYnwnmIVV47b+2mUOd6SaSwanLEUmCwU5CcOZ3/3k4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PX25FyMu+FZdf23ey7YsevekPuwUeY12PEkmrTZP4xk=;
 b=gwDW4pN60qHjOGKFOt7h5ftXwi8CUtmtKidQ5XqgQGF+Mu8wu091hz0RpFvVULwEcJvojIFddHGwz1lKVk/tHBZh7stmpqcQnD0brVxOo0wg/rhwI4bKCXsC1P6hYJ1NIayi93x6nciGIj9bVciSDROTChAUKT4xdPV68a2VJtBDmObMv250bLkUBcDIxvvlfCN2r7EixWS8YtrPX7cB4Bsc0TG4rKqTsi22pAs4PaBnxVxtDyktL/i4E5ENNaz4Jy0dyG5MvI1fvnYa7LDWRm5uLfjbuA7NHDGram184ZgRD3Lu4hDUCP2gSlvsVrQHm3DE7QHmGVrLXR+TIRhcIw==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by VI0PR04MB10297.eurprd04.prod.outlook.com (2603:10a6:800:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 02:08:06 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 02:08:05 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kw@linux.com>
CC: "Rob Herring (Arm)" <robh@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: RE: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Topic: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Index: AQHa7VciS0QZKXNjsEqaFNKRvx1ThLIlYjKAgACYuLCAG3W/gIACbbTQ
Date: Mon, 2 Sep 2024 02:08:05 +0000
Message-ID:
 <DU2PR04MB867735122DF54CAB00353FCF8C922@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
 <172356674865.1170023.6976932909595509588.robh@kernel.org>
 <AS8PR04MB86767916B0539B339120C2218C872@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZtMTybL79ui5ocPM@dragon>
In-Reply-To: <ZtMTybL79ui5ocPM@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|VI0PR04MB10297:EE_
x-ms-office365-filtering-correlation-id: 6fb9817f-c0be-45d2-27aa-08dccaf41564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?YkJ4VmRKS04yeFFySWU4TCs0cHJvdnloamJZNkhPWS9FeDBhVURKcEMzOUxk?=
 =?gb2312?B?aDRIanpzN3puOHNpVTdwM0d5TjZYVmRDTmE5V2JIa09MbzlST3BweVJqck16?=
 =?gb2312?B?MEc3MnZqeHhyM2xrL3F6ZXcxbDV5TWdkSFM3b0hrYWN6eWRyd3NLc0czNVBM?=
 =?gb2312?B?ZTZrc1pNNjUrN2RTNEpUMzdURFZlMmRvM0ZraFJDSGpSTHVnZzNUTDdpaGlQ?=
 =?gb2312?B?Z2xEMDhQRThDdVlIa0NuNENCaFVMZTVudVFtRGk3amVaMVlRN1BxNEY5Z0xF?=
 =?gb2312?B?WXJVc0N1MGJTQUxXSEo5L1kzbVN1Mml1VS8vajdlMlpCRjhJUUdHTHQxaTh6?=
 =?gb2312?B?bUQ2RGNId29hK000NVBDNElJOHM4QkZjSUFRdDF4ZlgwQTg4dEFVRUJPdDY1?=
 =?gb2312?B?N2d4YUxuRmpjT1JvbkR0ZmE4bks1R0RyOFN0bFZpUlBqYTM2ZjFNb1lRTXBu?=
 =?gb2312?B?ZE1ZMWkxcFFROTAwbUE0Y1BJNFNtR3VxTHd2UEtzOWl1ODZYZEc5cU1lT0Zu?=
 =?gb2312?B?b002NmlUWjVJaXFXVVhIQXFPUnM0QXA2bi9zU05PS3FiL2l0QW1relpDY0N5?=
 =?gb2312?B?QU05dytRTXdkZ0RXU0JxMTF0VWF6ckxVV2lFY2Z3UDZLaUlQUkt2YnIxb2R3?=
 =?gb2312?B?QW01TXJxbld5NzRsaGFBQUN0azczN0Mrc1V4Y3F1WmFSQVlQeVFNKzRYNXVN?=
 =?gb2312?B?Tk9tb3VDeERBSlZVNFJFS3RRNTdNY1FUamlUblY5eldmalh5NUkyc3lnbXhX?=
 =?gb2312?B?R1lpWWt0eEw5RTBwVlRQZEhMV2EzeXRWazZIV2REdTBCQ01Va05HeDhhR1dw?=
 =?gb2312?B?ZWhCYUgvL2dRRERad1FJejZCSkRRdHpIVk9LY0lZY1NBZ1RlN3lkS3h6MjBp?=
 =?gb2312?B?ZVBHb3hYUkpkL09pby9HUTRPWjRDSkU2N0RFY0Z4UUZCK2J1Y2o5aDYzeG9m?=
 =?gb2312?B?VVpibFFpUGdxenZpbE9GTzVGUTFPeXEzZjNmR2prMjEvMmovUHpSNzNGL3NR?=
 =?gb2312?B?bUNCZ1RnU05vK0dmMzRVTm4yS1BlVzd5RUZQK0JnSms5RjJmNUZxbnlNVnpk?=
 =?gb2312?B?a1l0WktYSkRQMStCdDFlNU1qb09IUElha01rNnhRQ0tWK2Q4emd4cjB2VmE2?=
 =?gb2312?B?TkcwL0YxMkFNUWhzQWRKeFFpbC9oY3ZpZ3hYcndVZWJ3MlkwbEZZRXZZVUt2?=
 =?gb2312?B?SzlveXdtVVpadzZjcU5lRUtCQlA1eFdJNEdrcGxsdmlSWmoxSm5pSTRxOHFO?=
 =?gb2312?B?cDJXTmR3KzJ5cWd0VXptbCs2bHhmUUl1SWY0eFNhRzdac2RFbEx5c0tLbkVv?=
 =?gb2312?B?bFZvZElFUEo3dDFTdVBhdFR4RVVPYy9XMGtGNzJQTEFvVkg0US9neWdaRWt2?=
 =?gb2312?B?T0oyR3VvVFJDaWo4ZnRydHpPOWJnN1d6VjNSTWNybWxnclBSU3QwNFlKcFNr?=
 =?gb2312?B?bFBJdUZUWmdRbW5ZMlNlUFd5a0NzcTVKVkIxREhMWkVwcHI3TE9XK2dVTEI2?=
 =?gb2312?B?S0ZHRWpuenNYOGR3dlpCa3RibEhaMmI5MlNRNjh0dnNvV3lyYjZVWFNSZU5C?=
 =?gb2312?B?dUllM0lnZW5RaU1hNUFjRFhaenJsYjBPZGxPQUxXWjZJeEFpOEY3US9GNkc0?=
 =?gb2312?B?bFR0K1BlOVpKbjlqVEFFZW5qcWJtTkhXRTVYZVJxcFlad2tTMlN1Qkozam5Y?=
 =?gb2312?B?cHliRnQreElpY1pkUkNmMmV5cTlYc0M0Q3BUT0NHL1owdDJ2NW9qS2tFQVM4?=
 =?gb2312?B?V3JsMzZpeWk1a2ErdG0yQVhtWjdwblFCU1EwdWJKYmJOMGhUZS9oOHdtdkhO?=
 =?gb2312?B?SUJ3VjFpcWNYZmVOS2oyQ0RISVY1RXpVbFVJQk05bUo3VFpUWmh1RVhHWTJQ?=
 =?gb2312?B?OFJRQWxWNGVJaG81Q1k1RkIyaW16d3BvZ21ZdXQ3TklKeEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eVJMMTRiK1RlZWhKbjFpZEhyY0pROXQ1WjkrSTZIVjdUMGVVdG80eVhlS0sx?=
 =?gb2312?B?Ty9Icld2ZjdMUGJBNEo3NnpqbjV3SWxrNE9lV00rN29RbVlNd0IyL2NFcUVo?=
 =?gb2312?B?RE9ob1F6Q25UZllMV1M3RE50VDVuQkJBZDh0WXJKRExsWkk2WnIzR2lyMnY0?=
 =?gb2312?B?T2tJcDhTN0tzQnZ4TzN1MGFLZmZEUHRmTnlNWCtxWW8vUmdMVmt5anZGSlJU?=
 =?gb2312?B?KzRnNjVwZXFGdmRKRHF0UXkrdHpwWXZFN3JvMEkzQ090ZW02L2xmb2FIMldp?=
 =?gb2312?B?bGU1QVovYllxMW5zazA1dXUwTjdQR3ZMV3NqQVdOM2kvZ29KTWthWDNGUjlm?=
 =?gb2312?B?VWdtZ1Z5dUJla2E4MU5lSFBQeUN6ZXMwQ1JIc1VEeHVhcWxIZkQzTGxYM2Nu?=
 =?gb2312?B?RkYzbm5IOGZsdEJZaGlEMXoyUlBvU3c3ZERYUDdyb2dSNitxMlJ0T2pWMHB1?=
 =?gb2312?B?WjVYblhhdzJtS2sxdldwMlZFTkQrSVM2WjdhbFFRWjU0OUxiRHNaVXJZamJ3?=
 =?gb2312?B?TUQybVpWdHRjMitwUmxkMlZHdUo5cmduaDJtZlR6VjBkODlqa2F0c21Pb1J5?=
 =?gb2312?B?U1RZM0M5TWhSVWhzUHBLRWpMdzcvOVRkQkcwSktUSFZXK2FxaUxsN0w4VnNM?=
 =?gb2312?B?dDAyMXFwd3B5c3lEcGgweTlXaGZTd3Jhazk2Ykx4QmJIOXhKL2d3YXpFRjht?=
 =?gb2312?B?UW8rb3AzUThJOE0veEFIdXA2MzRkeGFvMDI2MTFqZzh3M29NU21YdUJTakp2?=
 =?gb2312?B?WFlkTEN6L0thdno4OXQvMmpxNnNZcHZ1bFhDclIzdUcwU3RXU3ZoZ3BVWVVJ?=
 =?gb2312?B?dDkwM1Y5UE9SaWpqVWpYcXMrYTBwa0pGL0NnMEpMdFJlVlhzNzY4TjdYam9K?=
 =?gb2312?B?VjVpL0FISkpiMEJiZjVvZEhQeG1qU1NIZzNIdnZvMHVGdUZ5M3c3clBYUmU1?=
 =?gb2312?B?cTBoWlRaSHBDWVNXQ0YxWHZnR016RTV1SUo3NThpbTF1VWRmRHZ2a2xZeW5q?=
 =?gb2312?B?Sm9ZQ2d2UE1XVXdaMnUzVHpyYmVrU0J0STU0N29oSVFlQ0pWYjZhY0E0WHor?=
 =?gb2312?B?OXl2RXRxcnlqTWRpTmUwNnlETmhjb0lFeGhFVGtSd3pTU0VYMzhLSGF2ZmNX?=
 =?gb2312?B?eUtVaVphc3ZxRnkvNTZvaGxJRjh2SlJnbkVUWWU1Vk9uYllGZDVYS3kxQXV1?=
 =?gb2312?B?eEFJN0ZPNGpZSlBRVVpkS21mS1o1OE5La0VuQ2U2WjlKOTNWNVJvbHA4cjd6?=
 =?gb2312?B?RGM3YU5IU1dzeE5vS29zRWRJbzk0ZC9IUjVlSVdKMS8vcHg0TDBHSHU0azZZ?=
 =?gb2312?B?N3JlQzFLY0NDZnJTcm4rdUpaeTF0clVwVUFmQndpVWI4RDREZXV6RHIrdWJw?=
 =?gb2312?B?WlN4emphNFVxczc3V0h0MitGVldzaGtpdnN0RVNFMUZwMmxUTnY2c0lqc3hq?=
 =?gb2312?B?K3BTdU9EZmk5ZnBoM1p5dlJKck9mWDNMcDdhS0QzV1lEdFFYZlpETWdIc0RF?=
 =?gb2312?B?UXN0N2g2TmJUWDA2NVo1N3RTQ1V5MjY3YXNnSER2UE1lRXZZODQ0YnFGTVZU?=
 =?gb2312?B?N1MzbHF3Y2NQTFN2SmZBVXBkbWhzUlJTb1dQT3FUWW43ZGMwYmx0d2h2V056?=
 =?gb2312?B?N0g4a0paaEUyTXU4ZnBDVi9vMENWMExHYnMrbDI0ZUZ5YW0ydUVrMXYvYmps?=
 =?gb2312?B?THFma2VjOWM2YzN4elhIT0tjcGRyZWVXOVJvdFJWeW9KUlltSkVpRlBWZk16?=
 =?gb2312?B?d1ZzWjRKNmxvT2tBaitvM2dmNmFHcG9jWVpLT3lKdzg2OTNQdUVsUDF3YVN6?=
 =?gb2312?B?SEF5WUVzMTZFS1FwcDl6QkVvQnNFZXJvUGJxVEJJZnJvR2Y3SjBOenJENGo4?=
 =?gb2312?B?dThIbmFpc3VZZVZFa3pkK25UaU1OSzVRSXZFdStRSkdXeGUvOEhwZ0ZMeU5Z?=
 =?gb2312?B?ZEFFR3FNd3BJQ05JSlNkTk1yRWk1NTZDeWVvVTBrYXVuaHR6T29sMWJoVG82?=
 =?gb2312?B?SDVOS3paZWZkSG92LzFzMDRvTXBZK1J4dTJneXErZW9nMk96U0ZnaVFOalox?=
 =?gb2312?B?dUhRNlFxbXFpQ01DT0hVbjJpYjNUWDVSQ0I0ZjZSazdYdUl4YU9acXJQNlR4?=
 =?gb2312?Q?MaAGIK8VF8Ul/5WS9Z7hsbY+q?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb9817f-c0be-45d2-27aa-08dccaf41564
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 02:08:05.9060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGPsVJ9uWAEgMr639BeMNNgzM2beEWpEwjB48gXiEeOBGOqCbVENa5LjVvey0rcL2ECWzTn8kP2uP/uNP2rogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10297

SGkgU2hhd246DQpUaGFua3MgZm9yIHlvdXIgaGVscC4NCg0KSGkgS3J6eXN6dG9mOg0KQ2FuIHlv
dSBoZWxwIHRvIHBpY2sgdXAgdGhlICMxIHBhdGNoPw0KVGhhbmtzIGluIGFkdmFuY2VkLg0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogU2hhd24gR3VvIDxzaGF3bmd1bzJAeWVhaC5uZXQ+DQo+IFNlbnQ6IDIwMjTE6jjU
wjMxyNUgMjE6MDANCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBrZXJuZWwub3JnPjsgc2hhd25ndW9Aa2VybmVs
Lm9yZzsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgY29ub3IrZHRA
a2VybmVsLm9yZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
OyBrcnprK2R0QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzRdIGR0LWJp
bmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgcmVnLW5hbWUgImRiaTIiIGFuZA0KPiAiYXR1IiBmb3Ig
aS5NWDhNIFBDSWUgRW5kcG9pbnQNCj4gDQo+IE9uIFdlZCwgQXVnIDE0LCAyMDI0IGF0IDAxOjQ5
OjMwQU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+IFBsZWFzZSBhZGQgQWNrZWQt
YnkvUmV2aWV3ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3IHZlcnNpb25zLg0KPiA+ID4gSG93
ZXZlciwgdGhlcmUncyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhl
IHRhZ3MuDQo+ID4gPiBUaGUgdXBzdHJlYW0gbWFpbnRhaW5lciB3aWxsIGRvIHRoYXQgZm9yIGFj
a3MgcmVjZWl2ZWQgb24gdGhlIHZlcnNpb24gdGhleQ0KPiBhcHBseS4NCj4gPiA+DQo+ID4gPiBJ
ZiBhIHRhZyB3YXMgbm90IGFkZGVkIG9uIHB1cnBvc2UsIHBsZWFzZSBzdGF0ZSB3aHkgYW5kIHdo
YXQgY2hhbmdlZC4NCj4gPiA+DQo+ID4gPiBNaXNzaW5nIHRhZ3M6DQo+ID4gPg0KPiA+ID4gUmV2
aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIChBcm0pIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gSGkgUm9i
Og0KPiA+IE9vcHMsIEknbSByZWFsbHkgc29ycnkgYWJvdXQgdGhhdCBJIG1pc3NpbmcgdGhpcyBy
ZXZpZXdlZC1ieSB0YWcgaW4gdjUNCj4gPiBieSAgbXkgbWlzdGFrZS4NCj4gPiBUaGFuayB5b3Ug
dmVyeSBtdWNoIGZvciB5b3VyIG5vdGljZSBhbmQga2luZGx5IGhlbHAuDQo+ID4NCj4gPiBIaSBT
aGF3bjoNCj4gPiBDYW4geW91IGhlbHAgdG8gcGljay11cCBSb2IncyByZXZpZXdlZC1ieSB0YWc/
DQo+ID4gVGhhbmtzIGluIGFkdmFuY2VkLg0KPiANCj4gSG1tLCB0aGlzIG9uZSBzaG91bGQgZ28g
dmlhIFBDSSB0cmVlLg0KPiANCj4gU2hhd24NCg0K

