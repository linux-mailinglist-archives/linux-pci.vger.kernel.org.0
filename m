Return-Path: <linux-pci+bounces-8019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2B18D35E3
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 14:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE231C21800
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 12:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82113F43E;
	Wed, 29 May 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="fW7MFDu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F31C2A5;
	Wed, 29 May 2024 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716984053; cv=fail; b=dZJ4yFumhLg4mU7AvzY1Z1ZWKU4m3c2k7u1nS5unVuTdkMcBLouzz1nJqPTd7UhOTtR7NFngKO9aG56nDh8URsBYJJyjD2E/pZ4nG4rkq6LEOf/SJfWQweY76pd2dwG9ffhr8fUhPjKrk02SJVArN3pCo8hdoXVMa+o5EGVz3f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716984053; c=relaxed/simple;
	bh=XnIRBKYpGCVxwNuPxJt2WfG/6iuo8qzIhTB2FyFLqTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h5TY+U6S09Id9y/ngWQMQdHJRdmnRSqxarUP1PirejZLBYftmE87oVQ/rVtOvNJcIrPETIETt9s60z2cT5We6joZGeNnv0OssXhREyB1jySHGKPOhY+paNNbK9I1c2BK8qjsCOhpOb83i/5K9Jdqx6gENXu2RZRqsfOrniZeQus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=fW7MFDu7; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDhEpyIr+WdVPBzx9MKMzb5FLIMWt50SDkNqmcUDwo73CNjMqd97DLbLSzJ1GrP2R7XctfkKsrBS4Yr6VYqH2zfTyBT523XI/jNisCSN3nXXLaoARJr4Hl0Vrb0+8EHEsbJQCeJjiTnpJaZyj+ndwNO6nnqNs/dOGHQ54ILZrjnSKAja3z85yIs71LQ6IGY5KFS8u8eh9ku4GAcP9abI92byfBvFHLv/tSV6j5vgyPjkc1zvuZ2Tt0LfsuTzmfwKkb7Na9Bs5x4iaO5NLAHeG2QXcLM/D18Nk9WmkW1qfXzdAVPdbXiGkd9Z/qbtS4u3zsg/h1mJyAYDjA5NZ+TWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctLU9HXTAeagjLaVGDHLUIlAq1/NpGiKYRUlkvjdjx4=;
 b=W1U58jCqC1kBK6lza5ULoN8WpN+6kATKaEZijSxxrgdqxmoJYXjL+8S1SNnWa1DAPHSwAKvsv0kC5iRtOQTXBv9rwEGjsCSDC6UJPFcEUrmccdlV2ocE9KkbUMlQRKFrpH2rBpHm7D9ZvVnjuWWwfvvx0u+1BMMhBSIjzt/JcPcAHeF+Bq3W1d5dHsO/IAAcoqLD8axbqaud2QMtbRz7//uXFojzef6Sv9QPBkD9jINHurVcMrkPty2nUMzJYv6cUs8sAIOKOjs9syj8X6PpB4rXZrx9XAhg1WdsAEhyCNzjFl375UbeIlfM3MpOK9xG0sFQexVtajXV/sRbJKty4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctLU9HXTAeagjLaVGDHLUIlAq1/NpGiKYRUlkvjdjx4=;
 b=fW7MFDu7meXrcz8kRPgg+JXxfetIkMzXglf1EjdNfOQyr6tB4hJ/rb2IGspekhjfNMcQLhSntF92awTYVB15g4JKQf+Q6PsfUvg1bUdTzMLJCQPy9956FeLCQkZh49ZSI7OoGrg//HSGs+3hUvgqzCT8U5d8Job4amI6gXiORWYN3Zappxtc02aoS7DJfcZO+/4oXJKFQDOTfUd4J1m5U/COoofhXG/PfVO09/Yugp2+2L6xepMEYfxgkIgLo2boXyFrfy/ShR+eq2pAJhsPiULbchTZ57Hx10J1148oAXhqoXjAPeHLli6koNgoKc7ReK0FUh4zbj7EPSGwG4uSDw==
Received: from DB8P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::33)
 by DB9PR10MB5139.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:330::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 12:00:47 +0000
