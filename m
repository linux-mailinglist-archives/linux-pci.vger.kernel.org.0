Return-Path: <linux-pci+bounces-33148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B362B15767
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 04:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653EE560400
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CF6153598;
	Wed, 30 Jul 2025 02:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="RGK7klTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AB15853B;
	Wed, 30 Jul 2025 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841110; cv=fail; b=u3G4HMYUUDxKPFtXTwSxoPMvOz8/RLMJDp31hgPmOVDOOzO/LjjcQMytN6W6tVELeeRwPTugDSSQ4o55pZFIsGTF04HntG3TvkxEQCeJEjDWl4eMcCdyw0vTvBvAWcDQNkVOB8hMW5H1wSav7qUR/LqMuaRP6TQLI76I+XnqscU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841110; c=relaxed/simple;
	bh=Z9ZswmnmjcpCKma5BlvNATaQngYjFX96UTvR+RPhN7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tgSWXftT87mou/WtsoqMoxkBYCGfWv04HWSCt9XkYswFNSfnNrLIodBVMkmJdlaxTdm2vN63DT7wR0llfm6rxeSvcwO3sLLlM9vL5Rp9oVc11WGPc9GJPYLEOTxrbnvjNPuDjDB6faQOUM/hekjbtWkMCNPoFYe1JPy/FjLCuIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=RGK7klTE; arc=fail smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 56U0DsmX1419475; Wed, 30 Jul 2025 09:13:54 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1753834394;x=1755043994;bh=Z9ZswmnmjcpCKma5BlvNATaQngYjFX96UTvR+RP
	hN7Q=;b=RGK7klTEe6v4MUYebIv107gVntpq+GSN6Z+8JJ0DQAyXrAKHJT/xjfFHLsKHJAQxzHRNA
	qPkect1A3Xy3qev3CahXEDrwBDTqj22mFa6R8GYDb5IVYwcJvEne0Qw+IhziwG3mTSzK9ewqgTF8m
	7LATkMCwejUza26K5b7L9c0o28/UJhZi/Yu9j7v/Rom+1gzgYavsSsMBs9sfpvjVk00AfWONGMkCB
	6o3KSWDnKbDFZMAyVdQUsGf1U+MPY9uTUwNnHIEEPAx5mF0R6X8u0VBHzO0FKdNXi1egcSCb3SiFI
	Jl23leThrYEp1KlKS6IsSb/UnBk/sdJRr3pGjcekMw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56U0DDUl3327038; Wed, 30 Jul 2025 09:13:13 +0900
X-Iguazu-Qid: 2yAbpfLvJwmUFY9e3o
X-Iguazu-QSIG: v=2; s=0; t=1753834393; q=2yAbpfLvJwmUFY9e3o; m=ttb6WpNNjZBsu53EgZAr4mQgCt2upAxFnP9kPzPZuyE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 56U0DBNW2602920
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 09:13:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMmFx2HOxhVbifKwWAZ7jDdMkoZlsCmaxpGjAuvoBpiOr1AD64JaWfm/ylTvUrQImqiwc/8Lwi7+NmWgzbRgkH9w8hSPV6phfGPFS3ZgXcay7uKoR3t7hk7cXD6h6WtgF7NgmsL/NZ5Fms47DBimaIS9C0eDQ7k5ZZ+Vkob7jdUWY2mgDEQdVT2hA6Evt2S8MFGi51vLVCe8ueE+nkNs0dxs2FaUwLJzJDqTcvkYlTOO3srvjqNkU+9Os79s9Wa7NHGMftds3/eMET5C76XHA1lpY7vSCBhQiLhcu4oMRp0rWd5JRfZ65F+E8z5THD7HH/h26WRmtUcBhXa3AWlblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9ZswmnmjcpCKma5BlvNATaQngYjFX96UTvR+RPhN7Q=;
 b=J6w4fqbj83Hx4XhDjH03CjFZg1QkLPgHA9NvM7I6iMwOgApPT7Ls/kJlGo9qRfsuHd4aUEVPwGePU9AaYjdRZ5wItTtTmxGMz0pMC9Oe/8eciWZKLF5p+ql0moF6LRng/eWGPZsC4hrDN5NnzSgPd14Qbp8uMxW/avozOlrVAg24qwCpn46/bo+YUNebaQxb7kToySd88lJbfD3bWJSm13NYa9KQHCT7s+nQCvM6VrqiD0Wy1MpSvFjQJAKaLZtr+1igYirULGyFI8GmcDl5eDcix6r8e7MsD+kiN7wpcvPiUeLQeUTRWB0ABqhPSe+L4VjxslG2vIW148m1NdL9tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Frank.li@nxp.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <bhelgaas@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Thread-Topic: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Thread-Index: AQHb3Kr5i8C+P9vwEUaoXxVDSYttMbRHLc+wgACv8ICAAjUZYA==
