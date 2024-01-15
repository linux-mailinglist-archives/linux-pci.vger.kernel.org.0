Return-Path: <linux-pci+bounces-2142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15682D590
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 10:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369241F218BC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jan 2024 09:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B31C123;
	Mon, 15 Jan 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="uL93W0/j"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74749C120;
	Mon, 15 Jan 2024 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705309820; x=1736845820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cF0l8fETEqqmBJZCiRBXPeRjzkmWLsc+pcUpImdzha8=;
  b=uL93W0/jck5ifi3jtkfnVRNhQmuEAbo1A5MSSm7rPo3bUKuoTYwtTyfi
   qTiFFeU7GzZark35x1wD5cUmMd8e5FTdY08h57NN/4tnmPc0hvjjxqTgL
   1OP6ou6y8PUcP01FSvBUCZG2hYNjVWzTwlnyUih6ZTNoGGo+1ku2XFRjS
   a/oRxfFPFql7sbe3DhZ6qUbjLbaXqJ4ZIeHYBJFKlwtD3QdHDoZF6XJTu
   a+vJdyLmO3aShr16CW+dQ19awvwO5ECBoNJiWChZt8xtLkf9BQQkAV8NN
   pj1mCbGyhQXXYVdoXFzgTyLIGNTCQOIC/vyrmvGprnDodGQIXL8A+lLLh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="19262361"
