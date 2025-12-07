Return-Path: <linux-pci+bounces-42743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52137CAB7FA
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 17:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF0C13019BB9
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE202D238A;
	Sun,  7 Dec 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqfxjWAb"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9E2D2481;
	Sun,  7 Dec 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765126628; cv=fail; b=oMMkxjKP2vD+zu574IKUYVQfPXd1yXTKzn+z7788K1OhnnOLLaBJuB1lQlneCVsuXIgm8hRAX0FwdWORXt089U3kLR7V9EZci2XnXZ1kJZDz9gYE6GyLKpldYveGV2uOnE96rkHjX73DMVVoxMD4jPugGaB5D6ebqhb8QwYv2hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765126628; c=relaxed/simple;
	bh=7Fl+8oh9oZyTP6u9Te45aqELpVpJbW15N6w+KMVPCH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tibU26bSny7LZyO/nKsnavCNF1zYJOdkzRp8t6sAFl8XhweEngQi7sSRezvXG08L9HqVOat2bfiau0Xvemq/+t/B/u8CcMV+NWNxxdV4gScLO7UhzjoG4Z8vmp6E0X7GslgAJhObBe+fzPWWDJbdJSrszTufXWd7gDk1nfdBUMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqfxjWAb; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etElZ43PJRU/+oQQcof73btiPrLM+CwH6hymr01rYbbHs2otu2QrjhaWEvJTb52vCoaf623WmiZX4Lr1feqFz3QOMo+4dwA7oCf5s2mk3tGsfNhmGP3hLUKI3ivsOHrDSfWnk8HP5LN5ISBWdWQOqb9CiCLLfku6v4mo3C1oOLIEpsdNackqe2FZ/b54saNIS6NMgcGSwcGF6ylUIf5Brm/bWguKf/1xW6xOBxyMSuUuxLUH483YhQvljv9IUPmAunMCaQ2M6Zq/2oAoYbgjzTubNZWku5G4eoXqnP4k6DK8sGO8lCcxHt8xVe9LzcorUv10Aat8Ds3uAPreAe8tJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Fl+8oh9oZyTP6u9Te45aqELpVpJbW15N6w+KMVPCH8=;
 b=iDdG9kmrdku974fPwTn/7WRFNL+WUbyKiGYHc83MozebVgAyWqgH5AKBI9vBfiXQcVD+OQmjODmlw4tV6cYJwAY+Fdp0rdsi6U3CO0el5hrtmk6qsCAnxxktlTu65KPK4D+lsxAGe4BmNZkQmoMD9L2fXvSyhuQdY8s0Ci6Y9q9bHIaihZ22jMUagGaWmlDWAoyzhWwJd7LfiVuIj4JJE9vXKcDEv/xTpLqo/rEtNYCbrGic9jT8UvAU5Uc6CMsdMlDZhbTTk50wSUQeCWueWqVNX9z2/5Sl6kd4ENv/IWy7f6Z7HedQXwfcJs6HD8UF9XOR/0Esb2L8YeJ0wKN1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Fl+8oh9oZyTP6u9Te45aqELpVpJbW15N6w+KMVPCH8=;
 b=ZqfxjWAbE2u6OhQHupF+gHrrfOydLlju491kTVDmA5mpO098iuUdI5HVIM5jSd/DHdnPYA1vnCpjjgE8vl7fHiLvteJgIMy+Nll3VQJPa+OKEFky/v4Pow5AQ7LcV+ou/Rv5oGtpgtz7Nz8sV1elwPqL3lQFm+q1eKtj+y0oq5C9Vt0sbn/D46C/IeZozXuAi2hzI/zYAKvtvN0LKUUXtlbc/eIjpykuvUPxlsQAUhPAHAI9oEwXf4df3Ngz5i2s5IRUHKXrQhy8E+XY/68grhTA3HhHwBp2kHZXQXemN7o77FmSA8R+WG/kU59C5R5E/9bedB9KWqq0GIjWZTw0eQ==
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sun, 7 Dec
 2025 16:57:01 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9388.013; Sun, 7 Dec 2025
 16:57:01 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Timur Tabi <ttabi@nvidia.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Zhi Wang
	<zhiw@nvidia.com>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, Kirti Wankhede <kwankhede@nvidia.com>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "markus.probst@posteo.de"
	<markus.probst@posteo.de>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, Neo
 Jia <cjia@nvidia.com>, "ojeda@kernel.org" <ojeda@kernel.org>, Aniket Agashe
	<aniketa@nvidia.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>, "lossin@kernel.org" <lossin@kernel.org>,
	"alex@shazbot.org" <alex@shazbot.org>, Surath Mitra <smitra@nvidia.com>, John
 Hubbard <jhubbard@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Alexandre
 Courbot <acourbot@nvidia.com>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	"zhiwang@kernel.org" <zhiwang@kernel.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "aliceryhl@google.com" <aliceryhl@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "gary@garyguo.net" <gary@garyguo.net>,
	"dakr@kernel.org" <dakr@kernel.org>
