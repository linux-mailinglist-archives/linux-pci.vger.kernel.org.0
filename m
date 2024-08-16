Return-Path: <linux-pci+bounces-11774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80046955147
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 21:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9724F1C21AE0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 19:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3409A1BC090;
	Fri, 16 Aug 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="moVLPBp+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB16F30D;
	Fri, 16 Aug 2024 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835842; cv=fail; b=d1N057M23tHOXzJjLLU9woBPIrItPZYpgNkqhaoELeXqvVWcnu8wKoV5wbZXfD7ZMLKfDEjDstGlpmSM1nAZkudvmIhC+oTzq8LMb+pQDB/H+/QnipxSgSK5oquGHG5EHYMewpCrScKWhWj/80i7S3I+CUtrMbfVbdCxlSZxRH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835842; c=relaxed/simple;
	bh=8fbxtNOsZtB2bGjMA9I3LMzj9nAhVVTyF/ilw9ByAaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CjmSxbiF7B9997CTFMMSSi8aPlNW4VTaVaXpbJyN59bSiN0dMWQYmT5qd75527nDjrtZRysgjN5jo9kuM/0Qt62O23kwaMPTtBv11TDKH+38gbZ02oJK96M6nOjyaOsL15T8QP+rAa6NIlBk6XuNgikI4M93m9g56TBa2NI9YjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=moVLPBp+; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukunu7HXQmffM6ir+LnQGUpze/twMpp5gbus4sM3N/cGF3KPkMZjUZ3t507g6IkAruSewOugtXi/Y+FZVwhyl7jIqgPQYpn3M/P3HmhTjK7Hf/Z6Z3TCOoDY5j17wqwTn8IS/AVBfnMmmkLh3SZEc71i+OzqsH4j5RK0ycQNQCbZIVkydMBUpoGIfrkhdBfBy+laC4MIRRccGDKvsx6m/fUKftAbEy3YJLi0+sbGfMHEt8CYLNxC3f6kcu/fJmPJu5yUgjjTsvMoXMdgiEF3vLVAT3B3ZIOVuebxqRBx7OmVthWomHZFTYGkEaUyXOVXmpnU8LkLXkCEdB8qc7T9jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNKMdbqNFgv5k5CXcAHrO321d3+f6vN5KNDZJ/Nh4To=;
 b=y0XcMub0S4KdfdgwP3hN1rzmINTDXFeRCxhmeDaj15h6rZUjpIQjCOI67Mu6poiGkiRkg7zlpeZmpgZOM1FD4oiiNWhYQ3NzC8upIVGLNc/DUoketdx+Njz9PtTuimGSp/Xh5zP9zMQaoV649uCHu5l6/twvj4YLM3n+Pihwd/dktfJkp4Ff1WW7fErtbznhCAvrbzS5EYhnR6w/kP86t9WBIoTtbx8/x2wpEWdnpcCc+jE8LzUc2WMT+NwkZqsOtXbE2iIBbrBX9Tl+ux81ozWjy8oE7aJhANNYYF/AURQdvehNWPhAdhmO3YompVP5EtU3smpnCZ5mhDL1ngEqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNKMdbqNFgv5k5CXcAHrO321d3+f6vN5KNDZJ/Nh4To=;
 b=moVLPBp+AOvvdVXAjz859BsXnBkE18XUOQJGqPgfV5RF4iUT4Ec/DIrfIjptwcWk3EsUopos19ZflQo2UxH8u0z6PfWacRzxhfT6BIG3YYPw6nPvEKOa+Bz8xbkwKS4HRmM4Ml8kxhz79HQBnYkIV6KQYp5xky/06qR72u7tYgRCO7bcSvJSmXlFqY7lpY4jxXor37+L5RPH0nE3iTskwZN2CRLj9e7qqyyquhNEpUspJIPIf5NQTa3wTALfNhsZEFi0Va8rqp8MCwYqJmmfwebTj6f1qUyy+LkjKfI7/2tTtjVnAGSwpzzSz188NPk3lRZvriPDtAymD1kMKSOxXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10772.eurprd04.prod.outlook.com (2603:10a6:102:48c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 19:17:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 19:17:15 +0000
Date: Fri, 16 Aug 2024 15:17:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Olof Johansson <olof@lixom.net>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] MAINTAINERS: drop NXP LAYERSCAPE GEN4 CONTROLLER
Message-ID: <Zr+lslEn4cfBJ0A3@lizhi-Precision-Tower-5810>
References: <Zr+H3gHZ/B7zTKBW@lizhi-Precision-Tower-5810>
 <20240816181500.GA69082@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816181500.GA69082@bhelgaas>
