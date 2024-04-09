Return-Path: <linux-pci+bounces-5911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B389D1AC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 06:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25A301F23173
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 04:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777F47F57;
	Tue,  9 Apr 2024 04:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TgfdfW36"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9D18C22;
	Tue,  9 Apr 2024 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638528; cv=fail; b=FLk4rIrebe7E+ekMx2ABAu2wFR/Lly5rIp8m+gSiF1hKiBNolM3QwLPTR922KWyeB2iIPoj1xbm5eHIi2KiZI+jmdEq+5jxo8ksMgVFhTyYouR6FAStco0r9nXUZC4bX4VrDItaMI5qedEwuS2Tp0Qgyo8/g7VKDJZr30ayhiQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638528; c=relaxed/simple;
	bh=sEwl2mj9o4kSn0z1Vm13I5xoQ9l9WlXUbYJ350ruPj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YN15/NBmkhI/7EFoSZDyB1E5YIOq9qv1GdUCQv08XhzDbTTejWYkcEun7A1To0bSxesnt9ZwUhIZgehcyVy48LQ7qftoDqhZmCounW4sE0W+QocsSFxAQwv2rPS7NYe82rLWNsKxEmOk8dDG55cXCuvjjc1SrmIsD8AQlS5JSfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TgfdfW36; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712638526; x=1744174526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sEwl2mj9o4kSn0z1Vm13I5xoQ9l9WlXUbYJ350ruPj4=;
  b=TgfdfW36zLtBuLO5HK0OP2S8lZD5uyBb68vzgqPEpUVpCWHJTV/123xA
   U93WVtunyV3qiNIt32luEU1pbtZvawF9cSLVJ4uhVR1JPv3wc+BPqXXSJ
   SXmb3fMfK5SM2jMtR82nMidE8TzwZW9R53nvJc+dXcwGimRkMhXb4J2D1
   gSMf8kPDjit2/EjcMpYuSznZDdhfoSCaevGge8vEqHCEgan6UW68IGak2
   3Sf/803USREhetUNlBTLB+P6zDfRyPcjYa90hlrWbsOsmc3Xw/YRbwy7y
   aAaLUAW9iJ0rhliUdqwEnKObvp7xIrRt3mbe3kcfg25liDuAGLbhBE+2q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="116559886"
