Return-Path: <linux-pci+bounces-16741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C29C864F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A7283FF6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FFF1991CD;
	Thu, 14 Nov 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZO+KS75Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5641F7080
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577051; cv=fail; b=Nb7cn7yNp2LBNrSBITu97u/pAU9RR8mp5Ee7Pc86kKxMfno6vk38ovIxyXRLUtTkrD5Ec9JqZbeczqJpJAEw2koIhl4CEF/CUu6RqcbwPYetXXSVyQo3tTvv1Yo76ytpKF3tzfNcjFj73JtMPNwRLu8hl0T1WFY2atU+ILsRC3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577051; c=relaxed/simple;
	bh=XGiX07ITumDqFmFQ9bs/mteiSt4PQnGQBMoUYw4wlaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PZZoQm4uouO6+iqOPRZ8L9TfxqS0FLP2dEBe54MsRxmZH+S58CsKkQ/i99KS7ynNTI5alvcdgGXceb9WfQOH/xEI/Xg8pBvay1JIPym5M7vKB64tNDl0u+497Za9Pw4dTyegsMv7Imaz+sBWjvhD3sbW/kgsugU5PPJYcARiEWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZO+KS75Q; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1731577048; x=1763113048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XGiX07ITumDqFmFQ9bs/mteiSt4PQnGQBMoUYw4wlaE=;
  b=ZO+KS75QFkCZU8JjqEAhB3Y4pcvGkq9kWk7cKSYNJbxAWbuAgAhZI+w/
   h7mNQEr3WA0q8sBLMTVoRoKMJqEWGux73CjKBFWspqiPW4PeEeT6xKZ3c
   jmXSaajTwwQp4FkmI2+uZ1lACvS4eCDdJU1HltYS7yXYsbQaRU99l4573
   4/bDVXTS0ZGqTOvUjFMugTaz7Wz/8rl7mUDI7/n8jr4mFWBHpkcnixKjz
   HF8q9tvnRA0EzT0eu3sWoe/zSWNwk6UgoG0/CBELtQMGDL6SaEIv8RKEd
   IOl7QKAGXXsKSLv0PVexrCz6DRCc/0FEdesxKMWBGezjPJTKwIAFCAm6p
   A==;
X-CSE-ConnectionGUID: RGYFXCPUQyKwjy0vizjElA==
X-CSE-MsgGUID: JEs8gbj1TUCBA05zfalrAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="136955714"
X-IronPort-AV: E=Sophos;i="6.12,153,1728918000"; 
   d="scan'208";a="136955714"
Received: from mail-japanwestazlp17010005.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 18:37:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN0uhI+j49WZRkXoahQ2+0yLb3eZ7ZaGITN9XWykXNsWTyBKACruzO/zTU9bvyRQ9lvcqDA6R9RodnHBZLuMoexju+RxjvKR6rjQF54PIUzSGdX1rQ2ivYvihLwD11nlZsdqfxqljWTvbbjRhB+CtiTXUyL5Ry3K2rLRhUclEiqz00e0RMeSgBT9r/J7T0FLBQ0Z23exQJRlOnOd3dH+ZK850xHEzIDmQi4ChatoeqTUgiaP27UTho8gqbOTkclycdE685mA9rH2FHrFNS7oEcaClz4CbXRzb/97pnlK00gJ6f0OzpcK/tICwvn/1nKvVnSMrehX2CwOcMMQ+OIfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8XHVGhgwl+WP6nDdCszpRK+tQioEMNEPhtCtMALe0s=;
 b=yXN97G4YLttX+Z684KJ74aQ2VQiVHZ4hU17wR0tDrf39f27JZHb8qVDuVyAHdxpEcGwhI4IdrbqIGWutsTkMhvbwa3vNNYYOfmhVBh9RT/dfTCv3HVQ0efgtc7Uzsq9es709XDudVUthjzUuGWQ2hlLtnQBgTgCeLHTJ+fLz/s54JEVlx6a0UaxBZjeYrv8us7BkfxpjEmyXuKm5V1x8hXuBtxf68+m0ohSFC8vTXmOGT7ISYlxR450csMBYF7XmGQiegyI8nLXEFIcJ0UYZhoJbWpxjIMSxFELJ2K6UjXq/wKnpCNf2Qtz/c9bgvpkzAPhMKSMy1rzbksE3M+oZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYRPR01MB13267.jpnprd01.prod.outlook.com (2603:1096:405:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 09:37:17 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 09:37:17 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>, Jonathan
 Cameron <Jonathan.Cameron@Huawei.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v4] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v4] Export PBEC Data register into sysfs
