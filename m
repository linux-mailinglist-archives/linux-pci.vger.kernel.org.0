Return-Path: <linux-pci+bounces-15671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BDD9B757A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21E41F2159A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38BE149C6F;
	Thu, 31 Oct 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xuaW0mbK"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FC149E0E
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360242; cv=fail; b=DnPdNV9Tdb1So8UrLCCfTTbuHmaptsWQ2RINO7W1EeQ1aDWeh0PvSnFEZXqwHtd3JkRnsPJ0oysSzb1f4Jbtap5FAljN4B+euZgGwWfA4e5TwoQhrmt8UzWeeobQkg2nCzg9dXDFXgvOsrOFklx4UKp0ii3vBIV17WQ6wh0BqQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360242; c=relaxed/simple;
	bh=F4gIlAbD91BhNbG7lJXsWFHUVaPi4a2NwwYtU3X0vSw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kXALLqNeIziTSzDnyn+zpSRCf0bjXDH1UCYXSQFSexRrJugJFX3IbSddRMj9mgJ292iYofTtlygaKoxWbah52eBDMsCqGwBDQR1BJ25uns/Opl0JGivdyWjPspSN4/F/6AmCbfIptnCQKa/jMUB64oWDzFdkGiJABJphYGVr/Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xuaW0mbK; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730360239; x=1761896239;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=F4gIlAbD91BhNbG7lJXsWFHUVaPi4a2NwwYtU3X0vSw=;
  b=xuaW0mbKzxwEebRdm7gkEg+C60D8i58w0uNrmggkM2ZXBUrPYPA+HebW
   f4Bi7C43KqBJh49GrwZR7GAVuG//AaBxzcThgmjq7cpTCeqgE2VQoHFz1
   hkedmJ1LbgJI97QYkkhnCQVabH5c8l5OBf69uOirOvUL4ncS39TJkDH6u
   G9z1PwVVDYEszAcIfKynIHLPVHtsHTP2PZ/ZUypBK7GeHmz1b78jnRudV
   7PKXssqO+PAnX3xUt27CCcmGAYvKAImU0ut4Z+W/j53mVvLz4XO2/orGk
   3l0rfu3tQ6XmoIjDDi13w1jiNp6BgI1neP48YOL6jiUMfNAEo/jRg0yQa
   g==;
X-CSE-ConnectionGUID: z5wM47AJTv6BZPfJlv9Dow==
X-CSE-MsgGUID: KXf1MG9dRZG/hK04uBe65g==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="135561151"
X-IronPort-AV: E=Sophos;i="6.11,247,1725289200"; 
   d="scan'208";a="135561151"
Received: from mail-japanwestazlp17010003.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.3])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 16:37:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYLkM89Fo8dFDcqLc89DjExn0JN90GU+DNnCsUHByX2rEnh229slKTtH5ovLb2f1Kc+k9ebKBM/KzhToSdrVRsbK15zlI05oSjNFCmiCPDerTmU7ETH8XIfsnqHLFXgF2zzzrpqpp0EeWUlCPIyIQh3Ld8NzGkPQBB66nZQxGU1mXo9seFmqcR/xIxNucryj/kCyCt58Zvs5DjH7IzisUx72uhlSVNjPHDRga+PXnvH0/GhARHhd6DGivyFVJOM/SyotHlQccIXyqo8u7Il/3cwZBbK2mPpGKknn/j28VaUErHsmk+ojqfXPqSm8fqWSsHHhqrAYhizcJvLA+nDkXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxAu41jxNixXYPyAiNVGDAKOYrQhVyhc58mqgQwpa44=;
 b=MSedydqjoAxYk5yBP0ojzL8V8SvTlQj2PTC8SwCqf1fIsT1ZHQIpOady7kNul5RCZGcQRAKTQmTTT9dRRFFnez8ZxpLn6Gn4TydqBGlnJ42V62WRuJxiX+Ct032V8KX/oQlxcOBGEBYQVfMfSHZtgCcGew7ZLc/mzOHQ3ApDOYqmJOLwA5QzqHIzyNrKn1PGABcsDdN2bZ9PhzHMv1avtV4dO3GKxfRFNvxfcimn6dbOK0uV7Nk7a0tQthhj788QolpdK2nYERGe3vX4T/xzIKhgof7ZoEtMLBYXtZ9gpQNAAW46Hb5d/inFcINkUDdN2s/xLIu0wVZEIx3Rc3lWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TY4PR01MB13396.jpnprd01.prod.outlook.com (2603:1096:405:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:37:08 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:37:08 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v4] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v4] Export PBEC Data register into sysfs
