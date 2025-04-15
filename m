Return-Path: <linux-pci+bounces-25895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1443A89068
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 02:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECCD1799F3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 00:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDD74C98;
	Tue, 15 Apr 2025 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b="bzgCmXbz"
X-Original-To: linux-pci@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020098.outbound.protection.outlook.com [52.101.191.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DF1361;
	Tue, 15 Apr 2025 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744676650; cv=fail; b=GFYUJOUPRarjd6gpuO21b+PqfxW88Pi1dGcWulhBS29mNqfChOo1FZJi2WMEaE2xhrDpgkHzSiiR3Xfk4r8mJg8KYUU/q8hVbhT5SKT5jdnLJv++Po+5D1OC2E4Qw4yf02Vr+6qMDGz73MmEKTudVKGKmgl8lvluMT/uiudWeQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744676650; c=relaxed/simple;
	bh=lKqU+koBzS7uwNDvPTehFrXD2LqXEO1HOQoPlZAzO3E=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JZxZpltj6CKRebrEWlr6rCdlAxSlwkqOO0pk6awjVhgei0QuIuwzHxT3n8wGPRI5CoXdhZmOggOa7ncSEDFu89yB9Vj/sV6cCQFT0D7SWIrwNiiNUJrR835bjdjOa7fmlJclYuJ1qhAnbavetZAVul+h9QNL9nQmMUvosEXSzNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com; spf=pass smtp.mailfrom=raithlin.com; dkim=pass (1024-bit key) header.d=raithlin.onmicrosoft.com header.i=@raithlin.onmicrosoft.com header.b=bzgCmXbz; arc=fail smtp.client-ip=52.101.191.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raithlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raithlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhlNFDVXzEd+g4997uC13rlT+2Pan8axGxXOc/fsd53axPkFGO8O8nYQDZHX0JlZNog6TcfBMxyNRUhYmAYeJdNQul6YsyEGJD3lLl6sGrfsnBFjjrDtjLDySOvtsIIUf+LeibJ9mqIUkmrTiIHHeNP+JGpOHp25fRtMwTmg34Im0Lr9SMa+aRG6UWAlRfdKd9Wo8hlvKRJb2/pa4xbWZVLixDCvFrcwj6tmA2ReiKCK2nXaqJ+TWliJOU8b/rKU3Hdk++kjWoBAEYsVcdM8L9WF5ezKVXmepPaEl6C1pBp4f63NQMI20IJjlKlLdQaE0lL0WdH/csxN5dNC1erJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYTk1cpd/FxWyhuHhFhxdk+kjFdabhXt9esTl0FRiRI=;
 b=pzujbiTc10kbd9cjNRH19JWqrlh85xvHoAdvgafJgdvdMR7yohSf/Zkc8ri4NktPPO71vim8rbw4orHohXD7UcrnTavXeBqA/rzXNdVjyD5+zWyjoiATXK7YphgH+Z2WYE+k6v9jmF4+4oU7Hv3BdavXgFHsWG+Eqcyj/qN44IjVPq4GyPE9CrsWjMCGByPpmliqLh0745PFUKGjcfWIxGToTTAdkLJQOMa1m8yd/zVCMmsYz+rEctCrqKVFlbJ8FY2a33QBP6xnUYldAm8PZ8PkdB/tjCo5YDG4k1gE9ouhlIM6yoY2fCkJ7UULsZzHyod+sSB6Y+BREkk0rh4YOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raithlin.com; dmarc=pass action=none header.from=raithlin.com;
 dkim=pass header.d=raithlin.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raithlin.onmicrosoft.com; s=selector2-raithlin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYTk1cpd/FxWyhuHhFhxdk+kjFdabhXt9esTl0FRiRI=;
 b=bzgCmXbzRnyLFGsUHpCq4PQiM98+iXU7ppVMdRvY8kYz9Dpg7DLyqAX65NvFY3XAWvbIG2mFpZoGCivNqAVzIeK+xtnxTLIkDFF+kaERxw+FrCg9l4fEgWc5R85VHZdzw9Z/w+PE7IoJjQQF6dnA4UslkWH6+mlwXjCAAKi9N4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raithlin.com;
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68c)
 by YT2PPFF60D69038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::4a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 00:24:05 +0000
