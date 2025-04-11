Return-Path: <linux-pci+bounces-25651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B879A85274
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 06:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8814A7BEE
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312F81581E0;
	Fri, 11 Apr 2025 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h+BdC60Z";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6a4fg/33"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF23234;
	Fri, 11 Apr 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744345403; cv=fail; b=N7pVavqi/BKM2adHtaxdjQiwL4ARqRpii5OnpuKIWRZq2fuqOIdnQugB/ejZIQc2tpRovo7oyLvJUWNdekJUFmGjiT2vTmGuKwYrm74HzFAEG5iP3ABtbhmFuOyygDMSzZlTZ/0f/gK60a9aAKXEjavKUJYAbGVnH12HlZNVzYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744345403; c=relaxed/simple;
	bh=jX2g7ONQ0CceuNm4QzIxgl2Bf27NXv/aPb41R/gbQUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XEWBFGz/+Cy1cibZEBQILHHxqaV6xvWne0IeQ1ThTQwmxWlzPUPV+hjeiySll0osa4HosYIG00pTwUwEt7UIfgQ8paiTN/M31s6IOnHbHrBQts3O28dZgO3G9U4JtiByWSeU8JNQOls/OaY4fwuzK35h+1aXdZstjyKH307cEdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=h+BdC60Z; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=6a4fg/33; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwgFH026724;
	Thu, 10 Apr 2025 21:23:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=0MIfBYa0yeSj46edzXRiNzwRtaANtcPKjw4FITlEUgE=; b=h+BdC60Z0srN
	9dlGkLfJAkRG3JnnWFbtCAMqI259OrufyCm0eGbIil/a5PuXqrzT4D48EE3960NQ
	f6Kg9gESdsNcbS0xQEFJcVBo3RUAjqviWNOomkfnvWtE0s80GPDS/F5z50CEEm/j
	HbY81CtPzxkz3mDBJjvT5j+t09wLBrdMYaocknKNKwS8hOiVkqitMu9Wr+8AfR3H
	HpplvlFQdz/p6wRC6PM7lojHnk2GUsQ78ioHZ2ORPCG4LHm7OXDP9BVX/Y/48ed1
	lcJ0u1eH+ezXkorkh7SJhs+7uVk3nN+S4dayJQuNvj+z7rMp+Anaj9pCkVuq7Qb+
	f3GrIMDOuQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45u03wuevv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgoVCh0npetKKaOTt0p2sJuSjH4TybjTETs9z0mQy6o/PN77hWnNrYnjk0UgfA7dzut5RRv9qAemtAuxcnJDUqVMpcrHpB/Jby2zboJsZnWGElvNLNHjdUK6cuuBS53slpGTd57bVU+g5qIgz35TKENa9qnhhwxlJ+M/pQvrvgseUSgPMIufkOFy/nWbdIGEuOl0Koyst8q8O5VjEkVo3pXCjsn/l0BXxD6+hI52OrYgSz+Z39U27/mcrDSYM7zVIewgfZFu4ZehrPktu+jB5FjVvZ7IkcDiTtO3lku/fdHN2KFpappWrR2t5Aq/rJv6bZRHVlfiFesmRCuX4ZQN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MIfBYa0yeSj46edzXRiNzwRtaANtcPKjw4FITlEUgE=;
 b=d9/PVGqaGMSGggn5TXSJ3H0wBaUHByDWkUs99d77EPPae5wJWysRiRztJn3oYzaGORz+V+otHujALksgQJ/VwKh3tU4mnSHIoGJ7pkXJQ51uo1gBtY9P/NQx6cKO9k1gJLXH3dAHOXVCKEOC+Re0M4jN5WmfsHER1pQ+6BiRRSmb7BIEo0tU7AUPcfzWK39D6XRZ51MKKNSv37mf/aLVKWAlD3Pbz2Gmr8IjCoUemHMOrNm9n10SFphUchB1g+S/MYm1eO/tMuzWsa7/BMuJVeHrqqjHDpVIXGI3XH+Oa6q9YnuBX8HhX0FUMLdHBVUmBGiVTf9cHQAM9xWeIDFPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MIfBYa0yeSj46edzXRiNzwRtaANtcPKjw4FITlEUgE=;
 b=6a4fg/33RKo1NY/9lIdZe76HeesmzZKd5dfcv/VggPY7Mp39OZtC6ZcM6J7M0fzE0TISh6lmiz8Tz49LamwIZlRd9kfzWingvpaoNIKgVX90DTGq84PcCzpUKXCf1/LQeUt4bu772mCLHFJM8LKIml1ycioeUNWsm0ttw3V6g+o=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by PH0PR07MB10693.namprd07.prod.outlook.com
 (2603:10b6:510:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 04:23:10 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:23:09 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] PCI: cadence: Add support for PCIe Endpoint HPA
 controllers
