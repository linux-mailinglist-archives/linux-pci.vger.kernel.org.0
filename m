Return-Path: <linux-pci+bounces-8280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8EC8FC471
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88FE3B2B61E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4101C27;
	Wed,  5 Jun 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="B1S2GulO"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C531922DA;
	Wed,  5 Jun 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572125; cv=fail; b=ouPUTXprpFFa5/mUT+NroGfzfe+1f2b7dpvx/HlOjC1UQdtt54QS/XuqMKTJfliow57qx3cOBXmmNw9iBKLV0rV9PgjRhlWv6tc7ZimjnSoAKSmaOVNNhks9fHYfqja8kb1lSLsWRMeUNRsIQV5bbEOAQxInpvuLUTOdZR817WQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572125; c=relaxed/simple;
	bh=E59xtsST69Sd8KOgY7SC7YaS7JUQ67C9oA7KKbJKIPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K38MJmqMzSWo1sTarfCZyULEoQkxeSVmfvdh2PNHBN7rXPwhDWuODdQAPkiM3UFhvVpP3GXbrJWG8sqnzF7lxd6y1vGxxHDlY/Pw58v4EJ32ldj7M/q+Twelv141Tih1ehb5lEXNVYpiVcqhHs0Io1qtsSkqzdrgsOAXAKnjA2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=B1S2GulO; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1717572122; x=1749108122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E59xtsST69Sd8KOgY7SC7YaS7JUQ67C9oA7KKbJKIPQ=;
  b=B1S2GulOdlRrZ0v+/+xRjW5NRsqsSQn480eLEv5ilQZtetPSBZFIwwJn
   qrCChuOvNkQYRU3Zp8+ypLdnFbJzrlOygxzZcBJfT/R98KUR8fsUd1Jx8
   zxKVpeVgIGLsb2tyX9VUa8FAwGpdObhUDSZ/yF9FgB823mGo2JyKZepnA
   upYiVUZy2pXOYyj6cda+zXAgXMqDXCSZ63OvTL/UDAAu6/xyXGRDIxcXc
   kt7801g60QOd+2YX5NRc3w0KmJrGsvY1IlNDGe8K/u6XeE577DNXhHdGQ
   3+DvHdNj3ErsEjjgFoah/A9yOuWxvbfQeAgA8uC5coVbIdoPVksfMqNjs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="126118284"
