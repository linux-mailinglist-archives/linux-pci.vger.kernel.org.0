Return-Path: <linux-pci+bounces-38241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BCBDF841
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABD53E5670
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E828980A;
	Wed, 15 Oct 2025 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nIKRVBQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB59171C9;
	Wed, 15 Oct 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544104; cv=fail; b=Vy5ROoFgMZC0v4kjbKxFDeNzzA3Ku+93bNkr+C3LjDRYkuvth/TVjXw71c5Wjv8CJTIU4Df1EwgMjs/b/i8mGx2/S90L6n1qfIaFdUxVKlSYZjNVjg4NUSPdVqcO4bd8GkynoBZ1CZZCBjC6HgsHekG6KdQrOA96AzJ1MizDMFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544104; c=relaxed/simple;
	bh=i0mySEOVvrP9tGCrWwKwsnx9lHmxIR2M5Dwe2HR++Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OcAhgy4HiwKhcijuXspTdGb20ZbGuKgBqx06s1RIsHM8W2t2JCbdqs3GlHS1zyG4qfepbMBWuFNfO8CFSIQ/dtexPkH/Iabol/bIrBh5nCIoPL0vnjZdAXKHgzbing7BiY1yn77M7w52Gmt/ZXmkJUeTxjqotkujriGCzofAUXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nIKRVBQQ; arc=fail smtp.client-ip=52.101.72.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa67wBwlEbk4aV9pcxb40lHa+DKtjb0MWAbgyRrS6nSJeZRHkmI6HW0n8JRStCWY+Itu6unbsc8W5dF0Iz6wvIfBQVhUoJg/DwcnoV9gOJgHtKdkBiux93/jkXAtD6EMSOqOYZTUfWJne7OnWOXCsBe2flGDPXGR96yQQS1cfRlBuTVXtQTxOGdO7N4goqwFRfRn2Nh55e7MrP5ZwweI82aP6NJrUOCqxUyZP9sBsU9c2jaacyCxKSYNbtjyvM637IdMBH77kPiUgV7C4lKmCR12a2zo/WImPL2VYFj0iUDccCZrfWk2MxGpcjd+UyApdVq0SsLo8TSMJUVyDtlPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELM8vq6K8xwAcNwDTiifXEdILBz/t2El5jqYV+bG0Rg=;
 b=btT2/KtO1DxJ3omIjEPjvJ7+Y5ZCzNgZNhswbQNoC4UiokLvWRqfcqixftkHlnQursFPPKzzpJsXcx76Ne02rLJjQ9hJ8ezeeZYL97Ej9jkKha1CsziuzNG7tTPIj3RgnxoNRuU7L6vVHGEmYFTmTmzZ6gzmo/t5nvTAxwqcuXgVCBIxiaYLlrLVsUe1QM5PtMOEciOx2Jypu0l/Czkg9YQJ9ktvAYWWFN9aNcWBFOW/M2LXT4MfF1P0P8uCAYg1BstWvmmGTn06HlTwqjpxOH9TEPLrdIS963aVExQtLO93q8oBsGqKlFrEDJRevsmXv7oKDB/I0M/v1GwG8Vm+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELM8vq6K8xwAcNwDTiifXEdILBz/t2El5jqYV+bG0Rg=;
 b=nIKRVBQQKN+UqKd7lZLYA37RaPZd+cFJrILBjtav5PkXoDk3YOQ5HJeXamX6LKlbM9TFqhJEMz96gV06x/pe2CDq7lr/Oy12h+ocoYJENRk5tnCBDHxTl++WLXmYBXSBFpn4zU9BxKbfsRazFJr8zegDCwPKe/8MUNZ9uIyr/Xfc++PgnEcHWRZJ1b4zIAKNyZP5GKJ+qG+JJ6VeiOF79RDJMPjFP1jAEzj/XTcGpO7Wlixo43/MJspdZalZ8OsRZcErvbuhDthhwpvEBkxzWNRGe7E0B4Nki3LTl6MRUs6RjI7MKmr0Z5JrQJBuXfvzuBpNwQYuZgCtxNPLyaWb3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM8PR04MB7860.eurprd04.prod.outlook.com (2603:10a6:20b:245::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:01:39 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:01:39 +0000
Date: Wed, 15 Oct 2025 12:01:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/4] of/irq: Fix OF node refcount in
 of_msi_get_domain()
