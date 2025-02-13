Return-Path: <linux-pci+bounces-21330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9591A333CF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 01:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44B601889D5B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFC1372;
	Thu, 13 Feb 2025 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z7g+ErKI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB492800;
	Thu, 13 Feb 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739405301; cv=fail; b=KKDB8QfrNDP6ffcCGCWjsXaAtjuPVLvIDz2vjZQzrL6/GE/qIvZ68vEVMgr8QEyTToQwrHQyhptdgBAXnFX5/xNRbbQV/tfVrO9PqfpdqxvCRpaLZqXJBntvDWOwVZgTdiCsT6nu4Eyz6zq0HLniELlAwhRYwIJO0fYtCH2wqEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739405301; c=relaxed/simple;
	bh=jZx/sp9LtLb9ZHRf/Dy80/wY4JfDHfq8a+4NNhno6Zc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s6eAuoFK4R6wrRguY/Sy0W0ymUPhctO9/+oXPGlxvaWbNZgDUTnqsJgJ9rb5D24MGqRX2fcckfrH9od0kqemySgymnCSVPBaCCempfjDupXmMfoyCskMKri2IiJfLJRDUv9RrQ/fOQGzkDbKoYZXtoTwKKQJrLa++mjDrQ35w1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z7g+ErKI; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyljAvp741YeqrsNcH93D5t9azqNZyUHa8PsyXmA1TQQ+4qhrVMYnLk/cYFVOI8I4NjZIiFmt/GN6WNKfHcpdCsWhAVIGQ97nGS2oX9h+xx1RoN/55m372R5Xd94V9QQin98IfAgsoMg/JCCEUArR0QZHnhU+xeUhzzuPUrP6OOxth0l6udtjS0QUPkBnIwc3bC6zpH5TII0K6vWSmKeveAe+yZSL1NEloS6gzQH1iL1vgrVLrQOCZJpVuTfeGei9DyLAK5iBNAuGJ0dha5562wAEhI5jhgALvmimQnVtXfGc3M23rb9FvBIqHZz/3GkRnK4MWHdocMDgS5Bs0GWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SldXN4/CFKceJvHGq5UtsEQcAGc8bAiKQDCyuyezFyQ=;
 b=bk4rlkU2T6u7c/CDyQqXk4263HPhkZSbEffRFt8RfR/x+Yw+lMqFWeVm85srwBGuK+RWobRM0xIp2OOHP9TEzo8MneycucxVPGKRwSPBFagsb0qyPNvnKLWwWsV3vPBZNT0XY9L5kb8lwwRb3CF+kcsAxx0g4Z4h5meN7YMpYPYOXQwv9tj4LxZPmll9wVpuIPZUbhtcqDh6aLKYcHVfgQlwWdOOWulVuumrQHBYWyBm4Jn34RcbkR8AR9i/wsmgtXmJ1ooyvBKBnS8UTUhky/nqXjxMqNJXZ1VZwQj4rFJI83Y7d/oCdzKp5LCYrX1wBHU4AQUtmHmi/JHH2gJAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SldXN4/CFKceJvHGq5UtsEQcAGc8bAiKQDCyuyezFyQ=;
 b=Z7g+ErKIEK6XzwWQ8jbYOxePr1mRV3jnRTvyDl7X8kFuyL5t0uauU1rQHVbamDw3sICOqRF7XdNWnU53OD700lPYz8iba4HtkDEKWEY2VkjKVm/JDHOanTerzhfoLqcvmOhziMR4dyxdBqWCHGXlllyrICtisebefMqiBbjHluA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 00:08:16 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Thu, 13 Feb 2025
 00:08:16 +0000