Thread-Index: AQHbA+h74ei4/Wguf0W/KiuMbwib67Kik86AgBPPI4CAAIZVoA==
Date: Thu, 14 Nov 2024 09:37:16 +0000
Message-ID:
 <OSAPR01MB71829048884C23C3673C7484BA5B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
 <20241101110425.00005582@Huawei.com>
 <OSAPR01MB7182F740B00B1A38AB84AB6DBA5B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
In-Reply-To:
 <OSAPR01MB7182F740B00B1A38AB84AB6DBA5B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Standard;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-11-14T02:27:19.882Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYRPR01MB13267:EE_
x-ms-office365-filtering-correlation-id: 7405ec0c-e954-45d4-9b71-08dd048fed7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?aUM2bW0xTHpRRDZTQzhTUXJ0VStIbFhycHY1cm51WjFwUEhKMm11eFNI?=
 =?iso-2022-jp?B?NngyNmlZbTVKMkg3dkRvZmExandadEVXSHIxYkdJN0xWVjVPbGg0SFZo?=
 =?iso-2022-jp?B?ZTVTbGo2OGlwS2NwYVhnODhWSjRpWEJqd01TOWcxZWx2R0g5ejB5OFhI?=
 =?iso-2022-jp?B?enF2SENBR0VFcWxxUWdMeE1aWFBvdkZwWFJBeHNibWJWcStPWnVkVXMx?=
 =?iso-2022-jp?B?QVJmSkVYb1BSSWsrSzhGWXl2RFN4RWd0eVpnUGhXWWM2d2V1SUZVWi85?=
 =?iso-2022-jp?B?MTNxYk1QaHcwRzFmNGg3UkF0S3RNUzFrL1RJNU5CckZ1RnJBTU5uMmpH?=
 =?iso-2022-jp?B?RWlMUDNqTEEwNktpNEhsL2g0eitiZCswRXV1QUQ5RFZiaVp3ZVZFM3VE?=
 =?iso-2022-jp?B?Y1Q3RmgrVzZOMmZyVjFrTGZBUTl4enArWnEzVk4wQks5bm51OGdDTUo3?=
 =?iso-2022-jp?B?cXZVbHVJZFNLSkhDUUFYUEthWUNUSkRwb25wYjEwQkpOTlZiY2tMTGx2?=
 =?iso-2022-jp?B?bVFwQWtiL2YvbmJGeGRjTGN3QXFKL2xVMTlCdFJUY1N0SGE2a3EzWUN4?=
 =?iso-2022-jp?B?Wm1ZZjFkVERETFExQk5rZlhEcWRlMWZKSzlIaU55Rkp1T1RzSmZTRWhI?=
 =?iso-2022-jp?B?YnlwS2h5VjdhMTdzRERCTHpNZUo3VFBNY0VCQVlsYUh0eVZXbmVTTGdy?=
 =?iso-2022-jp?B?UjNwRzRhWWRCYnlWRFd5M3BvV1NpQ01VU2VkMGVSd3dWUVYvZjBaK0FK?=
 =?iso-2022-jp?B?V2QxZ1pOV0JkM1c1Z3NjU25lQ2dYRktEaWZFSjl1bURsbDNKMXpFR2ha?=
 =?iso-2022-jp?B?M2Z2ZUx0SExpQ3d4OXh6N1F5aUIzcTkyRWhSakVTV3FnY0RaMDdWRUZt?=
 =?iso-2022-jp?B?cGdObm9HbDhIWXZFcExQRmpWU2ZERkQrNDdWWXJoRFMwVkF4WEl5VFJY?=
 =?iso-2022-jp?B?aTJ3UVQ5ZGFwVFRrU1pPcjhZMGxrWWVreGo2aGxuMUNyWVNvS2N0WmNK?=
 =?iso-2022-jp?B?akdwdDUxbldLMU5taVpyekpzalIra1FzQmdJVjBQVWFQV2VXWU9zK2FY?=
 =?iso-2022-jp?B?S2JEY2FjTk5WbXpWYWVCZVc5ajZwcURiVFhENmEyaE5XdmdveCtBK2Ft?=
 =?iso-2022-jp?B?WkM0WGl3dGpYZXQ3VTZnME85L1lwdmgzT2RiZVJuNnlWcWpPSGFVWS9Q?=
 =?iso-2022-jp?B?b0Q0QU1oVGU4NVozK3F5U3RUME1yTEFQZlJzUWpNYytNdXpVUWFWRVhU?=
 =?iso-2022-jp?B?bytOSTdyb3J2ek5tUTB2R2RxSFVZTFJZTjlMTHpocTVsMzU4d3ZCcVd0?=
 =?iso-2022-jp?B?bnlueHRoY25qTlRPbGtLUUxZL0wwak8yN2MxNG1pZ1lMTnh5ZmJRNmRE?=
 =?iso-2022-jp?B?bFZpOXZvcHBZZ2FVa0VROStEako5NkVHRU55UVpmUTFDamZCaENnd0Ey?=
 =?iso-2022-jp?B?Y1RyL2wyamU0dDk5ejVnQVNtOGx3eExyZ3NROC9TSW11OWFEOERwUUV0?=
 =?iso-2022-jp?B?b3ErNkozQWJRc1cxMWE2Sy9LSlpLbTg0QmZ6TEFid0pRSFZ3Q1FUeXlF?=
 =?iso-2022-jp?B?ZlFGeTI2MkVuV3NHVTN0aitLVmtkQVE4dzZOMzVML1VPQS9rdmVjSE9E?=
 =?iso-2022-jp?B?blJYWmFCd2x1NVpjTjBHZTloeEl4MGQ2NURRRWYwVkxYblZDZWFkekVq?=
 =?iso-2022-jp?B?ZkUvcXAzVkw4Q1Vyc2NCNTRIQzUwRlhKR21CTnhhakJaazZ6RFliY0RP?=
 =?iso-2022-jp?B?a05pRXBsK21pSXRsS2JReGRZODJsYUVHb1dIbzBwb05HSERpODFkc1h3?=
 =?iso-2022-jp?B?c0s5a3hhMGttdzF2SnVEZmxwaWx2TmtIS0Q0b09kemdZMGFGQlhOM3JV?=
 =?iso-2022-jp?B?N0lvNHNIYmk0VDR4VCsrbXhmMFBkeW5jT1FCaVhuc1JGaFVMdEhnbmVN?=
 =?iso-2022-jp?B?MktzK1RGS3hWbGdCODNPYi9DZ0tUaXczVWE1a1ZYano1T1lyVS9mbkNU?=
 =?iso-2022-jp?B?Q3pmeUN0U1JaTnJmaGFYK1g4cEhCa2RscFF3NXFtalpSWnVKb2t3akhH?=
 =?iso-2022-jp?B?YWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UzhMQjRwWmxWb0IvL2lVdHF1Q2tOZFMzVXp4ZVpOeGl5cjNRU2lOY3Ax?=
 =?iso-2022-jp?B?dy9FbUlXOVpPR0w3V1Z0TzRyUjZWUjk1Mjd6aFdRSjcraEZWRjJjeWQz?=
 =?iso-2022-jp?B?NzY0aEdPRDRsMkYxT2dRWERHTDVXajI2WmNUMXVDOFZrVm1uUEhjZUlD?=
 =?iso-2022-jp?B?UnJHbTRIY2k0dlEyZDBJUi94cjJkdXU2Q2dCZloxOVpqOGxxOTl0amlP?=
 =?iso-2022-jp?B?YmwyOFJxV3dEaW1PNWFjNmhsbklHTmhJY3ZFVzBPTlZ2NWVGMGc1b2Vh?=
 =?iso-2022-jp?B?eXk4MXpXSU05TGxwcm5yZndGMlRhZzlvRHRSVU5Ba29Bd2dRYjdvYVhG?=
 =?iso-2022-jp?B?MnpQUituSnErTFVFMUNwMUpDU016UFZHdVdGeDFCM3loc1Y4U1VoYm56?=
 =?iso-2022-jp?B?VmkzOEhCKzlOSGR2N2lSM1RJOWswTzdNSzB0cWR0L2xLUnN0YUZpVjRH?=
 =?iso-2022-jp?B?Yy8xM1ZOejlWdDFydnVRTTd0M3RuYkRLcXlyZmEwSzZtNTRVNHQ0V0Zv?=
 =?iso-2022-jp?B?d3hpQ0l2RWlENVAxZjRPZWpubUtmRUxTczdQNVdkYkVCaXBkb3BGSjdn?=
 =?iso-2022-jp?B?WGd4emwxNVNFZXlJOGhIRjJKMlZTRWxTbXhzQ3luM3BPVXNoTUpCZ0N5?=
 =?iso-2022-jp?B?RnQ3d3ZhQXRKczZJWFdmMGprRWx5OEJrRUV2cHZpSWpMMjUrU3UwVmtH?=
 =?iso-2022-jp?B?Z0piWVZpNHZJbUZXYkxnRmVBYkZXUjI3QXFUU0ZKeTR2MlUzVU1GL0VW?=
 =?iso-2022-jp?B?ZUVVanlMQzUzVkphZURObFhHNW4xajF4OCtqYitLSkZEaWhvN1ZYbFdr?=
 =?iso-2022-jp?B?OUlSS25JTmI1MzVKZ2UrcEF5MVRIdmorNGdBRGQwT01aNVRNclRNeGg5?=
 =?iso-2022-jp?B?djVVcU56NmFFbjJ6SG1jeXp3YnlMVlM2OTVjUkZDZVFPUCtpM0tVOGRN?=
 =?iso-2022-jp?B?YTd3WWJNWVQ5d2MrWnl0ZkJuQVRIdmxZVS90OVJvelZYUGw1QjYxRHBn?=
 =?iso-2022-jp?B?YVhpbU1KZWZSYnZWR1ZKekdnMy9IQkpwcy94WnBrK0Y5R3hQMGpkdEJG?=
 =?iso-2022-jp?B?N0xYSmcxajZTZ2xFUklGSnpFSThHS0NZWWZzZ09YZlNma1cyTnNsTHho?=
 =?iso-2022-jp?B?NFpSZDNobVg5NVJrQ255QnExeTJYUElNMFd0c2x2WHF3NzQvNXVzR29N?=
 =?iso-2022-jp?B?Y2tseDdaVlVlQ1NmRXNYSHk5WXZWem9McXp3MFcvZkhFVE1MU0NKSUlP?=
 =?iso-2022-jp?B?a09sbUpHTTZXbjUydUdYRjRVMUI1eXFLaU4vSkxGLzJBckNhZnIzSjlp?=
 =?iso-2022-jp?B?VFVsRGNXTmlDNmIyS1ZZUDBtNFdVQ3VGN3hsMHJwRktjc28ydVVxQlFX?=
 =?iso-2022-jp?B?Q0piaU1oRExiZm5pTnJPRks4ZFIvN2t3dmx6SlVvUFgwSElGZStHUWsw?=
 =?iso-2022-jp?B?MHRvY0VkejdHS2N5LytTenJHV2s5dkxObUFOeWhBUlNWRythNytoUUZW?=
 =?iso-2022-jp?B?VjhnN0w3QkprTkZJTWRaWUhabTNtZ05NaVEyRmNYQkQzeUF1aC96Q1dB?=
 =?iso-2022-jp?B?ZXdTb2FVSUFvMU15czV2NzRLVWhXWFZsQVRaMVBPd2FQY2d2SStFeUZX?=
 =?iso-2022-jp?B?MnN5bG9jdXVLRkVlWGJBOVR0eldkN2NQRHpPeVJPZ09ub2ZLcHM2dTlN?=
 =?iso-2022-jp?B?Sno3OVRZUFdJaTlWNlgyckx1dmp0dW13OGFpbE1SWnNiSDFvOWV6MEZL?=
 =?iso-2022-jp?B?eXdvdG1hWUdZcVBQVDNjVWltQ3B5UzQ5R2pMTTFNeFhlekx6eDNUbGlI?=
 =?iso-2022-jp?B?Sm5aUnVZcFQ2QmJBVHdZdExEQ2VSS1FUaUE5V2p0b2FJVHcxZnkzKzlJ?=
 =?iso-2022-jp?B?R1piM2FTUkJyRlVQbGlKS3FnQVg2TDM5WGhTeGJQWnBjNEFlelJ1YWNH?=
 =?iso-2022-jp?B?WWx3U0tmbVNPemFESWx3UnYxYmVhVmpYZThHR2RQWVhzUTh5QlR4U1Bl?=
 =?iso-2022-jp?B?dTFqa1dkak5hc0tYM3liVk92azJSSGhqSUhkN05lVDdmR2JVMTR2VDlH?=
 =?iso-2022-jp?B?NzJkOU9vQ3kzSmZES3JwS1RDbzNkM2lFYm5MNCsrVUtqeERPdFJZMlBy?=
 =?iso-2022-jp?B?bkU5L2pGem1sUE5iSUdJb3EreGVrVmtjYUx0WVRHbGh0d294b3V3ZTIy?=
 =?iso-2022-jp?B?SlorZFJuOGFhUDQydURVVEhaaDJOd0xubjhkMjlGeTBxMWp5RTFwZ2xX?=
 =?iso-2022-jp?B?eVhIUWdXSmZMMEpucEgrU0JPOTdNRmtXTW1XQnZjZDdhQnFheTMwNXhs?=
 =?iso-2022-jp?B?NHVTQk5XTzdKSWJKNU5XeE1XenJVbldBNGc9PQ==?=
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
	XP89rYg1A2HxchGfIvA5ragwxkuvZ8TgjtuhnISy8Z657Y1UNumtExs4B5eNb3XIVBSDZzo1F7dzQ6JGK+QRJtRS5rgMFnz599opQU7bTGwSI3BsX++WSCyu8bv2C9lp3/SRku6IqcwGMsAK6yBQM56ufXFPnaKvIamnJ0aPFdLEM8gjGBiEbvT6AEZAt2BXv/drkwrGmNtUkMFlDU9z2se86SbwrhGkXQy9c2Ow8auFuuiIOdtG8Ju3URCbOjtAaw0qvdAImIeXwom3tQdNzJUV+WQ1uSXWqnKVmsnA/oo4dSNVDKhUVdoSRU2Pv1Ll/9gq92kGtccxo8Dgbh4jomI/HXQsg5dPKiD9I/6aGxaFZGmea4bxZMs9JWc5QT7+49ZFPeMpKedWl9dGjaQDWnp17UW0WV9uKwY6lH6JqL6aBRP5ZKql/A9OmX+wvTYe1dE8dkp+Kl1QENnV4JgUacxTyF2ogKBsPrFBi7TdQ7cqwa+E7gVmoZUhNZJ5z++fma8Ge1tfYZMwwshkuReZ8Mn6GxYmsEOc7VH9+v2zvQ4WBTN/kouE+gSngP8uxB/qgAYzvjVehDBt8fUdWh/C+Fj6ZPxm18Qd+X4tEqHKqBvSI0Ber9dzlVisfxjdJEl7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7405ec0c-e954-45d4-9b71-08dd048fed7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 09:37:16.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZLSND4CbtbvEoO18uM1XhKflOm5G+Bdbdy+NEQb82R9h17j/Pt/LoJRFZYdfpvTzbOxwRCudJ9imG6DgtA0RzV0wCa051wYnMhPHyz70ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13267

