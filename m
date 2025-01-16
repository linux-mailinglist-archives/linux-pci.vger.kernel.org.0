Return-Path: <linux-pci+bounces-20005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF0A14168
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968B13A3BCB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5338922D4CF;
	Thu, 16 Jan 2025 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JJ+y2NEo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD92514EC4E;
	Thu, 16 Jan 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050672; cv=fail; b=lBw/iuw5Z0OVnTdVWfs7a2aoTwcNFdsSEIEIHDJ1oW7678VeZPDB+60IOoRBo0eVWfAmp/7jCjhGoOwTFeqTp7xY+RV5h9NR2mtU4SrVz79P5sifbzKELcBURC1p3avilN64puFD/FhybTq8n6Yj9i+ncYrZ40m/cXmcmS59/ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050672; c=relaxed/simple;
	bh=7S5NRToSXsGI9Ngu9mgow5RFbwunpcxKLSJpcVwBFVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s2ym8ryb/pKMRAL3SUgi6yHnKLQRBqlho/6prl7nSGPSyTKbDhgr4b9aEPeUkfNyPo7WScMTxJtMJciPow9I1iWxX225sU2qXuQkOWOcylyOE08sv+Qk3i8l3yCLdGCz3R+CbmNRmVn+Pu1RLc7LjKPolJyAkyksO8cBFwT9jZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JJ+y2NEo; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QawLeq5jbz0IypFVqkmF+J9vLsCq2thYZVRajznHSlBF8DYZYRwkeVO+q9nEG+5NEr9xMJgH7mb3tP78xpSNGjD2/bzlVdrEg0jJXWm09/2X3v98WUirHXr4mzjbRDZkfbwLLhKiuqwyttbq+xO0NhlvX5UTmUzntnDGbGue0c8ALhThA0K5TeUgK/HmjVWpKn6cP5rp0aPTOzGnRg4ixdy9t+nfmiu0jfI7+53913349orLQA9KsvfTWSbdJhbJ8155Udp3ZBI+v+JB0y2OgNZ4/sU/7rGnwQAZ5lfFBHhRFyDh+bVx700f+CDjuXBdg2ht82B72ahrOebmHDt2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NCharVpWdd1d5/9Mu0RheuZTOyiAWVdV+H6lvc3HRg=;
 b=Zb/1XAxOLRKkBTcF8PJXfHkoJgp2LHjZqh05pLdhLvSn8TYevprZvmkv3Svpbp/jBUXv5fREgPaKjaPuDhMhYAkGWs8YjtDFyKu0F+P8qOcmm1HNw4frg4QJ+rcMy7DU3CKxcT/2Qa9fVOmuzMiSiCo/DhIske0SZdSaST6SkDWCrdr41IVoEGXgU4wjqPh5hiNHhDfsznKrDYta+wvh0a/Fw3YeTIk3LylEhnXOKhGbzf5zGxVfmQXvA9Z6EULstnWTWLcfm9QLcZPIhzWNWuNR/KeD0GTNY70XLMgDdhKWTrjdG73kF7pOCQUNS5O6zdsCxa3N7nMB5GuGtLy+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NCharVpWdd1d5/9Mu0RheuZTOyiAWVdV+H6lvc3HRg=;
 b=JJ+y2NEoIuv6FFd+H5aeec5uyir26a69AsmQUPsxXCGfrhb8f5NP7Vy7ks53XFVf5AHRjlo0F0PrpAoRJAecqUIs8c8ua1OySYG7ZITrDtwwWFT4+H475hbMpsirTqonY/mxcPkEW6fnbzXRwa+srRT+du55BlaXSFVb0ne3Opp7jeaBpcgQG7nqaQbcQz1Pf/gH7OaIzG29SSKHFJzYFpnaNE/0wmVu44bkc4P6smMUAxc691sgXmZtnUlZGfbGPtdpA+UpvnKjz8aqpRopHB2P8cfFCcAu8gdT1XG0y2YQ0gmLp1E6gC/TUpj47UNlMbJCSIX5Vq7DI7526tfRzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 18:04:26 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 18:04:26 +0000
