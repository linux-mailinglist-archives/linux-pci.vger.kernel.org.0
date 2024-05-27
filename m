Return-Path: <linux-pci+bounces-7836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D18CF893
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 06:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2648D1F213ED
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5952F2B;
	Mon, 27 May 2024 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WvkNz9YN"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2FFBEF;
	Mon, 27 May 2024 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716785876; cv=fail; b=d9dH+oPzITS9sWKydH4Jx1EfMWeLWf/OW62xcEbuyz0vm7wsEqcAgv2F0XeYm3jwvSudGxtKkSGgWAeAYKx/9qjVhcLcDUCE23MFfb4OoAhCxKWInxya4kd+lSGM4rgJgBxO6eaaVxFJa/Zjgqs2tc0Z85RUujUe0H+QNu3vxgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716785876; c=relaxed/simple;
	bh=rmPCxDGuWD/O0M26iceYRWq4kSviSGg1WRriLy5HFP8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jr/PgKb54euLp3qL85omSVvr69F2mefmpxPzI38WjEAIW3WkmrSR96TGA/iyEtQX92p3zgcC5UaaBGLWklQASekrTIv6yxu9ewVQfE+qiQJJvn5GC/BDnVcFoxvOrMf0gq8vibe0qdEPEHb02oxf/OTfRV/ghRmlixrocOVcObI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WvkNz9YN; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716785873; x=1748321873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rmPCxDGuWD/O0M26iceYRWq4kSviSGg1WRriLy5HFP8=;
  b=WvkNz9YN/51ORyRJb24z6vUtzIv//ALkd5J2qC5WrF9SU/2NLlS+TcAD
   Ky66xSWCweBNRJwmtLtvAlTrdJ8A6Fb8wudp3OIi1fJMVslnvC6uF37SQ
   u51rGiPrhLpeOb2hQeKIEGCrXPBGymn/5wCUptgDMXswxWXJ0SyCTvFKJ
   w8Arj48hdswOh+c8bGs06fl4HGyochgEDgGu6a7hcch4uaRpD2if8VcDK
   EKWCiH0yPrNJUo0PVeLz1GJ5QVFzu5DHUeulpPuv8dgX4pTBrV/+LzuOo
   vLYwnytYGDo/diMl+qvLhDA9xonUtIuuS2vefGLaoElvbm36ClNwqfPnK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="120502841"
X-IronPort-AV: E=Sophos;i="6.08,191,1712588400"; 
   d="scan'208";a="120502841"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 13:57:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSwKlJnacWmCY68DU6RC8DOTg2ruWBKs9Ww1VtZTbpl2T/PmKkL0n/EPau9j72ZSxK2TkZYhNe1mcZxF8QrgQzZOaMY/meUqZNXIrTbKjgoXkXnu9lAs44jRRuduE0nTcbjCYe/qfGuE46N4rdME0FAxGVFIYZ9WS136a+9BdE2Uox23MeE67BzV5JsfGMpXBCRKzw4UgZjXEfwQHv+AKCxemqqyFWS0KolLknn1e80wWqPp9xc1rVJtI+Nb6qjDeUelzU9NAz7+bRkIhS/cbDsWW5gtWq4r3GFqCm/gvoTKTZPHwG1PFGwV+b/1Rlz7GRRVZJ2ge+BLnwsb6npfRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhn1bn2oh9X1oll8mrg32gSEu8U6W9N0+dG8mFk54GU=;
 b=SPJnvoQnYvqJqq9VSUzpeXeVWuypJpoRPZ46UYqkopv6aM6zGpNwd0QDOZqx0+QgixYznSRzB2qaH2zm3eVij+71SNgs5owKX1kJHfuXLSHLPVEssTyr0dxqurYT9LEJBrjE/0qyHOj7LS6Bmh9v3NCsxW9J8AnlTdh0KIzryv5hkxiYJhoe0+zoQM98IVL4SVtSN60knb4eovGfDEeKBt9pOGcCyJz80NW817FANCxZEwfOyMDIZyDImgBnc1P/eLQgcD8wtwVxXmSzFhjXhf7w/v1YtJAAYKyY1OWZ7at4mTaLwHcOSiS4BHKL1hsTtw6hnpn10EJ5h32kfH6Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by OS0PR01MB5490.jpnprd01.prod.outlook.com (2603:1096:604:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 04:57:40 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::357a:7bf5:8d95:3cba%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 04:57:39 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v7 0/2] cxl: Export cxl1.1 device link status to sysfs
