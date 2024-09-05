Return-Path: <linux-pci+bounces-12837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4796DD81
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE2B1F2647A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BED1A255F;
	Thu,  5 Sep 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dl/YrbjN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9945E1A256E;
	Thu,  5 Sep 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548927; cv=fail; b=ElYYRtJ8FrLz7JPdp2JilNL6YQ0M/zLqLQpkk2gIBwp7QBADqxpfS5psEBJdMXNkx2pCNAdRyIRr6HCwysAfBdTx/ugVXPXUCalqyYvT/jbjiih2O4/tZaKnOE7wUpAo40s/h0JjWBDbfIZE/espLVaBIaJeyBagfwYv+XkHI00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548927; c=relaxed/simple;
	bh=MrlUGY4xdWYizITQ5hwl50XHSx84rbk7f60y8Lb85wY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+cNbs+4ZbVOUANAuSoaZ6ng9asHtmQyNSs/Hi2ZviSgsic8Jn5aFgAm0aYl1+BrqqvUEFoFzYI8EiHLBPuE7Duakvxw6oc5OEbxd+6ok4Rf+UzXaQRv8/uGwxHrd8MBsw0rB9N/uNAtgHnloWHvtCsJP+i9nQBHWSjrUtU5CoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dl/YrbjN; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6XoMP6vQQjWvRkHx3fo/E2TgI3m3QW77n2+oMvcBAfxoO4HgCLBArN9vA5DMsupo6bvARxDzpWQJ5gi5kQzzJk+DosjYKR7Qmm5NvkfHJTOlPRd3E+X4XisFQiNmoPvlAd+y+YObaIhqLIVHyHTLfijDBTHezNCdfSyqMB3YOtIycdkeyxxLmQesmrbKTOS3WXBZNk9CB4p1OLNlwh3sc44vDIqoiP9j2vrB2pKc8JI2Tp7bws7bimCzOm1QrTkOXOAPp5kFgNde4pXvM1jZRvc/lLkRMwvXQnYm3ZdkRUrN408w+NVKr3oJLmSP9881SSLjOFfzSgmtM1sWvHQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aulzC8BDXiULH2TKsH0k0MvmIBoMnrJBMXiQEWu4A7c=;
 b=sKWaYWrEqGGUUFxLVPMhJS9byuHOq6fgoCL2cBi/y48o4hFkjal6Sw/jD8zLnVuuHMPowYN1dj5CuZ9fTY66w6+6a5VYAXJXzAD5SX2AYQZRnftEWwkhrDIs8B0v+uImLD/kjmAa7RBZWYnKnmWivfjylU+I8tnOf3s5kDND1NKE98PPQL1uwfUIIHpgeUml3pu6WOR0E18u5A4XkJQr010dQkMr8CldwEFjLl2muWUz2g6E9TaKq2SqVvUsBYPHdQY4tB7I0WNpxEVLqL22Lq5gSKczVmgn9UfcSnfJZ/Z+Xa7OnbHjm4afhMB1NZaMn/X0T1GE4f0dCs7cAtlPWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aulzC8BDXiULH2TKsH0k0MvmIBoMnrJBMXiQEWu4A7c=;
 b=dl/YrbjNfsdXGTtZfBimbQ8wA6yEKg8nrTqq1+amNAX+movtfD8BCzZwPfobwyWyzbpfFznP9flkIepFcvO9mN/3KwmNTJfwWk52fH42Wpp5Zg5TQ0y4uQ8+46gSYDEeJG+Q8lbO/C82iBkq7KyeRWnz9B8e7pL/ttNTjowhtqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:08:35 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:08:35 +0000