Thread-Topic: [PATCH 4/7] PCI: cadence: Add support for PCIe Endpoint HPA
 controllers
Thread-Index: AQHbnwkT/WXya8JxT0KBS+TATPDd87OG289QgBUgEICAAfhiAA==
Date: Fri, 11 Apr 2025 04:23:09 +0000
Message-ID:
 <CH2PPF4D26F8E1CA2D74FDA7DAD29C33518A2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1C61F700C22A738FF8846DA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250409221559.GA299990@bhelgaas>
In-Reply-To: <20250409221559.GA299990@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|PH0PR07MB10693:EE_
x-ms-office365-filtering-correlation-id: eb82f97e-68a5-49df-e5dc-08dd78b0910c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7v63rjCdjuwZXLrXnceKdbUp89wAI0ttYALOZSm2d5wnwYutd2E2DFwZoGfF?=
 =?us-ascii?Q?CfS5pb4spmTT1vbFko7MAyer6lwWBYz0odW6ngMeSGaU+U8Zpl3mvKWoJSdF?=
 =?us-ascii?Q?O20iXS31qM52/ebiPqYZsnVTja2g/logCFl6NSVW8yOBuVAkSu8uiedIRsK2?=
 =?us-ascii?Q?1PyRZ7IxjJvqN9UmHQTjf0WyLn39fD+zBD/RSP454mC4SZhsP2PEsKtrzmTp?=
 =?us-ascii?Q?2h7VwjM1vwhS+ma85WrHqiYniIT9H5CNcnT4QqpIGWO+/eoR6uFYC41lKr3/?=
 =?us-ascii?Q?Lj2qlsyOuCes8a9cCjmIYhd1ozCsyYrhNY0ZWmxurdBU5lYs/ghvS1eZjElg?=
 =?us-ascii?Q?IQq+oKV+paCsnfyxKfvlY+P6k8Ue4a53iWe/o/xXCQaqv0kFv9Fg3o9i9OoI?=
 =?us-ascii?Q?JlqwQjekXwFqlZU3xHfpuSSxGqBkRsE7twlyKQ4CPMT4VmuNJ9X7+d+LLedR?=
 =?us-ascii?Q?k2ojDHrWEh+Xr8WkX0xzx8JCjHdu/pWI4vdqkL/LU3G2szZQQklCBykfRNCY?=
 =?us-ascii?Q?8gjMmgQjHvhvh9m1N7K8LPfjWKQh6jPZupln0IBvOG3/a7STAsNXBoDXMs6S?=
 =?us-ascii?Q?Kp8KYmT5MB1ozfGL0JtJ/0eWYppsp8//GQX7ktF1nOgYIfIRytw/qMne1qxv?=
 =?us-ascii?Q?JpZ9s45IKI9GPpI7qbh8Wx45H39xO6F9CwRz3BRx/6VgtaOwl+1TqIjo8e89?=
 =?us-ascii?Q?AY2YgyJ9tY0c3hu5LpBRiwawtnb/gCI1Hqc9Sr3IIIAA9UzdlNQB+ehObOa9?=
 =?us-ascii?Q?8p1K31MnB63iQoUtLGgCMTmD2gZ23Rd8KqzC8FRJxoFR+Sa7K+/meM4V+k7V?=
 =?us-ascii?Q?EIrAH5UW1aUCX72apfkUnGhkbtBScXPUARxn0UTsDXJhLkZ8s+najDgO2zu4?=
 =?us-ascii?Q?8sqEzcSBoTfBANqslpjQa8OjfVEsoEHz0TB8vLC00bFrt99pE6kkOFNxu4v2?=
 =?us-ascii?Q?/hHwpUOf6qiqui58cWkj+x+IBlQ4uDd9R+HECDlDXDw7wrzqd/ETb8mKvuQC?=
 =?us-ascii?Q?a21RifDxBnvQ6mkquU/3xkuMigUwHeRs0MHBwVCwS6eFevM4sUGeTskSNCEp?=
 =?us-ascii?Q?9voHd5mTDP+Q53M0EovNUXTIBg6xZUt32EQZ5imEMGNqLicmWG7c46dyVbVt?=
 =?us-ascii?Q?XkGYHTRrl/9k0FojJzvSMdowJOv/Ham9xwYH+GmvDILeWZEO4ei0DRfsddY0?=
 =?us-ascii?Q?m+DlKPdPIrvzehGp9G56XO1AoXHXUq1BP2tyXMCPQed7jHyPfh19om14vD4x?=
 =?us-ascii?Q?UGFQWuqbHWDePm5JWFqhVoV8us9vUr2Guguaf8ZE8Si+G2VOCZRjkIGF5ZvB?=
 =?us-ascii?Q?Y9o5OlJA4dKrlin/sXJwodCPnNDIquzETFp7uJnOHxgncQJPq3vKpf42qYyG?=
 =?us-ascii?Q?k/pXJCIyV46Vb6k5f/LTCjfIsrMQQ+Z8SczoKreTq7oUqW3J9H2i1xw3EP9S?=
 =?us-ascii?Q?Q672OaxoC51fClD6Vsou0ai8uO/F8es15dlRNBN/GYWou4E3MvZ+f8BzH07Z?=
 =?us-ascii?Q?de0kd5/ju6p+tls=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iM+zHtoJPbksCeSH1/cP+4hQ04gxYbZv5RkgrjIj+56sQtwywctn6msEvEbw?=
 =?us-ascii?Q?CYvh3Js2AHMeuxP8Mzir6DT8Iba/tcWjZHA+yddjrOjwxLjfOcbOJEU0mheD?=
 =?us-ascii?Q?Jx5QT8kcUoiNE1pF/ZbF0frexkWs8OeCfmRixPvB1KNDgpyIsv31t9fvqtwp?=
 =?us-ascii?Q?xi30qumKbrvgFLcWPfdCOrSdqQQ4fjEIDY1IkgX1qJfdmJFYj7q7PadAYXGX?=
 =?us-ascii?Q?+zBC9d7CcUqrGayXAvhbvZXugUJCPRj7dIK+8YOYcimcJwBPSmNeNryhClqj?=
 =?us-ascii?Q?mhRmvvBRoXL8mAECMZtAd1aU9jC6t6pIgESlCFqKffHtiserajnQwqzoCpD7?=
 =?us-ascii?Q?F6rg9utErlgMNJFq7GkPxqJk5Ob6g0wgLKRlPPZK3+jzBFydTPXT2e8e/OtU?=
 =?us-ascii?Q?ieW2XHZGFKNTp0PaqpAmdfOC2p9EkJTavtVs6T6UbhtYzGtcSyblyjDMzbuj?=
 =?us-ascii?Q?twG4tAjRacul8Pm+BWODTtoeon47CsM07ohYhK5CxGTH+IXUOSSCUW63qUmQ?=
 =?us-ascii?Q?tHfiZd3qsQCCHnBRey29I/cT/rrDphsSRxJP3Ad7gGsBtPcX3XSCN7tPUGeI?=
 =?us-ascii?Q?9bVDceakg63HvcJ1FMb3nf2lNrSAolOlavlRmZ5uilbf6nG2jkWKcKYskFqM?=
 =?us-ascii?Q?t4XVA39lxaXNrvRXxgbYEpH0UznBtNCfdFIJwMqYghG4rdYogvaWoUazi19G?=
 =?us-ascii?Q?DKA1uh2D2ASlVKfz/zuIewtz/d7uXWJhnXHg45TSXBC/Fyxy8PtkIKySSTQU?=
 =?us-ascii?Q?jKPo7NWuruLxM8r3jwrpOpTqX9mASIaxbFBlMJAq/M20cFBIvGo3uBUVvPDq?=
 =?us-ascii?Q?r6hN2EL0jbcYyri0/yBSC6Ym/7DOZ+x9eOB9cJLmQK85Mwhk7iH/8EXfR3aB?=
 =?us-ascii?Q?w38RXAMjNnyZoMjm5KzEzhI9MJxaYFkOEMkL4baf9sbxclmk/F8ikdy/oEk7?=
 =?us-ascii?Q?LQJ0r7005fCVy4CPDHXtdEOnp+cMDaDOtIazmiqU0l+KByTP30ootHXayv3m?=
 =?us-ascii?Q?0fimNQUcPE3BqswtZf6NvdQ79grY7dp9KfDcxlBf0BxRrIxDwSHswi2hou2o?=
 =?us-ascii?Q?zBjM0FxgOTnDQ+nTU62ryk2SRKw26W15/r7Papc0gTDcS7jAmlVCPQjI6Q9H?=
 =?us-ascii?Q?kaQbu9Bo2a7jqIeUIUVFHIAJtDd/xJPZ3zBLFdAEuCCzxztn4rsBgZg9c39t?=
 =?us-ascii?Q?NL8nE5CrJh4/Y8xo50jxZAHmCyBaM4aVt48ytbq9oEaeayuDYDrJq/QG0yEd?=
 =?us-ascii?Q?xhYiFC1N6NDCHD9KckzDHRAJukBYiCLoN8aqcWYwhaOtEqzf3JT1Wksv0/e7?=
 =?us-ascii?Q?VrsIlZ2dsbGLZ0iqPuhh7SWqhsDWT2Kk9S+oBw0G0qQvBJKWvK7BIN+JHA4m?=
 =?us-ascii?Q?6xd5KyqPJrOhgwCZDElyb/zVSqbpIptTgJyXx2R9Jqge295SX83mHzn4qT+s?=
 =?us-ascii?Q?Y4i56f84/Qn+k2IvYg7s5c0PDhRhSeDM4a7dCKe2njcrDlZnl5THhwC1f+d6?=
 =?us-ascii?Q?wCauz8xN0vGm7uegpbEvuxhcxCcP6LR1yBPHP64Og+qGSvUIBR7RGb+zuHJA?=
 =?us-ascii?Q?yuTMR5ViNkzeqGEdKZojPvDNc4nfgfr35vt4qGPSGn6T4gTup0qUVMkpP+RC?=
 =?us-ascii?Q?3g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb82f97e-68a5-49df-e5dc-08dd78b0910c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:23:09.9276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F17nQ2jODIGjfBVt33D0GN4RWEdS7ts5gsT2Ij/gxZwA2GePxURhR1z6XdFPdzifJdyxZnxb/cmkMDN+CKl6ns+cSluRcHwAzBgm1XaSNXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB10693
