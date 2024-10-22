Return-Path: <linux-pci+bounces-15040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F969AB73E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B17B220F6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5AA1CB534;
	Tue, 22 Oct 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zu3fqDxW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291A1C9ED4;
	Tue, 22 Oct 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626982; cv=fail; b=GDD/52KhkYLJv1LrbEPZrdyWrKwS1TBoOHuwNPy5zjmNaSeafkm5sxv4Gs6lG2k0Rwz6QyfV7l8M6gtfg/VS8RowE8cYXW7sa1SmFzRtQhmcTXWrpn+xfGOdMYdmPW/X8//XAWXArO6rzhRE3e5eznDVoWVFnR2lx/BtojGVTQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626982; c=relaxed/simple;
	bh=xMP8JgwiT3uG7xApWhN0rNrUWzrg3/LOsgtfPzRF9/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pVLrNGiVO7s6xrtN67Fr7q4TpQCeIaS1R7h6q6JHqEO46ebp2gJEQzpkfOMlbu66iNDs0kTReAcmLV8mPFVmmfqj5T71C3sLeRoR1c67uaU/a2Cfg69mtWA48D8eOdRDJrLk6srDpASdbzLm6bEb+a4uKPy3xzCqUx5aWm1t588=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zu3fqDxW; arc=fail smtp.client-ip=40.107.105.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2ljtovkkqno45bDe+bHSHsUAwTfRqCtH93Jm3nihe2d/Switq1cfHHzsH9IBndpJ9eRBiy/OGMuWm8i/PSNy/ELSAYGWtnzubgK2qrqAN9/AcMcVI8ozGW67Y8QTvWREL8FQNMk3EQ9Pmj/NZEhUybZAiidJQ+AzfXPaPWg/LO28f6I08kUT9YZ9fBZruNaJbXz4stumsqqCirU6qs+v/qTR6jvETk8Bf++zv2LV9xV6vGRO4hOhmT1vEmRc5pqOPx2Cy4xmLK5kg7I0uoV3sitRKNN28H2L95kaFUV1uYlATUnj0ojSosjkFKMEB+l80h4FiqPHMaG2l03yLd2ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v75GKoVjwYCkftZ0NJeGvU6bhT+W0i/6H56rch2GriQ=;
 b=wThA8GWXBdMkYzTpaLDchizaIau7MUMQt8QEznvB2W8thcLmCFsHGyyqDRBzb/ZmkC+g93EZ4IbrdJjVthFVvCRxthxDJCawft2PNP7v5QP99ExuEPNOGqwsW10g1mq1YWUCKbehVHlG+6X+NqKlBvopLNVA2OqDFWOyDL4TNWOPwa8pYWe0uFBfMlsxckC9U8BEPyodOnzhUwfs9x8oRRobwkwSGbTtDp1CM2TEMFT8knKTRG6LaMQyTCqaTkQG79Vl1svlB9Iv1/KwGROenXLx7+2PsrtiyXbXKQFw2mm186bgRU49TbCECrwlq8J+V4Fek+JssB8gZ0moxuFATg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v75GKoVjwYCkftZ0NJeGvU6bhT+W0i/6H56rch2GriQ=;
 b=Zu3fqDxW/MQmonpT9aC3D3P/LCuSYHajVd9uZZGAr/hokyM+a1mgU0Ln2Bzzdsoc/vyXLkDB/I4H0MvlpAEeFTGvVP/elTX7xsZSJyFBF/GtoizCIdPBUgknaaLhvh6O4xRjhxzUFrZhp22ttkajvlBZOWXXaL3tVmbP3KV9v97jNN7sJhMpetsRoYTFRdhXBJwhZ/V7N0nhVdBhRWB5ormP5tS/YPiMYo0rOCHyybr1QYQCN/PJIA66M326S2dhw8fT+FlMUy7M8rRLxlNahqL3p4K7LBOqkmzP3KJqk/MpvJWaWmYSP1W+e6Mpfg3QbhFEuKMSs6piD8ZRVvYpoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10998.eurprd04.prod.outlook.com (2603:10a6:800:262::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 19:56:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 19:56:18 +0000
Date: Tue, 22 Oct 2024 15:56:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, kw@linux.com, bhelgaas@google.com,
	lpieralisi@kernel.org, l.stach@pengutronix.de, robh+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v4 3/9] PCI: imx6: Fetch dbi2 and iATU base addesses from
 DT
Message-ID: <ZxgDWeaAVuz2ALxo@lizhi-Precision-Tower-5810>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
 <1728981213-8771-4-git-send-email-hongxing.zhu@nxp.com>
 <20241022164801.h7eh2gkuiy7pfkmr@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241022164801.h7eh2gkuiy7pfkmr@thinkpad>
