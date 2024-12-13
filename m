Return-Path: <linux-pci+bounces-18387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E359F105C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C151166B45
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE401E1020;
	Fri, 13 Dec 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BTsyh3ZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C18F5E;
	Fri, 13 Dec 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102450; cv=fail; b=RAUndBt7SVbejr/MNn8ZmBZpfe3vSheU8Y/jMbQR+YAmUYs3cwe2JvaWzsvTyRKUsCgV065ucz6BaYBVdpcT7R1GCJ+nb5ZXc/5GYlrK+lSqXRrsjWkmqlMdqE/ROBU2sWXpu3Rc6gwEeSqI/6807HF3vL5SR4Ls9Yi9xjIecPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102450; c=relaxed/simple;
	bh=cpq4LrAv2eUKZoSS8suTqFTZA6X7Zf3RzeGlsh3StQ8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uD55j58fV0uK6p5rs2eMmQcAzQlFJjACaKxt0X7VX0oDHDD/kABXg33l9olnlOP0ag9D05gPTTRbWk875BCzoO2HpumJ+Xbhs/aHCLoUXb+PPy3ZHRF46dK5BaR0eydmWwQuSXd1SCVIfIcUGLhn5vTLgi5eXQER6BcwxYo9uzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BTsyh3ZY; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZcd+lX3wExjd8XWmNo8tohtVm6MR+jkQ4Jv7UUjUCsdmYHjqJdDj4V9HhzgzUBHuLthooioi760C3ZmG+4WaKRFuKNg5CpVVMkK0fISZHDzlTRze/T5x0REbCGiNN4WHneXEODH1Sn75HVtJ1fKcTapEw09VyGZoefjUToaV9ux4v00SkLD6yzylkGExNdYweWZ8ZCjsyhHY8GIjIMaR+j2+tDsBimC8BitOM7oAR3ZFVnGcm0rND0sZedPA+M/MV5w9BfVUIBO2wG0JSpAg/Rv6ShDAm8K6uvHk10zAHbQBta7dtKdIh2XXFzvr/rFH6dwhYdIdBpEnR3QGNP9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmNieMvvI2Hu1lY6GxNGywrq3j2eHdNbvXjGbzsJEw8=;
 b=DbQmb+RhSATlZn8h2ygum93Y4FLWCO2moflJBXPiocolJA/r64mH5OsSMMTVMkJuuC4ad7uljQIS2fKVJIPzPOedeSYU5GBS1+eDy2pUT7gVVJtuQv+y1WwEHXFu2y2p8wxwpYiFV+oYowr2FuwrU9+jJL3ofDloRDYRjzOkua3sro1UD4VEOXcqhXfuy+FgV9TzG8Bym7DKJYz42CsrOneW+QTIUSunyf9WvrsIckTnin8e4935VndZjs7/EKyMxeHzz0PwuAWwcy3+7Bg/YT+paw40sbrUnjjfyDn2bWb9Mu8IGXTMMwRWcUgpryJNqkvdBzw+7swPV3zqJQLfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmNieMvvI2Hu1lY6GxNGywrq3j2eHdNbvXjGbzsJEw8=;
 b=BTsyh3ZYu2k2G+NnKtnuoSGmlaoFOYb1vOlwA7/r1aKExxzI3s6djRV2EfDuMWuLrTBf5uxKW/EcX1zF2Rbt1nX+QxO9RhWT+nODWHlyBKD2ViL+T8KsHEuMC5FEcOF/lkZsZ3MVRJwoyBVQntm0mW6mz0JaBz6cCi7kAVjN3aY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6224.namprd12.prod.outlook.com (2603:10b6:208:3c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:07:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 15:07:23 +0000
Message-ID: <d37e6345-30e9-4765-b2be-51e139738c33@amd.com>
Date: Fri, 13 Dec 2024 09:07:18 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] PCI/AER: Add CXL PCIe Port Uncorrectable Error
 recovery in AER service driver
