Return-Path: <linux-pci+bounces-42767-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 790C9CAD95E
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00BB73041117
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1515A288C26;
	Mon,  8 Dec 2025 15:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2GBOQjg5"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC81FC8;
	Mon,  8 Dec 2025 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207598; cv=fail; b=Uc4neUh05dL+sifUPl++MzEFtdpGWDfSqwGPhgftLMMMrv/cu0iVphuTaTCIBeAp2K65uQ8jlgGI7mfCzs1eGr17L035ycvns3tDAWU+IqlR1SQTw7+VkdTppWVq4p2edwJCdqZNL2azvxJtNiszceoLrey11paLhkbzCAf7/xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207598; c=relaxed/simple;
	bh=9VqNiF6iwqArs9VHb3l2WHKTcAk3xT4Mfnm2SDLxgyk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3a6dB7266SwLLne0HfF7v+8SxYF5Ilp7Hr/gaxX9ACFbvVOmY+TDWrdEogTT2nrPfGpTPL4vztgHfyKRfXRSu8Gwnu9P+3K1a8QmrvZcUwZ4gviQW/epZufwa6l33zH/i5ubkcJslO2TNpnW2dG73+mfdcwgR3kKyCCRhn5KiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2GBOQjg5; arc=fail smtp.client-ip=40.93.196.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jj3jbQr+gSJ5WHxLq1mp1geJ3v95A0tdPRn7pwX7eavwy5OlKPOKzHNnzsvc23IEMCUQrtJsJMwbT+j3jqyPbCzQq64e0CeGRSzBs53kwLL3vPJucVcP4FDJlbXi57FL47fqtnWEVockNszg7BXqTddxAurkBrWuHG6C/PVufucjJnuC6/1Cq0ROsTKkyW7spPhiDi08+9eiJBsDA6bb7WSnWYMLCURvuvllIdX2YAE0zDMzz38N6hCFpeVQ/ZUf+CoSMwL+pVPBcoQ0TU9L8torTe8Dy6aQFmU+4Gw7Yawz09lYKU9dtgna7tD0cJZQMaCny+OH0dKRcdqFtB7gQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYuoxqEa1fQr544JPARHMH8CpbsyAu2e+INMZ7BmVd8=;
 b=ZdyxfuuVF+ygbBGhH1w3y3hpoLGjYsRobZLVB3GUufput0Y0takMBb5dbO5km03YEHClrP2L4nngFJxv4C7JmyjIIEAynRNl8Cp2k0R25UDh7BrXR8uTBzXkq51MCSb5mL/BJ9Ib9aRc/CftYFgtYHVEeLxT3w1cxjTJTxjfFAlyvIAxsRD1E1rbMM6148O9Kypqa01qlJ0car/O7lTK14NCXRFTJHK8hNCE20NGeHL981oWtgR8Nfc8OF2ToBS0XEJWTLk4agyIixieuVdH2iIgFvVXSoRM4+bZdiFDHpQMlKu4JU3v+mtL1H2Jr60cuc052Gk8oU83C2QlmS9agQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYuoxqEa1fQr544JPARHMH8CpbsyAu2e+INMZ7BmVd8=;
 b=2GBOQjg5MIVkMGImu3MJG2N/cXi0tkwj+hw2JT01RupGQBnMbZbvOss62wRiIJ75vDQ1QbuPNOVs/V+kuRxZViCtRDYs0dWtOl8vkR6BCBUYaGcVbcU4iX9m8iN1ZQoGOHysabmZHqccrm+ZKpr4EQtpO++XxIn3PUGUGIhKc+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:26:33 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:26:33 +0000
