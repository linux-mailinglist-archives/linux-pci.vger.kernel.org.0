Return-Path: <linux-pci+bounces-35493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA018B44B97
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 04:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337CC1C81F99
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 02:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C041FF1C7;
	Fri,  5 Sep 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9VeXd1m"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EB14E2F2
	for <linux-pci@vger.kernel.org>; Fri,  5 Sep 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757039032; cv=fail; b=ERY6CJlc6fkfL0qb5GeoIpjhq23DcAhKhctVBRqI+1XSOyaPpJUTvCZjTWRj4jOJV2V2Xoz0ZOS9fRCTLrFjbySxRc54IBXNU/VAZL3rrtzJUQy7Q1smnB7UHJGYfVc8lQLaWL4/GLTilg6ZFLOP5Mrsor822ncWvBvG53wMSwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757039032; c=relaxed/simple;
	bh=YS4xOuTDA3HSr7U0vbcuQLq00vjWIjNPrp6jJT0Vtfc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7HgtoABDXvUALb4G3hUB1fvhRUfjXY7WjmGtUlixSVlVXpgBuOs6+4/gTsmZp/XLm33aUnTbWAA6LAoW0q8mup6AdqazVju/IDIoz4c9ebWA/opWAZLbc2byMD2HNr9m8oRz2ctAyH9JtUht5JuOQUpXtlCXdnSPhSOenEv9Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v9VeXd1m; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoNoYvqJI1YYavTf9vQSe5N91LHWJLXrIGp4uTASsWJp49tJ13SuUvArX/XyaBtB7gwKlYZc0NbRWRK7W+Sgi8sn0jH5U91N3QkEexB4GpFOlgXEj0yoUOR4G/oFnQ2V05g9gwwKCE5VXEdaGOw4+2PKXh2C2o+kCEBs2KPSDhcsK48EB1kaqTHKgGPy/PlIZt7isZbZEffuv+yt10H7sD4wKa1F4VPqllZ3utW7o/Rp2FvMCjzVNpnWsESVbosOewu+k3C/tmtAcchePvwIumW1ywwIFeQqW28qwHMLX7cfTKjLHFkp9GZbjAstm1EDSmXnr1t4qSA6R7NLkIS5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2Q2ZtBJ04Iw9B+ShToUlCiYC/k2mE23HBSRiwaSBIo=;
 b=iX0hRDyPK4wCRGCpKHj3WIhNPh6ze4EJIX8/lOA16beqimpfXgDRiztJxaV64zKwcheWGKpzzJjQw1LUdmh++oziQyZ+YWF7xRZhULugjOqO07rdpWOAapksU23EI8suSIwFRq5ILo25loZ95KDN0Q55TgL7KctsSlUIRnWr9xnpX2O6O44oVgtM2iuB+03AOwgWtblKXzPEfkL9nQzqcK+1xy3KrIThTq+AKcUL4X+OfSxkl9Qj9HpVnecv7Q5gdrbUI9cl7wkPVceX2dx5MPO1RID+RPUAC06wR75+6DOobuzFTLdVr6NCbLTE1otSdH085ahKWEOMyyEuoONMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2Q2ZtBJ04Iw9B+ShToUlCiYC/k2mE23HBSRiwaSBIo=;
 b=v9VeXd1m7kQR2qK7QuYo6X17Wf2XXLjiMsO7kqY+4rP6qXiT4yBUm6q8gg/5MaalVTHNLzhtk4oEhkwigUhpG61dAB6LEYIHVNpxLkssFkXyCSz1J4x8QSJEXH9dsgSNq7IFavmjsmocR5RW9q4cs4N7HSAWx7AOUGJV9us1J3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 02:23:45 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 02:23:45 +0000
