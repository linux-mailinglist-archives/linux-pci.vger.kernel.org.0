Return-Path: <linux-pci+bounces-11500-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98C94C239
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 18:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF428282CF8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA23119048A;
	Thu,  8 Aug 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KQRrvXis"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809719006A;
	Thu,  8 Aug 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132959; cv=fail; b=cb7Sf3dcoI/xDfy+vmvJ//qT5BLUAtIb/pevyp6ohZbBNnFPjzQKpeHgFIgiucqrUcTYkjLcsEvsdKnlBSHzbe1GPL7WMChbW8qyLkGHbiELQn6BKNOOmbbtk3HNZyt1hAEfDzIX3NH2YT8IPWDTxyr9tgjg2eO2kRjQ0aL73Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132959; c=relaxed/simple;
	bh=Fjsw1eklAH3brtKur4IyIvkZwhLOemMsR1sI7TJczJs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O3y3704W/4hd2IRcqE6qxVWj5m5hXle6uwA2851fF7ta5t6bW9SfkmOWbXgGXKb8jLn1eU/O+jWfG1s/XZ0ZZEIuLh5dK/EHmcqBAH1AXPt0k1GBXF6yL6dw9WxTEj4mgF6cA6TDnJ+OsE3hCmDagnTXh8vuwvBbZX1SXn5WeWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KQRrvXis; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IJYVKu5Mb42hbv6uCwL016QCwzDftV/uGXA5bS62gyv6fyRbDcqZHMqvngBddzGolunlxuU0WprMKoB+FtPhD2q4QFWItD+eMe4QCXBWr6WBmCyyQHJj9p3AwPtkdqf606aP03vRWdMnzrkAoI7Ermw53vUw3YEB4TVgGuQHfFgDs8Z/Fppc1VKm1Juk28MnfSQSeRgVd9amDSbluCM969rUTCgu646lymN50wG6EsVsPDn7ldAtRH1iyKkR7gv6nbE6daaNUS0mf2b8l109A1UKy+6XF/BByVshnz+L8VnF/wDw6O+gIeIMS0w6RLWgPBL6lpWxUqdHyi5d76JubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FHeOONCAtaWvv/ZqClQkjTmDTlr7Yp7M+U2uyq8VpI=;
 b=MtXIHk92L1TdGV8jLzbwnPD0/CJ3XSE4Viwj2dJoX5swesLvN10gVKdDzd7OMRro8vexSOqXf2dkKDl4qp62/QjgQbPwBBtMx32cV2Smiq0rqXpJHHrIqj0pwar5GLa7TB16RtYYHXKrnm4LdJbzQcLOtkg4UWBHzXR7rw554qPzqQZOOz6Os8Xndv6miO+td0yKQFhfKiceoyw9cqnanRspZ1jKggXzs2REMr7aqYemQyP8l8mTWtY++WIyFC1lFjOaHrjibLkjZ43TOnKk9FSgkSfGe3z0U4KqfxLaAj4cdt99DiElqmuIu0Bje5iHJF8Yijl/BKG0ri4/s8mByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FHeOONCAtaWvv/ZqClQkjTmDTlr7Yp7M+U2uyq8VpI=;
 b=KQRrvXisfXuJK4AOslS6vzl7LAY3KzG+Q2W+aXFHOavQM4OFY+BaEmvUB4faCRkSPvatjZpGbbjfuPSYSG0qdpRBc+rXf3hhbVBGQKTov2tVl01D21dk5E1Vru4SKkFElB5hnf1/6XsgzQ8hslHuUeECwoZ7X0fRt8LIo1/P04C1G7xuFfrYpJRxw0s2dKfDS4yFdPQQLqFkOMIJI2iDpA9O7nLr5pZodxOd2pZBHBpFrLLn0k9W9HPM5c0suJiEUYKcVxf+NLKI5J1heIO8lAHoAJb8ZLx7YspzWeYvm2orIvvTazBFeQFTyV1PXUSTF8+gnlhqxiMxpMVEcWFx+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Thu, 8 Aug
 2024 16:02:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 16:02:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 08 Aug 2024 12:02:15 -0400