X-Proofpoint-ORIG-GUID: f2OkUVMCt_0SDk5z7kFsl-O5hbkjv1uh
X-Authority-Analysis: v=2.4 cv=Qcdmvtbv c=1 sm=1 tr=0 ts=67f89931 cx=c_pps a=aBehHGrvSf44cF3hBtnTuw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=Izo7mvsFxUDh_7T53NwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: f2OkUVMCt_0SDk5z7kFsl-O5hbkjv1uh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=945 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110030

>
>On Thu, Mar 27, 2025 at 11:40:36AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Add support for the second generation(HPA) Cadence PCIe endpoint
>> controller by adding the required functions based on the HPA registers
>> and register bit definitions
>
>Add period.
>

Ok

>> @@ -93,7 +93,10 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc,
>u8 fn, u8 vfn,
>>  	 * for 64bit values.
>>  	 */
>>  	sz =3D 1ULL << fls64(sz - 1);
>> -	aperture =3D ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
>> +	/*
>> +	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
>> +	 */
>> +	aperture =3D ilog2(sz) - 7;
>
>Unclear exactly how this is related to HPA and whether it affects
>non-HPA.
>

Removed in the next patch series


>> @@ -121,7 +124,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc,
>u8 fn, u8 vfn,
>>  		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>>  	else
>>  		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
>> -	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
>> +	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
>
>Unclear what's going on here because this doesn't look specific to
>HPA.  Should this be a separate patch that fixes an existing defect?
>
>>  	if (vfn =3D=3D 0 || vfn =3D=3D 1) {
>>  		cfg =3D cdns_pcie_readl(pcie, reg);
>> @@ -158,7 +161,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc
>*epc, u8 fn, u8 vfn,
>>  		reg =3D CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>>  	else
>>  		reg =3D CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
>> -	b =3D (bar < BAR_4) ? bar : bar - BAR_4;
>> +	b =3D (bar < BAR_3) ? bar : bar - BAR_3;
>
>And here.

Removed in the next patch series and will be submitted as patch for bug fix

>
>> @@ -569,7 +572,11 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>>  	 * and can't be disabled anyway.
>>  	 */
>> -	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc-
>>function_num_map);
>> +	if (pcie->is_hpa)
>> +		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
>> +				     CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc-
>>function_num_map);
>> +	else
>> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc-
>>function_num_map);
>
>Sprinkling tests of "is_hpa" around is not very extensible.  When the
>next generation after HPA shows up, then it gets really messy.
>Sometimes generation-specific function pointers can make this simpler.
>

The "is_hpa" are used at very few places in the code where putting a genera=
tion specific
functions might be an overkill

>> +static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>> +				    struct pci_epf_bar *epf_bar)
>> +{
>> +	struct cdns_pcie_ep *ep =3D epc_get_drvdata(epc);
>> +	struct cdns_pcie_epf *epf =3D &ep->epf[fn];
>> +	struct cdns_pcie *pcie =3D &ep->pcie;
>> +	dma_addr_t bar_phys =3D epf_bar->phys_addr;
>> +	enum pci_barno bar =3D epf_bar->barno;
>> +	int flags =3D epf_bar->flags;
>> +	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
>> +	u64 sz;
>> +
>> +	/*
>> +	 * BAR size is 2^(aperture + 7)
>> +	 */
>> +	sz =3D max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
>> +	/*
>
>Add blank line between code and comment.

Ok

>
>> +	 * roundup_pow_of_two() returns an unsigned long, which is not
>suited
>> +	 * for 64bit values.
>> +	 */
>> +	sz =3D 1ULL << fls64(sz - 1);
>> +	/*
>
>Again.  Check for other places in this series.
>
>> +	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
>> +	 */
>> +	aperture =3D ilog2(sz) - 7;

