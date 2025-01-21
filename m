Return-Path: <linux-pci+bounces-20205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE1A1832F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B50F188399F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45EA1F4E42;
	Tue, 21 Jan 2025 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dFtKQlWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1721E9B38;
	Tue, 21 Jan 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737481613; cv=fail; b=JHO9nvD7PRR1DlePVMrRDuP5u42SUGqO+HJrCBEGmwCbjZRDr0A4PeKYkHbi+kWOUh06ngPiHZZQWn/Q/3xR/He79GehiaNC1eYMGZh9Tdo2YKyGgiUhvI+D9CcHd/59/KAJ8JXrQXPZb1OcSzvgns/1UBU2TXT9vL4u9FnYkkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737481613; c=relaxed/simple;
	bh=qFAzJI8mHBZsUq9WOr+vM/fto4hMVwd94zaEPi/kg4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lOxMKKXsa1wutNY/jwCf4nS0QzOQTjgY/O8haNKQUrfanjlV3tEmOHQ10sCguw99z2aw5JUGtFuo4k3wpMmIvkCIn4/gYJGmxytZlrBzw2R+ymRec5TxPOVs5LRt25OkRNIAgk9x8rm2yVK8SUsYMwzEc1dqT8mdw2mgpkTwbPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dFtKQlWz; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6V5cNS/gVe8RL+/JAZZyQJlSldR723EwwAXI9vfwmOk/vr8e0SKcVt6PG+F3y2ieJC2nAJed/gIs73Wqq455yqBxL9oetPybfhe7iaBDlc3IzDmmomuODKHHWixJ5Z9UJEnESggKe8Ic2QOc4QwgtYClKoLRvIYx4DcSKeV6nCKCRSDWPWk7P3gQDIbqI5A2JuZcGru4Lfb1f0B5b0GSaGTGUXKxI7sbfASWlLcVQ/R+P3/DPn3GY5prNl/4HQj5BDKzYA5BUhX09VWgNIMzNJ5bJpcDph/h2sk3a//ZBD9Lj6+7+IAEW50C7h7McGR/6oTbMCa7vB565fueQdgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRk7+7TndtlRkOIdhvP1b2qJxLT/IfcbBO8sv27kcC4=;
 b=PQw8nAHdlhY8aCshE1yUts09vNbZ/h/bGeVA21jwyiE3ILg/sAuHs3VUURt2KOaMmYSmcYcXakm9bGwHHkpJiYTbpHzs2dHBucXDJJ2T/08H903Szz1fnIysD7qRnDNUdBbti8Zpsx5FI11xL5mGxaahHi+DFcnjBL+RDXIbPBPJoNIRNIS/eQ/KpPob62YW2X80SwqDFjxHm49mqjGi/R+7Oh/NO0io41XMlrRMQD2TmNKZol5c72jZ8scAP8XN3chFiIWPfKS5ZzIWINznm8IGar3jIUVwcWMaAUdFrx4k7yITbKP/ejwN7bVzBj0WzvFJFHRt8x0P0wTQxutrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRk7+7TndtlRkOIdhvP1b2qJxLT/IfcbBO8sv27kcC4=;
 b=dFtKQlWzZbrWIQmgUp/prr+ASN0TgpK3jMlSQBRmIrdjV3RWe5+cdejqabsPT5SS8DzaRCm7l0kLbS8dOjh6J/bHwiMUgPzYUsnHQtYSGrNUHAS1X4AkPpKLwEGW3AuqZ/+KQJEytLCH7WU2Up6TQGSYgooOSlnSCqyD5WGBhHS4l3NwgQ/b0dSrwbGG4ntK/IwJE52qmcOUUh+hzGC7LYyPpkoarQWg53uVMjtnA8hS2fjr3fTVJfyEewmRUbVtQYbvPk9KIsqoDA7A7F8/Hw/mujKNcP5PzynUWgz9c+dQFLVPvRdcJR1v0UFthDAgIffbmiaQTqRq5+9ywmMKIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 17:46:49 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 17:46:49 +0000