Subject: [PATCH 2/4] dt-bindings: PCI: drop layerscape-pcie-gen4.txt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-mobivel_cleanup-v1-2-f4f6ea5b16de@nxp.com>
References: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
In-Reply-To: <20240808-mobivel_cleanup-v1-0-f4f6ea5b16de@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Zhiqiang.Hou@nxp.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723132945; l=3123;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Fjsw1eklAH3brtKur4IyIvkZwhLOemMsR1sI7TJczJs=;
 b=V79uxI5yLTOnwy3tTqodIBKDWcW7Jav45+EAtetvr3DivBpj1bYai79YmiSkyETwznmur1Q7b
 5HYx4fDNRWoCsKW6HrslkHERb+eGekQ9gfEMnk/KuUlQrC4JYmO2eIu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 751f02fc-b7c7-4eda-b17c-08dcb7c3845a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1BscnNmMVlJVUNTNTB5Sklab2tKWW42VEh1aU9NZURzNVE0VjVDYTNrN1E3?=
 =?utf-8?B?OWprbUl3cmpUWW5FSkQrMEUrYmZpSFRVVWlod2ZPNU5xZ2F6dzN4K0xGdlRh?=
 =?utf-8?B?ZC9CeXFWTmJxamcyVVFyMnpTUHFlL1JBZno1WENhVitCcVU1anpyT1gxS280?=
 =?utf-8?B?b2o4V0poaXZMSEVFODVsaU0yajljRWpwZThwaGdTVzZscUlIK2hzRUVkZG9m?=
 =?utf-8?B?dnc0ZEptVkJMZHpFRmpkcjVGekNYRUc2TjNpcEFhZ3UyUlBTNVBKM3Qzcm5Z?=
 =?utf-8?B?all4cWZzbmgwMmhSbWovcldmOEhTa2pJU2E4VjVWZFE5OG9QNThUUnNCWUZp?=
 =?utf-8?B?UWhwUGkxdm92UzlabUQ5bjVHejEvY2VyQU5kQUU1SUVnWEVtbE14VGNZMW1r?=
 =?utf-8?B?alRsejNvMkNwSkpsSm9QeDlHczh2cUcyaSs4dGQrdmZKRmRYUzh5cE5UZmc3?=
 =?utf-8?B?dThGUGxTYnMzSjJWcHloVmpHRDN0eWZYcEhFODV3STFTdnBkRWU4d01Lc05L?=
 =?utf-8?B?YU81Q0x6SUpNUXN4OTJmL3VTeDRQU2JVSzNtZlB5T3VLOHpPZHR0aDZDVitI?=
 =?utf-8?B?dDhWN2ZHaEZ5bFVQaGZIRmd4QU1kcVdSK3lEL3dqVmYyR0xnaDhHNnc4UlF3?=
 =?utf-8?B?cG9EZ2QrWnB5eXQxV3JpZTB4KzlQRGQzYnlCbjJDODFOZnNxanMvVU5CdTc1?=
 =?utf-8?B?SStKWWtRMlMxcWN4bDVxaE9LUStLM1hHL2luZnI1UjRGOVplanAvME9sV3BN?=
 =?utf-8?B?eEVqQi90Y3lzdmNQSlNGbU5CNUhrak0xWDIweVEvRVY4cGU1NWl0NkpOWDlU?=
 =?utf-8?B?aGtOWmNQM2dmbmVJNkF1d2JhNk1xR1BsRlBmSSsrcnU1bEEraURBajdURlpR?=
 =?utf-8?B?V3dBa0ZnSEhPVTlRRmd2UFd6aitvWjlpSVlMeUdqUHc2MnBFNXdxQWwvQnpL?=
 =?utf-8?B?enM0MG5HUVZIN21XWElweUhBR0NxcXlHRXkxOExPOExjVnhiVEFxMExSeTMr?=
 =?utf-8?B?Lzkxci81RG9tUFZPMU0zQXlRc0xyeG45UFRrUVN1aFVCVVBIRWgrcWZ6d21W?=
 =?utf-8?B?Ui9xaWpEMWZLdC81REU0K2llSmZmQUs1VlVWUXVrMFpyaHFYdUNLd0thTXpL?=
 =?utf-8?B?V2ZObFRRTE5sV3RFTmU1Yzg4bE9ETFpRWFZ2K2Jlb0FVNTl2ZnU0YTRBVU0z?=
 =?utf-8?B?VFBwbUhoSGFzNTRxOGl6eWpjT0UvUnZsR1V0cXBlb1dsZlpkVHlFUUY0dzJa?=
 =?utf-8?B?NXB5dWFqdnE0UGpKSGFWY1FpUGE0ZVpVVEFBY2YrL3RBeHRKSThEUFM3dUlt?=
 =?utf-8?B?NEk3Qit2QmdIbFVwWit6UURZNmVFSkY0d2dGbDRhZm03TzV5ZkNWbG4yU2VY?=
 =?utf-8?B?Tm16ZjhybnpqSG9COHprOEJHNnBuU25Od21GUHBNOVJuaVg5cll4c0NPZ0x5?=
 =?utf-8?B?SS9uSXpvY2VKK0pVdHpTL1lnaXBURUpFQ1ZMbVhndkI0em9VRUJEcW5yemc0?=
 =?utf-8?B?ZVpvWnBOOFFMTmtMSmZnQ3htVWtURlM3K0lOd1FBdGlvZFowMXpwOC9CaUU4?=
 =?utf-8?B?L05VMDBnanhZZnhvOHoraHRFdi8xNVRGaU5TZmhCbU9RRlhkQWVvT0tIZE9P?=
 =?utf-8?B?SllrOCtNbkhiZHNGUk1kSjhBNHZvN0lOV1BMZDhkRkM4UWJKRDhmREtqNTRM?=
 =?utf-8?B?NGRsL0t2K0tJdXhQdDdSYWdEQTEwNkRvTzVCNzlhcVJtK3I0NzRDTGh0TFJt?=
 =?utf-8?B?Z3pNcU92ci9NaEJ4Y1A0Q05HNjNHSTV0TWxxNFB3Qi9jM21ORkFYNnpSa3A3?=
 =?utf-8?B?eEpiU1dIREI0czBWY2hKYjRrbjIrV2w3N2M4TGtQNEpyaEtXNWRaT3NZUlhy?=
 =?utf-8?B?WkltWTJpbzdqMDRxajM5cU9MZ1Y3UlAxckY1M1hUTUY4S2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVZUZ1pEWDUrRENoNXZpMHl6UlJTdllEd3Z0K2U3M2dLa0l2QXZZYk9OQUNU?=
 =?utf-8?B?c1h1akxhbE1oUWJKRDM2dTUxNDQ0NXVESmNyS1l1elVla2lzZGVtdE9xWG4v?=
 =?utf-8?B?RkpXMU1pNmh6N0hLL1doNkVsOU4wSDBpMmp6RGEwNWhHV2pZU1g2Q1ZFVFFE?=
 =?utf-8?B?NGRSMyt6R0Z6RVZUZmxEYUpFWUFLYmdWRlBCQktWcW4rK2R2L2kyWERjM3M4?=
 =?utf-8?B?ZzlMZ0E1RTFEMEZEdUFVdjh3cUZuR3NWY0pLNnVIK3NuZHhEeFVtekkxQndj?=
 =?utf-8?B?b0hZcmpLOWk0UFVlSDlIWWd4YkVDeDMxNXNTc2J5T1I3MGJsVnhoemlkRUtm?=
 =?utf-8?B?cSt2VHJVblNRVURLWjRHVTJMTjJWb1g4NndYWmNnaU9uUU5aMTc2MENQemtk?=
 =?utf-8?B?d2ZZWnZxR0NzWllJVjRBV0lxQmUweTFwWEdaSVd3VjNvKzNKNVl6WForM2VC?=
 =?utf-8?B?OXF3eGg4cmpzZFJjMlVZWjFHYnFkSStEL3liQ29JMTE4c0NTOHMyYW0rOVNP?=
 =?utf-8?B?Y3MxZ0ZFOVJ3Uk9VbkhtZ2F2a3pCMkdGS1U1SVpxcWFGQTJ1bXVFY0xUeVh4?=
 =?utf-8?B?SzJPVDFyMXRIYXlhQU5DSXducGhyMG5HTy90YTBlSEhsZk5mZ2xXRHhDck1M?=
 =?utf-8?B?VVVGUCt1WDNtNEZ4Q0NSSVBKREcyejhVN2wxbmloOWpmZGp3dmhXTVZFaGl5?=
 =?utf-8?B?UVJQa2dxeFlPMVB4SExDWTZpQ2ZwN0VSZHRjZDRUcXFNZG1QcUxaTVRUV3R1?=
 =?utf-8?B?TTA1Z3MzZWVsdVZrdmV3b3RWQ25qeVc0Q3J1NStRSzh2QVlBelduc2twa0ps?=
 =?utf-8?B?UStSOVRyYmthR3JHQlB3TStsNmZ5WFhYK2pnQ2hPeTFpSFNxaVVBZlJwcEs4?=
 =?utf-8?B?cytFeGpHa3pNM084QzNxS0xqNDRuUE9taTYyMzl0aWxQbWIwdDVXWjlyVzQ5?=
 =?utf-8?B?VDRJc2tlQW5wcUxEdkxidjg2SGtKNmZBUkNYYXp4T3k2YmNFdlhXNHZyVDgy?=
 =?utf-8?B?cmtzWE0rRkZKbzFTNUt3VWdUanJuQTRSUFBJOUNDNHdRZ1llejJQSlQzMnNW?=
 =?utf-8?B?a3Y4d3BzeGEvTERnaHlPbkFyVUJNZXVyb0JtaFY1S3psRkRVeHJQblJRZTJB?=
 =?utf-8?B?YTAwNUxqTFNlSUpWdE1NMjh5akdxN1phMkJjQk8yMithbjlrNHNXaCtHRU1Z?=
 =?utf-8?B?Z3htdEVkZ1RMY0wvcURBcUx0ei9LSWNRNEV6TlIwU0lyVElZYmRBZjR0bjNu?=
 =?utf-8?B?VDZSUFZDWXhsMnkxODVoV2dWMUttZ3VxNk1PakZTR01FUjU4akZrNXArYzNt?=
 =?utf-8?B?MWxIc3BWd0RqbDJvUzZjN2dnN0N3T3M4SkxxeWw0TkVJMVdwRy80Z0ZRdDV2?=
 =?utf-8?B?TUk1WkVlTzc0cWNCaDFFcDZ5K1R6c0JyREg5T2pZNzVIUmtSOWRXNm5TczlS?=
 =?utf-8?B?eUcxdlFKYW1KYU5qUTNOZG9tZ0xTek4wMzlhN0d5OWJFS1N5Vmh4YWRXa09C?=
 =?utf-8?B?VEVFcUFzdUVJNUNUUXJZSDZVa09lZXZSdmJWTGJzblFqVjRCRTRsbmYxVk52?=
 =?utf-8?B?bEt4NGlxcFZBUXBtN2NoKzRPYjNiYU1ZdDJKNVFUQlFQRlJORGNJS3krZUpo?=
 =?utf-8?B?ZTQ3SVpTc3ZodWtHZ2NRNUs5QXozK2JlNXJFbnBFeE9GTHlGMW1JVE1XbkFz?=
 =?utf-8?B?dThKdm0zMGM2UTdLT290ZGsyRENWazNKM2VEdk9EUHl1UklpelIwbVZwaktj?=
 =?utf-8?B?SWpGZlliTiswdFFLMTNIekljaTBFMHpLMm0rRUViMGpRSHhPaGNEV3orQlBv?=
 =?utf-8?B?am42SmRBazNRaGlnU0o0akoxSE5FUnRzMnhDcHhPdVErWXdNdDlMQ0Vaa0Ex?=
 =?utf-8?B?V1h0bXh3ZmFKQWk3cTJCenllUS9hQVo5aHg0TkdCMTduakZxNDJRM2VDdm1l?=
 =?utf-8?B?VnE1cVZPT1NMQjNqNXdGaHJwV0NsWHNTWTdjOE5tclpxdk52SDJKTXl0dzNn?=
 =?utf-8?B?c2txV1B2RmJpUC96SzQ3NnJvelFVcEc4bnFqaU1rWklHQVo4bi9tM2pSN2hl?=
 =?utf-8?B?WG9CQStsYmRVQVRBOE80TkEwckRYT2RDektTTnZ3d21MWWRqeCs0V2VHTUxE?=
 =?utf-8?Q?Hb04tUKY7p4jLlTMSZ2b9MpsY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751f02fc-b7c7-4eda-b17c-08dcb7c3845a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 16:02:34.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDVZlq+rSassN4PCcJYswdYBuA9HVZS9AgYpc1NMqwuq2leEMhEKp+IUFJKn3ZN1SdK1F+ZkTL791U7RZ+hUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

