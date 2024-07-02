Return-Path: <linux-pci+bounces-9586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D8923CFF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 13:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56284281DCD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA915B12A;
	Tue,  2 Jul 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L4JhhFjn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51610179AF;
	Tue,  2 Jul 2024 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719921470; cv=fail; b=IaZWjBIuk9Ha1wv07JqGhtcj88VkuPzU5V8bu50e7nirZo1nepKENTLVFlSK2m7kupBQgj2KMkiqOTo2qhcf6foojjFFEH8g64IXh07E/wU6+2ugEsMBENsKyREVMUIFu793Zg94QhDQqWj+ZngL2GdX1DI+joPaUtGKzFQAyJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719921470; c=relaxed/simple;
	bh=r3zdlC038s/3GfP+LXWtyd7YSFCUL2hO/KrLrYsu1jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mIO3j5mvj0229qLMXmpGB4Ynsf9THkl6WXMZ3NywOmf1qz1/092b0GTdpgVYt93EFQBqclx7BcV12kOlBaQCmNiD0pq1uYnRBTge45TSCiKrezpLsnydz6fRKDO+DVoC8uWiErFpaTusBnDA8xAOvHJ+6MkjDEOIu//RmdXbxxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L4JhhFjn; arc=fail smtp.client-ip=40.107.102.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myuUAl5wYCE+ehNECpr1MtGHsMnlI9P4Ly6UVOmwstj5Xr0ydHGiAXK+mtpq4o44Fj0T6DzQQVfwqramhUfMRABSiW2jJRiGyC/6wQykN9dBaB5xhaZWvUXgBJhIZi1i/xy/MhdE2veUzwOv92e4nzuw3pbONZmCuMYqqP6n92btBtzbIEbLgbgX8Jb0wDCSB3svwKrdGx0UUMO7I5ZJAGvq096y8ZZuYCtgsYCVUVRQWNZ4ypBSudahgterxuXiu/o6kcdkm0a/mTyG8YkFeJE4P10FRmlrDVq2pxuu3jQBIpHiVB7n7n4VCeydPazDaDEGf1AqhQHfI8OheJbQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3zdlC038s/3GfP+LXWtyd7YSFCUL2hO/KrLrYsu1jg=;
 b=kNehpATd5C1BQxajbmTBaCDRR4mPMNj8Du3ij9M+wKkjQfOikokU68pO069dTCwmViXB5Q65S6VViPQfqIGb+1EP30Njstw236cXjHyA3p4lVAf7eIq573y8itNmp2zxV4NRc/6UnP6As8X1ntvru1kEMAqMtJNoBMT7j6c8MTUks54B2qlGHAoGz9VhSQePDxyPP7vAJtN8PqAj+ZMYLDV4HhwXL5Q+zbTlne3bmOySO0q5Pb3nesdHo/Y8NwTvyQXnVZjlAizPbpyAp2R+ruZCu5RbJpjg1Gvs628U5jB+G8qQkyqHZHRI5d13cKIT8cb0XleA/SvvJL6ft/Gh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3zdlC038s/3GfP+LXWtyd7YSFCUL2hO/KrLrYsu1jg=;
 b=L4JhhFjnUHcoDFi0tDytKk5IN8Xd1AzgObUkBe6Akiu11N2ty3/UBAAQ1ahGgeT2I4d4DtQw20Zu26WiWYgZGAklp0F5YOrUOsEbp7FrW/NeuvmYNO839aHELIxqmaOHiGMbcrvd82ryJcnac+vklemLQc4U7dxnzXt5va5RV4lqnqI8lK3HFGB04xoB4mRMf2LyL20dP2ed9idWV3EJcub8BJ0VvN1UqxFkGm4WeMQbBHsJq0d7+ZU9aah5lIVlzN0i0UYi49AShQNn3bfQ07qMsvsaW2Be5p+JGBc+J1mW3eirhfphFLOdtpsMhWSdbK2GWl4INCwlxXVwuCwR+A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 11:57:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 11:57:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alistair Francis <alistair23@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "lukas@wunner.de" <lukas@wunner.de>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "logang@deltatee.com" <logang@deltatee.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, Alistair Francis
	<alistair.francis@wdc.com>