X-IronPort-AV: E=Sophos;i="6.08,215,1712588400"; 
   d="scan'208";a="126118284"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 16:21:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8Bf1qpJrK6/KAawmzb3X0BJNbyjGj/UQHJrTrbD+titcx1IdlHW2gwLwhh9BsSZIBtgkbGfwFqD057JK/MAvnwc/4et9GavtZ4E0pFd1Z7XKd1vGaljto7XeLPXlhI1RH+I8V6FYwZCkBpENkYB1chS1IBvyQHjihZ/Xjwxl2cfX7yMCk5QqUaOyHF1v/BuOdGK3H5iKhUJTu5BodsQUHN94jkuhcQeE9SxIL0nsFhBL8HkL0kRSAE8HEpgcjXFC8WK/gZ85t6Bjwr+QqmTh9moCbcMqvqXpCWtdgw7e4guEvaTjVHDQHiJQbM6wAYpH1zdzhEe8Jz6Ig6HuMeIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D79D0pHpOoO5ojlByBL9uDXeuWYa0iXs1RTz4UMpx3s=;
 b=WDbEA0TbaLgfmGGSFtIySjHedW7fcM9J/EjGrztAeTYVumIXswKjc/KCut1O0PL7FvBu/KOuNgF4OJIzT3K8P6ZuLO6WsYhIBh3XfqKMcltsvlQDl+aM4vDwX9FTvBbIOQkMF9rtxOx143U3suxn3zhX7EV59x0WI4r1kolLgxuuxudJKkJHPO82z38Rf10wwvblIbvq+6nKLUdToi3Y/DoNTR+HH6Exn3Bc6kJxbqKNT0tFF+ebSFgSXzHH/1YP4PAqpfJUL0q7WXqiWw8eoopcGGr8bAD3cVpL1ICSyNEDh55+R9KHzJExrj4ymsR5vCtFt05Dld20XawD5eD96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS3PR01MB8044.jpnprd01.prod.outlook.com (2603:1096:604:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 07:21:46 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:21:46 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "mj@ucw.cz" <mj@ucw.cz>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v7 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Topic: [PATCH v7 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Thread-Index: AQHaoqyM/gJG8L/o4EKrbtf+maqvO7G39EqAgADzz0A=
Date: Wed, 5 Jun 2024 07:21:44 +0000
Message-ID:
 <OSAPR01MB71826C386ABCD27C0041EFEEBAF92@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
	<20240510073710.98953-3-kobayashi.da-06@fujitsu.com>
 <20240604173241.000009d9@Huawei.com>
In-Reply-To: <20240604173241.000009d9@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=5641713c-1b99-45f5-b38c-02ce0d5ebab8;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-06-05T07:13:20Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS3PR01MB8044:EE_
x-ms-office365-filtering-correlation-id: 73e3cb82-8e9f-403a-2f20-08dc85302855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TEZnZEVaN0h5ZzVHTXFHdk50LytFSFVtYTlvZHZDZHNQSkNXM0JJbEJi?=
 =?iso-2022-jp?B?ckI3Z0VFejJYR3BqSEtxOXhDSEJRc0FFdG9kRE85czFlbS9BZEJaOXZB?=
 =?iso-2022-jp?B?dGxQSytTVFhicVplOXdsanZGS1ViWHpjR1lLOERUQndYRGVWN2h6YSts?=
 =?iso-2022-jp?B?ZVBWY3pRMnNnanhIQWM3ZUpwUG0vUDhGUjA5cld3ZjdrYmVEeFBibjl6?=
 =?iso-2022-jp?B?cW1kVEZNZVMxZlg1bVlpb2gzd1FyMjA1Zk5TeWVIMjVKcFNMajBuVHl0?=
 =?iso-2022-jp?B?MXZTdzB3cTBWSmxIWHRCNjZ6NTltQmV4V0RlelVFNStpeW1FR1hVbzRI?=
 =?iso-2022-jp?B?TmpiWThjcmw5ZmxEMVIvVktkQTRxQVJpQzM4S0FnbHo3Z2N1WmNoejZU?=
 =?iso-2022-jp?B?VS9GSVlqM2swMjZBOExodEZHandtZTcrZUZqSTRPRExtV21iYVV0WGho?=
 =?iso-2022-jp?B?K2Z4a1lQUXJlMExUWmhSYzdFNENxL2NQM25ZazUxMXdsUUpyQWdnbTN0?=
 =?iso-2022-jp?B?VU9wYjQwZ2ZhSGhROG1IMmtseFgzdHJBeVN4dDFvM1IrTzVtdzFNZHZP?=
 =?iso-2022-jp?B?V2dkVHF6ekcxTy9KamwxMjZld2UrNExSRVN2RGZUMHVOU3BTVjM1YWZk?=
 =?iso-2022-jp?B?R2VNY3pMUFFzTW9MdG1yNXo5N2tabGJ0SkQ2SzlzeTRnMmYyUEdrVUVj?=
 =?iso-2022-jp?B?YjNJZUdyQnFLcVJDbkpuSVR2Z0IvMzNoYXVYT1lGMUxNSEEyOUJUTXIy?=
 =?iso-2022-jp?B?NG5YNzFBeXlRdzRkQ0FrRWw4dHRYeURyejNycTNhSCtTMW5URDd2dkV1?=
 =?iso-2022-jp?B?c1Z2YXcyT3cwUldWNWkzY2RXdzdXckhZNGdEZytXamFpc1Vsenk5WjRi?=
 =?iso-2022-jp?B?UzZBRWgwN2FTUkY0ZUQ0Z05PQzlxaFdxWFM1RVdXNHJjZzkxTFFNUDhL?=
 =?iso-2022-jp?B?OHpENE5kRVE5RER2VlZNSzJkR1g1Rmp1M3YwN2pQbmlPZmFla21La09N?=
 =?iso-2022-jp?B?N1RxdXV6VEhuTGxvUDdtcTFHMHVBaENadEZsQzRZWGFzcFJEcUhUcHZo?=
 =?iso-2022-jp?B?VURpWXo4NFhmb3dMamNlTmp6cHJaUTdJSkx2OXMwWDAvcW05cWpxWSt1?=
 =?iso-2022-jp?B?NS9GaXU5RlltZ0k1T1lDekY5MkY2YkFGNXV0UmxSU3dLc3phOThhc2ZP?=
 =?iso-2022-jp?B?cnRBVEE3dkdnbVY0Y0libDVtM0Q4T2tTU0pTUWRadFErUFEzN01OcmFF?=
 =?iso-2022-jp?B?a2NRQWpTRXlQS1FCN2NjYmt4Q3FOa2RyY0NjdVFZanRpQ0pOR2RzSll6?=
 =?iso-2022-jp?B?cXJJcXdGR2FQM1oyS1AvOVNXT1M0bVR3NGMwTkU3T2E5NXZQNjRoYU5n?=
 =?iso-2022-jp?B?QkdiNEhNREFISTRGWDR0dDdRK0wwSVBrVVk5dDhhWmJ2RGJCa1hMZXdj?=
 =?iso-2022-jp?B?OFZpalFiZHcxN1N5dWF1Nk9DcmR4TnRESmVUTlBUZllCQUhWcEZId2tL?=
 =?iso-2022-jp?B?TjdkTmJOMi9xN1lnbzgxSGhUWThSM24zYmhNYlQzUVRNb053K3hsaFlu?=
 =?iso-2022-jp?B?Mlp5T3BqM29kTjBlYklJSHFEZ3R0YTVUTmZUSGRBL1RvenZqUVQ1TWVX?=
 =?iso-2022-jp?B?T0lNOUFHVzhDeldGdlcyRkljY1ZhaTF0ay9xWHJOeFMyZER5Zm1xQWpw?=
 =?iso-2022-jp?B?S0xzMStwblpsWTdBNG82QU9YMzNOdTZlTUsyM1UwMStGeW1vQnQ4T2R2?=
 =?iso-2022-jp?B?U0ZITGV6WTFzbkkxMkhLSGhteTlOeExkVnhJdENrQ0x0THlXbnIyZVl2?=
 =?iso-2022-jp?B?QjBnbS9YZFpkUVpESDV3V2tobm9xRHc2WU9zM0VOL1kvTnFlN2RnQ21Y?=
 =?iso-2022-jp?B?YWpaUWhvbzJnSXpvTDN1Skc4N3JPZ3Y4MEhCQVROWmNqSEExeTBCTnFC?=
 =?iso-2022-jp?B?Nm8rZTJHRlpXOGlmc1FEaDJrUUNmUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?c2hsZGFWY2V0RklMNzBqVlVleGM5Q3MxdFY5TlpWcHlOdkpRU3ZXZmlN?=
 =?iso-2022-jp?B?Y0RTNm1GRTNHZFRzb2MvZTUreUdLWG90ZlV0VCtMRjJQUm1LQVczQXk5?=
 =?iso-2022-jp?B?U0lhMGVaeEtRUjhlYWRLQU5JTC9nM1RLZmFwN1JhWmVVSWtQYzZBSyt3?=
 =?iso-2022-jp?B?cUFEWkwvcTYzczY4Nml5d1FjWmJTckluRHhJUGZ6U2Uyalp3d25rZDZu?=
 =?iso-2022-jp?B?QTlldnhiZXVMMjByU2drWkx0UHhDSmdNSnhyQ0xnaW8yb0U2S3ExU0dP?=
 =?iso-2022-jp?B?VklGaE1FWmI0ZHlzZHhPRyt6TzVrNEU3cmYvK1lqeGI5cEN6ZTg4MDJT?=
 =?iso-2022-jp?B?dllyaWc5UVNuVVM1ekNaSjIzOG5iWlNJbWdQaXRYbExsSXBLKzNvcm42?=
 =?iso-2022-jp?B?Ym9jMkVUbG52bmxWU0JyTlFocjFUYUNRMHo3eU1HNlBPYy81VFh4MFlE?=
 =?iso-2022-jp?B?cFlCSkF4UzlsNGRxRWxiYnBHYTRzK1Nzc1pZNXFacjVWL2V2RlN3VG9x?=
 =?iso-2022-jp?B?MlRMWVVDa0Z2ZmhKYjY1cGp6Vm4xVEpubzNITEtUeG00eTNZd0hKN0dI?=
 =?iso-2022-jp?B?K2Z0ZHQrR2Q4QkliRnVJMGN2ZnAzUjdrZzRpL2xTWi82UHhtQndZMkVk?=
 =?iso-2022-jp?B?ZUZNRXI2bFhYeVk3U2FGdVAzQStGZnRXNDRPSG9VajZtQ0ZsRThQWHpQ?=
 =?iso-2022-jp?B?bFFyR1BieXVnVjhoWWZqWWpWb1krcnhCQlJCOFpxK3hGd2hIRHdRdC8z?=
 =?iso-2022-jp?B?STNFV0tVQ2h2M3dMYXhKNkpHd2RIOGNNQi9wbDZaMlVkQkFqeVQ5RUZw?=
 =?iso-2022-jp?B?UktCcEtwa2JPcEF2Q1VPMEt4NkEvMHZHZWQrUGErMTJXSWtrS0VaTFRu?=
 =?iso-2022-jp?B?QS9rU2ZFTWUwYUt3aXFWQi9yQmwrSzlpWkE0N05RNXkwaW1CdTY0c0lN?=
 =?iso-2022-jp?B?NjhDSDUzbGFqZGhFVExTSGQrZTZuWEdPNWFhVElPYmM3WUdWV2lvTGdm?=
 =?iso-2022-jp?B?cVhNZlJSam5qK2JqUXFlUTl1MytSM3d5dWUrWXFVWG5rTi91Z2V5Rk96?=
 =?iso-2022-jp?B?QWYwdGVRREV2a3U3MXh4WkhuZEE0OUNZWjVwSUMxV0cwTFlQV0Z0eXdz?=
 =?iso-2022-jp?B?RDJrWU0xcURVYVIvdFplMVV2dkUvamRYKzBFWWMvY1pabXlmWjl1U2F4?=
 =?iso-2022-jp?B?VnZyaXBqZ2dkRWVsUUZYREF1b3JDOUNqWklXSlpId05kWUtnUDFFVm9Y?=
 =?iso-2022-jp?B?Z3NyRDE1b2YzeDNOU2RPeXAxY2J4a21tdW0rSkhwRGw0dWpPdURRUndx?=
 =?iso-2022-jp?B?d0JnQTl0WGl3aUVtM0tjMlY0NHl3Y2Z4d2RTRXhlRTdFOTE2UlUrWjlJ?=
 =?iso-2022-jp?B?SVNVNG1yVmE4c3owS2c1NmlIbUwzUmpMbElFQlpiTmMrMzBZUU1vYmt6?=
 =?iso-2022-jp?B?d1BjTzFDbXQzTkNKbFZLRWJXcGVJTkNOS09uN2l6SVl5SVNZbVh4SEVN?=
 =?iso-2022-jp?B?eDE0emdPcmdVcEVwTmUxYnhJT1daZnRFVjhUS3FlYjE2N29LOWZUU1Zw?=
 =?iso-2022-jp?B?ekpaYTgxYjNZNXEzY29tdUUrUVB0Ykp6MTBuZUY3eUkxRUZsTTQvRUVK?=
 =?iso-2022-jp?B?b0l0MDl1bTh0NzNTWmMxdkJ3OHF3VlFTTjI3SlRkV29LUzE4N1drYWF0?=
 =?iso-2022-jp?B?Z3hreWd1dWw4Qlo3OHFWbEdtSGZoZ0VnemJaVHlTUlFjZ1B3d0ozckRy?=
 =?iso-2022-jp?B?RGNROFNyaEJoT1I4MWdhcU1udFZrQ0ltNWJzOHMwYUZxYm1YY2pEWGl4?=
 =?iso-2022-jp?B?VnZOMUdQbHpvQTBxSFkvNUFXN01XNzJNalpRejJEVkVncUd0OGx4SU01?=
 =?iso-2022-jp?B?S0F4OGp2djUvSi9NNTlvRGU5aEN1dkpMWnhidHB4R2NlaG5YelhLeXZr?=
 =?iso-2022-jp?B?Wm1Jalh1MW4xTWdJY1RWb01neXUrTEVHbUM3YjZsT3hwYWpGZjJLSlpJ?=
 =?iso-2022-jp?B?Rit0VW1hQzgwWVhJODJRTnZya3B5UlJnOW1pcGkzbGN4MGZZNldXcGEr?=
 =?iso-2022-jp?B?dFhXSHo0NnZVL2s4dmRGQWV2V2sxVjlaeng4Wk1qeWdlVEs5MnhTVVpu?=
 =?iso-2022-jp?B?TGpmRldsVnF1ZmJldTFHa2FtMVk4U0phQ0swOHFvalA4MTFsRTZJNmhw?=
 =?iso-2022-jp?B?UUVzbmxxY1NUNGhjWXBkT0dNVkh4UGxvUDFBb2xVRzdaQ3pvMlMxS0t2?=
 =?iso-2022-jp?B?OWFJZm5JVlNscmdWVXAvaEo3REFCbmhmOGQzNFRJTHhZS2NwY3AwcTQ0?=
 =?iso-2022-jp?B?MXVacHRqVGgrYnF2RDRQSzlyM3BLczNzQWc9PQ==?=
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
	OlvEL+vOg0sQav9a6HHDouLZxASlm/T+ZnDtR74n5TNAeyyHQG5fv8SNDnaiK2vU52uzzgR4dNwYDd3r7HA9n2/Fhzs8f7/JsozGEGC2KNX/zl19f+tON3evGttgvofCqPwUVpn/OVPdjq8iY0JJXJjGL77co6N8BSBL7WUZUYB9Cp0O/9MqetV3M06kVFLUzrOeU+badHsWask1Jr0xz4A9549lTKHhTAoci3hVL2RDZxlfnZoWzkOy0txsjsURBtBhcXUwFvUMCeuV6LkNk2fiNxjIUGlVQb6lKGX9EUiH05idxokK7eJMYn/2MsIcHXsw8bfWpYjl1tlHkuwj6LHqR2g1ExD0ptlO8tNEowR8YINGt7xEop20ncyUjmAThapW5Ga9uNVuVK2PEBs6l88+n4FaaK05FzQATwJT8lAy2FFp81mxoCpmYlnOOn2k+k9RlVXtO3AJWzPXrXn9yMUGUFqB6neepq+jezAGw3ZHXs3pKA1bf/3xvDGUDIds/9C9fzLoKUxxJf3nxdkN5QF1a12TL/TEPoye+AG8gm8Odm9t/Xyn79HSqH89yDDf70yutHXNxO57Wp2EMODxn/viQ08arquKremn9feu1w5c1MKP+43yzSC4YB/1i8Vv
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e3cb82-8e9f-403a-2f20-08dc85302855
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:21:46.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sQ3Il8kRx07xEMR8i8cITzmuvLRKxKe6VXa9Sind5yJ/eeMdXKCfZ4cuQSs0vv+Dy/E0k/WgjkY+uClmIiXfFp0XQQyxOxPadTRg2CZt9RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8044


Jonathan Cameron wrote:
> On Fri, 10 May 2024 16:37:10 +0900
> "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:
>=20
> > Add sysfs attribute for CXL 1.1 device link status to the cxl pci devic=
e.
> >
> > In CXL1.1, the link status of the device is included in the RCRB mapped=
 to
> > the memory mapped register area. Critically, that arrangement makes the
> > link status and control registers invisible to existing PCI user toolin=
g.
> >
> > Export those registers via sysfs with the expectation that PCI user
> > tooling will alternatively look for these sysfs files when attempting t=
o
> > access to these CXL 1.1 endpoints registers.
>=20
> The lspci support raced with this series and has landed.
>=20
> https://github.com/pciutils/pciutils/commit/49efa87fcce4f7d5b351238668ae
> 1d4491802b88
>=20
> A few follow up comments on suggestion to cache the offset, not the regis=
ter
> value
> (which might change over time)
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> > ---
> >  drivers/cxl/pci.c | 101
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 2ff361e756d6..c10797adde2c 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -786,6 +786,106 @@ static int cxl_event_config(struct pci_host_bridg=
e
> *host_bridge,
> >  	return 0;
> >  }
> >
> > +static ssize_t rcd_link_cap_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf)
> > +{
> > +	struct cxl_dev_state *cxlds =3D dev_get_drvdata(dev);
> > +	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> > +	struct device *endpoint_parent;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +
> > +	port =3D cxl_mem_find_port(cxlmd, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	endpoint_parent =3D port->uport_dev;
> > +	if (!endpoint_parent)
> > +		return -ENXIO;
> > +
> > +	guard(device)(endpoint_parent);
> > +	if (!endpoint_parent->driver)
> > +		return -ENXIO;
> > +
> > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkcap);
>=20
> If you follow the suggestion of caching the offset, not the register
> content then, these are all very similar. Define one common
> function which takes a u8 offset and call that from each of the
> functions.
>=20
> If you stick to separate caches (and ensure they are up to date),
> then you can add a utility function to take the dev here and
> get you to the rcrb structure.  Then you can call that and only
> have the final line in each instances of this code.
>=20

Thank you for your comment.

To confirm my understanding of the proposed implementation approach,=20
I would like to share my interpretation:

- The values stored in `cxl_rcrb_info` should be the offsets of the registe=
rs,=20
rather than the register values themselves.
- Similar to aer, the values should be read from the memory-mapped region=20
using the offset when they are needed.
- To achieve this, the offsets (like `cxl_rcrb_pcie_caps`) will be stored i=
n `cxl_rcrb_info`=20
during initialization, and the memory-mapped region will be accessed within=
 the `rcd_*_show()`
functions where the values are actually used.
- Accessing the memory-mapped region only requires the `struct device *dev`=
,=20
so a common utility function will be created and used for this purpose.

If the cost of accessing the memory-mapped region at runtime is not high, e=
specially considering=20
the avoidance of the walk to find the offset, then I believe it is more rea=
sonable to access=20
the memory-mapped region at runtime.

Could you let me know if there are any errors in my understanding.

If there are no issues, I will update the implementation with this approach=
=20
and submit a v8 patch (hopefully tomorrow).

> > +}
> > +static DEVICE_ATTR_RO(rcd_link_cap);
> > +
> > +static ssize_t rcd_link_ctrl_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf)
> > +{
> > +	struct cxl_dev_state *cxlds =3D dev_get_drvdata(dev);
> > +	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> > +	struct device *endpoint_parent;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +
> > +	port =3D cxl_mem_find_port(cxlmd, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	endpoint_parent =3D port->uport_dev;
> > +	if (!endpoint_parent)
> > +		return -ENXIO;
> > +
> > +	guard(device)(endpoint_parent);
> > +	if (!endpoint_parent->driver)
> > +		return -ENXIO;
> > +
> > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkctrl);
> > +}
> > +static DEVICE_ATTR_RO(rcd_link_ctrl);
> > +
> > +static ssize_t rcd_link_status_show(struct device *dev,
> > +				   struct device_attribute *attr, char *buf)
> > +{
> > +	struct cxl_dev_state *cxlds =3D dev_get_drvdata(dev);
> > +	struct cxl_memdev *cxlmd =3D cxlds->cxlmd;
> > +	struct device *endpoint_parent;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port;
> > +
> > +	port =3D cxl_mem_find_port(cxlmd, &dport);
> > +	if (!port)
> > +		return -EINVAL;
> > +
> > +	endpoint_parent =3D port->uport_dev;
> > +	if (!endpoint_parent)
> > +		return -ENXIO;
> > +
> > +	guard(device)(endpoint_parent);
> > +	if (!endpoint_parent->driver)
> > +		return -ENXIO;
> > +
> > +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkstatus);
> > +}
> > +static DEVICE_ATTR_RO(rcd_link_status);
> > +
> > +static struct attribute *cxl_rcd_attrs[] =3D {
> > +		&dev_attr_rcd_link_cap.attr,
> > +		&dev_attr_rcd_link_ctrl.attr,
> > +		&dev_attr_rcd_link_status.attr,
> > +		NULL
> > +};
> > +
> > +static umode_t cxl_rcd_visible(struct kobject *kobj,
> > +					  struct attribute *a, int n)
> > +{
> > +	struct device *dev =3D kobj_to_dev(kobj);
> > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > +
> > +	if (is_cxl_restricted(pdev))
> > +		return a->mode;
> > +
> > +	return 0;
> > +}
> > +
> > +static struct attribute_group cxl_rcd_group =3D {
> > +		.attrs =3D cxl_rcd_attrs,
> > +		.is_visible =3D cxl_rcd_visible,
> > +};
> > +__ATTRIBUTE_GROUPS(cxl_rcd);
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device=
_id
> *id)
> >  {
> >  	struct pci_host_bridge *host_bridge =3D
> pci_find_host_bridge(pdev->bus);
> > @@ -969,6 +1069,7 @@ static struct pci_driver cxl_pci_driver =3D {
> >  	.id_table		=3D cxl_mem_pci_tbl,
> >  	.probe			=3D cxl_pci_probe,
> >  	.err_handler		=3D &cxl_error_handlers,
> > +	.dev_groups		=3D cxl_rcd_groups,
> >  	.driver	=3D {
> >  		.probe_type	=3D PROBE_PREFER_ASYNCHRONOUS,
> >  	},


