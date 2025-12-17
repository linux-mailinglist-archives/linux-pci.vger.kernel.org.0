Return-Path: <linux-pci+bounces-43207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2BCC8BD9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1CB30E9741
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92BA2459F7;
	Wed, 17 Dec 2025 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZxEaIZ4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C372256D;
	Wed, 17 Dec 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988182; cv=fail; b=GWaZ/i2vHZksNUadMI1sucmOqSTA81iUbK8sx4+DNdXznOUkcsF0q5n7R3yojemxtK/r5Rktala17TRvneyS9mUNH+ujRsHOSdhRSo0AqYaN4kjfLoxv5htAh8bpjWLWOreotr3q/pcli2cg0XSy4Wx1ttlD0/ftwbYO7laOeZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988182; c=relaxed/simple;
	bh=Wi3PztltAJVblpNPxpIzdK51kiTUzNGPJq7rKSZ6lgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YdHqY85cN0QCa90UlxKd8iAudCrnaGOo27/Fw/3VEqJJnHZZksMWdDStCaEajYotL7O+jTjdMDmjvqyBXKwTID31dYJmRz5x69SOKHGLm6Q4PDehi68ejfJpViG6/a1zhQZ7GWho5BqlqhY++vkd6Q027O1lA+5+8hL4z/oF5WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZxEaIZ4p; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Odynd59bjM35qDZ/3BmY4Y1T5Wk43ruzgiri1OxAp39QL+hswDLuUo6rwcShTo7JAFYu3uYUzfk5FJbijNFNo3ZOMdihubQlOsK9hqfaXVuhyXFunwrV/uuzWJMnLVo7JbPD9az3omCk5CLeaFwqEjU8568eT/7b9YMJaII6ZFmS1A7Z3RwgaYpJqxjomLfSoA/C/qxoYI8sazeRcp2ZrxglRcNwomBFuc6ZaCHPal+W2f+oYKCNV/NmJuLjGjybTYDuiyFcqRsb/rnLW355LqDKIigebiHG2C3LwNrPf16gjH0wDbYIlBuIGVZxLtkGGdy9ZU4aJsli/TpK3KXDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9Q//DVOhol9nP+XeAWvlib+DUsWKnPx9GUYYBNSquM=;
 b=dsuTqFopnZrRWqfU4PseufQUWCs1+XNCGlFw9KS2pB37gV6W6IBVtF4Jp38a6Pe4VcdtN0j+ap2JVd0aDBjYkqCFj7ssjFw/stEq3/EvwghAqTbQQu6WtlJG81iBJGxOt/HJi/6fDKoZ45ljixUxJN08R94Gc9FXci2Ory+6wGooLbWcAW5UzbP53HJvB5R7PnZAyvywIROURC1htqQ9F62rESosdiVM4uzp6vLeDvzRbTFWc1AuNnGNNrhnhDTU8Ki8di3b8B3i4adovObilCJy4IT5VcZCzyN9aLQVsG/sqckbnSqUUsnSl7TE0zxLE2Hj3WBJIx11zY/W2iNiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9Q//DVOhol9nP+XeAWvlib+DUsWKnPx9GUYYBNSquM=;
 b=ZxEaIZ4pR0Y5nKtmOM2C8doSHyt0+Rol1uzijwZToWX+K9nmXmyCBkzkmhQF4Fh3kxCht+4XL1r36WsEaWdW8aOmtw5/y+VvKqXs2cH1sOj+Xe4ASWkx3mSRI8RKywTEydOLtDoX0ZoGS59nZ5DaFIwqqAXV5M/8R5iG6fYHz3LoZ14kwieE4hJy821aTDn+QG/wNLJtAKWP5R6WME2U49h055oBdJLgH7EY2o9NzUOfpuNrQ9UmNFl5QEb2lD64u5NpWlLkMQBa65lDZXqfKmo29C/43CkLkRpBT4OshXiuelIchgkaE3zDHN0MixIu8jkScpZHOcN0M8g31tiEwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:01:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:01:34 +0000
Date: Wed, 17 Dec 2025 12:01:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, jammy_huang@aspeedtech.com, mochs@nvidia.com
Subject: Re: [PATCH v2 2/2] PCI: Add PCI_BRIDGE_NO_ALIASES quirk for ASPEED
 AST1150
Message-ID: <20251217160133.GQ6079@nvidia.com>
References: <20251217154529.377586-1-nirmoyd@nvidia.com>
 <20251217154529.377586-2-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217154529.377586-2-nirmoyd@nvidia.com>
