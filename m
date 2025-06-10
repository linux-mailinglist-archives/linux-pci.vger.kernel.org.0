Return-Path: <linux-pci+bounces-29344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BB0AD3EF8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316AE7A16D4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053C35897;
	Tue, 10 Jun 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KGIZ7NW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F3C1D95A3;
	Tue, 10 Jun 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573053; cv=fail; b=lMhAbovlm8OhLF5FnU+BYjA6g/E54Z6R5Ds4kqBGEgSKRpFJfVdHy0ZhHgiGHTYwk58dHziI8QEplwHt4zH8lqQMKqPdk7d2CeYSpZqBxa37d+MvkJXYNsdijvbctTJK2TgqLAqY42b02H5B1F1K7v021MZFha/TzCKU//yq9/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573053; c=relaxed/simple;
	bh=kTkaOeZjRoRoma9yUAFscnxYqTRPz7DZHYBwVJg31aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ifOkZEwQmnxwa2ubmt1ZygiQCrlp5LLGsC6/TyBHK1ywfza8cF6O6+178ts8hfvLGSgarjmJxSmgLKKgTGrF8TRvIVU5RDenIgWpO0trOEbkNFoA9NIj2otVTGG4GrGzNmRK4ckuPeNBTRP7DWmtHJGTQ0RjoyJJq7NO0ewnNrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KGIZ7NW7; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuVAr7Ml/iVEjW/ZIMbH8uJLd2Dk9oKhh7n8BHAmahtTAl+ZrtcecLHeoZa1nYiXF8pWBjBRkW89XUP3qXyGA5BXlxg2JTnwU9Z8VFq8sgyZGZk632kcaop2uN+awE46qO/yLDkQf/ynAbdY7QOlw2oftYs/rjRM7ZnEFvPpBesjtyxpflYMCoIZ+q/mf4PDCzOrzJjIuz4KzzGKhnq/WcMMAP36e8yooUhG68U2SD81B2l1Tbl2qXHzpqjKWNW+RDJ/GBUSNEkKZC1PUEWuu/9MnPdnXOarSRUbs6DRgn5tjXF2diQ3niYYIoaQ6BqGGXS+ecChg4KdZulLRAezGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqA/gF7GoW7mlxeQkSNow9SwyHLiF4GW4ugs3q4uHG0=;
 b=ZTKQxlMur3ecDgIFW4YUrXof8qYixZjr3oLipR36GFiR1/iU+cFZmJjH/30PhDA7tzBckCqyYo0POLr8ALBuRSRbcX0znZnHskBUn53gFg0Xp7Iozqv9jpVpKIazguUhz5zeWqL1dFZrrbv1ahTAcTnhCPaASWAW80nCMsL1g1BYEmxviNebFsS0wDNem3IxAeNJXynZQsjo50n4jaXPDsFWlAPI+NKgZz9yuXek5WfLfsmidXx6BfW7WWZVB0SWyoUHuAHQpNP3wie8lvGY8Pt3YNNETWPdNqwV46GfFvboDl4lN9RA1il0NKO9Q2mUrTnO+0pMgpCZQCRgm4pgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqA/gF7GoW7mlxeQkSNow9SwyHLiF4GW4ugs3q4uHG0=;
 b=KGIZ7NW7Bt/iMBKg06GYh1+PqVpG3BQ9RZzDaxOQyfYii5WuvxK7GJ0aDV4Z2vzwe0q7+3X0gYhlVxEpIJEcnOR2MdErdb9GYo7h4gMNxQzp5VHbLwQrtHXcQYkwhOXTCsfbanVLNzJvD6AfYo0EO51EbBUruPyFOsyeXTEOjwd7uTEn7XTTIukczoMQWTQTttQA6y7pdgwqSYioSaO8BHUK5VDeUPSaNktLYrKwyKhLYF5QpwLBcVxhACoQ0ezN82SDzOlLuVJu7PN5poURMr0IjPLlu5qw3jTeQrr397n81Cx8BR0gt+NLNPn35lrMSpuekxLZAWQynKdJWgtLPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 16:30:46 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 16:30:46 +0000
Date: Tue, 10 Jun 2025 13:30:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org, will@kernel.org,
	bhelgaas@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com
Subject: Re: [PATCH RFC v1 0/2] iommu&pci: Disable ATS during FLR resets
Message-ID: <20250610163045.GI543171@nvidia.com>
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <40f1971d-640a-44b4-b798-d1a5844063e2@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f1971d-640a-44b4-b798-d1a5844063e2@arm.com>
X-ClientProxiedBy: YT4PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a861fec-a2f9-4691-87f9-08dda83c2718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UNvY0p4+SNLl39tqx8l6yf56NVwfA3NNIuyZHeIFCN+0BNw9oRe+l6oGDtAM?=
 =?us-ascii?Q?1jlv3jAa89DQHTpss8/vZwGHUrseMtaKD9b8mgg4v1jUjzlZ408gaac+4jNT?=
 =?us-ascii?Q?QXcOdQSc9kHSK7wK5B7r+x4HoQrf3SkWVIktzlipFPYkrlCsJtR5pTGyecj6?=
 =?us-ascii?Q?ZQir1mwdo4Xor0EJobzSlFzfb5yO+Bv7tnY8O9cy6KEQWMWYQgrev8SWek8K?=
 =?us-ascii?Q?N9KAtZqE1GW/yPYE1vPsTI1rzWtKVXeEuIZS60hlvkvHJHF9Llh0A0IZDUrq?=
 =?us-ascii?Q?jVQzRv8WW4+2rUl1IhhZ4XZlPzAKDK3jRVPp1FlqWz2BjOuNZoHrNU4plfYH?=
 =?us-ascii?Q?p/rTgZP+7+KsMq8pVo1VMaiGRl7kUNZhwNzHSbOZygOa3khKGS+Auy8p1+zJ?=
 =?us-ascii?Q?Imrl+8h3+QvM3Mfl9NrJEa3heGGZEyud0l3T02spaGRdRBtuqah+1P57gBxW?=
 =?us-ascii?Q?919fG6AyMtgoIw8kUfF5NqX5hCu5i5+x90fqDUUTb9fFLHcxqH+86/bNe3xs?=
 =?us-ascii?Q?VgXpANdGR/XUF2ICEMKagIEXGh13W4PUFETNPN4eevHUN35bCAk8FswpZNAX?=
 =?us-ascii?Q?Z++UjynCtEj1Y53vV/mAzDHc/dSpe0bwh+FO6yCp5U8T9/phWDRGYri5xy1P?=
 =?us-ascii?Q?lD8aZdpfrWi5MgJufYncXiOe4+H2CmzwcRqvOUTIWnJ9YKHdvw1Nc9c4OI9I?=
 =?us-ascii?Q?5m8KnlxmU5nq8HqCsYt3J+y1Y6it5ev4xg//LMYQCo4IG2gdM8yA9fx0vliO?=
 =?us-ascii?Q?t9aephNJOSScj3iQunEaa0c4REtwxsfYHRkeKQO0l3CoyC/k99uwJ8KpLirm?=
 =?us-ascii?Q?VFStGLisziSZzXwN6WdMK/7v+uPxSaj2jXMhS7b+y7Ttepa2Slx2K2uiASx5?=
 =?us-ascii?Q?tpZVeuKTX8P5f62EJc8l+kSZhrL78Jn6+G7l+KaNRRJSaSdX9wNkomnRj6ql?=
 =?us-ascii?Q?JJZsWru9Ljfq8Sm9yZ3SpKeZ7yL+wYrnVlfEjhuyI1kEsU1ZQ9jSShgZwr8R?=
 =?us-ascii?Q?EM5MYrVwyl7E/UdlsQ75xouY8aYNJ3u8N8u5bkblZ5dFBM200Wm9Sm3VyFH+?=
 =?us-ascii?Q?mtjP6/MkNK7LVUPNwXGpMrqP1RXDSRGwOjkt5ltUSict/lTsvGSC5U3Yiigb?=
 =?us-ascii?Q?TmzWd7u82NjSYoHt7YjgTEEzjy+3oxGsfXBp4NcqDySY9qC1269pF6jeEnhr?=
 =?us-ascii?Q?uHdATNM8jYFe/2Hqj+LxRWtCtmOa3qb9DnbEBB+oOlsTFu2riqskoaSuGpKN?=
 =?us-ascii?Q?fzHtRRwAx57Fsss/ivQaRs2MU6MwBocWNpi8ylnSUUvC6UDPUl35q6aS+yik?=
 =?us-ascii?Q?TVxxRNQbuwawzUJl3OxVMvsPrZEDAwRsputtd90OyXleE3TlxZVERO5mGj9j?=
 =?us-ascii?Q?Tm4dQn7QfBOdll5vTNKbxALKz7t1ZSTxiMxpBEsdsU6r8vzIq8Psx8uOolXI?=
 =?us-ascii?Q?aSTBzpo/yww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ylz4JErELgylGp4VUEXzMHkCYQn3P+e0HjxZuwvKRE9LnWCBQ7kk6w/S6gW?=
 =?us-ascii?Q?HoPbrJQP7w+aJzldsSGGSk/xGZHaC37C3jnyAsuHSQjSizoPA5dHe54vv25x?=
 =?us-ascii?Q?s8uu2ZFz0UvFThtf+LzEsr7lHZQbrX0+fcnHUduBEwib4652fJPHsCaS3HkA?=
 =?us-ascii?Q?t9W8Zje3kui8JYtJ6vm3Nkrn8+JwbjLqOwmRBPIdGgNkqRMdzPfO8QFgGDo2?=
 =?us-ascii?Q?PLDRLyAiuVHQoodEId+e6Ea2fgrjlZUDdicQnhbkbxlI6CrtH4SwT83sJsEF?=
 =?us-ascii?Q?hQJKufa8jff1GV34tobMy5ovWkjBfE43UBMbaKoH60yTdftb2ZV0CNpHXY6A?=
 =?us-ascii?Q?PG9ywGWJiSI/8kofzDndFQfHFuOQhUe60gEI9NwRj+13AzJiPuww3aDo9GWC?=
 =?us-ascii?Q?eINgIKjFMeOeX/DLPHFyuFWNjMFd0C4OfUhk8M6Dx1AZPFUzEqlp5OZONigA?=
 =?us-ascii?Q?IOBhdlp5k/bKSER4HRjXnbDwUR9QsjoTGQjy8Z4UmB1q8XDZpNpCx6Pv9ObP?=
 =?us-ascii?Q?zOApyfhaaxHNFGWnVUuPuxqQrFnP2VrBGUX06MpGZsu67zWwvnUtHgisANi9?=
 =?us-ascii?Q?/9YYDSMJEjDerSH9ZKcXDOPUOMUmoczpRucs+8fM0BXY0hiM44OvcOiLVMDq?=
 =?us-ascii?Q?anpaK6lKf08bEJX6UsidJVjHYlAszWuyfk/lDo2F6mCefdlhHjaro2XDZs7V?=
 =?us-ascii?Q?nSAR814cC1NesiIlR6dwV0M2G1B1H9QrqLPLij/UTEFkXR5FmcbfW/UstDtL?=
 =?us-ascii?Q?YqwvNLwKuzd6b0ih38GwZ41vvg6zwxzrL9O0DXQlLOqJxzR+nRBfA41lVbZL?=
 =?us-ascii?Q?BlKf2mFqnrscojZ9JOATNjbYPYkciFeua9lFnMdB60+tasFsdjIMymb6YEXO?=
 =?us-ascii?Q?JJY6Y3FQFdafrCAWA5ESW1Zaja0iiCxCji3Vpu2TnxVG37MRSssSYdAGmUXf?=
 =?us-ascii?Q?x3VU+HW3zcXPU3NdwlkTsw5PBZDYEPhWpjKb1TlSkZ4InBVWofnvXe/6+4yp?=
 =?us-ascii?Q?RLDuAXy80QXAgIBo28ewnQLJXLHv0z9tiAXxmIHvF9hFryV7ld9qrAC9Nivp?=
 =?us-ascii?Q?xVDY+pKj9t86VUoNtJgwBYE3EopkeDPeLcp15qDI0mDkxZ+G6lH+wk+J+727?=
 =?us-ascii?Q?EveKfzZwe5ynPA+Shmy6mkrRaX2IYmCXtlaC7qGH/k3uo+GAm6Xp2MYFk5gE?=
 =?us-ascii?Q?vClYEOohmLqRWmrx6XG6o3zW7x+1oKfXOGLhLJ0b23Y4ZM+zd0hhx0tYXYgw?=
 =?us-ascii?Q?YIKQX8FpgG03lbeP4bHdXDUVsT4jI03AbjuXXlk7C2MbAPBtKm6lzuyHPQ3o?=
 =?us-ascii?Q?NEExLjfgp3sCoqBhd9cLzhf+sV0NeGY8vuZSLMET+TgUOaFm6VQmjU+5Gvcx?=
 =?us-ascii?Q?dHp3oy5mvwYD1aeERovH3OXBbxHjE6DEBTaniGNK6ouvuVX9B57yh2FGNsfG?=
 =?us-ascii?Q?OLGlc1YZb8uB1yInlqh1XDhhxXjxSlqTidaliXDpH83839XnMOjMEj3kcjhe?=
 =?us-ascii?Q?8a+Ru+sZGL00ed2PgwmPLXj6hlP+MzNI1phlHYTEZ3Bdl64l/iZVeSABK/gf?=
 =?us-ascii?Q?Z4NoaN5KD/UXz4nlGIFLILMrEevrWTuPKF7Mcesk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a861fec-a2f9-4691-87f9-08dda83c2718
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 16:30:46.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vsln2p6CKwIofoRiCsrtBZtowm+qMIJZ3zi2SGzf/PoF34v4G+VTabeDK8n9RkLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281