Subject: Re: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
Thread-Topic: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
Thread-Index: AQHazEXJ0N8NUXAgUUexFjcbOI2VJbHjVYoA
Date: Tue, 2 Jul 2024 11:57:42 +0000
Message-ID: <f0083401-7bb8-451d-8274-d508c1b55992@nvidia.com>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
 <20240702060418.387500-3-alistair.francis@wdc.com>
In-Reply-To: <20240702060418.387500-3-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8959:EE_
x-ms-office365-filtering-correlation-id: d8140151-95a1-403b-4fc9-08dc9a8e2de7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXc0MUJoNmt4a2R3K0hEMisvVVBzUXVMUU1rb2d0RmgxcG5nYzhCZVY5T1JR?=
 =?utf-8?B?NTFvcWVMUUtSTGZiMXV1NURaNkRRMWIwUVlmVkFQVURvQzkvSklWbTM4VTdH?=
 =?utf-8?B?eklJYzc5c3lzR0VrbEU5UU5seS83N2hVQnhFSEw5N2lLSWF6MDlKNzgrL3F6?=
 =?utf-8?B?SU5lOHJvc2xVbUpOZVFObE9FcUFrZ3N0ekpRb2Rtd1ZBRjQ3RmdLT0h1K3hY?=
 =?utf-8?B?MGd5M0FqTFd0MFhFZyt1Wmh1Y2FkUDFYSVJYV1VUZ2xDM1kvcGpWSlpLbWZD?=
 =?utf-8?B?dFdVdWs3QnhnVHg4QjBaQ0FMaFROcHBzWVRlK0J3YkhkOEYvL1EzZmhIY0Mw?=
 =?utf-8?B?cnVyYmNZZHl4ZC84aVE2U2cxcTYzOWF4SXBMRTJ2MkF0VG1tVzZSQjg4cW5h?=
 =?utf-8?B?bjVFeVRWZGx4cUxZRzBsbXpRYjlGa0ZUbFJOVDAzYnJwOE9Xbm5xL244UGxT?=
 =?utf-8?B?WldaRlovSS93TGM2WFNEUE9WdldrdzlWV2hJcDQ5QUVDY2pZekZUWXlZRVZR?=
 =?utf-8?B?cWZkM290NjZTY2hCWWZzTnpGWE16dEVvMERWeUJHbGoxMFBGakU3MTlTdXB1?=
 =?utf-8?B?OW93d2pWdHhsSFBTMXoxV282VnJTTXpna3RuOU0wRDM0c1VrVmM0cnpKL3pV?=
 =?utf-8?B?dXFUWTRBeWNVYVl4RzNSQSs5Y29QTFpuRGhZVGlEeW1mMS9CWFdjcElqM3Zn?=
 =?utf-8?B?SkJBVnFJVk9INFplYnRCamx3dSswSE4zUC93cDQ0ekF6RWNBMHRtMnVMcytS?=
 =?utf-8?B?NzRNaVlOQWdVWlJ6VTdCVnRZWExVZUZRaFFpei9kUXBUZU5FcjFPSnBSVGtE?=
 =?utf-8?B?V2tIK0o0RGszUzNsUzQ5TXQyWnovQW1vem1pUHFpS1dCcFpsUEx6VExpZTU2?=
 =?utf-8?B?TTF1SHdmbE43NUdodDc0RElKL2xaM2xnYUFnZVFQdWVGSi9VdnN0MkFxT0Zn?=
 =?utf-8?B?TUllazdJMWpTYTZROThRTXlPeXMrUU40SXRzUmJKTE1ORVpFT1F0SDVVNU9n?=
 =?utf-8?B?YW1mSTluRHNtVlJ1SU00Q1krY1BWTzBDR3NIT3dNNWFWa01MSnBkTEhNaGJt?=
 =?utf-8?B?eVVZeVR1YjdPV2ZHbGl2bHBHQlBlMDNYNXJadUlUaGFXOVBlMGc3andsM2w4?=
 =?utf-8?B?MTJlYkZNeU13SEx5bWhCdVIxTGdNOEEvOE9wQmxnUEswdThjdXdLRzVJQU1C?=
 =?utf-8?B?RVNpWjAyQlNsMnNhKzIrcVBKclZuSjR3VUlrQUVaTzVYUzR0VWZpYjRmcFpN?=
 =?utf-8?B?THUvU0dJUVJKZFpib0E0dlNhYlU1MlpaRjZocmxCejZuSVhNRkdMS0hlVmlL?=
 =?utf-8?B?SFNJczNEY0hQeCt4M1U0MDRPajFnOXlkRzFiMkVkT0lIMGUvaFA1emdzNjZU?=
 =?utf-8?B?c3NFbm53N0xoUGwxMnJ4SitRMlIxUWtTd3I4QzNjK1o5S25qYlVTYVArS3I3?=
 =?utf-8?B?Y3lNaHdNL29kQmtMUXhGL1YvQVZoZ3JpVWF5NjZteEd1czFPOXJQUXZLQWIw?=
 =?utf-8?B?OHA2ckUvTjhDUDNVMHJLY1VkbFlSYUxycDV1QWtWUGNQa3MxamZ2UFBya1VN?=
 =?utf-8?B?N0FLOHBhaEI5UUdUeUhJLzNaTmdWYVlRZ0FDVDFtWE81aUhmSUwzQUVlWFNn?=
 =?utf-8?B?ZXh6Z2NFVDhXQ2lyRE16Z0I4MlhEMHE1N0MzR0FCSjNzMVFvNDI5SW9lcEh6?=
 =?utf-8?B?S2wyYmdtc3dOVzZSWHhqVW83VHlCWEkrdVVENiswaW04Tjc1VXZ4OGZ6cVdp?=
 =?utf-8?B?Y3VhMHNMNUJXeDFCaHcwQzNIRTNUR0R6ZDBMcWFuaFA0Q092YTdjOXRQUmNq?=
 =?utf-8?B?NytaSGJuWHF1TjdjT0R0VWRUTkpyQUV5dU5RaFNoTDJzR1Qzd2w5V3ljY2Ur?=
 =?utf-8?B?QXFqVHM1REV5M255K2VucURISG54aXJSWlZlYld4dkdmOHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnREZldyZVBpa0Z6WDdDNUEzUWlrT0wrSkJCSWdyMElwRkpsNElIZkN4SHJ4?=
 =?utf-8?B?NldHMGdYL0UxbmlqYmZ2SkI1MmJpUlJOSUt1K1NjUHo5WWRLN2Znc1BOd3VZ?=
 =?utf-8?B?ZkFBRFZ1ZnhrQ0o2b2ovZFpUN0tQVFBIMFhvUHNZZjg2dXlzUjRJR0xhOWVu?=
 =?utf-8?B?ZTVmVGZJdTdNVjM0K09tb0lZM0Zkd1RleFhTZXliUE9ySkg1ZG04NXd2WS9T?=
 =?utf-8?B?SVNTTWNiR21oUVJzb2VzeXNLYmsxZlQ2b2oxMDAzYU94ODYzd0lldnBsVVB6?=
 =?utf-8?B?Sy9PcjRibjBKKzBCRjNjNDE1UTlhVE1JWEhJOWNtU21adU5aYk9qYXNTSUNK?=
 =?utf-8?B?TkJsVWdZaUpiSXVnMGp5MWlMMUMrTDRSREM2UVFTUUwzVjd0T3RDVk8xSEgw?=
 =?utf-8?B?RnZmaFg2NnM1RmMvc0VUUktrc254R1Y5SnBhTUVQcVhBUXUyOGdtdlk5UkRo?=
 =?utf-8?B?OXhHajVqdjNNcmxteHloYk9SbndhTDIzcDBQQjF6bkxINkIzY2taRFZoaHlZ?=
 =?utf-8?B?WExVRWdJMFRQeklVcGxacDA4LzhZcG5nNHhsYWlrNGRRaTE3VXBDWjVYS2dK?=
 =?utf-8?B?QVdXZkltQnpRTWcySmVJNTBmdUNvV0Yxbi9kTndzak9oeUVwUk8xYkM3Zk9Z?=
 =?utf-8?B?U0U4OElXWDAvMFQrU0F3S0ZESjVxT3VHK3pJL2o5cjd5bGdLaHNDeHRYcWt1?=
 =?utf-8?B?WG8xdUk4TmNleWJkVjB3SkNaNFIwa2tSa0xFRUVrSkFzeFhzTGFPTjdNZDlr?=
 =?utf-8?B?Y200UHYzSlFpL2JwMnVQMkt4UmVHRTRkYzcySnZ0ZWQxOXZvK1RadUhkbTJO?=
 =?utf-8?B?OEh1cnpMdVBrcUkrMlErWXlaM043clZzQlRCZUNmaUNCVzZMZllpclRUQmFG?=
 =?utf-8?B?dVBneFRmYzUrekRxYng4ellsNUpLQUlvdUQ1WEhEdUhYNlBQZ3o2MFQreXJa?=
 =?utf-8?B?UXEwQm8zdW44Y1JUVm5pTEJNejY1Z3k2VEtRdjkySGxkVUNIekI0dWxvbStS?=
 =?utf-8?B?aCtoUjMyRG82QXlRRFV2c0l4eUpaM0tvRk5NMEhjaFZpMVpTTWNWMHBMbGNr?=
 =?utf-8?B?aW9KbjE5Z3IzVzU0VFVXQXZRelg3Q2J5V2FIdzJXV0J2ZHFnbDJ5WjVjNDhy?=
 =?utf-8?B?d3VPQVY4SHkxNE5UQlovS1VteXpFV2NTVThOTWxua1JXWjBuYVowS01Ca3FF?=
 =?utf-8?B?dHlWMXNhUXdyOTNtcTNKb2JCcEdqcmVkUkpzMlRsc2JBNzR4VW1xUmpIWUZ1?=
 =?utf-8?B?Y3dzdEFMa0tDdUtaK1JLQ1p5L1Nzbm9RWGc1S05oekt2VXBJQUI2bVphcFNL?=
 =?utf-8?B?bXQ1V0FjWEFWQ0xZaEo2SStmSEZPT1NFNnkyMk1ESnAxVHQzV21rb2VLaDhu?=
 =?utf-8?B?SmRmekJnT2lLd0VFV2N0WEg2MHdnR2Q3RnFWQXRHYjFHNUc4TmhGU1lRQzRH?=
 =?utf-8?B?V1o5NGRqMzU2Z1p3K3hUTjB2TVBoQk05LzNteFNPdnpXMnNyUFhwcXhBRmF4?=
 =?utf-8?B?KzJBUTlLajZYeHBGenJ4Q2N2MjZSdERjeFBNZjhwNkdRREcwRElzV3JXUHhK?=
 =?utf-8?B?T1B4dnN1L0kwT2t2eDgzTGFTNXo2a2MyN1ZJZ1JQZjNMOFQzbHJzbzQwNGZi?=
 =?utf-8?B?LzJKVkpLU1JyRnZNTURURHMxRkZldWpFd2x2eXIwbGNSbWdhK0VpUW8zcERw?=
 =?utf-8?B?YSs2SFVIZ3d6ZTVyR3h6Qk42dVFLcDBySVZMbHBORGc0Y1ZWK00wRTIrRnhC?=
 =?utf-8?B?cG91by9Pb0Fqb2RJL3FFdzJRdDhGdVpjMWZ4dFA4Rm5sMktDS0ZKOHpMNmpz?=
 =?utf-8?B?aC9wNjVsYzBacEtodHRLMFFueEdHei9GcUhVdXoyamFXQ2RmSERycm5LdzN5?=
 =?utf-8?B?UDNkTlZ4K3lRZW9CUDJxWDYxWEhwRkFlYm5icE1HclllUHcrQlhEK29ZaTNQ?=
 =?utf-8?B?L1U2YkpyTk9LS0F2M0wxcFRQNi9vQmNrSFJDeTVkRDNLUXZxSCtxWEt4b21F?=
 =?utf-8?B?QWdIWWhFZkVtRGlaSW5UdlRCWDNVcUQ4RHRFYzRpalphU0cxdWhhc3kvVnRB?=
 =?utf-8?B?Mk9qUE5HZVR5TGJxMVhhKzR1d1d4QUxkeEhZTm9FL3ducnZHMXNLRUtHYUIw?=
 =?utf-8?B?aFdTbjRWSzVzeXN2d2dHYjl3M2MrU3IyYTEwcldkREUrSC9HQktzOEQ1cUJ1?=
 =?utf-8?Q?wRHkvmTbX/QnJr6QFGIsoTbQ98UW5iNrdjbjHJaE6Pm0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B5F4BABAD4BFA43AC1772A8FCE4AB8C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8140151-95a1-403b-4fc9-08dc9a8e2de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 11:57:42.5345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NrbNLVx1dfXM9f3XQ9/Qi66UhjjVR6Nxle3WYCIFuCok4wsko4vMMIAJ5MqqP77AJh4OawJ7HfvAxTfskM3tfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

