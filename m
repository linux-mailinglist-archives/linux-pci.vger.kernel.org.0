Return-Path: <linux-pci+bounces-19063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7BE9FCC33
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 18:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64C718831A3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F111D357A;
	Thu, 26 Dec 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VIl+Xy7Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0D1494A5;
	Thu, 26 Dec 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735232845; cv=fail; b=Oolask/mF/FzoeroX8s37ZDeatYQfoKey2IJsvJVVb2BeuNxKA6rpeKgDrVj8WhjVNnLqcoLLLfWfOXJU+oxf+HXJaC5RsOWZS+rL9uDWTtHZkx/KYWlqOEpbRB4LdPygZb/Bk0hDqtIs4LgWqsZDXZORRgekR4ivG7ROemys6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735232845; c=relaxed/simple;
	bh=7pSZ7IVFUfWtP5EKnOIk96f2fzYktUjxJgfoLIY6ONU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BEd+4JcIRSxNhjM6OajQohzbejacyjnMy8z/6JCdgnJ1dq6mdzwCa+K+8ZC9uYbJi4F3Q9Km2KR8n0cMMHnYWKWXc5gP5DKih7EAq2+QX5MIxT3hU73y2ZiaMdz+E1kGra53K5/hjeeTG8kdnvoE/twT8CSxNSyA34ifmBY2+wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VIl+Xy7Z; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2sDFl/7hku0YfkTndMY3hsednXKCsD0nRmFftoqd+u8Y/Ucev5YcMOPYw+uOpY0uduBqL/LkiHbGqxJ9ZxndeIF7ahE3R6hzCOr9KBCPK8mwdE0FNdXc0blW3PJmINRuzvw2PpdfUqmWYK0lgcYqIJmgPq6vp9GP44shlTzOEtu4PLBpWR2M6mmKZBQLUbqYZ4pGXqsKan6oXPFpO+Lv0M7H/FdV2fRJayBEHupN3w3KOwzav4k6Vwf3XC1iDyPcExNBjtTaXErmQUu/hdwbPY7UEpdVzV0Hevx9ljB3fvHmtuN1/KMxwSkS/4Udh+w9IcEu5p8qiGeHawLNq3SxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4mzK4Vn5p884URO3yeCGq09ZQlmwgqZCMRZLCB3zhQ=;
 b=fTE4iCng1+Yg1Eb/USYqCV1bBJpK6UsPuiv5kmVAb4miyIeIUBOn3P2sqaI121IW5dKL02ngzsNZTzNhOH8rh1bDcOLF5hnvDU4lveDSxEpP1IB8foyX5Jow1uuAoIKPsuUbfjHhlhaoKfxTwUNvM4kR6Np4t20zBKk7F8Bdxb9/5qk5GwdlXlnZqOwGDnx1hAPH+n/NkRsJE2WIWXTU4lrYNFfJFlsFCm/gchlDFK+tv6VqDHqiLJIkwx5H7/AgM1lk8BA+hK08WDPDrGkDvdlDj72Y5fH11bcFSHPYzSOpB9gN4RFyS6FsyQINWN9/aYiSBPIaKO6MyLYT9/8ydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4mzK4Vn5p884URO3yeCGq09ZQlmwgqZCMRZLCB3zhQ=;
 b=VIl+Xy7ZRs9RYlN50x2DiApOwDw8REs4DTR7IbV5dqlw4kcHLEYrfMdjYpihuFPhWZ+hMW84xmPaxSvfPLton2PJAnHCKzhNsXUxmEH4PkYYk4liRMzzdX23ocsxnbu37CrYbhuMO2h4UYXjU/rqaALSqPNNTXrwRYgVwTErfBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.16; Thu, 26 Dec 2024 17:07:17 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 17:07:17 +0000