X-ClientProxiedBy: BY5PR16CA0029.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10772:EE_
X-MS-Office365-Filtering-Correlation-Id: cab3536f-5cfe-4ebe-ca06-08dcbe280991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGxIOU9SMnBMTEN1d3ZtRUMxN01sWkw2K0QvU1BMRnFNWXlUeDVWQVFTQ1Nv?=
 =?utf-8?B?VlFLWGZtZWlkOWRxWmRvWUhjOGh4NHdOTVBtTkFya1dwSG9nUFJMcFFiNDBj?=
 =?utf-8?B?cGxVQU91UmRIcHBHMVdHakIvbmYxYStHL2N4YWtHVExvVThyWVBNcVdhc3pG?=
 =?utf-8?B?T25Zb05oV0llallBWmpvbFhqK0NERlNnRVJicG9tOWFEZUFRT05mRDg3dkhi?=
 =?utf-8?B?bFcxWllpQm9NUlAxYW91NHM4WC85TUd0b2dFK0FPV1hMNmI0SnBmSXlKRlZr?=
 =?utf-8?B?QTgzQXZ1VTlMQzBHeEJxODZuaXFFU0RpLzVUZ0lxT1BveUNHcTMzREFtdmpU?=
 =?utf-8?B?WStXV1NqNVBYQkRqcyswL1JsdERYRGZrT3hlUGhHUjVEK2E0WGVXc2JXZHJC?=
 =?utf-8?B?QzZ0Mk5yeXErSERCZjdFOUNaYmtqTXlLTllabGhOckxselM5bUUwWVNhbXRm?=
 =?utf-8?B?TG5IZkZSN3BsSDdMd2dOSGFLWDdJYlAwZHpqTUJ1WDdzajNjU2lYMWhLc1Er?=
 =?utf-8?B?UlBnUHh5Q05leWdrdDdYNlVLNmpCbFFmR2dJYVdiVjhmTW4rNldRVk54cnV0?=
 =?utf-8?B?WFN5cEhuZ0J6RWxDcU9QRTVvM1FVRXVCVkZtS1lBU2tYSi9VN3gwdzNsa3Ja?=
 =?utf-8?B?QTljSE9wWGhEc0tQeW1LMWsvM3ptL2FDRmNwdmw3VUxCS1l0YzZKT09ja3Ji?=
 =?utf-8?B?TE9DRkkzVVNBN3pFRElLcFptaEorS0R3a3NlcFRjU1dnVDA1VjZ0TlhrUld5?=
 =?utf-8?B?R2JyNkhtNStLZVNwMURpZ0JlSVM3VzQ3aTdXSlViTHBXMnVZMGVNL2UxTDhQ?=
 =?utf-8?B?TllqVk5sR1NMZnlmeUN3MmFSdTdYK3pXRm5QUWNTbkw5WXBaSHJYek5SV0wy?=
 =?utf-8?B?RjVTQ3pTdjNGQjRuWG9FM2lCdXpYOFlNNng1NTM4K1pwYlpiWEd1YjViSmhP?=
 =?utf-8?B?UkhQTVgrZHkzU1p0MmxWRlgwZmJpbnlpaFNaSHh6Mng1a0JNNmNxYzEzNXZq?=
 =?utf-8?B?OUtRdGI5WUh4K21wRThuT3lxZmhlQkRpTDRZc2gxMUwwUFFYT3dWMDFBME1h?=
 =?utf-8?B?UU5ZTlVrcmdhUG5KMVFrYk1HRXA5NGxkWTNrM3VPYnJ0L3ViYklYYnRZVVY3?=
 =?utf-8?B?WDRnM1plN1VxbldOUE9KRlBCS0pOdUg0VW54RG9JUjdka21TNVJvK0pjL1Aw?=
 =?utf-8?B?RnFHbjdKZUtYek1OcDcvdHM5OU1UY3pNUW85MGFkTHNldHhWaHplVkYvZG1p?=
 =?utf-8?B?MTYwYUJMOUdXNUo5NmJ5aHZBa01TV0lBKzNKTVlJY0VLRkxyeStPUzRyMVNS?=
 =?utf-8?B?WlFNZHZEVkpOajdxZGdrSVhwaUtRWVBYQjBCUjVzNFlPM1ltTTVXT2JNM090?=
 =?utf-8?B?MVhVSlpwWlJCbE5EZmswOFp1UHVGa1cwaWJWejhubnZaOCtvbk1sMm5telhz?=
 =?utf-8?B?cmV4SHdWajlHbytPYWJ1S29tL0hzS1dqNVYxcXM4K284Q3lCT2ptQkZvQ1VO?=
 =?utf-8?B?RGJ2eGovYTlmemdEQ1I3VVlxSEhhbHF6OGdTck01QmV2YTJSRCtYL0w4ZVh1?=
 =?utf-8?B?ZTNLSGtwcUNUMExsTExBQ21uTzVFenRoMTlmVTV5RmYyZTd2d0dJbU1BN0gx?=
 =?utf-8?B?d0M5WmxmZWk0aHZNc2pSMDNMMVMxL0RlSmdUSmFEQ2V6YUdlOFpwellZOEhP?=
 =?utf-8?B?cnF4S0hjT2lWeEJOSEFqMU5lVFBHcTdoL3JGNm5yWVFtMS9UMUl3N2l0Tnhq?=
 =?utf-8?B?WklHTndTcTRsdWltUWJ0c3BGb0pwOWdveDBHdUxUKzlDRUtWWUpycHlPemZK?=
 =?utf-8?B?T3R1RFpYTHRpdUorWkt1N2pBS21McTgwSlhwY2E5QXdFamppYlhTN2VWNysx?=
 =?utf-8?B?dEQrbm4rU2kzNG5GZFl1cGZXcm95T0h2WVpiallrTVU0cVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjllbUpUWlBjQ2Q4eEh4UklDV3ZWVjFMWlpHUjRoQVM1Q3kvWld4R0hyWmxJ?=
 =?utf-8?B?UkpoWUkzS2xVY2lrZ2Y3aFIvbzRIblVYeHNhK2Nva2VFYzY5QWJmcXNybGx2?=
 =?utf-8?B?Q3poK3g0cUFWZ1k1VEkxTmtaNU5XSTN0bTBFMGtrVmQwZTZmbnpkWmdMZEVu?=
 =?utf-8?B?c2MzM0VXSmtKeTF4dHg5bnVTZ3IxMG9vUmhmb1ZDWVMvaWR0QU1sL2R6TGwx?=
 =?utf-8?B?bU1UQkJCbTNoUEo3aE1VWGlOOGt1Q3F3ZjRKZFNkTk1hNXZnVmJjbTd5US96?=
 =?utf-8?B?V2R1R1krTmcyL2crR2tQTkRjM0Rvdk5FTVJZRjZnVkdaZ01IOTYzUjJpZDJT?=
 =?utf-8?B?Y0xQS0ZGaERlZE9nYWxxaU5yb0ZHMytVSFA2YjFib0J6NURmcGNrdk1xU1hC?=
 =?utf-8?B?cjYxZkhCcEREZy9JV1d6bjZLUUVZdUxTY2FRYjVIZ0RlK1FNNE0rT2Y0WFBw?=
 =?utf-8?B?em9lUExCM29NZEdEaGQ5aFpvNDFicHc5N1RUN2gxRG9uZ3FhempsMFFJL1lM?=
 =?utf-8?B?OSs2SUozVFJlUW1ObFlObW5MVmRnSlZRMmJCN20vaUhqQlVmU0l0bUdmN2xD?=
 =?utf-8?B?aExoTlhubHd0akZVR01UUTdCU2VkWFJML0V1RzY5ZjBOaklJUkdQeUQzQzlw?=
 =?utf-8?B?YzNtODhlZFN6SC82UWUvZ0RNdGt2M2QzNTNBbjVXdEQ0ajFKLzhjUjgwQU5w?=
 =?utf-8?B?b0d4alI4WFlNb3FWZEJ5MDU0aURBSDlZOVJXU3B3MjNaTkltZGhxOUlFUTA4?=
 =?utf-8?B?NmZaZE9tMDNROFh1UGdHU01LaWlrQTBrMUkzYTZnRThacWdmZGM2dzluZEZn?=
 =?utf-8?B?MThsNVVMVnJVcjdCVEJQN25NWVNHbksvR2gvWW91L1lta28rVjVzdzMxSFpS?=
 =?utf-8?B?WHAvRWltL3BBTHFwMS9yL25IVnpLQ0JiQkhWamIzWjVsbGR3SUJIbVN1OEVo?=
 =?utf-8?B?R0lIQ0svZjZHVkxQVFlrMXlqcGxRSXJ3Y2JNQktCQU0veDJkZE01OExqUzhY?=
 =?utf-8?B?OFQvUXRlYWJYNTBKcjNSVmNGY0hYNFZweTZUM083Zm5zNEhaSVlwaGJLSWEw?=
 =?utf-8?B?MnB2RnpSdE1OMDRBSzJBTkYvYkRIVFcxK3RwNnVmZnJrczRCTHc3ZHh3VVZ1?=
 =?utf-8?B?RXhTWWYvRVF2VHMvdGJ1MUQwaGFJQnc4WkVNWXl5QUJObmRncVV3Ky96dnk1?=
 =?utf-8?B?VzZNbklFWERrWEJKdllqdWxXUC81YXpwWUFVbTBjaS9QZHpWaktqeFB1TXdQ?=
 =?utf-8?B?Q3IzRy82VG5KRTRMUmJzQkV5WkFRdVlNQXJ6ZngvdTZuWlUvd2FNSUR4d0NV?=
 =?utf-8?B?aVNwZGJ3bDFPZjY3ZGFsazJrTU9KcFBTMjgza1I2YkwwK3Z3M0I2Q3BiTnph?=
 =?utf-8?B?T202ajY5dy81clFPd0tSVVBvd3VPcjUvOHdKK05TT3RwN2tNWWs2cStkM3I2?=
 =?utf-8?B?eUUyNEV1N0Rta2ZzcHM1T3NjSDFOdWNaQU5DQTV5VVlqck5adVp5eHF2cXNP?=
 =?utf-8?B?TnNQYk9Sak1wK0d1T2tEb1h4bVJkMno1RTYrZzZ5ZGkvT244b3lFcWZhUnB1?=
 =?utf-8?B?RG14ZWQrTnFBWjdwSEFReUorK00rVHpzclB0N3JQSkVGVU9RZXhKMHVHeGpa?=
 =?utf-8?B?dEYvNU9SL1Z6NVZyTUJhZVlzU2wyOTU5TnBDWElJNmd6bzg1dlBFZEd2Zk1q?=
 =?utf-8?B?RnhrL1hzN0UzaWtlNklRVkFVaENxdDdweGlLUFNlN3M4Z3NlbWRUYmUrZG5j?=
 =?utf-8?B?NFVsc3hzSXJBa2xHdU9KTytGVW11Yk45YmNpc251c0lZUFRQeWl0K0dvNEY1?=
 =?utf-8?B?NkxSVTBLd1RGSFptNnRRcEUyL1RkNWRGN0sxRUlxNjlxRW1JUHdvMG5wWlVl?=
 =?utf-8?B?VStnbVdZWEM1NVJzWnNDNGVqdTE0Qy9QaWpmaDFLNnEvYnFWY2pnMUFPZ0RW?=
 =?utf-8?B?VzZ0L2o4RW8waTN6bnFUMjk1eWlJN0Qyc0U0NzZLQVN5dWZNOFdFRHNJZlZv?=
 =?utf-8?B?MmlkaW9KbCs1emRCcExMaDM4cVplb01oajBhOUt6dGV2NVNQYUNzanFKZUM4?=
 =?utf-8?B?a3N5cXRXcHZoVCtyY1VsS09DNVFHdkJNWHZ0SkwvQXRKSk5Dc0ZmQlc1eEZ0?=
 =?utf-8?Q?7pog=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab3536f-5cfe-4ebe-ca06-08dcbe280991
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 19:17:14.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV1bPm9nBCGtdSxr4SPptZmfu7BMFjAaKwr6mQhS6h6tsvsGRs9ZmAt8vcF2vKwGhZ/gUvXIArwy3W1CX1l+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10772