X-ClientProxiedBy: BY5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10998:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df035cc-ef6b-47f2-1549-08dcf2d397e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHhmVHI2MXZvakw5a1YzTHRGSVZ2a1lpKzFlbkpLUjMzRFJCKzhyRlliaU5H?=
 =?utf-8?B?RElxTWZRbDZQVERPSksvNTZMeVk0YzE0bzN4YjN2UUVqdkNGYjA2V3p1emlr?=
 =?utf-8?B?VzkvSUdnOGpzb3dHMDB4OW9icllNWjYrRU1ZaTBsU1FVU0FrUFJvNGR2STVo?=
 =?utf-8?B?aXBTY2hWUDdVV1Q4S2tyTG9wWUZMSVBGQXlWZmkrYkwzNmU5cFNnbkp2UkZ6?=
 =?utf-8?B?czdMRmJGdTMrQXZacVhML2JoaSs5bHloS01xQit3TEorbVBzdjllZE01OHhX?=
 =?utf-8?B?ejFPQTNvakhXN29teksxS0xxTWx4aGhKbWcrVDRaa2dOeHFqeFNOVkVkV1RQ?=
 =?utf-8?B?N012cEhnY0ZZOTBaQy96V0hMWTBJSnQ5S1o0cTcvUVdocFV5UlNpZi91UGhK?=
 =?utf-8?B?SnphUDg4N3d5VVd5cE41cUpobVFhM1gyS3lnVEt1b3NSbC9MYllQVE80dTRV?=
 =?utf-8?B?Z09FV1NqZGpodlpZTkx1MVlNN0xOd1N1d2E5WHpCa2wwT05YemF6S2UzK05V?=
 =?utf-8?B?aFlydjVjei9GMHNGUUR0aFMwRnZRcS8rcks4S1hHVndUWGhBRWYzdjE3SUN1?=
 =?utf-8?B?Y2lqQ0d5WWFNMU9HbTE5ZGswb0Y5MFF6Rm9DRkpIbFZoMFpoSzRZdFR3UVFQ?=
 =?utf-8?B?bEk1cnZuZVE0VW9uSUlhOFdxY3FXQ3dNYnA3cTJ0b1RVbVJYbVBSbktlVjNL?=
 =?utf-8?B?RjNlbzJubTh2NkV4SzAzSUtVN0VCeENHNUNrcTByd1FsZ0pIRzR3bk1DNmhT?=
 =?utf-8?B?OEpreW82UUwybUo5TGFMQXhISEp3OWI1cldILzJzNmViMERHTDB3Q0sxVHZi?=
 =?utf-8?B?MHpYczlETU54QmJPR1Q3NkJYRjVvbzcyZzB1ZTh3R2FzSm1JMy9CNEhMb2tR?=
 =?utf-8?B?QlRnQzYzRTN6YzZCRCtsSTIxbnRhb3A5TUVlN3RsZzRhMWFUUFZVWGs0ejNN?=
 =?utf-8?B?ajNzeVl0Unc0ODVRQW1xcmlLa2dVVG5Jb2pQVlBiWWRiZGkzT1JiYWtLQWdt?=
 =?utf-8?B?RThRUUdnd0RYbnYwRU5TcTFlYWdkb0xBZ0xqaTBkWWdCbHdOVzg3UkM1ZW5q?=
 =?utf-8?B?OU1tUUpXdVdsMTQ5V2JBU2w4OGdzS2hOUVBTWmt0cFk3UkV2eWpmeVBuTjF1?=
 =?utf-8?B?K1R3U01FOHZxWVZxb2tnUVYrWW5hNDRuYnlvaU9rK2FuVkRDdUg1ekxJK1pF?=
 =?utf-8?B?YmM5dERQSzRDTGoxY2VkQ0xGTmdjY1AwZ0VnSXVycC90WGxzUEJqU3JPbnUw?=
 =?utf-8?B?WnFUQXZuVVdWS1l4U0J5UkJXSy9IWmFXM1NYU0FUQnRndXNtaVpYdjNSK0d4?=
 =?utf-8?B?blNsUEprbmVmNnl1L0gvdFlMcktyUjhpbUNGWHlZVTZxV0ptdW5kb0IwMTE3?=
 =?utf-8?B?ZmJKQ2RTZisybmZNM1ZyanJjcTRiWEhaUWo0MnVOc0FkQ3Rwd2dlZlhSSDZW?=
 =?utf-8?B?TEN2QlZIR2FuOHJuQ1crc0E0dXJKV01ZZTRxUE40TldSKzlyNWNhN0x5V3M2?=
 =?utf-8?B?VlU4VTRIdGJvOGxGS2NjRytkNHRsNHFqRXlRei9OajJja3hZNW45TlFDa1Z6?=
 =?utf-8?B?em9MSnFaQ3VEbzZyK251cDJqelJVS25RMnBveDBMWXR3WUhUN2JLZ2s2YzVk?=
 =?utf-8?B?TkdSc1pPNjRITHpDMkV4NzdtTVZvSXUvanRXS1pSOE1reVhxTnF4dnBsS0xV?=
 =?utf-8?B?K0xDYm1DMzBzamNpMXlRTXBqemE0eTdDYVh1NUdBNUkvczJSNDVVZks3ZlVm?=
 =?utf-8?B?aTRmWDZGMjRPNHAxY0VZSzZncmh6YkYyTUV2aUtDYnRkUGVqblBBU0pqaWxC?=
 =?utf-8?Q?R9VCnlMKkVrCfpu+AgRuVBYaVT2vh1LXcCC4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkdzdzNmQmlPZzUzR1VpQ2V1OEZHZWtEN0ppcE92bU1PbHVrRnhiZDB4dVVF?=
 =?utf-8?B?ajFTLyt5VEpjM3lCNy9EKzBQUGFzVUMydVY1eVpkYzBLbktnWjVVZ0pGcjRs?=
 =?utf-8?B?SFV1SENSNmt3NEx2QWozMzNuKzRJUGVRb3BYeENwcDFid0NFcnJLUzZtYUF6?=
 =?utf-8?B?T01HUjkwWUxjZjRpVThITStQYXFEZHJQVFY4NzVoblhvQnVEQ21hd0dya0I2?=
 =?utf-8?B?T01lNWV0NCtoaG1OQ3h0ckJiYVExb3RHMXNJSnJXemt6QXNFRk9xVlJBKyt3?=
 =?utf-8?B?c1c2MkZ5bjN5bSthbWoyZkVMSHBWVUpJdDNyaWFObUdNaDU0cjBmT1U1U2la?=
 =?utf-8?B?MGhLbWR0ZHVaVnFHOGVHY2dvaTFJVmV2U1pnSUxmTHd3ZkZta2x1eHY2bGhM?=
 =?utf-8?B?UHZmWFFVMEtjNW1pQW1tVktrd2Q4c255dlU1TTY3SlpEaGU1SkYyaFIxQkhD?=
 =?utf-8?B?OStZQVZMd0p0cURwcE1idU5PRDNwQ0tFUXRrRmFwaDVGUnJPK1h5MDhxU0Ro?=
 =?utf-8?B?ZWlTM2taTjdsaFBHSUxKaWdYZG9lWXFlRXY4ZE1IRVlhL1JCMHFpTkRqb1N2?=
 =?utf-8?B?MVVMWUtOOUhIaVpsVlFKakNCQlVzNHozUlZRNEJoU0xvb1UwZ2gySnNOa21l?=
 =?utf-8?B?MmtLV0hWSUZwWWlJc0RQSE1GWTFlVENOOFdlUitZbGJ6ZmF6TnNFM2hzcXo2?=
 =?utf-8?B?aTFSejMyeWkvakNPYkhYUmtYeTBwWS9yVUZOcm5Vamt0UHRldEpNWWZod3Jm?=
 =?utf-8?B?d0YrWENBQndvNDhTcFVaUW9lYlFkb09LbGE3RXZhT3RyU3ArUmJxaGcvTkdL?=
 =?utf-8?B?TzF3UCtmNWFKa1ZnUXFXTURuWXpEVnk0RzBVK1ZFWExyak5oVWhRNFVBUGMz?=
 =?utf-8?B?d3hVMjV1ZkwzbDgzc1B5eXVwODhjdGRRdldpUVZmNjFiNEtZT3Vwc2Z6Vkxl?=
 =?utf-8?B?YnFNMm5UZzN6SWpIejh6d05IUGkyRUtudW1IYTNPTnRMRnZKR3BiZFJGVVZw?=
 =?utf-8?B?UEpDNXl0eVJZcUhDT1VhQ1NQNWFvNFBSNFBraDJOc1JJdTlzZllOS3A2YUdO?=
 =?utf-8?B?cDQ2SlZvWVBOSTNGamNhMVA5TnFOQThhVDFpaS9zdUFxRGtoYk0zSUUrNUJC?=
 =?utf-8?B?UTlEb2xTc3g2cnlxS3FVeEJod2ZLN1hrRlAyS09pbFNqbFJyd3dMZzg4L0Fl?=
 =?utf-8?B?Sm9HMlRseDNZWUtEREV3TloxeENYLzJGYlVSZVVCc0pIaHdWakhLZHIvZ2dU?=
 =?utf-8?B?Vkg4MTgzSENkcXZSdjB1OWpuckhJa2NEZjFGY3R0eEtoU0pTOE0wKzhKVjJ5?=
 =?utf-8?B?VHdrUzVTL2wxbUdmTEE0bTBTNWxaMjR5UVVYbVZKUVowckswSGx1V254OWtO?=
 =?utf-8?B?TkxybVdhcXlrd2lxL3VPcXBqSEZiZW1YRE15VnhwRU4rTXdlcjcxRWNsRFNv?=
 =?utf-8?B?RnNuNWp4d1FJRWticTVENGllRGQ5dklhU2UxWTZpSGh1SGhmcUhYZkpvUGIw?=
 =?utf-8?B?T0Q1OFU4Y2Qwd0NlOWFaSHZjQkpaMlFkeU00VWFoeVBTd09nUlpjdUkrbVRP?=
 =?utf-8?B?YUFOWndNdXBnSUZ2dlVJWUlQMDNKRXM3VU16VEZ2bUdCZ3hhQXRFcmlCWUFr?=
 =?utf-8?B?bU1NT21WVVlDTjhWcFJLZFY2YkZWaHhCeHY4TmUxOEtSS2pXNXJtQXAvekpB?=
 =?utf-8?B?ZnlxMWxEUXZXQk93aXpWWTBrUlZ2M2l6MHhsV0ltMmo2QkhYSE80Z2hzL0Vs?=
 =?utf-8?B?QUZDZkQ3ZVdCMVBzTmxMQTFGbkw5d2ZzTHlyZG5HSjR1NVhnOWhiMzhmdmVU?=
 =?utf-8?B?d3o2NW9hNkQ4YnRDSzhTMzVQaWwycWpBZlpiSzNQMTUxalJEdU4zYXErT2pk?=
 =?utf-8?B?b0x5bEREQ1lOa0cwYUxJQmwyOTZqSC9IQjl1QmtRS21Pbi9TeERISXFOcU0w?=
 =?utf-8?B?V283OTdwZlZSYm1ZRHFJQlBCSE5CLzh2WUg3N1p3N2tlb1J5Qm9wejJwWEZz?=
 =?utf-8?B?eksxbUpOa0lsTHFvOCtNYXdYUWNxRWI2bkx0VnlGQ2dwb2gvRmZabzB0RVhz?=
 =?utf-8?B?Qk4xcXpRaUx1aTdOTjQ1TWM0VzlUWHUyTG9nZWJtK3Fpd3lvZENZYWZ5TEpm?=
 =?utf-8?Q?wr6PkMZAX3m8/bQVwhtfiWS15?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df035cc-ef6b-47f2-1549-08dcf2d397e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:56:18.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sX/xcbkry59nOpIWHPhUOiHWB9P/u50qCLIRjdGygXRrjSY3k8LEox1utdK6U3NRWLrsjYczb25f98xfFEViVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10998

