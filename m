Return-Path: <linux-pci+bounces-16723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88A49C80C4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 03:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A5E1F265F1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 02:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E11E7C34;
	Thu, 14 Nov 2024 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="JWrzW6qZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD41C1AB6
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551318; cv=fail; b=eWBSCIerQWAa28OHjGgKEzdOPOWlYtiS23CZQKT2+XuAwaEW25NXsZoqnTnnRWrarRsP9871JmJDrO2VS73K/JlX8v2xejtU/IX08veuxXZ1fdhiMfaObwvfnxndufUsXVjYAsoqIOYs7jiLlaU7NRlMvfxUNmPoxB8ORsj2970=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551318; c=relaxed/simple;
	bh=RT204XJzudbz5s/DTw67mbD1KBoxth4CMYK7M2OhlwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OQMiBeC95190V+KGCZfNpwTEAlpWB+bLuhjiV3JKiuW4xq7YrE+OsGoTnk6rAvtmkn4efGLQPkt2vSPLBp0NkrVpSrAOkOfArgtpv+CyYaVNhD4lMjlg8NNOI0X6CfkZcc7ewaE+qtJ1bvzT2RNVXG2+VzKa7mHiTUmA+/No/3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=JWrzW6qZ; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1731551316; x=1763087316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RT204XJzudbz5s/DTw67mbD1KBoxth4CMYK7M2OhlwE=;
  b=JWrzW6qZ2DdByhxLgwQR0St6gq5X+p3qjZz05FMVfAd5CNBatWeHhWW9
   QqVsOt9GQHc3ahFwBEDejLTPrxFYrogQ0j3k6frezxuoI9Kf64plFzC1U
   JjxsDxwKtllWTWKAjSvZWYR9WLJiDFHncIQSuyBVX2xV3ZSQclVJi3GkK
   eUlI9wGKeedTcXdbAHv5bOcA4JXtVQyShTftan+UatYLd2q36J2xdiT1B
   qF5SCKMqPEV4Eq8LRajnADQJrg2ETsu1wtyg+9ZEtX8dxtUgALu5kjmfW
   obiXDPAOt/q+UZt2gsUU37d2oWh+PLWQiR+EVb0n8Tzb8N8xtmVgpGs2S
   A==;
X-CSE-ConnectionGUID: yxzMR0NaRcapzt0+nX1UNA==
X-CSE-MsgGUID: 62SFo0hUS6GaDceWSt7pXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="49843203"
X-IronPort-AV: E=Sophos;i="6.12,152,1728918000"; 
   d="scan'208";a="49843203"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.0])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 11:27:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jflxxhSCtAyq602X6i235Co7dDdwQqxyZAnSigVQOJ8d/7RO2Z1RPE5dvl5KpuMlHH09Z90wQzFbCO6ltUpGyExdIlvk/E9IfPLAMWXYRMt2kyYdoyMziK86Q4bOSdc3HJC+zSISzPvpD6nflqzFy1byJuMYS0byTxG7+tlxepQJY3lqVKwRLMEUF1+jx3lGK+Jpd+B1tNWHimg5EEmBLpJK4OnDWWA1wH05TYMon//6fTrHmVXsFNETFtGgeZKGJUksAkGYwYtwXJr8SVFjSF1e0QjS+NBTO+nX201r2Yf0kWU5XAaZucXeyVeaNID21OegXccE5LGuR/EC2CThfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dD6jmCX9cDgH6Fg76/mDhDlOhrGgszhMvWpRI+eIn0=;
 b=Aqr5bSH9Ykf37Y4E/a7YOP0AQHZMkVuAdaygl5px2J4yv4UodkJ4+ceWItSl/yXJKfI9Z14m1GecQ/S5N/rpHc0O2ZR0jITaOQlJaE+ppDS4hspJKtpA0sFnsvsO0bgLm/BUkDwYXn6B2VZG1P78dRvL0ZwKmKvYLMS+YcAuo+ibI4z7/O4DDpU4y2qEHO4DMAoV9pP0hZMlrOkQwP/cdWy6G1DxwRL3S0IdkMLnt5IOwJSrkl23gvROEYytC3PQLXFHgd9Gu+ftcQVGnDkzzxBSKF/vksTjzffiGrs1PwNl2PGr5Hmu4Hqatwnq6KV/ssmvGGip1HZ4wWI72TEE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYWPR01MB8840.jpnprd01.prod.outlook.com (2603:1096:400:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 02:27:20 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 02:27:20 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v4] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v4] Export PBEC Data register into sysfs