Message-ID: <a5d4f527-1a66-4c1e-9311-b8f3fe3badf1@amd.com>
Date: Mon, 8 Dec 2025 09:26:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/25] PCI/CXL: Introduce pcie_is_cxl()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251206004550.GA3300344@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251206004550.GA3300344@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:208:52d::17) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 03371373-f064-4822-a16d-08de366e2b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJsUTdqK3FqRHliLzViaFhkWnhsVWk3ZXZEemVnZGxFaERZRWNrVU96eUc3?=
 =?utf-8?B?N2luQU02cCtFL2ZTbWJtNkxuenhtTTlndE1lT0NHWnBFZmJZaWVIZVRnK0RI?=
 =?utf-8?B?bUl6c0R5QTVBcmtkWnord1JYVHFQUko3SzUxYkFQSFl0dFlrd3pUZ3BHT3FU?=
 =?utf-8?B?NmJ5MHlKdFplSDZmdWQrVy9TYUI3VTdrZlRRTUZTZzZvTlRqZldzUEYvVENR?=
 =?utf-8?B?YXNqZ3NPcWdOd05BUEF6YS9Ka3dZVGZqOXNOeUlmQzg0VmxhYVdsSHR4TGxL?=
 =?utf-8?B?dUdTM2N1Qjd6MjNIYlE5Rjc5aUJHRFlzRWlLenZibGk2aTR2WHE5bFl2ZUtx?=
 =?utf-8?B?R0RxbWg2dm8zYVNJdUw0TkV2S29DSWp5MFBxOHZLL0haNUdxOC9Ja1B6Tk5n?=
 =?utf-8?B?YlI4Uy9BY0JGS3hpczZrb1FwN0l4S28zYS84akVXdFFwOEZmM0U1a2lRTjJ3?=
 =?utf-8?B?V1VSV09pcEYvUWZFRm1JNnN3eDd4NitDa29BS080RGVpNHNaUldBYmRCUEZs?=
 =?utf-8?B?L3N0VFJnb0NGU3psa01yRE1QK3hFVXNoMTdmUVQ2UjNZS2dQd2N2ZStkMW9N?=
 =?utf-8?B?MDdNenNSUEo0djYwcjk0QWNEckVNMmZiZHJXTGdZUFF0djR3MGsxNmFQM0dv?=
 =?utf-8?B?RVFiUXpOUlZUY2pVN1pNZ3pWV0lyYTRuVFJxZnJQdTdqYjYxYXp2NVJyQk1x?=
 =?utf-8?B?THVVZTI4T3pUS2VGMy9uUUtrWWs4dFJKUDdod0JMSXJtaFQxdThETmJIWTF3?=
 =?utf-8?B?d2pGVkZ5Q1VQY0dMZHNyQlF5M1RzZkxaQkdGQ3pnK3I5QWFseEwyYzZ2ejNI?=
 =?utf-8?B?NEJ3T1c2NDZTQU5SL0llOXhvR0hTTkJhL2Y4SDNNOElHQ3lSMWFRSzJHQ0xy?=
 =?utf-8?B?UjVHZmMzRkJ4NnFUS1BYTEc2ZHZZVXFTaVlHMVFCeXFrREVFWFlMSEZUdkd2?=
 =?utf-8?B?U1VTNFdMRkhLNEtWT3hkbmN5TUt6bUNKSXEvYjFqLzJoOUFsRllSVUI0bUJF?=
 =?utf-8?B?dzUya2VneSsySTEvSlhFZy9WUG4wSVFVWU1rZTlFYW1nay9JK1JZYURNSk1y?=
 =?utf-8?B?N3hJUi9SNVcxc3liejI4SXB1R3dSS3FiQ2VKSHI4OHhtZ0dORW1ZclNHbGVH?=
 =?utf-8?B?ZEdqTWhVRlNmcEx0d1Z4UFBFQ0ViVGNGOFhiZ2FEUkIrMkJOLzZNZkJnbGR3?=
 =?utf-8?B?Sm5XQ1J1eUZYZFc4bDVEZnB0ak9UbWVwelA0MXJ6ZVZpR0dvcGRlRmVTQ1hI?=
 =?utf-8?B?L2JjdjlKMmFlOXJNT1JwOWtHR2VVQ3VrRldyWjVkMWpaRkl6VXpzOE5lYkVs?=
 =?utf-8?B?K1RuQWVYaW1ud1V0SkFURWxvUXliRk1aZ3hKVGQxcUlLYUV0MGJmWWtmblpH?=
 =?utf-8?B?M3p6M28vOEN1V0VZa295SHowZEN2ODVrUmhXUFJFZXFxd3BMN01iTHNZVWlC?=
 =?utf-8?B?ditaVHVPQS96c3dzZFgrNkdndTVQQnJLOWxFMFFuTFg4UlVsUFRMUG4zVVNN?=
 =?utf-8?B?MGxhWnpkcWxFNkNVNXFMMHdMQnlGaDBPaHpDTExHOWtXYWZPeW1lWURuNUFN?=
 =?utf-8?B?YUxJZ1hmYWdMQStZVGNkUGhxU2dwNkUzQmszY1N6aUFUZXFDUHp6SHhnOEpB?=
 =?utf-8?B?RGZNQTB5TzZGMzdqYXBCQnBQb1lEQ0poTlYzeEpzT0s2NCtISnZPYjNOQlBp?=
 =?utf-8?B?TkpFS1RNZVowaG1lSks5Mys0aVppVVV2VzNHZzJ4QWgrWGpTdVBOejJHeDdX?=
 =?utf-8?B?ZFdXS3lGNXhIUkFyTDBScVF2QXF4Y0FrN2FrK2xlK3lRS0lWdmlqQktzZ3FN?=
 =?utf-8?B?bjdDM3V5RzlHYTZjL1VSR2EyR05mOTg3Zjhka1NydnlzOVpTV2ZycG1TZUZG?=
 =?utf-8?B?UXN6anFoRGQvSXBBczYrblptTllSd3ZyQnVoRFYxdWwrNTVNSFF1VU5DQXBQ?=
 =?utf-8?B?eXRWa3N1c29wVXEvYWlkVTNMNlk2cDljbjBKcFgzMC9VTXpWbFNFVmZBc3Jw?=
 =?utf-8?B?dUV1TitUODRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJBb1hRUnlqZ3JDWnlQZk9hdHM1ZTdHWU14Y2ZId1hlME1Hazc2WlE3eVBY?=
 =?utf-8?B?S2lsQXFRRW5EakxtaGo3Y213dG92eU9tRVZpUG9XcTFBVGY0M1BsMDUwOEJP?=
 =?utf-8?B?Y0luZkQyblNYMy90Rm9PODVwT2tDQnNISmlpd2piYXVTU0Z6Wkd2UE8xMkRN?=
 =?utf-8?B?VStUU2NKMzlHSGxuYkR6SXlCMXpsY3lUNHEzQnFxUHVjUllxMHJZbHJvNTlk?=
 =?utf-8?B?dnplYnp0WWNUTkZ3TGhXWDRqWlVwZSs2TWVFVTVmenFtQnp4bGZMVHZodTN4?=
 =?utf-8?B?dndYVHkrcGtqWUR1NndweDMwazkwYW5GRThnVTFGY2tJZzcrZWJXTU8wcEM2?=
 =?utf-8?B?N2lzVlFzMitPL3kybEVIL1hvN3dRNnhXR2M3ZmY4alZMeFNSMlFFTWl4am4r?=
 =?utf-8?B?QlZUSHo3ekhFZm56TzJvT0J6TVo2dDJjd2Z4cHQxd0hqUEwvNi9wUHFTYStt?=
 =?utf-8?B?eWhzbUoreUtJZGNmcUptejcySktIRmQ2UDBKQnF5NWUxWXlPNnlLRlZ6WjBN?=
 =?utf-8?B?WG5LeW4vdytJM0Q0Z3B4dzQrL05mL3VhL3ZJV3NmUzROdVZYTWtrOEc1bVNK?=
 =?utf-8?B?WTE0ZUZleU9udUdlZG1SbC9KUmduczlnbHRwY2JodHVLbG9GemRTcEVLMU9B?=
 =?utf-8?B?ZWlsYjlpa0pEOXhSYnVtOE1hYUhxL0U1cnJYUlEwaVNYYnBScEU2Q1gxMjQw?=
 =?utf-8?B?clVpZW85b3lxUmFEQnl1a2JZajZmN2FnRUJHdURDUjdkVVBQV1p2OHd1SUVy?=
 =?utf-8?B?enduVkRYMGZhSjc4RVJDeFU0aWd3YWNuU0VYSTg0dEk4UkNsQllRd0hEUmV5?=
 =?utf-8?B?MmdDbko5Z3hQalJHNkhRb1F3TDFiOUxuRkllc3g0R0VmVytRa1lSekxsWVow?=
 =?utf-8?B?ay9YTXJMenEvOTFmK3ZReURxSm10ekM0c2JxQ0tCZitWZkJid2ZML29FMW9m?=
 =?utf-8?B?R3IzNXVpcDl2Zng3cEVqVmsyWnNlTTBJcWF6SmlJOXBoaUlzRzg5Sldvekxo?=
 =?utf-8?B?azV3Ky9ZR2xLTXBIdG1jTm5FampzQ2t4TmlidWNQMWtpdEYvSE91bnNoOTlk?=
 =?utf-8?B?TTlHUWQvOFViMXJUSFIwbkZMbi94dTZWeDlxZXVUeXlJa3lzNlFQaUNiQnY5?=
 =?utf-8?B?SDJZRHJBMzVyOXh5VDhpNk5HMEcxcU1TZUtVditmakxQYVducC8vcEo4TUJU?=
 =?utf-8?B?SlR5UkRCanptaTBNMklZblV5bHFwb0MrOGJvem1DOGVockFKVHFEVkNXTW91?=
 =?utf-8?B?MWk1aHYwRUYrMWxjbnk3SVA2NTd1MTJybFE1SnZrajVHRUVTZDJDZTRvQ3hC?=
 =?utf-8?B?UVp4enhnSC90WU9NcFFvOUUzZ0ZNMExpYnZNbHpaVG5RSlYxUkRYTGR2NFRB?=
 =?utf-8?B?MGRHek5IcTV6UFdCMStTM3o5UytmNWh6NTVhS0xWcmEyMEJOVUVVUjBDNnBz?=
 =?utf-8?B?Q2Fic1BRVFJuRmN2RGZMOUU5NHUxdW5hd1grYVkybVl4MzBNQWdLWjRxQWQ0?=
 =?utf-8?B?aEdtNVo1TjJUSmpnSk1kZHZjWXpNZmZCNFlTYXU2ZVlSYmhOM0w0UXVJMFZl?=
 =?utf-8?B?ZW8zd0NsM0hpNVBhSVc4c1NFYWhnUzZtTG1ocjQ5TG1INUc3NkQxOGp4MERG?=
 =?utf-8?B?SGFBK1JQOWVkL0FzNmxsUEFOMEVqTnBLY3JLL0VxUzZIUk1NZ0IzSHRqZHVP?=
 =?utf-8?B?VDBwTHlhQmxWK1d3Q2Q1bkxjNVB4cXhxVmhFYVgxeVlmb21OMGRpSXVraG05?=
 =?utf-8?B?TUpXVWNwTERYR0hBSWZObXZUOGtKZEI3V1FQRktWS0h1ekxkL1JDVm1VSi9H?=
 =?utf-8?B?djFzcTM2ajdtN0l0cUxub0syRHppMEVkWUZWUyt0alhxeEJuOFZ1MUh4Rjdt?=
 =?utf-8?B?RDVmYXJEWEpGTXVpb0thL1R1YlU1S3hZU211UjFaSjRjcHlMZWNML2hqalNT?=
 =?utf-8?B?NU9UdTA3OEtjb1VKU0UxOURQNFpvVUU1d2k0bTVGOVdMeFN4UlRYenJJbllO?=
 =?utf-8?B?akJ5ZmxtdHFBeURObzZxSUxuWkJCT3dIUmZmZkhpVnJVaTJ5SGxSZ21VaU9z?=
 =?utf-8?B?WDZEVHR1YmVKZ0RMMVV0TFRTbEE3ZEtuQ0hoSG9VeittSWRMa1BDRXVCSWY4?=
 =?utf-8?Q?XgpU1gytcm1vpMUO++Wi6HgnN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03371373-f064-4822-a16d-08de366e2b46
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:26:33.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMoB74ie1A6Bu2Y4yh09ZlzGHHJBur8j7Fiq1c0Y46bez9HQgGF2zEdAM7PGNzO2LcMp6BSqS8a6Clacy68lIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

