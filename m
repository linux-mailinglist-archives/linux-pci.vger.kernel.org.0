Return-Path: <linux-pci+bounces-28855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3CACC632
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92B23A3593
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25A22CBD9;
	Tue,  3 Jun 2025 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAElwK1x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777E146A66
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748952711; cv=fail; b=hfnTHIg7BzUYotAAfv9A1ed9beWZggoqQjfrsMIllC3xb48MwLqRTlGlRfqJZyRlJISznjQCw+kezScRLI3RfVRqcgAoGk6jXz9EPfZ9qEr7Hh8L4FVipFf7R5KenobqGc1hnBxdzQZ1WYGmjV/jkFU/rt9eWojBPON0RIR8crk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748952711; c=relaxed/simple;
	bh=jMgmPnSs9yZHVIQ4nqQfoizLmTlUfK+zr81qMdatIas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xbpj/z1D20dpU5KazM+sbHu+gB8g+QdBmGaBiY/c9jVYy/hMMjj2B3FpWCK1fyZmi089tYBOzd54IFYtl98TaC0Q3Ql51juzejZAIe19yrB6dn52j6zLNpM5Fwk502ig00fqmUVKp4sWBHma1vitvF2urecRT7fZiucvgDMvIlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAElwK1x; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrVBKQZzFxwpXY8UpnBM1Ye4hrdhIV0v6EGCanSydUV3l2KdhMSqyAAIuNLIFCY6YVpimeY7o4LjoqZN6cNka1ARdIRIHK2K2L9KmR/7qgi+rGZA/AS3e24KmuWT2jpJIvPuL22MRy33cvQ+mTlwJ9qj8Dneyj+TylEW8Hjbhxe7w8KDQ4wXQEA1IxaCiOUKo9FSv8G0b+oYB9UzqSYmrX56nfltB5U/x5xOUgbJYa9WqxCNe5lIIpYhAzYeQ4+7yLdfXKt+EhNf7vYiqpY2qoB8Mkj8VlRvBm+9nP6BNFcJpyX441qhB517onfYidTghWdos0cr22/79re3QDK4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13WpdcwqLqtvCD6Nv0glzi6zBC3Rr2e7HuTPQdlzcIc=;
 b=IaLADWx5hDdck3u7/g0KEOcRX2HXnJl+Ht68A9vW9QKgDNGdmG6sYQG44sx1nBi4wX3FBqpYa78WLJY4mkY244f8l0uCaf52x4DI4hp2+VaL0sxyB95SryTWA9dNlL+V2Uo2QE16lLDyXlPLtFe1jKZNkzHiNU7SfzXU14PcO2mYv7pNUEifSKti28/UGJUitKIKNYzmMswAQtpyiqFuJ2i7tdnyOhcsZI7d4WcyeZxS6CxvMVOrJegoUH2tDytc86/qz+q7DL9ByhBJx2wdWu6CfEbIiO8b+mkf9EjRCjl4EUk72tPSaDxTVChJOHyIkD7I1xCQM75QVxPmGKyXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13WpdcwqLqtvCD6Nv0glzi6zBC3Rr2e7HuTPQdlzcIc=;
 b=iAElwK1xO8OokeQMKgMmrTMddXCcQKQ0GmMRpzhgl/02fFASKprbkeBOnnaMaEtdmaxQpwWBr7TocCr/eC3Gx7YdBfnoy56dNu3gpznAbkKMxAYdAQxNqV3Eo+dLzx8Sc06cRw3pdC6bXyQ4WKI3coc4qjkrBOnAzH5f7R41pZhUnDfpUhcjc7MdvQvAGtN2MMT/dkzdJZWNPHcAsHXm4v/J92x9I3rBrbiewK0R754YGemnjThV+szqYIKR3Bmh2L/DJUEnaFCllFkjP3PMcu+dTwhibKRTKkot1CPgCJiiU/6dtVwfRh9/SEQ98bAjeO0rwY7eX238ZI1B0JC2Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 12:11:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 12:11:43 +0000
