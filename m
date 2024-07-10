Return-Path: <linux-pci+bounces-10053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E692CCE2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 10:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A88E6B24DD2
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE81126F1A;
	Wed, 10 Jul 2024 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="j3mdCO6j"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4012BE9E
	for <linux-pci@vger.kernel.org>; Wed, 10 Jul 2024 08:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599868; cv=fail; b=PI2fUBN/zCiv607JLwc+JwoIL8TyBFIKmBXznOKN8Au4JqdOm7PL1mhHW93L9yaKKvJ9GXqOxwTx/oVsqTzM9mfeOtbN5Mj3NagkYWgL6+9cLJyN5XxbfQKkm9j3zYukYctetqKHvqtPWAYXj7uWK0AXYz1ucuk9A5sZcpxXS3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599868; c=relaxed/simple;
	bh=Wjv+rNFp2G2shpAgNmULABaKwTAMhkx0x+A6lOA3WT0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZYTNbYAaNUJ5Ym4WPbm8WPBXfQrf7iAZb56mYI7phL9A6DIf6AEMUsN41t2wnf9A3bzkrAaXpRXUnyVvd9makKaL3xzCicn2/nsa7qLKSA8BwMJ+BYIkVKA3dX5Xtg2U+ASWQPpOrUg+jpcw9jJmrZWjvSExFMWhwEtPdobfBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=j3mdCO6j; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1720599865; x=1752135865;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Wjv+rNFp2G2shpAgNmULABaKwTAMhkx0x+A6lOA3WT0=;
  b=j3mdCO6jWXRqrReVuNjQPeAkIl9j2k3tP8vYh8GEP7De8Njo+UNH6685
   NGUMzjfvuvaq57uHtd1nq0LiNHSKXgUWBYwsfhjhO1kP0NhJyqHl72TFR
   7rU+JhuZk/ubtuKASxwVbyKkD7434yXZ8vZaV54pVfVBnIGY6TEf9vYtI
   jkMn4R/rwWIn03m6+6IWFXJ3efLOCepWRZLU99YR1JulcFnC6DubYW8Vj
   48I7XdX5Zz7oeakjN8VKBMONXMu/2dJhB6RpQA7fWwuhlOIx/JQRXiSzM
   1PZQp2+3SVCjtKtnpvkAjDSZhTWFr1pNiEVnVzvZ2Nr7Juf+cW5B9MU3f
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="124308917"
X-IronPort-AV: E=Sophos;i="6.09,197,1716217200"; 
   d="scan'208";a="124308917"
Received: from mail-japanwestazlp17010007.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 17:22:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY3nH1VBAhqrmD2OCeGA3uvIO8JGibG1GbJ5pvJt1C4/3ZtdvENn1oKw41x3tv+7uzmzq4bu3uVXElSBa1NGXeo0YhsIfjzGt2PbWJSwKh8OS5STOfoXzZutYPTuScuymoFaaPL/g69DG4WJr0qXMXG4kR5oZOqDVYY6MCcBwAmfkA9wxoNL27q93r62rz2i+j2Ch2WMC2klSjv0IW1/gzeZlzS0dH/ah4yF6eTbWKTPkksnbky2M4dtq3rDaEuYvuZC/GkJnIg5czCG2kUW7Fq1Y4AN3loEh3/bNGwF+kT+YSG7LA6Y2XQwSpwfqKRImcM5AvqEftI1iExwOSP6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1NKPyx/laikhPmn+PJOdHl8rdNd24XWiAUSYwLZg+w=;
 b=daIHVm/4uda6c3T7iTnEPzOjj1E2Ogc82KcaKcIZCQqPuBlqHog+o12usaqxBDi//S0qUfoQL7axAX60bResGa87OcYOeJ+KAa1UDK/hxnv0AOEcXKByz1/E5dwo1TvlomtK40E7b0NJSl+prmWTv0VlQ/SsYOwmkDd0IjZrCItNUl8iI5T+XZcgwjv8qh5b53XASKRVTESYIHXwF6+mjoERCMeo4vW1XAOrN453rFBhqPOTO9RMdSNgtB7V6izW5rj9etpca4uFQVq4JiljJ9konyiR7oYxOZcyTHWMLXlZnD/aH1TgR0OFJdAwb/NgeVo7PulnCKYblsExOwTogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS7PR01MB11551.jpnprd01.prod.outlook.com (2603:1096:604:23b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:22:53 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:22:53 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Topic: [RFC PATCH v1] Export PBEC Data register into sysfs
