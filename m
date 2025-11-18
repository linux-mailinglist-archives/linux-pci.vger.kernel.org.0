Return-Path: <linux-pci+bounces-41516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 84998C6AC97
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 18:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B61A03A2A45
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB62036403D;
	Tue, 18 Nov 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K3OnPfro"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D5241695;
	Tue, 18 Nov 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763484788; cv=fail; b=A+G5bTL4lZ81rWq74odbQoxH7YXWk51aK1d2dT8iw+nNVUc8ba5G+K31nQFH2IdL/0ejhv29CisS5qo+EEMPu55WFaDSv8KRN5Q0WCEYjHeWKcQpMG9SyLSfTQ1upH4QxhSUnKr3LhccGhe1NY4qAh57hauNMm9stuOIByaCqOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763484788; c=relaxed/simple;
	bh=NKkfCovyI2aDwNySfyr93pZRvpJT3HIoGkrbPQr22xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ko8le/Yyvr8u+mA2W+EBMhYmmEFlAFILBXE8g5HdZ3Uew2QiToY9SawGCgzkmljba0/aJ9y8TC/akDuoehu9NL5rf+9Ftbr1CY9NsiAzp443X5hJuwvGZ4L3qhilp+81TzQ2uD9cJXvGqdRsxTeX2MMHEQ3Mw6wz/R/8QuWR25M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K3OnPfro; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxlUCGz7gNJSprcOPUo2w3Mv+vuCiiB8fOfADEHWR9VLHhNLrOvK+HrJHSCTQVuSQNmeKML5LBIWx+17ygM3liFSkrNHXINmiLu4F5av9OQz/31LVwJdE3x+jN+RGS9I1SPezIgIUCxjYCdwNFNyQPtIHJr9od8IZXl85tOzU6W1vUsCZ82cwaGnImsoUTt8PqloLS6vPzNwLEAlsvuP7JDOaDOUkv33QikD0UQkueHLNZPFkf4te6urPb0Tdrmjz00GX0LgIDCaXG15vcOrZ8ZqtzdaQgjz1SerRgrDLQeUa1EDj2NxFp4m8ewgTL4N+JWzLXbKg8uyZalTx2yarA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPscyGwehav659F0fdr1MMnl9mc1+28Xyb95Sk2161E=;
 b=JasMwMC5Ke46tC6hQsNkB/g5vGiIWuQPHOz9HELrofCqZc3Sx1ix8dXBh6llqFOpf+b3aEnr42VP3s36DqoB/AgNvZa/bfs6kRkLo1x4m6Ph8jggTOlM9eHvXxad/NmwxrUQpC39b/YFiH4ZaBTg+d4c8xAA5wu98nJTMVBOKo9dIH7R9A2Wqt8LpuFxCfGrPjg1cPbBg5gPO4nE8jcwg4QWD3KC72HBmBoztF4QQA2TW80M2x8bEXPja0NcviF8VCJWMN0k+/jZxPfjQqw/lEDiiozh//gMgVfiI6X5HCfQ53dJ1VqRaKbzpDCzD3Xgv8PGD3XFaIl31QgOiLjugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPscyGwehav659F0fdr1MMnl9mc1+28Xyb95Sk2161E=;
 b=K3OnPfroY6QIORcdFEqsH4gWbtcIGBy1adIBnmzbxIW6zKwFU0ga8nJRJz9b5u9K4SA13ZAVMrKmuqr5PUmEKmtdqPXa0UsNRezg7/PD+R8YKrgaHGWrgb5JFMJmEhVlVHgcPiowvU3JAsuW+cQOtvWjztm70EvU6BNphAn5ms3caLEovP2UkFB+aw9iMzUN5nv9BEilAhuZNDfhC2VoS9x+R4XZcheXjD35WkrpUDdnNcLVGLG/X4KtXUTf0tg5W1xPEzAp0qcNlYju3PSKoLaM3RY4mJv/BKnEp223N0U2hMcKFcezBPgG0zkadrABBiC/ov6gPHH2YdsQDRWuaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM0PR04MB7121.eurprd04.prod.outlook.com (2603:10a6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Tue, 18 Nov
 2025 16:53:01 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 16:53:01 +0000
Date: Tue, 18 Nov 2025 11:52:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 1/4 v5] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <aRykY0F9IVmU8f3r@lizhi-Precision-Tower-5810>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118160238.26265-2-vincent.guittot@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM0PR04MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 750a88cd-67bb-4997-6219-08de26c2ef5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZuzdAHMKj8VE0eOrh0xLOrXlZRRNxQQ+XvPKj1tqNa22PF4ogSXN6DjVZknK?=
 =?us-ascii?Q?+mhDhxqCru9krmH2v+vJhkjl/EmuLWkYU8zxDAGXXomONdvbIxNuHAqvX5Gh?=
 =?us-ascii?Q?drQxJ3gmeAkVddIWwVr6UZxksIVnA26hnOU0srqVHTSAr1ft4JyjgeU7G8n7?=
 =?us-ascii?Q?m9DuA0/ZpOqvJvTHSZ2o7UtnxDh912+4dcGt8EznkUGqoDI4TuijFiVdWFvL?=
 =?us-ascii?Q?VYSRIOImuRLdK9hhIwXyBBbAfDFSHS9LwvqwcRPiUpDgI/tyeJeEp9W0bywf?=
 =?us-ascii?Q?ETHOnGzbBPHsCtDnlsJcyXcO5mq4t6HA3YJsX5QyS9QsRZOqVGrwgBfLzDZB?=
 =?us-ascii?Q?Le38RD53Z8iTRuOlF+QH90wSamU4MH4gLRZNRoyr51m5Iip8UBvxMIO2R3A5?=
 =?us-ascii?Q?c4E55uR2+QAc0l9tiVXC/PRMPFGXQF+vmNi08ep8zpc34QvLhKuKQR/C3n36?=
 =?us-ascii?Q?t5pRbDTeEXY9fXOJn6rMD5dG8xdqhf2h828GmIwae1WVj63uMjWgBkfwophd?=
 =?us-ascii?Q?6Ib8EO9FK7+MD8jD2nEo+foFZ/Jt1rPYnZbmzbkgb0013bZChKe4MQHfFBGk?=
 =?us-ascii?Q?zXdeg00zMziQY493b0SEd3kOTDdKPEGAJENabtyGd93y/4WpfuS2nJC4I5ex?=
 =?us-ascii?Q?+UQSlyQarXa7RHvMGqDhsnpWSzPecbVvMaZZBZNAkpcB8IkDDrVSA51eHA0c?=
 =?us-ascii?Q?xjpLBHNgNTdLE3MCGp+kHa2ArQP1jqQpPGt2Yyob+EQJDjRgz25B3019gzRA?=
 =?us-ascii?Q?zEpTqLuZc5+KjuW0284ZAgxYabU+ncsSI9kYRJXYbNNVEF9MPjuoUjOQQC/x?=
 =?us-ascii?Q?80heLX/EZ/Fn9PWXP5CwLRlZwESBkbLqTVujpzwzm9ICsQ0F7sFCxt45dBNX?=
 =?us-ascii?Q?X2nEA4Fs1xD3d5JknfKo/TjfyLXuosFzRijqsBojtkf1AHL04NSKQz9rg096?=
 =?us-ascii?Q?ehrlHNkfVU8RR+n/RG0SGfnyI+jOq65VIHqRvloyfcLENR+nR4kOrvEitnce?=
 =?us-ascii?Q?vjSbpszqWwW4MMUneKGSEOmD3EP/fy/rkkfjTtjMa78nwqhs2jPVO9bAH2DT?=
 =?us-ascii?Q?edI7jnCOoC+Htr8LlSIel5HkNNfUt8OF7fDWEcM+jPXZVVZXMCFP92PQ5Y7d?=
 =?us-ascii?Q?O1L9Sk1GC/p89EyQScbv+e+DUz8bbIK/70GlhzROE4wsrajdnHduQ/xKyMMa?=
 =?us-ascii?Q?gqyjWRmwG/peCn30q9NaBUthPIHoQgTee4rOZtlArfrq9oXzrY+Dj2PGvBTz?=
 =?us-ascii?Q?ZQY4F9CUPQuAxhDimaEgNG1skuNOt6vUQNJwQB9jBfKGYMbDuDQjdHTefuX0?=
 =?us-ascii?Q?bO8QtpX0DStAQYKzQOIU7VHphgpkpIwbKJVxtAKoNXc4j6bkDUK2njBQHeCj?=
 =?us-ascii?Q?KhhqYRkFcm4pAJref+/54iVn1/LSclY3dXmKlXWTE8wM1f2lxzEtnZSjDvUa?=
 =?us-ascii?Q?hUe5aGEvZkmbit9pAx7DMWJBFh7MhFQ9kluJI2GKQ7NyBizgTuM/Rg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3ZAT3A7QS77zOzKFyRDVALAABDhB/Fv+EhVhLE3DFqNxJMj8i7LCeF8Us+8?=
 =?us-ascii?Q?IhqHytA28UdmhtD9yOEY3voeasihxpSHzFmIQkA8fgYdSrtFmLKg5eTktk0+?=
 =?us-ascii?Q?+XE3+bTOGSABVeV8lRpMu2TlCBSt1kYh6mx6gEJJhE+aMK1eLWqwGMWwIQXR?=
 =?us-ascii?Q?Xj/FWGDkmqw81jQR8ED720yWAHENPJg0OV7BAiLwKdxjVDQUj3AERbnNfuCc?=
 =?us-ascii?Q?f+B0RaKhZge8kzni5UpGwKCu/17q3M7/TL3wvCERE2qgb/Cv5ERqtfH9FHxx?=
 =?us-ascii?Q?2EtPlajQhKkBlFEN+ACfAhX/mX4S17pCQCLewSoLBoLPIZDvUiBvIJH6lTJ9?=
 =?us-ascii?Q?Vkd0OBFyQzeqYCjD+A12s3RqO4Ut5RBTKKkXAjvYeFYSDQoeJwfzFqc5DZAf?=
 =?us-ascii?Q?u0MsySCRqiKmNOutinpGGpV43qdgVfLHNPlK4cBk/Ut8meTBTwInBQ/EHOhL?=
 =?us-ascii?Q?3AjHZyaj2rIz5VYkmMARuhr8lw7M5TsdlY4GDUckqfkyVbQ7QsaVCziHFutH?=
 =?us-ascii?Q?EOU3mgOmlpS+bKypkjl2HLv6Qs4Bg2kFFnLLQNwuM4PVfaZYbXMkrqUhFaqc?=
 =?us-ascii?Q?idewHVUgDV2d0WTmE7za+XjfUROC6/z9JMVaZzn96V1ULDt3G64rOUGXL5wE?=
 =?us-ascii?Q?/mTnzG6eszHdigXNglbMz4TDgTUrB1Gem3ZJos0PUorc+ekdYCy+W0UeTOJp?=
 =?us-ascii?Q?cR+Ta2nCcTTTlHcOZZJZlAUX03zKFb5LFvJD1lbl7u3labWFKw65xw0S8KsJ?=
 =?us-ascii?Q?4WXeLfiZJfGCEClBtuEOKLQ23bOa/cop2TMOR1b4laFmijp8Sa8L0bT9rHnb?=
 =?us-ascii?Q?Mz+yw06LJb2LeRBIwbH7nm5N2JV+5LfqI9YzYaWYCuDJCWPX/38cs8dUay4T?=
 =?us-ascii?Q?PGcBxF79bZ/+1xSZPq2S7yJn/sykr3v8ZHl2aJEwHc6+XBqaBJ5xs3fTMpiY?=
 =?us-ascii?Q?UH97s0ljDcx6PsVJSUvabs4jPXz4PizplukIiGIw+N87fuAuKqA55anHO7WU?=
 =?us-ascii?Q?ypDSSuY2WYFFnN0/g1z8Aqc2uDpCIlOzTureO98PphbspkGUiiHliWuFXxnl?=
 =?us-ascii?Q?EgVvVyKifg7RpK/XwowkecLso9ZuCdhFS3APwoDjcUHGKRpE7Gmooo8hRuUK?=
 =?us-ascii?Q?sH1KwZUs/O91DcDZS6GZPEnr9Bet2ZfB+Ks8A8iDEY2mAypl8xF+Dqw45shs?=
 =?us-ascii?Q?byEswR4K3qZScngrFoOLKL7eesuKPxIwdV1LfpkHgQueTG5wTqBIQaFmgbEY?=
 =?us-ascii?Q?KDJVIR31Xbpom7V2cbdqiVKthTVFUDLhl4EoxRaZPLUlZ6qEReGMzMY5gB2Y?=
 =?us-ascii?Q?0XOOrmyXAKdYZtsbuznQR/OSa1i4A3HXN2QOMkpe3mL0f56lrHyNHKkihFyo?=
 =?us-ascii?Q?Sppcpab/akzaQB8DeiWlRMY7Fz16EdXSItR6f+Yjsun6dw7dkYX8wXnLdLaA?=
 =?us-ascii?Q?c6/djVua47oMvzUf2wl2Y/HK/oke4LuF6DdwS+XW2Fm5ZXmtzm9faxQy7eki?=
 =?us-ascii?Q?SZKRC6UCIw/5BsfUk5ApTs72+/iOEIXTGhrZymWjDRNxpzG6GluhLbAKiWvS?=
 =?us-ascii?Q?cbWaXujX+x8plgAU1Fhcsxsc4Kcff2r/hkw3JWNr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750a88cd-67bb-4997-6219-08de26c2ef5c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:53:01.5983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkPXUsB0xObSQqXUGU9sLRCIXQkEgHgOCwoWJSrmFEpWGKS7t4M2pUZ4qIZW2oKiCbDoAbDB0KZLK8cW1jypFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7121

