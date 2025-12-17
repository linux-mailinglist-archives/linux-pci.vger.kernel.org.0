Return-Path: <linux-pci+bounces-43239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1BCCA125
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 03:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1162301A1E8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 02:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A210277CB8;
	Thu, 18 Dec 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omw7lPak"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBB274B55;
	Thu, 18 Dec 2025 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766024351; cv=fail; b=Rqzsqr6M5vjg6aw4JkeONNYx9fHOAVbYFWmxHM0fvJ/fGWLh548JzBtjFhzWXMHA4/F+107wfMk8YzkO0k0IHpNnazU6CdXhJSU8g0p7SFdZ4abniAmvLGYSAXdywyXr2j/A5GXLADs9GEf4HnqMGVcqfkA05hMC/CDh7PzflHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766024351; c=relaxed/simple;
	bh=k8Ehoda6h5tcsD9iTv/R8Zbxzk+F3xR0YiKLsN9qiXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A6nKV6DSJR8GfO49z7ssle49G06K+Z07XhaONeK2IPAeIOApYwcnHfMPBW5oEhVMAwGdOMrmHYtzKihosK1TGDpBR6b1w7YhiuUHO0Kl1JHkrbuzQKyX2IO91W9+ncAz+4PxSSj3B0rQu06VuLGOMrnycJh9LXl72527mhl7Rqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omw7lPak; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNfH0DYpFYtwl/16RNNZS1HnJsNasSBgKiw8ZYei4g8td01pqD1BUZpAWaxEvVwLXK6gMRcz7FY7JFaVQGqwZmDpByw5+MF4cVP/ZRLWZLh6TpuKuUWizi23Gji9lgioMVHqZnlw+DswtZfzzVN7YHYwP8tx/tFQ2BCt+k0e2AR7GoKzU4WEjiBh2wKGjMisl3ByIk6+HzWt4eo5thf0/a7K2MFgm7CvB4XzlrycXe9erAnAoHJLDQVKW61fI996rosJX6X6hHbiDZ2xWChuaP0+7eUnFAR0fxfDk+uXp5wKL7A7wTYhfIYCX4AYTAeo1AmPzbQ1uAgTX9IPmW9HgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqS0ouOtnxsiUwxrfY6Jto+jgkQn/4xgDBJNMOqVZPo=;
 b=fM/wyPTbsOZvDs8L15SjoRSQNqAc87NlNdkJsQPxAbqQ353XYXOo4YZ7s4/47Ss0bh5630MT1GQIWVT8HsNNbn0Tc/ucnWVDkGdYYbvuUZ7+3URiaCng/8E2emteS7Os28p+q1otQaTW6UwGFeU6e2cE4xVzPezm2eh5BBh55OF4Vrb4d0T0Mlnupe5bGsA2Bi4+7V5aoPqzU8mKaAGxtfnlhrE3VylxVYrJtQSpRF3pBnfslFaDMAJKKA6eqT6acimQgg0YRUNHRoinIbGG8awHXTnwS5b6fLC+hx2ushnGzRnWU3BeOuVuz9JaXHguWmsh3u1N4iZ8RldtxFrhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqS0ouOtnxsiUwxrfY6Jto+jgkQn/4xgDBJNMOqVZPo=;
 b=omw7lPakWHy3g68jwglzTeBknWeOxLx0O/JabbBkLioS9fu2MixzWLqZ1x+ZNtAoQMxpl8oRcsvc0xuAqgwDuMWbsdlfxEttc+llTBMHExOuxkwJPxI8foxhBOHra+vRDplsWAf9tQCnZSke2FJc7psrm3xUq5gB0lrolwEb8RmHj7fTwSVui0ylT2jt7xaMuCoE+Xpkv3L1eeBhU1XdodVHFA3M7S9lnxQkM93Y+cFZxhd1vPgqzfA4KKzbWzir2cFxCt5DdUDfUF7M0UjrK64wL++oaMF+mGv1o8jzwQkbCvNNHxK5GuORct4Y4MlAncWExjVsx1xT1icknL72gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:47:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:47:23 +0000
