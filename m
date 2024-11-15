Return-Path: <linux-pci+bounces-16913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A49CF324
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD1EB2B1EB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915E1D63C9;
	Fri, 15 Nov 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RCFcUxxb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A122187561;
	Fri, 15 Nov 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692327; cv=fail; b=dgUFaQ0b8ylOR3q8UdOzEaYyN8C/M46xgVJz4yd5dC9JXBfDCWhJWAUxGQiwWMGNeB1ldJpUS+jMy8AhLYEqXx3C3rT6eCVN+T7Tig+yGUsnemoQpkK/39waaRMrX1luAsE1H1dW2iq977soxwTFSHIC8v0x5QO205yq24AU5hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692327; c=relaxed/simple;
	bh=3sdoKDM/g59u9W92EuaGzvL+1WBb8QSkzI6BTHk/ZwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tqcjA0qA02B58ClVvIJ0wp9fH87BBrtJzuGjwD/2ohYwwFBqN+op8auLT8J6bGBJF2Boz94/cV/K8r+9UJEwSbpI23Uh+fp+R1UXWRQDhRWuvASoR3YALNQRY7sdqZnrHB5xLc0GPpW0xF7h2dDe56wjDMhWecUPEBJ5RE5hsZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RCFcUxxb; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtnGTKJqD49TkSacnYw8FNGT+LxOQAXpDqPjL3pi1vT4UHJ7SM/Pfx6xJnCQXC1VD/2dykgZEFRT8ySwHBkcj7EDWbx/QLpZqt+mcWBjunvI3Rvh4xKtWGJf0CQ1yVkU7c5f1Ay9Y3yWH9L1n/qonOuUe0dhRlVeGQVpArOt6yV9XnQhoA4iATJPs9k9cNxjSWPruBcBqgEA38u49IRaWdy2zY1Uz7I1QyPTdIAsFg2D9a9R/2rhr/QASPscddRSjbcWf3K1vbJ6PtVGhIi/43jobf7L0+seLGv3lxvSiBYXwd9b48JM92lvLKUcFsqreEnMFE3J0GXV6JcYw++Vgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcSNUxJJH1GrLnIO5NNKx8P48rFWP6bMS//3GlKx6z8=;
 b=fFwXAG++aLxqkuSYjlgybf12uxLLddrHlaqclTSBzBH5YEHcZImnfZ2/VGjEvh3AvZ3h7RrAz+c4Aq7OIGJ55agrHoBEjww4yBS5+tD+Sah/sSb8ZWuaeAQ7Y1xPmL45oWqbscwa38f3lsv3qTCvlALUO9EVnFEsCiePkQiXJhXdHLm7mD6+TNAYq5Pg9Fwy7XUcumPmuj+3o5XwGQe5yREZLTQApbRyRmiAWAFvIDuWrOBPFJjQcsPOXFw+hxNuhmZNaY7MqTUa9mbC6sOlRBm6YLd1f2vk9RUnM4pljLK1NhuTEoIg/svQClm6ZzkiXlTQHEZdMQkrIpnYaU6e7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcSNUxJJH1GrLnIO5NNKx8P48rFWP6bMS//3GlKx6z8=;
 b=RCFcUxxbctddU02hRQp7pF9snSKzfRtq+9yADU+uEvAgvqiqxqrcohED11SF7My9UCdul7dlyonQILmUTly2vD2Lz1bGL7g269INRsqHh6E15IYPzXxuWug1u4KO5eP1HekrrCkLgfs74pjwnPLhEp5mxqjo87gMioNndhhH2/TM3Rlz4UiZtOSjKwqutncZGixDAngY2xWiQJlp3YUyJBzLBlpEx06U3qjaVougeGarUjmvaxunNRbAq9ASpa83rYWDVxKBCfiEOzPklT0gO/Qu4qONpkx8sKKNXZ5FDphi79qfDyQTIqsvWERjIwEzll3dRmCZtWcJuga1d2CHBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7016.eurprd04.prod.outlook.com (2603:10a6:20b:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Fri, 15 Nov
 2024 17:38:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 17:38:42 +0000
Date: Fri, 15 Nov 2024 12:38:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] PCI: imx6: Use dwc common suspend resume method
Message-ID: <ZzeHGd/vfNFgsID2@lizhi-Precision-Tower-5810>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-9-hongxing.zhu@nxp.com>
 <20241115070932.vt4cqshyjtks2hq4@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115070932.vt4cqshyjtks2hq4@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: 431a0026-b1c9-4065-553e-08dd059c58c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJEWm5iRzJtVFhqWWhrSWk5YWVyWE1XSFA0SCtsVTQ1Zkl5Mnl1ODRQTENt?=
 =?utf-8?B?SCs3UTVUZ25VOXc0a3dWTTNXUGRkV1BYaFpUdGFodTZ5VTZFbjJFZXNMMkxm?=
 =?utf-8?B?Tm9jOG10d3lLU1A1NTFjV0l2dVNjbWlibC9pWVRmQ2pac3VZcHQxMVN6OVQ3?=
 =?utf-8?B?cVE0ZHcxN2pBemhKWTFuSG9jdnVONXh0Z1Nwa25XN3RvYk5wNENKQ3pJTlEy?=
 =?utf-8?B?RDE3S3ovaXFUcHNJeVZlb2VQb2FVVWtsQ3l4ZVN1S051UDh6SXpPcWxTaEVU?=
 =?utf-8?B?N1JxQ3hYNnBKTDBFbjJxcWZ5M1AybG5vQ3prOHR2VW5kbjJ5UXJBUTVNSHJC?=
 =?utf-8?B?SWpVQXNkR2N0ZXhTa2hTazczYVZqQnNHSFNTSFNjV1JLdHR1TlMwYi96djZJ?=
 =?utf-8?B?UXJYNzJtam5yd2wwS0tEMkpUWi9OWVdtc0ErWks3c3FjdnBkaWtJNTJ1akxU?=
 =?utf-8?B?eHRNRzVwVFI1MzJ3TGVVNjgwKzVua1hPVjJrZ0VwN1BaeGc2enRrSnNWOEk5?=
 =?utf-8?B?RHU2NG4vZk5nSU5LUXcrbEoraXZTcmwxVFNBRm5KbWNzcU8veDVjMmZNa25l?=
 =?utf-8?B?ek5NR2dER0dXWWxDVXh0dkpvV1JkWGoxRHFPZmw1TG1ybmY1c29DNGhyVFov?=
 =?utf-8?B?Y1c4b1JTRGo2QnViVVhsOG4rUk5XRzF1SDNBNEtYYzNEZWRpL1hiTk80OXR6?=
 =?utf-8?B?M3pONlBJYnN1aXdGYmx3UURtSU1CQlY5cUgwVFNPSFNoMndJZEYyQlhwODJi?=
 =?utf-8?B?NWVEL2lwNjdiMFRnSEs4MzhLOWcySHdOd3RFY05WaXVzVXpzM25mZitRUEhn?=
 =?utf-8?B?L3ZhYWNGWjV3UytWVDQ3NnRCMVR5M3c5U2JZUnRqdDlwdnBldEtyd2dUdFhX?=
 =?utf-8?B?Ly9OWWdSRWd6NlUwSnVLMjFTbnNFcFRnQTlYa29HZkFtRXJuT0xSZXpqQ0VG?=
 =?utf-8?B?cEh3NjlSZHZ6bHJhcXNFUTJWOFYvbUlEeFdEV3BkUU5Zb1FTdWJwTjBtc21t?=
 =?utf-8?B?MWJGRkxUdDhRTkdwRlFvbWdWRnlzbWlnbURjaHpuUndpcVp0UzlEYXJBWG5y?=
 =?utf-8?B?SmZ5VWNRNlVoZFlMcmc5OE1sazV5QjA3NzNhWDFCMHJSL2kvUnY4VUNLTFhv?=
 =?utf-8?B?TS9uTlNFeHBKWmg5RHpRR2pXeTUvRjExNHJ2VWpsbUFKMGZ4VVJmeUxZWDVt?=
 =?utf-8?B?TVdESWg2d0JjWjkzYWhicFAwQUpTYW05dmlBZjNEVENuL2hGUG5Ub0p4NjJo?=
 =?utf-8?B?Um8yaFJ3NGJMaDRlWGo4OXg2UVVPdXpOZ0ZXNWp0elMrbktTT2pDRS9CdFVX?=
 =?utf-8?B?UFRlVzZPVVVkOVNwUU1xV01QeGFwYmJWN2NuSksyL0JhZ0tSbjJKQnlQMGU3?=
 =?utf-8?B?VVdVNERMZThES0RWd1A5Ty9sanNnMHB6TnFEM3FTUk5GRWFUVlhsTklWRWRs?=
 =?utf-8?B?SDgzdVMzRlFRdDJ2WWc1QW1ickRSV05STmFISlF0dldqN0N5aFZhZXh2QWFk?=
 =?utf-8?B?QkV2QXlleWlvT013SEVIR1VQUmhpNExUenY3MlJBS1lsUXR4cmkzMmlXMVZ4?=
 =?utf-8?B?UzZ5WjllNy9xczZhc1ZYd3U4OStSTnNrZ2VKbXhOa3ZFRVVHL3ZtdUhpUTkw?=
 =?utf-8?B?cXFsaC9ETXk2L3JkK2lQdFExQ1dYbHFjWGIxYU5mdTIzbzdGUGdpZHFSdVhZ?=
 =?utf-8?B?Tzd5TXRYaDdsalhuTTVHSHJtejdESEpJRE9OV0hHaW85OVFzU3FVMTI5cGxk?=
 =?utf-8?B?dFV2QXBtVDVZdXM3dEZCc3c3ZGhzVkhpWEZLa0MyU0R1SHhIZm1yaGlkc1gx?=
 =?utf-8?Q?Tmnb3/AGHAObYvETIElyjQ2kBaAmIfEPunjKg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEM0aWhTWnFuNXNiQVhiMXFub1NTaXdBZ01DTWpxdU5EMjVCNGVRQkliZVlZ?=
 =?utf-8?B?ZTJsRkJVWWdNblV1NjY0T0NUdFdKZHBBaDVnUGFRMTVUMmVBU1hHQjlDMTVW?=
 =?utf-8?B?dG9OSlpCWVJNdFdQWHhBSjlGK3lsYWdXRnhFbWljMWdGOWZSaTVia2owN2sy?=
 =?utf-8?B?S1M3cDJNMVJpV24wMCtxYzlOMVNZQVcxbXZZVTZaRmVQTmYzQmh4ZmhhZVcr?=
 =?utf-8?B?bWdSaVZWY2ZLMmlwcnFHM3NUbUdsUVl1RGNTdzhEVlQxSk5ORkIxNVVUMHpz?=
 =?utf-8?B?S0FqZkpZdVlydGl3M2xNdjdYaEFMWDM4cHk4bXNTakVZWVpwZWs5bzZiampR?=
 =?utf-8?B?bE0xQnp1L0QvSlhHWS9kY3NFL3JHaHBrSnM3VUhaa3ZHaktzd0U1L2drRlpr?=
 =?utf-8?B?ck4yMW10ZmM0WVdDTHhyNnF6RjFxUTgrN0FJZitjaFF3WHc2Y2FZQlVSQkVy?=
 =?utf-8?B?Rm1PbFVHcWZ6OVF0eXM5NmtKRzk4VjdSRERrQlluTmV4VEVWblIvRFJPSjlR?=
 =?utf-8?B?QStJVzZTNzl1bGJpS1lKVHd3REtSeEwrYzY5dmYzNGNoLzZSTEh6MlF6WDhO?=
 =?utf-8?B?THFGUzZMOEwvemc0Zi8yV0tyZHViZVFDYkw2WksycDBscFJISlRrMkpXWTJu?=
 =?utf-8?B?Zlh6RHZpRDRuRGxYWFZRcDJCbVBFcXYwTnA5UlRTNVFPcEt3WUJFSzBaOG1s?=
 =?utf-8?B?NDBMZEt4TWo2RWZGdU1Ud3ZpL1U4bUxXT2V1S2UweFEwUDA3ajFnNUFTNDYr?=
 =?utf-8?B?V3ZnR1NWZkNmV3ExVkVDczM1L0g3ejEzYUtmdVBpSlZSaG1JUjU2dmVJekd6?=
 =?utf-8?B?dkRKKzAycWxNdUNRcHlKbXY4NEFOSnV0MEZLZmxIdHpERGNXQTMwMGVKWS9W?=
 =?utf-8?B?Ry9TRDlPTG85c05QN01pNzVsbGxySlpUUVMyVU4xZ2w5akpMYUJBT3hram5L?=
 =?utf-8?B?M1lucDZGcHpvSEVBUWVIMllGOSt4SzBucCtMd0Q1cmtWRDF0b05rR3dLV0g3?=
 =?utf-8?B?QWJLVmh6Nk1aamI4NGNwK0tOOHdjMStYVjk4Mnlna1IzYjZ6SVRlak1ob1Y4?=
 =?utf-8?B?NmlnSUJZVjl4L2Q3Z2UzZFpibnVUN244UWdybkVRRzltL1pid0UzSzdXL21Y?=
 =?utf-8?B?UEdBcGZrUXVWK3BLMXRKaUtNL3BaUG5rV0FrWVVOL1lGd2dIaWZnQzhIakZZ?=
 =?utf-8?B?Q0xIZkp2QjdCbDFqa3NBUUl0QUNiOFBQWW9EeEpWYWZJQStKaUc3R0dpK2pF?=
 =?utf-8?B?RHUydHg3ZGdvMjIyUGhTVnB4NjY4ajVpUGVqOUtnWUlYUnlONTJ6Z1JvVG5u?=
 =?utf-8?B?MnhaWnpFaUY1bW1wbE8yYTB3K1BTTE40alBvZDd1VlV3dW1iYzYwVG94M1Zt?=
 =?utf-8?B?eWZRZ0FSVlFuV1JUdDgwVmEvRVl5TWRTZEw2SDF3V1lZdUI4KzhpMTNPemJC?=
 =?utf-8?B?dWxDOEdRcGs0WDNPRzlOYVA1T0d1ZjRuaTlQWnNsMnd1Y1U0S1dKbDFzWXYv?=
 =?utf-8?B?eXFkclNaamZtUlNXcytJWDFFZW9KQTJLd0xCSDRTb0E0b2Irdy9RYVk1azFn?=
 =?utf-8?B?UTA5OXc1SFF3aDF1ODN6THRnT3poc2lzNi9VV0NHWDVaaGJUcm91T0sreTJC?=
 =?utf-8?B?NHBMbHRWV1ZTeG0wQkFzOGFjdGI1RGV2eGViZi9JdjdjcTlucDYvUlZEL2lX?=
 =?utf-8?B?UWZkRm5WS2Y1TERubE85QWdFalFrL2toV3orUEwyazRGRnhZanF5R1p4OGND?=
 =?utf-8?B?bWRjTnplWWRSS1gxMUJWWlhxd29vTFBidUwzZWFsb0haY0RXbHZRN0RRNVVP?=
 =?utf-8?B?RVBYQ0N5ZDI0cjdOZ1BHVWM2Q2QwT0wvTm80blpmcTlUTDdmbHJXQzlMb3d1?=
 =?utf-8?B?SjRobTRCeE02OEIwK2hRNFhOa1hmdTlhT0JaY08xa0tDSXFXMXV2ZlZ3ZGNo?=
 =?utf-8?B?aFhocDRWL09DVEVZZk53blZMZW5TZlg1K0tVeGJoSUErTHY1a21VUS9GWkw5?=
 =?utf-8?B?SmJQNitleSsrSFFZTGZKcmhyTkdqMWxGR3M2blVyMnV3OWxGMGRBbGZCazk5?=
 =?utf-8?B?N3ArNFlZcFVJazJjU3l4NVhOd2FGRkpiVXdicHRpeVJXSUtSbWlqRFBhcDVV?=
 =?utf-8?Q?YiQMinNePGLaDHyS3WT0sgYCc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a0026-b1c9-4065-553e-08dd059c58c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 17:38:42.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGe5GpydFe/0pxFY3Y+aPGsP0opLb+BgInPGb0q1EnfzYNZsFrYtWfW8cjnogcG3KQtgZf6r1jnWn69IOfq7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7016