> Jonathan Cameron wrote:
> > "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
> >
> [...]
> > It's not user friendly to just output the register content, and this
> > is breaking the one thing per sysfs file ABI rules.
> >
> > Various possible sysfs structures may make more sense.
> >
> > 1) Directory with files for each entry found. Each file
> >    is one thing so
> >    power_budget/X_power - maths done to take base power and apply the
> > data scale.
> >                 X_pm_state
> >                 X_pm_substate
> >                 X_type - potentially with nice strings for each type.
> >                 X_rail  - 12V, 3,3V , 1.5V/1.8V, 48V, 5V, thermal
> >                 X_connector -
> > 	        X_connector_type
> >
> > With the stuff in the extended bit only visible if flag in bit 31 is se=
t.
>=20
> Following the ABI rules, I propose the following directory structure, bas=
ed on
> the suggestion provided.
> Please review it and let me know if you have any concerns.
> If there are no objections, I will implement this and release it as the n=
ext v5
> patch.
>=20
> power_budget
>     =1B$B('(!(!=1B(B 0   - The index number to be set in the Data Select =
Register
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B power - Value considering base power =
and data scale
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B pm_state - D0, D1, D2, D3
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B pm_substate
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B type
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B rail - 12V, 3.3V, 1.5V/1.8V, 48V, 5V,=
 Thermal
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B connector
>     =1B$B("=1B(B   =1B$B(&(!(!=1B(B connector_type
>     =1B$B('(!(!=1B(B 1
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B power
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B pm_state
>     =1B$B("=1B(B   =1B$B('(!(!=1B(B

After reviewing the existing pci-sysfs implementation, I've found that=20
implementing the directory structure that I proposed cleanly is proving dif=
ficult.=20
Therefore, I'm proposing a second option with the following structure.

power_budget
    =1B$B('(!(!=1B(B data_select - Read-Write value selecting the power bud=
get to be displayed.
    =1B$B('(!(!=1B(B power - Value considering base power and data scale
    =1B$B('(!(!=1B(B pm_state - D0, D1, D2, D3
    =1B$B('(!(!=1B(B pm_substate
    =1B$B('(!(!=1B(B type
    =1B$B('(!(!=1B(B rail - 12V, 3.3V, 1.5V/1.8V, 48V, 5V, Thermal
    =1B$B('(!(!=1B(B connector
    =1B$B(&(!(!=1B(B connector_type



