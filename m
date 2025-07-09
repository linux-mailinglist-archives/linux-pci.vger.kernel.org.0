Return-Path: <linux-pci+bounces-31746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7AAFDE52
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F51889C3E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 03:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37661217F26;
	Wed,  9 Jul 2025 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cq/DstAg"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75D215043;
	Wed,  9 Jul 2025 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032371; cv=fail; b=e0azrRkDKCqmeJlCTglv8x5DA94qpJrTfZjReDNjBY+Y6PWiOgitiXtZApd8RjlgMqo0QEEAkE8hvnzN2BC8qX+A4GZOgUTcTYx4HJT3jzd1Dm5GmiLWkBIuOFbSEFSrGWCV9y1zJYShRDe/Q7MpJFMWltY43FfgfUawbhLxxq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032371; c=relaxed/simple;
	bh=CgI+2lFo3wVlpHxfigUASqHsZSVtEvfhQLKGLlb6yKY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IqO5mEFIOXBxBE3Yo9/oOgX9VQq/3oCEeL92IcuUPfaT8sxOqj3dQO4D0yJuRBaGDLz4scGtxrkeasBw6+k6bvwjCZGPN+eziDved8MOyJMOI1M8w6EGSnhNzYzm/4eb6k+Z1pnEzHugsazXwOqR2LSn16pGU80yh1MbzluAJNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cq/DstAg; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbaCAve/p/dWtAtJ2joNFwIMgje0bofVX3xDBhWKRl4Kgx9RgZ970p7Gx6l/O4hnpWfs/lvmeFjs/x4+tqL2RTQY+5o1RdGiS2JDsFZELWtoZJcmepoUg7vEiS2J0H3jRPKmeO/847ap21AqQv7vIR5mvf+EoyoZmojLb1K4sp85lNI88NntgMKi7dlo2pgc/UVCGjYrCGheDKSMYVKJXi35ZhpTEzSZJKXMpyy5tPQqUsIyrK6ylHc/NP0Owg8wWbafK57lFQW7qAHUwZ7i5IM20B+8GAuiKeoMntYLb2mR6RRlVMsDGf8xCO6+jzHden1oOsB/nisfUoujTxvlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93F0DP3KVW3C/puD46xGFXPVVcnhXpzODqR5lUX7wiM=;
 b=prlV7xFVVCQaUc7zu+mbV6rQHEr2OKhInVuEnmJgify4HRbzUh7ivafAZc+3hp3bCAq2bKOcQzrl8vFwy6tfFWLTHsuxKe36VKurzJuBoG4+tReV2dT4F7MrW/PlRaLKfZkEZdnnWfusGQImYFJvgdO31dnkg8zwmfJUdWCR1RuKZIGjunoE9DY1W52fZVnrB43A+oMKn4QZQpB6q3rVIL06v6BoklWsRMaojeOOc/JCe8WhJqIEhF6l27i25uvgX8V7RjhPzCMjAVax4kPRaDgTvXixGhd29AH8310xGANTtMZq+kNDU2UWcGXBpg6jq7go1gYutay28oPYAah3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93F0DP3KVW3C/puD46xGFXPVVcnhXpzODqR5lUX7wiM=;
 b=cq/DstAgAqcLrKWI8xzas+5Rw2yuMIbu10K6R80SYO3uuMkfyBONQJ7pD42suDYGL9rdRCTaombA+RejuSR74LBqloZ39Fj1xzmbh3TWVnKv/VT84XDtIKOqBJ2+TucFsivK1ghaFpi3m23llDMH22Iu4I7qHQp4Q17bW8y2RuvKZtG8vaSxlzCLyfqM7u9cGCF0E9P9SoSxR2VpY9XtXwMDfGKecLvZrVg4Pk+jHBdEG5GM5lWbPSvjZT45NeVgKIhEm4rpI1hvqnd5hE5cmtayukS9UbFBNh9x1ljo5PWuqTN0qECZ61GQVyjktcusn/nA3nl+8YexqwwxlYklQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 03:39:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 03:39:26 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: imx6: Refine apps_reset and EP link behavior
