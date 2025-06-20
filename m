Return-Path: <linux-pci+bounces-30261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE5AE1DA0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 16:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED1D7B0C7C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D10295D86;
	Fri, 20 Jun 2025 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4oHNOv1"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200262949E0;
	Fri, 20 Jun 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750430469; cv=fail; b=eZoGBX7dIBMkXHkyCf9MgEF+ceM5pyH4wx35zM3bShr2gieQNEOkIffth12LVaFKTOacSWcO0uD/ziKzr/1wKzYEW+rO44sHLtg+2xdQvLQFmQMRgLVILFXFjGjaN2rXFQ97bg2dtRcqZJ/uiXOp1rpIqfKYrLxuUaOzhYuiNsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750430469; c=relaxed/simple;
	bh=owxGfhgqXHv8J9zzebli60viSnZBFLMBt+GJBGWCy8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KIiyOQvZw/sbigAlCiIr5NjyaCeHFuN6c8xa0/PFATqGxutwtA9ni4zAuN1knoU4wgnKbbCoBeC5kDtxtnn5e3rvft+/67IswV6dc3KKemu3tF/MdvoHMITtNkFLRAeIcEhE4YJxB/YRMOFz0S2aqYQqq6NOxbpu8A3KGKRJjkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h4oHNOv1; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJGOKMWiuzsdCu+qjkeQ10hwlTjFlVAbaUBaw+aBIpJuOrvoqNpFLs+FNs8ZnFfX/7udsPTkohJ9sn7/m4b0x0ZZ7CPJ+sxrsr876gTasEO1Zdo/4tT9HBwp0PhcOJXMV+1/7E4JE2qYPbgR7Y9p5xbybE0XSCPL6yPgmoRm2KNUgZJZKzKkhbFYdiOAh9BxMBbT98JnHFnTVzw9LKzRKvxJ22/7/BVZZOYf5guWDmtsYtJDgY8ROMRuJH0mrkeVSWjQeabRU24PXMYgrniPCxuZmPTz4kvE1UBWTq9JyyJdgVPEaouVfuwAnBOqAFQshH0lt5fkSSWOZbNcLf/57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8ByH+GWwXVa/t0gseyzX8WuqX9QV7d5HM4MoMX1IRQ=;
 b=qk6KAaIqPrLENQftl35RBW2XPLNGn9mFUHTcSgi3I5pgqpAUNydDs2XoXaIRD/3bO7zfinrGHN0OHrFGdjcN78zz8+gRq17wC4qtAGVX0FzUQJ3GDddMW7CdPl69Y+nrnWKMA7ra/IRKx8XnL0dNUQujaUSnpc1rb04vfpXpshQRt0M/HKRvOACAwTd/zkbl3Hfq50MBxSrdz8oD03/T5Yy0waPD81+8BvaaEKTMY499sEBhR4d/2BdSnl1F9AW/VScnKombgcQN3FAe52IwqYZ7xPl7zI7oq7syQmMQJ9q2+KuFSckpH5UMdaq454ILuPG+Tb5XuZ1dF1CYwDiV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8ByH+GWwXVa/t0gseyzX8WuqX9QV7d5HM4MoMX1IRQ=;
 b=h4oHNOv1neUv9C0N6whDG6oC2GaLygG9InI3Xpuzj5x6vZpkYhqPe6H5wI4rDi1BcMKYLS2vFWulBf+tJQSqvrk9XguHj8oGIUUd17HYU/sO4JfByLH0402MBGu/siPchbN+2t6sGjcsFUXbOTyVUJu84TaMIYNbgOc+01p3i99hi118DtD+qKx8bke3FnIMHerR6eQCWbDqicGz8FeH3g0su4RqoF2qOAoOPnrURGjeDz0KieBSDjxALnG+D34vV875CLM3EBvCPCwXt0Q6FxMpMGYZdZ10qgWKGOT6p05peNz7ix3Zv1VCx9k61a05R8THav6EOMUXH/M3RzAoQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7563.eurprd04.prod.outlook.com (2603:10a6:10:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 14:41:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 14:41:03 +0000
Date: Fri, 20 Jun 2025 10:40:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
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
Subject: Re: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <aFVy9OMxL4WXEOzz@lizhi-Precision-Tower-5810>
References: <20250620031350.674442-1-hongxing.zhu@nxp.com>
 <20250620031350.674442-2-hongxing.zhu@nxp.com>
 <20250620-honored-versed-donkey-6d7ef4@kuoka>
 <AS8PR04MB8676FBE47C2ECE074E5B14768C7CA@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <130fe1fc-913b-48cf-b2a4-e9c4952354fd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <130fe1fc-913b-48cf-b2a4-e9c4952354fd@kernel.org>
X-ClientProxiedBy: PH7PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:510:324::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8e7890-02ee-4c05-77f5-08ddb0087b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWlIbVlYM0pJUXV2M3NPdVlES1FQWHI2enF1cjRJQnFCWVNucTZRQlUyVlpV?=
 =?utf-8?B?VWRpbHZRQlFmcGVBOTVzTnVQYURpTFJwUjd1cUFrdUdhbnFTa0dUNVJ2RFlC?=
 =?utf-8?B?SW03WXIrbGlnTmR3cDdVektTQkF1Qk9JYWdJTmQ5b0hMQnM3QjdDMnhSdU9Z?=
 =?utf-8?B?MS9wS1VqemRPVEVHakdkVUxuYjNyS1JZOXQxaERmR3lvZlhRRTdJeUxmUkxG?=
 =?utf-8?B?UHg5WmlGbmNYQS9iV1hBUGZEekZyKzltQXJCTDE0YlFEdUNWdjRmdkgyV2xo?=
 =?utf-8?B?bnB0YTdyYjl4aEFjSTZPK1d5NzI4eEJEWUFHV3ZkSk8rdDlOTkI2ZG9kWDNo?=
 =?utf-8?B?djBNT0xTMVl0M3VwVHlTWUs3YncxVDVqWkMzMDBOK3lIV2M2VE95cXZicko1?=
 =?utf-8?B?UTZSWkNRcTZPYm0wNVF6Q0VNZTVibENaMFJXMk9UdGh2OE5zWEE1ck45STBh?=
 =?utf-8?B?dm8yWXZleFV3WkIwNkx1YVJmSFVlY1RMTUl4eFhIeU1nVTE5RTlrRTVNN3NS?=
 =?utf-8?B?dnl1aDlaK0VRRlJYOFcyZGE0V1B1MTd6cStTaU1ZK0pWYmVtSjFJbmxOZS9z?=
 =?utf-8?B?RVFrOFE5djE0dU43MWx4aXoyS2V1MzdhSFBGNjdXWDdGa1JpTkhzbkorc2Vo?=
 =?utf-8?B?cmI3TkZwMnYvR1Q0Vm5rZ3B6NlhYbWExYmJDMEtjSENEc0Y3TGZnVXUzYnJB?=
 =?utf-8?B?RWxJUkxyZ3l3ckxCT21rYm1ENGtTWlhWWG4zSk5DWk82MkFjQTArUWs3Y0xv?=
 =?utf-8?B?UGhwdThiN0NvMmhDeEFNU3lKdmk5STY2QStMVXFYSU01blI1cFhseS9JUzRS?=
 =?utf-8?B?Mk1XeldFV1NibTVTa1hmM1AyRFMwcXZydDZKMHNYNHdYQnRROGJldnNLL0xK?=
 =?utf-8?B?WEwrTzlBZTRMeDRGYjRYUGQ0dFA5RlF1bC95S1Y0NUNMakVJcHhCWkhqYWQ2?=
 =?utf-8?B?cGNZa3Q4UlRLOWMxMVZWa1F6eWMza0NvMmVKMU1PcWVydHJTc01wUDR0ZDhi?=
 =?utf-8?B?RFJUODFXRVhLdzA1eFc3NmFacUtuYW1DMzUxOHdsRjA2aGQ2VXhydHc5Wm1B?=
 =?utf-8?B?VDAyczFrV1NFempxdm5URi8zaVN6aEhoNkhDa3drTFdGZUtLTDk1TUNkTDll?=
 =?utf-8?B?bldRd2JsUDJnUE1iQm9SOWJKMVVsTWpEaGxBczE5TzlHU1FmWHVjdFFHSExs?=
 =?utf-8?B?VEFBU1N4aHZZTk41ZnUxU0FEYWJFZFp0WnFTdmlpSVR5UkJiRXFMeXBZK3dV?=
 =?utf-8?B?MCtyaHlJQU0yOHkyYVB1ZDJHUHJZcjBSVFZzQ1VpeXVGQ2owREZMRVpMajdU?=
 =?utf-8?B?UlVIc2V3SHlZblZkMGgyUmVHUDlrRmVUNUlUMWhvQ2x0Z3BNL3VRZ1F4VjdO?=
 =?utf-8?B?KzYzQ1ViY1FVN1p2L3pveXNsNVlqUzk4eE1JellVZUUyNTQ3T3o0RHJWZStO?=
 =?utf-8?B?YnJSQXFjTExScWgzOWRWVW9FNDdmMDVkTWJzNlZ0QkZVbmhpUUJyeUNzd3Vt?=
 =?utf-8?B?TVdmUWNkUEdzUHJLRko1ZFRadlk3c25iQVhYdGNyWjU5YzVNM1ZPQXVUSDln?=
 =?utf-8?B?bC8rZStZVlRwQkRoZzM1Y2hnM1E4SzhicmlaK21idGJMendUVHBSODBpVnV2?=
 =?utf-8?B?QklBL0FvdnM0c3pHNGV4dUlTMStmUFJaenArRzdSM0lmWTVhZUpVSElEZGFH?=
 =?utf-8?B?MWJPZFB2cjNJTWkwK3h6QlA2TzZFZUJ6ZVV1TGhVYzUwREEzREpoSUgvZmtI?=
 =?utf-8?B?MThYajUrY1lTQ3dmaGR4SGVQRCtUWENJb0lQOTQ4d1lWV3dEd3puYU04aHQ1?=
 =?utf-8?B?Uy9GNEc4Y1VGVENMc0MxWWlCbG4xalpCUGxpeUR1SHlibnFjbmFxVlgyVGJI?=
 =?utf-8?B?YjRlVzBseDl1Q1ZZdUEyUXZzVkpuNXE2dHpSN2lpUytpc1JRbmVXRURiQ3JD?=
 =?utf-8?B?aFNFemM1RU9EMVdmSDllVk1GRDMxZC8vM011UGVsVzRZc1MwekI2a0x2YTVt?=
 =?utf-8?Q?aroQZU99HNU4XeVttfxRdoKR2b2zEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1dYN3ZFUGhDWUNmTlU3SWFkQmlpOWxVY0pYQ3RpbUQzNzZMVmRWOTlub0VH?=
 =?utf-8?B?b3l4aEpobW5FM2VRR1RDZGJDL1R2TURmZzdTSTJNUmNrRVVNYnBDMnZDb21R?=
 =?utf-8?B?eURvdVR2SHZJZWlhaVdPbkN2UUYzQktvOVg5dnBzc1RoK1ZaZGF2QW94UHBp?=
 =?utf-8?B?VFBOM0tLeGFHNUNCNEtCekU4OVZaaTNnLzNqcm12cnc0Q0pKdG1CU2hhbVRi?=
 =?utf-8?B?emhyODRhb0FKdlZmZjdpQ2hOWFdLK1FuNGNJazQvMXg2aG5vem5KajFwOUlx?=
 =?utf-8?B?MGRRTjdhZFNLdGpzb3B4WDZPeCtzV3ppdTRSc25HTk1hdE1RZ1lGNmJYR09r?=
 =?utf-8?B?UDFGRG0wYnVkUEJtUkc4SEZRZGN0ejVCYWJNL2tkcGRnR3NmMFRETWZrWlBW?=
 =?utf-8?B?WnduUU5veUgrYTEvWW95Qk1MUW1xZVhxamRESU5DM1F3MllIZmZJWVMzcEJl?=
 =?utf-8?B?N3VuMGoxcjZWRWR1d0xxQUp1d0VjZW03NzZYREl5bDNraWNLeTRTcWd4cjBT?=
 =?utf-8?B?dEJQV3pCUWhvcEIrbDd6N3lXQ2plK1FuR0FKNzlIM2JsQ0VmLzFxeDRpdDN3?=
 =?utf-8?B?MUtkNVJPTGQ3dUZsVkZWK09FTEVtL3J5OE1XRng1MFg3VHM5LzNUTDVlRHVz?=
 =?utf-8?B?a0JENTdjVHZqcmNzKzRBM0htQXVrcVZuZ0RjTlNkVkZ4Q1BhSmY2TjZlR0to?=
 =?utf-8?B?bHU4NjB0QkFlLzZScjJnMFFnZEo3UFh6N0s1V0FuVGhqQTViczhwczJWZU45?=
 =?utf-8?B?VXVBU1R2am41NVdSd3NnTHhqTlh2T1dQallybmR5TEJIaUlGUEdiaW43ZEp0?=
 =?utf-8?B?Ulh4cWd5cjdFVWprNGgrYUFHNXBqd3B2eWxtTDk5OUZVOXl6c3FtZG1jNTlV?=
 =?utf-8?B?Mk1uRzdmZWFra2dtS2s3THJld0gvTVhNZFhJSXo4Q3FuYVVJVEJNczNHZHp3?=
 =?utf-8?B?OEdUQkNVMlVMeDBzbDYzNEZuZFJ6blN4MDduUzRqdzh3dTJsUGlNMnZOOFNz?=
 =?utf-8?B?T3kvWFVueHFNZWZPOWFYeklzbXA3WWo0R1ZnVmlUemwzWkZjamRuWnMreldD?=
 =?utf-8?B?b0kybW5rNVIwMVZPV3B3VGpIZUZWSWVSczMyS2VQUUY4RC9VV1oxcnl1dG1G?=
 =?utf-8?B?OGRQRmxTMmxGYkVYYU14ZW5oRjJJK3RoSWZYazBQcCtPLzZqRUdFSmNKN3dT?=
 =?utf-8?B?UlhkYUN1UlFYMTZmV0lEcTQvcndtOExTZjNBTGxkQWdMdHpzYUwzUW9Remha?=
 =?utf-8?B?SWNPV2lsUnhEbWR1WE9VM0ZUdE1PWjg3c0VwakIzcDJZOU43RWgyZm9RUTE4?=
 =?utf-8?B?MmZHQWszRUZMNWVQWGpmQ3ZLTFh5ZjBUd1BiekMrMHhiSXBzSldkR3doRVdk?=
 =?utf-8?B?cDd1MittdllRUW5yMFlXMUV3MVBXY3UvWXNZZzhzMGxpdjB2c2dxOUR6bzhB?=
 =?utf-8?B?ajRqeUxNS2ExdytsZ1dGa0M5dkF6SSt3anAranJ0OGdLNmZTRDJMMng0Y3Nq?=
 =?utf-8?B?QkJCdUoyN1ZYVnFpNG41SGFkYWEwWS9rc1BMSkw4OXFIRjhBQWJLQkZsRmxr?=
 =?utf-8?B?TXp2VjdmbHY1NjhXMldmb2pib3c4ZTJXdFppamFlZDViUTFib1hLUHVFZlEy?=
 =?utf-8?B?eXA2NUVTLzNiUmhNWjRta25HMStXV3BuaWp6UHdSUDlTSm5FUmpGSnhSNFlk?=
 =?utf-8?B?SUNORHdkalR2ZDJkTko2QXZUMUpWeWF0WEgxY3d5TFkrNmRXSTRTa2FveGly?=
 =?utf-8?B?ekJ2Z1AwTHgyZkNLLzZGRWRZdWlSUDQrSGxyc0FzRXhZN09QSXBRb2NCYWlM?=
 =?utf-8?B?amMyTmhjVHM0d3RKbmpuZ2Jzb0Q2dGlwZVhDVGRsRm5DcWlUcHZuSWZEeWZi?=
 =?utf-8?B?bVFreEJESUVBNFV4S05zU3NEMkxEa1dNbDY5cEFuZkFZR0liRFdtbDF4ejVh?=
 =?utf-8?B?Z3Vla21DUllLTjdtSS9nRUIwUTZBUlhBUktNT0ppUVFXZ1FuK1VzUFVEVjZJ?=
 =?utf-8?B?Q0RUa1haTzh6dW9PcWxIc3Z6N3FzOWVWRHIwZnJ5bHpIcko5SFQyWk9HdFFE?=
 =?utf-8?B?NG14WHZvRVVxcWt0TWV6QWE3eXIyZkFIYkdZd214R09kdm1hajlIS2h0ZmtB?=
 =?utf-8?Q?quas=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e7890-02ee-4c05-77f5-08ddb0087b1d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 14:41:03.0174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d72xYvzQ0DD3tAqkdhBXoBUMid4XXvYg7NJprJQh+oXBlRjlYE0+qWfbIsIlWpEzK9nUWH789tYY4oAKg9UKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7563

On Fri, Jun 20, 2025 at 03:08:16PM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2025 10:26, Hongxing Zhu wrote:
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk@kernel.org>
> >> Sent: 2025年6月20日 15:53
> >> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> >> Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> >> lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> >> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> >> bhelgaas@google.com; shawnguo@kernel.org; s.hauer@pengutronix.de;
> >> kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> >> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> >> imx@lists.linux.dev; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH v3 1/2] dt-binding: pci-imx6: Add external reference clock
> >> mode support
> >>
> >> On Fri, Jun 20, 2025 at 11:13:49AM GMT, Richard Zhu wrote:
> >>> On i.MX, the PCIe reference clock might come from either internal
> >>> system PLL or external clock source.
> >>> Add the external reference clock source for reference clock.
> >>>
> >>> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> >>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
> >>>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> index ca5f2970f217..c472a5daae6e 100644
> >>> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> >>> @@ -219,7 +219,12 @@ allOf:
> >>>              - const: pcie_bus
> >>>              - const: pcie_phy
> >>>              - const: pcie_aux
> >>> -            - const: ref
> >>> +            - description: PCIe reference clock.
> >>> +              oneOf:
> >>> +                - description: The controller might be configured
> >> clocking
> >>> +                    coming in from either an internal system PLL or
> >> an
> >>> +                    external clock source.
> >>> +                  enum: [ref, gio]
> >>
> >> Internal like within PCIe or coming from other SoC block? What does "gio"
> >> mean?
> > Internal means that the PCIe reference clock is coming from other
> >  internal SoC block, such as system PLL. "gio" is on behalf that the
> > reference clock comes form external crystal oscillator.
>
> Then what does "ref" mean, if gio is the clock supplied externally?

In snps,dw-pcie-common.yaml

	- description:
            Generic reference clock. In case if there are several
            interfaces fed up with a common clock source it's advisable to
            define it with this name (for instance pipe, core and aux can
            be connected to a single source of the periodic signal).
          const: ref

        - description: See native 'ref' clock for details.
          enum: [ gio ]
> We
> talk here about signals coming to this chip, regardless how they are
> generated.

PCIe controller takes one of two reference clocks, internal PLL (controlled
by clock provider) and extern crystal (controller by a GPIO).

There are clk_in and clk_out at SOC. External crystal output connect into
clk_in.

clk_out come from internal pll.

The boards design choose one method (internal pll or use external crystal)

Frank

>
>
> Best regards,
> Krzysztof

