Return-Path: <linux-pci+bounces-16104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3C9BE176
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136E3283C7B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803C71D63D3;
	Wed,  6 Nov 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Yd46+lc/"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa11.fujitsucc.c3s2.iphmx.com (esa11.fujitsucc.c3s2.iphmx.com [216.71.156.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A41922E8
	for <linux-pci@vger.kernel.org>; Wed,  6 Nov 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883614; cv=fail; b=sz8VjS+To1M9jrO8L8xkEOiLq7qWfhK1WkNjGbdUKmnxt9UNj5CjsylROob0AR46zxnvQd2OcSbWQZPsfkuzf+jRoktTCFqIRbcM7EN5Rh4Fq3LaOAgG9kOHlWUFn3pQYYrVoEJI/vfYSX/fRsDSXejL6BzBXi+EXMQhcloSvWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883614; c=relaxed/simple;
	bh=ZrZgKVCWcbIHq27QaAI7dWgLfOs0H1NLb3oFEthEnt4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OfPTKOssFrGhpfeTEzCM0TSJK+zAZHse8TXdgkX3aJVGBRZgzm9VUXn5KAlPJiak9SqRzPneDsZ/s4ezG5EcJhoN1HAkRH5LS73WxfLidXK60wqdflS7Q9RoG+bPPHb2RslGiPRYZa+r2HOfb7KKkLlhHADHTLLn1G2X6Lc3yKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Yd46+lc/; arc=fail smtp.client-ip=216.71.156.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1730883610; x=1762419610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZrZgKVCWcbIHq27QaAI7dWgLfOs0H1NLb3oFEthEnt4=;
  b=Yd46+lc/WGU+Ynztf7tXdKbL6+aWYuC8Th1e/TLb1ItNvKf/I4azSWav
   RcJ40sd+m04wZsbcALcGQGLjNm4gdjbX84/cOaTK3FZILs7QYflmLDbkb
   s3a1AZ8Fx1IYT1ERR05Vd/hIXf6UjX2CQ2h8PjRbUcZVjApzdTobvVag2
   LfZ4+MydbucaTeEKjvptflNBdwXNA35riChlOSfFAyaMz7Plrw89cmtZA
   3S43OLugp14nZ8YlC5D+rcjKRzq7sdkxfkYdY9BNaewz8ZWCRRMDb0D6w
   umtHE8watgPJuQD+MNi/vhuFv8uYpK5t7/ngV8arwFAtAUUidN7/VGTku
   A==;
X-CSE-ConnectionGUID: /mvGoJYPSROBpJkpshgSPA==
X-CSE-MsgGUID: Ek7Vo8eYTiu0Q2JEbk4bRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="136857371"
X-IronPort-AV: E=Sophos;i="6.11,262,1725289200"; 
   d="scan'208";a="136857371"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 17:58:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psqm/P+RydjDZ/ccW3418UbkY42zKmDIZHG8Yz/gLb8J02axc7EEvWSKytp2Y0+o6YV2hd53JXxmdtCHazwf/MpoJUq66/J/SutXXA0zvIsFtbiExy6BVsXDnPTwb9Vyzm4L6p4COUKyYeOG8InY2BunCUrZMNbC7gKWNPraFbXPT6AUxTRROHviyr/3sEe6VZ2aPR/xzr7BgbbAHU6jeMsoHj162tVfmJ5DLj3XxwX08SWLn15zhuZTJt4nwMtM3wsbydN7Dafon0rlKGD/Q0Fexp7jzDKk56y30ictI70UwbiEh5POdqsJw8PSGBix+URtMPGF8aWF/xf0w03xFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LODFvXoPI6Q408fWc6GGRdjEITmLTsRGD4k/DjCmjkY=;
 b=JPfT4h364MgySKFueAr91r4NKeQ3qzEHY//YN0uqxCXUM3HmexPmebHg81wrEHzuDcusJwkb9qeqVu/QgDKUWbMtyCqyTbh4WdAIs6Z6aPpoMxnl6V4OTZsaWqrmslAe2Y4byomn/Q04N+YNwJNrm6OLE8UQTube4RjDZRn3AdmvdaeDh7VP2w/NNkhlBI+JsmrEsEiWU+1g/86HIzHDu3/En7xo6ixCB6De2VjN6I109//wUdgLi0Z6VUQ2Pr+YM7A9ZKe+w1wdePaFB9ZsfzHHJf0gN4ZFPeZ+0GU2BZjyYOB74f2/Mmfd75jjMUdLNxp+mO5Vosy3QWp0zl0VuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TY7PR01MB13766.jpnprd01.prod.outlook.com (2603:1096:405:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 08:58:56 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 08:58:56 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v4] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v4] Export PBEC Data register into sysfs
