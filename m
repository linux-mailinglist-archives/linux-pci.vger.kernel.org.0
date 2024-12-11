Return-Path: <linux-pci+bounces-18184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C79ED7F6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C5F2828B4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27C239BBC;
	Wed, 11 Dec 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwdiLg4t"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA085238E34;
	Wed, 11 Dec 2024 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950689; cv=fail; b=EFG/UKjUHJKlvGdugM24btAU6iMRoUrnKygFqIDWQ1oX2bfacGwnfwgX1xVkAG/pvSdZLTwEjNZR9vqHl/tQz4wg16+w2KTYviap5rxrFMJJVkSm2vUIlHxdhhbesWBDjqiHFBeHhcifJ1PAmVtQdL71lXsZ7PS53x1G5MZMSC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950689; c=relaxed/simple;
	bh=5pjdUm+qdlHFHhK7ZyIpeEGf+O4vh3vaMbBm61oH25Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OUA2pGCBtvGJhJF8f/J5E4UMp7yBWXaLmelpXRSyS+H64xShp81P1LMhEztV2dym+3WAgRFWxx6WnxP4ZAZjqvgwiDZwz7CxmX452H8Ut2LLjhCBEqLcf8mdwyh3dWSgpSSZgSy8L73S/rErWNrfNqv008+7Bpr2obCyOxQQsQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YwdiLg4t; arc=fail smtp.client-ip=40.107.104.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHoDfkrEBRrWGNkexEPEysHIfN6Dfm5DqTEInPYdvmtUF9XIFD3oJcphZG9+cvfDZOmgvQ4cgUGNClAPo50qbyYTKYVzXx5d6KtkmtjdxH5zPTb/gLt7/rJULD0q2nqFfBaAmtGlVbkFxD8jyzQtmqDMcCPc5+9udqrhWkUUGU8hhM1kOjUDy4b2feEYNlTU73qB/9235uceQgCQnK7XWaayNNDMwXfdrJNHfF1p16NPojxn+cF3Y5QeuYPAYEAqqwcX6ofNtqIdeIZb8LHNanUnn8Bk9Qy5vzXX8Uporv/2bEnZsLdCnOffbC3MlP8wwT0UxnjOGfQtLaVabfyjBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reEdFfm5r8CECXTiigkGpsrZkbeQGvaWHv5MjgKBfkw=;
 b=C7ntj5IeBGRFm01RpegzljK5fTS53zJBbhJSc9xpertr4X3l5//QYxBpIKpYmsnPka4pbiv+LFVQMqvNKggCJI20XYGNHGlQodnamerFV0EitJCVYqmIZKywbqD5k7bKQVcbeQT5AZylLaOwt2NDS2vidHCTR2SUHvwXkaoo14Xtc6VrPLHxYoK2qo2U/y2PTn3FI5HufRlC8ZGgHtoliAqU8hLhrvbOIXwyMNnvximzE2ueo8ImCqMrGE+KfnWEMbxyA7kLrvuu2Qqtou0i3H/UitCCf6/H5Vs4s80L9WgxytM4SA86I7V63B86UXapf/gvk5er5HOVrSsWYP1Vfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reEdFfm5r8CECXTiigkGpsrZkbeQGvaWHv5MjgKBfkw=;
 b=YwdiLg4tHpoCVurMc+sFt89iGiLyFZGAWYezSQ2MAQzrr3nXMYjnkewdzCrP//CaVw8D8D5vZ6Hv5ZG+rowqbJidcxyH2DYTwzQwTPTYm0PlTr83U5OQjVp7an8UbXG6bOiT+jtjswh/L3GnOne0RUwJfJpg9OKMbGgV06H+9lsVDYnFwVnBzU7YCuFd+bZmBYwUA3JebvapmUpvDapWESnWDfYwxOWINKJXZmKGaVoFmCBLYd3GwhKzNp+6b9A9masVBIpyHi/5ql5nIdKX6oj5I96jM5Z2BH3sTqjhsmFv6nufke1rAMfG7a8iw/1bSahLBb0eHqg+eKLcgNWQKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:58:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:58:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 11 Dec 2024 15:57:32 -0500
Subject: [PATCH v12 4/9] irqchip/gic-v3-its: Set
 IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-ep-msi-v12-4-33d4532fa520@nxp.com>