Message-ID: <91a05b5b-a642-4cef-9c81-cba246435aa9@amd.com>
Date: Thu, 5 Sep 2024 10:08:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 02/12] PCI: Add TPH related register definition
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240904195254.GA344807@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240904195254.GA344807@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0032.namprd08.prod.outlook.com
 (2603:10b6:805:66::45) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ce5d96-5e91-4ac8-5200-08dccdbc9d48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVgrT2lEbUU3V2xnK205aldjenZpQkFUY3FtTW1UVnV1MTAvMEw3SmJFSlE2?=
 =?utf-8?B?cFF5cS9VSERWUlZHNXk2b1gzUGdQRG9hNkVjUWRSZFpYdlY5enpNWUNYSTJJ?=
 =?utf-8?B?akU0VC9VTnpZK296ekNDOHk5b2JOTFUwMCtEU3JXekFmM2xEeC9aZURtbEw1?=
 =?utf-8?B?ZzdvQWNEclN0TU8xY1JZek5ITXBQMG9QUy80ckJ0bW5WL3l4UXZnVFdxVmRS?=
 =?utf-8?B?NlFMQXBTSThkMWpxY29aNzhFaVFVeXF5a2VnbHdlREJsbk1TdjNKL0hXbE5E?=
 =?utf-8?B?cTQvM2NqWkNOaFZ5UlN3VzNXRWZaSk91Q1NaUzhTc3JlRmgrNmpWRk40anVD?=
 =?utf-8?B?K0h5M1hmUUFWd1krK0h6MFlEd0RCMkxNZnZYbHJLRHdONmFuMWxZalBWR29E?=
 =?utf-8?B?T1AydCtPODlJU0RlZWl4YUpJOUVRQzVSM005NVBiQjB2RWdRWkJJQlNyZlNy?=
 =?utf-8?B?YmdKNHBGeWh2Y3d6WXpVK0FGeDdwRDgrRGpLd1RzT0Jodm5BNjJoeUsrWE1x?=
 =?utf-8?B?YTBFMVB5TllLN2xXSlk0eDIwNGlvQjNLQVJBYWR1OG9ZSmtpbFFvTGl5MDRY?=
 =?utf-8?B?LzVXMUIwZUVMNHFzNHFxb1dpRHVkdzdhUG83SHY3eWx5Y3R4R2NldlZYZTBu?=
 =?utf-8?B?L1lKaEJPaGk3cW1RV3FQYXRvODMrZzg2VjZZb3ZtSXJsb1h0dm4wb0JCYm5w?=
 =?utf-8?B?RUlCL1VGWDd4OTBTUzZxT1VpZlBNK0VSVFpidGhselY3c1JEamw5b3B2RXlp?=
 =?utf-8?B?MVEzL0lkSUJGRW90L2ZoNG9ENjgvcGFFWHZPUXR0ZXQrbG81anVYTWtoNFhV?=
 =?utf-8?B?dHZGUzU5TFgwRDk2VGVGYTI1NjZsaXBsMzBrWWxMMXh0WjNEM1pUWWhyOXh6?=
 =?utf-8?B?Z0pmT2U4U00vdC9VZHplREplb0ZpU2xUYmhzY3RJcGZMSzh1cFJFYVRnaG5q?=
 =?utf-8?B?UUtBVHRhclgrd3FNN0FLRWlrSDJoRzFOeTU2cm5PM0FDMjI3Umx0WVZzS0Vt?=
 =?utf-8?B?dVJwUVVNbVl0OXhGQnIwYW5zZmJTdnB4MS9rbkZ1VVI2cFUyaUI0ZEVLSTVw?=
 =?utf-8?B?ZFIyM2tKZnRCZFMrZ2YyYklWVHpuTEZCMk50Zk54cEM5Nk9MbnNzNmNOQUxm?=
 =?utf-8?B?a1J4dUhKY0MwTlk3S0NvK1FwdDErc0gyWjRqTGhzWkVST3JmQnhnaWVHV1JQ?=
 =?utf-8?B?TTJLNENjR0QrY2NjbnlCRGRja3Y1ZFEwdXljQmZZbWNsb2h3WHV4NUdRU1Rp?=
 =?utf-8?B?bHYrYkdvUnR6QVhDRG54Z25rZDduV29wRXJ3ZDQ0RVNuS0dDbVozQnh4Y0Zn?=
 =?utf-8?B?N1B5OFh4MzlaUW02bkY2VjVpYzQ4UkV3OHFnMXhEU0k5N1c0enJrQlVhbmZx?=
 =?utf-8?B?Q0E0QysweEtCZmJ2emhNdDQrMWxxU3JRNUg2OTVlM3l6U3huQXBNVzNBRWVs?=
 =?utf-8?B?bDFUNU1jSFlKZTlrYXg1WXNoS1NucUlScHoxekJmdDdYK3lnWU5zcTBsZHFu?=
 =?utf-8?B?amp4bWZOUEh3c0RTNGRsRDNVM2NKNmJrTFlNempzWmdmT21OMVdQRUNncXcw?=
 =?utf-8?B?ck44WHBRckJtMUV2bW8yNHdZNmRiK0twai92SjYyREIzNDJCV0EwbjhIMmxl?=
 =?utf-8?B?WTYwbTNCRVpwSWhCaHBCVDZjMkR0dGFjWHdFV1pKZUJhYWtvNE5OMGp5M2Zn?=
 =?utf-8?B?QWl4OFNuMkQ1VWJtbHU1NHA0Y2I5WEViUzgyK3AraGRyK0RBZEZXeUNqbFpH?=
 =?utf-8?B?Z1oySHRCdjhJWUthSHRRS0o1UEIydWs3c0pLNjgyQ2FFc3N4K0tmR0pBLzFy?=
 =?utf-8?B?TEVoRDVtL2FQNmtqYXVwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlJWQ2dtMnBFU29KK3ZYRFZwd1I2TzNvQlk0SVB6S0pXaWMydmZ6c0VPa2I0?=
 =?utf-8?B?MkRrTlgycnRPMVNnOWNYWndhV0VZWWJiOFF1WnAvOGs4T3o2NTlKQkFoNCt4?=
 =?utf-8?B?TGhtcGtRT2FaZUtRV2NhZlhBWW9mKzFWb3Rac0lEUWhkaGlIZUhKVU5KOG5i?=
 =?utf-8?B?ZXArWG5HVHYrbzAwejlmNlp4ci9qTGppSm9LbnpQLy9PM2RKQkRNOWU4QUNN?=
 =?utf-8?B?RkFJZGgxbE96QTEzVkl1c1ErdFNyUVViWnJiNnU0WHpUWWx6VmFTKy81NWJZ?=
 =?utf-8?B?dEw3eXhDN3BEcVhvdk5tUHlIUDZnOTltRHNCRU9UR2RGY3lURTljT2pqVm9U?=
 =?utf-8?B?UUR4Z0xPZFFBOUhnZ1FzNEcydTZQN3pySUhJRjl1QVJBTXRkbTRlZkFQbXdU?=
 =?utf-8?B?QnFNbkVSVStkRnRmR0RFT0hhT3dBa2RJSmo2OThqQ0NhL2h3UGZjeThGT2lJ?=
 =?utf-8?B?ZElJRi9hTjh5NzRLQnBFSGlITUdLU2Fpa1RJdUU5M0xkVnY1WU1IeGlndFBz?=
 =?utf-8?B?OWxCQlBxQUxZbzJNeGluSi9wSVZTZFY3aFRXQVFscTVyZ1lpdG1zeklDTjlO?=
 =?utf-8?B?V3k3MTBFMFJ5Smp3aUVGb2lDK1Z0SXRMaXpoN0R4QmJpMHhnZWx4eVFETDEr?=
 =?utf-8?B?VzJycXhCSFVmL2c4ZzViRkV1bStGOGpoVzdZL0FaMkFsWHNqcWNOcyt1Yzlh?=
 =?utf-8?B?Y0ZSQUpneVF5U0FCV2R1VTdiTzJkSkM1RTlFdW1QRHpsUEJZR3NyZGp6SVVi?=
 =?utf-8?B?NjVSMVNQVjU2YVhMZmhuRERmcDVsNlY5aWtJNlpRWFNyT0RMUVJUOExGb3VY?=
 =?utf-8?B?VmxaeDE1bVYvL3hoS3pvQVdTZmJqekJ1WFZWZlM5eGVxMXZhN2dxS1p1MllK?=
 =?utf-8?B?N3haYnlrRVFxRWVlK1MvOHBXKzMzZ2JnM0JwT2I1YzhSZHFteHhlaUtLdmdB?=
 =?utf-8?B?UXJUZkpxQmd1WGZvT2Y0b0hYNE1wWHBGY3J4MzBzSFdlQytEOTZHODhtbS94?=
 =?utf-8?B?akxZeWkrWjAzbVRIc09hd1lZZDk2MTdXd2xkcFBCVDFKaXFmaVFWcGJLNDhl?=
 =?utf-8?B?TW1ldytFR1l4VXhhWlZsZGpTSnpQbi9RbFArQ1pxQkkvT2p2SHM2NllObit4?=
 =?utf-8?B?ejRlMzJXRFRHZFU4NEhKSzdYVk1xN01TdmMzMXhPa1lLT0w4MFk0dmh0NjZD?=
 =?utf-8?B?N0tOcDlrVDdvUEdrS3kzK3RmMWNrNmVLVUhraDJ3V0kwbDhGcmtNWExTeTJi?=
 =?utf-8?B?UHJoeXZkejBrM0JVbTZvWkVPYXMra09WajF5TXBESFJnWWt1Y1dFMENLWWV4?=
 =?utf-8?B?SklWVTdhR1JRRE55aVVMaW9YSkF3cDBRaURmVXpmdlNBalpyc3BGMUZzUVVp?=
 =?utf-8?B?YXg2ODBHTkFLUmNuUFJqZ1p3UFdmazNUbCtMYzBQVjQ2Q0h6cFl3UXU0azQz?=
 =?utf-8?B?NmUvL2pVeHpTUzN6RGVicFJpOXFheCtlR2FkR3lqbU14WUpIbWlZQVZHMlRP?=
 =?utf-8?B?dW9GMCtYNnN5YUpkNk5HZnUzYnljTUlhZUdIRE5XMjhVNVF2MjNQZzdBenFh?=
 =?utf-8?B?ME43N3VmNis5ckRobHNCNTR0ZXQ2OFVBUEhta3d3ckJ2ZDJzdWthYTVLc0Ji?=
 =?utf-8?B?YWkwVDJIZ3hCa0YwaTkraFlrL3kvSG44RCt1bW5RN2w2aXhsS0kwZWhpV3RF?=
 =?utf-8?B?eXg4NklGeVdnUm9PWk5yYjUrVERNUFh0bmRKY0FUQ1ZJaS9HQ1BWTjNJLzNj?=
 =?utf-8?B?dmJDNDdQVVRqcENBYmI0aE1YaVdpaDdUOERPOUlNODF4MnBmY1prMC9VQnN1?=
 =?utf-8?B?WmZrL25iaGpXTXpPbVhVaHdmejFLN2N3Tm9hVUdTNklEMUkxaUluQmNOb21C?=
 =?utf-8?B?QTlyTzVoSytmdnYwN0ZPWjFWZ2J0Yk5BaVFFTW0rdUZEb3gzSXZzNTkzR1Fq?=
 =?utf-8?B?bXVNcGwvSlIydHN4bzQzTHFjRlBhZGJ1bHNRSnJadEgxQzRXUnVrRitjV0Vp?=
 =?utf-8?B?bm85YzhrNDZFMzB4NHREa05KemprcGluMVlEUExxS2FFK2wyVjFhNHlrYnZW?=
 =?utf-8?B?TDNJVktnUForMURxc3BTVVNUejNXdDlkUU9MNFVpYlFsZUtOQnh3TnpPV1g5?=
 =?utf-8?Q?YVJzBFtKLkqdkhKRwnMvLsoKH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ce5d96-5e91-4ac8-5200-08dccdbc9d48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:08:35.7356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xK7SXAdMdXOjV+y5KJtOcqe5FWUO6i+jUD500wPNlv1PrLdpACUH3ZYsji8gCeGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669