Thread-Index: AQHbA+h74ei4/Wguf0W/KiuMbwib67Kik86AgAezf3A=
Date: Wed, 6 Nov 2024 08:58:56 +0000
Message-ID:
 <OSAPR01MB7182C8F253B9FC6044ECEA8EBA532@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
 <20241101110425.00005582@Huawei.com>
In-Reply-To: <20241101110425.00005582@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=51477420-9a5f-4178-bd06-0a5893ca6579;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-11-06T08:48:59Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TY7PR01MB13766:EE_
x-ms-office365-filtering-correlation-id: 298b6110-6299-4c8f-f973-08dcfe413efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NG1FZUVLUlFZTVJWcEY5Rmsvcm9CRCs4VmordE4xTFY3NW1xQlpoeFF1?=
 =?iso-2022-jp?B?UEp0VGJMdlp2Wm5DYXJOWWNEUm9DSGF2UGFwOUU3cDVSVlBuaFpOcEpM?=
 =?iso-2022-jp?B?WWpiUFhoblc3WlJCUVpxMWJoK29aY2pCUmxSbGdRWGpxNFk5SkRxd1pk?=
 =?iso-2022-jp?B?TkhOaERPYnBaeGxQcEJiVlVPYUtpUFQ5LzZyOVI0aTFRWFpEUEVqNlEv?=
 =?iso-2022-jp?B?d0NwaC9yMEozZ3pPSmpXRm9hUUtJcGZUenJ3U2gxeHA3V1VZdlZaejBs?=
 =?iso-2022-jp?B?SDdLb2p4cm03bTdSanRtTmtmb2NQZHExTFhlcmVhcDNBbDF6dnNWSHFI?=
 =?iso-2022-jp?B?K1JOODBGYmJTa1Z3dXBFaENmaTI5SkJuK3ZhYkRoQnd2RDV6WmhkdDBn?=
 =?iso-2022-jp?B?aEFQa21XVFdCVFVqNzRuOXN3bGttU0xjdkFLRHh5RnQ3dHhJUnhUams0?=
 =?iso-2022-jp?B?SFVzQ2xtdHhPcEJhMEt6dzhVeFROUEVwQmtBdmZ5YkdpSUVCanlSL2hy?=
 =?iso-2022-jp?B?SVNWNThJZlorWDVldHdCQVdBeTlhdFB3ejhwSHh5YmtWKzRmM0c4S2FY?=
 =?iso-2022-jp?B?bGZSbzFRS3huOHU2MlFYVjVVdlQ4d2VuTDJNK014QnNPWWpGQW4zbHI1?=
 =?iso-2022-jp?B?cU4rcE5yb3k1S1Y5c2V2YjB3SktXY2lkSzRxS0gxeWtVZVJkMGk2UGJ0?=
 =?iso-2022-jp?B?S044NHEyL0NYV3R3dFBBOW5tcFJSNlBOb1B2T05JRlVMUVNyU3dJT0Nq?=
 =?iso-2022-jp?B?NjdyZm9ITzVBOGlQaVBqVmtXdVRyS0U2UGs4YzAwV2VDQ1NHUHZnbFFS?=
 =?iso-2022-jp?B?QXJGSGpmbXFLYkw2ekJoaHMxbDB6UEk4c0RvN01xRWxTNzAyUmxmK3BR?=
 =?iso-2022-jp?B?QjhiV1BkMnJrbG9seXRkRW14YlZhSDF1d1FGVnZQL3RrNk9DMnc1aWp5?=
 =?iso-2022-jp?B?Zk1MV1lJUjllTVJsVEdaZXNHWmROekhNUmIzS2JqRDhURkVPenFKek9M?=
 =?iso-2022-jp?B?OUFwcWZZeGt2YTMyYjNLVFRBZGVmSkhlK3Z2Nmh6SlFVUW1NL1VkdThW?=
 =?iso-2022-jp?B?TlVXejRjbk9wdUR1akduS3Y1Zzg0UEIzSXkvb2FXV0hiNXY4NC9abE94?=
 =?iso-2022-jp?B?YTQwQzJ1TGhjd0kyd3hLMHpmM1IzMEtyekhlU3RwTU5ZTWYwdWF5MzM4?=
 =?iso-2022-jp?B?dk5lZStVK3JlQnB6Y3d1MER2ck9NRGN6QXZNWDF4Z1ByWWtSMTFnUit5?=
 =?iso-2022-jp?B?R1I5a3E5cnpadFVjdHg4dE5JZnhDL1dsYXFCTG5uUVZ0Q3NybWc5MGIv?=
 =?iso-2022-jp?B?YXJDZUc0Z1FWdWJNcFdCTG9odVArbE9mTGlSeVZjd1krWXMxRDZzcFh2?=
 =?iso-2022-jp?B?a21SVzBlUlRsUmYwK1RzbGp4L0hnVm8zWkFKbktBcXAzSkVvRm1OMVZp?=
 =?iso-2022-jp?B?R2FUbVBveTljMDJiNmJxNFEwT2g3Q2MwbzJJdFVjdkx5RkkvTUR5VmZl?=
 =?iso-2022-jp?B?U2FUMFlwUVN4SzI2S0FRc3g5TEszZm9uL1pTbjdGRmx2SDFEd3lxdGhn?=
 =?iso-2022-jp?B?MkdvQVZVcVpmNXZvY0RIT3E4ZUg2dTB3R1g4TDdMa09hc2czbi9PUmxC?=
 =?iso-2022-jp?B?bklxK0lneWlOVUlvVHlYNElQY0NiRUVydHdVYzJmbWVlSjByZFU4aDVi?=
 =?iso-2022-jp?B?dCtXRmRkUnlPa3pRKzFTNVRIWXFDSTNTS1ljaGZFeWdNQ0hHWGNzVUFw?=
 =?iso-2022-jp?B?N1JTZHYrVE1tait5bU40ck16UEZ0YURXL1ZwMGJkS3dGY1VteXJRYm1C?=
 =?iso-2022-jp?B?UlhhQ0loOTczR3NpR3FpaU41WldwNlp6Ry82cURpem1YSnprSFNwY1cz?=
 =?iso-2022-jp?B?dG5qVnFzUk9SWFgzWHp3a2FBVmo3U1piY09iSVJ3OXh4bFp0VnE4c3Ix?=
 =?iso-2022-jp?B?L3E5dEs5SzN3K28vSHdwVUdETExWRmdEWHVrRXBBRlVJRStLazNqU2FL?=
 =?iso-2022-jp?B?eGRRLzZabjBUNTBSVFB3TDVQS256TUtVNUdYNUlJL3JmVlY5ZWR0SHJV?=
 =?iso-2022-jp?B?MUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?QU5Lc3FUQTh5UFdqa0ZCUEd2QnFhdEFESDB3SVNPOGVQc3lVeHZ6YXBl?=
 =?iso-2022-jp?B?NHpxM0JwZExJSGlRQ0ZDUzY4S3dhTmZEVWptU1V3Zy9zUXpaVVVJMVRy?=
 =?iso-2022-jp?B?a2pqU2hFamo5WmFvNGtaYldkM2VBdDNTN0RKRkk3U3RCTUVVR3U5SlhZ?=
 =?iso-2022-jp?B?VjlHTjhRUkxCYk5oWXMwYjk0TG0wMGFFYmtFekxsWjFULzk1QlFENy83?=
 =?iso-2022-jp?B?aHZmNHNDbFJNdUpyOTdnSlRxckRyZWM0VVNqaDd0cmNFSUFEYXQrVXJu?=
 =?iso-2022-jp?B?aFZpMXd4WnpwR1M0QkV1OFpEaWc1eUh4YmwwckpXdERLZGtXZFZyUHpR?=
 =?iso-2022-jp?B?Ym1GQWJ0MGlZRS9ub3MyT0pMQm5LKzBpcWVWcVZHZU1PTkNxNEVvRWc0?=
 =?iso-2022-jp?B?cEZ5Sko2R0VvK2MwVGUvWGE5bDk2ME1halRYbWtCVVBYVnlzRE8xQlNU?=
 =?iso-2022-jp?B?bEVtLzZ6MGFQQTdIRDJFRkxmeldqaTRHWEQwSmw3ZVlHdkJYUndjVzhz?=
 =?iso-2022-jp?B?RHEyNzV3YXgzcHZ0UzRSaTJYRVpZNXpXcXZxODZQUnRuK2lXTXplZTdH?=
 =?iso-2022-jp?B?aWR3WkRnTUdlQzlPcmR3UURVTC9Nc3pOazhEbW1WdC9IckNVN3p4T0Ur?=
 =?iso-2022-jp?B?V3RxMFBXK3gzajgzRmZpNURTWlVCSVlodlJ6aXNJY0hJdUM3dVl1NjVo?=
 =?iso-2022-jp?B?MzV0eG53NUFOQis1NjdVWGxSMk9qMVVwenZpTUhTQ3FHQzhmbkNCT2Vz?=
 =?iso-2022-jp?B?TGtlWkl1c0U3YVlKOVZhbmN0SmdKbVN1Q1dxbERQam9NaWxUTkxOT3Ru?=
 =?iso-2022-jp?B?YUV1alExendES1Z6Z0lXMmhReW4xRGhEdnVFdldpRE56ZGdoZzlwN3Zr?=
 =?iso-2022-jp?B?Vk1Sb0FMMWFmZ0cwRTZrcFNiZVcrVVlSL2I2L0FsTG5DeGdna0tZMUNW?=
 =?iso-2022-jp?B?Y21saCtHeUNBZFl5TTdyUGdMSlVNYWw1V24vNjBkbnFZU0d5Vno0NUYw?=
 =?iso-2022-jp?B?SmxITXhQN0VEcWJZdWpieHVQUkR0RUErbUFUTjN1eUhOVU51cmtGREFS?=
 =?iso-2022-jp?B?ZUVpTE9VYzU4b0FDN2NmYVVzcEZTd05vZkxqRDJNU3UrcWZCZjE1UGg1?=
 =?iso-2022-jp?B?VmlSWTBoM1pjY3RvS3ZHYWNzVHZpeDJ2ZnUybUpPUHo5LyszQWhPNGdT?=
 =?iso-2022-jp?B?dS9PU0EzbFVsZHFoYVBjZ0xWdTVrejVUOFh3YlhCT1VkM3RWT3Uzb0M1?=
 =?iso-2022-jp?B?alpOZU9pSzhTR09vVmhWcXJDcVI4OFBFdXI3bk9IaFF3b3hIL0VadkVp?=
 =?iso-2022-jp?B?bm45cTlsVTB1Q0pyNnVqcFRobDg1ZXlvc3krY0dIblAraEM2OTlJQzJM?=
 =?iso-2022-jp?B?Ujc2bE5QdkVmeUhIQXcvQ0xTK3E2Q1ByVEI4Ym4waGduclVISnZ1M05B?=
 =?iso-2022-jp?B?OTRUMGNROXQwbllPaWw3R3NDV21nUWozTmIyOFp3SjhQRytuWFE4MVN6?=
 =?iso-2022-jp?B?VHhWaTl5Zy9TcDEwVVJNd2swVlRZbExSN2czKzZvMXNSWjFFbi9Wc2Ro?=
 =?iso-2022-jp?B?VkYrZXlCUWpFc2o1TUN3OWVsZG9aenR3djBMYVJEc3lPTDhJZ2VVdXlz?=
 =?iso-2022-jp?B?c2Z0SVRpYk5aVnNoZWNYMGxQWXFLcHpjR1ZRZVJpTHY1OVZtaW13ek1F?=
 =?iso-2022-jp?B?Uy9CUXZhT1JXY1FISWZTSmhvWXdQOU83dmt6MmZ0Vjh4ZWxsVEFWOTlJ?=
 =?iso-2022-jp?B?eWtZOFRoZS9MQnRVVVBTNnppcSs1eExQdHE3Z0daL0hjVTlEcHBsOTlP?=
 =?iso-2022-jp?B?T3QzWU54TitpMzBOM1V4R2xRV0p6Ry9GMGpWSGVxVmtWdEsyOXVDemFN?=
 =?iso-2022-jp?B?UXpKVHdKRmdnekZ2VzZUdDJ2NHRNV2tyNDdGSnVuVlRUVlBidXByK3Vt?=
 =?iso-2022-jp?B?YUVPYVRXcHJia2pUSmRxMXU4WmlZNDRFTVV5dGhEY0lIOVQrQzBvemdt?=
 =?iso-2022-jp?B?aFc0TEswajZKTWhiNWxSU2Y2OEo2RHRrS2RYUTMydmN0Y1dESjZTcWdT?=
 =?iso-2022-jp?B?d3ZYdnVFR2c4blA0TDlKOWhjYnlid2k5NDJ3MVNaY1cxeHo3d250TE9G?=
 =?iso-2022-jp?B?VExqOGo0ZzR6dkJGQjVlbm1EdmxOQWFGcmk3MFhjZjUxWGkrbUNJYktm?=
 =?iso-2022-jp?B?QzVQTDVzb2xVc2wwN0JHN3RRenVLV0RpcmVIUy9pbXRMcnhpcHl2b2dl?=
 =?iso-2022-jp?B?b2JtbkhleDZIQTRBWTZwTHdzRDVoUDd3cHpDZTQ4MnZGcnVKWjRFWW56?=
 =?iso-2022-jp?B?bzlPbnl4UkJRQXNpYStkRnNJa0pSMENlYWc9PQ==?=
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
	UxrJdwdxaczaT7NqhMssZAz9YFsKdD/sXKlLs4zq7wwnrup9h5KhtX3oquk2Iim6cKW5F0v5al0N1A1WeyCY+paGZcloB/evL0FaSgSms2FGEDzd6gATpN4oEoJhN/9S+O0Hbyrmyfalf1iAHTEknzLQTgsmHEzT/VR92dzM83F6MYRV1QXuOf7ZgAUtPJmGKa+oAulkfugqRDlmDuaM+m3BNFmFTpsjgbA/omznOg+ptsfLdrNv5z17djZeoUwtO/iD4CKDkFgPt9h7Q7xL6TYaZezZTDSg2eLiKO4QgmjmYjuckXKzz0e6EZjR1DFJALbdCV84AhW2T9zbExPiu0L+5UFRDXeUQCab10Vgsj8A8Fu3HE+QZH6m5V/QQEBrT80IM3plDepxIHvxKrBlOz0x1t0vudh1EOfHoCoc9LEIl8jJcSuvgbwOeNxgRR3CTcNk5Wbd37d9xKd2ZA8M1T2sGhv4josqMLPUDg2x1cBzUHEEnT967wjJzDEOA3x3ULzvrhyliDq0D/zHfKKSNQL+aNRiv97ANCz1/zzG7xbpc7+rHpmMuLLrFQh/GWhs8KQwgt/SPo8DVbdgEP/D14hOcgl25Li1PjOsa0DkQ80mUkWB8Z5DObRJYPGWuYLy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298b6110-6299-4c8f-f973-08dcfe413efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 08:58:56.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihYJN+6jRw2tioBCTs2pDFBNWyLc7pZEaqoWDA+7EZzCqtbcU3pBDBTWt6lOkF8LzQp4ocZsXlPZaC5FTIBw3Fyr2th5TcBHWnyRzJCv7HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13766


