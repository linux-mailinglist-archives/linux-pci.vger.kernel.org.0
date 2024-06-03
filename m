Return-Path: <linux-pci+bounces-8178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B878D7C55
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D30280FA5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338B3F9E8;
	Mon,  3 Jun 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="snF2WXxU"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB7E3EA95;
	Mon,  3 Jun 2024 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399263; cv=fail; b=UFzJbBS1PXSH6Qmcj2jdqpBN1LZqsd8gOJCIqBLZNJztqfYz80IdGLEdrtIdrfKMyNFseIRXq5pvcUDD3Ujt1SCkVQkOSirXrdqdpzXYKisONANmgmhXTcTHCJ/R1wG8KbRgCJjOofi3rU2X5JvZ0F16Us8rNCB9Y7sq5Z3OZWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399263; c=relaxed/simple;
	bh=HJLup6tM/8p1+Lgj0jHfIvKKP/U/l7FUT8QyCj1FnjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nw3M7FFWZj/6EWGSk2TD980HB9nctj0qPKzNmYxErciO3oLZD6397Ws561nqMOVjI64eIH0+CotvlUQN5Zs1gXzXjWlPoM1XLDzLYGvdkbWxzKBqsINEKhkUXVjmF90VW0jdHL8MyzeahAJro5C8W/2FHG1WSMa0ZTDFaaVqbCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=snF2WXxU; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApgnhSQZeR4Y6R1+YBhmPeU9CttG3rTctxpZ5ufdDJKOQ+/5ae/X5HUeAEtIzmqzvPlSXyBxjlH/5Q1Q0zfXeii6ygwlM9YP05ubsbKtGWW+LjAOyCVz1dRf6TX5hLqUQd/ftGp99xKeeR3xkNn9ZLYzcrHMC6Rao9ZZ/ORTygnFqUeGaErb3DsUYx3pqerD9bIh+yj8n81G5u3Lna1knSs4F2X9yIbpybMxTNLwbnQ0zoKFDrqMU6WnFtPY715PYeIPvH164vamHbqD1zXhl55mutIfqrVvfKpySthHlbHlj5nHyj6fWGTG7c8TU70pRjOv+SMNeAEqeT6hBabCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wG1MhfqiaQzWKQRg2qRN9nneorZpFjD8o0l2KNtEEsY=;
 b=l0GRDRZvFgOSGtKceb91Bq1e1kRvAWRA+oLHpxkQVn8IMkPuAryZ0tpPnC9Qp/MsuoiLBMsPTbkjaTKF0/ii8KbVdT81tCCJkV9A/G8mvPRMEXcUiN2qaTRbjXglqssmHBoiQQuDT17ltVBr4n6BVE1Kua1N7lGbC/yt8bcwHTELX1QiikO/27BUU9VdGsLWrurXAnPhP+DYR1K/0qH+X6tbFSnoxpDBi4ZElqFNvGs0VNYT9JfRBlJz1PlY/9NdmgL1JASOfsY6G5WpEsyc4vVHEby2mZhov2apXpI2HdAcd/amIZZjZVOIW6LUSYebGBkxThN1yex+rEZPswrG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=redhat.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wG1MhfqiaQzWKQRg2qRN9nneorZpFjD8o0l2KNtEEsY=;
 b=snF2WXxUg1zOqlEo4zSW7xOshI5JlUkGD0v4NpuOrTi9/JdEFwI2U5sPocf/H3VKuOccTnNtb5Uu6InTZoul46PoIF2DIB9QbM2ux/KN1HbmvNrhfoNW/1vK3lWuX7PzV7hwSBt+aQWiqUM2Dhi58Julr2t/Kjrnl7jatfKOC77fCqb+ieRFTKnWXUFzF4RZ2JkppkrHyaeKUyXB/Y7gpMFmMY94H99TQMe46ubJz++Qk1C1M8UL8l0SYt0zVtMaalxb8CSpJz7+Hlmdt8JyOazzjToAZ94xcG2k4/3c2tCCc370F6QhUE2Yh4KJ13UjuZsx7sA+w87DtdC7xJAnGw==