On Fri, Nov 15, 2024 at 12:39:32PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 01, 2024 at 03:06:08PM +0800, Richard Zhu wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Call common dwc suspend/resume function. Use dwc common iATU method to
> > send out PME_TURN_OFF message. In Old DWC implementations,
> > PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
> > generic DWC implementation of sending the PME_Turn_Off message using a
> > dummy MMIO write cannot be used. Use previouse method to kick off
> > PME_TURN_OFF MSG for these platforms.
> >
> > Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
> > dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().
> >
> > Since dw_pcie_suspend_noirq() already does these, see below call stack:
> > dw_pcie_suspend_noirq()
> >   dw_pcie_stop_link();
> >     imx_pcie_stop_link();
> >   pci->pp.ops->deinit();
> >     imx_pcie_host_exit();
> >
> > Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
> > imx_pcie_start_link() by dw_pcie_resume_noirq() in
> > imx_pcie_resume_noirq().
> >
> > Since dw_pcie_resume_noirq() already does these, see below call stack:
> > dw_pcie_resume_noirq()
> >   pci->pp.ops->init();
> >     imx_pcie_host_init();
> >   dw_pcie_setup_rc();
> >   dw_pcie_start_link();
> >     imx_pcie_start_link();
> >
>
> Are these two changes (dw_pcie_suspend_noirq(), dw_pcie_resume_noirq()) related
> to this patch? If not, these should be in a separate patch.


