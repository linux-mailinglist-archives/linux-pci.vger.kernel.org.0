Return-Path: <linux-pci+bounces-21317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA52A332C1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385231889512
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EE204594;
	Wed, 12 Feb 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="10vH7q9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B850202C38;
	Wed, 12 Feb 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399852; cv=fail; b=YE4cRbtPGJTdOvjB5bmZzwyflCfEoohIhKFeuHQRNG1gFMwaz+iz7QxgtuWJ5qX3C4KEdLK+3DdkbjL9/eF7MWt8iIC+WbDneClZvVNPqXbVpNO3KLdG/KSmUDQceMKYqQF97bRHEg+i6TLdjG0WhZN79ra5Etc36ZtS09/J5ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399852; c=relaxed/simple;
	bh=xHTXBAec573Xupqdli1b99hsU5MfPhrjs7JiH8IEvxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KcYx41miSHhvmDVU3RH54N54W/HdYVD1nFc/DA3bLCqdh+SRyGZ70uPuXPmBOiwkqrvCNSaE6DXKxQ5iYe4v2hYYELZmwxPboHl2wAWN41PFD92iyNjsy9mZJ17OuMuIiYSj0xMEgkGVkfgsLezIbiyNVeYMtc9K+wltLuPbRnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=10vH7q9V; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNgSOeKPmHdS36vSPzpt6S09jPu6X9zlCq2eVGhzBTWc3r2efSLLBgCfbTFEVRfLKkM80JeLn0tXn97JonWumHJnkEuVapeNXIVo3kvvdR2ZOnbdpSxjrBbXxjXFpZfJYWwXfFwwbmnE0dvPGoxNSPbOsmuWNB5zGwj1W0imT96t65d4IWp6uSm31Ac0HaQFbHnhG33POOVoZT+gMT4WgLsSPfgVPykr2u7mGeIjF3zfrYSS8GkX3fgoV0cmUVf3YVBYsnFKt5jqg6wRfCdnOWO8Neh4FEhefHYUu/14aqpM3VRRHZ1zU4olwKqr9FQwAhhf/T+KEoRdnfbn9VsJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Ftl2hDicUhbXc8jm5Viwr3nr3+otfIPlyrywmrRYXM=;
 b=a42DIsv2pBdUBVWp4qQm2lYHyeqSrFLeHtIIOv5Cq7HsJn30HqSnoM0vALR/au6o4Mk/pAf3eRLxTP6rEpQU6SA8FRh72PWhzeuOhDzhCRqYo95ov3NJ4YCoVU6IQozHuVjaGJPBb66x20fdWaIdLh12l+tHNFb0CUmZAYmhRJQv4GP+WAD/L1zsFpwfjNhRuoKdhmBxFhj2r2tSRxoxO1nE2G1xLX25GNjohaPmUy2rZptsEEiIWENvft/fGovv3WZedofPKH25Q3MpV6ukz/HyWDz1PGs6Gtz0iCkXfyH0RoS1l4twGuc+jZ5Nt7XeKzS/u98f3zUtVs9+xhLNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ftl2hDicUhbXc8jm5Viwr3nr3+otfIPlyrywmrRYXM=;
 b=10vH7q9VfPA9zqB6Zf7q7IqSMTpYci1Vl7DCk1UJH+Tor+ZDfIi6KyV8NO4Fx3Z8gQKEN/TE0Gy/iDLhGbgZP+8t9lgFA7pQ2AOtv7/8tZ276IriHTPCmLy0LcwMRbBD4wmFkc/xUMraN9P1gvZpqisfoimdKqGQnKx4JY61Jlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Wed, 12 Feb 2025 22:37:27 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 22:37:27 +0000