Thread-Index: AQHax4L+i4Kp4u4qEEmK0TgyfRRzXbHvs5Ng
Date: Wed, 10 Jul 2024 08:22:53 +0000
Message-ID:
 <OSAPR01MB718249EE43F62F46A9793280BAA42@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240626044330.106658-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=d3dd8d91-6300-4e99-bbcf-d5c519cd8003;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-07-10T08:21:43Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS7PR01MB11551:EE_
x-ms-office365-filtering-correlation-id: f9cfc8c1-aec1-4e54-8793-08dca0b97ec8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NUd4YStLb1haL1M0dW5qeDUrRzFFMDQxVzdScGFIV0pRQ3R2bkErNTdP?=
 =?iso-2022-jp?B?ZGJkU2N6SlhLSEt4a2psanROSlpwd0ZXdmJxbnZWTE9xeFYxc1dBakxC?=
 =?iso-2022-jp?B?Z2FEZVlQVEo0ZHRqTFRPelozbWZISHRuTDVJdkhoRXdPS2pvWUVMeFBq?=
 =?iso-2022-jp?B?ZEY1MUZDcGlBbzA0L2VyS0VQaWp5U2JPRFZpbUJqdHZJUFF1SmhKNzhL?=
 =?iso-2022-jp?B?Q20xZzNRUytSbUFURUpYV1R3b05uU25JL1VOUlFBOXlWNCtZMkJBN0hz?=
 =?iso-2022-jp?B?VDBlRHo4RkUzSDhaWklqUUwxQjI1QldlYjhJQ2RIME1JZFduUUoyUTl6?=
 =?iso-2022-jp?B?aDFETzFhNU1CdUd5UGd5YVZyRk5RVmdpRlFSc3pHUDFkYkZ5SHp6and0?=
 =?iso-2022-jp?B?M1lua1JFd0dtUldtVE53YTZacVlZWmVxNTV4L3lrTUxudU13NHlBVHI3?=
 =?iso-2022-jp?B?S2Z5OWxZQi9OUktzZDRRQU9YQmxmRDBjZmhWQXZNZTVDMmZWaFZ1Vkt5?=
 =?iso-2022-jp?B?S01NMkU0SWtiRUdSTWIxK1RvNGdvaUJnQ21xb3d3SXNZZlZaMkVPSXlY?=
 =?iso-2022-jp?B?eGlTdG9VQzJnbmoySUhqVHNiWEcyMGErVGk1QTJIZlQ2S2FJVjRvM2VI?=
 =?iso-2022-jp?B?bmIvVG9ucnU5YWhlb0JPdTRXMG1mRkZoazhUaW1Jb1RXRlRoSDdBQkM4?=
 =?iso-2022-jp?B?aGtOUFRBeVJ5UE1pZmJiWjNpb0NHcG9JRzkvV2t3eDFrdFpoVHhBcGc3?=
 =?iso-2022-jp?B?S0ZJZzVvNFhCYWU5SHhuVkZ4YS9OQk9zUEtMcCtyZlcxaklmczNrdWJG?=
 =?iso-2022-jp?B?dnpFeWI4YVpYRnpFOWRHZGVvRzArWlBUL0Z2R2Vsdm5YZ2RtMFlpZmhO?=
 =?iso-2022-jp?B?d1lxU0k2dlE3bDdaeUthNzFZQWhVQm9JK3RiUHJhWDJndkVTUVZYL3dI?=
 =?iso-2022-jp?B?N01KVGJObXRiYS9qTlFQaWcxeUlQWVllUHhWNFRRNVRXcWcrd0ZGYmJk?=
 =?iso-2022-jp?B?cG1SWC9ZZ3VKckZCUmQxVFJKb0EzVzhyamJidVZ1UmxQTElkeFpkUEY1?=
 =?iso-2022-jp?B?Ry8vc2NLYldMQ20wVGZRK0h5SGRFR2xoMUNrMEpiekFYZnN4MlQ2R2JE?=
 =?iso-2022-jp?B?eXFRaFVaZTdxbVByTlVPRkhFRUJSVGZRZllSVEVrc2lQU2p3RGd3YUp1?=
 =?iso-2022-jp?B?dU5WSUxlU3R3WkUyNWpZck1wdXM4cFhzYzRvOXNoVDZTU2tJOEhHVjBJ?=
 =?iso-2022-jp?B?dzEvOVRXSFFRclNhVVBHci9zWG9ZTmM4V0NqOEMwTndkWTBqU3dib0ly?=
 =?iso-2022-jp?B?TTlYRlpyVTFtNmk2dU94UzNLOC9GWFgvNEtGOWNkd3RUbVlzZmxONlov?=
 =?iso-2022-jp?B?aDZVSkZnQmhncWs2V2tFN0duNmRGNW16STAvenY0M2pTRWZzZHNiQ0hS?=
 =?iso-2022-jp?B?eHhRUkhYdlZ0VVJ1TnJ5TVBQOHpNY29xc1NJRVdqSmxYTExYbys4WTAv?=
 =?iso-2022-jp?B?NTNHTC96NjdXL0x6Z2lqV040Q2lyWFlHb01JRER5a2R6WGFKanpiMWlY?=
 =?iso-2022-jp?B?YTJoK0k4c3gvWGptOU50a1l6b2VSK0VGN1ZacjV1Q2ZMaTExMGRMek1R?=
 =?iso-2022-jp?B?amIrRXlHV1lxUzlaU3lKSlVOUXFxN0tWRkRJd1Y2VHRqSjEyb3IxK01G?=
 =?iso-2022-jp?B?Rk9VdXpoK3d5ZUhHK1dLbnhYQVFpbC9WckltV00rK1l5TEhrRG0ycjRW?=
 =?iso-2022-jp?B?SFZEOEh5bGkzbFU5b2hNcHBTODhTK0Zya01BZklVSStPbzRpT2hxN0Jp?=
 =?iso-2022-jp?B?Y1A3cjVEY2dyUUVhbWJWOFJ4WmtCZVVnSEFXY1EvOE44KzJGUk1VYzAr?=
 =?iso-2022-jp?B?clFZZDhHWlZRVzdOVE93THI5cFVYeWdIOU9jN1ZIcnFhdU56NXBsUHNU?=
 =?iso-2022-jp?B?ZGhWaUdDZXNlMUVEUWRHTXRsTUNmYStwUmR1MnVrZ0xWN3R3cy9haFZh?=
 =?iso-2022-jp?B?NWVQMHRQci9abitaYmlacHVZZHB3ajliWGl0ZHlVbTVwOXJFMThRb2Nw?=
 =?iso-2022-jp?B?QW9TbHA4RE85QVQycUFuOStUeHNRLzQ9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?NVNLQ3JVWDA0MGNudkJ2TlZuYkZ4aUszdmtiRDA2MXNYbjlESTdDRktt?=
 =?iso-2022-jp?B?NnozMVQ0R3Q2UEJpUjBTRTZ4b0tQZU1nRGE3bmNKNmQ1MytWbXhtVk01?=
 =?iso-2022-jp?B?WkdXK0xEUkZZYWFULzJSMDZ6a3VnL1UyUHhaUmxQMFFocDZ6Y05ScmFN?=
 =?iso-2022-jp?B?Y3g2WTIrUXpvbzhpNFBnS1FGenVMMnh4SktQcmRkcnpKaEpkSjI3Z0FZ?=
 =?iso-2022-jp?B?S00vMGdXcjNEWGM3UWFGN3NSKzVURVZjVElDRlBFaHd3Zkh2TWt5emNh?=
 =?iso-2022-jp?B?V01FdEJMdkdEUDFEc1NRS1VWblNnUUxZZzFxazYvQlZhN0hJVGxhQ3Ax?=
 =?iso-2022-jp?B?K0gra1BFc0g1YWduWFVuYXowTmt4dHQ5WjJ5MXFSck0ycC9CVFJhaVJ3?=
 =?iso-2022-jp?B?MSthWjZQME5hUG01ZmtIR3BxMVo2bTEwdDVNL3ZnM0NZTWdQUEFmam1Z?=
 =?iso-2022-jp?B?L0s3bGRac3lpWmU2cEVEeHFZdWh4TEk3NTV0RjY1K25RdUhXR3VLVDVv?=
 =?iso-2022-jp?B?Wk5LWUJ4NHA1b1ZMZmJXQkFGV0ZXbWc4NW5TT0QwWE04VHh4NUhPa3Zp?=
 =?iso-2022-jp?B?MlFqZHh6OHFKV3VWSEpJaGZQUXJWNml5UWNRdTFZSEphdEI4RU80aS96?=
 =?iso-2022-jp?B?SlNWS1E0RXlaWncyM3hncGliZEdmSGdtQVFBay9WNm90VGtObTlGMldV?=
 =?iso-2022-jp?B?aXRUaW1qVWNhSGlpQjNmRUN1cmYyY3NCUXhYWDBjVlovRk5OL1pnNlBB?=
 =?iso-2022-jp?B?eUdmQUFabGlFYTVMWHdId2hmejArY28rb1orZmV0VWxveTBlUStnQWUv?=
 =?iso-2022-jp?B?Q2JVcmRnckVKVE1UNkYwbllYd0hxZ3I0dnp0TGFydUhIMjFEK0lyMGhQ?=
 =?iso-2022-jp?B?VHVUa2orY3R4UDhFSUIxS1RTL2Rqd0VEUDI4NXdlRkwybGpFb2pvc3dO?=
 =?iso-2022-jp?B?aitWQ1ZjcWs2ck5mNW5HdXowZzMxaUJGVVhvNWZySUpIVlhjVnU0N3Vx?=
 =?iso-2022-jp?B?YmhZWkg0R0VyYTBTc2l4ZVplTVVpUHM0MmhPQ29CZGhpZWZtd1BEaEtr?=
 =?iso-2022-jp?B?R3c5NHgxZWl2a1ZlOVVDYWJxWjRUSDcrWkUrWUZTSGtYSlppK1pKWndH?=
 =?iso-2022-jp?B?QUNmTVZoSDJHbytMWWN2VTBXTnRXMEVnVkpRdnVKam04eHg1c2wxQzZX?=
 =?iso-2022-jp?B?ZS9DMnczNnZjUnkvM01PK2lqS0RnSHdZZ1plQWNXSy9xT1ZZTXlWSGd5?=
 =?iso-2022-jp?B?Vi83ZmxHZkVJdmNKVW1kakdTbjRiMzAweTV1NUR4b2lWNlV1b0tDQUZ0?=
 =?iso-2022-jp?B?RHJCdDZpUHRJcWg3anJxSXo3NkF3SE9zMDZGaWlZMDdvV085ZEc4Y1lq?=
 =?iso-2022-jp?B?elVkZUxFM1NtUHJKWXQyc3B4bWs5WGRZWVo4TlA2N0ZNZCtaZE1xRkw2?=
 =?iso-2022-jp?B?K3VrQmEwT3NBYUJLNnc1dzdsakVuOUhQVTA1SGtHc2ZzZDVTSDJBbktq?=
 =?iso-2022-jp?B?bHU5MUwzM3k5SnprNTNFandiZDdrY0lMR3pzOGRVV0dEWEpSKzVOR3BM?=
 =?iso-2022-jp?B?Um9wcVM4Q0xNcnkrdG14U01UengvcEdicHVJK3RVUVI3emJibFUrT2I3?=
 =?iso-2022-jp?B?U3d0QVNzWU1nZTJiV3BUallqd1JFcFpOUnBWN2VSUW10WDErU3d0bTRl?=
 =?iso-2022-jp?B?NGc3elVJQXA0bWNtQkFoYldwemNVV09NSEsrWEpnaVB6clV3cWdEVkJr?=
 =?iso-2022-jp?B?RldoditKZXJzcEdBK3o3Y0w5QzhtVk1XRkNROUx2RHZEa3ZhR0ZZRmo4?=
 =?iso-2022-jp?B?bEpOVmxPMkVJczFrMnNQOW1WVVBBVWtORVZjbng3ZHd3ZTIvMTlCUDRZ?=
 =?iso-2022-jp?B?bEF1YThCM0VOYUV3aVhwL3BoS0x5c05UODI2WkZDZGR3bVd3OHdsNGZy?=
 =?iso-2022-jp?B?eVRKZmNtNjEzeFNFL01iQS9jOUpMeHhhYWlDd3NoYnpqWGdlNzBVc0JV?=
 =?iso-2022-jp?B?ODlnL016K2RLaGxKbW4wa1RpK1FpM3BEV2x0dHBhYWpJVXFYU3pWYVlO?=
 =?iso-2022-jp?B?djhWVkZWaWZkRHVtOVpPWE5aNytscENSSCttZHVYRFJhNWVMbDVaUlFl?=
 =?iso-2022-jp?B?LzNFaXFUVFdOMVJ3UCsvYUczZS9FYkREUitkSUpMalRTT3ZlbzZzSUxv?=
 =?iso-2022-jp?B?a2QvdWwrUTZLd3d1Szhvc2czRVpVWVpZbUprRUtSc2tRRHY5U3BGelVn?=
 =?iso-2022-jp?B?WGg4dll6QmxzazZRdVRIUDFYcFlPMzRZdlc3ZjBmemw3Ny8xNG93Y25E?=
 =?iso-2022-jp?B?aWF4ajJEVW01VUtMUjhZdzhwUnQvVktxeVE9PQ==?=
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
	r+lIe+IAEhdttYSk6dt2xvrIVPHIdM4c8j3iHnIMaTq/XalLE8ngjJU3Hfa9xI+LE0OVQdh5/GkHvVFJDi3IPciwWAOz+NRUJLVWDyH/clB/vk+T/a3EW3g+cjsj8slKsmUY4hfrWaNI8T66bRY8e4ueD3oUw0Ns7oSH5PUjHLpXR5f+M4LuS9ojJSs/O8PYghRRKsyvUmieOWVmOdKbea9I6VTToTHDMzvumsh/M6Iiq+bwhysFboXCEMyl5mjWReu++1OplN0BovSSYcQCpLqo+JctGaa3useNbuGrfNz7kfh/2QEO+duCyCYK12QfmUWmgG8luvMcl/+jRPAJ4WkqKlfjWFJGDWwaAT2yAOUbEqEMR8MPJ8GelUzpGwFCp69/jUCtcOH9y9D3DEB0HjxzFw0AG9atBWozZB8phU8FJ3W1yDF3i7IE0athzqtBvXq5nN9NFSe+hYA30N1oX5U5wgk0dk1khZPEEjrrbEC+W++kraRgoRqtitncfuZnK2BwHnkwA5EwBSm09kuUO1we2KAT2bq6X7hyAyAGe5QPH0e1Ut83WTjr1mxKO9fXtFqMDZy3kL3Rq2EynyCYXXYPd+qzR0VQ8g5Ea6LtkkdepJRxmAqw+6eFWcustaa2
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cfc8c1-aec1-4e54-8793-08dca0b97ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 08:22:53.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V61lW9lN0MyO1vGqnjpO6ONdBwZ8VQqhyvJhCTl05sfdeKgSJ0iZDkkh0m/eItSQGT/XCD9A5eem85hADfQsoJ25eJspCAk8JpW9mHHL0EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11551