On Tue, Oct 22, 2024 at 10:18:01PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 15, 2024 at 04:33:27PM +0800, Richard Zhu wrote:
> > Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and iATU
> > base addresses from DT directly, and remove the useless codes.
> >
>
> Again, what will happen to old dts that don't define these regions?

Upsteam dts's have not enabled EP function. So not function broken for old
upsteam's dtb.

Frank

>
> - Mani
>
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
> >  1 file changed, 20 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 52a8b2dc828a..2ae6fa4b5d32 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1113,7 +1113,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
> >  			   struct platform_device *pdev)
> >  {
> >  	int ret;
> > -	unsigned int pcie_dbi2_offset;
> >  	struct dw_pcie_ep *ep;
> >  	struct dw_pcie *pci = imx_pcie->pci;
> >  	struct dw_pcie_rp *pp = &pci->pp;
> > @@ -1123,25 +1122,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
> >  	ep = &pci->ep;
> >  	ep->ops = &pcie_ep_ops;
> >
> > -	switch (imx_pcie->drvdata->variant) {
> > -	case IMX8MQ_EP:
> > -	case IMX8MM_EP:
> > -	case IMX8MP_EP:
> > -		pcie_dbi2_offset = SZ_1M;
> > -		break;
> > -	default:
> > -		pcie_dbi2_offset = SZ_4K;
> > -		break;
> > -	}
> > -
> > -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> > -
> > -	/*
> > -	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
> > -	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
> > -	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
> > -	 * above "dbi_base2" setting should be removed.
> > -	 */
> >  	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
> >  		pci->dbi_base2 = NULL;
> >
> > --
> > 2.37.1
> >
>
> --
> மணிவண்ணன் சதாசிவம்