On 12/5/2025 6:45 PM, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 06:09:38PM -0600, Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
>> status in the CXL Flexbus DVSEC status register. The CXL Flexbus DVSEC
>> presence is used because it is required for all the CXL PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> CXL.cache and CXl.mem status.
>>
>> In the case the device is an EP or USP, call set_pcie_cxl() on behalf of
>> the parent downstream device. Once a device is created there is
>> possibilty the parent training or CXL state was updated as well. This
>> will make certain the correct parent CXL state is cached.
> 
> See question at comment below.
> 
> s/on behalf of the parent downstream device/for the parent bridge/
> s/possibilty/possibility/
> 

Ok

>> +++ b/drivers/pci/probe.c
>> @@ -1709,6 +1709,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>  		dev->is_thunderbolt = 1;
>>  }
>>  
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	struct pci_dev *parent;
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS_PORT);
>> +	if (dvsec) {
>> +		u16 cap;
>> +
>> +		pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_STATUS_OFFSET, &cap);
>> +
>> +		dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_CACHE_MASK, cap) ||
>> +			FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_STATUS_MEM_MASK, cap);
> 
> Wrap to fit in 80 columns like the rest of the file.
> 

Ok

> Not sure the "_MASK" and "_OFFSET" on the end of all these #defines is
> really needed.  Other items in pci_regs.h typically don't include
> them, and these names get really long.  
> 