Message-ID: <1acbb38b-4fdb-4c9e-bd76-e108367fcd79@amd.com>
Date: Fri, 5 Sep 2025 12:23:39 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68ba3c9f508ed_75e3100ef@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0073.ausprd01.prod.outlook.com
 (2603:10c6:10:110::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6677f6-9ab9-48a6-2119-08ddec233d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVJEV0JCdjBudzFOVFplTjhoQmdPT2pjNEtUUXA4SVltYTU1UThOYWNueGNF?=
 =?utf-8?B?OUxCa1dwSTRBQVdsNmJuRGgveEdFVkVKcjlYM3kycG5XL2twYXZIa090ZGdI?=
 =?utf-8?B?bkttTnBsdEhyWTk4dGhuYis0aks5UGdFVG9WczNlbTZDTDR0M3F3MzY3Y0pP?=
 =?utf-8?B?N0J0bmJETUtPdS9FZXNnWC9xZjZjTTIybG44RkNDdFNWZ0RCUXFlOHFPb1g3?=
 =?utf-8?B?Ny9yaUtnOGlyNVFlQ2dZcUNYZURQWmE0bml6aUs1ZjRRaE5WSUtrTGRYeUtX?=
 =?utf-8?B?bTBEQkVuN01KNFFzSklucHZ0N2FYTFhYaWtsbnZkOGxOT0VDZjNhQ014RXUy?=
 =?utf-8?B?TWQ2bW8rVDRBWU5Sd0QvTjZ0NG84dm5OUGJ6cGpuV2thSDhwQmloRHBDNWZQ?=
 =?utf-8?B?L3ptV1hsVWYrQzdSV3VJcXkyeUZETlJQOTFjbWdLdjlMT1g2a24zb3pMYWYw?=
 =?utf-8?B?a0I3MEY5aHhsdVVyaVlQMXlBdGgybmZwWmhqb3RmdGg0YTRTOWc0WURZQlpU?=
 =?utf-8?B?Vk9QZ3RVTVVmeXowMzR0ZitCVzlPQ1cwMm9rZU5XRTZ5dWJ2K040bnVWd0ds?=
 =?utf-8?B?ZlNwTTFXclVXcW55ckVnbGZ0SFZrRVl3SEZ2UThlaDEvZXRCZVNIbEtsUWpt?=
 =?utf-8?B?TS9vZ09pNTNNbDBmNWl2MDN4Nll1SlNmZ2xPQXA2aGxFYXU1M00vU3VzSW1w?=
 =?utf-8?B?YjkxMjVTdlNCUWlUTDJFMTZzQ28yM1lTSkYyem1KTWxvVkU3K0NjY1c1NmhQ?=
 =?utf-8?B?TkxaZHZNQnRUcmxCeWV4UXlwM1M5YzFhL2ZLV05ScW9PaW83Q3VCZllmbDUy?=
 =?utf-8?B?dHVnc28wL1NZczg0M2RsQVlLdDdFT0cra0JpWXdBK3lNMVJEYkNQSkVSRDl6?=
 =?utf-8?B?b1VSYkh6WUxCcTVMcEdTWlVNUWVnaWREUTJQejVhcXB4MWsvaVFpQVg4eTVH?=
 =?utf-8?B?Y0FpK1RNQUxhbkE4Y1AvWk1zS1NLWHR3UG1EZU1SMnJTblFiVzRnOGdLc0t2?=
 =?utf-8?B?S2tDOGJKbDRLd09RVVZvVW55ekZrWHVGSTdFOGNZQit1V0x3NDBoLzdDWk5T?=
 =?utf-8?B?ODREeGVLK1AxQTBLNVZSSjM4bU00WXF3YkFPdFVVM1YwU21FTHRjVWFLVE5D?=
 =?utf-8?B?b0llR200UENWSkxBM1Y5Z3IydUFFNXpEdUVtZEZ3cEJIajR4Y2xPMk9tSUJr?=
 =?utf-8?B?VE5FT0RSQ2g1NWpudUJoZ3JvS3dlVEVPclR6eTRhNDhrbnIrUXNuSHdCZTlm?=
 =?utf-8?B?c2E3RUhXTyt6Q2ZvN2xEWXhmOGNrWlRKMXVCbUFObFIxeUFjTGl6dlYreWhp?=
 =?utf-8?B?SzhRbFFkYjQ0blBPU1hXLytLVm1ValExQ3pNTTZZcFFKMGdWdGxrTlVSVnYz?=
 =?utf-8?B?ckpQVzM1Z1UvMXA2ZVlrcjFhZitFYTZHajBldXJqWlFuSlVzYUtRQTVWMVBz?=
 =?utf-8?B?NWtEMWpydWNhZGd1WHBDczNRbGVqaktaRWtwQ29PeVdML0s5eEMrUmI4VmNP?=
 =?utf-8?B?RWpmb2hTQW8xbTNrbmlweXNybm0vd1h1R2padmxtaUxyYlptM1R0aUdoT0lL?=
 =?utf-8?B?d0hEbjZXamVpVlRMRnNwV3o5ZXIzNThQSUJYcWlnOUhVeTZLeUN5WGJpVUhD?=
 =?utf-8?B?cmwrREtjNXNvbWJKTVc2OFRyZGNxaW1QQnRmdTEraXlMR2ZhVDVkUUR1a01E?=
 =?utf-8?B?aTBDbGYyL2Q2Ym1ZTjMxa001bDdCSUNHT0N3OWVJb2dUUWxtNTBXbkpuazhn?=
 =?utf-8?B?WVh6Umx4V3h2TXBLaDZXekllZ3NXekRkdHc2NkF3RmxnSTJsNUZFejVLRjFk?=
 =?utf-8?Q?K4mgPb0dj+oL9B4HUA0A7xiiZaKCoA78z2D4s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a010YkZQekx1QjBiYS9tdmF4Ym4xbTZxOHY2ckZtb0tLb3FCTVdZVm56ekhh?=
 =?utf-8?B?SVhJVHpQQ2pmYlova21Ya21VSUxSLzN3QmxwYW1wSGZxckttZXhkK3kxUFhK?=
 =?utf-8?B?ZVBGYm93STluOHZGeWh0ajQrYnRVTWVZaXhMa0JJUFN4cVRraXh4WTY0UmM2?=
 =?utf-8?B?MUZuSFlZL2tUNzhIQzFOZ25QUTYyNllQNDdSR1RKTkc1UzFRUkJMN0Fkcmtp?=
 =?utf-8?B?Zi80dFMwQ0FCdTFzdEdTSlVibFh3anAyOXF6dGlUSG9VQnNKbGJUSVppa00r?=
 =?utf-8?B?RUJEOHZoUDJOT0dkbWcwdDdDbXlaMlM1ZDhCVUNhemFWME9QTDZrVzBPMzNM?=
 =?utf-8?B?T0Jqa0srSk0vYVltVGZKMzdsbGZiU2UyOGorRTIrT3RQNkpSRFBueHVobGVV?=
 =?utf-8?B?Q0I5cWxzeU9aTG1RWGpnU1B5UWx1M0UxU0ljcmE1NmNwWHhNYjVOR1hSNmlx?=
 =?utf-8?B?N1ZjTk1tT010NWcxcEhhaTN2Vk1mcFN0b25YL2Y5b2ZOeXJFYnlzRVJjTTVT?=
 =?utf-8?B?d1RWd29hTUlUMFFmWHdDOXdDWGZOdnZJNmlEQWVZMHllVFZlek90ZklFZXB2?=
 =?utf-8?B?alhxWllRZ2MrYjMxTFpta3o0YnVyOUV5dmZHNzk5QzBncjA3N2IyZHlpMmpW?=
 =?utf-8?B?cEhFUVNGa2NOSHZVQ3JXMzZNdnVyR056bmh1akdmRlQrdUxidFJTS0xaV3JP?=
 =?utf-8?B?L001UVNJNEQrU3NUN1ArS3puT3dhRy94ekdMcFNFbFA4M1ZrYVVyN1NoQXBP?=
 =?utf-8?B?U0loRGE0VWNVV0NQd0doZHc0aXpxQUxUOHRXbkpxNGtjYmZ4YThZUEVtYTIz?=
 =?utf-8?B?WUFGeFMwRHp0L3d3d1J3MDhMdzNIZkMzN0p4ZzhMT3ZXQi9RRGFmTVp4OG4y?=
 =?utf-8?B?NGR2bVdZR0Vadkw2c0UwZUhLdFBlaHVTeUE3N1hWbnI2ZDVIQ0FEMW1aUE80?=
 =?utf-8?B?VjNzOE9BUVpNWFFtS01BY3hZSGd6bTV3eEZIbUtva1R1ZTk5KzR1MDY3NFVi?=
 =?utf-8?B?QXBhLzErVkJTeHB2aTFQUU43TDJnSWVHVWxuOFFhWWJHNE1YZjNKM2U0RWJ5?=
 =?utf-8?B?bkVHVm5odytmSWlEVWNtM2FNYmtza09ud0ZyNTRQLzlZRlRGbjZpMzR2TnNL?=
 =?utf-8?B?RzQwRkpqWEd2ZXpmY1h0aXBtb2JRZlZKZzJUMUlvOHJxSXhJd09IUmx5enFK?=
 =?utf-8?B?QjJKdUxoVERuOEM3ZjJVcmUzN29JTmF3cGNhRHlZWGJ4aHhyKy81czliQWVl?=
 =?utf-8?B?eHNCNUZnOUZoRnBZdnRZQnE1bEdSSE9VSVJnaGZNWndNOEQ1dVg2RWphcGJG?=
 =?utf-8?B?L21OOGs3TjNhT28wcnlrclhYSGF1VGZ2dWFXSE5qcXNucmZTMVBORjl6TE5s?=
 =?utf-8?B?bkI0OTFlc0lMTFgvOEpxUDl2Y3RmNnpxRzFqM1BLTi9oeW1CbkhmYkZZZ0NC?=
 =?utf-8?B?bjdKc3IwV05XcEI5eFZxR2Z0Zm1vTU1WT05nL1pBVlJhOHNDazNBMGlLQ2N6?=
 =?utf-8?B?QW13T1hPVGt4RkdOeXVWTzNPRjYvUzdrU1R4MXliN1I1V21vQVRPOEp6WDIr?=
 =?utf-8?B?SnZ5OStwcWxzenY4UDFXcUFBYnJuUlF3blFiM0dHbVFDcStOTzB5bFllY2dS?=
 =?utf-8?B?SVdkOG5VTGZVc0R6aTZUMUlUUU1HTEZrREFGTmRYUC8yV21DYzZwK1VJb0dN?=
 =?utf-8?B?eXpsMS9wV00rSEdCdTFudFdEMG96UjU0MlhIQ3BwM0RiUlhUTGFxTE05RXlk?=
 =?utf-8?B?VHQzYjFrQmlwSi9OMEYxcldPTithLzVtclFTeDZ4VGJQWmZXTmJ5WmNxVXJq?=
 =?utf-8?B?MTJSbkRTdG1uR1JWNE5aNnRWbXR2ODhjbVR4bUtMNTdiWHErZTlnR094YkJR?=
 =?utf-8?B?RWdkTGJSQ2VTSXhtMDdWVU42WUtrZy9VeElwaEFWOXlMM09WSm1Rd3VrOHJS?=
 =?utf-8?B?Qllvamw5RlFha3hBSkZ3dUEzOE9HTFM0UExDR0lCN3hUY3drY2YwZUptVkV4?=
 =?utf-8?B?ckc5TDczcjB5bUx3K3pRQkY0Ym5xMi9RZnpIR1htM1JpUFBGdHdnR0UwSTJY?=
 =?utf-8?B?cHdlM0xmZFNXajA0OFhWVGt1T3gwZFprVm1WcXRBNWR5Y3lIYldNVDh3czNK?=
 =?utf-8?Q?ngs6VIJQN25jZNqslR8JBCbm5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6677f6-9ab9-48a6-2119-08ddec233d29
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:23:45.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSIuChInkA43DG4OP0fUViWA/nF2LFyRjjm9NRz+uBlkuUIHrUUPrU5FEJlaA0nTTYDVdwvpv2WO6+HRFNRvPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457



On 5/9/25 11:27, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
>>> +			    bool enable)
>>> +{
>>> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
>>> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
>>
>> There was:
>> FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, 1) |
>>
>> and now it is gone, why? And it is not in any change log, took me a while to find out what broke.
> 
> Oh, sorry, it results from this feedback.
> 
> http://lore.kernel.org/9683c850-3152-4da5-97f1-3e86ba39e8d3@nvidia.com
> 
> ...but since the address association registers are not programmed then
> nothing routes TLPs to the IDE stream. My mistake.


