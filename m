Return-Path: <linux-pci+bounces-35490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47901B44B4B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E864EA0848C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BDA1DFD9A;
	Fri,  5 Sep 2025 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L9DP/vMa"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80C145329;
	Fri,  5 Sep 2025 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757036431; cv=fail; b=DhYYdKjzfyTqsqMMNciLUKoLqsqX54ofJOFmSpLtZ0NdBHxbFD8Or0a3WVCqjQobk7ZW/MzfbLXOz8pg0kAzsdmS5H2hNmYdb8z8gMygetxTALUfHdLtnJu1990YSPA7CKnf1Z7f+nETXDLNbzjDkJ4qMJCZI2+PhIPvsD/7aAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757036431; c=relaxed/simple;
	bh=sGxPxjpT+1wWMnAw7waioRw89EbZ4k6gvnOlMKUCWwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7CO58s2sDqzXYopns9LOv6cwdLgZmA2Zx1H3BAtdY41SHg2WBnYAOEm9Ik7DwjblBFaP7baMt6QyDxAeaRc+HdvLJ3bc2Mvrzj8eLnEOUkkdgPg8JKDYMfS365ieelK/rw0oNnJdBZgdPl25W7WQsKj7VI3BShCdqDdfQY2rSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L9DP/vMa; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9VprjlDU3ShTD15p4dtYI2tQcyAFyrw0cMpngABxMG0Zft+SCT1JNax0uf+NQ6iHi8pljCrLzuxJIXSCb9sGRnts1tv+5R7Tabdw1wN8BascRDPEbo5dLxv3fbef9qP3rsRWR88/GjACgbrZCqZkWNZo4djVmBa4qc60ziEnkcqQYVeHsEHLrch9Ta12Arc55gMNS6RgiAtUZ9XE8q+/DNv1GekYZzCWz7tLhh1f5ZFlW7H5fYNELZkqes4qYYh0HDtQqDFWJBVGPgTSvfEHAtc+J9cyjS9mC93oZQVfw7//uce1tIaqAW911LoviEsruqs5TqO1flgBJgX94rLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGxPxjpT+1wWMnAw7waioRw89EbZ4k6gvnOlMKUCWwk=;
 b=XFFBwMUtBn0DLktNRz103KRhP7oQJBPxfPpX64/U9LFarr2Uyvvpkgr1ONFIJk8UyZO3REPR9RKko43SUEf6GfGLRcEkYe9VLoiZtNjrM7hisZs4MvlYhzvVlRyzzq0Dl3VfZ03Wy03HG4lwkSQ91amoNPqh2+GJz+JpZ/VjJse0Y0AVND9+e9eNKvFYtmzSFbgAJU9yXlExUu3NbgQYq4OJGnqNgDVNisUx8gMaRqIHDo9s7TSYEfVMMX1WZ8ej4rMDyDMSOje2OnTEICqkAIjV1qb6aVD+zYgf0q0Ql5rwJqjyK9483iMducTN5Cx3Y8SFa34SD9kx4lVU3oo6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGxPxjpT+1wWMnAw7waioRw89EbZ4k6gvnOlMKUCWwk=;
 b=L9DP/vMaHM69h+YON7imY6tEdQpiVPqHURGG2IX9CGlvPbaILiqNou0F+4MwTFOPZStzQNP6RltXjmjLl7nCESQjiK8lrESWk338M+UYxK6WAlGmDuZ8DcmptIVQp+yIdoXT0KZEOLz5NJueR3XeDX31xw1pZKgt/YYxMibcJ0Hhf0mgbzqACLffXgv2rOJTph7YQn8+zA9tUVEbdbll7rw348r9eEMu+o6T0x9UdbkHF1esKGdnttpjH9Bxn7PPC0nmy8Gr9KCOUyXXaNWNoB51z540hcAZMCNq3asxzQBHxp7jsS4q9Szml9IyzghM1MoPheBECjR2J8GxkGWjEg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AS8PR04MB7815.eurprd04.prod.outlook.com (2603:10a6:20b:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 01:40:22 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 01:40:22 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] PCI: imx6: Enable the vpcie3v3aux regulator when fetch
 it
Thread-Topic: [PATCH v5] PCI: imx6: Enable the vpcie3v3aux regulator when
 fetch it
