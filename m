Return-Path: <linux-pci+bounces-20166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67122A1740D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36891889E92
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF76B19A28D;
	Mon, 20 Jan 2025 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HoZP1ggv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8E190462;
	Mon, 20 Jan 2025 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737408043; cv=fail; b=Qrx3zvS4q+D5nfuqC89nZcDEjn01CR9Bsu0Ik9ZiGEpr8S5ovH0NDVl8oBa7GG9ZAEEluE6gn7wd3zI5EWVn3S29Y6oe6f2vyUXc6H2zJAa55WxzQiMOA5jF7++1ReIJgUL8VEA4m3ytL8TBb0sWjKtCBcy56HHdLFfldZ6tZ+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737408043; c=relaxed/simple;
	bh=bupf1NOAOd15GxL7Yb4aXI0XKfZalLN9H1TisVle6Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nXvTHOwdA1fR6FG6gESQ0Dtgs2m4hP+X5ZBAcrp4AUpkwumyOAI0QcjQmKmpGTNu7kjF0eSfdkvpUk7tcT+yk6BjwfBnponTDI1qQLta78DkNrAxecIE24UbNZB7/jYaaB+v9yqPaDwJEfIkJD/pBwGCbVlwE9eTjVOpySR2zyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HoZP1ggv; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgIjBRe0LysmtuCU2cS5erYQPeLqSYJpsr/1OgrDWkBSI3aJQLtJCdAccBX7dxWvY10Gfnj093T+REaU/TuR1E6Xg+qxWAMaBFZLyNQNfDhlxqkeypQk5t1lOwOsynmdbFzI+spnlUNrkPKvQ0NmCHcWHjAtcrjtFAHCagZfehy0DUiXmKmQrQUNc4LeOmGxDbw3PlAtRcoypdYDSQDGzUsyYNrLRu5UL6P+XBruu5+hS+/NGtpqwUC8eJwH2S6biXnAlmrBSWR1nwrkLSjgGAd1rQxM7SFaXUoAIumFD9cAulAScWLTz9rW+fK/n3WuPF8NrZ6DAln00q9Eu/2RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAssmxE3olzuhmGfiR1v0z7JE2fIlqr5C/1v379mQ7g=;
 b=nPvSoDveMvfouCMQQYktXjauxL1ITm236JnBZZ/btpuDJnI7ocXw9iyMegtoEiGQxXKcQ4UgmY9czFp4+i2B2BHbP0zQD0AuVi3Nha3iVH8lqtwECuFxXC9ynQOqy+j3IwvQiJ7aHMTQ8fyArunJPEoFfOn5Z7qQurP839+TZYD2hKvshT6nWseY9G7TMYJjbRuXQyyz/pZJM2bkbFLnluH4daBbw5jDX4ZHspHfhebLimzGPOZCUGSeXS8vOutjYrAbntOAczU4pivb8qDwIeZ5rYyetTeYJyVE1OVTko/FYBD2r+c/+xLUQljNebR7ENyfxfXlNP/HGHkTMV6tYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAssmxE3olzuhmGfiR1v0z7JE2fIlqr5C/1v379mQ7g=;
 b=HoZP1ggvg6YRXWAmLYDaRi6Uyk8RAoa+1QvhidgmGyDZj/tcQ58YoBbyWACudobM/02fNWJWYeUZYR0bK7xX5JBKJdR0L5l0rDt9A2pVsyGzJZi5idMxGVm0L5FD8V+4n40H1Z9BKVwY7s1ToNFMNnEGILy8oFwPhxXRUYJsXCMd+fVpGmqrRCqmHnlNof9SprT5HidPc36ZuiYtmXVUDyw0w9tWxox0TFIuKSe/w4H15mWyrxEtJkl5LhX7JOz2Qh6yXVJIiT6hi6cJvcJMpkhTSXEdt2+yWluxhDNRf+FrrusVJCYtVnu27A/gOfNbEj2a6yLohjy0vJsbehsJww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.18; Mon, 20 Jan
 2025 21:20:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 21:20:37 +0000
