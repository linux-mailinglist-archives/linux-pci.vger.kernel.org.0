Return-Path: <linux-pci+bounces-12525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1C9666A2
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 18:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B9E1F21334
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60B1B81D4;
	Fri, 30 Aug 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kcFlpMpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2053.outbound.protection.outlook.com [40.107.241.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263B1B81C5
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034501; cv=fail; b=o9Lyk9rS1slGlPegKHmIrxTW0U1aJFCG9LRKj+yjlSCA4TdDyviy0uc6MIZVgfGQxFngVek58bRORrJ0/ampLCaFqjKojKSVwArcSwqvpTcHzX2RaoccIbU95a1FsmMrZjd1eiU6YT2TKc0S4WURcKbGHnH/NdPGMgyHZb23OBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034501; c=relaxed/simple;
	bh=c63hnSGaQL+74wUrfmhftbt0lPCYjwaIauLk/IC0qBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ibdxbnBvsznubZ3v6PPFznxABFbW27IPSpQL7NcOiZuSY2qi/ZelwbgjIVp0uWooQNsAKfKuwE8C7gYiTmBfMLmI56vfgkmBw5wxV2v3OK3rCqkUC4WGhyVzRmoIEtgptxg83/NDH6oSWkEFeKXtQ1j1wIFzxf1dDk6IUqYEH6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kcFlpMpU; arc=fail smtp.client-ip=40.107.241.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc0IiX4luGK1ruO+dbeccBFGEuDQ3S7GF8zOj5oCX4wYNOPf5Bcp/PnpI0IVr8t6XoyZbH4wLhfzuPMxpcQzZXfG+GF6PnTU2WFhGsDmzijGOawZ+ATyrjXaT8RvLL3JKkVGzz6TRhYFp2Md6EBU0zCnrsK3hAyND8SpFnVgazJPVXa4qyYy6sZ9K9UXt0KUt4m+n3AM683Gn37wzp1Eib8sLm62EaQy9T9RWzjtjcxHkv6rHfec0ZrvgTX67AojI2eW1m94i6lgu00DY/DK+5g0eeE1dpgzK113MGgw9y7Pj3l7bUVm6UNMGRLZaxKH8NyTk+tmccx6M1V8aueTwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A60fAR4W74Fg8ZBGL1FFQyIO7EMsn+tUQqRpHA8BduE=;
 b=MTfK39MFyv6lriktsaqKL8XvZXv9eUtU2Fos/pAOzldVPNmMLb8rDpmbAq1J6mWI3qiJZVNM0XqJwsHAotM6FqnyHDWTpCMOWlRSrpN9UCLcRSAmHICe3deV4u4jRyW5V8YGpxT5PhMbkEXskpRozSmX4ABEV8FvUAZGdDdG/uT4L1pqpOOkK+ZSBkN9NIk2RjZ5WDlsawaZ1gX0uokfP5cK8Q0fy94us6zDnLDo8ZlIrnXSKCIZVDp5vFbxChV+mE5aPMuJ7WEh60KJICGLAvasp+9mtpwJosVVtul0931sjUKl9KLMjUTTkONZHciA2uDr8lfGWkAu3mMdCYh8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A60fAR4W74Fg8ZBGL1FFQyIO7EMsn+tUQqRpHA8BduE=;
 b=kcFlpMpUrpHJfagswZYQMWptC5KXDeYu7bj2ntQNCrB3C98/z5LkcTSUyn0xql7dE08QQc5h0yoQN26/dl/HF2d/AuXwwRbmoYGuecUNkgyJgZpDL1l0ABz7JKdHsRDQsGziqYbFM/N+9qwN5NkifVUIH7+65VPE1udRDMIYZniU24J2J+FGd3PGXCJJDqc3iQ+aOG1L8YEgOIgJyzV3aCvjL7evI1FucFYpg4cYDT9SPS8s9013z5YkUIVKw75qK03U82JGUP7nOe06gTgr3Q+Co3IwrWGOjUY/VgAtATUcJhw/GqPm3dJGAPIOn7Hu4o/cB2Tev3L65qQWZtwMAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9295.eurprd04.prod.outlook.com (2603:10a6:102:2a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 16:14:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 16:14:55 +0000
Date: Fri, 30 Aug 2024 12:14:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <ZtHv+LN8jypZgpZT@lizhi-Precision-Tower-5810>
References: <CAJ+vNU2YVpQ=csr-O65L_pcNFWbFMvHK4XO44cbfUfPKwuw6vg@mail.gmail.com>
 <20240829212235.GA68646@bhelgaas>
 <AS8PR04MB86760487CB68BC5AA90634AD8C972@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAJ+vNU2e9__ftVct0zY56HGTkUyF_QEpEDN6_n5uCXCnQwo6Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2e9__ftVct0zY56HGTkUyF_QEpEDN6_n5uCXCnQwo6Ng@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9295:EE_
X-MS-Office365-Filtering-Correlation-Id: 04896154-0119-4732-ecc1-08dcc90ee2cf
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bk4wb0pnN2JsRjFkZjF4UVp3Q3RKTEpPL3A3MG5meFpKTDUyblV5NURxWFFR?=
 =?utf-8?B?eDVPMmRybHZObmJkYnBVS1E0dGR4em5wWWlVSHpkVHRDaXdZZ1RPTWQrU2wy?=
 =?utf-8?B?enZGN1RBUGVaQURQR2ZmQW1kL28xOUQ5NlliRytKb0NYQUtjYkZlb25EUkRq?=
 =?utf-8?B?MmZxUzgrYktodWJwQU1ZRDltQ21CZVV3NTZpbkF6UkU2cDRjaDdIbEU3RWhi?=
 =?utf-8?B?Z1dhS2tVZm52RllnSE1aZWJiMk5PWGdLSFZ5ZVZPN00zK1RGbGFoWWJaMGVP?=
 =?utf-8?B?ZVo5TnJpcW9lNmlvUUFtVE5IQWtFOVNxR3ZNY2pCamNSblFhVXR2aVNJcHNH?=
 =?utf-8?B?cDNmTkNmYklwbnRzOVVxVGdhR2FabnVmWjJQQTlJNkQ4UEZxNFBTMzFlUGx6?=
 =?utf-8?B?U2JOdEwxNnhjdzVEOSswYy9JZEY3T1krb3F0TzN3eVhZZjRhdkpzc0hubUFx?=
 =?utf-8?B?L2RRMGliRGxabVErL0kyN1FjdVBKZ0w4UFAyR2VydzByd1FFMzV1V2pmK2Vs?=
 =?utf-8?B?RnRsNVZkY0czQTlqTkd3NjFncUhPNWZsVjkvWkJTMGFMZUZ4K3NyZHBzMm9E?=
 =?utf-8?B?MnJpTGlwSWZwYzF1clozYVRKeGxRZUgvQ3UzeWNuNjJlL1hKSDRnNlU2N1FH?=
 =?utf-8?B?WlBxRDdGT2lYNXdFaWJqTXhrRGNvYTZpb3NIWTRMRnpiTjVvK3BHaVJoN2Ev?=
 =?utf-8?B?cE1RRnRBNVpoNGp4bU5CaXB6MzROUmJGK1V3TFZ1VW9pTS84TnZmQzdIWWFO?=
 =?utf-8?B?dnFCWWtkSVl3b1Y3KytMNkplUDNhcUFYclI5VUtobGtncTlOV2N5TmRGNWJB?=
 =?utf-8?B?ZnNEUklvRnZnRi9uWCtZczhmemRBOWcrUHByREFYd2VrUGtnWlltY3ZkUWpE?=
 =?utf-8?B?ZVBrV2ZScVowTlNIYXprMXFMNEg0UFZwOUV2dFcxV1Zkd0ZNUzRkTkdTNERR?=
 =?utf-8?B?Zk9jeWhmY2UyU0h5Y3hSUWMrWExYQXlmend3MVRpdEk0eHYwRjFaa09pMWcv?=
 =?utf-8?B?RlJBOXpUWlNqSENLLzhSbDh0cHBqQmtGb0U3bjFmNHcvMEJaZ09VV0NDbHE3?=
 =?utf-8?B?MGw4c0hxV2NjTDZNNko5OGZ1aVRpZ0h0SjlTVVdVVHl3elRFdzQ1azdEY3ZP?=
 =?utf-8?B?R1d3SkdmVGJGTjFVWGRsZy9FdG5kR0JycHcybGVWR0pSM2x3aTdHbVEvNW4v?=
 =?utf-8?B?UzZZenhIcVFnK1BUWXBLSEp5OUNXZ0R5OXV5R0lVeEZlMVA2MHZnSW5qc1RI?=
 =?utf-8?B?K0lyQ1ZIWU0ya0JGN0tmZGZpMGY2WWNKNnhxREQydEdsS092bGRhMUE1c1Rv?=
 =?utf-8?B?eXhlZENlTHplSzlvbVo5cjBxZXFVZHU2ejNHRTZuYUtLcVc0N29iU1pNWU1M?=
 =?utf-8?B?ck12WUppSjZzRGVzNFRzaisyZUR4bWltRXpOTWNpY3pId3YxdHZZbWxuVTJQ?=
 =?utf-8?B?b2pIUVd1UVE1SHU3dFVpbExuUE5qVFRQRisvUUVtL1RkNGRLdmJWVkxkTktN?=
 =?utf-8?B?U3NrTU14VFlOR25ZTmM5ZE45dE1tWksrMmowODRvSjZjdmlJOTJuWVBBRXNS?=
 =?utf-8?B?ZkJBeWhlWTZITkJ0T0owMDdNYitRRkNGdm1pWTY3NXlPWGRWQmsvSnQxczkz?=
 =?utf-8?B?cWpjbkFDK1hLS1NqS2tGUjBETHNPazlpdGFXelVWUnZ2VStLMXlOVGlyblps?=
 =?utf-8?B?R1gwNTZWc25abjFUQit3SDFMNTJrMG5FR1AxRVd2ejlDbzI3R1h6aHdMSmpG?=
 =?utf-8?B?WmNwY0I0SXFsU3dwQjhnYUpxUmMwa0Q3dHd0dnd5c2h6MURISno3OXhIWkhC?=
 =?utf-8?B?cC82clljMWRJYm0wK2JNRmtNQklucEpEQ1IwNVFkTnBuaEh1OFZEdndKbzNG?=
 =?utf-8?B?amVaZlAzK1FaanpLcVYyMkhyRGNtY3hHTElZU3h3bCtiN2c9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TGlpSkQvNVRPMEhzSGRZbzZ4c0dWSVMxWDl4NXNRVnc4ZE43cVpGWGNhYkg4?=
 =?utf-8?B?RFdSRnN0bjBkSGFkRW9DRmJmSTQxS1FtYTVhYlM2alF3eklvbXNobGJ2dUpl?=
 =?utf-8?B?R0IyWVpXdTB0YU84Rk1FcCs4MS9qOTkvWFJGYWp0Ym8xTXdDSTZOVEpta1BV?=
 =?utf-8?B?bnl2ZE9RWkZtRkJaYjE5bFRnWUtOaGpsNzdwdTh3UGJGTzdlaGhqYW13cTgr?=
 =?utf-8?B?Q2dxN05sV25FVTBsVkR5dGFOeXlyZTNCYjRubko3dWxHTk9EYmcrYzZERmhq?=
 =?utf-8?B?UTJLMTNCME5KczNWU0haT3hYZDBKSE1JZEQ0MjFic0cvMzM4cEQ5SlJETi91?=
 =?utf-8?B?VExVWUZ6L2R2aGNxOWhuSzdtZDdOQlVCVzVVajc4RXZwVVJxQUJzb2x3QUFq?=
 =?utf-8?B?WjFKKzZvKzlaV2J3aWJqQzNlM05Nc2tiTTdlQVdoY2VWbGpDMEdWRTlxM2tB?=
 =?utf-8?B?cW13UzlPWmJZTFJwVWEzNUYwVUZCSjFXcDBzWEhONDZlZzFMZ0NhTzVLZUtN?=
 =?utf-8?B?UjEvR2p3eE9xT2tkSW5EamhUWkYwUXVjeEFUak1Nb3ZDQlhrWGVya2RLUjZF?=
 =?utf-8?B?SlNMeUUrV2RMQUdvMGVwdTFUdTA0U3NWNExZK1lLekd1b1VsWnAwUTBrZmMx?=
 =?utf-8?B?RHVJTWl6aTI3OHJPWUZ2dHBodFMydkw2ZWt6U05ycE51QXhLdC9xRXBGQkgw?=
 =?utf-8?B?NmhobnVJc1JHL2paOCtaRU5jVFFrZ3hQK2Q0VHNTcDFoeXFBR0NiUGgwREdq?=
 =?utf-8?B?aTJac3VadHdObWhDWWprMExJQXhhME1CNThEUlVwSFgwZ2NhbUtwR0dNenhW?=
 =?utf-8?B?WGlPaVJxNFZ2L3BwSE9OSEdaM3p3UVh5bkQ1K1JxUWNNZENyTzBsRHNZem9l?=
 =?utf-8?B?Yk85d0RCcVlhMVZXN0pDWHpwaENlZk0yaCtkNmc4bEhyMzIyeFpCeHNjb3N5?=
 =?utf-8?B?S1lVWFR1aWVwamgzQ0tKTW9VMEV3Y3I5WG9hQTRJeTc1VElTZEY0RXlQK3Z0?=
 =?utf-8?B?MWd3VE0ycVdMWC9Bcm12cjUydDdZOGJuQnRQM2hoMUNhbDBjNjlPOUlPQ3po?=
 =?utf-8?B?cEtRNjhUNUQxSXdaVWk1dVZXMndlVTNDTkNmQU82R09ScjllWVhTRWg4V3F4?=
 =?utf-8?B?bmNUMkZrVzUwNG9kaW5iSGRlUzA0MHBQQzlYamZZLy9oamd2NU12aldMK0Nu?=
 =?utf-8?B?Rm8wSDNjOUxrek5FZ2lpbkNvZE5VMlNDWUpOREhzUkdSZU1tcythMk9hdHpU?=
 =?utf-8?B?N1V6bTdNdmtScWJHV05hNjgzZ1hpU0V1Q1dqd0V1UGc1OWNBSktXbityM09P?=
 =?utf-8?B?ZFhLUWZYY1IvYWtzNGU5S3hETit6ZHg2WUlFZjFRSmhxTk9TY2dxdjF3Mndy?=
 =?utf-8?B?akxLNkxDSGZkdzhKWVg4aGhPajlZVGtrZXp1Q21nOFNyUjZlM2FUc3Z1Y3Nv?=
 =?utf-8?B?RjMrR1h4YVEzU0hnUTBLdndLMXRIRXU3T1UyWHhrRm9GTGwxempvK1l6bkd0?=
 =?utf-8?B?S0tKVDQyRjNacUNnd1pUWU96eHZBNU85RHVmeHRjMkhwbGgveXBzZ0xDSThG?=
 =?utf-8?B?MDRIZ1FMdXl0eXpkTlM0ZEcxVTJEM09PbUV2dDF1aVlHVGZGeVErTk5tamh6?=
 =?utf-8?B?RlRpdVNWcG1ZREl3eGdsbWp4WmoxRHcvcWFxT04rdHppV3FUOGNHdnphMDVB?=
 =?utf-8?B?dktXR0FpdlptL3A2YUpIYWVhS2tSTnhhTURMUGFlZ2xmbzY4VjhHTVFmZnVo?=
 =?utf-8?B?VFh2R253WXBUNFVBa0RKOTJTdkdaRXY1VW5pSUkyTEE2MnpPM0txK3NIdnRO?=
 =?utf-8?B?R3UzOUR1TWhZayt3SnBKeVV4UkNNYTVvNTh5SzNmMk1UcWg1dlVSRE12UUpN?=
 =?utf-8?B?b0RIeFNXaUhsNEk2MFUrWmFCYzhaSDNqZGJIYTB5YWFkdk45U00rZlo2a1NG?=
 =?utf-8?B?MjA5ckFmMlI0WG01V0lnYzFERkZFMWRIWDhySkU3WllGQS9MNjBrZExwZ0Zk?=
 =?utf-8?B?R2lTUkptVTlBdTdJaC96ZlJ1bkI5dmUySzlYYVR6eWwyWUtrajFiOGxQWllE?=
 =?utf-8?B?MWhkYmVRVGU1N1NOeUc0Z2QxVGtzUVJhQk5yVW1VSWcwRHRwSkREenlIeEEz?=
 =?utf-8?Q?aO8vBLJtkVf4FGFKbXLEFTueA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04896154-0119-4732-ecc1-08dcc90ee2cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:14:55.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyYACsbuhq1qZM9I6AIlz0Zfgt63LDQJR6za+Tr/I74CCAwldISb3sE2qbrf2UKTzCcv/up2Dduo0RAyP5QqQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9295

On Fri, Aug 30, 2024 at 09:03:09AM -0700, Tim Harvey wrote:
> On Thu, Aug 29, 2024 at 6:50 PM Hongxing Zhu <hongxing.zhu@nxp.com> wrote:
> >
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: 2024年8月30日 5:23
> > > To: tharvey@gateworks.com; Hongxing Zhu <hongxing.zhu@nxp.com>; Lucas
> > > Stach <l.stach@pengutronix.de>
> > > Cc: linux-pci@vger.kernel.org
> > > Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
> > > host controller
> > >
> > > [+cc Richard, Lucas, maintainers of IMX6 PCI]
> > >
> > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > Greetings,
> > > >
> > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > > device and the device is not getting a valid interrupt.
> > >
> > > Does pci-imx6.c support INTx at all?
> > >
> > i.MX PCIe RC supports INTx.
> > Add pci=nomsi into kernel command line, can verify it when one endpoint
> >  device is connected.
> > Based i.MX8MM EVK board and on NVME, MSI or INTx are enabled.
> > logs of MSI:
> > root@imx8_all:~# lspci
> > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
> > 01:00.0 Non-Volatile memory controller: Device 1e49:0021 (rev 01)
> > root@imx8_all:~# cat /proc/interrupts | grep MSI
> > 221:          0          0          0          0   PCI-MSI   0 Edge      PCIe PME
> > 222:         14          0          0          0   PCI-MSI 524288 Edge      nvme0q0
> > 223:        382          0          0          0   PCI-MSI 524289 Edge      nvme0q1
> > 224:        115          0          0          0   PCI-MSI 524290 Edge      nvme0q2
> > 225:        521          0          0          0   PCI-MSI 524291 Edge      nvme0q3
> > 226:         53          0          0          0   PCI-MSI 524292 Edge      nvme0q4
> >
>
> Richard,
>
> off topic but I've seen in the IMX8MMRM a claim that it supports MSI-X
> but I have not seen this to be the case as you are showing above with
> an nvme that would clearly use MSI-X if available.

IMX8MM should support MSI only.

Frank
>
> Does the IMX8MM hardware support MSI-X?
>
> Best Regards,
>
> Tim