Thread-Index: AQHcEXl4j9h/La95tEeoE0oh9kOYLLSDWmwAgACLEBA=
Date: Fri, 5 Sep 2025 01:40:22 +0000
Message-ID:
 <AS8PR04MB8833550F479E80555481BDA58C03A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250820022328.2143374-1-hongxing.zhu@nxp.com>
 <piirka3qlna6k33r2eutg26s2iepnvubzbdps6rh5b2tzhxxmg@c7nv3jgkwxpw>
In-Reply-To: <piirka3qlna6k33r2eutg26s2iepnvubzbdps6rh5b2tzhxxmg@c7nv3jgkwxpw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|AS8PR04MB7815:EE_
x-ms-office365-filtering-correlation-id: e29c00cb-4944-47c4-de1d-08ddec1d2dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1VSS1lhc1hrZy9YRGlEWTUwSzR1cU5QQS9od2lBVGFMUVdXVW5wQ0VmQ1pk?=
 =?utf-8?B?d2krQVIzSlhHK0xXOUZtVWFoWEY4WktDOHViSU1EWlp6SXc5R2JZaFM3ZDF4?=
 =?utf-8?B?QXZxZW9OcDJXQTdSN3NXMzZKWEFWVUM2Z3RIU2ZUWFlqVll0d0V4bmtuUmRO?=
 =?utf-8?B?blRaYWNwek9tRWE0TVJqTnI3SVhPV0Npa2c3L1VwdlM5dVBSa3NlN0JqVDY1?=
 =?utf-8?B?cG5tN3liTElEQ1RDYmhtd2lKTmxpOHVqSUY3bmVrbjYxcEFDTHBib2txbFhH?=
 =?utf-8?B?MEQ2Y2FHMDJ3V0NRNlNlbHl2ZjRWc2Jhbk9jZnNkMnljUksvZHlxbEhGeWpq?=
 =?utf-8?B?UlhwRFFOaTNmeDZWaGYrUzd4VWYzalhqdHJXMEVxeTFJYXp1cUxVellGRDZQ?=
 =?utf-8?B?UERpenNBc0RKdnhlOTBzdk5mMEhzU2FySnNQdWpOVFIyL3BmVTd6eW8wL1M3?=
 =?utf-8?B?L0d1Q2FJMXV2NFVtbnMrVlZKQUVLR3RLc2dzT2VYbHVud1F1RnMrUUZOWkcx?=
 =?utf-8?B?c0Z1b2M2cFB4a29oWjI2VmNCNUR5QzFwK0JmOGMzSnN3VjBtbjBpdFZHcmQ1?=
 =?utf-8?B?Rk1udHNwb0k1Q1BkS0oxMjFIMjc1eWJwN0p3UlFHc1BjWEEvVDR3bDg2Y2Y5?=
 =?utf-8?B?SjhXUExhS3E0WWFWWGtleTlLVXM0ckJtODZmUHprL1pXK091TjZqMEFhS1E3?=
 =?utf-8?B?UVhYMytBNURvTjUwNEZLT2xhRHV4QWZVKzR6cEN4b2YrTWRUVFZtWDdRQTJC?=
 =?utf-8?B?L3lBOEptVnZOL3MzNE84cHJtRjdiOXdpSEFBK1pSOEptQWdNWG1Ud1NhRzZH?=
 =?utf-8?B?RlU5djBUSmh3Sk5qd2JIQ21YL3pmRXlRa010cnZsdTlVY2RHSFZXK2QwYkk0?=
 =?utf-8?B?d3VhZnFvTzB2clg5TE5wQTRISkxlQVQ4Mk1MZlB2OVE4akZXZFlBYWZ0cTFT?=
 =?utf-8?B?U3VwZm1XTU9yYmRac2h3Vksxd0tGYW1ML251cS9aK2xhNjk0dzQ0NkdMQ084?=
 =?utf-8?B?VHU5SDZtcHRucUxIcnV5K2FyNFc5QW9mT2Nwby96a01BWHJDVEowRm9LdUcx?=
 =?utf-8?B?bXphcTFkYkx2ckFQWSt6VldHOU9KNmRvcjVJOUhIR1FYNFZMQTNvUzZ5cUpL?=
 =?utf-8?B?YXB1aGlIVmdranVSL3h1WjVuanpZNnRHQzExQ0FuN0ZIRzFlVGFEWGtxb1ZE?=
 =?utf-8?B?SmIzUCs0bUk2by9iUEJZejd0VEJQblFvclFWS2JIbjhSSTBzZmtYY0Zwd0Ra?=
 =?utf-8?B?eGtSZ3JQeEZ0aFlCVW5qVi9KNFpYQzNXTm5QeFlnSHZzazVuNHFrZGVaYVoy?=
 =?utf-8?B?Y2pvVlVER3F4SDBnYWdmWTV0QmNEbW5OSDFDeTUvQkxQRldGa3dCeEd3VGZ1?=
 =?utf-8?B?cmM0UnRVNFJ5ODhETG1lZ2ZCWkdHVlJkQlh5RTBwb2kvYnpBTWdwalI0K0ox?=
 =?utf-8?B?bTl4T1NTeXAyYXVkUmlTZVh2OVVDV2R5RlBYUHo2dUlyZURpa0tNRUVybS9J?=
 =?utf-8?B?bmE0MVNoaDFXWVF2S3NXejJYaEMvemt3cTE5Z1RKZkg1a0FDZGdVL1BjNlp4?=
 =?utf-8?B?bUxWOFRWQjQ2NlprVjhLSGYraVpXMzNFc0ZDZGFVb1hZMUZSSkJwS21WK3BX?=
 =?utf-8?B?NTY0V3RTYTRYMGs0NHVmM0RvWnVPb0ZQeW44Y09PaDFjVnphQmwzOStVeFBT?=
 =?utf-8?B?bGtsZmhkMkxKWWNodmE2LzhSbnRUYzRrL1JlbUpOd050RDFrdU1wMUFoTXdt?=
 =?utf-8?B?VTh6MllLRDR0NkVyUksvb29xZHNWSFlMQ3NpQTRlTVQyNjhHRUNObXZYQktr?=
 =?utf-8?B?UmR0Z0NRWkVSZFY1cm95clVURFFOc2xnY1EyVGpJNm1zR0lJQmdqVWhzNE54?=
 =?utf-8?B?dDR0MzFBb2UwSFNxNTVnbjF3UFY0MTVBbUJ3aWoydWxKZSt5cS8xMEEvVERr?=
 =?utf-8?B?UUp5aWxlUTlvdi9SaG5hNkZWdTNRZ3VURWZGK2tnemJwYi9sZlZUUFgvUmQx?=
 =?utf-8?B?Z1RTZHNDWEdBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QWQwbSt6OHdrQkF2Uy8zM0FZRjBVUHByUnZGSnk1RzFkRTFyMzNRQ3dPblZS?=
 =?utf-8?B?dVU5YlhoeVhRVHROMVhCL1R1cVpTTWRadkx0cE9xclNrVThOeFZ6a0V1MWhz?=
 =?utf-8?B?bEZhWmZLdVRuRGo0STZQTXdjM3RuQnhUS3kzM1c4cHh6OTk2YnY1VDkrNXdD?=
 =?utf-8?B?YmFjTFJUNUFQRDdWMEp1RzZvNzRSanAzNDVPVjVXMUNIZWtseUlBM1cySlRM?=
 =?utf-8?B?cTRKcWtPeU5GdGVsREtJdURvVVRZK2h5dm0rQkhVMVJKdDM5SDJtMnpmODlQ?=
 =?utf-8?B?Mms2M1AwM1U1aEI0czdHYmZjYS80bGowMkpJZUIvamdZSVh0elhOenEvUUZp?=
 =?utf-8?B?WXVONloyc1pneHFEdlZEZytJU05mbHJtWWFWZzFtTWtiVzVQUGY4VS96dlUx?=
 =?utf-8?B?ZTliSGdaRkFPeHVwL0lySHBDYWozZnRyckJQWENTb25ZN0QvUlNNTDZmQ1g5?=
 =?utf-8?B?NGZxUU5qM1RnQVJoT0x1SC9UUDVHZWV5SE8wQWljdWkvbk5TOE5FVGxCZER0?=
 =?utf-8?B?VnR2Uk5hbmN1OVZWcmZPYVhaM0d6NW04N1ZlUmJsczRvcmNCSnhOdllwMm5x?=
 =?utf-8?B?SHJpQVdXZ2J2aWtwMFozbkVuNGZCNVhHZDVxZDdwTkVod2FvWWlPN0ljelRZ?=
 =?utf-8?B?MUNDSitJN0JEczkra2FqU2oxR0ljaVExOXRuMEU5dUhlT3E5L3p6T1R0OVNy?=
 =?utf-8?B?eXZ0QkU3MjI5L213bVc3RzN6OVdHYVA2dzRDQ3JIRkJ1eGVBVndGa3pZWUpC?=
 =?utf-8?B?eHVZeVg3OFNTSUl0NGpSVXpGS2NUVDdzYmhHQzhmem5HZVhJZ2lsSUVSNlVF?=
 =?utf-8?B?Mm1LdTA5U25sTjZCcmE3NndFSEN6Q0lrc0grR2RHNk9xT1FQYjU3M3h4YnMw?=
 =?utf-8?B?K0FVcmNIRUhqeStkV3BBWnVvMzRFRVp3cCsrYisrSzJZUWk3UGsvRktNaTdR?=
 =?utf-8?B?eEJIdCtEK05Qd1JjNkdlSUdxdksvMXZUZ2pOc0Nta2IwZHE5UWt2SHZ3VDgv?=
 =?utf-8?B?Wk1lamZEQWlZSGtlQk4xNzJkWGVYOE9pdUc5VEdqcE9zWTlnbndoV2tsOUpL?=
 =?utf-8?B?LytlY2pOSFhFZ0MrcWtmeGxoMzV1d2NPZFNsaG5oL3pCdVNqQURNelArSnV4?=
 =?utf-8?B?RTRaSGxwUzc5ajV6Tm1rTmdPd1liV3BuSW41bkcrWmFYZnpXZGpYYlpVVFgz?=
 =?utf-8?B?dDZLcEVDOENqS0ZUb01kVm12bEpWcDM5NXpncm9Rcm83c2tXWGdiakVzWG1F?=
 =?utf-8?B?eHpGc3laM09YRUhYN2ZaYTlFSE5EamtvdDIrU2Z5TjQzeXhBVXhhc3B6Tnly?=
 =?utf-8?B?bHcxNk1VMDV0T0xtZ0MvUWd6Nzl4emxJaGt6V09jdEp0QjlYTnFEMnNwS1JN?=
 =?utf-8?B?SkVHV0pFL0tpMTlaS1lRZ0NNZlZ3aEFWejYrdkpOa1lVSURvQlFFTUNyRk8x?=
 =?utf-8?B?aWdQME5LUUFlWUFiRENQSE1hOFZZeXRTS2ViWmxTM09SNHMyRkdidzFIN3VB?=
 =?utf-8?B?dndWUXViMXVqa2VEQzZqeFdPNDlZSUN0SnhzK1NQSXhkemVXbFhLdG5jYnJT?=
 =?utf-8?B?d1FMbEYramo1VXcveHdhYkFPS2FOdlVGUXhXK3IxTFM1dCtZSG1ISTRuczcx?=
 =?utf-8?B?L0F1TGQ5MlNIeXV1Z1VaZkZ6K1FEYXIreGxad3Q5Q3NkeDJseDEzUlc3MDFZ?=
 =?utf-8?B?WHNlbUNOamtLLzRJTmdpQzRlREdwVEFvMDRPajZCY09CQitjeTl5TVIzMmI4?=
 =?utf-8?B?TXc1cVE4cit2TkZ0MVl2aVdtSkZMS01qT0JXSXUrbUZqeXVscjZadS9ad3ph?=
 =?utf-8?B?R2Z5SUVyNlJmdG5SYkxnK3ZtdVppNEU2TnBmN3RBRkRFek5tS3N4VDFaY0cv?=
 =?utf-8?B?U21QZXY4dE9BMFhYdmtSbWtvSDltRUdYM2NZN3VudlVwRFdJVzJWMVpqQlFJ?=
 =?utf-8?B?Z2ZKclh6WnMwRkUrZEgwTytUYkQ3ZXJUZ3c2eCt6WEovRDJUY0xWM0ZmYVNt?=
 =?utf-8?B?RUxUck1IV0xHWlNSQW9sNlFrdkVXc0ZhOXR1ZWg0SEJwTGkyTG1wTzQ4cnhm?=
 =?utf-8?B?Q0prWWwvYUJBWkZ5R2t5NlBzUU9pQUdJdDlYRXNWZ3NxQ3pOcjZOQXBjcE1a?=
 =?utf-8?Q?DLRKCcWr+ynP2/HNyYVZR2WRk?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29c00cb-4944-47c4-de1d-08ddec1d2dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 01:40:22.2097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYXRSY0e0ig//97SbwjjIGyfD2g9KodCbDoe0Yv1+8m2oWO63Lj0DE6MIFuQF6Lw+L16fVHj3/sOsffj7vhsfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7815

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDnmnIg15pelIDE6MTANCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGxwaWVyYWxpc2lAa2Vy
bmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOw0KPiBrcnpr
K2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBw
ZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjVdIFBDSTogaW14NjogRW5h
YmxlIHRoZSB2cGNpZTN2M2F1eCByZWd1bGF0b3Igd2hlbg0KPiBmZXRjaCBpdA0KPiANCj4gT24g
V2VkLCBBdWcgMjAsIDIwMjUgYXQgMTA6MjM6MjhBTSBHTVQsIFJpY2hhcmQgWmh1IHdyb3RlOg0K
PiA+IFJlZmVyIHRvIFBDSWUgQ0VNIHI2LjAsIHNlYyAyLjMgV0FLRSMgU2lnbmFsLCBXQUtFIyBz
aWduYWwgaXMgb25seQ0KPiA+IGFzc2VydGVkIGJ5IHRoZSBBZGQtaW4gQ2FyZCB3aGVuIGFsbCBp
dHMgZnVuY3Rpb25zIGFyZSBpbiBEM0NvbGQgc3RhdGUNCj4gPiBhbmQgYXQgbGVhc3Qgb25lIG9m
IGl0cyBmdW5jdGlvbnMgaXMgZW5hYmxlZCBmb3Igd2FrZXVwIGdlbmVyYXRpb24uDQo+ID4gVGhl
IDMuM1YgYXV4aWxpYXJ5IHBvd2VyICgrMy4zVmF1eCkgbXVzdCBiZSBwcmVzZW50IGFuZCB1c2Vk
IGZvcg0KPiA+IHdha2V1cCBwcm9jZXNzLg0KPiA+DQo+ID4gV2hlbiB0aGUgMy4zViBhdXhpbGlh
cnkgcG93ZXIgaXMgcHJlc2VudCwgZmV0Y2ggdGhpcyBhdXhpbGlhcnkNCj4gPiByZWd1bGF0b3Ig
YXQgcHJvYmUgdGltZSBhbmQga2VlcCBpdCBlbmFibGVkIGZvciB0aGUgZW50aXJlIFBDSWUNCj4g
PiBjb250cm9sbGVyIGxpZmVjeWNsZS4gVGhpcyBlbnN1cmVzIHN1cHBvcnQgZm9yIG91dGJvdW5k
IHdha2UtdXANCj4gPiBtZWNoYW5pc20gc3VjaCBhcyBXQUtFIyBzaWduYWxpbmcuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4g
LS0tDQo+ID4gdjUgY2hhbmdlczoNCj4gPiAtIFVzZSB0aGUgdnBjaWUzdjNhdXggcHJvcGVydHkg
aW5zdGVhZCBvZiBhZGRpbmcgYSBkdXBsaWNhdGVkIG9uZS4NCj4gPiAtIE1vdmUgdGhlIGNvbW1l
bnRzIGZyb20gdGhlIGNvZGUgY2hhbmdlcyBpbnRvIHRoZSBkZXNjcmlwdGlvbiBvZg0KPiA+ICAg
Y29tbWl0Lg0KPiA+DQo+ID4gdjQgY2hhbmdlczoNCj4gPiBNb3ZlIHRoZSBkdC1iaW5kaW5nIHRv
IHNucHMsZHctcGNpZS1jb21tb24ueWFtbC4NCj4gPg0KPiA+IHYzIGNoYW5nZXM6DQo+ID4gQWRk
IGEgbmV3IHZhdXggcG93ZXIgc3VwcGx5IHVzZWQgdG8gc3BlY2lmeSB0aGUgcmVndWxhdG9yIHBv
d2VyZWQgdXANCj4gPiB0aGUgV0FLRSMgY2lyY3VpdCBvbiB0aGUgY29ubmVjdG9yIHdoZW4gV0FL
RSMgaXMgc3VwcG9ydGVkLg0KPiA+DQo+ID4gdjIgY2hhbmdlczoNCj4gPiBVcGRhdGUgdGhlIGNv
bW1pdCBtZXNzYWdlLCBhbmQgYWRkIHJldmlld2VkLWJ5IGZyb20gRnJhbmsuDQo+ID4gaHR0cHM6
Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJG
JTJGcGF0Yw0KPiA+DQo+IGh3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJG
cGF0Y2glMkYyMDI1MDYxOTA3MjQzOC4xMjU5Mg0KPiAxDQo+ID4NCj4gLTEtaG9uZ3hpbmcuemh1
JTQwbnhwLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0Nob25neGluZy56aHUlNDBueHAuY28NCj4gbSU3
QzMNCj4gPg0KPiAxOWE3ZDIwMzgwNTQ2ODU3N2NiMDhkZGViZDVkYWQ1JTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2DQo+IDM1JTdDMA0KPiA+ICU3QzAlN0M2Mzg5MjYwMjU5Mjk3MTUz
MjYlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlDQo+IFUxaGNHa2lPblJ5DQo+ID4N
Cj4gZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJD
SXNJbGRVSWpveWZRJTMNCj4gRCUNCj4gPg0KPiAzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9M0FyeCUy
RiUyRnN2TjA1JTJGb3BCOElMM0M0YiUyRnZMYzFkaW5mMQ0KPiB5bEpRa2pmcw0KPiA+IDY3MCUz
RCZyZXNlcnZlZD0wDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRl
eCA1YTM4Y2ZhZjk4OWIxLi41MDY3ZGExNGJjMDUzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTE3MzksNiArMTczOSwxMCBAQCBzdGF0aWMg
aW50IGlteF9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
IAlwY2ktPm1heF9saW5rX3NwZWVkID0gMTsNCj4gPiAgCW9mX3Byb3BlcnR5X3JlYWRfdTMyKG5v
ZGUsICJmc2wsbWF4LWxpbmstc3BlZWQiLA0KPiA+ICZwY2ktPm1heF9saW5rX3NwZWVkKTsNCj4g
Pg0KPiA+ICsJcmV0ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X2VuYWJsZV9vcHRpb25hbCgmcGRldi0+
ZGV2LCAidnBjaWUzdjNhdXgiKTsNCj4gPiArCWlmIChyZXQgPCAwICYmIHJldCAhPSAtRU5PREVW
KQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiZmFpbGVkIHRvIGVuYWJs
ZSBwY2llM3YzdmF1eCIpOw0KPiA+ICsNCj4gDQo+IFNvIGlmIFZhdXggaXMgYXZhaWxhYmxlLCBk
byB3ZSBzdGlsbCBuZWVkIHRoZSBJTVg5NV9QQ0lFX1NZU19BVVhfUFdSX0RFVA0KPiBzZXR0aW5n
IGluIGlteDk1X3BjaWVfaW5pdF9waHkoKT9bUmljaGFyZCBaaHVdIA0KSGkgTWFuaToNClRoYW5r
cyBmb3IgeW91ciBjb21tZW50cy4NClllcywgaXQncyBzdGlsbCByZXF1aXJlZC4gUmVnYXJkaW5n
IG15IHVuZGVyc3RhbmRzLCB0aGUgVmF1eCBoZXJlIGlzIG9uZSBjaGlwDQppbnNpZGUgcG93ZXIg
cmFpbCwgdXNlZCB0byBwb3dlciB1cCBzb21lIGRlc2lnbiBsb2dpYyBtYW5kYXRvcnkgcmVxdWly
ZWQgaW4NCnRoZSBMMiBtb2RlLiBUaGUgdnBjaWUzdjNhdXggaXMgdGhlIHJlZ3VsYXRvciB1c2Vk
IHRvIHBvd2VyIHVwIHNpZ25hbHMgb24NCiB0aGUgY29ubmVjdG9yLiBUaGV5IGFyZSBkaWZmZXJl
bnQuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0N
Cj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