Message-ID: <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>
Date: Tue, 21 Jan 2025 17:46:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
To: Hans Zhang <18255117159@163.com>, manivannan.sadhasivam@linaro.org
Cc: kw@linux.com, kishon@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 Niklas Cassel <cassel@kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250109094556.1724663-3-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::33) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: d50d0924-e925-4af6-cf91-08dd3a4394aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVlFNHc1VTdEZHg5ZHNZNzlaTytlL0FUQ0NtN1Y1bk5EcHdLRENkazZaZ0I0?=
 =?utf-8?B?eXhOTHArTVBFcGJjd2xTbDZFaURTNjBTU3NTRGl6K0lrZ1BhaGlDempDOEJN?=
 =?utf-8?B?emtZZmJlSWgrcmxHR2ZXdmpSbEp0dFRIVE8wRi83d2RrWExoN3dkSzNmN2c0?=
 =?utf-8?B?Z04xc3U1dXBHbWd3ZU84UDhlWnBZM1NoemVzcWdOaUZjTFZFNUZmUzZxb1N0?=
 =?utf-8?B?Z0doWk40K0ROd2xHQXpYQW9rU2FCRWlBVFZDeXNxd0FNeHVYOEU1SEdxYmZi?=
 =?utf-8?B?R0svRlNBam8zbEZSMk9UNjhiQUYyRnU2Q3FYMkZiaUNXY0l3dmt3NDJqNjJR?=
 =?utf-8?B?eFZ4VE5RN21XTHRYQU0xaEIzRGxXR2dYZWkybGZLeTFVUFNnclUyOFVHRnVw?=
 =?utf-8?B?YlhQSTlaSThxc1BCNlEwOWlUcDBaa0pJdytXUGFsbzkzVzVPdUthazIxakNF?=
 =?utf-8?B?NzdFN0d4VWg4VHRNdWE1bklZQmVDQUNabEhFSjJCL09yejBKSXA4SG5TZ0Mx?=
 =?utf-8?B?VG1EczBaWFVQZm5VcklUYjlPR3lYMkVxeCtTMjB3Nk50YmhXTy9HaXJLQUJW?=
 =?utf-8?B?dEdhcEhhdmgxOWpzUUl2dnpSTStOKytNeGNHeHB5cUkydGM3US82Y0NMZVQx?=
 =?utf-8?B?WHhnM3JSMUE4Sk51T2xoMlVJdVVPVGdoQXo5aXAvS2ROSHJQd1RhZU16RXd2?=
 =?utf-8?B?cDJ3amZTcWQ4dWFyWUtXdEhMR2t3VnphZURXZk9KQy9TOEFGZmRzZkkzS1FT?=
 =?utf-8?B?RVNyRHJSVzQvT1Y1MDByaG0vcnRMUGp3VjlDd0ltNFhOcWtwaDkzTG9qYVI3?=
 =?utf-8?B?ODFZNWpDeVJhWUtSK3ovVDUxNGhlUzNpeWZJSkVleGlpZGdLbG9tV1pZMVlZ?=
 =?utf-8?B?dVhSQ2VTa3JtU1NENG13RWlISG8yZWZZS3J5LzBJZEtJbWVZRmpLSHk5Qmpm?=
 =?utf-8?B?cWlRZ3BWcGhOakloQkNIdnQ5QzdaekRQeXRqQ1dnTEFsRlpNK1BLK1FZNGpO?=
 =?utf-8?B?VmJxRy9yWEtWN2hiVU4xRGNWdXFLc3hIa2dFRm5XcG5wVXJEcmNtVGJGNmFr?=
 =?utf-8?B?UjVmaktBajRmYVpoLzFXWlIwVFpBUnorck5RMnF6SlhtaXhPZktnMXV1TW0r?=
 =?utf-8?B?bXVLQkxiOGJkdWRxK29UZGlvZStnaFFDR0N6Q2FIWkI0N0hDTEJWS3R5eHQw?=
 =?utf-8?B?N3RZOG16ZmZuQ1ZTQkNncmVjOXpkbW02VWpLUnFpSDJkZk8xQmhsMjl4UHFB?=
 =?utf-8?B?WVg1V1hISXFmdklXK2kzUFFyeXZKTEh0bkFLRDNBLzNtVTg1SG4vSWVLWXpD?=
 =?utf-8?B?L3VSVHluU0t0UkM3RDgxaTJXMXFXOUlZaFNtTTJ4bEx5T0w2eml2UnJYRmxv?=
 =?utf-8?B?RWhtck92UmNsVHdYSDN4NGVCT2pYUEZlY3ZURXNWRGxXblpmU1U5bG84T0w2?=
 =?utf-8?B?c0dNSXI0ZnhZU1Q3N0xBaTVqVllxVlRvWlFONmFBcVpOKytUa1NiYmFZK2FE?=
 =?utf-8?B?WXF0enRHU1E1S0ZFeHRlQ1l0TGJXOHU0YWJtcHE0NEFyZTR3KzI5WVVoR28y?=
 =?utf-8?B?YmN2ZmxSNTVoNmlwNGdLaSswN29Fc1NKdDIxZmZnYU5ndkdxL1hmQ25hOFRq?=
 =?utf-8?B?UFM0TFpPVFJDQ1ZaUTFQWHdRN0xWYkVyVFpydlNJSlBFTEY1WW9DK0ZUNlVW?=
 =?utf-8?B?S203VnVIUDVpZVZ1UmdBNDlWUld1KzZCbVV4MUs0Zy84ZzBXN251cERsWXdC?=
 =?utf-8?B?M2cwcjBxbnQ3T1haUW5Fc1pXY0trcVlLbnRwcU83K25uZnVORWZ0YmtvRU5H?=
 =?utf-8?B?Y0NrYlg3SmJZd2lGUytjTGxpN2dXNkl6Zkc2cjEraVphWFFOMEJkUDI2SG5i?=
 =?utf-8?Q?gE2OUgjoxkg3c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTBza1hPVSt4elVjb2QwMzNuK1NiVjQxNW1oaGY5RzUxRFMyaEJrL3owVTRy?=
 =?utf-8?B?UERpYU9ZVGZRVjhDUHl0Zm1JZE1XZ2YvdUNWMlVDdDR5S1lua1A0RVN4K1VY?=
 =?utf-8?B?enpmUGlUeUpRUERZN1FMOHZKVGlBRVFMaTZ5bkQ0bmlIR2JSak5lYjQ3NWlw?=
 =?utf-8?B?cXo5RGdOenZPRFV6YnhJMlNXQ1dQZE9ZOE5hQUpPaEYyd3dRU1hNSU5MN21m?=
 =?utf-8?B?RGwxYUNaUzNmUmpibUgrcEJKS1JQUXZidFYvU0xJNzJpNFBSUjB6N0FxUjNM?=
 =?utf-8?B?c0tlRnBoUjdNMytqeC90aW83a2ZPbXZWTFh2YVdaYS9sbTByWnpRWFQvZmtq?=
 =?utf-8?B?Q21hcFlZZ3IweGFZczk5WGZzQnQra0VHaFIwc0ZwR2VWYjIvMzcyRmRzYVc0?=
 =?utf-8?B?NlV1TFAzcmRnVDc5WDdXY0xFSjNvUFpyaEhBVFg3R25rMkFTaEZzSWtXZEZr?=
 =?utf-8?B?RUdjY3lROVJXbkNHWjJ2WDNodDh2TjE5alhuUEV3amUrTFdtZkZGb1kyVUwx?=
 =?utf-8?B?Ymp6V3E2cVpnbXVnNWRqemNDZUpET3F1WDVKWWNDM1VVTkVRMTRRZlpRR1lP?=
 =?utf-8?B?a3Z4Vkk0dkErZ1hJTGZ1UjBWNlUrS1Nka2hqUG5lZ3JkelpzZ1A4V0VFcFQw?=
 =?utf-8?B?UjhyaThjaUxpZUhjU05JNHVwVE5sbXVreGUvajlYeVNkRU1Qb3VIRXY2ZHRl?=
 =?utf-8?B?R2wwMEE0Sm0xUk0xTFR1NTdDa2YyYkp4aVY4RHd3MCtFYTZuSEVuUXdiTm9J?=
 =?utf-8?B?K0xCRkFDVjRnWElOcUtLU2RaMWN0bTBHVWZGWisyT3BwREhQVkkzRFBLUWh2?=
 =?utf-8?B?MEU1cHl3S0J0RGNwRXo4SGtvaVhMU2JrM1JFdEZmcUJwMHNMY01hekVySGNZ?=
 =?utf-8?B?MnVWdFhxTGRaa2R3Z0M3U1pPZEtKcVBWKzFCcHVzM1lzM3E3VlozeTNNeHVR?=
 =?utf-8?B?V2hHMTBBSGVaVW9XcnN2Z293L0x6THBSL2drc2pCd0diNTl6YTBMV2puUU0r?=
 =?utf-8?B?VTdYTnhaUlRDUWhla2ZDaGUzSm9EcEpEOFEwMm5DUytNajZTd01jOEV3T21M?=
 =?utf-8?B?cVk1eUlQVzgzRXNuTWRmTCszNVFkbW9sTndNZTA2TDJnS3cxaldHaC90djMw?=
 =?utf-8?B?TGpSeDllMWM0OGhCcmw1c08yVEo2enp2OXZOTWhmeXh2WTQzclV5ODVOQld6?=
 =?utf-8?B?VFEvYU5MdVA4K0ttYmdyc1lxdFVtL1VONDNmWWRiLzBVK2pnSG9odmRRR1Jv?=
 =?utf-8?B?V3hiZTZ2Zm5IRjZ4clhKcTdZbW4wRXlEcW4xTCtFUFE1L1Zna2xPeFhCYXlZ?=
 =?utf-8?B?YS8wdUxLQ2lwS0xHTGpQb0NJcXVEdzByUjZ1ODZHUys4cEV3Mkh5UFY5VS82?=
 =?utf-8?B?em1MNUpkdTdwVjdvQ1U0R0draVcrbk4rWllqZVVzOHZoUXYvMEZ4SkNNVzBQ?=
 =?utf-8?B?VlQrY2JBSmhKR0xvcS9mYmFabjh3clFXNFZsUnRsRGZSdE93K3JrWE9rZ0tX?=
 =?utf-8?B?aWFwb05CRVR5RCt0Uzc4Ty9kZ1B4c3IzYjdiVWp5ZVJmSnNMV3hMN3ZwOXVj?=
 =?utf-8?B?SFFkT3BPZFU2S3JjeEgvdVlRQWo3RXZ6TEloY2lFSUVFWTJqWkFzS3pkRG9H?=
 =?utf-8?B?T2FsUUFDSEdZSEZkSVpUMWRLM0xhRGtqVXFRK0RqVFErekJVa3ZxZVZ0clZm?=
 =?utf-8?B?anUvWlc3Wk5FQXptUm9WWnNSbFZmckp5T0NRdVJEOHZLSkFpNmFZQ1VoZHox?=
 =?utf-8?B?dTZ3SnNJbm9rOTdiWW9aRk9uWElXc2RrQ1BLMHFNU1Rkd1hOTWRlUHBSMXJZ?=
 =?utf-8?B?bzlWSGVJbTdleXJ2a3NXZlY1UFExMms5SVlic0JvSnAwOXlLKythUk5yN0M0?=
 =?utf-8?B?ZFhpWklpWVorcmRoVW4rRXpSQ3dvQ2VoSytXL0c5REp6RXdlNWJLS2l2QkJM?=
 =?utf-8?B?OFg0Yk0rOEJHYmt3d1dJTmwzaTUrc2w5UURDbUh6Q3pyaStXWmkzY3dSZStj?=
 =?utf-8?B?WDR1aUMwbGN6YlVLeEVNdUlkeTFsUWYvWSttdVR3TlNGMTB0YmxVbkdqNGdQ?=
 =?utf-8?B?N1ZUK011eXVDYW1WN1JwR0w2cFhqV1g2b3NqdHZGNUV0UklMeER1S0RTbTVw?=
 =?utf-8?B?L2RZaEV4anNZa2ZqdEM2WjdEMHVaMzRKakkvZnNqNWVSQ2lWdHJVTlNwZHZU?=
 =?utf-8?Q?nPLbUNaiTEQinQZeeECN7rYThaG6oR216cObl1T89vO1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50d0924-e925-4af6-cf91-08dd3a4394aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 17:46:49.0677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQQ/FIhqyVboRmYB450b46hWz3n64p1tmtBdKZdb2osZK4GjttAPi/1c/H4LMqR0FG5TfuB6AAJWSiVg7tXfog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005