On Tue, Jun 10, 2025 at 04:37:58PM +0100, Robin Murphy wrote:
> On 2025-06-09 7:45 pm, Nicolin Chen wrote:
> > Hi all,
> > 
> > Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> > before initiating a Function Level Reset, and then ensure no invalidation
> > requests being issued to a device when its ATS capability is disabled.
> 
> Not really - what it says is that software should not expect to receive
> invalidate completions from a function which is in the process of being
> reset or powered off, and if software doesn't want to be confused by that
> then it should take care to wait for completion or timeout of all
> outstanding requests, and avoid issuing new requests, before initiating such
> a reset or power transition.

The commit message can be more precise, but I agree with the
conclusion that the right direction for Linux is to disable and block
ATS, instead of trying to ignore completion time out events, or trying
to block page table mutations. Ie do what the implementation note
says..

Maybe:

PCIe permits a device to ignore ATS invalidation TLPs while it is
processing FLR. This creates a problem visible to the OS where ATS
invalidation commands will time out. For instance a SVA domain will
have no coordination with a FLR event and can racily issue ATC
invalidations into a resetting device.

The OS should do something to mitigate this as we do not want
production systems to be reporting critical ATS failures, especially
in a hypervisor environment. Broadly the OS could arrange to ignore
the timeout, block page table mutations to prevent invalidations, or
disable and block ATS.

