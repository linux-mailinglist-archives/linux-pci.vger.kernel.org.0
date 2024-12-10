Return-Path: <linux-pci+bounces-18023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75FF9EADD2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 11:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CB6288165
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18B078F40;
	Tue, 10 Dec 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mO9DLzna"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCFD23DE8D
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825943; cv=fail; b=pJY0Ow1Q6JRlNn0VJjBkllj4G7/jAX/EyQKtAYme9Wa3gUV8VVYyUcfw+OJczF2oph8XM1s7Q01aoEM+hVMXjRPbNOHZO3qHeJOqa3nb8RqgWe2Ii8MWHEG5mcoccJq6MDfXvQ6AJASMlUP+53YcUb49UZAd9DQMghQbYbPWKSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825943; c=relaxed/simple;
	bh=fZZn+M0B0S7zeMS2iSabnbcFBRCdpOEKFU2kqG9NReo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lHzijpR0BbBwtsAhpxYlxRebH0DFUIIsi+TObQ0vqGFuec/9eWTk8tRTgerp6lhDgFW3Za1fmmlKoc9vb1Q3AC1S4RKHu3J6JLpiRrrL6xuDgZM/nPTEy35k9b5rLRVHZC3tXPV806CI2mG2Xo5XMX6J90R73HPgpOFaVJG4yzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mO9DLzna; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBP79LSiVsadDL4wKgd1sBI9lF/+NMKk6Trx2COvtYSfkpuNQ4h0jnD4dpBnqY6cVbu5KOVgVrL9k0yTZmctninB4QZDl+puKV3Am7O8HnfFHqKspMlJmNPcwbzZ/nLadK9oLlK+4otmaGUNjQo0VlxqJrg5LxPKTdbWfpr2RFIyaMMClJfghQp4H9j1EvSMckzzwnpfetS9fOuudPJt8TIhymXUY4jTfVEJhqHtWfVaoEZ8dINLhqRhBC85M2g/rN6/GuTAXo/TRVqMKJ3ZU332F9XW/JCPmex6lzrz1MOHdBlA6MkbdlnarAf6aS7MTnDysomSkH5fUJLqgkMcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97WLu4QQoTZUZ+H+ppH7Rig84BCAItEf5rVUIONoi00=;
 b=qzyGRItQ9eLtioLIDpKmHol/jVnMQxbmPBz5pM2h5asMT+QcEzfuTqds6R5bCgYeyCLduNEkt1bwK2nUsB3WU6ZFwzLXUgevgZ84ZcJDdFQBzLC4XEuR1MpuEkIO0zaPXDlCBK9DC4hLW9Zvn2w15TOUIorgZSDNbfukxgDgmcUZsv/3tYx2zl5Lt/+udyGaGxDnKs7Vcmcob6b0w1Y67FdcEnG5knykNAqb2+Inl2LYm5vTMYrW1w66vLBxoNs6m/FmfUlf73dz1DJSB1aZwRn1pJEIHbQh6vmzAjFM1nLPiUDZV65Z2D9wDdLNFkEln/mhPO7pqsjHgQVhozwbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97WLu4QQoTZUZ+H+ppH7Rig84BCAItEf5rVUIONoi00=;
 b=mO9DLzna362Rzg3DQQ78IA+UQwuI+tnUYS5rDUUrRw3kkLWmAZ1PoBIl1Gi69ebRDy/nTtlff/VExB+IbhG1fmnWKteNwnRDrx3IUEjzQWfVuTfF5ULfK9S4ClEKtU5T717XbcwM3EjUeeIswaDMERWbtsC32Er5ogdOn9eZ5OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 10:18:55 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 10:18:55 +0000