Message-ID: <d56fcbea-8405-4f61-9c32-63db88f1483c@amd.com>
Date: Wed, 12 Feb 2025 18:08:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/17] cxl/pci: Add log message and add type check in
 existing RAS handlers
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-11-terry.bowman@amd.com>
 <67ad27da2f65c_2d2c294b9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67ad27da2f65c_2d2c294b9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:805:66::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ad671b-f2ce-4601-b67b-08dd4bc283b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1FGaTA2QXVDRlVPRnBhUjdnZkE4WFRnSDB4T3o2YzVLd09vcEhmank5TE92?=
 =?utf-8?B?eHNBZlhFSDI3VHFzWG9XdUtUOHNXYzRncFJqR0lBWGJrWktnLyswOTBiNnQv?=
 =?utf-8?B?ci85K3JDKzRzdThJMkdNb3VxVEFiY2NlUXBTWHlENGs2dDVJTmJmNmRUUUJ6?=
 =?utf-8?B?Z3hOWTd0SElTa0p6bW5iOVVZNEIzT0xYbXY1U2JLRmt0c0d4dGtHYVdzWHh0?=
 =?utf-8?B?OGRDeGNJbzdpak1NNjhMbnZWd1lMS05jdWFCRTlrS1o1b0NDcitJQnZ3aGNX?=
 =?utf-8?B?a2hVSzl4d0FVcWRZalUyL3YrcmcwdGdKMjEzeWEwR2Q2ZnR1SHhZNjFuejRh?=
 =?utf-8?B?TkMrRDBUcnZNWTNGRFZidW16bkN3RDJReENxbVI1MHJwZnUzdHRhTnlrL1F5?=
 =?utf-8?B?Y2k1czNSb0FhaXhxTzR1eW9nVlRXdkNhMGNHRzRBMHpmT3hPaWs0QWlWTmFy?=
 =?utf-8?B?NjRndTB3aXd6b2h5SlFxUS8zSm9QaGlVaWpmWEk3VlEwNGk0SW1FTFJUd3lp?=
 =?utf-8?B?VDhtNTROZHZndW9jVE1Qakh0MzVoUHZ3NXd2ZlZuTDY3aVNpWndMamF1d1BW?=
 =?utf-8?B?MGIxNVowQU9Ib0t3Njl3QWlJQU1WSVQzTXZpNjRTZmFabTJub0Zid1d1V0FS?=
 =?utf-8?B?Tjg2Z0VaZjFFL0l3NnlBZkhBNWx3NFp4MjJZcDdObnhQemZmYUZCUmRVV3B1?=
 =?utf-8?B?TnZCVllDQmRJYXg2dTFmUzAxeG9iV1pPU3hBN050V2IwdlN4SGxlcStxWllB?=
 =?utf-8?B?N2N1cmVpMGw3ekVPWjU2c0dQTjl4OWk1OGlHT1pPeFB6N3dxY1haSE44cGNG?=
 =?utf-8?B?d1BTY0pxdEdDTU1qNEJ2Y1VxVSs1bkc3NEZlK1NlT1RMUzY4bDFjRDhxU282?=
 =?utf-8?B?T0JzUW9RZDZJcEc0MjZ2V1FJZXYvWnYydnVqVzVESWg5TFdtT2l4WExTYTNZ?=
 =?utf-8?B?MFFsTXFrVGlhb2x2M29iUHFSWVhsL0xDZkhFTmhySitUdE03TlpWbHE1ZkNH?=
 =?utf-8?B?WTdGR0ozYS9wMm1KZmYwcFMrNDdoLzdUT1FZUVBBVWlYUnBQY2ZSYzFZd1hG?=
 =?utf-8?B?bklVeVYxSFZnTjExMkhBTGkxL0gvak9TK05SSnhaa2tEWFJWdWpON1pwbTBX?=
 =?utf-8?B?TElJNWMrdVhDKzhSc3ZydE9sZ0JVdUJqZEhFUUR3bXA3ZElVMGJxdFNkdnpk?=
 =?utf-8?B?M0s2dnYzZThqaWp3WHY3eXlpV1lETjJHUnJLNjVvTXpKanVpSUZla0NraFVM?=
 =?utf-8?B?NW4rQnNyWU4vRDh2ZzJ4MnkrMzVrbFlTTEdJNkNsVXVBeHNRa2R0ajVveGln?=
 =?utf-8?B?L1FhWm5QTDhiV25hdzBOcDhnb0JrVTN4V0l5ZE9TMStkbFcyeVplN1pCSXMz?=
 =?utf-8?B?cW9ybWY3cDV3eWZ0TDJDYzFsWS9GS0VqcVpaUnh4bk02SHpCUk43Y0Focnhz?=
 =?utf-8?B?WHRsQS9kNFNiVmh0aFZWUitQeThXVTRaOTNaQUZJYkY4Z0oxaXlMMkNtd21B?=
 =?utf-8?B?dGt5c3pKbkdqaHo5cHVoZGN3cExISTM3d0tyWjlhR2dDQ2kxU2JSN1JyczFq?=
 =?utf-8?B?NW9Dc0ZpNzRJeEt0aG1KOFJFNytmZlpHMkNCRTlEVDRPV0VPc09MZEdvZldx?=
 =?utf-8?B?ei9jdW1UTDZsUVZSamFkTFhCckZ5emNUVmVsVnpVcWo0VFgyRzdSTm9tY0E1?=
 =?utf-8?B?Q004cFZjZ0M1TGNQRHF1RkFNT1lVTFFKWko0cWVYL1V4MjR1NHQyUHNFOVVY?=
 =?utf-8?B?ZFgzYmE3ZGR4cW9SZ2htZk1hVGZuVi9EQkFFYWpYVGVGakkzdG1QK0FJUGQ5?=
 =?utf-8?B?QmxoSmZIY1cvWkdGWGE5d1E5b3R1VUVwczQ0NjI3NUp1dXlmNndSdzJ1QStq?=
 =?utf-8?B?LzdXSzZQbkpiM0lOZG54QjBJdldNNGtjNGxab29CMjlqSXovRWFTMU5QZDFy?=
 =?utf-8?Q?pAMvWR5YIZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVlJRm50Zzd5R3d4eTcrQ3FOalNyMVp6L2ZwRitHWWY5VVM1UzhrRitCaEFD?=
 =?utf-8?B?SGFzZHdYMzBOR1dudUYxTFYvWlFpWWZUSE5nZlhvNlFpQkV6ZnhkaTY0RzJK?=
 =?utf-8?B?c1J2UmVZaUZKY0JtTVM0Y1ZMbGYwakxmYzI3Ti9ueUhYV1hFNE1JeThMbkI3?=
 =?utf-8?B?bGtVRnVkU2dtenRmcUt5azFIZUZLQzV1clRuRXBPMkRUVjczb0ZkZXpUbVQ3?=
 =?utf-8?B?OTdRTTZWeFIzZDdra1MyemRLZHdVcDRMc25jbjJSQlc1UGhnNGdrTjhYclZT?=
 =?utf-8?B?RElOUG5OdHVFLzVnV3dncXpQeVczVzBGMmpYWlZvUk1kcTZrVDM1WmtqMjNt?=
 =?utf-8?B?bm1XSzFDeHhnU0N5cUlTa0FUUldVSjhocVk4QlJRQUxWOW5PVGJDMUhmUWhv?=
 =?utf-8?B?ZnV5SHY5b0d6by8wcm1LRURWZHV0MURZR20vSW5SdWZ5TWxwbnpQemZiOTR1?=
 =?utf-8?B?V2txVG50OUp0bGhndHlvR3lubUlFMEhrUkVRaW1KS1ZCQWg2ZE9hTDNVZW9t?=
 =?utf-8?B?VTVKeEZxbXVxYmtCczJ5SnFPN1ZIV0ZadW5yVDZZZEtHT3E0NkZheFJBRXpr?=
 =?utf-8?B?anM4MkowSm1IZDhKUEcxcE05Wmt2L2ZZL0VNZ3c3Ulk1WnptbGFoT2IxcG9x?=
 =?utf-8?B?eFlnUk5ma09zbWRYQnc5T2R4cEhuYjdlcFdEYWZjU1UyRGxlUUZhYzI5QVBi?=
 =?utf-8?B?dm9wbmJpUUFhWWN6eVk1MENRK1o5cFhlL0VaeTdzek9iZGhBL3RtRDB0OEpV?=
 =?utf-8?B?eU5LS2xIWGIwSlZNckZTcnplaytZUXhrUmtTV3VxRW0xMHN5QWE1Ym82Tmln?=
 =?utf-8?B?RFFrM1pDcVlkSENtR2VXT3Q5ZktUNHlUeW9mNktCZFVuYTBFbkFNa3JNNmhJ?=
 =?utf-8?B?L3ViaTRMekg1Umk3Ny9kOVYzL2U2ZzcvTVJlWHhKMEQyKzRrTHFLUEd0dVpV?=
 =?utf-8?B?T2kwcFNYMDk5MWVVa0JWR1dnMUFVL3pWYzdwWFNPajBrREF3ZUFwcjZITHJR?=
 =?utf-8?B?RW1iUEEyS0dJUXFodTZ6SjFXdHNibWxjVE5TNTM0cFdYaVpMc2VVUWxsV09M?=
 =?utf-8?B?cVk2L0R0UXpKTXpnVExxN2psK2h6alY4ME4rZ0djRjI5VkpxbjVaejZPbS9N?=
 =?utf-8?B?V3hpdytub0xTVzd2SVlkWlhSZEcxTWI3N0xHVGdFL2hHM29RNWRadFdHWTAy?=
 =?utf-8?B?RUFtWW9oR3E4WVk5TWlCemlCOEYrSWcxR1RzN2RxK1V6R01yeThTY1VpRE40?=
 =?utf-8?B?eXduMHNzOTM0QWcrbU40RGptSFFxOTVzY2ZoZE1lNEljVG9uODRFZ2k1S2Nl?=
 =?utf-8?B?UmhrRG5maVRCdGlXM0p3dEw1Y3Q5QlVpZnhhZzh0aWkvSVJaOXhIRGtkcitO?=
 =?utf-8?B?eHBFUk0yZjJtNjZsQmYvTS9KL01mS2c0VW9wMzdialcxelhoUG9zSldMRnZ2?=
 =?utf-8?B?Unc3b25jZ1A1ZVFQdnBnRGRsdWpBdFVtekFuRG1hRnJjTWkxOXJ3aHlCbUVq?=
 =?utf-8?B?dnlYWXJOVUhxaFJ3NnU4YXYwOGlQV2xJQ2d1TGd6ejRtcnkvdmVHR3RLWVZJ?=
 =?utf-8?B?OUltTGhQZmR1SldqaXZYQVdMKzJVcFI0WEd2eDJjQlZGUWV6TEhvQXpTYWs2?=
 =?utf-8?B?ZXZ5ZzNLZyt1bFNjMXJlT1U3ODFnSVNHVVNrZWt6Y2RISC94djcvWUhVQTFn?=
 =?utf-8?B?YU5HS1VnbWRqMzN4R2JTQUNSZ1RqWnc4eCtodEFVbG5sQ29NMFJCQ2NwRHZH?=
 =?utf-8?B?YjlIZndJbnJPUWV5azQ2TXY2Tk9OOVBKM25hdDNaWjBmSElOK1luUlZGN0xj?=
 =?utf-8?B?bHRRVXIzRHBwOS83VitvcTFEcFZnRU55bTNJZHNZeFBBQmFPU29nSnpnSUVr?=
 =?utf-8?B?WU9VbEhWc2JGekNqWk50REpnRkVvMjhLVU9GUDhTL2RZSFBXQnR4TVFnaHZa?=
 =?utf-8?B?TzJpMW5vRkZsM09yY1RXc2dSeXB0NWVxWC9xUXBHY0VEYkk5SHBqV0hZb2Nu?=
 =?utf-8?B?L0pHa1p5bkgzVC9lWXFzUEFnUWZWdExjNUdQSlZFb2tqSWo5MU10N3dLM2c3?=
 =?utf-8?B?a2hISGR4OXJONHI1YTBwc1h5SmZ0SU9DVERHNmNpdS9ZZnRzU05IMFJaL2I3?=
 =?utf-8?Q?jCEOEHN0EK4gM7Tpd/tmmg5ap?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ad671b-f2ce-4601-b67b-08dd4bc283b9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 00:08:16.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOt8x60yHfRwMXJ6fOfvDOTvnCrnseN+OLqI+aPJ0hnST2BnEpnPn+OSzE8gEd0RDDHU0KXM/1cNNGCNa7L1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671



