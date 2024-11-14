Return-Path: <linux-pci+bounces-16801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C499C9569
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F63B2430A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4EC1B21B9;
	Thu, 14 Nov 2024 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZOX/8pNl"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013009.outbound.protection.outlook.com [52.101.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC71B21BD;
	Thu, 14 Nov 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624787; cv=fail; b=G9dR7EoqQGghyII6G2tIBHXm/IRBjW4clhYmMUYBulciHwXFKNstrUNgMFRBQJKl6qjfdNcHdIA2s+GMssZuYZoMo6QseO8QpJt9UBom7IuhSvyzj2MA1XDIxURyo8Ekakwtgz72JxsbBCxNbS51T3bYTbB7lQi6YEv3q20qvC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624787; c=relaxed/simple;
	bh=W0/3suDS2X+PR81+KxkOxEg/dzb/QOb1xgTjwq/FHuI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fnnw3RErGN6hnD7S1/PjHQui43dMZZyoBGliRH/fJ3/ZwP/pei45vAbhafapqpTeZ0VV3WwfsX/nv1RgiBfMvYP+crf/QqCUiu9CquWYzjOQUQFqyTAbibjzCPsuFtCjXh8K+wzR34LvG4iUr6HshEGY+7hqbjjzvJPap/CpZ0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZOX/8pNl; arc=fail smtp.client-ip=52.101.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8HBaMTw/OzKG1jvGCi2ac8yGMVPuRCuTzRXvFJskwF260MEnb1j4JxXSzFdWy/nCVpeTG9azfW7c0FSjRhOr3fErRMbd2qUPue6enHam+5FQCh/Lfz5N/OpfVJVRmcNmKlHria9qdoOXrUmCc9kpb+3PqKBIzOuXQFvFMGy8aaB90+IJfeHCPAlonG/PM7o4pVE0t6bF+JzDrlZxLh0j0GMG590Jsd6XxYd6kGwsQXrwzO4OWKzo2J2ic9UO71kw8enMSSD1I2r5jmUdw2Y8shreOJTdzlBEMPPKbz3FBxnY/Vmig20tvbhqW8rgIf77ZJTjVEihbcAp5XBKPB0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlXLZ5x5NHDqWvGgBVnFd6Us3IzJiiZwh2cGtn9n1VI=;
 b=IABAhDDYt4lnlQWiokDVNV/WrtxQLxx4X58R5Qn2iQ/U+n5b1lLzkksCB5DqKJVTEX4zbLiAZLZ8W3HqL70WAp29yJx6Kv0OF9w3/zhCSjEShorktPAykTLR3FZU5tnE2JGBClLv+WpQMTYtGqSEa6jYtEmbbjctImdSBKglzEkA93zA6lmGpj0+U5+CyU0nE73UeWzodRFs1G9HWMQAG39ZY/NVERiy/2ZsK5YQgsrRoV+SrA7ylgOvvbObABdAXps6iVCmF9fDgVnOT0nL2rxH0r4GHbhrr1IBiwgmOztqohXuIctt5KxZgeiefCIbNnLlDPq/VzQEY1yogY+48A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlXLZ5x5NHDqWvGgBVnFd6Us3IzJiiZwh2cGtn9n1VI=;
 b=ZOX/8pNlL25L0j65I8JmSeyP1oChN/1ji5owb5iwKIUXUeNJGCFzP0TB79pQ1aO4TjtuVpUfgifNn2p2c+qof3WgrZfrn5qIxCJfQBaeQ8VoO/FCOs1QDSYZRsT1pt0cQEj4eJVObEPpj9eUz7Pv302CfvldtEjbM01OJgAnMFPFAqUJK25kg0znqASEH7xnrP6Juj9y6gaBhHhMo51awTkPhqUoOa0DGjEQL3MdgeRI9A9jFV5QAQr0Ep2PgXK6lcIPDY4EK4iuXSzbgCiViHFt/4ZLSp2yqAegpXfVwkVmZ2kjDwlV0dYD1Huxl6m2QxoRnt9i8cQp5ME0QMU1gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:53:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:53:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 14 Nov 2024 17:52:39 -0500
Subject: [PATCH v7 3/6] PCI: endpoint: Add pci_epf_align_addr() helper for
 address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-ep-msi-v7-3-d4ac7aafbd2c@nxp.com>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