Date: Mon, 20 Jan 2025 16:20:28 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z46+HAvErtMPGy+4@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
 <Z3wG6pMbjsldqU/n@lizhi-Precision-Tower-5810>
 <861pxfq315.wl-maz@kernel.org>
 <Z3we4QuRo5ou+r2y@lizhi-Precision-Tower-5810>
 <Z4U7KoU1iVOlGTcw@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4U7KoU1iVOlGTcw@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR05CA0121.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d96c27-e4c8-4f89-57f6-08dd3998487f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dThPc3Zpbi9kaEw2aDJhdUlDY3JiajdzekUyb2w2L0VkaDZtZ1ZkRk1XcHZQ?=
 =?utf-8?B?U0VBOHFQZThIWG0vT2FDaUNjWDZoc0g2dkpjMGZWa1VLN25NdmxQSW53Mnds?=
 =?utf-8?B?aFMyNncvV3Z6aEgvNGJRUzJMKzl5aTQzQkNKazY4emFXR1J4TDJVaThzTU9N?=
 =?utf-8?B?cjg0Z3NyZHZsVDkycXNibXRlbldxL2trM3R0WmJIbmRFUWxhRmpCU2FZUEV5?=
 =?utf-8?B?cllmTnBKNW9NYTV0UDQxeUNjSmNtbXRpdmVXYUJKemoyTHR0Y3pYUGwyRVl6?=
 =?utf-8?B?V0NweVZTNXRpNTgrb2F4eVlVa0dlR0pKejR0ZTd1TWcvQzZHVmlsclpQVFpw?=
 =?utf-8?B?YjFOVGJZVUphLzg2S3AzemVoY0NhSDRpUVYyUzM2M1ExNW9KWWc4bnNZb3dr?=
 =?utf-8?B?R0JpOHVON3E4TlVNWVA1RzQ3TkZqZXZEREhBZzBPaGNwbGdSUDFSQkRSZ3Bn?=
 =?utf-8?B?OGUzUEVxcEFWQjdST2VnRSs0VU4xVW0wc0xvaW1OVGc5OWhRWkdMYTNzWTZK?=
 =?utf-8?B?NDdYMUZrOTF3R2w5a0hGNEpmSGozdU9laVgwN2RudGhCYm5LTjRHWjdqdkFk?=
 =?utf-8?B?K09qdk11c3dna3JhZVFQbmkwZHNXZ2FOL0t4NC8yK1FBVDVvVUNlalVDL1JT?=
 =?utf-8?B?RndxemJvZ3Fhcld1VVJFa2xDWHE5NkJjOUwrL3dyQ1ZVUlVoRFhWNEVkcjhL?=
 =?utf-8?B?Nkl6dFRaMmNoNTRtalkvdjB1M0d0YmVZT2l6YUdjSmlYUHZ4aitFcjJJTno3?=
 =?utf-8?B?NWU4YjRKVzhJdmpWSGxaTmZsRUVSRm1vTzZrSFJYQllNcE81UmZOSWk2N2E0?=
 =?utf-8?B?REhBQkp0V2xoYnd6ejl0UmxLMGx3MFp2LzVvR1I0SnlYS3pJVGR4Zy9FaWpr?=
 =?utf-8?B?YzZzRmZpVUhVQjBQc2pKdEVXc1hCQkhLT0JSTnpvc3JGaUE4bkNIOXFHMHFN?=
 =?utf-8?B?SkdhbXFVV054aDFIcVJ0c0dhZVBXdVE2eG1ZcmpyOGVrcnpORHpOK2pocFRj?=
 =?utf-8?B?UGxDWGoxSGxUd0NGdkFPOE8zcDk2RmxoVm9qbDBQT3NOWGxFR0FNWnFBdXBx?=
 =?utf-8?B?MC9jaUFqeS9LbmM0NFZGTEM3dmNMMW4xd2xxdlcvSDlTcGcwTTkyaytLZFVn?=
 =?utf-8?B?YmxSRVlXankvall1bFo5eDVOalNLN0xFdUhoclZTRkQyTHoweUZvY1ZFZFR2?=
 =?utf-8?B?dGRVdXhKYXltYWVpcXBNUG5BQzZaazZJZVJRaXArSFVMSXpLbm1wcXVkeW1E?=
 =?utf-8?B?TmlxZzlZYW1rWWVRTS9ieUVaaGF3WTNiNHFvUXkxUUxjeU1HZDE5YVFxRGU1?=
 =?utf-8?B?NGhDR0lzelVuWmc5ek5MUktCbDR0S3dvUjNpdGlKRHFhWFFSTnV3TW1Ed2Rw?=
 =?utf-8?B?Z1BQMU1NV05HNUg1cDN0MHhvbXVTUFJxRGNhRFI0VVViU1FNWHVxNUl6bFRY?=
 =?utf-8?B?eFYybkpHN0Q1Q0lEdWp1TE1sVFV5SkpNczVPVVE1RVF2QzEyMkVpM3VjM0lh?=
 =?utf-8?B?Y2krUGVDcFliUHhOYmZuV3czV3JmR2pnV0gzQWhtWFl6R1kyZDhmRUNIMjA3?=
 =?utf-8?B?Q2J5ajdqT0lnb2ZzcW90b00ya3hBNkNmUmxicjZaRlVhMS9EcFJ6akFieklw?=
 =?utf-8?B?bUxIS0M5R0Qwb2s4SVZKMzVKaDdjcExXQ05ZWEVhYUYxbGpVbDd3bWZYdUpx?=
 =?utf-8?B?NTBWVEgyWDY5c1RQVDJJMkxZcm1uUmlQakpLVWhiRzE0d2tMMTVOaGtOZENo?=
 =?utf-8?B?ZFlub1BOa1NSMEZMZlUweDNoTEoyTXpJb0F6bmR3bzhpUndWd2JqVzYyVS9a?=
 =?utf-8?B?ZGdiNEdYYWM1WDBpa3VXdG8zVzMyNU5IY0hYQ3F1MitOc280MGY2Mk1LTDEv?=
 =?utf-8?B?YTlzWFNOVzhKOStHZThCUkFySm0xbTZiWFJnWUpBUk1EOHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJWbk8rS3FFZU4zSlFqakRYUStEUVF2RHVCWFlITzV2Sm50UDlOdndQYjlP?=
 =?utf-8?B?d3JDdU5mMmtBZWpWREtGVGllNWRCZ1NXa1M0UXVKZFcyall0MkhlbUg0VWx0?=
 =?utf-8?B?enlxTzNCZ3dFUDh2M29hdmJEdXpPRCsxbWF2M1pqa2tINGs3TGE1TWlETVBH?=
 =?utf-8?B?VFpPdzlScW16ejU0TW5mandKZlhwWmMyZzM5elhpNEtpaTdqRnBHb1V5ck1m?=
 =?utf-8?B?ZlNBdWlFZlVPV0lESDZLSThqRWxlUmRIajF2V245WEp5ck11cFJyUE1pZWhE?=
 =?utf-8?B?MEE0anR1T2FwYkJJWFNncnlwVUc3L0xiQlZxd29PYUVVdlRMa0xHWUxocjly?=
 =?utf-8?B?R2VtKzhPRmpkVnFkaHZsMS85ODR2T3NxaHdCV1M1S0p6QlJJYVFKbHNLVzBF?=
 =?utf-8?B?SVVXR3R2VlpnQ212YnNpREpSdnJndXFFeUVuUHA0ZVJkS2o5TU9ORTM0NnBR?=
 =?utf-8?B?dlZTRkU0UFVJczZZQTBaMjRDekduN21VZWowVEk2NDNpM0MzdDVOOTdpQlAx?=
 =?utf-8?B?aVNBekpxcEdTdTBQYjAvQ1kxbFBSalNUNFFuTkRSaGFQakxtQ3N3Zkh0UDdh?=
 =?utf-8?B?cGFsaWNDVjNMN0dQMWIzaU5rREpCdjhrK1VQZ0thVVFOK2Y4YVdVMUF3emVR?=
 =?utf-8?B?Y050OThEdnp0R0hUYXpUU1I2aG95NmNxb2NVOG5wMXBEZ01hUVQ3UTdJY043?=
 =?utf-8?B?MjFHZ3d4Smo0MkEwVFU2bmhySy9rRCtPMWpWZS9icnVGWUlSTHd0QVFNdlpD?=
 =?utf-8?B?ZUpZY2ovWnBmV25iZXYxV3crbjVZZCtBbkNQOS9obnZSYmIwcVZ6bVp3Y0xF?=
 =?utf-8?B?aUYrU1pMTy84MitjTzVGRGdseERzQzk3cTZmRzJDNmVpUUJpYXNtQno4SWJs?=
 =?utf-8?B?c0laQ2puMkdBbE9XblBZYXlZcjdkdHV1SDh4ZVZyajFIeWpORFZYOVNqOGhr?=
 =?utf-8?B?NDRRLzNSMXhTYkx2TTZmbHNNc0w3cUV6L2lVUUpmVk5wUVBveW5POWhQRmZR?=
 =?utf-8?B?OVJ6bEthbW9LbmxCMEdtY2c1NnlPY2RwU1JyOVR3Q0V0U2NZWW1YVWVvQlBz?=
 =?utf-8?B?S0NWTTZ5Zk5CRFJMbWVZdXN1SE05UUlOZ1hTZmMzdEdPNndXcGlNZTlwUjRS?=
 =?utf-8?B?NDl3dG8xZzdmWENNMlRuUUlQSTNHUCszSE9ERGVHNE9RbmMwZ3pKY3dVWDZr?=
 =?utf-8?B?UStQK21GSkFvSVpab2dwajFDa1hWekp4eWlBNzlTZnZyd2FFdDJPSDZ3Rmps?=
 =?utf-8?B?ZHY5ZC9XZkxPRVoydG9TeGZ3UGJsOG92TlVBTVZnQkk5bUo0NGlHUkFzSXJn?=
 =?utf-8?B?b0I5ejkxcFdCbDRkejBaeUNzZjlCMk50QWptNHpCRkFHejFWS2NjVVp1TVUv?=
 =?utf-8?B?d2R4ZW9iczI3cHFJVGlhUkIvQ3dCOUVqeW9PbWx2NThQcDBOK0JiZTA0dmZM?=
 =?utf-8?B?WmRFMUgrTktyRGdPSUxQeVNYYkpKMzJYZ2xUb05HYTVFaURLYzBFcnQ0WkxX?=
 =?utf-8?B?TndhTk1JNDZsN3NKVHZRd2JkRkQyUHZlK0dNQlNHalRGMjJNUTZreG8vcG9w?=
 =?utf-8?B?K01XYldMVStrRXp1ZFhPSnZtcWw2bnErVUF1bjlQMko3MmpHMGFEbStwRE9u?=
 =?utf-8?B?b2N1cGs2RFpicW5yUDYrR0NyblU1b3kyUnNRR1dlZGxSMTB5aG5qSEtISURX?=
 =?utf-8?B?Nk9kUHRuOW9SK1FRcUM0ZHdjc284ZzNsODU2bDJTdTRYUFI1b3J2ZnZZczB1?=
 =?utf-8?B?Ym9pZGdSVXp5M1Z2MGk1T0liam9HOWU2aVZLbFRtK2xOM2swZmh3bVdFM1pH?=
 =?utf-8?B?YXd4YmRRVlViVXJjcXZlckk5T01ib1lGQmVpODBvemFOR0FMMkQrSGtucGk2?=
 =?utf-8?B?enhxZWVJWlJlTS80T01FcXA0anBlM1pLdDR5cVExaWNNTFZVRnZRQ21sZEtB?=
 =?utf-8?B?cmN1L0hjUnFXWUs3MVFlVzBPRUJNMFZvSFBZOGRBdTRXc2xtaitESEVEYm5D?=
 =?utf-8?B?KzE1ckZQS0tqWVZqU3Q0eHBnQzNsUjFvbUxzRlUzMkZpQ1NIQ0NWbXdGNUZN?=
 =?utf-8?B?TWZyMGhXcDlwcGRId08xeGV1cTlURDZVVEdMa2JPVTJqMHBRTmJHV1VlMGpi?=
 =?utf-8?Q?BpFM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d96c27-e4c8-4f89-57f6-08dd3998487f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:20:37.3428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlA1fbfZz79vg1l0K0DYO+YPLkxjZraM8hPdsxIoZj39XdBn9hGvCWBlf38Ktb9OvXGO/3fVhFW67fgQxG1nIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338

