Return-Path: <linux-pci+bounces-41660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52910C6FFF2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 17:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D9FB502BA9
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61640327BF7;
	Wed, 19 Nov 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jkfwe1Pg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF22E8B66;
	Wed, 19 Nov 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568445; cv=fail; b=HYQlay5Y5/5vI5uBOpvdfrym7pRz0V0YZipUED2+KJDn9q5ljMCbJiwlNBBqsifwj65L4vS5tydYz/Sg1HvcxKn5umZCxF6o/oikZwMVw7rehkHEEMRSIhKymMOK7B8B8NJsV5S3kZpu0FRKmVCvYl3odegcOawbPb7RMQvPsYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568445; c=relaxed/simple;
	bh=iCs8p99wEJXrtBgCEQVNOBP2YKciBA/frkzHYRgZLSI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgvAYcx5/3eEpPnGIp8BGQqZbHihTtNewjT4IAKd7ZNIF6vV9qCShNjI9bw8XeAq+ApGl5gPdiO2FUm4/IMrZNQQEGY5d4NVa+8zDp9KRCT34MGJmvhUpTSGKOX1z+4iUpdtSYSgIV8VEN1GT/cc+ncEdPOCI62XTHXjuhtsMN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jkfwe1Pg; arc=fail smtp.client-ip=52.101.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFH1LNNi29xkFdufRDvxHi/v4aF6ISaYAniBCdwGV5x7WH9KLjDorlprGUHm1xRtN69maLXw0L7VM8g0PkOqEBXsdfjqQ2DZN39ekIJfqvLShfO9L4zTeDOkfI0EEAWlZna3RYA2vQz3c9sznhRPc27HEcV8mywrrAEejeYtqBkz8GrMm+Js55i4qNHj+8PdgopGgppP3yArUId9CwIWBjq9adHxWITDxyR/E9ko3gF1g5TFjtHHVwlAohJFQuzxC/5z6E/pkL62CSyjl84UdocvBLAt53w3/lQFWhctqZFKqw57DxYpwiwJnXREgKdExKh702lSTqxDRcrjEqd+MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqn9uCJvyau8QayOxExeyBse0Y/1/7nxbpn6XeRlkXk=;
 b=NUA3WUPqm3IV/Zw5K6cLMyK0IjPQz/P6WrvINdj5B6kNPaLpeerm9r10Bd1Agk99taRzH20De/2nf9tna1VEbO46JLcWrJd6jXfkbqWb3g9r5AJ1b3W/eGac3IHdUbPMPR97KHe6m+DUaMctPvtrZjCuqR/E8xflOft4RoWGqiuix5kzUbaROmP8t5FywGcQpImR4O8ErlLrUN7cxvs55UeJ68WBoUjfQ0U0dbuMI2dKpLUpAi54PNXFBZIF8nTpGWHXuEJMjCLZ17f61qSqt5fAR0aZmUac+9PQDTI5eWIe5CjEamYy+r5+gfgLTJ6fmRoRLDNHjBm1dB2nkbtncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqn9uCJvyau8QayOxExeyBse0Y/1/7nxbpn6XeRlkXk=;
 b=Jkfwe1PgMf4rjySdJJYwm4eWQimzEXm3ZerHPxk3Rg8CCEvr5fVY/sFU/oLpVUfcxvJEKa09qpNj7SHOoipi6vLuUH1JGbWtsdD5e/6P2vjnjtzoSolRiOHdQBcftmae4NTte2T0TmMm9kNFMBGubtSv2Co6hz/3nbqN74hriL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:07:20 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 16:07:20 +0000