Thread-Index: AQHbA+h74ei4/Wguf0W/KiuMbwib67Kik86AgBPPI4A=
Date: Thu, 14 Nov 2024 02:27:20 +0000
Message-ID:
 <OSAPR01MB7182F740B00B1A38AB84AB6DBA5B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
 <20241101110425.00005582@Huawei.com>
In-Reply-To: <20241101110425.00005582@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-11-14T02:27:19.882Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYWPR01MB8840:EE_
x-ms-office365-filtering-correlation-id: 0cbf7f48-ae96-483a-1746-08dd0453ddbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?bmMyTGpDWmMrWXpjQ2FiQ1drSFRWZGxQNS9UaENVUnIwVkR0dmZ4b05D?=
 =?iso-2022-jp?B?ajd5dzNtZ016UVZjeTZubU1od2Y0LytoVWxPcldCYzhjb2IrU0lkYXl5?=
 =?iso-2022-jp?B?RTlSaGxRTWNRd2JYS013Nk82bmJvS1FUVURpY3ZkTEtZWWhYRWhvQTB4?=
 =?iso-2022-jp?B?d0t0ZDBnRW1VblNhNVhUb25lR3NoMTVsWEZPYVZxMHM0dmhEOW51OVZC?=
 =?iso-2022-jp?B?YmlHQzRYanRpcFNJN29qSzJXY2Yvdko3azZKNkhnem9YRHNrSWhMZ3NE?=
 =?iso-2022-jp?B?ZGN4bS9LbFEwUXlRWkpESTJEODVYeFVVdzNLSnNWc0p1bXd1ODlSQTJ1?=
 =?iso-2022-jp?B?dVdoclFaR3pSa1BLUU15UmtxWENGR0haOFhCQU1NSDNOUFV6MSt6bUk1?=
 =?iso-2022-jp?B?OFBzYjU0S21xSGlTMWcyV2VlbXdPT1VmTVprT21VbkFaaC81bStYQkl2?=
 =?iso-2022-jp?B?OUpLM3FoRGZNSFFFdFJZS3E2bFRieWpMMWszZjBaVGdNcnFweWsxY1NI?=
 =?iso-2022-jp?B?ekFtMDUvbmFjNjRHWFc3NVVHcDA2UG1Lb0pDczc0OXBJMEFhay8zYW1K?=
 =?iso-2022-jp?B?TjdYZkNRRkFTTkRCUEVuMGZhcjJwT3ZEb3ZCTllheXZlR1RMYllJRXZH?=
 =?iso-2022-jp?B?Y2swZ3RqWjVXbkp6UGFVNVdXV2RoUmo4NTV5SDN2SzJCVzFsa2NNaGh3?=
 =?iso-2022-jp?B?WDRNSWZiU2Q2YWk2Zm4vdnJBOVYzaFloZ2pmNXdSREgxRGw0YkhmWElu?=
 =?iso-2022-jp?B?NGorM2xBdDk3VkVudGs2d2lLcmZyd0JDcHA5c0xDVzdUNDNMRXpVV2lV?=
 =?iso-2022-jp?B?dThOOExwWnJsc096WmVNblZSeFlWa3g2Um1UblpwVkhXRzVyZVJMYUE2?=
 =?iso-2022-jp?B?cEtyKzhSVEZCSlhxT2FrNXg4U2JrNCs2TnZwcVkxVS9aNnljSUVGSkdL?=
 =?iso-2022-jp?B?WS8zODJ6SFFuSkZvSkdrcFJJTEZjRlN4dDZIK0luTFVvckJWZjUwMzgw?=
 =?iso-2022-jp?B?MXNHVy9DekNkV051MDdVZlErb1U0MjZFbWV0SVZFNlNxWkFmWHR1LzJS?=
 =?iso-2022-jp?B?SllCTVpQZFlMRVJBcnpOeldITGZEQi9GYXVjN1h4YXBsbkZ2bEdHWitq?=
 =?iso-2022-jp?B?S1lLa1o1azhRVnpYQlR3WmhNM3lXbktPUU5mNCtmdEQzRFYrc2NoU0NT?=
 =?iso-2022-jp?B?SDJEa2s3bjZKQzNSLzNkTFBKRW15Tm1SSzVERVRSM1VhajBYV2pxaDl3?=
 =?iso-2022-jp?B?enpINkV6NFdKcHJFUTVWWTFzWGFEY3pyZGZmRk1ublE4dWZzaHVrRmZB?=
 =?iso-2022-jp?B?ZzZkUkpMbVR4V0xtZnBKejNhTEVaRHREeXN6cHJHUzFKQ0tCd28yL2F3?=
 =?iso-2022-jp?B?MEU5T3V6ZzM2ZmpvZVhraFZRV2dtancwbGUvYnJ5ajJYRUJ2VkswTDRM?=
 =?iso-2022-jp?B?WE9QdjIzUXAxTE1DUDJFTkRLajRJV2djM2tZNHFFdTRrMjBWb1F2b2xH?=
 =?iso-2022-jp?B?MEJtbkhGeXF3NFA2ZXlENU5OZmU4NmdzU3RqaDBJdUcvRUJFYitpa2ls?=
 =?iso-2022-jp?B?TGZoZlUzUndVa3k5bW93NTdjVk1tYlVVY2NweEs5enpGckJXR0lEYWtP?=
 =?iso-2022-jp?B?dFlYS1ZXNkZYYVJnTEEvNHpUYTZWNVJ3NkRYZXR3Q0lRVG50a1lSSXpY?=
 =?iso-2022-jp?B?ZmtGNy8yNDdCMEhsZ2VoT3hrTys5aFV2S1k4dDh3bnJxcnR5TEZXOVNY?=
 =?iso-2022-jp?B?VHlBcVJZTTVNbVUxaEdubzBUN1BLZ3Z2RmhWRFdSWSswK3ZWK0VkQnFQ?=
 =?iso-2022-jp?B?SUZ3KzdVNzVxdTV3SEN6Ri9aVG9PMUUvbmdHSEk2dzduY1JDQmJoYklm?=
 =?iso-2022-jp?B?MCtuem0wdm1PdURjcjRBbUdZQ2szQnFNUFlCZmMrM0l2djI5bXNsQ3FV?=
 =?iso-2022-jp?B?ZHdPTEo2V3RIMExpZGxjWm9DaCt0MHNlbnU0OFJiK2NYTmh4NnZpdXJM?=
 =?iso-2022-jp?B?alh0RGhaQUlJc3JtZE1DaWtNV2lXWWljUjY3WXFLSmNLUHJad043YS81?=
 =?iso-2022-jp?B?YUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?alRDMUZjZmlXelhvMjY1TDVyMWNLL0x2ZWdrWHNQd2tOT1JhYnhRQ3F3?=
 =?iso-2022-jp?B?c0p2T0JwbHg3a2lMdXZOUzVsTFNSYXlnbWtONm1CajRrUUpRWnVlZTM3?=
 =?iso-2022-jp?B?VXBrK0ZsQ0RFVS9Fem5PTlZvZlVPakRZaitERC9ibk51dkVBTk1RMlph?=
 =?iso-2022-jp?B?ajFyb1BDakFXODBrWHE1U1Z0YTI1MGdOZFd2MXZ3UkJKR0hGMjV1eXlt?=
 =?iso-2022-jp?B?eHpWbXhtM1dZdlJUZU83MWtoeW1qQmxsWHg1cE03aUgwWU9tYjNTSzk4?=
 =?iso-2022-jp?B?VTZvZ2ZjbTlpV3ZSWWJHaXpSRnJpbUR0OWhOQTZuLzYyTERsdkh4cHdh?=
 =?iso-2022-jp?B?S05iQXd0WThjbjBLSlRQVGY1V05idmRzZnhna2QwOFRpOVMxOFZuSEJh?=
 =?iso-2022-jp?B?Tk9mMTdaUFNLRStGTjQrVWtxYmEvNHQ5dG5zS29EeWUwdDRXUjl2WGJJ?=
 =?iso-2022-jp?B?TXRpZHZGcFZnYWorWTdwMG1xbnhVci84SmIvL1c3c3FMbXp2QSs2aVo0?=
 =?iso-2022-jp?B?NnRTSXhKazJnZTErb3k4cjh0RnFOdVJQbnB0WmNiOUNvUTJwa2NONnBw?=
 =?iso-2022-jp?B?VitsNFVLY1JFTkt1WTlwNmtuWDJ1RWJ6SFBuM3NkRTNwNG1hVmVMYVRH?=
 =?iso-2022-jp?B?cWR2TEh5NjU5WjZ3U3RoK0txL1NRK0g4Zld4UEc3WTh0Qkp4VTZsMTcx?=
 =?iso-2022-jp?B?WktGL3hzK2JoQmY0NTdDdWl0TGpUTFZpREV1cmRhZjRiWkJESldjb3Zp?=
 =?iso-2022-jp?B?T1RmY1pXZGtuaTBLaDdNNEs2L0J5aE96ZGdZVk5LS2QzOFZxMGxMM3dD?=
 =?iso-2022-jp?B?ZE5DVjRJbGVmbHc1a3VRZUZ2WHV6RjVtamRpZ0J2cTNaL3A4K0JKK05O?=
 =?iso-2022-jp?B?bktkZTc3Sk5OWlFDWEJRSitLU0VJNGF2a05EWEZGSEkySzVhRjhnRlo3?=
 =?iso-2022-jp?B?NGZ5YUxpK28yai8rSFkrQWt4bDJMUUxzaUdaNUpvM1plTmhiV0dCZ251?=
 =?iso-2022-jp?B?TnJraStIV1lXenN0UE9GWjlOODA4aXRxMmhZUzhvNVVUVElyRjdqWFdu?=
 =?iso-2022-jp?B?bGpCeHp6RkhqSEJDNENLZnI5d1BZYXRkRGxJT0NIMkF5dnlKRXJuRkZi?=
 =?iso-2022-jp?B?OFc2YkoxbWVGckN6dHRtY2EyTTBLa1Z0RU1XeUplRGFNeStzUEtZd1Nx?=
 =?iso-2022-jp?B?L2xBUUZ3cnRtRjV0YStaaXMzUGNyYitJSjN6RVNlV0QyYWVoOWdSbXAr?=
 =?iso-2022-jp?B?alVQd2ZKTXRrSy9VU2hRMGpGUEtacVJPeVBvb21JUGVQaFJGaUVkVUdR?=
 =?iso-2022-jp?B?WXZ5TTdpN3dPd2czbVdtSGpnWTBIcG54aTJXLzZpUWZhK0pveGowQmZp?=
 =?iso-2022-jp?B?ZitZZVlKVEg5NlhCK1FsREN0QjgwVjZLVm5Fa0sveURWUlZYVXNxblhp?=
 =?iso-2022-jp?B?cythWi8rQzI0eHVJUzhLTFlaL2FVcHZWUGIyZnoxcGRwaFlDZi9xM0t2?=
 =?iso-2022-jp?B?QUJTSzMrSm9wT3gzMEZuRE9aUy9YNUNTVVFlcGtiVE1ZaDEraDhkUjZQ?=
 =?iso-2022-jp?B?TEtReVFwakNXUTZSRThodjhNWmVZWTNQWGs5M2dza2I1YWFNdFB2aVYx?=
 =?iso-2022-jp?B?QUZsTGtoMWtGejN5WWFtREE4K1FtRi8zZnhiYjBEVzNzb1FMUFkzNG91?=
 =?iso-2022-jp?B?ODYyTUlPY2IzaGtDMUpKc0kyUGVFMGc2OWY1SE5uWmRNUlJIKzExWkJx?=
 =?iso-2022-jp?B?ai9yVk4zakUyV3IyUHdXS2NCVit6UGREY0RCT1JnSWV6QkxMVytvSDJI?=
 =?iso-2022-jp?B?SE40cm9oNTFTUVJHLzV6eTdiVXJlN3NlY0plWk5YSmpMNnZPUnJLNHIw?=
 =?iso-2022-jp?B?STQ4c0JkNzZHT0hibGk5ZHNPekowV0xrZzZiUUpMY1ZPeSsvdm8vVm81?=
 =?iso-2022-jp?B?TDFBZFlyeDVndHRGMVZCL29TWDRRUWoxcTcxbXpTWTBMZHFPTFU3QmJ1?=
 =?iso-2022-jp?B?eURMdVRpb2ZjRVl0OFMrWGlmNm5HQWlRd2JHelBJVS9ja25tNm9VODRP?=
 =?iso-2022-jp?B?dURkSGw1SHZvbDZQR1pwOWRlTlVsZHQxNUtPSTExOGhKK1k0ZGdxcjh0?=
 =?iso-2022-jp?B?aGhLQURXV3V0UExvekJFMDJyRGpnd1F1eVhnRTJHUElia1E2akZ3U21a?=
 =?iso-2022-jp?B?SEZOWGpvWmFwZUNhZWN3QU1yeG5nWDE4M0dvdHZWUGNGaE5sRG53MFZD?=
 =?iso-2022-jp?B?OFBoYndXZWlOLzdURWlqNWR2L0JzTlI1WkFLd1JqUC9HQXdOMlBzR1Vj?=
 =?iso-2022-jp?B?R09HSkZpT0JOdUFWU0kvZ0JpTGJHb0RxbXc9PQ==?=
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
	2sHfD/yZALilZ/XIcCj+keFINbqiOcvYzy/ybRl+hTdB/4o0pbyRHg0PcNi0j8fu7CMEGDxsBcFEQiK4BQj0VcUsiD5pwaDqs6SLk3tf5sUURakSGTQ+DXxnTfqcxE13afW7qmMWikZCMMrSoTGusfpLNgLyRrcoMWvr/86ZkHQXNoRVJNE+4Bwm4yxdyigS3fpqLmRyQyUdTeLpJA5GMQ/VWp3C78Ccj9kEX9c6CH4UxCg8m10FFS9ayAt8nMAIZTN5MV81D2yBUKfjGRj5UYnGwID4qw0B+ycKfOdknFeK9ATCD67uUt16dhefoyUOrpVMXUz1c4XoHwQQLv0zF8Kg91yL5AaZw42uZ2oASoP17T6rDpyh97+sQwBQCdxMmUU81rLnStojoyvod+mrT5FeZmHjlEnLAlLY5WhBLd1Mer/E1fgehmKGwKhfGQ4Fs1/65Cq/7SaA8lO+RI4zrSTb7I31M0txPXNKpvY9M0NxUjL0Y+8zD6jNC5wVGC6gtK83MOItWfHcdm/ceTXq3WwypuX2XOxkLLIWp1XtWxZEOu78Vc0IxhGXYCZMCBUDloiO25DJRWbd4a4A4atjIGJ13D8ps3fPoSMq07ALUhIbygeBRp39oL9ysk2vJoYT
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cbf7f48-ae96-483a-1746-08dd0453ddbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 02:27:20.4766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi3+2nb/UWxTwQDUMDgO91xmkzBVmhjiEbNgyZiD+09PmcCaxvXTJHYB5H+v8m4ZKGWyXy2pJEfpHIf7VINYCLXzPvGWEYa86efaO0nmLyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8840

