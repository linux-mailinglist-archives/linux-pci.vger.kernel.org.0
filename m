Return-Path: <linux-pci+bounces-14505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95F899DB11
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 03:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC91F1C209B0
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CF224D4;
	Tue, 15 Oct 2024 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hglI/MsZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B434BDDBB
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 01:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954376; cv=fail; b=O10ha7zmOsrotbYh+w9WXvaeRrTUvKaKTWdgSgwBUv8lnDeMPV3lWl/OQ+P16bL5yNvDxKiTM3suo32uu4qoG1rr1llTffK3+DMM+fJWetsIO7dyTN+VQE91EzrNrxkJSDwlaGOz/SumkRoksuvHvwsO18NkcBTGWVZn1HDvLzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954376; c=relaxed/simple;
	bh=T8W299rJSGqpi3o+QaTUEjNhKVpaJRlImi/lIBk5BKU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUK+kvyop6JjBzQhyuMMG11VoMMiBuJxAAntNGjwCFFw2Ozf9OaIKoxdZW7B5ddWb6o2LpkIwRCixBMCfTvzEZcNNmXdJxlYNnYLAXXuQNK39ibeF8qPWDmH9bnZpGVv4+HNDJYAuz6OtgU803cf8RP1OG/gst0asEIosTHiUg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hglI/MsZ; arc=fail smtp.client-ip=68.232.152.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1728954374; x=1760490374;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=T8W299rJSGqpi3o+QaTUEjNhKVpaJRlImi/lIBk5BKU=;
  b=hglI/MsZugyfYiGD+1iQy5/DOpeYHa0957nxG3knyARnJ6DjHJklIzV5
   udFLcTK9euWOuIJlBmTacPV0/sIqUkZQJm3TJqcTJ4ckaF7kAmYXifbU9
   tc092QVJBwU7z0ZlOAzvIEcDD+irC757OSujq5D8KaMJeF2ZSY6DGTYb6
   iUCjRWXzIqJZ5OmaS9bfBcYVmDPCytZaXqv2DQotHGcW4dJBmoywT5YBa
   gW3nDSq/DwdVciRT1N1SZHRsCs/xaPIxWhI+WVrOfj98e2H8eYN1i86UF
   xlzRkW8kuCf1Rak2TjF265kqddXvwGzdm1w+AkP6y7+p+E3whItwpjHYb
   w==;
X-CSE-ConnectionGUID: oPvrpYU4RgiA1x5K1c9/Kg==
X-CSE-MsgGUID: PFu/n682Q/WuDzO5Z0IsNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="44755868"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; 
   d="scan'208";a="44755868"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 10:05:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b43st5ItXeau5tdSt8lab9upL+9zy5zU8TToMDgh0mN/tnlOb8iGRdjx8GIeE7nMrx2BMsmfW4LmiGje1URXaJ77moAanY3Vyq3cLS3B8dITt4AN4i9aOGX5J4Bll/iNaI1gW3W7FQRFl+IFLkY5bZKZcuagIjmRYSCQK+z436Sxe3/CePVVGcVmwO74igwCCvtiSAI24BPC00o3YmUGXdNWkoI0En/hxtzF0VuHoONWegeL12a64AU6PTJunzpU8Ir/TVeHIxTWJXsP/v/i5IKgGoYdmpTKhFRVc+pwps05oLPn4nJ9NNjNazEPTe7oCj2xWlhS7SvVSD6rs0WE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkWhQaeM9IZaIp8akxg/DmQ7cUjeIUicEY4crr8d5Oc=;
 b=BMHDO69OfmWU72b2DdgMwcqPbDL6876/1y3Yga4alvK05pYtNBGWgn90GJtJAO5tG8pHpZ7bTJ5L7sqfPFZhM5q/vE9M+wctqPfbuWARFRpzWBQ1NFL+3pNGptF9Di7o5rTRDnlPCMuWZ3K66lUYvryc6G+49JMu8Txwf0m7kvM0bVeSNE7lOC4zeCgF5S1clmrRvrCkWUhM01q6Vs2oo+ABUE2AoUA0QaKkKln2lMgorVLYkVeH/MDeqSUiYqtuQVTO5ARnNZAciRQ1Dtz37Kzr3OTkjYnnMUQzy2lwnn2JQb8Qore+oEHPMcjjlMtjqLP90zFgd/QhsIEAPprM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TYCPR01MB6785.jpnprd01.prod.outlook.com (2603:1096:400:b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 01:04:59 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%4]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 01:04:59 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kw@linux.com"
	<kw@linux.com>