Received: from AS8PR04CA0084.eurprd04.prod.outlook.com (2603:10a6:20b:313::29)
 by DU0PR10MB6703.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 07:20:57 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:313:cafe::fc) by AS8PR04CA0084.outlook.office365.com
 (2603:10a6:20b:313::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 07:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 07:20:57 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Jun
 2024 09:20:42 +0200
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 09:20:42 +0200
Message-ID: <ec9742a1-45a3-4058-b530-48b2ceb9c5fa@de.bosch.com>
Date: Mon, 3 Jun 2024 09:20:09 +0200
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|DU0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: de24b80b-4e02-4caa-7bbf-08dc839db690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|7416005|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUFsV2hDZ0Y0dlVYY2ZJb1VuQjA1RUUyWTVFdHhFT2NNOUlIQXJNOW1kTVpj?=
 =?utf-8?B?UzVabWJQcGtNMDZmQTVDVkZSbFJ4M2dHVDdjTXpEdG92OXdZSnVPdUM1di8y?=
 =?utf-8?B?bnBCOGYwWk54RTI2a1IwRXBVSEViYzY2amQ4RVJ0TXVlZEJHTW5zeUVJd3ZC?=
 =?utf-8?B?dzFkOU4xaHMzK1FCV3M0TjVOYjQvV3cyZFZmdUM5MW95WWN5T1BaY1BZd2JT?=
 =?utf-8?B?WXhJUitVM3RtUlp1VU4yM1F6QTE0S05DNXk2TDd6T0tWUnpmMFAxdkNzaURS?=
 =?utf-8?B?ekpibWZiTkVYbUJqOWV5dEVJL09vR243aUZraVQxczc2L0kzYTRsV0MvK0lD?=
 =?utf-8?B?UDdBUkFVTkRqVDAxMytvbHJXQnFkamVuRDMxV1FrVHZodzFYZTE0aGtrSzV2?=
 =?utf-8?B?eDZUSzR3dWNvK0dwNzd0QzhUdzFwdFB1QWg2WkdmNytuNW1vS3RPYXIzVitm?=
 =?utf-8?B?QlJiaEtHNE5nYnh4eXJKRWkrWDNrL095TlFqdEtKNDQ0SUhOdHlKRm1wOWN5?=
 =?utf-8?B?MVFuNVg1N2k1S2Q0TW93UGZuNkJVQ1pNS2t1WjRwSXR4bC85RE9Xai9ERU1H?=
 =?utf-8?B?T1hBdlE4MHRHdWZOQTFVWkp6dzhoMXdybXJUVk1XYzJ6Nlc4UEszWDdhazlp?=
 =?utf-8?B?Nk5Nd0hjeEU0alVGd0VCWnBaNUw1VmlJajVQTzI1cHRhTGlBMGd4NTA2N3BY?=
 =?utf-8?B?WnpOMlNVeGhWZUorSlRtY1pnQStLRW82V04wYWRWTUlnYjNFNkFiUHdKUGUz?=
 =?utf-8?B?UE85WHExeUs2eGl4OVk5QjhzVm1laEx6TlNMQTJOSkJJSU1MeEFIc25sRHNp?=
 =?utf-8?B?Nlk0Skg3bVJnaTBONTdTeFBnTWp6N0RSbHhPY0M5NHdXVm1kK2ZjR2JHOC9K?=
 =?utf-8?B?SVExTHlFbjFKYVZKVmt5VmhZb3h6d01ydnMvUWMzZGo1eTlkOUFSTDBxYytH?=
 =?utf-8?B?K1dRUFQzakl5ZWc2VjNiKzUzS1hqVXhFTXZ6QXJSNUlDOUVRaVR6T2ZPSzB4?=
 =?utf-8?B?blFEK2E2WWp5M05NenovZGJFaUlLQ3JFZ2NxK2V5YXY0UHl3YklUcW1aTzBR?=
 =?utf-8?B?N29sSEtvaEJCRHc0MGpmL05nOElNdzdGb3grVERqZXp2d01tUlFXTjRmK2cr?=
 =?utf-8?B?S0xJVkVMbGtlRVhmcWw2UHIySDFJSlRVTy9NNm9zcGR6UHFFV3p0U250bmJZ?=
 =?utf-8?B?cXFiTlRHVmp1M2xrWW1DbVBsNlI1RDg2QkxucWtTU1dGRGFITkIybTVqYTFt?=
 =?utf-8?B?cnVDWExnRkl4UkkwR054QkFpaFRtTWFUS3dsYXZHZlpqcG9jaVExbGZYclNt?=
 =?utf-8?B?ODQwb0ZRaDV1NEc3VFlGWS8yMW05TktMNVVwNjRXR1pGOHlrbzBSajd1N0pG?=
 =?utf-8?B?WlRGV0Q0ZXBBOS8xcVFrVXByRVhxSjRRL1pGU080U2MzcnNsai9qNXovU3hN?=
 =?utf-8?B?ZDZjYzY1TzFtWTlVeGVuNlpGTUNhdUVnU1dOblI5WHRYVDFXK2lFbXAzRGVP?=
 =?utf-8?B?ZTRUcHE4TTFnTlRDSndXdlAzK1hpU3RzRTVINmEzMjREOFFmWDFqZ0JkOFZH?=
 =?utf-8?B?c1FvQ29YcTFoZmVGcDFMYUFGQUgvdmJGdGhpMHo4cVlDcEdtckhFL25oeDVV?=
 =?utf-8?B?RW81Q1hhZEwzL2hFL1ZSTUwwNWhmVUdaVnBiQTQvdGZjZUszbE8vRkxmZzRS?=
 =?utf-8?B?Y3hYOVJDN2U1RzBLUDR3MHhWQ0FETXcrdUo5WFlPSkd3dkx3ZzNpTk5GZi9J?=
 =?utf-8?B?SW1Ba2lucHNMNFBqM3d1WDN3Q0NsS3V4OHEvN3NicVF0ZU9wVG9sMURCRS9w?=
 =?utf-8?B?RzA3TVNNWUZnekNLZFEwMmVMV2RjR0paTmpwTmUzTzcxKy9jSk9MSitJY0t2?=
 =?utf-8?Q?tVQDruQLls7oq?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 07:20:57.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de24b80b-4e02-4caa-7bbf-08dc839db690
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6703

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

...

> +impl<T> Devres<T> {
> +    /// Creates a new [`Devres`] instance of the give data.

Typo? give -> given

> +    pub fn new(dev: ARef<Device>, data: T, flags: Flags) -> Result<Self> {
> +        let callback = devres_callback::<T>;
> +
> +        let inner = Box::pin_init(
> +            pin_init!( DevresInner {
> +                dev: dev,
> +                data <- Revocable::new(data),
> +            }),
> +            flags,
> +        )?;
> +
> +        let ret = unsafe {
> +            bindings::devm_add_action(inner.dev.as_raw(), Some(callback), inner.as_cptr())
> +        };
> +
> +        if ret != 0 {
> +            return Err(Error::from_errno(ret));
> +        }
> +
> +        // We have to store the exact callback function pointer used with
> +        // `bindings::devm_add_action` for `bindings::devm_remove_action`. There compiler might put

Missing 'the'? "There *the* compiler might put ..."

Best regards

Dirk


