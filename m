Return-Path: <linux-pci+bounces-20285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A997FA1A51A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 14:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C7B169EDE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 13:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B920E31C;
	Thu, 23 Jan 2025 13:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RgmtR+co"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB57211276;
	Thu, 23 Jan 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639309; cv=fail; b=dWiGLzE+WLseXDsO7lL5zw/oRE5fFitVr8UsDmiEPlH7HZ2e10nyMP8aw+2WNqSGlqzc63GO8xUS5PfIi0Ap9z9cjV23+Oqt8ZkONef738Mx1Ai9dKqIUjEn1TbvxPtPJsVBqntJ0tFvVeKFg0Agm8vvSWQAIrH7Y8NgMUpMD0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639309; c=relaxed/simple;
	bh=KCGDpRm//yJoGZ1Iyc+oxT0ILXtC4NHjueEXVu8JbZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nu8v6X1+rwRW0vFMrVai6paMSsrOpyYo+TitNVG7pRTgkV3abk9lrL8Ch9WkWV+CpeCMZOIa/GhvsznuRItT2n7/npoQBrNYSBwWikgjKn/My+7ksTZLb0Y0SywlWY4rVBvrB3g8DhvXCRFkl+lF0Wiiu7YZIWnHG1WEtnV4JNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RgmtR+co; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffDOnNSL4TgFN8qnYq6uL53xgA3Sx9w/C1Oi5IQqOcWKR7jYdGFHUpaY7v1qwJl1Q8TXJWf1klbecJM9iG9Kee6UJN4bSqBm6tq9AY7j+Fqu8wgRQBuOII/bOWKmKA24OO4q++9D4eXa7vrFXdom0EL71ulZTXU19vxHw01VOwvpMWWiqWZA9u1SDCRYJq+GCtxmDwfUIApbB8umiwQyU1NL4PvB4xb+fR/UmDPITl4jBkiHtsmA2OYYti1aoQhQe+auOBxgUy69W7cEw4PWcpIehJ5OysoKrwRy7+G84H/2J7fwyrAwujZSlIC71kGMWyVUgZ+tc7l7oK36aX2SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOHYVHZrJBdxEy6Dr3un8+wRFdLeEH44/GBkaBBYNj0=;
 b=P16UICR7FJQeHZ51AzEeuEJimOQkRLf8qB/Jj26ftPTh4PvfdtFD7B1fwxzku/KwIZoixSVwUZOBANOEcwssemzy5PNgNX/FtZpTRgK8f65+0rKZfYJUHUuVUcMN6ytFxCss5QbeY0WUvSKzMpIkBnjVsu26b4NekNbMQGMxhBN6NNCsQc4k5s/JeQ0OQPvwFwsst02mni8X2nQdnkiHSMvYrhd1s8m567Huso2turQMEhPiYEQA/4Zdpwcew0XfV45cogVcg0lx6FhLxWuyZBbFS6mMg9JU1TI3TCqH9uocIS9RO9iejplLhe3/QCk5PtuGBxXcqYI7K6UBvTlLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOHYVHZrJBdxEy6Dr3un8+wRFdLeEH44/GBkaBBYNj0=;
 b=RgmtR+co+E8d5imybj/l2DGo9rSd8Ch+h2WTnXHTbXASuX9IttIH5EU8aVMCHV4Ay8SyjlIHexTGVas8LJF4A6jsLZ/DCkjEQrNAVgUZTe4M+7y+MLrCx6BFJcTSLotrTmdnXbJS8rI5g5P9INeuLr+k6gpVL64w12QCslUHSa5uMJdEa87bTjdxRe1j1uQbo9OaT5fo8mbflai4LMOQ8Gs69W5zVzSHIjaTQhKY0sMPAIfV9wfiqQD7a6EWMysVU9J+zdwLzArsRa8y+5RP1Pgj7XJZjbvpIiAgc1XZAXYE5IYgwUhoY474Dnv9G40BnBNvx1G/8AVtTjwXShQTtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 13:35:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 13:35:05 +0000