Message-ID: <1bcf7e5f-da20-4f6c-979e-2c136215df11@amd.com>
Date: Wed, 19 Nov 2025 10:07:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 06/25] cxl: Move CXL driver's RCH error handling into
 core/ras_rch.c
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-7-terry.bowman@amd.com>
 <691d376d5a132_1a3751004d@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <691d376d5a132_1a3751004d@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::15) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 800af218-78c1-4384-d868-08de2785b7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFFUNGVWclJVMFdteVUxWVE2TGlZbHdEWDBud1l6UTc1dVdFL2ZQK1hBRG1V?=
 =?utf-8?B?OHRQMmhUNVlPVFBrQ2l3c1BsZnZBamIxeUZUa1ZMOGgvVWFqWFRZNzBjbDRL?=
 =?utf-8?B?eG9oaFU3NzVnZWxNSDgvdHZnVjFGV1dlNTB2a01aRWZYVFcrc2kyNlFlUTNF?=
 =?utf-8?B?QXFvck9jUlNBeG0zV3JoMmhRbnZkajBkMWl4cndSdmJIYy9oVUdza21NV2lF?=
 =?utf-8?B?TVVsVCs1L0VDUy8xSkovQURPNXFNOXl5T2VBOVpwcjJ2bjlYV09DSms0NU0y?=
 =?utf-8?B?Ukd4aUc1b1pCd2QzZ1k2cE9VbEY4UWNRTkhWV2poTUdCV3dobTR3ZXFGR0d4?=
 =?utf-8?B?UWRjeEpLZ0s5YTFqRWs5dkdCZHRBOUFZdVlQaFVDQTN3Z1MrbVdmNU9RL2ww?=
 =?utf-8?B?OC9lWXVjNTQ1K0NyRktFOFhKTE44dnhtdlFsM1NTQlBsMm40UU04K08yRHlE?=
 =?utf-8?B?V1cyaGpmYm9jVDhJMWhVR2xwajJaNHdtbEdkbUdELzRpZG5HRDlPVlZhSEtE?=
 =?utf-8?B?d2NaZHpxd01nYUNRdFJYVytDSDZlN2hTM1YrcVU1bHNkNjRzMUpiSDM0aGF0?=
 =?utf-8?B?NzN2KzFYdVMzc1MrVmZMUXVXNFNtNXJDbnBKaFFNUGlab2VLcDltb2xRYUoz?=
 =?utf-8?B?YzUzb2ZmS2JPSUFHbWpJbGNNUURvU3RrTlR1RnFlYXhBOU1UU0ZuRFlhYk5T?=
 =?utf-8?B?RW1ORkllcS9EMTh6NGxURDV3NGk2UTRIOHl1Y3VQSzZSWmJ4ZW01REszVGhE?=
 =?utf-8?B?VHdNZTZMSUlLQ1RveEdmYUR0SHpNQUcxYlEwVzVmb1o2dXFBVzJ0UUp4SUpU?=
 =?utf-8?B?NzJ2TkM0OUZ2K1ByQ1NmZVdRZ3J3QUh0dTN1SE1HNEFiYVRlQkFFYlVaS2k1?=
 =?utf-8?B?bit3bFM1Ujk5S2pwQjl6ZytDMHpBV0dxeEdJT21wOGRXeW5QbXBRbzU2Wk5p?=
 =?utf-8?B?Z00zQ3hROXUzL0hlN21rMHpXN09oSURGOWx2RmhJcHU2L0N2VDQrcnFKTWdk?=
 =?utf-8?B?TWRTUVVuQXJiVnlNYVBCOUdJTlh2bEMxNTdab2l0MXdUcXQ3ZHAxWjVpSTZB?=
 =?utf-8?B?NGh4ZDZnTWdxNFhYb3JKSnNXTFY4YW9EVGtoNGEra08wKzEwZHZSbEVpUU5i?=
 =?utf-8?B?a0xQTmJyVWdMUEM4bHVJZ2p3TVUyTWZzNk1wK05xbzJ0czA0SUNwZ0gvU3Fk?=
 =?utf-8?B?c1NJMlNScHFRZDJtTFhpa1RjdEltaExNUnpiT2JHL3Z0NTJwZ2Z2ZnhIVElL?=
 =?utf-8?B?SW1NTmFRM0dqSCtDK0JiT21sY2drRzVpM05QR3JYUUV4K2s4WERiNU9vVlBD?=
 =?utf-8?B?SGFGMzdSZXlpREhyMlNMUC8wSkNKUUtubXVtcG8xR3E5WVN3a0hNbjFMNjVI?=
 =?utf-8?B?VHR5S1RrRnF5N2c5MDRlSS9memt2c1ZVVVBHRG9VWnNLQW5HNC9XbVp5NitY?=
 =?utf-8?B?dk1PS1hkNk9XSUUybkMyc3VzY0hDbTVPOFQ3MlczbWN3WDVRRHRpNVcwVXJs?=
 =?utf-8?B?ai8vZkF1ZzU5VnFSUFN1LzRzdDNOOWFFUklhbURhaStHeldzY2NySnA2cVh2?=
 =?utf-8?B?KzFrWS90RnBLU0V6aE9GMElOOUpjbUNjZ2xxdkxUQVFNUGtiT255SUdSS3Fr?=
 =?utf-8?B?d2VpdTRIVnBJUFJMSHBpc0ZiR2pZcXZkQXVBdko1Y015V3RML2swamxsR3Bt?=
 =?utf-8?B?KzBXRlFmU0daenpUTWNwTExqaXZ6MjVpdFl0ckRITUlsYmhLUTN5Z25HdERx?=
 =?utf-8?B?NHQ1RFdtaVhEWWJNNEtRUkpGOFcwSUNQYkljNit2d2I3RVhsbG5ZQXlvaDRa?=
 =?utf-8?B?cURQWjRnT3Z4ZmR3UmErUDZ6LzhxVTh1dUxGbFAwcWFIRGNCVXI0Rmp5Mmgy?=
 =?utf-8?B?OUNyQ1FoSzU4SHJLeGlrS0RyTHBxbTFoTmxoTHV2RzgzN2prTmFYbFB0eGdy?=
 =?utf-8?B?bExrUHhQZUlZQzhmZS8rbXlDeldzNFZocjgxVklQVHlITWNnR2dYeXBzc1px?=
 =?utf-8?Q?sS8z9kr/J+6GQyzHpPitRDieYZEx/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEpVREJUcStqTENnVmRHekxyU0xMVk8wUnJCTUFCSmQrV1BCdkVUaXU0aUUz?=
 =?utf-8?B?MmtaQUtnU0V2ZEIwK1VUcm1xRmpkdDEvcEF6UW5xeXRaSkxKaXdaVDNLU2Ry?=
 =?utf-8?B?c3J6V0xiNkNWek1HWFZLVWttcjd6V1VoSFUyTTArSUtkNEhMNFM0UW15Tzd3?=
 =?utf-8?B?MWpkQ250Y204RG1yOVF2MUJUbkowUCt5WkVjaU5tSW1Bd3VuVjhGR2R6Tko5?=
 =?utf-8?B?RVduOHkwL09GK0xQMEJ4MWJTNHNEUHlDT2F5K2grcitMaGQ5ellEUlFCcnAy?=
 =?utf-8?B?OGkrQ0tiMTJLZHVrcnNNYzZPK0VnWXZmR0hwRkZPWnYxQ1plZ3BuWHZ2ZGI4?=
 =?utf-8?B?M2tHRUZxUHVxRkMyWXRGZExDSm9tMlRtT3AvbXNZZFFxVGFabEtUOEc1TytF?=
 =?utf-8?B?VE1FNnBWNmVOK1BsblRFTmZ4ZUcvc0tSbDZSR3dsb0hza1dXeENZQksxUE5W?=
 =?utf-8?B?Ry94VnJOdndYV2RCRVFPdnk2aTd1OFBHSWZIejRrN1pxU0hGaDFCelJ2cUFa?=
 =?utf-8?B?WFdWMVN6Q2RHUGRhYlI2aXA1WllDbkNxUDJSR3orNEdISjhUdzgzaFV3WEFy?=
 =?utf-8?B?Ullia1BrclV6bmwrcW5iOFZSOE4yVGcvb1VKNk9yUGlaQjFXODkvYjFGSUNz?=
 =?utf-8?B?c0Q5SlFqU0lTMm13cy9FY3dQMFhwRUpITjhKeFBhelAxakdsb3hSeXUxeDlR?=
 =?utf-8?B?YzdsKzlMWjlxTURtQmdPK2NBek9DT1lrUjhGcnp5Tm9LYmJvU3RYYzBLY3I1?=
 =?utf-8?B?cW54QVdEMUN2UXZraWRCOHRhb2xVcS9SdG9Ea0U0NDZVMjNlYktqQ20vMTJX?=
 =?utf-8?B?eUNjc1pyOTBkeDRIQWg4MjJMQWdrZ2NHSStqSXYzUjFlUC9wbG5QSDYzMkFs?=
 =?utf-8?B?enJuaFc1aGdqT1Q2Z2Z4RXFpZVh5VWlLd0pHSHd3YUVDNVQ4RXdVZDZVU3Nr?=
 =?utf-8?B?Y1NUTFZnd2JIVFZOT2ZKaDNPTmJpUm1EUUJYeUFvTzZzT0lUSGtHU1VPTnRD?=
 =?utf-8?B?aGdsaVFWMzZ0aTdCaVhrTUo3VENCd3YyTXkwL2M0RkJBZGxSYmJJRmtJNW5q?=
 =?utf-8?B?VEY4cGplWG00SzFTT2VYbks5RWJBSGIzMVhpOGhIQjZQZ2dOUW43VTQvT2lv?=
 =?utf-8?B?MHBSR0lvVXlWQThNYitwTnhoUFBXQXZxK1RuNXl6WTVHNmRRMWVLdTBYM0hi?=
 =?utf-8?B?YU5OMkxEWERkMzB5Skc4WWVRWGZoLzRnY29mbkpyazlrekZEVmxhVDJwRTN1?=
 =?utf-8?B?eFQwazNJQ3RQSGNSUGcxcmhHVGRXM29TeGczdjR0cmUzdXdqOHhSMDEzajhQ?=
 =?utf-8?B?WGNyQ2RSZVp5dncrZEMySS9KMWF3cEkyZ3hhQmJLV25wVk9FN0txaTFwRW1q?=
 =?utf-8?B?K1BkSW8vS1dOaEh1ZWMxNzlCeGZMS05JL1pGcWdZUFA3d1J1d3NsQ2JRS1NN?=
 =?utf-8?B?U1o4N1QwUDRFS2I5RmM1M0puS1dQY2sxU0lYTWowaEVDTGhPSS9Lc3k5Y0JJ?=
 =?utf-8?B?YW45MkVXMUh5VWVKOWVYeHFZS3VOTExRaXgxNDhnK1hlSlZWbE80dnBzeXJp?=
 =?utf-8?B?dTNZdnM0eEpiaks3TnY4SlBUay9BVTZEU1BVd3VTY1IrTEZ6LzZNUUtucHB4?=
 =?utf-8?B?Q002T3hNS0tOUGoyQmZIcW5KUk1CR1c0Ujg1ZlN5OGpXaUhFWEN3dGxEcExI?=
 =?utf-8?B?TU1SUXl6aU1Id0lFZzZwR3IrOUZwVXBGSkxVbGxlejUzdzJEY1JCQ096VVkv?=
 =?utf-8?B?VjNLZnZ4Ynd6cU13Y0MwRHY3Mm9LL1MwSk44MkEyVGF3em1hZUlHNWFhd3hz?=
 =?utf-8?B?czViZEdmaHZkMW4xR2hSZFR4VUZ2eWMyNFpEUHY4bXRieUtIeC9LSDBJcThB?=
 =?utf-8?B?STlia2dsOVppMndya245OWFKdCtva3JZUnEzYVE0SlNYcm94cVVsTzVWcGpm?=
 =?utf-8?B?VmFsM2tRTTlaVmRvOWZ4T0R4bit5QVBRVjE5SHY5cnc4bFZoU1kwSlAzV1JU?=
 =?utf-8?B?L0tMT2JsNGk2a3JlRi9jcFZOSjdBWEpEK3JzNkw0Z1VzeUZIdWJNQkpSOGQ3?=
 =?utf-8?B?ZVJGSHV1MklSWUJPTnpuN2FKZDJ5eVdHWVh0M2JIYUorOXorSS91MFBDR01N?=
 =?utf-8?Q?ZdOrRbDXuZPwSdxHN25l71Ttp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 800af218-78c1-4384-d868-08de2785b7d1
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:07:20.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cbb+4z0R0MLpEBrNuiHxkG9lLELaPgnjrp52EXMKwMzJSLGqnZ0oFTE88pupxGaOiNKt80E+HwB3Qs+DpvrzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770



