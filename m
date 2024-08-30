Return-Path: <linux-pci+bounces-12519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242496661B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 17:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65A1B2084F
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD921B4C49;
	Fri, 30 Aug 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nwuY+OnR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BEEEC3
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033172; cv=fail; b=BaYQxxewaI8VzTxqhGdkqvuPSM7nB8jCZFUTUHqeNdaaFa8n/ttw9ycMy3DK9LtIPEGJRnelefxVKoGJCOrpYOpFCDsNtAsjjN6C/XFwipS7syThZ3YtHFtFWAAHbNXeo76CBMoFpLTb8HDGrigZI9kp8foHH126Ke9ZLx8WHLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033172; c=relaxed/simple;
	bh=BMogESwXO+06KgFhPxhc9hCr9wxoXmNAbyMpARlqcbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UvMvnoMzjcP6MBQDRBrqFcJ4RAs5kPl6hF1S2mvsw5A5uk+9rnIZropC7ShgablU2XMdBUecDelzyag8PcpqKzVVBuWiC+9+sOJAwT4jfI/p6aOXY2yGSbHiMQcyoAlDwqk0TP23GEMuQPt1udMBNdf39WbLnIEADgej1nfURpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nwuY+OnR; arc=fail smtp.client-ip=40.107.241.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5dskHwZIYglg9woLEztQifE6mi8ZpVT7V8jlujKxlyDJ6RcikDoe/5sXNXbs4aSOoZlj0HIdBYXklRQMXu8a0amWYRfjEMTuDpwsRf858lS6i12rytZfh9yymNywpjkkdOC24RYB2d6ZwwRctGPBVZcs1NMUwTGTmzx/g1W79SWwkqfi7CVg1ckxU3BzYMysvcC6bQnfVz03a1cMHJYDmseFM4kX6dEQnpSA/WXOHijMdflwC4tF4ej16AidOGqpBMGg4HwFm8T38qZkI+ey+5Mun2L9l9kyfDRWo6e4r6pm+pGLZUuvZM70SC4RPlKe96kF59tdrxal65wR9O3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnffLLZP5NrtiLjAUi+ZYAMNnKykmZYmYZb/QGuj/ks=;
 b=Y1XqYnokgJQIIAh2zo9w3QtAMh0d3/UubMwpJfWjya1g8dcu9mCSUZ8eXvqLw2EzTOkYGceJR0ecDEwxbdmoHeNZr+HkGOIIDqi7A2n9fQhxES9FhBOOO+yVhktEsRZdqAtVdXNp0QdIrqBo//j5mV2hzBcDbPlefRjRytWYRvb/lmc8Ne/AFkq/w6U+7bsW3z34iZ655R27uEF+wCTnQC4uPyWlLHDjYmDBzRgMx1vY9MDKrQ2vbJnTFN41pwRb9gX9dHRMuQ5Dwygt1YZLII+C7HP3Mmgvm5/UIw9B3HxBwJswe5TBaMEZukXMB+DvrGiLYCjdlmOmr7XloWi1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnffLLZP5NrtiLjAUi+ZYAMNnKykmZYmYZb/QGuj/ks=;
 b=nwuY+OnR/+6IPU5WhG8DRksNqYyh+Yj3k8XE/WLadOaurCBHVsN+kblMn+/fQcNM0nIujl8nyL6BY7rgpcKmRYJHtkDEpy9EB1YHybJQbJWkJFe5fVVU3BfWoH82JwivhkVGMDkcAZ0qfS/8l9bxM72DuwDOpIg+odPAp4fwN/f++UuN7ZRrffKR3zY1EzlOwNKvQE12gSrJrXQSqQPtZpKCI4C/p4jn5yYTwI5jt2rurMwBhHVVT9kYxFrKXR0IA0zZF5pg+vyRYwU7qFat1FWBuORb/70MrLWfbW9sTwoUl19TLk6M4kf6FM/17pAWVVqDv1gFAnYi0FuQ6yTWhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10663.eurprd04.prod.outlook.com (2603:10a6:800:260::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Fri, 30 Aug
 2024 15:52:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 15:52:43 +0000
Date: Fri, 30 Aug 2024 11:52:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <ZtHqxfPgXo1RlZbC@lizhi-Precision-Tower-5810>
References: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810>
 <20240829220005.GA81596@bhelgaas>
 <CAJ+vNU0taRj3PgP1tgcK68C++x93XO-aitvn42Pmk3EoWuj7OA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU0taRj3PgP1tgcK68C++x93XO-aitvn42Pmk3EoWuj7OA@mail.gmail.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9089a75f-2e6e-499b-c45d-08dcc90bc91c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?L3dKM0Y2TWpvQWlXNXpJVlVFeUVYam1aVjcvaWIvdXdFN1dmaUtiQ2ZUNXBD?=
 =?utf-8?B?MVBBZTlvQzRPR2VTSjY1RjJWRXJOQ2dOUzIrWHp6N0srL0Q2M01zRHF6b3Rt?=
 =?utf-8?B?b1FUaVZkY2xTaW12UlMrTnFnNWxnd1IzWXZRb1hXNzU2NGljb0wxTG9vMEd6?=
 =?utf-8?B?Yk9lUFllRzhKT2hTblZ6Z25reDJWQ1VxUEV3V0Zhbm9aTTh1dnFIRVdpZG5G?=
 =?utf-8?B?M240YXZuaEErV1dZM1BmQndoMXRYRG50VkV1RFdxQTRCNVFheG92YzU4emFj?=
 =?utf-8?B?dWpJK2dSQllwa1Z2TUo1bG1yWHBLU2EzZjQrRTZST0JDZXJRMVlXeEI0Y3Jv?=
 =?utf-8?B?WjdTTmk4ay9lV2xqU2huMDBxeCt5aEEvVGhVbjlNMThUUFY0aWZmZFJia3dS?=
 =?utf-8?B?bFFFd2ZHb2hRd1I1UXpEMFdtWk5taEF3NFF5VGltV2YxOHE1REZJbFgxVCtl?=
 =?utf-8?B?WW54OFEvbzdUMG52aW1IWFdTVGhlam9OeGNCeVRjMjJhbW1VVXFqSWlYbDh0?=
 =?utf-8?B?QlEvOVhxVnNqSklBNGo1V0dtNDFIVi9SVUxVUTc4YWl6cE5tbWwxby83SndV?=
 =?utf-8?B?TVl2ZWs1eWtUMmdtY1o5Y0NiNHZMTkdTVjZUNGxac1pmRmlTZW02bDNRVGh1?=
 =?utf-8?B?Vlk5QnlpcExBNXltWVdUUjYvRU9sdzdDQ2JXY0l0VFZzZysvR3JzOG5vZlhB?=
 =?utf-8?B?YWVuSHdkdXBOcDIvNXhpQ0g3M2d0NVNrQ0NWNGNvMDF5N2VIeXN4cC9ZU3Rl?=
 =?utf-8?B?RzlYc29Yd0JQdStPOVVaeFBEdkx0NXJ0RHVjVXUwWVE3VXkwQTlwS2drbUpF?=
 =?utf-8?B?emdqYkQwVFlkWFVIbjZrcVFGSEFWVzRqU2dGV1Q5QmUrL2NsNVIxL0d1NWtv?=
 =?utf-8?B?SmoxUldTR25nd2phZ1BGckphSkM4LythdmhOQTV4bDFNS2xXazRRcG9RVDFN?=
 =?utf-8?B?N0RVSVdxTDYxa1A5QUFFSHlBK1VLMlFxTURFbnlFcFJORmtUT0ZjckVtbTh0?=
 =?utf-8?B?UTRCT3NUTlRhbmVIWDRmZlg0UzQvRE1SbTJvMmFIUll6NmRNWjB5ZjMvN1Ri?=
 =?utf-8?B?Wi9udm9QeDhQR00rT2dYWm5QdzRzNVA4VGw1b2RibG1NK2hCYzRrem5nMVVJ?=
 =?utf-8?B?TFVlSXNLVDVDZ01RRnlBSW9vSE9vK2IzT1lzbm1QU0FIZkpJSjdSYTh5ckpu?=
 =?utf-8?B?UEpTeTE0UHZseDkvS28yaXNiLzBYVE4rUzVsUUc4dU56Ym03MUtnT1NrRFpI?=
 =?utf-8?B?RkFXLzBiRGcxT3IrclE2Z1ZQNXFYY1BYRW53bHF3bUNJdC95VjVvcG9CRk5i?=
 =?utf-8?B?QTZpQURNcHlzcWtaSVFDaEhUdFVMWHhjSHY5V3pPL1Nhbi80cE02djRMdHZ4?=
 =?utf-8?B?VC9xNnR2QytOdVVKcVhVUDZWRjJUZ0FNRG1SN3ZOUmp6aHdMLzd6WW01Y1U0?=
 =?utf-8?B?VENFcXA1M2h1SllQUWhaa2xybFRYTFpmc0NUWHVSSC9zM2JGNzV2R1pWRkJL?=
 =?utf-8?B?Q0VxTDh0K0FmQnBrcS9CY0pKS0tscDJpaDFhbWc2SlJvU0VHMS9yTEVMTkF2?=
 =?utf-8?B?dlBGc1NyNXVjTTY2c256NmpGTm9GU01DVS9nR3dJWjN0TGNmM1RIdTVLVVFq?=
 =?utf-8?B?UEFLcE5PRDR2aEJzU3NiRzVUcmVPSEpOVWg4eWc2d0g2VTNPWmJuaWY5c0NU?=
 =?utf-8?B?bnJJbWtuTE1nV2RRaFNHdXl2emVWQjJpYmFHbTZ3WnZ4R1R4cmRleXAxZ3or?=
 =?utf-8?B?OVRvMmp4dkJoa0FYK0dMeGZTeDk5M0JrM0hEZkVIT2hrTnU0bUpjSEVSV0JN?=
 =?utf-8?B?MFlPU0dkQTQ5bCtrL3Jxcm5VcXlrNG1MM1Q4VjAvYWVJNFQ4MTZaWU5ONmJj?=
 =?utf-8?B?QkRjSTZ5SGd0MzhuVUdMMmJUeWlhS3ZQRWYxTnM5TmFqRXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dGQvMkx5ekQ1R2U4MStPVFc0Q2ovdDJvN0JLenpTMlZmVjYxalFuNHRQMStM?=
 =?utf-8?B?aXdQRlpvRE5OR2FXemlkM2hyZE9yZmV2NnNPbUt0ZEtOemdsSHJGVklBWVZ6?=
 =?utf-8?B?ejZOWnl1R3dOd3M4SmU0ZGJ0RFBHeFBYRmMwQ1lYbnZOMG5EcmlodUxsbTh4?=
 =?utf-8?B?Z1dUVS9nUER2b2dpOUVrOFVnemhQbzBnT1RvbHdMQllCcXdoWDVZVU1UWklD?=
 =?utf-8?B?ODJyV2hHYlVLb3NoVUp5WEdvWDhYZlo2bUFsOHliWE9veHhuSlNoeU0rcVYv?=
 =?utf-8?B?N0xLeFZETFhkL2o5K0lsWkpiM3dOZDB4K3BoMUNIcmlNY3NRY21XVXJUeEg2?=
 =?utf-8?B?N0hqT0pVMldUZElpVll0cXg2aFZCYWZuZ3VCb0VBVGhOTnBoc2RGWFdzTSsx?=
 =?utf-8?B?T1Jtc1d5U2NWa01saUVmVUE5ZDROVStJZEVUUnV6T1RXZ3J1TW5LVkNkNWw1?=
 =?utf-8?B?VjZHbEVOY1pBTnp1V2Q2QzA2RVhPYys0SU1JMlpsQ090dUpoWG9nSm1tQTR6?=
 =?utf-8?B?eThITlF6R2ZwRHYvYmxyeFcreFFiQmR3ZzA3cWxYU0NFTkdKZ2xyR1luNm9F?=
 =?utf-8?B?dDNVREdGMVlDQUlzbFYrYXh2eWJWckRsTTRibTNnTGhVRGl5SVI5cFZkclJt?=
 =?utf-8?B?WUNEdzZOT0xvQW5BMnJCSzZac2s2NFcyU2lHeXdSMjY0aHNnSnpWQ1hlVVJF?=
 =?utf-8?B?ZGZmVFl0NWNxeGQyVVdVWVByRkZVeDl1YmordFlRU0IwdWV2ZGtiazhDRFFM?=
 =?utf-8?B?aVREU3VDd284WXQ2ZkhNV2ZtOTdtZlR6T1NHUnUxREdWcTV6ODJZa0daSUta?=
 =?utf-8?B?Qko1aTVxNjYxY21BMFFiQ1NzdnArdlJ0NFNHdWxETlR0TytSYXZrclBEYllw?=
 =?utf-8?B?cXRSb0grOTRSdGExYVNQa1l3NlA4MTF5a1lpZXdEMFZXWlZweklrWGR5Q0JM?=
 =?utf-8?B?eHAvT2VTcitBZ1NjMGRIYXVSNGEvM1QrZFNqUGZPdUkvemhNbHBjclYrTlk1?=
 =?utf-8?B?OFVuZHpSYnNFTmJ2U2o2V0V2MW1NaG95bzIvdUpiRWlHRFZGbEJucUlhM1lu?=
 =?utf-8?B?dXRDb3hkN0lUOWlEcDVSdTkybXN0a0h6NDBRcS9SQUdwd2k0b2IyaVBsM3Jl?=
 =?utf-8?B?dThMdDhVRWFCTTZJcTZZajZIMlU4NmNidEo3cWk5NWtqMFZUU3JzeVdOalNR?=
 =?utf-8?B?Mk9vdmZiaUFaNHFsNWphWTJUZGRKS0ZEc2FHR1UzZ3V4eW1YOFdwK290T2c5?=
 =?utf-8?B?YnpLbEZrWFl0a2J4bDF6cWJmTWU5SjZ6UEsyNDlmOTNiSkpvZ2JmeTZNVlhv?=
 =?utf-8?B?eFVrcWNtQmNZWmpmc0JzbDZOZU1CSW9naWdpYkg1b0xOb0s3OVVRdWNGdkg3?=
 =?utf-8?B?bVdLRytnZ3ZHMFcrajBhQjgrQkFnQmFZeUxtYk9PeExmOVNHVFlJeEhmeXdB?=
 =?utf-8?B?aVgyNXR2czc2bmMyU0piNVpQdDBYM2w5RGJIbWJJZE1scExBSGJnbUQva1ZB?=
 =?utf-8?B?Uk5NcWsyMCsxbjBiK0QxSVJKODk4Z29EamNCNStEVENzMHN3ZlU3dzFsc3NY?=
 =?utf-8?B?VW40cUhXc2VLa3U4d2V6NGVJTFFGQUVKUGExbG1vdStiNGhVUzdWaFg3cE1R?=
 =?utf-8?B?NlVUU0IwK0J6WnNZbmdXUjIzQnlTVnFkZ3lzVkljV3c5ejhQRkZGU0lPNWx5?=
 =?utf-8?B?NC9PbFdjQWVrdWlQdHp4Sk1vSVJha0ZRRGVvdEJ3K0ZXN1lHajVWL2xJN1h0?=
 =?utf-8?B?bnJrdUZ1NmxWUnhGb3F1WnJVdnBZM2hCL1RXRnI5cnBGNERKc25jeEpGeGRt?=
 =?utf-8?B?ZXhnYU5qVng0R2dkLysrZW9zQlI2N2c2SFdqcHl4d2wxYTh2LzVFY2FvS1Jz?=
 =?utf-8?B?MkVxRkpqOGhaUVhqZmNlaEk4SGVXcGZqYVpjVFlsRTFZTGZENndSQUt3UWZa?=
 =?utf-8?B?MDl4YWVEcUp3NEo4WVB4aFdsUGkza0QxTU9FNTJPMUo1bXhHTVBiL0cvYVFH?=
 =?utf-8?B?b0hjSUlseFNuYUFieDd4VHdPV3hKZWp6cEg5Qzc5MGthM2pBdzhlUWlZcHZp?=
 =?utf-8?B?WGt0WU9EK1QvL1RCNFMwOHVmMWR1RnA1SW5QckJOTWJPbm8xR3o2U2hKbmVB?=
 =?utf-8?Q?m32KZfjpLKsaarE2Y+wF30gGQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9089a75f-2e6e-499b-c45d-08dcc90bc91c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 15:52:43.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9bfQ+XMRcGpHFG930VXBWkUD+0QktEyIO6tjtsCu8MhUg8Gs3MVTCrjqGHHqK47tojPtmkWP57AlVPaclDRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10663

On Thu, Aug 29, 2024 at 03:21:13PM -0700, Tim Harvey wrote:
> On Thu, Aug 29, 2024 at 3:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> > > On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > > Greetings,
> > > > >
> > > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > > > device and the device is not getting a valid interrupt.
> > > >
> > > > Does pci-imx6.c support INTx at all?
> > >
> > > Yes, dwc controller map INTx message to 4 irq lines, which connect to GIC.
> > > we tested it by add nomsi in kernel command line.
> >
> > Thanks, Frank.  Can you point me to the dwc code where this happens?
> > Maybe I can remember this for next time or add a comment to help
> > people find it.
> >
> > Bjorn
>
> Bjorn and Frank,
>
> I provided some misinformation regarding IMX6 - my original testing
> was flawed. When testing the IMX6DL linked to a XIO2001 with a legacy
> PCI device behind it the device driver is given an appropriate legacy
> IRQ.
>
> Regarding IMX8MM linked to a PEX8112 bridge with a legacy PCI device
> behind it; the user gets a -28 (ENOSPC) when requesting an IRQ from
> the driver but I don't have the hardware or the driver for that in
> hand so I need to wait for more details. I don't see any reason why
> this case would not work as it works on an IMX6DL.

Do you have chance to try other arm64 platform? Maybe defconfig cause this
difference. CONFIG_PCIEPORTBUS=y is enabled default in arm64, but not
at arm32.

Frank

>
> Best Regards,
>
> Tim