Message-ID: <aO/FWzJggZ16maGr@lizhi-Precision-Tower-5810>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
 <20251014095845.1310624-3-lpieralisi@kernel.org>
 <aO7Mx11tWFbDX8u1@lizhi-Precision-Tower-5810>
 <aO9VYGkCq7MDCcNn@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO9VYGkCq7MDCcNn@lpieralisi>
X-ClientProxiedBy: PH7PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:510:33d::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM8PR04MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 6598de56-d2a6-466d-9013-08de0c042026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gswYsyjUNNMEIJqYeJc8SGjNM3dAxLzEvIjwwEeLlwU6bZmvkJhOaH4YwMBJ?=
 =?us-ascii?Q?ErGG9rdW3y3V52w1n1XyYidcY7gAl6LvzzIZHGzIf1j/OGQHBGdGZw0BDxwt?=
 =?us-ascii?Q?YAzVTCGF2mXhh5jyGnA9ohQyyt+sfEZpuRrsPQ9KKP2pbGSWPkc5nZMq98gv?=
 =?us-ascii?Q?JQBT0WSJSlmYboDjSG3QTorzZ+gpe5vKadG2mlhDXcDHHeidr8nBG/s809J3?=
 =?us-ascii?Q?U+/ZYZBsUx72Syjuk96mBmRdGtVqu/ES3pGgYRtmqYYu8V47kiFKgOCjgSnQ?=
 =?us-ascii?Q?XDQ0Habd3Z1Z0EQu62uS/3YiC1ANRphRjfTAk0KX5ZzJQCUwNwnHbUdWh/Hk?=
 =?us-ascii?Q?c8HdoOJNPfOTOmlEXlj68xTYWDBoXte6egcwju8YTeoXjwxtGtOnbMha+NGH?=
 =?us-ascii?Q?5fUOlUc0akEpn4ODpfkAew8xWmOg6Qo4SY4g+8KFyl6ztxTGRYgttfjDpUOL?=
 =?us-ascii?Q?sAFIalAHi7YfaOJv+1E+BETnQ5JYWcBlcnRf9oe6gcUOxsQd1FcBwDgUtRTG?=
 =?us-ascii?Q?M4CJ34MRyH9rHWi+kGemcbGSRBMRCiu8eTt9Cy+BAPMeMlpCm0RollsvFuFJ?=
 =?us-ascii?Q?VO3Tjyv0ChXyTtreBowB79Zi3UFatJAxs2PrlfyidngKtmkvw9gfQq97bCfY?=
 =?us-ascii?Q?yef+Q7FvqETuPxGWdQ+Z7zCI0qoTtpluag/ElwKE4Vbgxv2KBY46zZkLon+/?=
 =?us-ascii?Q?GIfFXekXnZVzNgyu8v3NSt6K7EiPqTuRpKMiKwSS2UBJAyzBcJDsPVjZuPzt?=
 =?us-ascii?Q?JKZ61XE+vbk/cUrmIRgNsGBw9vBA2sVHnO+PSOqlcHYrOaWlQpJbzaEWMQgj?=
 =?us-ascii?Q?5P4yKECVCz3pMhadjuOHvtpxVXR002FsFfOCNIPdxKPH8OjZ40bOawRphiDJ?=
 =?us-ascii?Q?Fpn4vv+iVHH+4b0LiFInzIy5fUIINr0igdWnz71GQsvEOuJpnzW1xThgtdYp?=
 =?us-ascii?Q?7OQNO2jRhYiny8oo7wKLCgPMwk3NysMyP93qCo9sM+3E6j/70YLGQaoLGfei?=
 =?us-ascii?Q?hlfxcTRgxaevMfYe009y84mKhg3LrdA0pKMrtPSkPmmIdHKGprt7n5MzvLbJ?=
 =?us-ascii?Q?xFU1yFkPu43u1VXkbmp2sqafFPz5tJ6GNKTD12AarqrddvLgcrUlIiq2T/Y8?=
 =?us-ascii?Q?TR/SN2NFKNu1FWywzaYhiLHvHYuPnBBJJuGmj0wgGa9VcCBzwjO3xgFokASD?=
 =?us-ascii?Q?5FSdBe0blH0jOXUnijDqtR7U935RiN4DFKWjk0yYPviPbYNZoa9WI981AuE8?=
 =?us-ascii?Q?deKcqNEowu/7FeG5CHwW6BNldXhsmS4PlkmZkpzwjuIgsSsXeLeUJq5KdlIf?=
 =?us-ascii?Q?uXAcG02/L6Q8z0PjANJUF3Ys5ioimBcY0u4MJUaU0wI1o31m07jVSy+GVXkx?=
 =?us-ascii?Q?pPQVtPCG2Cul2r24WOWb/AWShoAvzwXPc3KGssZKiVREp/j8ajx7taCZfUzh?=
 =?us-ascii?Q?G+Ap1qRRAheSgei0cdIHEczhKYncM5Ktj8y3OAFXS6EorZ820j9eduR/F/FW?=
 =?us-ascii?Q?FM5XD5/1pfhzd2bT+p0SRLMWjurcemiBxQk2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c967Bz7NY3SorILu5mCGVtgU1drAmA+1Cy74GB6oxB/iOh01BBbaDkeUIlYi?=
 =?us-ascii?Q?9Z4pv8oYrMLFRFjhfRA8QGjemsTJ9kdp2J5kWArO+WarU3eofqVsnYvyQhlK?=
 =?us-ascii?Q?ulA1cctzHv1tklOAwxleey48hIRODHewG6OrCnf0xAmEmzFwfzqqXdv3Q9ZA?=
 =?us-ascii?Q?n3g91ZARo2kwj+zV4PdgqVkRi+7VWdV0+RxaMuHjO4TjmvG1KA4RUbwshoFr?=
 =?us-ascii?Q?OvJomSFZWntOz3/10B6CIzCaqqtk8hcyaaxkHB/7axVd1iiS9p/oxj5bCFNM?=
 =?us-ascii?Q?N+Lh5k7ymv6ZJ6XwElrNTnKN8vj8Fd19ztgYYcwUsWGVi6gpV21sXt9o5LAQ?=
 =?us-ascii?Q?uFRj5g+ijzWnHbo4YW/R0nkimScIp3XoD3+L1XeuxI9zCmOYDn01HcjB4mQT?=
 =?us-ascii?Q?eRBXoWoN2r8eZj5TM1yDsggyjXDbovzhaNKlmY96/LRseAh7gs1DE4ZGhAZy?=
 =?us-ascii?Q?oynYJ5iMwCaklEOVWrPCW2FVVF0UHvv658X8wTuyw35uphUDb+J5ZH4Ftj/c?=
 =?us-ascii?Q?Lr9hdAdXOzRbdLrnCPlHv8K8//4yiwTMpu/Z2NQf0Mv52ouwzf8XwZyUakcE?=
 =?us-ascii?Q?9tok3CiTol4oEO7/iRYwh8ns8tpqs10JC28XMMgT75VtDBZPjH+9+of68G0c?=
 =?us-ascii?Q?r+3e7ftHzvF/zoufknc78m8u4P55dgpiJtxuv27pP2GBn1swxAkyZjLtdOOz?=
 =?us-ascii?Q?GfRWJz+0TTbnVxZLjr/XgNzYEI2KTOOFjfxLUlRTCc3Uwru/W49JAUChFoat?=
 =?us-ascii?Q?Q2SosnORlSslwHYIz3jSp3zQuzPOTbTyefIzKFAO8SXU8FztmfCK8l8HZ0E9?=
 =?us-ascii?Q?cPUj/cNDPoeYKzczpqmun1UQCFkWCricsXNrGqiI9GdYlvTl99R2ziCifNSq?=
 =?us-ascii?Q?XkTQq8r8/RArGp1YKQk38u6Blps83QJeBqnLEbEwR9rsaZPCE/FeVICB8ptD?=
 =?us-ascii?Q?QWknnVy2N8uTvGWOp4gPzRFVHUQdZDoE1HbpzGd0h+IGUssXiNivVkE5lUWr?=
 =?us-ascii?Q?g3WEW57h9BUaaxC4zdYYpfrjAIygiWrcVN/3shPQMl/KLCBXUYdtlDjeu7Z7?=
 =?us-ascii?Q?LsPA4Qr4dGQs+zxKuH8Byzzj45sbPRU6lYGDaVkq88/VZOoQNi6BMGicDoP/?=
 =?us-ascii?Q?BDPA0SKjORqIxSED0RL4Dd/XLFStNK8Dsag98fknRLItkLqbcTx/BzwZWIG+?=
 =?us-ascii?Q?pHknlQqiZZsn7y0L0XcDw/s44A7fSjNf4iXThEN9WIFCymngw9LVhUthWmVM?=
 =?us-ascii?Q?cnkv7KK4fk/8EZ7GP/qhBfKPSxrz2MyZWE+EEEzIHXYCWfJhLoXR9bxwEqoe?=
 =?us-ascii?Q?Bft3FHFXxYUa8DWkPP+tKYfx+Db8XUJMaMO5mwf6cjPz/jtJKKiEjGLdP35s?=
 =?us-ascii?Q?BbhJR9OI56E9AOKDokepj79UHtw048Qi/Mtu0jIWiZ4zuj9P9ugkYdn5CvHZ?=
 =?us-ascii?Q?ZaFambDkoCnNksORx++LMAdhFt9vtbhAp/5MjOafkWY9X0obutePky4wzqLN?=
 =?us-ascii?Q?CzlR3hVlGWTUhanYkvp/tShr3dtSbku2/Wg8n2a3astEOAHMuDO5keSBbeAZ?=
 =?us-ascii?Q?zabQVWMdxhX+64oPQPE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598de56-d2a6-466d-9013-08de0c042026
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:01:39.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+A6WshyCouCVud56RbUb/qiwoQ/w42Fe2KEv3XxKr58PBYl3AmCpIPDjywDrf0XsceUBLf6fWi6QrqwAhzyTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7860