Subject: Re: [RFC 5/7] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is
 enabled
Thread-Topic: [RFC 5/7] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU is
 enabled
Thread-Index: AQHcZq3Gld7Mk9dKpE6SHpCx87lEdrUWVnAAgAARNzU=
Date: Sun, 7 Dec 2025 16:57:01 +0000
Message-ID: <26FAD9BC-9CFC-4BFE-9985-DD660BCD840A@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
	 <20251206124208.305963-6-zhiw@nvidia.com>
 <6c2e13d934c11170edba603fb88e8f2d67a2a049.camel@nvidia.com>
In-Reply-To: <6c2e13d934c11170edba603fb88e8f2d67a2a049.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8059:EE_|PH7PR12MB5685:EE_
x-ms-office365-filtering-correlation-id: 4f7e4314-efa5-41b5-f6de-08de35b1a437
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2p4bk5yMGFIQUQwYUl0N2J2THQ3WDYzclpOT2lpaGIyUUl3Q2lxeEx4NFov?=
 =?utf-8?B?NWRoNHl4ZlZlQ2x1ekhSaWFVWWpURkZzNHVQTFByK3JteTZhNWxyb3JnYzJz?=
 =?utf-8?B?d0dxYzN0M1hkSjVpeWVvK05Rc29xbDhUME1pUlNyNldvUCsvaFZTd1FnQzl5?=
 =?utf-8?B?VVNIYzhMZTJhWWFpbVh6cjV1NTBwbDY5YUQ3T1FBSzNETEdGL2w5Q3NoaXpj?=
 =?utf-8?B?S3hNUFU5NHJobm0ycGhXTzNrUWNuZ1Q3RGVWQnFKYWV4aFdUL1FFYUJ6T1ps?=
 =?utf-8?B?U2l3UzhOaGJJMFZoRlkzdHQ3S2JHR09VRk5iYnNzNldFT3FmWXl2OVdKY0ZT?=
 =?utf-8?B?MjNRTy9JN0VpZ3duejA1MW96eG9Qc3hQV2FFdlh1ME9XN3hnaDRyRk1RYy9T?=
 =?utf-8?B?bEd2blhsM0tNK3Yxbkt1TlFSclRJak9Hbnh5QVVtcE9EOGIxUDNYQTh3RWVC?=
 =?utf-8?B?dnNneVNxODBHcDZlSWg2OEo2QmJ5QXlQd3Y3OXVNZGRxanc4UkcxSmVSMEh1?=
 =?utf-8?B?QnRTN3FlSnE1dW5kdW9ENUVlVmpER0thR29SWWhTcXFFNUZnUU1hYWdMZ01N?=
 =?utf-8?B?bmJRcVFDVHZMUTBWcCt3cjRqblkvVUhXaU9QTit4K2g2UjdtakRXNXk0NzFH?=
 =?utf-8?B?WWVKRGF6VmN4Z2FWck9IekF5djNjaEY1T04vOTZROHJGN3FCcUFJZTkvVnJz?=
 =?utf-8?B?SWZ4UVJybGtvTEkxckN0eVlMU2g2MThzdlVPMFUzSHJhZkxOQno1ZjJlUXE4?=
 =?utf-8?B?TUFsNTlhVXBXTkUwNjF2UGZzSVkyU0lQQ1ExZjZCOUZlSjh2bitXemtacWpu?=
 =?utf-8?B?NFFMZnJtRGZDWjRVTE5MVnhYZEpNT0ljWk5rMjR6RnUrMTRiVjlVVmx5M2Zm?=
 =?utf-8?B?K29NZjg2NlZjOUZ6MW1YaDJBeU9ISktXNFUyRUJvUFRNZ2xyTUE3UmtyRk42?=
 =?utf-8?B?aWo5MUNTSDdrbWZaSzg1bzZhV2lmUFBiZzA1dERhZmxyTE5QdFJzRVRNSjM0?=
 =?utf-8?B?ZXRhdlIxZE9obi9UODNPaWlYWDVMZVNvcWxUaG5oRlVoWG9SRGVXOURCVE1x?=
 =?utf-8?B?SHhaVHNvTVBxSHA3QSsyMXFLTDlCZVBnYlFvOFdhSWxucnNmSWdOSFFBSjV5?=
 =?utf-8?B?UWhENHh6VXNuZnZiZFRUcUk2RVJzWTJXVDdIWDRINXdtS294MGI0dWIyQXhC?=
 =?utf-8?B?ZEZZL00vOVIxSkFGcFFvemdMTU0vQ3FFYjc0emNIckVpWWl0SENyWGVwTDZt?=
 =?utf-8?B?MFg3UWFXdWpMY1RPOGNQZjlvbVlDWjN5d0J2QURvcklwajFLa2tPajR4am16?=
 =?utf-8?B?TWkyYS81c0lTZ3JzUVZGeHhER2dDanVHeUlNaWE0aU1Jc25TaWp5N0tUMXAz?=
 =?utf-8?B?Mi8rRDVZUmpId21KS0VLTVd1RGh0S3d4Z1owcEptU1pSaU1wV3dDcmhqZk85?=
 =?utf-8?B?aDRDMlNVTlI2YUsyNWpVMkJRdi9XMmdOeXpkRHUvN29lTTg2MDZ3MmlCTFhn?=
 =?utf-8?B?NmpldysvanpKQm9zL1hXd1owa2kzRmlsWU1QaTJmTDFqYVd2M1E3Y2s5QnB4?=
 =?utf-8?B?YUQ0Q2dIaVpyUndWcmtVeU1rekpMS1UxY2FlcVpDNmRneW5Oc0E3SFZkMWRK?=
 =?utf-8?B?amw4NUhMSy8zNHhRb09TblJtV0xmZXY3T0MyT3FjT0VRTWR0K1R2NUhyNHdX?=
 =?utf-8?B?T3BoY3dRZkc2T1NSU2R4emRzRWZ0R0Yya1dZMjVGOU92SHJoUyswN2xlN1dU?=
 =?utf-8?B?a2drdnlaOGpWWlVFRXFwQlBlVm14WTBPZmNoQkZlb0JqRmFTU0NRbm9OelZw?=
 =?utf-8?B?TWtDT1V4Sk9PWnprT0VLT3c5OEhuV0xyaFJHVUE0MmRBNEFTcDN0RVlZUXUw?=
 =?utf-8?B?SEFWc05ObVkzYWhFUWlNY3pZTlY4b2g2TXlDVHh6bzRsL1VNWWdXa1VMZS95?=
 =?utf-8?B?cEI0OWs2L0ljTXhuelFGMTVCb0ZTcjdVZlZ0WkhZZ05YbzBlcCtLQmxZWVlQ?=
 =?utf-8?B?NTBqY3hEV0VGamc0UVBEOExFVFBsZU5RWTJKcU1VWi9uTHhIUEN0ZlFMVStT?=
 =?utf-8?Q?mfoeo3?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3VHRjdZOUNaNXdwZCs0eURCckxBOUtTUVNmZC9aNjJHUXdyZkRFemRuckpn?=
 =?utf-8?B?R2c3S3lycU9rbVZFUitqOEVFazFvTUZ0R1JrUW9OZnpvMzFTMGtvZW9wZkNk?=
 =?utf-8?B?RnRVRDlYZ0g4VVRyaFR3Wk1FV0g3dFBNUi9UMnFmRktHNVZRV25mU01lMnZY?=
 =?utf-8?B?WFZCNUZDWnJramNtL04wQ0tXNkFFZVFuTjZDYTlCOXpMcHdrWDlCT3ArWXc4?=
 =?utf-8?B?VHBpaHdRcTRpS1h5Vi9BM2JSbnpHWHZURXR1YnR4OUZXZUE5QXpBWTRmN2g5?=
 =?utf-8?B?dFJqMWp2V1hSYklHajVsZ3h6bk5TemJyWVpKUEZSdnpLWmFsQVBOSmZWQzlj?=
 =?utf-8?B?UXpXd0FLK0VTWGxRSUE3Mnp6eE9Pd0kwOTlxUzdMWm9nOENnLzdiZ2Evd0Jq?=
 =?utf-8?B?bDFsbXZSVWJubWkyUU9PWkE3cDdOUm5lS3creDl5enFOVGl1OGFWdEY3eVp5?=
 =?utf-8?B?WkZvZXdTMjFVaHpGYmlNR0Y4d1JlbWcyY0RqOEU1YWM4Y2VxSXJSUmFEYTBR?=
 =?utf-8?B?TVJXUDVSWk9PRWdacVBaNjYyVit5Ym5Sb1ZXem03R0ZGcWp0WlljYTU2NkMz?=
 =?utf-8?B?Z3oyUnFSSkxxZHh3a1lQR09oTkh1ZWtsQUlhcE5XSEJLNVpVS29ybytaaG5S?=
 =?utf-8?B?dmNEZVVOSXlWWWtkbVNNMW5DQTJOWTlKMnA5czNuMlpwRmNGMnhKU0g5L2ZW?=
 =?utf-8?B?bmlWaGZOd0FHOVd6djg3Vm11dU9RTkZSM2Jyd0NkbHd5bldGTTVxMDh4OWtH?=
 =?utf-8?B?ZDljclhBZnNpaEhXS203VG5HRWR3MTdud21vblN6YldDdUZoNjh0V0FVbE1E?=
 =?utf-8?B?aXJsVXhONHZBd2xPU3laTGtGUlBObDkvaXNmVXY1VXRaNU9DbXByaHV4cFB6?=
 =?utf-8?B?citEbzJZMWQwRFFRcHNNNUNndzRkODBuZ05iRmFNOFVqUUxrbEQydlVpcEU2?=
 =?utf-8?B?T1U0MEp2eGU0SEViaUR6RGF2akYwWGw2My8zYkszc1F4YWdDSnVDYStIZUE5?=
 =?utf-8?B?SG1yNi9TSlpMbFY2N2JtMmRNZFA5enpybUEzNEtScmRORXMvWTZuV0VzN01M?=
 =?utf-8?B?Wi8rejl3Ui8wK2ZTUnhrWGFncjhPcWVDUnBtK0JnUWw4c2haQjJ0RFNGZHll?=
 =?utf-8?B?S011Y1drT1FJVFcvOGVVWVV6U1EvQitIaEFyU2l0MHEyVS9VUTBIUHozNDVU?=
 =?utf-8?B?dTJBbEN6NGluZXJ2eFdtK041QWEyTFpjZ3JqVkMzZGZDZXEwTi9zN1RjOElB?=
 =?utf-8?B?L2g3SHl1VEh2R2J0QUQ1QVF2bWp2c3hXUlUzaVh5ZnZOVkdUZG03QnR3dnlm?=
 =?utf-8?B?RUFLL3FQcWIremxHVzZZeHJQc0g2dGZXM2toMHFDZHBOUkhtK0xxQ1RiU3B0?=
 =?utf-8?B?MmlYbktRTXYvUnpOLzRKdlRvQkxMcWFTM2ZvRUF2ZmN6S01wYnJreDFFWjEz?=
 =?utf-8?B?aFVjTUNJMElJalRJSlc5cXBtL0h0YXBDZTZrN2NBUkhTNFRxRXlGOUt0U2xo?=
 =?utf-8?B?ZkpEcmthSENoREIyaGpPSHNLRGpiUC8zenVLNUxhMTUwWjlPbWh1OU8xOVFX?=
 =?utf-8?B?b09ITzczT2gwZGo1N05zcENxVkEydDRnVzR6akZKcEVqdjRST3ZwVTFldFg0?=
 =?utf-8?B?QTdaS01jQWlQbUdCR2RPdFFYblpQMHBKUnRNUldWRjZkdUJjN1lEZVdSaWd1?=
 =?utf-8?B?QVJKWitadEhCT25LQ2cxM0hoYk4rUHMyeEhPVHoxMVY5UjU5M215NFJ3dGlI?=
 =?utf-8?B?V2pieDRrc2o4ZmduVy96ZnlkUnpISURFbFJxWFF4WkxsdGNra2QvWnZtVFph?=
 =?utf-8?B?RGpWQ0tSbTZ5STlhOGRtM21jTXQ1K1YzRDdUd1p5RVgzSm0xRVpFckFmYkR3?=
 =?utf-8?B?dWZwWVN1cEJ3d2tSZ3cxY3hXUWlxeDF3Qjd6MlI1aWtVTjcvWnRwWWxlNzhZ?=
 =?utf-8?B?SHQ3b0lxR211angyWHAwS2VCUjhZMmZmSWpRREYvdEQ3OUNLd1kvdHZzdWl4?=
 =?utf-8?B?aTlLb1ZGSHNEdGlLdkExSXdqSGhwNWhsV2RvQUdYOE0yNGtTdDJKR21SR2ZF?=
 =?utf-8?B?K3g4R1dhZTk1VkQyeG9mRmRibWhnSWhaOENDc1QwaG0vRU0yL1NkV2FYM2oy?=
 =?utf-8?B?UnhybnduS1p3YWwxbVJScnB6djExN3JJT0ZrdGpBRENVVGVIaTB4Y3pMZE5F?=
 =?utf-8?Q?N9MdS+MZkwuLybRDW9Z82b4VdqcvNRofmbfOd0w2mh1C?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7e4314-efa5-41b5-f6de-08de35b1a437
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2025 16:57:01.3443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JF8HKwgwHlWokVr7lHOuGwlTq+LHcQ71jCrCRvxJYT8aS6miKruXoJwF6VHYH0/Xd3Zx4+VPFsvCcvXbDyVMyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

