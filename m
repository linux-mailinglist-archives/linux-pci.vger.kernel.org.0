Return-Path: <linux-pci+bounces-15810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95619B9778
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3341F2191F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2131CDFDC;
	Fri,  1 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YAul7Q+d"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B51CDA1E;
	Fri,  1 Nov 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485702; cv=fail; b=dF+zMHYYorGhBCvziey+kAHIay4oNUo/vYCbpESrloI6OTY2tps/NnIM49zx6e66p6qq04ZFHVQffzgZLFHcmnnBvkVE8fg+vE5m2CYb+iGI1RRl0itn3ZhzT91XBHd6Zy+hhx/Uhj7+DbqJRBwEeMdmICGFh55HLsJcfEcbMqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485702; c=relaxed/simple;
	bh=mHdDrOkYxsLgnPmMxbl9BsKAhJ6A1j6Xf30+LGWXKcI=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=Y/kpa8NyvMW1bin2K6jMQZsJLlK9HFy2VyalarwC0h4qDXp7dwfOx4y9HLLoRJnUxnECOp6utHxZe9u39MMp1n/iXL5u7mMDXMQka8hbW5gJ8rS+BKvKfAKRAXKH06b5wYZZLqfF6ayB9K9ydC0XnSCiVjK0nmjztvAIIOKQewA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YAul7Q+d; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aENalO4h+jUw0WyKQsvBxrU4DQKISeSi0zDHgmdgPG0zRxFq4y17eAkdukF98G0AsbyWsAEGJm1b8Bwp08HDeUGF+97bC5332XAjn3IkQCAshDPExF1LPuQ2WSr7DKlZoFTcp6LvBqg6tHNcNRukQVzgucP9xUDdewPLK4IrhVrGoGGOcmW5KVM8x6HmoUAQliD7HLLHtbfkYBeoh7DNkzJqk4FwEc01qrgtdT106oQeb9EVMKCZwfRHvA8uzBmGOYhldhPXiULKqduycZRbys0ZmTeDxqzasX+VxqY/QNT68MdM6rRaBA2Ebfvd9PUucwXxp2euKWyYnoT+je2F7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaGW2EnLSP+H6/exQqp7QRJp3r6k5+TwADMmHnWrXNE=;
 b=nFDPdtrUADmu3DjJlVnXTS2YgqiyfMQv4m34HfA3GzYLWsS6MjsyUq3uN4+SUyoIqLwmb+ZocGKhFeVd1NzJ899TBNoJWjIYzFdY8nYe9mE8Y5xfQxT7Uebh3uYMyqDptwRvuu5kl8wCI1a4hLgu1IT/D0Q+5Xn8hJNfOBqBk7LtQVszGqiaSksRfGN46o3vp8Qr2dnn4G7d3h8jKTC6ARqhK4CWxdb66vcYl/6AZsIOfNk5DJhZu39DPGvbo/QtyRK/Pj4jRWaJscKdIaft2SJUGhWQqM0/DcwTXVOR30Xcm/H93QIC2OJrS0RQpVaj6H3Qs/14A5bHYKTSLxfleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaGW2EnLSP+H6/exQqp7QRJp3r6k5+TwADMmHnWrXNE=;
 b=YAul7Q+dtgcCzpbGDCxFMM991gyoqOPC0fWhXPTqovzacqqK8ovR02GU0m9vbL4THTyk5T90XLIy4SSb48wz8xwQh0qiP4HiMq82e9Ky8T8fReUKu15nHIQEps8tcVhDnHqKWvUNXTbmqlXb1zjL8B/fqdF3aIIB2ohpodH/miM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CY8PR12MB7731.namprd12.prod.outlook.com (2603:10b6:930:86::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Fri, 1 Nov 2024 18:28:15 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 18:28:15 +0000
Content-Type: multipart/mixed; boundary="------------ZCqoTved48uVI4k8I9sY9cO9"
Message-ID: <8a73bfa1-b916-4f0a-92be-0cb677e1e334@amd.com>
Date: Fri, 1 Nov 2024 13:28:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/14] Enable CXL PCIe port protocol error handling and
 logging