Received: from DU2PEPF00028D12.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::1d) by DB8P191CA0023.outlook.office365.com
 (2603:10a6:10:130::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Wed, 29 May 2024 12:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 DU2PEPF00028D12.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 12:00:47 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 May
 2024 14:00:37 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2001.de.bosch.com
 (10.139.217.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 29 May
 2024 14:00:37 +0200
Message-ID: <fd608689-86d2-4fdb-9713-5c69d68808d3@de.bosch.com>
Date: Wed, 29 May 2024 14:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/11] rust: add devres abstraction
To: Danilo Krummrich <dakr@redhat.com>, <gregkh@linuxfoundation.org>,
	<rafael@kernel.org>, <bhelgaas@google.com>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <wedsonaf@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <benno.lossin@proton.me>,
	<a.hindborg@samsung.com>, <aliceryhl@google.com>, <airlied@gmail.com>,
	<fujita.tomonori@gmail.com>, <lina@asahilina.net>, <pstanner@redhat.com>,
	<ajanulgu@redhat.com>, <lyude@redhat.com>
CC: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20240520172554.182094-1-dakr@redhat.com>
 <20240520172554.182094-9-dakr@redhat.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240520172554.182094-9-dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D12:EE_|DB9PR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: f837e4d7-81d7-4e96-9259-08dc7fd6f9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|82310400017|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWozaWRZNnFLK1UrTlcwVnhWb3liQ09lSk1aOFBuM2FxZXVzN3dNYmViNjdM?=
 =?utf-8?B?ZzA3WGtHOS9tWUFKTnB1MDhlMUl0VFFOQS83NE16ZG1uVmdYOVlIQnBQWThF?=
 =?utf-8?B?NnU0R2piQ1Bmelg3ZmRMaHBYVUtFVFR0dUM5ajQvR296NU9DTGdpT3Jqbkox?=
 =?utf-8?B?TDlFMXI2cTZWRktkVUFaYW5BMnNDelFwZzJaUWNNWnVPRlZZOVd0VWprNDMr?=
 =?utf-8?B?cklJUlJJMTE2Z1ZBRFpsR1FhOVZLaXB2c2dwUk1qYXNROHo4V29sNTcxWWNV?=
 =?utf-8?B?VU5iZVRhSGhtMVhOL2VyMUhTNjZMTFhjZnBaZy9ObUo3TDBabnZFOXhZZjU4?=
 =?utf-8?B?T2N1OHhVQ1VodXlTOFZGZUhQUVJTVzNOeVpMR0lHRnY0NUlLaUFZM1JzNlBY?=
 =?utf-8?B?ZGRHUjBhcGdCWWlERkMyUEJaWTd4UitnMDNoM09ZQzB0RDl2aERnMHhJY2dJ?=
 =?utf-8?B?dEE2cnpXK3doN1N4cW1SY2wxR0orTmRBQlIxenRzRWZmSGwyMFo0cGpTN0lh?=
 =?utf-8?B?R2JLVXJOTk1RajVESzVPZE1wS3JnYzNXTFdrYTFmVjRLRGZRRkMwcnpUOTVF?=
 =?utf-8?B?TXFHVThVRU9KNzhiZkZQZ0FvT00yMVVJY28rL0Y4ZHlBMXAyemtwUzMrYmRo?=
 =?utf-8?B?aUErOS96SHV5ZlkxU3VjN05RdDVyaWdHQTludG1KcEduWXpOVmgrZlBBNUoz?=
 =?utf-8?B?eGhrU0lzVzNVTlVNaUluQ0N5TFpMdklnVDBUNlJTY3Z5YzdtcUVGQnpaWTBz?=
 =?utf-8?B?WHlOMmYzb1Z5T1o3L280eUtoTzdDU0NtWDFnaXBManJYVHBNRU1VckJjaHIv?=
 =?utf-8?B?OGc1aVZ6TXRJRXNxcFE3RXR3aElmM2tGbkIzSnl3QU92cVhKTmZVRUZVekho?=
 =?utf-8?B?TWxKa211dHljLzl6aUM1NThLOUc2ZmloSko2bjJ0SmpzVHB4U0lqSFJxRy9O?=
 =?utf-8?B?YklkQWZqcHc0cXkxRmRDQTFlYnZnZTd5ZUE1Sk5EazYxcUMza09RWFpaSDZy?=
 =?utf-8?B?bHRyd2FYN29hb0dCRHhab09FTDRPRmdUVkJOL25wMnJZVEZ5RVd3cUJCa2xW?=
 =?utf-8?B?UzRCMC8vUDE2ZzdRQXZWRnNiZVJJYUNoS2JNS00xQUhwUXdYMGdRdnVnSVVl?=
 =?utf-8?B?YVkva0dlUUtDbnVIbHhOVm5oVVZ6QTlwQWVSeWdDQWorVzZYK1JydTFHdlR1?=
 =?utf-8?B?ZnZ5ay9xYnJvY3hyY1dIdDZod0VIUnN5aGRuV1RGaktYTUgxZzllQ051SzNs?=
 =?utf-8?B?R2l6a1QwZFN6UUVaQ1JyOFpQdHhpWmczZU1VaXB5THpnaE94Z2ZnL0l1QnFV?=
 =?utf-8?B?Qkk0NXloOUd2VVBhWTlPT0o5WFhZUGNxRGRsZ2RZajJsUXV5Q3ljZk9YaGJo?=
 =?utf-8?B?eGZOTmpNbXIrWXIvNTFXbERmaGNjTTNFUVVReXd2S0pWT1RXYVlteDFDT0Jl?=
 =?utf-8?B?dm1yeEhqZEsrR3BPZzBBSjR3V2Y4SzBzMUh3VnRTbnl5eFRlOUlHRE1TU0kz?=
 =?utf-8?B?MnBNR0dOV3VnYnFwV0d3RG85UEFwREhVRy9vcUJOMS8rdDg5eW5HK2hhUCtl?=
 =?utf-8?B?ejJUVk4zZHhBZDgwa2FMMUFKazhRZFdwa1BVQmUwZU5BTDRWU3UvOG95T3RE?=
 =?utf-8?B?MzJrUkQ5NG9SRXVoK0JzS2JGcWlZOENWTjBaL1VpTzJhVnNTb2txL0U4TG5j?=
 =?utf-8?B?OG1acTcvMEFDVFNhcTROeVVTeDNHZnFodDBac1NoTEFOS2pIWXlWbE14N0g5?=
 =?utf-8?B?UjdjekhhNXBrdGtNYlRuNEdSQUloeVYvN1dOTUNNczdqZHhxaXhWT05PZnRs?=
 =?utf-8?B?KzlRTmZlaFdWV1lIK2xETE1PMDgzTjFCVnRhQzU5bko1QlVqWDl4RzhaTmlM?=
 =?utf-8?Q?cfasTkGAWCdr+?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400017)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 12:00:47.1721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f837e4d7-81d7-4e96-9259-08dc7fd6f9ee
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D12.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5139

