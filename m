Return-Path: <linux-pci+bounces-38237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E16BDF591
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84514F9A73
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FD62DAFD7;
	Wed, 15 Oct 2025 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ckGsthPf"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82E2FE079;
	Wed, 15 Oct 2025 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760542079; cv=fail; b=DCDS4igWycktJNmlzKqxnog13iac5eqHwHk5c3ie9J3mKUfLLlpdws8qAyKdJLuSJEixDW5USP4lLNQcId6OItRmcO6+iGrJokQ46l/In8L5GkaUZ69q2er+qSda9Wd8v1EQSvK6XgQBoH5TG/lYuSQ4cGuljM2396+X3tJYW7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760542079; c=relaxed/simple;
	bh=r6ns8gA5dVzj7cxbi57O2UUNci+ulCXDLc3ggV07Usk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DJhMf5FL5z0VJcYkdVGUZa32J7LaK1HHe2jKTakf88aCZL/wVXhkxUusHqrNtA+2AcyfbRC6GCjwASPI7Kh/ic1j0Wx+3vIjYq2ZCQ6VQWaGCJ2akkMGOYg9RUKMBM/v8iJJJUlyy9CrAPfeCymEeUiC3sXNcutgBeclYd6MjwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ckGsthPf; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyQKk91mJGSGWW6FdGNWKu/UYlPitb0IGXKjmr7aaIZL2qM3Pnw10Ucfc+xwXjUl6ViU2f6BvOdUXNBW9XbGljH/o2amh6MVbndSGE1lWO5v462+Df+lio48bKc1ovvUKjy8jIxeYYA9IbkV5m00WyjoCHPo3LPYkVythOuSxq0q5npKi2RTlv5r+cVmvu2vyDkh2Q1DeXuDPkwgsplQsMPaeCVFcz5aCqWzxFlDNXZtAYgwU3LyqI+X4xUf97XasyvQ19Foh4omAZX6hWatanlarQDSDDnFckSuHS3CWY6bG7st0w7nQTculud8GbXlSgwyrv8r88bvuz6cU2nNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG+oFqeA6XxM+o0H9V/VL3px4cByIkzFClpvL6poNro=;
 b=XhB++pb3XTQp7USs121gYJGvT+bU+fH7L+/8IRtTDU6caTcgaVRjGXscNlb3cdFvIXiRbFsbkE2QykAvD0SE3wm9kJLJEl/BbB9BwOtiwOEOVt6qMmSnX82VMwzv0mzVK39YExnOKgGgJdTTfuOOfZQ3seN5ktAxNBeBw4A330ehGNs54NspmgwVXChg9yTSwNonMJjekuxTVdZsnOCV1SYqHYG/RzF/6SRjqa/dX54MNH16b6JkWW55HjUILQmHei74o+HTTsmaS6mdK2p4HrxIYOGCnVxoT5I8eUQ3RwLexsSUBdK9ajNz9z1v+c5KdASppPBXjPfPTgSvcZgF7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG+oFqeA6XxM+o0H9V/VL3px4cByIkzFClpvL6poNro=;
 b=ckGsthPfhnos+fVKqWRueb5yUf0iyJHVQVl4GIVDoG107vCKJeVm4syvSvohIRxUSHq3S/beIPihFzUGMFF8eiaTEYGLZ/g9NWpAeBAf9JRIXjJfqTyf9JAh+dUmeLUFsE+++xcPdVh0QXK+2cO4ZwbNl345lOjKU3frU2TP0JTzW64oJlvIoNc0f68i+er2BBRm17qxG0B4g4ieqgki0t6+0eq59KnPAvoT4bxLWKBnBKReSvltWzkkUcXdwlLzt8kd2ffi6bQREu6bEupdTYT9+xdOQwoPAjmRIh/EeqZWCm0kWiAOsuc6hhk+96nANVJQ0ujRyL9As2StzkLlIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 15:27:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 15:27:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 11:27:29 -0400
Subject: [PATCH v6 2/4] PCI: endpoint: Add helper function
 pci_epf_get_bar_required_size()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251015-vntb_msi_doorbell-v6-2-9230298b1910@nxp.com>
