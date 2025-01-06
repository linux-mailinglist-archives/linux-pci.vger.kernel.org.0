Return-Path: <linux-pci+bounces-19320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2128A01DBC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 03:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D223A20CA
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B4F9E8;
	Mon,  6 Jan 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cEh464eE"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com [68.232.159.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F129A5
	for <linux-pci@vger.kernel.org>; Mon,  6 Jan 2025 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736131271; cv=fail; b=aiekDRg0y71VgFQpTw8SQcvDEHjwbncjakZbsiDRRYYVNta+O/zrMe5urFGKGvuCH1VmB8U9TKCOAm2VB+YgkspVFoJooLZpvpyFSrg5kqrtdXRYRUIDDzk5m85bU8kq5xxWfanWGhVs3l28wIqIz9rGXikgX6Xzpfn54ymPME8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736131271; c=relaxed/simple;
	bh=oh9Yx0EuLUjT++GkDs5KTbBGsjlbhKbNKHl/Gcj4Sm8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uieP/BWUoIaq5FkJZ9hbAPd13LhSKuQu9MLw8VKwxIdYxp06IKmwOJpZShEFD9xxL1EEowjKHSyFaFkG6/P0RvadeC7bwa0vh74m61OZcsBzpb4G4A01V9jO7sCcc0TE/UJuKK3n6nNlFIxL0iSOEmFKux9cXYmguhFoH2FdoyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cEh464eE; arc=fail smtp.client-ip=68.232.159.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736131269; x=1767667269;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oh9Yx0EuLUjT++GkDs5KTbBGsjlbhKbNKHl/Gcj4Sm8=;
  b=cEh464eE0WC+em3cgW1EoENwgscTOoanJBZEeumoFaLAP8hnGzTHF/SD
   Mpv7SM1oZW/Ervl0Aa1/lqTxrQSuXC+elyhnJDb6/sNzXS0US/RdVq6lx
   c0JG+dtG1xGSxLxoLQwCxlAEm0qpeNxsqfOwGUEuTbBPbqXO98qZR9UzY
   rgcCIKKYQFKrUddnBaPNQiuxbiLF81sHnoX0RkIGuABvsAAR4WRrlZ33L
   0Pw9nzQuAtHLPmBjnJ+Kkl/LTE+fF04nUcU0NNVYUQJJ9dAYqQvVCevqe
   wLPC63GrNlBw2LxGtm5/pxWxHgjMpg2QiiYng6RmOhUbBW0oHQ5bblpH5
   w==;
X-CSE-ConnectionGUID: Io8P6J1uQKKZzckUzlAV4Q==
X-CSE-MsgGUID: U7SWIP6/TOWxCRZwnxq6pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="142372791"
X-IronPort-AV: E=Sophos;i="6.12,292,1728918000"; 
   d="scan'208";a="142372791"