To: Fan Ni <nifan.cxl@gmail.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <ZyUXLpQBBgTl733z@fan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZyUXLpQBBgTl733z@fan>
X-ClientProxiedBy: SA0PR11CA0138.namprd11.prod.outlook.com
 (2603:10b6:806:131::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CY8PR12MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9e1b02-c758-4cb2-4c7c-08dcfaa2f319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pyZkNJL0RYSDh6cm5CNTF0MGNiVzV5T3ZRcHdCZ2ZMcGxhTlc1UWNXK0Vk?=
 =?utf-8?B?WmFxLzdqOGJsa0VUVlV3eFMzVnd5Z3pKK1RrNnRjWThsd0VXZlhhWDBrODVl?=
 =?utf-8?B?UkRZVFdaaENNMWtSN294bHQxSXFlQTJZTGtJQXlNSmw0YVBBN3VrM3J1dTll?=
 =?utf-8?B?MWgzaXV5dnpIaFlMVWk4Mkc5TjZyckYzVWducStKenMzR3dJNENQMkxZTURR?=
 =?utf-8?B?ZFVwNjVYc295UjhRc2NhSUU1ZzFDbW5DNTlrdnBYMk9yLzBYU0h5STV3OEdL?=
 =?utf-8?B?UmZ5MGhCUXpTQ0FOdDNkUkgwUXRSZVlrTlFsM2F5NkdqVjFqY0tRbFlyOVR0?=
 =?utf-8?B?OVErVmpYTkRVYTVualBRNWkrc0pTMEYxMUZTTUYvT09VSEUwNnpOcFJmTXR0?=
 =?utf-8?B?dktCOENxWUZVeWZzSFBURzRhTTBQU1pZS2lEYUxKQnhVR2lmZVh2d3FzKzZa?=
 =?utf-8?B?bmE1azdVbHI1MkI5ZEFqUEdZTW8zNHpVLzJsUWRwU0dpNWorY052RzJsOHA2?=
 =?utf-8?B?UmJaMmhlZzBMZENhRm50NVo4SVdRQks3VlJ4djNZQWZuc2FxcFpjbXdEelkw?=
 =?utf-8?B?bko3ZnplTVg4bEdmVHpJOVBNNkVqSjJLWll0WDhCSjBSZ1dlNGtWWFpOYUFj?=
 =?utf-8?B?c25CZFM4b1JEc24wM3F3ZHh1Z1JTWlppalkzS3ljYXM4RzMyUXJnV1BXSm4w?=
 =?utf-8?B?bEtkLzZQR0N3SVNjVXdvdGpWVmdYVEdlYUYzY2dMeXI2N0U3TE41Wk02Nk9Q?=
 =?utf-8?B?OTdyaUI2alZjZndUdllGK1I2OUcyUlc1UFc4Qkg5Ni9DZFZaVVFZNFNPK09H?=
 =?utf-8?B?TTBjSGd3L0JZNS9KQzVwbzRWeTQ2RlRsKzMwdlgvVHhWUDNyRjdJWXN1Yk5l?=
 =?utf-8?B?V3prT0tIVlduMGtMZDRhV0ZCd2lYRi82dWJnVklpN2lhRjRvc3RwMkFpNFd5?=
 =?utf-8?B?anRwNlZjdjRlMjJsUW4rYTZqdHB5YlYzdWdIajUxb2E0blBsQ2xydnkvNkhk?=
 =?utf-8?B?Qll2OURnQjlWQ3FlcWtRcURLMkc3dno0RGs2NEJteGdYSGo3NjNxd01xaktp?=
 =?utf-8?B?bUdvT0N6aW5Yc01PSGR5aEwzRkRtbWpUbTNPRmRVMzNPeHhHT0tZdnNtMURj?=
 =?utf-8?B?LzM1WmdhelUvMi9sVDhQbzVSdlRKMXhuWFFGRy9DUmxDbUo0a2ozZElEaTlI?=
 =?utf-8?B?dkZ5WU96V29XdWpKREZROWU1bGNtbVU2WjE3cVFGWDU4YkNQSUpIQldiWTlu?=
 =?utf-8?B?S3NlalFrVkQ5VHE3TzVZdEVKd1BWK0lKUVFTTEZPbjhWNFpibW4vanMvZ0NO?=
 =?utf-8?B?OXhGVUtYR0pHYmZEV2l5cEUxUDhMei8xemVlUkZ5RVljeC9xa0xzRm1naVhk?=
 =?utf-8?B?RDNZK2VqbGE0VnE5K0RsRndXc2ZNRU8vZUQvN3owUzJteTRSWC9Hb0ZTa09k?=
 =?utf-8?B?Y0M1cGxuaGhhTG9IU3NtbW5zN0VhWEhpa2ZQdXh1MFBkcGYvVjdrLzlJTjZp?=
 =?utf-8?B?YUpTakwxSEQ0TWpHVTVNaXpBVG42VFk2ckRkRVVjdGR4aU1sNDZlYTk4QnBE?=
 =?utf-8?B?M3FhN1l4RHFlVi9aUldHWWh0RE5vVkxnQ3FyNG5oZ0RSeTBQUFNpWkJHaHYz?=
 =?utf-8?B?YlhyWjM4TndoYzNRckZPc29YSldCNWlIRDZOK28vZTgzNVdlSGE0dWJwSmNQ?=
 =?utf-8?Q?itpNQxr1J8MVmV7nOlC7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVhJYU1DT296MHRyQVVJTDFKY0dEWC92ZDZpUEI4NjhndlpMZ0VLM0RucTJX?=
 =?utf-8?B?QWQwMUxhMElTOTBhdlZ4bmhSMDZpbUJvWU5ZR0FHQUJ3ZXZKL2s0bDJnK2tL?=
 =?utf-8?B?VU4yTDRubVp0QXlmOGpBc3VlTVRvYTFYSW9aRW5mc2toVXRUaHA1WXkyUGFF?=
 =?utf-8?B?MHlDdkIzaXpBMHkyVE1WYy9wWld6WTNEK1N2cEZ4M3ZOQXRwV256UkNvWVpo?=
 =?utf-8?B?VmtkU0haYUlUaGxxMTkxcklndk1JMzU5NkdvUmJOWGlRVzZDVTVHWGx3aFNS?=
 =?utf-8?B?T0luTWU5RFNGSzZjcDdoM0F2Wk5HbmVsSzNENGVHeEFDYmZocHQ2M1ZQMFdI?=
 =?utf-8?B?OVdpb2dSMTNxMWg4T0NqYVkwZ002a0IxV1p1S294a2pzMTFmZWsvZkV1TVZu?=
 =?utf-8?B?V3hzcWRCWDJyZXJKQlFxYjk5OEM4ODZGWjVmOXRCdzJacERhQUpwYW5WWUd0?=
 =?utf-8?B?bDlaeEFMWFFkS2IrNk9ueE5PeENjZGVBM09JTUV3d0ZBdlJ0MWdmSHdQaEcz?=
 =?utf-8?B?L3Q3RDlGaUpQQ29Qb2prd0tiSHlIVmV6SlZaN0RndXdtMHdhRTF2dlg3aE90?=
 =?utf-8?B?UFB2UllpcWtqOUUzU1c1dGRqc0ZEOUFnYUQ0aHlxVUtndlNjNHoxMk5zaXFR?=
 =?utf-8?B?aHBacDJvTCttcU5NNlJaaGtjWnZrTDl6MldvZ1I3TlM4Q0JBNS9DUFBVejZK?=
 =?utf-8?B?UDdIU1R3eFNIek1LazQ1b1pFdWxFUWxXaGpiVjcwTm9jMlRQenF1MFU2RUtP?=
 =?utf-8?B?MEhKbTRNZGZIODEya0tTWDRSZVVGZk05cTYyN1NLa2FSUXJEc25wMHBLaGZ4?=
 =?utf-8?B?ZkUxS1JPS1dyRGVId3l6d1o4K2RNNmRQZnN3T0REVzc2WlZXa3RmRWFPSlRP?=
 =?utf-8?B?R0ZHY3h0VUt6SUZIN0oySzV1SXhEaEdqUFc5d2UrNGNRK3FJRkZOS1lEcENT?=
 =?utf-8?B?M3RLeXhxaVZPTGdMOTVNaFhsc3lxdWpkWFhWSFFST0NOS0FIQmtpSHRLeDBD?=
 =?utf-8?B?eTFkbnd3bmlOeTlvVHZNUFlmamtleDFoWDc5TGpKQURySjMwTGN4eHRjd1pu?=
 =?utf-8?B?a3BCSURmOHVUaTk4M0FHZjlaUnNoR0g5dEhBYTA0Y21IdVAwdXhya29iYVZ3?=
 =?utf-8?B?S21oOHNGelh5VldpUTNEcmRDSXFvT0pvTUkrRFgwc1J2eERpTUNVakFWNzBW?=
 =?utf-8?B?cWptalNuNW9FdkxVWWtNU254NlBwaEJ3WkxBU1g2STVBMXdEM3NzNk53cFo0?=
 =?utf-8?B?eWViTXJuR0JMU0hrcUlqUllqSEtDbHBVZXZVQmRhczErVXB4U1A3UjRjNTFZ?=
 =?utf-8?B?NVBhL0s5TFJMWEpvT3NLdllPaHVXUFd3SmZEaUIvNk03Zm5SZkVsQVVhdnpO?=
 =?utf-8?B?Y1BFcTUzTHBhbms2dm52R2RydThkbzB5WFI5K2paNU03SGZyWEFTWWlKVS8y?=
 =?utf-8?B?NVVoalNLM3RwRkhUalNIbUJpUlBaKzdTV1NZcUVxUWtsYlFIbW5HMmFmZ2dw?=
 =?utf-8?B?cmdZd3I3K2hkYkVYZDFlNGxaUjkzUjh6T1d1c0g1R2hEcTl0Nmptbk94MlZz?=
 =?utf-8?B?WDJZVXgxUkdIOCtNT0VEWGR5c3FhQWpFVjNiQllaaklxbFdiZGp4bnZ5YWJu?=
 =?utf-8?B?cW9kYzZldFhRVGk0VnpsRnBSSjFHL0pIbExtakVXUTZyNDNpNlNmRUN5U3B1?=
 =?utf-8?B?K29nczEvNDhNOUxibDRyYVN3bEtwRUJoWWhJWk1ndzVXZFlQQmw4Z0JBUjZh?=
 =?utf-8?B?V3ZKWE9QdHE4a01KVUYrVS9lUTVEa08zU0d1L2FHSkhQUDVna2NGTG5QeTk2?=
 =?utf-8?B?b2gyWk1NSGNITDV5djN0cE1la2Mvb3k1ZGJnaytQK2dLaE8yM09jbitFTndk?=
 =?utf-8?B?OGdPWXp4RUdDZkNPTVF0NEVjb01aL3lUSFBycjdOZjUvU1FBQ0FYbmF3cDVh?=
 =?utf-8?B?cG1wN3hTQzU4RXdlRWV4QW95RXY1S2lwVEpBellCYzhOOXBUaXk2NFVwRk5q?=
 =?utf-8?B?ZzVYZktubkNIbmk3TWg2N2loWkUyak5rUzcyekMxYmR6TXU2OHhIMTZYWW8w?=
 =?utf-8?B?SXhsNFpZQ0cxRUlCazRNcHlVOVVFWUNZQVRRS1FZNTZUN01ieUc0bnM1QUNl?=
 =?utf-8?Q?shYZar8fs85gP0M99g+i5s0BN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9e1b02-c758-4cb2-4c7c-08dcfaa2f319
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 18:28:15.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPDapZTFHVvRpVjzoTBDu8JQrj31I/0sMzfV/k0fD5RC+8OkJJCYzVUOZ/F4eo7C8RXcDcej5H0yx4Q8u1uPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7731

--------------ZCqoTved48uVI4k8I9sY9cO9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Fan,

I added comments below.

On 11/1/2024 1:00 PM, Fan Ni wrote:
> On Fri, Oct 25, 2024 at 04:02:51PM -0500, Terry Bowman wrote:
>> This is a continuation of the CXL port error handling RFC from earlier.[1]
>> The RFC resulted in the decision to add CXL PCIe port error handling to
>> the existing RCH downstream port handling in the AER service driver. This
>> patchset adds the CXL PCIe port protocol error handling and logging.
>>
>> The first 7 patches update the existing AER service driver to support CXL
>> PCIe port protocol error handling and reporting. This includes AER service
>> driver changes for adding correctable and uncorrectable error support, CXL
>> specific recovery handling, and addition of CXL driver callback handlers.
>>
>> The following 7 patches address CXL driver support for CXL PCIe port
>> protocol errors. This includes the following changes to the CXL drivers:
>> mapping CXL port and downstream port RAS registers, interface updates for
>> common restricted CXL host mode (RCH) and virtual hierarchy mode (VH),
>> adding port specific error handlers, and protocol error logging.
>>
>> [1] - https://lore.kernel.org/linux-cxl/20240617200411.1426554-1-terry.bowman@amd.com/
>>
>> Testing:
> Hi Terry,
> I tried to test the patchset with aer_inject tool (with the patch you shared
> in the last version), and hit some issues.
> Could you help check and give some insights? Thanks.
>
> Below are some test setup info and results.
>
> I tested two topology,
>   a. one memdev directly attaced to a HB with only one RP;
>   b. a topology with cxl switch:
>          HB
>         /  \
>       RP0   RP1
>        |
>      switch
>        |
>  ----------------
>  |    |    |    |
> mem0 mem1 mem2 mem3
>
> For both topologies, I cannot reproduce the system panic shown in your cover
> letter.  
>
> btw, I tried both compile cxl as modules and in the kernel.
>
> Below, I will use the direct-attached topology (a) as an example to show what I
> tried, hope can get some clarity about the test and what I missed or did wrong.
>
> -------------------------------------
> pci device info on the test VM 
> root@fan:~# lspci
> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
> 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
> 00:02.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
> 00:03.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
> 00:04.0 Unclassified device [0002]: Red Hat, Inc. Virtio filesystem
> 00:05.0 Host bridge: Red Hat, Inc. QEMU PCIe Expander bridge
> 00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface Controller (rev 02)
> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA Controller [AHCI mode] (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
> 0c:00.0 PCI bridge: Intel Corporation Device 7075
> 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> root@fan:~# 
> -------------------------------------
>
> The aer injection input file looks like below,
>
> -------------------------------------
> fan:~/cxl/cxl-test-tool$ cat /tmp/internal 
> AER
> PCI_ID 0000:0c:00.0
> UNCOR_STATUS INTERNAL
> HEADER_LOG 0 1 2 3
> ------------------------------------
>
> dmesg after aer injection 
>
> ssh root@localhost -p 2024 "dmesg"
> [  613.195352] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
> [  613.195830] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
> [  613.196253] pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> [  613.198199] pcieport 0000:0c:00.0: AER: No uncorrectable error found. Continuing.
> -----------------------------------

This is likely because the device's CXL RAS status is not set and as a result returns false and bypasses the panic.
Unfortunately, the aer-inject only sets the AER status and triggers the interrupt. The CXL RAS is not set.

I attached 2 'test' patches. The first patch sets the device's RAS status to simulate the error reporting.
This will have to be adjusted as the patch looks for a specific device's bus and this will likely be a different
bus then the device's you test in your setup.

The 2nd patch enables UIE/CIE. I moved this out of the v2 patchset. I need to revisit this to see if it is
needed in the patchset itself (not just a test patch).

Regards,
Terry

>
> The problem seems to be related to the cxl_error_handler not been assigned for
> cxlmem device. 
>
> in
> cxl_do_recover() {
> ...
>     327     cxl_walk_bridge(bridge, cxl_report_error_detected, &status);                         
>     328     if (status)                                                                 
>     329         panic("CXL cachemem error. Invoking panic");                   
> ...
> }
> The status returned is false, so no panic().
>
> I tried to add some dev_dbg info to the code to debug.
> Below are the debug info and kernel code changes for debugging. 
> --------------------------------------
> fan:~/cxl/cxl-test-tool$ cxl-tool.py --cmd dmesg | grep XXX
> [    1.738909] cxl_mem:cxl_mem_probe:205: cxl_mem mem0: XXX: add endpoint
> [    1.739188] cxl_mem:devm_cxl_add_endpoint:85: cxl_port port1: XXX: add endpoint
> [    1.739509] cxl_mem:devm_cxl_add_endpoint:92: cxl_mem mem0: XXX: init ep port aer
> [    1.739876] cxl_core:cxl_dport_init_ras_reporting:907: pcieport 0000:0c:00.0: XXX: assign port error handlers for dport 1
> [    1.740338] cxl_core:cxl_dport_init_ras_reporting:913: pcieport 0000:0c:00.0: XXX: assign port error handlers for dport 2
> [    1.740812] cxl_core:cxl_dport_init_ras_reporting:927: pcieport 0000:0c:00.0: XXX: assign port error handlers for dport 3
> [    1.741273] cxl_core:cxl_assign_port_error_handlers:851: pcieport 0000:0c:00.0: XXX: cxl_err_handler: (____ptrval____)
> [    1.741812] cxl_core:cxl_assign_port_error_handlers:855: pcieport 0000:0c:00.0: XXX: cxl_err_handler: (____ptrval____)
> [    1.742263] cxl_core:cxl_assign_port_error_handlers:857: pcieport 0000:0c:00.0: XXX: cxl_err_handler: (____ptrval____) (____ptrval____)
> fan:~/cxl/cxl-test-tool$ 
> --------------------------------------
>
> dmesg after error injection:
> --------------------------------------
> ssh root@localhost -p 2024 "dmesg"
> [  228.544439] pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
> [  228.544977] pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
> [  228.545381] pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
> [  228.545879] pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/00000000
> [  228.546360] pcieport 0000:0c:00.0:    [22] UncorrIntErr          
> [  228.546698] pcieport 0000:0c:00.0: AER: XXX: call cxl_err_handler: 00000000a268bfcb 000000009e0da039
> [  228.547103] cxl_pci 0000:0d:00.0: AER: XXX: call cxl_err_handler: 00000000b9f08b93 0000000000000000
> [  228.547515] pcieport 0000:0c:00.0: AER: No uncorrectable error found. Continuing.
> fan:~/cxl/cxl-test-tool$ 
> --------------------------------------
>
>
> Kernel changes:
> --------------------------------------
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 5f7570c6173c..bcecd1283fc6 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -848,10 +848,13 @@ static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
>  {
>  	struct pci_driver *pdrv = pdev->driver;
>  
> +    dev_dbg(&pdev->dev, "XXX: cxl_err_handler: %p\n enter", pdev);
>  	if (!pdrv)
>  		return;
>  
> +    dev_dbg(&pdev->dev, "XXX: cxl_err_handler: %p\n", pdrv);
>  	pdrv->cxl_err_handler = &cxl_port_error_handlers;
> +    dev_dbg(&pdev->dev, "XXX: cxl_err_handler: %p %p\n", pdrv, pdrv->cxl_err_handler);
>  }
>  
>  static void cxl_clear_port_error_handlers(void *data)
> @@ -869,12 +872,14 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  {
>  	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>  
> +    dev_dbg(&port->dev, "XXX: assign port error handlers for uport 1\n");
>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>  	if (port->uport_regs.ras) {
>  		dev_warn(&port->dev, "RAS is already mapped\n");
>  		return;
>  	}
>  
> +    dev_dbg(&port->dev, "XXX: assign port error handlers for uport 2\n");
>  	port->reg_map.host = &port->dev;
>  	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
>  				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
> @@ -882,6 +887,7 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>  		return;
>  	}
>  
> +    dev_dbg(&port->dev, "XXX: assign port error handlers for uport 3\n");
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>  }
> @@ -898,11 +904,13 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>  	struct pci_dev *pdev = to_pci_dev(dport_dev);
>  
> +    dev_dbg(dport_dev, "XXX: assign port error handlers for dport 1\n");
>  	if (dport->rch && host_bridge->native_aer) {
>  		cxl_dport_map_rch_aer(dport);
>  		cxl_disable_rch_root_ints(dport);
>  	}
>  
> +    dev_dbg(dport_dev, "XXX: assign port error handlers for dport 2\n");
>  	/* dport may have more than 1 downstream EP. Check if already mapped. */
>  	if (dport->regs.ras) {
>  		dev_warn(dport_dev, "RAS is already mapped\n");
> @@ -916,6 +924,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>  		return;
>  	}
>  
> +    dev_dbg(dport_dev, "XXX: assign port error handlers for dport 3\n");
>  	cxl_assign_port_error_handlers(pdev);
>  	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>  }
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 067fd6389562..aa824584f8dd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -82,13 +82,15 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
>  	 * Now that the path to the root is established record all the
>  	 * intervening ports in the chain.
>  	 */
> +    dev_dbg(host, "XXX: add endpoint\n");
>  	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
>  	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
>  		struct cxl_ep *ep;
>  
>  		ep = cxl_ep_load(iter, cxlmd);
>  		ep->next = down;
> -		cxl_init_ep_ports_aer(ep);
> +        dev_dbg(ep->ep, "XXX: init ep port aer\n");
> +        cxl_init_ep_ports_aer(ep);
>  	}
>  
>  	/* Note: endpoint port component registers are derived from @cxlds */
> @@ -200,6 +202,7 @@ static int cxl_mem_probe(struct device *dev)
>  			return -ENXIO;
>  		}
>  
> +        dev_dbg(dev, "XXX: add endpoint\n");
>  		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>  		if (rc)
>  			return rc;
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 3785f4ca5103..8285f14994e8 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -294,6 +294,11 @@ static int cxl_report_error_detected(struct pci_dev *dev, void *data)
>  	bool *status = data;
>  
>  	device_lock(&dev->dev);
> +    if (pdrv) {
> +        dev_dbg(&dev->dev, "XXX: call cxl_err_handler: %p %p\n", pdrv, pdrv->cxl_err_handler);
> +    } else {
> +        dev_dbg(&dev->dev, "XXX: call cxl_err_handler: %p no handler\n", pdrv);
> +    }
>  	if (pdrv && pdrv->cxl_err_handler &&
>  	    pdrv->cxl_err_handler->error_detected) {
>  		const struct cxl_error_handlers *cxl_err_handler =
> --------------------------------------
>
> Fan
>> Below are test results for this patchset using Qemu with CXL root
>> port(0c:00.0), CXL upstream switchport(0d:00.0), CXL downstream
>> switchport(0e:00.0). A CXL endpoint(0f:00.0) CE and UCE logs are
>> also added to show the existing PCIe endpoint handling is not changed.
>>
>> This was tested using aer-inject updated to support CE and UCE internal
>> error injection. CXL RAS was set using a test patch (not upstreamed but can
>> provide if needed).
>>
>>  - Root port UCE:
>>  root@tbowman-cxl:~/aer-inject# ./root-uce-inject.sh
>>  pcieport 0000:0c:00.0: aer_inject: Injecting errors 00000000/00400000 into device 0000:0c:00.0
>>  pcieport 0000:0c:00.0: AER: Uncorrectable (Fatal) error message received from 0000:0c:00.0
>>  pcieport 0000:0c:00.0: CXL Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>>  pcieport 0000:0c:00.0:   device [8086:7075] error status/mask=00400000/02000000
>>  pcieport 0000:0c:00.0:    [22] UncorrIntErr
>>  aer_event: 0000:0c:00.0 CXL Bus Error: severity=Fatal, Uncorrectable Internal Error, TLP Header=Not available
>>  cxl_port_aer_uncorrectable_error: device=0000:0c:00.0 host=pci0000:0c status: 'Memory Address Parity Error' first_error: 'Memory Address Parity Error'
>>  Kernel panic - not syncing: CXL cachemem error. Invoking panic
>>  CPU: 1 UID: 0 PID: 146 Comm: irq/24-aerdrv Tainted: G            E      6.12.0-rc2-cxl-port-err-g2beab06a67d1 #4414
>>  Tainted: [E]=UNSIGNED_MODULE
>>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>>  Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x27/0x90
>>   dump_stack+0x10/0x20
>>   panic+0x33e/0x380
>>   cxl_do_recovery+0x116/0x120
>>   ? srso_return_thunk+0x5/0x5f
>>   aer_isr+0x3e0/0x710
>>   irq_thread_fn+0x28/0x70
>>   irq_thread+0x179/0x240
>>   ? srso_return_thunk+0x5/0x5f
>>   ? __pfx_irq_thread_fn+0x10/0x10
>>   ? __pfx_irq_thread_dtor+0x10/0x10
>>   ? __pfx_irq_thread+0x10/0x10
>>   kthread+0xf5/0x130
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x3c/0x60
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1a/0x30
>>   </TASK>
>>  Kernel Offset: 0x29000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>>  ---[ end Kernel panic - not syncing: CXL cachemem error. Invoking panic ]---
> ...

--------------ZCqoTved48uVI4k8I9sY9cO9
Content-Type: application/x-compressed; name="cxl-port-err-test-patches.tgz"
Content-Disposition: attachment; filename="cxl-port-err-test-patches.tgz"
Content-Transfer-Encoding: base64

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

--------------ZCqoTved48uVI4k8I9sY9cO9--