X-IronPort-AV: E=Sophos;i="6.04,196,1695654000"; 
   d="scan'208";a="19262361"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 18:09:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc6Dzd1SJuidHivrQEDWhUmwDoH9tEVU8ZiW4YLPzDK/tlIdJib+qwuDZY9Lv58b84huvTZQ5uT7WpedOc+QFN93TLhlkKdYYrCA6DI9KQoE8+4pcsdiZTJQ9bxGajGJcb8eD25ncV19hpixDrqiBtkcINrTeSSzHwYOkwlBUivjjzvJXBZ43B7e4EghZ9UOp2GJIPALe9OR/w0sn0eRxFtW9+VQLPR7WjqEg6zsuDU5cMJ7LfYWKxq+lDKhsVMayHCPa/nFHYohJCaoKYBaZZkvvwbOQ9XELdtguZKmI8L3LIlNo8jzTrEKYVpLmvX23WsE+vRNe5KV0pv7tnPZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tKgY/OdGkaywT062KE964JBVgDqtnwxcYYQwa2niLY=;
 b=UNE566ntsieyWxmVekTKR/+ZCGt3WzfYMU0rGj2yvMPRHOwzeBCeV1b/Kb8uk6d2eLvXrWIKgc6McgJV7il+z/LC2Jue6/597oNGrIhLjGGnYYmVe+cnsrfQ+vI+otipkhiStMrAf2pcPv2J7t0rBt258a0Uc2OHaMqAS33Df1RBA0PJWL6kuAOEWW/xDfcs/7HEbjKMHvx0Z5/41f21f66t6Lcqdm6xVwKEw4EYq8qpdDemT+rlT2JUgL+Oh8U20vHpBhV8uT3hvywHQ/7zXQokI0jTpDdNXn8Y7dTXAQxIL1rRjMEcTLohPGCmhMhsqC5MVbTQM42AU6PbMWjjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB11764.jpnprd01.prod.outlook.com (2603:1096:400:3b8::7)
 by TYCPR01MB6095.jpnprd01.prod.outlook.com (2603:1096:400:4f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.17; Mon, 15 Jan
 2024 09:09:00 +0000
Received: from TYCPR01MB11764.jpnprd01.prod.outlook.com
 ([fe80::19d6:fc5e:27ce:1700]) by TYCPR01MB11764.jpnprd01.prod.outlook.com
 ([fe80::19d6:fc5e:27ce:1700%4]) with mapi id 15.20.7202.017; Mon, 15 Jan 2024
 09:09:00 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Jonathan Cameron' <Jonathan.Cameron@Huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "Yasunori Gotou
 (Fujitsu)" <y-goto@fujitsu.com>
Subject: RE: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Thread-Topic: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Thread-Index: AQHaMwXr559Y+43gz0Gam6b/l4Ghc7DRwyuAgAItCgCAAj19AIAEiiJQ
Date: Mon, 15 Jan 2024 09:09:00 +0000
Message-ID:
 <TYCPR01MB11764763DFE894B96EF0C6C38BA6C2@TYCPR01MB11764.jpnprd01.prod.outlook.com>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
	<20240109155755.0000087b@Huawei.com>
	<659f404a99aad_3d2f92946e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240112112414.00006443@Huawei.com>
In-Reply-To: <20240112112414.00006443@Huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=199ad4c3-ad50-4f71-b548-25b10445d77f;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-01-15T08:43:39Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11764:EE_|TYCPR01MB6095:EE_
x-ms-office365-filtering-correlation-id: 13f1c570-26e7-4e46-feba-08dc15a99cdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m6N4tYsf/LzDWeJV2V6pvyivgf4sdudoNb2Mjt8Sq3qprM7qUA+0+7f2fi1TiMgP3f/jgCtSi2haQqwcAGHQSk6TYzUPVV1/nd0Nz9F5Rhlv+zotFDvaifWZfXs5KJRAqFjzZk4dCG+zePphEhutwLVXxAJmZSpWJa5Hqa5k/e2oVIc0Z6ZLzbScuupGQyH2LbtITvQQ21VhQtLcbM+xOV6xwbSLkzppnmf8WpZ/C2Ns1COh/0g/VSkgwZUc/u7zXNIu1TR/33wFGUZxF7DgrtqJHXoAzEby+jEvuGoDjr+L6T6ztAQE17tTim6DIgiC0nufLf80pgOqXzA8qIwo1THex09bqhAWez/AGkh1a59U8apbNQdPvrTtPp3z4IHUMNIN1Lkrf9TTwGZfWN+Uq4SEube6wvcIURzhPItGyzxCuBSH6k5JAgPfdSAYQHLKWzYvbWLeeY3mw8r84Mjf9ImeBd8Z5JfGCMmRyTex2QSa0SUe3W1fV6qL/mNDVEo7QDH8SypE8Z9oSUqGGx/sMDzKcbQMNrx2CMimPcm/3eig9npeffxQDOlRrnia5GvfZ05Tl0wmA3THqCEpr8sw9ki+1bK5h7R0RpmYjXAP3bKEVhGPHtNPqejs3TdLWsueTDLQUvG1UhS+dFfzRRKt7A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11764.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(1590799021)(186009)(451199024)(1800799012)(55016003)(1580799018)(26005)(53546011)(9686003)(83380400001)(85182001)(86362001)(33656002)(38070700009)(38100700002)(82960400001)(71200400001)(52536014)(110136005)(5660300002)(4326008)(7696005)(6506007)(107886003)(66946007)(122000001)(66476007)(66446008)(64756008)(66556008)(76116006)(316002)(8936002)(54906003)(8676002)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WXhpOGt4TjVGMzN4NURRT2FOWHFnVHdjTFJkenZIdnRyaG5rYTQ2c2kx?=
 =?iso-2022-jp?B?RThzQ0tLZ0FwcHRWMTNXQ3YyKytsMmI4U1QxKzZrNkx6VURJVVpEcVly?=
 =?iso-2022-jp?B?OFg1bWNtY09vVDVDc2ZETnRpWkRlUTVOT1F1endWYktvb1B1amlMU0hK?=
 =?iso-2022-jp?B?a0Qya2lKUTJncE1yTC9Pa01DSnVxZG1DaUpHU3JVMmY4VUtLOTMzQ3py?=
 =?iso-2022-jp?B?cXlmRGl2MkN5NC9kQ214VWFvYms2RVp2VXV3MXkvNnFZci8zd1d4cnF1?=
 =?iso-2022-jp?B?L2hjTHdnb01EUzZzTlJZK1c4bmp0ekdjWjVNNklMSDRCbWV3Z1VSMWNt?=
 =?iso-2022-jp?B?ekJ2UkMxWlhIQjVCMWIrV1hxMFVNQTF2UWpRdjcyTVR3ZTNqS1hHaUNV?=
 =?iso-2022-jp?B?dXgrYnh3NWp3ZmsreGF1V2JvYzFLMDIxMVVRaW5NVEhxaTRhOC9pS0lW?=
 =?iso-2022-jp?B?QnhhQnZWMk11ODNIcFQyWmNiTXU4NmFIQi9tdUFuaVVjZ0gxUm9DUHJI?=
 =?iso-2022-jp?B?WnUzWXhONWxSaUg3V05KU1B4U0d0cm1hRVBZZEIvWld0R3h0RGRULy9E?=
 =?iso-2022-jp?B?SWxsSGU4dHEwS3I2ZGQ1V2ROSXJrZUJnYitYMGxBVU5DRkVKS2tlZzNE?=
 =?iso-2022-jp?B?V0hNSlBiSmtGcUk3ektJRTlOZzlyVmtIK2ZrRDVMOWdwQ1EzbE41TlV2?=
 =?iso-2022-jp?B?K2FCREpxQmo4Y29vUmlzL3AvRlN3b3hXYk1LU3J0cXZ3SmRKTHFKb3Zx?=
 =?iso-2022-jp?B?WngxZ0pCS2tYczZmL1FDQWc1ZXBjeEJ2T0JkQU80MFd5M1JTbjNvblFJ?=
 =?iso-2022-jp?B?TE1LZDlubHF1YVJxaStSUDl1NkE5UU5mN0tVdFBKUml3bDIycEphUkg3?=
 =?iso-2022-jp?B?QTd4VVFoaEtxN0d5VDh2UkVjR3FHQWpON0txbDF0NkdjVnJaWVRzTXFh?=
 =?iso-2022-jp?B?MVJrdndwbStpVzJTanI4SDMvYzJhbFFVUXdqY3RMYVJFSjlvb25HQ0FX?=
 =?iso-2022-jp?B?enkwQVRURmV3ejBBdFZDYmhNUGdjQzc2MEJialJpT0FIM3hpLzhMRlFK?=
 =?iso-2022-jp?B?bkJFZ0tmT1JaamtDQjZzTWpLVzQ3ZXhJZGV4REEza2JBSVJrdkRKNkVI?=
 =?iso-2022-jp?B?b2RHT1ZNRjVqV3MvZXNadmI1d1o4aDgvRkZZT2o1Nk84YnlhN3BLVy9W?=
 =?iso-2022-jp?B?ME1DYkRtQzYwL0pxd05UbEdHM3lMc0NZai9kTDVWeEE1bTdiUlpHelNC?=
 =?iso-2022-jp?B?K0JCRkVQMkJJMVdMV0NOTzZ2TDFKVXZnN3czNU5QSzBnS0gwZEN2SFBI?=
 =?iso-2022-jp?B?QTFsWjR1TXhES0F5eXJ0UzN1cUNpSlhXZXhKZU9MWlpkbXFZTFVyVTJK?=
 =?iso-2022-jp?B?cHVQV3BzUlF4SHdSN2hWZ1Zya2FVNys5Q3o2TzYyS1M1cjczZEEwV1gv?=
 =?iso-2022-jp?B?aFdOVEVqcWM3b3N6YW45aElWSm9pWFFRb3ZqdWo2M1ExU3dDYmZhVlBs?=
 =?iso-2022-jp?B?R2FvMGdCYWZPNDJ1K3BDYWR4OFlVNW5GaiszU3VHUExLWlRBL1hkV2s4?=
 =?iso-2022-jp?B?c1hNUGY4amhRZTdvN0JlQnZnTkNkSjRya2FORmJtREovVWRXOHk2OUcz?=
 =?iso-2022-jp?B?VHNENzZ6dzZpeGNxWnZzMFE5MzhkZEtOUWprSGVzYThya2VWSWpod1lr?=
 =?iso-2022-jp?B?SUFWVVpXZW5SSXNkUGxJcWJNS3hMemFwZjNhSjhXcU1lT3Ezc3RrV0Qy?=
 =?iso-2022-jp?B?dnorNm5Sa1RxTm15c2I2czBwaXBYVUZEZGZOMFExVXl5d0hIblc5eDU0?=
 =?iso-2022-jp?B?U2xSYUtzQUdMd0xTZGIrK2FTa0pFa2NKeTg1SzJrUG9FblF0SXRJSklV?=
 =?iso-2022-jp?B?MStOdkFZdUhjZTlMZWJDSTNZbFlsN3U2ODdmaXJKMG5BS3NocGtBTzhY?=
 =?iso-2022-jp?B?Wm1RV01yVnVsQVJ6YXdMbG8wMG16UGZIT2x1NGNUNGlKdlFNRGxJeHJ5?=
 =?iso-2022-jp?B?VWRVT1ZDUnpZZ1ptMDUyQnFVZy9jV0lzenNwMThIWjF2TThySE1JQlVW?=
 =?iso-2022-jp?B?dXJ5aXlVMlFWYUdpZE5WcG1IVmRRVW8ydG9QeTNTemRVV0s4ZE9WZVJm?=
 =?iso-2022-jp?B?dzV5K281cCs5bEdadlZHeCtQUjZldUcwZnI4d1dGK1pVaDZ3aDNxNWto?=
 =?iso-2022-jp?B?cThER3l3OUZTNWZGZlRtaXlOVUk1YjAzcVhmREJ1b3BtcHovUUR6WWt0?=
 =?iso-2022-jp?B?VllJN0NldTQ3MWhDSkZlSjJOWXVpZVhaQURNOVplME1HUnpnbnFlaVBr?=
 =?iso-2022-jp?B?b0hBSEwzMjZ0RUowcWozN3ExQjZZbDNsaEE9PQ==?=
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
	2+3Ptpq3JnB1TSElmZPkMZgwM4YPmGlgUgsl1rjtLxyzk9LNRQkcfNnJVDot7ni+26dtgnreFgQyXIjpuiOBs5FBchxz5txDAfrSQjbrVEeGdHZMwN7uJGv5WpZW535IBNJoRE99I8eQYgnje1pTslh8F/0HI4rcs3pdvsJ4MclPwTm6mYj0jmprBa1pmM81K4A9i+gFvdTG+yjLW8+Jn4qJgQuC95uHMJeE+w51O5xHjMvtqHCn+6V0t3tqKuEBQO9dWOoSObz1SqLOTl0OfByot8UUiWSOl+N1Elkh07rU5DBniWj4t/dnsnXo0jt02C+eMPuth/C1U4mwZrdHkamZiI+uadUT2TiPmrY/B0v1I43blQNC7t+K3C50PhkNigfsBJJKzVQpWD/XzHLpZs9l5LvDQjGomOCGIX2yDkf/X4QXdm5g8ojanE8ySGyB3KloYReJ5XWmHrWNjqOKfJemvZjFVRf8w+fiphwNtDYgqAaSJyL3zb2sPPQAC2HGjTRXPrGgKmNDjn/eL04szTD03xdDHSNAOValK9Oid3jx7A3CW5iS6Pgj1R+08Nip+a6OqK1e338YJolFryXPuC9L2hgBYSfUcuD6BNvYL4KII+ZTX1lgKEWfanAT71cx
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11764.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f1c570-26e7-4e46-feba-08dc15a99cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 09:09:00.4721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZgDFeFFDZVm2LXgD18E2ENxZGiILUrvzsVHWFTxJB6xSWWkJNAjZgWpmhS2Fs8uYOTTTwfNW/ERhk5PXoE/d6JFJpFCnZA2ZT9Jz7+8Kik0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6095



> -----Original Message-----
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Sent: Friday, January 12, 2024 8:24 PM
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Kobayashi, Daisuke/=1B$B>.NS=1B(B =1B$BBg2p=1B(B <kobayashi.da-06@fuj=
itsu.com>;
> linux-pci@vger.kernel.org; linux-cxl@vger.kernel.org; Gotou, Yasunori/=1B=
$B8^Eg=1B(B =1B$B9/=1B(B
> =1B$BJ8=1B(B <y-goto@fujitsu.com>
> Subject: Re: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
>=20
> On Wed, 10 Jan 2024 17:11:38 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>=20
> > Jonathan Cameron wrote:
> > > On Wed, 20 Dec 2023 14:07:35 +0900
> > > KobayashiDaisuke <kobayashi.da-06@fujitsu.com> wrote:
> > >
> > > > Hello.
> > > >
> > > > This patch series adds a feature to lspci that displays the link st=
atus
> > > > of the CXL1.1 device.
> > > >
> > > > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > > > the link status can be output in the same way as traditional PCIe.
> > > > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > > > different method to obtain the link status from traditional PCIe.
> > > > This is because the link status of the CXL1.1 device is not mapped
> > > > in the configuration space (as per cxl3.0 specification 8.1).
> > > > Instead, the configuration space containing the link status is mapp=
ed
> > > > to the memory mapped register region (as per cxl3.0 specification 8=
.2,
> > > > Table 8-18). Therefore, the current lspci has a problem where it do=
es
> > > > not display the link status of the CXL1.1 device.
> > > > This patch solves these issues.
> > > >
> > > > The method of acquisition is in the order of obtaining the device U=
ID,
> > > > obtaining the base address from CEDT, and then obtaining the link
> > > > status from memory mapped register. Considered outputting with the =
cxl
> > > > command due to the scope of the CXL specification, but devices from
> > > > CXL2.0 onwards can be output in the same way as traditional PCIe.
> > > > Therefore, it would be better to make the lspci command compatible =
with
> > > > the CXL1.1 device for compatibility reasons.
> > > >
> > > > I look forward to any comments you may have.
> > > Yikes.
> > >
> > > My gut feeling is that you shouldn't need to do this level of hackery=
.
> > >
> > > If we need this information to be exposed to tooling then we should
> > > add support to the kernel to export it somewhere in sysfs and read th=
at
> > > directly.  Do we need it to be available in absence of the CXL driver
> > > stack?
> >
> > I am hoping that's a non-goal if only because that makes it more
> > difficult for the kernel to provide some help here without polluting to
> > the PCI core.
> >
> > To date, RCRB handling is nothing that the PCI core needs to worry
> > about, and I am not sure I want to open that box.
> >
> > I am wondering about an approach like below is sufficient for lspci.
> >
> > The idea here is that cxl_pci (or other PCI driver for Type-2 RCDs) can
> > opt-in to publishing these hidden registers.
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 4fd1f207c84e..ee63dff63b68 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -960,6 +960,19 @@ static const struct pci_error_handlers
> cxl_error_handlers =3D {
> >         .cor_error_detected     =3D cxl_cor_error_detected,
> >  };
> >
> > +static struct attribute *cxl_rcd_attrs[] =3D {
> > +       &dev_attr_rcd_lnkcp.attr,
> > +       &dev_attr_rcd_lnkctl.attr,
> > +       NULL
> > +};
> > +
> > +static struct attribute_group cxl_rcd_group =3D {
> > +       .attrs =3D cxl_rcd_attrs,
> > +       .is_visible =3D cxl_rcd_visible,
> > +};
> > +
> > +__ATTRIBUTE_GROUPS(cxl_pci);
> > +
> >  static struct pci_driver cxl_pci_driver =3D {
> >         .name                   =3D KBUILD_MODNAME,
> >         .id_table               =3D cxl_mem_pci_tbl,
> > @@ -967,6 +980,7 @@ static struct pci_driver cxl_pci_driver =3D {
> >         .err_handler            =3D &cxl_error_handlers,
> >         .driver =3D {
> >                 .probe_type     =3D PROBE_PREFER_ASYNCHRONOUS,
> > +               .dev_groups     =3D cxl_rcd_groups,
> >         },
> >  };
> >
> >
> > However, the problem I believe is this will end up with:
> >
> > /sys/bus/pci/devices/$pdev/rcd_lnkcap
> > /sys/bus/pci/devices/$pdev/rcd_lnkctl
> >
> > ...with valid values, but attributes like:
> >
> > /sys/bus/pci/devices/$pdev/current_link_speed
> >
> > ...returning -EINVAL.
> >
> > So I think the options are:
> >
> > 1/ Keep the status quo of RCRB knowledge only lives in drivers/cxl/ and
> >    piecemeal enable specific lspci needs with RCD-specific attributes
>=20
> This one gets my vote.

Thank you for your feedback.
Like Dan, I also believe that implementing this feature in the kernel may=20
not be appropriate, as it is specifically needed for CXL1.1 devices.
Therefore, I understand that it would be better to implement=20
the link status of CXL1.1 devices directly in lspci.
Please tell me if my understanding is wrong.

>=20
> >
> > ...or:
> >
> > 2/ Hack pcie_capability_read_word() to internally figure out that based
> >    on a config offset a device may have a hidden capability and switch =
over
> >    to RCRB based config-cycle access for those.
> >
> > Given that the CXL 1.1 RCH topology concept was immediately deprecated
> > in favor of VH topology in CXL 2.0, I am not inclined to pollute the
> > general Linux PCI core with that "aberration of history" as it were.
> Agreed.
>=20