Message-ID: <0d552424-150e-4b92-8326-0fe6387e0ce6@amd.com>
Date: Thu, 26 Dec 2024 11:07:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] cxl/pci: Add support to assign and clear
 pci_driver::cxl_err_handlers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, Li Ming <ming.li@zohomail.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
 <20241211234002.3728674-15-terry.bowman@amd.com>
 <20241224185000.00001a5f@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241224185000.00001a5f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0099.namprd12.prod.outlook.com
 (2603:10b6:802:21::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: a6aa2cac-4398-4a97-7989-08dd25cfc029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlVNL0JYNHBUQmVycGQyWjJQeU03ZEp1bGhVR01iUUJacVBlM2ZoOVl6UVR2?=
 =?utf-8?B?M2ZabUVIajdZZEJsMVhYN2hUUUhEenNEMm03SjI3NTFSNytUd0oyeCtFOG1E?=
 =?utf-8?B?SGpyNVVYbi9uNERPdHlUSmZzeGsxSi9hZGlKYk91WVpuMDl5T2dtN3ZlSlIz?=
 =?utf-8?B?eFZia2RhZUxTTTZETWwxT0tVY2pqby9zMm5tL2ZxSWRVQTczUC9QdnFQY1Zr?=
 =?utf-8?B?UFE2anpNeUVOMzdWZHMxUFRaNm1vYURQTEVaSG9jYlYyNE1qdjE5TFVRcE9z?=
 =?utf-8?B?akVzY2gxYTAydm9mdUVJQnZORzFwemFicXBXV2tLbk4zQ3N4QlFIY2pheFVH?=
 =?utf-8?B?Z1ZQTXVOSDVyQjVtbmhjVGhtTFptKyttYTdBU3QyeEY3SWxQR1lpR25CUVU5?=
 =?utf-8?B?UUFCME5FeGZmZGFnWmhEaElMY01qdENqMVJmdHFLZnB1Y0VYL1k1MVZrMDVu?=
 =?utf-8?B?UG9Ub0ZiSXcvQktQTXNwVkF4NlZyRXFVS0E4TjR4VkZqc3R3UVYzbFduMHpu?=
 =?utf-8?B?YmRuZEE0ck5IdXVzZG9Za2kxVnNNRG9sNklvZkdKZWFFL3RZNTkxdzAyTm1M?=
 =?utf-8?B?OEtyc1AvRExjM05yVEhTei9TdWpwZS8rckRpTHYxM0puaDRnMjhwUHhWNWRt?=
 =?utf-8?B?YjBWcFl1K2wrandOMHQxelBnOVVXcU9iNHVCY055a1RqNnNWTWtxeFdocDcx?=
 =?utf-8?B?aEdXUWlaYzFESlpHUTRnbm1mcTh3UVdTc3VBQnVhWmZNMzQ3VkxrN1VxTFpV?=
 =?utf-8?B?NEtlSXZhS1RTNitPNU9mVXk5aHEwS2VRY2JiMEVJZnZvRUZ0SWg5eThMb1Br?=
 =?utf-8?B?dFJMTkF2U0tyKzJheCtDL1hUOFdiVWVnaDdsdVZmTm12VktOSFRzN1h2RllK?=
 =?utf-8?B?cHRBelBQR2RNTnZlZ1doY0NlSDM4N2JRMTNvM2VhZmgwaTFtQzRVVDdOUlVO?=
 =?utf-8?B?a0NCUm9CeDZaZDBqSDBLZmpYSkduS3FhMFVTN1pVY0lNbWU0OVJyclR0R0xV?=
 =?utf-8?B?bHJlcTBFOXlTbEFEbjE5blpmcWNCRzJjR3Z4WXgzM2JzME1UbThHYUNtVnFT?=
 =?utf-8?B?dXZ4ZDU3dmF4OUE5UFA1Nlg4UkFWdUtIQzhkUmhEZy94YllaUXplV2FMR0l1?=
 =?utf-8?B?SkxydHpxZlRxUFdOT2xrcDVEY2UvYyt4WFdQVE40Z1J6b2QrMnF3SVRaVFFq?=
 =?utf-8?B?VG1NbDdaVS84Y1lhUUZTRXJhaE9FMG56OWlXWTQvb0FieVZCS01jenREVTZn?=
 =?utf-8?B?cTBwNHZySmkvWjd1eEZORGtjSlUzWGpudTBMNUJOemF3YVJ6R0lucmI4VGJa?=
 =?utf-8?B?UG5IZ2NrN1M2aXNNeUlxZk1UOHFyUlgvU2s0UGk0L1F4Smd3QU91OEluSWVy?=
 =?utf-8?B?NkYrWXZaRWdiVmtCTGV6Z0tvUTlmM1VHR3NMUkdRblNNVjM1Mk5kYUh2di9s?=
 =?utf-8?B?cGREdjFUTkFlUjA5eC9ZZFNzWklWeW1SaXEvRy9ZdExoU2xkZUUrMlNvWlFZ?=
 =?utf-8?B?L0FyOE5ZRE9aVGpMSW9nck4yaTBnTkVHa1pCbWVuYjFtOUVkNEZOOXhrNk51?=
 =?utf-8?B?SldkSXczdFNuTFUrS1lxUXF4R2VMMU1EOHJ2Z3Q2RTRXd00rOVUydmhqN2Ni?=
 =?utf-8?B?ajhKbTRvSDZjRlg4ODlmQ1RQTWRmbmJuclg3NlVtN3dtQmpVN2ZOMmlWSW5m?=
 =?utf-8?B?a1hpa1BMV0w3QVVZNjBmYWRMNW5zNnVoa1FRdmJZREZwRkpUWENqMGhoSUo2?=
 =?utf-8?B?NDE1N3N5bjJHY2w5Ni9rV0lqT083bzdPbERpTTFvTTgrZldiM3h1SDd4aklZ?=
 =?utf-8?B?WnVDQ1QvSTl6Z1pzaFJKaHV3eFhkSElvNHFRdVo0aEJTamlYMzd3R2VqcWlV?=
 =?utf-8?Q?uqgpDG6G+loXD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzJraVo0eWpvODlQcUVRbGJtalpzQmoyZnZVUE1qMmZaRXNPZVQrSllLb1dP?=
 =?utf-8?B?TjRXRUVVT2FDTVdsbjFZelh2SFkzYVFaOWJzQU9QZ01KREozRlFHOW0xMkpD?=
 =?utf-8?B?TEZLOHY1elh4TVBra2RBb1IyU3Fna1hkWkpTUm9raEQyc1FhaWlUVk4wdUdm?=
 =?utf-8?B?VWNTS0ZMUTZ1RW5NMnVFUkk3b2dMVE8rT3kxYU1WclFTdUtYR0UyUmk1L0Q0?=
 =?utf-8?B?SHh5dlBNNFR3U0NEZDdyOGxTTjltek15RFdMakY0ZTJRNVNRL1pPemlyL3Fa?=
 =?utf-8?B?cE9zODlyRDlMRmtrL1NrcjFOMkpUYW5vMmNLSVZYSEF6T09Qb0VGR3dIYi9Y?=
 =?utf-8?B?Ui9YMjhzRmRLYjhEaDY2OEp3bStScS9qQUF5ei91OVRKTEpseXFwREtWSmtS?=
 =?utf-8?B?eEdEcHJSSG5DOGR6WnBGdVFxd29Yem1ncmNGUi9PUFROc2dlTFVMRGZzLzk1?=
 =?utf-8?B?VWNPanBBRXRPeGhRR1JBWFpUZUdKUVVnOENjQWxITkIxNTI4VjlVRFFocUVn?=
 =?utf-8?B?QkJMRmZCRVE1Y1RQS2tONWtKdytTTUhHak1INTNPWGtJV2krd0dwOXE4dW9R?=
 =?utf-8?B?cC9lTWU5K200RlUvajU1cExsbDE2ZHJhQ2lWMHBmUmhPSTlaUDJVZVlvL1ow?=
 =?utf-8?B?NytHMXFLOFQxcmF1TUw3T3JlNVJudXNpcExSc09uZGtaRnVMMWxyMk9Kdkly?=
 =?utf-8?B?Nm9rOWFtaUxtbU9zM3I4Z1Z3enhtanVxZUJpeWR1Vm55TGtVeFMyL01ydU43?=
 =?utf-8?B?MjZLYkZicmk4RW1GbFIzamV0bXdDaWtLUkZSYTM3Mk5MeHNGQmdFcjJCaldr?=
 =?utf-8?B?a0wzb2VxbzR4d050V1NSUTRUdjZFcHdWVUVkeUg1enA1c1JNRFR3WDlRdWI1?=
 =?utf-8?B?bktXREpNNDdjUE9kakQ1UTdra0RDM1U2YVR4VmtuTWxOUWRoT1pqQ3JEWHJP?=
 =?utf-8?B?MnRmMy84c0hVWjFCU1EwUWtuWVZSdnRVcmtHU0ZOQzlhSnl6N1lLR0ZtdDl5?=
 =?utf-8?B?ZlE3NzkxRG8wNHd4V3lLaGk1K0g5MXJjZndXckFVYTJBRzY1YjFwMjZRcEZa?=
 =?utf-8?B?K013cDFPc3R5bXo0MzdrREpIQzJpMjF5NWlQaXc1V0kzQW1waE40RFp3ZDQ4?=
 =?utf-8?B?cG16UTZVaDdkMGZEdXkrcTVxbHFxQnhsWDdWUDZGaTg5REJjLzViRmZYTkZw?=
 =?utf-8?B?UU14Q3JnR1Zzek43UzdTSTkrTkNhZE1HL0JCTXJUSVI4WHdiNVVSSmtSTkVD?=
 =?utf-8?B?cFdTQSsxQmlSSG41cFVYSjhGNjB6aU9lZGFFY1p2VGV0ZURDZUhCY01QL0pt?=
 =?utf-8?B?RFA1ZHNVMlZwdk1UTGtzNThSWWsvRHNXQWQ0L2Y2bTZ0RDhqYWduRHBidU5H?=
 =?utf-8?B?U0dVVzB5NnI0b1YxRW9ZcWtOTlNyNE9raVVSSUZMenpMZnV3a21OdWxJWEZN?=
 =?utf-8?B?clU3ZTFzdThlVXBRQnZSYkNDbEc2NUxNbWx0VHVWR0VyamdsUFA2aExNc2li?=
 =?utf-8?B?WDJwLzQwRUhPbmZqSHB5QlNhMm5hT1o3MmEzblpkVUt6RkZKU2xaTmlBWHVi?=
 =?utf-8?B?ZFcvTFpsSnBnclhWTzVYbmtNWWlYazdZZXF5ZFp5bGkzMDZvMDJsc1BBTzR4?=
 =?utf-8?B?Y09vWEpmWll0NS9wamdwSWtRUHJ5UUtFOTd6UWdOVSs5YVo2Y2tSRUlHUHFy?=
 =?utf-8?B?dW1zNEJxVFg5OXVsYXlUOGtmSEx1R3p0Wm56bFk0UmlUVEU3SUkrUzU0WTkw?=
 =?utf-8?B?NTgwRDhkSHkzMkNwaGZTalFZdGFVWHBXRm5wZ1YzN2IzSWF2OHYzSURReU5Q?=
 =?utf-8?B?a2VUaHlULzdtSXg1VElCVDhzNm5ZUnptKzJ6WUZqQ0FPVUdQVEFuNWhnTUFJ?=
 =?utf-8?B?SmNpTGlFUGlvN0N3cmtDZmF5eHg1a25NYkxON3c0dktHYmQ0bHJ2VWE4ekYr?=
 =?utf-8?B?SVlwYmZIMTlvT1JEcjl5eTNsUkVJSW4yQ0ZkR09NLytvVXRlaTc4RzViZ2RY?=
 =?utf-8?B?cSt5WUpnc3VPWjFCQ2NSdXBoMVRTbTFhdFhaaHVNTjR4aUJHbE1qYml5VTVT?=
 =?utf-8?B?TmM5WE9PM3h0dkdjb0VXWmN5NSt1aGpjT01NQVhHbWRHSWIyaWlLc2dJSU5l?=
 =?utf-8?Q?b2ebDMQvdqbu2cJ9Go4g1xCNr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aa2cac-4398-4a97-7989-08dd25cfc029
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 17:07:17.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cREB9vndEkO+55fwHWz1hrvTWFZBJhaoxsuokLVh763XrNneXE8ZAw1FFMDe3Lg89aLbyPOj909hzKS9HfgUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246




On 12/24/2024 12:50 PM, Jonathan Cameron wrote:
> On Wed, 11 Dec 2024 17:40:01 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> pci_driver::cxl_err_handlers are not currently assigned handler callbacks.
>> The handlers can't be set in the pci_driver static definition because the
>> CXL PCIe Port devices are bound to the portdrv driver which is not CXL
>> driver aware.
>>
>> Add cxl_assign_port_error_handlers() in the cxl_core module. This
>> function will assign the default handlers for a CXL PCIe Port device.
>>
>> When the CXL Port (cxl_port or cxl_dport) is destroyed the device's
>> pci_driver::cxl_err_handlers must be set to NULL indicating they should no
>> longer be used.
>>
>> Create cxl_clear_port_error_handlers() and register it to be called
>> when the CXL Port device (cxl_port or cxl_dport) is destroyed.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3294ad5ff28f..9734a4c55b29 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -841,8 +841,38 @@ static bool cxl_port_error_detected(struct pci_dev *pdev)
>>  	return __cxl_handle_ras(&pdev->dev, ras_base);
>>  }
>>  
>> +static const struct cxl_error_handlers cxl_port_error_handlers = {
>> +	.error_detected	= cxl_port_error_detected,
>> +	.cor_error_detected = cxl_port_cor_error_detected,
>> +};
>> +
>> +static void cxl_assign_port_error_handlers(struct pci_dev *pdev)
>> +{
>> +	struct pci_driver *pdrv;
>> +
>> +	if (!pdev || !pdev->driver)
>> +		return;
>> +
>> +	pdrv = pdev->driver;
> What stops a race here?  It's fiddly to remove that driver but
> it can be done.  At least I think we are messing withe portdrv
> but this is such a fiddly stack I'm not 100% sure.
>
>> +	pdrv->cxl_err_handler = &cxl_port_error_handlers;
>> +}
>> +
>> +static void cxl_clear_port_error_handlers(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +	struct pci_driver *pdrv;
>> +
>> +	if (!pdev || !pdev->driver)
>> +		return;
>> +
>> +	pdrv = pdev->driver;
> Likewise. Smells like a possible race.
>
>> +	pdrv->cxl_err_handler = NULL;
>> +}
>> +