Date: Thu, 16 Jan 2025 13:04:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 3/7] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <Z4lKIJ8nDst7rqCs@lizhi-Precision-Tower-5810>
References: <20241119-pci_fixup_addr-v8-3-c4bfa5193288@nxp.com>
 <20250116153239.GA582080@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116153239.GA582080@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::35) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 7275c007-07d7-4ce7-a653-08dd36583719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZngyTkR2MG1scGNnNnlSeDY0VG93TmtzVklmS0F0Tm9FSS9xeE90MUdYMDFE?=
 =?utf-8?B?YmJCdXRRRGV5UmNObC8yRytNVE1OdXNZdkFUb3NibS9TaXJ6bDU1WmJLNHEx?=
 =?utf-8?B?RlZpOXh5M3kxRS9GQkF6cWM2TTZ6RStzZXh0M0FLZSsyNTZCbHpUMWxvYnVG?=
 =?utf-8?B?eDEvOVBuVDdkdmtkSGtBUDNxNGxMRnlsVjF1b3RPS2VqUlpXcXB2TnhMT0tj?=
 =?utf-8?B?c3ZUaTZqYzFVMmZNMTRYaUZsa3Nnb0xUcmlKMEdXUFdzQVo0RUtpMVpIRU43?=
 =?utf-8?B?bHgwbFNoa3huUDJWSm12c0VYMFFCRnIxU01zQWM4M0FKNGoyQTFRczFnZDdX?=
 =?utf-8?B?MkdYSGNZMHVjSWtuYVcvdVJ3TWtVbWt4Kys2RFJtQ0hWNG8raWJEVk1zU2I0?=
 =?utf-8?B?bmZFOU5DeHplVFNQZTQ3aGhtWDNMbFd5NXk4WGkwaTFUeTljMEw5c1hSdXVy?=
 =?utf-8?B?Tkh4UWNJcWZYbGZlYTFUcGlxOHdVRHY4MHpRNzY3dXBMbjlid1RLOEFxblkx?=
 =?utf-8?B?RFlkSno3RVZOYVZDUGlXek8xbmxqMm1jTXhUOVVpVzkxNlRDUzF5U1VrMDNG?=
 =?utf-8?B?bXRrQnVBUThFcmsxUG13K21kaW9QOTFVYXRlWTIwRTZqRjdXU2NKWDk5SFZt?=
 =?utf-8?B?eExWRlZ1dkowdTRjcC80M3lFZ2RZUGRBUndCYk41eW05cE1qQ1VIWU1pWm5k?=
 =?utf-8?B?WTRTaUJKeWVsaFBFS0VMUU5NSlF2NTA1MjNhL0xnTGxVaDhwODFNbzVtZklK?=
 =?utf-8?B?V3hrOTZRTitkYmhtT1hMK3duU1E4bmV1NHQrZ0k1NE5TNWRnTXlub1F4c1U2?=
 =?utf-8?B?UWxBV1FhY1FjRU4way9yeGhBK1E1WHhpbEpuOG9uVkVCWXVKR25XNmEwbXNk?=
 =?utf-8?B?MmJUME0wcW9BQU9FQ2llVXdBKzg1R2NpTURGZ3ZVK0Urb2NqUkpNSWNBN3Rs?=
 =?utf-8?B?TWNuV0VWVnppd2R1ZFBjWnRveVVDWjJQY1luWnhtelJ5aW9LckliLzZxNnE0?=
 =?utf-8?B?ZHgvRDQ4L0VpaVdXa1RQNEdaTVJ1MEk2ME1JYk5CK3poQStTRzFTaGlGYlV4?=
 =?utf-8?B?THRjZmM5VG1jeTBScU93aGFGTCs4aklkVVpSMEhpODMxWC9GUUozaHp1Vm9y?=
 =?utf-8?B?S0lvZE9leFVNMDdjWThuVnVJQ1JUUG9XaHc5TU1WTVljLzVQemQ5c2xGc24y?=
 =?utf-8?B?WlFkUnVySzhiclBHRzQ2bk4vNkpiNkN1aGFMQ0dmN2xqZ1d3d1NPTjlYL0Rv?=
 =?utf-8?B?ejc3ZXNaMTBCUExTNSsveHZ1U1k1MjdPc1NRRVl5eXd5cXN6blY4aVNkREFh?=
 =?utf-8?B?YWxVdEN3Zm1LVU83YndoTWVqQ3E3WTFNQ3ZzL2o4bXZSNnhzRnFVeTQyaSth?=
 =?utf-8?B?Ymk1cWx3aUQwWnpPK3k2SVMrYzNreG80Q0dLckNxekUxZTFlTVk4Mk0yeExW?=
 =?utf-8?B?M3lhOW4wV3ZYRDNtSGVWaUh2QkE1aTR0VE5pODFOMjBhbUdhNkZZMHlBbkNB?=
 =?utf-8?B?ckpvK2dEcUVDZlcvN1hVVml2ZlB2SkpILytMQnhFM3c4Z3IzZ1MvUTZNS3Jo?=
 =?utf-8?B?NzRWOGhGT1k2Q0Rsd0J6Z2E2MnEvVHhIbTZvaEVLNXJWWnBYeit0QnJ6dDRx?=
 =?utf-8?B?L1kxLzZjUmthYXE3TVlGbkQxMzhPVlEweGQzWDd1VUliMEcxL1ZLdk14S0dx?=
 =?utf-8?B?UWlJaUdyWjNiUVlETmNyZFJDU0o0dmpJYy92YVVPWTc0ZEY3ZmxhMEpOR0RX?=
 =?utf-8?B?QjR0cFdIN0l4Q1NzZGJaV3VhOUxZS3MvUmFqaURlR0pDVzRINFZUTUdPVGNT?=
 =?utf-8?B?VU9xVnlONDJOMGdzTC9XMC93SG1zQXF5cmw4a3d5ZjZDalk5VThtZTVFQ1lQ?=
 =?utf-8?B?dktLOXpZdzJDbkFSS0xNNTYzUHo4MWFtbWdMK3NwZWczV0wxczNweEh1MGlo?=
 =?utf-8?B?akhLR056eHNSd1l6YnBGRGZ6Q2NiSlRIL2swMVA1b3ZsSktrS2Z4N29BS1dy?=
 =?utf-8?B?cDBudXMycTBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdZd1FDU1NWVXN0RnN2YjlSZFB3cituYm55N3dKOUdiK1FVSStnNVlxZzk4?=
 =?utf-8?B?VDVWTEZuUEI2Q3FoaDdiaWtYRnlRN2ZiYWRxQXhGYTZrdjhkem5RVndrVHE2?=
 =?utf-8?B?OHFQYjYwOWNRZk9PWHcwVXdKWXJYb2s3enVLZk00NW9Pc0FKdUU2QUpBZDUy?=
 =?utf-8?B?QktzSFRZcENWYzFqYmRrOXd4R01teSs4NGtUcDU4OURYTkFrYjg1RlB5eUt6?=
 =?utf-8?B?NlRsQTJHRmVSSWRUMHp4MUVqNFdCN0RHWGpQY3pleHlueUpvWlQ3Yk1JUXk2?=
 =?utf-8?B?VmxWYUpveWlTQTVIZ2ZIV0pMZ2lFanA1L0ZOSzNTUUgyTjAzSnhXMzRNZG12?=
 =?utf-8?B?ajFLcFVGQVdnMWx4QWh2WlZoamhTV0NwUTZNcjNiZDdsN01iaCt4VkI4UmEr?=
 =?utf-8?B?Y2NUdldTNVRYQnYzd3EydHp2cW05Q2pMV3d6NGg5RXRzTHRMQ2lhSzFNMm96?=
 =?utf-8?B?Q3NjNXc5WmMxMVVTNk44dzJKVk1kSTNWY0I4bkMzNGRaVndlOXBnb1ZKcE1M?=
 =?utf-8?B?TkM4VitnOW1WSnRzZTd0UDF3QnRoUEs5Vkk1Zy9ka1Z6bk9JSU1BVXFqQlN1?=
 =?utf-8?B?bG0ydkRGeW1ISGx0UkE3Y0xqYU5IZmdSUk5pK3c2MjdrMHFVeGp6bmR5MlBl?=
 =?utf-8?B?c1djMmR1RG1sK1JKNTNjdy9KQnZmSHJ0Z2hKNW9PK0FyMjBVYVNwRS9KTG1C?=
 =?utf-8?B?aFQrUGlJQnZJdllHRVd4VEF4L2JyenlwUTZxdXNSVDBDdHh2NjNSUEJldG15?=
 =?utf-8?B?YWw0VEQzUVM5MlR5NVhGQ0ovNWRRK2IyVndjWXQvQVNJeWJreEVqTm1UTEp4?=
 =?utf-8?B?ZUtKM1ArT0IzSmEzTWlILzd5MnhIZFFhZTcwdmtUdHRBaHVVVHNBTmVxSG5D?=
 =?utf-8?B?TkVOZ0tydkJCWEgvdWY3emxOZlE3d202NlJ4UHF3L0R3d0xER29PeGxxZ2Fi?=
 =?utf-8?B?YWt2MVRqc0RPcU14QUp6WFVhdmp6dTJQOXlxVnBJZDgxaTc0N3FtMGxxUis2?=
 =?utf-8?B?T3JiN2cvNUdubHNMYlB6c2RNWGwxazd2TW5vbE9VWGNhZlBLQzFQTlNBMmgx?=
 =?utf-8?B?cmw3eU1GRFFkTVR6bUtyL3doaFNza0h2RUhyTmFPMWdJVEd2NWJVSTZaYWRB?=
 =?utf-8?B?RFQ5cm5sY3ZYbzB6aCtsNFRONWdKZWZUcVJkaEFqNnNZcU82WW44cmtWb0Zz?=
 =?utf-8?B?MG5ZWmZJNVdKSHJPTG5KRy9OQXFFV0JsNFdxZGdHTFRZNVE2ZHZvc09uRjlu?=
 =?utf-8?B?aFVSVkFPWHY5bE00SEc3aFMyN2U4dWRYNlVWYjBiVm05RHNNUTVBWWdwNDhZ?=
 =?utf-8?B?a2cyeFZodTNzM1RXYzAzek9uRmxGbWVDaDBCc3ZDbHZic2JWVUVsU0JYdXJO?=
 =?utf-8?B?WlVBZGx3bG1KVHFEYnBVU1hTT1VVSE5QZEpuQ3NzQTJVNlB2RnZBT29kMWJI?=
 =?utf-8?B?b2xBOTlpTmJtOXRzMG1rMERKWjVVTzJQdkNOOTN6SVljSWpUMUJxUFFYR2d4?=
 =?utf-8?B?NC9razY1eXpNWFhmMzlQaDNUejYxSlJ1a2FiZ0J0MlFiSkliTldDSDJSdE5B?=
 =?utf-8?B?SGx5aW1zOW5sYjFnblk0dytMbkl1MzRGaHpZMFU0SndhYVI0ZEpKME4yd3I5?=
 =?utf-8?B?VTY1NHFoNlFOMGo4M0szZ2Q3NEhWMTF4cFVsQldSajhLelRaSGpNQ1RDeWx6?=
 =?utf-8?B?L3NrQTFBSmtzM2tmb0FMaWhlbnErWGt4RGwra0haUDZtT3ZoVzVxZDh6TFdh?=
 =?utf-8?B?NEUzcnUvMHV5MTJYWUJQSUpHNWs3NFdMVDB5VDBZSHZ0YVh0VnpWK0ViZ0Q0?=
 =?utf-8?B?OWtlMVFJV0N4Nkxub3RsSWNzWnNXZmt3NTZsaURYQVBCOGs2QW5vL1l5WFZm?=
 =?utf-8?B?UmlWVlAwUjNzSTNUS1VBMitXMTJhanNlU3ZOUERQd0V1VFZ4L0FnclhkYUo0?=
 =?utf-8?B?WmRLb0NVUVBLUHBmdW54RUJ5eWhSa2hjZG50MW40M1JnZG5KZ3hvRE43OUc2?=
 =?utf-8?B?RnJNL3p0TUZ0Q2pseUFKUzlxdEEzb1Jzb3h0ZmlLNFQ1eEg1KzN5QkpuUjVk?=
 =?utf-8?B?d0FQUnh4R3ZGNC9qME02RGhoWmVBVlFrOWZsbkxYZDJlZmlhUXhRaDhpdUJK?=
 =?utf-8?Q?Gxh0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7275c007-07d7-4ce7-a653-08dd36583719
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 18:04:26.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyW1Kq0wGmc4mtn8I/dJeL7wKTL+ho3gYavxFw/wDN4tgoANdBgk5w3oTsW065jGp7a7NtVMqdvXuYKfv1ZLwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