Message-ID: <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
Date: Tue, 10 Dec 2024 21:18:47 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYCP282CA0023.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::35) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bdaeed-3eac-42af-9310-08dd19040d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlNvZjliUnQ3RjAyV1ZGR2MvcGl3b1NneGRuYUtDbXo2OTVVVnJaRlRxazFL?=
 =?utf-8?B?RlJ5cE5VWEtUVGs1cC8vZUdIRHB4SG5JdnJMQ0RIcitQWk91VnVDY0Ezcis2?=
 =?utf-8?B?SnoxcGNyc3BqOTJqQmwyWUdKZjRuQVRUczNVbThkV0hWV3pIZTVmL3pOaUlI?=
 =?utf-8?B?WkFwVTlBUldVc2I0Si9zNHY3S0tIMUdoWUgzYnc3MnRpVlVqVUh6L242UWcx?=
 =?utf-8?B?eVprcS9FNW01UGwvOTB1R0l5WmdLdW1nV0xsSTFVT3RLcCszR2szRG1iV1FV?=
 =?utf-8?B?RjVrQmxDczVHWkI2aHZGalBaVmJZVzVTYlVtZlNZaUtHcEREMEc4UFFVakdR?=
 =?utf-8?B?L2hRcnYrMTJkeHM5S2p4a25pUWhxcUk3eG9zZ1A1SlIvZm1vT2JsYkVnNzk2?=
 =?utf-8?B?b2hQaFZGeHFtQmNxMmJQZG54NXVsSWtWN1VhU0RTYTArQ1E2TjY3UXFEUGhi?=
 =?utf-8?B?NlE3VnBOQ2haUWRoc002Mm1ONHBzV0VHVlVsMEc1dGtWUXNOYnFzY0YyMXhm?=
 =?utf-8?B?TjdMZDRqUUNqNmVYRHpmNmNsbGRJUDYxeXdVeEIzMDZWZFJJN1ErbW1IS1Zl?=
 =?utf-8?B?MTFURmVMTlFYM3d3Rk0yT2t1a0FVR2ZXdk5IeXdwdTNTU25jVDVucDJ4UDZS?=
 =?utf-8?B?T2xDSE1TRnJCZk9lR0hDclVra2Z1ajVJSkNncUFkZWRIY0ZpTDQzOC9RZnQ0?=
 =?utf-8?B?aXUwMXpmNk5iWlJ3Q05UMFRWMWkwNS9XYzlRRGV6VDZKMnlyY1EyNzQxdlFr?=
 =?utf-8?B?S0dackQzSzBJN0JsV0dvWXVMalNRbGs3Vnl4SDZ2RU5YZFJZbGljS0pZbmc1?=
 =?utf-8?B?RXFkTUNhb1ljMm42amVZUnBNMUdLWW9jRmg0Zk5NdGhmR0tkWnBKNlpzNk5y?=
 =?utf-8?B?ZDhPRXg5UE9MdDJCRXRCT3RMRWNubWExL3o3U0JuZUJKVHJlZFpudUtOYWtW?=
 =?utf-8?B?YVZUQ2hjN3poYkpId0owNkdtdWw3YmdQcXpPa01kUVpQd096UmVYUm1jTG9I?=
 =?utf-8?B?RkFxMExnS0FrZ1p4YmlkQmxsQW8yKzd2R2YycW9yeXdhbjhnN3FvQTFxbzE2?=
 =?utf-8?B?SmVpbS9jUENTSWtLanZqUE5MS0RjVldNdzN4MXZDUVRJYk02QytRNEtGMEJl?=
 =?utf-8?B?V2UvZUhTdGg0Y3VHN3VuMmV3bHZNZ3VFV0Z2WGF4RHVPRFl2VW9NbVVEZUM5?=
 =?utf-8?B?K0ZqVDdudFhNaklTVkZhRjhvaFQvUmsvZU9zUGtXSDB1WTVqSFFGUDJTYTlU?=
 =?utf-8?B?ZGxsQ2VqT3JjaDUvMWxaODRlNTdqSVBWVzlrdnFFYy8rOGV1NklabEFrOVlL?=
 =?utf-8?B?dkgzWlQxOGJEZXNqNER6M0NNQkw2RGM2TkZYc25YaVRLWldOVzkybm9tbzVq?=
 =?utf-8?B?VnY5amRUZlRoTDRNU0F5L3RJMXpRQitPK3EreUg3ZUJ2SUgwOTc3aGRVNGdU?=
 =?utf-8?B?eTFXUDVjc0FSQXRac0hYNzlyS3hUaWRaVTRkZVgvVTFQUFljdFFzV2tISlJV?=
 =?utf-8?B?NGl5ZVE4K1I5VTdXS0JEN29pYmhuUWFKdjc5TCt2TnFsYzVORDBqM0YvNmZm?=
 =?utf-8?B?UUNNVjJKMlJTbjhlcW9Kald4NmZJRERZWnNaY1puUEp3cXZ0ZG1adDRaRlZK?=
 =?utf-8?B?bU4yeDZSOU1XeHR4Q2EyWk1sY1phVVhhcVpyRXBBakt4QVFxbmtEWmkvem93?=
 =?utf-8?B?WmY1R21vd01Ib0xmYTIyNkI0UmFENG1udWpKTW5EM0xKOG5jbmpEQVhlU0FB?=
 =?utf-8?B?RG1kdjhkOGszTk92dllPTnhkT05FSVVGZ1E5MTRnM2x1K2pxQk1OWllQWkRZ?=
 =?utf-8?Q?j+ItBciIK7sETzZnqOukF6Nyl6ojEdmG9poLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R096L2xwbEllb1RUS1Q5UDJoa3pFUmU0VEZ6aTYyNllqbzNRMHB2VmNRaWhN?=
 =?utf-8?B?Rkh3ZEFITEYvSGxucHRoWVp0cDhYanRtaWhaNFNSRjE1N0MyVWI4VDh2djFY?=
 =?utf-8?B?bjIwbTBBRGFNamZ6aG93Y0Z1anJEUnRVa2pZcmFwM0hWUUsvb0E3eDhNN1dE?=
 =?utf-8?B?Vm8vaG5rWVFsR005WkFXd3lpd0tqVTd4OUFZRkNEZmlEcEJ6YmhhUWVuVThq?=
 =?utf-8?B?aWlRb0ZuV3hOaVlzZlMyUmZKK1p5TGJFaTFQbUU5VHdXT0EyalNRelg5RFJw?=
 =?utf-8?B?WkorTzlMODZMM3VQOWlGMXI0Z21OMmxOcCs3eVRycDZhbFAxZHZVdDRoeDhY?=
 =?utf-8?B?Sm80cUhha2d3WWV0Uy9JUVpFN1BHcTVrT2QzMzdWYW02VWZIUnoweVg1WnhE?=
 =?utf-8?B?aExHdG42VVpLRmV0MlRnd2h6ckZVY1BUZm16cUZ2ZlN2blNwUU4wNjRkOXgz?=
 =?utf-8?B?aHdXTjgvUVdQK0FHbEszbnhiRkFHRkdQbDhyT003YTVNcWhMNHMveENKN1NQ?=
 =?utf-8?B?WE5zMlRuWXZ4V3dXYm56OFlBanFXTFJNc3B5bHVTZ3ZTL2RmZ1BITFNIVnkv?=
 =?utf-8?B?ZUNsZ2JsbUQyOEJhbmtWSmFsZHdXN2dkOXhrNDhMTktDU200cDlSVm5iRFRU?=
 =?utf-8?B?cFhkblpNNTVUWnJZakFTd2JsOHdwWnppSEp5YTMxQmZsWXIxNi8ydU1DVVFD?=
 =?utf-8?B?T0h4c3NiL1A1NFEreU9mcVpyZldLZmMxclFHRUdTZFhqMHY3NzFIelZpaFpK?=
 =?utf-8?B?TTNpN1VzKzRrT1VMUjhyYmJUQVlicmlBR0QraVpVSWZJRkpFZDFEWmhUcm1l?=
 =?utf-8?B?c3BWbWtveTBWUEd5Qk1FeFN1eFNIUFlEcjFnbFBYc0ZLdjY2ZmJJelpQTmNt?=
 =?utf-8?B?cVp5c3NwRVUrQ01qQzJISDBqK0RwRXJicDZodS9Sa250WUNXc1lZeklVYmsz?=
 =?utf-8?B?QmxlM2ptN2NnRE9YNncrK3NzWWxkK2x2M3RIL2IzdjJ4WFFsZ00vMmZCbHJJ?=
 =?utf-8?B?TWZnVmMxRWJlQmR4Q2wwMnM4NVhCc3FodEhtUXh2ZzJnN2MxejRrMVVXOTdR?=
 =?utf-8?B?a2tPWkd1eWZUSFk4SHdJYlJxSjhkVFpHRngvMXI4ZTdaazJGcy9EdXpYTkJl?=
 =?utf-8?B?SThRV3pnRmhsT05HbVNnaDNOd2RiUDRXaUNIbVJac3JjY3had3BCVTJtVFBh?=
 =?utf-8?B?emVaOGpOcm03enFuZWJzQWV3UTJuYzJLMVQzSGlPQVIyRVBCQkRPUlcvaGRt?=
 =?utf-8?B?UGZRR3hNK09VMlFDaHBtM0V3RkVPSU13WWhKcW1TY1BXd1g4ZTVib0hqY3pR?=
 =?utf-8?B?M3l2ZXA2V1A2eFIwQzE5dHQxejBuNFhjL1NOQm9PSDVxcGhYNEFCbjAyL1J3?=
 =?utf-8?B?bmVSTG55NkpHK0pyeW1sWWRxbUltdFNZQ2ZvaHAzODY4M1ljaXJMbk9GSkk3?=
 =?utf-8?B?MVRFWnlUSGhLVjNKVTJJd0xPVGk1OXhhUUY0QUlqMWk1blZnaHdMZ25na3h0?=
 =?utf-8?B?eVAyaDhOOENiYXJhK1BUQVI0eWRxZTlweTBGdVoreG4rS3VuRW42Y25uL1FC?=
 =?utf-8?B?S2pUbE81Unh3NGFRcXE1VmtHVCtjaG5GRjNQTE91WkxkRUQrbmNpR0dFZGk1?=
 =?utf-8?B?bm9NUURNUVhBU2M3Wm4va3ZEeUxiUkc4Uyt5dkVTZjBlT2w4M0c3VVFsUjQ2?=
 =?utf-8?B?ait2N2JqWmtaUnhjakZoRHZiWkpoaGpxWUtMTnI4OHhJUWFhSElNSTFuM1oz?=
 =?utf-8?B?ZzgvZGpEbU9VaDBXQndHZGdIM0N3TGtEYTBxYkhUSWJFOTJnaDZvN1VzUHov?=
 =?utf-8?B?M1IzcEh2bnp2WFNVNlhEQVdteXVPRzNwZ2o2V2VhN0lzUHZxVG5heUxsZHpO?=
 =?utf-8?B?T1ZDZWhhMy9BcXVJUGZWeTgxNldTaGFsOVQ1NVVLTDhnQmJ0NEZQRjJIVm42?=
 =?utf-8?B?Z0ZZU2tYUkVUd0YvajB2UzdrTm54S2NrNC9wREpoVTZFb0FlZDZ1QkF4VEdp?=
 =?utf-8?B?dVA2Nnd0VytSME0zK1k3VDVOQjc5N1NHVENkOFBQdzhSYlcrN1VEK2lYeW1w?=
 =?utf-8?B?U3VSM294RWxWbUdFSzd5QThmMkQvLytKcGl3RDVQRFdYL3VqSWdQOUtmYVlL?=
 =?utf-8?Q?2GdATF5e56jFJSJzbiFbiEAB5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bdaeed-3eac-42af-9310-08dd19040d71
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 10:18:55.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3izQkESymt9cjyODe5S+kale1uaXfa+owpvUAyspbneLiEUj69WOe5rJ4vDlGI6/dr9i3LDTS977WTw7sUIwtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356

