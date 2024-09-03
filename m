Return-Path: <linux-pci+bounces-12648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5138969642
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1537B20D08
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E821DAC56;
	Tue,  3 Sep 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="wfVKjwyx"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45821D54D3
	for <linux-pci@vger.kernel.org>; Tue,  3 Sep 2024 07:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350221; cv=fail; b=giL/U8P65OCg4M1R8e1u02mI0ixJjMum6vcSq59SvYVH/oyPFtytwGrfCFdFkGueXWOruq1hgImDETvm8eMcjg7bIMyeF3cLGbz8dOjPncRPLsD2z5QdhUk7WF/ayMJgHREomV4o/zipXd4PYXKkljAtMo2DvrwdHckxXEntW8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350221; c=relaxed/simple;
	bh=Cp3PuW8VwePyA4iPecAdXI4287xctdKnpEqUkiQB1aM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZTBOCRIPX/EaxaW2+/m9IG34XyLmR0D/0a7JcZFfCy081gmlqXwGB/+aKGiHzqE5iLKVI7Vx0Y1tdWH+zqmXndQN4vJSY/koorp9aEREWTnsb7Wsnd+aFWn1uR8F5rO8t8DErIU7YKddH5U2wh+Iy05hNbja3KoBJdFaeTRnikw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=wfVKjwyx; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1725350218; x=1756886218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cp3PuW8VwePyA4iPecAdXI4287xctdKnpEqUkiQB1aM=;
  b=wfVKjwyxbSUeQ/Kd/8fpKk56ZPhE0DNupQHvoWyR8cmGZBBj8XezXa2R
   waoKdCoVfEJN011zooZOs0M3WWA6EX/TCouxRMD+kDuUYbFuD+l0uJV0y
   vV2OBJi40/OO+DoYo84bQXBPHXyfoTHor0ja0HGtWzATuteBkD0l8OmjC
   Svsh20JiurtR1ReF0gljOK03rY+49bNZ55JhBicV4jzJZJgeMfkbQdles
   xbO5rT7xMbGtTNY42dcMuhw9OtlaUWvlLUqwws7/NWyxsC1gsnH/EphAR
   JunLt2ASNoqC6SgZktacdeownStjXcbcpvpvB9vwzB7OtE/surhKz6Xu3
   A==;
X-CSE-ConnectionGUID: r1YrsnB0SpiyRy+NuzcTsg==
X-CSE-MsgGUID: GTqaYPlGScWWliB5rPVUsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="42700903"
X-IronPort-AV: E=Sophos;i="6.10,198,1719846000"; 
   d="scan'208";a="42700903"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 16:55:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGzequkZ5sLdq4wKSLJC3t/FcAFhm0ln96LpeXheCJyyKPDhTe7pByyaMHxmH2Z9rnll5xFvb3Zn1GY3LWiJxwjICdUcrp7L3ZLjnYD96HfJu8YiPgQWwjIE0iJaD3d+mTo+uVkGrzkxday5kMLoxgjnSAOWPu7SpQMAvqVHbCo5moWm9c2Ck2UOyl1cSOixNuBMfanZwd7tjPmXbGTDzGVu6OEZZH1642NStbdY55vHtjf1h8hIAVLF7eJ/5pWJkG67hcXB0Wu+OSUFo2Ae1YCMyTcScyBudFZwZHFYu707rNtEj2VLE3ah3/AdP0+owrnIJBrTD9goHtlxj915Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp3PuW8VwePyA4iPecAdXI4287xctdKnpEqUkiQB1aM=;
 b=O8U8OufjQKW9xCpHFne7iiV/ZjwWNSB9rUeOWQ+RHcv/GMGGufSrPJrhRbW0fJSF9h4jwGs/gpZ30Z1w+exTSuGlUAcdnrXG/hVjdj1nbqn0xm0oaYRWaPqJKef8Jg9yoltnCSz3ctfQaNDrpjpuizllPCrvX4xnVKAVFOv2L7WVvSPP5mfAKbNNRVOPV5wcA26cVQaMQUxQsMglRcxB3KNr6eH7EJb78WdPNY5iQR+cAHUYDPTmPJijtvuqzFK27GrJ7Nxijs2mOtxOqogxTqffKmSkOOews8271dTr0aIPdmNqeIREUJ/ovtWyBmI+n88Ukw8uujCUkLmEYbOgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB6382.jpnprd01.prod.outlook.com (2603:1096:400:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 07:55:44 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%3]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 07:55:44 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: =?utf-8?B?J0tyenlzenRvZiBXaWxjennFhHNraSc=?= <kw@linux.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Topic: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Index: AQHax4L+i4Kp4u4qEEmK0TgyfRRzXbHv4xSAgAkfqVCART+n0IAG6ZgAgADxo+A=
