Return-Path: <linux-pci+bounces-27047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B19AA4C41
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7711C0615D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB025DB11;
	Wed, 30 Apr 2025 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1prpl3X"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE95925D526;
	Wed, 30 Apr 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017820; cv=fail; b=OJNZXI4qd4VAhk7Oo6gZcNnBdrkYI/Clh1blyX0r3I+HFBIfU2Aod5ddRe7xMOMi1BLrcOGoixrcZNPOOVqHcjK0SRZebbw3wc++g00H6wWYoLuonO5SUuaJYKEdWBKZMfPDGEiPus1TsUhgzNo0IPnG4jgIvMleDbReSf2HATE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017820; c=relaxed/simple;
	bh=8K7Sb6L+NCaEoD6NeTASLWUX2uuDYC32hBzqE43Y9lI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MfYBZiaX+uTHR0F8vgkkRPMzjUg8qakEA99gZGnoPk8fqlTNC/xNdLeblJQDo4WGrCelhhwfRCUS0TDQXCtym2t5gBy5ovZXOTgsmM0X3nZNNSbuag3nKRta+amZt+RB5aL/fZztqPbYY12p97K+5iKK5gZ/jzgFyqcJvdEk71U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1prpl3X; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tou/ugzvCY3+xbjhY1MIpkhQtEdktZAlia+Yv2co5SgJAhFJ9QE0d3KUgISoa8toKHwSimyT/HW8N+ABdqmGY3L4OWiz+/mBwBoLMa0foZmA1o6Cc/6qZnfOqPexqMSljgycj/Z7H2J/CBCP2H4E6AGRLonqd9MdzUe0EMI6srr1/iSumMYmmNSROKHmbnavjirl/N9vkFvj3m7atqVNAOhb33yx1JVMwoXatPcz83qmW4A1trul5wnPaR7rC23HRVCmWUGMRiRAHpqgEw12WJTmMa2107MIQHHek6hI8TdLuiuYjrgXPaW/NgpsTbcCZrdh8tAd2CrS9SNPN7q1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K7Sb6L+NCaEoD6NeTASLWUX2uuDYC32hBzqE43Y9lI=;
 b=WcAzgWMD4jx5R8T9Bl8SqTWrJupOBSV6FZE5f63cxwtlDMy6BLL+4f7IGm5vmpP46QhnZeLhrWUFCyfPRBhL3l8PODbu07mejGGgBUEv1ZamL8LfuHHY9AqK1jiAYHp9xHiQ5tmcZgODwaPkw9sBd6B928PXqdTjmlgqo0FrgngnEsA2d2PYJi0oh4jz/ppbmoE/k3n2KV/gDz2aYJKnrvPoqobplLlikBM1Co7sRUHvIJVkA3lGEs2bpS6dqi6YU/V2LCyHKx9jPEAXE5kye5Vg94B+xRDGiIuel2I0mM7DkPrCsqQS2DUW1OS7eqba+oEcfcy+QjfAe8fb6zqvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K7Sb6L+NCaEoD6NeTASLWUX2uuDYC32hBzqE43Y9lI=;
 b=X1prpl3X/uIf7tmVx7nDhJbcSLqi53GtsnqdvUgeLFmhSpW2xF5ebPnSpShlrHdHUy7O1Tg2fryy+Btoz79xNJ0WxaSTTzX+UIrV71JRdjxQljd1h0390FPN6ZTfYuaLzbPoO5zb71Ekt9waj0M7nnDUEW46d5aMU4Nr+dmPFYS3IkXKb3VtqND2bKXeKEbSsLVRgo/+N1rElK2lLY00urXT6dRiQcswdfPmGKj5WhEJcDcI+0KKUqBG50TexMHBfJcnSFmt681u3tDO48N3X3KXZj3umQZj66ZVf14rQwFNRUO7oFeBXdfc7oZNBKIPEC/IrKV9gIOieUIdoqK/Gg==