DQoNCj4gT24gRGVjIDcsIDIwMjUsIGF0IDEwOjU14oCvQU0sIFRpbXVyIFRhYmkgPHR0YWJpQG52
aWRpYS5jb20+IHdyb3RlOg0KPiANCj4+IE9uIFNhdCwgMjAyNS0xMi0wNiBhdCAxMjo0MiArMDAw
MCwgWmhpIFdhbmcgd3JvdGU6DQo+PiAtICAgIHB1YihjcmF0ZSkgZm4gbmV3KCkgLT4gU2VsZiB7
DQo+PiArICAgIHB1YihjcmF0ZSkgZm4gbmV3KHZncHVfc3VwcG9ydDogYm9vbCkgLT4gU2VsZiB7
DQo+PiArICAgICAgICBsZXQgbnVtX2VudHJpZXMgPSBpZiB2Z3B1X3N1cHBvcnQgeyA0IH0gZWxz
ZSB7IDMgfTsNCj4gDQo+IEluc3RlYWQgb2YgcGFzc2luZyBhIGJvb2wsIGFuZCB0aGVuIGhhcmQt
Y29kaW5nIHRoZSBsZW5ndGggYmFzZWQgb24gdGhhdCBib29sICh3aGljaCB3b3VsZA0KPiByZXF1
aXJlIHRoYXQgUk1TZXRTcmlvdk1vZGUgYWx3YXlzIGJlIHRoZSBsYXN0IGVudHJ5IGluIHRoZSBh
cnJheSksIHlvdSBuZWVkIHRvIGRvIHdoYXQgTm91dmVhdQ0KPiBkb2VzOiBpZiBWR1BVIGlzIGVu
YWJsZWQsIHRoZW4gZHluYW1pY2FsbHkgYXBwZW5kIHRoZSBlbnRyeSB0byB0aGUgYXJyYXkuDQoN
ClllYWgsIEkgYWdyZWUgd2l0aCBUaW11ci4gDQoNClRoYW5rcy4NCg0KDQo=