Date: Tue, 3 Sep 2024 07:55:44 +0000
Message-ID:
 <OSAPR01MB7182EB662ECA6E4360E63128BA932@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
 <20240710110519.GA3949574@rocinante>
 <OSAPR01MB718231921A414BE66FDFA555BAA22@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <OSAPR01MB71825F612653E9893662C789BA962@OSAPR01MB7182.jpnprd01.prod.outlook.com>
 <20240902172820.GB1912681@rocinante>
In-Reply-To: <20240902172820.GB1912681@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9ZTM3YTBhYzctMDM5My00NDFkLWEzMzctNGEzNGE4YjJl?=
 =?utf-8?B?NmVmO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA5LTAzVDA3OjUzOjE2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB6382:EE_
x-ms-office365-filtering-correlation-id: d111c537-21b9-4794-0656-08dccbedd05e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eEc4R3NtSmUyRXdyMS81QjRTZnFLWlhMZnhBcllkMVFsQ01sSGVlVCs0ZXZj?=
 =?utf-8?B?VmozZnY2VkJaT0dkNFVLc0lKSE94b2E3YU5Lb3FXUE96T0ZSVWphU3BIVXFr?=
 =?utf-8?B?VzVRZHpDMFhkZXFNeWwwckI2QVJEanBRVnFBcnVFb1BzTkNKeDd1OHJSSTNQ?=
 =?utf-8?B?d0QxQ2RwNGt6dTRvb0d1MHV1VzZsTUhBVG5maEprN3NhK2dONis2dmpTaEl4?=
 =?utf-8?B?T0FHQklXYXdqalQ4OXNDVEluQWZ6dFVYQ0ErOVdSOHArQmMvOTRLVXlQZTlJ?=
 =?utf-8?B?UXNPMURpZHlRdkNTY0FEd0daRGNFMXducUllOHlpWm9EL3J4dUlWOFZCMWFM?=
 =?utf-8?B?VTNqdnAwenFSQytOTTJwODI2TnFpMXlaN1c4MHQvVFVMZVdiR2V5N3pnS2t2?=
 =?utf-8?B?QVRBYWpjTk9EL1FzeWx0WWY2OWFRb3JBbWRtQXFYb2dpditrTmZVOFFOcTZn?=
 =?utf-8?B?M0tLcGFCVUZzSGRYN1VndDY4U1AyL3hnUmlmTUp0dXZnS3J6SkZTc0YvNU9F?=
 =?utf-8?B?VXdSVVR4dnQxYUJHcUk2U1FSejhiWHBiTDFxaVQ4L1piRzM5R3Axbkc2SnR4?=
 =?utf-8?B?YUc3WW85NDV2NmdMUXQzeXhyUW1HemRUcFVkQ1hlaUt5czFZTGp6NDJxM0tz?=
 =?utf-8?B?TzVjU0llRWxPSTRhMVVNbmVZQXVsazErK3g1VjhnUlVGSzdSSHNwbDQ5MnRB?=
 =?utf-8?B?VG12OE04ZEtScXdjQmRDeSttS2V1Yng1cytuREhrelhldU9adHJqTi95Unl0?=
 =?utf-8?B?NTVrc1VsdWt1TlJvUVNPVlFwMXcwR3FiT1NuelpEZVVwSDRXcW02cVozQjZI?=
 =?utf-8?B?VTJMSmNGUUgzY0E0VnFaeHA4am55VldHRVcrbFVVWU5PZVlIbGxiMXh4OENz?=
 =?utf-8?B?aThQUGZ1V0dKUmZlOFR3SVZLZjB6UVlxUlhsTGhzY2RQVXRzQktzTlNQOW1Q?=
 =?utf-8?B?Vzcra1hUbUJHNXFxeDFxYVJXeHZBb3ZtczVvb1BLM2MzNkJIQ3M1QmVFL1h1?=
 =?utf-8?B?MDdCN3VnaG5CSHl4YXN1NGdpNW5sRy9OZkNmci9yZ3p6R3l4UXovb1NrQ1g5?=
 =?utf-8?B?SVlrdUhPdWlXQ2xlVDRsdVhuQ1hpcDhFSFpBemlyUnRvL0tmV2tFeHZrUHBP?=
 =?utf-8?B?WlIrZnd4V1RSSU9LVnB0cFI4UzRIRDlZWjM3UGhJQlpEWG5VK1BvWFpUck5w?=
 =?utf-8?B?dnEwZkJjMDQrQmIzY0w4MitSRTl0ekx6RElTS3FMVVU1TFp0bjR4WjZTOEVi?=
 =?utf-8?B?SStISmJ0bk53bzRqOHlZSFlXdE9sS1FzSnBWVCtJdWgwUkZDaTlxZENUWEFI?=
 =?utf-8?B?YTdjb3Q1V1dtdVllN3NSaWhaWlM4c3lHZDdWZVNvWHd6eHJZVHVWMTRHbWFp?=
 =?utf-8?B?Vm95WkcxczdWN0l0UEl3OFBIVWo3bFB6Ty9FOU1YNnAzcjZQUjNHZ3RYdTMx?=
 =?utf-8?B?WEp1Nk84VzAxUUd4MUZQeUZUWWViK044d2lOYS9uSm1nU1p1ZHN3U3ROUWYz?=
 =?utf-8?B?VmlZaFJWTi9KeVI3dGtUdU01MEczd0k1cHJ4ckFKWlI2WWJXRFFnMFFKa1Rl?=
 =?utf-8?B?MC80bGhKQWNDclU3dU5HblVkdTdkSzQvWGptN3VTb0hjT3lndFlxYlp1TVAx?=
 =?utf-8?B?THBQMGFPeEJoUWp5N3FBcUZvU0szRkVNU3lvMDkvZGQ4NGg5NWdJSU5GbThr?=
 =?utf-8?B?eDZhVTNOU2xHaUplMklIWndRczgybkpPUTRaZWtpN1VrYzl3dUEzelpLSy9k?=
 =?utf-8?B?ckVWWjZuekQrSDdoRXJyWndtYWpTbFlLeXEvdVFodGJWZEtNREV1STl1RjZa?=
 =?utf-8?B?N2hoZmJXYm1YZXp3WTg1YnllSnREQlhEaXIxemZ5S0o5c0d1UENyeGJZOFhP?=
 =?utf-8?B?ZzgzNDNCRy9jRklrcHN1MHR3dzZCckZaNUhRVVlLUlNJSFhoTktjbjFmQmxx?=
 =?utf-8?Q?BaeSxDHQ6Oo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3dDMnhubXFhNjNCOFg4QXBvR0gxZTExYnVJbjhscWp0RnZFZEgyZEQvWFdt?=
 =?utf-8?B?QU9hamZCbWNlQkRTc3hEeFQ4UTlSUFBsV25yRjdFRG1PR3AraEladGlJUHBx?=
 =?utf-8?B?OWRaZXp0a1FNRG5UdnNBY3NVeEVJaUF3M080VGdJOXhWZnA3Zkd5SGtWa0lv?=
 =?utf-8?B?aEQ2dUxRSFpNWGhaTFJ0WFZMQ3B4L2hoSVZLVjV5cG5PUmVuRnI3YXVxcTlR?=
 =?utf-8?B?cUpZblplS1pnUG9jampxMjF5dW5iTDhkWWNyeS9XWE1lQTBkNFRKekdVUGxo?=
 =?utf-8?B?M2RvbG45Z01XeVJUbnkybTUzaDAyeVpyd3FMZU42VXNjSGFwVjN2MllZMVBU?=
 =?utf-8?B?Sm82ZzZIakdpd0JRUTNZM2dLekFYZ2szZURiajYzU2lkQUMyWnh2U2ROT0J3?=
 =?utf-8?B?a0l0NEIzYUl3a2RWcVZCdGk2Uk51d2N3bVlmTS8vOUtXeDNobG5KNFg2dEMv?=
 =?utf-8?B?U1V3M0VkZ2s5SDJ3dGRLWEI4M3JOTkJucjd0M3pPKzY5RDArTUxhOEE4MzZF?=
 =?utf-8?B?ZmF4VzdueWJRS01qaEZDUDBQdGp6T1pPNWNEemVxWkhwVG1teUJvUVVxcndV?=
 =?utf-8?B?aU9OUTBXYmdTS2xmZlhRZ1ErbVdzSFE0TCtuNTNVa0s3UFE3Q0tnV0Q3Q1Ax?=
 =?utf-8?B?L3RZSXVBdFBLUnhuQUkzbytHdUd5clEzSnBhU0xRZTRQcFA0SFFpbVNKaWlJ?=
 =?utf-8?B?aGhvS1pBSzJQOU0vcnoxVWd4M29ZVHZjSzA5MjNLM2FzU1dNcmJJRkk0dUEv?=
 =?utf-8?B?U054eWNDeFM4TWsxbitaSGhZTXA0U0IreG1IY05MbnQwdEwyLzduekJReU1o?=
 =?utf-8?B?NVRJK1Y3K014bVQ3TDFqcmdlZkpmV3pQL2ZNTG5NZ3MwVStVamlsMHBHSlZx?=
 =?utf-8?B?Z09GM0FTMFd4VDEzRTF5MWVjM21YRG05TXFpc2N1MzFUaTVmaElIelFMRyts?=
 =?utf-8?B?N2ZxUEVwbFpLbFZtY3k0bXNPVWlVSWFRa2wrWWJYdHZ5Q1dwNmVnZ3BFOExC?=
 =?utf-8?B?M203VzlobzRubzg1UzczZVBlbE5ucE5IelhVQXpnenhRbE5aUVFIeXlzaHg4?=
 =?utf-8?B?R2tUQk5rNTN6elo2cHZJNGFyUmpMZFQyaUU4R2txbVBhNHBsY2p5bzR3VEpv?=
 =?utf-8?B?TG1oWjkyY2FKcmJCTFZqQW1hR2lXQzBQS01sV2dFdWRCbDhSRVRla2lDYTN0?=
 =?utf-8?B?RitPU3E4N3FDdEVkemxpOG5CcHVrV2dBaWttTWZ0WXE3Z3pHa0lDZWJJaGU4?=
 =?utf-8?B?enRwbG9vUmtKSTRDMCs4bU9kU0FoWTZDSjB3V2QwYWluSkhOemlSMmJJR0Rv?=
 =?utf-8?B?OUVoSUdoUGVmcHNsMUlWMDczMWlod1dqK2xTWXduTW5XSWhJbGZma2YrQWpQ?=
 =?utf-8?B?bG1jL0ZnaVIybWk0RFBhVGhpT0lBSEJkY3RCWVlsR0dValFqNXAvTHpVSENv?=
 =?utf-8?B?Zysrelkwdk5XanFyaUhDY1ROanRqbVhLWEdHcWJFMS9peklsaStES1drWm51?=
 =?utf-8?B?cVJmT0xvcGd4ZmhKMUY2VklVK3BvbFNleWZyUGtzY1oyRzFnUU1SSDZQRzBC?=
 =?utf-8?B?NDlRWi8vbDVQZkxLZjF5MVd3OXNGd0NvcTlVS0tBc1B6M0w3NlQ1bk4yY01N?=
 =?utf-8?B?K0tGNm1Xdlk1ajUyZFFDSGFhMzY3WDZUaExlWThLaG5IaVBSZ1dqV0VIZDN0?=
 =?utf-8?B?dkZtdmJiZHFiK01JQXBUZ2VyY2NOaFNFbWd4R3FHSVZDckwyMzM0R1FrbVYr?=
 =?utf-8?B?K3lsK3pEQWJrdjgxQUEzME50UWNxVzZSeFhyYkdzS2Y0Mm8zaWVkKzZ2V1Nj?=
 =?utf-8?B?NkZIc0tDTzZxSnNGYjI3dDVhWUgwai9wY0VQbVExZXVJYzNoZEhKWVRERlg1?=
 =?utf-8?B?YnZuZTZxN1hxRk5jOGdHanovdlp5dE5NK25TaGpHQzRlLzN4SDd0N2lwdTZ3?=
 =?utf-8?B?dW1tNFhmZGZCN2ZzZkxPemQzS29pT2doWEdZdFVSZ1ZhYzNxL1dpZmZxMnRO?=
 =?utf-8?B?RnhsTy9KZzROTGpSRWU2a0ZqdUxlM0FDU0RnV2I4M0VudnhMdFZ0cHBPYjJR?=
 =?utf-8?B?d1ZudFgrS0lsNkhoaE9WaVhTVTBrdHBsM2xWbloxU3FhVDVWc1FyU0FBbmpJ?=
 =?utf-8?B?N21KQlBFQjdiY0cwQ00wZjBJam5MK2Vhb3NmTHBpMGZWeU52RFVNOGlwNkx0?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hpE45ZSDezMLTHGA9bKvO4AEqHsxg104C1n1wiogcs/aAiHtEImpYwO/KxyQV+5wbX/j3chmDenvCw7m+ctbn79SmOAHThPY+nAk57Y4cVnWv+7JMGi5NH9DWJdLnEMwttdnjdl9HXgNkNjUT1045EJDqu+RyxCj2w6oLL6it7MHD754gMlygDflrfgaiOy1OMAk/al8J5XJ+BGLqyhixUM/7x8tnoEjLDYHPjiReAFdzc+egZVcobWzqujq4ttP4BJGEGUf2WgZBEy8Frki8GCGZT3ySJhcIoToYUJvTWOBO8HgBAYcOrqtPbtI031h4OXnWdDVbOdARRR8JERQBtSmV51JtFcd+SQXiv9eFI/GURLz6+HP4ENnFGw2dNp/Qk1nRFBt9czasCA2XkE3BB+MQ7qnIOxlUlDcII+6qyI+4fTiimR4IQEj/cqLm8V8miRCp4RnMNL3IoXIAoOp6XinleiC8i9ia8fcwGi564iUXu48POUdw7pXa+h1ZjQADTBvpf4JC1Ub56N6qhYkobXkfsYScaaBsqBwsVUUtWN93WXbXxGqWDoRWFZJlHJwFSKB5WfihBfpjxCGmkqKqTGcM9157s5nBnTR/DtXZPGhG44BiaFwYWd8698awE90
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d111c537-21b9-4794-0656-08dccbedd05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 07:55:44.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fFyeNs+6nJDI+Q5rskLI0sZvt9eEO5P+pZyYNNapzGrAmWRAJ2wYi8OJVBC4p0n/tRzNjEgmbX4vCNcu/yEpOPAaUxIV/tyglfUOvLpirm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6382