In-Reply-To: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=3039;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=W0/3suDS2X+PR81+KxkOxEg/dzb/QOb1xgTjwq/FHuI=;
 b=CmGk9/KoFwJjo4n4AYZ5ddK4TCAISmSrzK3mH0rPCsmbJ7Vw9rX50/YwCUG/5kAYwaiugj2as
 fdXFX0Nr5PnDggkHNsGFbI6vtmt+fbnqzAyIahih/VWC8vSQTmkbUFz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: ac137464-518c-4b74-da2c-08dd04ff18a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJiWjZZdmNERXNDUUdYWUt0VFBtZDJrK21LTk1GbjlibkhMdEhvUzNPTXdT?=
 =?utf-8?B?TUgyUDBFemlMUVFnb3dvNk1kVGk4QkFhTkxVUTRUNFIya3dncWptQm5SRTVl?=
 =?utf-8?B?Q0VkWnY3VVgxY0ZPZktGT3RaWFAxWFBLZjl0dzNTRHh3QjlPQVBweFc4KzQx?=
 =?utf-8?B?U1o0bVUwU1RiWnlpMWpYVmx2bGtwN0dUekY5alBXQWw3bnhzeXhmbVZWVzA4?=
 =?utf-8?B?L3B1a2VXaHpYbXI1cXlaUlEzUkdsSVpURDBweUZBRzMwd2ZmN25RZ3NsZEtv?=
 =?utf-8?B?RGtNaTBtcnlEM3VORHozQSsxa0xOU0NoNWtnVnV1Um9PcFU0dWJBK1FqaCs2?=
 =?utf-8?B?VEFrRVZ4YTlOdHo5RWdNWCtEcGtkNmx5SExyeGZ2ZkZiR1VxWTAyS214dllH?=
 =?utf-8?B?M2szYUJ2RDl4UXA1dFRtSHg5Z3NTMy9nZjRucWtJLzVZK25xQ0tORDNBQXE5?=
 =?utf-8?B?SlNHQjZoYlpaQnNKVFg5NW1QTjRNdjZSVWF5dkJtUFFrZWk4N1MxWVNJd1lq?=
 =?utf-8?B?cFBuS1BWMnQ5c0RMazZJYUNsUEkwTXY2d0l4MUV3K1pnam9QZDJLc0RMNkhv?=
 =?utf-8?B?SFE2enZHYWxsMWZ5cmZlR05ndWJlYkM0VEdZWDRqak1Mc1dGRi91VWlKWGpk?=
 =?utf-8?B?VGxQSTR0eDE5Y01rL2JuaWE5VXp1N21raVBiVG5oMzJQZ3dsTVFVcVQ1MC8y?=
 =?utf-8?B?QVRxRjRZWWRmWU1Cd0hQcGtDV3h0ek82clhvTUxjZEFrY1JMWFJmMkxLdFIx?=
 =?utf-8?B?YldUUXA0bEZLclpYdXdScHhXazg4aVdwSzEwaXlyelFjT2dqVFRjT21nNzlU?=
 =?utf-8?B?MUhhdUpaYlU0OC9SRXY5akpWdjBCL2FlTmg0WXpPTnlIU2l6bE1FOUZtZHdz?=
 =?utf-8?B?bEtjNlF3SzBoUVdldmFPNDJ2TG1VU1FWYlk5N2t3R25aTEJHd0F6YjhTL0Rl?=
 =?utf-8?B?Wk56VllLaXBXaW0rMGRNQkxNOCs0TUxMZ3NIc2RpcVljT3ZKb09MVFdyQ2VL?=
 =?utf-8?B?UUp2WGRpVG5kMithc0V3dkxJekk3dVZFOWw1dmJMdVhGZjdlSlZhWDErV3dk?=
 =?utf-8?B?N3BLcGFucTRyTWF6cGNuNUpKdHc0aTJQZk9ycm9KR3llbE5mTE8walFIY3R2?=
 =?utf-8?B?eHVHU1J4eWZCVDROakFObWladDhUcUUwSmxiZXBhQ2hrMFB5RkMxQzhvYmZL?=
 =?utf-8?B?RHIyWC9xa3BVNUVZeWNmcG12WWpXM3ZmVlJqSm0yaUVHUDFGaXc4ZSticDVC?=
 =?utf-8?B?U3JqTldDaUwxdWlmSnNIWnAyWVRRRDluL0lzOElITzRWbUZZNCttL2hEZEkr?=
 =?utf-8?B?Qk9kajRWVkxuUENKd1lBQytYV3RPQm9kbjNCYmxBcFlzSmNRZDdRWFlJaFly?=
 =?utf-8?B?UHVCRElSdjNxb2hoclRLYTFacHBnSXloNFVyNE1yOTFBOW5VbHM2T1JYRGJt?=
 =?utf-8?B?aXlxRWIxbUtQLytUVWM3djJmQTRWU1M5d3VwbXRQcTFRQUhQcUQwWm5RbmpB?=
 =?utf-8?B?amxkTmZacUpkV25GVVBXeEtHQUo5OVZ6d3AzYTFMbW5nWFR4WDdvTGV4dWh3?=
 =?utf-8?B?N2ZPbW1OL2Q1TjFXKzFnL2ZpSHFZT3pTMWZSSjJPc0psYlJwdkIzVDNielJ2?=
 =?utf-8?B?MUJTakcrWXhDL3RtT1RYcWk3eUhpSXkzUFRJTVRCMWZyWVBSVmRua1Z6SExN?=
 =?utf-8?B?MkVUR0hzdDJuMEpydXdjNXFmaEdEK1BaajhRQlppVFpZcTQ1eDVURUtFZVor?=
 =?utf-8?B?ZUhlQVlYNFhaNE81L2djL2tka0FZM3JjM2toSFNNY1A4U1FTYkJiNWRWa0sy?=
 =?utf-8?Q?xUka5+RLHA19QCQoXxxY0Wo8CpaRX1cldrCe4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm9GMkIzN1laZ3ZWYWZmSFY4eEYxT1h0ZHZzUkhSMjRRNkVxR1ptdHNqUU40?=
 =?utf-8?B?dWNHL1h0c3Rpb25GMnlUM0dmN290LzB6eVlURHUwbFU0UVZTRnJOaEM5RUFk?=
 =?utf-8?B?clFXc0VCUStRN0d4Q3YvMm5oOW1KbkIrVDdQbXZWbFRwemxLVTROVFgzMzJ1?=
 =?utf-8?B?RzNwZGV2YlptTU84Q2NIZW5uS005SlZjOTNybHFOVTdXQ2lWSHRseUpSMTNo?=
 =?utf-8?B?aEhiZ0I4SXZpT0EwaTdhbng5ZWpXVDFQbDRrWFZSN0xGeXUwbmtJRnBiU1lE?=
 =?utf-8?B?eTdWODRKQi9mZ20vMWJXdzBGYkZOOXlWczVyM0Z6eGw1WHVVKzVWT0dQd1h4?=
 =?utf-8?B?WGFUL0VzcUJKbkNuY29jUU9TSncwU2tOaWhBOWZBQW54MkhaMHZkL0FXd1Ny?=
 =?utf-8?B?dFJwaTZxc0Rad2p6Ny85eWR6RVc0ODIrUitjNkZXMElYSXFrSHNsTU1IZEZi?=
 =?utf-8?B?eVc5OVk1T0ZDV2RhaUxReTk0bExYRXFFK1JQa1FJdVE3cHZ6Y3ZIeXBQZ00v?=
 =?utf-8?B?WGthRks5MVFMS250VElZK0pwNUNibWkzQ1M3NDR4dVlkVGViMXAzclhTa09u?=
 =?utf-8?B?S0dEbSs0UUJxa3FneHJvYUhLcllTSU83eUVaWEx1L24vc2tILzVFK3JDQ0hp?=
 =?utf-8?B?MWFpSys1OE9NSlBpQTNNQWtza2tuR1ZWZ1laZkFweTZlSDc3S1A2eldnVW44?=
 =?utf-8?B?V2c1U21NQnNlVDd1cVB1U3c1VmJMdGJ6UW9jdDdMb3o4MzNKbEtVOTZyeUNo?=
 =?utf-8?B?TFlOL3JIdU9WcEdkQTQwa3VFVGJkNmdqUFhwODZiRGJ3Q1IrSW1HSnFEbVRK?=
 =?utf-8?B?STFsTVkxTitFQ0VmczNMd3plVTZNSHlIc3F2ckg3aTVCbHI2cEJrWFQ0NG9r?=
 =?utf-8?B?SWVzU21sWGxNa2lGYk1zMTE3di9VODZkU2lDNWJWdzVQK2lyaW1ZS3hlMGZn?=
 =?utf-8?B?VXAwY3p0ODMzSFJldkt2ejkwNTljZ3BBMU4yN1R1U2VVMFhnMnovamNmQnlM?=
 =?utf-8?B?bUt0U1pMUkJsN1M4cHZmVTQrMFdjczdYSjRFMEFFQm5iUG5ZdHY1SmFSMURO?=
 =?utf-8?B?OTBxM0d2R2k4L1E2a0dkdlRKTUpPNzdJcU1sbndKaVNBLzZOZDRKeEVDWkVs?=
 =?utf-8?B?R1h0WTR6YVErVklodURwU1gza1F0WktnV1dXU0hlR1VaU2hkVEEzUHYvYUdl?=
 =?utf-8?B?Rm9XbGdyeTZmYk9OMDhRRmY1QzBGNHJ0QzJyY2VDNmpXRllvcGVDdUtEN3RC?=
 =?utf-8?B?c0UxWnVqa0FUazFqTXZwWFA3VGtGZFJpMW5zd1NGaEZlZndxdGg0YVgxL0dq?=
 =?utf-8?B?bzNZVjNOcGh4SWUzeHpKcmVIYlJEV0NQeDNWcjNWVFhSamM4VGdZR0ZLZEpR?=
 =?utf-8?B?VWJacUxzSHpIS3VZdWJZNkxSSGZsTjFaOGtNcnhWbzJTRVVVa0F2TWlPMjNp?=
 =?utf-8?B?c1lScXhDSDlvUytQNFp6cUlPWkY1aExPTFRTTVdZRUMxVEpDSWtwZGdBTG9o?=
 =?utf-8?B?Y3A1ZWFMTzA5SU1pVjFjTlZLM3JGMGZMWUZ0RE5VMFFQck0yNm1sQVZIWDFt?=
 =?utf-8?B?Kyt1SWNmdkZWVzg5QUlrRkd4SUhtd3lHcXJXZjNoVUp5aHNpV09qSzFpQXBt?=
 =?utf-8?B?VWRqN3k4ano5RWttelV3ZXMzdU1zd0I4TmlGT29hMWdCOUdFTUNLMGc1NVpv?=
 =?utf-8?B?QTlPYTN4MUg0cmUwRllwYk9LSGxtN3JITHByYjlHaXJKRC9USmFRYXczN2Rk?=
 =?utf-8?B?eUNpMHp5cnduTXV0dE1ad1ljNlVuYm95SCtLYzcwRTNsMjFGRlpITGVEVVZQ?=
 =?utf-8?B?dlBUQWxpTkpoSzVkcnFpUFJCalducnhOSlh1YVh0djFlc3VkR1RCODluL1M2?=
 =?utf-8?B?MytFM2RDanJIdVEzckJFQW1VNFBnVDVEWGJqZ20yVHNuQUUzb1FzRnJZeHNw?=
 =?utf-8?B?MnZmOGJIVzZrMXNCRGpiTHliTWIxTFVvSktZVnRWSHlmMk54MTdLWHErY0g5?=
 =?utf-8?B?ZHRENVp3Zk14SmQyL3d6U1NSQVc1eDdhUEhPSTh3a0lxdDBFUmlrZ0ZiYWdl?=
 =?utf-8?B?QkNaOVBVMFU1aFluQS9LeU5DcHVpV3ZtOHlTYXpSUXBVQXJ4UXAzY3V2T0o0?=
 =?utf-8?Q?zp2I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac137464-518c-4b74-da2c-08dd04ff18a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:53:03.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTGBBSplcryIC1HMs5mNKXcuLd5/dPYTzyA8lUDtilA3NVu2Olygw0363iYd+HcJ0O7PYMmqGUFmvbvQmT3Dhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

Introduce the helper function pci_epf_align_addr() to adjust addresses
according to PCI BAR alignment requirements, converting addresses into base
and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 39 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             | 13 +++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..a3f172cc786e9 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,45 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_addr() - Get base address and offset that match bar's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement, nothing
+ *	  return if NULL
+ * @off: return offset, nothing return if NULL
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ */
+int pci_epf_align_addr(struct pci_epf *epf, enum pci_barno bar, u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	if (base)
+		*base = round_down(addr, align);
+
+	if (off)
+		*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..20f4f31ba9b36 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,19 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_addr(struct pci_epf *epf, enum pci_barno bar, u64 addr, u64 *base, size_t *off);
+static inline int pci_epf_align_addr_lo_hi(struct pci_epf *epf, enum pci_barno bar,
+					   u32 low, u32 high, u64 *base, size_t *off)
+{
+	u64 addr = high;
+
+	addr <<= 32;
+	addr |= low;
+
+	return pci_epf_align_addr(epf, bar, addr, base, off);
+}
+
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