Date: Wed,  9 Jul 2025 11:37:20 +0800
Message-Id: <20250709033722.2924372-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::24) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS1PR04MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: c880b959-c3e1-4984-e44d-08ddbe9a340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3RkVjI3cHdPdnNiUzdCUjAwVXVMb2pkSEQ5R0VzaWlEcjBFYmc1NU9YcjM4?=
 =?utf-8?B?OU82OTBTcjR3MUcxa0NaeFFEVmxaSjV1MkxmejlZWU51VzNsQ1NqSXlJZVVP?=
 =?utf-8?B?ZnkvSzVaaXljYnFwczZiZVBNUUg5L09JcE5XbCt5a0RsUVdyaW02U3pFV2R6?=
 =?utf-8?B?dVlLN1JwKzkxVWtWZFIvMlFxc3FZU1JDVU9aNGY5NjczYUZUWnZTNHZBMzND?=
 =?utf-8?B?ejE1MDIvK3pxanBKQjZSZko3S0JhUnFKMkZ6VGl4VnRRNUppaHluREFJcFpq?=
 =?utf-8?B?UHF6S3lyTlByYWpCdmgvc3FISnZQM2VwVFNqVlFCYzZPV0VRODFlMnJMc3ly?=
 =?utf-8?B?cGxoR210Z1BVb3lQb09GaldGUkRzd1ZENDNRUkJ4Sml1QkY3MElHeXZPKytw?=
 =?utf-8?B?bnVMeUhPRCtZU0MwZEE3aUFib1lraDF3NmFwdTJpTVBHekt3aGhrVEN2QzZX?=
 =?utf-8?B?cmJYQWJOTC9MMWNSMTB0dTJ0OUZRVThseTlVQmdKOWhMbmR0WEx3ajZzc2JO?=
 =?utf-8?B?ZFh2ajBjWVdUZ3dwNkJEaktQRHhyRFJwZGN1WFdKTzBPd20xR1ZsaFgxTEdu?=
 =?utf-8?B?Qks2bTJacHQ0ODRWYm1ueUpJdDlNaHpCVldvV2lIUDk2elpvajEvN1dUTTdr?=
 =?utf-8?B?dHZlem8waFR5Z1NMUU9oV2wzUzJITDBhWmdCMzFpTVpzc1RWR3Ara2RNQWE4?=
 =?utf-8?B?WGxnOWhRYVpuMFlRTzR4NURFN1MyTC9FQ0YzUEx4ZzlGL2lMY1lFanRwalBz?=
 =?utf-8?B?ZTVVWVhKQkRqR1VqTmhPM3dGSis4YjZXQytYMUNuM3VMNDAxWjZPZXJRczE1?=
 =?utf-8?B?bkE0eWpLcDRQOXJJWmdvQ2k4OG81dVNTQkpRMkc5SHlVZUV1S08wdW5OeFdH?=
 =?utf-8?B?R3dqa2x2QTRGNUFxNGZBT0xqQmtha0lBKzZqMEFtYnNpZitmOXAwMlBjYlNo?=
 =?utf-8?B?M0N0b2YrRWR2b3NjdUo3K1kweHJQbUpPTVVXeGtnTzNEbFA1UGphY256RVFu?=
 =?utf-8?B?cDZjYU5DOWdmTEVXNTU4cHkxK2k1aW42eThidjRlWlNuYlpiMWhISnBkTzRT?=
 =?utf-8?B?OGxjYUFscTVwbUZiOG1jdSs5QmtEODg2MWJuWDBFNUZva04rcjN5a0xtL1pZ?=
 =?utf-8?B?Uk5zSVRHWElkVjRLRlV6NUxoV29RT2E1V0g3L2JHcldtdmxqV0lJR2wyVnl3?=
 =?utf-8?B?eDFvUzRxSEhJNHhOczNDTGJuV0ZWRWk1SGpidStKUkxWTFRBQ1lJWkpCWjlo?=
 =?utf-8?B?K3VINEltTDlSNDlMMS9WSHBCYi9aM0VrSXFvZlpQTC9SWGxpUU91OU1oMFRU?=
 =?utf-8?B?aCtXeHVENURoU0VFald1ZXpPbVpMdHZIM3g1am1OZDZtOVBnR3Bhd3RJUWRa?=
 =?utf-8?B?SW5sanNGbnlFYmMzS2dKeDZKbW9uUjVKVU00bGZMbFEvT2I5ZFo4RWZJYkFu?=
 =?utf-8?B?ZFUyQ3QwYTNsQlEwdlFMM2M5cC82TGdpd0lDdEo1by91UHR6U1FqT01qUDlF?=
 =?utf-8?B?M1VUaExqZml6NnZaNWxJOWlXbytjbjRNSHplN2w2RitBWVJpdVlRQkdwUEFo?=
 =?utf-8?B?b3B5OFJjYTN4ZXp1dUJudjBqdlQ4emFSSmYzbnpvS0tXYjc3d21WRFBhVGlS?=
 =?utf-8?B?cXkwaTRDYkRQT05LZkg2eVAvRHFoc3Ewc0xoV2xOYmhzVTF4Z1J6TVZ1cUpP?=
 =?utf-8?B?ZVBUaTAxNlJ5Ry9qdHd0VExxczRHYUNlQytPM3pXZmJuSy9IbEtQUytsTDFR?=
 =?utf-8?B?SVd4Y05FejVlTFhTTEhrVWxpRC9LUXo5Y3pmM3IzN2h1ZnY2c2wzUG9vN1hS?=
 =?utf-8?B?S2Y3L0VTRHZGZ2pCRDlPamZwSlN1ZmdsWnJ6aDUxdmpRL21kZk5WWjU0aXgv?=
 =?utf-8?B?UmN4M0tsNUVHTkVxc0R4K0dQMlcyRXkvQjlleXJaWDc0c2RPQlFWRitHQjBi?=
 =?utf-8?Q?G41ZhHHXSi/J++oi3eyZ5ebdnk4axIy0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHFsQnZtd2VjU3EwUkJoNUxoM0c2cGEzSUdoUk1ZUnNBL0VjYldaZ2FxeUVN?=
 =?utf-8?B?eVZHbHluY3c2WitvUXFJWWtTUkx4MmthOUg2a3llL0VwWXI5U25jMzg0a21Y?=
 =?utf-8?B?UUlOd2pYOW9Gc2F3Y2g0TTRWTkpCb3lXTHdUdW8xVGFXNjRUQVZCK01FTjd3?=
 =?utf-8?B?TFJpVWcraFc1NS9LVXRwL2U1UmZwaFdScnhSbHo5MkRuelN2TStVZDRsOFIx?=
 =?utf-8?B?MldnZzJWQUptTEEvMGEvYzJDckN1NTJ4clRVS1ordVY4Tm5TclNPM0w4QS9S?=
 =?utf-8?B?WjNDblZmL0tCN2NjNjY1L1FCTmMxdzNuQ2d6bVViNkNsTzRlWUphWWtWRVMz?=
 =?utf-8?B?SlZkS1RmVVVCQW03Y2FTYzl1V2FJakNZVDNaYUNBaGFrMkgrN2lLZUJBMzZJ?=
 =?utf-8?B?cHcwS2J4R1kwSGtidVBrTzN1d1lGTDdjT01JK1crRlRNbkhlcCtmelVwWSsy?=
 =?utf-8?B?bVptdFkydVlRcytvZ29IOEVEalZWWWUzdWsrbEl3NU5rdjc0THRmZ2VWZWxn?=
 =?utf-8?B?N1h4WFlIbDgzNm5pbnBiMTZ1R25GS3I3U1hrVXo1N0RwUlBxRHFWTUFkNnZR?=
 =?utf-8?B?QWNta0dVcnBjMkU1ZjlFZU1qQnlRWFF0QVJleU5BbDJtaGJNSER3Zkp1Kzdi?=
 =?utf-8?B?VkRuckZsMDNCMENKVjdqRHVUMUhOYi9HUmc5THFqTjBXdVo5bmUvMkxGRFg3?=
 =?utf-8?B?clpnRi9MbllFWmZUMVQ1K21SNmFxREJmbUJibWdKczMyZndtb3hzS3VjSFZy?=
 =?utf-8?B?OENYWllhK0JFK1JZajc1NTBRVTVLU01EVEZyMlFCaWhFRkxLR2txRjE5eU9k?=
 =?utf-8?B?dHhiNEpDSGFRUXBjNTlCaHh4c2xUQlVjM2NHL0JYampBZEdlMzZZUjJuV3lG?=
 =?utf-8?B?dnZXWEt3ZTgxY05aY2dJeC96dDRlckZYY2RYeEdBRWprVFVqTjlXcU4xMHQr?=
 =?utf-8?B?M3FETmxSaGFEMHhMY25EVGlyc0gwdllpd1NLWXg3dytxQjRUSkFYSVIyUU5k?=
 =?utf-8?B?VDZNR2JTdGhMN1ozQ3l5KytIOHA1SWNLWDFVUWduWE1pNURNK1J1OTREY1Nr?=
 =?utf-8?B?c0J0ZWZvTjNES1dDTlZhdXBmZlYrM3p2Qy9vTi9uQ3pjR2ZFM3h6S29NcVdo?=
 =?utf-8?B?TmlBUFlia0l6cy9FbU9QQUk3bnJVOHJ4TnFRUG1pTVhYa2IwRmk2MkJKL1FX?=
 =?utf-8?B?RjU2SitYNVh3TzFXZ2J1RnQ1Q1VrWWxIdFhMc3ZtWm5tMVhJTXlHQWRpNU9i?=
 =?utf-8?B?a0tJZ3QxSmNKd3dZYzRrYUlvaXUza0pIeEJaRDBpMmliSGl5T1lUdlMyKzA3?=
 =?utf-8?B?azZpcXdnbWlJWFZTamdzZ3ZBUG9SdXFZVUlRUUZubjl3RUZHRmhIMTNCL1ZK?=
 =?utf-8?B?cm5VVTV3cUI2eTNxMDdMZWIvN1NJL0oxbTE2Z3g1Y2xSYUhMSjEyQmxLZ1Ix?=
 =?utf-8?B?ZXdVSEladlJHdjJXd0VNOXZnSVRsRFN1WG8vd2JwYkFIYWVGYWdGVG5LTGpY?=
 =?utf-8?B?VmR0L2c3N0psOWRGT1ErbVY0TGNvSmp1aW9HUmsrZWphUHMyUktOeEFHNXlh?=
 =?utf-8?B?ZXRTM2tkb215bnhlMmVHa1NSRUZ4V1NkSGhodHQ0eW4wQlJ3N0ZDU2ZPNDVt?=
 =?utf-8?B?czU0UVVTdXZCUy9xRmZZV2pzOHdWUHgyTHNLcFh5ZlBPZUdsTGZBTXVOQXF5?=
 =?utf-8?B?NDc5M0VmYlVYU2JybVIzbzZnMDVFRnBxQlY2TExiMmVPTkYxemdabzI3Ym1T?=
 =?utf-8?B?N0hScXRlbUtibDFiWkJONjUzMTJLNUhTVHhOancweTV2VFFQeVN4QVlFVWFq?=
 =?utf-8?B?cDhBK0JyTEhDc1RVK1FrTHYvYWdQaXc1ZlR6aDlLeUJtL0lic1lmbzR2VmlY?=
 =?utf-8?B?czlQcjFyRXc1dStqSTQya1dKYTBGazB1YWFtUGxrMWpMYW4wS0htMEpjbHRh?=
 =?utf-8?B?SmNDQVd5T3MxOVNlMlBEOHU4Z2xENEdrdmUwdHBnNmQ1Vzc4N01iLzg4WFph?=
 =?utf-8?B?ZXgxdTF5dWVzYVcyVFlvSTdiczRGUWxiWDNzb0kyc2w3QVYrSE5PcUtBR2Fl?=
 =?utf-8?B?dEZhSloyN2s3eDJmZFo0RkJGRVJCdTlUb0N2QzFOdjVHNjNqcUhweWZpQ1hV?=
 =?utf-8?Q?j+qLTPU4xfbvZq2w69aF4IuxX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c880b959-c3e1-4984-e44d-08ddbe9a340a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 03:39:26.6827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfP52Cq2yOBXr+WqjvqZ3jxs+w3rTPmskkJxSLjlJfD93zdNurzWi9WnJpQWcY59AQlRE8/0gYFAPYgzZ2/Cmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9358

apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms.
Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();

Remove apps_reset toggle in imx_pcie_assert_core_reset() and
imx_pcie_deassert_core_reset() functions. Use imx_pcie_ltssm_enable()
and imx_pcie_ltssm_disable() to configure apps_reset directly.

Fix fail[1] to enumerate reliably PI7C9X2G608GP (hotplug) at i.MX8MM,
which reported By Tim.

Main changes in v4:
- Update commit message and add Tested-by tag in the first patch, and
  add Fixes tag into the second one.
v3: https://patchwork.kernel.org/project/linux-pci/cover/20250616085742.2684742-1-hongxing.zhu@nxp.com/

Main changes in v3:
- Correct the email address of Mani and Krzysztof Wilczyński.
- Add "Reviewed-by: Frank Li <Frank.Li@nxp.com>" tag, and rebase to v6.16-rc2
v2: https://patchwork.kernel.org/project/linux-pci/cover/20250612022747.1206053-1-hongxing.zhu@nxp.com/

Main changes in v2:
- Respin "PCI: imx6: Align EP link start behavior with" patch.
- Add the apps_reset refine patch into this patch-set.
v1: https://patchwork.kernel.org/project/linux-pci/patch/20250606075729.3855815-1-hongxing.zhu@nxp.com/

[1]https://lore.kernel.org/all/CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com/

[PATCH v4 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset
[PATCH v4 2/2] PCI: imx6: Align EP link start behavior with

drivers/pci/controller/dwc/pci-imx6.c | 8 +++-----
1 file changed, 3 insertions(+), 5 deletions(-)