To: Alejandro Lucero Palau <alucerop@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-8-terry.bowman@amd.com>
 <58b9bcce-ac76-e0d0-1a8d-a8d8c0b20b43@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <58b9bcce-ac76-e0d0-1a8d-a8d8c0b20b43@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1a7ec1-70a3-4157-451c-08dd1b87d8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXRtdWdCNWpDOXNNbitoeHZrTkpkK3JhZ1dFL0JCZTVvRjFtYkpVUFZVTXVY?=
 =?utf-8?B?SmpRZVpCblQ3UmI5eFJzNFVBNzZZNUl3cmNGSXNsczlNZUV3cTNRZERWT29p?=
 =?utf-8?B?TTZpbnZIbFdDOXJCcGxiVnRlMlVzY1ltbG1tN3lSRmZEQ0U5b2EyU2lKNm1S?=
 =?utf-8?B?WHloQUk3dHVBaytxSHRsblgwM3ErVTk4K3RVaTNUNTdQUlJCR1B2eHB0MWlY?=
 =?utf-8?B?UVU5czI3UWRKd2twL1A4Vm1Td2toTnJob1hKSEczbFFoQlRjR3M4bE16VEQw?=
 =?utf-8?B?SVRlZldQRmlvblVyRUJHUG9CWWFzU0hXRENCdXJhcHdSUG5ndENGUFo2aEw1?=
 =?utf-8?B?MEVzcXhIdWl3enFMcmN5YnhCRjg4VjFMVmR3SEw0eXNIQ2Z6ZkRvU0FhN1Vr?=
 =?utf-8?B?ckZ2cFB1cTJUd1lxcHlyUTNkMXNicENkMlF6eXo0endVaFVmVE94SG1QZGdk?=
 =?utf-8?B?ckdjN0pIOUNXZ3dmYnRrSXliNDZvZjYydng4WU9SNFB4dC9wdFhKaFdCZDJ0?=
 =?utf-8?B?S01nYmpEeUJHTmhBMjc5c1NFWGhMUDZORzJ1Wk1lUXRDVmxlais0S3hhd2xn?=
 =?utf-8?B?NG54bk4zdlprR1JqOHZWNktYSVMvVkdEaDJGakdwck94K1ZWeXorbytYTWZz?=
 =?utf-8?B?dGdweUdnMmJCN3FvQ2tnemR6eXBWYUpveFBYZVRiaDN5WlNYMVZTUWREZFdx?=
 =?utf-8?B?LzllZmJUMmoyY2xIVXgyaVFDazdxMGpROEZRRXY5VUIrSm5nb2dFVHI5bmI5?=
 =?utf-8?B?WFVGZUNIWENiN3BpMXpmQ1hoSmhkSEs3VGVGWnU1VW9CUytLQWQ5ZDU1ZjJw?=
 =?utf-8?B?Q29uZ1E3NFNhNCtYZ0R0M09VMjl5WnRJd3IrakFBbHZiWlArYzNIYmI0c1Jz?=
 =?utf-8?B?UGpLRk1EMUxpTXg4c3Q4OEFaTTNUdVg3RzNUbDZVaWs3ZjJRYXNqNmNPRUU2?=
 =?utf-8?B?OFQ0RnJyNW40MmNVc0FobHRzOGVqNVExY2JlblhnOGRwWHorMWVrQ1N2bUhD?=
 =?utf-8?B?U1BLOFBzQWlqaWpDNm9TK2p6aXRjOHBGbzhHSmhZV0h4YVVmZ09MQ01BVnlS?=
 =?utf-8?B?TE8zZFBWSi91ZmY1L1ZMM1BjODdSaHBqNkliTVhsVHBrcnllZEpKZ1RmS1lV?=
 =?utf-8?B?MmtIQ1JnYjJLQ0Q3YTdiRUFiMmVRWmliT2dTbHV0R1hna2IramdkNkFHbWxp?=
 =?utf-8?B?MWRsUlZSSHdCT2ZBcHdjQ2JiUElLdHFlK2pvQURzQ09QWHgraXVEVGlDcCtL?=
 =?utf-8?B?dnZWRWNqQXdRaFA0a1ZYOUlMcGtEWUovRWc5RHdUbThybHFrbzFJQUFiTWE5?=
 =?utf-8?B?TmVWWjYvZmUzb1VNK2xqUUhJdzFFbVIwL0hKZzRBbkJubHdrYVNSYnVHc2JH?=
 =?utf-8?B?eE1Za3g1SEwvbVJQVEdXa01FMng0Zm1QRkpMZVBKeFFRd0tyY1dtcTY1b2ZE?=
 =?utf-8?B?VnRLSHdSclhsZkZHQmQ3S2kzekd6aXlqWW5RYWtKOHNOdjRBMHh5YjBGeUQy?=
 =?utf-8?B?WnFvNnc3TDM3MTFxcUdtUXA2Tkd3RFBVZ3B4WlpEdkI1blp2S3hWa3FFUXl6?=
 =?utf-8?B?NnpnNGdROXArSnpPZzFzTE1uWDUzU0g4U20vV2UvVXlVZVlnQVJ4MGhkWmln?=
 =?utf-8?B?YWVjc2NaU0lQaXM2SW1QUDVRQjlHQlRGbTd1QkhrWU9HeWdkZ3Noa0xVMDJy?=
 =?utf-8?B?bDdxd3BJN1h3OU5Wb1diZGFJZ3k1a2R1MTZlZS9mUmJVU1Z0Q09OVkt3NjJt?=
 =?utf-8?B?SnFIeXFZUHNRdDZwcHJwNlVBZ2Nwd0hKenlLL2ZhVE4zZEtQS1ZIT0tVN0hk?=
 =?utf-8?B?ZE1NRklURXcvUVl3MlhQUFdFZzB1MzZBY0NzWXViN2NVaVlpK2tDektGQk94?=
 =?utf-8?B?RFlrZnhOTXFiNXN0NVBGblhrMzlHZFVielZ5dURJNWcvcXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVg1c3AyVlN5cUVWTkFpTUsxNkIwYkJTc3hpQjMwV0hpUTJnTUN3N3pHSHk5?=
 =?utf-8?B?U1dxMDAvcldOZjArVStIMEZxNVFVYWJXNlliYjhlTXB5M3Y5TVByNVUzSU5n?=
 =?utf-8?B?MnEyR2RDdG1JbVltR1NBeUk2QUhKSDlXcWtkVlNIcHNaR0dIbDQzbmcyanpW?=
 =?utf-8?B?U3J4cXFMSEhMYmhhdUFvaCs3L0s5czZWa3pBTkx3Z25QbFpJVzFwWGNwalRl?=
 =?utf-8?B?WlNYeHQ4bkxHU3VOOTJMdE55ZDFpUVpOcUpSMzZBN2J3cGpZUE1qWTcvY040?=
 =?utf-8?B?SGlUVzZGTVFCUWFNdG4vT053aE0vQ3JDNGRIT3ZYNnFVeUFCMmpDQkhhVHNM?=
 =?utf-8?B?aGIwRmlFdXF4MlpqcWNzSWtQUlR5c2szditsVkFJeXBYVG1CUjIyTm9zTmFY?=
 =?utf-8?B?SE15UVk3c2xJWE1WZWlPQUJ5bFlIQVY0eFRRSHIzNjU1cnZIRmtvSU02THlP?=
 =?utf-8?B?UUtuZmlMSmE1VHZGK3lXMVZ0V0lBdzY1OUhoOS9IUkl5QXNCelg1S0tzYWt6?=
 =?utf-8?B?L1ZyRVVQanE2VWhTMFBaYkN1OGZ0M2M2UWN1SXc2dlVpWnFscS9QaFB5aGRh?=
 =?utf-8?B?bWF4OXJaUEVxU0JsclkzTDJyQWRXRXNTZ29qVHNzVUVPZVFUMFNtU1M2ZzZ2?=
 =?utf-8?B?TTUvaWp0ZDVpYW8zc29FK3JxV2dWbGo4V0I0cGRPaFJESW9kZkQzamc1dVEx?=
 =?utf-8?B?NTZqZHlEeDloUUZ3UWRYeXM4Q0FRalM4bDJ4alpvUzNIZEJUKzg3MzQrcCtK?=
 =?utf-8?B?RXRRU1MvNm1YaTFFalh2OGZJUVRnU1RiT2lXNzRnUTk5UnoyeDY3d2N0a05a?=
 =?utf-8?B?bnhMa2xrWDNLSVZSOUE2OWpVSlZDYUFrYWdoQnRnWWxNZGcrNXJtWnVmc2tT?=
 =?utf-8?B?a1BiMTNUak8rSTlmREpwYzdZQTVaMWdQVFFVMURxL2JmN2o2K2RkcTJFUVdN?=
 =?utf-8?B?VkJQSmttWFc2ZHBIRVhuTkU0a1BjNU1mWWFBMmVlS1lFekVVaE5YM2kzMmt0?=
 =?utf-8?B?RzJveXY2VE9GMkVNaHk1UG5LZVlFeDBOTGpmazFGVmVYY0Uzck9lVFlzQUo3?=
 =?utf-8?B?Z1JlbWpieTkyb2Q4OHZldjg3eFJuL1FqVzhrQ1hrNlo3c3dxQVgrOGJobTMw?=
 =?utf-8?B?d21YbUJ3USt4V0laSzI0elkyOThDRDlEQWN4UkxsazRIdDRlVkxPREVURVI3?=
 =?utf-8?B?YUJRbitxMlJPb29IdTA4Ujk4OU8rQUlDdmM4S1dFQ1dJcUlYcHNQdU9NWERG?=
 =?utf-8?B?anA2STNkcmp5SUM2WmtsSmJHbWE1aXhHU1NKZWdjMjFxM3lXMnY4akJSaW93?=
 =?utf-8?B?Q01tUEpjQ1lsbmdiOUthOTlvU1BSNmt6cUxIcTlzOUtiTkMyNmNHS015WU5E?=
 =?utf-8?B?cGtFS29VcXZEUFF5SUx4MysrRVBEazlHSERBTi9jU2xiK3J2TmFoY1kwTGhk?=
 =?utf-8?B?cHdtaE8xNTAxT0xOWjVaMWJSRnErQ2JKRFJOckNTeVB5dkpkT0VxVXV0UllY?=
 =?utf-8?B?UndtMVU2NEhQVmtKNUVmM3BaeWFBd3NneDVZL0RvUEF6R1c1RXpJNnY3bUs4?=
 =?utf-8?B?RGp5OFREbHdXTkN3YWEremtvSUp1QjhBR0tXY2k1bVRZNFhoTFkveTN1Nnc2?=
 =?utf-8?B?aCtMckZuMDJsZDZ2a05yc2NaSy94Qy9wRS9paWE1UmgrRnA0Vjh3WEg5VTNZ?=
 =?utf-8?B?U2FTaTZiVzcxSWFteDBYSzlsMGRFWkE0TlNXUzkwK2RnaU5sMG5pY0JkWHJM?=
 =?utf-8?B?aVNBSVhJOWNLTnpDOUd5SmxaM1M2WGNHQWQrTThxZFR5d0ZiUy82citEbmp6?=
 =?utf-8?B?empld2o0NXlraG9lVUNSQnJlTHNwM29FYnpmNDV1NHZtUWd4b0FUQi90aVNk?=
 =?utf-8?B?QjlLZUQ4V0VSV3h0cEJVbHlHc25YWkQzblB5Z3l6VXBZRFJBdTB6anVhL1dR?=
 =?utf-8?B?ME9PYjhEZ0FlNVNMT1N1eWc1Z05zSytsY2Y3bFFRaWdwSlpuL2pnaUw1LzVi?=
 =?utf-8?B?eWJOZUJlbmpnUWRQZ2JGWE1hNXN6eVdIREhFcWM4RXAwdnpQQ2ExU3JDVWhE?=
 =?utf-8?B?YnRKcE1vM2d4cm0vUmtHZncvLy9kYXI0b1l1ZnFoZ05YYVpRNnFZOXlIRXlw?=
 =?utf-8?Q?/g0UOv1lpQ8DnPwIffJUtyzKD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a7ec1-70a3-4157-451c-08dd1b87d8a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:07:22.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPPX3I54UuPNN7AFes9+aO4rhftZ/1e4Xk8PTo586TCMgIBrHdKFcv7MaCLgPfu4yzCJo0b6nRfIoGg726T0hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6224




