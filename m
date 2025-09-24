Return-Path: <linux-pci+bounces-36899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D8CB9C319
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB294163A43
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 20:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496614386D;
	Wed, 24 Sep 2025 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AIE6nz5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705E13D891;
	Wed, 24 Sep 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747093; cv=fail; b=cl2+GcWB5l++Up0665WpZ6yj+UEJ33gCze1NbvVJ4JjPj5MnuRTQrJXTyvp6B8t8OsN6psN1zWLeTWgDm5dLMFvAj1d52mcZCXY4cWI4EdFWLYcIDOqesl5e0hHMfFMwUBzqFLFKDA+Lkbn0tRtahYJISTJCap78DCqFkGSkDow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747093; c=relaxed/simple;
	bh=IpUTktJCEjyjTS4jc20Vum4zyk3ds6IHiuI3OlV+j+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YWHGsv5U7t9mHx/eQ+rp/fvizP+r+1ILi/jNGJvjgFcveR5kFCg/vR1uSpjlCsclNyHee9HavcOG9KAWQsPWzVL6uE4W4bFdlmxmIL8POc5Az952U9Me/fVrVpDgh10i+OOVh0rdF9ZxX32o/VKIXVvkt+kxEUWU0Ia+DKGTQBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AIE6nz5V; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0P//KhoUvnMB52T0vQwbKk6pLsM6fEwUIl7NjwDKVzncovS8KHHxD1VAim2ODSC63sjC3VTx4S3kM9Qj32XkBlDYsCrPKW4DmGEiTqdukRupGhnf023oQVtRtaGF/ZJfyCK1YhzPvpyxw+WPCoLyGozp0qOR5PLEr1p7nbbfLg3rwddGtH+Or6LuaD85P8+2EbecrLwqC9qqXkCt/D49H46ROMHOXT/qjA/zh2FVpIVX0rc8hmmmyc35hKDSEx9DqL4McSAUOOgzgd0pgUwp2g6TnuTWN7Qx7lOd2S0yNuaOs6jNjhcrv0gDIohIpf/EvSlqsTdciBzWqWlM2dd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muK3+GOnWWXevsxWy/FQfE/KEPG7lz5YDG8bo5UuQl4=;
 b=irU4KVRf93jab8U3omvIIkhxzICQ3LmsRtwU9l+mZb2t2ygc222rxxl53ReJPjwCvYNy7gOYtotxiZOQN5GdwOTHbRuhFeNZ6591WLynvNgJjPsCOeEXMY3z8kRGBt54o3fEm7nfk3mJO620u7bPKkZhWBm2yftKFi6vlmaSdS2IravqgAuZWLPf7VYSp9pIWdTx+g7/yCGZQB9baVudoDKikXPjaGgSRUlzkA9II9PGHW5Ft0TsptMAH2XGS6DXofmp3Ke7zABpvDPYF4AkXlZOp9ves6JNMNPvfl0ypRA8Wo5iJ132+aCBor5ya5KISkkfAVXmpwEKCjOksTqosg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muK3+GOnWWXevsxWy/FQfE/KEPG7lz5YDG8bo5UuQl4=;
 b=AIE6nz5V5iK0aH+2mw0X6tke2YuaRSeW6qZdmhRlMaiyJUiwsp8NTRVZhLHj10UhnrDCqGZWchR+VrfMSxul7cqFrNelLEp56fO9IZCA6r4EvjOb0FHyShU2n3gDX1a0TFAexlreKjhRFx3ZMob0wfHDQhMJ4DDcxlio47DcHKZU/s2/dubiTekbhHFBniT2AmvrVc4xh9cka0w5qx+o8LXcDPvnJ+bVZKkBY0QhrbgZ5J0pvSaE3QY/ceCUMHZwVil+1FmOsXTSlmQCdOub0B4EXCdkc5L2c1uqplEJvrMYbY0VTYogvE676YUHGncmQLSCyFE9u4EO0KhtK5TW3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by GV4PR04MB11776.eurprd04.prod.outlook.com (2603:10a6:150:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 20:51:25 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 20:51:24 +0000
Date: Wed, 24 Sep 2025 16:51:16 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Add MSI doorbell
 support
Message-ID: <aNRZxAU0n1hvYeEZ@lizhi-Precision-Tower-5810>
References: <20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com>
 <20250915-vntb_msi_doorbell-v2-3-ca71605e3444@nxp.com>
 <ejhs6fb2nmfhnjswhrvd7iwyddwvvr5nv6bu7dt4aypbiecyfb@wza667q2x4qp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ejhs6fb2nmfhnjswhrvd7iwyddwvvr5nv6bu7dt4aypbiecyfb@wza667q2x4qp>
X-ClientProxiedBy: SJ0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::28) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|GV4PR04MB11776:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb2239c-9b2b-402e-7a25-08ddfbac1ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkFHN1ZDdEhkVWJLY09wWlhNa3Rsa3MxdXV2NzhZZ3p3MGRmSjc4RGVSRWZI?=
 =?utf-8?B?dVNOeml5YUwxV3FwUTJjcTBnRC9IT2o2ZDJsRXc3Zld4RXgzSUJJYmIzN1RF?=
 =?utf-8?B?WW9XV09oMkgvUG01SW54MmdWcE9SaGhvMHBpVTlVcG85ZFFCMDBVT0pmRDlR?=
 =?utf-8?B?aGg1bTduUys5OWhmUEp1N0Z0K05VNzJGNFR0YTk4S2FyU2hqYmE4QUNlVkxN?=
 =?utf-8?B?Rk5zTEFJVjdBL2tsSjkvc2JmN3ZLbEt3VzhmY2Jmc2Rpd3BDa2JVTDcrNkdS?=
 =?utf-8?B?MVhCbnNVa1BnR3dCOXc5YXJNank3RDRzN0U2QTE4QkZtRFhSUk80em1sOGFB?=
 =?utf-8?B?OGxQTndUNWVhN2x0bVhtOG5lbllBdnhndG14S1pYSnBSWHRxTUpkUW5oVjZo?=
 =?utf-8?B?MDRBbTZvYk9SaFZWUUs3SW5Hd1JBaGtnRGF1MTJwdUVDOVNpd2M2ZEUrK0dS?=
 =?utf-8?B?bENhci8zSzhSajZkcXIzdk1iRkR3TGVXbm5JYzNhZmxkdyswSXo0ai9wRk5X?=
 =?utf-8?B?UHlmU1JwMndwSnVTUDByVTdCN0hERmNXZDl6STJvWDY3K0hkdVJrSURDNllH?=
 =?utf-8?B?TkdVOEV1eGNManQ3UUlTRjJwNURMUkJkcEJmdGhMd1RyV2s1NFNuVHBJMzNK?=
 =?utf-8?B?TkRJVXZKNzBqWjQ2T0xIUWJoeENxd01KeitudnNKS2R6alU3d1BwbHFTbGtN?=
 =?utf-8?B?NzYxV2FQMzV0WXZJblk4d1RZMFQwcjRiWmdqRlhNcDBFbGJBbittMktac1N6?=
 =?utf-8?B?VVJaY3V3bTgwWloxRWQzVHlmb0t0emFoQnpIZGNYdUp1ZUZZdVNZODBrM2t6?=
 =?utf-8?B?VTNpMko2dzhXTE0yZ0tUaS9rT1FhVEFaaUhtZTMyeWZjcTNDTDRrSjBKOUdY?=
 =?utf-8?B?RVZPUnJheWxhSW5VVmRpZXUrNG9mWXNKYlU3V1lqRHd3bTRpNE9pbXhKeU5U?=
 =?utf-8?B?c3Zid2J3ZVdxU20vSUtCMFhRVnozME9OZFlPYTE1czlxOE9Uc1JKRUZJNXVx?=
 =?utf-8?B?NGJDeHlQUGk0Mm1zL1orRWxFVW1NNkIra3VZak5IUlNYY25vVUp0cFFBcHU2?=
 =?utf-8?B?cjFabkJsSGI4ZDZ3NE44Tnk0L1BZYTVNaG84VENzczlUZlplTkovbDl0RTlR?=
 =?utf-8?B?N2J5bjdrc3l2OVZKSTN5Y2dRbUFWeVNIQzJVTS9wN1k5czBGb1JrZkhFMHQ3?=
 =?utf-8?B?alhtbGFtUFNUc1VqbjNwSHRwS2pvRkE1aWR5MEFnUWVLSC81MzZ4bFpMekxG?=
 =?utf-8?B?V2RwS09kbkxaL0JCTkhaL2w5aVRRN24zVWZCZE4wdnZxcEVrYmhrZmU0Q081?=
 =?utf-8?B?QzhKdHBUamRMNXZLdE9wTVppY2Z2a3hpc0xPYllyN3VES3I0T0FTc05tQ3Ny?=
 =?utf-8?B?SzdDMFA4WHJVSURmUi8zWG41eGVOZnRrK0RXT1R4ZTZDUm1nazhWSE5GNXhG?=
 =?utf-8?B?aGlpTDNLalZ6blFCbFl1dXZIek1ZMERUSkQ0a1BBVXdGWWlMb2N2S1hSWnEy?=
 =?utf-8?B?ZUE1QVo5SGRpRHd2V3RaQmhWczlubVpYOEFsNkxmRmR5MG8zczRjOXZiYTVR?=
 =?utf-8?B?dURpcWZxekE4VkRiWXVpT1NIRnhqOFJuTTdTTUFwS0E1OU5LYS9WcExvNWlJ?=
 =?utf-8?B?ZHhjTWlhdVBRLzM5QTVtVVh5YkJLMGFzb2prR0Y1OU4zSlZMMDFHcEVuZnQx?=
 =?utf-8?B?WU5BZ25ubHkvVC9iY1JpNUtzV01FOFAydkZUWGh5T1dqdmpSMTN4MDN3a3R6?=
 =?utf-8?B?YUFzRXBIWVIyekM3bXpFUHE5SlBqcE1FV2FIQ0FRY0RRWVUvNTdTZjBOYThH?=
 =?utf-8?B?ZWt0R1RDRkdjY1N3NXhtWXBhUUpaOWZSMkIvS1JiaFBndEhoN2hRcmk0TGhT?=
 =?utf-8?B?ZDhYK3ZZQUVZSXk0NFhmdm5RS1ByZ1h2VXNqMWpoQ0hDd3ljcHBSNXNXYmpS?=
 =?utf-8?B?ZVhQb2pWZVdrbEV2ZlJCYnRqWVFSeUFzdWhEUTFDdGora0doYThVQzhSWW9E?=
 =?utf-8?B?MWRnUzZUT3hBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmJLNjhmMXZaZ25XL3VlbzZrNHpDa2RnOFk5V0pzNzBrd09PZCs1czZRQVM0?=
 =?utf-8?B?MlBTR1JNRFFXWHJkVGViL29DLzFKa21Ka2FQNEVNZitYMU1OVnN0ZHdkKzRM?=
 =?utf-8?B?YWtGR3VpUGp5VXhzNTdXdkJ3UmZmbGk3UkVDWE9QSTBwcGlpSzJieDYreE1H?=
 =?utf-8?B?a3ZUOFVCWUlqMDJqQ1VDTGl2TDUrNTBXSFQyRnBXdk9VQTg1Mmt4dTJlWnFs?=
 =?utf-8?B?ODBXRWhDemVqNVBWWXAwdmtjZjhTTkVkdStsNkhGYnlxNml0RVpwamErOEhh?=
 =?utf-8?B?RzR0a003cnBVaWNqc1ZXMFhRUytPa29LUjg2RGJUSkhnQitZQkJBdzQ3N1dQ?=
 =?utf-8?B?UkpkR0k4OUl5M0NBSWU3L0NpbU5mT0lRK2dSL3pRVHQ4UXlqa05LUi9xU2d3?=
 =?utf-8?B?T09wQmc1VlNGK09TcU94VmdzalNwSWJ1WnBSaTRIZnh1NTRiVFZzakZVMkIy?=
 =?utf-8?B?aXl1OHFnOVRZc3ZOZi93R1JXUy9OSWNmOExHNE9BV1REVENodFZETGxOY3p3?=
 =?utf-8?B?am9tY2xsTWFETjlDczNHMGYrYnpJbEpHcnllY3piRzk4YzVmb2taR0M0UWxl?=
 =?utf-8?B?ZXd4cWtYTzMxS2hGYldBdDZqbDVPd3hFQkZOUC9JRUVEMnZXNjJvZWNOWDhq?=
 =?utf-8?B?VjJ0VW9vT0Y4Vzg2MW1oVW1CbG0yMEJrdFZBcXZuUEpLajhjcWZaTWtNOG5l?=
 =?utf-8?B?czN5dXZaNjZ4K3RwYUVqREtuQUlqcm1nUjkrakhwa2M0NlQrTndmK1pTTGc4?=
 =?utf-8?B?TXRQL3Qrc2s5d1RRUEdLdWd4dHNPcURLc1FEc1cwTWtNOFE1cmpUdGZndFBS?=
 =?utf-8?B?ZUlXV210b25ub0FrUkVzLzRzdlVvMTR6Zkw5NnJrNm1uRk9uQW1pZ2hzMW1x?=
 =?utf-8?B?bnoxR3IwSmExblBPK21QWUFQa1p2dWVDcVVSSUpmWFpPWFpGSk9JMk1md0M3?=
 =?utf-8?B?VElFa1hkSkJFZmk3cGRKbXlvMjhOcFo4MUhrNDl3cSszUVRmbTFvNXA5Sklw?=
 =?utf-8?B?ZmE3d09sMVRqUXhUckZKSHoyU29QNFBueGswcitraElFT2V3ZkNJNXdiSzJj?=
 =?utf-8?B?S1BQVkFCQWpPNHhnMFUydTJZYmJMbkxqajB0b25uVEJFRktvZmFBam9rTzhY?=
 =?utf-8?B?S2ttWHRCR2d2azczTEFMVi9Ld0xkcVg1K2FNQTZERmxSWm11bythRURqbG4w?=
 =?utf-8?B?a3JhbGVwa0o5NlQwaEYvRkcvK0hETy8zbGlqaUl2QWxBYXZMa0dDdzk5bHky?=
 =?utf-8?B?NzlVN0VsRXJEaWR3am5OOEo4M3dldVRxN243MlFoNVdhMEJraGRhY0lZRG5E?=
 =?utf-8?B?TTl6Z2tjYWppbFpON3NwbWp4ZFFOQW92U1R4M2RDQlBId01nM1hmK0VTRjV5?=
 =?utf-8?B?T2M2dDBReGRsWGdRbFlNM3Q4Y3VwNXRQZGRuRG9ZTzhPWEgvS0laR0NqOCs0?=
 =?utf-8?B?SEgvTjh6bmZId1gyNUFlamJoR3pLR3NpOTh4T1dMcHdkNEh2MEJXRjkzTG5a?=
 =?utf-8?B?U3hycHJaZnNRWXFUa2dzcFRscDBML3h6cEtYaGhWcVhwUmJJNytQYWUzTkVU?=
 =?utf-8?B?Z2IzSkpIUU1NNmpldWtsNHAwRjZzQ2pOYllxc1pYRWlIMmZnelNUZ2UxbFhs?=
 =?utf-8?B?RUZiRlJ6MDVyM25ianpXd0tFcUYwRko1SWpTVDRRV3g3MUVEanJVZ1pjbUtl?=
 =?utf-8?B?L3ZiS1hrUWxPeDhUc0xIWmw5WFdXNmcwT090MGNHdVlxdElZQlR1WDZrM3du?=
 =?utf-8?B?RDhjUlh1bXJydTBhZVN0VTA1V0dST3Z3aitJeTl2enkrQzZPMUYzRTZTRG1F?=
 =?utf-8?B?NkRDMG5WQnpMSytEbnJlaWRYWjB6ZHlsWERFVlUxQTZYaXV5OFk5WlpIQ2la?=
 =?utf-8?B?Zmp3NVhKWjJhOXBQM1VxQUppRWcraUhla2llOHJGYmVQYnBGOUZxN1I3VFNp?=
 =?utf-8?B?M3o5aHoyY0xCQWs2OUczbENJemhoY25YQWNObzhFTFJaTWNuZVpDNVQ2RmhJ?=
 =?utf-8?B?QVo2ejNkakdOVEFDSWk2UEsvUllZU3BtbldwdHJuM0VhaDlyWG95THdPb2Yv?=
 =?utf-8?B?eGFGblZqL080dHBrUWp1cXNha0NkKzBrbTFtcGtQV2dTSFV5NE83b3JJcmE4?=
 =?utf-8?Q?mAnK6kXpb0B3lp+NYp/X6W0+p?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb2239c-9b2b-402e-7a25-08ddfbac1ff0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:51:24.8493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcdK/Hi6FfMYvlCactVoaBY+fg0CcEhO1+2r/0M4KVcupMQ6J5HjU2iRUyuQeSqPdYB46MYdUcgh0VlXGzPFMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11776

