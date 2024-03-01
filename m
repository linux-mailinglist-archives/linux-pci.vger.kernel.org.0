Return-Path: <linux-pci+bounces-4297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE75786DBD1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 08:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91AC9281723
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 07:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E169304;
	Fri,  1 Mar 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZP3Ia1yz"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa8.fujitsucc.c3s2.iphmx.com (esa8.fujitsucc.c3s2.iphmx.com [68.232.159.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE67433DA;
	Fri,  1 Mar 2024 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276639; cv=fail; b=u2NNGuaeC07+qPvkFy9EyHh0dPvLSkqByGxG9ODXv+3lLjk7Xe/XAPqACOBajAt69e/zy2LQjTcD3jheXXD21bAblckRSK8xcUATsOPs1AIHqmvMvHMKlam79tGd1x6DK+m2StsxWtj7v17y4bnPllSF5w8zsYRYnZtdJ7dUtMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276639; c=relaxed/simple;
	bh=VLzs0TBDygK72XPl1CUyFUmJVPvqkb9xmqQ6EQVVVjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d8zTZlxF4lhboxEPswLqXhsRtxnvjUEAqxZrdK8MpAb/lhgPgHnAkqadvG6rLaDNsIYLtstyuvfMnBXJyzg+usjkqQUOEto6fUoJlECO8GB/nJ7kDR5dWbjd4wx3iqU7dQch9OoIyragVzgTAVx8gq/WfXtg7CjZidVVbA32lw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZP3Ia1yz; arc=fail smtp.client-ip=68.232.159.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1709276636; x=1740812636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VLzs0TBDygK72XPl1CUyFUmJVPvqkb9xmqQ6EQVVVjE=;
  b=ZP3Ia1yzoWld4JKsQ9y/MKPxohESVhGiJ4C4HtYl6YT5rENpElU9lhU7
   beXibF0/P0e5FlgaYcaG/+3EaQEaYaVQP8TOuSEkhOKqehBMt6q5wQMHB
   3kIUziZoZRmHCrqbtp3UtP1C7mnINRikyZR6qV7s180LBZZFh2P95Ytto
   MmuK/WmN2VLIGwq/rmyHwRLMjX2O/9yeoC6PJzSF0vxYdfNQO/tE/4Fm/
   PdUOmzjECAZdf7dibt2H4H8Cdl+cCTLj7RqpJqMvPWna9+3K5W5EDb6MZ
   hQHETf8lmB55mjSbbAHyoHmY7brKu48l7IrK4d3l8RWKTvxn7/xV9Eu8o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="112738800"
X-IronPort-AV: E=Sophos;i="6.06,195,1705330800"; 
   d="scan'208";a="112738800"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:02:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B34iWuRH8TFbuPe4s+bhq7fa/rdtuqG0Llw9hWWSl8vdDk4EVAmx8HKTnuQo3w51101CXJ8cbmGnQf4+sGMxg5lKXLgzLe9/0rEl4gkar+y+vI872/loMaL5IX9xxwBKi78ss64nkmprdDCJbDaFs40rN1BeWKt9MWgdx0HTwPbV2A6HUki1M4AoGmMX033+b3T96avmBlNsjPxMDi0oDWiKEawDGUpkrUKArX9n0CQPCd12dK2+TlTlgSJ5IlbLO7NlW60bJ5OfO0TB4YHwLY+fOG8lXmRa4hOZdoQ+R/OybP2VryUIYsJ6Rtx50RhhH0UIKjuw0ANLfx2S+FTaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLzs0TBDygK72XPl1CUyFUmJVPvqkb9xmqQ6EQVVVjE=;
 b=hEsp0K6pRx1QhKMcEQ7tEygaUbFiG3BetKxhAnNH/7PvtIfpZdwP1vm+UaruVqsTaH3Q7SnqTke3h9qds3lCnJeABSfYgB3XtbnpJzNOi0cRqRImqc98rd6gMOFkv8jf20uBWa8Docw+K3fKfWFFjZMhFolb94TRHvpsXTSwvEl3kb8Gt1EpMW0HIh8d571PI2aTw20nxMXxtCjCfV9FsUnZZbA02wEbhtz+n4fRUvd/huSI0SimUXvipvTNEhjaG4scJMJ6dxOt42DQEkrq0rF/CXs1W6rsjbtMAeQXxDEIE7T/JWXsz8jl42kZrGI7hxhunUI6fTanjdJbzApZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OSZPR01MB8661.jpnprd01.prod.outlook.com (2603:1096:604:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 07:02:41 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::6cf0:1fef:737c:37d9]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::6cf0:1fef:737c:37d9%6]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 07:02:40 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: =?utf-8?B?J01hcnRpbiBNYXJlxaEn?= <mj@ucw.cz>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