On Mon, Jan 13, 2025 at 11:11:22AM -0500, Frank Li wrote:
> On Mon, Jan 06, 2025 at 01:20:17PM -0500, Frank Li wrote:
> > On Mon, Jan 06, 2025 at 05:13:10PM +0000, Marc Zyngier wrote:
> > > On Mon, 06 Jan 2025 16:38:02 +0000,
> > > Frank Li <Frank.li@nxp.com> wrote:
> > > >
> > > > On Thu, Dec 19, 2024 at 12:02:02PM -0500, Frank Li wrote:
> > > > > On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> > > > > > On Wed, 18 Dec 2024 23:08:39 +0000,
> > > > > > Frank Li <Frank.Li@nxp.com> wrote:
> > > > > > >
> > > > > > >            ┌────────────────────────────────┐
> > > > > > >            │                                │
> > > > > > >            │     PCI Endpoint Controller    │
> > > > > > >            │                                │
> > > > > > >            │   ┌─────┐  ┌─────┐     ┌─────┐ │
> > > > > > > PCI Bus    │   │     │  │     │     │     │ │
> > > > > > > ─────────► │   │Func1│  │Func2│ ... │Func │ │
> > > > > > > Doorbell   │   │     │  │     │     │<n>  │ │
> > > > > > >            │   │     │  │     │     │     │ │
> > > > > > >            │   └──┬──┘  └──┬──┘     └──┬──┘ │
> > > > > > >            │      │        │           │    │
> > > > > > >            └──────┼────────┼───────────┼────┘
> > > > > > >                   │        │           │
> > > > > > >                   ▼        ▼           ▼
> > > > > > >                ┌────────────────────────┐
> > > > > > >                │    MSI Controller      │
> > > > > > >                └────────────────────────┘
> > > > > > >
> > > > > > > Add domain DOMAIN_BUS_DEVICE_PCI_EP_MSI to allocate MSI domain for Endpoint
> > > > > > > function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
> > > > > > > write MSI message to MSI controller to trigger doorbell IRQ for difference
> > > > > > > EP functions.
> > > > > > >
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > > change from v12 to v13
> > > > > > > - new patch
> > > > > >
> > > > > > This might be v13, but after all this time, I have no idea what you
> > > > > > are trying to do. You keep pasting this non-ASCII drawing in commit
> > > > > > messages, but I still have no idea what this PCI Bus Doorbell
> > > > > > represents.
> > > > >
> > > > > PCI Bus/Doorbell is two words. Basic over picture is a PCI EP devices (such
> > > > > as imx95), which run linux and PCI Endpoint framework. i.MX95 connect to
> > > > > PCI Host, such as PC (x86).
> > > > >
> > > > > i.MX95 can use standard PCI MSI framework to issue a irq to X86. but there
> > > > > are not reverse direction. X86 try write some MMIO register ( mapped PCI
> > > > > bar0). But i.MX95 don't know it have been modified. So currently solution
> > > > > is create a polling thread to check every 10ms.
> > > > >
> > > > > So this patches try resolve this problem at the platform, which have MSI
> > > > > controller such as ITS.
> > > > >
> > > > > after this patches, i.MX95 can create a PCI Bar1, which map to MSI
> > > > > controller register space,  when X86 write data to Bar1 (call as doorbell),
> > > > > a irq will be triggered at i.MX95.
> > > > >
> > > > > Doorbell in diagram means 'push doorbell' (write data to bar<n>).
> > > > >
> > > > > >
> > > > > > I appreciate the knowledge shortage is on my end, but it would
> > > > > > definitely help if someone would take the time to explain what this is
> > > > > > all about.
> > > > >
> > > > > I am not sure if diagram in corver letter can help this, or above
> > > > > descriptions is enough.
> > > > >
> > > > >
> > > > > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > > > > │            │   │                                   │   │                │
> > > > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > > > │            │   │                                   │   │                │
> > > > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > > > > │            │   │                                   │   │                │
> > > > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > > > > │ Controller │   │   update doorbell register address│   │                │
> > > > > │            │   │   for BAR                         │   │                │
> > > > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > > > │            │◄──┼───────────────────────────────────┼───┤                │
> > > > > │            │   │                                   │   │                │
> > > > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > > > │            │   │                                   │   │                │
> > > > > │            │   │                                   │   │                │
> > > > > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> > > > > (* some detail have been changed and don't affect understand overall
> > > > > picture)
> > > > >
> > > > > >
> > > > > > From what I gather, the ITS is actually on an end-point, and get
> > > > > > writes from the host, but that doesn't answer much.
> > > > >
> > > > > Yes, baisc it is correct. PCI RC -> PCIe Bus TLP -> PCI Endpoint Ctrl ->
> > > > > AXI transaction -> ITS MMIO map register -> CPU IRQ.
> > > > >
> > > > > The major problem how to distingiush from difference PCI Endpoint function
> > > > > driver. There are have many EP functions as much as 8, which quite similar
> > > > > standard PCI, one PCIe device can have 8 physical functions.
> > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 ++++++++++++++++++-
> > > > > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > > > index b2a4b67545b82..16e7d53f0b133 100644
> > > > > > > --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > > > +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > > > @@ -5,6 +5,7 @@
> > > > > > >  // Copyright (C) 2022 Intel
> > > > > > >
> > > > > > >  #include <linux/acpi_iort.h>
> > > > > > > +#include <linux/pci-ep-msi.h>
> > > > > > >  #include <linux/pci.h>
> > > > > > >
> > > > > > >  #include "irq-gic-common.h"
> > > > > > > @@ -173,6 +174,19 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> > > > > > >  	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
> > > > > > >  }
> > > > > > >
> > > > > > > +static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> > > > > > > +				  int nvec, msi_alloc_info_t *info)
> > > > > > > +{
> > > > > > > +	u32 dev_id;
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
> > > > > >
> > > > > > What this doesn't express is *how* are the writes conveyed to the ITS.
> > > > > > Specifically, the DevID is normally sampled as sideband information at
> > > > > > during the write transaction.
> > > > >
> > > > > Like PCI host, there msi-map in dts file, which descript how map PCI RID
> > > > > to DevID, such as
> > > > > 	msi-map = <0 $its 0x80 8>;
> > > > >
> > > > > This informtion should be descripted in DTS or ACPI ...
> > > > >
> > > > > >
> > > > > > Obviously, you can't do that over PCI. So there is a lot of
> > > > > > undisclosed assumption about how the ITS is integrated, and how it
> > > > > > samples the DevID.
> > > > >
> > > > > Yes, it should be platform PCI endpoint ctrl driver jobs.  Platform EP
> > > > > driver should implement this type of covert. Such as i.MX95, there are
> > > > > hardware call LUT in PCI ctrl,  which can convert PCI' request ID to DevID
> > > > > here.
> > > > >
> > > > > On going patch may help understand these
> > > > > https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> > > > >
> > > > > If use latest ITS MSI64 should be simple, only need descript it at DTS
> > > > > (I have not hardware to test this case yet).
> > > > > pci-ep {
> > > > > 	...
> > > > > 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> > > > > 			      ^, ctrl ID.
> > > > > 	msi-mask = <0xff>;
> > > > > 	...
> > > > > }
> >
> > Bookmark 1
> >
> > > > >
> > > > > >
> > > > > > My conclusion is that this is not as generic as it seems to be. It is
> > > > > > definitely tied to implementation-specific behaviours, none of which
> > > > > > are explained.
> > > > >
> > > > > Compared to standard PCI MSI, which also have implementation-specific
> > > > > behaviours, which convert PCI request ID to DevID Or stream ID.
> > > > > https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> > > > > (I have struggle this for almost one year for this implementation-specific
> > > > > part)
> > > > >
> > > > > Well defined and mature PCI standard, MSI still need two parts, common part
> > > > > and "implementation-specific" part.
> > > > >
> > > > > Common part of standard PCI is at several place, such its driver/msi
> > > > > libary/ kernel msi code ...
> > > > >
> > > > > "implementation-specific" part is in PCI host bridge driver, such as
> > > > > drivers/pci/controller/dwc/pcie-qcom.c
> > > > >
> > > > > This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
> > > > > who use another dwc controller, which they already implemented
> > > > > "implementation-specific" by only update dts to provide hardware
> > > > > information.(I guest he use ITS's MSI64)
> > > > >
> > > > > Because it is new patches, I have not added Niklas's test-by tag. There
> > > > > are not big functional change since Nikas test. The major change is make
> > > > > msi part better align current MSI framework according to Thomas's
> > > > > suggestion.
> > > >
> > > > Thomas Gleixner and Marc Zyngier:
> > > >
> > > > Happy new year! Do you have additioinal comments for this?
> > >
> > > I think this is pretty pointless.
> > >
> > > - DOMAIN_BUS_DEVICE_PCI_EP_MSI is just a reinvention of platform MSI,
> > >   and I don't see why we need to have *two* square wheels
> >
> > "DOMAIN_BUS_DEVICE_PCI_EP_MSI" was purposed by Thomas Gleixner.
> > https://lore.kernel.org/linux-pci/87o7197wbx.ffs@tglx/, the difference
> > is
> > - "platform MSI" only have one device id for each device. But
> > DOMAIN_BUS_DEVICE_PCI_EP_MSI have multi child devices, which need map to
> > difference devices id.
> >
> > If you like, I can try to extend "platform msi" to support msi-map. But
> > The other problem "immutable MSI messages" need be resolve also.
> >
> > PCIe EP require "immutable MSI messages". address/data pair can't be change
> > by set irq affinity.
> >
> > >
> > > - The whole thing relies on IMPDEF behaviours that are not described,
> > >   making it impossible to write a *host* driver that works
> > >   universally.
> >
> > Host side need NOT know EP's side IMPDEF behaviours. Host side just know
> > addr/data pair.  *(BAR<n> + offset) = DATA (in RC side) will trigger
> > doorbell.
> >
> > "AXI user bits" concern see below book mark axi.
> >
> > > Specifically, you completely ignored my comment about
> > >   *how* is the DevID sampled on the ITS side.
> >
> > See above "book mark 1", let me change another words, descript again,
> >
> > It is quite similar with PCI root complex case.
> >
> > In PCI RC's dts, it looks:
> >
> > pci {
> > 	...
> > 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> > 	                      ^, ctrl ID.
> > 	...
> > }
> >
> > ITS call pci_msi_domain_get_msi_rid() to get device id.
> >
> > static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> >                                int nvec, msi_alloc_info_t *info)
> > {
> > 	...
> >         info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
> > 	...
> > }
> >
> > PCI msi common code call __of_msi_map_id() to convert PCI rid to stream id
> > from dts file.  It should have similar method if device have not use DT.
> >
> > --- EP case (Run at EP side) ---
> >
> > for my patches, it do similar thing, in dts, PCI EP controller
> >
> > pci-ep {
> > 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> > 	msi-mask = <0xff>;
> > }
> >
> > static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> > 				  int nvec, msi_alloc_info_t *info)
> > {
> >
> > ....
> > 	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
> > ....
> > }
> >
> > PCIe EP common part will convert EP function device ID to difference device
> > id according to msi-map in pci-ep node.
> >
> > >  How is that supposed to
> > >   work when the DevID is carried as AXI user bits instead of data? How
> > >   can the host provide that information?
> >
> > book mark AXI:
> >
> > Host driver needn't such information. Host write PCI TLP, such as
> > *ADDR = DATA.
> >
> > PCI EP controller get such TLP, which convert to AXI write. PCI EP
> > controller will add AXI user bits, which was descripted in PCI EP
> > controller's dts file.
> >
> > pci-ep {
> >         msi-map = <0 &its, 0x<8_0000, 0xff>;
> > 			      ^ "8" is AXI user bits, which added when
> > convert TLP to axi write.
> >
> > }
> >
> > >
> > > - your "but it's been tested by..." argument doesn't carry much
> > >   weight, as the kernel has at least one critical bug per "Tested-by"
> > >   tag
> >
> > My means is this solution can cross difference platform with only dts
> > change.
> >
> > >
> > > Given that, I don't see how this series is fit for purpose.
> >
> > sorry for add book mark to refer to difference place in the the mail.
> >
> > let me know if need further description.
> >
>
> Marc Zyngier:
>
> 	Do you have any chance to read my reply? Does it anwser your
> question? anything missed or still unclear? How to move forward?

Marc:
	Do you have any chance to read my reply?

Frank

>
> Frank
>
> > Frank
> >
> > >
> > > Thanks,
> > >
> > > 	M.
> > >
> > > --
> > > Without deviation from the norm, progress is not possible.

