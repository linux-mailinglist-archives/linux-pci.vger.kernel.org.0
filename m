Return-Path: <linux-pci+bounces-14244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5C0999555
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 00:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7CE285F49
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2901E4938;
	Thu, 10 Oct 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c0+X4rzW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E851A2645;
	Thu, 10 Oct 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600063; cv=fail; b=tKvdWEsKJs8EYOa1CgZ+o1hD2z0UWK45d4hL9RBAVdeVWu97jBli85b9KqCOXmpTfMhS/mtJNpUMpTnTvSNDA+zQ9F6Es2ySd5QgpJsPvJpN2mxeOecHbE7ZUmrLaqTuAqYH2fNADl/sf0qgVOIudUJsmGx9u8Sd4Dd6Mc88SaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600063; c=relaxed/simple;
	bh=GtrNY9QbcOhap+nSdOpIeYFW03NjU023oTYquiD7OVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KkiTiwXsOLBFmY/R7Zua9mRXSxymmQwqD+19VzxeFsd7sAYag+WTczm8SYy5SnHh7a8a19YEfsBM1wcVA5WczLWbTW9m0t/vI405fmkEkS1DOUbs6Ul3R4hROFWeRdc53xJoLu2FRjLuwU0mIk4FxNUGSKm57rdcA57wkmBvTlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c0+X4rzW; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hx2FrJsTDMz0jvjs3dnuOwH3hTF21q3XahiCWt0eQwqvHkyZRLYrIFEl6tCXZ841ez+gmbWbf78w3U8nY3u2gqhFNPfmMoD5e7hhlcM+C2ymgRLyzkhK3GUeWHRxhWdrgeR4IugQwZxGEK7PcZUXLY4IYNcOj9ytNdV0ciIQhw1vcWYDPt+w9GJ46kIbHxro0kCGAnO+b42Ud/XBiL8hM+OHbrRAx8O9YdYJcX1+bvtUHzIy+w/rDUitISuLRd1gEaWR7Uf1zlqYyGIS0DvBjOEEzetSL97ihqIFf7hbF0PPgXl367dG04YKsrwkHZdTgZWCbumqWaFzCz0UfLlSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83+0/6Ywl6zihmDbm7BeC5/S8IzTD3uagiRaEzQ5c+g=;
 b=ND/Vf8fm9Ovxh4txX5+2i5KnlDgrfjWYmbIayjU6weRDn2FcE1NHpd2syzjfDHto/UX9vTbIakhFLEXzuL75BMgEkmJ0/S+tqzXtHiE3CmmYe6giFoWVt4CsomiqIjLn8J4CO+dajg+7k9rm+UIHsnUprtIdT+cPLvSSwDV7U+PBroDTjECFXhQzFKAqrXANMtI9KM45o6x5SnAAtbwepKy6qY+eCIKkehe0C7P/lLe9Ad4T0qfUqUuYp0YCrpQr8eCVoDjUrMoLUm7GeXxeUZpHv/chJSaG3UUvI0/JJz1QjmTToc9OvyRK66J4oktDIzfVNF1vGVcqgDux03Y0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83+0/6Ywl6zihmDbm7BeC5/S8IzTD3uagiRaEzQ5c+g=;
 b=c0+X4rzWNAMJg34x7aKY/Mw5gzrqw9hikoy3sO0PLSmHeJnXwEj2wIhOjUTFB4dM19fwyjre4j6iEyuEjvyMowVWFn8NZB7mtqd7psTE/DP78S4S4OrFG7alZ1cY797rwxskrNYKH9FsQYpce7GEKeyhKxgd0GYd1KHHaG3DhvbQrMqbtpNJk5SAb//tlZ9kuiNeIdu3rgRxOpLG4j2bx7oGxGVJL6KC+/QrV17FEK4lGwTxN6tuhCrC0+Cc50rMrjfmg/tvSMChGl+NUec86BNPDVoFFr3ZeX26s705gcbHGrfbZ1Vt7EIZsMYrCRKOWi72LhPx42nh0w9rpZQE1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7144.eurprd04.prod.outlook.com (2603:10a6:20b:11b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 22:40:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 22:40:58 +0000