Message-ID: <fa431683-a12a-4ed2-b00c-63e9da5e7055@amd.com>
Date: Wed, 12 Feb 2025 16:37:23 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
 <Z60gdyVGJQSLRER9@aschofie-mobl2.lan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z60gdyVGJQSLRER9@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:805:f2::21) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: fd95e849-9f78-44bc-dbfe-08dd4bb5d3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXMxNmxPVDR5RVdSMTd2S1dNeW4zanFwc1NZU3ptMXkxTm8yUnpWWm44NENr?=
 =?utf-8?B?VHp4bWhmZlB2WDNaUzFVSnhRTmQxMnRJTDdGK0MzVHNEM1UxSnA1cDl0NmFP?=
 =?utf-8?B?dzZqeVlwY2s4QzVhVTNTeUhXY0hIay9GUUFXMHA1VnhvUzhTeU5IODNCZUxr?=
 =?utf-8?B?OHMzMmlncmt2U3RGL1dsZkpKVGVqZThzSFd4SmhTUHNDNEVwL3BCbW5DYVBO?=
 =?utf-8?B?ZjcvZ1JKdGltUDl0ZmgydVNXY2hZWTdlRUlBVjhjUlF3ZUxaOURjU1p0K3Jv?=
 =?utf-8?B?UlpPNDd5SEhHR2JTK2NGbHduWGRJdWhqTkNBTnp4ZXNlYnpNNFBCRnhXVm1l?=
 =?utf-8?B?UGVIV1AzeDFUQ0MvdjlrbXArZ2pPUzVRbTlqS3ZaOW44MUUzcG5NZzZScUNF?=
 =?utf-8?B?emN5bU42blB0ZlBnTE51K1pGQlVweFRkdGV5ZHRQTGdyTHdGa2lyK3Y2cFpp?=
 =?utf-8?B?MG9BUXhUTitoWU1UelIrQ1NaN0NUbk1TRDZqZDVxWmVWSWtLc0ZsN2tyb0xq?=
 =?utf-8?B?Tmc5UXM5UGVpQlRSSGdqckhadlRYQzYwZU5OVDlKNUtBbkw3QzdCa0VoLy94?=
 =?utf-8?B?cXU1Z1FSRUJwR0liR1JrSGxZL0pPWHRteGFrVDNOemJXSjlIMmc3SGRrbjVn?=
 =?utf-8?B?Szd1TTZTZHowMnk1d1grVUcyeGdsaFZCYUJtVm9xN3NEYnRwdlZqYXpPZGRz?=
 =?utf-8?B?Qk5JdktjSVFYT25iZHlTNG5sQ1RWdEZSTkNoQ2dtZXZqY0VEekI2NFF3YkRt?=
 =?utf-8?B?TXhRbHZKTlR6ZTZOa2lHeXdTSjhHc3JYeFhHOUhsa3cxT3dMYnJZNTNZeC8z?=
 =?utf-8?B?UnJRR2E0a1c4MlBpY2lnalBENXhENzNZeVBEZy9yenhybGlubk9IR0hmbHBC?=
 =?utf-8?B?YmZPTGMzaUJ6blppcFM5SlBudlBjMVJneWxYMHlRWTl6TDdPNW1NbWpNUFMw?=
 =?utf-8?B?MDg4YnNqQnJ5S1RvSE1mOTR6a3lLMWd0bThZWkpseVpTR3BVa1hVcms0Mmsr?=
 =?utf-8?B?bit4UGVBbldDa1NSUXRZT0FodkROZ3dlNWRpMDRrV0FvNGd6L3ppNmRIY1VR?=
 =?utf-8?B?WHNQUVNXTEJRYUw3TVREK1JPTlhEdjdGa1lKakV1aGJwRisvMVFrTmF5UGJv?=
 =?utf-8?B?ampwNTFxdjQvSy8wQjM2bjhOaitHbHYrclQrdzVQc1FyVldDRGhDcjlRTElO?=
 =?utf-8?B?eVF4RzlYSitxL3BzTUpSOU03MysxTFRpVU53bG9rVWRHVUR1N3ovbnJpUFRy?=
 =?utf-8?B?Q3VaQjJhQnlmUjRGSGZhbUo1d2M2b0MvcVd0dlpzYjF0SUFPNExuS0YvVWR0?=
 =?utf-8?B?Mjk1VXBoMUdTNHlrbTVpTUZvL3pwczdYWklXZzZ1bzFWSENGRytjaFBzNU5W?=
 =?utf-8?B?SmcvNTNnM25ERlhZZzJsK0Z1Ly9aU01XNjY2NklFeFBpNzVmZzlFYmhOZ3Nz?=
 =?utf-8?B?RkJWSG5mcU1YcXBhSTdmbmlZNm9WSGdVMndHTjl5SGM4eHgybUJBTWI3d0No?=
 =?utf-8?B?b0NaWSsxK0RTTzFNYjFrZ2RJYitZRXBIZFk1RHBpYlpEcU85NkxjT2ZQemVp?=
 =?utf-8?B?STg3WVBzbFo4NzNmK2xNamRKWnFGbjNSR1IwRmZsVEZ4Yk4yeGlVNE8zWFFa?=
 =?utf-8?B?bjB1VlZmMVl2eFRIcDB5dGMzRnljbmtadU84clJEaFFXVzVxSmp0NW1OYjdn?=
 =?utf-8?B?b3lPTCtVMkdrODF1L0JJaklCNGY2TENFa2p3dldONFdRVlc0djM2Tk90ckpU?=
 =?utf-8?B?dG5aWmlYaXpuSGlCSkVSdFczR1QrL0VCV3VVVXFZYVdiNmduTWNQbk84Y3F4?=
 =?utf-8?B?Q2lBR0NLbENSWWZnYS9SQytLOEZIVCtrckxIUmlHSDJWaU1hdkVxdHJIQzBi?=
 =?utf-8?Q?ln8YQIdlaWxIq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTFjWVJ2ZnB2Tkl6azNtcDZKVG5jNTIrcWw1MUczUjRsM1ptRmVmRkl5cVJN?=
 =?utf-8?B?STFUYVZtUTJNWVJnSUJDSjZ1QlRHdFVGVHZvTmJkRFZNcmtDSHBjWThIQUFE?=
 =?utf-8?B?aHMzbHIzRko0dDcyNVJOdzl0eGo3cTd6eWFKRTM5WHJkNnNUNnA3U25Vd3V3?=
 =?utf-8?B?UU9lY0tIYnk5K3VROTdIYkFjYjJJYkoyYllKUkdyUHpqaUZMZjRjTlpuOHhz?=
 =?utf-8?B?SGF1WTdwQTRnRVVBL1QrNXBsQTlnRlAyZnRJRkc3TWl1YWM4UFFNZnpUOW5N?=
 =?utf-8?B?OTAraUdBWDI4L2t4K09aTUtrZU94QTNlQkdKZ0t5YUlIUzNlY0pieThmbWwv?=
 =?utf-8?B?S0FPTEoraHEwSUEzcE4zR2ttRDkrZmlUT0pwMEJhY3RENk9Pd2pmQWVMSEp4?=
 =?utf-8?B?L05GZFRPN2Y4U0hucnVxMytqM0NOcnlEeUNUYXduRjFsckc0aUhYYVkrbVZV?=
 =?utf-8?B?d0czMW9XUEJaWFh5bFY4WnFBbWtuQnJZVE1kOGJjVWJPOHVHbjN2Vnk3OTJl?=
 =?utf-8?B?bFFwbWNsSDRRQzNSL083YXJ5WlVRNEpUUFdFSXZWeElXdkxUaC82NnhtZEdp?=
 =?utf-8?B?VVVBdC8yYWpzbWxBSG9qSUgxTXhvb0w0M01HUHNpbm5ad2ZNaVF1MUVTeXRx?=
 =?utf-8?B?ZGF4TmhEM1BTU2kwaXA3d3lKWXpaaVJBbUMzcHp1bEZteitVcVBzSXJEMWhH?=
 =?utf-8?B?OU5PNkpidGNkQlAvY0FJOVJjV2ZYZm0xOHpDSHZMYTU5RXY2Q1NrOEVpNkx1?=
 =?utf-8?B?OEo5Z0JFaGRCZjdwallvN3dWcE9xZ09rUW02aWo1ZmFuOStqS2g0eGlLRXY2?=
 =?utf-8?B?b2EzMGs1UExDTHRnVG9ScWNlSzZINTR4Q0JDaFJhTXo0QW9wcFdBbElQTHBP?=
 =?utf-8?B?N2Q2MEd1TVFSWnYvdXJ4Q3hzMlZwYkVvMlR2VWtGU1BKTFVEQy9VcUM0OVBD?=
 =?utf-8?B?Zi9ENG95YmV6cjlmd2V6cE4xV2N3NGZmaUdBNmFnZU1OSWl3RFJtSGZCeDlk?=
 =?utf-8?B?WFRjcFlnNXBXdDRUZ3lzNWlaYlNXa1lGRVl3Y0NrSXF5Vm9NeHVTcURUZFlS?=
 =?utf-8?B?QitVV0pvb3Bsdk1EYnR5eG5CWXh0RXFNU2tuVkxLKzljMklzZnNkdlR5QnE3?=
 =?utf-8?B?RlJzU1FubGFCQU0xR3A2dm9QcUZKM0RqbWIrL25ja25zVFFjYUNobm1aejVP?=
 =?utf-8?B?SElmUGg1NzBEVG5KZURkZnhXNDRnV3R6TmRBMDJ4NHFMVW42VDV4NWkzVkZE?=
 =?utf-8?B?TTNQWUtnVUVLLzZrNzE3OUh1dE9ta252MjRvTGttUjhVUkkwbEJVSnA2OE55?=
 =?utf-8?B?Ni94YnNnVmwydXBDc1NpMzl3MitFazRYc09uaUNvK2JvMGRsQnVSVzllR25p?=
 =?utf-8?B?eVhaa3dUbjVhS3hjNTBXa1N4UGhPQmJFQ0dhMlNvTlJOalA5SmNPaUdLbkxs?=
 =?utf-8?B?bGFoVGVwQ2lMbzNINEtZNlg2T1MvN2JtcmEyVC9qdTdLR3lnU0g0ZnU1VXhp?=
 =?utf-8?B?MUR1M2lxR3l0UHZJa1FWQkw0WFF2Q1QyQTRoWHFZYVVNMi9xNlVLd3lLcUc3?=
 =?utf-8?B?SWFyYlpwL3dGY2Vvb0g2TFRPWUZ0aDBaWG1XRWJqcmkxZ3IvVnNrOGdYdStt?=
 =?utf-8?B?SzdtUzdrQ0JGZFBzSHVwT3ZtSEoxQWVZQkRCNDFaRE5XblpCbjhBTWJNbnFx?=
 =?utf-8?B?S21vODJ1aXVHNngrS0ExUlFLSE5KR3lISksxWXM2Um84YituRS9kaTZadlJ1?=
 =?utf-8?B?dUluZ1BocFU4RE5lYnRmMjIyckZKYi8yYlAxdk5XWHowUy9sUFgxcDZOb1BZ?=
 =?utf-8?B?cE1RaTdsUnFwQ2JBU1h3bmxkQXdCWVYwTlhLT05Zbnl3QjN6Z3I4VnB0OGdi?=
 =?utf-8?B?czNvVWUzQUU5WUE3aFFpL0xrMHZoSE91c2pNRVhWVm9SRDdKdmhiTlhQdmdC?=
 =?utf-8?B?VGt1UEsySk1BeXhQeTg4YjB5UVpzYW9VemJmRlQxWmRnNzlOeWttOEZOc1BE?=
 =?utf-8?B?Z2lEbWR0RGlQUzhGa2VteVdubG50UzZIcVpxeWk5d2Y4UUp1YjF5L3ZzSGU1?=
 =?utf-8?B?ZVIvS3RZWkN2dklPTWpnZVNxTnBDenlsRkYyaWNWYU5MbCtNeVlqMFE4d3ZB?=
 =?utf-8?Q?lDwQC2QO4j7zwLiPNrNsZBk55?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd95e849-9f78-44bc-dbfe-08dd4bb5d3cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:37:27.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h60gtpkOq5uf/5hlUyNPyFvbpasbWfbokdTkqwl0gcH2eTdHuE7Dm3FTlMUUUmCrck6BuuTloK9wtcKsoEt80Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852