S3J6eXN6dG9mIFdpbGN6ecWEc2tpIHdyb3RlDQo+IEtvYmF5YXNoaS1zYW4sDQo+IA0KPiBbLi4u
XQ0KPiA+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhbnl0aGluZyBJIHNob3VsZCBk
byB0byBnZXQgdGhpcyBmZWF0dXJlIG1lcmdlZC4NCj4gPiBJJ2QgYXBwcmVjaWF0ZSBpdCBpZiB5
b3UgY291bGQgdGFrZSBhIGxvb2sgd2hlbiB5b3UgaGF2ZSBhIGNoYW5jZS4NCj4gPiBJJ20gaGFw
cHkgdG8gYW5zd2VyIGFueSBxdWVzdGlvbnMgeW91IG1pZ2h0IGhhdmUuDQo+IA0KPiBUbyBnZXQg
eW91ciBjaGFuZ2UgbWVyZ2VkLCB3aGF0IHlvdSBuZWVkIHRvIGRvLCB3b3VsZCBiZSB0bzoNCj4g
DQo+ICAgLSBBZGRyZXNzIHJldmlldyBjb21tZW50cyBmcm9tIG1lIGFuZCBmcm9tIEJqb3JuDQo+
ICAgLSBTZW5kIGEgbmV3IHBhdGNoIHRoYXQgaXMgbm90IGFuIFJGQyBvbmUNCj4gDQo+IE9uY2Ug
eW91IHNlbmQgYSBuZXcgdmVyc2lvbiwgd2UgbmVlZCB0byBhbGxvdyBvdGhlcnMgYSBsaXR0bGUg
Yml0IG9mIHRpbWUgdG8NCj4gcmV2aWV3IHlvdXIgcGF0Y2guDQo+IA0KPiBNZWFud2hpbGUsIGxl
dCB1cyBrbm93IGlmIHRoZXJlIGlzIGFueXRoaW5nIGVsc2UgeW91IHdvdWxkIG5lZWQgaGVscCB3
aXRoLg0KPiANCj4gCUtyenlzenRvZg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZGV0YWlsZWQgZXhw
bGFuYXRpb24gb2YgdGhlIHNpdHVhdGlvbi4NCkkgd2lsbCBjcmVhdGUgYSBuZXcgdmVyc2lvbiBv
ZiB0aGUgcGF0Y2ggYXMgcGVyIHlvdXIgc3VnZ2VzdGlvbnMuDQo=

