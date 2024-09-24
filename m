Return-Path: <linux-pci+bounces-13420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809E7983F63
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4572844EB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F463148318;
	Tue, 24 Sep 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PiA58ekY"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4562148316
	for <linux-pci@vger.kernel.org>; Tue, 24 Sep 2024 07:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163573; cv=fail; b=pr8kMhubJFX7uXfh8NOAuUo+pGBQkEX2roBGbBq2KIb5M+xPtBDBdARv45xfX7E2KdmxIBLm7Ujokac7HOnc7zxf4LHq2jZJ1TAGlGAHHtZuxS73yL/atqcju4egnw0ODmP+4NFSp7QnlKI2uYBhJ26dVmLy72If6Qz/8BswU28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163573; c=relaxed/simple;
	bh=w5EkBSG3HyySR03JcWrl78Df2+uUOnc+fpZ+Sn7Mwy0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bTpiIw+brwY9WodR0Dc0UzLyori9ZyZF+lqihxzlH/6aUvmOlTL5uxOWA4bVLleWSrbP/sF1ewcQ//Ch5ZX0te2vsAQtoNi2jecS9LbS/4eCC9yaNKGYV0ogq4dniCoNlMKW+++Qdo9YUD/M1rhggicyT3mkrGXHKpTyMPgV36E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PiA58ekY; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727163569; x=1758699569;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=w5EkBSG3HyySR03JcWrl78Df2+uUOnc+fpZ+Sn7Mwy0=;
  b=PiA58ekYl61WZenDLAEmH5OZm8PDncUvk9mFJJJUOGvV6pXxiJk1Adtx
   fWpBoRI4QTcFsVjiKPsqNe6jmuVKJtnPcPld4fU+0jxzv7m70ut4Iz9Ye
   hwd3Khx7s6u7JXdvm2fcv9Rnh0slsGe2/eJjpwMstvdlP/Sn3llrXkYhZ
   piQVW6H2QHYcumFoHC1Tk2DhEp3dfMWtUR4Qlm9JRmNCt0etcGHKCWw6Y
   M6Z9QH+VVlnDxcCKHmDODfaY+NE+81B5b+eBi3Bf4MbDI+1Wc9WWAEzzd
   iluk47YKBI+PZlEmq87OWz9NlFjfGBvTeJtGganzDxXM6Z/oIdB96D6Nv
   w==;
X-CSE-ConnectionGUID: 4JM+JMSpRR+LbjFeGeeIIA==
X-CSE-MsgGUID: tX1phELXT1OWaF00xx7tLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="131698144"
X-IronPort-AV: E=Sophos;i="6.10,253,1719846000"; 
   d="scan'208";a="131698144"
