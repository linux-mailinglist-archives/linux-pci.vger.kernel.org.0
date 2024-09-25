Return-Path: <linux-pci+bounces-13467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C89850F8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 04:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4739A28485B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 02:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D80148301;
	Wed, 25 Sep 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AA9c325y"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0D136664;
	Wed, 25 Sep 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727231511; cv=fail; b=qXnsjaC2GbYEMZO4tDNQFGePFoDrtSdnzWHNfitsq2DSU5i4adCFVS2gHmy36MwvTG41BFnhkNSgSyDVw7dMkGP9zO86nKRSH767c9NPMx54D62AqPQ4numvuHgVXbdnnh1E3TktPe5IEIeZPq/wm82GESk0FZ3hru1+TzcwDMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727231511; c=relaxed/simple;
	bh=jxF+Gqz3szXRvfwO50JR/UAOuH4DdyTZILnXraR+mLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p90STfjXAb2YB00PUCb4HkLyyizqDB1cTPBDEyLv8/tNJQ+Hw61OTbmBEnSjUgq6cvC4RTbG5faZb3uWqapyHF3XV5FJ9sSHNcjRIAh0OSxIdZNapXzZ0xrjqIUQu8dfGuvXaYop0c8Vzda2oQdQLFDJ2c9ldRQepodp3TDBJ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AA9c325y; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RO7YugNBQVwNM83pvsOD6ynt/6pQ6mzJoMg8lTm8OHJ00P0tfaAKTyPF13jNDZMj5fMyOzBoZraL6NssuuqBSqcfUrIjtnZ/6IQsJxblbWwE5wi9GrJChO5LmsonuZ30Uxg7lQfCCyPWwMfOusxfgL63BeEgNlN99dcWLhmEeRSulCRAsLtDhtuiuPaYvqbRJR9hAsZrhrUyNX6SXhO7NNLSTyUA8vBbK6SKoZdhBVlo4C2fWVqNmZtKkeJ109/QgyXEVyk2MyBgGcoSZufBMFFd/j4rFuRdarPOen+Jr7ZY7deON5V9i6byeiv02FfTxWeZPrmPQ4c/0e67/aMVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxF+Gqz3szXRvfwO50JR/UAOuH4DdyTZILnXraR+mLY=;
 b=o4K2jjysji834amptLqMCHwrv2OZeLRD3GHgv46SzRLT4Hq9TPZYyplRx+ME3Vmpt+MQkgPljXb0pulz7v05hTbVf+Jb6FV3JYdcxHHtTedCPBVWI+isjl7YwEZLKKYiZPXwUrDRjTQjR9Unz/ybLQQJCgUSmnNg5Q1LE3f9tuBsaUWJ1UH078v1QGro6j7Q89MMiqlUidNXB/iGj2Y950vv6syvd7k92SzDjtJJFjEh0FTnTZHb/JXuzh217sqCWrb5w632QimrpfnGyIkWjOpn2Nje06DOmJ7sKoAzbuvRY31NQCMG8ycpB+BKRPn2C/YvYehLqHzbdxw/bBqn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxF+Gqz3szXRvfwO50JR/UAOuH4DdyTZILnXraR+mLY=;
 b=AA9c325yHh+EffwTS3C9KAvQgFSKmslgkrxA5lj/PKG0Fb/mRSIthc0scqxoc4wJkxQIkDOhUq9dz44C9RIhsBIIThVonmh1i6rAEMNhec0Ywq9iZbcrUXc7F2HG6A9+DI4l2ChMm1X9GoNnLBRw0XWbPD6ZO46+9mPtrkvATP3MEtQ4dXUR9XfuaV0VIZ9OyHvbbv6ZnhMfkRhGlrSiJA3BO81Nx/2GG38+lcAD17rEtfChIOdLCnPeP56KzlzlrzE5RbSvHW0Mmaoa6GElKJjdJMtNgGfG+2Wi4wIzKHTDnj48SWzdHPNEIddNrcN7UCAswF+K3A9VJhUcYsiemA==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DB9PR04MB8137.eurprd04.prod.outlook.com (2603:10a6:10:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 02:31:42 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 02:31:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
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
Subject: RE: [PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Thread-Topic: [PATCH v1 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe
Thread-Index: AQHbDjTjeKGi9dgwR0+Ck4WHAuh9dbJmtvMAgABX8gCAAAuDAIAArv+Q
Date: Wed, 25 Sep 2024 02:31:41 +0000
Message-ID:
 <DU2PR04MB8677A659D73AB056EFE0B4158C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1727148464-14341-1-git-send-email-hongxing.zhu@nxp.com>
 <1727148464-14341-2-git-send-email-hongxing.zhu@nxp.com>
 <20240924-ended-unlaced-cc7ddf87af90@spud>
 <ZvLZWqRFnAtgFo3B@lizhi-Precision-Tower-5810>
 <20240924-spoilage-fanfare-357c65b8418e@spud>
In-Reply-To: <20240924-spoilage-fanfare-357c65b8418e@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|DB9PR04MB8137:EE_
x-ms-office365-filtering-correlation-id: ba023665-a500-4b3b-a411-08dcdd0a30e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZmdaMFF6d2JQRXhrZ2FUaVVuMTFsOVc5RUNOekY3MmR1VURQWml6UDc2aHB0?=
 =?gb2312?B?Y0tJMFQyYldsSFkwRytyVGE2WnNWMW9nb3lXdVpUN2xPeEVlNUUyRHY3eFJ2?=
 =?gb2312?B?eU5QenNERjBuWEh0clZPNk91YmxLbGxrVTZiRHBFQTJlUUJoT0orTDEvakpr?=
 =?gb2312?B?RlNhQmJJRjhscWhCRFFBb2VhcjJoVDVvY1VmaGxyaVFFOTdqb0ExTXpId05w?=
 =?gb2312?B?NmdIMmxpb2dOSUxDeldCMFZaMnBVOW9nYW0yRHE2dWxzbGVEOVhSNFVwR01w?=
 =?gb2312?B?MjIwdzUvd29MUWxaek5KNjY2ZFNYVHVTcnM0M3kvZkxJa1dCc0hhZjluTVJ5?=
 =?gb2312?B?RGo3RytVZkY4d2VPRUN2SjBsaFEvRzVickFoTkpOMU1ybndoT2JyK3FuV1pl?=
 =?gb2312?B?SDVha3JtbEoyY2ZYWEtUbFp4anQ5YlU4WHZJcHVoTkZqbHhFRnBnN21Ua3ds?=
 =?gb2312?B?WDNsSGRVbzBmK1oxNzBGMldaTThuN3MrRGsyNTNXT0ZSb2RDcjk5WmRrZUFU?=
 =?gb2312?B?RVRHVThzb0t4RGsxN2NFVmlTcm0xYVdVdU1wS3NpbXFwU1drQUVQUTc2TzlV?=
 =?gb2312?B?cmUzaWhwT2oxc212alp2bXZoVHhwRkdWSWN0N3JxZnJZUDV3UTFVMm1vMDcy?=
 =?gb2312?B?V2ZGdEF3NFVDNUpOcGV0a2xRcHdENEMyS3ZmcGdjUUtXVUtiU2VvT0xVM29L?=
 =?gb2312?B?dkJyRHhCOGFKaUVYQ29LcXFXME1NVjFrUzd5dktaYlVVY3dIUHhKdzRYa2lr?=
 =?gb2312?B?R095dGd6aFZkQ29oN3pKYTFKejdzS3pQRDVGbDFzcDE2allpRktKc0IyR1Ns?=
 =?gb2312?B?RkN1cTJvdmVwTUNuTEoxZklTQkgxV3c2azdtamRYL3hsd21uV0hLL1Fqd2U1?=
 =?gb2312?B?Z3I5WHM5Y0RlWHFVM0tRamo0Qzk5OE9Pa3BxZ05scFdwaWU1MFFZQ0gzTWY5?=
 =?gb2312?B?dGliZ0xrci9zVWVubmlyeVVYbUF0V0FUV2N1NkpkUTlLaGg3OHhmMGgyV3hC?=
 =?gb2312?B?MlJ0OW0xeXo4U3lNL1R0cmV4MmVsMS9PWUlPa1N3ZmkwUXJkLzJCcTFJbXVa?=
 =?gb2312?B?bFBmbGZadTZFcUtrQXBaRWQrT3BXc2JZN3ZLcXhMV2ZlQzNzRFY2NkdWcDBi?=
 =?gb2312?B?dHd3em5tN1puYTV1Slp3UGRhazhMam5GMGxRc2hnTzZYZVRBTDNxRjlRYkFZ?=
 =?gb2312?B?RytyaElDQmFkV081YzJpSE1oOGJuMStlajRpTnc4Sk5OTmx0WEtoMWpOdnZl?=
 =?gb2312?B?QlBvRUQ2cUJYN2VPS1dmcFEyaDdRVXBUdmpiOVZtTnZaVlIwOHVIWU1kMHdp?=
 =?gb2312?B?SmtlMUFwUDFjWC9MZmZlWmxrRmJzUHZjb2U4ZHNTb0FlQTB3TVBEWmhHSnRM?=
 =?gb2312?B?TDRGb2g3Zm1nUTBmdGxQUFhJc0xIdlhIendoR05xSFZpTlN4VUJkK1NUVWtm?=
 =?gb2312?B?WVJjd3oxTVE0UUlhMzYvVW4rZUkzb2xQUFc4YlhIY3hrdnVNZUMvYW8wNFlm?=
 =?gb2312?B?dzVJK3FLNkdZOTdNZ0J4aWZEQ0hsMFMwM2R1U09jandRY1VDK2xlYlQ2QmlR?=
 =?gb2312?B?NmlHTUpqdHV6TmtHL0pnSzhSak1UY29YaS9Zc1Rub2FwOWJuS3pqVWJQSjFD?=
 =?gb2312?B?OERvSGlya1Q3K2JxN0JKdWVUTVVoK0o2U1F1TVFPU3Q0V0d1Q09IMkV1OURm?=
 =?gb2312?B?ZEV3RlJ3WE5zNDkwb09DZlpjbjRYbkFTNndEWkNBSDMxaXR4SXNneEJ2V0lK?=
 =?gb2312?B?ajBkQVZHQzBoUFU3UnlzekhDRXhzWjRNMkhPRE5MUVZWa3loTm5rMXE5MzI5?=
 =?gb2312?B?aG5QT2p2eFNiOTh6K2hjQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MVVKcmhiZHhyMUppTTNOenZMMjdSbVpxQ3k4d2dZdDJUd05BUi9RVzY4b3FG?=
 =?gb2312?B?Y1UwZjVOMTg4UkNHSmUydGZlNUVQOFplV091Y1NVR1NrZ0tQdElWajRTcnZy?=
 =?gb2312?B?RExxeE1oSStYb2ZYUytNc3daL0kydHk2SGMxaGZSUlRicHo2NVdTdmh1WlVG?=
 =?gb2312?B?TjYyUFk1V0JhZ1FlS3diQmp1MjFZbmkrcVVCTGtyZitSVEhadGVoT2lQMmhR?=
 =?gb2312?B?cXNwbFIvanJKTWVnRHBycEp3bVJ4N2xqZnVNSWpkVnhFeUx5NFFsaHh5dnhv?=
 =?gb2312?B?VndBMTNsMTFVVDN6dVpKMjE4bmUrWm5rVTk4dmc2UVpSWTBOTHVJOGRVTFZz?=
 =?gb2312?B?SUJ2bGNnektlM3FBZGFQWjZmeGY5WXhQTkpZTmdoWG14ODQydEd3ZE80VlZk?=
 =?gb2312?B?SWFlRlhTVlRHQkNobmdDYmJmOW5rRmJocDUzelhJayt2TklBdDgrY2liNXFR?=
 =?gb2312?B?eHNLVlZtSkVjZ3cvTnJ6QTJEdEczZm92VXc5d0s1cmsxNjVBamRtTGNnR3pE?=
 =?gb2312?B?OGJWUWU4bWdyS0pxWElpMzd4dWxzNC84WkZCRHY2TEFEaWtzMloyMGR4WVBW?=
 =?gb2312?B?ME5zQWxDamd2WGtDYTZheGxJZDdrb25wMkk2THJkeElYc0tMSmxLWkxna1dQ?=
 =?gb2312?B?LzV3UFY3czM3VEtRQU9VeTBBYnQyNkNoYnhOTkdxTEs0SWZJSEEvSFNlczJz?=
 =?gb2312?B?cmlJNE5kcStEYzBaWVRoRGIzSkxMc3gya0lyZ295aktrcU0rRUUvS2NFdzRC?=
 =?gb2312?B?RkY3WlF2dTRIcEdoOTZhMlpGWEJWdkl6RmJpWlUwT1BRRCtMd05abzdGSzdj?=
 =?gb2312?B?T2R0ZndKcmJSeEpFZnp6MTZDQTU2eCtIcUJteUV0MWltYko5c2JBbStYQmto?=
 =?gb2312?B?ZUFiWmdBVTU1dlEyNzZkQ1U1RTFuSktSQzBwQTYvTDFvVS9MalBET3hWLzYr?=
 =?gb2312?B?UVpJUG4veEZmbEo3TXVKTzZaUmlvNUtaUDV4UWM4QVZWOGswTW9qL0pTMGF1?=
 =?gb2312?B?ZGpIVVg1dXgyRExDbXFqUDMrQnpKT1hyTW4rMDVYVkxKbVZIVWNZMjZhQUFm?=
 =?gb2312?B?ZXV4Wk0wMDdOWFNraFZkYjh2dkRUcXdNTVNkN2pWaUhIeDZIamV5YXFIZmE3?=
 =?gb2312?B?Y0p2Vk12dUJ0NGwxdDhJSEFxN3RqY2RSMUh0dVNoeHl1V0lOaWxXTDJIdEU5?=
 =?gb2312?B?Z2swQ3hDeEluNzR6a2ZEK0dUd2VaRElqcm9XSzdxbDBFeGRwT3VJVDFsTXJi?=
 =?gb2312?B?TWdwZzg0SnRkSFhFalJQOXc5Q0RoeUtZUnFFbTNqWjhlb0krWEFNd0l3U0Zx?=
 =?gb2312?B?RHRkU3Z5OU9KQlExUGpvcjMwU2hkYlh4WjJtYSs5UW9vbzdjTGhQSDNlaDh2?=
 =?gb2312?B?b2FyeHdLd2V1anVBV3FFR0hOYlRNTUNINU1NMDRxZnl3U3NHbmVta2VrZHNZ?=
 =?gb2312?B?QlhNM0t2SVdaWHZoRUxCNXhiQlV3YjcrSkdpMWRPNSs3ZFBBT0s4VGJFcXZ5?=
 =?gb2312?B?ZC9yMU5ueHRLbnNlaS9iVnZvU0wxU0p6eUdid2JiZmJBTnVINkRycTliN1FD?=
 =?gb2312?B?VDdGcy8zaUo2TTFXK2dwNk9rbGxmRUl1dENFWm1wRUlGUFhKT3A1R2ZtRndI?=
 =?gb2312?B?VXdxMG1kY1VETWIxbGNRaFBJdFRPWkpYV09sZGNwWjdUSHhlMytFQW9KZS8z?=
 =?gb2312?B?SEhWK2UzQWFyRFJac3hzSnF6dWZRdS92YkkveUJ1MTFUNjhyZXB2OFFmVkw3?=
 =?gb2312?B?Yi8vUWtWR0JUdHF1elNLRDBIOENwY0N2OFZtcU5TcVB4Y0tzK29Ga1EvdTZ5?=
 =?gb2312?B?ckVYanhZc29zYXNYQjJrQ1AxaWhhNnZLbHZuUjlEVCs5bHZRSkhCMjR1cXhU?=
 =?gb2312?B?TzZES0ZURDAySU5TdUZSanlocnBndlVJZEFSaW5JRXFlUjRBdGd6b2ZmeXEy?=
 =?gb2312?B?c1huRGV1QzZ6Y0F1VjIvR3lzSU5EUFVaekxxRVY1S2dXd1hjamVZUTBDb2Jv?=
 =?gb2312?B?WVB6SGQ1WkxVSDl0TUdnYy9NbUk2WDR6a1hVUm9QS2V3alk3Y0dVSjlqUWJF?=
 =?gb2312?B?SXNTMmpRQ2E1WWVWUSt2dFMzeDRuY1JISDVPUHpuS1pBYkpaM2djOEx0WFEx?=
 =?gb2312?Q?+YtJHYb11eI7iJDooU4OgPD5A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba023665-a500-4b3b-a411-08dcdd0a30e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 02:31:41.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKsC0yfbvgihKiTng3e6xmnNf4GKSDqAGzHlpoC0/z/4tmJ+YaJQj9JR5AVsp0Ivzjsir/aDRepRcD6ZF0RdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8137

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jnUwjI1yNUgMDowNA0KPiBUbzogRnJhbmsgTGkg
PGZyYW5rLmxpQG54cC5jb20+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAu
Y29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4ga3dpbGN6eW5za2lAa2VybmVsLm9yZzsg
YmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtl
cm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IGty
enlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBz
LmhhdWVyQHBlbmd1dHJvbml4LmRlOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXgu
ZGU7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzldIGR0
LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgcmVmIGNsb2NrIGZvciBpLk1YOTUNCj4gUENJZQ0K
PiANCj4gT24gVHVlLCBTZXAgMjQsIDIwMjQgYXQgMTE6MjM6MDZBTSAtMDQwMCwgRnJhbmsgTGkg
d3JvdGU6DQo+ID4gT24gVHVlLCBTZXAgMjQsIDIwMjQgYXQgMTE6MDg6MjBBTSArMDEwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBTZXAgMjQsIDIwMjQgYXQgMTE6Mjc6MzZB
TSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+IEFkZCBvbmUgcmVmIGNsb2NrIGZv
ciBpLk1YOTUgUENJZS4gSW5jcmVhc2UgY2xvY2tzJyBtYXhJdGVtcyB0byA1DQo+ID4gPiA+IGFu
ZCBrZWVwIHRoZSBzYW1lIHJlc3RyaWN0aW9uIHdpdGggb3RoZXIgY29tcGF0aWJsZSBzdHJpbmcu
DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBJdCdkIGJlIHJlYWxseSBnb29kIHRvIG1lbnRpb24g
d2h5IHRoaXMgY2xvY2sgaXMgYXBwZWFyaW5nIG5vdywgd2hlbg0KPiA+ID4gaXQgZGlkIG5vdCBi
ZWZvcmUuIFlvdSdyZSBqdXN0IGV4cGxhaW5pbmcgd2hhdCB5b3UndmUgZG9uZSwgd2hpY2gNCj4g
PiA+IGNhbiBiZSBzZWVuIGluIHRoZSBkaWZmLCBidXQgbm90IHdoeSB5b3UgZGlkIGl0Lg0KPiA+
DQo+ID4gUHJldmlvdXMgcmVmZXJlbmNlIGNsb2NrIG9mIGkuTVg5NSBpcyBvbiB3aGVuIHN5c3Rl
bSBib290IHRvIGtlcm5lbC4NCj4gPiBCdXQgYm9vdCBmaXJtd2FyZSBjaGFuZ2UgdGhlIGJlaGF2
b3IsIHNvIGl0IGlzIG9mZiB3aGVuIGJvb3QuIFNvIGl0DQo+ID4gbmVlZCBiZSB0dXJuIG9uIHdo
ZW4gaXQgdXNlLiBBbHNvIGl0IG5lZWQgYmUgdHVybiBvZmYvb24gd2hlbiBzdXNwZW5kIGFuZA0K
PiByZXN1bWUuDQo+ID4gUHJldmlvdXMgbWlzcyB0aGlzIGZlYXR1cmUuDQo+IA0KPiBQbGVhc2Ug
cHV0IHRoaXMgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIFJpY2hhcmQuDQpIaSBDb25vcjoNClRoYW5r
cyBmb3IgeW91ciBjb21tZW50cy4NCldvdWxkIGFkZCB0aGVzZSBpbmZvcm1hdGlvbiBpbiB0aGUg
Y29tbWl0IG1lc3NhZ2UgbGF0ZXIuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+
IFRoYW5rcywNCj4gQ29ub3IuDQo=