Date: Thu, 10 Oct 2024 18:40:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Message-ID: <ZwhX8I1SIpbRA1OU@lizhi-Precision-Tower-5810>
References: <20241008-pci_fixup_addr-v4-1-25e5200657bc@nxp.com>
 <20241010215745.GA575297@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010215745.GA575297@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 501e09cc-9be4-42e4-01e1-08dce97c9bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW5HUGhVczZVcVdxT1R0eTBEdVp2UGJDdUdiOHVSZ1Rkb0o4MTYyaVVrZU4x?=
 =?utf-8?B?OElxdTd1VzRJVUY0aTlpUGJDbmFpTGhkZzhrUWpldGdvQ2xyQVNlNWlYcUhI?=
 =?utf-8?B?aVhsa1VuQSs4UjhGL2RSS0M1RE5qQkhValBCSnBUMy9FdXhOeTdMYUEveEtY?=
 =?utf-8?B?NkxxMUphQmxMRXZQZ2l0Q0JkTkV1UExiZ1lSNWo4b0trZHR5VDFtVU8wQjl3?=
 =?utf-8?B?K3dPSHB1b1ZqenhrMDk3Q3ZMQ1VKcHJhbjBud2JJeHVBR2FRaU5iVHUycXFm?=
 =?utf-8?B?dWtGb1ZVSkpydE5tWENNQ3VLUnpIeEpHS3pHVmNmRUZZMHJXWVdxSURUK1dZ?=
 =?utf-8?B?cEgvaHVVWEJEeUZlL21rNkFnNHQ0VVFteWxXaVdMdFc4UlZ6TmREc0laQkhY?=
 =?utf-8?B?Q3h1UmZ2bnZNTmVFdXgxemMrSkd1cTlYMENHR2RaLzFXZi9wS25QL3J1aXBS?=
 =?utf-8?B?Z09lYXVIVlNTRXFxR1NzeFRQU09wNHk4eU90SG9LMlppVU1BZVBHb2tJcEdJ?=
 =?utf-8?B?Y2lCNDFyMjgvelRmem02d1Y2MlBQMWxHRVZDclVMcEVnMkpQSDdqOTd0Tm5v?=
 =?utf-8?B?QXVhNnhjcmlDZFkxUXBhNDh4aHBVVCthaStKNk84NHpnUWRldklySEdYeVdH?=
 =?utf-8?B?NU5zRmkxdVpVQmliejVjMUNUN1RXaVdYczBKMGJwL25KTWViaWNsWG5mMkVo?=
 =?utf-8?B?WFZlZUFRbWxsMDhoK1ZrMS90UTV6b21vbUhQVFdaVzh2QkROMFdTdkE0WEJ3?=
 =?utf-8?B?OFpDOG5lUCtCSGhIVm1wL0xleWlxLzlJaSsxM2FKeklCaHBOaThhNG5BV3VH?=
 =?utf-8?B?TkV3aGk3WjVsZTVNRTVod0xmalIxZXY1dnFidWVSK1N4S1htRDI4VUE3WTJW?=
 =?utf-8?B?ZThlcDduRml1TVhtd2JQSXhUYURXMU5wNTlScFVrMzV3ckRuRmNQVmZWcnla?=
 =?utf-8?B?NFBreU1rYUlWdVVtZzhSOURJWFNSb2pVRytlaW5Xd2MyWkNQNW1CbVFTRDlR?=
 =?utf-8?B?VDg0MG9SaVhGUFFLOE81cVVGa1FHeTBTUXJRTDVISHcxKzAxKzd4RytRSVhm?=
 =?utf-8?B?NVlFeGlDcDRDVm9MRW1HVVE3clpYQ2pNMkZTVVhsMUM0WWJPQ001cTY4bzZh?=
 =?utf-8?B?Tnk3Z3hMeHlqMjlTYi9QWW9FUHZGNlBtaC9KMGJpSkg4dWhzMGNmN1JQTnNM?=
 =?utf-8?B?d3VCYjhxZ05ZZFhhWHlOeGhxbzFKUS90NEs2dnJya3haZkVLRE1DamIzT2ZX?=
 =?utf-8?B?UFJmeFAvWHNoQkVack5Ud3VNaHdFMVByc2pmbDA3emxRcHN3amtVTkVxRlhj?=
 =?utf-8?B?Rml0UktEamVkcXVqS0lWRjdBeHpGWnBqMHpobFhUbzdlcVZqOXBRa2FYTEtE?=
 =?utf-8?B?VUV6eTBlYWNjYzgyUXBGZ2N1Z1c5WXFwNlczamJLNXBka3J0K2g2eFM0bEhZ?=
 =?utf-8?B?a1ZabkNDT2JNb0dZcFRlOENWTWFNM3E1cXVJVzI4TE1UM2ZiMkF0czhtSHZh?=
 =?utf-8?B?bkRWOHlRTGZ3U0hCWWVwUVoxa2dkZThNVmQrcWN3dkRscUFNNklTdFV4aEV4?=
 =?utf-8?B?b2dOR3YvYzN2V2c1eWVVVzhlL2JaUHkrdXg3RURmV2oxQXM2VmFBRXJEc3lY?=
 =?utf-8?B?MHNqTzhmZ1MrZG91U2hWdkEzajRlY3hlbEplZEk0Zi9vMWFoMnNKMXlYaHhy?=
 =?utf-8?B?SG1ZTTRMQ1hvM200VHNJNVJYdkk5TDBwK2xwNXNBcHQ5allod1dYMkhVclRJ?=
 =?utf-8?B?QkZBWFJiN1gyZ0dDZUZzSy9YZkdHUGJONytBZXp1T2x6ekwyN3dLang2Uytj?=
 =?utf-8?B?YlBnRDNYZ3BlN05zT01adz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtxeXpUSnk3S2MxYTBKQWFIMnlQbFdjVHhqbnRIVU50VTgwZ1JsN0NLR0Rs?=
 =?utf-8?B?U3dGc21uMDdnZDd5RHVrcHNaSDdYK0gwdXhjYUhtM1hwbHBXa204d3NveWdJ?=
 =?utf-8?B?SDY4UVJ5QWFwNWoyWFpyQUhlTjRCbGswS3VMY0huK01VKzBBeWl4bUVUMS8r?=
 =?utf-8?B?bHh2eGM2UUVsbkpLcGhXUXZtNlUxYS9YYUJCcDhxRCs5WnpHTk4xT2VaK1N0?=
 =?utf-8?B?Nnc4Q05WV1BpWnc1cWhlTUphUFVRTXJNK3hjTkgyYTFmWFlZK25XcUtQcytt?=
 =?utf-8?B?VHE0YkhCdldRc1ZYek5aMjB5bE5nTXpNUGxwZ3ppMnI1TUUzY1VDS3ZaUUE0?=
 =?utf-8?B?VDJ4aDQrdmQrU2pNUDNSRUo4R1RkNXFYWkl1aWRHM0l3QlpMbWhHOWVPY3l1?=
 =?utf-8?B?dWNjNEdqZUozSjR0azhYR3lUMC9tcnFkVnF1UlRRUUR1S29pL1RsOVZFY3Vr?=
 =?utf-8?B?WWxoOW9qQnJudzMzTW84Yi9RWHFxTzBuVWNaTWlqa0hxTERyM0ZmZlF0Vi82?=
 =?utf-8?B?dUJ4d0paZjdXK0ViRWdyUDMxTCtFcm5jNWlGVStzL0cvanJoMWczbGVjS1R5?=
 =?utf-8?B?NityckY2MTBuYzVmSm0yRjUrL3FyRzZQWndjRng2My9ZVDZDMlJZbnE2RWRs?=
 =?utf-8?B?THpKUVVzRUNzbEEvUnVPSTJhWUJBN0hyc2R0UXNFYVhhV25SME5yTWFYWXhW?=
 =?utf-8?B?MDB4Z0dNaWtkbHo0akhobENrZUhoZVFKZlh5SHVucHRnanFmbzdVbUxPeU15?=
 =?utf-8?B?bVNXNXhqTmM1WnJ0OEdIS3k4Q3NSTi9rRlVRWG92QU9mYzZNeGR3QXJPejAr?=
 =?utf-8?B?QW1lQ3dWYU55ejVjMDhxVjRHY1A0Sll3U09LM0hkRlo1N3drRi9qVEtDUTdw?=
 =?utf-8?B?WG5SWGxJUStBQnl0aER2dUZpekMvcmZ5cGdIcE5KV3lPN0Vya2dTQ3U5NFJ0?=
 =?utf-8?B?WTZvRWNId3NaeExPMHRMOXh4dDhOQ1pXeVlldlhXcjJ6aEp6UlRPdXNaaFY3?=
 =?utf-8?B?VnFvN3BIbHNtY1V3VFV4NjRxYjZsNzY5d0R5ZE5saDB4QlRWRGJFMEg2MjVX?=
 =?utf-8?B?Wmxxazg4T3RBQWlZY1gxdnlhbUs4dGx2b3ltUm8vMTZZd0FWVmFyUThhUm8w?=
 =?utf-8?B?L3VIVGRUbWNVT2NVNU9RdUo1UFA4TFNBVmJmTnJMNGQ4N0w4SHUzT0ZlRFBH?=
 =?utf-8?B?MG1HNGpDMUpyQjA5a3Fnd3JKTWtScHNaRjJaclhhQXNXcmtEK0ZwWSt6dlZl?=
 =?utf-8?B?Y3ZQdE9kWDhYYk5IanIyZUZVQXZnNHhxbFpLRnpobnduQnk1TmV4aUIxaG9P?=
 =?utf-8?B?QzBzQXVVdkZyQnoxNytwTktleGNXNUthakFpaEtSVkF5RkRTcEVwTHhxZXBY?=
 =?utf-8?B?K1IwRGxEOC9CWWoxbjZ5YjZ0V1BYTmlPdGhsTHJYaFZzai9XNnVveGx0Unhw?=
 =?utf-8?B?OXFkVVJ3TXVuVS82U1Ewb1JlRm8xeHNXR3Fub3Nwb09CTW16OUZqYnlTQnNG?=
 =?utf-8?B?M1RRVmk2bU5idXRRZ3B4YTVyemYvN0RFZzZPMm51VXBzUWZNT0hJdll2Tmpr?=
 =?utf-8?B?THhDWlY0bSs3NzloYVhvZHJPcm1MYjloYWh1WStqVFcwYVpiK1JnTFhldUtS?=
 =?utf-8?B?bGFPNU1qUnVIdWs0S0t1OFRQTnkwZ3J2Tk9ybjdxZ1kwWTNicnhYbjNFcEJ5?=
 =?utf-8?B?cFkwYmFlZUEyNC9uVUtzK1pIbHExWEhFNU52MWNUNndVNysrTHN4M1Q1YlBW?=
 =?utf-8?B?ZzlJQVBPQ0QyUnBscGIwU3NhSnF1OW9URTlabUhZa21aWldZdHUrYlIxTGRl?=
 =?utf-8?B?M2NiTTlpYzh1ZXYrZU83OW12Y2RabEFQNDY1dEEwdy9wUm94dDkyeWE1N2Vv?=
 =?utf-8?B?ZnFQYVFGTDYzL3M0V1JMMDhrVFBYWUoxeEU5ejV1eXhJWk1yb2dSN0krNzgy?=
 =?utf-8?B?QTVYS0xXYlJtMEJ2YXEyS3ovWG5ZZk5STDFvaUhzTVNaSHdnbXJiM3Z0VXlv?=
 =?utf-8?B?Y1VwSFRlRkZCdGZjUVAydFhPeThQQ2trU0J2eWE5WXd4cGFlR2ptWmVTMW1G?=
 =?utf-8?B?anFDc1R0UmM1WjJ5YjIrYkdBM3NCeG5WTUdtK0ZxbG1ESVduaTR4bHVieEo0?=
 =?utf-8?Q?PWjgcOg8ZX7qDfzhjzXtqi0pA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501e09cc-9be4-42e4-01e1-08dce97c9bb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 22:40:57.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RUFQXG8EDL0o/udJkP6ga2fmiAyi8G+m5ioNeYEl+7n1JEjAsJeRWOIb2X5TZxZNSecdRsrNr/SSVkfiEhwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7144