Received: from mail-japanwestazlp17011029.outbound.protection.outlook.com (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 11:39:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyBp2K2U4dVoFcVyFpj3tonju+ZEy6OEROhtGbxWfi0kI+3otVcQxe2omekxzYoM/9dEH/h8O5Dj3UEY1xU2vLnoWsqqmZ4X92oKtNkHwctAlJJgcmKtiwj/flwBO3NLde1/Lgo47YqY577W2WS5hepwI2S7uEYz0GZugUr6mjFLy4fMuDieCm7Z70GrWkBJmr6s20B/h1kpPsOHGzjJCMRa+Nl+pt46SBNxvJRKfSdwu65tCOGpW8OJ1pYhy1IxcLIh1yt+SON+c8VWBLgNhhUfpuX192Ehrr29CLXYxVuqbwkyC8Z6MHVgNKFKLdCCfNzu3Rkbb/pJ93rtiX1Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvgbTEcoLnTsQnxAxCNcPcdoN/C6hQBaDBeQFAaZ6Xk=;
 b=qcTA69zxbd6MnXCeq+oXtepHa6EWS7UqJHAlSlRjbg7MprWjgZPx5JmBbDEAFrLc9XplvIXiSXQ5pbigTFr/C0Ep9NJJN62R3CKu4Vu0UdNWt7oygjOiCam6by2rvE5+flwLOoYMkv731llO/2P1pJsnC8ODZIq5UjE2PFTvwu7x7XlDFMFfKds2i79TAf7hLuuhzMLcooHIR7f39IufbSunfaqfUptZTEebB94I3q4GdqacDlssI8uKwZgCUSunkTgqFrwPB4Y38CZWyHzoYDQcpTukjHeDldr4A4ggfAp0oKuBTkWRE9K95153Bfcaghrl3kZOX0QP7oyg0I58fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS3PR01MB9800.jpnprd01.prod.outlook.com (2603:1096:604:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 02:39:55 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%7]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 02:39:55 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@huawei.com>
CC: "'kw@linux.com'" <kw@linux.com>, "'linux-pci@vger.kernel.org'"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Thread-Topic: [PATCH v5 2/2] Export Power Budgeting Extended Capability into
 pci-bus-sysfs
Thread-Index: AQHbSrk6gqHOLc5m2EOlUHrscD022rLhUvMAgAD2PnCAAElmAIABWxowgCVEo8A=
Date: Mon, 6 Jan 2025 02:39:55 +0000
Message-ID:
 <OSAPR01MB71820DB170BC354471B7DC48BA102@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20241210040826.11402-1-kobayashi.da-06@fujitsu.com>
	<20241210040826.11402-3-kobayashi.da-06@fujitsu.com>
	<20241211174334.00002adc@huawei.com>
	<OSAPR01MB7182A97AD0B536DD214BCDEABA3F2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <20241212124736.00002d04@huawei.com>
 <OSAPR01MB71829A3B55E61A78E8CC10E0BA382@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB71829A3B55E61A78E8CC10E0BA382@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=edecf0f8-b404-48f6-9c90-282d770cac05;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-12-13T09:39:59Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS3PR01MB9800:EE_
x-ms-office365-filtering-correlation-id: 7b6a61b5-3e7d-47da-c07b-08dd2dfb6759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NGcxWklHdk9JYlBQOTcrNGwrK2ZrWVRaMkRPRUlaY2s0eEgyOHNtZVdG?=
 =?iso-2022-jp?B?UFZvWitmclZ3eWdMRWZnT2RmK3B3Q2x6bG5lTjBQcVY3VlZNSlV2bjBS?=
 =?iso-2022-jp?B?ZDNua1B0U1crY3R4dnBnTXVKYjVnRUYyNVdiNzZiLzFKSUNmK0VxRmdQ?=
 =?iso-2022-jp?B?NkM2ck54bUt5R0dnMlRVamF5S0Nac0tCaWlHRDdRNkRpWEw3ZHpQNjBM?=
 =?iso-2022-jp?B?WkxUUDBubjgwMGZlVzFlUkVlZjc0Z1czNmRvdGZRSjdlUi9kWHpKSUhL?=
 =?iso-2022-jp?B?WEtDMlRDZGtyWFlTckxUV01tOFFLQ2NoQkpFNm5OZ3dDbzJMUGVHenlP?=
 =?iso-2022-jp?B?VzVvazJmVkVIdEFBZ2p6OEU0WGp3SHdsRVdSbVNZeUJIaVFRbHpVakc1?=
 =?iso-2022-jp?B?NUY5WUExOS9IZ3EyVHJIY2JpSWZEUExkWjAzdVljZGdpSUx4aHpLVUtH?=
 =?iso-2022-jp?B?VTNPOWszaVFhS3BFS2xicTVyZitCUzB4T1lKNmVBU1ZadUdwcTZOSzA5?=
 =?iso-2022-jp?B?eFdST2J2K2p5KzBTVWp5QlVZaDBrOTVkZ1YzM1l2eUhMNTlRaDZoMXgy?=
 =?iso-2022-jp?B?dW0ySUlvN3NXbTREcm9rWk9aYy8zUXI2QkJFV1JBOGxoQUFyZmZKZE8r?=
 =?iso-2022-jp?B?bjVwSkhXS1d3anZjT1Q4TjNzT2d3dGhvaFhzZW1wUW91c243T01JM0pa?=
 =?iso-2022-jp?B?SndnbmZpRDZoOTdudS9mMkVkbXhPZE5DQjRLMHAxbkVlbzZwUnJHMmNQ?=
 =?iso-2022-jp?B?VzZSektMbXNkdU5WZDBLcTg0YllwenJ2djFtOU1QQ0QyRDlZYTJVYmdk?=
 =?iso-2022-jp?B?blNaNXdGZ0VTOGxvcENub0h1aysxNGF0elZIYnNCcml1QWdyWCtiQS90?=
 =?iso-2022-jp?B?VmQ3SzdXR2l0MlI0TXdiY0ZlRzdPMFdlZ2h5KzZxUWpWYWdhRmZCOGtW?=
 =?iso-2022-jp?B?dFJmMGZadEZXNHNXVVh2R05zOHJhU1FJZWpmdUlPZDJ4dUVQbVJLVjBl?=
 =?iso-2022-jp?B?emFveHRmV2RyYk5yQ3lyK1pOYnIzbFlmbzgrR0FISjNQb2FjMkMwN0JH?=
 =?iso-2022-jp?B?dXpqc2crMW1MWmg5NXJ6MUliaS9GbjdGNXNRaEdabUxNVFNPaUdXTEtT?=
 =?iso-2022-jp?B?ZmFSZ3hKa05qRm11T3lJM1lweWlDVkprQURXYzE5UjNhY0RpVzdpWksw?=
 =?iso-2022-jp?B?NjZXT1oyZlE0Uk5nZkZPTkd5S21FRkhRMEV1b09SQUN1UWREUFd3MkU4?=
 =?iso-2022-jp?B?VmFLMjdQeHNZS21TelZ2NGxBZXlEbFBuZWxTcm5FK3VRaVNhdVNKak9C?=
 =?iso-2022-jp?B?MjlLZEc1T2FOR0VNanZWRWYveDJlbjd6TmdiaURYQnpyTlowMUNnSjYv?=
 =?iso-2022-jp?B?dFNKM20xaEdHSU90S01FSFAxRWhVMXRnUGU0NEFzUlNnUGtib0p1KytJ?=
 =?iso-2022-jp?B?NGRpaXVPQ3BoanNCb3hRUjlkemovKzZCcktlWUFNTjdPM21SeWlKS3BT?=
 =?iso-2022-jp?B?aXFpQ3lMb2xuam9mN250OHpVQ1FvRk9mR21FMXI5aVJzK0V3d0ZXK3F2?=
 =?iso-2022-jp?B?aWYwYlRKMmJ6MFFQRERsZkR3bkNnS2Q2TUFWeENVUzkwa0psRFlvanFm?=
 =?iso-2022-jp?B?OWFBQ1UwaSt3QW9FaEZyaGlZY1NEWG9RMjAvbVZpRU9kUFNsaDl1a1hF?=
 =?iso-2022-jp?B?Ui9aejc5MEtYaVpKYmVMOEF4YlhDdUdQU3ZLSno2U3hRZ3JlaU5iaWNh?=
 =?iso-2022-jp?B?YTVsTWV5WStYMkE3VmtxUGRnWjJsQjEzbVlGRU44YmdsN3Vla0M4WXJP?=
 =?iso-2022-jp?B?VlZ5VGE3VWlxVTRFMHBnVDlQNFJWeTNRWm9qSzNVVzVtMWpGMnZ3MDFi?=
 =?iso-2022-jp?B?VGFnU1lsMXQwa28rMGR4enRtKzRIWmRNTkM0RDh4NWloZE50MTlXeUVH?=
 =?iso-2022-jp?B?Q2wxaGM5VkV1bnBNVmkwTUNkRHBuQndNWHFrQVZoa29IWFJwN1MvRkwy?=
 =?iso-2022-jp?B?cVYvT2hQai9BU0ZETXgwUVVsWjlaQTArTzVCcGFwMG5udUNxekRPRXFT?=
 =?iso-2022-jp?B?VEp5OU1URlU3QU10Q2lVZkhpcG93cnJyY0MvOGpYYUMrOEtqTk5YNGZD?=
 =?iso-2022-jp?B?UmJOL1F5VzZLd0x2K09QRCtwZUFOc3B3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?QnU1RVFCZlhHOFl6RGNvcmwwNUxLenY2RmRGaWFlcVZyRXVoc29wT0ow?=
 =?iso-2022-jp?B?b2htTkRKZE9pS09yaXhXcnpTTnBPamZNckJuZVRVUWpYVWU2ZmsyVFY1?=
 =?iso-2022-jp?B?MkNQZGxsNjVES2YzeFZKLzBiNFhsekt4R2l2VG0xQkNVQ29HMEsxbkZl?=
 =?iso-2022-jp?B?cTJwY0N5ODRVL3NYeGQrMUwvdEN3b0lJc21ZbTNXSXo0V1grZmxod05t?=
 =?iso-2022-jp?B?dFZLaXhKelVCS2ZEemdObnY2MFc4cSsyNTE3NExXTHdpRTM4WGZpbU5k?=
 =?iso-2022-jp?B?T0JRT25TSkZXQkloeWtsczBCb3Y2V290d1RlMWhrenByVFRzendMQnQ3?=
 =?iso-2022-jp?B?dzBTY09MTzk1N3hFekhiS3Y0S2pNNGhHK05uUWExbDh6UHlRQ0FyRlda?=
 =?iso-2022-jp?B?M215UzFnQU5jd0lzd2VEaEhYdzlmZXFIZ2xXNlBobm9SaVNxVERFY0Zu?=
 =?iso-2022-jp?B?OUdNaDZLZ2k1RUV5T01VdGttZmtQalMrZGgwdG5DaGFVVktzeWRQcXp1?=
 =?iso-2022-jp?B?KzBlZ2dCVEJMSkxwckNleG11d2llSGpZc2pVZDE4WGwxUnBhMUM2TDNt?=
 =?iso-2022-jp?B?S0FUcGpoaWdWclRyZXA4YU1takhQS3dUbjlXWWJvQ29DVEoreXR3cDBm?=
 =?iso-2022-jp?B?bkgvMGtpUFcrUWVxMTFSTGdyVVVEOWhobS81TS9VWll6K1FxU0UrazVV?=
 =?iso-2022-jp?B?dE5JSEtQNXRsU0k0Vk1uK3ZmZEl1ZWF6bUw5VjdDd0xOcnYwdTcwdXVF?=
 =?iso-2022-jp?B?VWtkaDZQTW9jeFFQcWRzSm1JdzBnUmE3eEN0UFdUaHdRVGlIdzFENnUy?=
 =?iso-2022-jp?B?SEhSV1ZudHl6alF4RDNVVGVtZG1YdEwzZHhVd3k4VUFuSDM3M2liV0l6?=
 =?iso-2022-jp?B?elZhcXpudDllK2VvYjZuUXBvNmhqb29wOWJwVWs0NE5RWndMSXdidEIw?=
 =?iso-2022-jp?B?dGo4ZUlrWFVodEhpS2c4bnlZVjZnUGJiZ21BZzM2c1FtSGlTYjk5U0g1?=
 =?iso-2022-jp?B?RDdib2oyaGVNTmt4dnJTSFhFTXdkd0NSL3hVV25pTXJVTjV5UnlFS3ZY?=
 =?iso-2022-jp?B?cEg5VFZoWUZ3NVBSL1dqRUJBWWUwZlZXb2xSbjJjVm40SktORFpFSjJm?=
 =?iso-2022-jp?B?MkppK2tvcStDYkgzVDdvdDNtcHhEYS9CTWR0T1k0SVp0NmFFVmpMVldF?=
 =?iso-2022-jp?B?aDZMeXFNSFBLeVcrdVg0dG4xcEpaQ05kdC9BSnpjUW4wT2NxN3hGVEVi?=
 =?iso-2022-jp?B?MXMxdFFMcjV4eTU2U2VOOVc3ZEFhaW8rMGRRM0E2NHVKZmtBbEExRTNC?=
 =?iso-2022-jp?B?L2Z6aTV5TVVaeVVSQkExMTc2bHJxbW9MeFJCT085SlNYaWpHYzV1UWVs?=
 =?iso-2022-jp?B?aXhoUGMzR3Vab1RHb1ZqQWZxNG9wVi9LZUVKa2tjZ0JwWTdTMXhsTDg4?=
 =?iso-2022-jp?B?eHR5OTVlMGxqb2lnU3lSN1F3Rmd0ZS96RjQ2QVVnKzU4em9KNlp6czMx?=
 =?iso-2022-jp?B?NGZxdGlMNERuMDMrWXQxUktjcXVXRVNSV2dYZU92b1hDYW5YVUNsaGRi?=
 =?iso-2022-jp?B?SzlGbGtxYnFyWGlBYkdpK2tJaS9mdnliSVFNZXZUSEpPbGwwZGVQTTd3?=
 =?iso-2022-jp?B?K25US3kyQzBRWXBwYXR6ODFQNHJHMHRBdmdieWZOb3ZldnAwb0NCRGl6?=
 =?iso-2022-jp?B?ckRXZXhSdlhUVmJYbTRLWWV4MTZIVnNTNngycTJZYlIzRmZldTBvQ3Ur?=
 =?iso-2022-jp?B?Vyt3ZDJGTVJoQkFWV0hOOFpZYVNvdXR1NWVuNkQwaWYvWDZjWFVTalI2?=
 =?iso-2022-jp?B?MFFQdDhsdW90VnJBbThjdnEwV2lFQU1BTGdQKy9RR0gwSVhsL2I1UUNy?=
 =?iso-2022-jp?B?OWx3aW1BQWxFSEJvRkJMcDMxR0hlUm5zajBiL2FmWFRkSkZqTytjQ2xV?=
 =?iso-2022-jp?B?MUlsMEUrcmVPM0FoS1VvcGJhWVhCL1N5ajJ3ZmNXZ2JUMHljMlpHK3RS?=
 =?iso-2022-jp?B?eEV2WHppSGRVQkFXNlloVGhGTndVSjFRNThmeEIvQ3dUTXFyRXFEaUhN?=
 =?iso-2022-jp?B?RHM1Z2dmYThScHpndFdVSkFUaVlUeUpvU3lrWjV0bE9VQVBjM3BOVGp0?=
 =?iso-2022-jp?B?ajFoQk1MWW15d3R4NVVocGxYY3VEeHh6TlFyczdiMW5LSTRLbFhwT1Nt?=
 =?iso-2022-jp?B?VmFOK1M3MG0rdlBpNVN0dkZKNXFackluZ294UnF6cXBNRVFGaUJkUy9U?=
 =?iso-2022-jp?B?bjNBaVd6MFdqTkxWSlhzczJSUnpmdldnLzlmdFBMSS9PNnNKR09wSTg4?=
 =?iso-2022-jp?B?bmlOR1ZmWlFNMmE5RjdiVGZQbExLeVNlTnc9PQ==?=
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
	TST9VoG4SZHudFWi8jy/EYH2kqV3H9KvErCd0Xn37kLHufdEpArtiYRE5iYUdOJAASEJ/7UflWVwjDJ62a3E1M5RRLCO+KQL2BJcytNzBVzXQcj2AG+XGYLblGAEs83nrsj/Oas5cusaYJpcR9D/TTsRs5SUCueK24OlSP+e7ML2Nvm8TWI9j4Kj/2jkgMUyZN5OYsvKfEXrz8m6Wr2wS7LyI+ThtT8tznSlMbLJ/kweOwx5jzC1mZXQW4PB9c/n60+7Q7nLjkcSYOg0maMghhfBP0RmFWgrSMtEvdaxGcmiQ9c4/LE4vchtZFy+MrwdS9UfbipbAM+ACh9yEsh6IgqNoCuhwQPcviwxznOLPk6blHi0juPNEPvbxarNgcQEo9ZIZ2JbZz5/tDh01POegjAPlJrOdsvUjEArj2FKw/6ObL3dwrE0SbQzxsqSCpvftmTLKimpXpAITdBG25BJ+Kmsu8GsY4JLd3W8nJyISJWvroC+Fzoi0F4OYvQt3lTn0Y35TEh4H2NZWz28ULw+xk6zGvMlTa3+RWD1AvuK27r+LiNTEggsCuBp2t3sxzpM+Glh6+Vm0+GXbkOuN5ZjNzVgFFgeA9lXpwS3gzNd0UuCImNUQWeNuFbm1cNzPwXQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6a61b5-3e7d-47da-c07b-08dd2dfb6759
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 02:39:55.0212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/3L83xFYg8e/JHxG1gL4/RfBTe9Lw6ISVQI0rLOzRL2K1hTR84ZNaXde6XMZg4eX9W/53lc/IL6KVKSEXISpiITAfO4stRvj2RTSkQ6zt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9800

Gentle ping. Could you check this patch?

> Thank you for your detailed feedback and suggestions. Based on your
> comments, I have a few thoughts and questions to ensure we move forward
> effectively.
>=20
> Jonathan Cameron wrote:
> > On Thu, 12 Dec 2024 09:08:54 +0000
> > "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com> wrote:
> >
> > > Jonathan Cameron wrote:
> > > > On Tue, 10 Dec 2024 13:08:21 +0900 "Kobayashi,Daisuke"
> > > > <kobayashi.da-06@fujitsu.com> wrote:
>=20
> ... snip ...
> > > Regarding your proposed file structure:
> > >
> > > budget0_power
> > > budget0_pm_state
> > > ...
> > > budget1_power
> > > budget1_pm_state
> > > ...
> > > budget2_xxx
> > > ...
> > >
> > > Is this the correct format?
> >
> > Yes. That is what I had mind.
> >
>=20
> Thanks, I see.
>=20
> > >
> > > In my understanding, implementing this would require 256 attributes
> > > corresponding to the DataSelectRegister, which seems overly redundant=
.
> > > Additionally, I was concerned about the mechanism of changing the
> > DataSelectRegister each time a file is read.
> >
> > I agree it is quite a large number of files, but there are larger
> > sysfs interfaces so I'm not that concerned. Do you have any data on
> > how many entries are typically used?
> > We could use an is_visible() callback and register all 256, or we
> > could do dynamic allocation though that would require walking to find o=
ut
> what is there.
> >
> > The implementation should cache the current dataselectregister value
> > and only write it if the value needs to change.  Sensible userspace
> > software would just read all the elements of each budgetX_* before movi=
ng
> on to the next one.
> >
>=20
> Unfortunately, I don't have specific data on the typical number of entrie=
s used.
> However, I estimate that it would be within 10 at most.
> Could you please provide examples of large sysfs interfaces and where the=
y are
> implemented? I would like to refer to them for implementation.
> In pci-sysfs.c, there is an attribute called resourceX_resize, and I beli=
eve its
> basic concept could be useful. However, the PowerBudget implementation is
> more complex because it involves multiple sysfs outputs for each index.
> If there are more reference implementations, I could propose a more matur=
e
> implementation.
>=20
> > >
> > > Therefore, I proposed this patch implementation, even though it
> > > might not be
> > ideal.
> > >
> > > If you have a suitable implementation to achieve your proposed
> > > structure, I would greatly appreciate it if you could share it.
> > >
> > > Upon further reflection, the issue of needing to change the
> > > DataSelectRegister could potentially be avoided by initially
> > > retrieving and
> > storing the register values for all indices.
> >
> > Cacheing these is definitely an option to explore.  I'm not sure we
> > would want to pay that cost at boot, but if not we could do it on
> > first touch.  The 0 value is reserved anyway so if cached copy is 0,
> > read it from the device and fill the cache.
> > We would need to read some at boot to figure out which should be
> > visible, but that would be logN of max entries at worse, rather than
> > all 256.  If there are only a few it would make sense to just read them=
 all at
> boot.
> >
> Although the exact number of indices is uncertain, I believe it is suffic=
iently
> small.
> Therefore, I plan to adopt a method where all values are read and cached =
at
> boot time.
> I intend to create an array in the struct pci_dev and initialize it in th=
e probe
> function.
> If there are any other suitable places or methods, please let me know.
>=20
> > Annoying there isn't a count register for these!
>=20
> I also feel that. Thank you.
> >
> > Jonathan
> >
> >
> >
> >
> > >
> > > Thank you for pointing out the coding style issue, I'll fix it in the=
 next patch.
> > >
> > > > >
> > > > > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ... snip ...