X-ClientProxiedBy: MN2PR08CA0020.namprd08.prod.outlook.com
 (2603:10b6:208:239::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 70992ee0-7da8-4a89-63d8-08de3d858d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?F8xEItcBSkcRyAphbaBE7ydOUQuvNTLPqQhkBhn4Bu6G7zNToIcvTGKkEjyi?=
 =?us-ascii?Q?CESHTMhJERs3Y0V2HTSwDIegCHR1iH8UidXwCK350Pw2fl8Gn3HNpHFIUnLu?=
 =?us-ascii?Q?iI8XXwiNkKnEqrOQBDR3R6y896MChL8ayuCkiJcIf7Ahg7TvZeG8aukQcVkF?=
 =?us-ascii?Q?ViE67OU6eXlzLl4hJ8S9RdsJdNkrERLiT3bHgX5jlc5MRS0NjHYPSZKiVLMw?=
 =?us-ascii?Q?PfKLbvrXgDcvLwYBHjmX7jVWpu/1wPzC9MYwN26bJmD5feTZfHoX9itnvnxa?=
 =?us-ascii?Q?ts609Tpu1F7IpRKNJk9FcFG7m1m1WPgdBU9Za9xrK/cuQa8BFrUGZrvPy4E3?=
 =?us-ascii?Q?/0dAsbvM0R8Xi+dOKY7cAtvPlwy8hiKSRbWVEoH1Gkp7DoQYc5rCBFxa/P7K?=
 =?us-ascii?Q?rIhPmJetJ5KJ+Xw+LUw7VC2o3kphmoM7l1wumA4+nRXZOg3k9JvMm5pbwoaA?=
 =?us-ascii?Q?Taj+SljU6nlx2KOx66yJmtydFFEXpFzKinRfI2WY8oM9fWlJiw1UGSL0XexV?=
 =?us-ascii?Q?EXh2SkajzzUEoicWkNH5cvg99sQgBF42+HXa9LD9LrxbC59SxiIP7CIBGB7/?=
 =?us-ascii?Q?dKBOUoUZcL0de3A9Djuh3X2qQz5/3y9ps/ASwXE8tRaC4mzNmhTdQ7K+JsYP?=
 =?us-ascii?Q?fSC08lXORRAykt8wwkxqG3qtUjiBNVJsijAbEDOxNwTso4ikOeBQLKR3CJRI?=
 =?us-ascii?Q?tnW6EQZODb6V1sgqrtr1aG7K8zYTq4NONjx4I45FMq4C1hAPc/3DnE8kkuKg?=
 =?us-ascii?Q?JJAjBLOUlmV2K9HEBzid136uFI+LBM9u8Cw+XJjfx05OeVGrXX0AF38YEucd?=
 =?us-ascii?Q?/OyZzN2K9BuW70SWwGCTh+Fb3nXDodkeHnvo9kMA02wHdtoKUpRh1Oii3biK?=
 =?us-ascii?Q?ioUT7MofGb4EWZWtbSuD2gdgPeuN4wauqQ/ZZ5VikjgRzBt+3YX+Hw2/n6tR?=
 =?us-ascii?Q?jLdQ93TqWt4bGrIkZUXnoYP74izyqo3829DPd/cgS4+WebHWCVUALmuyHzqp?=
 =?us-ascii?Q?LeU1Hj+R7oBXr0otXjJJSB0wTaHapiOwJa0IX1tPFTaw20mJ5tWsmU5XChxz?=
 =?us-ascii?Q?JjtO0+GkyyoCtc1QpNueoqzq6fVxJ5CKI6h1T1ogTj81XnhiHruVcOwWArkd?=
 =?us-ascii?Q?mdIa7ABxWdqG9YG5RLwOguPlU4e8Y+TAC3F1Zj8N8OrJH35umdJ9dTf2wCsX?=
 =?us-ascii?Q?gMYVcL6XwAlUybkV8X/gjocQjkxeIIyOzv2PYln3r1PRk5O7Liyj7j3SbuAR?=
 =?us-ascii?Q?xoZbyTw9MQgFgt6HTg6bHZLbd5fc/XtdpvLm9FjBS5d9US2/D9My0oH8cud2?=
 =?us-ascii?Q?roFYBOMaFubAJerMVCe1A8uXgaUr0DtheiIs3DCSa19B7CvvlgqLtYMvNhJO?=
 =?us-ascii?Q?Ze3OAFgy2rf17+0uIJx0aG7hxavhuN6XdEQcJw7J8D8nt6knjyWRmin9nLZD?=
 =?us-ascii?Q?9d6Ov2yNMu3fwKv+6IlbjqFeOSc8I7d4?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?3ACMxF1tGUdPmK9b2CnWHGB0r5vG+YEcnnIg2OIzirnBO4kG5vP++2GBdMbU?=
 =?us-ascii?Q?bKuJiqgEaNeZLyx/5V4RFJOI+UZmuo+j38vOyVlV93yYdFNXAL+LfUGaYYTY?=
 =?us-ascii?Q?6FFF6Zj1epFqOdOnX0kKUd3g4fTgXZeieFQVm6ApWE2PpxsR971VfbXZyKIR?=
 =?us-ascii?Q?d78o2UNIq4luF6zKaYgwgJkEFrRAb/0zygatHPlq9kzMUZaQWoOYC1zY245g?=
 =?us-ascii?Q?dRHxGL5duT8N6RqQRLZOihSxbIiQz3b1bToxOraZnvnJ1xewQnRXCTyhtqdj?=
 =?us-ascii?Q?jM3hiFIX4yYcG14LgJpO19kunqsJnZELB47L/ICGHGER5U7GPJVmYczyoEl8?=
 =?us-ascii?Q?yJjscGLOOoywg+RPx8DeNfBPPfqPSvB+SKkiWAJ9KI1c2NjsjQkapUfw4gPQ?=
 =?us-ascii?Q?srD43EPnF2Caj4q2c73ymwfSXSTQRDNTfzCbPJKJix6jyOPhh6GQKdfabCZu?=
 =?us-ascii?Q?q5qNxAvq6lOyoA7Ko77tmZB3E5KBfiI3HV2F8W8C98RWK8L7dbPOxUsJK0om?=
 =?us-ascii?Q?bbJmVC9S1jpqPHl75zHmauSDcYmgRhqsRXWF2MbVhbOv0TbruyvYh9vZL+9T?=
 =?us-ascii?Q?y033Q1dUQlqvvizVjOJ3x/QIvU9gFOidNbVUU8YXqMyiMj3dMPkOkRkX0rU8?=
 =?us-ascii?Q?EPMF7OZL55bkkdSaKM8Bs9AZIV1li+7BeGzofQh5Cm9MUz1J3BOGRw1cnhvs?=
 =?us-ascii?Q?3ivXu75AwIGULNbhpbeoj3HLtFNALqX9HRUiezf60UL3pAlSHG3t6yvPBCJc?=
 =?us-ascii?Q?N5Mbe9TH0qqCP6TQmeXIdtndbjovQw5vC/2SYzEjZ5Yb0Q8eoCgLSElfqeIH?=
 =?us-ascii?Q?41rGJ6kn3dwScCB3Njer0x/X043KTeO5A1+XsqXvUEeO0Atvb453dy0XCIBb?=
 =?us-ascii?Q?5WxKTQCq5NciSr1RXjvATsTatAjeaKORKbZjwoc7HnK/7SkYHuwo8dGQ3aIw?=
 =?us-ascii?Q?xtj3wj9S9yuGvfQX6qG3IP3TzPOJ2RNfqmvLd9MHrwedMve23ISnWBUSZAZP?=
 =?us-ascii?Q?q2eaAt+3E9U6qj0ecqr0KJja6GE46auOofcRnd/Hs3lW8siCwjNl6DLRYskP?=
 =?us-ascii?Q?+2tBOKOUrXhsPxabNs5dZK86jml7Fgqxge1CSOxBmEIrxQML0Uz4k3/e7Wr8?=
 =?us-ascii?Q?sHdVV/WcZFrw17J4cpWyy5xl3rfUy7hF7DptNdueftQTQlbUyST/J1nzU/i7?=
 =?us-ascii?Q?3ZSB/ILyWO934LEFIR+s5utAjJe0VO0opUdP0lq7MYSrZqbvFk4cDbNBrX1V?=
 =?us-ascii?Q?SdGgvJwMshJnPPcK/mK9jIMSlrkAVcGoiz/k2ZRZIW0k9AJwkuQjX+MTwGtS?=
 =?us-ascii?Q?g/z96iQ/cLUjyHnkk3Vf8NguEblxBPCRzQCUQptIC1YxOwa5Ji9rwh2Gq8bz?=
 =?us-ascii?Q?epAVAW3fda82KoSLo55QTYZS9KVEe2iq9O3Gab/oGGEPPb4ZFfgie5kVMA9a?=
 =?us-ascii?Q?pP/PR07D7iG4+R5WAuPwEHmud+qv9HDkNg+7oHYQ5Vjd4j5M7M99AwfomH9O?=
 =?us-ascii?Q?Qm5gWuoLgSZTvUO/mRJaH7mtcdlTC+GwV/248g63901DQs/5NYt0PCkr09LF?=
 =?us-ascii?Q?g0NrCsEMZhW4Z56pmjI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70992ee0-7da8-4a89-63d8-08de3d858d4a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:01:34.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxgnsIc79NWZViTSSAvglsa6xsBd4MVBaOKdfHJHJYjP+IdWV+r5Z8upiWtCFUaz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347

On Wed, Dec 17, 2025 at 07:45:29AM -0800, Nirmoy Das wrote:
> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
> bridge that causes them to share the same stream ID:
> 
>   [e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics Family
>                                     \-02.0  ASPEED USB Controller
> 
> Both devices get stream ID 0x5e200 due to bridge aliasing, causing the
> USB controller to be rejected with 'Aliasing StreamID unsupported'.
> 
> Per ASPEED, the AST1150 doesn't use a real PCI bus and always forwards
> the original requester ID from downstream devices rather than replacing
> it with any alias.
> 
> Add a new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag and apply it to the
> AST1150.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
> v2:
>   - Use new PCI_DEV_FLAGS_PCI_BRIDGE_NO_ALIASES flag instead of
>     PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT to only skip aliasing at this
>     bridge, not stop the entire upstream alias walk (Jason Gunthorpe)
> 
>  drivers/pci/quirks.c | 10 ++++++++++
>  drivers/pci/search.c |  2 ++
>  include/linux/pci.h  |  5 +++++
>  3 files changed, 17 insertions(+)

I bet there will be more aspeed devices to come, but this is a
reasonable start

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason

