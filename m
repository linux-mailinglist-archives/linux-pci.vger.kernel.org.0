Return-Path: <linux-pci+bounces-29354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E49FAD41D9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46952176914
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986923AE96;
	Tue, 10 Jun 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cunl6zU+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBAA20A5EC
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749579690; cv=fail; b=G2s2JoQPQsa562W/5XsCcWZ8FHue3vCcu4L+DSpktJdl8HltyAJWDCGiJ/QWOItYeZhCA3Lkrx468ji4XnpJhCDFoaS38Wwg1uzXqZOwblWkteCkcw2lfzL0V9tB8WOPSHgbgw1IZpOLz0Ba2KhneuMzC3Vjl4Mp0DMnpcJyeSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749579690; c=relaxed/simple;
	bh=tX9iF9wRoVpxEeslhuJHNfX44NutLSxtFvo5k7/9NyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aIke0e7wbPiFVbIjLvTNdSdRuQJ7TBzr4pMVQsVRfz+3YPll7jJmKsTGvtPPvCsXWcpjjPEThHnRB+WSW6KHR/eifDXyCH/2CqDBPP9y8X4ovzDWOxY5G3X8iTz2uIJPY3OiDzd7RjXnffcQsBnGgTtFAhQwVYWFWFt0zy1Ik3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cunl6zU+; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4Jmg3pmaJYrpSw9yvwGthS6nA+0NNR6Y/C6Sau/wT6lFQHq83a1an4fNCs7YfGrAASHe+DU/i6SFziUbOLonBG6TLryl34NW32gS+xFYYMTgSWO+1cAO5WzaAYX3JrynKX4aGKDSIa3wAWRIx2uQeHDoSUsLHIrBEWCmukxNovQeEOgcu55ExxNzgw9/thIjYUxrdaphjnx9b95HaWKA/CjHlNrr+oCvsJm9uF6MWCHxLLOcMTeRgUXLXabhVqh++uv3VFFJu2vO8HFGxkxo0tWJwq+2j6s9SOAY2TWhexeqiGLhMZUuDO4Y0UAiJp2CeIAXWcgmd8Y8Q8Cgus9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3b3E6b2nj7n88iTAi7fmFOWzytuFSaeRzWSsJ8nzTU=;
 b=y9YT/dWGl5iI56J683UR9eGY8SoBjbLsq3n5up4HPTeZpCvRv4ZTCpj1SiRF7zTX4BoNOHvhqkRGmKRwectRl/TaiUERyoj5saEXj8m/0IP8+vcOxFVr/hYWPoD9F1oSJlZ+E3dbTwQqxkX+4WetzfRbG66lEb97GLLVqtXBZFsRrloDvZ237OVudotrX2k/doQDlRp0D0yR/rqcFrmNIEz4a+LSPeR270k6HepISN4q5vIaOySGifx8f5lNIGp0swIf6dEDGA7Pu8wk62wPU99V/l3lnIrTa0nQxvNFvXLh4qxGA/7HKqaSrDLc9ROntVrLH/oo4Yixgo0r8X41eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3b3E6b2nj7n88iTAi7fmFOWzytuFSaeRzWSsJ8nzTU=;
 b=Cunl6zU+ZUC1JuAHKWVqzAv2x2IBV4UMqonC8TrdKz4IHuvOVlAdlo1PRnPkmcw9xp/fiD9GW2CGO0CkNuCwAPQGrGprvJWh1zOiSYNXizsCW2KSJuQIgB6To8JXeTqzUsf/4gVTWVvd42yIPon+N0ij994l9sGHVLHXPlZhaWFqeFw4TI3aKFy2WGa3G/l94uvgt8Z27P6WF6oTAMnzubWfwTz1tRiAXW/LIA6uL9G7rqTBK6HY4wf9jZcIz9z5baCymeGG+KI7GudnBTA4KgEzJlLTcLanU7zgv3Q0xCb9DYVDO0XHjZ3YQf58n9nGSuDpu7IjrDa+HC/dCNb2iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 18:21:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 18:21:20 +0000
Date: Tue, 10 Jun 2025 15:21:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250610182119.GL543171@nvidia.com>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
 <efd630b0-d08d-46a6-a5ef-8a448eb19993@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efd630b0-d08d-46a6-a5ef-8a448eb19993@amd.com>
X-ClientProxiedBy: YT4PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a5ef17-e41b-41fe-6dbe-08dda84b98fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGRNbjRpejBuM2VvVEZOZnB2RFJKT0VyV1AxL2lhdmwzdlp0VG9BRnhkb0Nq?=
 =?utf-8?B?NjM3WmFvdDEzdEc0aVpRWjYzWmRrMkpUZFVrSU5pdDU4VVBHYmhVVStkUmhx?=
 =?utf-8?B?M2V1VzZWeXNBaEFqYTk4MVJ1SmN4OTBFb3RCQXo1R2lwVnhreW1UQnkxMDM5?=
 =?utf-8?B?UStFVUtiVUxheDhzTDArMk9KUGk3OThWUEsrOVYzVUkrNzloUUhyMnlOZ2h3?=
 =?utf-8?B?VzFzVmJSd0hBdWFRU1BaTEthWHFTeTFvQ1JwMkd3M1JkcGR4VjBBaWhBdW9I?=
 =?utf-8?B?cmN3enVKRDdiYldVS2hnZUVMM3doZzVBZUdjZTdvMkFERnRrelJGYkR5aEZJ?=
 =?utf-8?B?NVZUTElFamdGa0haOTJnRy8wVDFvTnA5d3gyM21OazJQc3VjZGpHcVB0eURk?=
 =?utf-8?B?Nnk5UHVUV1AxWDZmOHpsRStRU084d2hWajJNa0dwQVNheUNvVlRtV0xqV2lD?=
 =?utf-8?B?V0tub1M4am9vakdtV1V2OGdpZDRQN3hua3JtcTZoRmpiWUg2R0J5QitCcTJo?=
 =?utf-8?B?emdESnJnTTgyUnN0MkRWcWtrRlZBRTgwWEJPSlhJQk9tdEowNVRGVzFUbXhn?=
 =?utf-8?B?RGdrbEQ0Q043M1NHSXdRU2NuejB1WUJReVlKdDQrRi9TUVVldzdYd3VkdjlY?=
 =?utf-8?B?OTdWZUVrT2FnNTh4S3J1Q1R0KzdETVY3OTI0UzNBZmdFTTNvYlliTWpCeG90?=
 =?utf-8?B?aE1GZzQrbk1EUmgzRHk5eWdPM0xybGNidERCVnJjWjB1alhCd1JTWENXbUVh?=
 =?utf-8?B?T2RSSlRoNUxjdDhERXRDYnUvNVo5enpHT0JueExjOHZkWUQ4dlFkMnNPRU1z?=
 =?utf-8?B?R0lKTlVvYWZIQi81L0xMYXlhOHB1Q29lTG1ma3hGcHpENDM3RVVoSXYwbHVx?=
 =?utf-8?B?NkswV1djTENzT0k0bVVYMU9KTFArT2VRa0V6ZmpzY1lFQUFPc1lQNmxqRUtY?=
 =?utf-8?B?bXRKZmtKRkhQK3E4RWdRVW1tOWJHSDM2cURnNEhPQ0JUbkgxVFBCOHRrUzg3?=
 =?utf-8?B?Y0RnRkR5elFsMEtJVlhmOVFTSElzeHJuK1AxVkJvY25McW1NZmFHTExXOUZK?=
 =?utf-8?B?bDlTSVZWbU55SU1mSk5yUjIxL05IRWFkTE5SeTVKMWxFT1lTbFlrdFE5R2Zy?=
 =?utf-8?B?UFpVV2RwOWFoQXEyNDQ4TFZpN2F5cXZKMkJFT0JzZWVMa3VCSmdINjVjaFhO?=
 =?utf-8?B?RXMxVzIxWkdpOVVHQ2pYWlo0Z1RWejVja3ZLSnJpVGxNZDRHdFYxVzg2L0dL?=
 =?utf-8?B?bngxOWo1cFdHTE5aRElLbnQwRFJtSXBFMHlody9oOUgvRHJNOTJXY2lQY0FC?=
 =?utf-8?B?OUs3aE5Td0ZocWdSeCtCV050RWdablVXeXhZMDZGQWliR2VITlROckJGUnFQ?=
 =?utf-8?B?SUVEK1c0SVZ0M2loa1Z1S2tYQ3N6cXlxb21YNUdIaUhheUxDVFJ0OWpTY0Z3?=
 =?utf-8?B?N2ptM1VyZXd2eEt4cUZxdE1mQmtGTDVkd2FMME8xSHRVc1k2K1pkMTd6VWt4?=
 =?utf-8?B?U0hBSFZjZm5TeXNPclV1YzhCamtuZTAwa2I5bHlZeUQ3U1hIWlkwc2RrUmZw?=
 =?utf-8?B?c2gzWUhiRytienI5aDFvcVhGanJYWkZkUUJuZGZNbE1kY2tvemtIamROOHFV?=
 =?utf-8?B?eTl1SDM2RGxLS1VwUU1kaEhoaHdtUDllWkNHdUU3NENjaWpQS0VoMmRBdGFm?=
 =?utf-8?B?TjBvWFhYSEJEUkJvSlYrR0t4QS91Y2RIdGx3N3BPRkxzL3hVa3pHSVFLUnk5?=
 =?utf-8?B?enU0dkxVNGprc2NvY0llRERjMm9hMVNqU2tLVWdHWE94eUgrdUxCVU81MTBV?=
 =?utf-8?B?elB0VG9kNzd1KzdqZG5mS2gxblljQUVjYlFoRE1PZTMxMmRSQjBqbFRUbXgx?=
 =?utf-8?B?Sjl3aHpHZkpsdkNSL3FYSWJXSWJkSThTWi8xWmszQVJNa2RjWTlOR1FOUk9T?=
 =?utf-8?Q?q0Q3EkWwFb4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVvSXZ2bWhwbHRscm9WVWhCZXphaFdNejhKNFppazVMMmxHWjhUY0ZiaGJB?=
 =?utf-8?B?R0l3a3dRTnJKbVQ3d2VjWkkrQ3ZiZUJnZktqajdjY1IyaUU3RG9NZzBlQVBJ?=
 =?utf-8?B?bGxJbzAxY0ZFWTJFeUpYNjA3TGN3Y1pCL3NybGE0UXRaeUVGa05QSTYzVlYz?=
 =?utf-8?B?bkJyUDJ6bEJjVjZrSm9IRTFuZTlNbnR4OW91M20wN2NkZkdHNXhDSW8rOE12?=
 =?utf-8?B?b3lXek1lZ0dBZmptNjUzdFp1ZUFIakZramR3OHJMK2V3RXI5eFlPMFhaNUFy?=
 =?utf-8?B?eFpCbksxK3hsbGpUWEVmalcwTGFIemNqKzQ5MUphT2pKbXRMcjFsVDNmb0tB?=
 =?utf-8?B?VGZqM2licW00Q1R4eCtBMlBJMHNsb3Z6RG9HdndsMjduMENYazNQRDE1dGkx?=
 =?utf-8?B?NkZuMGtoMHpPQmozT1Blc2QyTTZ5blNyZWltZGc2eTl6SzlZMkgzTGtycVNQ?=
 =?utf-8?B?N2hLUm1qS1ZBVXFnaVZGK2pubHNxc2srYTJNajZzV3RLTzVzY3YyRGEwYzdO?=
 =?utf-8?B?N25NSllEaVBiQTJDZ3lIZisrT0FHbEVxUXBhK2tHWi8vYmQ1YndDMkUzZ3c3?=
 =?utf-8?B?REpYS2xiak5hbFMrU0FweXQ3UEdlTmVTV3llREF2S3piM1kzb3J2Tm8wZlA1?=
 =?utf-8?B?dDlNOEJRZUxPcFpwcVpJUkFQYlJSanM2OGVKSzdIMEtKWTlBdERNVFRnSWU1?=
 =?utf-8?B?M2UxbjI3cUMwNHcvOWl5WHFUVzZNeEZIaXdKQ1pia1ErZWQ1a2tDalN5WmVY?=
 =?utf-8?B?dTdubjBPdG5COStIeGdtRjBJMmRFOGVwVnExenB0SytxK0MwSFFlNXRyYSsx?=
 =?utf-8?B?V1g1bEpNeHRIUjFHMnljTndoNEdUVXVReDNCOVQrenQrSHJxSWJkTmJ6SDNj?=
 =?utf-8?B?SFhwaEtORXZKMmhaODhWeHlxeTlYWVpITFc5NVd2V1VZaEIvcEFNR3B5MkNW?=
 =?utf-8?B?OWJCN0QrTllHYThDVXkyUHp1Mzg3SEk4Ym5DUzhIV0xyWjlDb04wWUJHWUlt?=
 =?utf-8?B?NjZoeGFPMlY1Y2d5RGU3L0lvTUxOWU1sUUFuN1JaQ0R2ZGEwL2daRDIzMFVl?=
 =?utf-8?B?KzVvSysxQ2FNQlA2OGFXemdBQ21wQk11dW1JRGF6eE5FRFV5WmJwNEVYREtX?=
 =?utf-8?B?d2c0T20xNXB3K1BvWlFpWG02b0U0UmtCaktBM1BqMDBuZ2R4bXRUZzkwcHF1?=
 =?utf-8?B?THgrRWw1WUZSSnNycUx3YTFQQzFkc3RTTEg0MTBKTUpFUURMUklPVXlTTjQ0?=
 =?utf-8?B?TGczbnB0RU9BZ3lsVENhelNLOG9GQVdTd2pNU2RxVlNDQnA0b3RRVFJGL0VG?=
 =?utf-8?B?ZlNISHpYWDF5SjZNNkhNY2Njd1FwVFFlTmFpVlBaYS9pdWpuTGh1em9pOTJy?=
 =?utf-8?B?MFc4OXBETkhrczdPMm1OK0JjRVdIdUdrenhyZ2pIa3lCeTByYVVsaGZVYWcz?=
 =?utf-8?B?SmR0TnYxNHF4MFYzYkIvMWhBKzVmZjRTNFlRVmdadkszbWkyNXR3cjJaeGow?=
 =?utf-8?B?dkRmT0NlWGRUU2dvUHIyaXltUUZLdDBMYjJWdFRxSFhGQkd1ZWRiK3RjU1Nq?=
 =?utf-8?B?RWt3OFdFOFJPRDc0VXZab0NWWUhsZUVtV2YrVW1qYWJXRlhYQkthR3MzaGI5?=
 =?utf-8?B?WWZ0Z095VThrdDQ4VGVNcDlzZzdocjJoL3liWjE1VWY5NUlpdWRTenF5akho?=
 =?utf-8?B?Rm5nVE54MWFnZlBFaFZQQ1ovcDg2KzhEREtqV1Vmc0xlS2RkYmNHZEpva1d1?=
 =?utf-8?B?K3hjYXJzcVI2NVFuNTBpYWJXOUIyUVI2b0tWUDRRallxdzRwNzMvR3hvN3Zo?=
 =?utf-8?B?dnNIbUx3bmVwbytmMFp5aGJZOEU4LzVOZFJPSFJXK3YwZVRtcUJ0aVJHRHZX?=
 =?utf-8?B?WDF3L25BV0Noay96VTE1OGpYdCt5RnU2TEw0djYwbEhQd1RuRnBIaUhDK2gr?=
 =?utf-8?B?WW5XaXVDWFdDSDBiWlgzejFVa0NhWjhHZDJMMlliWjU4VkNaMHhrZEJyMzJO?=
 =?utf-8?B?ZkJ2YldaSzVlSlVDRDZkT0lQem50TnlraXdBMWJQeGdSOHNvOElrS1lTTDMx?=
 =?utf-8?B?eDVJeXdzOGx3OVBIU1UxU21xVGYrNzlBeldIVmp5Snh3ZGg1aEQ0OHlTU0h4?=
 =?utf-8?Q?Emtg2CqzyLvvtbuYcwKj0rmco?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a5ef17-e41b-41fe-6dbe-08dda84b98fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 18:21:20.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Eq4Ix7kZzRduUarnQb2I8mkCwlyWLOgO5JJWVCPmwstm8f9uZO/Q+QrColj4/jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419

On Tue, Jun 10, 2025 at 02:47:32PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 3/6/25 14:05, Xu Yilun wrote:
> > On Mon, Jun 02, 2025 at 01:48:57PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 03, 2025 at 12:25:21AM +0800, Xu Yilun wrote:
> > > 
> > > > > Looking at your patch series, I understand the reason you need a vfio
> > > > > ioctl is to call pci_request_regions_exclusive—is that correct?
> > > > 
> > > > The immediate reason is to unbind the TDI before unmapping the BAR.
> > > 
> > > Maybe you should just do this directly, require the TSM layer to issue
> > > an unbind if it gets any requests to change the secure EPT?
> > 
> > The TSM layer won't touch S-EPT, KVM manages S-EPT.
> 
> Is not it the TDX fw which manages _S_-EPT? And the TDX host driver
> (what is it called btw? Intel's "CCP") registers itself as TSM in
> the TSM core so it is somewhere near S-EPT logic? Thanks,

Yeah, I wonder the same things..

Jason