On 2/12/2025 4:28 PM, Alison Schofield wrote:
> On Tue, Feb 11, 2025 at 01:24:34PM -0600, Terry Bowman wrote:
>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>> registers for the endpoint's Root Port. The same needs to be done for
>> each of the CXL Downstream Switch Ports and CXL Root Ports found between
>> the endpoint and CXL Host Bridge.
>>
>> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
>> sub-topology between the endpoint and the CXL Host Bridge. This function
>> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
>> associated with this Port. The same check will be added in the future for
>> upstream switch ports.
>>
>> Move the RAS register map logic from cxl_dport_map_ras() into
>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>> function, cxl_dport_map_ras().
>>
>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
>>
>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>> before mapping. This is required because multiple Endpoints under a CXL
>> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
>> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
>> once.
> snip
>
>> @@ -788,22 +778,30 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>   * @dport: the cxl_dport that needs to be initialized
>> - * @host: host device for devm operations
>>   */
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  {
> With this change an update to cxl-test is needed.
> This func was wrapped to make sure no mocked dports are sent to
> cxl_dport_init_ras_reporting(). 
>
> 2c402bd2e85b ("cxl/test: Skip cxl_setup_parent_dport() for emulated dports")
>
> This works for me:
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index af2594e4f35d..1252165bffba 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -299,13 +299,13 @@ void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_cxl_endpoint_parse_cdat, "CXL");
>  
> -void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +void __wrap_cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  {
>  	int index;
>  	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>  
>  	if (!ops || !ops->is_mock_port(dport->dport_dev))
> -		cxl_dport_init_ras_reporting(dport, host);
> +		cxl_dport_init_ras_reporting(dport);
>  
>  	put_cxl_mock_ops(index);
>  }
>
>
>
> snip to end
Thanks. I'll add this to the patchset.

Terry