On 9/4/24 14:52, Bjorn Helgaas wrote:
>> -#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
>> -#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
>> -#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
>> +#define  PCI_TPH_CAP_NO_ST	0x00000001 /* No ST Mode Supported */
>> +#define  PCI_TPH_CAP_INT_VEC	0x00000002 /* Interrupt Vector Mode Supported */
>> +#define  PCI_TPH_CAP_DEV_SPEC	0x00000004 /* Device Specific Mode Supported */
> 
> I think these modes should all include "ST" to clearly delineate
> Steering Tags from the Processing Hints.  E.g.,
> 
>   PCI_TPH_CAP_ST_NO_ST       or maybe PCI_TPH_CAP_ST_NONE

Can I keep "NO_ST" instead of switching over to "ST_NONE"? First, it
matches with PCIe spec. Secondly, IMO "ST_NONE" implies no ST support at
all.

>   PCI_TPH_CAP_ST_INT_VEC
>   PCI_TPH_CAP_ST_DEV_SPEC

Will change

> 
>> +#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* Ext TPH Requester Supported */
>> +#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
>> +#define   PCI_TPH_LOC_NONE	0x00000000 /* Not present */
>> +#define   PCI_TPH_LOC_CAP	0x00000200 /* In capability */
>> +#define   PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */
> 
> These are existing symbols just being tidied, so can't really add "ST"
> here unless we just add aliases.  Since they're just used internally,
> not by drivers, I think they're fine as-is.
> 

Yes. In V1 review, Alex Williamson and Jonathan Cameron asked not to
change these definitions as they might be used by existing software.

>> +#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
>> +#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
>> +#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
>> +
>> +#define PCI_TPH_CTRL		8	/* control register */
>> +#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
>> +#define   PCI_TPH_NO_ST_MODE		0x0 /* No ST Mode */
>> +#define   PCI_TPH_INT_VEC_MODE		0x1 /* Interrupt Vector Mode */
>> +#define   PCI_TPH_DEV_SPEC_MODE		0x2 /* Device Specific Mode */
> 
> These are also internal, but they're new and I think they should also
> include "ST" to match the CAP #defines.
> 
> Even better, maybe we only add these and use them for both CAP and
> CTRL since they're defined with identical values.

Can you elaborate here? In CTRL register, "ST Mode Select" is defined as
a 2-bit field. The possible values are 0, 1, 2. But in CAP register, the
modes are individual bit masked. So I cannot use CTRL definitions in CAP
register directly unless I do shifting.