Thread-Index: AQHbA+h74ei4/Wguf0W/KiuMbwib67KHLxfwgBmYG4A=
Date: Thu, 31 Oct 2024 07:37:08 +0000
Message-ID:
 <OSAPR01MB71823E85BFD00CB3FA5B6E50BA552@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
 <OSAPR01MB7182E3AA1B504E46608E2375BA452@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB7182E3AA1B504E46608E2375BA452@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=4364afd7-99cf-4dbd-afe8-dc8f674092f8;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-10-15T00:45:15Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TY4PR01MB13396:EE_
x-ms-office365-filtering-correlation-id: a3d3a108-f124-4f14-5eef-08dcf97ed328
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?c0hSRG96VnMrWEFLNDlQNDEvRGcxTm53bnNPUkhkdTgvOWZtd2lYOVdv?=
 =?iso-2022-jp?B?MkU2ZFlSZUtHdDZUQ0FJcVZieE52am9IN0hHVmY1cFo1UEFhTUp5SEds?=
 =?iso-2022-jp?B?U3dSQjB1N1lqU3hXckhucG9JZ1lUUmFnVnRMVDE4a2dONzNXZHUwUk5R?=
 =?iso-2022-jp?B?QVRSZGZ3SzZRdWVwTHgyUDQ2aTdFZWdoWExMb1FxWXBwOUxIeEM1dWdM?=
 =?iso-2022-jp?B?a3AybHdkbUdJODlKZ2pSd0QyV1gvcWtzblFheitZSTVrSlZCQk4zb1ht?=
 =?iso-2022-jp?B?T1libjFqRHFmdXhtNWZqSVZPQnpPN28zMGlrZUI5akZXOUpCVG9neGcw?=
 =?iso-2022-jp?B?VTNjLy8vMW00aWlGa20rSUh5ZVowN0p1VHU4Q1VYVFJkL010RmdobVlj?=
 =?iso-2022-jp?B?S1VNUGlUK3FjUDVBWnFkamRmdksvQzRZR3ZFL1NNSHR4MkovV2NhYkl0?=
 =?iso-2022-jp?B?b3E0cWJJOExkcm1OeFdUQzg1aDg5eGRoN0wxaUxLSjRncWNkTEpFRHZk?=
 =?iso-2022-jp?B?VXRKNG04TUtid3cweCtELzVCWjF3WDY3eGlVa0ZBZ1dyaVE2VUhHajF1?=
 =?iso-2022-jp?B?aU51dlJHTVJNTlFPUXVFYU53djZLeHBkVThlSmdOcEVwcHRYVEk3NjJJ?=
 =?iso-2022-jp?B?WSs0am5RWDlZODFtQ08vZmFKb0pvTUxNQlpkYXVvaTZoQVpGOVBjMGhq?=
 =?iso-2022-jp?B?bUN4eVg1eS9KdENTL1NYYkRlL2xzUEZBMjFNZ010YTRrYlFnbEZ5Qkd1?=
 =?iso-2022-jp?B?UitlY3FYRnlnVEhqVHd0S201cklSaWtlRGViU0NwMGhCYUtMbTBCM0FI?=
 =?iso-2022-jp?B?cVJadnBRMEpGL0t2OVVOb1VXRWtVTkNIK0w5ZkRQR0tpdlFUSEJSUFhX?=
 =?iso-2022-jp?B?endyM2d4MEFnVmM2VjBOQ1pXQWFjRHI0b1ZjTCtON0dXdkEyZExjT0tO?=
 =?iso-2022-jp?B?OUZaTzlwOTB5djlNTzRiQXFSTk5CdThaL0JKdFJTWkltcU9qeHJrSkx6?=
 =?iso-2022-jp?B?YTZqcStXUThCZnl5YzZNVmFYRVVIOGFlMTBNWjYralV6V2cwRHduZDhJ?=
 =?iso-2022-jp?B?cGdxWE9nYm1MVG93cUpubldyM29mNmVlRzBvRC9hRk1kaDlpeXBSWlRR?=
 =?iso-2022-jp?B?Nkt6UWZJa2VTYnMyQmJVS1drenJOYXpYVVJBUHowRHlUVWZyQk9YZDhz?=
 =?iso-2022-jp?B?b1VreEk1OXhraFBCdkVSUmxTM1pOb1FtK1hPLzZXS0FhZy9vMmNUbHhG?=
 =?iso-2022-jp?B?cktWQWd0c2NWbjA5enR0NWhxdktWWDRLTGlFSllKVmxZT2NTWmlyNDJT?=
 =?iso-2022-jp?B?WExBSFN2Z1FUcXJ2Lzd5NlJ4dDhaWWhJNHdkK1ZVR1ZTQkFGZlRrYTd6?=
 =?iso-2022-jp?B?bTFBWW5uRmx1RG9FYVE1RVpua1hPR2lmSzBYenhXMW85TlMwdUFvODBp?=
 =?iso-2022-jp?B?NmEvL05NVG13Wk14VmZSdEp4eVRCZVJMdDJsM3Y4bnA2VWNheHFUNEt4?=
 =?iso-2022-jp?B?SGtBbU8rU3JCc3lXZXZRQ3VOTk5EenhYQnRwK0JDZkZzWG9jTURIb3Nq?=
 =?iso-2022-jp?B?VHFWQXp3cDErRDlsZjlSL3J4aHdjNFZiOGs5dTBjdm1iemplZUlwbFRO?=
 =?iso-2022-jp?B?d0VQSG1GcFJrUGNHcFYzcnd1N2VXeHFsRm9LdXB4elRnbndKMVpKdkdT?=
 =?iso-2022-jp?B?TWZ1SWxpSVlpVTI4U3BNRFdSdEdxN0lGTWhXMXNZK1NGVXFuUm96bDlY?=
 =?iso-2022-jp?B?YVFHV2ZpWHVYWlg1WnIzVURpenA3ZWJMbUdiWWZ6NTZHZ09aQlR2NDQ3?=
 =?iso-2022-jp?B?Z3hPc3JwQW9vcEUzRlV1MWxLUlpkYWZOcTJIc1M0TVV2LzNhUmFCblZZ?=
 =?iso-2022-jp?B?bTM0aXd3NmI0RWY0TXdBVWRLODE2UUhkclNlR2JjbTF1QlI4YXNrRjBz?=
 =?iso-2022-jp?B?ZEJHTDFqSE9HZEtzc1FkUG5MMjhMRmlpUlE1TTlxUVZzVWhvYjdnN0Vt?=
 =?iso-2022-jp?B?R0oyVUQveW1zM09qVk5TaERRL081L3V1YVZNM2o1QkVlTzdyR2RTWkpH?=
 =?iso-2022-jp?B?blE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?R2s0ZVgyTVZmMnhSQnZUT1dBMzhza3Btcmt4bEF6V3kwbDhuUGF5YWRy?=
 =?iso-2022-jp?B?NWNSc3VsVUlaL3FmSENULzlHb0xucnRQekorQ3FVTHZ1VGErSmFJOEY2?=
 =?iso-2022-jp?B?TzQ2WW96REJIMlNmaFJ3dkRBRjB2clBGWG5lL05hVGRjNi8rcFZJUVBO?=
 =?iso-2022-jp?B?T1pETmxGVnFITHdXZnFWUTZ1NFRMQUg2Q0NKVjIyTTF1WDVFWEQ2VEZr?=
 =?iso-2022-jp?B?QlZaNmNHYVhOZzJkVDNIRE9oSHVVT3ZXV0pucWd2WmtnY0s4MWpTVjlX?=
 =?iso-2022-jp?B?YTB1d0krZlV2SkxwNUhEeE9MODE1b3FZaGVDdmRhZFlOb0k4ZzNnVUh5?=
 =?iso-2022-jp?B?MGp2V1BpdmxZRkpITmFWRzU4ektsSmIrRTZidUdpSUkxNHJZaDlVQ1BN?=
 =?iso-2022-jp?B?alQwVVA5QUFPRjZObkxxV2w5QnZHdmdjTFFEcHB5a1JBT0RqMXJaZ2N6?=
 =?iso-2022-jp?B?YTJmWkRxRk1rK2g4UEErcmJEL1pVN0hJaXJ3TEhTQ09RaVVpNDZSdXRH?=
 =?iso-2022-jp?B?OThMYmFLNzZBbGNHTU5xRnBVZkhibWhBYW1MOGJWWFRwNEdnNFpiajVy?=
 =?iso-2022-jp?B?VDBoR0ZZemhFbitYTDltMkhOMVh2TlJCcXNGendTVDBXUzI5Y0hXY3h0?=
 =?iso-2022-jp?B?VGVKQ0p5QnZNWTlMcEZoMHV0M0hvc0FBNmF0dENNcjMzeVkvWWZGcHMw?=
 =?iso-2022-jp?B?RERNd3VodVg4d0pldUoyNW03RnpGQ1dHS21xRGZTVk1QUm52VmVpSmQy?=
 =?iso-2022-jp?B?SGZnZEI1SWZuVnZnWnc1UEpDdmlXL3VSbnZEcjJUL09PYnRqU3JYSU5t?=
 =?iso-2022-jp?B?dHZ0aVdTbjJUODE2ZXVDVjVnWEp1VHdNK3VZQ01qdlVBSmtWSnNTei94?=
 =?iso-2022-jp?B?WmNJak5kSkNCUzg5WW00M1Mxck9qYmg5YVd4dVhRK0lyTkRVUWZIZTlD?=
 =?iso-2022-jp?B?TWV0WkxUQ1lYcXA5R0tSZjVEWkplYnhNTi82cXY1NEFtMVZPSnh3N0NZ?=
 =?iso-2022-jp?B?S3Vib2lpZVg5ZWd3ZytJeWxOOWJiR2RVVXBxa1ZNeWY4eWJGVTYvRmdF?=
 =?iso-2022-jp?B?dDZReWV3dSs5OCtqOHRxeUwyYTZlR0U3Z0cvc3BFODBsZ2dBY1BZQWxk?=
 =?iso-2022-jp?B?djB6WXE0TXJQVTA4RmxLVWVKVHZsMTZnTkZVUjFqRjM5Tlp3UnhRL2d3?=
 =?iso-2022-jp?B?UmZMaytSRXpHQjBOUDdrWUNCS1FiTk9WM2VMTnJuSmRrL0NOZlB6Mk1X?=
 =?iso-2022-jp?B?U0ZDSE9xYitOWHNRLy8zeExCRVN2c3FIcm80aUd4US9IUG8vcVF1WnRX?=
 =?iso-2022-jp?B?TTFTYzUwbkxoZ29JZ0VaUmtTSXgrSVFHdGo0Y0dxOU9pN0M5QWpkSmcz?=
 =?iso-2022-jp?B?ekYvSlRsazJUT3pITU01eW1OYUhFVUtmbmZPdHVGRC81YjdSeWNHaFhP?=
 =?iso-2022-jp?B?cUlxV3JYUnRvTXEySVpVYWx6RWNaOHZrUVBraFF2b1k3WE55ajgxOHEz?=
 =?iso-2022-jp?B?bU9Lb2xMWkpqbERaWmVtdDdTMFExSjdUU3lRb1VpZzNZbVB5SHE0N2xK?=
 =?iso-2022-jp?B?NFFkVmljQ0tVbXZvZnJjVmtoK1p6Yjl3MmU4MTNHcnBPQWtyR0ZWem5L?=
 =?iso-2022-jp?B?NTZPc2Mvc2NkNmFtY05ZNWREYWdPdm5CWXF1d3V6MCtCSG9zZmJ4ZSsw?=
 =?iso-2022-jp?B?a21QZnpFK2QvZ2lvc2NUdUIzZXlVMjgxWWxPYVk1TktiMWZMcXJiRGxl?=
 =?iso-2022-jp?B?QUxSaWxNZVRPSjI3TmdJSUZ3ZFQ4ZWI3UlEyTGJFaXIyMCtGYmduUzU2?=
 =?iso-2022-jp?B?WGlMN3ZhMXBKc21MdlZuTmVlRjRWMmN5WjdubGFwVWFjdTc1UklQYVgr?=
 =?iso-2022-jp?B?M0V4YUhsd29RWnhrdXdZV2xYWFpiNlUvUHc0L2ZKQ25FdlR0Vk9FWTh6?=
 =?iso-2022-jp?B?Y0VuNk9ESTJBKzlhcndXZ0k5QkN4Z25wVENrd0s0MnE5aTFoaVFXQUpa?=
 =?iso-2022-jp?B?V3R6d2VrbVIrbDFzTDVxQkljMVhld2lJc1RVSU90amJvdWZhTnlBZk1m?=
 =?iso-2022-jp?B?L3poeHp0dmhsUFprc0tEeVpERnNlSWduUFpJL3l3NjVyaTY5NEVadGxV?=
 =?iso-2022-jp?B?L292SkY3UEFrZFZsOENiTUZsTHVUQ2hUY3JvQStlSERRUk5aWjVPRHU4?=
 =?iso-2022-jp?B?TFpJcktQTWhRVk5KbjJhZWVYT3JlVVBscXF5VWt1S3pvVXA0bjRtQlNJ?=
 =?iso-2022-jp?B?VDR0c3hzR1dDUjcwK0JLWEI3N0VMVzBCeFdIaHZMeU1HR2MvQ3JFcm1V?=
 =?iso-2022-jp?B?Y0IzRkJUdklaNWhHbUlqSVYwbVFRc2RtaGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zeF6Dv6FWOdaMYBK9pHJLaZKESKobceSVHLPVxj0k7LJxy84sWDGvwct/vOM2y9C4Uc5IAbMAtPZCvBBoOBnZ0mQtEL3ESIS/g5FEH5OCVk/bR0gbB/gGbaIJUm3avlH386HFbG67tHGSxjZoug1DXjfWiod1O/dWrHnyux5TDh260I5C4Wg7T89qVSU0+0bRuibVU+zLU7xfB3Sg2q6CcSIugWim2Gcr99lpsX0I9vA37bJ9CEZAmtTkn+xw/PKt9td2Mv8r1pv3L68xQVmC0h9J66etrvB2A9zcFMaVany6Fd0h2CAJ0IWcdPTAfMBN/Tz/8/lFq6336UDCpVSnKBU/i8funGvw23iAeihtU2bLtl0krUDxFXGAoJhDt66Ws6f5/plTvRr7+KCJMdatK0xugibh8Y1uaAALz4ZyqLSLwyy1EgphjyxyjuLoRJWebb2ypXKQGHtDlnZ0DwGx2+bP5+80OJnD7LP0fGbNGQEHW81oebZVpk2oU8Ql9tM1v6dGbr8K5dygyzt5+rYgXZvH1AnrRqKiBKEBZG1IQrT8h/ir3TypZP03iu1mhMvlYk/SulFmPcsG9UCJKrQGGyjR2AA8yOIazCW6JyE4KOvYJ2x+REI3Wfag7OZDWqA
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d3a108-f124-4f14-5eef-08dcf97ed328
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:37:08.3136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bitV8ASwICKzFl+KsvAdF3IDInQGpuY4aHEDF8uboHHo/v0CFbNTliyR75cMy38xN8bbAgeMpxJv8U51Ss1bk3M2auekZzt/BO2ICPHOYSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13396