Jonathan Cameron wrote:
> On Wed, 11 Sep 2024 10:20:53 +0900
> "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
>=20
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
> Hi,
>=20
> > ---
> >  Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++
> >  drivers/pci/pci-sysfs.c                 | 28
> +++++++++++++++++++++++++
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
> a
> > +		series of 32-bit hexadecimal values. Each line represents a
> > +		single Power Budgeting Data register entry, containing the
> > +		power budget for a specific power state.
> > +
> > +		The specific interpretation of these values depends on the
> > +		device and the PCIe specification. Refer to the PCIe
> > +		specification for detailed information about the Power
> > +		Budgeting Data register, including the encoding	of power
> > +		states and the interpretation of Base Power and Data Scale.
>=20
> Is there precedence for similar register values just being available via =
sysfs?
> This definitely isn't in keeping with general desirable sysfs interface
> characteristics.
>=20
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index
> > 2321fdfefd7d..c52814a33597 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev,
> > struct device_attribute *attr,  }  static DEVICE_ATTR_RO(resource);
> >
> > +static ssize_t power_budget_show(struct device *dev, struct
> device_attribute *attr,
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
>=20
> Why not make i a u8? Would remove need for cast and otherwise make no
> difference that I can see.
>=20
> > +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA,
> &data);
> > +		if (!data) {
> > +			if (len =3D=3D 0)
> > +				return -EINVAL;
> > +			break;
> > +		}
> > +		len +=3D sysfs_emit_at(buf, len, "%04x\n", data);
>=20
> It's not user friendly to just output the register content, and this is b=
reaking the
> one thing per sysfs file ABI rules.
>=20
> Various possible sysfs structures may make more sense.
>=20
> 1) Directory with files for each entry found. Each file
>    is one thing so
>    power_budget/X_power - maths done to take base power and apply the
> data scale.
>                 X_pm_state
>                 X_pm_substate
>                 X_type - potentially with nice strings for each type.
>                 X_rail  - 12V, 3,3V , 1.5V/1.8V, 48V, 5V, thermal
>                 X_connector -
> 	        X_connector_type
>=20
> With the stuff in the extended bit only visible if flag in bit 31 is set.
>=20
Thank you for your comment.
We will modify the implementation to follow that "one thing per sysfs file"=
 rules.
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