These were moved over from local CXL header. As a result they are not 
consistent in the usage of offset and mask. Would you like for this to 
be made the same ? This would be to change all points where used.


>> +	}
>> +
>> +	if (!pci_is_pcie(dev) ||
>> +	    !(pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT ||
>> +	      pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM))
>> +		return;
> 
> Maybe could do the pci_is_pcie() check first, before the
> pci_find_dvsec_capability(), so we could avoid that search, e.g.,
> 

Good idea.

>   if (!pci_is_pcie(dev))
>     return;
> 
>   dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL, ...);
> 
>> +	/*
>> +	 * Update parent's CXL state because alternate protocol training
>> +	 * may have changed
> 
> What is the event that changes alternate protocol training?  The
> commit log says "once a device is created", but I don't know what that
> means in terms of hardware.
> 

There is potential an upstream device (switch) was hotpluged and in the 
case of the alt training retries may not be correctly cached in pci_dev::is_cxl.

>> +	 */
>> +	parent = pci_upstream_bridge(dev);
>> +	set_pcie_cxl(parent);
>> +}

Thanks for reviewing. 

Note, this is the wrong series (the last 2 patches in this series failed to send). I resent here:

https://lore.kernel.org/linux-cxl/20251104170305.4163840-1-terry.bowman@amd.com/

Regards,
Terry

