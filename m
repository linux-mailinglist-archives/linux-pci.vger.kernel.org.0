Return-Path: <linux-pci+bounces-31863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE4B00926
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4583B644044
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAB26FA70;
	Thu, 10 Jul 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XR8Ba8Wx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lPRyYRbe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B02AE6D;
	Thu, 10 Jul 2025 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166081; cv=fail; b=N8XD5cRg3J3I/bL+Q1djXuyh4r9yhzYnoEFplREs/1FfdmRe9Tg8gRgrl2NpZ3mIrRV6vT68JPH1fhNWTph0fjlS3chDgvt/0nRg0CC5afqL/FS/+rjOyTgRHluSPFbbRToa9Loqh67NfwxS4HqHLJugUH8DynnU1eNxoyEIxgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166081; c=relaxed/simple;
	bh=nWo5M6I435J7ADIebBjB6Fc3e0ir1lJXHaQ/4VeBr4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AUi53eU21fU7jF1jS+HYhrmQVgJqUrqaNmPxSQiuV9KKFgYwA9KV27+srODGMEP3PvxCqXppyimGYOQ+TMZNo9ZKc6xPUbeY82Chvlf6IXYkBEZD4aiJjMPg4AyOoQLK03/QcrVZ4jVRbngmaT6IsK0c1gtYcwpLEdC/lVJnsjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XR8Ba8Wx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lPRyYRbe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AGastn022489;
	Thu, 10 Jul 2025 16:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=93lyzB1JIOrJ23yOQLYtii857v121y+Gi6gcQxNkbVQ=; b=
	XR8Ba8Wx5PyRI9OZUQeUa4eZfdtzJxmvjP+gLm62d++tyGWHGoI06/87YmaPIgiv
	ZbHwZC9bpgvTsrnEHBKitZzrr81PfxXau/MS53d04ZJ17K2HPTM+Ql8qpdNF8t+F
	dYzQnKMBOufjxiYXDS5zZGLvUQf6PeV8pajrnmoxOmTyn3jROwE7ioX1E3ll5cl7
	OFc3K3iv3cz0+kAfjbWcSj2QIlmDI16j/iU0c7oQ9VOYCZSMvjWAlu6hzAdYEHT2
	wyMPo8j5orpMiIWxLCRNemm8NEwKDtme4shOurNh+T7QEW8l0wtkz+jC5tnHZRIf
	iFEE/NIZoWiJOP/Po2t9WQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47th6gr0r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:47:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AFeubW023632;
	Thu, 10 Jul 2025 16:47:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcs4f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 16:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiuNaRlXBYmjB9e0vf9xcRroHNjtJOXdyiUedtccEPOX51gCJlc9ornNJPV8gwtSyTzI2WA4qLjuyqKCkA2EifYxXtaLs3mpLuUUMqb90+1vklsoEcZqLVSxLuCDCuyIFG1uC/56M1Xa6Nx39lk1Cj4nMhr9ctqRXvhI+BNouoI9Lv4mnyvxyHZlHaDmDbXdHxECDIZdtn9CJybmL6pZ9hrFke2TkjA6eQUZMXOqaQxzBM+WTm0DLjkZmg1+4UBT516jyajvCQ1ZigUmnR1pzffy7s9p55GNTJ82qPfbdnoWe5KLfOo1ntD0wjNq+E96CpFuZ8g+RLp9z4R3yvjbCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93lyzB1JIOrJ23yOQLYtii857v121y+Gi6gcQxNkbVQ=;
 b=QwzbbZuBuPJy3qKMB6p0bMZhal9K085gDFRfsyIRTPFPOOlvKuLwMUYgEo2TwnFdbaz81uIKUJMYVsU29LIyXXbqGdWw8kvPGGeasUhyG/8gSMQ8QSNA4sH+69GaAZG37Co6vmsSRyQgDGQQlFwe2Mg8oXjX5eHAcHG4LKHNtanOuXM8Ig8oBjxNj4X9CjrEL+ULLjwYh9zhuVCujBGGJ7e2TfyvAcyLdChRP99/YDMpDvTGePC4b/XKI62ENFfyZ9Y4MjJkR70FglarLlp2VWhLisVf4RvoZnjRHz4FBGwwbuIKnGXbVvuojQindqkHm5RgV4xdAVTjAeJCg+O5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93lyzB1JIOrJ23yOQLYtii857v121y+Gi6gcQxNkbVQ=;
 b=lPRyYRbeJh/jFgRIeQG6HRGTmYL+PdRhEKFabqnb734mb3463ORbw18YribVQ66RQQsZnwsEtYilulI1y4mgvPQXhSsDC5o99EIXUCILLaKxXReNPD6RnytK+9fynGPHpGFXrEAQ81JP6PdlbSuKDI6EGxyYWGbQQv3zWhmxwO8=