On 6/12/24 09:23, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> interface definition builds upon Component Measurement and
> Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> adds support for assigning devices (PCI physical or virtual function) to
> a confidential VM such that the assigned device is enabled to access
> guest private memory protected by technologies like Intel TDX, AMD
> SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. The work in progress CONFIG_PCI_CMA (software
> kernel-native PCI authentication) that can depend on a local to the PCI
> core implementation, CONFIG_PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. Consider that the TSM driver may
> itself be a PCI driver. Userspace can watch /sys/class/tsm/tsm0/uevent
> to know when the PCI core has TSM services enabled.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> defined for secure session and IDE establishment. The 'probe' and
> 'remove' operations setup per-device context representing the device's
> security manager (DSM). Note that there is only one DSM expected per
> physical PCI function, and that coordinates a variable number of
> assignable interfaces to CVMs.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem flushes
> all in-flight commands when a TSM low-level driver/device is removed.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |   42 ++++
>   MAINTAINERS                             |    2
>   drivers/pci/Kconfig                     |   13 +
>   drivers/pci/Makefile                    |    1
>   drivers/pci/pci-sysfs.c                 |    4
>   drivers/pci/pci.h                       |   10 +
>   drivers/pci/probe.c                     |    1
>   drivers/pci/remove.c                    |    3
>   drivers/pci/tsm.c                       |  293 +++++++++++++++++++++++++++++++
>   drivers/virt/coco/host/tsm-core.c       |   19 ++