X-IronPort-AV: E=Sophos;i="6.07,188,1708354800"; 
   d="scan'208";a="116559886"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 13:55:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl9WlaAB6/NFQSWfhfEqYdr1WnuBgapHT3tC9b4fDdP2vxDL7RDAxzfMSgmPgGE7xkE64F+2vK8IZRj/XAin3teUYy5VeIZGfyzdG3lAUTNCsNkDCQbVtsvpUDh2MAsvuyBGiHuvgxK2aqPcXt1xGC/F+OvhCPrI01TsJRHCt7bZQT6EpthLs3dR5I5+sudJCngJ0XGwnAM1RPD7gEEVoIjIsre5qFswMDx0x03fmaOO/vlkb0F6dCYsH9X3l+lqNp94wV6CHTm5jcTk0+knENULunUdO/jEpNXnwkTI1LJrYltsvQsobXv+DIJEhZjHNAYzJNxWHTI6U4Sa707+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjHOMyglGG8HDNqpx4a55wLLO9byTQaAdcJ6aZWyVyA=;
 b=f00MP8qmNgJbfQe3VLvmTkysz4zB9eInPh1lzr/fWJL9LLbvG1ElYYB98hOpnm1q1DySAV9pzLb0IAdPWIeEtb/1TieaX5RWZ9bipGeYdqn3PBIbNCHsdXpAEFbYaPtmXuCHebIzSozG3BjcEkexXvgfNakOK5mTWFR8q95W01HXIAOKEqrBoCT7cl8L9mG0ek3/90ZWHgUis4tMz6koqNqGYief9YgH/VOuUpZ8v2MsRf9sOMHgMIJAgSm+y00/5hJb/eTpBFQvM+C5e36cqburVEoQlKe9QlDK27H5+U2gk7EkL3CZYHdBZ+7SiMPZJZy8NyIw8nWtXG0PnzVskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS3PR01MB6705.jpnprd01.prod.outlook.com (2603:1096:604:10f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 04:55:12 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 04:55:12 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link status
Thread-Topic: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Thread-Index:
 AQHadFPBx8nrp1zF/UK8IxmlbTRGybFKhXmAgACiphCAC0FrgIADC5wwgAWdxoCAAHeyMA==
Date: Tue, 9 Apr 2024 04:55:10 +0000
Message-ID:
 <OSAPR01MB71825881744DABB01057C6D6BA072@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
 <6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB7182F74119B93BB6D944C1B1BA032@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <661464ff8492a_2583ad29419@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <661464ff8492a_2583ad29419@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=2a72563e-62a8-4ecb-ab25-f81a3ef45662;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-09T04:52:37Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS3PR01MB6705:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 la6A9uC0SfSi3xWk0orYC6IVsqDlLEd1hZ6pFP/182drC4PhpW73TT+cj4AVvoEWbWhHqSInOlqp5pvJR4MNw10vdRGylmn4VdGXs3EvPXXSqD6HWWVyZReEj1ESPdyr41mTRJgAM4jy6UtXSeiW+43gtiGHFkYDi8nV6ofelrjltqQzEjGL/q6pxzwEbwiYMjL8Pbkz383g7fBM8Er3jfS4DUPC8fBE837tFxq8AHeTEiNxpurQPK/3m1UUGMcfgx4BQeALzDsMGinUsvdofvs7mT69am+tfy5rnS+sWGnd7wGrv3KsfMoHEiQjvcTmLWXGLyWTpSln3XjRjdeULz/HO8ut0gSa+C1+yE9pXEvN/nbiLs/S0hoAg1NOqvZ5sLOaApd8LRltT47HEEhy+ie4mQLRJa41j5YBGlJp0Zi5p9ta4dPDDpikUjMbr0cvg7p/qaHf5OVVzrGXMxPAtV39bl3LLsHhbdFt2Z1sSymlAbHBvT593PZ9RcQh94ZYZyukkoWNL/K2K3danDS16CMhdX+HbY2YFM7t4m248Deo4gONpZ5E4OCA5ft1P32d/W68kaLWEpGBAhqLBJ2zU56ILpqLxjPd6ui52gjvCPB9vU0V4hzQ4dEpsuofZiko3A1lzjPUgvBO7RwdCl6sDPgAD3sQqAUuwutF35u87R9BI7GNEsfQO9od8y2UgMaiOyX8bO6L0WK685nEPAcZXA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZWJFU3JrcUo3Z2RQQy8vTjd2V2U5SUM1blM1RG1abTB4NWF2QllwMU1o?=
 =?iso-2022-jp?B?VXhOQk50R1ZYbmlLMzFjbDJpMXJ5TGhaVGZQdGNQWFZnSkkzR3ZIUTdK?=
 =?iso-2022-jp?B?S1FZMzRFaStvV3FXcUZvem00RG5KMEZNTVJheDBDbDViK2tyTGxPV3lh?=
 =?iso-2022-jp?B?OXFZY0d4THFzYmJCOFZXL1VmbEp0V0h2ZGVpNGJ4NnloM3BFUlhzeXY2?=
 =?iso-2022-jp?B?UGpEU0hRSFVkdUkrNThkU2phVWJNMDVwYTZCVEU4dlQxSk5EdjI5UnUr?=
 =?iso-2022-jp?B?b1FEN3VSeVJldEZTV3ZQakRqYVlHY0l0NHBaRTZidS9CNm1wRW1BRUpR?=
 =?iso-2022-jp?B?emdLVzVrSmdUMWhZWWVxeStoY3laUGhjcXFsNWM3WFB2QVl6MllKa2la?=
 =?iso-2022-jp?B?UGVsRFFGWlZ4elVsUFNvQzJoT3pwUCtIOTE2L0p0dUUxN0tHc2dVRkk0?=
 =?iso-2022-jp?B?SDJDVUVDQ0NKanFiQkZzUWJOODVRem00ajVncGJiajE1c25BMC9VSWJH?=
 =?iso-2022-jp?B?RDAvYldiSDduZ3BuSHEyNVNLUnNXSXo4ejU2NjFWY1VsWXBJTk5Rc0NX?=
 =?iso-2022-jp?B?d0x6WDdzZXhNYkRrRmtMQVRWbWg4N0tablVSNk5KK0xVdlBQbXZnL3Ry?=
 =?iso-2022-jp?B?d3pKSFlCdlFqclk1cnpVV0pPS3Z5SGF3dCs0ei9yclo0MVNQTzFLSVFW?=
 =?iso-2022-jp?B?REh2d0poWk1GM2RkZ1dzN3VKUXFhaGNCVGRxZ1pDMHE1aWxlb0lGTy80?=
 =?iso-2022-jp?B?NXIwQXZzZ05nbmZ3cWp6QXlYSGxYaWJSN2RPdFNjK3lRcFo0YVBsVGtO?=
 =?iso-2022-jp?B?UjBDRGJRU2ZEVzAzU0MwSFRTNlFXcFRpL2Q4RkVzSVVhYTI2S3FIY1lt?=
 =?iso-2022-jp?B?RnQ0cWVteUJpL0NiVWFzVjdnUWJ0SkkzdVA1cnNsODEvaEdFKzBrelFG?=
 =?iso-2022-jp?B?ODFPS3VNdEtZNVFldUk5Y01COURGRVRzRHZSbFBZV0xwcHRwWEp3VmFj?=
 =?iso-2022-jp?B?UE4xNjBBYVhNU083aUZVVGM0YXNMVy9oaitjNzY1TFhlQUZzbktQWDVp?=
 =?iso-2022-jp?B?Y3RkbGwwVVhtSHdpcFlFckNkS3dCcWhrdE0vSmhuOE5TajV2S1M1dmt6?=
 =?iso-2022-jp?B?L29XQ3l0czR3M3RxNGlGZ21ja3JnSWdLUnlQSHROa2NPM0l1RW9WbkE2?=
 =?iso-2022-jp?B?amVjcy9wZ3d4d014K3BRSkpxcnVIbjI3dmxSalVXKzJvYXlBMzdEdHNi?=
 =?iso-2022-jp?B?M0Z6TCs2bDNUaWlDU2ZFN2N2Z0xudzJGcU4zMzF3bWp0dTc3bjRpOEZm?=
 =?iso-2022-jp?B?ZitCRk5YUHdnNnhSMTRJMWltRnBIOEt0eURnNHlpNjI0R0dQUjJPMXYr?=
 =?iso-2022-jp?B?UDJBVTBUNEJWMlBOTVhFUGJ2ckpzOG96WWViVk1jUW9mL1RQK0xjL3VH?=
 =?iso-2022-jp?B?NlhYVXo5UlJCK2c2VGF3aU5HZUF1eVd3SmZtTE1SYkN3N1VaR3p6UmlD?=
 =?iso-2022-jp?B?SlFEK2tDNE1lU3NRYkYva2cxcUZTNDl3eHlxVkV2cVUranNSZ005OTFU?=
 =?iso-2022-jp?B?NlRFMno0anlhaUNDSmp6OUkxTEg5V3lndGQzTlBTYnR5UllySDF6WkZZ?=
 =?iso-2022-jp?B?VFMrc3BUdjRISnZoYmxBS3VPM0xDeCtUYU8xemp5SVdrVld0Znd2WExy?=
 =?iso-2022-jp?B?Y0xsME00aEJLSFBsWENmNjJiMkdZTFlXQngrWFlXMjd0N1A1RGlpa0Zu?=
 =?iso-2022-jp?B?T1VQWGttZmtCMVF1ZGt2R0VzZVNydzM0c280TldVZkl0MnlxdnRZSlZT?=
 =?iso-2022-jp?B?OTVWcGNaSGh5Y1djVE00TU9IQ2lHcE4ydUprM2h3L1NOTGpyMVpXQ0VP?=
 =?iso-2022-jp?B?Sy95UzcyN2JtUXhvejJ2WEg2N0E1RC9lRnBwcHhTUytoOUhwaVZJQmxo?=
 =?iso-2022-jp?B?Q2ljbytCZ3krU01OOWN4R2ZRaG1FZXlFNEdkLzBLYk1kQXQ1a09XSWQ5?=
 =?iso-2022-jp?B?Wlkzd3pUY1NQWnIwK3htQnNyV0N1cDZlcGVaUnA1UStSRlNRWW9nci9l?=
 =?iso-2022-jp?B?T1BIRWZJQW9WL29YYWF1aFExcWpMVjZkbHVhN1VVQklLWDRicGxlVG5L?=
 =?iso-2022-jp?B?dDRObkpXbEg2TmVyaVRxbERWV3hLZHRxcGVvc2p6T2hXaFJ4ZDFodFhk?=
 =?iso-2022-jp?B?cFR5aHZRQnVlM25ueE5tNW9uWGl1aUg5OWg4KzFrNy9OSjg0a1Rpd1A5?=
 =?iso-2022-jp?B?Lzh6OUd0YzdmMjYyOHRxNXVibmNpSVVEekpmZUlEMDBoR3VMUW9qZFJu?=
 =?iso-2022-jp?B?dDlyb3R2cXJFRmxtV1BRUHI1NG1JVE9OQkE9PQ==?=
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
	rZpJAfJyaJoiA3MwUljg9r4zObqciP2Jx/1WmGTrPojR5Wu1VyCZHakqgLIEyUQqwftJMoKEmPWOkpbzWNffyZzAD/jae12Tn+Uui1zjIv66be+ewJm89bJWikvlH61jl8++t9sHjZdV79IC7YmX1jeWoRCQpkAlsdCvbDMI10ff9WUySy63gMkX/KW/Ls0t1+5RC+UcFrrOZX+c/eHhhqCjhKZMMA7kCsFfYwoSRu6f0nWTHmTI5tS+Vw8w0ev1G1gmjVI1MnaDJ9jterxlEGQc/0oEL6zMxItY47MgLNxsKJr5BvAUH2uUzqe8WeM+66pQZEA4JdR6SHUruW3x92UQTrV+nmu8yiN40Op9bnM1p2iXtfwLCqC8BmH/csafD5qVdVR4+drj3pbe6SSGILBYCZp70FdnH9MNaiBE0L7K99PFVXadosGVoN/mcnQ9q+SIFr2CU/1pxehgyCc8w8kHq56d6hnBV4EOOyxtLy+AQhpt0fNWbPar4qwt4fMnyOgm9Us6rRyNo535XUBm7+gAXYj0NwMgg1UPX9+L6jJVZyQ6EYK6WL5FL5AXZWKQFi+8YoM5FiTWH7h+tCk96tMyq2xZO1rE4vqN4IDoi5Tco9jG4KH9Vy6JVHmF3ZkM
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5c11d0-5bcd-4d8b-ed64-08dc58513c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 04:55:10.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DyAgEDx/6s5cjkj16EgAOdrwi1zNcCoZBinERQgNWMzt8o3on81cPD6aVVArbaolZ6GvQwGsPDmsBKTWOucuCS7EWKrt81caYi8kVWo4z0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6705


Dan Williams wrote:
> Daisuke Kobayashi (Fujitsu) wrote:
> [..]
> > I would like to report on some additional findings.
> > The process of registering cxl_rcd_groups to struct
> > pci_driver.driver.dev_groups seems to not generate a file in sysfs when
> looking at the contents of the module_pci_driver() macro.
>=20
> Oh, apologies, and thanks for taking a deeper look. The failure is becaus=
e my
> suggested example led you astray. I suggested this:
>=20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c index
> 2ff361e756d6..eec04f103aa8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -971,6 +971,7 @@ static struct pci_driver cxl_pci_driver =3D {
>         .err_handler            =3D &cxl_error_handlers,
>         .driver =3D {
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> +               .dev_groups     =3D cxl_rcd_groups,
>         },
>  };
>=20
>=20
> ...the correct place to put it is here:
>=20
> @@ -969,6 +969,7 @@ static struct pci_driver cxl_pci_driver =3D {
>         .id_table               =3D cxl_mem_pci_tbl,
>         .probe                  =3D cxl_pci_probe,
>         .err_handler            =3D &cxl_error_handlers,
> +       .dev_groups             =3D cxl_rcd_groups,
>         .driver =3D {
>                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
>         },
>=20
>=20
> ...otherwise __pci_register_driver() will overwrite it. This is a subtle =
bug given
> probe_type is directly initialized in .driver.
>=20
> > For this feature, I think it would be best to output the values to a
> > directory of /sys/bus/pci/devices/<pci-addr>/. To output to this
> > directory, the attribute would need to be registered to pci_dev.dev.
> > My current understanding is that the best way to do this would be to
> > register the attribute with device_add_groups(&pdev->dev,
> > cxl_rcd_groups) on probe and remove the files with
>=20
> No, the dynamic sysfs registration APIs should be avoided when possible.
> The above fix is what you need.

Thank you. With your guidance and the hint in the previous email,=20
I now understand the idea of "groups" and "dev_groups".=20
I see that, by registering "cxl_rcd_groups" with "pci_driver.dev_groups",=20
files are created in device's sysfs when the device is attached.=20
I will update the patch to reflect this.