On 2/12/2025 4:59 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> The CXL RAS handlers do not currently log if the RAS registers are
>> unmapped. This is needed in order to help debug CXL error handling. Update
>> the CXL driver to log a warning message if the RAS register block is
>> unmapped.
>>
>> Also, add type check before processing EP or RCH DP.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> ---
>>  drivers/cxl/core/pci.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 69bb030aa8e1..af809e7cbe3b 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -658,15 +658,19 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  	void __iomem *addr;
>>  	u32 status;
>>  
>> -	if (!ras_base)
>> +	if (!ras_base) {
>> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>>  		return;
>> +	}
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> I think trace_cxl_aer_correctable_error() should always fire and this
> should somehow be unified with the CPER record trace-event for protocol
> errors.
>
> The only usage of @memdev in this trace is retrieving the device serial
> number. If the device is not a memdev then print zero for the serial
> number, or something like that.
>
> In the end RAS daemon should only need to enable one trace event to get
> protocol errors and header logs from ports or endpoints, either
> natively, or via CPER.
>
That would be: we use 'struct *device' instead of 'struct *cxl_memdev'
and pass serial# in as a parameter (0 in non-EP cases)?

>> -	}
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -702,8 +706,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	u32 status;
>>  	u32 fe;
>>  
>> -	if (!ras_base)
>> +	if (!ras_base) {
>> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
> Is this a "never can happen" print? It seems like an oversight in an
> upper layer to get this far down error reporting without the registers
> mapped.
>
> Like maybe this is a bug in a driver that should crash, or the driver
> should not be registering broken error handlers?
Correct. The error handler assignment and enablement is gated by RAS mapping
in cxl_uport_init_ras_reporting() and cxl_dport_init_ras_reporting().

Terry
       





