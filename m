Return-Path: <linux-pci+bounces-40930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC5FC4EF1A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 17:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69C714E0805
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDC736B06E;
	Tue, 11 Nov 2025 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HKIeSa9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C619369977;
	Tue, 11 Nov 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877420; cv=fail; b=lwRrn86iCl99pRt0iBqflkE9ykBmlJ72WsDh0yxTWC7WHCoQy/yc7fRlvMFSoXJA6GXQszu4TtokuI4Yq+a/XqvI7QxnUc7XS+RwXhlPihvc6qSO2VOuPwUXDVPz4NUWzfkmv3rmZrCB7/0P+JDaxb+KNUSUjCT6mGAs0f8O4Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877420; c=relaxed/simple;
	bh=7C1XpeoR3HRElqDvtUtb9nen1EOk21xlDXRjvDxH6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XtQXcb5k0EBs5WyGOx/puubaguzCdNvsEZTXNXKF+Zz1P0y4PlLBqwo8kvwLhECZUth/xVvTStmqL6OPgVGved2zaIX1kagI0O2CGGZwJc0AowWFIv/0vtMdWoHM085RAbfi1qaywikzEcFvaW2738xjEsq2700KDyn+kTZSwoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HKIeSa9h; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbSTUnLZcact0RxpPm/NQ9saSb8vftFu1xhUxK0uKcy4x2OHKJJdCzIhXYkv3IQ/eZ8kRFlrWzMlUtUbNJUwVHNiUPBqvuNxq0zreROrYq5OXYfAVGRjLnSgdOINnFqUbYd70lRdJADJe07Ro1+Y9hHVn8ZNerTNLeOdcnzgG8anJSa8Oz/PwV0xTbe5Jae2UgA/tC9xF8XCquuXUM0PQMFOnzbCepAPeyL5xs8DFgvyaCJJWfzjoUfVGhB01zOGe1xxGYI2kcsMJSW1etRTLLJY2JgrC4Dq6U9/CL9u41hSzKUG9S09lxoJkzHITMWMZrP/0gvXImsgfJKH1cnq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=988ryDKCTovb5NwR13XM8uBg44q1yn4y50Nyc67JM3s=;
 b=Bhh1QY+m1KKasUq6zFW7+Idk7sINnUqgcIEguLNR2vUZ72MEwCAwDUOQwl+TjfUP+zv2/2iWLZf6noUZtp7qTL9/v/g6QEJ1+DNtxkI19ellkR8g/fJ2pcs50rN3PX7HYjmN41+COuur2TFq/n7S2afXCJudLt8RhL2hcHVgp1V9S9KtDvxU4mpuIqLegzRq8uYhVIavXra8PiaL6qJHW6KdUQv3bgaAJdjyB4s5NEICMaZYfej3wJWdnVVz9mq9bW+jjec5xHF3+FkSMsxJsiM3ErTZNILlRYbbjgQR7AcbZfJQ8sVOrid/8KBcqce1eQ1kG9bBkmdg7HZPzigUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=988ryDKCTovb5NwR13XM8uBg44q1yn4y50Nyc67JM3s=;
 b=HKIeSa9hdE+2NAqYESGa3DyQ7TOABrr3ALavphUlLoZtMaX8MHnSjqO8Ivde5qvEUCymVG7jULRABxm3y7ipv+EqiWUHewoYhTOe9hfqKocquh03Qt3nQaU9v4iV9mRXvLcXFSnC+AhYno3Uupx/IUfU1+DbeXehKQ2EBDCoG65/ON5anrTnabYifH8gt45zclcuU6StIhbe02Q5s7mr2pRCKJgaZraR8205wJVcNSxU4TbITSzQyEKzV+plrn+dTtN9FFTiqkp+GHLmWrv9aRPBDVppl042tWetUYPwbEDH+L5hdl4T7uoHZtb+yD/fCdjfGIXo5ie34OUbjUBCPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 16:10:14 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 16:10:14 +0000