On 12/12/2024 3:28 AM, Alejandro Lucero Palau wrote:
> On 12/11/24 23:39, Terry Bowman wrote:
>> Existing recovery procedure for PCIe Uncorrectable Errors (UCE) does not
>> apply to CXL devices. Recovery can not be used for CXL devices because of
>> potential corruption on what can be system memory. Also, current PCIe UCE
>> recovery, in the case of a Root Port (RP) or Downstream Switch Port (DSP),
>> does not begin at the RP/DSP but begins at the first downstream device.
>> This will miss handling CXL Protocol Errors in a CXL RP or DSP. A separate
>> CXL recovery is needed because of the different handling requirements
>>
>> Add a new function, cxl_do_recovery() using the following.
>>
>> Add cxl_walk_bridge() to iterate the detected error's sub-topology.
>> cxl_walk_bridge() is similar to pci_walk_bridge() but the CXL flavor
>> will begin iteration at the RP or DSP rather than beginning at the
>> first downstream device.
>>
>> Add cxl_report_error_detected() as an analog to report_error_detected().
>> It will call pci_driver::cxl_err_handlers for each iterated downstream
>> device. The pci_driver::cxl_err_handler's UCE handler returns a boolean
>> indicating if there was a UCE error detected during handling.
>>
>> cxl_do_recovery() uses the status from cxl_report_error_detected() to
>> determine how to proceed. Non-fatal CXL UCE errors will be treated as
>> fatal. If a UCE was present during handling then cxl_do_recovery()
>> will kernel panic.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>   drivers/pci/pci.h      |  3 +++
>>   drivers/pci/pcie/aer.c |  4 ++++
>>   drivers/pci/pcie/err.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 14d00ce45bfa..5a67e41919d8 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -658,6 +658,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   		pci_channel_state_t state,
>>   		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev));
>>   
>> +/* CXL error reporting and handling */
>> +void cxl_do_recovery(struct pci_dev *dev);
>> +
>>   bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>>   int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
>>   
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index c1eb939c1cca..861521872318 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1024,6 +1024,8 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>   			err_handler->error_detected(dev, pci_channel_io_normal);
>>   		else if (info->severity == AER_FATAL)
>>   			err_handler->error_detected(dev, pci_channel_io_frozen);
>> +
>> +		cxl_do_recovery(dev);
>>   	}
>>   out:
>>   	device_unlock(&dev->dev);
>> @@ -1048,6 +1050,8 @@ static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>   			pdrv->cxl_err_handler->cor_error_detected(dev);
>>   
>>   		pcie_clear_device_status(dev);
>> +	} else {
>> +		cxl_do_recovery(dev);
>>   	}
>>   }
>>   
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 31090770fffc..6f7cf5e0087f 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -276,3 +276,57 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   
>>   	return status;
>>   }
>> +
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	bool *status = userdata;
>> +
>> +	cb(bridge, status);
>> +	if (bridge->subordinate && !*status)
>
> I would prefer to use not a pointer for status as you are not changing 
> what it points to here, so first a cast then using just !status in the 
> conditional.
>