On Tue, Nov 18, 2025 at 05:02:35PM +0100, Vincent Guittot wrote:
> Describe the PCIe host controller available on the S32G platforms.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> new file mode 100644
> index 000000000000..da3106dfcf58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
> @@ -0,0 +1,130 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
> +
> +maintainers:
> +  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> +  - Ionut Vicovan <ionut.vicovan@nxp.com>
> +
> +description:
> +  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
> +  The S32G SoC family has two PCIe controllers, which can be configured as
> +  either Root Complex or Endpoint.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,s32g2-pcie
> +      - items:
> +          - const: nxp,s32g3-pcie
> +          - const: nxp,s32g2-pcie
> +
> +  reg:
> +    maxItems: 6
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: dma
> +      - const: ctrl
> +      - const: config
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: dma
> +    minItems: 1
> +
> +  pcie@0:
> +    description:
> +      Describe the S32G Root Port.
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +      - phys
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - ranges
> +  - pcie@0
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie", "nxp,s32g2-pcie";
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  <0x5f 0xffffe000 0x0 0x00002000>;   /* config space */
> +            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
> +            dma-coherent;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            ranges =
> +                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
> +                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
> +
> +            bus-range = <0x0 0xff>;
> +            interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "msi", "dma";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0x7>;
> +            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            pcie@0 {
> +                reg = <0x0 0x0 0x0 0x0 0x0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +
> +                device_type = "pci";
> +                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> +            };
> +        };
> +    };
> --
> 2.43.0
>

