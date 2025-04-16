Return-Path: <linux-pci+bounces-25969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF95A8ADD9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 04:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D203B46F7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 02:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667F35958;
	Wed, 16 Apr 2025 02:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1E77BUk"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972822839A;
	Wed, 16 Apr 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769348; cv=fail; b=ItpjANF1cIaakdS5bYMlvmG+6IsGqqMs6Xg+F1COhE+5mLDirJGUm6iyRrvf05VQXlFgfBTu3hnczQtlG0XR/amc96pqkTxBh65MMxdZkmZf+MVpY6KlY0VXaKbtWxL05nUnyr94ErFdZ99ZcSnsV/4RD1AXUn6MFjqgQS1mFHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769348; c=relaxed/simple;
	bh=UgWrJddwH2RrmjtW1mKsNq/fjT4IyDk25xS5DYUk7lI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Io32P3JLp4wuki9JmaxU/ziShjul4KCSciPVitMOF2dJfUT4DpWNJ5kfsLd+H9pdGX56bt/h29KWSVIYjx/dAwGvxOEi0aWhWE4JEfg5I88SF1BpT/RC3gus0gmfYPzM36+XgTPBnMW8VsCvxH6uSTRMnQTPuklEh4BFKzlKZNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1E77BUk; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHbkufDiW/rSeQ6Rbx7kWujL2nHJ9AjyqVI/SlWtXnQ36gdk/hETNDP/8H8ge+FkZmi4D8gKvyNvcQ8x7Cul3Sg8XSmcTldiy3bhTuDSRD2esLyCfruX/emJzZGshrrAGg5lOtnJrha/OdrIXuiVh3sXXKerBu5QLGFaji05+ayutcIXYkBw6z7APDJFu+6ymrH551Nq21/rLPAPpuGrAcDwcnaV452pdrC5gwzyy7vurc1CbK1gkTR0mSDtDnFwJSiDg1F+rTlF9n8EOdfrpgeJwRMe1T+ZbCi6gZAD8zsXEja1e479h9FRqyEKMAyieqAWGCfAJPTEZetXEkY2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgWrJddwH2RrmjtW1mKsNq/fjT4IyDk25xS5DYUk7lI=;
 b=AzUN+PMMeVCmd72E+GfMlTdStJGsnGpfYXe8M27/hhDohtRBFiuWAtLEgriwArXo7iWe7iMjvtkEMObOZzgHuQnfPkQVjxbcPIXIWDhtC7jfpyUt093gZnOhiFlgS9tmYSNwIw2f9piLx2ZeE7l9+KhW2TpXSRMnjumNTWAQexUG9w2RIBQWGkl0vMxn5Grxq+8CF1Bo1OO6n0afrZX87BDlegbuWWFgMeJCu+LeuwR/0LnTYJ7FzI2Q5VhU9gMyI/hMSMdBkSbTRAamZ6ou/qEAH/iPQFsS/pF+9rAenLLeTTRHRYf2GdsmwIy7UCvhmRIUiXrP2akwWFml3zkKCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgWrJddwH2RrmjtW1mKsNq/fjT4IyDk25xS5DYUk7lI=;
 b=A1E77BUkDA4mONm7ROXKEaN96CEYiUMRs9tQfiAbD2O6mQSToiA222DbDZ5pZK9ioQWrVYJ/PwYVQagkNZxp0449KMKejPGn9HO7B7oybfRgdFZYkvRrFC2rYsEt8CyBumGPCqSHH3j3XgX3/6dTBZjWFo2TXk81NFIi/rdur+eTd9DxFOJKs61IUSwcWKbD4IBQU/q++2+Qt5ZDJNlOyTW+6FhU6+/NhZ8rxeLnQrMyDiH9OmtUveQtK5gdxrcB8Q9iftZC2u28MOshDS/562yFWFB4TCEdf1g8XUQyiNXMMgouhOkgF7pkDEJIo9AimW1+Aumvm9t0vkt/gzwUsQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI2PR04MB10594.eurprd04.prod.outlook.com (2603:10a6:800:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 02:09:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 02:09:02 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
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
Subject: RE: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Thread-Topic: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Thread-Index: AQHbqDKBL99Pwo1Evk2anRpEtc1bU7OhwmqAgAC+NgCAAdzSgIABNopg
Date: Wed, 16 Apr 2025 02:09:02 +0000
Message-ID:
 <AS8PR04MB8676A6D869CAB2FC88FA01968CBD2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-7-hongxing.zhu@nxp.com>
 <uqrhqkmtp4yudmt4ys635vg3gh5sibhevu7gjtbbbizuheuk45@lhxywqhtbpak>
 <AS8PR04MB867619A464E923655EDEF4878CB32@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <3wmkjmutepc2s2ookc3ces4eyxe6morhhwxzlpup4mkkoy5ocx@py6h36upgl75>
In-Reply-To: <3wmkjmutepc2s2ookc3ces4eyxe6morhhwxzlpup4mkkoy5ocx@py6h36upgl75>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI2PR04MB10594:EE_
x-ms-office365-filtering-correlation-id: 2f6301ca-9926-4c18-3d2e-08dd7c8ba862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NWZwT2NCR2RPc2R5c2lsR3RLUTV4cWtIcHc0amxmaEZiZFRQeXZwa2kvMGNI?=
 =?utf-8?B?ODdvNHBqeHFUYngySkVxZUhNSFIwOStlSzBDd0lhU3FkTXhNZTlZT3oxbDBy?=
 =?utf-8?B?WGZkMGhSZW1jYU9GeFQ5TjFVbzZ1d1VpQXlTT0VsV1NkenFpNnBmZXBwYjZ4?=
 =?utf-8?B?TkgrZDg5WHhhOEdScHdXTXJUNVhEYzE5cXd6d0p6YVpQbzRQYlVZZkJvOVNq?=
 =?utf-8?B?U0hwbFgzSGtZRkFxeFdzbmYwZDB4eithb1dCdjlRVUZwTUl2VnZUa0VBRWlx?=
 =?utf-8?B?VFdxc0gwakhWTmZTazNKZWRiMG5TMENSTTB1ZkdDdDJDK0dUUG5STFBmTkJ5?=
 =?utf-8?B?Tm0yelBGQ0p2ZzZxaGVZMG1USjBSMkhPQzU0ek40dmJuRjJvSmJIUEVEUzhm?=
 =?utf-8?B?cVVNaUxTS2dnblFGQWpEc3crWnpWQ2N4VlphZFUyZVdrVTlNVm5WU3J6TlZM?=
 =?utf-8?B?UHdXWm1TbjFJdkd6WWQ0cnZwWFkxNFRwbVk4NEhZeEJaRVd4STBKaUdBYlZr?=
 =?utf-8?B?dTlUbjB3UWRUZll6MDVKNU1NYkRSZGZxMDUvQWwxUjY3RXhIRitFQTNDTjIz?=
 =?utf-8?B?REt4ckdieTFrL2dCYlZBbElCN2tyclhaNks2M2hLWVJWaDZvOVRSRjkxeVZN?=
 =?utf-8?B?am1nRWFYbkorWTVCcW9UY0psMlEvWlhOb29PdDI4d1hHaFZnd1Q2WWVadnlj?=
 =?utf-8?B?bGRWTnpDMVRQRDFRVUt1YWw3L3NGRloyaERCZXFDZDRzK1VGMlNvaURESHJv?=
 =?utf-8?B?Nys4UzNBZk40akdxckRERFJJdmFTZHBJWFF5VS9JaXljQ2VaVHFISGFMZ0N5?=
 =?utf-8?B?TW5aLyt4eU5rU2Q0Q2Vmbk1IdDlZTGZOU1V2SXBSWUhpejJmWWl5UGdva0xE?=
 =?utf-8?B?aFZpd1NrK0FCNWt5ZndhYUwxZ2RmQy9NVjJkbVZJMkYxOUVHMUJGTE9DcDVY?=
 =?utf-8?B?cFlsMUZsdFVYOVFhWVdadFd6OERTcEtJdTdQZkJnb2FJZVhncCtFRXcvdXVI?=
 =?utf-8?B?UlN3Qml5WWgzTGhDUGE4UWtLY1k4Z0wxbHR5cm5DdUgyRmhCQVJYaUFxT2tC?=
 =?utf-8?B?N1VIWUtQYW1kbi83N0d5My9VdVhNMkVYazVIcEkvcDd0Q0ZqYU1vd2JFblBM?=
 =?utf-8?B?bFZzYjBET0lnZVA3d0w3Zy9FUjJhRzNORlhIZEIvd2ZOMkU3ZllaQXV6VzVj?=
 =?utf-8?B?NHRIQkJZaVkxczE0SzJoaFc0em1xWTJCeVZzQ1NhNjRaUmFtdS83ZHVHQzlM?=
 =?utf-8?B?VW1INi85ckloUFlSOW1MdlM1Y3VKWXZsSWxQQWtoTUYxOUJTclNWdmFlWkZr?=
 =?utf-8?B?VHVjWk52cmpqYnVQR0JDYTRMZDUvNkFJSXM2MHFjdkVPamlland2REZqcDJH?=
 =?utf-8?B?Sy9KUmVCeXc4dU9EMkVMbjJLaTY5Z0tRdWlOUkFvdkhtZjlkSlhpdzUrUjJR?=
 =?utf-8?B?ZllseURLN0EvV2UyMGYrTGNCV0o3VzhvRHhLdXFTQ3VTS3Z6bW0zT0dNV21P?=
 =?utf-8?B?WS9FK0FDcEgrS3JhSm03QllsVEIzTVhrT2l2a3A1UWlVR1M5SkRJUWU4bVB0?=
 =?utf-8?B?YXY5T3h2MEJBK29pTWN1VHhFLzdSNU85amE0T1RtZEkvd29YYmoreG1uMS9Q?=
 =?utf-8?B?dXE1R2w5bmFaUDMwMk54OUs5RXFGN082MXFna0hZWm9oekNrcGY3SUE1c0kw?=
 =?utf-8?B?QW1PYkU3a1hjRTEydmZFYjhhdWJUUzJwQlJiZkNaZnZrUCtDWDhXV1NPWEdz?=
 =?utf-8?B?UCswVUIyV1UxaFUrOTVERjYvb2QyUXowaS9BQnVDQ0JERWVvdzRoMktyV3Vh?=
 =?utf-8?B?SDB4QnFlQzdqODVBdng2TlBxZ3BncWI5dFJvUjZ4WVJHMHZnRlJ6Wk9TeFBr?=
 =?utf-8?B?YXZmZHRXWWM5OURrUzRlT1d0QUlVT0s1ZXorRkpIaTJkZ2NJSFBHT1RQTlgv?=
 =?utf-8?B?OFVWTDd0ZFlhK2VFYlFFaXV6c09NekY5bWErRUhKSFY2eGljL2ZXYXRLVFlZ?=
 =?utf-8?B?S05LZEt6eTJBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NFBpN0VYeXdKY0lxbE8wM2oxTHJwbjh3S3didHFZVVIxek9DRkc5TjRZVHAw?=
 =?utf-8?B?bHFWaXlIMjkwd3JFQVRVY0RCSTlUT2UrcTZyb1I1TW93emJpbE9OTFVLZEhN?=
 =?utf-8?B?NE1odUNlaHNXaHNZdlNCYi9qUWd6WTRFbG9Ga0E2WWozQ0JwRldqczlrb2w2?=
 =?utf-8?B?a0pqN0xBY0lhYU9tS0RHV0JpWENYeXV2QXZNS0RBb1Rnak1uOFM0Q2RZVEJh?=
 =?utf-8?B?b0ZUc0lMMjY0bEpPNFBHMTNXQzhBRWZ5aGR1OW9pTjhtVHdsS21vTjNobms5?=
 =?utf-8?B?SzRQK2lVU29KV1FSSTVLNTNubkhsdUNaNHNuTEt3bU5LWXVQZDAvRmttR3pk?=
 =?utf-8?B?OWUrTWxMajRxN0pmMmhSUitUWEFtcWF0ZGNCcFMzb0kwa1QzUUU4aE4zbUtR?=
 =?utf-8?B?SGdDMEgrSW9xaXdxMW9YZSswcUkydWppemNORWdvbkFTa092Z24raHcxaGxM?=
 =?utf-8?B?ekNvRERqSEVFSXJoZVllTWR5VnNla3RDNGtHY3piTE5yQkFpek81UFB1aG5r?=
 =?utf-8?B?NFdhY0V6cEhINFd0ZmY4Z2xYSVVDYXFYMXRCSU41THVYaitUZUl3OGF6T2Ev?=
 =?utf-8?B?SUlJS09oU0hQakt6dHRsTjJzUFV5RDkxcHNtNE5oOEZVVlZwanIya2t6NjdX?=
 =?utf-8?B?ajd1NXN3RVU5dWIyMlR4ZjJJRUhlU3gyM0QxNjlNblRxUkRTMTdYb1l0MEJ2?=
 =?utf-8?B?WXlPT3Zsd0xkWVdYbWdxUE1XMmQxNXZhKzVTN1ZtWHlGczNrMGp3eCtpL2pI?=
 =?utf-8?B?SnBGeVZvaDVKMXRiMWFuVU5LelFDdWVGa2xodVRvaGhQSUJxdVVFQVdDM2pn?=
 =?utf-8?B?MisrQTJ2RkRqUVhYalZuWUt1ZUFZWTB2VWo1dUIwbjNpNkV3dDV4RzRVa0Zv?=
 =?utf-8?B?ODVRYm41WFFEMnBsdVpCSWtxbURhbGg1VkZKOE1PTDkrQzUwektZdXdrVHZK?=
 =?utf-8?B?eTBqMExBQVQvQ3U0RFlKRkEyZ1l0OUt4Qkh6SVRRQUNTOWl3NFUyUU5yYW5y?=
 =?utf-8?B?TGdPUXoxa1dDeUUxSTN2U3RnN0hMZGxQSVRBczkrTXgyOHBGZGlkdWFLR0ow?=
 =?utf-8?B?bzBOQ0xxUzlXdFJPWnRBUXR1eWpKVXpvazh6Sjl0SjRWUjdKSXppbHV0ZStS?=
 =?utf-8?B?VUFSOVRXcnlDV0Q0WVN6Wkd3UmNWTGQ4RW4xdmZFd3hvMWFCZnRDREEvWXN1?=
 =?utf-8?B?ajUvZ1FzVzBZU0pGR1ZvejcvdDNCT3phSXUvYlIva3BLbjh4ZnVKWkYzTXpw?=
 =?utf-8?B?Z3V5dVpodVBhcHozdHlXd0xRM0UxekgreGFiQlRaV0hCTk1EbzdUN2xQUjdr?=
 =?utf-8?B?MzFnTXhNR01tSHNac29PekVEK3hkSE5qRk84Z1czM201MTR0eTdTMmJYVnNY?=
 =?utf-8?B?dFdnUDhQVHJVdHVyd3pYZ0FheUZUbWhJd2M2QlBPKzJSbFl6VjBHOW5LcXdL?=
 =?utf-8?B?R0hqT1FQWEwwY0wzRE1VbXdObVpMZEczWEpuY2tvSHpIQkQxWWhUVmI0K1hX?=
 =?utf-8?B?MjhjSHcrUEgrK1g4TGplK0xUTGJKVVJIYmQ0NUlnRWlDeG9YOFVsTU8rQ3lC?=
 =?utf-8?B?Y25BeDZpdDlUNGxwRzhmQVZEL1N0WXgwazlPa1FnNXZ0aDR2c29pSVhRc2l4?=
 =?utf-8?B?bWZPTHlEckcvTXQ2TWJzbE4xWDZ3RnZsSEJFdFdwK1cvRWtDZ05DUVp5cDdI?=
 =?utf-8?B?WEhOOTAwRDBESUdRZU9pUXBVMnJtWnROYUhBUjljMjdENytBNjFoMWFsdUFS?=
 =?utf-8?B?Z3FiQWx2U3loZ1V1S1BCbUNkOFhqOFZualVRNUhMYm9zQ2VRNElEQUQyYWZY?=
 =?utf-8?B?TUxlUUxncUFVM1lrckd2M2pQY240MUpycmxWN0dVMGNhTzZqZWtaV0labm14?=
 =?utf-8?B?dks0VWRTMHVRRE5aL0YyMWp4T0wxL1B2L1ZQZkpzSjFxb3VjcGhQeDZXWGFE?=
 =?utf-8?B?ZjNYeXczdEQ0eURqSWlQZG5oa3pGVUVLQzdzVUVxVjBsUERDUFJON3pidUsy?=
 =?utf-8?B?NWd6eUdqRWhWb091ZVhUUW4yT0FJYWp4cEJWaUpGZXQ0VVgyUTA2cXVUYWJQ?=
 =?utf-8?B?Vy84amQvcXdQV25DYThQbWJnQXdqdU9sZnVzN25BaGRTdU12ZlBoaHVZWXdH?=
 =?utf-8?Q?q/q1whrFJECc7KTi4t2Z0ErXl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6301ca-9926-4c18-3d2e-08dd7c8ba862
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 02:09:02.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szMMyBclHP5aY2eDMs5XU8p+EJN6F1ajZqU3UIElEInW4EmU0Ne0aT0v88QSeOFOFk6FJ6bGGXjiDV6wKnVt2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10594

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjXlubQ0
5pyIMTXml6UgMTU6MjENCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+
DQo+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5v
cmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwu
Y29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA2LzddIFBDSTogaW14NjogQWRk
IFBMTCBjbG9jayBsb2NrIGNoZWNrIGZvciBpLk1YOTUgUENJZQ0KPiANCj4gT24gTW9uLCBBcHIg
MTQsIDIwMjUgYXQgMDM6MTY6NDZBTSArMDAwMCwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE1hbml2YW5uYW4gU2FkaGFz
aXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiAyMDI1
5bm0NOaciDEz5pelIDIzOjMzDQo+ID4gPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiA+IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNv
bTsgcm9iaEBrZXJuZWwub3JnOw0KPiA+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gaW14QGxp
c3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NSA2LzddIFBDSTogaW14NjogQWRkIFBMTCBjbG9jayBsb2NrIGNoZWNr
IGZvcg0KPiA+ID4gaS5NWDk1IFBDSWUNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIEFwciAwOCwgMjAy
NSBhdCAxMDo1OToyOUFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+ID4gQWRkIFBM
TCBjbG9jayBsb2NrIGNoZWNrIGZvciBpLk1YOTUgUENJZS4NCj4gPiA+ID4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gPiBS
ZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDI4DQo+ID4gPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDI2
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiBpbmRleCA3ZGNjOWQ4
ODc0MGQuLmMxZDEyOGVjMjU1ZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IEBAIC00NSw2ICs0NSw5IEBADQo+ID4gPiA+ICAj
ZGVmaW5lIElNWDk1X1BDSUVfUEhZX0dFTl9DVFJMCQkJMHgwDQo+ID4gPiA+ICAjZGVmaW5lIElN
WDk1X1BDSUVfUkVGX1VTRV9QQUQJCQlCSVQoMTcpDQo+ID4gPiA+DQo+ID4gPiA+ICsjZGVmaW5l
IElNWDk1X1BDSUVfUEhZX01QTExBX0NUUkwJCTB4MTANCj4gPiA+ID4gKyNkZWZpbmUgSU1YOTVf
UENJRV9QSFlfTVBMTF9TVEFURQkJQklUKDMwKQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAjZGVmaW5l
IElNWDk1X1BDSUVfU1NfUldfUkVHXzAJCQkweGYwDQo+ID4gPiA+ICAjZGVmaW5lIElNWDk1X1BD
SUVfUkVGX0NMS0VOCQkJQklUKDIzKQ0KPiA+ID4gPiAgI2RlZmluZSBJTVg5NV9QQ0lFX1BIWV9D
Ul9QQVJBX1NFTAkJQklUKDkpDQo+ID4gPiA+IEBAIC00NzksNiArNDgyLDIzIEBAIHN0YXRpYyB2
b2lkDQo+ID4gPiBpbXg3ZF9wY2llX3dhaXRfZm9yX3BoeV9wbGxfbG9jayhzdHJ1Y3QgaW14X3Bj
aWUgKmlteF9wY2llKQ0KPiA+ID4gPiAgCQlkZXZfZXJyKGRldiwgIlBDSWUgUExMIGxvY2sgdGlt
ZW91dFxuIik7ICB9DQo+ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgaW50IGlteDk1X3BjaWVfd2Fp
dF9mb3JfcGh5X3BsbF9sb2NrKHN0cnVjdCBpbXhfcGNpZQ0KPiA+ID4gPiArKmlteF9wY2llKSB7
DQo+ID4gPiA+ICsJdTMyIHZhbDsNCj4gPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBpbXhf
cGNpZS0+cGNpLT5kZXY7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAocmVnbWFwX3JlYWRfcG9s
bF90aW1lb3V0KGlteF9wY2llLT5pb211eGNfZ3ByLA0KPiA+ID4gPiArCQkJCSAgICAgSU1YOTVf
UENJRV9QSFlfTVBMTEFfQ1RSTCwgdmFsLA0KPiA+ID4gPiArCQkJCSAgICAgdmFsICYgSU1YOTVf
UENJRV9QSFlfTVBMTF9TVEFURSwNCj4gPiA+ID4gKwkJCQkgICAgIFBIWV9QTExfTE9DS19XQUlU
X1VTTEVFUF9NQVgsDQo+ID4gPiA+ICsJCQkJICAgICBQSFlfUExMX0xPQ0tfV0FJVF9USU1FT1VU
KSkgew0KPiA+ID4gPiArCQlkZXZfZXJyKGRldiwgIlBDSWUgUExMIGxvY2sgdGltZW91dFxuIik7
DQo+ID4gPiA+ICsJCXJldHVybiAtRVRJTUVET1VUOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0K
PiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdGF0
aWMgaW50IGlteF9zZXR1cF9waHlfbXBsbChzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llKSAgew0K
PiA+ID4gPiAgCXVuc2lnbmVkIGxvbmcgcGh5X3JhdGUgPSAwOw0KPiA+ID4gPiBAQCAtODI0LDYg
Kzg0NCw4IEBAIHN0YXRpYyBpbnQgaW14OTVfcGNpZV9jb3JlX3Jlc2V0KHN0cnVjdA0KPiA+ID4g
PiBpbXhfcGNpZQ0KPiA+ID4gKmlteF9wY2llLCBib29sIGFzc2VydCkNCj4gPiA+ID4gIAkJcmVn
bWFwX3JlYWRfYnlwYXNzZWQoaW14X3BjaWUtPmlvbXV4Y19ncHIsDQo+ID4gPiBJTVg5NV9QQ0lF
X1JTVF9DVFJMLA0KPiA+ID4gPiAgCQkJCSAgICAgJnZhbCk7DQo+ID4gPiA+ICAJCXVkZWxheSgx
MCk7DQo+ID4gPiA+ICsJfSBlbHNlIHsNCj4gPiA+ID4gKwkJcmV0dXJuIGlteDk1X3BjaWVfd2Fp
dF9mb3JfcGh5X3BsbF9sb2NrKGlteF9wY2llKTsNCj4gPiA+DQo+ID4gPiBJcyB0aGlzIFBMTCBs
b2NrIHJlbGF0ZWQgdG8gQ09MRF9SRVNFVD8gSXQgZG9lc24ndCBsb29rIGxpa2UgaXQuIElmDQo+
ID4gPiB1bnJlbGF0ZWQsIGl0IHNob3VsZCBiZSBjYWxsZWQgd2hlcmV2ZXIgcmVxdWlyZWQuDQo+
ID4gPiBpbXg5NV9wY2llX2NvcmVfcmVzZXQoKSBpcyBzdXBwb3NlZCB0byBvbmx5IGFzc2VydC9k
ZWFzc2VydCB0aGUNCj4gQ09MRF9SRVNFVC4NCj4gPiA+DQo+ID4gPiBJZiByZWxhdGVkLCBwbGVh
c2UgZXhwbGFpbiBob3cuDQo+ID4gVGhhbmtzIGZvciB5b3VyIGtpbmRseSByZXZpZXcuDQo+ID4g
VG8gbWFrZSBzdXJlIHRoZSBIVyBzdGF0ZSBpcyBjb3JyZWN0IHRvIGNvbnRpbnVlIHRoZSBzZXF1
ZW50aWFsIGluaXRpYWxpemF0aW9ucy4NCj4gPiBUaGUgUExMIGxvY2sgb3Igbm90IGNoZWNrIHdv
dWxkIGJlIGtpY2tlZCBvZmYgYWZ0ZXIgdGhlIENPTERfUkVTRVQgaXMNCj4gPiBkZS1hc3NlcnRl
ZCBmb3IgaS5NWDk1IFBDSWUuDQo+ID4gU28sIHRoZSBQTEwgbG9jayBjaGVjayBpcyBhZGRlZCBh
dCB0aGUgZW5kIG9mIGRlLWFzc2VydGlvbiBpbg0KPiA+ICBpbXg5NV9wY2llX2NvcmVfcmVzZXQo
KSBmdW5jdGlvbi4NCj4gPg0KPiANCj4gQnV0IGlteDk1X3BjaWVfY29yZV9yZXNldCgpIGlzIG5v
dCBkb2luZyBhbnl0aGluZyBmb3IgZGVhc3NlcnQgb3RoZXIgdGhhbg0KPiB3YWl0aW5nIGZvciBQ
TEwgbG9jay4gSGVuY2UgbXkgcXVlc3Rpb24uDQpPa2F5LCBJIHNlZS4NCkhvdyBhYm91dCBhZGQg
b25lIG1vcmUgY2FsbGJhY2sgKGUueCB3YWl0X3BsbF9sb2NrKSBhbmQgZG8gdGhlIHBsbCBsb2Nr
DQogY2hlY2sgYWZ0ZXIgaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpPw0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiAtIE1hbmkNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+Cu
teCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

