Return-Path: <linux-pci+bounces-17716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C432F9E48F0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D267161BBB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2F20C475;
	Wed,  4 Dec 2024 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jskNY5xG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16BA20C016;
	Wed,  4 Dec 2024 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354788; cv=fail; b=ktw7jvHftSXyA7V4IikzUhRR3/q16AcDBF+qXZVCF/gu890Chrkid+sD+jrrGFQ5wuA8op+lg2mvxkzeax1YAn2jhBmS4k6T+G43N+WIDajk9o6LidRb5u900osYBXwkvjn0kAJpRUlHUX8BankotJhEz3qpfjzQY11tsQrqINc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354788; c=relaxed/simple;
	bh=XHKH4FOIl126Q1Bwamwgx3RWbXI4RV2VvkzHgZRYSr4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sJUfSDz71tHahkWyBupPB7Vc9gabSndKuYbkGW7BBCJEvmx7hdAWi8P9Cvv2diIpl25TiHVR7FnOIiR9R+b50rK6KeBcrK8MXEkRgh3Nsb09zIczjtoCWn5Y9jcLCILcy/tqwlbddrK8xwoNIxdx9BvHiPXKijnN8E8CsgSWp04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jskNY5xG; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifpbaM84jjb4xfxVvBa3q4NFmztMz/yJC602jpMYkir739IRzJhY1xXUTt3YhRCXfI/XUbpIFsxBN+QoYj16DI8A8txMsK60Q3uQTo7FHRhUaYVEPGFAe5RAyteb2w17UDNcuqzt4jfoI0/x5uvDn9WS4vXLlj/jNBCzPN0oNFFS4ZJ0X7MvIyhP4+KjSFPzsVspx4BG3Hq61mjQd5DRoCkoMKP7stXGnBMBIAaNgB3fROivgyvu8CtP5ueUdf0X+XgZemXXVTjJyL09yoB6B3nP7Bm8lqi2ZRwAmf3Y5bMIKOh7lr4RkeItZZHMtiUBBTlMLjysUjiTyb7aBXrxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGSD9AFyTIKO9H3dSEv/OAXr3iod9eJEv/xONqwEuno=;
 b=uTKRzI41VJTwHOC0CaQr9kvvKCjzniN/GVRvAznplYyshx4dU7vznyucwjt+YnDcX9FF1aqEz4WGU6qScwWHcDf2gxcUwO5cVKawDCl2FO10CKlOPy4BHWCjmcpmbUJbDsQzGCFi2fyqyy9OcCvZSW5DOfuMBOQV9TDtV1DptS4XfoKSudJwI5fj6q/wzLGfi5bmR8tKN/6El1yOKE5Qs9dZ3mn/emojkcF+1fUusrYzny85geKIl8o4lHoSTWxXiWGkYLaLxsfPmOpjgrG7GAGuyTqnTyEpDT6Y7U+n1BxfZwmfPDZa57VOjkG70BPsKWmyu8tkBiKHnCJDhYzi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGSD9AFyTIKO9H3dSEv/OAXr3iod9eJEv/xONqwEuno=;
 b=jskNY5xG461uhgYzjk2A6KRG33inArd7BGR+MMv82zhJPo5GKR+jDssUENUwWsuOUuf2KnFXzXhvnTLxWaUn/V7Pb0eq4fnkpleSKl3g0/9he95Uoz3zQ+Qb9qYMLM/WHdXzQL8cycghZ6rbrUL0cTqiofIz7kXUynQeQHd8qD1Asr6TpGEJAJKdArLIMyYI7hIda5VJxWF6iA7ZKyfLs8I6kLfzPjTtNYQb3OCahEe3b3gOrg0lUoi0WciFguDq+YYT2WEN/rhRE3OR0OZjL3hJqACulD13pofw0Zg+kGFHlClazXYQt7Ed0WRaKX8fCGA2he4MCWWOKgm5aEpdig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11006.eurprd04.prod.outlook.com (2603:10a6:10:58a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 23:26:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 23:26:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Dec 2024 18:25:52 -0500
Subject: [PATCH v10 2/7] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-ep-msi-v10-2-87c378dbcd6d@nxp.com>
References: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
In-Reply-To: <20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733354769; l=8502;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XHKH4FOIl126Q1Bwamwgx3RWbXI4RV2VvkzHgZRYSr4=;
 b=d+i8+h5nWlkVHgZIkWlRB4JfTEC1Hq116o2oGNoSYQ/T5Ph93Xi+rPoboBwgAwablEbl/nIsx
 oVxBrN55Pl5Dj+bsMw7ZcLFE+CFOMsFQx6LyWNjh2wBsPvAWu34uAUl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11006:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e89c59-3bfb-4ca1-1b77-08dd14bb10b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTVENGVpcURoeWQvbVE2U1diZjFjUzF6eEM4WnBiSHpubk1ESm9sUUNSM2x2?=
 =?utf-8?B?Z3JIZ3ZIKzNYRWowcUgrRUhyRWJGVUp5dTMzaGdEek1PMjBmcDhmL2VkeGdB?=
 =?utf-8?B?dU9xRlNjUjVVQjZkY1dsUVJLdTZuaXBIYjhmbFJEbUZkS3NhNTJmUld0eFhJ?=
 =?utf-8?B?MDZaa3VFRXZJbzVZV0p4aXZWTjE4Y1NnWmxnTWYzOTBhcE00ZVhsNkpWekVD?=
 =?utf-8?B?S1ZQRFMxMC9LbFc4TGQ4U21sSzFIMGE5NDl2RTFrd25ldTFFRWw0RCt3NWlx?=
 =?utf-8?B?eFl6TkNIRTQ4MUlLdStNVWVxSmlLa1ZnWC92NjJLQTZNTlhyVVdKRVNzdGQy?=
 =?utf-8?B?S2QrU2xrbXJFbC9QWHJuT0s4TU1BUHRnMWdqekhLLzZPV1JzSXpNeCs2emdh?=
 =?utf-8?B?MjU1VlV6VEQxYnM2bFlOYzdIeXFoeUptWXFCeTZsMmdpV08wOVRUVHMrVnRt?=
 =?utf-8?B?NzdMYXNqdXFkRXhlelNzYzE5c3F3ZnlIbFEwWnRpMGV2Vk5tTUc1SXIyNWMw?=
 =?utf-8?B?eWxUMzI0OFM5TXNCNGlMTnFWTWhjMjJZKytWamVhNjI1ZXBUUlBVY1J3Z01H?=
 =?utf-8?B?KzdBTUE3MXBsdlp5YlhPaVdGNE9xUVhnN0w2REFSVWIvNC9ibDhPb3hYZTZt?=
 =?utf-8?B?KzNxVlQ4SEJKVWNSSEJ1OTZqbjZ3UVB3UWNBS2pKN0t4NWRlQU0vUXNUcUt6?=
 =?utf-8?B?K3RRa1VhNmxuNW5jTnk5eE8yRGpMK1hvMUwxL3pyMUhFV0oxOHJ5c0VMNmdy?=
 =?utf-8?B?ZUh1cGNYbW92SjArNUFFOEkybmE0UkUveWtqUkgxTkFQYzIvL2NMblVPYjhB?=
 =?utf-8?B?YU1ZSGVpMEVuS0lzQStRSXJMM3pORisvRHRiQUFsTjlnTGJqc296N0V5bkY2?=
 =?utf-8?B?eEpySnpKVUNtN21RcHRBOXloN2k2STdua2h3MzRRaVR2UmRRYlBHbFdtMHAy?=
 =?utf-8?B?ZDBaZ2RwcGYxczVXVU1MT0o5SzBlbjRVK3hjOXp5SDlkN3E3U3Y1cUt2bmMv?=
 =?utf-8?B?eXpndEhadVZxVGtxaklxOEpYWi9rMUsvVE9INVE0Zk1kWUdKLzQ2KzA0WkRR?=
 =?utf-8?B?Mno4U1diUzZWajhyQVhHTlZFMWF6bmp3anZaZ245VHN2NGFEWW1oSW95OWxI?=
 =?utf-8?B?aE90TWNWRmtvdC9EQlNNWWwzMlREWjdSYnE1SzYxc0kwcjdSeFNLZ1A1VW5p?=
 =?utf-8?B?V2xCRDRoUXp2RkdMcTFFTTN0TXQ3SmQ5Y01uZ2l6c2VVTVdJeFRySUpmSHVS?=
 =?utf-8?B?Vkd4Vk5VOWdpWlgyL3VPNjJQT3lCcHI3RHRuK1lKZ0hMZDgySFVLRTNsSXV0?=
 =?utf-8?B?YmpoT3pLd3YvdzFoTVVaMVFGVFFaOWRGNHRQc0VoK3VmT2NxdzZvZnY3bTZL?=
 =?utf-8?B?Y0xIbkJ6UmdaZWxESGRxY0J4YTRuNldkU0gwbEc2R3QyWFpXVnlrdTNXR0w1?=
 =?utf-8?B?aUJaUWQ2Z0pyVXRiRk1SdkNjb2VJMFVQd0dEYThHRFp5VlJmc2JhNW50NWF4?=
 =?utf-8?B?V0h5UTAvY0ZFazF3ek5LNm1VWW8vOFlucEk2VHhhL09GcDVpSVc5NnlZenA3?=
 =?utf-8?B?cEhIeFlQdUNvUXFOYytwME9SZkpJTmxrOXhVUDYzRXQwUCtPcEovd0QzQUov?=
 =?utf-8?B?UW91dk04eVhXSkhtQ2FWeDRzeWE5NCtJMWJCM2hUeGF1NG1uTDkxUUMwWUtl?=
 =?utf-8?B?VkR5elhYV29mZUtVbnRIRWJtU1pQZ1ZieUdaOXFZamtVaGxEVElUdGhrYjlM?=
 =?utf-8?B?T3Z0eXBEVXhoQlpLTjRsZE9jdldUOVVjcDBmRFJUV0JaNERSR003NlNONENP?=
 =?utf-8?B?TEo4YzI3MXJxSkpnN2l1OEhoNnBidHBNYStDL1VVZko0cUNjNkNOczRpY21Q?=
 =?utf-8?B?YmVZR3NBc0hiWUdOdVY3UmtBSGxUTDk4UytSRnVKeHVrdGxQbDN6QzVSWCtB?=
 =?utf-8?Q?UVaQtP+AphQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?My9KSXUzUTJ5UHkzWWxUNkwrMEVzcVhYMXNweHJrcXVoc1BYbUt3b1YxeXJQ?=
 =?utf-8?B?S0FnMHdBVEwxNGNpRmVZVHRHWTJjSHZVcmRmaWRvT2hQRVQrRHUrTnhtWS82?=
 =?utf-8?B?UzJaTkducjFteDRYY3hFbGxMYmp1T3VKSFJLK0wzMjRpV2wvL2laN3pZaGhK?=
 =?utf-8?B?VHFYa2UwUFF6M0xsWGg5ekIveWQ5R2k0U1RhTUR3aWdIcHFodE9yWDZ2SytS?=
 =?utf-8?B?R3E0SVJTM1MyOEErRGtCa0w4c0pXVU1nSjloQ0RDenFuUkc5QS93dzdMckY4?=
 =?utf-8?B?YnYzZkxwakcxSlB4UjZNL2pWWHllaFlnalFUajNWUFd5NzlxT1VuUTNIRDEz?=
 =?utf-8?B?ODZSSXZZWFVLdFJRSXB5NnkvalNaVkJDajFJUStlYitSTnVEaGkvcDkyaXMz?=
 =?utf-8?B?V3Q0OWFzbFRwbmJEN2NxanNtaHZHTDhhSEhwSEtLQXp1RW5DSTlrVy8vOHRm?=
 =?utf-8?B?Mi9NMjNndFJiVXRQREV3bTBoOGtlTjV2M1IySUVTZnFKUWt4czFsOEh6clla?=
 =?utf-8?B?NEtVVStzVGloVjc4Zk5zUW90L1ptWTdoZXlZUXFrTEJkdElHbXc5UnpoL3ZW?=
 =?utf-8?B?MVdzRWhOQW4xWXZSRGl5NHRGKzFudTdHeFR1M2xoNk1abmRKWHNxRnNEbUNH?=
 =?utf-8?B?RTBGUDMxNEFNSXJ0QXJMOFdSOTRaL1kyM3RGNjBBazRQQUU4QkgrUjdmeVd2?=
 =?utf-8?B?eE9rcVRCdlZ2R2JlS21SbGgyRTJEd0xVN2k4N2xjbTQzTFFFN2dJNU5Pek1Z?=
 =?utf-8?B?MnJkV3VQWGtxdXY5TEpLNEJzM2kyQ2kxc2cwSWF0QmxYUnMwUHlLenVmVm5K?=
 =?utf-8?B?c1FXc1NHVkozRnY4eWtJRmVGMWR2dGVzVzVLNXZRZzE3K3owbmMydWpmbHBo?=
 =?utf-8?B?azFIV0U1WDRYNEJFeklSNHAycTNtQlduY2tjSEE4ZiszRnJ3eHFOS1dEdmFz?=
 =?utf-8?B?eU83djV5RUpGM1h3N0ptNVB6RHZIM2V2RTBzU3RWcGlkbGVSQ1FZK2xOU05G?=
 =?utf-8?B?L0NzTkNFOUJtaE5TRUNPZGRvMlk4Zjlrb0dqU3FuVkI1d1RkUnRYbXU2RnRh?=
 =?utf-8?B?ZFE1SWRBeHo4YTJLSElKYUh5RSsxSlVhMVRrdzBNM2J5QVplWG1ibndYRnd6?=
 =?utf-8?B?VHV1enJnWFZvT0VUTzh3Z21wL3VRYzhTYyt3ZktYenNMbVFidUkzcHdLdUVW?=
 =?utf-8?B?SmR6TjhNdlFZRHFJYk5SdWl4TDRMRmh3SUZ0N3hxSURyVTVQRldCYTZMbk5l?=
 =?utf-8?B?SVlTNG1hdkZZRTNHRktYTUNGUnpKR0p1R0kySFBkemVBYWVFVGFzTXlGYVda?=
 =?utf-8?B?UjQ0ZGxtUXlIODczRHh4elc0SERIS0d0N0dPN1RoWHpZK1VSWkpmQS9mQzFj?=
 =?utf-8?B?cHY3MFgzcU1VS0VmaDBCQU5ia2JEZkE4UXNxL1RXRVRRZUdHZ284dXVzUFpM?=
 =?utf-8?B?WUc2dTYyMTVyNXQ2bU1KM1djajdmb0tpSGZJVm8yMjdrdWNJdkgyL2dJYzkw?=
 =?utf-8?B?d3NOaWlpanVDaE4xTVhtczN3bzI5ZWtuZk5UQ2I0dTRpNWt5Ri90alVtTmZS?=
 =?utf-8?B?MkhCeDJWd2JKTTRqREU2c2R2K2JhMGl3cVhmNGxvOG9UV1gxcERXRW9XdE9k?=
 =?utf-8?B?Ujk5VW9oMjJLZDdTcVg3S1lMYklUR1lsQURPNWZyN1cyT1V4eFdldnNSdFpy?=
 =?utf-8?B?R1paQVF0S2pER3hTODh2emdGa3ZCc3U4ZTdzdHpjUEo1YlF3T3VPOCszdmEz?=
 =?utf-8?B?eDczU3VQdUplREF3NFV2RzM4NXByY3RKT1ZYaFM5bFQ4cTJwbnpQaVJ6UUV0?=
 =?utf-8?B?SjFWcG52K0JRTHA5amNaT2g1NTVBVFdWYWVwcUJQUW5xTVdPODFuMGhYejV0?=
 =?utf-8?B?U0J6UGtYNW1wZ3l2bld3SldKcVNsM1BXbm50TC9kUVlkSGNYM2dodFpCNFF2?=
 =?utf-8?B?WTNLaUFZbmJ4OVhuS1ZoQVBQS2xzdkZnT213WnNYWGI0dlBWcXhCWU5iVDNB?=
 =?utf-8?B?M2EwS1kwS1ZvN1IremVHS3N0aDIvdTdkM1BycllCbHg5Sit0RGpCbzdMVnBt?=
 =?utf-8?B?aUhseWZ5NVlISTRBZ21rQ2c0OTVVaXZLYlczYzFEM3FLOUh0NXc5THl2Z0Uz?=
 =?utf-8?Q?ziUc38OtlY1/Mq0lE83mmauGQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e89c59-3bfb-4ca1-1b77-08dd14bb10b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:26:22.9260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sF/TyBFNE2zNUdcb3fFQCMQuZHxhlIwEBlg/73zTMMSoEEwyUNU85PBqMcXEETMUFeITSegrDZgTaj6mVQmsaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11006

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |   2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 148 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |  15 ++++
 include/linux/pci-epf.h           |  16 +++++
 4 files changed, 180 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..b0a91fde202f3
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epf_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->msi_index;
+}
+
+static int pci_epf_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *arg)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct msi_domain_info *msi_info;
+	struct pci_epc *epc = epf->epc;
+
+	memset(arg, 0, sizeof(*arg));
+	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
+					      (epf->func_no << 8) | epf->vfunc_no);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the device
+	 * domain, but vector allocation happens one by one.
+	 */
+	msi_info = msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec = msi_info->hwsize;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, arg);
+}
+
+static const struct msi_domain_template pci_epf_msi_template = {
+	.chip = {
+		.name			= "EP-MSI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_write_msi_msg	= pci_epf_write_msi_msg,
+		/* The rest is filled in by the MSI parent */
+	},
+
+	.ops = {
+		.msi_prepare		= pci_epf_msi_prepare,
+		.set_desc		= pci_epf_msi_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_DEVICE_MSI,
+	},
+};
+
+static int pci_epf_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &pci_epf_msi_template, nvec, NULL, NULL))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = (epf->func_no << 8) | epf->vfunc_no;
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epf_device_msi_init_and_alloc_irqs(dev, num_db);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	msi_domain_free_irqs_all(&epf->dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(&epf->dev, MSI_DEFAULT_DOMAIN);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..f0cfecf491199
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..5374e6515ffa0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