Date: Tue, 3 Jun 2025 09:11:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250603121142.GE376789@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: BL1PR13CA0377.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: bc68d546-433d-4b71-6853-08dda297cdde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dXNLeUxzU3RNSm9vWWViWW9PVTZxT3NYcmNxalYvZ2t5Q3U2ZnlzLzNQQjFn?=
 =?utf-8?B?b0ZlUmNCWW1FczlDMG5LeWk1T3l4TURvNCtZQmpKa3M0SVpIbEtseEpQVUo4?=
 =?utf-8?B?eVdTM2NSWGgvSDdsYXdDN3g4WVRJWkt5NUNNK3pxbTc4YzZDQTUwZm1CK0lh?=
 =?utf-8?B?Y01kZFY5L0dWd1lGMlluL0lLYVdrbjZ1UTVvWE1TMW9xWWdpT251STRYTEFu?=
 =?utf-8?B?SUpIT1dEdUZKWlhsRlMvaTF4N3ByU0RSZi9FZi9yM3hFSEFjUTFPdmVRcVJ0?=
 =?utf-8?B?d0ZIbG1lQjRDRTgyYnlxV29YeThQQ2pEWUx4N1I2YVo0S01sZlhCKzBRdVJJ?=
 =?utf-8?B?UGZRVWwxdDV0UTVaWE5YNC9RMDlHWm1Jd1FSeTdIVlJrYW94S1NnQlB2SWJp?=
 =?utf-8?B?U01lQXUwT3VMWU02YlNKUENXNXUzVCs4YnBGTlhpeStZVlgwUHdOckxoVzN1?=
 =?utf-8?B?cGdkZ3pMNHpqOUJSREhyTW5lUkx6R1dzK3dydFNSNXNVUGNMdi8xeGYyR1RV?=
 =?utf-8?B?OFVIQU5XM1M5WlV2QjRyTnNDcXJyOWw4c2g0MWhWS2xjWk5sNVZRczAySFV3?=
 =?utf-8?B?cnllb0Q4SVVKOTBrTE4xRWI4SGVCTGJKTlluMVlsdFZKdWVUclpYaXU2bE5G?=
 =?utf-8?B?dW5qUzNvUVd5ejM3YWFFNnQ4NVA1UW4zUnVYVWhWLzBjVXRpYWE1cVdsWDdB?=
 =?utf-8?B?cSswb1RRNnhZTmVaZEtmZnMyZ09ORVV2d1Y4VzNNZ2cvU3lxZmUycWE5RW5u?=
 =?utf-8?B?VHd2RS9lWjRhWnpvaDNnWGxRU3krZkdrRFgydWNNUVg2QUZDdEVvUG1nSXFM?=
 =?utf-8?B?Vk56WU9CVTY0MW4xYW9VZjEraVBleENxZEVZSTh6RTlIWXFIaFhWTVJpTjRj?=
 =?utf-8?B?QklmV0p6LzNwWnhoOWJJdk9WNm1md1h4eUl3NCtMdlB3R3JrS0VObEVuZmNi?=
 =?utf-8?B?Sy9rKytpQzNsNDBXRG5tWlJXYmlYcEZtcHlBN0NYdmVvVlRML0MwdlpVbno5?=
 =?utf-8?B?QXh3L05RNTM0ZCtFWkVEU3ZrSzJqUm1jZGluNzRFNG1TcUlpU2pWZnRNb2Q3?=
 =?utf-8?B?SEZqeXJpajlGY0NLSXkrUU1pSHk0NWttRmk0a3ZMZnJUZGtoYjl5Zm52YnhC?=
 =?utf-8?B?RTVzUVduRmdMZkVNUlNucnhyR1JVRXNUQXVnTk1MSXFobzFsSXRBbXBBUkJK?=
 =?utf-8?B?dTVLRWJqbWFNSlFYeXlFV29yRGlCQUtnRnM4UEhuQlVDT2xzMEFEZjRJMENu?=
 =?utf-8?B?TWoyRWk5VkFtTmZOTVdkVGtzL25BTE5QTzdIMmYwYzQxU1F3bS81WmFZOHY2?=
 =?utf-8?B?d0JYbGt4WHpZMmZpZ3VyNHI3QzMvekIzSXAwc0kzYVkyM3FHWVhLSkd5Z3BU?=
 =?utf-8?B?V0RjVVJkbUhmQ2M2L01NWWRDWVUrMHAvQ0NkK0YydE5hOWZlcUx4QXo4ajda?=
 =?utf-8?B?amF5ZVFWalpLRVZLMVBBbEdSTFNLekQvbFhTUDZaL1Jja2NQdXhXODlVNnNO?=
 =?utf-8?B?K0JUeTBISWl1NWtWVG5KNVZTVnBKRUFUY1hXeElwaERtVFVFN3UvTzYya1VX?=
 =?utf-8?B?ODBJVVdBVWo1N09RRjlVaG1ETWw1cFdBcytTblFUMUdVMEJKT200U3Z0MnIx?=
 =?utf-8?B?VHRaUmZldWJnVSttenhhcU9zR0UxZUpMNTUvb0NVS3NpOTI1YkNXTjBpWFJO?=
 =?utf-8?B?RVVLMytTUHJKS281R2EwaDA4dWVpeTJDWXF3WnJJQjlNS0tWdmdUZUIyTUlY?=
 =?utf-8?B?Q3pwdWZWSFJYSFJJTUdYNERoRVI1UDRzVDRNMk54aUFCaU1nYkV0a2Z2d2tl?=
 =?utf-8?B?OFZiU2Z4Z1krTy8wTFVlMXJ2b0xieXZhRTNFVmtiejdtK09HbmFWVXE1b3U0?=
 =?utf-8?B?UmhLMnZxUUMyTE55WE4rTDU5dlRvZ2tNTXU2cHArNDdsQlJSM3ZSZEFTTmYy?=
 =?utf-8?Q?+9igqvG07Fw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NZOEltY0tRMUQwUnZBT1lQNEpZamRWeEsvR20yc3MwdXkyOGI0TkdzS0FN?=
 =?utf-8?B?Z21TbWNmQ1JzM20rc2lOYm84U2E0SE8wUCtjeWJ3OXlXbXZHZDBiZ1V4c2dl?=
 =?utf-8?B?WU80T1FJUnJjYk42STZMbUhQMGZuM1R4N2JyN0pYUi8va09qTSswYWJVb2NL?=
 =?utf-8?B?ZWhZOS9JZW1kaU4rZUk0WmxHbFRmaG9kOHZ2TFVmOC9JWGhzcTdDOTZNaExB?=
 =?utf-8?B?M0dVVGZjVzV6VTdlVlZ2cWVCQTJmUG5ndjlUVEJFbnZ2M25DZUFMb1ZpMGYy?=
 =?utf-8?B?YmpPYUJjS2pzWGZ1aERXR21rWDVrTEk4VmVtUFppUFF3NTlHb1ZSblRYZHUv?=
 =?utf-8?B?cWNQcTk4RFJtbkRDZXJsdm1WZ1RyaUZqVXVjUXhBMGEyWjdYY0pxQUNhbHJS?=
 =?utf-8?B?SjhOWWR5QVkyenJ5ZzdBTkp5UmRjQ3IyeGE5eDIzVmUwWUlKQWlFbHF3KzJ1?=
 =?utf-8?B?ZFhVSE1ZNkZuWXl5b0FacTR5N3RjaVVkdVJKOUZkWVNCWlVady9HSkNHM0lq?=
 =?utf-8?B?Qnl2Y2lUOUQ3TVdidGdDd3Z2a1l1NFpnTlhpWUlrV0V1QXNzMGVhRmJYbWZK?=
 =?utf-8?B?NVhEQzBtbDdJVERnYU9DTGxIYVBzY3RwZHpDTlJVRWtCU3lLVmlvR2xxbE1R?=
 =?utf-8?B?TTM0ek54Z2Y2NC9DbGdETFRoNnpnMDFBRVovUEtXYmVZUFozOWo2UGZPTFdz?=
 =?utf-8?B?QU9HQXFLWHB0bmdyZ3haZEpLYldEd2svd2doMWRBb1BITHZlbVQ4S0V3OFdP?=
 =?utf-8?B?ZkErRCt5RWJKcWJKUWRZWGNMNFdIc1VEZVBzOWRUR2IzR0FNN09mRjdZM2lm?=
 =?utf-8?B?ZnZCVk5ydUI2azhzekZnZ295dTNWYzJLZ1NxSUNtTlZoYlEyY1RDSm5TaHBZ?=
 =?utf-8?B?enRLVDhTdlpOcWxHVmFrRm41d0JJN3U5UjFqdXFHRzBrcjIwUjhEK1BXeDNr?=
 =?utf-8?B?cGdTVVIyUzc3Z0NlVERWaVhrVzRPUWl0aVZiVG04UmIxQjJmQXFJYitXRmtS?=
 =?utf-8?B?cUVvaDVxWGRrcHE0T0lCcnZiMEFQenYwVGl2Smx4K3ZPeDlXR0kyRGszYXkx?=
 =?utf-8?B?RTFHZURJOGRvRklLUnhhb0tRRVFVanIwZldxUVkyTVFQeE5iK2RqQ2pOUSts?=
 =?utf-8?B?RDAxY1RkVnJ3bEdmM2NmRXlFWm5ITld4Zm5rZ0QxWGRzd2J3NmwzcFhQV2sr?=
 =?utf-8?B?WnFmOEtDOTYxdk9BcGgwRzhCalFzdHd5VVpPZmhPaWRwMmlwS2E1NGFyR3Nj?=
 =?utf-8?B?UDJPRldwM1dJdmk3QklaMVNxOGdjSHc4V29uSDIvSEtJYUhaNUVyYy9sUEox?=
 =?utf-8?B?OE9jM2V6MHBrS2x6aTQ0VzUyZFlDWnB2UFRBT3J0K29SSTNvQS9YR1FzLzg2?=
 =?utf-8?B?WDhtdjhiL3M5cHZHeU5xMVhQc2hKUXRrVFJORDcyT1lpRVlhZXNDOWhyZU93?=
 =?utf-8?B?dTR3RG4vWEJ4bkprRWlqcG5hbUZpTkFFRW9EQUp3RDdnWFczSjhhRXdDaW4x?=
 =?utf-8?B?OHFGV0FBNTgyUE1iYzd4MUYzNXArUHVxUXFoaDlUYmh3UEZydVVDeW1ud2xF?=
 =?utf-8?B?R250WWRQRkhGRW9KOHorcC9MUytsMlBLakZkeURNSWVlMDA3YU9KaWN2bkF6?=
 =?utf-8?B?TFdGdzJJZjBpT1NWQjdRVUJNVHdLeTRKdHVNb0hmYWJMeCtRVDRkQUhwSXc5?=
 =?utf-8?B?R0RISDFSRm8zTXNTbmxmNmI1b21rbzI4dUxGNmpnVHZuY2kwdnZJVGNIOFJ6?=
 =?utf-8?B?ejRKRXBhVVVKOU9pVEZqL1pwTFRGYWdta3VicXB4L2puZzY2dXZvMjJYQ2d3?=
 =?utf-8?B?bDVCSkxPZVZORUQ2ZkdodXFFTXRvNkEzalRzMHIyWEp5TDd6QUQ3MjAyM0NY?=
 =?utf-8?B?TUg4c0FETExHR3kwWUplWk9BT3VxWC92bFRXeXpqNi80MWtGODJXWlI5bXRl?=
 =?utf-8?B?ZllGWndXZ1hUY0E4K1NQUXlVZjdYNG9nUU5Hd1FUbDlCM0tDU1FQalA4Q2Rw?=
 =?utf-8?B?akV3bWp4elRHVFJSTnVPWW9aL2E0YndUaUd5ZmxCbVg3OFVGQWI1eUxKOWRY?=
 =?utf-8?B?NzB3T0ZEMC9JOXBMSzBTSmpQeVRYUDZTRUVhc3A0WUIycGRGZjY5VEl2Y2lU?=
 =?utf-8?Q?ie/SMDb5/SuHH4MjbMAhnpeNa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc68d546-433d-4b71-6853-08dda297cdde
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 12:11:43.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3crSGhCVZhbybQXxn01lTkxipx/rebCZSfkeFJoLUbr0qU3qOjfcc3mWjR25gHrP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

