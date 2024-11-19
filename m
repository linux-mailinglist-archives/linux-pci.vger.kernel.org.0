Return-Path: <linux-pci+bounces-17097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8C9D2F12
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15144B29441
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C041D5ABA;
	Tue, 19 Nov 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iyqxNOhv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71741D54E7;
	Tue, 19 Nov 2024 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045505; cv=fail; b=KBVIprrwE/Q681PvUdqwsU6KkqX5hpo5hfB2qbLN7FKykyznNwOb+gsJkwWm6R2ljraFLOLfT6Ynoxibrc/gmmWb0v3gsdAK0JKPhFPo55MJxbKaGn8GhL8qs/Jw5+ilMS2wbQQO3g3t+hNxg28Cvt+TXiuZQe+8qC09hzuXDLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045505; c=relaxed/simple;
	bh=KCFf/kpOBLVWg/CB7YyvqJwaYB8a0PfjuuAqUcU9aFM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OT+fhALNquG9dhyXf3VSfp7MrROXsSSWQvLEXVotepq8L6A2kO9uLgcE7xO+Uq5Nb58+R3IAJKEheidzB8bj3rGYyC3bng9ElR/OyEi8E6oafJg5Ki0YTowrD1wSofrLU46RluYhzFMWJLNyT0puYIw/XzkRhzOoY/pAVfcf0EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iyqxNOhv; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7ewZ5mPiaQyy6dMT5pbLEjMVbMMF01UOtunjOQa0aHhCfkCA7DWjPXc4c3MYYSnl9+Io/288SZ7ZJMiquowR66Djw0HB7IHu1qLKjurFSD3gSERwetxPe0v4dWmpe9b1mq8zKwkf1bw1ix1mbT3SO8ylpelAU07vSYk8E4RZoJoOQDCdU2n19BzzUxWyfbrjd+hphqAQ7vHL2lYNQeDEBudap8IKvL+wsHaIzDS734iy8lM3pTHmyIfrrvGKdu4L5YtZ2bLqF6Qd/YWpbMlvm+ixgRYXtxazYmAb+2QjABsRAW6GLhuHgqDYygmsQ0+j/XYTdiBrtPmvMnUlPScqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo880m49XDBtiS+4QbnI4MX0ENP0IFEjlOSwgPnwq6Q=;
 b=Z2BDKhZwIjWUp6tAxQzQh7cJyoLwVO1XGIrod2j/MB5RPsR6pi8vHHKRFUKMqptv24WkWcilGPtiApQgDob3sKrnzh/1YeD+PYs+3TSEg+sF8nirjCHYSQqtf27eIjDmbYJfh+T8lJ6VYgUpclJ63TxtS8c/eaHHfztFqcCqJn751O1613Wt+qOB/RauPRWGPYSlJVX1QUDlvBbx5KVl9Rk4gkV/kUyAjwUV8nI6TZjVg6oYWMHqrU55yRkmPnamUFyCs0xGRIZ/gr1tM8xbx8Vq23xOYUFPfSoqQ7iyNW+KundYaBXLYV/UmCUO6jPAaL/kB2vXbBJ3+VA+aGeZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo880m49XDBtiS+4QbnI4MX0ENP0IFEjlOSwgPnwq6Q=;
 b=iyqxNOhveUk1tiOHccV13C+uHS3Nuchoyqkv3Hs8BzOWHiH/LJy8y9B9NHka3nnxoUutnuQ8d4ebzLgCrs/6g/odcCXTGL9Tc4B89lFbqYf3Epe7r3w8H5j/ES5GS1YH4Za/eYwLY3PdQXV1knkosmJf6NglrtNRsRVs63vx6RdLrWYZrDr8/kKEjCzL4erZCRErJP1f3zEsML2vGQKE8smYyfdkftRsZ+n1Ro9jqmOEkEAUWCQWFaWnc2XErL5XU6WnrLdrTnMLB57PlNgtgVSOQGyKg7oY86mp1FuzW8gRaDV6WwyLNkaIHJCaEn0z0Cy0cCjX1Z1K3F1c5sZP2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11068.eurprd04.prod.outlook.com (2603:10a6:150:215::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 19:45:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:44:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:23 -0500
Subject: [PATCH v8 5/7] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pci_fixup_addr-v8-5-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=2245;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KCFf/kpOBLVWg/CB7YyvqJwaYB8a0PfjuuAqUcU9aFM=;
 b=EkYvMVCH/Bzr/fRcfMaFf1qNPMxU2/f3B8LGbJF8zNEzeda5732d8hQ64ffPQu9js4BxynKzw
 tablQmaPlhKCofN9MWcbNDZJa3YsFbY6j4JjpFaZggAlg/lluGLeH14
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11068:EE_
X-MS-Office365-Filtering-Correlation-Id: db05c448-bcd7-43ec-1d57-08dd08d2a73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXRBRDdEUEgvTGZYYUpaTEMrYlVRQks1Ym1rYUhqTHhQQmZRRXYwTy81SEJx?=
 =?utf-8?B?TUxQOW5TSmRCOU5FNGFlUEdRZE1EMXRUM0k1dCt5L1VZUjQ0QVZPYXVXd0pv?=
 =?utf-8?B?Ti9GY3R3WmcwWFRvY3pZR3RhaC9oUXFJVk1rOGl0VlFBYi9JK3EzbU9hVXFi?=
 =?utf-8?B?NU1aYXY5T0Y3WnUxNkdRbWlhVFdVTUk0UlRXNWlvM0dkUzhQcmgwR0dMRS9o?=
 =?utf-8?B?ZjN5bENadEZMSnY5ZE1RQnBoNUIwRTljUkJtTDE2cDkwb0lBM1phTkhMZ3cv?=
 =?utf-8?B?OVBHVjFaVFJNUHhkTjdBT3RhYlZUWDhkTEhJc3hNSjdjUC9pSTREeGIza25V?=
 =?utf-8?B?TG5ZNFNiT0lzVGJHN3NKeXU5WjB0NGwxSXh0RUVJY1J0QzAwajk0VHM2Z05M?=
 =?utf-8?B?enoxOE5nQWtEMGNmRXZFRkdqb0N0Q3FHRlNIVVhSUGNlSXhMZnAxcXVkZVo5?=
 =?utf-8?B?bUpoZWZITVdyMkFaQTNxa2ZPTHhZMGNSQTlJT3FoV0dicStURWVPdTlDT29y?=
 =?utf-8?B?NUZ2UERqb01EcGdMbjQ4b3hjUnBJNEp3VzRVR05BM3JHdkNsdmlpOGtnV2VL?=
 =?utf-8?B?dzBDRTZ1N3RVeUMwMUltRjF4UkRsNEYxZ1dES29MSzlqK2pRbXozU1VMK0xR?=
 =?utf-8?B?K0x0UkxHS3dtU1BIdlFzS1I4K1RuV0RLRmYvSGlzUHpEVTc2SDNPSjZxWDFN?=
 =?utf-8?B?V3ozMEJZSE5hVWx0Nzg2Z3NtVW9PS1lHOHd1NkpNTFhQQTFoMk0xK0tzbXpu?=
 =?utf-8?B?RlBGNmkyNk8zdEJnT09kc1BOR2FsdXgydG9hbGxJeW1QTFpyTFdsUXE1OTQr?=
 =?utf-8?B?RGc1Y01hV0tFYW5zdjhsbkloaklBUTR2bThLbGEzclk2SEd1T2kzZW5yc0tx?=
 =?utf-8?B?NzRiY3haOEVHNGhrUE9PVDBrQndHSmdKcVAwM25mckFEY3EvNzJQbXdpYnk3?=
 =?utf-8?B?TmRNZmtKbzZIYk94b1NwVC92SEJ1aEczSituYU0wSDA3NG9ady9QMDQ4aWFy?=
 =?utf-8?B?a0FDbDRsMm1jTlJjTFFERXpYOEJBSEFQR2U2Q0VzbzF4VEgwTUxNemppQmZL?=
 =?utf-8?B?WWE1T3l0QzJSMXJzUVE3SlRvYUd6eVk5Q3hueTlsR1pWQ2piYnZ6QnhsdFJ4?=
 =?utf-8?B?UTYraDlCcDZaY2tpNWQ1SFozUmJZQ21pRjUydnZlVTJtaDk3MFA1Wm1JOHhK?=
 =?utf-8?B?UmRvRHhTWDErLytUNDd5YVNxM281a1FINk9DU2FRT1dDSzZRTGpLQy9NVGdr?=
 =?utf-8?B?UzFnaUplekd4TjhxY1NnbGtuRkNGK1g2MkNUSFcvZVFoN0FZQW5Wemk5RGNR?=
 =?utf-8?B?WVVqalFVSXBqWkdKUjBrYTVFSExxRFh3RFRvaHJvNmJETU42V2VJbk5iL2h1?=
 =?utf-8?B?bC9kQU92S1NwUUpiZW55OFVwalZjaUc0c2pkTkUvYWNlOVdsWEFIOWUzaFg4?=
 =?utf-8?B?RFgveVdteUk3bnYrQzF0cE1jTmJETmNIZ2dJeXhCRXREUndvVm00SWUxSGNm?=
 =?utf-8?B?c3ZpSjgxZzNmMXgrV09YRFhyRXZJWXREeThjQVdJRGE0L29YT3dMeTRFRHlC?=
 =?utf-8?B?QkpDeWJ0cHVPVGRibVY2TS9ld213Z3BOa2p2L3dOOFZKKytheDkyc1grL2ZB?=
 =?utf-8?B?MFhibmcyY3E4RDJyYVJjcFVIclhJUVliZVZCRGYxOGQrT0JJUFBoSTc2ZWdJ?=
 =?utf-8?B?dmhGSXZmUUF1ZTIreVc4SDBGL2VKalZscGswamxuRDNyTU1DWmxaMmJLY3Z6?=
 =?utf-8?B?em9IUlpQR2Ftb1ZNQThjSGc0ZnBZb3V3TXRoZUdUWDk5VHZrd3h4REdJQmlv?=
 =?utf-8?B?Wno1aEpWbDEzdWtGYkxUck5BQ0JUazQ0WDJuTkVpcFl4ZmVRVU5yVlZIaTR3?=
 =?utf-8?Q?/Q8EsUNf2V888?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3VTM0orQjUyYXBiTzJlbXNGNERwb3VJcFBoUUV1YS9kMjZrNzR1MjJGSVg2?=
 =?utf-8?B?dnpFbGx2bVBBYzZOMGVjdnNsckhYOEJpNENVTFk1S3h5M1pZdVRZWmNGV3pt?=
 =?utf-8?B?OVdielJYTEZnYmVFMTZyY3Nzc2RjRElyYlFLcXlaMkptbys0SXNReGtEWDhT?=
 =?utf-8?B?WVJnaVY2Q0FVQmo1WU1vWHN2UU55aWJob0QyV2xHdUUvVll1K0pUaHROTkVO?=
 =?utf-8?B?WWFTQzVMZFVldmFFSXFnSUVHRGY0TWZlT2RTR2FPMlJmbmdnbGxKZjhSOFdn?=
 =?utf-8?B?OUo0V3VzMEdpMUJCY1N2dVpxZ0FNY1haODRuTmExK0JLRmptalREWS9KVXd0?=
 =?utf-8?B?NWtLVGJMRUJmcGZHS3BRSTBrYmxtSVZLVUM3TlRBRlFqUWtXZjYzQXlMMXJC?=
 =?utf-8?B?YUxMalp1dHpHWGk1OStwVGZ4OVQvZXdIUnlCM2tlTkdCbVZiWGJqK1E2SC92?=
 =?utf-8?B?QjIzODFBTXozdFczZFAvM3pRUjM3YjJON2E0RU9PakZKS3RYbmxLRjRaNlFJ?=
 =?utf-8?B?NTJCU2tET0JvZXgzOTJXZHZmV1R6QkRhcHNOYmZZdVJYSFI2VmRIeUs3NHhw?=
 =?utf-8?B?bUZwUDNaL2lkVHJNKzVMSWRnZHBKZUZDcy9rakVvYnRvUVRuNXNpdWcwemwx?=
 =?utf-8?B?d0p4SVR6akk3aVk2ZzhoREd3L0ErcHp3Q3VYdG9sZ0RLbHZtNDMrOWN4VWFE?=
 =?utf-8?B?ZXA3eS83TzMvamlaTUlXOXdqcWdmVVZJaFl5NzRrU0NOcXptKzB3N21jWHRo?=
 =?utf-8?B?cHNaSFFJWjdFZktZSDIzbU9WWnN1NGlsWHFMemZiVmg5M2FWOFhJWnhiKy9E?=
 =?utf-8?B?dXV2bGIwT21HaVI3WE1kRTNGNm9vQTVhREMxV1hFS2VZSUJBZys5Wk5uU3hM?=
 =?utf-8?B?YUlsVmFWTnJPeEk0eFV1SjhyTFlXTnRjQW5KN28vaEpiM2UzVmVjTHJyOGcy?=
 =?utf-8?B?VVo3OGo5Zm1NQnhRZUtWaC9mRVF2OFdRV1cwZkZqQ1R5c293ZUFJOFU3Z1lP?=
 =?utf-8?B?OEdGN0x6bUlQR3MyUmRXcHZEZTlNMEQ3eEFEZk9raHgzOS9DbmNhbHB6Z0VV?=
 =?utf-8?B?UUY1NC94aWJnY0M1WDBuWG54VlNJNmMxanJDNlQ1RHRhSzR3VVEvL21LWXpD?=
 =?utf-8?B?Nyt2SHRjRHVuRzFxWGZCYi9UOTFOSmNkd1g1clRicXgvLzI3amNGYkswb1hr?=
 =?utf-8?B?SEFkTkQxaEpmOC8yMkpXMk5ROGJGQmF6MUsyRFNyYUZmMHN2ckh1ZXZGSGc3?=
 =?utf-8?B?cFQzM1Rza0wrVG1TSmtiYjBLS212SXVNMXZENGRtUzdOcTUxMlBQclFaVGJx?=
 =?utf-8?B?YW93S3JEM0JaTEdtNVZJTG9LSWdLQ0ZZU042L2toMkd6QXVyVUNxcDNKUUJw?=
 =?utf-8?B?NUV3d01nS25jYjhPV1ZJRWNlK1ZYaDY2UzlIZTRab3FhdXFsbkVnVG5ad09Z?=
 =?utf-8?B?N1VXbStKRWdwV2xoTjNrN25wZEpQWXovWldsU2xjcVQvSXlXZ0Q0eitIRDFa?=
 =?utf-8?B?UVQ4UGo2L0ZrK2l0UExJTVdDbUZoaGczY3FKeHNZWFMyL0xORDBiZEdBTkZC?=
 =?utf-8?B?K3VRVHpkWTBUNDB6ODBlVWpabnFiZ1pjRlE5cTloSmw5R2NxSGFwZVBtQW04?=
 =?utf-8?B?dHJ3MzR6Y2VJbVlMTEsxMUJva2JlRkkrK1hvMVlHNkVuWS81M3UzRGNLQXlO?=
 =?utf-8?B?ME9wc0JjaDdaMFUxcStwLzRaRkpYVUdXL3BheTVtUXlXUFBJYzhRTVU1MTd4?=
 =?utf-8?B?Z1RMVXdxOFNuSXQvYUtleGRJV1VLUGdGVjY0eTVlZis0NUZsQm9rMEpGeGha?=
 =?utf-8?B?MmRUTTVPU0lpNy9BWHp0UllROUsvV1N4WWh1OHBhRGZkcTU2MElHT3BVZzdQ?=
 =?utf-8?B?dVc3b3VjcHo4dE04QThLdXQyNUJMWWRCY2hTMFh2N2NkOUg3YzFKQTBmR1Rz?=
 =?utf-8?B?QmJxWXFBWC8vWmM0QlhDQTExNkZoMjMxNWtTakd6Nm1TTXE0U2RpYjF3czFH?=
 =?utf-8?B?Yk1sbHBRWFp5QVBOL3JlZDRFUmc0R2k4QUlVdjBsdXZqTjBIcC80ekRxb2J5?=
 =?utf-8?B?ek4vcW12Z2Q5dTJmYjFLUlhoNHZLSzM5azB0MkVaNnFER1oxOFkxMFYrM0hG?=
 =?utf-8?Q?xGvzShxkm7w4fNXieNDzB9+Hs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db05c448-bcd7-43ec-1d57-08dd08d2a73b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:44:59.9425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/rElYdKCtK4aoGvI5kfRRVsOtTYGVOG+NePP6ANUBcA3FSjm1uqUOcmWB2AktpAF0fe8zJ/KqklyoQaG0i6pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11068

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only needs
'dbi' and 'addr_space' because the others are located at default offset.
The clock-names align Root Complex (RC)'s naming.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v8
- none
Change from v2 to v3
- Add conor review tag
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..7bd00faa1f2c3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -74,6 +75,20 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
   - if:
       properties:
         compatible:
@@ -109,7 +124,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +141,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