PiBAQCAtNzA3LDYgKzc3Myw0NSBAQCB2b2lkIHBjaV9kb2VfaW5pdChzdHJ1Y3QgcGNpX2RldiAq
cGRldikNCj4gICAJCQlwY2lfZG9lX2Rlc3Ryb3lfbWIoZG9lX21iKTsNCj4gICAJCX0NCj4gICAJ
fQ0KPiArDQo+ICsJaWYgKGRvZV9tYikgew0KPiArCQl4YV9mb3JfZWFjaCgmZG9lX21iLT5mZWF0
cywgaSwgZW50cnkpDQo+ICsJCQludW1fZmVhdHVyZXMrKzsNCj4gKw0KPiArCQlzeXNmc19hdHRy
cyA9IGtjYWxsb2MobnVtX2ZlYXR1cmVzICsgMSwgc2l6ZW9mKCpzeXNmc19hdHRycyksIEdGUF9L
RVJORUwpOw0KPiArCQlpZiAoIXN5c2ZzX2F0dHJzKQ0KPiArCQkJcmV0dXJuOw0KPiArDQo+ICsJ
CWF0dHJzID0ga2NhbGxvYyhudW1fZmVhdHVyZXMsIHNpemVvZigqYXR0cnMpLCBHRlBfS0VSTkVM
KTsNCj4gKwkJaWYgKCFhdHRycykgew0KPiArCQkJa2ZyZWUoc3lzZnNfYXR0cnMpOw0KPiArCQkJ
cmV0dXJuOw0KPiArCQl9DQo+ICsNCj4gKwkJZG9lX21iLT5kZXZpY2VfYXR0cnMgPSBhdHRyczsN
Cj4gKwkJZG9lX21iLT5zeXNmc19hdHRycyA9IHN5c2ZzX2F0dHJzOw0KPiArDQo+ICsJCXhhX2Zv
cl9lYWNoKCZkb2VfbWItPmZlYXRzLCBpLCBlbnRyeSkgew0KPiArCQkJc3lzZnNfYXR0cl9pbml0
KCZhdHRyc1tpXS5hdHRyKTsNCj4gKw0KPiArCQkJdmlkID0geGFfdG9fdmFsdWUoZW50cnkpID4+
IDg7DQo+ICsJCQl0eXBlID0geGFfdG9fdmFsdWUoZW50cnkpICYgMHhGRjsNCj4gKw0KPiArCQkJ
YXR0cnNbaV0uYXR0ci5uYW1lID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICIlMDRseDolMDJseCIs
IHZpZCwgdHlwZSk7DQo+ICsJCQlpZiAoIWF0dHJzW2ldLmF0dHIubmFtZSkgew0KPiArCQkJCXBj
aV9kb2Vfc3lzZnNfZmVhdHVyZV9yZW1vdmUocGRldiwgZG9lX21iKTsNCj4gKwkJCQlyZXR1cm47
DQo+ICsJCQl9DQo+ICsJCQlhdHRyc1tpXS5hdHRyLm1vZGUgPSAwNDQ0Ow0KPiArCQkJYXR0cnNb
aV0uc2hvdyA9IHBjaV9kb2Vfc3lzZnNfZmVhdHVyZV9zaG93Ow0KPiArDQo+ICsJCQlzeXNmc19h
dHRyc1tpXSA9ICZhdHRyc1tpXS5hdHRyOw0KPiArCQl9DQo+ICsNCj4gKwkJc3lzZnNfYXR0cnNb
bnVtX2ZlYXR1cmVzXSA9IE5VTEw7DQoNCnNob3VsZG4ndCBzeXNmc19hdHRyc1tudW1fZmVhdHVy
ZXNdIGJlIGFscmVhZHkgTlVMTCBzaW5jZSBpdCdzIGFsbG9jYXRlZA0KdXNpbmcga2NhbGxvYygp
ID8NCg0KPiArDQo+ICsJCXBjaV9kb2Vfc3lzZnNfZ3JvdXAuYXR0cnMgPSBzeXNmc19hdHRyczsN
Cj4gKwl9DQoNCi1jaw0KDQoNCg==