On 20.05.2024 19:25, Danilo Krummrich wrote:
> Add a Rust abstraction for the kernel's devres (device resource
> management) implementation.
> 
> The Devres type acts as a container to manage the lifetime and
> accessibility of device bound resources. Therefore it registers a
> devres callback and revokes access to the resource on invocation.
> 
> Users of the Devres abstraction can simply free the corresponding
> resources in their Drop implementation, which is invoked when either the
> Devres instance goes out of scope or the devres callback leads to the
> resource being revoked, which implies a call to drop_in_place().
> 
> Co-developed-by: Philipp Stanner <pstanner@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>   rust/helpers.c        |   5 ++
>   rust/kernel/devres.rs | 151 ++++++++++++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs    |   1 +
>   3 files changed, 157 insertions(+)
>   create mode 100644 rust/kernel/devres.rs
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 1d3e800140fc..34061eca05a0 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -173,6 +173,11 @@ void rust_helper_rcu_read_unlock(void)
>   EXPORT_SYMBOL_GPL(rust_helper_rcu_read_unlock);
>   /* end rcu */
>   
> +int rust_helper_devm_add_action(struct device *dev, void (*action)(void *), void *data)
> +{
> +	return devm_add_action(dev, action, data);
> +}
> +
>   /*

Is it intended to have no EXPORT_SYMBOL_GPL() for 
rust_helper_devm_add_action() here?

Best regards

Dirk