References: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
In-Reply-To: <20251015-vntb_msi_doorbell-v6-0-9230298b1910@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760542064; l=4440;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r6ns8gA5dVzj7cxbi57O2UUNci+ulCXDLc3ggV07Usk=;
 b=84JeZlR5zRzoJOLcwOjJ9k0ALaCeWsBkLTGnZV+HGpoDznfGFUGh0hhjZZHNl+9AimI8nPejG
 GxKqFor9127BWZ3Juy7Gb9OPdqVYUgYAfXLEt/7ExNm8fn/aTfFaThl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM0PR04MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 9731deb4-0e6f-4fe4-fa95-08de0bff6934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEhsbnJZMXlja1ZQRmRFSzk5RnE2dFh2emRnaFl6T1VROWZzaldkYnJSUHg5?=
 =?utf-8?B?UEY0MEF6KzJIS3NOSXZBSVdIS3pFWlZBOG5SV1VZOE5hVis3TDlIU0JGdUJ2?=
 =?utf-8?B?R0QrSFVxZWx5UHpyR1lFMU9BSDdFbUJsSlhoajZJTkRSUUpBYnVrU1h0SytP?=
 =?utf-8?B?ajJ1b0lsSkh5TXRhYTFuYnlLRXRXcnN5SGNuN2p3NFJJdFNiTlI0YVRWYVc0?=
 =?utf-8?B?MW1ya2l3SGhET1dMVVRqMTRIaDVwNW5kSEI3OVh5UktFVHduSDBBdkNmaUxw?=
 =?utf-8?B?MXoxeXZiczYxUG81Lzk4MWxveU1mbCs2UUJnL1ZVd2l6R3VUL05XTnVaaHhO?=
 =?utf-8?B?WTMwdkdldk96ZEVFK1V1c1lTTWRaUkcwRXp1WnQ0QXR4azV3bEhTMW9UK0Vk?=
 =?utf-8?B?LzRkczdKT0lldXg5TkdETTA4N1NwRVkwWURGeWFFOWxvS0JtaXBIeFNZdGN0?=
 =?utf-8?B?REdvTXBYQWV3bnZhdDNCOVZNZW1FblN5KzZaT3NOZm9jazc1QmpzTWlaQk95?=
 =?utf-8?B?K0Y5dlRsTVZUbTRjRnRZTFBES2JaTldMOXVjaGN6VHhvNTJMNjZFeU9zbm9P?=
 =?utf-8?B?VTVscEt0Q0JaOGwrTE1Na28wWi8rUDA0ME01NHFBbFhtQzN2RUdEOGdxRFZQ?=
 =?utf-8?B?VTg5WmpmbGZWUXdveExsRk9mZ0pReGpLV3p0ampBWjhGRSsrZ0FRYkRKclJG?=
 =?utf-8?B?T0FhQzlYVldzbnlIRWpMWjdtV1lGOXBPSEVxTkcwZDlxY1krWFRsUUh2UFFB?=
 =?utf-8?B?S0VFSmNBblorMEplTE1ZSDkyVENqVERTeXhydUFGblhLNDc1WjRRN1ZhN0Ji?=
 =?utf-8?B?NWhhWmI5cWU2WDBqb1FvQlN4SVovRFptcnNvTWtKMHRMc2FFUkd2d1VPMm9S?=
 =?utf-8?B?WVRJOXRDMHcxemlaMm9YSjFWcENIUXBIbkJxL3l2STBNb3MwcGJBSEhYT0dW?=
 =?utf-8?B?ejkrTmhaUGdNeUpOV3lTQUFnREEvSnRoR0pEU2VYU0dCcnRZTFRuVmZTSjY4?=
 =?utf-8?B?S3NZOXZlRUV6ZldYY0Y2aU5Cb0thVGlsZkZoUXQ4UFR0TWhqQ05ZTFFxcm1q?=
 =?utf-8?B?MHp5WTArQWhzYWNya2Mzd3huQlNIQnhhcFkvbW41ZG1QaEdNdzhITTk2YnpT?=
 =?utf-8?B?M0E3ZkNtZXhFamJRV05Tb3lsUXBXa2ZlQ0FEYjlYYmtkdnduRkpwOW1pZ1Ns?=
 =?utf-8?B?b05sSTBCaWRIYXJwWmt1eGkwM0dpNHBZM3djSFFHU1JaUkVVSXFRRVJiTy9r?=
 =?utf-8?B?TmhaWk1TVnUwWk83TmhnL2JReUpmaTdhM0t3T2ROSXRJMHcyQkxpWUdnM3V2?=
 =?utf-8?B?ZFErbXFDYjFROFMrYXlVaEZtZXdMa0MyOElIU1I0eVd3TmFndWdmYkk3SytM?=
 =?utf-8?B?Ry95K1dsL3lIb244bzVEQjNkczFZYURRMmw0d1B6WlNCb2ZnUE4yNHBMYW5N?=
 =?utf-8?B?OWlITlNLcHJYOGMxUHdqRDQrZmwwM2JsdzIwUnhHcXRXUnRnOUhSN1ZSc0J6?=
 =?utf-8?B?eldtZi9YM3ZFY0RUZlhld1pLWVVxVkpEOHYwakk1VEZWTFN3Z2hlUktpKzl4?=
 =?utf-8?B?blI1bWJVR0Y0djdRa3lOOS9aWDd5UGVpaDJjUmtRdEwxZ0IvY2pMS0FEYkI5?=
 =?utf-8?B?b3ZLbUIxNDFJWUxGWDBPSE0yeXBoZko3MGE1bkJjclVxQTJUU1hKL3M1SjJS?=
 =?utf-8?B?Wktyci8xSmpsR1hrd29pY2NWbGR5ekF4TlF0NHBUUnd3K0VWK2RhN25pOGFY?=
 =?utf-8?B?TkJ3N3VJTko0Z3I4aWxsK3NvQUFpcGFLNFJMSzEzd3pXbGk5aGYzWXZrT21h?=
 =?utf-8?B?SUNENm1TVENSNGRMWThxdkcvNkJTL0dGZndmMk52YXVVR3RaN3grdE1pbWxE?=
 =?utf-8?B?d2ZCdi8yYzdBaHdKQmZyakxVbFFrRStMM1hiVzBMVllQSGY5N1p6TVR2Q3I0?=
 =?utf-8?B?SDVyRTQ3Y28zcEQ1RlFVd0dlRlc4cDFrdEppS3JQbnVramRoUHFvSXVlajN2?=
 =?utf-8?B?RFI3Vis0ZEJQZk5KSnJBZmVwdGVubm9XQWpXckpWaVJvaCt6b2gySXpLTnpt?=
 =?utf-8?Q?lfsNao?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ellHK05FUTJSYUlsSGdqaFEzeHkyeTJ6NU9FaDI0eEVEUUZzQ0FhOHVIRzlo?=
 =?utf-8?B?Zmp2UTFKQUdaYTFaYUYwYTlMd3FqTmdOZG9CZ3U5VGJudkRQUk9hOTVZNDlK?=
 =?utf-8?B?SVM4M3owNmQvWExTd2tGRzl0U3c4Q2d6ODZBNzF5cVRQVGtPYXFyQm1qZ3hE?=
 =?utf-8?B?anlUM2RyL1hqNjJJcjNOWUxmNEhPc1JpL0VxVEtneHNDdjdqSmJ1L0VudnQ0?=
 =?utf-8?B?OXJvdlFUZ1U4MEN5MDRhU003VkFLTjFjM3BoZmhySTNNSVJZTW1uQmZwMFJV?=
 =?utf-8?B?U3FKVkJtZ1Y2Rm40OXNOL3NlN3A5cEhqNDhjaWVhMHBCZlA4NmZnejFVM2FU?=
 =?utf-8?B?WHNxOXVZV0lvUjFrVTZGNVAxeVJhL1BIa0dKYWJtTlZDZ09lN1pzTXh3SkY2?=
 =?utf-8?B?aEVScFRWZmdtNGxvZUFhVGJsaHZsa1VSL2dUOTZuNkRrRXdvc2tuMFBHQmwv?=
 =?utf-8?B?cWtyOS9iY2NQcC9GSUtoY00wN29CZlgxOG9VMWVXYS9SbTlpczF6YmVSWHh3?=
 =?utf-8?B?UFlMNXFMRlpIWWpPYUpGSWdpdXpmbTdiZEVmaHd1Y2JsemVGM2tjaHdkY2xy?=
 =?utf-8?B?SnVKWUpISitXOWNrRXA1Wm52SVhvekplam5nMThDQXN0YWhEWnJzV1l2S25P?=
 =?utf-8?B?aG5mTnErck9BMGI0Szd3dWhobWsxTFNYenllZUtid0RQV2dqZ2ErU25lU0hY?=
 =?utf-8?B?YXY2WFE4a1N2NkkzMG9lcXNMWlRUOHN5MHRETXRqNHM1NURrSzBpaDBySVZH?=
 =?utf-8?B?UzVGeTR0cVdDOThoQXVib1RnU0pUN1Mza2ZMenRFbFFLQ2ZOb0tUMHpDUmVT?=
 =?utf-8?B?aytlbm5vVnk3ZHh1Ny9hN21tZURlRjdBQlFPenBMeTVSSTFYNVJGVWRWTC9q?=
 =?utf-8?B?elpHQXZKWmxNQlJTZU9mU01qbkdtdU10eHJZT042bWpuTCsvV2lQdGVPZFla?=
 =?utf-8?B?ckhZbHVjU2Z3MXhhUTNjdmlRRUFhTnF3T0pKZTFMenN0VlhwRWN6Y1NIK1FF?=
 =?utf-8?B?YmQwUGRNL0QzaHlGMnFaR05ta212R0dublJXWTdOWHo5VU1CK1hkemFMWUx2?=
 =?utf-8?B?NlZsVWhScmFCWWJTcE1JYm5XbDRVQVhzVWtkdXdWM0hxL3RKSVc2bkJNSjlK?=
 =?utf-8?B?clhqZlVRWlJmSTRkM1Z4T2Q5cC9rdlhyQVArMHg3YjJSbkNPY2I2bGtSUmNX?=
 =?utf-8?B?Z2dFSldpZkIxZW03UmozQnRwS29BMFVjdEtrQTVjWkVodGZkbTE5OEpRQ2VS?=
 =?utf-8?B?ZXRYOTg0emwwRkhYZGdpYnNxakF2YmhTUHNiNHh6L1N0RWE3OVphNGVucngv?=
 =?utf-8?B?bHFGTUF2eWlKNXRldHlJZDFZSDN1N3BmaVJocHhiSU5EdVM4NzRZazg3WWJw?=
 =?utf-8?B?Ykd5aDBOV0VQWjczUjQxUDFBdU5Valp2Y2dvSnRtNzMzSkw3STNPUTFWUXVI?=
 =?utf-8?B?a3Z3YUtVWU1ncmRYZmlDYVdZYUZJZ3BTeVpmMXpWQ3lOdjhScUhjd0liUndk?=
 =?utf-8?B?Z3VBcDVmc0Z1L25mZmR5MysyUDNXSDVjdjl6Q0VaMVB6dURoK2dlY0h5bkpP?=
 =?utf-8?B?K0ZITnM1dklJSWRxWHhNVFdwNWN2OEtUOTdXaG80OTUyMGYwWFkrWkxUaVcr?=
 =?utf-8?B?MGdPYVgzdFlpbU41bEZOcFAxd3JVUDVxeUEwZ3A0RWFHLzFIVm9iSE9pSUVC?=
 =?utf-8?B?S0xqZGtDQ2dQN3J0NTczZVVvemFmZnRTWUZCV01QMGoxY3JOZER0MDZRZitQ?=
 =?utf-8?B?Vm42TU1yQmJ5bi9aZXI3cXVCbGJVZUZZZEVtTnJibmZsWndtc3YvWnY0R21T?=
 =?utf-8?B?SytpWDh6T0FUOW5FamRRdk1RSTQvWFZFMHkyVE1sZ3R0T2VZYVlKQUdYRFhD?=
 =?utf-8?B?cCtVYlFvWjYvK0c1a1pqQ1FSZ2pqQi9pL3lIdm9ad3dsSUU3c2NyU3NKSG1I?=
 =?utf-8?B?ZmIyZnRwYU1zLzV0dm11bC9RbW9Xc2F2U0dTaXllYlJsWE1tKzc2SHdjZmYv?=
 =?utf-8?B?d0JCekNwa0hObkJtNFRuMGZLaUI5cThUY0VIa0VVc1BwMnNzcDZFVk53N1Yw?=
 =?utf-8?B?R2lXb2s2ZjRHc1hwSDUrRG9aaGN6MnFhQm4xNXJtODdZeks3Ukd5MDFPbllL?=
 =?utf-8?Q?tISIQWUCW8b+KwiRqDef8cW9F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9731deb4-0e6f-4fe4-fa95-08de0bff6934
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 15:27:54.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNyvXxvccHms51YyaLjMxWfrCgTr0jjzVfColfNPjQ+FFznyZimiaTPZ6fuTepxYUXrFUNaKlJR6HPMGsSSVrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993

