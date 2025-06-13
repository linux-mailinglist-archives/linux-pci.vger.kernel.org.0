Return-Path: <linux-pci+bounces-29789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C8AD9763
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEBA189DDA5
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217B28D8F5;
	Fri, 13 Jun 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NxubP93a"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63128D85C;
	Fri, 13 Jun 2025 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749850473; cv=fail; b=ma8Cue1+r17u1C7hNow2jrOEClDOd4WcgDCsr8si92NFBK1UWXuV2tkUnWyaYPwks26+cJ+YrmpDduOXMaGvSkk1SxRQDoe7sZB6FX9xkJB2j5kRChTP7/A4MHEyx+rvzbbA0JLry1Q2K5HYPpMNFvLbT9xg9kgpjsch0a2LrcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749850473; c=relaxed/simple;
	bh=vo0+uX5He7qurvniAXi9ptwZD6ezTChr3HbYcFRyn6k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=a7ZPxEV4++hDZClNepC6sG9/4GRIf7WFK8ysSSuIdXHMym02XXIJ5r89vErW4OIsbC51ErXmxUX0jbQlGSBbAHCs+p7s664fAy1kMvYQO1hXKvo7MeNmh+kgdYLdyqDuWeZ/p9olqHQJmmzui40G6gOV8uuTHc/lIFrlUlZ1cQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NxubP93a; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHey/rEWzFlV1USdcqQZhZtCrTImQeYgB+UckiTqKKBpEvYrI2R6Rq0EoXiSOTEnzf1OP1f1mzS896DLsl2RoZ9qcCJFmMHroKpyymabnA3cKoKo38kE3Et47Xx8RHj3Pk36kf54DGsOc+NOTC+RYN6sXhLz72aucnD+IOPE02AGblRCQCRkM7E9AieaU54oHQUXwXffFHm/Q9ypM2oGO5IOPJgyNwFoq+/Gq/czWnDjUDeeAc4F870ToBgSbyu2rLFWNyc8jGnwp7je54b8PQ3sx8h0HI6b1j/RChrUNewkhDbEfa8JvGsLAYc+HU/tzchjpm7Mc0F055v7dulhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9IV/apwEqVQDnH8vxgsjDfKjhFL+S4vJcRbo9evyQM=;
 b=aK1ElbMMWOzpcGfSTZ7aJ0zfvUYcSw69xxz0PhkzMrFOGTW9X3ClGE8IUQDjt4tSBrgdF804/Zi4l4MVjaVYjjlIhjzn9Sc3GOQ3CmJW36ee1LKVo8PdjkIVRw6tzFUVcfGSaMjxVvrqjvqHUZkrb4ozRJRiy+7SZeBSFgnaTKbIW5rFQ1vO32RRRTdaXvubI2uebrEz5cQW0Yi+5RcCTQio3M23MxhIny5zU+R8YxDENsyw6fiGUsN8VQiUhBv+bsksTk/jYzVS8rmzRwlBmp1jAIgG5sFIZKe013uNyvPHLKh/dZ/Mrbedkpk8VZv9jSpLYnXGQylrFELMLMD+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9IV/apwEqVQDnH8vxgsjDfKjhFL+S4vJcRbo9evyQM=;
 b=NxubP93aoGG/JV9k1megnq0WP9l+vm+B+BSfiKmLEG0nAdL6NNlh6XX30W0LLUIBOY/0+916hmiKnWaDzZpl30g3V+ElK1h5r8+Ybq815MvPR2XzzViNzZszaVGa+j48XaWxjE30BGRwphLxSr3dipLEo3Fmy81PFh0bL1LVrl63iqm/ABNsyeAhs6H/gZ9gBVkeFIoNUSfb1qdVwAtc0Nn0d83lQZM24jkFX5bDB0in3Lvhr/luhj2xyqLo9rSlwdo7KcGE8mfeVkeVdPuwGaxUr/XqV0taQ354PFk5syIsvVHdae0ScSEWtUbd1BCg7TdmtW3cqbdpbL7Y1lL2Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB9856.eurprd04.prod.outlook.com (2603:10a6:20b:678::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Fri, 13 Jun
 2025 21:34:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 21:34:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 13 Jun 2025 17:33:29 -0400
Subject: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges to
 reflect hardware behavior
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250613-tmpv-v1-1-4023aa386d17@nxp.com>
References: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
In-Reply-To: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749850461; l=2240;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vo0+uX5He7qurvniAXi9ptwZD6ezTChr3HbYcFRyn6k=;
 b=XHURsMmBGAtgT5xUGONVvuEPKmSuM5r3gNNE6IZa9F+0V2HHPEuhnziVlNyktztCC71nzlLyx
 h4d/8xoTty/CUKCSNyKaEiPCLgT48YxhPFE9H2I+xNC4NWWX2hqyoXp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH5P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 48778e18-af1c-407d-c97d-08ddaac212bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWJjSDFzaGlEY0YrN2w2QmRqUWcvM2JadmoxdFJ4NU1SM3ZPNThFUXdkMzVU?=
 =?utf-8?B?OHN4UTNZOWQva0FJRWV3S1ZWYU9zVHdvUkpRcHFCZjdnU1J2TDJaenpvaU9U?=
 =?utf-8?B?Y2ZhMTVzNGJYUzFYcXovaDFiK2JXYXhUTlRRZ2tOdUc3RkZZayszN0Fla05Z?=
 =?utf-8?B?OVhrNTJXbjBtWkU4cjRaNXBsUGEwUmI5WHg0bEFjQzR5bW1wemRvUjlJcllu?=
 =?utf-8?B?UXF0UW5HeGtqdnRBenRPWTIzK1pJdThEWUlnM0psWmt1NUF1VWlpNFJvcWRJ?=
 =?utf-8?B?TnRZcExMcjFzd0pLeWJDbkxxZDVrcGVqY082endEb2Q2Unp6NEhzUzhYNU1t?=
 =?utf-8?B?akNSeGU0TjE3VXg4QW1LR2pCN0VlTStWVnRMYmNadHdQT2hHbGpPRkl1Vmwy?=
 =?utf-8?B?cG4wNU56RHZ2UVlTak5ldHBNdnl0ZUJaVUY1SGRXN05URWY3NlFyY2lXNmtq?=
 =?utf-8?B?NS85ZVdaSndHRDJBbTZ3N2piYkQvL0JTZGR0SWFUazkvbzhpcEhiSnVIQ20x?=
 =?utf-8?B?V25ZbTdrUVlqVzdGcVJTVmZnbVB5VmtFNVhybE1velFzSmpEK0xIa1JuOGhK?=
 =?utf-8?B?cUQyZ251ZWdyRDZmVWhwSGtsQS9Zdm41Tm9YQ2FsUHdmRjl1c3U2Rlk3QkM1?=
 =?utf-8?B?bzA4eDU5VXI4Mm5UUmJtaWI1ODNGSHh3S1JmMDhMZURxY0JoclpJSFJ5dXRD?=
 =?utf-8?B?R2ZvVk10WklYK1FleHY1d2gxdG9ja25HT2tmMW9sMlVEUkJCV21kamx4YjdV?=
 =?utf-8?B?dzBLcDU1end0UWJhbGc4VURmSnhUQzZkS0NOUEE3Nm5BcXQ4ck5lSUN6TTh3?=
 =?utf-8?B?VmxTakJjVUQyVFEzcWxGU2pTbkxIai9jMW5lcmZ1TyswUzdVSTdJbnJYdGlD?=
 =?utf-8?B?SHdvOUtMeWkrQllzK0YyQUltQktUU0UzWXl3TW9YM1hIWTB4Y2xQRHgxcVdL?=
 =?utf-8?B?SzIyQXR2ZFRjOU43TDVsaVI2YWc4MHBsblljSU5tU0paTTg3OGc1UVpaeUY0?=
 =?utf-8?B?OXVoa1RQWTBZUElNN3JFSVhmeFduTXkzdkoxaFIwL2tqUUxoYVRxYndFT05u?=
 =?utf-8?B?UkZKSkZnT1Y2WG1uYjF4RlltMDVKRHhpVXBxaDZFNXBSRU11bDJFQVVVQjdX?=
 =?utf-8?B?a1lEQm1vSmN2L3BJb1FnMVpvTm56MnRiS1RlckpLeHk5TUZkRWJRMHBxMG5B?=
 =?utf-8?B?Z1lKRWtBZU16c1NlUlp0RmpEdm5XRGRSaVhpbEdaZy9hOUI2M29DaitES0ZQ?=
 =?utf-8?B?TWg5S1ZscXFUNGkvWVFDYlNsQVFFUmo1MEVBU0h3UXA3b1dTVW00THYyWndi?=
 =?utf-8?B?VEgxcDZSeWh1RVZPSnorcGdaVnNlREFsOTExVjBvN1A5T3Z4RGh3WTlvTm9I?=
 =?utf-8?B?bjlTSW10K1h1MDE3L3hqaHRXTit0dnd6dWhTYVo1RmdkT0pNdmpaUmg1R3ZL?=
 =?utf-8?B?NFVreEpXYXk0RU8vU2RlRUk4aHJuOC9yZlllZHl0V1JmSzM3VitQZ2l3MlJW?=
 =?utf-8?B?Qld2amJaeS84cDhteU8vaWc2UWI0QnZNQk5QM2Z3STQxZFNrTjVXVXZVbytQ?=
 =?utf-8?B?dXk0OHdLNjhxZzZBRjNRYXF3UWtNZVpRclFheUpILys1VGxKZHlvWWo0Q0h4?=
 =?utf-8?B?ZW4vTjdTUXZVU0VOTWZ0ejVZTU5wTmd0RTNQa0ZDWTFzRVppQ2p1cUNJa3Fy?=
 =?utf-8?B?Wm1Ea2VaMm00WXNCM3AzTWZ6czBsZUxsc2xyYmw4WEFLUWVERnZlaU5aUmNQ?=
 =?utf-8?B?L2ZUUGdHRWV6N255UHM0WWMzNnBOU1plNk1SbXhkcEZhWm5wNm9TdjhhUEU1?=
 =?utf-8?B?Nm8zNzV0QzdWQkpXU21ZM3BXQUowM1FZMlhpY29hMk1VZmFLQ0lvdVZyYTVr?=
 =?utf-8?B?UlNZMjN1ZlRhVS9wQjFWYjZjSXFYeHlKVG5tSUJ2aVJYMXQ3a2c4RklEODNs?=
 =?utf-8?B?akJQaUc2RGtyVUJmQU9uQnd2OWpSTzg3ZU4wbnQzbHVjLzVqZGdwU0w0QUZW?=
 =?utf-8?B?cmZ6K1RLQ0lnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QURMWGdSWW41ZENUeGhuV0pVMlJNbkN0Mm9tMWlYNjF0TWk3cWZMZEtocEdt?=
 =?utf-8?B?VWtDVXlpMlNJdXVwdEU0UUZMbEViOHR1QVRNc1F3eCtGZmhTWmRnUWFUZDQ4?=
 =?utf-8?B?YkJmMmc3OGhMWEZlN2QzeE1jbTZvRWVxYXFjSldwdFFsZmd0bEwrYVgzUmRV?=
 =?utf-8?B?Zm0wVXQ0OGY3N2RzeUpldjFNVExzSXRsU0xOUzlCbnN1QnJkZDJoYmFhR1dR?=
 =?utf-8?B?djNRQTdGRklTUnlPSllqTVFYSm5TTWxMQzhTSVFya1dHekdicStuQ2N3VU0z?=
 =?utf-8?B?TnlydWd6QzdEVXhKWlhNWWJROVA2aFExaE1kcXdiNTFFdXR6Y3c5ai9VRE1m?=
 =?utf-8?B?bUlaVFViQlN2dHJNaXVHTW5tVWUycHJGQ2JhaGFobGh3RFNYeDFOQkZic01t?=
 =?utf-8?B?Nnk0SlFFczlrREE1Y3M0aE9vN0pIc21yWTgvRDVkTHdQdytRcXlrV1pVdkxj?=
 =?utf-8?B?TUtObVdFb2ZRT1hNT1p1aUE1NW1maVJRN0pCLzlBeEFSbVkvVkQzZ2lVYU16?=
 =?utf-8?B?T0srdjdlSHlUVkpndTk3UFVuaEx6ZytWMllIVzNrOS92U0EvZno2WS9HbFFK?=
 =?utf-8?B?dXdxcFBKMEQ2MkhvbzhZYThiUFNIWTc2T3MxWGVsaXF2cG10Q3lZZGl0SE5J?=
 =?utf-8?B?d3JnMmRFWU93aWpPNjZwa1pzWHR6b0I5RTZVQk1NbmJUZVR6c0pEK01mRElh?=
 =?utf-8?B?OWdlWVlxZjBxTVY3VGVIa25WemFURjVZZUJVamZpNFRheG4rRGdaMjlkSS9O?=
 =?utf-8?B?ZzV6QW9uc3BjTmpVWWRXeTFnNXNKOHp1RXpNN1BMcjAxT3ZXRXRuellXQm9J?=
 =?utf-8?B?UkQyNUNSUWsvdDF1cEc0QjFEL1FTNXJVZ0I3QTU4aDNNYlFCYXdVT0gyL1N1?=
 =?utf-8?B?ZVR0MFZTUldvd3hGUjR6K05QbHlBa2pVZTRENzZvT0xrbS90NkJmTCtvNmFB?=
 =?utf-8?B?UEhwMDhlMlYyelhCVG41Z1o1eGFZeENTRm1sZkZmVnVrSzJBZTBhRkl6SEsw?=
 =?utf-8?B?M1BOTXNLTldsVXdwRTNuUFZ1OXZaN3BnMlZBbnJBT1V1WnRTVzdvRzlMSUZ3?=
 =?utf-8?B?YkpkYy9KaXY3V2c2Z0YxUTZ1LzMwdDFIeXdlMUhtbTdPRzF0VW00cW1DV1lJ?=
 =?utf-8?B?cWVrRlRxbUJvdThHNnpvUXJQYm9Bem94THhaSkQrMXF4Y0NJSFhCMHIzL3BG?=
 =?utf-8?B?eXF4c0ZWSjlqNDNjTkpOZUFvc29odndCNDhDdVBUM0JTNGdJT0ZobkdNS0dF?=
 =?utf-8?B?b1JydnorcXN5bGlGY01rY01MRGw2Mkx2NllXczlnTXAwOCtBdUFaN3RJNTZs?=
 =?utf-8?B?SGI2OS9pWXdGS1I0RzcxOTkrRUF6b2k2bStrbVF3STZsQTJKV1l5VVROTFoy?=
 =?utf-8?B?dCtRYmZBQ0ZoSDhZaDdabyszMHNadm5FazVnZUR1MFowTU02K29mdDVWK0tZ?=
 =?utf-8?B?b25JbTRPUzVNVkMyRklTV0VQaVVoQy9kUUorYkZ1R2UwbEo5Mk1KT1BwWlVB?=
 =?utf-8?B?N0FYUTc4bmdkSXhrYlZIQ2F1TGVYR0xabGhIQWxmeHJqUkdxZzV5WUxlZ1Fz?=
 =?utf-8?B?VmxWNmlCRVlod2hzM3VhOW53dzUzaGIvSFZ5SkJXMVBiMFk5UW9NRCtVa0hR?=
 =?utf-8?B?SFJPS2JvZ3JwY3pJN0hMRDBrVHRnRkpmUS9EWkEzMll2N1pNMk5OOXNwTHNr?=
 =?utf-8?B?dWZMa0xQUHhFeWpSRHpkRXRaS3JwSUc1d01MbHhyYTBOQklKdFJiblhnQzZ4?=
 =?utf-8?B?UUxPZkJtM3pnWGNkOHgrM0F6WFI4VHdWemZUUHgrZk4wb1NPSm43R2pmUlg0?=
 =?utf-8?B?dFU2aG0rblRNNU9DOUljRVRwZFJleVVVZFZQemRkbmU5RzZLRWZwbjR2YzAy?=
 =?utf-8?B?OE9EOG9XTE9SMTNrR0NFYm81c1h2WlQreFRLclZzTDVadEdsNjc1cFdmYk4z?=
 =?utf-8?B?TXlGTzVuTjdScG5SYlM4MXVGb2FwbXAwd3BUOHFrQ1NYWEJHQy82TWd2anJh?=
 =?utf-8?B?c3YzZWNvcHplK3hEZkJwVkdud0xoVzkrTWFuVUpuc0w3MXYzcmpGN09Ealhl?=
 =?utf-8?B?anV2US93dkxSRldLVkp5V2FqYi84cWltZWZpYzlNUDhzVHJ2eWUxdjBob2Rr?=
 =?utf-8?Q?0a/rnRfvZAtR7lat2Hkg53NeX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48778e18-af1c-407d-c97d-08ddaac212bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:34:27.3137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDs6EliptGoUqETG+8VRdE7SdgpBwnmPJ9HoKl1rXrxYQ6+8I23R0gh6U9KIQrUwem1xvB8LhVScIkfV3vtlWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9856

tmpv7708 trim address bit[31:30] in tmpv7708 before passing to the PCIe
controller. So add a 'ranges' entry under the parent bus 'soc' to map
address 0x0 to 0x40000000.

Update the PCIe node's 'config' and 'ranges' properties to use the real
upstream bus address.

Ensure there is no functional impact on the final address translation
result.

Prepare for the removal of the driver’s cpu_addr_fixup().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 39806f0ae5133..2a18aa93d4723 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -147,7 +147,15 @@ soc {
 		#size-cells = <2>;
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-		ranges;
+		ranges = /* register 1:1 map */
+			 <0x0 0x24000000 0x0 0x24000000 0x0 0x10000000>,
+			 /*
+			  * bus fabric mask address bit 30 and 31 to 0
+			  * before send to PCIe controller.
+			  *
+			  * PCIe map address 0 to cpu's 0x40000000
+			  */
+			 <0x0 0x00000000 0x0 0x40000000 0x0 0x40000000>;
 
 		gic: interrupt-controller@24001000 {
 			compatible = "arm,gic-400";
@@ -481,7 +489,7 @@ pwm: pwm@241c0000 {
 		pcie: pcie@28400000 {
 			compatible = "toshiba,visconti-pcie";
 			reg = <0x0 0x28400000 0x0 0x00400000>,
-			      <0x0 0x70000000 0x0 0x10000000>,
+			      <0x0 0x30000000 0x0 0x10000000>,
 			      <0x0 0x28050000 0x0 0x00010000>,
 			      <0x0 0x24200000 0x0 0x00002000>,
 			      <0x0 0x24162000 0x0 0x00001000>;
@@ -494,8 +502,8 @@ pcie: pcie@28400000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-			ranges = <0x81000000 0 0x40000000 0 0x40000000 0 0x00010000
-				  0x82000000 0 0x50000000 0 0x50000000 0 0x20000000>;
+			ranges = <0x81000000 0 0x00000000 0 0x00000000 0 0x00010000
+				  0x82000000 0 0x10000000 0 0x10000000 0 0x20000000>;
 			interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi", "intr";

-- 
2.34.1