On Thu, Jan 16, 2025 at 09:32:39AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2024 at 02:44:21PM -0500, Frank Li wrote:
> >                    Endpoint
> >   ┌───────────────────────────────────────────────┐
> >   │                             pcie-ep@5f010000  │
> >   │                             ┌────────────────┐│
> >   │                             │   Endpoint     ││
> >   │                             │   PCIe         ││
> >   │                             │   Controller   ││
> >   │           bus@5f000000      │                ││
> >   │           ┌──────────┐      │                ││
> >   │           │          │ Outbound Transfer     ││
> >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> >   ││     │CPU │          │0x8000_0000            ││
> >   │└─────┘Addr└──────────┘      │                ││
> >   │       0x7000_0000           └────────────────┘│
> >   └───────────────────────────────────────────────┘
> >
> > Use 'ranges' property in DT to configure the iATU outbound window address.
> > The bus fabric generally passes the same address to the PCIe EP controller,
> > but some bus fabrics map the address before sending it to the PCIe EP
> > controller.
> >
> > Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
> > fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
> > input address and map to PCI address 0xA000_0000.
> >
> > Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> > the device tree provides this information, preferring a common method.
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie-ep@5f010000 {
> > 		reg = <0x80000000 0x10000000>;
> > 		reg-names ="addr_space";
> > 		...
> > 	};
> > 	...
> > };
> >
> > 'ranges' in bus@5f000000 descript how address map from CPU address to bus
> > address.
>
> Shouldn't there also be a pcie-ep@5f010000 'ranges' property to
> describe the translation for the window from bus addr 0x8000_0000 to
> PCI addr 0xA000_0000?