Ah, right, my root port does not have these ranges (streamid comes from RMP) so I suspect I do not need on the default bit and probably it is my test device which actually wants it (been a while).


> We may eventually need the ability for the stream allocation path to also
> allocate a traffic class in the root-port, but for now this assumes single
> device TC==0.
> 
> For now I am adding this:

Yup, this should do. Thanks,


> 
> -- 8< --
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 4f5aa42e05ef..610603865d9e 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -379,10 +379,12 @@ struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide
>   }
>   EXPORT_SYMBOL_GPL(pci_ide_to_settings);
>   
> -static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide, int pos,
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> +			    struct pci_ide_partner *settings, int pos,
>   			    bool enable)
>   {
>   	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, settings->default_stream) |
>   		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
>   		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
>   		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> @@ -424,7 +426,7 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>   	 * Setup control register early for devices that expect
>   	 * stream_id is set during key programming.
>   	 */
> -	set_ide_sel_ctl(pdev, ide, pos, false);
> +	set_ide_sel_ctl(pdev, ide, settings, pos, false);
>   	settings->setup = 1;
>   }
>   EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> @@ -481,12 +483,12 @@ int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
>   
>   	pos = sel_ide_offset(pdev, settings);
>   
> -	set_ide_sel_ctl(pdev, ide, pos, true);
> +	set_ide_sel_ctl(pdev, ide, settings, pos, true);
>   
>   	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
>   	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
>   	    PCI_IDE_SEL_STS_STATE_SECURE) {
> -		set_ide_sel_ctl(pdev, ide, pos, false);
> +		set_ide_sel_ctl(pdev, ide, settings, pos, false);
>   		return -ENXIO;
>   	}
>   
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index cf1f7a10e8e0..a2d3fb4a289b 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -24,6 +24,8 @@ enum pci_ide_partner_select {
>    * @rid_start: Partner Port Requester ID range start
>    * @rid_start: Partner Port Requester ID range end
>    * @stream_index: Selective IDE Stream Register Block selection
> + * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
> + * 		    address and RID association registers
>    * @setup: flag to track whether to run pci_ide_stream_teardown() for this
>    *	   partner slot
>    * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
> @@ -32,6 +34,7 @@ struct pci_ide_partner {
>   	u16 rid_start;
>   	u16 rid_end;
>   	u8 stream_index;
> +	unsigned int default_stream:1;
>   	unsigned int setup:1;
>   	unsigned int enable:1;
>   };

-- 
Alexey