Date: Wed, 17 Dec 2025 11:47:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, jammy_huang@aspeedtech.com, mochs@nvidia.com
Subject: Re: [PATCH v2 1/2] PCI: Add ASPEED vendor ID to pci_ids.h
Message-ID: <20251217154722.GP6079@nvidia.com>
References: <20251217154529.377586-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217154529.377586-1-nirmoyd@nvidia.com>
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8c4c69-feb0-4140-f98d-08de3d8391fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?H0cQmfX/pICX3Y8aAFJpEQqH4/jcPEqSLxhLV73aev7xstBUpgLJsvD8SjCZ?=
 =?us-ascii?Q?0FuUAayhNEoJJbhu7sPyEdVauD0QW/YZV1lkNVcwSPgurUgOhW/YRG5YInOS?=
 =?us-ascii?Q?62SUPYLl73vynSAhfggn8tjgbEErHGK0pY0UhHOL/XOtagLOyATHjwXGejpX?=
 =?us-ascii?Q?Vr4ysp40SwMUqyhz2LKdJQVbuoWBj4heqNRfuLsxl98HCU77UGoPofywJ72g?=
 =?us-ascii?Q?8YSfNsx7fGa4cuE1lRNbNlfyQu11/ap7JYpR4KMmwpoFOuE+8y+rXinNocRM?=
 =?us-ascii?Q?Jh9NKwwWWlZZrSH1gOAZyCMgPN1iASvlYDJDhzRp0w2P1292hpNag3MLHaz4?=
 =?us-ascii?Q?qlyXzh8hnahtuzwPZ+s9dHIwPzFb7k5ZJW3RLX6exKOqjWw/lrwF93pZOGSz?=
 =?us-ascii?Q?+VtwxDpNmpI62RZk3ooADNlmgTcLUBHoSxBCa1GFCFsJgAYGJVNSxWrX9B3j?=
 =?us-ascii?Q?kNJEsvwuzL0dmlsCMI6SukGCNgXnf8wDtyw4MrarLwJjLrmnqQ98DZDZ+H8f?=
 =?us-ascii?Q?qY+ANDAzz7tPg2oN/x7oIUmkL9ssXtqlEtv5r5S+K5itfN+eH6z5Alz6jo5a?=
 =?us-ascii?Q?M08Gh34R0ZhkTYuixw6S7a56CNf8Gxywnl7eHZ2xq8+PWyLLeHwRGKtQ/OON?=
 =?us-ascii?Q?MhiOqOKVF+lzsobHRcpoBrgMQ78yhKKsPd2qoqzwfFsu+icGqR+gBv+8p86b?=
 =?us-ascii?Q?miNtq8xiydyuDMEwyMduUHJGuNDhaKoLfC1K7y0LjODGNuIpRgK1BH3Vomei?=
 =?us-ascii?Q?Ej1OfdQnnWpO5lFCPyzB6k6iydy/9zA+gxHq8KWmsgCXR5YWH8GvphDckh1t?=
 =?us-ascii?Q?PTOBF0rNFUSgh3cec1teyOoPrQ0SrfygUzu3oUaXJKmWdAb4C+uQYVOAP1QV?=
 =?us-ascii?Q?qj2mv42N/Y0qbHtaYCHVIRtcfUFr7G5jCSToULp12P5s2bWftKPwCr6hLdmH?=
 =?us-ascii?Q?LGVTij1A7rnY3KKwSe21opv0RVhUv5mr50WPokS/Anu2OH+/ZbnXtzSuEipd?=
 =?us-ascii?Q?OmJUXB9ZCA9dfGpAxuVHQjtwH5l/uDR6LkV9pROUcJUXVpuK1gUF91oGI1lo?=
 =?us-ascii?Q?jynmDDKI2LwG7OaoUY8vXkro93JybodaN49SMSjF8Tbfwvo7Z0qyqtH1vEN7?=
 =?us-ascii?Q?D9K8hfsuG8kshPKDmBR07uJivKJIqI7cONfUGUxRDF62Ff4lbcDi1lMdVSwm?=
 =?us-ascii?Q?m5RyUGWpHzX0kXef7bnMVN0piau7WLm6H82mhROFQ0H/yyHjgd5WY1dmL8VI?=
 =?us-ascii?Q?eHjjiiIynx8DM1ecROq1Fg/9uQP5yAX8Up+GXTUiMkiBmyHV1FJr4V0GnpZt?=
 =?us-ascii?Q?QeW0APOtFGXve6VtMBn4IaKRPAOygv/vK/M2/x8dE08Gc/VJA1iaIJw298+p?=
 =?us-ascii?Q?0M+Xp5U+Aeds0F1SDQBwyyckP+LnETiv3gMp3NS2RbaLhZs7y2gc7hFXZIZ+?=
 =?us-ascii?Q?Rpwy069pYURtjTk66MRMtfaRZcCLqQYW?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?/MRh3pakr4nXUaIKFnqZgQ8MOiwAWXjLozPX5RP6hHg1zsgqfqhkavDmTaVb?=
 =?us-ascii?Q?ZyktrdOOq5tOWuByMFbppE4Uncg2Dfccqz6fw+wTS2QbDwUeGhTtY1tkLkmi?=
 =?us-ascii?Q?vw1fuJWPkr3XOFL/LKAhqWMl/Twnu/t486zJXGHCRvu/Ec1SyEmzTtOF/ThC?=
 =?us-ascii?Q?QjbYy7J/9rC16SPGFvzcqy+v1rFhK/2NgbFF1pB51AAvN7vm4ocF713hCgFT?=
 =?us-ascii?Q?5vu1ACZs2kj3ttH4meYKUeRZ2CoPPGP0/HPV/0wuh7TRFA+WUj/0O5C9gBTS?=
 =?us-ascii?Q?CnA6tVN0waKPdC+x2/CmVgnxnojOZGTBA70smJO1cbbFxqCbH+DCC9XMNVh7?=
 =?us-ascii?Q?K8F0xqcwKjJ+Z6ZrKk8nMijkYreWm4B/ChULmOMZwcmwJ9A8UVyomJV7T1bM?=
 =?us-ascii?Q?ujSMrAgmRhzOiWQf2QGDMs9Fvmnd3wfu/KpTV/MpqV8Y0F/cypTL7Er3Q652?=
 =?us-ascii?Q?QFbeIqLtbAc1tmramJsIip6tSsVjaL0ETSrQpv9idA0RMR69W8xqdxfRCGxs?=
 =?us-ascii?Q?7ZbVRqJPgC/6jmfiQGwqTmRJaxxKgGaET11kKf6igFpqkGpkByn/A1kFi0NV?=
 =?us-ascii?Q?uXoVDKUc9OjtqrKU8WXKM4oSzuLpKgDV8lLgUi/uzKrBcTxLV+gGwAlw7wi/?=
 =?us-ascii?Q?GQDst6rPvdAPLReGwJzG9iju/M1+k8QNKmf+D8nmPLMAwRw62D2MewtBDgCg?=
 =?us-ascii?Q?8uSWXOOb++aayXviRYzfzysTyIEeRAw3BqyR0qHkRGlHy6T/C4lfbIJHLDre?=
 =?us-ascii?Q?BmQC9IjN32Fryc7P2pMzTFWVOOfD9drO5JMe5Y8rjixfxndR4sr84BcwuJNy?=
 =?us-ascii?Q?tEWQvoPwlT2liyZ/XnbTHsE9PQKyxSiigMvoEDeZy8wuPoHVMXoaPxmJSnbR?=
 =?us-ascii?Q?d7HtTAC6IzcvjkdRQsosumEAMb4OlYtsI8xDQHK/F3jJPoTYpDRqZtuGxoMq?=
 =?us-ascii?Q?uB3zlMk0p8024r00ZIKrTIRdYSeyTniiWqrLVRoHNaohlapvjFf45Tq/PIkW?=
 =?us-ascii?Q?oMfooKnghdv+eIgECoLtfaKn+xRgZ3AZG43lKofLXBUmixIW39aav9xI4VmB?=
 =?us-ascii?Q?2qm2CpblzHgnePRCKkssedRTNSbgTnWEhLGggnPQaie/euuF62yOdqDflOmf?=
 =?us-ascii?Q?U89UQqp+PDXXKy3BfEt9JcqEadO4AsxFTCCc2P/uLlT+m94M8wpIsCFRrXYz?=
 =?us-ascii?Q?T80sJwxbO7/Gn/bhYA7m0C5elI6Nk+ZB/2nFExvV7R6lemv77NL080V0ejm3?=
 =?us-ascii?Q?mu97PHlJLhnRPi31+huudE1SjiTbqGOW1EAoW8LLv//fQ4b3zKD3vZ1LWMX5?=
 =?us-ascii?Q?XMZgcXODBkHxFsB/vX2deipv3BC9Xe9HZUWdWHm024UbOQIZSlOrQR60GDwo?=
 =?us-ascii?Q?HTbhJn6AYqdFJDr8M0bvM4Wp+HTyhAvLkcdCDxGAfEszaVhQoX5aeyTip/mh?=
 =?us-ascii?Q?yT/cflf4wwiJuE1H9I0N3HJN416ctj2uJ72DgaH3szeqScdycF3e1pxehbNx?=
 =?us-ascii?Q?P/utEHPeOuyy2U4AliDvn/TM6RgiN5yP+EDxGfFpAIUPsjECqLd1pAUb1IIR?=
 =?us-ascii?Q?FoOhsUuJe5LNru48O9I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8c4c69-feb0-4140-f98d-08de3d8391fc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:47:23.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLBCSL25NlukLDmNoG/L9QpbgDkOkK8RCvu0fNh6Xpqz3Ruz+WUlkkebuBnJPRNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

On Wed, Dec 17, 2025 at 07:45:28AM -0800, Nirmoy Das wrote:
> Add PCI_VENDOR_ID_ASPEED to the shared pci_ids.h header and remove the
> duplicate local definition from ehci-pci.c.
> 
> This prepares for adding a PCI quirk for ASPEED devices.
> 
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>  drivers/usb/host/ehci-pci.c | 1 -
>  include/linux/pci_ids.h     | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