Needn't 'ragnes' under pcie-ep@5f010000 because history reason. DWC use
reg-names "addr_space" descript outbound windows space.

>
> I assume the pcie-ep@5f010000 controller also has its own registers in
> the bus addr space, separate from the window to PCI, and its 'reg'
> property would describe those?

Yes

>
> The similar patch at [1] includes:
>
>   pcie@5f010000 {
>     reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;

Yes, but "<0x5f010000 0x10000>" is not related with this outbound windows
translation. So I delete it.

>
> I assumed that [bus 0x5f010000-0x5f01ffff] is PCIe controller register
> space and [bus 0x8ff00000-0x8ff7ffff] is ECAM space.

For EP side, needn't export pci config space for dwc controller.

>
> But that can't be right because ECAM requires 1MB per bus, and
> [bus 0x8ff00000-0x8ff7ffff] is only 512KB.
>
> > Use `of_property_read_reg()` to obtain the bus address and set it to the
> > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
>
> Why is this different from [1], where parent_bus_addr comes from the
> 'ranges' property?  Isn't this the same exact kind of address
> translation for both RC and EP mode?

The method is the same, but space means is difference.

RC side:
   regs, 1: controller register, 2: config space, (although it should be
in ranges)
   ranges, (IO range and Memory range).

EP side:
   regs, 1: controller register, 2: outbound windows space.("addr_space")

All regs need call of_property_read_reg() to get untranslated address.
ranges:  use "parent_bus_addr" in [1].

>
> > Add 'using_dtbus_info' to indicate device tree reflect correctly bus
> > address translation in case break compatibility.
>
> 'using_dtbus_info' doesn't exist; I assume this should be
> 'use_parent_dt_ranges'?

Yes, sorry, I forget updae it.

Frank

>
> Sorry I'm so confused, please help me out :)
>
> [1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com
>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v7 to v8
> > - Add Mani's reviewedby tag
> > - s/convert/map in commit message
> > - update comments for of_property_read_reg()
> > - use 'use_parent_dt_ranges'
> >
> > Change from v6 to v7
> > - none
> >
> > Change from v5 to v6
> > - update diagram
> > - Add comments for of_property_read_reg()
> > - Remove unrelated 0x5f00_0000 in commit message
> >
> > Change from v3 to v4
> > - change bus_addr_base to u64 to fix 32bit build error
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> >
> > Change from v2 to v3
> > - Add using_dtbus_info to control if use device tree bus ranges
> > information.
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 18 +++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
> >  2 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 43ba5c6738df1..42719ad263b11 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/align.h>
> >  #include <linux/bitfield.h>
> >  #include <linux/of.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >
> >  #include "pcie-designware.h"
> > @@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >
> >  	atu.func_no = func_no;
> >  	atu.type = PCIE_ATU_TYPE_MEM;
> > -	atu.cpu_addr = addr;
> > +	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
> >  	atu.pci_addr = pci_addr;
> >  	atu.size = size;
> >  	ret = dw_pcie_ep_outbound_atu(ep, &atu);
> > @@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct device *dev = pci->dev;
> >  	struct platform_device *pdev = to_platform_device(dev);
> >  	struct device_node *np = dev->of_node;
> > +	int index;
> >
> >  	INIT_LIST_HEAD(&ep->func_list);
> >
> > @@ -873,6 +875,20 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  		return -EINVAL;
> >
> >  	ep->phys_base = res->start;
> > +	ep->bus_addr_base = ep->phys_base;
> > +
> > +	if (pci->use_parent_dt_ranges) {
> > +		index = of_property_match_string(np, "reg-names", "addr_space");
> > +		if (index < 0)
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * Get the untranslated bus address from devicetree to use it
> > +		 * as the iATU CPU address in dw_pcie_ep_map_addr().
> > +		 */
> > +		of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
> > +	}
> > +
> >  	ep->addr_size = resource_size(res);
> >
> >  	if (ep->ops->pre_init)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 4f31d4259a0de..5c14ed2cb91ed 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -410,6 +410,7 @@ struct dw_pcie_ep {
> >  	struct list_head	func_list;
> >  	const struct dw_pcie_ep_ops *ops;
> >  	phys_addr_t		phys_base;
> > +	u64			bus_addr_base;
> >  	size_t			addr_size;
> >  	size_t			page_size;
> >  	u8			bar_to_atu[PCI_STD_NUM_BARS];
> >
> > --
> > 2.34.1
> >