On Wed, Sep 24, 2025 at 11:52:29PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Sep 15, 2025 at 06:22:46PM -0400, Frank Li wrote:
> > Add MSI doorbell support to reduce latency between PCI host and EP.
> >
> > Before this change:
> >   ping 169.254.172.137
> >   64 bytes from 169.254.172.137: icmp_seq=1 ttl=64 time=0.575 ms
> >   64 bytes from 169.254.172.137: icmp_seq=2 ttl=64 time=1.80 ms
> >   64 bytes from 169.254.172.137: icmp_seq=3 ttl=64 time=8.19 ms
> >   64 bytes from 169.254.172.137: icmp_seq=4 ttl=64 time=2.00 ms
> >
> > After this change:
> >   ping 169.254.144.71
> >   64 bytes from 169.254.144.71: icmp_seq=1 ttl=64 time=0.215 ms
> >   64 bytes from 169.254.144.71: icmp_seq=2 ttl=64 time=0.456 ms
> >   64 bytes from 169.254.144.71: icmp_seq=3 ttl=64 time=0.448 ms
> >
> > Change u64 db to atomic_64 because difference doorbell may happen at the
> > same time.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v2
> > - update api pci_epf_set_inbound_space
> > - atomic_64 should be enough, which just record doorbell events, which is
> > similar with W1C irq status register.
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
> >  1 file changed, 136 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index 83e9ab10f9c4fc2b485d5463faa2172500f12999..06c13f26db1c6e55d23769e98e2cfd80da693a20 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -36,11 +36,13 @@
> >   * PCIe Root Port                        PCI EP
> >   */
> >
> > +#include <linux/atomic.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >
> > +#include <linux/pci-ep-msi.h>
> >  #include <linux/pci-epc.h>
> >  #include <linux/pci-epf.h>
> >  #include <linux/ntb.h>
> > @@ -126,12 +128,13 @@ struct epf_ntb {
> >  	u32 db_count;
> >  	u32 spad_count;
> >  	u64 mws_size[MAX_MW];
> > -	u64 db;
> > +	atomic64_t db;
> >  	u32 vbus_number;
> >  	u16 vntb_pid;
> >  	u16 vntb_vid;
> >
> >  	bool linkup;
> > +	bool msi_doorbell;
> >  	u32 spad_size;
> >
> >  	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
> > @@ -258,9 +261,9 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >
> >  	ntb = container_of(work, struct epf_ntb, cmd_handler.work);
> >
> > -	for (i = 1; i < ntb->db_count; i++) {
> > +	for (i = 1; i < ntb->db_count && !ntb->msi_doorbell; i++) {
> >  		if (ntb->epf_db[i]) {
> > -			ntb->db |= 1 << (i - 1);
> > +			atomic64_or(1 << (i - 1), &ntb->db);
> >  			ntb_db_event(&ntb->ntb, i);
> >  			ntb->epf_db[i] = 0;
> >  		}
> > @@ -319,7 +322,24 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
> >
> >  reset_handler:
> >  	queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler,
> > -			   msecs_to_jiffies(5));
> > +			   ntb->msi_doorbell ? msecs_to_jiffies(500) : msecs_to_jiffies(5));
> > +}
> > +
> > +static irqreturn_t epf_ntb_doorbell_handler(int irq, void *data)
> > +{
> > +	struct epf_ntb *ntb = data;
> > +	int i = 0;
> > +
> > +	for (i = 1; i < ntb->db_count; i++)
> > +		if (irq == ntb->epf->db_msg[i].virq) {
> > +			atomic64_or(1 << (i - 1), &ntb->db);
> > +			ntb_db_event(&ntb->ntb, i);
> > +		}
> > +
> > +	if (irq == ntb->epf->db_msg[0].virq)
>
> So doorbell 0 is supposed to trigger the command handler? Is it documented
> somewhere?

I missed my very old patch in drivers/ntb/hw/epf/ntb_hw_epf.c to use
doorbell 0 as trigger command handler, this path should never triggered.

db 0 is not used in ntb_hw_epf.c

>
> > +		queue_delayed_work(kpcintb_workqueue, &ntb->cmd_handler, 0);
> > +
> > +	return IRQ_HANDLED;
> >  }
> >
> >  /**
> > @@ -500,6 +520,90 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
> >  	return 0;
> >  }
> >
> > +static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > +					    struct pci_epf_bar *db_bar,
> > +					    const struct pci_epc_features *epc_features,
> > +					    enum pci_barno barno)
> > +{
> > +	struct pci_epf *epf = ntb->epf;
> > +	dma_addr_t low, high;
> > +	struct msi_msg *msg;
> > +	size_t sz;
> > +	int ret;
> > +	int i;
> > +
> > +	ret = pci_epf_alloc_doorbell(epf,  ntb->db_count);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < ntb->db_count; i++) {
> > +		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > +				  0, "vntb_db", ntb);
> > +
> > +		if (ret) {
> > +			dev_err(&epf->dev,
> > +				"Failed to request doorbell IRQ: %d\n",
> > +				epf->db_msg[i].virq);
> > +			goto err_request_irq;
> > +		}
> > +	}
> > +
> > +	msg = &epf->db_msg[0].msg;
> > +
> > +	high = 0;
> > +	low = (u64)msg->address_hi << 32 | msg->address_lo;
> > +
> > +	for (i = 0; i < ntb->db_count; i++) {
> > +		struct msi_msg *msg = &epf->db_msg[i].msg;
> > +		dma_addr_t addr = (u64)msg->address_hi << 32 | msg->address_lo;
> > +
> > +		low = min(low, addr);
> > +		high = max(high, addr);
> > +	}
> > +
> > +	sz = high - low + sizeof(u32);
> > +
> > +	ret = pci_epf_set_inbound_space(epf, sz, barno,
> > +					epc_features, 0, low);
>
> Should this new API be used in pci-epf-test also?

Needn't, because pcie-epf-test default set system memory as bar's space.
switch to MMIO when enable doorbell and switch back to system memory.

size alignment already consider at bar initilization, and we can't change
bar's size after bind now.

Ideally, msg MMIO space can append into BAR0 space to avoid polling status
change. But not easy to implement yet.

Frank
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