Date: Thu, 23 Jan 2025 09:35:03 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH v2] PCI: Fix Extend ACS configurability
Message-ID: <20250123133503.GM5556@nvidia.com>
References: <20250123033716.112115-1-tdave@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123033716.112115-1-tdave@nvidia.com>
X-ClientProxiedBy: BL6PEPF00016410.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 802a8029-c587-45b8-09a7-08dd3bb2bed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XF3medHbN35dXHBpLuT+kX55nvAX9CdcnlnsK122ExGVt1FZti8SLKkDM8RW?=
 =?us-ascii?Q?pAkvLo6/qrB/GVE7TcqPMUbYWwko0XXfQjNz1mDlp9rAxJ6dqs8VWto05Umx?=
 =?us-ascii?Q?GBcpKfdMgf15Zx77DbqcM725bT6zao5o8XLZ5Awxv/rkG/WT8aLgHkOd6Rex?=
 =?us-ascii?Q?XPxcEFPjE9qQHkGCjThezGJ/ABx1tavLWnF8g84Z47Cx+nt+HUbT9WUSevFM?=
 =?us-ascii?Q?nX37LoXx+RzulYNeAjiR30un5R9N/ljLITnO34ncTrwUsNkTSmuoPvc19je4?=
 =?us-ascii?Q?lArSLEHoJFef1xifmVCy9JR3Yh1SyZsqhtTfSkFuKwhROf8y3PuG7D7ymfWZ?=
 =?us-ascii?Q?DwVq8kdpEkfARakD5e71qc/W9IspRxTdCu4tun74X1vfYvnhc71gG3nr22YS?=
 =?us-ascii?Q?pWUwbgpOz3cHRi388PI3c/ZrQA5y7lMi4WUmQdcsovrmWedLtRvjhf+9TzM2?=
 =?us-ascii?Q?9h7MCy5vnL7H9PS8pR3RZOmtFoa3H9bKWSbMLTMl3Wtw2N+9cA6ZB566BHO5?=
 =?us-ascii?Q?iyEVGv13sg/hM7PtB5NvHqoPmCEyVblxISfu4bhwI2sFCfrHFxZtPtKIA1P2?=
 =?us-ascii?Q?eRV+wKpjKU2lcgvuvEx/FlXts1eJbEhP/xyRa3ysJzhuJ+Dtt1o0EsDQagLe?=
 =?us-ascii?Q?khnPapaK7MdxZ2caJNk4Dy4yN2C1XNVcxriUfSuc329wcCZZ5qpAxOuT4zNx?=
 =?us-ascii?Q?QpKSFbRyI+jv9vQ/30LMrPiWlL1RfOrTQqqKAOKqfNi5l5O3mCfQKkFporrX?=
 =?us-ascii?Q?RtuzHLxm2D9Hx/lPWswgGh/+pLmzaGxMbsQiaROv3BtFQq6+07sZ1lZhMaRD?=
 =?us-ascii?Q?z7p1uMKkkNZYKOKQxscQzDxGS5fBgj3y1kQP/pVhOj7I99qsgQwB4MIs34/k?=
 =?us-ascii?Q?Jxs3a9vqSViZD7fuqIpHdhHT4UJ3D9GEu5JciFopZmeSGXDjEE1tvCQ2BrSW?=
 =?us-ascii?Q?esBYW84jsBqG/DXsPA/Gb3qE7CyHEQvxNS77/KsF/KGa4jsRJWCjJpiQHWRH?=
 =?us-ascii?Q?kIY7Yyg4CCEPMBW8TzHwYPwVP8GbHZ8cN4cCorpv1DNIpOteinKYJ6EouhGX?=
 =?us-ascii?Q?rmUPZrw9L+eMZl2Goy+BO2LS/QgBy7pkbhcXFtUn3CmFPYXX993lbOu/h2ax?=
 =?us-ascii?Q?l1uayCjQt0hXszemf2FiosMBM9twsdd9XwQzuihOaFtJvE9DWpkVf72Z5Gyl?=
 =?us-ascii?Q?HbEQL854yiWcO/Ba5LPM7sKUREVcAOIXmcPtbi48Xu2VZ79z7Fhu0oPIhsO2?=
 =?us-ascii?Q?UuFvOjKjzIP4kfNnyo9Qz+4uKQCa7R5N31ZRAua6BLkKbgZFf2fTqVNdmrdI?=
 =?us-ascii?Q?2CHA7AL/CUNgPQSDevysGFgzYWgdve+15dxdqgf8WUtmmNh2nwHGhE0Ii4wz?=
 =?us-ascii?Q?8rHh2Acpi/5R/6rRlHQb0yi2N751?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?coBwOGQf76wWoBy34zgWkuad9M2765lerQb5RDFFs/LdZtkBmNnmwT/PKVvl?=
 =?us-ascii?Q?Qc+qNjRq5DFNTqj/oPwgwplqrFBcO0x7DsaHB6racdClJsFlhDwXUAUzCX3a?=
 =?us-ascii?Q?9k5BekfaA/wtykBpwK3xnc7k0iulgQ6U6xDNziOe9wH6AuQsGNt6/k6HZCBw?=
 =?us-ascii?Q?Zx4SvSTOgsINXN3jq1MvbaJyiTvTSbOtJnK0umcqZ2bpl9Jz13E2enpGO7Qs?=
 =?us-ascii?Q?7EBXdKs1UVb9Exq+1Ot/RhEV66bhyg9LN44RAnDT6TQ5RIRH9hCzCoUq/5eQ?=
 =?us-ascii?Q?E3ZVY9y6A7/9/bz3XG0sNIVx9sZ+60JclYVqiShpEw/MX5wQnz+3+f6H2DUs?=
 =?us-ascii?Q?6QMDFXiDPc/uLZyPsO2WQkjDO4tfzBKrvZOim2HUhOliNjjCT7+E3R9egihy?=
 =?us-ascii?Q?H4J0B3wM+plE5ZbdE49/T6wTo3vfokMfxP7k10p/TGJyay21uw+osLEHlmTT?=
 =?us-ascii?Q?r8oUOYNLB2K4/hEDAEG/VqOd25vYncNBa8fHqpAWk0viu9Ibmlj0LDtlQU0X?=
 =?us-ascii?Q?EW8Dk+/pwmrg1/ZADtFMNZvOsuvPaQyjwcA5/mx3x1VnmD65maALXDIl3SKZ?=
 =?us-ascii?Q?OPxhBX1LXNXQJD12TEiWkzNTauiZqf8b9E51kyv2EQEIWyKRZmnfgBlUztMs?=
 =?us-ascii?Q?0uIcF/BWx/g2Q4xxQdATeoVgHUhxSvQvRgtmDI3nsgUy86VD5N0PPz4fBTY4?=
 =?us-ascii?Q?53Sk5mvngcmykyxXmRLHHbBTWF4insjyXvWS/4gn78VZJMVriwFxvBOw1PLV?=
 =?us-ascii?Q?wKEIv26hY0Y6MCUJf617GkQb1fDD3nE1fjwje5Fltev9YnEWtTNlxre807U4?=
 =?us-ascii?Q?V3uSrejwve6g+7HsUJwMZw5gv31IA8xFDCXRm6HXFDRnY3mo3fY26LtAXuO/?=
 =?us-ascii?Q?GSVEvnEhJhRgfms9UEMQKCpL9Q4hjL/Bnrbfhc96Yby4RYWC5+YNHhtn4eqC?=
 =?us-ascii?Q?1wZg1V6HeL8pt97L7aiBh4839TiBwPyrC3dtDgF+eivd6YH/mXmfAdySsDDj?=
 =?us-ascii?Q?Sl6z53Q8hXFCJM9rUoeHS9oH2iztnN5p3S86pd0eFcyvqukf6SpQL60BmJNY?=
 =?us-ascii?Q?v4TiZ/KSuRyOyms0pwne7F5mejgi7NZ1pSagRBv2r7KzB6NtUkzuPagoE7IL?=
 =?us-ascii?Q?hKlp2mo8dU1cZnMxua/dDihI2snBHApxsCKRyMmZSyfZxYR7xkvp+YKDVIk2?=
 =?us-ascii?Q?kPCZvsrIeJRu44CvTP7ODGLs5UGF+1BQWZC0qLKGm1bdgt6NK0UDfGa/XvcX?=
 =?us-ascii?Q?mu8tk/cM3h5EvXlESyLTWNqGgDtNhwxJe+BMsfNR7WQ5qM1ZJWlVUoeVHrgN?=
 =?us-ascii?Q?oq2EBKT96WN+Zqn6OblUy5FtFcj2RXtuip9u8inTRnEuZ/bijNw20H8mR6EY?=
 =?us-ascii?Q?zSiUAhhCapkuCzRnYKZv508M7vU5HplinyjCZND4YyEOwSN8NSMwApLcDlhn?=
 =?us-ascii?Q?GUt1Zv2qQzUcrn6PsSvhbcLyFlJmQ8rfQMWAvMDyakVSyZ8o3ORid4Tm1L0e?=
 =?us-ascii?Q?0BoB4Q0nOzzmVO6GMjFdROQ6J/4LHbdpy3oTLEqFTTeRrvRw4kq3Uc2iy3iT?=
 =?us-ascii?Q?vbkIEs7AgOIV4/ycl7GrUL8f/dDFE34781c7SWb/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802a8029-c587-45b8-09a7-08dd3bb2bed4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:35:05.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dux/sszoNfmTWVfrZCzqzHPwYbTJUa9gNHBN304vwrCAHJqe6anZiJ/UAEwLj1as
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142

On Wed, Jan 22, 2025 at 07:37:16PM -0800, Tushar Dave wrote:
> Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced
> bugs that fail to configure ACS ctrl to the value specified by the
> kernel parameter. Essentially there are two bugs.

>  drivers/pci/pci.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

You will probably need to rebase and resend this once the merge window
closes (Feb 3) but it looks OK now

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