=0A=
Jonathan Cameron wrote:=0A=
> "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:=0A=
> =0A=
[...]=0A=
> It's not user friendly to just output the register content, and this is b=
reaking the=0A=
> one thing per sysfs file ABI rules.=0A=
> =0A=
> Various possible sysfs structures may make more sense.=0A=
> =0A=
> 1) Directory with files for each entry found. Each file=0A=
>    is one thing so=0A=
>    power_budget/X_power - maths done to take base power and apply the=0A=
> data scale.=0A=
>                 X_pm_state=0A=
>                 X_pm_substate=0A=
>                 X_type - potentially with nice strings for each type.=0A=
>                 X_rail  - 12V, 3,3V , 1.5V/1.8V, 48V, 5V, thermal=0A=
>                 X_connector -=0A=
> 	        X_connector_type=0A=
> =0A=
> With the stuff in the extended bit only visible if flag in bit 31 is set.=
=0A=
=0A=
Following the ABI rules, I propose the following directory structure, =0A=
based on the suggestion provided. =0A=
Please review it and let me know if you have any concerns. =0A=
If there are no objections, I will implement this and release it as the nex=
t v5 patch.=0A=
=0A=
power_budget=0A=
    =1B$B('(!(!=1B(B 0   - The index number to be set in the Data Select Re=
gister=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B power - Value considering base power an=
d data scale=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B pm_state - D0, D1, D2, D3=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B pm_substate=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B type=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B rail - 12V, 3.3V, 1.5V/1.8V, 48V, 5V, T=
hermal=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B connector=0A=
    =1B$B("=1B(B   =1B$B(&(!(!=1B(B connector_type=0A=
    =1B$B('(!(!=1B(B 1=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B power=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B pm_state=0A=
    =1B$B("=1B(B   =1B$B('(!(!=1B(B =0A=