Subject: RE: [PATCH v4] Export PBEC Data register into sysfs
Thread-Topic: [PATCH v4] Export PBEC Data register into sysfs
Thread-Index: AQHbA+h74ei4/Wguf0W/KiuMbwib67KHLxfw
Date: Tue, 15 Oct 2024 01:04:59 +0000
Message-ID:
 <OSAPR01MB7182E3AA1B504E46608E2375BA452@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240911012053.345286-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=4364afd7-99cf-4dbd-afe8-dc8f674092f8;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-10-15T00:45:15Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TYCPR01MB6785:EE_
x-ms-office365-filtering-correlation-id: e7f24407-639a-4df1-4dd3-08dcecb563fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?YTA1VXZaMGhqMHcrcndkZlAyWDFZeFp0dCtIVlVZQ0lqS2tZWEFDOTZT?=
 =?iso-2022-jp?B?NldiRkhoSVRHU09RUUxIR05SMzN4YVh0N25UVHIwbnRNZ0VLM2dDRENG?=
 =?iso-2022-jp?B?SGJVRDRXU00vS1FiZlFFSGxubTgvL3duRXBvM05pcER2RllrMmFHWDJ6?=
 =?iso-2022-jp?B?YXh4R0xNSWwvQWdIUXZDem5kSXRvUnFKeUtCdHliVm5PMncyLzMydGJa?=
 =?iso-2022-jp?B?cEU1eWRuWHFFZ0VieGNad1VmZlFwc1dOL1FKNzB1RjU3TnR6WUhhZWNN?=
 =?iso-2022-jp?B?YjdaQ0FVajVqVlNSK0RjOVlKSGJlQnBkTEtvbmRIdkd0RWtNaFZkbjhN?=
 =?iso-2022-jp?B?MGp1MTJtd1YwSmpQczBtMTU3b25KUFR0ajdkNjJDUFNMcy9RWWxncFdJ?=
 =?iso-2022-jp?B?aWpTMEZiQTduc241bjltR0QzbGdUQ0lvUFY2bVNTNDBjdzB3YWZmUlFQ?=
 =?iso-2022-jp?B?VTlPWWRxbjNPMkRYQTd0NG1EdXJkNHdxQ3Bpa3p3cStQcEZVQU5UQUxY?=
 =?iso-2022-jp?B?UTJKZ282VnBjNnV6NE44Y1F4YjJ0VGtFU2hrbFIzZU4raG95bE9meG4x?=
 =?iso-2022-jp?B?ajE3ZHNuK3NpV1VncVk1SENPTDU1Sm45c3VyZlJBU005NENEcHJwSjlR?=
 =?iso-2022-jp?B?SXpGMWcvSkpmMnRZRGkzSXhoTVF6RXVwTjI0NmJWYkJRMjFoS0Q3MnlW?=
 =?iso-2022-jp?B?NTU3MTBWbEswWDF2NGNncXpSdk12Mnh1c0Y1ekUwQ1VIdkhvOTNYWnFr?=
 =?iso-2022-jp?B?UFVQeDlPTlU0Ym1JK0VOY0s2bWkvK0dZTFh3aTVvN01RNUtaeHdYUGFy?=
 =?iso-2022-jp?B?YVp1cUlrcjZ2MnFXKzJnbVczbXhtS0cyczVpUEdsWkVuWXhiVFFtYm9v?=
 =?iso-2022-jp?B?V3IrYlE5dXh6UWVMSmkzczZDdWw4b3REcFZDMVhnVlBnZlAxY2dCM0Er?=
 =?iso-2022-jp?B?K3F3WDk1YkpEYkUvSnZ2eWMyRnIzMXNaZVBTajBuSGRmQkN4S01SUjR0?=
 =?iso-2022-jp?B?V2JwSnFaejJSTzd1WDdsNU5jWFNTTHZ4UTVTbyszQ2JoMVBzMHlTYldo?=
 =?iso-2022-jp?B?NzB2SW80ckFYYWtUZExydXZWVWZwQWFrSS9paFV5L2JwZ3p3U0hteDhW?=
 =?iso-2022-jp?B?dmRxMStsVkJNaktSNHBZNWpiN3ZrYUg5R2RGQmRYREtwYmltVFc2WkdZ?=
 =?iso-2022-jp?B?SmREUFpSZDE1WXhORGdlczZyalZjMWw1RG4yaURXUmluL0ZuMWNVcUFJ?=
 =?iso-2022-jp?B?S2N2cmFTVnRzcEhDUk9Uc3FvendIMDdYQzR1NlBWeWhFcWNBbktRYUJG?=
 =?iso-2022-jp?B?MVEzemZaN01HRmUrOEtuaERnRWpsdnFVeTZ2dHRYSWhRM1dqSzkxdkVK?=
 =?iso-2022-jp?B?dzZHRTEzZld5RVoycnhtZnI1TUszRHYxY0NSZlVIZzR3a1RJTzdOTzNl?=
 =?iso-2022-jp?B?RGFFMmM0RTg5QkJhaE9ZRzVGdCtkNzZISE1aQUpxMVNrYWQ0YmVCOWZw?=
 =?iso-2022-jp?B?S3hIdHdadkZjTDJJV3daTVpBYUtYaitCVWpHMytLOCtGcWRkV3c0d1d3?=
 =?iso-2022-jp?B?eFl6WWRjSExqVTM0T1pWZ3JGZ0pzVGtwdlN6SGpHak92S2tDcGdUNzFO?=
 =?iso-2022-jp?B?WTFSSy82Yk14S1NTTnMxNzdtQ0dzVjhjS00yTUd5R3VTV2ZzbHFUb01C?=
 =?iso-2022-jp?B?Tm9nTmVPbXF0ckl0OG9Qd0JQc2c0RmF1SE1lcitzVEw3bFZoNnh4d0do?=
 =?iso-2022-jp?B?b0JmT3NkdEJCL3Bselc4bFB3ZzlPbFRYdE1rY29IaG84RmdpeFFvMTA0?=
 =?iso-2022-jp?B?S3BWcWNWMmN0dFFjaENnZEh1NmMzVDUyRDdnS1VqYkdIdnZmV2NxNU1J?=
 =?iso-2022-jp?B?RTFzZHBvQ2Ezc0pLSnpHbjdPWVpxOHprbEQ2V1cyWU1TT0crYWR2QWJQ?=
 =?iso-2022-jp?B?V0pDOXRzOHpOcHlzZExhdDBrYk1McDVVL3ZMYTFkSWJUSGlLTXNSMVZJ?=
 =?iso-2022-jp?B?RT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Z1Y3S2Nlck5tYzVXL3YydnFJVEZ5L0IxR24xdGsydVA5cWpQWWJZay9j?=
 =?iso-2022-jp?B?akpaQVlzUDdLRjZlL29wYTMxT2pHTFgyMjdjSWgyY0MySks5VGlnZDUv?=
 =?iso-2022-jp?B?NjNWbm8yQ01WNzNXNmtSOERNeSsxeU9aN1JQSUhWY1NUMXVDSDdSWHNW?=
 =?iso-2022-jp?B?dGVLaTZsQXV4RVVkYTk0dTBtOGhuYkMvQ0NkSFoxUDJuMmJLNzRsMXVT?=
 =?iso-2022-jp?B?YlRxTEs5UE9EbnVXcTNNeVpkenNVcXdSWEtFQzNXbU9OTmN1UVVoWGdy?=
 =?iso-2022-jp?B?NTNtN3pmYUIzK2g5akRTNGVPemZ2bmltVXc0Y3dCb29VWXBUUkVnOXpL?=
 =?iso-2022-jp?B?RTZMdkpjNFcxanF5RTVMVHlhZXdySHhyck9zeUhOVFFsRERrSnBKQmZI?=
 =?iso-2022-jp?B?Nmt1UklxK09kZXVKY2l2ZjR3Z1NpZ1hiMVJ2TzhKaGQrRXYwVEQ4RGJY?=
 =?iso-2022-jp?B?Ym1xNGFXSnVpQXFTUnJ3NkYya20rMTUveWJrSWZkSmhMMFpobVV3NnE4?=
 =?iso-2022-jp?B?QTFTVFVvb01GeXZGOTF0T2JocFZxekhiMVpzL3Rtd0h1Y3o1a2JTZmVk?=
 =?iso-2022-jp?B?RUVmRDZWYXIrdUJJOTBjbU41bnpUWjBCMys4Vk4wZmZHQVh1amh2S3Iv?=
 =?iso-2022-jp?B?MWVocW40T3AyWFFPSHlLZFA1djdQQ0MwODFWTTdiM3NzN3hQcDk3OGVS?=
 =?iso-2022-jp?B?djcxS01jR0ptaXQrd1c3S2VseWNLOXAxbS85SDB2OVZxWVU0bWRVaWN0?=
 =?iso-2022-jp?B?YU9Lai9DUWFoK1IvKzJIeFhuYThXQWlmVVFYcGRZaE16aXMvLzMzZ3N4?=
 =?iso-2022-jp?B?YnFwQTVSV096bWNxVEZJaUovaGZCZUNZUGFNVFA5anJBZlVMVHUwSlZ4?=
 =?iso-2022-jp?B?ZXpaanQ4M3Fic1o2ei9GMW4wR04xcFg1ZEVUMmtYRlpZaFM5NG9XNjBB?=
 =?iso-2022-jp?B?eGlGT1IrbVFRNjlXdDNVVml5NEx4Wm04UHZtakVZTFJoZmE2L1NWQ0Ja?=
 =?iso-2022-jp?B?RStZejZvK1hlQzhvUW96NGZadUVIcDJpN0VWWVk5aHdDY01yYmJiQXY3?=
 =?iso-2022-jp?B?bGR0K3BSZGtZUTNMM2p2VjZDaURkMTF0UUQzOE54NldkNklrbFB3alBP?=
 =?iso-2022-jp?B?MEwyZ3J1aFMxeGJ5RFkzbG9IRUpuTi9pWmZxWTM1RjQvZkFXWlMvQjY4?=
 =?iso-2022-jp?B?Ym5oalNTczV1cnBiN3A1eVZYQTlocXBnK3BGSmJJYk1LUldLb3g4MGJP?=
 =?iso-2022-jp?B?YmRXYjNVUEt4UkZ2UmxDemNIN0l0RW4vQnlxbnVPS2ljWFVKVUhCcTJy?=
 =?iso-2022-jp?B?Mm1xWThrdUlzeStieTd1OHFXM1QwMDZsOGM5RUdoSmRuUjRlV0grcHAr?=
 =?iso-2022-jp?B?QUZMY3RiVEJnNHpldEZhTjM3SWwxcHNQZFZEYStoQitRUzllclFBM3Zy?=
 =?iso-2022-jp?B?NDlDNWxPcWNvTWtodWJhY3RLbm1tekRYcUtxK3A2M2NhdkJGa1hwdVJ2?=
 =?iso-2022-jp?B?ei9zNHlLVGJmMWw1OG05TW5qNmpFOTZobmt0SWx4cUUwZWxoVjREbUJt?=
 =?iso-2022-jp?B?OVBMWVpHODFTQlhyb1JvMUdkb0VjQm9LbmY4V29hNW1WLzYvRVVFU1JJ?=
 =?iso-2022-jp?B?WWlkRDZzNUtCaTIzb3NEdnZsYitJcEZQK3VMVlNCOUVWazZxOFNjcTU2?=
 =?iso-2022-jp?B?T2d1QW96T3hNN0dQQVNIQWJmL3VMV3NOYkZvNVJiVTd5U21iMUxwZXJY?=
 =?iso-2022-jp?B?QnpJQjZqUDI3bmprY2FRb21HQ0Zsck9YamUrcjVUOFk3SU9yUmdLVHF0?=
 =?iso-2022-jp?B?YnJEU1NvSVBmbTJycit3YU9wb0ppLys4SzlYTWdCaVZ6M2k0QVhjcGF4?=
 =?iso-2022-jp?B?bVUvSGRuWVJWWWNrWTNNTnZyZVZIcWlhdDlqdEorWC9xNW9nTS9xeGtv?=
 =?iso-2022-jp?B?V2NEL0JIUVR2dDh1UlhuR2FoWFYwRXdhZ09LdjM5MUUrR3hxZnFCakgy?=
 =?iso-2022-jp?B?aERVOEp6cDBoZkRLYmpXL3Y0RytSVVVSS2hsMUZ1MVlvajFmQTN4UURM?=
 =?iso-2022-jp?B?ZmhCeHFoRGc1eHJhMDUrc2xBaWh2UHcvSEhzR3ZaQ0UyY1FyUjBGVFFT?=
 =?iso-2022-jp?B?K3cwQ2M3c2tUSUNzUG9rV2dhUE9Vb2NaTDBCT2ZqdFY2K3pSRjZqcUdw?=
 =?iso-2022-jp?B?Y1A4czIxUkhCeS8ycEhGKzhTMVlVMDl2QXpQYWJsQzFSUlFNdGl2M01a?=
 =?iso-2022-jp?B?bEp1b3BVTUw4aEJoN2Y1eDBJaVhXN0o4Z3g2RVFYRzBqa1ZiOEMwQ1Bt?=
 =?iso-2022-jp?B?REhVZFg1emtHNnBHM0w0b3R6c0hPNGVnNUE9PQ==?=
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
	7kFx3AhQOgHMcmAZsYIdzdqF2rNSFu5YuyY7HYOFsz5Nc+Evzl8aNWxkdVyPspkrc5oo/OTk1S3gZcNQXgaVjhfIVwU1Dy2OTRj1AkErncjCP0CvjgRFStZ0t58MoHBRWxydc6m4Xb84pQ9U9k5cMZohGkR4cnUxq3ndW/9sZT2BucfoRLhMc0J4vXWNtN4e7XFCLQkO3W5681fLYctJNfjzzShn2RBmRalKw42MscJPYYk5c2yTQgcoPT1KDONhmin2dm2f8WyjOMSQKOPSwkPEuH0xYH0vODCc/wtFJQyEJPWOw+4AVg3YZOa4ZK2j9xeo/LULlg5cuKdmTFnQTvt1KNK8Cc2M2Bevug9TGTnPOZsrjoQb+8VOE0qW3GlM/iNFFvwsl3ak7ayKRCeBhYOhoxnkmHFl+Xc08R3Zvq3VbzUhosxr+xhZ9Jsd78IZQ6nmziTfiGIuS9+ZRHjGvSHRgJccYwq266jiBDQ7/zQXNySFPbivpio/aPDsmRgGa5KszhVw7nGOloOC3ctfE412ZCu/IiComio5iixJm2JxcIu38gSizsFt+YVDHPcTovLlRaWeArTqPU+DbDnLwbIu9mMBN0LU2Lo09mMliPqWFuE15sG0BVW/z4sE5NbJ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f24407-639a-4df1-4dd3-08dcecb563fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 01:04:59.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ayMSVLF199nL7aMbBuIktzKlHl7nxv0EJNzuvUjCNDmPsUQVuOfctREEDIX679ITWGEvHtMQpjv5/TnFC+u3Q6+k/B+DtQ+f6o9FETNKos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6785