The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable
and block ATS, and we already have iommu driver support to implement
something like this. Implement this approach in the iommu core.

Provide a callback from the PCI subsystem that will enclose the FLR
and have the iommu core temporarily change all the domain attachments
into BLOCKED. When attaching a BLOCKED domain IOMMU drivers should
fence any incoming ATS queries, synchronously stop issuing new ATS
invalidations, and synchronously wait for all ATS invalidations to
complete. This will avoid any ATS invaliation time outs.

IOMMU drivers may also disable ATS in PCI config space, but it is not
required to solve the completion timeout problem. The PCI FLR logic
will put all the iommu owned config space bits back before completing.

During this period holding the group mutex will not allow new domains
to be attached to prevent any new ATS invalidations.

> > Therefore, there needs to be a sync between IOMMU and PCI subsystems, to
> > ensure that ATS will be disabled and never gets re-enabled until the FLR
> > finishes. Add a pair of new IOMMU helpers for PCI reset functions to call
> > before and after the reset routines. These two helpers will temporally
> > attach the device's RID/PASID to IOMMU_DOMAIN_BLOCKED, which should allow
> > its IOMMU driver to pause any DMA traffic and disable ATS feature until
> > the FLR is done.
> 
> FLR must inherently stop the function from issuing any kind of requests
> anyway (see 6.6.2), so "pausing" traffic at the IOMMU end seems like a
> non-issue. 

Yeah..  I haven't liked this blocking domain approach too much, but I
was convinced..

It has the strong advantage of being simple to implement and not
requiring any special cases or code in the driver. We don't actually
need the driver to disable ATS in PCIe config space, it only needs to
stop sending invalidations and fail all new ATS requests. All existing
drivers inherently do this already for blocked domains, so this should
solve the problem for everyone.

> I guess I can see how messing with the domain attachment
> underneath the rest of the group manages to prevent new invalidate requests
> from group->domain being issued to the given function, but it's pretty
> horrid - leaving the mutex blocked might be just about tolerable for an FLR
> that's supposed to take no longer than 100ms, but what if we do want to do
> this for suspend/resume as well?

I don't view this a problem for FLR, we can hold a mutex for a long
time. It principally delays domain changes which are kind of nonsense
to be doing concurrently with FLR in the first place..

However, for suspend, we probably want to leave a marker in the group
that the group is force-blocked and all domain attach/detach logic
will only update the group tracking structures and not call into the
iommu driver. When the resume happens the core will set the current
group domain list to the iommu driver. No need for a long lived lock
this way.

Jason

