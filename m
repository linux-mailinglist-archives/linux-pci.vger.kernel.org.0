Return-Path: <linux-pci+bounces-19678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89409A0BD06
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E771886E41
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7552122BAC8;
	Mon, 13 Jan 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I29xEv5K"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0B22980C;
	Mon, 13 Jan 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736784696; cv=fail; b=uhoXbvpYQrveHY7FEg3WiVXscAQSIOyBfn6+3bh1jtKqhqWW4XnaOlcadY3tYxm2IU6R4dmn1bXHZTx6wt9YY7uPUXsKszWJVuc2DInmzmM4hfOpLcf0me5IA3gYSVnwDgaAFXUuwmXWpdzPGlLeiSRItqBA7o+Ijv9mdlt/mOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736784696; c=relaxed/simple;
	bh=Qib2iWOh0/SoakH63aW+SzWo5MzkJLdO4LaPouxBMKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fu3bL/qg4rOLlBOQTd1rZzhk04/9Rg9gaDcn92IF315sAq++Byo+tlxNNYL5AjoqtcBC6Kq3UC78StK7JVu6e7AEOnHW7b5nWt99u9DtvTCEqVpy3pJ9siI3IICLDvB8U8jiEjwFdmD8wZNo/3CABXIPL/UycTyuT7/ReJ8CXWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I29xEv5K; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frnuZicaQ5GRUn0l79QEK3Vasl02oFZJtMg0iA4uKWvNi10ox0lwZFvxL3qKjY98wT6FuwP53+CEnqUUMCuei/l89jei7lVtncDdVH7rFddmChe5exjs/g+UDcghADFjRDAEzw4NTf2eM3khkGjWsimCrBTG7hGvWJhd4YvrenjWwr6R/RBmELYiRPAQZCaMICJYt+0VcxOtt9Cpa4x3JM62PjzkVjxt9z0DX8MCbqxKu/RVS1+JlKSRAk4dofjzbr9cdv9x7MYVOSz1dF6dF9Sy1Iyj7V6tP6+poXbCbz3Hj0ruDnB0mSW65+MMm0UXrLKJbD49GIswAgXPQRw4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9Kv2Wgcei/8EgnduNC8YCc/HfGEzOUsT7hsUBUo/Yc=;
 b=XLwaMUO7uRKM15ibUKkzwuXlp2FmYBXNHcl8F0ABROmCJwBYD/twD3wiO4VJuru+g+b7eYWb0UILD0NTg7a6+HnjhAdQaE6Xewn1zjG1VHarwVeARHR5fIDk0jKEafglP9JqYUrcplBCC1O9/6A8/Fu+mM/1pLlZG0nHodM4+IdkN/GXuuDTIHYkCdDroJdHQYzJxFl2mvcVbLWhqbSRPG6aLXxivwQ9MVihLEveyV2pQTatt9FLhMAp00woszmcid7Bm+oDDlD8tgR+1rsVKbxvOHH9kxq1kIFM3ixSV8S9IV5ixy1idrk4s9gR3m4BxmI4ROPnOHuVp3VPg6pWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9Kv2Wgcei/8EgnduNC8YCc/HfGEzOUsT7hsUBUo/Yc=;
 b=I29xEv5KtFDWAZQWOqYvsFAbNLJpw8DZVT+A09GZFWeLW8BRRsJb2fXKCoNWe44RTLeiCVDOxA3rPJk3LhapCCCfEu1rmLsZFh65VFRlhrlW4l9NoasnbjgJ2FTw1hjqDnCAEuk0VXgLzX4l91OZk0q8Gixb3zszRP4ZlK20+deQ3T26PFfxRrEb5eUzouRtY38z3HQFzCZ804o2aYRwuryRgcNwPkpPCNMYWhYJSbEJ7jxIzeyI6n2BWswA+T/NFTL445yWl/Cy6MOlicPG5FaCC70vAgOwd/WzaAaDLzOBNH4hv/HBu5oYVPYdcLgQzOyr4jYK+3PoaAWO/CEZCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7573.eurprd04.prod.outlook.com (2603:10a6:20b:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 16:11:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 16:11:31 +0000
Date: Mon, 13 Jan 2025 11:11:22 -0500
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
Message-ID: <Z4U7KoU1iVOlGTcw@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
 <Z3wG6pMbjsldqU/n@lizhi-Precision-Tower-5810>
 <861pxfq315.wl-maz@kernel.org>
 <Z3we4QuRo5ou+r2y@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3we4QuRo5ou+r2y@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c794e6-94b0-4f02-ca34-08dd33ecf122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTFiN1hvdGM5UFh3MGlOd2ZjL0s3MnFMbnlzQ2EvMzBMbWh1cG54ME4xVjlY?=
 =?utf-8?B?cFdUZ1ZJRllqN050ZERnMmlTLzdwcnY0S1hsS01makRaL2ZFeW15eFl6ZmRP?=
 =?utf-8?B?K2c3enNwV3Rjbm9jYjZvRFdNRkw4Q0N6YjNrcGRScFFDNzZRTXAvakhmUWRC?=
 =?utf-8?B?alIrYU4xZysxTk40MDlaZDE1Z3lDeXdsSHpnQUMrc3QrdWdOQUNWOEc4MXdl?=
 =?utf-8?B?b1lzbWhXTUhJVWJwMDBxVjlmYkFUOGZHY2M4U1VwdkF3dlhjMjk2alB1dFJt?=
 =?utf-8?B?VllHeWdYK1pPOTRFUTV0VngyQmN3VllWMGlxdTMvTDBrcDZUdnBDTnJIeG5Y?=
 =?utf-8?B?cnBLcWRFblBKZlVFWStYZ3h5aytCMzVsNWJMWXc3aGp0Q09Ba0h2d3duUnNQ?=
 =?utf-8?B?L2xyR3JwaXVMYWZhNFJGRE9yL0twVXV6Q3BKVkRwM0lxWk91dXJlZ2tiTFVq?=
 =?utf-8?B?YURYRE55ekpMaEJTcXJ6dUhmNytlN0F5V0x0ckRRTVZRbFRKU200endXME15?=
 =?utf-8?B?b0E2Q2t0V3BoTTRWZWNJNEwyOWZ2WitUclMvMmlQWWRuYWViejgrQSt4ZVJB?=
 =?utf-8?B?Vko0ZGxheEhtVGlRT1BVUy80Z2RTVzRZVDVEamVBR3ZHSXR2N2UwT1BDTFA4?=
 =?utf-8?B?MWJNK05aR2lkMUQ1WDFXRncrM3BaVVlpTkZuUkpCYjhEWEJUOGtNSHNFanpk?=
 =?utf-8?B?TzVqSWx0UHJiOFlyKzlkRmhqUXJua0JNb2JxMTdmNWRvZ25qdXRBQnd1WkY1?=
 =?utf-8?B?SFk5ckxaWUlyV2J5Rk5QYXc0RnlMT0pheG43RzNMK2M4dTQ4RGo4UUpSMXRj?=
 =?utf-8?B?Y3p1WHBnQXR5WU5EOHFzVUd0NUFzWVAwL2ZORmFLUmpPdXdiQy9EOXlGb0JD?=
 =?utf-8?B?M2Zmd3VvbEw2SFhkbVllVU1uTGlQR2tmaTIvcG90Y0gzb3NaSlQvS0oxMDhK?=
 =?utf-8?B?SXdJbkNsS1RqMi81Yi8ycmIzdjM0K0dPdnJ0bStZRTNnZWtVZVpzUlVlSTdM?=
 =?utf-8?B?NkdLQkJrUlB5MEQ1WlBwM0FUelJlZ21sMWhoTmlnTi9WQlE0NVgvdmhnbUlq?=
 =?utf-8?B?RzFhMUNVd2FsQXRFOWhiK0Qrc0ZJOHpJN1JWbXhMblBnRldZSjNrOHBHVUk0?=
 =?utf-8?B?SHJIM0RGaFZSZHhVNm5xYmQ0dTByOGptUnFTWWZGU3pOUzlmNWRSUFNTL3E2?=
 =?utf-8?B?YWk2aDBjUEtUZmxwcjZsN3hhUTZMVDNMWlczQVExbFlFYW1FQWF6SFltNE85?=
 =?utf-8?B?NWRaYzdWRGR5Tmg3R2t6RExVK2o0OUR2QnF4NmJad1FxL3VLYVRWVU96NWRu?=
 =?utf-8?B?cGxsbFd2VU13dWFleXdTRkFFeHdtaDNlUkVPMWNFWDRCWXRZMk9Jbnl0R3lr?=
 =?utf-8?B?aWR6VGQvM1ZMcjd4cFd0WkFIUjdJM3cvdXFpK2trV2xOLzcyMElvZjBHcG1s?=
 =?utf-8?B?d2cvRVdzNmVLMUc0ekppSzFFNTJVeDVPd2NFMUIxM3VqYXhLLy9ITWVQck90?=
 =?utf-8?B?UmFuby9idll3Wm5mWHhHWnkvT1VLMGJlTUwvMkZEMy8rL3B2OTBxdldzWnJK?=
 =?utf-8?B?WVNSdUFOak5YMlNoU0pCQ2RTYStXd2s4NUU4ekRKWDNFSjh0RUpGRzMxL3ZB?=
 =?utf-8?B?bW02QjY2ZUJHdjViY3BkRXdBSTBtQVQvTlNNdGVYYndJYTYyM0Y0Um4zRWpI?=
 =?utf-8?B?dGh1V2N5VXMyM1FIMS9YaDg1TkxGN3NaU0VMc3h2VERPVWdzWER3RlNPeTYr?=
 =?utf-8?B?bU5pQVRSb3RFdW94M25GSXN1YWVkM2Y4c2U2RFBLc1hHSUl5TGNmUnVySlFQ?=
 =?utf-8?B?WWI3WDRJaXJzNnNIU2N3MHNsaXJIZWpqSlRkUm5QWjd0WnJ2WWFTUTVzQzZJ?=
 =?utf-8?B?ME1jcmV2WmJSZ0xJZ1lkWFh5YUkrR0ZwQ2Zwc3BiL3krZDc2dUhIS3Z4SWwy?=
 =?utf-8?B?Kzg2QVR5SDQra0dTTk9VN0RjQ0N6NXJ1RnpFQldYc1hTbWJ0TlZRNTlOcU9K?=
 =?utf-8?B?VndPMG5WVkxRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUZzUjhDSFBoWTRpcFRaRnVESVR2ZXFEOHF6U3NEUUNQKzUvWDI1MnNaMUt6?=
 =?utf-8?B?Yjl2TCtPcFVpUm40K2kzWStkQ2pKb0RSTXowVzAvLzJKWGdUN2t2anhSSWEv?=
 =?utf-8?B?Zmo2dzJPMGJZVkVhQmFnVEZjWHUwMlRZNDZ0RWE2RHhvVkt4M0RxbDl0aUMy?=
 =?utf-8?B?d2QvbktkTU1OOWlLSEZPVm94bEhqOVlHSXk0Z1U0MWZGY1BGR2J3ZjVOd3Q1?=
 =?utf-8?B?NmdMdXlpVnhETzZHV2huOXRHRFRTNjNxcVU0NjVPazFVZ3ZvcmhhREs1eFQ5?=
 =?utf-8?B?by8wL2ZVSnZaWWRLeUZJWXhWNEUwNXQ3VCs4UHRUVy8xZ1lHeTFZRjZWMzc5?=
 =?utf-8?B?SW9lNlZQbUkwOXhsYysyMWJvb0tQbkUxdnRacnc0bm1WUnI3RWxmTjAzL0NC?=
 =?utf-8?B?UGVLT2JLVktiMlh6RXlrQ2tDWU11MkdFaGVCTzVOYTMrUk14dVVDMnlMWVU0?=
 =?utf-8?B?TlhCSmNjMjRyUEY5ODl6WkVTaWxWUUVLcGR5bzJTVWMzNVRHVGxYRXFhVEVN?=
 =?utf-8?B?UndMMkoxOHRCeGJ1eldpNmE4SVRhcTRDM3NONWNsdm5ZcFBXMkh4UU9WTmhr?=
 =?utf-8?B?eUt0Qk02QTF0c3laWHlvS3E4bUs0MDRUUGFKWmhOMWNVRXhKN3lRMjFleVMr?=
 =?utf-8?B?bUptUytGSm9CL0pmZHZEdHUvVWlEZGZEUFpaeExoQkxHSE9aZ0ZyS2tURVR4?=
 =?utf-8?B?RjE4WEdUcDB3bHQwdU5mclFJL3JnOS9xcHM2bWZqcjk2ZWxLVFdZVHBhczFG?=
 =?utf-8?B?Mnk3YWhMQlc4WXpFVlIvUGM0eGE5WGFLaDU4L0ROdDBiWkpYSTR1dmtveHBF?=
 =?utf-8?B?L1FJK3Q0ZUw3MHl4ZzFhV09IVGRFRVRwM2Z1SlZxdVZ1Tk1hMjEvcTF6Q0da?=
 =?utf-8?B?SzlXMDNzSTVTcURuN2tkMGVjOWM5NXYxS2J5MlJQbWpNNlJiOWMrRE1CSXJv?=
 =?utf-8?B?SENhY2EwMHNaeUhFbGY0R3ZmRjFPOXg2RVNXbW5aMDk0b0xQaG05U3hSRHp3?=
 =?utf-8?B?OUFYb3pZTFVWU3d6VGNmRUNLVEJYMTNOUGx4czJSSnpLUCthM0JTcGdIYllq?=
 =?utf-8?B?Smx0Qml2emtZTXJZOUQ1cmRtWjQwdEpwUmlTeTRxWXREUktYRmc3QldZekoy?=
 =?utf-8?B?bENEakVOMEMxMm4xVHh0UXRkQ21lcHI4dzJSUkdNYW1rMTFVa09OK05mTWtj?=
 =?utf-8?B?R3JqMTh3VTdPSmk1NXRJajRRQmVtLzVrUDdQaVArZk1hSHlBS2RLc3pJTEpG?=
 =?utf-8?B?SXlsUmkxTFhyeVYzRkZOVzh2TU15angvSG43dEJlZjFjRjBzaENLVTFJYjc4?=
 =?utf-8?B?RHRJTnp0NmQ0SEp4QU02YkVvaHpoQmNRRlpBYTVxbWNRVEo2WGY2V1NtYzdT?=
 =?utf-8?B?WWxKVVJMREhaNStXU1AvNUpmWFROT2JrZEpZRWI4VExtbC8vN1JDanhSNzZR?=
 =?utf-8?B?ZXRmOThsTkFtT2diY3dJYUxLVE5XV0dTdXRjTHhLSkw5dFdVczc1NHA4RzJZ?=
 =?utf-8?B?OHV1aDBPQU5vNFRaL0NtOU90QmFSSGdseXBOQzlsRlkxNThncGtQU1dNKzRM?=
 =?utf-8?B?b1VuOEYxTTcvNzFQUkdtQVJlUU1MUnpFMDlSYnZteVdTaVlkSm9FUXBtSDlF?=
 =?utf-8?B?Rnp5SFhrQUhIY2l3UlN3V0lSL0tBOEQ1bnI4dVgvdDVvUU9HaTk2YlhBMWxW?=
 =?utf-8?B?ck5xMlRkUXUzNkt6ZmJ2UFc0cnBBVWRsd2dUdjRYMCtwWjV6NkFCeWFscHJk?=
 =?utf-8?B?Z1ZhQ0xpQXFSMkFxcWVTenVJc1NFbnFSNnpBRkt0SHZ3WHNwRHZTbVU4dkhX?=
 =?utf-8?B?ODd6T05MaXlLd3p5RHNMTmwwZ0lqdnVoMnV4cjRpUVRjQUh4WXArdnVNaEFp?=
 =?utf-8?B?OW4yRlVheWdYOEs5NTVDOUhRalpENmRvQWdxbFBsMkYwNFlGWDFSeW9HWHlH?=
 =?utf-8?B?OEtnYkhiam5oSTdLaW44bHVmOTFVNXA2aHNCd3NRL0JQTTcyV0FYZzZsUzY5?=
 =?utf-8?B?Ump3K2lwUmlKQVl2VURscjJNQ1cvM3BPYjg4MlNWQU1yYzRiYk9VR2JEOWNw?=
 =?utf-8?B?VWdGOWdvZDAyRmFQRTJ0cnpuWWZ6eXdHejJVUmc4VXJpOXEwVnFwajdjdGtx?=
 =?utf-8?Q?CYLI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c794e6-94b0-4f02-ca34-08dd33ecf122
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 16:11:31.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKHPu7v1KZfPPbPXO152UJ8kBydEeTf9+9a7XX3xfN5YGslUc/cMQ/wxHZr5qwln3ZFH6gYSqvq6QT47PLrYmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573

On Mon, Jan 06, 2025 at 01:20:17PM -0500, Frank Li wrote:
> On Mon, Jan 06, 2025 at 05:13:10PM +0000, Marc Zyngier wrote:
> > On Mon, 06 Jan 2025 16:38:02 +0000,
> > Frank Li <Frank.li@nxp.com> wrote:
> > >
> > > On Thu, Dec 19, 2024 at 12:02:02PM -0500, Frank Li wrote:
> > > > On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> > > > > On Wed, 18 Dec 2024 23:08:39 +0000,
> > > > > Frank Li <Frank.Li@nxp.com> wrote:
> > > > > >
> > > > > >            ┌────────────────────────────────┐
> > > > > >            │                                │
> > > > > >            │     PCI Endpoint Controller    │
> > > > > >            │                                │
> > > > > >            │   ┌─────┐  ┌─────┐     ┌─────┐ │
> > > > > > PCI Bus    │   │     │  │     │     │     │ │
> > > > > > ─────────► │   │Func1│  │Func2│ ... │Func │ │
> > > > > > Doorbell   │   │     │  │     │     │<n>  │ │
> > > > > >            │   │     │  │     │     │     │ │
> > > > > >            │   └──┬──┘  └──┬──┘     └──┬──┘ │
> > > > > >            │      │        │           │    │
> > > > > >            └──────┼────────┼───────────┼────┘
> > > > > >                   │        │           │
> > > > > >                   ▼        ▼           ▼
> > > > > >                ┌────────────────────────┐
> > > > > >                │    MSI Controller      │
> > > > > >                └────────────────────────┘
> > > > > >
> > > > > > Add domain DOMAIN_BUS_DEVICE_PCI_EP_MSI to allocate MSI domain for Endpoint
> > > > > > function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
> > > > > > write MSI message to MSI controller to trigger doorbell IRQ for difference
> > > > > > EP functions.
> > > > > >
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > > change from v12 to v13
> > > > > > - new patch
> > > > >
> > > > > This might be v13, but after all this time, I have no idea what you
> > > > > are trying to do. You keep pasting this non-ASCII drawing in commit
> > > > > messages, but I still have no idea what this PCI Bus Doorbell
> > > > > represents.
> > > >
> > > > PCI Bus/Doorbell is two words. Basic over picture is a PCI EP devices (such
> > > > as imx95), which run linux and PCI Endpoint framework. i.MX95 connect to
> > > > PCI Host, such as PC (x86).
> > > >
> > > > i.MX95 can use standard PCI MSI framework to issue a irq to X86. but there
> > > > are not reverse direction. X86 try write some MMIO register ( mapped PCI
> > > > bar0). But i.MX95 don't know it have been modified. So currently solution
> > > > is create a polling thread to check every 10ms.
> > > >
> > > > So this patches try resolve this problem at the platform, which have MSI
> > > > controller such as ITS.
> > > >
> > > > after this patches, i.MX95 can create a PCI Bar1, which map to MSI
> > > > controller register space,  when X86 write data to Bar1 (call as doorbell),
> > > > a irq will be triggered at i.MX95.
> > > >
> > > > Doorbell in diagram means 'push doorbell' (write data to bar<n>).
> > > >
> > > > >
> > > > > I appreciate the knowledge shortage is on my end, but it would
> > > > > definitely help if someone would take the time to explain what this is
> > > > > all about.
> > > >
> > > > I am not sure if diagram in corver letter can help this, or above
> > > > descriptions is enough.
> > > >
> > > >
> > > > ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> > > > │            │   │                                   │   │                │
> > > > │            │   │ PCI Endpoint                      │   │ PCI Host       │
> > > > │            │   │                                   │   │                │
> > > > │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> > > > │            │   │                                   │   │                │
> > > > │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> > > > │ Controller │   │   update doorbell register address│   │                │
> > > > │            │   │   for BAR                         │   │                │
> > > > │            │   │                                   │   │ 3. Write BAR<n>│
> > > > │            │◄──┼───────────────────────────────────┼───┤                │
> > > > │            │   │                                   │   │                │
> > > > │            ├──►│ 4.Irq Handle                      │   │                │
> > > > │            │   │                                   │   │                │
> > > > │            │   │                                   │   │                │
> > > > └────────────┘   └───────────────────────────────────┘   └────────────────┘
> > > > (* some detail have been changed and don't affect understand overall
> > > > picture)
> > > >
> > > > >
> > > > > From what I gather, the ITS is actually on an end-point, and get
> > > > > writes from the host, but that doesn't answer much.
> > > >
> > > > Yes, baisc it is correct. PCI RC -> PCIe Bus TLP -> PCI Endpoint Ctrl ->
> > > > AXI transaction -> ITS MMIO map register -> CPU IRQ.
> > > >
> > > > The major problem how to distingiush from difference PCI Endpoint function
> > > > driver. There are have many EP functions as much as 8, which quite similar
> > > > standard PCI, one PCIe device can have 8 physical functions.
> > > >
> > > > >
> > > > > > ---
> > > > > >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 ++++++++++++++++++-
> > > > > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > > index b2a4b67545b82..16e7d53f0b133 100644
> > > > > > --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > > +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > > > > @@ -5,6 +5,7 @@
> > > > > >  // Copyright (C) 2022 Intel
> > > > > >
> > > > > >  #include <linux/acpi_iort.h>
> > > > > > +#include <linux/pci-ep-msi.h>
> > > > > >  #include <linux/pci.h>
> > > > > >
> > > > > >  #include "irq-gic-common.h"
> > > > > > @@ -173,6 +174,19 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> > > > > >  	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
> > > > > >  }
> > > > > >
> > > > > > +static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> > > > > > +				  int nvec, msi_alloc_info_t *info)
> > > > > > +{
> > > > > > +	u32 dev_id;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
> > > > >
> > > > > What this doesn't express is *how* are the writes conveyed to the ITS.
> > > > > Specifically, the DevID is normally sampled as sideband information at
> > > > > during the write transaction.
> > > >
> > > > Like PCI host, there msi-map in dts file, which descript how map PCI RID
> > > > to DevID, such as
> > > > 	msi-map = <0 $its 0x80 8>;
> > > >
> > > > This informtion should be descripted in DTS or ACPI ...
> > > >
> > > > >
> > > > > Obviously, you can't do that over PCI. So there is a lot of
> > > > > undisclosed assumption about how the ITS is integrated, and how it
> > > > > samples the DevID.
> > > >
> > > > Yes, it should be platform PCI endpoint ctrl driver jobs.  Platform EP
> > > > driver should implement this type of covert. Such as i.MX95, there are
> > > > hardware call LUT in PCI ctrl,  which can convert PCI' request ID to DevID
> > > > here.
> > > >
> > > > On going patch may help understand these
> > > > https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> > > >
> > > > If use latest ITS MSI64 should be simple, only need descript it at DTS
> > > > (I have not hardware to test this case yet).
> > > > pci-ep {
> > > > 	...
> > > > 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> > > > 			      ^, ctrl ID.
> > > > 	msi-mask = <0xff>;
> > > > 	...
> > > > }
>
> Bookmark 1
>
> > > >
> > > > >
> > > > > My conclusion is that this is not as generic as it seems to be. It is
> > > > > definitely tied to implementation-specific behaviours, none of which
> > > > > are explained.
> > > >
> > > > Compared to standard PCI MSI, which also have implementation-specific
> > > > behaviours, which convert PCI request ID to DevID Or stream ID.
> > > > https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> > > > (I have struggle this for almost one year for this implementation-specific
> > > > part)
> > > >
> > > > Well defined and mature PCI standard, MSI still need two parts, common part
> > > > and "implementation-specific" part.
> > > >
> > > > Common part of standard PCI is at several place, such its driver/msi
> > > > libary/ kernel msi code ...
> > > >
> > > > "implementation-specific" part is in PCI host bridge driver, such as
> > > > drivers/pci/controller/dwc/pcie-qcom.c
> > > >
> > > > This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
> > > > who use another dwc controller, which they already implemented
> > > > "implementation-specific" by only update dts to provide hardware
> > > > information.(I guest he use ITS's MSI64)
> > > >
> > > > Because it is new patches, I have not added Niklas's test-by tag. There
> > > > are not big functional change since Nikas test. The major change is make
> > > > msi part better align current MSI framework according to Thomas's
> > > > suggestion.
> > >
> > > Thomas Gleixner and Marc Zyngier:
> > >
> > > Happy new year! Do you have additioinal comments for this?
> >
> > I think this is pretty pointless.
> >
> > - DOMAIN_BUS_DEVICE_PCI_EP_MSI is just a reinvention of platform MSI,
> >   and I don't see why we need to have *two* square wheels
>
> "DOMAIN_BUS_DEVICE_PCI_EP_MSI" was purposed by Thomas Gleixner.
> https://lore.kernel.org/linux-pci/87o7197wbx.ffs@tglx/, the difference
> is
> - "platform MSI" only have one device id for each device. But
> DOMAIN_BUS_DEVICE_PCI_EP_MSI have multi child devices, which need map to
> difference devices id.
>
> If you like, I can try to extend "platform msi" to support msi-map. But
> The other problem "immutable MSI messages" need be resolve also.
>
> PCIe EP require "immutable MSI messages". address/data pair can't be change
> by set irq affinity.
>
> >
> > - The whole thing relies on IMPDEF behaviours that are not described,
> >   making it impossible to write a *host* driver that works
> >   universally.
>
> Host side need NOT know EP's side IMPDEF behaviours. Host side just know
> addr/data pair.  *(BAR<n> + offset) = DATA (in RC side) will trigger
> doorbell.
>
> "AXI user bits" concern see below book mark axi.
>
> > Specifically, you completely ignored my comment about
> >   *how* is the DevID sampled on the ITS side.
>
> See above "book mark 1", let me change another words, descript again,
>
> It is quite similar with PCI root complex case.
>
> In PCI RC's dts, it looks:
>
> pci {
> 	...
> 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> 	                      ^, ctrl ID.
> 	...
> }
>
> ITS call pci_msi_domain_get_msi_rid() to get device id.
>
> static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>                                int nvec, msi_alloc_info_t *info)
> {
> 	...
>         info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
> 	...
> }
>
> PCI msi common code call __of_msi_map_id() to convert PCI rid to stream id
> from dts file.  It should have similar method if device have not use DT.
>
> --- EP case (Run at EP side) ---
>
> for my patches, it do similar thing, in dts, PCI EP controller
>
> pci-ep {
> 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> 	msi-mask = <0xff>;
> }
>
> static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> 				  int nvec, msi_alloc_info_t *info)
> {
>
> ....
> 	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
> ....
> }
>
> PCIe EP common part will convert EP function device ID to difference device
> id according to msi-map in pci-ep node.
>
> >  How is that supposed to
> >   work when the DevID is carried as AXI user bits instead of data? How
> >   can the host provide that information?
>
> book mark AXI:
>
> Host driver needn't such information. Host write PCI TLP, such as
> *ADDR = DATA.
>
> PCI EP controller get such TLP, which convert to AXI write. PCI EP
> controller will add AXI user bits, which was descripted in PCI EP
> controller's dts file.
>
> pci-ep {
>         msi-map = <0 &its, 0x<8_0000, 0xff>;
> 			      ^ "8" is AXI user bits, which added when
> convert TLP to axi write.
>
> }
>
> >
> > - your "but it's been tested by..." argument doesn't carry much
> >   weight, as the kernel has at least one critical bug per "Tested-by"
> >   tag
>
> My means is this solution can cross difference platform with only dts
> change.
>
> >
> > Given that, I don't see how this series is fit for purpose.
>
> sorry for add book mark to refer to difference place in the the mail.
>
> let me know if need further description.
>

Marc Zyngier:

	Do you have any chance to read my reply? Does it anwser your
question? anything missed or still unclear? How to move forward?

Frank

> Frank
>
> >
> > Thanks,
> >
> > 	M.
> >
> > --
> > Without deviation from the norm, progress is not possible.