Hi Alejandro,

I agree. This can be significantly improved. I'll remove the condition on
'status' and instead introduce condition on cb() and pci_walk_bus() return value.
But, 'status' does need to be a pointer so the caller (cxl_do_recovery()) can
determine if to invoke panic.

>> +		pci_walk_bus(bridge->subordinate, cb, status);
>> +}
>> +
>> +static int cxl_report_error_detected(struct pci_dev *dev, void *data)
>> +{
>> +	struct pci_driver *pdrv = dev->driver;
>> +	bool *status = data;
>> +
>> +	device_lock(&dev->dev);
>> +	if (pdrv && pdrv->cxl_err_handler &&
>> +	    pdrv->cxl_err_handler->error_detected) {
>> +		const struct cxl_error_handlers *cxl_err_handler =
>> +			pdrv->cxl_err_handler;
>> +		*status |= cxl_err_handler->error_detected(dev);
>
> This implies status should not be a bool pointer as different bits can 
> be set by the returning value, but as the code seems to only care about 
> any bit implying an error and therefore error detected, I guess that is 
> fine. However, the next function calling this one is using an int ...
>
>
> Confusing to me. I would expect here not an OR but returning just when a 
> first error is detected, handling the lock properly, with the walk 
> function behind the scenes breaking the walk if the return is anything 
> other than zero.

The cxl_err_handler->error_detected() return value is a bool. But, The bitwise OR is not necessary. I'll refactor as part of mentioned above.

Thanks for the feedback.

-Terry

>
>
>> +	}
>> +	device_unlock(&dev->dev);
>> +	return *status;
>> +}
>> +
>> +void cxl_do_recovery(struct pci_dev *dev)
>> +{
>> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>> +	int type = pci_pcie_type(dev);
>> +	struct pci_dev *bridge;
>> +	int status;
>> +
>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type == PCI_EXP_TYPE_UPSTREAM ||
>> +	    type == PCI_EXP_TYPE_ENDPOINT)
>> +		bridge = dev;
>> +	else
>> +		bridge = pci_upstream_bridge(dev);
>> +
>> +	cxl_walk_bridge(bridge, cxl_report_error_detected, &status);
>> +	if (status)
>> +		panic("CXL cachemem error.");
>> +
>> +	if (host->native_aer || pcie_ports_native) {
>> +		pcie_clear_device_status(dev);
>> +		pci_aer_clear_nonfatal_status(dev);
>> +	}
>> +
>> +	pci_info(bridge, "CXL uncorrectable error.\n");
>> +}