It is sooo small, make me wonder why we need it at all...

>   include/linux/pci-tsm.h                 |   83 +++++++++
>   include/linux/pci.h                     |    3
>   include/linux/tsm.h                     |    4
>   include/uapi/linux/pci_regs.h           |    1
>   14 files changed, 476 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 5da6a14dc326..0d742ef41aa7 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -583,3 +583,45 @@ Description:
>   		enclosure-specific indications "specific0" to "specific7",
>   		hence the corresponding led class devices are unavailable if
>   		the DSM interface is used.
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function supports
> +		authentication (PCIe CMA-SPDM), interface security (PCIe TDISP), and is
> +		accepted for secure operation by the platform TSM driver. This attribute
> +		directory appears dynamically after the platform TSM driver loads. So,
> +		only after the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one, before
> +		that, the security capabilities of the device relative to the platform
> +		TSM are unknown. See Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Date:		July 2024
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Writing "1" to this file triggers the platform TSM (TEE Security
> +		Manager) to establish a connection with the device.  This typically
> +		includes an SPDM (DMTF Security Protocols and Data Models) session over
> +		PCIe DOE (Data Object Exchange) and may also include PCIe IDE (Integrity
> +		and Data Encryption) establishment.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Date:		July 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index abaabbc39134..8f28a2d9bbc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23843,8 +23843,10 @@ M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
>   F:	drivers/virt/coco/host/
> +F:	include/linux/pci-tsm.h
>   F:	include/linux/tsm.h
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 4e5236c456f5..8dab60dadb7d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -124,6 +124,19 @@ config PCI_ATS
>   config PCI_IDE
>   	bool
>   
> +config PCI_TSM
> +	bool "TEE Security Manager for PCI Device Security"
> +	select PCI_IDE
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool
>   
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7679d75d71e5..7e1ed3440a50 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1696,6 +1696,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCIEASPM
>   	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0305f497b28a..0537fc72d5be 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -458,6 +458,16 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e22f515a8da9..7cddde3cb0ed 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2518,6 +2518,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_doe_init(dev);		/* Data Object Exchange */
>   	pci_tph_init(dev);		/* TLP Processing Hints */
>   	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_tsm_init(dev);		/* TEE Security Manager connection */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index efc37fcb73e2..fd4ccafed067 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -55,6 +55,9 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   
>   	pci_npem_remove(dev);
>   
> +	/* before device_del() to keep config cycle access */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..04e9257a6e41
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/sysfs.h>
> +#include <linux/xarray.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/bitfield.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static const struct pci_tsm_ops *tsm_ops;
> +
> +/* supplemental attributes to surface when pci_tsm_attr_group is active */
> +static const struct attribute_group *pci_tsm_owner_attr_group;
> +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	if_not_guard(mutex_intr, &pci_tsm->lock)
> +		return -EINTR;
> +
> +	if (pci_tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +	if (pci_tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +
> +	tsm_ops->disconnect(pdev);
> +	pci_tsm->state = PCI_TSM_INIT;
> +
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +	int rc;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +	if_not_guard(mutex_intr, &pci_tsm->lock)
> +		return -EINTR;
> +
> +	if (pci_tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +	if (pci_tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +
> +	rc = tsm_ops->connect(pdev);

I thought ages ago it was suggested that DOE/SPDM loop happens in a 
common place and not in the platform driver implementing 
tsm_ops->connect() (but I may have missed the point then).


> +	if (rc)
> +		return rc;
> +	pci_tsm->state = PCI_TSM_CONNECT;
> +	return 0;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	int rc;
> +	bool connect;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	rc = kstrtobool(buf, &connect);
> +	if (rc)
> +		return rc;
> +
> +	if_not_guard(rwsem_read_intr, &pci_tsm_rwsem)
> +		return -EINTR;
> +
> +	if (connect)
> +		rc = pci_tsm_connect(pdev);
> +	else
> +		rc = pci_tsm_disconnect(pdev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if_not_guard(rwsem_read_intr, &pci_tsm_rwsem)
> +		return -EINTR;
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +	return sysfs_emit(buf, "%d\n", pdev->tsm->state >= PCI_TSM_CONNECT);
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static bool pci_tsm_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->tsm)
> +		return true;
> +	return false;
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm);
> +
> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When device authentication is TSM owned, 'authenticated' is
> +	 * identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static void dsm_remove(struct pci_dsm *dsm)
> +{
> +	if (!dsm)
> +		return;
> +	tsm_ops->remove(dsm);
> +}
> +DEFINE_FREE(dsm_remove, struct pci_dsm *, if (_T) dsm_remove(_T))
> +
> +static bool is_physical_endpoint(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return true;
> +}
> +
> +static void __pci_tsm_init(struct pci_dev *pdev)
> +{
> +	bool tee_cap;
> +
> +	if (!is_physical_endpoint(pdev))
> +		return;
> +
> +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +
> +	if (!(pdev->ide_cap || tee_cap))
> +		return;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	if (!tsm_ops)
> +		return;
> +
> +	struct pci_tsm *pci_tsm __free(kfree) = kzalloc(sizeof(*pci_tsm), GFP_KERNEL);
> +	if (!pci_tsm)
> +		return;
> +
> +	/*
> +	 * If a physical device has any security capabilities it may be
> +	 * a candidate to connect with the platform TSM
> +	 */
> +	struct pci_dsm *dsm __free(dsm_remove) = tsm_ops->probe(pdev);
> +
> +	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
> +		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
> +		dsm ? "attach" : "skip");
> +
> +	if (!dsm)
> +		return;
> +
> +	mutex_init(&pci_tsm->lock);
> +	pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					       PCI_DOE_PROTO_CMA);
> +	if (!pci_tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return;
> +	}
> +
> +	pci_tsm->state = PCI_TSM_INIT;
> +	pci_tsm->dsm = no_free_ptr(dsm);
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +}
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_init(pdev);
> +}
> +
> +int pci_tsm_register(const struct pci_tsm_ops *ops, const struct attribute_group *grp)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!ops)
> +		return 0;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (tsm_ops)
> +		return -EBUSY;
> +	tsm_ops = ops;
> +	pci_tsm_owner_attr_group = grp;
> +	for_each_pci_dev(pdev)
> +		__pci_tsm_init(pdev);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_register);
> +
> +static void __pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	if (!pci_tsm)
> +		return;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	if (pci_tsm->state > PCI_TSM_INIT)
> +		pci_tsm_disconnect(pdev);
> +	tsm_ops->remove(pci_tsm->dsm);
> +	pdev->tsm = NULL;
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_unmerge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	kfree(pci_tsm);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev);
> +}
> +
> +void pci_tsm_unregister(const struct pci_tsm_ops *ops)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!ops)
> +		return;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (ops != tsm_ops)
> +		return;
> +	for_each_pci_dev(pdev)
> +		__pci_tsm_destroy(pdev);
> +	tsm_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unregister);
> +
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz)
> +{
> +	if (!pdev->tsm || !pdev->tsm->doe_mb)
> +		return -ENXIO;
> +
> +	return pci_doe(pdev->tsm->doe_mb, PCI_VENDOR_ID_PCI_SIG, type, req,
> +		       req_sz, resp, resp_sz);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
> index 0ee738fc40ed..21270210b03f 100644
> --- a/drivers/virt/coco/host/tsm-core.c
> +++ b/drivers/virt/coco/host/tsm-core.c
> @@ -8,11 +8,13 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>   
>   static DECLARE_RWSEM(tsm_core_rwsem);
>   static struct class *tsm_class;
>   static struct tsm_subsys {
>   	struct device dev;
> +	const struct pci_tsm_ops *pci_ops;
>   } *tsm_subsys;
>   
>   static struct tsm_subsys *
> @@ -40,7 +42,8 @@ static void put_tsm_subsys(struct tsm_subsys *subsys)
>   DEFINE_FREE(put_tsm_subsys, struct tsm_subsys *,
>   	    if (!IS_ERR_OR_NULL(_T)) put_tsm_subsys(_T))
>   struct tsm_subsys *tsm_register(struct device *parent,
> -				const struct attribute_group **groups)
> +				const struct attribute_group **groups,
> +				const struct pci_tsm_ops *pci_ops)
>   {
>   	struct device *dev;
>   	int rc;
> @@ -62,10 +65,20 @@ struct tsm_subsys *tsm_register(struct device *parent,
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> +	rc = pci_tsm_register(pci_ops, NULL);
> +	if (rc) {
> +		dev_err(parent, "PCI initialization failure: %pe\n",
> +			ERR_PTR(rc));
> +		return ERR_PTR(rc);
> +	}
> +
>   	rc = device_add(dev);
> -	if (rc)
> +	if (rc) {
> +		pci_tsm_unregister(pci_ops);
>   		return ERR_PTR(rc);
> +	}
>   
> +	subsys->pci_ops = pci_ops;
>   	tsm_subsys = no_free_ptr(subsys);
>   
>   	return tsm_subsys;
> @@ -80,7 +93,9 @@ void tsm_unregister(struct tsm_subsys *subsys)
>   		return;
>   	}
>   
> +	pci_tsm_unregister(subsys->pci_ops);
>   	device_unregister(&subsys->dev);
> +
>   	tsm_subsys = NULL;
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..beb0d68129bc
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +
> +struct pci_dev;
> +
> +/**
> + * struct pci_dsm - Device Security Manager context
> + * @pdev: physical device back pointer
> + */
> +struct pci_dsm {
> +	struct pci_dev *pdev;
> +};
> +
> +enum pci_tsm_state {
> +	PCI_TSM_ERR = -1,
> +	PCI_TSM_INIT,
> +	PCI_TSM_CONNECT,
> +};
> +
> +/**
> + * struct pci_tsm - Platform TSM transport context
> + * @state: reflect device initialized, connected, or bound
> + * @lock: protect @state vs pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + * @dsm: TSM driver device context established by pci_tsm_ops.probe
> + */
> +struct pci_tsm {
> +	enum pci_tsm_state state;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +	struct pci_dsm *dsm;
> +};

doe_mb and state look are device's attribures so will look more 
appropriate in pci_dsm ("d" from "dsm" is "device"), and pci_tsm would 
be some intimate knowledge of the ccp.ko (==PSP) about PCI PFs ("t" == 
"TEE" == TCB == PSP). Or I got it all wrong?

> +
> +/**
> + * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
> + * @probe: probe/accept device for tsm operation, setup DSM context
> + * @remove: destroy DSM context
> + * @connect: establish / validate a secure connection (e.g. IDE) with the device
> + * @disconnect: teardown the secure connection
> + *
> + * @probe and @remove run in pci_tsm_rwsem held for write context. All
> + * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> + * for read.
> + */
> +struct pci_tsm_ops {
> +	struct pci_dsm *(*probe)(struct pci_dev *pdev);
> +	void (*remove)(struct pci_dsm *dsm);
> +	int (*connect)(struct pci_dev *pdev);
> +	void (*disconnect)(struct pci_dev *pdev);
> +};
> +
> +enum pci_doe_proto {
> +	PCI_DOE_PROTO_CMA = 1,
> +	PCI_DOE_PROTO_SSESSION = 2,
> +};
> +
> +#ifdef CONFIG_PCI_TSM
> +int pci_tsm_register(const struct pci_tsm_ops *ops,
> +		     const struct attribute_group *grp);
> +void pci_tsm_unregister(const struct pci_tsm_ops *ops);
> +int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
> +			 const void *req, size_t req_sz, void *resp,
> +			 size_t resp_sz);
> +#else
> +static inline int pci_tsm_register(const struct pci_tsm_ops *ops,
> +				   const struct attribute_group *grp)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(const struct pci_tsm_ops *ops)
> +{
> +}
> +static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
> +				       enum pci_doe_proto type, const void *req,
> +				       size_t req_sz, void *resp,
> +				       size_t resp_sz)
> +{
> +	return -ENOENT;
> +}
> +#endif
> +#endif /*__PCI_TSM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 50811b7655dd..a0900e7d2012 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -535,6 +535,9 @@ struct pci_dev {
>   	u16		ide_cap;	/* Link Integrity & Data Encryption */
>   	u16		sel_ide_cap;	/* - Selective Stream register block */
>   	int		nr_ide_mem;	/* - Address range limits for streams */
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 1a97459fc23e..46b9a0c6ea4e 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -111,7 +111,9 @@ struct tsm_report_ops {
>   int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
>   struct tsm_subsys;
> +struct pci_tsm_ops;
>   struct tsm_subsys *tsm_register(struct device *parent,
> -				const struct attribute_group **groups);
> +				const struct attribute_group **groups,
> +				const struct pci_tsm_ops *ops);
>   void tsm_unregister(struct tsm_subsys *subsys);
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 9635b27d2485..19bba65a262c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -499,6 +499,7 @@
>   #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>   #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>   #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>   #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>   #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>   #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
> 


I am trying to wrap my head around your tsm. here is what I got in my tree:
https://github.com/aik/linux/blob/tsm/include/linux/tsm.h

Shortly:

drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to 
control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi, 
it does not know pci_dev;

drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;

drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
- tsm_subsys in tsm.ko (which does "connect" and "bind" and
- tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
ccp.ko knows about pci_dev and whatever else comes in the future, and 
ccp.ko's "connect" implementation calls the IDE library (I am adopting 
yours now, with some tweaks).

tsm-dev and tsm-tdi embed struct dev each and are added as children to 
PCI devices: no hide/show attrs, no additional TSM pointer in struct 
device or pci_dev, looks like:

aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind 
tsm_tdi_status  tsm_tdi_status_user  uevent

aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user 
tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent

aik@sc ~> ls /sys/class/tsm/tsm0/
device  power  stream0:0000:e1:00.0  subsystem  uevent

aik@sc ~> ls /sys/class/tsm-dev/
tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0

aik@sc ~> ls /sys/class/tsm-tdi/
tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0 
tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3


SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing 
but pci_dev is only needed for DOE/IDE.

Or is separating struct pci_dev from struct device not worth it and most 
of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,


-- 
Alexey