Received: from TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2671:57c7:e28d:98cd]) by TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::2671:57c7:e28d:98cd%8]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 00:24:05 +0000
Date: Mon, 14 Apr 2025 18:24:01 -0600
From: Stephen Bates <sbates@raithlin.com>
To: bhelgaas@google.com, logang@deltatee.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: sbates@raithlin.com
Subject: [PATCH] p2pdma: Whitelist the QEMU host bridge for x86_64
Message-ID: <Z_2nIRgPqp2JlT9m@MKMSTEBATES01.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:a03:333::22) To TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b08::68c)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TO1PPFC79171DBA:EE_|YT2PPFF60D69038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a281b8e-f9b5-4eaa-aab8-08dd7bb3d467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2NBalE1K0VHUjZld0ZaVGlYOTExcTBvS2tSUWNtV3pvc0h6MytMYlFJRjk0?=
 =?utf-8?B?NG1QYjVldmRjNXNZcnRWbzQwM3lJdFBBTjdhU2h0ZEUrMjBmeUlJNThCR1dT?=
 =?utf-8?B?TUlPVDByMWJuYkdOUmFnU1VZTDJGUFNyN1JzRzU1QU9nb01kc1loU2NkV2Jl?=
 =?utf-8?B?dTQvM1k5ZG1QeHBCQStpLzRoUmxzZFhMRnQwL2RsUnE4VXMzcTk3eCs0NFc5?=
 =?utf-8?B?T1lHd21IeDA0MHV2NUs2Zm5iaThxcUt3MjFMSGJvMkh4MFNrQ3ZWelltQTFy?=
 =?utf-8?B?WU1wYitqUm83WnoyZUI2NzJrOG5GZDl0a2pHbHZuaGxrcEdmbHlDVkFRRkZR?=
 =?utf-8?B?UXRGNWQrZTRzdHBqaVJGdnh3d0IzZHg1QzB3QU1tVW8xaFUwc0k5cmtsazh1?=
 =?utf-8?B?alM2SEZaZWhETmNDWlBnbitxVFNyZ0hML0pORTh3b2YxcE0rY256dVBKdXhT?=
 =?utf-8?B?OHNiamNnS3pid2w4eDVjWGpZQnY2WnY5a1RPRmM5S2ZxTjNqTSsySTdsdmJs?=
 =?utf-8?B?dmVyT3BKb29RRnk3NVNEcnhLR1R1MDhHYS9VVHRRVEMvVHhUUzArVERmeGZl?=
 =?utf-8?B?WFB0OW9VSmU3SjJ0cWMxRGN5NjM3WE53cTNVOUVrMkFxVFRzWUlGbGthSjls?=
 =?utf-8?B?NC8yaTVwcWRucUxKRHVLYy80Z0lubGRlUTFMZ0xiVDdPaitqa3V1dU1aeUcx?=
 =?utf-8?B?cjJVQm1OVXRiRk9YZXkzeDlNN2tXdEpDdnh1dWFrcGQza3RXVThubGlST3pZ?=
 =?utf-8?B?UFJSd1hOdmlPVzUyaVJBcHpVM2wvSm9naXR3QzE4b0RSU013eHM0UlE1VW5s?=
 =?utf-8?B?dngxVCt1Z1NtSXpsdjNLWWhXQndiQXFxdmhjWE93V0pBSkp1R0lLU1FuUnRC?=
 =?utf-8?B?Z3RSdUxXaUFTQkpOazdKZU8wRFZaRllPbmdzSnA4am1jZERaMmRuWFljbEVh?=
 =?utf-8?B?d1JaRFVsYkZVSGFFUHFLUEt3TDdadVBhSUdLTFJCd01yK2o5cUh1V2poMnFi?=
 =?utf-8?B?RG9PeVYyVWxKWXZvOFNnZVpTc1VXNHYvWXNQa3RNWkdBbU9DcjVwclJjMkZr?=
 =?utf-8?B?dXRpWENxNG5kakZ4U1pMK2hFdHVnUHg2K1VaVXdQY3FWMVQxVzhlYmZaSE0w?=
 =?utf-8?B?eE5aS1dCVVYvaUltTnhWSEJWMmNCRkZvVVZ2UEtjcHpWRUZlVGNFWTRCZGVH?=
 =?utf-8?B?MVdWcXpLUm5vdWhycHVyODdMTGNHaEdkSW0ra0N5eXlsRms2Vm9pOGNPejU4?=
 =?utf-8?B?Z2FwK2FJdFhxRzFpSUU5ck1UM0pNTEdkOTRWK2VscEVmc3lJRWdZSVl6OThX?=
 =?utf-8?B?MFl2TWFQbFBhYVQ5RlF2clhQTFlrSSt2VFB4clkxbjIzNElaTVVOY21wWFhW?=
 =?utf-8?B?RFl6YlFIZE5hSHlkRzlTdm42c1p1dGdIUmVFMzdVRnI5NVR3QW5QVlJXTmVZ?=
 =?utf-8?B?WERkd01pY3Nhc3ZJNk9ZYU84U3VMRGU1enlDblJRS2ZDWVpsRDVVM0pXNEFu?=
 =?utf-8?B?YVN6aklJRndWZi9jVThGK2M3aHNLbEM5Wm9LK201cVBxUFhsenhXbnR3MHJD?=
 =?utf-8?B?dzc0YnRab0V5c21GK29NS2FGdjRmcEc0bnYyZGlLQnlMM1Q3MmZRU3loNnpQ?=
 =?utf-8?B?VzBVdEZ3NGQxMHFwdFpVSTBUcDFzaUk5N0h4MW8wbFpPUVl0WTQ2aSt1MzUz?=
 =?utf-8?B?RzdUR2ZWTmQwdVB2YVNMSzBwUzRCVmMzOERzTThMNzczalNaZnd3WFRYNnVw?=
 =?utf-8?B?WVFaVlVQY1p3aFdoT201NHF0cDB1SXd6aDJxa3cwTDRjQjV1OGVOVzNndnZt?=
 =?utf-8?B?VXZBRU1SSVZLdy9uQ3phVGVmQ0VlTkxxTkFBaEF6NmlkaG1GSkxNWGovV2F5?=
 =?utf-8?B?OVJrbXo0akxvYVFVeEJiSW1Kd1VGNnpjTisrTjQ4ZHlnTHljbTk4NitDb05t?=
 =?utf-8?Q?WEtoa3X1igg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjFxYVV0bFVpQXNUbk12M0Z3QVg0VUZ6OThhRWxIenpxY3hZREkxcDArV3lw?=
 =?utf-8?B?d1RYUkJGV0hmb3Fsa1ZWVzN1alJwd2RFQkxPbExXSlNmdk5DU2NQcHFQT2Rh?=
 =?utf-8?B?T1Y1bVBvNW5UaUQ2d21xY1pxM1VJSzBzTVBlNzFtRC9PVHExTzdnS3Yydks2?=
 =?utf-8?B?SGVUNGhzenExYjhiUHQ5RTBlS2tQMG5hUDVyalk3TnhZZlVHTFhlcDJTdzkz?=
 =?utf-8?B?SU0wOGFLZU1hUkpYVVQwTlh6TlpEci9aTXZwNmlLK2xZNEJjZTN1Y0JDNTVK?=
 =?utf-8?B?THZwR1Q1ZkhJS1l1MHJSYVVJYVl2d3ZoZjRrMjZLMDFqV1d0ZVhBWVN4RmNl?=
 =?utf-8?B?Y2g5eTBYUHlDYlVGNnNSUXpITWZOeHRkTDFZczVyczF3VDNSbTFGQlBrUkdy?=
 =?utf-8?B?aFJqbHpENFFYTitqeHZycVlZTzQvWkt4QnFsV1NBYXF1NFlqeGZSWnRQMVpS?=
 =?utf-8?B?RmJEb3NIcXk2L0NsNzY5enljZXlTKzN1czhQTkJnNExQRUYwTDlRMVh1RkMr?=
 =?utf-8?B?aExpaGlKZWh5cHo5QTNNdTV1djlKdkVTZnFjdGp2dEUwT2RDTzRTejRxTG5v?=
 =?utf-8?B?K2ZZTWlGdkNkdHp3MmtRemRqQ01TblJSd2xJYjhxQ1p4N29CaTh4R0RIaEhw?=
 =?utf-8?B?ZjVWdnBPSkdWR3plTzYvMlBWU0pwQWRpMm1HQk5ZSDJGc3ZXaTNUZUpTeVlO?=
 =?utf-8?B?TGhmL2RZc2U5Tng4ZFRZeUxjaWZ6L1FETll3eDdZUVlxclNTeW5lQ1B4QnFw?=
 =?utf-8?B?OXVDc0NIN2xMSTZTYVY5cW1WUUQ4OVFKSVpmUk5NRUFCL3F4L1RPZ0M4OTRh?=
 =?utf-8?B?VXdoZHVJeUFFK2JIS1g3UU43dU9sUjZzVVB6UDQrQ2M0TTNlNDY2T1JCZnlu?=
 =?utf-8?B?OWY1UUx5Q0VjVHlQTndkTTY1SE84Y0k2cVUwUUVvZndQZk5UV3dvVWc3aTJi?=
 =?utf-8?B?T05YZE8zS1Jpcjd4amgyYnhTSTg2cXRxSUMxOVNZNlN4L3ZDeklZL29nb3FD?=
 =?utf-8?B?SlhIV01lTkU1Q0lOSDJ1MWdNV2hUS1JVOG9hUktDRXAwQkNMeFBmRHMyWVRW?=
 =?utf-8?B?dVRLeW5NVWVoTGNaUUczRHpnRDU3M1VDbThvdkdqQWZxQkFXc09VVEl6d1VI?=
 =?utf-8?B?OXdQZC9hejBpMVRLeWt2MS9yeVJWcGROL0pkR1UzSTJNOFJXd25wWEtsWUtU?=
 =?utf-8?B?c2pTQWJybzRpU1BpU25oM3BrcE1TdHp4WFVMTWFKVEtQbWJOWVB0WE9HUkFP?=
 =?utf-8?B?UWtBSUpNN0kxRkJJWjZLT0pOc0xlb0VqTjhDYVFLdTNwYXVHS1pqR1ZVc21E?=
 =?utf-8?B?dTRza29ISHNqTElqb2JGM2xXdEI4RzFJOEp6V0RrUjJ5NitjUjF2M1ZyWitl?=
 =?utf-8?B?NUFxTXJ5RlVZWkdUTS9XU1ZONjVaaC83V0xBQ3dmdlB6THAxUDdXM080enMr?=
 =?utf-8?B?V2MwTkthbUN3bTRZYWxCOGU1QmJVUW9UWCt3T3l5Z2dJdElTOXRta2JlaXdx?=
 =?utf-8?B?VFhGNGhyY1d3endZaTJ5V0hLclFVd2NiLzZhcEdXc1ZuaCswQWZYbG1KRUhU?=
 =?utf-8?B?L2FxcmIrd0Zyd2RzaGhYekdEekVXcFpCTlc3cmZ5MzlSdm42aCtrL3hEOVpJ?=
 =?utf-8?B?YW01TXkrUkFKUElEbE1ybklqN3hFc0Z6V2RhZzZNS1ZJdG5wVmpBTURVRCsr?=
 =?utf-8?B?ZHJ6Z0x3KzQ2QmNSeUxGT1kvMTZKb1lieHVMVFRReW5aY254WmVpVTFMM1FO?=
 =?utf-8?B?RVBROE1ZNGdydTVzUjEvMDIwU1ZaclpYSnhkRXp0R3lXYW1MUjh6YVo2TGly?=
 =?utf-8?B?M3NGZVY2QTl1Z052YS91bXJDR0prK1VwZ2FNZ1FTMnkwTWZTdTV1ZkRQSGdY?=
 =?utf-8?B?T09xUzNuM1JXQ3doajV2V1VJckVqWVZvY0o2d3A2eVRiUklRcFhWb3ZtbVhL?=
 =?utf-8?B?MFlJV3F2dVI1c0p3RzROYkhtV2NZTEp4MW1VbS9IS3ROejYvQ2lFR0pvcUlz?=
 =?utf-8?B?M1JQYklyM2RyWHNnZW8wQXlORVRoemNZVlh6UHNKWWJEczYyTDJNL2M5ZkFP?=
 =?utf-8?B?c2RyVEwrRXAwVzdCR2RuOXZPQ1NKdXNLYXpHUFVydUs1Slc0NXdjQ2plNU9E?=
 =?utf-8?Q?dyPG/PryLGDRyUbjPQGKr50Yw?=
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a281b8e-f9b5-4eaa-aab8-08dd7bb3d467
X-MS-Exchange-CrossTenant-AuthSource: TO1PPFC79171DBA.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 00:24:05.1160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geP+LqzrmoDboP0X1AJxyML2lO28/2TbKFg245Ic8hk2+/skf/N8zQoLajtJslJuTV3jLlN0Vrc4UaLqM4vI5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFF60D69038

It is useful to be able to develop and test p2pdma applications in
virtualized environments. Whitelist the QEMU PCI host bridge emulated
by the default QEMU system for x86_64.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 drivers/pci/p2pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0cb7e0aaba0e..03b41ee0cc72 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -442,6 +442,8 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_INTEL,	0x2033, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2020, 0},
 	{PCI_VENDOR_ID_INTEL,	0x09a2, 0},
+	/* QEMU Host Bridge */
+	{PCI_VENDOR_ID_INTEL,	0x29c0, 0},
 	{}
 };
 
-- 
2.43.0


-- 

Cheers

Stephen Bates, PhD.