Introduce pci_epf_get_bar_required_size() to retrieve the required BAR
size and memory size. Prepare for adding support to set an MMIO address to
a specific BAR.

Use two variables 'bar_size' and 'aligned_mem_size' to avoid confuse.

No functional changes.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v6
- update commit message by using bar_size
- collect Niklas Cassel reviewed-by tag

change in v5
- update commit message.

change in v4
- use size_t *bar_size as in/out arugment.

change in v3
- change return value to int.
- use two pointers return bar size aligned and memory start address aligned
- update comments about why need memory align size. Actually iATU require
start address match aligned requirement. Since kernel return align to
size's address.
- use two varible aligned_bar_size and aligned_mem_size to avoid confuse
use 'size'.

change in v2
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 75 +++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 214e3f6e6d0d5a216c3469b8ff47908414cd1286..38c4fd06e9693ceaa0c86f67090faa6e390425e1 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -208,6 +208,49 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
 }
 EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
 
+static int
+pci_epf_get_bar_required_size(struct pci_epf *epf, size_t *bar_size,
+			      size_t *aligned_mem_size,
+			      enum pci_barno bar,
+			      const struct pci_epc_features *epc_features,
+			      enum pci_epc_interface_type type)
+{
+	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
+	size_t align = epc_features->align;
+	size_t size = *bar_size;
+
+	if (size < 128)
+		size = 128;
+
+	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
+	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
+		size = SZ_1M;
+
+	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
+		if (size > bar_fixed_size) {
+			dev_err(&epf->dev,
+				"requested BAR size is larger than fixed size\n");
+			return -ENOMEM;
+		}
+		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
+	}
+
+	*bar_size = size;
+
+	/*
+	 * The EPC's BAR start address must meet alignment requirements. In most
+	 * cases, the alignment will match the BAR size. However, differences
+	 * can occur—for example, when the fixed BAR size (e.g., 128 bytes) is
+	 * smaller than the required alignment (e.g., 4 KB).
+	 */
+	*aligned_mem_size = align ? ALIGN(size, align) : size;
+
+	return 0;
+}
+
 /**
  * pci_epf_free_space() - free the allocated PCI EPF register space
  * @epf: the EPF device from whom to free the memory
@@ -264,40 +307,16 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type)
 {
-	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t mem_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
 	struct device *dev;
+	size_t mem_size;
 	void *space;
 
-	if (size < 128)
-		size = 128;
-
-	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
-	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
-		size = SZ_1M;
-
-	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
-		if (size > bar_fixed_size) {
-			dev_err(&epf->dev,
-				"requested BAR size is larger than fixed size\n");
-			return NULL;
-		}
-		size = bar_fixed_size;
-	} else {
-		/* BAR size must be power of two */
-		size = roundup_pow_of_two(size);
-	}
-
-	/*
-	 * Allocate enough memory to accommodate the iATU alignment
-	 * requirement.  In most cases, this will be the same as .size but
-	 * it might be different if, for example, the fixed size of a BAR
-	 * is smaller than align.
-	 */
-	mem_size = align ? ALIGN(size, align) : size;
+	if (pci_epf_get_bar_required_size(epf, &size, &mem_size, bar,
+					  epc_features, type))
+		return NULL;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;

-- 
2.34.1