On Thu, Oct 10, 2024 at 04:57:45PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 08, 2024 at 03:53:58PM -0400, Frank Li wrote:
> > Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
> > CPU address information.
>
> s/in of_pci_range/in struct of_pci_range/
>
> s/CPU address information/parent bus information/ ?
>
> This patch adds "parent_bus_addr" (not "cpu_addr", which already
> exists), and if I understand the example below correctly, it says
> parent_bus_addr will be 0x8..._.... (an internal address), not a CPU
> address, which would be 0x7..._....

It is "untranslated CPU address", previous patch use cpu_untranslate_addr.
Rob suggest change to parent_bus_addr.

Is it better change to "to retrieve the address at bus fabric port" instead
of *untranslated* CPU address

>
> I guess "parent_bus_addr" would be a CPU address for the bus@5f000000
> ranges, but an IA address for the pcie@5f010000 ranges?

simple said "parent_bus_addr" should be address under pcie dt node.
5f000000 should be 1:1 map.
Only 80000000 range is not 1:1 map.

>
> > Refer to the diagram below to understand that the bus fabric in some
> > systems (like i.MX8QXP) does not use a 1:1 address map between input and
> > output.
> >
> > Currently, many controller drivers use .cpu_addr_fixup() callback hardcodes
> > that translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR"
> > (drivers/pci/controller/cadence/pcie-cadence-plat.c),
> > "cpu_addr + BUS_IATU_OFFSET"(drivers/pci/controller/dwc/pcie-intel-gw.c),
> > etc, even though those translations *should* be described via DT.
> >
> > The .cpu_addr_fixup() can be eliminated if DT correct reflect hardware
> > behavior and driver use 'parent_bus_addr' in of_pci_range.
> >
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
> >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> >  └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
> >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > 0x7ff0_0000─┼───┘  │  │             │   │  │            │
> >             │      │  │             │   │  │            │   PCI Addr
> > 0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
> >             │         │             │      │            │    0
> > 0x7000_0000─┼────────►├─────────┐   │      │            │
> >             └─────────┘         │   └──────► IOSpace   ─┼────────────►
> >              BUS Fabric         │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
>
> Thanks for this diagram.  I think it would be nice if the ranges were
> in address order, e.g.,
>
>   0x7000_0000
>   0x7ff0_0000
>   0x7ff8_0000
>
> (or the reverse).  But it's a little confusing that 0x7ff8_0000 is in
> the middle because that's the highest address range of the picture.