Received: from mail-japanwestazlp17010002.outbound.protection.outlook.com (HELO OS0P286CU011.outbound.protection.outlook.com) ([40.93.130.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 16:39:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbl9n/473e4FjeNyeTn3fvyXPsxSkJPDqSie66tcvcTbvSqCsWWBq5lXnAJrGtWr1DzY6XnMpohEZ4cEsmuyUHUWV0J9iZOt+iKhPS48NdugSrdgiapOXetBUKyrWG/y9ZiN1L0vmHzusUGN3ALRg6cCJ6gxQSQP+k+Iwu8oq+hJp47DyQmDBFgoQo+jiFcHWK4qgXWYJ/ow7LnIhhamTw/kmEyVJYC2qvaKNMD2GMb6VrCOfuQ8zwDATCyHAY9dT6oRnGa62bg01EV8AGxXmMtD5B6EExn4Xi7Kj6wZODVDgDP2i2C4CqdzV5JWlj73CH9F2LRleiiWUaF0YCinOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ag2oW4uQTDkC0PHc8GFVcqGhN1PHShMqPNlF4k3tejM=;
 b=TSrgWTbLpvCTodMY2RRtFWWqwmNGkZatFi3pI5m4c+wWDxf9Oj1Cl+lyFpTDV5lFL49mCj9nQvaofU3BZRkaY0Z+fQWi8yHpjH2yPokNbndPEHwik57lN5UQmd0T7k8Mg5KZ50ZC1BhlVK7dz7ZZfnXcHye97khYnur8ZMVU9lZK2qirVA8iuuJgyh9gwtVDc1EIg2B9yzzQY3fUQpPop1N2w694zvfCDXA3Fa7TV7MezOSFda2DtNPz2q5fib8PN5NCIlDVJ6Gxz5dQA5N3dtX6/lGptIRA900sxzRc8GTsa0dwQvCN+OLfGC9jUT340fymENU22sJmwNixtM6EiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYWPR01MB8316.jpnprd01.prod.outlook.com (2603:1096:400:163::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 07:39:18 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 07:39:18 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v4] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v4] Export PBEC Data register into sysfs
Thread-Index: AQHbA+h74ei4/Wguf0W/KiuMbwib67JmoSsg
Date: Tue, 24 Sep 2024 07:39:18 +0000
Message-ID:
 <OSAPR01MB7182FEF4BF415680C9C6B9FEBA682@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=True;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-09-24T07:39:17.959Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYWPR01MB8316:EE_
x-ms-office365-filtering-correlation-id: 826c0b67-0cee-4896-7efc-08dcdc6bff46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?V0phUDlmU2YraTJyVDlFZE52bWFBSk9YeE15czdHeWhHdDd6UVVXVXNW?=
 =?iso-2022-jp?B?WHEzRzNJdE8vSlJVdGErM0FSMmJoTFFHcUJCNWljanI4Z2FpVFhmQSs4?=
 =?iso-2022-jp?B?cm5QWGxyNFkvK0kxWktYVUFwbWZnS2J1NUgzaUl3TFRLWWQ2WjdqOTFJ?=
 =?iso-2022-jp?B?RXVURmNIK0RGTDhzM3lYMk92U1VmQmFoRWhvRVFDUERGSERRYktBbTNP?=
 =?iso-2022-jp?B?QnJQMkF2M1NHWTl2ZVBkaDhKOHNHSTBQQ2ltQm0vUURNd29NeU5EcTNM?=
 =?iso-2022-jp?B?WWw0amlPQmJaeWc2MDIwdGpqdWk4Rm5GV3Q2cld1TERoakRaaWRWNTda?=
 =?iso-2022-jp?B?L1d5bloyVWFYTTZHT2VkRmxqWStWQmJYWFJiZ3d0NUZXcFpFcmtZSDVp?=
 =?iso-2022-jp?B?NDBVeVV0dWxWQm5jNTNkczBxQjNoLzB1SlpuWkxCQnk4MDdYa1RIKzg4?=
 =?iso-2022-jp?B?emU4d0dpWlBLQkNQc080akhvQ2dINDNGUlMzRUxSTEttcW93VEY2eDBh?=
 =?iso-2022-jp?B?SXMzOHhLVitSd0ZEODJhcVdYOTl5SFZsMVVFRDFaWnRXM2JtaFZqRmwy?=
 =?iso-2022-jp?B?ajRoaTBJbURLazNBTlNVUFE3VTRhYjlJc1lWNFFrRVNydkxkV2liU0RO?=
 =?iso-2022-jp?B?ZU5mUU1yS3U5MEdzVGo4QWVqMjAyRXJiVmIrNXM5UzRUY0c3cWxUaldl?=
 =?iso-2022-jp?B?bXpuOC9weWN0Zk82UnBrcitnMjNNSmNXbS9YbEhMQndLOC9KekFGWklF?=
 =?iso-2022-jp?B?c0hBZ3dROXJQMjlaWDBZTmRFM2xhbWhvVWlFNW5SeXpTaWVlZWxsZjlD?=
 =?iso-2022-jp?B?ZUlQZGtZWW8xVDhzK0l2NkUrVW90YjZyZms3czJTdVJmb0NzcXhTQlRC?=
 =?iso-2022-jp?B?a1dieXkzazRFS0RHdVpLeDJnRjExRHRvalA5Q010ZlVYcWVRbEVLSEow?=
 =?iso-2022-jp?B?WHM1NzBYakFRTktKRXZYVjBjZ0pVY2puRmJkaURpZjFKMEFRQzBPcTcy?=
 =?iso-2022-jp?B?ZTZDcGNuU0ROQlFjWlk3RjBicytZWWFqUEE2d3ZiSndNVzEzaVBjdEhh?=
 =?iso-2022-jp?B?TUFPQnRhMTdmVFlKREtoenhEVzlmMmYyRlV2ODlmZHNnSFk3NVdpY2w2?=
 =?iso-2022-jp?B?WHBVZHpKUjI3cE4yZmZOSG4yVW9jMllsc0xvSU1xRlJIcnI1b2hRMndB?=
 =?iso-2022-jp?B?UlpVcFNGMlUrOG0vNm5aZjZzQzRleERDZnZEQnd2YVAxcWZTK2VqWlBR?=
 =?iso-2022-jp?B?YlFBQWVyYUpIZGNGYTUvbU9VeVlZbWFkNlAxVEVVR1FCbGFSbkxmWlgx?=
 =?iso-2022-jp?B?dXRnTzJvMFpTeUVDM09QdjJidHVKUXBDTVVBNmZKODRqNEoxejhUVi8z?=
 =?iso-2022-jp?B?am4yTm1xcDA1UG9RbU9CQXlKRTRrcy9sS0ptQ3RPWE1iVVlXajFrVitj?=
 =?iso-2022-jp?B?UWtxL1J4TklKcm8xN21xandUTzZyYzErV0daQWYvM3o4QXg2NU81U0sx?=
 =?iso-2022-jp?B?dzVwYjI5akJ3OTVrSlNLbHE5OC9YQVNnNEYzNC9XeVJhejV3R3dIMHd6?=
 =?iso-2022-jp?B?ekYvdG9qQXE4WlQ2WHN3U3F1R3RCTXQ4cmxNbUhsTFc3RS83VjRsa1pV?=
 =?iso-2022-jp?B?cXZzblFXUzFJWHhWeFhJd0VyT1h5bWVSeG1OaTJ4amx2cnZJQndOYlhP?=
 =?iso-2022-jp?B?YzdlaTl3TU5waHk4VEZndldCK3JTMkJVMGt4dlljNlJLUjM1czU4TUZG?=
 =?iso-2022-jp?B?bEVlRzZSVktFM2xRTDJmU21yQmpyQmlrbFIzQ3lVUVd1TlpqT25HbVZw?=
 =?iso-2022-jp?B?b3hjb1MrckpFZmRpWnhkYklEMmFtZisxUHY2bnlHbzEyNmN6U0VVampV?=
 =?iso-2022-jp?B?d3lMcXZNRURUZkxmaWd0b005blNUczJSSUhwVWRJb3pFa08rU1YzTGUr?=
 =?iso-2022-jp?B?RFN1bW1GamVYdllmd1RnOTJEbjI4ME5sYTQrR2NuQzZjMXZBZSt1WDhm?=
 =?iso-2022-jp?B?TT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Y1FnTndFTWdTcEFUWUk0Z3RqVVRKUiswOGg2RWtNUWtqaHdoL3VpNEtn?=
 =?iso-2022-jp?B?MTk5aTBUQ2hEeWlpcVNnSjc4eWIxWGZ1anJtRVpXbk8zMWhhZXJiMmI5?=
 =?iso-2022-jp?B?UDVqSWxITEdaRUdxYUcvSFBUNFNaTXprZHg2aDA4SmVxeTJEMi95b1JQ?=
 =?iso-2022-jp?B?TjVIWnNXanJlY1lybTc2dUQrQzUzOTNzS3ljL2hRM0UrSnlhcndPUmNZ?=
 =?iso-2022-jp?B?Vmp5TEhZeUZsMTJWdExHaXZlUFNwMEZCaUxhbDlybVBpT1dNWVV0MHdO?=
 =?iso-2022-jp?B?VVMxN0E0bzh3amVvUy9tdlNId0tKbHF6RTdKQnZnNXdBYjhkVE5ZYUpy?=
 =?iso-2022-jp?B?ci9jcGhTMkRIbHI4VHJuODNWL1U5NzFJK0FuemFURXpFVERNTXJVSmVy?=
 =?iso-2022-jp?B?UllTQ0NNUWZiR3Y3Y0xySklZN1BUYjYxYnllb1FaTC83MC9MQzlsVWM1?=
 =?iso-2022-jp?B?NWFtanpkWHNHOEtHSFM0ekEyZ1hrMVJ4cU1zdWd6b1dWaE9nZzRlL050?=
 =?iso-2022-jp?B?RHNCRE95SE4vOTUySEdFSXpxclIxZE5Hd0FlQmRFbzJzTG9EVjhzcTFZ?=
 =?iso-2022-jp?B?T2l1d1lhU2ZHajdxVlc5azAzVHNld2ROTjRrZkptSUN5byt4ZHYrSXo2?=
 =?iso-2022-jp?B?L0NtTHJqZzF1ZHlCWmtHbEZqMmtrdkJOMmZrWkdKK0h0dHhOdkQ1YkR6?=
 =?iso-2022-jp?B?aFRCbEViREZHb0NVb0RZTW1RZXQyMmJKbVI4RDg5TjlLYWVIZXRhQkxM?=
 =?iso-2022-jp?B?NjZRQ3pRQy84by9OUzNPUzJXUTlianNmZjdTdkFrOWU5bjdGVEpLMHdO?=
 =?iso-2022-jp?B?NXhCZHkxNkZqejU3SXU2TDhtNWFzOHpLU1FWK2MzcU51N05yQnl6RThK?=
 =?iso-2022-jp?B?TWVWejFNNW5NeW9vaFowMG1NS0tvdnZpcHlPSFJRdDZ4UFpsaThTcnJH?=
 =?iso-2022-jp?B?cE1XQk90UDJCMjA2d1lpV0huMGVmeWlxWUIvQ0haQlFzcFdCNW1UYWtl?=
 =?iso-2022-jp?B?TURkczJNejhRQmRMR3Bjam5JbkxWRWtsUjhxcmo1RVZpVmcyZ0pBK2hl?=
 =?iso-2022-jp?B?OHp3NC85OXE5OFhVbzJrc3pubmljay91cCtXblFXeU96SlFlMmlaYkJ3?=
 =?iso-2022-jp?B?N255aHVZekhnTVBYMDRtWkMxMDQyMWVxR0tlZ3E0UUtBZU03UHZQajNx?=
 =?iso-2022-jp?B?b0U5MGdCbFdjVHFZWTRacE9teDhkc0Y1SHd1cnJ0elBLYkduRFU1ZkJM?=
 =?iso-2022-jp?B?T3o1Vlg4eWF6Ni9lOUtjdkFGRkl5S2NxcTlvNXpOdlJBV2JnSy9wc3p1?=
 =?iso-2022-jp?B?KytvM3o1VndQM0gwdjgzMi9GV3o1c1I4bU4zUXRHMFpHVDIyYlRDYXNs?=
 =?iso-2022-jp?B?TloxT3EvS0hueC9BeUNUUXduRWdjN0pCQkQxS3hEMGcycHdtdzVOQ2I0?=
 =?iso-2022-jp?B?VW5WZkRxOTcwVXZIS2t2L2thL25HZEpLRXdGOTlNa2JBdlg1UXUxOWlo?=
 =?iso-2022-jp?B?SFc2RU43KzV4Ky9WWDlaMk1PczlVaTducU5vTDE0ZzFla2JMYUdEOHk3?=
 =?iso-2022-jp?B?ZCtuaU0xMVhqbFUzVTZDR0ZJbHN4RXBPczVqR01tQmovVUhCT1FGSGZu?=
 =?iso-2022-jp?B?Y2RhV3FQWS9Vd01BMnV2QWt4dlhNN3RqZHh3c2htRTZFcGlmSEtTbnlS?=
 =?iso-2022-jp?B?Q3BxdytWTGpoSTYrT2M1WWs3Y1dSb2NaNlVjOUM0NzRXTHFPdjNFNUlz?=
 =?iso-2022-jp?B?UlRQdHR6UExTOVNtS2RpQy9TQm4yUGpkb0tWc1pQQlpoVlVqcEp6YlVo?=
 =?iso-2022-jp?B?dVhnbkdwYXVoSTN6UEF5OUtQN1VqUFBaRGk0YzVyNFZVaTErL1hINjA3?=
 =?iso-2022-jp?B?YlZlSEtOVzVZSUhUMHZDMEs2ZFM3OTZXVTAvQWg1eFpvejBvRGFLYmNo?=
 =?iso-2022-jp?B?TFU5bW1NNUZpRHRPT2lqcTI3U1BqQU9BdFpPVFF6OTJJazRMOEVSS2dh?=
 =?iso-2022-jp?B?ZjZYNE9yQW1iS2g2SHlySnFIQm9Qd01JcXdaajF3VnBwMVVUNjB0SytL?=
 =?iso-2022-jp?B?aDJKR01MR2pOVVhneGhTUmovcFkxaXVRUlhFa0VvaGxFNnM1am5sL256?=
 =?iso-2022-jp?B?cHRpOUlxUVF5NTlDcERRTjFGT0Jna2dtRWRIbWxPRGZYYUNnaFJ6YUVm?=
 =?iso-2022-jp?B?aUxXWkd2T3VnbDFURXZ4QW9KVXNYU1JORzRsWkpUbC92TkQzNU5xOGFT?=
 =?iso-2022-jp?B?b0hVaGNTc2hMeTBWNHcyTXV0UHdjc0RITDZzT2hlWFJON2RTT0ljRnVp?=
 =?iso-2022-jp?B?S2xYYk5iQklmTVJGandjYmlGYkpyaWpkVFE9PQ==?=
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
	02hpJb6Z3wQ8xTbemHftzAkaLHOaf6fo8bVp531+q4TCp70JoH798Cb+zggDuer8YmCB+gDNDYpyGeWQ806wttEsn1sAfOZADojDHA08Gkd1Wi/CCh1JwK+YwYlk4Zko9xar5vd/2Tu2umFUjCgHUSjBGnqCiKdFer3V+WC1vagY6G4ZwDni0H3uSoKegHj+piBg5M5aMaAx91aL2Pogu2KWim7oXcQji+OJayr2BNAOjfD1iBSVxDZKyR2AvJ8L42aef+Vdfld3aPujwoEDjm60tzAqHdsBdAOUeaL79wN7ZtABLU9ahQEB+2/z9pxzqCAY+K1vE9ltfnitarYtiMKpFEeIctszgdBMt3urs8pI7oHtUwl9BTGnXFbIGepwHYdYeFXUO4ptdDd61iT+nyN8yQMIJWhXF3sxM75pTjO74MRDQKL05j7zdZtNDSNCAHHc1wB9ieFtMR7ejk/8pd5C/UQ31U7QCHNt2mi8XJz1KU55gAT3SN3ULVjgSwrvkeDCTq4+FHORJAaWwd7xCc8GiOKOeT6fASlMQeNrQK4Ey+UUtgP5Sv54YwI/mWAeF6sMkwJCYRj3LlM7mdTprnLCqQeoEF6UWIWsR/DKk3FilYuo6UZ3fT0sSQG/n70v
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826c0b67-0cee-4896-7efc-08dcdc6bff46
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 07:39:18.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOTRPrQ2NvFs/ilE0NKeFTfRBqfr7dOuW+VF7VtnEWT8A9AJS4k+VhyqydZE9zdwj3S+pkHaCH1QHOJAZYVZ318BFPQUD0yUzOp0jJb5ccc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8316

Dear reviews.=0A=
=0A=
Could you please take a look at the patch when you have time?=0A=
Thank you for your time and consideration.=0A=
=0A=
Kobayashi Daisuke wrote:=0A=
> Subject: [PATCH v4] Export PBEC Data register into sysfs=0A=
> =0A=
> This proposal aims to add a feature that outputs PCIe device power=0A=
> consumption information to sysfs.=0A=
> =0A=
> Add support for PBEC (Power Budgeting Extended Capability) output to the=
=0A=
> PCIe driver. PBEC is defined in the PCIe specification(PCIe r6.0, sec 7.8=
.1) and=0A=
> is a standard method for obtaining device power consumption information.=
=0A=
> =0A=
> PCIe devices can significantly impact the overall power consumption of a=
=0A=
> system. However, obtaining PCIe device power consumption information has=
=0A=
> traditionally been difficult.=0A=
> =0A=
> The PBEC Data register changes depending on the value of the PBEC Data=0A=
> Select register. To obtain all PBEC Data register values defined in the d=
evice,=0A=
> obtain the value of the PBEC Data register while changing the value of th=
e=0A=
> PBEC Data Select register.=0A=
> =0A=
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>=0A=
> ---=0A=
>  Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++=0A=
>  drivers/pci/pci-sysfs.c                 | 28=0A=
> +++++++++++++++++++++++++=0A=
>  2 files changed, 45 insertions(+)=0A=
> =0A=
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci=0A=
> b/Documentation/ABI/testing/sysfs-bus-pci=0A=
> index ecf47559f495..be1911d948ef 100644=0A=
> --- a/Documentation/ABI/testing/sysfs-bus-pci=0A=
> +++ b/Documentation/ABI/testing/sysfs-bus-pci=0A=
> @@ -500,3 +500,20 @@ Description:=0A=
>  		console drivers from the device.  Raw users of pci-sysfs=0A=
>  		resourceN attributes must be terminated prior to resizing.=0A=
>  		Success of the resizing operation is not guaranteed.=0A=
> +=0A=
> +What:		/sys/bus/pci/devices/.../power_budget=0A=
> +Date:		September 2024=0A=
> +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>=0A=
> +Description:=0A=
> +		This file provides information about the PCIe power budget=0A=
> +		for the device. It is a read-only file that outputs the values=0A=
> +		of the Power Budgeting Data Register for each power state as=0A=
> a=0A=
> +		series of 32-bit hexadecimal values. Each line represents a=0A=
> +		single Power Budgeting Data register entry, containing the=0A=
> +		power budget for a specific power state.=0A=
> +=0A=
> +		The specific interpretation of these values depends on the=0A=
> +		device and the PCIe specification. Refer to the PCIe=0A=
> +		specification for detailed information about the Power=0A=
> +		Budgeting Data register, including the encoding	of power=0A=
> +		states and the interpretation of Base Power and Data Scale.=0A=
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index=0A=
> 2321fdfefd7d..c52814a33597 100644=0A=
> --- a/drivers/pci/pci-sysfs.c=0A=
> +++ b/drivers/pci/pci-sysfs.c=0A=
> @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, str=
uct=0A=
> device_attribute *attr,  }  static DEVICE_ATTR_RO(resource);=0A=
> =0A=
> +static ssize_t power_budget_show(struct device *dev, struct=0A=
> device_attribute *attr,=0A=
> +			 char *buf)=0A=
> +{=0A=
> +	struct pci_dev *pci_dev =3D to_pci_dev(dev);=0A=
> +	size_t len =3D 0;=0A=
> +	int i, pos;=0A=
> +	u32 data;=0A=
> +=0A=
> +	pos =3D pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);=0A=
> +	if (!pos)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	for (i =3D 0; i < 0xff; i++) {=0A=
> +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);=0A=
> +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA,=0A=
> &data);=0A=
> +		if (!data) {=0A=
> +			if (len =3D=3D 0)=0A=
> +				return -EINVAL;=0A=
> +			break;=0A=
> +		}=0A=
> +		len +=3D sysfs_emit_at(buf, len, "%04x\n", data);=0A=
> +	}=0A=
> +=0A=
> +	return len;=0A=
> +}=0A=
> +static DEVICE_ATTR_RO(power_budget);=0A=
> +=0A=
>  static ssize_t max_link_speed_show(struct device *dev,=0A=
>  				   struct device_attribute *attr, char *buf)=0A=
> { @@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] =3D {=0A=
>  	&dev_attr_current_link_width.attr,=0A=
>  	&dev_attr_max_link_width.attr,=0A=
>  	&dev_attr_max_link_speed.attr,=0A=
> +	&dev_attr_power_budget.attr,=0A=
>  	NULL,=0A=
>  };=0A=
> =0A=
> --=0A=
> 2.45.0=0A=
=0A=