lx2160 rev1 use mobivel PCIe controller and switch to designware PCIe
controller at rev2, which is mass production version. So drop unused
document.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/layerscape-pcie-gen4.txt          | 52 ----------------------
 1 file changed, 52 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
deleted file mode 100644
index b40fb5d15d3d9..0000000000000
--- a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-NXP Layerscape PCIe Gen4 controller
-
-This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
-the common properties defined in mobiveil-pcie.txt.
-
-Required properties:
-- compatible: should contain the platform identifier such as:
-  "fsl,lx2160a-pcie"
-- reg: base addresses and lengths of the PCIe controller register blocks.
-  "csr_axi_slave": Bridge config registers
-  "config_axi_slave": PCIe controller registers
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: It could include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
-  "aer": Asserted for aer interrupt when chip support the aer interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
-  "pme": Asserted for pme interrupt when chip support the pme interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
-- dma-coherent: Indicates that the hardware IP block can ensure the coherency
-  of the data transferred from/to the IP block. This can avoid the software
-  cache flush/invalid actions, and improve the performance significantly.
-- msi-parent : See the generic MSI binding described in
-  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-Example:
-
-	pcie@3400000 {
-		compatible = "fsl,lx2160a-pcie";
-		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
-		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
-		reg-names = "csr_axi_slave", "config_axi_slave";
-		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "aer", "pme", "intr";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		apio-wins = <8>;
-		ppio-wins = <8>;
-		dma-coherent;
-		bus-range = <0x0 0xff>;
-		msi-parent = <&its>;
-		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-	};

-- 
2.34.1