I can add a get_device()/put_device() for both cxl_clear_port_error_handlers() and cxl_assign_port_error_handlers() to prevent operating on a recently destroyed pci_dev. Is that sufficient? Regards, Terry
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  {
>> +	struct pci_dev *pdev = to_pci_dev(port->uport_dev);
>> +
>>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>>  	if (port->uport_regs.ras)
>>  		return;
>> @@ -853,6 +883,9 @@ void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  		dev_err(&port->dev, "Failed to map RAS capability.\n");
>>  		return;
>>  	}
>> +
>> +	cxl_assign_port_error_handlers(pdev);
>> +	devm_add_action_or_reset(port->uport_dev, cxl_clear_port_error_handlers, pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, CXL);
>>  
>> @@ -864,6 +897,7 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  {
>>  	struct device *dport_dev = dport->dport_dev;
>>  	struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
>> +	struct pci_dev *pdev = to_pci_dev(dport_dev);
>>  
>>  	dport->reg_map.host = dport_dev;
>>  	if (dport->rch && host_bridge->native_aer) {
>> @@ -880,6 +914,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport)
>>  		dev_err(dport_dev, "Failed to map RAS capability.\n");
>>  		return;
>>  	}
>> +
>> +	if (dport->rch)
>> +		return;
>> +
>> +	cxl_assign_port_error_handlers(pdev);
>> +	devm_add_action_or_reset(dport_dev, cxl_clear_port_error_handlers, pdev);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, CXL);
>>  