On Fri, Aug 16, 2024 at 01:15:00PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 16, 2024 at 01:09:50PM -0400, Frank Li wrote:
> > On Fri, Aug 16, 2024 at 11:12:31AM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Aug 15, 2024 at 03:15:52PM -0600, Rob Herring wrote:
> > > > On Thu, Aug 15, 2024 at 9:53 AM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > On Thu, Aug 08, 2024 at 12:02:17PM -0400, Frank Li wrote:
> > > > > > LX2160 Rev1 use mobivel PCIe controller, but Rev2 switch to designware
> > > > > > PCIe controller. Rev2 is mass production chip. Rev1 will not be maintained
> > > > > > so drop maintainer information for that.
> > > > >
> > > > > Instead of suddenly removing the code and breaking users, you can just mark the
> > > > > driver as 'Obsolete' in MAINTAINERS. Then after some point of time, we could
> > > > > hopefully remove.
> > > >
> > > > Is anyone really going to pay attention to that? It doesn't sound like
> > > > there's anyone to really care, and it is the company that made the h/w
> > > > asking to remove it. The only thing people use pre-production h/w for
> > > > once there's production h/w is as a dust collector.
> > > >
> > > > If anyone complains, it's simple enough to revert these patches.
> > >
> > > My comment was based on the fact that Bjorn was not comfortable in removing the
> > > driver [1] unless no Rev1 boards are not in use and Frank said that he was not
> > > sure about that [2].
> > >
> > > But I think if Frank can atleast guarantee that the chip never made into mass
> > > production or shared with customers, then we can remove the driver IMO. But that
> > > is up to the discretion of Bjorn.
> >
> > I think Bjorn's request is impossible task. Generally chip company send
> > out some evaluted sample to parter, which use these sample to built up
> > some small quantity production. Chip company have not responsibility to
> > call back this samples. There are always some reasons to drop mobivel and
> > switch designware, it may be caused by some IP issues which can't match
> > mass production's requirememnt. Such informaiton already removed from
> > nxp.com. Only Rev2 left.
>
> If you're reasonably confident that nobody will notice the removal of
> support for Rev1, we can include that in the commit log and just
> remove it.
>
> The original commit log basically said "we don't want to support Rev1"
> without any indication of where those parts went or whether anybody
> might care about them.  But if Rev1 only went to partners for
> evaluation and we don't expect end users to have them, I think it's
> reasonable to say that and remove the code.

Thanks, I just find 2020 Yang li try to drop dts part in below thread:

https://lore.kernel.org/all/CAOesGMhz8PYNG_bgMX-6gka77k1hJOZUv6xqJRqATaJ6mFbk6A@mail.gmail.com/

Olof Johansson raise concern about their HoneyComb.

I added Olof Johansson in this thread. I think HoneyComb use evaluation
chip to build some small quaitity boards.

As my best knowledge, rev1 should have some big problem. I can't find any
detail about these because rev1 informaion already cleanup totally. I don't
prefer continue use risking rev1 chip.

Frank

>
> Bjorn