Date: Tue, 11 Nov 2025 11:10:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Shawn Guo <shawnguo2@yeah.net>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
 supports-clkreq property to PCIe M.2 port
Message-ID: <aRNf3TUTawixqGR1@lizhi-Precision-Tower-5810>
References: <20251015030428.2980427-1-hongxing.zhu@nxp.com>
 <20251015030428.2980427-2-hongxing.zhu@nxp.com>
 <aRLhko0h1OZgvo2o@dragon>
 <AS8PR04MB8833D099959C62A97AC8CB868CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8833D099959C62A97AC8CB868CCFA@AS8PR04MB8833.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b28f7f6-937e-4f1b-e43e-08de213ccc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXVsL3NMblNVTWpGLzRFTjQvMk1pZXM1TTNWS1ZOeFZraWNDSktKaEtjM0Nj?=
 =?utf-8?B?Q0pjdUVFL0l0TUIxaHJkbmdVNVFaR205Y25TWDJOdk1qZmEyclN6V0JrS2hG?=
 =?utf-8?B?WWZyWG91cVBJNlZUNENQOTBxTE1ZYS9hWVlYVEpUbUtqcXo4dVlCYVNQdlFa?=
 =?utf-8?B?THhoUlZSdHNQUEVlWVlISno0elYvVHdJaEpPNHhYR3NObHVBTDBYVmZ6SU8v?=
 =?utf-8?B?K1JKVXVsTHBGMzg3dExOMWdJd1FxeDBUNUJGRFZBZUJTUlMyaGxMcjBFZmY1?=
 =?utf-8?B?ZlJyUGt0RUllTVhkQjlGRURxcVRENHFEc0tERGRTK0FZZjZ5MzV0dTB5Rklr?=
 =?utf-8?B?RTZONXN6Ukx4NWIxVy9XR1NJMkd5U1JPOERsbWV2VzZ4bmw2Zy9ER1hoN2tE?=
 =?utf-8?B?MnZ5ZmhMdk5hTHFKMUlBazhueW9PV2F2cWc4bVgxUys1NTJpbG1CeTJDOWdl?=
 =?utf-8?B?bUZDaDd0ZHJaL0NyMkxSVVgzRzQ0ODdTZUdXRXY3REFuSjVlQUlCaVVvNDRO?=
 =?utf-8?B?a25IT0FTeXhRY0lVRzdMWEduM2VDUU81d3JTQms1U2pRbFlmODdldUtxcTNy?=
 =?utf-8?B?NlpPSTRETWpSblE1UytHMWZvYU9CM2dLUTdDM25OSFJCVGZRM2pnMHFZUEI0?=
 =?utf-8?B?aHkxcFdCVHBPR3NORTIvRWJieDQwaU9Nemp0WGVqem51bmRHVm5XckFScVlD?=
 =?utf-8?B?aUd4TEFuZmpaVVV1V1N0Z05HN1FHZWxLd3lDcXBzSmNkUlFxckRVVjJVZ1BC?=
 =?utf-8?B?SUJBeEhpc3d0SXUzbUlsdGdxUDNQbHhQZlVvV3JZcUpKOStNM1ZOTVQzU0NT?=
 =?utf-8?B?UWxIcmZ2ZDlvNHRBemZnMS9KOCt4bEp6ZUg3b3pGQ0ZwLzVDdjBEQUhoUkxi?=
 =?utf-8?B?ZUxaTGJBb092c0l4M1F3UXdLd3ZMN0R4dFJTZFJDOXEwVUUzL0dnSmZMWXhZ?=
 =?utf-8?B?Y2VFYS9pOFhSelQ1Szl0OEFFTkI0YUxlZUYvSVU0TEdSUjRqWUo1clpBVUlW?=
 =?utf-8?B?NTVsZzd5TlRFbEM0akpsVDdOUnRBZXRIdFc1Z0JMa2hYdE91M0dHS0lweHRz?=
 =?utf-8?B?U2NpeC9NanBUSnZtbnpUTWMzb293cE5FeVppV25SdFh1czJZOXZER0FpOC9s?=
 =?utf-8?B?bHB1aVMwZUNkdExTRjlFQ001MnlpQWJ3OHRwa1dyTnQ1Yk5GMkNYcFJ4VXlz?=
 =?utf-8?B?U09teGZVaWk0ckd3cU9sc1Byek93aDB2OC81eHJ5a0poVTh0QTY5c1U5VVdV?=
 =?utf-8?B?SFJVV1dkZTduMXhSYVBHR2JxblkwRG1KN2NlZHRtNDNSY2xxNjFSQkkvV0tP?=
 =?utf-8?B?K21FaEYyd0pjT3NlUmlDOUpPSVR1K1FVTWFNYldGejg4OThFQVl4bnRSTGM4?=
 =?utf-8?B?ZjNCMmxiSXBaem8yQWVFSENYcHhQRkdrR0JpY2hyQ2p5empKem1pUGpRQnRC?=
 =?utf-8?B?RTJLRzE0U2pxdHhJL1VkR1VQU1VwUHZwN291aHFHcVJVYnNYTXVMVDVkOHlq?=
 =?utf-8?B?TFA5VTcrcEY5UTFmTnhXRXYxV3VsemJjeXorTmhlT3phd25rK3ZrUk9VbzRy?=
 =?utf-8?B?WVE1N1JGVmZxQkJmZS85bmM2enk5Z3pWU0Fxa2p5L0JqWlB4R1J0TFVGOHZn?=
 =?utf-8?B?Q29IV0Z6aWNQRUhwcUVLNFFtV3Z2V0FtMTl3VmNEVng4cVA4MjR6SnozNStz?=
 =?utf-8?B?RUozK2grc1BJU3YwVFVCRm5NZHQrNXpITU04RmtEZU5VTkwyVFhYVTJtUURO?=
 =?utf-8?B?aml5VEEwQVVvSVhIZTlTQmpHc2liNzVnZ3dYUDRFTHo5YUIzSXlqZDNUc1hn?=
 =?utf-8?B?bUN5SlA0RWQzbFF4aGV4YlFsc2RkOEx0MXhycXk2UEc0MVk2RTJ0V2xQdEtM?=
 =?utf-8?B?TlRJWlVLTldseWZJZytwM3FScUltNEIxS29CVGNDVEEwL1BlK3BQY3dNMFNM?=
 =?utf-8?B?c3hMMzg3dGthdXArT0J0R25XQi9UTkl6NFcxVC96MW4wU2pzQy93Smp2Qlpa?=
 =?utf-8?B?VUlzN0x5RFZUWTM1Zk01UHQ2Q1p1ZFRZVzNPTVEzNVVkSU5IODFNRW9GL2Yr?=
 =?utf-8?Q?n2nZK7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWJtUUo2a0diWnY3ZFJ2Ui9wcWVESStLYkhoZlg4MEF1b2ovb0FiWnFDZVkz?=
 =?utf-8?B?dnlLall3ZmJZOCthVnJqeXFIblBtM1JWM09vUFFpaXVBUVdKTTIxUkZMU2NM?=
 =?utf-8?B?VEZnb2dTZ05JdE10Vlhic1hOelJpRTlka0hSM1BKeU9ESmwyTmh0b29YbHZi?=
 =?utf-8?B?UXhtaG01c25oNW1McFNteGl1QkNkcTFseFRHUFdIT1A1cjFsOUlETTVXeE5j?=
 =?utf-8?B?T2lTcEQ1TVdwVHVpSUlldnhOTGxCRmtQZ2FiSkpaS0R0RVRxZnF0SVEwQnRi?=
 =?utf-8?B?R294eFk0YzVwdWNtQjFQY0ppblhyaWpzckh5NWMyMCs4N1BRRWt2ZHZGT0dB?=
 =?utf-8?B?TFVEbXQ5d1RlYXhNaG00aWNyYmxITXRxenhENVdwajRtdFFoRzVPUVluUlU0?=
 =?utf-8?B?QjBQZlVKeG9rL3VEdzFFbFJldW1FbXFhOEF4T1lCM083bGZ4d3dybnVra1ZR?=
 =?utf-8?B?eTdyK0MyYzVvR2J3NkdCM0N6NGt3Q3M3MitSUEtYWTV5NThaK0Y3M1JWZVhi?=
 =?utf-8?B?Q0VlcmJmUFYxRlh2ZTYxUjJ1NFlGYnlmd2E3dm9uNUw4RHc3cUFLMlV6b1BZ?=
 =?utf-8?B?UFJCdko4aGE1VDNYQ25JUzlRc0xNS05uZnBNdUNma3gwcytIdG9YTzlxTTFY?=
 =?utf-8?B?UDlQN1ZNOFhlZWtYZDdwSjg3U2sxckYzY0ZzdE5rdC8zNkdnZzJycjgydDhY?=
 =?utf-8?B?MFNCeFUyZE1oRHdUM0thRXovY0xwMDVuRjJuSS85Y3BueGNxb0lLanRXOWJN?=
 =?utf-8?B?elg1OWl3UkZYaUN3bzJZTUIzM3NiMVVIaGZIUkcxK3JibkZic0EvWDR5UktR?=
 =?utf-8?B?bUcrTklLb0ZraWpTdWkvQXdiTm1xaU03Z3ZJQ1MxSkEwNWZVVFI2eDh1cDVL?=
 =?utf-8?B?NzBsREo3TGRDTTRIWVJXUlJ2OE5uVGNDZ2I5QWxBTE5iL2V3ZkdSN1g4LzZR?=
 =?utf-8?B?ZmRBdEtOQjJhWkFMNm9ya3IxOEZOZ2hTN2tlZXo1K0VUUFJMenBhQitOYmhK?=
 =?utf-8?B?YlF5UXdFd1c1bmFtbXB2TkErM2k1aU1nc3BhQkdPTXlXay9YUFVCTDIwNGpI?=
 =?utf-8?B?dEpVdzRrbjZyTVI1YW96eldjOC9DNUZkUEROcm82SXV3RUxXS080ajI1T25j?=
 =?utf-8?B?QWtYQjR0ZUZWOU1GME51a1BSYzhLaHdVbkFxbTQycjkrVFlab2RCUDVjQkNC?=
 =?utf-8?B?NFVVZWljdUZiL2htK0hpRzdwL0RCVWJTSEpJRjBhTGQxZ2VReStCRTRaNGli?=
 =?utf-8?B?RE9yWkxDZjRTYndVckE0YTJ5a3JQTEQyNWdMNnQ5YlJ4cTZlUHdoTlB2K0hn?=
 =?utf-8?B?M3BCOVloT3FSRU5CR3o2MkVydmthVldsSXlCSFA1RE1yZkV0TEtNZU9Kc29Q?=
 =?utf-8?B?dEViQmJnVko5YVJIRFhPcVM2bEUrRnd1SllPR2NkUFRUY0VXLzJmbXp5a2Ja?=
 =?utf-8?B?TmhHbWhvbGxsSjBFaWIyb1JwcVhJMk1BTGsvU2l0dmQ0T2dmODdwL3plT1pB?=
 =?utf-8?B?OW5aNCtmYS9OeEIvdU5ic2RCZGdKb1VBQ0dXVkVTVXMxbDE3eVRldFFubHN0?=
 =?utf-8?B?cm5nQXVjYmJLS24yZ21QZ0xMK1U3Tmd0Q2JVdmJ5RGZENFJtRkdheURvT2N4?=
 =?utf-8?B?T2x4UHJROVErM1dodm9NeXNTODdSbDc4cnNlR0JmZklCYlpwZkVBaVBPRm1F?=
 =?utf-8?B?MGgvSVJiMEdReGRwUDFYQUY3RGlFL2NhclhLTFkyZ096MDY5T2NxZEtTNGZJ?=
 =?utf-8?B?YkJNUzAwZHNYMFQ2NEtZdGQ1RjF5Lys2dGt0a1IzNE9FenVnbk1CVzRqZGhR?=
 =?utf-8?B?dXpXTVdvWHBpOUF2emhXU2tlSmVOb09BYzJDRG1wanZQOW13WGdVeDhheVVK?=
 =?utf-8?B?SG4xdCtsb0hTckppOGQrMFJwTG90enlHSjZUQTVna3VVMUthODNQeGgrSXUx?=
 =?utf-8?B?NFRqVUoyeWFoSmtMeGFWS2UvSytTd042bWVqQnl2MGVVVkZEaCtjS3lCdVNI?=
 =?utf-8?B?a0pTdHlidTNBcjRIRkk1eGtoKzNuZ3VKeXBzSVR4SDJhdThmSXVWSnpURjVz?=
 =?utf-8?B?ZTdSWVBTd2V0ZW5HZmc2RzljVy9KNXRkbzVIRFhpQXdzVWFhbXhiaXQzRmN4?=
 =?utf-8?Q?ozcG3THxZowreaC5NgaZwCVo8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b28f7f6-937e-4f1b-e43e-08de213ccc84
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:10:14.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Kh4GPjgIPBJ7AW/TAG/rhyd4S/UuRa5Vh6hGGz54bKbN1V6FgSOIcqLsBJvp48nawG/Fm6bznYOXGvci4+lMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