Kobayashi, Daisuke wrote:
> This proposal aims to add a feature that outputs PCIe device power
> consumption information to sysfs.
>=20
> Add support for PBEC (Power Budgeting Extended Capability) output
> to the PCIe driver. PBEC is defined in the
> PCIe specification(PCIe r6.0, sec 7.8.1) and is
> a standard method for obtaining device power consumption information.
>=20
> PCIe devices can significantly impact the overall power consumption of
> a system. However, obtaining PCIe device power consumption information
> has traditionally been difficult.
>=20
> The PBEC Data register changes depending on the value of the PBEC Data
> Select register. To obtain all PBEC Data register values defined in the
> device, obtain the value of the PBEC Data register while changing the
> value of the PBEC Data Select register.
>=20
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++
>  drivers/pci/pci-sysfs.c                 | 28
> +++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci
> b/Documentation/ABI/testing/sysfs-bus-pci
> index ecf47559f495..be1911d948ef 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -500,3 +500,20 @@ Description:
>  		console drivers from the device.  Raw users of pci-sysfs
>  		resourceN attributes must be terminated prior to resizing.
>  		Success of the resizing operation is not guaranteed.
> +
> +What:		/sys/bus/pci/devices/.../power_budget
> +Date:		September 2024
> +Contact:	Kobayashi Daisuke <kobayashi.da-06@fujitsu.com>
> +Description:
> +		This file provides information about the PCIe power budget
> +		for the device. It is a read-only file that outputs the values
> +		of the Power Budgeting Data Register for each power state as
> a
> +		series of 32-bit hexadecimal values. Each line represents a
> +		single Power Budgeting Data register entry, containing the
> +		power budget for a specific power state.
> +
> +		The specific interpretation of these values depends on the
> +		device and the PCIe specification. Refer to the PCIe
> +		specification for detailed information about the Power
> +		Budgeting Data register, including the encoding	of power
> +		states and the interpretation of Base Power and Data Scale.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..c52814a33597 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -182,6 +182,33 @@ static ssize_t resource_show(struct device *dev, str=
uct
> device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(resource);
>=20
> +static ssize_t power_budget_show(struct device *dev, struct
> device_attribute *attr,
> +			 char *buf)
> +{
> +	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> +	size_t len =3D 0;
> +	int i, pos;
> +	u32 data;
> +
> +	pos =3D pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_PWR);
> +	if (!pos)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < 0xff; i++) {
> +		pci_write_config_byte(pci_dev, pos + PCI_PWR_DSR, (u8)i);
> +		pci_read_config_dword(pci_dev, pos + PCI_PWR_DATA,
> &data);
> +		if (!data) {
> +			if (len =3D=3D 0)
> +				return -EINVAL;
> +			break;
> +		}
> +		len +=3D sysfs_emit_at(buf, len, "%04x\n", data);
> +	}
> +
> +	return len;
> +}
> +static DEVICE_ATTR_RO(power_budget);
> +
>  static ssize_t max_link_speed_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -629,6 +656,7 @@ static struct attribute *pcie_dev_attrs[] =3D {
>  	&dev_attr_current_link_width.attr,
>  	&dev_attr_max_link_width.attr,
>  	&dev_attr_max_link_speed.attr,
> +	&dev_attr_power_budget.attr,
>  	NULL,
>  };
>=20
> --
> 2.45.0

Dear reviews.

Could you please take a look at the patch when you have time?
Thank you for your time and consideration.

