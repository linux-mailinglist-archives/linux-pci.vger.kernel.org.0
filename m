Return-Path: <linux-pci+bounces-10820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7A393CC9B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 04:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AF42825B3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 02:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDF31803A;
	Fri, 26 Jul 2024 02:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NQk6YLk2"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012044.outbound.protection.outlook.com [52.101.66.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA9848C;
	Fri, 26 Jul 2024 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721959250; cv=fail; b=dvNzWsc+7hRjufM2W+XrSwgMsSMg8u2XNxT4mwlkYm0TgqPoW338s1hB78XqRu5vVxoKQMfvedtf5n4068wUvSMsV5jmT4EI/E0IR79Nq5U68A65cbxWqofkVldu26R9v9rVx5Zur+nkr0n5VdGUuTZ3CoJZK68K+DqHoMF4eL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721959250; c=relaxed/simple;
	bh=ciKzR0IHV1DJwA7mUekKLX/iXnuEl4q60AQrOVQ3M4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sa2ADSTCD/cVhrkLQ0a9b9IHuOX3La0uQ5xtAQYxrhQi/l30jskfgdiJPxJkFmie4JQhXrB20XW1B36oadXJpG3LTNlmHNoHKIY4MfkP1r8Nu6n/f6R8owHSX26SPgO5TnLoQ19yhxVsY09lRNqjT8Cm8cVVcJicqUvNI3P5/S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NQk6YLk2; arc=fail smtp.client-ip=52.101.66.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsSilVizM5Sfi/eXqP9xnUUaSIS3dXt786/4uxnmT6DdfvM/+VPt/KkHqcNZEsBFKyubHw6vUGdhMA2qWqb9qVvPP52oVsPOmFzfqmnyTjHAn0cw4oUqW2zyX7bw7ZjfwWpKpt6p8KRfCBFxhg94jx9zmvGQpSRq2aeKBIrrhYPG04Flc89QDt24ER+PxA9GKAILHNcKLdRsMKtCpLPrqEJO+CgOKDVRLyrvqHXPo/5fOCZp6H5MzqLqv76OzdS7/Nwvo1m6gjjKWzH9KXe+HqAX9qQ9vV87HdQd4sXNiwK0SrWHx7NNnsq6aNSG6WJ+AxWYjTqH3LHJT+X64hXj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciKzR0IHV1DJwA7mUekKLX/iXnuEl4q60AQrOVQ3M4s=;
 b=M6XDE3EtnEnvvBj8kAIMjiX3mqIeb9BNFWc1w9cGpu1p+lPZDYtnjs7CqNWD2O16BCU+3fR3otX7NuJeVc27IfZ9pacFf9h09MRGfTMEpcsxZx7UOA0gjfgYZoG0avlbaWVizmapAJQqH0u9VSFaw9ANqS3H/sx5Muk7M7szOKdf0neoo4ZRPRPYBA1IEG+86/aohbl/6fyPc0u/2ygIvhHv6OhqEwp0RX0MlSVliN2sn/mBDIyl0o0HRtzYatDnc97J7SurUgaGbf7Q5nPdq+/BIQk0z88yuEdy7ZL9rTsAqO+akA1Jq1uKpB22YfHH/MWSUh0JC8FZhgHl7AWXNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciKzR0IHV1DJwA7mUekKLX/iXnuEl4q60AQrOVQ3M4s=;
 b=NQk6YLk2KhIQ9QtKF1OWYux6rpdTNoJSLL4lA/tYBVCXVultzVLV7xOUG9v/9pEwb6pY87CMSF9ThAWk5zAInKif4O6lbiuLeZY4IQPxb3cGDhlbsyO7Z0axzqjwcI8V09IGRmoVagvjpFjN+ytCluxvfu6piDrdeT55b9Y5X8ukIk0vpymlth5+LrDy1fzP1P3VtEAVdZ6KJTgaCQ7fvOamq8aul2YOUOiadwuGQ5h4YyS/2d/+PS0nZuUAVliUWY/L6+NvKsBTPEh8P+HwduQjrH8ZRTadqnKBeM3yuR2Gv8+ZNOPXcFP0q8dCePgkurePBB1AVAwJ20OvqcTOpA==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by AM9PR04MB8764.eurprd04.prod.outlook.com (2603:10a6:20b:40b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.27; Fri, 26 Jul
 2024 02:00:44 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7784.017; Fri, 26 Jul 2024
 02:00:44 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Topic: [PATCH v3 0/4] Add dbi2 and atu for i.MX8M PCIe EP
Thread-Index: AQHa3mfZhk0kkn8q9kyUgCwxMMJRXbIH6dqAgABXATA=
Date: Fri, 26 Jul 2024 02:00:44 +0000
Message-ID:
 <DU2PR04MB8677563C58588898A602E5FB8CB42@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1721892916-5782-1-git-send-email-hongxing.zhu@nxp.com>
 <20240725204341.GA858380@bhelgaas>
In-Reply-To: <20240725204341.GA858380@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|AM9PR04MB8764:EE_
x-ms-office365-filtering-correlation-id: 6e69f378-7eaa-499a-5402-08dcad16c29a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TnZxUElyK2g4VHMxR011c3BHeGNTdmJYSk85VVV0SXBRSDZ5MVZqZ25OM1NH?=
 =?gb2312?B?QjZ2OUpMdVp1cWpyd2xTRlBtT0lsbURDWFRwUSsxdU83ZmZCdUpKM2swRFNC?=
 =?gb2312?B?cjJmdHYyY0Vjalo4WnByZE9vdlVoSUdieXFub1lLSDdQeGl5cUVUNE5CaW1o?=
 =?gb2312?B?eWFiTlRSMm1wNzFTV3JmU1oybnlpeUpKeVVwZElndi9PZDdSYThaR0FxSHJ3?=
 =?gb2312?B?eXVraWlXYmNDMUhVeXVFeUxNV1RmVmNLWEt2VVpvYjA0ZWVIdkdmSFNCbnBJ?=
 =?gb2312?B?MUx4dUh1dG9sVDEvekx0MUxpOURDVHVreVVNOStOby93L1FOUXprSXY2QkxS?=
 =?gb2312?B?WjdCMDlvdndnbTZUYkRsRnhSUXNOZnl1UkN1TkY5Mmt6UFRoMXV6ajhpM2NG?=
 =?gb2312?B?aDdRdmFMMHI1QnJMeTMxVTdBREh2TWZTcHhucFUzbkVCWEhSVkVKMVZZYXJm?=
 =?gb2312?B?OUtCeE1odURIVXF6SXordWlnYWlCY09qdzNPTDdEOFlPQ25VdDAzSEJoQ2VK?=
 =?gb2312?B?cmZieGFZbm9ESGhqdWlEUDgrNUhlSWZxU0FTVDlRUnFmUGlyaEwzM0FSTEgw?=
 =?gb2312?B?TkVSdHQ5MlJVRkxjUjl5dWU5TVJzdjNtTjFqdElBV1BKWVpyUHIwVU00QzRE?=
 =?gb2312?B?dkVucXYvTkFNN0pwK3o3dmFLQUhZWlIwSDg0QVR6dkx5cjVieDZobnJoUFl0?=
 =?gb2312?B?RnJrSDh4ZWY0WFAyelRDYTRoYmJFNVhSMmF4S0VXRFVHTnZiQTBQL2Vjb3VX?=
 =?gb2312?B?NFR0dHE1cTVVSGVENHZFaS9HZnlITDNCdHJZa01naHZjMFZHY3ozeGJvZ21h?=
 =?gb2312?B?cWZNRjlpbERrb3JkcHBPcGk0bDQzRDVYcTEwVE1iMk4ybUx5dnVCb3doTVpw?=
 =?gb2312?B?dHo4WFRocHRSU2NTcnRrRFRybkpUbU5WLytpbHF5OHpmRlNMNW5Cdmt6WUVJ?=
 =?gb2312?B?aUZoNFY1VFlLZ1lPdk5Qd3pIUU9GNFlKQXA4VTVjVnA4R0tzYS82NU4rcFFO?=
 =?gb2312?B?a0xtV2FrZCtSVEFEeHNJd1dsVTVraERvTVc2UCt5VTU5MWNpSytWQVRqSm5O?=
 =?gb2312?B?V2JxOXRML2QrT2lZaW8yOW1kN0NXdzIvTllkNFVZTExPLytDRzN4aVZRaG9a?=
 =?gb2312?B?RFZYV2hzaWl3VFIzUWFXL1piZThHWWc5MHBOSWp2ZUZHd2VPREZsVHVjZXBk?=
 =?gb2312?B?YTd0TzZEMU1wSzF4N28wdlp2Y2ZaT2JVcHR3Zm1UTGtaRmxtZ2xYemNHZzRy?=
 =?gb2312?B?anh2REtBOHF5SHBoVGlCSGNxRTlGKzIzVU50Lyt2MFlRVUQxR1U1M1F6Q1h4?=
 =?gb2312?B?VWRuNWJ6amFXdjhGMGRoWjRHUkhGVysxbGdYSVMzZnRZWVhCY01oRWwvbVZj?=
 =?gb2312?B?ckJwejUrN2cwbk5qM2pFVVZ6aDdxWHVEcDdwb0VFSEcxb1ozSnJPVTZESmZS?=
 =?gb2312?B?d1RvbXRBb2JvM0FVdVFmS3hOcmxoMmJrQ1VHWDk5aGhEZXhNQVBybjVyT1Qx?=
 =?gb2312?B?VlZSNXJwdzRibTY4V3NDZU0rQWsxU29UYnJMWlJNVEJOeHduTHFBc1N4YzQx?=
 =?gb2312?B?ZmRTR2JNc2d1V09YMWU3ZEVadmp3SDZWWncvQ3V2TzFDNzUyN25FcEtRMEpG?=
 =?gb2312?B?OFhqUGhlbkFmMzJSaVJVbHdXOE1FcGZMZkYrRkpGdWxlWE9iUG1GSUg2R3lx?=
 =?gb2312?B?WENDbHlNcVBNS0QxTWx1TVZNWElmL2kwMTNFSEZkVUhscWg5RGdvK25XbjhD?=
 =?gb2312?B?NmFYUUduNk9WcUN4TzVwR2lTU0JHU1h6TnJpQVN3Wnd1RiszdlErS1ZGdzFh?=
 =?gb2312?B?WkVUci9IQ2x6MGxOSnZuU0M1bnNaNVY3REMxOTIvdXc0RzlVRkpZSEJzZStu?=
 =?gb2312?B?TCt4bkhjbGVaR2Y2YUxOM3M3M081Yk4vVUxoRTdENTZlbVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?M3dYV25OaUFtQU5wb2UwTDlYTW9tZ3BCUG9JSExIemQrUkFZM3RMYVowSTRx?=
 =?gb2312?B?Q2dsT0xneWtld3F5ZFl0R25OYjh0cmdJZVo5VFZMazZHd0prNVJPQmlEWXRz?=
 =?gb2312?B?aXYrWlU5b1AySFNld2RYRFhJZ1Aveml4d3lYTTVDVjI4N01meHgrKzJFcHR3?=
 =?gb2312?B?V2luWGNGV2QxV2xCSlRVUWFYa3dxb2x6NWhKckJPOUVjcTc3aWhxODRZNHVW?=
 =?gb2312?B?YWt4U3dkV2ZRc2thLzhPcmRFRnhyS2NOc3NoTkFSbEF3b2p0dlZlbWRWM2Zp?=
 =?gb2312?B?MisrblBkbFE0Nm0yWVZ3cEdLalkvcUJuSzAvVWsxSEhLRHNORVlnamtkSXdF?=
 =?gb2312?B?cFFpaTZmT3hVaWRMQ2wxQS84YmdHTS94aU4xQllMR1ZsNkRTdXFsMDJ5Y1Uw?=
 =?gb2312?B?YzlYaUtRQnRtOW5IYTd0MTFkYkdtRDBkMWJaVjlqWHo0d0VJcHd5LzIyZnF5?=
 =?gb2312?B?eFFDc2RJellUNldmKy9LSDVzNXlvY1pUaW13K01Zak1OdFFrRXlhOTgyYkh3?=
 =?gb2312?B?YVVya1kyd3dtamJxeVRZZlFDYTBXdEl0ZGVUUnRqeEZTeVZIS2NUQjVnczlB?=
 =?gb2312?B?M1Yrclp0T1lxbHRjZmxMRmVEUTgrRVRpMUFRS1ozNnIyM2poL0NLV3I3OTAw?=
 =?gb2312?B?QkhFUGF1SkZreWt0TzhYdzhaWmhkK2plRFBpT0tzdS9RTStQbUFnejN4bHdz?=
 =?gb2312?B?QWpFaU5Nc1JmOTM4ZFVLNDU1TEVsa1EyZGRuM2NLc0tHaDVsL2xVZEFmeTFX?=
 =?gb2312?B?QVhpK2N4SDlUODRCR0UxVHlKWVZDbkhwNmpjT2E3c2k3Nmk4azlScnZuTHMx?=
 =?gb2312?B?eTlRc2RVUkFNWnZETmNLd3RxZE1NTGVzK0pWdEpjdU0xL2VhQzZYUWRNbVdm?=
 =?gb2312?B?OFhISE9LNjh6aTg0RUVyRlVhV2pwWUc4QktjbjRNNzlpREs2UHNEVGt5cGJa?=
 =?gb2312?B?VFNmTXdFWW1wS1hjakpuT0ovSFdjTlNzSzhMRytiUHlWZEZIa25KeC9yK0cv?=
 =?gb2312?B?c0JnRlRRMmNGSmhjVUZsRmFlemdpaFllSk9heVRKaWRqMmtGL1h3MHdyREtZ?=
 =?gb2312?B?cnhCNXlNR3Q1TVdoVDNCcmpkL0dnQXRZVUlYZTZTQ2pkb1hyVFJsbGIzaklv?=
 =?gb2312?B?M3NsVDg4MThVQXpJcTJLZEpRWkRjRGsyOU9panowd0VCa3dZVG50V1hqQ3lv?=
 =?gb2312?B?SjZQOGJRKzVocmoyMVVkZi9ibjQ1eUdmeitrOWdZWEU1M0F0eWViK3MvVTVk?=
 =?gb2312?B?QTM1MW5qOWFRMER3VGR0VC9LQzNPYllCaW8yMFd3QjFabWZWUVhqZSszYkFt?=
 =?gb2312?B?Qko3WjYvRjk4cnpXeFhUMit1c25jVjEvQzFKcHJKOHJSMG1ZeUlwTHdvTEFq?=
 =?gb2312?B?bFR0aHRXNkg0UitDVWZYUDdMMWdRUXdZdThxMEJsZlUrY2xkVUg3RjlKODBL?=
 =?gb2312?B?bUtCR0JnK2E2YUxmRGMvWXh5ZTMydmxRcytDNEtva0RqWTByWmd4Q3FvcVJE?=
 =?gb2312?B?VHZPdnZ4SDFNSFdCOVFKTzFMUXBKYThlZjlkbm1xM3JSSGxxV2ljcGtWYnJE?=
 =?gb2312?B?aTRoWm1JWW1Xa2NLcVBKM2crK3ZQQjVGUkRuNHFhemYxOUFKSUZ1MEEvZEZ1?=
 =?gb2312?B?dXZpaUJiQW53NzM3bzB1S29IYXBrYWR2TkRlNHYzeEZlSXk5NVRBRXc1b1J2?=
 =?gb2312?B?QXlVeDhjdWJDU0M0dE5MZDYvRlJIb2RlcVl1cllCZmJ3L1YwcmlOQmZPcTRH?=
 =?gb2312?B?U3BCdW0vbHoxQm1BVnc5Skg4NlRNZ3ArNnloN3Y0V3BObzcrdjBSejl1RHBB?=
 =?gb2312?B?ZkRqVDNNUUtKM2ppNDVIL2RMOGtQOHlTZ2hieUtiN0x4WFJmbTVzNllURjFm?=
 =?gb2312?B?MlZIWXl1YUp4ZWw2QkNGc05GcTZ3MG43MGlkMXAvUUswSCs4NVJlY0VlOUxF?=
 =?gb2312?B?dllObjd1M3FieXJhc0h2Ny9pL25SZnpocVdsbTYrWjlINVh1K2JwKzQ5NjdC?=
 =?gb2312?B?YVB2aU1rb3lVdmkwNXE3eVlLalJSMTVyRFBZUWFTRERlaThHUEhVSkM3c3B2?=
 =?gb2312?B?K2pidnZKR0RGWDVFbFdxN2VyRUdYS1NHM2F5SjJiY0oxdlVpVUNmRk5SRDlO?=
 =?gb2312?Q?EuF7det6BlJ5tLuPjoqwCD3sR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e69f378-7eaa-499a-5402-08dcad16c29a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 02:00:44.5313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VESiuyeTtcUpXXRh8vdMdTOLSvwsxljxShoAdGcULrT5w7yePfA4dTTtX1qMiL9sV+62i7QIeTX5BF7JR7xcFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8764

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTE6jfUwjI2yNUgNDo0NA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHJvYmhAa2VybmVsLm9yZzsga3J6
aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAw
LzRdIEFkZCBkYmkyIGFuZCBhdHUgZm9yIGkuTVg4TSBQQ0llIEVQDQo+IA0KPiBPbiBUaHUsIEp1
bCAyNSwgMjAyNCBhdCAwMzozNToxMlBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiB2
MyBjaGFuZ2VzOg0KPiA+IC0gUmVmaW5lIHRoZSBjb21taXQgZGVzY3JpcHRpb25zLg0KPiA+DQo+
ID4gdjIgY2hhbmdlczoNCj4gPiBUaGFua3MgZm9yIENvbm9yJ3MgY29tbWVudHMuDQo+ID4gLSBQ
bGFjZSB0aGUgbmV3IGFkZGVkIHByb3BlcnRpZXMgYXQgdGhlIGVuZC4NCj4gPg0KPiA+IElkZWFs
bHksIGRiaTIgYW5kIGF0dSBiYXNlIGFkZHJlc3NlcyBzaG91bGQgYmUgZmV0Y2hlZCBmcm9tIERU
Lg0KPiA+IEFkZCBkYmkyIGFuZCBhdHUgYmFzZSBhZGRyZXNzZXMgZm9yIGkuTVg4TSBQQ0llIEVQ
IGhlcmUuDQo+ID4NCj4gPiBbUEFUQ0ggdjMgMS80XSBkdC1iaW5kaW5nczogaW14NnEtcGNpZTog
QWRkIHJlZy1uYW1lICJkYmkyIiBhbmQgImF0dSINCj4gPiBbUEFUQ0ggdjMgMi80XSBkdHM6IGFy
bTY0OiBpbXg4bXE6IEFkZCBkYmkyIGFuZCBhdHUgcmVnIGZvciBpLk1YOE1RDQo+ID4gW1BBVENI
IHYzIDMvNF0gZHRzOiBhcm02NDogaW14OG1wOiBBZGQgZGJpMiBhbmQgYXR1IHJlZyBmb3IgaS5N
WDhNUA0KPiA+IFtQQVRDSCB2MyA0LzRdIGR0czogYXJtNjQ6IGlteDhtbTogQWRkIGRiaTIgYW5k
IGF0dSByZWcgZm9yIGkuTVg4TU0NCj4gPg0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUtZXAueWFtbCB8IDEzDQo+ICsrKysrKysrKy0tLS0N
Cj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaSAgICAgICAgICAg
ICAgICAgICAgfCAgOA0KPiArKysrKy0tLQ0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtcC5kdHNpICAgICAgICAgICAgICAgICAgICB8ICA3DQo+ICsrKysrLS0NCj4gPiBh
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEuZHRzaSAgICAgICAgICAgICAgICAg
ICAgfCAgOA0KPiArKysrKy0tLQ0KPiA+IDQgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBGb3IgYWxsIHRoZSBwYXRjaGVzIGluIHRoaXMgc2Vy
aWVzLCBjYW4geW91IHBsZWFzZToNCj4gDQo+ICAgLSBTZXBhcmF0ZSBwYXJhZ3JhcGhzIHdpdGgg
YmxhbmsgbGluZXMgc28gd2Uga25vdyB3aGVyZSB0aGV5IGVuZC4NCj4gDQo+ICAgLSBXcmFwIGNv
bW1pdCBsb2cgdG8gZmlsbCA3NSBjb2x1bW5zLg0KSGkgQmpvcm46DQpTdXJlLg0KSG93IGFib3V0
IHRvIGNoYW5nZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gdGhlIGZvbGxvd2luZyBmb3JtYXQ/DQoi
DQpBZGQgcmVnLW5hbWU6ICJkYmkyIiwgImF0dSIgZm9yIGkuTVg4TSBQQ0llIEVuZHBvaW50Lg0K
DQpGb3IgaS5NWDhNIFBDSWUgRVAsIHRoZSBkYmkyIGFuZCBhdHUgYWRkcmVzc2VzIGFyZSBwcmUt
ZGVmaW5lZCBpbiB0aGUNCmRyaXZlci4gVGhpcyBtZXRob2QgaXMgbm90IGdvb2QuDQoNCkluIGNv
bW1pdCBiN2Q2N2M2MTMwZWUgKCJQQ0k6IGlteDY6IEFkZCBpTVg5NSBFbmRwb2ludCAoRVApIHN1
cHBvcnQiKSwNCkZyYW5rIHN1Z2dlc3RzIHRvIGZldGNoIHRoZSBkYmkyIGFuZCBhdHUgZnJvbSBE
VCBkaXJlY3RseS4gVGhpcyBjb21taXQgaXMNCnByZXBhcmF0aW9uIHRvIGRvIHRoYXQgZm9yIGku
TVg4TSBQQ0llIEVQLg0KDQpUaGVzZSBjaGFuZ2VzIHdvdWxkbid0IGJyZWFrIGRyaXZlciBmdW5j
dGlvbi4gV2hlbiAiZGJpMiIgYW5kICJhdHUiDQpwcm9wZXJ0aWVzIGFyZSBwcmVzZW50LCBpLk1Y
IFBDSWUgZHJpdmVyIHdvdWxkIGZldGNoIHRoZSBhY2NvcmRpbmcgYmFzZQ0KYWRkcmVzc2VzIGZy
b20gRFQgZGlyZWN0bHkuIElmIG9ubHkgdHdvIHJlZyBwcm9wZXJ0aWVzIGFyZSBwcm92aWRlZCwg
aS5NWA0KUENJZSBkcml2ZXIgd291bGQgZmFsbHMgYmFjayB0byB0aGUgb2xkIG1ldGhvZC4NCiIN
ClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
DQo=

