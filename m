Return-Path: <linux-pci+bounces-45283-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oITEJSWwb2nMKgAAu9opvQ
	(envelope-from <linux-pci+bounces-45283-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:41:09 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C33F647C9E
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EF618CC978
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB23002BA;
	Tue, 20 Jan 2026 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="SHrmRcVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022124.outbound.protection.outlook.com [52.101.96.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674A27F017;
	Tue, 20 Jan 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924794; cv=fail; b=N7AhWlHMNQ2zvd2wLLzuLD7sc2nq12z/mKxF+akzJQwAolErvb4JYZnjizlTh6bng6TwH1n0vpsyzEr6s6XMavqqEuB8ww+zXYZBLoqnV47r0s/OUeB4zXyPnrA4SizaOgeBzzgNOe3spKSXlaXQxRr70BtAksUxGiExKkJxIUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924794; c=relaxed/simple;
	bh=6Qpr2VlTqbzISF/g+7QTyGSl8wVZs1KblMx1RS+gKkE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KBsTMINu5N7jy5oHtaNBza1UpQemklLrbHI2c6ssQfk6UxvHm5RB3RA0Kdls2Ls+lmGtPnhE52E4yv8d0DHfjGyzFYUjd7brw+yfb+zf2LKQCOJkmPupcMQ4bhNZfSav/A9HjFqT99C5WTZGvo0WtpDyTa2vzzFarqXMl0ZWvFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=SHrmRcVZ; arc=fail smtp.client-ip=52.101.96.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyIUGt4tHgnXEMvw4Fx647CVw80/1c919gAcef/M3Eja+LfYzZ0xXGcaNFWikOYx8YafMfniMar0IySAI9VPHkMlJhPomyxQfiXebkFBky6YS37t9Nhc2cMTOJqSVko4kwfJeyaUxgS7TjGifWqoAwE/9IZK0PisAgtMhY+Du/r8K6GKU7mA0PDtAMxCz6BMZGDayXbxipEucSN5ZYT3jPvllm5Wv2LgZ09eyxr/VQZH5D9MC5feXhwGP8OIau748vgfLPRV3sErD4tK19Oh7Z9r8JOD2+1gTHPtyecwmwXD/pPw/awSXKidrb2VzwmtjYUVuGe+qN5cMV0i9BakRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyEC3RFNYp1s5cTvr7tKkVCQnbkOP2onWKFDMPuj5Ok=;
 b=OG35ZES3JPFh/rKnbhpc0ZpjPPQwQxhIku01DtjkKnxTw3QTxFXsDdB0BbKe8qsnkrke61NWrM8/j0rOqqL81G877Y6LzCC9dauFQ+Zn4pnptzvaWUeDTudg31cuotvjed+H3iwaoyuj1gkqteElkTEjgFow30NdqYwRFX+/m+Bgm4e+RbQrQQMF4AOAfNGsM2sua+Ybf4RimoCQJVN8i8q2+K9F6UVJbVgWLTA1zDe3aBYqaIWIQAB18eIJ3SpAge5yxC2Q6qIIGuVxmgRj34kngSgc16+bx2uPlRoJvj7dKfs6dNnNJBZHu3J9ePFzxGgOw2ssL6XTH+SFwVMTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyEC3RFNYp1s5cTvr7tKkVCQnbkOP2onWKFDMPuj5Ok=;
 b=SHrmRcVZz1lrEpTkXwGqdHjPEwMpGB7wW3w/tPG6bZbnByS7c5tHDTd7SbYAEWXI/5gBqkiv6OizFkwxsT9HPTa4LK/+W57RPf6Q0T6kH5qf7eYISPDGtBApdIGilr7SpKUi/UK+qsYgmXXGec5tjO1DiABAYfy5GAnU3aVvlwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2251.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:103::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 20 Jan
 2026 15:59:48 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 15:59:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 15:59:47 +0000
Message-Id: <DFTJI4PTLDWM.1F7X1KN1Q264S@garyguo.net>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
Subject: Re: [PATCH v10 2/5] rust: io: separate generic I/O helpers from
 MMIO implementation
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.21.0
References: <20260119202250.870588-1-zhiw@nvidia.com>
 <20260119202250.870588-3-zhiw@nvidia.com> <aW83HV4lVR5MQlDd@google.com>
 <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
In-Reply-To: <DFTC434Z6XRK.2RTE2DFC16TDA@kernel.org>
X-ClientProxiedBy: LO3P265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2251:EE_
X-MS-Office365-Filtering-Correlation-Id: c19cb395-9627-45e4-304c-08de583cefdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Slo3UnNnZnpKWGJPUUFPNUJDMlByVEFQVkg1c1k5NDN1dVAxdHMyQTVPRzZq?=
 =?utf-8?B?aDNuSUlhbWlKdzlGQzZHYTRneXBjYUk2T0Uyek5wcUNmYStJNFNzak9RTjJL?=
 =?utf-8?B?MFBvSk1odDZNckRoQlFiSVhST1lFU21PMkxVcWk5SGtKaFRzYkc0dUpiZ0pn?=
 =?utf-8?B?NnJpR1B2Tm1sT2hsYUJ0dlZkdThhTk5MakVqNWtCYnFTRXBEdHBaTnBwSnZW?=
 =?utf-8?B?bVNrWWZOTUVMMWpTeUFIblZDRG1QaTZiSDZsZWVNU1NKWElQQ25ndFdDTi9N?=
 =?utf-8?B?Q0tFU0pOSXpWZEZHdS93MjRBSXBaVHRNYUtWeGxKVzFNRG1FaFRwSXdZOCtm?=
 =?utf-8?B?NE4vdHo3NnA2SkdOUnlXdFZCTFFCWit2NmM3SER2dEt3SjBXVWJMT3h4QU5N?=
 =?utf-8?B?Y254QUc1aGVzZ1FXc0pqKzBudzBzY1FkMkNyNVVxNWxYL3Z4SDJsOE1FTXYr?=
 =?utf-8?B?cUE1K3Z5ZnF4czJ3cGM0bFBkQy9mVmRUemQ1SEdNNFhLaC9BaW51YUl4YU1I?=
 =?utf-8?B?YURaZ01GVVN3R0plNDJydzEvQThMV3VwVzlWbERHVzNDM0prbzVIaEgwd2Vv?=
 =?utf-8?B?eThRd3I1Vm1DVE0yOGZCdk1FZi85a3psRDFtTmQ4d3RMTlVlUmp2RmJIRGt6?=
 =?utf-8?B?cFdJTERMdjY5T3ptaytzRkpCZ05hYnFXMFZtYkZaT1RYUlYzcm5RVCtCNE92?=
 =?utf-8?B?bWVxRGVkampCTm15SVpnQURjR1ZiOVJOeDIxTkF0UlFpbFFIVEU5TWw4b3pt?=
 =?utf-8?B?bExoMG9za2dneVd1a3BHV2JrRFZIU1FkazBkNkVpZXNFQ2htSFoyUU1Yam5C?=
 =?utf-8?B?V3Z6dXhYakpDN0tiTm9IS1BXTHNOUjNZT2ovQzJRZWF4Smt4VEZSVXM4N0ZL?=
 =?utf-8?B?dHY1dU94eXJsMEFqOWNFdlkzUTJOUko2anNjVGkrUXlLQW9BNGFzWDZBc0Y0?=
 =?utf-8?B?SithanZFRmlXeU1VNUhLemFKZXEzUWFPOUNLT0NjT0FiTVp3aXFST2oxWWlu?=
 =?utf-8?B?TlpUSGhEQW5KOTN3QVpJTHZJMjZpUFJGL1N5eHRMZTV2dUFtaVBHNzNiUUZS?=
 =?utf-8?B?cUdMdUNZQm81d2s0OHVPWVFja0FSeUJzNExGcmdrTnhUcW1qYmJ3ckh2clFY?=
 =?utf-8?B?TnpVbTJIVGJud29xNlZuOTNOU3V1Q0Vpa3lOL2ZibEREc29jMWg4cy96cXlF?=
 =?utf-8?B?b3VFelhUUHRmRjU1bHk4bzhpbG5FUTNYcjdBSTI0OEpNaTJEQjNJcE1ZZ2Yy?=
 =?utf-8?B?WEs5M3VHTHM1bmk1RldDSUtwWU1ubUVDZkxNZDNPdm1YVlRhdWozRUNrWGNa?=
 =?utf-8?B?aE1LRkFINGVYclFlZWdWNjdrdTB3dXo1NWJBa2Y4Mng5VFV5ODV5Yk50YnYz?=
 =?utf-8?B?UTBqaDQrYkZyK3dRamt0cFBxWXhwZExMQ0Y2TXRqSnF0TlF5QU9OeHdiVTdN?=
 =?utf-8?B?cTB2dmIvU2xjZWhGRUxJMnpyWW5ESnB2VUljdklKN2FUM24vcElXRHRQZ0JU?=
 =?utf-8?B?cUV2cUN2ZXRybC9HWUZvbmRKaWNVRzJqRHVtL3Z1Y1hybHBKN2ZDU1JWU25z?=
 =?utf-8?B?dDQwTldCdURIN01jWmgvOHdFZEdpVXNMRXVyMU9kamJUcjRLRGZJNGM5ZWd0?=
 =?utf-8?B?ZmJiQ0x0dS9SaitBWTdHVlB1a1hLeTV4OW5EOVc4ZENuVTVEaWtsOWd2Mk5h?=
 =?utf-8?B?YXV3dU5VRW5FZEc0eUxxb2tlY29ZTm5lRHRyZURRM2V4V3VmKzgrWXR1R1FI?=
 =?utf-8?B?RVhseER0bzFEZmwxVnp4bzBRTE9FYlppRGdmK29JOER4a1kySk5FajlHdkM2?=
 =?utf-8?B?MzJOT1ZRem4rS1FCa2hFSWs5R0RVSW9FYVIxbFBMMlMvWFZkUEF1Y24rNHdP?=
 =?utf-8?B?bFVGa2d5MlFCdkJCb1ZHenRlRWZ6WEFwTEwvSXVyY3I5d0pySjlkZ1dkcTcy?=
 =?utf-8?B?TGxCT3oyMUdSbmlXQjl1WGpLV1hIQlcrOGthbzZIaUpOajVSVjNPYnRNOWR1?=
 =?utf-8?B?YnpGbVdrTC9lbjdpWlZXbVhXTTVhZ2FjVkVRNVBUVEl2bGtQMEFMbVpvYTBt?=
 =?utf-8?B?bkFTUkxKdWNsNk5sdVBRV1ltR2p0cGlqWjd4NkdOT3MrRUVUejNZTUxQbW1H?=
 =?utf-8?Q?Cv14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy95VG81UndSaDZLclpOOStyemUvWDQ5bFBZQVpFaXkvdmcwakZPSHJ2RlZw?=
 =?utf-8?B?bTd3cVkvWldUUXVIMm1WZnJ5L3Y1blhlTXdvbnpnUm1pa0pzSiszMlBTbjhw?=
 =?utf-8?B?dFByc3dlZWlTZmNPSFFIdXdEdjJCR3NKRXJEMjdxWXlBbWNQMjhSTkJvakYr?=
 =?utf-8?B?U1Zpd2N2V0pmdXBCTVFlNWY2eHZWZmpwQ214VVdROXBXdEZxSCtyaTB1NnFj?=
 =?utf-8?B?TWN5cXhCQk9YWnBSdDNua0tyM1FnN2FmQTZXUnh4dXk5U1M1Y2ZPVmFzWG1O?=
 =?utf-8?B?QjVpUnBmZkFpV3pvS0prTFhFK3pDTG4yWmlONTY4aXJJM2dobXozNGxPeDdO?=
 =?utf-8?B?NnQxaDd5RE9wZk1pcDJ5UG5IYkRLQzNkcWFVVXlDVmN0bDhJeDdKSmlmSHRv?=
 =?utf-8?B?b21nQXRsa2pmS2ZIby9uaEZLN055Ykd6OFI5VWN0SlFCbGJwbWh0K1R2RlVS?=
 =?utf-8?B?VlNjKytXelhzbGtxUnpER2lHNmxUdkh5QjVTMkNUUVdNaUNJVU5DdGpaMkVR?=
 =?utf-8?B?TVR0ZjFMSjVrZEUxREFGc0FCK2lpVWhROG5DMkRFdFUySHRMVUVJb1YraTQ5?=
 =?utf-8?B?NDFoMXBhU0dDUVdGbkRhdFM2b3ZHRSt5QlFrdng0N251eGlndkRUSWlCVmVB?=
 =?utf-8?B?OGlLcXVadVpmTmZyVlpJcWNIYkIwSER6bFdJR2dMd0Z4UFZhL1VIc0ZqK1Vr?=
 =?utf-8?B?V2pJWWt3WDZJbDNhRzhGMkdUYVFoMTMyaWxWTTJwb2Z6N2kyNE9XTTlFV0JW?=
 =?utf-8?B?aTQ2c0tJUWtrQTRxenlweDdCdTFXaHVsQVpOSWcxdGZnUUY4d3pPVDAvSWtq?=
 =?utf-8?B?bEovWStoOVlsaXJ1RmFDOEhBM3R0ekhuZVB5T3AzemlQenBYWDlIcDBCRXJi?=
 =?utf-8?B?SXp3L0trSmNhSW92eFZsOEovVGVBdDBRdXNBWUxSSE9ML2dTTzNpZzRVaWtp?=
 =?utf-8?B?Z2Z1Q2dsU3pjYm1ORUx5c2lJUmpOaVVkWFV6dGpOeW5CdmV4K2FNekUyTmF6?=
 =?utf-8?B?ZHNnenBqMnpBZXlLWDhac0xTZ25FQWVNYXJ4NjFWM3RKZWtMSWsvSmVBVmtZ?=
 =?utf-8?B?QnlJQ2pzNWwyaTBhejBDNkpLUS90YWdRVVc1K1VpK05oWVlxbkluQnk4QUsx?=
 =?utf-8?B?K1B5OUJqVFRkajUzN2lZTStCTmFGL21vOHlrMTVzcTFrWkQvM1lOTnk3K0Ny?=
 =?utf-8?B?eG1mczVOUytTeFB4ZVRraS9EelI0RHYwcVJUUnV2bmFVYUJLdmc5VWJlWE1R?=
 =?utf-8?B?QXJ2d3dXNmhPKzc4czZRSnBQQUJVUCt3Y09odjVXeEhXUmR1cWlJbU56ZGVB?=
 =?utf-8?B?TlF5b0VBaWNYbkg3RmE2Zm9ydW84WHN1U21uUW5xNjFjUzlBUzNTdWYxK2tU?=
 =?utf-8?B?eVRFTU14OTN3ZnM0SFc4aERnYUVlR3BWM2l1STBzZFVJWklHNGYyTGdBbXkz?=
 =?utf-8?B?L3RxbEVZeHNFTWs1UkNXY09BbnEwMlZMaXlPSzFiQ0pVZGpjY1ROVHpRc1ht?=
 =?utf-8?B?ZlpGTjkxeGV4TTBhUzV2MklKWnc1ZUk5NWtFSXp0dmxvZVlIeVIxTHAxTWE0?=
 =?utf-8?B?WFN0TWowM0tzdE1IWTJTNVhkSlFsNTA5eCs2VFh0aG1zUlJKNGtzWVQ4K3NK?=
 =?utf-8?B?WngvYlJJUER5U055MHVRcFlpODhTbUpqNkVNWDNUZXhVMlFoSmM4WHMwR3BL?=
 =?utf-8?B?Z0k3MllNMUhOOWhWUTgzY0U5OFJPMHJtV01KMDBvNHM5a2VkMUpQdFFLVzVL?=
 =?utf-8?B?ZzVuczA4SXpwZEtpUnRhM09OU2oxZk9OVUtvSWc1c0JYL2VzdHJsUFN3bGlQ?=
 =?utf-8?B?ZnZLRkpRR3pjSjVSc0MyeDdyMHlHTWJUVS9ERXRzTUx2V09vUmFseWdydGxu?=
 =?utf-8?B?ZVQyRnphS1EyMHdPS1dpWDA2WWd1VjcvY294SGJGUXk5Z3dyb25Xc0N6Qzdp?=
 =?utf-8?B?eG96M3hZUGRpaU5aNkxML2FzZUZsNXQrQzRFZ01pYUgwWGtHYzV4NlppTUVI?=
 =?utf-8?B?RGFXdC9ocXlSQzdrR3lJRnVwLzNPQlNocFRpbTNJR3hpbmhPUDhGaUFCVDIy?=
 =?utf-8?B?dG9vNVBvaGRtUXV5c0Yya1NXenpITk9IQmNScThnN2kwTW95N1kySjluN21x?=
 =?utf-8?B?KzdXZjhydlZiN004NGlwRHQwbExGV3BjMXlVeUdqdjBZTkNHUkRnVno4ZTBC?=
 =?utf-8?B?amNuMzVlZW40YVoraSttd0xJcWJ3YkFBSlNRSURTRHh4M0ZvaW9hWTZUaSts?=
 =?utf-8?B?NVF0S3lNaHVXNEFuMkU4MWN4WVYydU9NYlRjKzhyaHZ4VXgzNmVERDdEK1Q5?=
 =?utf-8?B?NVRaNmFKSkF1UXZkTWVvZ1hHTUFuY2tJWVZWdjFBS1BRcWtScGlJQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c19cb395-9627-45e4-304c-08de583cefdd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:59:47.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9NqIkPiWK/1aBB0POR3XM0zrjn7swt4wrHmclxZxDafkLBdPbJ81eeFPLEHM03aWZ/woDBDYDVUjXIqGbqULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2251
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45283-lists,linux-pci=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,google.com,kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,posteo.de,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pci@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: C33F647C9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 10:12 AM GMT, Danilo Krummrich wrote:
> On Tue Jan 20, 2026 at 9:04 AM CET, Alice Ryhl wrote:
>> On Mon, Jan 19, 2026 at 10:22:44PM +0200, Zhi Wang wrote:
>> Overall looks good to me. Some comments below:
>>
>> I still think it would make sense to have `IoCapable<T>: IoTryCapable<T>=
`,
>> but it's not a big deal.

Ah, I sent out my review without realizing that Alice is purposing the same=
.

>
> I think with this approach it's not necessary to have this requirement. I=
n
> practice, most impls will have both, but I think it's a good thing that w=
e don't
> have to have an impl even if not used by any driver, i.e. it helps avoidi=
ng dead
> code.

I think whether there's a runtime bound checking and whether a IO size is
supported are two orthogonal things, I would rather we have a single series=
 of
`IoCapable<T>` to just indiate the latter and still keep the `IoKnownSize`.

Best,
Gary


>
>>> +    /// Infallible 64-bit read with compile-time bounds check.
>>> +    #[cfg(CONFIG_64BIT)]
>>> +    fn read64(&self, offset: usize) -> u64
>>> +    #[cfg(CONFIG_64BIT)]
>>> +    fn try_read64(&self, offset: usize) -> Result<u64>
>>
>> These don't really need cfg(CONFIG_64BIT). You can place that cfg on
>> impl blocks of IoCapable<u64>.
>
> If you agree with the above, I can fix this up when applying the series.