On Tue, Nov 11, 2025 at 08:02:35AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Shawn Guo <shawnguo2@yeah.net>
> > Sent: 2025年11月11日 15:11
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> > bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v6 01/11] arm64: dts: imx95-15x15-evk: Add
> > supports-clkreq property to PCIe M.2 port
> >
> > On Wed, Oct 15, 2025 at 11:04:18AM +0800, Richard Zhu wrote:
> > > According to PCIe r6.1, sec 5.5.1.
> > >
> > > The following rules define how the L1.1 and L1.2 substates are entered:
> > > Both the Upstream and Downstream Ports must monitor the logical state
> > > of the CLKREQ# signal.
> > >
> > > Typical implement is using open drain, which connect RC's clkreq# to
> > > EP's clkreq# together and pull up clkreq#.
> > >
> > > imx95-15x15-evk matches this requirement, so add supports-clkreq to
> > > allow PCIe device enter ASPM L1 Sub-State.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > index 148243470dd4a..3ee032c154fa3 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > +++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
> > > @@ -556,6 +556,7 @@ &pcie0 {
> > >  	pinctrl-names = "default";
> > >  	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > >  	vpcie-supply = <&reg_m2_pwr>;
> > > +	supports-clkreq;
> >
> > Is binding updated for this property?
> >
> > Shawn
> >
> Hi Shawn:
> As I know that It's a documented binding property as below.
> - supports-clkreq:
>    If present this property specifies that CLKREQ signal routing exists from
>    root port to downstream device and host bridge drivers can do programming
>    which depends on CLKREQ signal existence. For example, programming root port
>    not to advertise ASPM L1 Sub-States support if there is no CLKREQ signal.
> ./Documentation/devicetree/bindings/pci/pci.txt

Shawn:

	This file should be removed. It is already merge to Rob's dt-scheme
as PCIe standard properties.

See: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml

Frank

>
> Best Regards
> Richard Zhu
>
> > >  	status = "okay";
> > >  };
> > >
> > > --
> > > 2.37.1
> > >
>