References: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
In-Reply-To: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=1104;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5pjdUm+qdlHFHhK7ZyIpeEGf+O4vh3vaMbBm61oH25Q=;
 b=mkzVt8ks8Sx225sdryqVfv2jrzObaDIjUCPU3nr/ZROfKBw0r9KBwNhQURWC9A+VFYL3Ps+F+
 HzKUpY2p3qvC7sjGAAARJ3r+sZ/DOgk6jMIKNCh3Pec2auhQHvuSvWd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a3c0b3-b1dc-4dcf-6aee-08dd1a268213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXl4WDlxRXFia0h1MnFiREFWMmZHV3Q1VFVFbFZESWdoaE0rNXF3QUpSTTlU?=
 =?utf-8?B?WmhXYmVzVWNyZnpsR0pmN3FRcDg3ODlDc3BTKzVlTXVMK1Z5eUM3TTljdmlJ?=
 =?utf-8?B?Z3VWMjhLd3Q3OFhmd29WMkVBMjB6NXNSQVo0MEd4Q2hKa0ZRV3FkeGl5Nkdl?=
 =?utf-8?B?Y2tGWXRSZkxicHorWFZyV2JIaE4wVFNRR0MvUTR6ZjAxQW9Fd3kwRzJCbms4?=
 =?utf-8?B?QjJzQ2o1eUY5a0hXU3d4aE5IZnFZaVNCWGR3VnhnMUNuamt6Yk1DbXZMQkJy?=
 =?utf-8?B?eFR2TEk5WUpSWjZtaGJZNFdvRUpiMk9RT0I5RHJNZHRiMTFBNUg3cGJUR3cx?=
 =?utf-8?B?azh5YnYzeVJRc2tERklBcmQ3U21zQ2ttaUNMVnAyaTZBRWFEWHZMak0rR0hq?=
 =?utf-8?B?THIvMjI1ZVNVbWY5UGlxcXErUWpsYUdTSDZVenptaEJydWFNWGdhNG44L2Vk?=
 =?utf-8?B?bEVaZURRKzQrVTRFdGZ3TzljbXR5UVZqV0F2WFdTaS81Tm52TTlyVnRHcmVM?=
 =?utf-8?B?TVJVNmsrMTlLbTkvNTBvc2UxTVRBb1dPR0l4aDlJNlZieWx1ellERDQvZktF?=
 =?utf-8?B?TFRSZkxtRWlPbzBXTnZHRFRBdk5WcHVGOVlCL0VBTDhndzBzK3NPZzZwWGFH?=
 =?utf-8?B?Y1B0dW1xWjR1OUFOSWE2c3VUZ0VYR2NCSy9vVWtPajBHRTBhcTZKOERBYTEw?=
 =?utf-8?B?bmxTRkFPeVJrTDg1Q2I5aDBtNkhSeEFzTlFIcWFKYlkwYjhBU2FRUVRFZUxP?=
 =?utf-8?B?VHhmYUFEd2tQUzVJdWFQYzM2bnFoSWtuaE81Z0NqWU51S3pCNm96WjJLRTBB?=
 =?utf-8?B?bWx0RGo4NndWaVcvNjd4TFQrUDllaTIzRXViQVVCZWlKaWNaOHoxMmRCYkRR?=
 =?utf-8?B?NTU1WVNYQ3pTRUFQdnJhV0NxMFVjdHV4c0RRTEhWbTA3M0Z1T1pqUlVtVFJN?=
 =?utf-8?B?N3REN2tHQUVVbDlJVVYvcWVleHRPR25zUjhrV1BtaG8yaEJsNlhXV2hySllV?=
 =?utf-8?B?TjVTY29ZU1pRSG5XcGxsWC81R2pkUW8wUndhNkxWbjA5VG9DRElWUW04bzly?=
 =?utf-8?B?NXFLYitSU05XVjJNK2pHNzJFQXhnRjdHeEdBWnplM2RNY1M4Mk5DMm5DdFU3?=
 =?utf-8?B?Rkg4V1FwREoweGtNUHFYZWVaZHNxSnhmOGtKVTVDL2o3RWdOTnhLcU1MWUJ5?=
 =?utf-8?B?c2orb011Ym1weWN1ejVmSHphV0VGQWR1VlhOeU8vMjBtd0dwTlI5S3ppTXRG?=
 =?utf-8?B?T3hDOVJsQ3RGY3RzZ3FwN0U5aFRNT3VmbW9wbENXSjBQbG04V3JQVmwzZVZW?=
 =?utf-8?B?QzZuRHE4M0lFYUVhYVVaZFZxZjNZb1BUY2k0bjhSTzU4SFV4K0ZXTWV3MXcv?=
 =?utf-8?B?L3d5T0h6cWFvT0RWNExKOWhjTktZN0xha3FMSENWQkJCbUFqOE03MllPcGJ0?=
 =?utf-8?B?aUhvOThZTndPMUJseURsVHRiZUppSTJHQTBIQ1EreDZQZFJRU1FTaHpMcG9y?=
 =?utf-8?B?YUY4UWsydlI0K3J0WWtYeU5zVDZRL2VRZjExc1dJcmFjY2FLanNkcXJSemZt?=
 =?utf-8?B?TlVOSUFFc0ZVZGsySEphVmllb0VJWlhqNDNOU3VmWlJxdS9JYVUwMVVEVzRm?=
 =?utf-8?B?WldnOXJwMzJkYlJ4NnpDUlppaGdQYUllY29DWW5aWTI2eEM0MTJ3Z0hsQmx0?=
 =?utf-8?B?RVBoWGY2d0hQeUZLTWpGZmEwVXd3QWVIMjJ6djFLUmZHcGVtZlJqZU9KMkk0?=
 =?utf-8?B?SE14UEQvZzRlZk5ERzMwa1JrVGtoUVY1Z3pSeXBOQmFBQllYL3EzRVNCNW1W?=
 =?utf-8?B?ckh0aFRWZis4NjZ5TXhvZTdPVDhLNjRDWnpWVldORzdUM0IvNnlQcW96dkhO?=
 =?utf-8?B?ZklOeXhpaldvMjdsYkdvQUw2aU1ObW54NTZjckVLeTRyQklLb1dJNUIvUS9Q?=
 =?utf-8?Q?lmKjJud6cLY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGhwZ3NINnZEOWpUaGw4czJCTS9sYXFlYWtUWlNoSFMxWFB2WVMzbGlYbzBh?=
 =?utf-8?B?aXFJTTFjbGtsZGZoK0RVczRZc2w1a3RFVE1KNS8ySHErclFoU0xkTXVOclk4?=
 =?utf-8?B?WXJUM1NXRUNvL1k3QThNamZ6OWFCcURoTUIzSFl5ekNyRkNVeG9hSFlxUmgz?=
 =?utf-8?B?cU51VGpvS0ZCM3RGWE40dDNOQUc3eW5wckp6TzN3eGwvdWw0aFgrTVNyL25z?=
 =?utf-8?B?WnJnT2IrOENlaERDbTE5Q25STHRnRExxM0xwYmIyajdQZmg4NmJBZ0x6QWNX?=
 =?utf-8?B?Tk10ZFVIZURmMGNxYldUaGlOTmRoeGFpemlnWEk0QUFlTGNWdnh3NEZlSEhm?=
 =?utf-8?B?aWZ4NnFCOURJajlYSHFVaHBsaTBEeFdXQ3owN0VoOUNRZVNmc0U0YUc5bHAw?=
 =?utf-8?B?OGJ2N3l0TUhEZENSbE4wb095UjBEdVM5MVR5VE1JcmJPNEhDSHNKQS9SaGkz?=
 =?utf-8?B?aDB4c0NCY2Rycnc3Rm50cFNPVU9KdGo2aUJpNThsRWMvZms0NlZ1dEhZeWlk?=
 =?utf-8?B?ZzdPMmFscmQ0SnFJeWVsOXJIcDRLeFJOZ1RUV2EwRmI3QWl6SlZ5bmZScW5v?=
 =?utf-8?B?M2JtQXR5aktJdmFKd04zakluVTlWNEplSTU5TGJJZFRwR0tiOGZKZWpkZDJO?=
 =?utf-8?B?NHVMVkVMK0FnbzNBYUdra2toOE91bm1yeit3akh3d3I3UFU3QW8zOUc5eENn?=
 =?utf-8?B?T1B4d01nWE43amJrRWN4Sk42TTc3alVMY2dpVWxWNjBiY0N4eENoVHdOSGI3?=
 =?utf-8?B?YzFuRkVlUGhMbSs1NHhwLzIzT296aDZSYTBhZVZIMTFKZXVkZnJ5WUo0Rnpj?=
 =?utf-8?B?NkduWW1oRmhxV3hRTlZBY1g1MlJla0dyejFJTzFCRDRDcnVxdnJPQ2lpWmRN?=
 =?utf-8?B?NnRzTW1vODQ5ajFKeHFDdlovekJDV3RVTWNrWTR2bGZxODF0TnQxd3Q5dDZ2?=
 =?utf-8?B?TVYzZkR6TmV3ZjdnaGNQVm9uSXNmbTVITjZSNGdzRktsVmo3QmM4dGFBRGlO?=
 =?utf-8?B?czdNMWJlV3UxZ25KdmlLVVdwT0RJZWUxNDNzU1JIYlRLZStUSmRzS0dUNUZq?=
 =?utf-8?B?Q1pqMVlYak1iaWlqbmxYZiswWURtMVVNVkJPYUVJRTFyZnloNHZSMFQ5VWNF?=
 =?utf-8?B?ejJpSkM4MHV0RjFiMjhiU2JFWWExNjZESnc1aGF5ZkZyL2VJZkF0NnJNcXJF?=
 =?utf-8?B?WTlhSTZiVUJOKzNDdVFSSlVjMDgzcUNVL0sxTTFBcUlWVi8vR3UxMWh4bExB?=
 =?utf-8?B?K05SSEg3d0xvanRaOEwxakJCeGVvNnVmVjVUU3RpOTBwSWdCVmRyRXlaUXRw?=
 =?utf-8?B?QmZpRitGbkJhMHlkcjhJV0prMWNTSXV5L0Z4REV4VDFFTVdzS0M5cTdIdG02?=
 =?utf-8?B?ZEg4NmhtQWtGa2Z5TlRKK1ExRWJTR3A5OTdpK0VXbGxsSGlMa0xDSEtzQmpH?=
 =?utf-8?B?OGlZT3FuSFZQL0o3b0Z2S1JucjJQemd2L2I5TUhtY3dXQzk3clhoSWRoSXVo?=
 =?utf-8?B?YWU5aStBbDJmWWhweEtDMFJLeERXek1hbm9OZ05yL041QU1JRHZJaTVCSFNF?=
 =?utf-8?B?SGpHVzd6dFNqVUhkbnFZVFJ6KzNvc0F3NDMyYVM5Z1AwWWwzRDh0T1MybVdR?=
 =?utf-8?B?aE1tQXpiYTV4UWhGWUVnUFdqMkNFYnRnR0tNV1huWWdHRUFISUhtakxmYjFH?=
 =?utf-8?B?ZTN6enVzUDYrdkJua1YvZUFxOXJUYjVUUno5U1dBMUFqM09wb2hMU3F3NTVv?=
 =?utf-8?B?SmxaMERlNFZlTXIvUFpkM0VhQ2dTNlZUTzErZHUvT3R1aVZEMEJNZ1lleFQw?=
 =?utf-8?B?bVh2YUM2MWhDR2ZyQVNGdEVPYk1NNDlicXdIYlVWL0hMYkFGZFlkRDkrLzVa?=
 =?utf-8?B?Q1l6elFCdkd5V0diZlJBK0V1VWxpYnRGYjVmREd1eGtBZUQvWFArVWIyYUdK?=
 =?utf-8?B?QWQxMUtRRjR3VGsyU1FEcVptb1hXbldDanRHZHhEeVdKK0grVklLRlZUaXBR?=
 =?utf-8?B?QUYxMjFuTHNkc2hmWDltUmd4V01WeFdYbUZNYnVGQS9jSk5QTm4rZWdzSGM0?=
 =?utf-8?B?RWRndkYvTVVzQ2lrL1BteXlTSWlnbWhxTEFCaUJLOFB5ZWIwc3NHSURiWUpG?=
 =?utf-8?Q?TwJAbMtSRFUJ953/1iKgk8GE5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a3c0b3-b1dc-4dcf-6aee-08dd1a268213
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:58:05.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R92AL37QBhU+oPloxhySVsSMUrNCVxTI9bfBxKBoNHXSFvEUC9X+LgSKAqofNpDuwqCz5bn56HYDbhtinoJwCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

Set the IRQ_DOMAIN_FLAG_MSI_IMMUTABLE flag for ITS, as it does not change
the address/data pair after setup.

Ensure compatibility with MSI users, such as PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged. Enable PCIe endpoints to
use ITS for triggering doorbells from the PCIe Root Complex (RC) side.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v11 to v12
- new patch
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 92244cfa04647..edaae13bbd3cc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5126,7 +5126,7 @@ static int its_init_domain(struct its_node *its)
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
 	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	return 0;
 }

-- 
2.34.1