Okay, reverse should be simple.

>
> > bus@5f000000 {
> >         compatible = "simple-bus";
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> >                  <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >         pcie@5f010000 {
> >                 compatible = "fsl,imx8q-pcie";
> >                 reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> >                 reg-names = "dbi", "config";
> >                 #address-cells = <3>;
> >                 #size-cells = <2>;
> >                 device_type = "pci";
> >                 bus-range = <0x00 0xff>;
> >                 ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> >                          <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
>
> I'm still learning to interpret "ranges", so bear with me and help me
> out a bit.
>
> IIUC, "ranges" consists of (child-bus-address, parent-bus-address,
> length) triplets.  child-bus-address requires #address-cells of THIS
> node, parent-bus-address requires #address-cells of the PARENT, and
> length requires #size-cells of THIS node.
>
> I guess bus@5f000000 "ranges" describes the translation from CPU to IA
> addresses, so the triplet format would be:
>
>   (1-cell IA child addr, 2-cell CPU parent addr, 1-cell IA length)
> m
> and this "ranges":
>
>   ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
>            <0x80000000 0x0 0x70000000 0x10000000>;
>
> means:
>
>   (IA 0x5f000000, CPU 0x0 0x5f000000, length 0x21000000)
>   (IA 0x80000000, CPU 0x0 0x70000000, length 0x10000000)
>
> which would mean:
>
>   CPU 0x0_5f000000-0x0_7fffffff -> IA 0x5f000000-0x7fffffff
>   CPU 0x0_70000000-0x0_7fffffff -> IA 0x80000000-0x8fffffff

Yes,

>
> I must be misunderstanding something because this would mean CPU addr
> 0x70000000 would translate to IA addr 0x70000000 via the first range
> and to IA addr 0x80000000 via the second range, which doesn't make
> sense.

Yes, it is my mistake, first length should reduce to 0x0100_0000 from
0x21000000. It works because dt convert IA to CPU, instead of CPU to
IA.  for example, input IA: 0x80000000, match second one, convert to
CPU address 0x0_70000000.

>
> 0x0_5f000000 doesn't appear in the diagram.  If it's not relevant, can
> you just omit it from the bus@5f000000 "ranges" and just say something
> like this?
>
>   ranges = <0x80000000 0x0 0x70000000 0x10000000>, ...;

Yes.

>
> Then pcie@5f010000 describes the translations from IA to PCI bus
> address?  These triplets would be:
>
>   (3-cell PCI child addr, 1-cell IA parent addr, 2-cell PCI length)
>
>   ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
>            <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
>
> which would mean:
>
>   (IA 0x8ff80000, PCI 0x81000000 0 0x00000000, length 0 0x00010000)
>   (IA 0x80000000, PCI 0x82000000 0 0x80000000, length 0 0x0ff00000)
>
>   IA 0x8ff80000-0x8ff8ffff -> PCI 0x0_00000000-0x0_0x0008ffff (I/O)
>   IA 0x80000000-0x8fefffff -> PCI 0x0_80000000-0x0_0x8fefffff (32-bit mem)
>
> The diagram shows the address translations for all three address
> spaces (config, I/O, memory).  If we ignore the 0x5f000000 range, the
> mem and I/O paths through the diagram make sense to me:
>
>   CPU 0x0_7ff80000 -> IA 0x8ff80000 -> PCI   0x00000000 I/O
>   CPU 0x0_70000000 -> IA 0x80000000 -> PCI 0x0_80000000 mem
>
> I guess config space handled separately from "ranges"?  The diagram
> suggests that it's something like this:

Yes, history reason, dwc's config space is not in ranges.

>
>   CPU 0x0_7ff00000 -> IA 0x8ff00000 -> PCI 0x00000000 config
>
> which looks like it would match the "reg" property.

regname = "config"

Frank
>
> > 	};
> > };
> >
> > 'parent_bus_addr' in of_pci_range can indicate above diagram internal
> > address (IA) address information.
> >
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v3 to v4
> > - improve commit message by driver source code path.
> >
> > Change from v2 to v3
> > - cpu_untranslate_addr -> parent_bus_addr
> > - Add Rob's review tag
> >   I changed commit message base on Bjorn, if you have concern about review
> > added tag, let me know.
> >
> > Change from v1 to v2
> > - add parent_bus_addr in of_pci_range, instead adding new API.
> > ---
> >  drivers/of/address.c       | 2 ++
> >  include/linux/of_address.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 286f0c161e332..1a0229ee4e0b2 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> >  	else
> >  		range->cpu_addr = of_translate_address(parser->node,
> >  				parser->range + na);
> > +
> > +	range->parent_bus_addr = of_read_number(parser->range + na, parser->pna);
> >  	range->size = of_read_number(parser->range + parser->pna + na, ns);
> >
> >  	parser->range += np;
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 26a19daf0d092..13dd79186d02c 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -26,6 +26,7 @@ struct of_pci_range {
> >  		u64 bus_addr;
> >  	};
> >  	u64 cpu_addr;
> > +	u64 parent_bus_addr;
> >  	u64 size;
> >  	u32 flags;
> >  };
> >
> > --
> > 2.34.1
> >