On Tue, Jun 03, 2025 at 12:05:42PM +0800, Xu Yilun wrote:
> On Mon, Jun 02, 2025 at 01:48:57PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 03, 2025 at 12:25:21AM +0800, Xu Yilun wrote:
> > 
> > > > Looking at your patch series, I understand the reason you need a vfio
> > > > ioctl is to call pci_request_regions_exclusive—is that correct?
> > > 
> > > The immediate reason is to unbind the TDI before unmapping the BAR.
> > 
> > Maybe you should just do this directly, require the TSM layer to issue
> > an unbind if it gets any requests to change the secure EPT?
> 
> The TSM layer won't touch S-EPT, KVM manages S-EPT. 

Why not? This cross layering mess has to live someplace.

If the actual issue is the KVM S-EPT interacting with TSM bind/unbind
only on Intel platforms then it would be better to address it there
and stop trying to dance around the problem in higher levels.

> Similarly IOMMUFD/IOMMU driver manages IOMMUPT. When p2p is
> involved, still need to unbind the TDI first then unmap the BAR for
> IOMMUPT.

Huh? I thought if the device is in T=1 mode then it's MMIO should not
be in the non-secure IOMMU page table at all for Intel? Only T=1 P2P
DMA should reach its MMIO and that goes through the TSM controlled
IOMMU which uses the S-EPT ???

Jason