Thread-Topic: [PATCH v7 0/2] cxl: Export cxl1.1 device link status to sysfs
Thread-Index: AQHaoqyGdNi4aM+gaEWMyVZIr2rvALGqnM4A
Date: Mon, 27 May 2024 04:57:39 +0000
Message-ID:
 <OSAPR01MB7182C6E08F22874F2D08CBF8BAF02@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
In-Reply-To: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=4d3565d6-a0c4-4380-be3c-d0757a88fc81;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-05-27T04:48:23Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|OS0PR01MB5490:EE_
x-ms-office365-filtering-correlation-id: ba13ddb7-38a5-441a-27ae-08dc7e0988bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|376005|38070700009|1580799018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?M1M3aGEvdUlZZlBWeUVmWEtMSUVhZmFSaEF1Y2RCNG1QaXhDNEpRcWNB?=
 =?iso-2022-jp?B?Ri92SGMzZ1hUMStLZTQ2clE1TFU5eE93OStGb2RwNzJWZ3VTdUFJVkVC?=
 =?iso-2022-jp?B?NGQ3K1A5TXpNclorSHZkVWhJMjlnSkVDcjJHZDNlZkIzWHNWdWtWZGNG?=
 =?iso-2022-jp?B?N1luOHluNjBoNWoxaXcrdkdkNW5EbmUyTXoyOEtqbFhJeW1YZVR1NENt?=
 =?iso-2022-jp?B?NkttRGhyNHdHNzBESkxnU1NmK0Q1UGRJQUlxdGp2dVRtU0xzTlpoamI5?=
 =?iso-2022-jp?B?OGJuNmYrWDAwUHlRcEV5SFUySENFZDNZbVNFVkptSU03c0J1T0YyeGlq?=
 =?iso-2022-jp?B?VHNvTmFVYWI4a3NzNTZTRkxoNUt0L2VNajk5K1FNSG5VcG43WjB6SG84?=
 =?iso-2022-jp?B?dUhGRTdzcHV0VGFRNlYrcXN3dUMzWDIwUVBSWUp2R2ZXVWpLMEdvSmlC?=
 =?iso-2022-jp?B?REpqaFNNRXB3eE9Ia2JyV2xOUXJUUk9JbWp4RFVhMURXRE11aG4yT1J5?=
 =?iso-2022-jp?B?bTFWcVFGK05vMXdBRVpzTUJqQmREK2t6YmQ2cC9sUzV0ZlNqWmpiNE5Q?=
 =?iso-2022-jp?B?bTRPbnVCZys3N1FoRS9qdVFaa1NJckZlR05RT0ozZXFjVE5aTjNZMnZp?=
 =?iso-2022-jp?B?LzcwdHpoLzdzWHVhYXZoS21lYWFEWXNBRXUyd3REY1daQldIbk5mNG9M?=
 =?iso-2022-jp?B?eWptSm9KRmwrUUJLVWxPVHdCQ2lOaDA1SWFoZ2FVZitwdTJtbUY2SjlS?=
 =?iso-2022-jp?B?UDZrOHRBelNoMVJ5SnRvbS96MkYwWnlFMkZTU3hid01oYTlyd1VsaWpw?=
 =?iso-2022-jp?B?cVJ1VFBaNU1SczlwdWxDYndQQ0NiNDVtcE1YYURqUTU5dWhUR1JXV2pM?=
 =?iso-2022-jp?B?MVZURnpneEVMRmtpellqZCsrN0lYeEQ1Ymh5ZElUOVdmQlY1QisrNHdH?=
 =?iso-2022-jp?B?MDFZTVkrTTg2cDVGYlpGYmY1Q1czODZuYXNtQjltMlBRZDNFNmcyRHh0?=
 =?iso-2022-jp?B?VDNSTC9Dc2Uxenlxc2pEZmMxanB5dGIzam1jeTVQcCt2SzUwU1QyRG1l?=
 =?iso-2022-jp?B?NkgxM3k0czUyaDJDOUlnVDNzZDNMdjlxdU52aDNhbUpyV2hIYXMzMjBF?=
 =?iso-2022-jp?B?c0pCeXYweS8za2FkWUl3Ny9SbzZMMk9hcElKMDdSU0VZU213bFBIWXpa?=
 =?iso-2022-jp?B?dnBHdkJwZ1VEdkpJbGdOV2F4TUx0RklzWmhydkF3T1dzYXhDTS9qNnc5?=
 =?iso-2022-jp?B?VU1OVk4wUExyUWdjNVVuQmlORUUxb1piU1laYSticGU4TnNRZTMrV2F6?=
 =?iso-2022-jp?B?b2Y5SmsySVRwamdEalBUQ0JNclZwUzdwNHIvTTBxSzRMY3RSRk9vR3k1?=
 =?iso-2022-jp?B?Tzhra0ZTWFJnQkdjdVcweXI2cFpJOUVES3pDT2prblN4QjBybmprSGUw?=
 =?iso-2022-jp?B?a0hWejNoSW4vSGNhN1d3VVVsRTdPcXNDUXlsdDRyMk5Zd2ZTQ1RJNm5n?=
 =?iso-2022-jp?B?akVyeUpSajBabkYxTmlFd1J2TE5hUGg3RjRUMm9xSlZCNHlpK0ltL0tu?=
 =?iso-2022-jp?B?Q1BWN2Y5R0dYWmlaZmNzVHFwWThvUGVVWS9qYTBZUTVwUjFnYitNc2sz?=
 =?iso-2022-jp?B?QTdsTk1ybDdEQjFDWlpTZFB6clh2K1pSdlc1ZUt1c0NVR2QycS9iTDBi?=
 =?iso-2022-jp?B?MnlDUXpVazZYTVZzKzlJODJWSk5xcVVaYjhwaXBTWDBITzlBU2lVUmsx?=
 =?iso-2022-jp?B?TUJaM21kVDdOMVJDS3N5dG44RjYvL0h6UkxQRU50MWN5SkNRQ2laMlR2?=
 =?iso-2022-jp?B?K1NFTkE2Z0xTVjVSMFVBZVVjUy9TSjd5QmtMb3Z1emp4SStIeS9kYThw?=
 =?iso-2022-jp?B?TjlRN3R1Z0h0RmNzd3ZKRTVhL0w2UEtZS1NrNVlYVjlDMEpJdEZrbG92?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009)(1580799018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SUZ6T0pTaEozRC8vZmZ6emE4OGt4Y29QakxYWnBKWkFCb0J0ZjRRYWVi?=
 =?iso-2022-jp?B?cG0yeXhvdEd3SnJ6TDRpT1czWW8wYUk4NVZuSFNTTjhQZk92bWltNkVM?=
 =?iso-2022-jp?B?c1BFRDMyWkFucmFTTTJHUFByRHFTcTJrUkowSjg1Nkw1aEtCN2NOVC9Q?=
 =?iso-2022-jp?B?dm9idlRhL0srRk5YQkNaRWY0ZWs1eHo1NlRTTlEzSTIwRWdib2tJa1I2?=
 =?iso-2022-jp?B?TUEvdHQvZFpQZ2VZYXBZOGdLYllsMmVIaFBhV1YwOUtKcCsyYkhzVEFB?=
 =?iso-2022-jp?B?NVh0c2wzdHd2ZVFDSHRHSWlHcDVxMkVSWUZZRWF0UGh3QUd1UWV1NUJX?=
 =?iso-2022-jp?B?R3JNbEtSZ2ljWDZ5Z0JTMHBwV1ppZloyMUltTG93TXUwamw4ZWl6bFdy?=
 =?iso-2022-jp?B?NWIvdWJsVTVNMkRFcjdQSEgzd2I0MHdLMFBHcjhZaW83TEFua2ZaZDVT?=
 =?iso-2022-jp?B?Sm5CRVdmZWEzY3N4Z2ExQzUzampIMmk2d3l0MkNNcyt4Y1ZXWGt5NXYv?=
 =?iso-2022-jp?B?Rm92VGRmcHljNDhoT0x4N1luZnRMVWd3RDlBQ2hIK29yNmJVWXRuUjZk?=
 =?iso-2022-jp?B?NG1EOUQzbkZYcU5EZTlPaG9uVFRDa3p4VGFKN1lkYzN5RGxYTVc3eTlv?=
 =?iso-2022-jp?B?QW40NWtLRzMwTjlTWUhNRHpjWFlUTEcvTVprNGV0L1pIRmJ0QkFBZUtj?=
 =?iso-2022-jp?B?aXgzZWUycWdyOE5ZeHRlR0hCeUZnR1ZTV0JPZTNwcVkxdzZTZ1JoUXNC?=
 =?iso-2022-jp?B?N1gvSjZPZE42bUN0ZGtZRkNrNzJ3dXJKS0toNVFKdE0wakE0enVlZnBK?=
 =?iso-2022-jp?B?V0RlYTd4L25YbWNIblJJNnJ2VklpK2pvekhhTTdCK00xMm5mc1hxOXkz?=
 =?iso-2022-jp?B?dkZ4SGplUjVPWlRaSVZ5Tm15OEl4T0RDT2JSNUJqVVY5ZmtxTmF6MkUx?=
 =?iso-2022-jp?B?cmJCU1VpdFBXRTRKYnBlRmV0ZFJYRjFOekFrZzBHYys3UG5tdGQzRjFP?=
 =?iso-2022-jp?B?ZHIxVXNMUkhWd2NiVElmbzlrdHBiaDQwbURPYmFCNVhoZkcreHFFREtV?=
 =?iso-2022-jp?B?WmhKU2RPODhQZFVJdEN3QU4rMCtOczhTK2lPUWFia0dOa2Ftc1VsaWJI?=
 =?iso-2022-jp?B?bzlEenFBZTZWaXA5N3dLK0tTYlk4NEYxN1ozZWc5dFVVQnVBYmo2YUEw?=
 =?iso-2022-jp?B?eVdLMXg2R0x3OGVtV1FZS2lXbFFYVFExTkdlSTI1Z3dTQUNxRHNNcVhS?=
 =?iso-2022-jp?B?R3lWdmhTcUt4WkU0UWZ6dnlIYUFvMVMxTDI4dnozSkRwZ1g0cUtlYU1i?=
 =?iso-2022-jp?B?SU1EdGJDNWs4SXZVd0Nwa3pXR3ladEszZ1BCTDJ6aGg0QnNwajM2bGo3?=
 =?iso-2022-jp?B?L3hzVjM2dDhBYTRqNVkzOW1xOW1KeDQzUWNPc2F5WE5hcWhIRG5IY3Vq?=
 =?iso-2022-jp?B?allIVm80SUZ3dHBrVVdHck1LMy9rWFA1c1FXTFBNNU4vNDBHLzVneWhs?=
 =?iso-2022-jp?B?SUdiZ05aUyt2MGVLcEVoNmEzWkE0Q28zWEgxdXBuTGlENlZKcWdWQjEv?=
 =?iso-2022-jp?B?SWlhZEF5ditUblFNQkt5UXZybEh5TGRBTlJsbGRBMXRCamsrT3N2bERK?=
 =?iso-2022-jp?B?RXlOeGdpRHl1bStlQXZldmZudHlCMUhZOVhRTThoVjlzdkFrbzBnQk11?=
 =?iso-2022-jp?B?K3QvY05rTzRxeWJBcUdJb0djTkw5cEgwaWVaZE4wT2hOQU1aTU5UQm1m?=
 =?iso-2022-jp?B?VDZPb2hpZERGSnFPTU1UTG4yTU43WW1GNVdoZURXVlVEV251dnR0K3VR?=
 =?iso-2022-jp?B?bGhOZVlYSCtqY3FQNnp2VEU1WnRITWhBSlZ3NWlvZUd0R2xFQXhEV0JB?=
 =?iso-2022-jp?B?dUptSHk4eXI4MGk2MzNCdTU2RzRseDZrNGl5QjQ0TEhBbisxaHdMMG4y?=
 =?iso-2022-jp?B?VzRMRnNlZjVSSWxldnlacmtRUHlGMmJlM3BwS09zUHdSalpVVUFyQW1w?=
 =?iso-2022-jp?B?eXBaY24rbjh3a0Z4dkpDVEtzdGlkeU5zSXdKMUxzNS9EaEpkV0phQ2xw?=
 =?iso-2022-jp?B?U1krRjVTY2lyU3NhSzJJUW5URE03K3Q1Nms1WmJxZitIMkd5QjR3WUtX?=
 =?iso-2022-jp?B?U0N0MEc5RkFuQ29HVlp6RXRoZEY0RkxIK1c2eEh0QThPRjBLdWk1cGtI?=
 =?iso-2022-jp?B?blhLNS9OTFc2OVhMc1ZWOTZkM2p4SGFUTVNqek96K3ZZb1A4RUFScmV3?=
 =?iso-2022-jp?B?THlVTVBORjFXTEpqT2lqRDVHSStGT3QyWkU1aU5pc0lyekp3UkRmZ2hG?=
 =?iso-2022-jp?B?MjRUb1lQNURDOUQrNG9BZzl6dG82bHdYcnc9PQ==?=
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
	ewzbAEgX7sPhBdHcCQks780oGPJ4sgQChgqmkUTys0bh9aQCUIHArcu2ePdzsnqHxUFmjmzLht2vRiqLQjlGKZcBF2CMP1LVPJaLlzBWB8PZVcC4k9x0sgY8rgowASnrBQ2nQBNqNjTFWxRmht04blqySKBqqo3AAEMxl9MhMbWnt6ghn+UftjWw7oD9vvnUxodMinpSkCk2ogLZAdPhGlLQo3f53IGh1t88RjIaOEV9l479hT4D5MYFhAL5slUIRxpFkKf69RhJRxQlJTaF+9J7iLldIPF+yDeUC2uwiSG9Lx/AhJtl7/mO0YLC598w0e3FcOujOuIxvm3Rgskz5Y262f3hxCv3k6jBfr0wWK8Dghh2EMYVHL4UzmU0kFMnJpwXcLsD6WCmcEYcU4VAj3ukctd1gtPfv6zQZa/+4XRbmwFQY2jePHtwHJwRFLyCrLa5PE4bbcFSOoMlztu840EJry3gCcWHYpDLiMsm18xFfSkyQMQtdQ6B5BQSRx246CY+Q+zEkTbVTo5v+fTL4WJTAmTjcgEKWuNNbKYy2/yCUxA8ywuZNBxDgc8r7gFwpZikqVgo8MYhbyV7sT0wd7Nqt7cINwN6FSMswqtwUjUOub9WQ4v1Up0DGRCiqARL
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba13ddb7-38a5-441a-27ae-08dc7e0988bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 04:57:39.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOQ/RDcY6BC+csSmb+5q4FsB7oYIS3PWWX5baEw5CkevzxYGUHJW4v83S4Y0XdBXTTPWsbsjZ7kCYDkxpuDIiBJ61x54WAjFxgD6NCrWFxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5490

Kobayashi Daisuke wrote:
>=20
> Export cxl1.1 device link status register value to pci device sysfs.
>=20
> CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> the link status can be output in the same way as traditional PCIe.
> However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> different method to obtain the link status from traditional PCIe.
> This is because the link status of the CXL1.1 device is not mapped
> in the configuration space (as per cxl3.0 specification 8.1).
> Instead, the configuration space containing the link status is mapped
> to the memory mapped register region (as per cxl3.0 specification 8.2,
> Table 8-18). Therefore, the current lspci has a problem where it does
> not display the link status of the CXL1.1 device.
> Solve these issues with sysfs attributes to export the status
> registers hidden in the RCRB.
>=20
> The procedure is as follows:
> First, obtain the RCRB address within the cxl driver, then access
> the configuration space. Next, output the link status information from
> the configuration space to sysfs. Ultimately, the expectation is that
> this sysfs file will be consumed by PCI user tools to utilize link status
> information.
>=20
>=20
> Changes
> v1[1] -> v2:
> - Modified to perform rcrb access within the CXL driver.
> - Added new attributes to the sysfs of the PCI device.
> - Output the link status information to the sysfs of the PCI device.
> - Retrieve information from sysfs as the source when displaying informati=
on in
> lspci.
>=20
> v2[2] -> v3:
> - Fix unnecessary initialization and wrong types (Bjohn).
> - Create a helper function for getting a PCIe capability offset (Bjohn).
> - Move platform-specific implementation to the lib directory in pciutils
> (Martin).
>=20
> v3[3] -> v4:
> - RCRB register values are read once and cached.
> - Added a new attribute to the sysfs of the PCI device.
> - Separate lspci implementation from this patch.
>=20
> v4[4] -> v5:
> - Use macros for bitwise operations
> - Fix RCRB access to use cxl_memdev
>=20
> v5[5] -> v6:
> - Add and use masks for RCRB register values
>=20
> v6[6] -> v7:
> - Fix comments on white space inline
>=20
> [1]
> https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06
> @fujitsu.com/
> [2]
> https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@
> fujitsu.com/
> [3]
> https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@
> fujitsu.com/
> [4]
> https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@
> fujitsu.com/
> [5]
> https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@
> fujitsu.com/
> [6]
> https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@
> fujitsu.com/
>=20
> Kobayashi,Daisuke (2):
>   cxl: Add rcd_regs to cxl_rcrb_info
>   cxl/pci: Add sysfs attribute for CXL 1.1 device link statu
>=20
>  drivers/cxl/core/core.h |   4 ++
>  drivers/cxl/core/regs.c |  16 +++++++
>  drivers/cxl/cxl.h       |   3 ++
>  drivers/cxl/pci.c       | 101
> ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 124 insertions(+)
>=20
> --
> 2.44.0

Hi all.
Gentle ping.
Is there anything I can do to help with merging the patch?=20
I believe I have addressed all of the points raised in the review.