Gentle ping. Could you check this patch?

> Kobayashi, Daisuke wrote:
> > This proposal aims to add a feature that outputs PCIe device power
> > consumption information to sysfs.
> >
> > Add support for PBEC (Power Budgeting Extended Capability) output to
> > the PCIe driver. PBEC is defined in the PCIe specification(PCIe r6.0,
> > sec 7.8.1) and is a standard method for obtaining device power
> > consumption information.
> >
> > PCIe devices can significantly impact the overall power consumption of
> > a system. However, obtaining PCIe device power consumption information
> > has traditionally been difficult.
> >
> > The PBEC Data register changes depending on the value of the PBEC Data
> > Select register. To obtain all PBEC Data register values defined in
> > the device, obtain the value of the PBEC Data register while changing
> > the value of the PBEC Data Select register.
> >
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++
> >  drivers/pci/pci-sysfs.c                 | 28
> > +++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci
> > b/Documentation/ABI/testing/sysfs-bus-pci
> > index ecf47559f495..be1911d948ef 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -500,3 +500,20 @@ Description:
> >  		console drivers from the device.  Raw users of pci-sysfs
> >  		resourceN attributes must be terminated prior to resizing.
> >  		Success of the resizing operation is not guaranteed.
> > +
> > +What:		/sys/bus/pci/devices/.../power_budget
> > +Date:		September 2024
> > +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> > +Description:
> > +		This file provides information about the PCIe power budget
> > +		for the device. It is a read-only file that outputs the values
> > +		of the Power Budgeting Data Register for each power state as
> > a
> > +		series of 32-bit hexadecimal values. Each line represents a
> > +		single Power Budgeting Data register entry, containing the
> > +		power budget for a specific power state.
> > +
> > +		The specific interpretation of these values depends on the
> > +		device and the PCIe specification. Refer to the PCIe
> > +		specification for detailed information about the Power
> > +		Budgeting Data register, including the encoding	of power
> > +		states and the interpretation of Base Power and Data Scale.
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index
> > 2321fdfefd7d..c52814a33597 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev,
> > struct device_attribute *attr,  }  static DEVICE_ATTR_RO(resource);
> >
> > +static ssize_t power_budget_show(struct device *dev, struct
> > device_attribute *attr,
> > +			 char *buf)
> > +{
> > +	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +	size_t len =3D 0;
> > +	int i, pos;
> > +	u32 data;
> > +
> > +	pos =3D pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
> > +	if (!pos)
> > +		return -EINVAL;
> > +
> > +	for (i =3D 0; i < 0xff; i++) {
> > +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
> > +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA,
> > &data);
> > +		if (!data) {
> > +			if (len =3D=3D 0)
> > +				return -EINVAL;
> > +			break;
> > +		}
> > +		len +=3D sysfs_emit_at(buf, len, "%04x\n", data);
> > +	}
> > +
> > +	return len;
> > +}
> > +static DEVICE_ATTR_RO(power_budget);
> > +
> >  static ssize_t max_link_speed_show(struct device *dev,
> >  				   struct device_attribute *attr, char *buf)
> { @@ -629,6 +656,7
> > @@ static struct attribute *pcie_dev_attrs[] =3D {
> >  	&dev_attr_current_link_width.attr,
> >  	&dev_attr_max_link_width.attr,
> >  	&dev_attr_max_link_speed.attr,
> > +	&dev_attr_power_budget.attr,
> >  	NULL,
> >  };
> >
> > --
> > 2.45.0
>=20
> Dear reviews.
>=20
> Could you please take a look at the patch when you have time?
> Thank you for your time and consideration.