Kobayashi Daisuke wrote:
> This proposal aims to add a feature that outputs PCIe device power
> consumption information to sysfs.
>=20
> This feature can be implemented by adding support for PBEC (Power
> Budgeting Extended Capability) output to the PCIe driver. PBEC is
> defined in the PCIe specification(7.8.1) and is a standard method for
> obtaining device power consumption information.
>=20
> PCIe devices can significantly impact the overall power consumption of
> a system. However, obtaining PCIe device power consumption information
> has traditionally been difficult. This is because the 'lspci' command,
> which is a standard tool for displaying information about PCI devices,
> cannot access PBEC information. `lspci` is a standard tool for displaying
> information about PCI devices.
>=20
> The PBEC Data register changes depending on the value of the PBEC Data
> Select register. To obtain all PBEC Data register values defined in the
> device, obtain the value of the PBEC Data register while changing the
> value of the PBEC Data Select register.
>=20
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/pci/pci-sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..b13d30da38a1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, str=
uct
> device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>=20
> +static ssize_t pbec_show(struct device *dev, struct device_attribute *at=
tr,
> +			 char *buf)
> +{
> +	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> +	size_t len =3D 0;
> +	int i, pos;
> +	u32 data;
> +
> +	if (!pci_is_pcie(pci_dev))
> +		return 0;
> +
> +	pos =3D pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
> +	if (!pos)
> +		return 0;
> +
> +	for (i =3D 0; i < 0xff; i++) {
> +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
> +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA,
> &data);
> +		if (!data)
> +			break;
> +		len +=3D sysfs_emit_at(buf, len, "%04x\n", data);
> +	}
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(pbec);
> +
>  static ssize_t max_link_speed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] =3D {
>  	&dev_attr_current_link_width.attr,
>  	&dev_attr_max_link_width.attr,
>  	&dev_attr_max_link_speed.attr,
> +	&dev_attr_pbec.attr,
>  	NULL,
>  };
>=20
> --
> 2.44.0

Dear reviews.

Could you please take a look at the patch when you have time?
Thank you for your time and consideration.