Hi Hans,

On 09/01/2025 09:45, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> 
> Change the data type of bar_size from integer to resource_size_t, to fix
> the above issue.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v10:
> https://lore.kernel.org/linux-pci/20250108080951.1700230-3-18255117159@163.com/
> 
> - Replace do_div with the div_u64 API.
> 
> Changes since v8-v9:
> https://lore.kernel.org/linux-pci/20250104151652.1652181-1-18255117159@163.com/
> 
> - Split the patch.
> 
> Changes since v4-v7:
> https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
> 
> - Fix 32-bit OS warnings and errors.
> - Fix undefined reference to `__udivmoddi4`
> 
> Changes since v3:
> https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
> 
> - The patch subject were modified.
> 
> Changes since v2:
> https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/
> 
> - Fix "changes" part goes below the --- line
> - The patch commit message were modified.
> 
> Changes since v1:
> https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
> 
> - The patch subject and commit message were modified.
> ---
>   drivers/misc/pci_endpoint_test.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index f78c7540c52c..0f6291801078 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>   				  enum pci_barno barno)
>   {
> -	int j, bar_size, buf_size, iters;
> +	int j, buf_size, iters;
>   	void *write_buf __free(kfree) = NULL;
>   	void *read_buf __free(kfree) = NULL;
>   	struct pci_dev *pdev = test->pdev;
> +	resource_size_t bar_size;
>   
>   	if (!test->bar[barno])
>   		return false;
> @@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>   	if (!read_buf)
>   		return false;
>   
> -	iters = bar_size / buf_size;
> +	iters = div_u64(bar_size, buf_size);
>   	for (j = 0; j < iters; j++)
>   		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>   						 write_buf, read_buf, buf_size))


This change breaks building the kernel with GCC v7 and I see ...

ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko] 
undefined!
ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko] 
undefined!

I know that this is an old GCC version, but this is a farm builder and 
the kernel still indicates that GCC v5.1 is still supported [0].

Jon

[0] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/process/changes.rst

-- 
nvpublic