Date: Wed, 30 Jul 2025 00:13:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818EC396806B8EA7CE96AB09224A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
 <20250613-tmpv-v1-1-4023aa386d17@nxp.com>
 <TY7PR01MB1481875AD0293961D0DB8738E925AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aIeIeQsDLz53aAHR@lizhi-Precision-Tower-5810>
In-Reply-To: <aIeIeQsDLz53aAHR@lizhi-Precision-Tower-5810>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB7163:EE_
x-ms-office365-filtering-correlation-id: b4b0b1ac-2274-47be-1db2-08ddcefddbb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YlE2Zk91YS9kUXRKUjZ5dU9ZUVIrckoxbG5ycnZmTEpWZ0dOdTF6em1pT3o1?=
 =?utf-8?B?enh0ckQ5eHFiSytWWmw4b1htL244L1ZsQ1F4OHcxTTZmWExYeVp2ZzJrenlS?=
 =?utf-8?B?MWNnZXlSUnBMa2M3UHdnM1BRUkorYno0MVV3UmZKNDZrVlQwb3VkSzBWYTR6?=
 =?utf-8?B?SGNhaVVKdUZuT0RPV2pvcWl2dmEvaXFSd251ank3VVlnRFZXZ0VNeXpKQm5V?=
 =?utf-8?B?alNoTDl6WWNOSFB4dEN2YytsSFRCOUdoMHZ3WFNrK3RZdTVPRWQ3VlhIaUU2?=
 =?utf-8?B?a0lmZEUvZnE3ODN0M2hOc2lEZy9sZzZnUjFxaEtTVHNjT096aEFkYmQzNVNv?=
 =?utf-8?B?bzhOR1M1dExheXMyc1pCalNaalpERm92YUV1dGIzK0JBVUdQK3pZYThOZ1Mr?=
 =?utf-8?B?anZvQmhoUENGKy9scGJVYWVSb2Q5K3BSN2I4NFdtVUtrSElXZkswa2NHUzJ3?=
 =?utf-8?B?RlplR1VoVnY1K2VzWEM0d1prSDNrNGg2ckZPdUE0cEo0RTE5R3ZMSDdESnBk?=
 =?utf-8?B?emlVTy81Vm5EQ0NHSFN6R09KQnNWNHFrNVN1S2FLVU4yaERyNkdOVUFlaG9D?=
 =?utf-8?B?WjdsQXY2dk9pWkgxaWpYeTJjOWhzR3A4VDBXdzR5V0g5Ynphak5SaFZBUm5l?=
 =?utf-8?B?ZVVCeHYvUkozTHVQVXZSaWJPNFYwTEtydnY0K3hDYnBjZWVydlU4ams5aVk0?=
 =?utf-8?B?TTVlRjY1YWtUMWlldHJEUHVHUlRJSjlWSVpwVENDV1JRcnNwR3EwVitQWndM?=
 =?utf-8?B?ck41VWhaeGdNTERZUUNPZC82QkppVEhkcXdKcDJnSjd6QUM1d1A0OWVJc0dR?=
 =?utf-8?B?a3laNzRwL0xoK0J1bmFGazVSRXRaNmJQRlJ6S25FaElKRlFOQ3R3MDBmd215?=
 =?utf-8?B?SzE1aXRtOEJQYmEyV0J1MUlmMkhVeksyV0JzUGNUUkxSOFpLOFlOSGNDRzZZ?=
 =?utf-8?B?U3krMGV1WnFScFplSEgyVmwzWDF1Y3liNFpWbVYzTERVeldMR2l3cjk5RkpN?=
 =?utf-8?B?bmxSRStYc0RXVko0UmlwVmNhaGRTVm0zU294cUdrQlVmbXlWR3AreFdSbjZQ?=
 =?utf-8?B?b1AwSklTdTBlQklXL2RBL1B5YWVZZmtFL1B0Rk02cndHbXg2dHU4OGNSb0VF?=
 =?utf-8?B?bHYxakRBT0xKb09Gc04zWEE1U3BVTk5kSU9pOXdkdE1ObW1zTzEvblp0T0N2?=
 =?utf-8?B?S1VQM0s5ajNsSUxXR01lQmZ3YTBYeWhGcTZDZEdSZkFzT3F3SHdMYVdUeHBB?=
 =?utf-8?B?akp1bXBpRXd3NnJBaTdvTXFNS0pmRUw2NWhibW9NZHRXYWtvSlpvRERVRHVZ?=
 =?utf-8?B?UVdmNmptUjl1RE16SEppalROVVVsaDRuVWpYL3ppRVJMeWtHYzBsRTExUkk5?=
 =?utf-8?B?SDZ1NzNqU0l0MUw1T0plc2NiSjFoU1A3QjdOQTJBcFhZUnYzd3IxUkJpTWc1?=
 =?utf-8?B?T0h3enBmZGk3ejBJelo4WjJtNXNKb0dXU2VHRWJnbStNUTZUcDI1RFNXMXBN?=
 =?utf-8?B?Sm1kdEdOeE5tb1ZVZ3JaYWRVTit5c0Z2OVB3RnJ6QkpJZVFOUjJKQ1ZuUE1E?=
 =?utf-8?B?eWdxZVRWU3lMSDVNcEsxQWhCckExSXpHdUl6VjhiWWFIcDlDRGNjVDVaNDkw?=
 =?utf-8?B?UVJ2STFYUDVjOGljdG93aDJZMVU1Qy9RUTRTWTNYeXZjbnorQU93dHpMM3Vv?=
 =?utf-8?B?Tk9Dd0pNZnVua1V4NnppRzVqNmlYWDVqT0J0QTBFaTJEc1NRNzlPdGM0NGxU?=
 =?utf-8?B?MUU2UnFhNHRJSzJ3TjJlUWV6VEFMNXlIc3lKVEpiR0d1dlNSVVVxUERheEZu?=
 =?utf-8?B?QTI2M2NHck9RQmdMc0NkT3ZOQzdab1NWR083eU1UU0VIa0FnYTBzOEcvdVZC?=
 =?utf-8?B?aTNkVWhRZEpHa0pQajFidk5HVG92c1A1SzRVeWRoZ2RUdTVEb0NBV2dPVXBP?=
 =?utf-8?B?NWNkOW9JSDc3YjlDSjlmbVJ2SzYrNzB0ZTRvQjhHSlErK2E3a21wNElJeSti?=
 =?utf-8?B?ZDVhckxxSG5BPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MkV3WjA4OWtaOWl6TXVsazhRSjlPaS9zVXVVamRISnVQS0xxMTBKUm9PbXdM?=
 =?utf-8?B?aWJjajczZ3A1YTdWa0MvaEJtTGl6dzczWm1sWGxwQzNSVzZ2VlNUWDNneXRX?=
 =?utf-8?B?aWc5SkF2dk43S2EvbU9QUzdaczdmVEJGK3lud1NHblRDTHFLajhSUVZlWUpu?=
 =?utf-8?B?dFR1WWNIZHU3TGNjVVc0dVNlYzdMcXdZenFjN2srMjlrWFM5bHhoYk8wT01H?=
 =?utf-8?B?QWNqWjF5ZS9EcjB2ZEQ2TUtzdmtQbmNwQUh3ckMzeStmNDBJU0tiNTlDNFlN?=
 =?utf-8?B?TkdiWFBoSGRUcXhlN1JGYnB5R0o4UU5CTHQ0cGd1Z2xnNVo5VGUzUlVSQ2Rh?=
 =?utf-8?B?T3JleHFHSGxUU0NEcjNuRjZEVGVVUndQcGIvUW11WTBqVzNjOHZGbEpIdS9S?=
 =?utf-8?B?TURyb0UzMXZHVFd5eUU0V2hMeXBtUklUZStsdTk2NWhmV3pSUGIvdStWc3Ey?=
 =?utf-8?B?UVhiVHNLT3k0cVFLR1pQeS83OXZVRnhxVElHcmY1Z3hqY1BuVG9uVis4VCtI?=
 =?utf-8?B?RDB4N1AvQkNYZEpLV1lsZENMUWJqUFY1aGpScnpXcmNLL0k2TlhUMDZFb2NF?=
 =?utf-8?B?WU9zM2JueE5BRkxIbWdmdWg4V2QvUU1memFpVWRiTTJIaWlQa09wTjdBeUZk?=
 =?utf-8?B?dHdreDh4Nm0rN2tCOTFVN2pka0R3TjN5V3lvbDBpTHNuVTEyVEE1K3NjcTEz?=
 =?utf-8?B?NHJUME9kMlBCbmxFZWtIb2puUzhwZjdiTEE5bTRuVmpYbm1BcXdKSURxaTBx?=
 =?utf-8?B?cjFxbE1RcjNPUlZueWtHS012SGhkTUFpaFkxaGhtWVJnN0t0V1BIdGJMUzU5?=
 =?utf-8?B?eEM2K1J3RnAyRTdMTnd0WDFyeGV4by85emJZY1BKZGJFV202Nnc5UytmNUsx?=
 =?utf-8?B?b2hYRVFoYW1QN1ZWUUphYnY1bHZnRk9JY0dGS2x4eCtxMHNOK29SbDFrQ3oz?=
 =?utf-8?B?KzVzWmJUdSszbkFVaU1tN0F3cWkzTlVKdWdkY0RqbGhiVnlqMTZYK1gzbTlG?=
 =?utf-8?B?SFJaalU5andMWnIyeklTZHYrSGwxVUdzaHNOT0pXQkNKSFFZVWZ0MXNRVnJt?=
 =?utf-8?B?dWJYQ2RWc3cvUmFxVUgrVUFjRFBDMG5zdTE1T1ZKK2xmNUVEK3N0eHJGWkFs?=
 =?utf-8?B?Nk9DVndpVjJqZWhzNWtqVjJ6YWU0N1hQb3YzZTV1WHBlb1FUY0t6bk0vangz?=
 =?utf-8?B?YzBHVlJhVnNnOUNGMEFzV3VWeS9KSmdwbUg5OHJ2bmRDOXNYTURXMW10UjEr?=
 =?utf-8?B?QTRhYW9qcEJwZGJ3TmJ0dkRKYTJ3bzQ0ZURXZG1Kbi9SVkRiZnhxRlBHZ1FO?=
 =?utf-8?B?Y3dKRFNsbHErdjBoZEgyZ2lYUDJpSjZBYWF1TmIwWXdpME9kUGt2eFloK1hI?=
 =?utf-8?B?cnppZWw1MUFuRDc1bDY1SklMbmhidVJoUmU0OXlhTXVYVUMzck5SWkNZN25x?=
 =?utf-8?B?MEdibWxESXBRbnZPWVZDaTBpeGRrTDhza294amc5SlROcTRsUE84bEhGMGg1?=
 =?utf-8?B?ZWFiTVV3OVN5NmF5cnJIN05ZelllNHluY1BtVll0eVI4RGhrOWY1NSthYWdT?=
 =?utf-8?B?NW10MDN5c3d1Q1FyaWoxSitLYTNwUTdrK3piZndMemZQakUzQzY5SVNzd2JL?=
 =?utf-8?B?ZTVyT1ZibUhTc05qZXRuU1hEbXhKL09qMEs2ZUtON2NDZnFYYitOUDFqN2JF?=
 =?utf-8?B?a1dxclNLT2lyTmVRbjZYTzhCZXhGclJSSlZZMjEvNnBYelFCMEtWYWRFTnh1?=
 =?utf-8?B?ajZNS1ZaMnRFQ0FKK2lFQUJQRGR4V2ZaUy9YQS90MmpCQllFdkd4b2FmSkpa?=
 =?utf-8?B?MFRsUjc1eFhUSEVEeUhpR3l1MU9oelR2UW9zMyttdVpwdVpqTm1nUkhPbzRR?=
 =?utf-8?B?NVU0VlVXbldEVk52S0ZMS0dRSzJBRDROQWlubmZxWDJsS3RwMzVMWm50SEYv?=
 =?utf-8?B?QW1ma28wSkM5dmpoTU5yODljb3BKbjJlZ1YrblNlL1JoYmpHOFZ4MkxzT0Fy?=
 =?utf-8?B?OVBmcUtkcUNPTnd4eXZoU1VwR3NSZzE1R3BaTGFhTE00UWFnTFFtNUhyTmUx?=
 =?utf-8?B?ekJrVE5PYXhsNmtzRFRyZXZES1U1MmNTMnZCRWFvOXFEUi90Z01SMHlUalVC?=
 =?utf-8?B?QmZsMXB4RDdqbUw0OEtxQlZWS211U3ZNbGl4TllRWGJDM0tubExSTnZVNnMw?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b0b1ac-2274-47be-1db2-08ddcefddbb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 00:13:06.4256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rW9REQT9mB0JGUSTVI0ZBP0/5UmEVtyRJ0Jy0r6NDL2v/uNqAYy6zBkjMv3DHknii6iZW1EIJzyqVSKh0ojLceWbrMBVuxClKs9WJGJlYtLdE8I1IqoCViHwXR4ZtUlv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7163

SGkgRnJhbmssDQoNCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hp
YmEvdG1wdjc3MDguZHRzaQ0KPiA+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEvdG1w
djc3MDguZHRzaQ0KPiA+ID4gaW5kZXggMzk4MDZmMGFlNTEzMy4uMmExOGFhOTNkNDcyMyAxMDA2
NDQNCj4gPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdG9zaGliYS90bXB2NzcwOC5kdHNp
DQo+ID4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3Rvc2hpYmEvdG1wdjc3MDguZHRzaQ0K
PiA+ID4gQEAgLTE0Nyw3ICsxNDcsMTUgQEAgc29jIHsNCj4gPiA+ICAJCSNzaXplLWNlbGxzID0g
PDI+Ow0KPiA+ID4gIAkJY29tcGF0aWJsZSA9ICJzaW1wbGUtYnVzIjsNCj4gPiA+ICAJCWludGVy
cnVwdC1wYXJlbnQgPSA8JmdpYz47DQo+ID4gPiAtCQlyYW5nZXM7DQo+ID4gPiArCQlyYW5nZXMg
PSAvKiByZWdpc3RlciAxOjEgbWFwICovDQo+ID4gPiArCQkJIDwweDAgMHgyNDAwMDAwMCAweDAg
MHgyNDAwMDAwMCAweDAgMHgxMDAwMDAwMD4sDQo+ID4gPiArCQkJIC8qDQo+ID4gPiArCQkJICAq
IGJ1cyBmYWJyaWMgbWFzayBhZGRyZXNzIGJpdCAzMCBhbmQgMzEgdG8gMA0KPiA+ID4gKwkJCSAg
KiBiZWZvcmUgc2VuZCB0byBQQ0llIGNvbnRyb2xsZXIuDQo+ID4gPiArCQkJICAqDQo+ID4gPiAr
CQkJICAqIFBDSWUgbWFwIGFkZHJlc3MgMCB0byBjcHUncyAweDQwMDAwMDAwDQo+ID4gPiArCQkJ
ICAqLw0KPiA+ID4gKwkJCSA8MHgwIDB4MDAwMDAwMDAgMHgwIDB4NDAwMDAwMDAgMHgwIDB4NDAw
MDAwMDA+Ow0KPiA+ID4NCj4gPiA+ICAJCWdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJAMjQwMDEw
MDAgew0KPiA+ID4gIAkJCWNvbXBhdGlibGUgPSAiYXJtLGdpYy00MDAiOw0KPiA+ID4gQEAgLTQ4
MSw3ICs0ODksNyBAQCBwd206IHB3bUAyNDFjMDAwMCB7DQo+ID4gPiAgCQlwY2llOiBwY2llQDI4
NDAwMDAwIHsNCj4gPiA+ICAJCQljb21wYXRpYmxlID0gInRvc2hpYmEsdmlzY29udGktcGNpZSI7
DQo+ID4gPiAgCQkJcmVnID0gPDB4MCAweDI4NDAwMDAwIDB4MCAweDAwNDAwMDAwPiwNCj4gPiA+
IC0JCQkgICAgICA8MHgwIDB4NzAwMDAwMDAgMHgwIDB4MTAwMDAwMDA+LA0KPiA+ID4gKwkJCSAg
ICAgIDwweDAgMHgzMDAwMDAwMCAweDAgMHgxMDAwMDAwMD4sDQo+ID4NCj4gPiBJZiBteSB1bmRl
cnN0YW5kaW5nIGlzIGNvcnJlY3QsIHRoaXMgc2V0dGluZyBjb25mbGljdHMgd2l0aCB0aGUNCj4g
PiBhZGRyZXNzIHNwYWNlIHRoaXMgcGF0Y2ggY2hhbmdlZCByYW5nZXMgYWJvdmUuIFRoZXJlZm9y
ZSwgaXQgZG9lcyBub3Qgd29yay4NCj4gPg0KPiA+IDB4MjQwMDAwMDAgKyAweDEwMDAwMDAwID4g
MHgzMDAwMDAwMA0KPiANCj4gWW91IGFyZSByaWdodC4gIEFkZHJlc3MgbWFwIHNob3VsZCBvbmx5
IGhhcHBlbiBhdCBwY2kgZmFiaWMuDQo+IA0KPiBTbyB3ZSBzaG91bGQgbm90IHRvdWNoIHNvYydz
IHJhbmdlcy4NCj4gDQo+IHNvYyB7DQo+IAkuLi4NCj4gDQo+IAlwY2ktYnVzIHsNCj4gCQkgcmFu
Z2VzID0gLyogcmVnaXN0ZXIgMToxIG1hcCAqLw0KPiAgICAgICAgICAgICAgICAgIDwweDAgMHgy
NDAwMDAwMCAweDAgMHgyNDAwMDAwMCAweDAgMHgxMDAwMDAwMD4sDQo+ICAgICAgICAgICAgICAg
ICAgLyoNCj4gICAgICAgICAgICAgICAgICAgKiBidXMgZmFicmljIG1hc2sgYWRkcmVzcyBiaXQg
MzAgYW5kIDMxIHRvIDANCj4gICAgICAgICAgICAgICAgICAgKiBiZWZvcmUgc2VuZCB0byBQQ0ll
IGNvbnRyb2xsZXIuDQo+ICAgICAgICAgICAgICAgICAgICoNCj4gICAgICAgICAgICAgICAgICAg
KiBQQ0llIG1hcCBhZGRyZXNzIDAgdG8gY3B1J3MgMHg0MDAwMDAwMA0KPiAgICAgICAgICAgICAg
ICAgICAqLw0KPiAgICAgICAgICAgICAgICAgIDwweDAgMHgwMDAwMDAwMCAweDAgMHg0MDAwMDAw
MCAweDAgMHg0MDAwMDAwMD47DQo+IA0KPiANCj4gCQlwY2lAMHgyNDAwMDAwMCB7DQo+IAkJCS4u
Lg0KPiAJCX0NCj4gCX0NCj4gfQ0KDQpEb2VzIHRoaXMgbWVhbiB0aGF0IGEgcGNpIHN1YmJ1cyBp
cyBkZWZpbmVkIHVuZGVyIHNvYywgcmlnaHQ/DQoNCj4gDQo+IERvIHlvdSBuZWVkIG1lIHNlbmQg
djIgZm9yIHlvdXIgdGVzdD8NCj4gDQoNCkkgd2lsbCBjcmVhdGUgYSBwYXRjaCwgc28gcGxlYXNl
IHJldmlldyBpdC4NClRoYW5rIHlvdS4NCg0KPiBGcmFuaw0KDQpCZXN0IHJlZ2FyZHMsDQogIE5v
YnVoaXJvDQo=