On 11/18/2025 9:20 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
>> from the CXL Virtual Hierarchy (VH) handling. This is because of the
>> differences in the RCH and VH topologies. Improve the maintainability and
>> add ability to enable/disable RCH handling.
>>
>> Move and combine the RCH handling code into a single block conditionally
>> compiled with the CONFIG_CXL_RCH_RAS kernel config.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>
>> ---
>>
>> Changes in v12->v13:
>> - None
>>
>> Changes v11->v12:
>> - Moved CXL_RCH_RAS Kconfig definition here from following commit.
>>
>> Changes v10->v11:
>> - New patch
>> ---
>>  drivers/cxl/Kconfig        |   7 +++
>>  drivers/cxl/core/Makefile  |   1 +
>>  drivers/cxl/core/core.h    |   5 +-
>>  drivers/cxl/core/pci.c     | 115 -----------------------------------
>>  drivers/cxl/core/ras_rch.c | 120 +++++++++++++++++++++++++++++++++++++
>>  tools/testing/cxl/Kbuild   |   1 +
>>  6 files changed, 132 insertions(+), 117 deletions(-)
>>  create mode 100644 drivers/cxl/core/ras_rch.c
>>
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 217888992c88..ffe6ad981434 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -237,4 +237,11 @@ config CXL_RAS
>>  	def_bool y
>>  	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
>>  
>> +config CXL_RCH_RAS
>> +	bool "CXL: Restricted CXL Host (RCH) protocol error handling"
>> +	def_bool n
> "n" is already the default... but I think this optionality should be
> scrapped.

Ok
>> +	depends on CXL_RAS
>> +	help
>> +	  RAS support for Restricted CXL Host (RCH) defined in CXL1.1.
> I can not imagine an end user or distro ever knowing that they need to
> disable or enable this option. What is the motivation for making this
> support optional going forward and defaulting RCH error handling off
> after all this time?
>
> ...does it get in the way of VH error handling?
>
> Otherwise the decluttering of adding a ras_rch.c file looks ok on its
> own.
No, it does not get in the way of VH. I wasn't certain which to use, 'y' or 'n'. 
I will remove the option and use default as you mentioned.

Terry

