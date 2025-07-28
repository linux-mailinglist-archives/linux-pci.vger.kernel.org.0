Return-Path: <linux-pci+bounces-33075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B087DB13D17
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 16:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB51516F8D2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 14:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F31A704B;
	Mon, 28 Jul 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AWC7pQD6"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0B265CD8;
	Mon, 28 Jul 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712777; cv=fail; b=BXXXEbI6kdtRP3bS5uQkw310h7UWaONNjWy3xLEcUnbg0WLoIyuVK7VBJ/j5RxD+2rTPcJVjJVoLL4NnsC9vkX+4uUTsH0V1+K3+win1Bis6mAEYlAyVerYzkXcPgWFlJi5TKEoLNjxVpP0T+NprQ2i9ANOAjR8x+eYDAv1nG7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712777; c=relaxed/simple;
	bh=cXxdUFoNMLEXdZawxI84zhQodXDBdX6ZXaB2RSo1fOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NjQfHOjeNxi+h4hj+V7paAfI0xoqJbupQIxJgXQ+cHP3roFXstjcNNxsEhRMCBXMeDY1yfipAdANZioN1Nv+5jjq916sj1sCo3YBGfngoyyIk3kHrVCmB1oVL3LlPWONSgM41CknlX/8pooxIQSA9ooLFcPecXRXl3iCjlb70wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AWC7pQD6; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9WUv+XSQolAhtNpEI8cYv7BVra7iEBEE6GMRBLLZ0Qg7M2ln3Un/+PXHv4GD+KhuJYGN7Th17bbEWFm4Qqyx/nY437EdCGfLJW0UF/sQZU3gzGcxMgirfQsOtUoxokO9qoHgHv+mJJbT9PdOauo5whHTv4BV8SGPrQFgdLKPgSCYVd9MBF9SqaL5QH505Z8WRmSmH4uUooPhws0EbJwtfc22XF1bOZ3n06glIvQrDLHDRfawFbQOjeksbJ1Lx522X4ym6oBYyO8NSL1V1WunkZ5Q1aLabBEm4Zzl83ybPC31b2izYAIBcZL4xnW85c/NCAJxvRbdfMJAC7IDfg37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc7z2T3E9zr4CI2CrQz/0zkIfPlPM+m4Qb5CkwZwd3U=;
 b=zI9hgAA+h+sgoUbPQqSnCyAE1RwiPqyIcUm8Dg5BtWElq1EYgZwjLRnoUkaNITac6QRR7JcUHb2Xs6pvdmpaXNfntwL/+Gw8ifaAxMizsG6xlZgfGhIF2szV1X4cqqZdhzqsfaopp1X5yDER24X4iHf43wrAVCWkvEzj7Hx21SsyyL5gseb1+l7wZ+HEZI5pDbhCWbZB+F8CkordeVNBi6DCZtRK3rituS64vkH/9/sqeYRXHtNGPrr+jMWiZTg+qCc+26mqn7ktTUSR9MSyz+ezuEvpdS45jkv69HnfGtxXkEq5wclMd++37/OsOZBXRC2R3kqJPhisjljvZJG3ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc7z2T3E9zr4CI2CrQz/0zkIfPlPM+m4Qb5CkwZwd3U=;
 b=AWC7pQD6eJqxPPP2wTOMdwazHMzeTAtuomB+Luto2HnpfyJuUs9Vl/AFx6G5jck2qfr7Rp4yjLG1LuuN28mdqT8ZahEjU6Lmw0b3yyola0F9BR/hGQCwqt0ccAwTejZNDzf91aQX5yCHA0wWEymgolYu/WpTMz5fAUjPeARRnVYUInHm3TOJk6LEJJIJfEhkQpOzwQhb+6vvK6fc/32D3LCMlMZtuCpL25OaSJZXzwY3504PO1cepu3O2RYb4ug+K8FQxFnyAhH4iTbdCv8IGe4s+66bBMiiAvkbznPN6dIYU8TX3gFWDZEamg6JazpYBaTVM0snO491BxWMOfGn5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7243.eurprd04.prod.outlook.com (2603:10a6:102:8c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:26:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:26:11 +0000
Date: Mon, 28 Jul 2025 10:26:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges
 to reflect hardware behavior
Message-ID: <aIeIeQsDLz53aAHR@lizhi-Precision-Tower-5810>
References: <20250613-tmpv-v1-0-4023aa386d17@nxp.com>
 <20250613-tmpv-v1-1-4023aa386d17@nxp.com>
 <TY7PR01MB1481875AD0293961D0DB8738E925AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY7PR01MB1481875AD0293961D0DB8738E925AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 72da29e3-e8fc-4a38-5915-08ddcde2b39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V05JSUwydWF6ckNDSWFXeEVjWU9zemxXVWVSU0k0STlHK3hGUnl0dWIraWdq?=
 =?utf-8?B?S3k4c3lHYWxmTVRvdzU4dnZCZDBOcDJ4TkYzTjFmQkpZZ01DWXJCRjNhWXYr?=
 =?utf-8?B?b0tBdXdUaTRGRjhYcDlodFNVOVVoR1h1cExsNGNHcDdKemRFUjdLRVZjS3lG?=
 =?utf-8?B?UkR6dHFiVC9CN0d2UG4rQmwwY2kyUURvNEFrQWUzZXdZT1E3cCsxNWJBR2Vu?=
 =?utf-8?B?RE13MzlqTUVtZlpaeWsvdHRkakNhaTVUWEUvZlBDUHkzbG54SFBScUpyNVly?=
 =?utf-8?B?OFF0dmwzWWdab2tJc09xSGJpbWt4SUIzM0JVZHNodm1FbW02VjNLY0NkZi9J?=
 =?utf-8?B?dDhGYVpENDhaaGwxd05yaFNNVFRnQjNpS1l1d3NPN1lZSTJxL0pzclB4b1RP?=
 =?utf-8?B?WmhZZWNRM2tsSFVmb0k1TnNDaTFhSVdaM1J6MWovYm5YQzh0UWdpT01NZHFF?=
 =?utf-8?B?ajNZUGVEUW10ZG5qdnM5K1A3UmZJcEF1Q0pXQ2xwaFZkQzVKVmlNL2NOK051?=
 =?utf-8?B?RlpaRUEzUTBMelpCQVdKVk9PVFJDSFVFTWYrZ1dCb3IzN3pyTEEreDczd2hs?=
 =?utf-8?B?Q0RmL0xQbjlIN0FtejN1Y3A3bmdqLzg3RUxVTzNSVFdPaHkxZzZIQzNFWEJO?=
 =?utf-8?B?ZklWNUVVTmJZd3AxVFMvNGF6WUNUMDEvWUVzVlJUc2FTQVVoQndnWWMwSGQ4?=
 =?utf-8?B?ZWg2bGNTSnkrRTN3NG94VVpUZlphUHFVc3NnUkhiTzdmVWtLd0xaU3liblFa?=
 =?utf-8?B?dDB5TGNaS0dlRU9rUVUvb3FoaVpkY0JrU1pDdVh2Tk9MclBySTNJR1hZUGRa?=
 =?utf-8?B?elA5TmZVK3RRSlhtalNDb3NHTmlScXI1dnR2bU9pS2QzQ2FoV2Q4dU9pQkFq?=
 =?utf-8?B?VHRKYUZkSlV4MFY0NXE1ZkNKb0hLVmpybjROYzFyNzdrZXFHSnZIeGpweDM1?=
 =?utf-8?B?TkxsZDNtakVYTU9xR0JSVXhxbVNuRVQ1aDBOY0UxOGlHdGxDcm1PUXB3TmtY?=
 =?utf-8?B?UlRTcTFTbEJ0ZXJ3SXA4Wmd2VXB3bE5mSlB2Z3I4SHIvZCtscktqaTNDZGJQ?=
 =?utf-8?B?RUkvaWxBYWdjWm13dXBiOUZJQlQzZ21OQ2RwanZBQlRUVXF3Tk9JYmhNNWJn?=
 =?utf-8?B?dTNPVzdxcjArS1ozcEhjcHRLNTJnL2pEMXRZZFJTZ1k1cnZRVGlOTkNabkkv?=
 =?utf-8?B?aTV5OHUzd1FNMGVsNS9JN295cFpEZm5Xb0JSZGp4d0RoRjJWakxYMEw1dlY0?=
 =?utf-8?B?K3RDVEFuN3JrRlF0N1o1YXJOSnM4MTV0RHU1amZaaXl5WXVCZzRQREVWTnow?=
 =?utf-8?B?UkZERnF2L0NySG4yRG1HVC9RY25UOWdWd3ovQVFxa3hidHVPQmtKNjF1K1Va?=
 =?utf-8?B?alVDWTlIeWdkTzRoQ3lrVklqWUx5UWprNHVURU9SWUlwMHhZQlNZR3FZY0JO?=
 =?utf-8?B?Y0lBblVsSTNwZkR4U2xoaUI3b0VkeXFtUGV1N3FTenhKM1lYODJJVFlIbFRu?=
 =?utf-8?B?dHRHUi82WU4zTHkzc0Q5VHB5bHBiSXgvWTZUK1lvcDh2WXpqNURTcmdabFg2?=
 =?utf-8?B?aitnSTRqSnVNN2ZkdUhpY3VHQU0xczJYSW1Hbkc1L3ErUmN1S3U2UExtQVdH?=
 =?utf-8?B?QWtQMmdSZ0RUejJHdmx5V1VlWjNTeE5mWlg4NnhaNkFiLzdTaEtSaG9RaVl2?=
 =?utf-8?B?NzFZbXp5bGhsQmxJZEtsd2NpNCtMT3lpa0h2bGE5MFh4S3l2M0JoNTNYQkta?=
 =?utf-8?B?eHAyWWRhSGRLOTg1S2RBZXRRT0VqOFpkWTZRb2tIcVVrZGtHMGdKeVl4bDRM?=
 =?utf-8?B?NmU3VGJFb29oOHBwdjc5YUwwazdrdzZKcnBPY3IzcEV4QUFRSlMxalVraW92?=
 =?utf-8?B?RW1rM1BZVi84aVM0QkNWQmZISE1LVGdLQnBRQlhUUWhVbzRlOFhZakttc1pB?=
 =?utf-8?B?S0t4UGpZdEY0UWJxL3psWVc5eWZCaUpKR21OL3JSVWliVnVSbkl0TWlsazlR?=
 =?utf-8?B?RlJhTlJ4QmRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHVCNXBTOERvQyszWnVKUGRxaFBqeno0NHdpczVqcVcrTCtMbzQ0b3BqYjdn?=
 =?utf-8?B?dTJkYzdIeTRPdzNOSHN3OVlwSFRtYmtyYVd5UHFaSVNhZnUvUUwwNllmVjg2?=
 =?utf-8?B?S1BFVXlFd1VyZnVFa1A0RFlTck9CbjRhb0c2alAxd1drSUJnZUN3SnVuVUVv?=
 =?utf-8?B?ZFZuSXdBeml2K1o2ZmZTczB1Q2FPSGM0ekJPc0t1ZkRrZFg5cFFHWGVxQTR0?=
 =?utf-8?B?MFY4NDNjVlhaeEtXbjNXQ2orclR0QmFLcWV2WjVXdkVoYjBhZVY1R2tMaGFp?=
 =?utf-8?B?dXJLODhkVGNKbFRsbFU2a2QvaC83UnY3SHRmUkdIVi8yV2tvSVR1dmxmWWdG?=
 =?utf-8?B?NFNNQ0taeVZtQ0ZLR1hrWWNuS2E2RWQ3Yk5YdXhJc3dxano0RDBhWEdJSVZS?=
 =?utf-8?B?OTRETUJ0U2FQQU55cHdVbVpNUEpyTUNwd1RpUUNFS3Nha2V0bDFsemFpOVFn?=
 =?utf-8?B?UUlWOUNLd21uVGN0TExKakVKcXdEOW11NlZaOG9hbS90RTRGUGZhWm5qNDZC?=
 =?utf-8?B?dmtCQUI0SnZyZitQMlBSLzhKSFovbkl1QXpRVGJKVDNieGRraWhwaXNsS3E5?=
 =?utf-8?B?eFFaQWk3ZCtOaFpwQ1dOeFlBbnlCbTR1V1NnSXNsYUtFbG0zWXFoc3p1aXlx?=
 =?utf-8?B?Um9idFRJQzhKNFc5NytGVnNGVTYyRlRsV2dYTm94Uld2K3E4N2xic2d3b3hy?=
 =?utf-8?B?NHNxN0QxTTZqbXh6cEpuWGdxL2hUYmNXNUY2RTRsRjBFNGRWVkE0OVV6RzZJ?=
 =?utf-8?B?S2tpMnIxWUp6SFgxQ2xXZlhrOTZHYW9ESXN1SytSWU1uKzFNVCttY0NCLzBs?=
 =?utf-8?B?dDk4TFFQYXpHYzRkeXdENDRpTFVyS3F0MTlvS25IMkR1b0tHbURYRlVpRDJm?=
 =?utf-8?B?Q1ZBVFNvZzFHMm84cWJ2TjFHMjNxQkgwdTJXS0g0TmFjdDZ3TTNpcTZqQllR?=
 =?utf-8?B?S1V0aFNvcmwyT2dpQ0xvUGgvVXVJcFprR1dGUmVNWm9LWmVXK3lKZUtGNEt3?=
 =?utf-8?B?Mm5zUzVjdStBLzVnSEVnVngrandwcDU1Uy81WWFHa1J4dS9QeklrNnhyWWtM?=
 =?utf-8?B?THZwT1lPUnl4aDQvcFp0RzgyVGR0aVhYWlBzWmxUemRtM256N1VTYWZtNmpo?=
 =?utf-8?B?NEFyR1JMLzYrYlQydEdwUld6ZklCb0JTQ3N6bkZoV0xocnJlN3hJNzNZQ1JV?=
 =?utf-8?B?QXhVeTkyUjdTdm9hdTF2MUZGVzZOdWc0VGdkNU9sZzI2RGcwSkdxT2Y4Z3Zh?=
 =?utf-8?B?VDdvTG1RdFozVUV4RGQ0eTN5dkhSNG5tbFd5ZlRVaXVMRklwSXJzQ3JUS2lN?=
 =?utf-8?B?V1dJWnNEaHN0SjlKcDExeWpBWUxyV0w3UjdXNjV3UFhDUkxmakZyS1MrQVRh?=
 =?utf-8?B?eXdUalVXcng5MysxM3ZWNjFlOW1TNVdSS0JOTDQwT0dOR3hvVSt3Ujd4VXZy?=
 =?utf-8?B?Mi9nVENiZ3BxNWZacEFyaEQzTk5nUUFTZlRQWUZKMEVrNi9XRVVVYm5xMmht?=
 =?utf-8?B?cXN3dERNUTYyb2lWcWxRSlNFd3NRcE5PU1J2SmRaeE05ZkpWRU5ONDk0K2do?=
 =?utf-8?B?Qk5wd2tVSko5SDJhdWdGWFlvK3ZJV241c2FvVC9seW82ZHQwMXZTaDA2Y1Nw?=
 =?utf-8?B?OWdqOXdrQ2k0VC80SlFpelBsOEVDSVNDd1h5b1dleTh4clR1RGdaQTlFUDhl?=
 =?utf-8?B?YXp0SkNhemwyK2pkYjhjSFVDYzNDOTBqdDFTYVpQbXMzWEE5d2R6UlBBMWdD?=
 =?utf-8?B?QVd5Wkp0aEwwWUIxTm5VcTkvTzJZMzRrL0tNVzA2dmhHMi92VzdFLzk3TlNx?=
 =?utf-8?B?eU9LZElkU215TU9hUkdTMjV0VTJ3Y2JDUVFudEtvZXg3MGwwc1ppcWZnZ0Nx?=
 =?utf-8?B?Sm8rU3JDaTdNb1h5RlFMQ0ZOeGZtQXdEd2dOMEh0aXRPc3FOTnZVZEFCS2tY?=
 =?utf-8?B?cTdocTRNc0hBUHdhMWhwajB4aCtPSU9oZy9kOHhLekRXaEYrVElHRnA2RGhj?=
 =?utf-8?B?WjZPcU81MDFoS3NwbnVIeGZQUHkxeU1EbUg3bGl3V1NiWFVMWjIyRjkrVC91?=
 =?utf-8?B?TnNHTEhSQjB2dlFkd1hwVjVCZ1I2UTJibzVoemZ2MFErbU0yMWVZNUcxc0Fi?=
 =?utf-8?Q?E30w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72da29e3-e8fc-4a38-5915-08ddcde2b39e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:26:11.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8waFZee8m0mqhDDU/uB1Ryb8ywEny9NSa1dVoLvJMM4OCwtyGo+npJ4dz5AOHBJYmc24LZkOLOAKnasrxTvr/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7243

On Mon, Jul 28, 2025 at 05:38:25AM +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Frank,
>
> Thanks for your patch, and sorry reply was too late.
>
> > -----Original Message-----
> > From: Frank Li <Frank.Li@nxp.com>
> > Sent: Saturday, June 14, 2025 6:33 AM
> > To: iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof
> > Wilczyński <kwilczynski@kernel.org>; Manivannan Sadhasivam
> > <mani@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; Frank Li
> > <Frank.Li@nxp.com>
> > Subject: [PATCH RFT 1/2] arm64: dts: toshiba: Update SoC and PCIe ranges to
> > reflect hardware behavior
> >
> > tmpv7708 trim address bit[31:30] in tmpv7708 before passing to the PCIe
> > controller. So add a 'ranges' entry under the parent bus 'soc' to map address 0x0
> > to 0x40000000.
> >
> > Update the PCIe node's 'config' and 'ranges' properties to use the real upstream
> > bus address.
> >
> > Ensure there is no functional impact on the final address translation result.
> >
> > Prepare for the removal of the driver’s cpu_addr_fixup().
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> > b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> > index 39806f0ae5133..2a18aa93d4723 100644
> > --- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> > +++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
> > @@ -147,7 +147,15 @@ soc {
> >  		#size-cells = <2>;
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&gic>;
> > -		ranges;
> > +		ranges = /* register 1:1 map */
> > +			 <0x0 0x24000000 0x0 0x24000000 0x0 0x10000000>,
> > +			 /*
> > +			  * bus fabric mask address bit 30 and 31 to 0
> > +			  * before send to PCIe controller.
> > +			  *
> > +			  * PCIe map address 0 to cpu's 0x40000000
> > +			  */
> > +			 <0x0 0x00000000 0x0 0x40000000 0x0 0x40000000>;
> >
> >  		gic: interrupt-controller@24001000 {
> >  			compatible = "arm,gic-400";
> > @@ -481,7 +489,7 @@ pwm: pwm@241c0000 {
> >  		pcie: pcie@28400000 {
> >  			compatible = "toshiba,visconti-pcie";
> >  			reg = <0x0 0x28400000 0x0 0x00400000>,
> > -			      <0x0 0x70000000 0x0 0x10000000>,
> > +			      <0x0 0x30000000 0x0 0x10000000>,
>
> If my understanding is correct, this setting conflicts with the address space this patch changed
> ranges above. Therefore, it does not work.
>
> 0x24000000 + 0x10000000 > 0x30000000

You are right.  Address map should only happen at pci fabic.

So we should not touch soc's ranges.

soc {
	...

	pci-bus {
		 ranges = /* register 1:1 map */
                 <0x0 0x24000000 0x0 0x24000000 0x0 0x10000000>,
                 /*
                  * bus fabric mask address bit 30 and 31 to 0
                  * before send to PCIe controller.
                  *
                  * PCIe map address 0 to cpu's 0x40000000
                  */
                 <0x0 0x00000000 0x0 0x40000000 0x0 0x40000000>;


		pci@0x24000000 {
			...
		}
	}
}

Do you need me send v2 for your test?

Frank
>
> By reducing 0x10000000 to 0xc000000, it will fit within the 0x30000000 range.
> And by adding the following to the driver:
> ```
> pci->use_parent_dt_ranges = true;
> ```
>
> the PCIe will work, but this setting prevents access to devices located after 0x30000000.
> Is there any other DT method to avoid this?
>
> Best regards,
>   Nobuhiro