On Wed, Oct 15, 2025 at 10:03:44AM +0200, Lorenzo Pieralisi wrote:
> On Tue, Oct 14, 2025 at 06:20:55PM -0400, Frank Li wrote:
> > On Tue, Oct 14, 2025 at 11:58:43AM +0200, Lorenzo Pieralisi wrote:
> > > In of_msi_get_domain() if the iterator loop stops early because an
> > > irq_domain match is detected, an of_node_put() on the iterator node is
> > > needed to keep the OF node refcount in sync.
> > >
> > > Add it.
> > >
> > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > ---
> >
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> >
> > After go though of_for_each_phandle, I understand why need of_node_put()
> > at break branch.
> >
> > It will be nice if add of_for_each_phandle_scoped() help macro.
>
> Yes because this fix is not the end of it AFAICS.
>
> Please review and test patch (4) as well since I slightly change
> the existing logic there, I don't want to break the EP mapping code you
> added in f1680d9081e1 (by the way, I don't get that commit logic, if the
> msi-parent loop would match it could just return and we could have
> removed the
>
> if (ret)
>
> guarding of_map_id(), correct ?).
>
> That's what I did in patch (4), please have a look.

It looks correct. PCIE-EP use msi-map. There are comments from Marc Zyngier.
Suppose you will update new version. I will test after new version posted.

Frank
>
> Thanks,
> Lorenzo
>
> >
> >
> > >  drivers/of/irq.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > > index e67b2041e73b..9f6cd5abba76 100644
> > > --- a/drivers/of/irq.c
> > > +++ b/drivers/of/irq.c
> > > @@ -773,8 +773,10 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
> > >
> > >  	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
> > >  		d = irq_find_matching_host(it.node, token);
> > > -		if (d)
> > > +		if (d) {
> > > +			of_node_put(it.node);
> > >  			return d;
> > > +		}
> > >  	}
> > >
> > >  	return NULL;
> > > --
> > > 2.50.1
> > >