Subject: RE: [RFC PATCH v2 3/3] lspci: Add function to display cxl1.1 device
 link status
Thread-Topic: [RFC PATCH v2 3/3] lspci: Add function to display cxl1.1 device
 link status
Thread-Index: AQHaaVdEGvRzHAT/IkC2Z8kA0GmdCLEfb0qAgAMJsKA=
Date: Fri, 1 Mar 2024 07:02:40 +0000
Message-ID:
 <OSAPR01MB71825AD9BF5DE5D037447FABBA5E2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240227083313.87699-1-kobayashi.da-06@fujitsu.com>
 <20240227083313.87699-4-kobayashi.da-06@fujitsu.com>
 <mj+md-20240228.082836.19016.nikam@ucw.cz>
In-Reply-To: <mj+md-20240228.082836.19016.nikam@ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9MTUzMjBhMzctN2ZiMC00MzU5LWIxYTgtY2U1YTdiYzU0?=
 =?utf-8?B?NjcxO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTAzLTAxVDA2OjU5OjA2WjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OSZPR01MB8661:EE_
x-ms-office365-filtering-correlation-id: 3c5933c3-16b6-4256-7871-08dc39bd9611
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TR8mtsRilEuGs2lm4aByK3fBm+Fb+vbzA01reyIstixBxFubAOPmFBG4vA2NKQiO6nXiouewYonCXCVD2Hirh5/ttmsj7O8peuOPyDSKS7iEYlI+4bJHNfmCBXcxHw77b67OfnyVCSl+j0bIy4Xz1Un/1i0xRcFEdz+vcAr6x45cc1sPREXKz0/ix7R/9dEvw4R4ucCunjPTR0PrgWJx/GGRBYDsQnYg4gwlPyTr0pRFN4zcHwXzpfr2HfORWF4CcWi7DimHiJY1nFY0GogM4Vc5gDkvXyYDy1/4Oak6fGXMgBIoVDo6J29Q0Hk3LlqwLvkfpewCwua1az3h4Oa5P5E4gpVK863eg5kNSH5a5ejbEGI6NNgGuugvzb6eJChuka5ci6hgAopVTQJJoFDRA0Qgngdavu6Eh1mj62iEPR6OcTLEIsYhQan50b7YGtDsVSm2ERNT8r8NTR9pd0wFkvp3O9GZQnyu9wUxUzd0bVfcHFHQ+YcpQFx/Pcd2KRINM1ABQR9Qf0VIJ8P2UD24zw4hcJ9b9EzUDLgwRjiO8xb4wP4DgxTXxsmcQ0fxCz8okpjB59A+iheowoZmqq4+cpEPvvmf5s20ZuHqO4e5u+BckHcH4CFO6323wt/C4R1qcDIRNUMKNYAv9Gun9xgoUnVaerIgPX+StCi5b+gTnBbdnCWz4OSLlBXVAGWwZaWBb+zWqs8BhZURCZd7U92hz/GNiy0JzFw/SjxfNdE8IXMiH0xmgxN25MuI/S5tBk9b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmo0UnB2VGRsTDJoQUNyMWYwdXpqZEg5a0NoNWpCUGpKdWV6L0wxanBMVVpx?=
 =?utf-8?B?QUgvaDNKQzk4YWxUQUFGUG4zYTRxMmtDeVIrNG04VVpHSmttNDJZUXFDL3FF?=
 =?utf-8?B?L0hrSmw2eng2L1hCRndvRndocW1RTE9YODFxZ3d4Y1g1V0laN01VMFpXNml0?=
 =?utf-8?B?VlU3NGtmZ2p1MGJ5WlY5ejN6Y0ova1VkNTl2ckZacGY3aHpMa2p1UU9LOWxE?=
 =?utf-8?B?Y3NLcnA2ZGRrVlpvTzdiR2kwdXRlWjNrV0I3SWs2VG53VjZVZGZXOGdiWDhw?=
 =?utf-8?B?eitOc3JnMlBURWhrc2NUWjNYT2daSWhvSVJNYk96RFZLV1dYZ1pWaU5RUmNR?=
 =?utf-8?B?UTdrdXQydjJzUmppeThPKzltUm83R0V5aFRwV2Z3OTBBdi8ySG8ySXN4QllI?=
 =?utf-8?B?VWZvZmFhRjg4UnBOTnE1SEErZ0RIZXFmS2FIYVJmT2ZtVTNEUjVJL3VBeTh0?=
 =?utf-8?B?SW5rYzBtSllMUlVGcmVROE5nK250d0tCUE52aUt1QmlxODN3eldHeVV4eWhZ?=
 =?utf-8?B?QlZ2VzZvcXduNzBWaWN1SVNkanAxU1lUNHRuaHgwbjcxdE91YUNCTk1jV1Vt?=
 =?utf-8?B?WVB2K0lHSXc0YlBqdHlLSktrcGlKTGExRkVudnhqT2gvNlJXdHY3TlA4cHJv?=
 =?utf-8?B?emVjdjNSdng4c3FXcVM4T1NoRVVkTEN6VERCWWt6V1dmSEoycUZWR2t4VkNr?=
 =?utf-8?B?ekU3TVhVZ3pUZm5qTExDTUJzbDFiU29kNkdVZy9xb1JMY1gwU1pJTVFsU0xl?=
 =?utf-8?B?Vkw2emJENjVHbXhobm82UlY4eUR1UkpnRzJyQVpDWWY5T1hWYWRhdEhna0V1?=
 =?utf-8?B?UnFFcWZsb3R6d1hlSmx6TXEzVmJuZWxVK1BFNHRWYktrUXdZS0JDRjlUdnNk?=
 =?utf-8?B?Rml2aWV3d3psbFRqb1g3eXVxR2VMRmRXc0J5d3pMZnphV1dkYjlTMjNwNVh0?=
 =?utf-8?B?bXU3RFhtcXIvODNzU3RDY1BpeStOVnhpMmwwTU9GOGV0VlpaUnZFQXowaXk4?=
 =?utf-8?B?QlV3U0xuTXl1SEk4NGRFTGtiemJFZTl1cUxqank0cjJ1alA2b2JxZEhlUGVR?=
 =?utf-8?B?WHhMWkNQZCsrbGdoQmRVOCsvQmdQK0lLYk94bXU5Uk9SRGhWSnFydUEveUtt?=
 =?utf-8?B?d1pPWjhnODFUcGQ2NERReWZmUGVnTjJoRjZzamNWT0lhK3pDSVVKSHZ3ajFK?=
 =?utf-8?B?a1k1bFVoQ25hN0l1NkRuRjNXMFBZT1AyWFZ0ZTE2Nld6Z1FyTGU2TjBjc0ZN?=
 =?utf-8?B?dzdvRnBXTGlnci93S0p0bU9lR3NGYmlzMzN6VTdPWko5OFcwelJ1RzU5SVNY?=
 =?utf-8?B?OWJpQ0dpVDEzci9xNmpLK2M5TXNXdmF3VkJWbFBiNGhCdVV2dEtQMHl6cnk4?=
 =?utf-8?B?NlRYV2NkNXdocnRYbjkzV1gyRE13bDhLTTFwcWlvSFdHOGFmNmUxZ25YK1d3?=
 =?utf-8?B?bWtqd0JGQmUvNHI5cnNrQUhUODk1Q1JlK0gvRUVrZkNUVDJraldZTldJWGU0?=
 =?utf-8?B?T3ZuMUxmMXBTcEw1OThSVGYwalhXZEZ4WGFzeFZhZ3BrZlBtNTNJQkFtbEl1?=
 =?utf-8?B?WDBKR2dUcytzakU2TlQzek9yVUg4RmVjMS9ETjNVeWlSUGUwLy83T2tvbUdZ?=
 =?utf-8?B?cm5nd2RBSFozV2FCdUYvWTZUc3VKaWhDR2YwWC9EYjJvZ1UvaDZqcjFmeUYr?=
 =?utf-8?B?NGtOVEF5a1hDUjdrVTBtbjRoRG11SDdYclFQZEp3VlZkNnB2TEZPbDNuNUhV?=
 =?utf-8?B?amR3bXFrKzFkc0wxT3IweVdEaDM3WXNKTXZGcXNraTdWWnpDRkhBWHVsL2Zj?=
 =?utf-8?B?ZTZYb0c5REJZNDJXU0oyMmU1ZC8zTzJseHRucHFuSnhHRWxzeHZaT05HcjhL?=
 =?utf-8?B?ZWNKR1pYOUt5TEpyYWlvUTR4TFcxNHZlWU9sRE0yalRlaVRzQTdWdFplZU9l?=
 =?utf-8?B?VTUrc05HTERMamhMVDhXTFR4QUYzYjAxbmdlVldTQTNOLzJtcUF2cjl3OUpr?=
 =?utf-8?B?bm9VOFJJZVJHdXNvMTdSN3J6Uk1sUW8zUE0zMW1mMDJmNEQ0VFlsUXE3aG1y?=
 =?utf-8?B?c1BNWWEwcFdyejlNeUpvVElPcTdpbnRVT29zb3lNQmhaTzhJRGhndkxuQU40?=
 =?utf-8?B?cWxFbU9yMUlUcENqdzhSZFpkR1JxYXlEVm00ekUvQVpQWjlDVXRtOFlYU1R1?=
 =?utf-8?B?ZWc9PQ==?=
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
	okTc3bI12raZsxbGsn443zNV8CZtmQD8T5tBOUdlj/lanzYsNW0jeIEQFJ2uCTk2+y3sS/kZd4FJelZKZmcCLQtJrH4lPQ9fBHNaTHukd+9VC4wMb3+5Rh5UOubNWuJNaChkcqdnJ18Smlr7+ZoLRkJLEvvvSZsU6T6+EeShP1Wu7ftRbpqVj/u09VN3WJseHnf8i4Zc1VToWiyHic5+To2Ttr3NU0bSOd+XdDiNAAiKoKUXZ8A7skulxHf/gNBrUBbUqYXJZVSwRAbWbSsIJpYR4s9kcytdM33oLJ+8Sdc7QqZZum/CtZfvD2LPpKi4YSnohE3KTDOCdTAPcFot1x21f4T8RZ186sMkcVN55wH9hoQagskT3NwK8ZwG/K3+tRajxUHBL5JHddNpMbXkwwbRpr9XFoKjH6jlktq7CIHEHArPpgB4VUNWdQVmrkzZLpiXJbND7X6oTWhythlSR8k5Ou666YII0uDgWPzDQwale5TNN44pM7IKswcGKK3f/arzyf58u6WHsh0+/BREXXmB3xP5fvfcIEeIkf46n4cfj9vgfAyUKNzA0i7QVB61gvpVSLuF/R3Zg98TwAL7bUQBK2+qDw0H1VNvJchNnQSRv2+v1osOzB/azue0eWrH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5933c3-16b6-4256-7871-08dc39bd9611
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 07:02:40.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJa7tZlNYAKihPm4EZZDCCX6ZP4zHmpcEbh5ba00jayjno5fW7lj2TYK6DgY6WqezQufXjMTJNBB1paqkPIOTd2hoc6jhvjN3mZmRTA5Tk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8661

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIE1hcmXFoSA8
bWpAdWN3LmN6Pg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI4LCAyMDI0IDU6MzUgUE0N
Cj4gVG86IEtvYmF5YXNoaSwgRGFpc3VrZS/lsI/mnpcg5aSn5LuLIDxrb2JheWFzaGkuZGEtMDZA
ZnVqaXRzdS5jb20+DQo+IENjOiBLb2JheWFzaGksIERhaXN1a2Uv5bCP5p6XIOWkp+S7iyA8a29i
YXlhc2hpLmRhLTA2QGZ1aml0c3UuY29tPjsNCj4gbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsg
R290b3UsIFlhc3Vub3JpL+S6lOWztiDlurfmlocgPHktZ290b0BmdWppdHN1LmNvbT47DQo+IGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1JGQyBQQVRDSCB2MiAzLzNdIGxzcGNpOiBBZGQgZnVuY3Rpb24gdG8gZGlzcGxh
eSBjeGwxLjEgZGV2aWNlDQo+IGxpbmsgc3RhdHVzDQo+IA0KPiBIZWxsbyENCj4gDQo+ID4gVGhp
cyBwYXRjaCBhZGRzIGEgZnVuY3Rpb24gdG8gb3V0cHV0IHRoZSBsaW5rIHN0YXR1cyBvZiB0aGUg
Q1hMMS4xDQo+ID4gZGV2aWNlIHdoZW4gaXQgaXMgY29ubmVjdGVkLg0KPiA+DQo+ID4gSW4gQ1hM
MS4xLCB0aGUgbGluayBzdGF0dXMgb2YgdGhlIGRldmljZSBpcyBpbmNsdWRlZCBpbiB0aGUgUkNS
Qg0KPiA+IG1hcHBlZCB0byB0aGUgbWVtb3J5IG1hcHBlZCByZWdpc3RlciBhcmVhLiBUaGUgdmFs
dWUgb2YgdGhhdCByZWdpc3Rlcg0KPiA+IGlzIG91dHB1dHRlZCB0byBzeXNmcywgYW5kIGJhc2Vk
IG9uIHRoYXQsIGRpc3BsYXlzIHRoZSBsaW5rIHN0YXR1cyBpbmZvcm1hdGlvbi4NCj4gDQo+IEkg
bGlrZSB1c2luZyBzeXNmcyB0byBhY2Nlc3MgdGhlIFJDUkIsIGJ1dCBzaW5jZSBpdCBpcyBzcGVj
aWZpYyB0byBMaW51eCwgeW91DQo+IGNhbm5vdCBkbyBpdCBpbiBscy1jYXBzLmMgKGV2ZXJ5dGhp
bmcgaW4gdGhpcyBmaWxlIGlzIHBsYXRmb3JtLWluZGVwZW5kZW50KS4NCj4gDQo+IFRoZSByaWdo
dCB3YXkgaXMgdG8gZXh0ZW5kIGxpYnBjaSBhbmQgaXRzIGludGVyZmFjZSB0byBwbGF0Zm9ybS1z
cGVjaWZpYw0KPiBiYWNrLWVuZHMgdG8gcHJvdmlkZSB0aGlzIGZ1bmN0aW9uYWxpdHkuIEhvd2V2
ZXIsIEkgYW0gbm90IHN1cmUgdGhhdCB3ZSBzaG91bGQNCj4gYWRkIHNwZWNpYWwgZnVuY3Rpb25z
IGp1c3QgZm9yIHRoaXMgcHVycG9zZS4gSSB3aWxsIHRoaW5rIG9mIHNvbWV0aGluZyBtb3JlDQo+
IGdlbmVyYWwgYW5kIGxldCB5b3Uga25vdyBzb29uLg0KPiANCj4gT3RoZXJ3aXNlLCBwbGVhc2Ug
Zm9sbG93IHRoZSBjb2Rpbmcgc3R5bGUgb2YgdGhlIHJlc3Qgb2YgdGhlIGZpbGUuDQo+IA0KPiAJ
CQkJTWFydGluDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50Lg0KSSB1bmRlcnN0YW5kIHRo
YXQgbHMtY2Fwcy5jIHJlcXVpcmVzIGEgcGxhdGZvcm0taW5kZXBlbmRlbnQgaW1wbGVtZW50YXRp
b24uDQpJIHdpbGwgbG9vayBmb3IgYW4gYXBwcm9wcmlhdGUgcGxhY2UgdG8gaW1wbGVtZW50IHRo
YXQuDQpJcyB0aGVyZSBhIGdvb2QgcGxhY2UgdG8gYWRkIGNvZGUgdG8gcmVhZCBmaWxlcyBvdXRw
dXQgdG8gc3lzZnM/DQpGb3IgZXhhbXBsZSwgaXMgaXQgcHJhY3RpY2FsIHRvIGFkZCBhIGZ1bmN0
aW9uIHRvIGxpYi9zeXNmcy5jIHRoYXQgcmVhZHMgYW5kIHVzZXMgYSBzcGVjaWZpYyBzeXNmcyBm
aWxlPw0KDQo=