Sorry, this patch have not touch dw_pcie_suspend_noirq() and
dw_pcie_resume_noirq()'s implement, just call it. I have not understood
what's your means.

>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 95 ++++++++++-----------------
> >  1 file changed, 34 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index fde2f4eaf804..3c074cc2605f 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >
> >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > @@ -108,19 +109,18 @@ struct imx_pcie_drvdata {
> >  	int (*init_phy)(struct imx_pcie *pcie);
> >  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> >  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> > +	const struct dw_pcie_host_ops *ops;
> >  };
> >
> >  struct imx_pcie {
> >  	struct dw_pcie		*pci;
> >  	struct gpio_desc	*reset_gpiod;
> > -	bool			link_is_up;
> >  	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> >  	struct reset_control	*pciephy_reset;
> >  	struct reset_control	*apps_reset;
> > -	struct reset_control	*turnoff_reset;
> >  	u32			tx_deemph_gen1;
> >  	u32			tx_deemph_gen2_3p5db;
> >  	u32			tx_deemph_gen2_6db;
> > @@ -899,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
> >  		dev_info(dev, "Link: Only Gen1 is enabled\n");
> >  	}
> >
> > -	imx_pcie->link_is_up = true;
> >  	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> >  	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
> >  	return 0;
> >
> >  err_reset_phy:
> > -	imx_pcie->link_is_up = false;
> >  	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
> >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
> >  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> > @@ -1024,9 +1022,32 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> >  	return cpu_addr - entry->offset;
> >  }
> >
> > +/*
> > + * In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2
> > + * register is reserved. So the generic DWC implementation of sending the
> > + * PME_Turn_Off message using a dummy MMIO write cannot be used.
> > + */
> > +static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> > +
> > +	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > +	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > +
> > +	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
> > +}
> > +
> > +
>
> Stray newline.
>
> >  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
> >  	.init = imx_pcie_host_init,
> >  	.deinit = imx_pcie_host_exit,
> > +	.pme_turn_off = imx_pcie_pme_turn_off,
> > +};
> > +
> > +static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
> > +	.init = imx_pcie_host_init,
> > +	.deinit = imx_pcie_host_exit,
> >  };
> >
> >  static const struct dw_pcie_ops dw_pcie_ops = {
> > @@ -1147,43 +1168,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
> >  	return 0;
> >  }
> >
> > -static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
> > -{
> > -	struct device *dev = imx_pcie->pci->dev;
> > -
> > -	/* Some variants have a turnoff reset in DT */
> > -	if (imx_pcie->turnoff_reset) {
> > -		reset_control_assert(imx_pcie->turnoff_reset);
> > -		reset_control_deassert(imx_pcie->turnoff_reset);
>
> Where these are handled in imx_pcie_pme_turn_off()? If you removed them
> intentionally for a reason, it should be mentioned in commit message.
>
> > -		goto pm_turnoff_sleep;
> > -	}
> > -
> > -	/* Others poke directly at IOMUXC registers */
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX6SX:
> > -	case IMX6QP:
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> > -				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> > -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> > -		break;
> > -	default:
> > -		dev_err(dev, "PME_Turn_Off not implemented\n");
> > -		return;
> > -	}
> > -
> > -	/*
> > -	 * Components with an upstream port must respond to
> > -	 * PME_Turn_Off with PME_TO_Ack but we can't check.
> > -	 *
> > -	 * The standard recommends a 1-10ms timeout after which to
> > -	 * proceed anyway as if acks were received.
> > -	 */
> > -pm_turnoff_sleep:
> > -	usleep_range(1000, 10000);
> > -}
> > -
> >  static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
> >  {
> >  	u8 offset;
> > @@ -1207,36 +1191,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
>
> [...]
>
> > @@ -1267,11 +1241,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >
> >  	pci->dev = dev;
> >  	pci->ops = &dw_pcie_ops;
> > -	pci->pp.ops = &imx_pcie_host_ops;
> >
> >  	imx_pcie->pci = pci;
> >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> >
> > +	pci->pp.ops = &imx_pcie_host_dw_pme_ops;
> > +	if (imx_pcie->drvdata->ops)
> > +		pci->pp.ops = imx_pcie->drvdata->ops;
>
> Use if..else pattern
>
> > +
> >  	/* Find the PHY if one is defined, only imx7d uses it */
> >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> >  	if (np) {
> > @@ -1343,13 +1320,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
> >  		break;
> >  	}
> >
> > -	/* Grab turnoff reset */
> > -	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > -	if (IS_ERR(imx_pcie->turnoff_reset)) {
> > -		dev_err(dev, "Failed to get TURNOFF reset control\n");
> > -		return PTR_ERR(imx_pcie->turnoff_reset);
> > -	}
> > -
>
> Same here. Reason not explained.

"Some platforms wrongly use
devm_reset_control_get_optional_exclusive(dev, "turnoff")
reset_control_assert(imx_pcie->turnoff_reset) and
reset_control_deassert(imx_pcie->turnoff_reset) to send out PME_TURN_OFF
messge, after change to common API to do that, so remove these wrong
implment."

Is it okay to put above into commit message?

Frank



>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