Received: from CH3PR10MB7959.namprd10.prod.outlook.com (2603:10b6:610:1c1::12)
 by DS0PR10MB7271.namprd10.prod.outlook.com (2603:10b6:8:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.31; Thu, 10 Jul 2025 16:47:51 +0000
Received: from CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::2c43:cb5d:a02c:dbc2]) by CH3PR10MB7959.namprd10.prod.outlook.com
 ([fe80::2c43:cb5d:a02c:dbc2%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 16:47:51 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        Jorge Lopez
	<jorge.jo.lopez@oracle.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/THP: Fix hang due to incorrect guard lock
Thread-Topic: [PATCH] PCI/THP: Fix hang due to incorrect guard lock
Thread-Index: AQHb8FdAj0XDsNPQXkCEGogDizA5M7Qrk+wA
Date: Thu, 10 Jul 2025 16:47:51 +0000
Message-ID: <FA00F01B-4C0A-48F5-B541-9A377C54D437@oracle.com>
References: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
In-Reply-To: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7959:EE_|DS0PR10MB7271:EE_
x-ms-office365-filtering-correlation-id: dbc451f1-ac13-42b1-5ce5-08ddbfd18256
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O6zpU0Qs1QGxzcNnFOA/lZiungSO8SRlnAgY4evlk+MF3jyyYPbtexWWslgv?=
 =?us-ascii?Q?4moa9+dhmh+QgZ4zG6S9PjvsCbRBgMpBsFM6lbxD0R8hnh7djx4aN7Aa5pFj?=
 =?us-ascii?Q?wFgd5WqIDzY3f2qb45a/XAiv0dJA9lAXjnbwO2EzhQQtqhoPVnPhBogf1xcD?=
 =?us-ascii?Q?mZYcQQD53jJAtW6FGZiH2FT4ShFPqdbNmbaNRwxxv42WKnVQNxv1Mr/XQETV?=
 =?us-ascii?Q?5IDb7b5HbLLZzexB5HZcu+5QdC1rya3bCRFYe2ftkRtblvmkLuN/O/EQy2q7?=
 =?us-ascii?Q?mnjzfOj6uFBR/aZAFGX4Psftr3EWO9HMGPJRJ+N61GSdTH2Q5aKoPnKL9Bgb?=
 =?us-ascii?Q?HbAWEvNx4pgdN4mwVRhr95bvXf4m64VtKuNPSz/F/7xkPV3kbYP8HvKlAGbY?=
 =?us-ascii?Q?RXVHEvmAbc76mapetVGq7n8HGs28tHIsbe//YJBaAVriwKiRvxb6al/1P0v5?=
 =?us-ascii?Q?Na5jwj9sA0jIrASFddQ7ORf+6D1vFl19VJfg5bkQOr77v6FvDs2vHgDgZHta?=
 =?us-ascii?Q?abEn/ArxGMYBXVZvvXGlqSIxvEFbLbiTSr64tOWdhVp1e6F5TOUnKq1AapRs?=
 =?us-ascii?Q?1lHPCxdRguJIU4y2AdK3+K7wMBU+7nGF3K6OzI3U91lUpvn/AsuB9i+k8jeL?=
 =?us-ascii?Q?U/wK0e4e17IwS3v9JGCb/gPKc0rPLDETvrNbK5xATo2tLbXPTGa9ZEU3oGRI?=
 =?us-ascii?Q?/9gF7eSkxPENYHnHmVYgmqujmZ9MhXOR5fvf9IVlVsunwj6X345jri3qK+jX?=
 =?us-ascii?Q?JcFoSPPi5HtP388pWZ0+qgHfIqJIz3S0xOzHafSZ4QFIomFM357N3coQjCVN?=
 =?us-ascii?Q?1FIhT8L4LqiKmUzX+09drcIFMrks0vxtkLis90flI/9YbyUU9xi/izPfAlM/?=
 =?us-ascii?Q?JqsYcSkimTf4A9iTAcqJxGAP5lKuqrZliF+E+ghsL+XxG7uRHMTFwZd04a3k?=
 =?us-ascii?Q?Oel7w681/GauNyDSF6Z7jfYqybO5donDnOpbxkZm4TFzDjWecjuWJJovfXsY?=
 =?us-ascii?Q?xD2dnvmWyeL0/HXEWSXOEr+O7BAO+aKF5+LYpZAxTBNMqXpy6w4Eg73aoTNs?=
 =?us-ascii?Q?p7Z7SV7qg7+U/NNkugYF41yTsxB6zPqwxgenIER+0JZafbhYXDY5seOnpxP3?=
 =?us-ascii?Q?3KTK55RT8NPpY1TegvNa656iyF6ebQOg1quujzFdr7ZZx/dVA76SiLlPPIYR?=
 =?us-ascii?Q?yqjdM9XzmeR2upFZPQpkaAYzUdK86A/nY9uU1Ca8eV2clk+wS+JHyC7DrrBa?=
 =?us-ascii?Q?HDSzolAXW1EHoWZFUEt6JSkmwfTvWXC/lxXn94R2swtrmvaH0D5t7nJMR3+5?=
 =?us-ascii?Q?jKMP5tDoovtF4Kg1+dHO+AuP2QveKLGERUqwrS08ItFUdABSkXf96hzOETiG?=
 =?us-ascii?Q?vKdCGFNXvYhcMDXS+xxlZ1sShaP/KnEQg+fmvS5M8YucvaqBv+9rUq9+lQj2?=
 =?us-ascii?Q?iHC59/YQmSliJ7PZWZt3VhZHonS82tCatNqNlw2oXurAmOQGgNNbZw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7959.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+PWP9z4QUPpndQBUICPYMuhntbBNu0crpiHFzZPd7HKJMiJ/K2Xgmf/BcwMN?=
 =?us-ascii?Q?5zzg/Bj4/rrLwUz/dUMftPquUGUeJnFPXKKUYk8zUVZjqRisi5E4XTJdfEbM?=
 =?us-ascii?Q?MmZIdDrSR9tquXRMR5VpCj1aGWO6LmTHBy4eP4f5JCaKQK2avxKciiCyptbY?=
 =?us-ascii?Q?Qfg74OZw6c6P+QM2u+ybyrOu/88nWWyjfom7zGsnEVa+SGuK9/cngGE9oNrb?=
 =?us-ascii?Q?6Bcw0jPzBx4B3465TjUbf4bUDJNL+bGYxVXZ66gFLaplvu7qpkrrXSwZR3OB?=
 =?us-ascii?Q?afD5pAkbT7ohuqrM5mQ6FieOgtEviCCC+7qV+biVz+tFB9I85ONgcB//HoG9?=
 =?us-ascii?Q?gxorNKDo/uhF4bumFLGWHLlo8C+tQ2ZVakSXM3kHqu36CfdsaMu+dUpEXur+?=
 =?us-ascii?Q?+RZeBBUGeQ7gVEpYqWWwtHyKIB0pQJKlLEXS/Q+HVGz81hUc1Q8WHmQF72z4?=
 =?us-ascii?Q?cNO3aL0OLwtWjUuLs4USj49DnVX/Ur/OX5totmbaNRpKRSV725QPMwQzRmLV?=
 =?us-ascii?Q?BuuyISAVplkkBcWwrYPUyS11Poexz88uaj1lqyJpr8XcpyolF/baoutMv8cq?=
 =?us-ascii?Q?aSnr107r8BJdXst4H/Piyn2ksmkmj0bAgmug9qKQLrlWsRTaa9J6izDNGz0P?=
 =?us-ascii?Q?M9GIYnSIICljoWhCcwRVqYhabT5HwYXRkhDcJ481szLxmYrateIP5HFHd3qs?=
 =?us-ascii?Q?8VypHwAffUqGk3WfXryiqC7pyiLj+EslrYXYwrke8eWvR/TwY4aeVj7iKaw8?=
 =?us-ascii?Q?rcXAyas0/tgEq+hnbmxkp4w8UiYBoNCMKVmr+/ubEZKWeqYgMMFlCgmh8Fdt?=
 =?us-ascii?Q?7HYjR55p5is0TINT/mpdir5XkcLYMIrmhCOABTG9wOSk1p6BjxEFkRrLAVHy?=
 =?us-ascii?Q?Oc2vdwHHbbAwlD+yGZLM5o5NnmmnQ19srIdlIrxZYl75Xppn2VdN8g/QDx3g?=
 =?us-ascii?Q?2W1SI72Ezkw7Bs+krk+2dm6DrVbsGxN1lE8DBn6SWWxEy81J0Gf3fvAQO9c1?=
 =?us-ascii?Q?dZth0BJvcCMV+nmaQI+mOBU2gjG1UA9rf/YXPTJWGbdYwEV4CPI6I3++Y+2z?=
 =?us-ascii?Q?1VYR4GrYu2LVBkSAipUZAy3nPDMxlUfO/pVx3srmb/MVhnpgqEv3GbbFW8+B?=
 =?us-ascii?Q?1Sk9eMEHEGe51nQ6dA+A9E465AoYeN/WKTV1jMk9f4WFpc560cgPRrEf1Zxi?=
 =?us-ascii?Q?g7ZCzUtdK3sytzUbLZNHsg9PJZFK9PxChJiRRRO6pN45LJWK3brjKMsJ2LA8?=
 =?us-ascii?Q?3QKKmNpvBw4PJiDFBLbbv72X4lyhqet6NFKEMZWesBfG+auzesSQqHn8WHHv?=
 =?us-ascii?Q?/GV9JcxznQJmKvJTHKV7z5a6OPga65zvEzwbRDX362YtHaJ5yg3t5wIhfkCt?=
 =?us-ascii?Q?7Em4iCP09Z0gNMhRsIRBxwM0FVnd7h8Av+t0Gyzn7XTuDWV5iPr8C0b7ZrTA?=
 =?us-ascii?Q?u4Bra9xxUdm+Jbzz2lYGYxUy4qfBi5sLE2tIcTAc1yDSZfwrrxsoUSD+6Q9G?=
 =?us-ascii?Q?YHHJC44mCB+9APiOUynSW3Gp+AW4fHo3jYQeoKScBjeFp6Z5An57hBBG5+9i?=
 =?us-ascii?Q?KExce9HPcT8Vpoi+2dFAERF3Nr7SrJSNO0lp07Puf17BOgl00+xW5x9meXsr?=
 =?us-ascii?Q?X7V0A0W8MQTlumoM0a7LgJ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9388420FFF0284AB52897EC87AAD977@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0yBFVV0urGEJBf0yPKCo0tElkK12thYiY8rnfJQ3n0WzlcZjSFPPQIP9g44hAvyFhN8SxJCDzw4xGlMQyPMTI+72SFlrLQl7/L+i3qFU1ftdoUWMRK4vHZVsO14REJHHWfhGJPe4dmUBxhO3HDZ6DsByjbTIojhgnfshPgZJGmhKjp2HOwqF+Ti2GsCRxbHPsudUnzlbIrciarPh/tRFI3f/7XdL29nFB233Aut2uvfXMd5s7OPdzsMan8Oo6O6+eCkzq4l7crIZd9O9XBHuOU+Qz7D7RwUDr6ZL0SID4HERDau8EwAVD2NXxy1GcAURXqIwe9mEFCHx7kroPEozswQQtcZHnOtWHwn9luFaFyJVsqCuLKZHV/OwnaB/vsQPAdriQLjTpMvPo4f6hS2A5iYPss1rspiqifVJU9rjxArN9kWGcMX4lTQUjVrEfN1I0ZXjAENV1DykbaAh5H2qSL8q/xg5KwSKPBcl0A5x4gRySnbCBHjzPv2GrLmy26Pike6o7xiWKJj6stRs/egWDPvSpn6Gq10ESqXyLqCokko994xnWvQhnsCqRH+4j0oYwhtYSr5az/lwrP1O/4M02eVLc2Dg1E592r4GVP6bkU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7959.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc451f1-ac13-42b1-5ce5-08ddbfd18256
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 16:47:51.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WBo2HibP1WeMLbLBh/B7oSYafjXO8Os98U9+v7aER7MsM4iI6oIUQjhH3HHfbEmwG/GeQjAhh4KnXwPUQZzisw9M7/0Gyqs4SaFhE4nvxGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100142
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0MyBTYWx0ZWRfX69WzlSVd/NGg XALAkaDDpvU1B9xUFw6//AW71ULnqZuYEx2uOACs63+7oeG+6JhDMiaPt9y+M41K7Xsxhm8xbrH yHJlBYfJAN5Mg0HTD+hCaXonLSXgitIJgiiSSPoI7HDiXuS+EAvaq2ZzADRzP5DM00gDXdZh+ep
 COFfOyjBXoZh9WmJQ5uVneQfnFsLS/V6IiX0JSYgKIAzjJGRW94KfPKNhAex33FAMoWAKLehcSI g873mtISVSmA+FtsvIRN54atHsnW6Eso53HsGiOlzZSH842wu1ELHBho3l8WWaIpwdDYzy3VxrR UGRmLr0tlXP4UUKQkGAz2GhEaLZG8quJ+E0ZNSkfvaw5egUJrJVorc+/OFbIO4Bx2OYL/E7jCIY
 91Hx/YaiArkR7ypfs/Ij2vRa4dhmvlNNDpCl+yvb6K3TyKiH62nMMt2fnPhjCl0KQPoWHPNc
X-Authority-Analysis: v=2.4 cv=LpWSymdc c=1 sm=1 tr=0 ts=686feebb b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qlxIRn9Gb8iMQPW_L6QA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 631RYAsCHi4O7NwchB4MlLfV3doYD98T
X-Proofpoint-GUID: 631RYAsCHi4O7NwchB4MlLfV3doYD98T

Just realized this patch was missing maintainer email address and mailing l=
ist for reviews. =20

Bjorn,=20

Apologies. Can you please queue this up in the PCI tree for inclusion in 6.=
16-rc6.=20


> On Jul 8, 2025, at 15:25, himanshu.madhani@oracle.com wrote:
>=20
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>=20
> Fix system hang due to incorrect mutex lock placement.
>=20
> following stack trace will be seen on system boot
>=20
> [  525.664681] task:systemd-shutdow state:D stack:0     pid:1     tgid:1 =
    ppid:0      task_flags:0x400100 flags:0x00004002
> [  525.796878] Call Trace:
> [  525.826116]  <TASK>
> [  525.851195]  __schedule+0x2d1/0x730
> [  525.892917]  schedule+0x27/0x80
> [  525.930478]  schedule_preempt_disabled+0x15/0x30
> [  525.985718]  __mutex_lock.constprop.0+0x4be/0x8a0
> [  526.041993]  msi_domain_get_virq+0xcc/0x110
> [  526.092031]  pci_msix_write_tph_tag+0x3c/0x100
> [  526.145186]  pcie_tph_set_st_entry+0x125/0x1d0
> [  526.198346]  bnxt_irq_affinity_release+0x35/0x50 [bnxt_en]
> [  526.264015]  irq_set_affinity_notifier+0xe0/0x130
> [  526.320291]  bnxt_free_irq+0x6e/0x110 [bnxt_en]
> [  526.374507]  __bnxt_close_nic.isra.0+0x1eb/0x220 [bnxt_en]
> [  526.440175]  bnxt_close+0x3a/0x100 [bnxt_en]
> [  526.491264]  __dev_close_many+0xae/0x220
> [  526.538179]  dev_close_many+0xc2/0x1b0
> [  526.583014]  netif_close+0x9d/0xd0
> [  526.623693]  bnxt_shutdown+0xb1/0xe0 [bnxt_en]
> [  526.676874]  pci_device_shutdown+0x35/0x70
> [  526.725871]  device_shutdown+0x118/0x1a0
> [  526.772788]  kernel_restart+0x3a/0x70
> [  526.816588]  __do_sys_reboot+0x150/0x250
> [  526.863504]  do_syscall_64+0x84/0x940
> [  526.907300]  ? __put_user_8+0xd/0x20
> [  526.950059]  ? rseq_ip_fixup+0x90/0x1e0
> [  526.995937]  ? task_mm_cid_work+0x1ad/0x220
> [  527.045971]  ? __rseq_handle_notify_resume+0x35/0x90
> [  527.105367]  ? arch_exit_to_user_mode_prepare.isra.0+0x98/0xb0
> [  527.175166]  ? do_syscall_64+0xba/0x940
> [  527.221040]  ? do_filp_open+0xd7/0x1a0
> [  527.265882]  ? alloc_fd+0xba/0x110
> [  527.306556]  ? do_sys_openat2+0xa4/0xf0
> [  527.352434]  ? __x64_sys_openat+0x54/0xb0
> [  527.400389]  ? arch_exit_to_user_mode_prepare.isra.0+0x9/0xb0
> [  527.469150]  ? do_syscall_64+0xba/0x940
> [  527.515023]  ? do_user_addr_fault+0x221/0x690
> [  527.567141]  ? clear_bhb_loop+0x30/0x80
> [  527.613017]  ? clear_bhb_loop+0x30/0x80
> [  527.658895]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  527.719332] RIP: 0033:0x7fc3ec504777
> [  527.762091] RSP: 002b:00007ffecd62c4f8 EFLAGS: 00000202 ORIG_RAX: 0000=
0000000000a9
> [  527.852685] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc3e=
c504777
> [  527.938085] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000f=
ee1dead
> [  528.023485] RBP: 00007ffecd62c700 R08: 0000000000000000 R09: 00007ffec=
d62b8e0
> [  528.108878] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffec=
d62c568
> [  528.194273] R13: 00007ffecd62c548 R14: 00007ffecd62c568 R15: 000000000=
0000000
> [  528.279672]  </TASK>
>=20
> Fixes: d5124a9957b2 ("PCI/MSI: Provide a sane mechanism for TPH")
> Fixes: 71296eae5887 ("PCI/TPH: Replace the broken MSI-X control word upda=
te")
> Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> ---
> drivers/pci/msi/msi.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 6ede55a7c5e6..d686488f4111 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -934,10 +934,12 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, un=
signed int index, u16 tag)
> if (!pdev->msix_enabled)
> return -ENXIO;
>=20
> - guard(msi_descs_lock)(&pdev->dev);
> virq =3D msi_get_virq(&pdev->dev, index);
> if (!virq)
> return -ENXIO;
> +
> + guard(msi_descs_lock)(&pdev->dev);
> +
> /*
> * This is a horrible hack, but short of implementing a PCI
> * specific interrupt chip callback and a huge pile of
> --=20
> 2.41.0.rc2
>=20



--=20
Himanshu Madhani	Oracle Linux Engineering