Received: from PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 12:56:50 +0000
Received: from PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6]) by PH7PR12MB8056.namprd12.prod.outlook.com
 ([fe80::5682:7bec:7be0:cbd6%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 12:56:49 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
CC: Danilo Krummrich <dakr@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, Zhi Wang <zhiw@nvidia.com>, Neo Jia
	<cjia@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Ben Skeggs
	<bskeggs@nvidia.com>, Andy Currid <ACurrid@nvidia.com>, Timur Tabi
	<ttabi@nvidia.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "gary@garyguo.net" <gary@garyguo.net>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
	"benno.lossin@proton.me" <benno.lossin@proton.me>, "a.hindborg@kernel.org"
	<a.hindborg@kernel.org>, "aliceryhl@google.com" <aliceryhl@google.com>,
	"tmgross@umich.edu" <tmgross@umich.edu>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Devres optimization with bound devices
Thread-Topic: [PATCH v2 0/3] Devres optimization with bound devices
Thread-Index: AQHbuEYV2v74EmdvhEaaPnhzF7af7bO7g3sAgACqpL4=
Date: Wed, 30 Apr 2025 12:56:49 +0000
Message-ID: <872604E6-9C11-4338-95F3-2ECF20AE3309@nvidia.com>
References: <20250428140137.468709-1-dakr@kernel.org>
 <D9JMO1USPIAB.3TBU959NO7P9M@nvidia.com>
In-Reply-To: <D9JMO1USPIAB.3TBU959NO7P9M@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8056:EE_|MN2PR12MB4190:EE_
x-ms-office365-filtering-correlation-id: e38a690b-9644-4b27-4ea2-08dd87e678ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1A2ZWVtZkp0WElCUUxNZzBVZmZLTkZlQXlIVHhZWS9paFhsY3lOMGtaaUxH?=
 =?utf-8?B?WG4xc1ZBWmNnL3Erd3BxL2dvRXArK1N1YjRoWnlRc3RkTkt0dWhLSTFHOEVv?=
 =?utf-8?B?UElrd3lFcXdmQ3l5U3FTMm11T3VseGFzODJOWFlSSmFDWkJzSDJ5MGpEdWdX?=
 =?utf-8?B?bHN4c01lU2trcUxPVVVrL3VybzdaN1NoZUd1cW9CbjNmYkJHdHFEOENMRWVW?=
 =?utf-8?B?cHhhTW5oS1pqOU5lWkhocU1IeThOUzZUQVBaZ09YSzF1UVpkd0tQODRxeE9i?=
 =?utf-8?B?dy9TWEQxRE80dmkvOFIvV0lHU3FVZHVFQ1AybGt5dzR2VUhQNm9IeHM1SUlV?=
 =?utf-8?B?Szd0OFJQRytvSlowaml3MXM5WEFyenlTeWljWk5ncmJ3aVJOYXRwdk1RL0VZ?=
 =?utf-8?B?MHBkRTFQeWhZTERyc1luejNlN0ZOWHplaWZFLzFNN1FJc1JlV24raUVHM0Jm?=
 =?utf-8?B?T3o2Zkp3MXczbGxVZGV0bWRlN2o0aVVsR2hSdzBnd0NXVE8zTXUyMUpsNGo1?=
 =?utf-8?B?em85QnFZSWpKb1YrazZEUDBPOUxLbEtDMC9RVXFlUkVWbDdHYVF1ekJIOE4y?=
 =?utf-8?B?cmVGWE5hSEIzdVhwNTBQb0J5eFNjUHNTWk84eU84M0YzekhkcVV1YzR2N1BQ?=
 =?utf-8?B?YlFkbGZTR3FucjNnWUhEa0MxTytQOWxTQmpZMVNMMTRMS2NneTI4Y0o4UW1S?=
 =?utf-8?B?ZTF2SnhGN2tzNkNIZ3dQc2pJZmNOTW1Hd2REV2F1ZVU1WWswY3hOZjNOb1NI?=
 =?utf-8?B?RjRBOWJXNzd5UXRyY0NtSWg5Z090TWJzMnFNc2tFNHJBR3cwcDRvb1RDSjdN?=
 =?utf-8?B?dGwrL3JjcWpYUnp6UDg3VlBXMnRTRVFiN21SNFdTWUpLcFZkaG8ybGF0MnMv?=
 =?utf-8?B?cFMvZkNzN3pNbnNWTFBtakU3ZjZFeUptbHB5NzdsRFZtMlhWeHpFVFZiQnda?=
 =?utf-8?B?aGo4a0dXOFkzL2UySEM0cHBzbWRVeHByZndxMFFYSGkwRHdVTEhjVVg1cy82?=
 =?utf-8?B?MlJNdU52cUNnUnhaTTlHMU93Q20yL2hPejhYbEt6bm1ZZ2ZjK0MxaFJNRVdM?=
 =?utf-8?B?MzR0eXdSVjhMNzE5SDEra2hDUHhhSXdmeEpYbE5HRDFlTUJsYlNwL1RkVW1i?=
 =?utf-8?B?SjcrdlZMRk9ERDNJYVQ3am5pcFdZNkQ2ZnAzNVhxTlRLUmVVQ1BHMzg0Kzd4?=
 =?utf-8?B?UVd4aWdLRUNYbGFYSitJcFNkWjJiKzYycFpxa2MzV2d4ektrK21OWWNLRC92?=
 =?utf-8?B?cDlUOXhVQmUyUkMwSTJMM0JER0VJNkk2azJESytqazM5enNoejFxYkF2bHkx?=
 =?utf-8?B?Q2U4QWFUU1dlTGtkQ2laU21qZjBTd1ptbmZ5Njg2WldjS1hLNWpsVVVGa1d0?=
 =?utf-8?B?dWNTRENVaHltaGVpeGpTQ1ZEcGFTSzFESDR5L1NEMkFLelZPSENSYXhDZ2Nk?=
 =?utf-8?B?aWp6T2c2eDFZNjB4eWxLWWVMZmU0MGNGaWZEZXpjc2pJdXZQbEhPeVBQOUdO?=
 =?utf-8?B?bjhMZVdyV215UnhEaE1yRVB5OWJidEFmUjZHc1VReFhaS3piL3RROW5SWXNz?=
 =?utf-8?B?amovdEpXd0FSK2svQnlnWVRPcHpoV081cTJHZ3NlT0FGRU9KbVNENU5pUHJx?=
 =?utf-8?B?a1FrQ0h0Y2FwYkgwYmRPUFNFMG0yalRmV1FKK3BieHJtTDF5SVJwMFZEWGlj?=
 =?utf-8?B?SlNscExMQmRLUXE5Q1E2dnlXSy9wVGt4RkUwZFhjU0xlZjNsZnZHNFJyck0v?=
 =?utf-8?B?QkwvSlMvUEFmSnRwNVRWNmlQbmd4ZlNDME9GeGxWMVMra2piY25QZnVsVUZn?=
 =?utf-8?B?OFlQMmdYb0dXY280ZlZJWGVkNGE1WDZSUS9mTGd0WFovWkF0ZVFiN2gzcWFR?=
 =?utf-8?B?ZnNvZGJYWDQyZVpva0xhSk1pbUNua2xJL3hFOEUyRlJNY3pPUS9BQlVnNGJt?=
 =?utf-8?B?cmtRL3VGUDE4Mmt0SjJxcmZsY2JlMldBZkxjdmE3c1ZUdEtickJvZ1IwQVlx?=
 =?utf-8?B?UEdXYjBPd3ZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clAxY0NLTzkzL3BaMFlKc1EvRFlWdjNFYmJ3UGQwSG01R0JvTXI2TEs4dHlq?=
 =?utf-8?B?YmFjbHRWZ3U4MkVTMjk5UWp2ZlVteUZ0QlhBSFRxbFJtc0t0WWdmZFVEdkFV?=
 =?utf-8?B?QnF6SDJhQnh0NjA0cU1aV1dXY2Exc2E4M3M3SXFxcTRPdDV6aWdNTDVldFNt?=
 =?utf-8?B?Y3UyckdTYmFRcXBIWFdXQ2dVUWFkQnJNOEZEZ1FneGlKRlRkM1FNVEpYckU1?=
 =?utf-8?B?SExWbUxQQWpURVhvT056QTdkMThIKzMzWTZnQlJiK2tNT2FWYU9UbXcrYWZS?=
 =?utf-8?B?dzVpSFlObjN3eUwxNjZmRVBBaDdiV0tYbFNuNjU0a1gzcEZHYTRFb05VQmxl?=
 =?utf-8?B?KzZuNzlMbVBPZk9BZTJmaC8yMGJVMnNzSnRTUWVlakZ5djhlZFpYbmJmSUZE?=
 =?utf-8?B?MkJ1Vng5ZkRsR2IyUnExT0hXZHpqNG5hcm4yYU5aQmQybGx6dzdxK2hjeHNn?=
 =?utf-8?B?RzdIKzB5OHEyb1g0dkgyK2dTZnF1VjVpWWhvYW56YWpWbnNKTzNYREwwZVYy?=
 =?utf-8?B?YVNiL3dCYm9HUUFXR2l3bXdURy9KT3h5TENPZ3ZrK2QvMitLSHZ5c2x3SVJS?=
 =?utf-8?B?ZmNtVGptMzhEb2M4eUo0QlNQS2Q1UlB0eVR2MzRWaDhveGJuTzlEUG5PSUds?=
 =?utf-8?B?aDNjTTVIeVJxSTJ4UFdOeGhhZ0hMTlV6SW9lTFBrQjdkQkFzeE9LQ0J0dWEx?=
 =?utf-8?B?Uk5mUW5TWml3aHJqVUFWV3A2RFFteXNxamFwNDJQY0xMMTNaSXR0Y294SlZ0?=
 =?utf-8?B?aHpwUUhUc1JJTjcvbG1tWm5GYVByMUxOaW9OSEFJTHVOeVVyUE05WlA2M2NW?=
 =?utf-8?B?M29rMDZ2MWxBb1E5eUpQM0VpN21FRDNkV3Bud1ZzU3ZHQU5aMVFRZVFUU0Q4?=
 =?utf-8?B?bE1CeWhtWktHUHR2U3IrcGVRb1VucjBSNURHaFJjTkFwTkxpc3BZSTUyVWx4?=
 =?utf-8?B?ZlZySWhscGY4cEtCbW9QV0oxUkJuUlRqb1U1TFRnZWxZdXR1Vm1uQ2ROSGNY?=
 =?utf-8?B?QlhFTE1VSVJ1dUQvRVV1T1pxU0tBelJoTDlaVUdmR1VFRDNQbDEzZGFsT2Vh?=
 =?utf-8?B?UVk3K2lPN2UxeGtYQmlvSnVNa2J5Y2VFUno3cHZlY2pUdjF5cTdDWTVja1Na?=
 =?utf-8?B?cnFGUHFLMS9DQXR3Ri9tUk5EeTNTWTZaWHRMaWp2ZXhuWDV5MVJsTWJtWVZB?=
 =?utf-8?B?ckI2Um90NVNFUWQ4dkUzb2h6b1BUSGpUaG5jRG9jdlBGNWNjLzVrV2VuMXlm?=
 =?utf-8?B?Y3U1ODdtaHNWNWxkZUhpelFCTXNtN0dDU3hYdUUwTldsV3YrUGFiY1NUMmQ4?=
 =?utf-8?B?SDJtcnNUSnlhbjlBaFNuWWt4czY5ZmFlU1VIUmxGK1BUVlB1M3ZKbUtyZjkv?=
 =?utf-8?B?QnQxZWVCM3dQRXhKWHdocTdxdXIwTm5WKzQvZXJXajZudXQ4UjdubDYwSW5O?=
 =?utf-8?B?cDFMQTVMVlFRSk04MnIwandkS1p2a3VjL2R0TENnbWZqUHRMSWR2QVZmcW14?=
 =?utf-8?B?anJSYnBlbk5mQkMzQTAyNEZ0MXlnU1U4ZlJhR28yQ3Z6RWM4NG1SR3FsWk1J?=
 =?utf-8?B?cWltTVIvRFR2Z2JaS2tkdjZDRzZ4MVVNc0JGL2NkQ1JBQ2RJZ3c5N1N1dkxP?=
 =?utf-8?B?aFZ3OFVmWWZHQUFQQlFKMG1RU2plNTZEQU5lTlRXcmZMclFZSlk3bWlnK2ho?=
 =?utf-8?B?NW1qR3ZQeGRMSE9ldFF3OGp6MmFyS1hmc3I1LytJV0d5Z0VlMWJoVVE3T1gv?=
 =?utf-8?B?MFJ6Q1RDdVdTK3I1dnhhVnpKSEtxUVVrdzRTNXV2RlhBWVZFS2VXN2lXa0dl?=
 =?utf-8?B?ME5nTjBseGRXNHJYQU95U0V6YUdZaHFpZm52OWJVaklNbWc3cjdvNWpYWDhk?=
 =?utf-8?B?T0pYS1RuWHJWQXQ4OWpZbThvcC9JL0wyRDFSYTJFRGtUdGI1SEU1WURWeFhN?=
 =?utf-8?B?ZGNpOFVhWTlLaTNhK1VHdmhRK3o2clc1MGdXd3dVY2RlOUVseDNRSXY3NCtN?=
 =?utf-8?B?MXdDanhvMGp0RzQ4RTYzNXQ2YzdJWk80SGFjalY0K1ZHVE1Qdjl0cXhibk9X?=
 =?utf-8?B?VldCNTdMODZRSVpYN0RuQnhnVE1YLzBKaGVnNWQwNmxJWFFKd1VWeEJzMjBF?=
 =?utf-8?Q?7fQGmzVL99NWEqBNSHU+xX6ZO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38a690b-9644-4b27-4ea2-08dd87e678ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 12:56:49.2955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPudXdz+jcc+6JhS9JrHwWlCJDpHl+/N/ICsuBbizG0orsAzA0/QRQQOVZhdMLZbyUZz8Jy4yhP44cjmWRVWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

DQoNCj4gT24gQXByIDI5LCAyMDI1LCBhdCAxMDo0NuKAr1BNLCBBbGV4YW5kcmUgQ291cmJvdCA8
YWNvdXJib3RAbnZpZGlhLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24gQXByIDI4LCAyMDI1
IGF0IDExOjAwIFBNIEpTVCwgRGFuaWxvIEtydW1tcmljaCB3cm90ZToNCj4+IFRoaXMgcGF0Y2gg
c2VyaWVzIGltcGxlbWVudHMgYSBkaXJlY3QgYWNjZXNzb3IgZm9yIHRoZSBkYXRhIHN0b3JlZCB3
aXRoaW4NCj4+IGEgRGV2cmVzIGNvbnRhaW5lciBmb3IgY2FzZXMgd2hlcmUgd2UgY2FuIHByb3Zl
IHRoYXQgd2Ugb3duIGEgcmVmZXJlbmNlDQo+PiB0byBhIERldmljZTxCb3VuZD4gKGkuZS4gYSBi
b3VuZCBkZXZpY2UpIG9mIHRoZSBzYW1lIGRldmljZSB0aGF0IHdhcyB1c2VkDQo+PiB0byBjcmVh
dGUgdGhlIGNvcnJlc3BvbmRpbmcgRGV2cmVzIGNvbnRhaW5lci4NCj4+IA0KPj4gVXN1YWxseSwg
d2hlbiBhY2Nlc3NpbmcgdGhlIGRhdGEgc3RvcmVkIHdpdGhpbiBhIERldnJlcyBjb250YWluZXIs
IGl0IGlzDQo+PiBub3QgY2xlYXIgd2hldGhlciB0aGUgZGF0YSBoYXMgYmVlbiByZXZva2VkIGFs
cmVhZHkgZHVlIHRvIHRoZSBkZXZpY2UNCj4+IGJlaW5nIHVuYm91bmQgYW5kLCBoZW5jZSwgd2Ug
aGF2ZSB0byB0cnkgd2hldGhlciB0aGUgYWNjZXNzIGlzIHBvc3NpYmxlDQo+PiBhbmQgc3Vic2Vx
dWVudGx5IGtlZXAgaG9sZGluZyB0aGUgUkNVIHJlYWQgbG9jayBmb3IgdGhlIGR1cmF0aW9uIG9m
IHRoZQ0KPj4gYWNjZXNzLg0KPj4gDQo+PiBIb3dldmVyLCB3aGVuIHdlIGNhbiBwcm92ZSB0aGF0
IHdlIGhvbGQgYSByZWZlcmVuY2UgdG8gRGV2aWNlPEJvdW5kPg0KPj4gbWF0Y2hpbmcgdGhlIGRl
dmljZSB0aGUgRGV2cmVzIGNvbnRhaW5lciBoYXMgYmVlbiBjcmVhdGVkIHdpdGgsIHdlIGNhbg0K
Pj4gZ3VhcmFudGVlIHRoYXQgdGhlIGRldmljZSBpcyBub3QgdW5ib3VuZCBmb3IgdGhlIGR1cmF0
aW9uIG9mIHRoZQ0KPj4gbGlmZXRpbWUgb2YgdGhlIERldmljZTxCb3VuZD4gcmVmZXJlbmNlIGFu
ZCwgaGVuY2UsIGl0IGlzIG5vdCBwb3NzaWJsZQ0KPj4gZm9yIHRoZSBkYXRhIHdpdGhpbiB0aGUg
RGV2cmVzIGNvbnRhaW5lciB0byBiZSByZXZva2VkLg0KPj4gDQo+PiBUaGVyZWZvcmUsIGluIHRo
aXMgY2FzZSwgd2UgY2FuIGJ5cGFzcyB0aGUgYXRvbWljIGNoZWNrIGFuZCB0aGUgUkNVIHJlYWQN
Cj4+IGxvY2ssIHdoaWNoIGlzIGEgZ3JlYXQgb3B0aW1pemF0aW9uIGFuZCBzaW1wbGlmaWNhdGlv
biBmb3IgZHJpdmVycy4NCj4gDQo+IFRoYW5rcywgdGhpcyByZW1vdmVzIG9uZSBvZiBteSBwYWlu
IHBvaW50cyB3aXRoIHRoZSB3YXkgcmV2b2NhYmxlDQo+IHJlc291cmNlcyB3ZXJlIGFjY2Vzc2Vk
IGFuZCB3aWxsIGFsbG93IHRvIHdyaXRlIGRyaXZlcnMgaW4gYSBtdWNoIG1vcmUNCj4gbmF0dXJh
bCB3YXkuDQo+IA0KPiBGV0lXLCB0aGUgc2VyaWVzDQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleGFu
ZHJlIENvdXJib3QgPGFjb3VyYm90QG52aWRpYS5jb20+DQoNCk5pY2UsIEkgbGlrZSBpdC4gUXVp
dGUgYSByZWFkYWJpbGl0eSBpbXByb3ZlbWVudCB0b28NCm9uIHRoZSBjYWxsZXIgc2lkZSENCg0K
UmV2aWV3ZWQtYnk6IEpvZWwgRmVybmFuZGVzIDxqb2VsYWduZWxmQG52aWRpYS5jb20+DQoNClRo
YW5rcy4NCg0KDQoNCg==

