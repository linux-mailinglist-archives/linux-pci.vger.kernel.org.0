Return-Path: <linux-pci+bounces-38378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45DBE4B13
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251EC3B3115
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971C3329C42;
	Thu, 16 Oct 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GD4xBcO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448A2E2DF2;
	Thu, 16 Oct 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633467; cv=fail; b=V2yzWDY95yVY6hGJcatGlR1rPb4jxQKxVGwPs3muj2/x3BXP2bmHw7XEcCbKlS8xk2aVQk9nS345FOfx+/6Ow5znI4miELDmCXj7BB7b2gOzw+I/pl/sitaOXg8LKdmiJkiiNW/Ri8miqIzK1WtnLRoD/rSVTHQZw1sK3//wT9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633467; c=relaxed/simple;
	bh=HNhQbs60BNCBeulW5U3SKEVuyp3OOIMejjWg+aCFp2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFFmwsP7wljH3WXtoJS7GWzbMcNgPfiT2vBpXcAqtYTMnesVQCOxqM3KYSz7s0e6x885fs/Mdrf4GxfzPqRyMMpyyyzRRvdLzTVFZ16APXFYbN3Z3xKPpA1PbxA9fvEGwacv3qTS+cGeY/7laILFZF/xpXSvMbSWUkKuSkBsO5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GD4xBcO+; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbJif+6fXGtkk1Ghd/7A6XC1qw49ghjpXQrqBTA4PsquoE/lcOHcTm4pzP9MZmcoEcYnfnrJrdsSVP8lxWop5tU7rvw4u7jw27VODpq0vr9I+OsHZv8We/u+sWYfBS34Q3Zi7PPHRzUFXghRGSQlmeBrVrXE9i12CgHRvOcP/UfmnKEcW2Jj8XQ4t+oQ9LUHSsff/QYQKQcSBwxviDKMloIMQNwFGmq9Zw3dhrKxybBRDtKYDf0JiWufmrlwIqbuhKouEPZD7Ge4DCEQVjRnAJlXQt2IMS12kgdraJGn8JRxBS1M2pUo+Rc+e642PadDDyKLZvCKUMZJ2uThEH2yTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkjb7O6b9K9s9XurLxDHzl2iEcrlgBxGxlkJGFbzXtw=;
 b=OMYoSfqlUywcHuwSgMdtnMl6DRAUSPeOqzkZj5xiMeicvEk40YOrPkeQQQwCUjLbU5LR5MsIkihfZ1/xpQcgVDpx4/zAJ4A6jBkt4dPgafWstk0PsI+lxZAag/lluZBwJPpenHkUx+DZL8k4SfkWLUw++n8HVDI9MuRlWzAYAjyFwP1yCXkhJjC5SCschf01st54fZ83+K0R9Bk7xZ9GmsTsXMxxi8Js3Lzot2lNYsSG1xnGX0kPhQ5uGtftmInPUX1avyPhsOjeb3K5lQ3CBKJTVmhIrS406UMpFar8t4C/jhBAMFxuVGDeg+DCbZag9/Foh6TUOOkSWRGqBGawRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkjb7O6b9K9s9XurLxDHzl2iEcrlgBxGxlkJGFbzXtw=;
 b=GD4xBcO+HtBXh4hYZdqOSKNH5Wc8cmyg5XZ6AtSVzdyYYlL8Bj8+AX/4y9dKt/xxIISKWo/Elg6HC/1biljehR+yxCiqZWB+1g+lbYtf/2rnqY5n6UPGSAavO3wtJXz1mvhVpRYAAs5LbQ1W9aInTqT+9xZfWuEz/eN0Tj9O2TeQN+913wA+d9oe6WaMDPr2Nk5lPto759sazkGHy7sD7wbWQfr3bSjCF0gvoOrSq3w5dpRU/fg8CzvgHM0CimCPPD4hgaGjBCcfBYvb9Hg+xM2nEchtkUYsX2SE6dqvMPv1aI54FsyCuwmxFmumXQP/CMtiyedfxa+jd8rrnhz5NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11602.eurprd04.prod.outlook.com (2603:10a6:800:2fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:50:59 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:50:59 +0000
Date: Thu, 16 Oct 2025 12:50:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Mohamed Khalfella <khalfella@gmail.com>,
	Christian Bruel <christian.bruel@foss.st.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
Message-ID: <aPEia0SAm8YoKvnY@lizhi-Precision-Tower-5810>
References: <20251014024109.42287-1-bhanuseshukumar@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014024109.42287-1-bhanuseshukumar@gmail.com>
X-ClientProxiedBy: PH8P221CA0065.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::13) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11602:EE_
X-MS-Office365-Filtering-Correlation-Id: 47aa6f8d-9608-4247-f0ce-08de0cd42eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c+ko1R4S5r0d6swxSc7DPdT85qtZbIwTySB9AKQ01Y9ofG7lfIJPeu0bKk1F?=
 =?us-ascii?Q?2KKrTjG+lyL5bqjweP/QJ+SWqY1Ca8lpSLdhJNXV7h9PAxJvGH8oSZZe9D73?=
 =?us-ascii?Q?h8rumteBsX/k37y6eLceWVCLfgMy0PJjCLqRL8Gt2ae3Q1R6YneB6pabW2Vx?=
 =?us-ascii?Q?65IrzFFDSjyCkvk8yRwo3MsvABCJP3KGpJL3bZ2wMow64vH73k0iYl8Iql/O?=
 =?us-ascii?Q?YO6xFBsIOMRVmxIK9yzlsXyqGHwkqAM49H+ij5ByatFA82WWcsT89euDcZi7?=
 =?us-ascii?Q?s/fCCyNmm6/NHxmIUtgJzmSmLYfcj0LQF9v7zeD+IKloKSTv8kjX7e6PP8l+?=
 =?us-ascii?Q?sAxsNzN9MfjOlTItyPTBdJAkIHa6rAYMwv/H8Yfo4sfrkBDJDpPebrOgIVgd?=
 =?us-ascii?Q?9qj77ZkMciSEp1YFhS6cbK3ewsdD88R8pPiETQbuvhhzkdGJj5+9PHM0Ww3v?=
 =?us-ascii?Q?cewTBzAiobgG/3YB17MWm+fFy9MLjrAVQXZrIjUzZ7G2XeHpJkg8ik4QOrEY?=
 =?us-ascii?Q?ju1wW5n0bGJwDpKMkKhZsmC4h6ayV7nGYIlAaGz6xktcyHffSRho8lwAhtE4?=
 =?us-ascii?Q?WLK5qp0+jZgPmS/aUmDO9wPIXr/MgE/rq3L+qTzQhe76O3Q5cuO2Lz57T3Kv?=
 =?us-ascii?Q?zK0Q7AQO2SY01EullVZrIeQsu2nU/lU4UhEUwjnUWuynECSS3tBTd4j8V6n/?=
 =?us-ascii?Q?2pPq9n00FLIIKwekpR+x5EY4RqXkeOygBjh6v8DonPaPSNnM33QiLEJJe6j7?=
 =?us-ascii?Q?3mS6+L5YoFQPLD2JWQsDlKGhFl9o1oQQBe7XtFLOeBUHcW7zF5qvVfqIAdD0?=
 =?us-ascii?Q?CkGuNYS76eGW6WTEPiz9jTXLx4LCkR46qjU7Py6DZoDJdY2ahBXRKwpxL/PN?=
 =?us-ascii?Q?eGG0+DPXLoFo0TIsnIVpJsAn6LThBtP+L3uVbgVSVJ0iASrVMtUi0fmyxUkz?=
 =?us-ascii?Q?kdhgRW4g3gMGuxadHE8FOrtZXhIAywGWEhJOj8xFe86y8QhktKSPG811mjzh?=
 =?us-ascii?Q?EySsPZmjTkJ0MTEsPmjeI2EhEsraDe5xxO9CwDnmjoOGBp44Bbc5N3M3d/Cy?=
 =?us-ascii?Q?3VAIgU/kK2xDkSSEliqCYyiQXuWgenxa2RWv0xD3BHYsVs5h//LqHA9oWXwo?=
 =?us-ascii?Q?Pj8sLT2gTf3NFXerIZd3o1k6kkVhrUozrWphinVU85+6Im9qWiQUZpY/5/81?=
 =?us-ascii?Q?zct1lU8fPFk6GC825nmIhLWtrbLbRl/4zYlaUDd0k+0hizgIQuZUfn8DQRWK?=
 =?us-ascii?Q?gLRmSVXsc7earI87x4ekp1/8tVDbCuOPtBlX1Z1Xq7NeG+X9CI37s9cMSOAY?=
 =?us-ascii?Q?Ro8dIW7GgYN71o3D3hS1e7kIeHG7h5wrW/7z9XihwoCAVeYWvZcBtUcamUfD?=
 =?us-ascii?Q?rP1e6jJYzBhXvKa9181egrUMrHO0eDfATZDupkTAvXwkzkqxiEIKjRzIAzuA?=
 =?us-ascii?Q?36d6Zd+nNdeq2YyWEbwodm7JpBAII9t8nSNCr75HoXENXBAXJqmDJPPGv5tI?=
 =?us-ascii?Q?IZNKtcG9w+GCc9VSRpt9P5ZgLQrOOSMPocqN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8mHfBpRoXepS/tbocCYuNHEeoG0WQrJQQIUS+Ba6K6Ru6W0NRWxpTDC9HiA?=
 =?us-ascii?Q?zQxtSvkiOvp722QdxtW7cCPjUy9EZnqmcsPRUblJjFRBb/Ed+9tJ/3hdxFFk?=
 =?us-ascii?Q?BiPyKpeOY2Z/aI3C4ycM8o+Z5Ngch6tclx607naERpJL/k69Rrg9jPMmX5LY?=
 =?us-ascii?Q?g/glMG/Bzlpce5vIiFIQ8yMk5YeIvOi1JQbbGpIKLNOAoOAC0ZSZYT6/yHNV?=
 =?us-ascii?Q?c9dbLbbS/LjNsBpW+IF7jxg8im/16UV4kvz2RxDb8K2ZWo49Q8OfdtccGxxb?=
 =?us-ascii?Q?wW2YOZ0RglINVPbUAkb4DWIPSA2S+wdXjSboQglv3dkg4/SeSv3rK6rtN3IK?=
 =?us-ascii?Q?ABunZoqGbb8oGYLVfZAJzfUL1AwNu4hgTrVCoKJXjV7Zdl1R6I/tSSZFH9zd?=
 =?us-ascii?Q?OP2vNajEAXQwQZFx1sJO6JidDhdO8kZN2YPQ384lVqARlS/mu9rP2G3hSNzn?=
 =?us-ascii?Q?aPI0vmHhpIHCmL+Q6Ek5xv3+rwgfgwbmWuQ8PzyFHL/sxXrCoBWqA6D1ZbWH?=
 =?us-ascii?Q?Z45c4xhyXdSswu87K2cHoPxjJ4njnKh/fHqEOQmNg4+7tyTzlaFtAAxWDQJN?=
 =?us-ascii?Q?hrXTDKL9E7EVQ7hthAKFEA0daTrszDM4T4qp0ZOEa2SVxPkoUriMLJ9F4Bf9?=
 =?us-ascii?Q?4tZEMSdAycrk3nmWr4AaBJQFEVGYgy/BT5HSNf0HhqT4uNsPUv54ovwxNHu4?=
 =?us-ascii?Q?WkPZZnVVGGSO+L11jCVWo9fp5q9yFjMvJGnf0NhlpOldESE7bdbQRyoy6xVJ?=
 =?us-ascii?Q?YC+VMJh8h0tsIxVJOZMMdC1Dyoomn9EL9BfN1XUhCEuQGMzk9596zyagIuia?=
 =?us-ascii?Q?ODsM68GJ2xzvUnQaa5cwyZdArYdGixyLEGX2kCuuZQbTHWB6A6RoamMuM0Gt?=
 =?us-ascii?Q?/lUXTq1Fii/M28jrgcl+DovmlErtbAeV8OMPdnvXkU+f/LFn8CEe4De5A4TL?=
 =?us-ascii?Q?nrP08XvppjDwHu6HhgHMKG4ksLj/8ddwu1wIGwLq+9hhCUtD+OLOTUFsJO9U?=
 =?us-ascii?Q?SaMOobryqWvHNa7RRF44r2E5qRWlIvZm+AS/SyoFdMHZu4mfcBqKtdOJuaST?=
 =?us-ascii?Q?usrCug7TFTvglBumjoojEMHO4nTqU6VCfmd4l7vsNRcDuEQUec3IEjq1pZg5?=
 =?us-ascii?Q?2Z3jswcmy/FbURtXN0lkMyGI5mHdahq1sSE2XBzIbIkqSxXC11JXRSWMNX/g?=
 =?us-ascii?Q?EEtfPx8fEjT+1t8hfQKXVoPItFsTGVBsnw8K8XnPt7FbjfCbfYW1cLGicTOX?=
 =?us-ascii?Q?yHJPgPdk8pw1OycD+p8esCAkQeh1n7LeKe2sbZC8sa07G+y4htQESoXKvr4b?=
 =?us-ascii?Q?mVHpVZj7GiwVdFVBL3G+U52ImYyRAN6QdCYcNnNvNtksnH/OArcjD2csCFaR?=
 =?us-ascii?Q?1Ek2XNXhTPMuoBHBPZQajh4/+Jv3DjyaD3xpv7nnfxZBhN/9EJDM4TPaVly1?=
 =?us-ascii?Q?N21CGMYmiMzDukj0JW/khivPkkXGJ1M6aslyTG2JtZ5q6hS15OkN/vmmhUjU?=
 =?us-ascii?Q?bH3cM8JYiEg88YK20axqsfklRFuP7uL/06SvEw0Anc1reqqoyc6CVwxk1uRK?=
 =?us-ascii?Q?1RLcKdwnXCCx2joT1Ks=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aa6f8d-9608-4247-f0ce-08de0cd42eb8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:50:59.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HO7Ogasxpzi5xvZ+Wzpeh0JKiLCamGpATzBEsR1yPInXfeZxSVFrcJb2QK/wV3vAVr6SYEoPlDAf75ymRwkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11602

On Tue, Oct 14, 2025 at 08:11:09AM +0530, Bhanu Seshu Kumar Valluri wrote:
> When Root Complex (RC) triggers a Doorbell MSI interrupt to Endpoint (EP)
> it triggers a warning in the EP. pci_endpoint kselftest target is
> compiled and used to run the Doorbell test in RC.
>
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
> Call trace:
>  __might_resched+0x130/0x158
>  __might_sleep+0x70/0x88
>  mutex_lock+0x2c/0x80
>  pci_epc_get_msi+0x78/0xd8
>  pci_epf_test_raise_irq.isra.0+0x74/0x138
>  pci_epf_test_doorbell_handler+0x34/0x50
>
> The BUG arises because the EP's pci_epf_test_doorbell_handler() is making
> an indirect call to pci_epc_get_msi(), which uses mutex inside, from
> interrupt context.
>
> To fix the issue convert hard IRQ handler to a threaded IRQ handler to
> allow it to call functions that can sleep during bottom half execution.
> Register threaded IRQ handler with IRQF_ONESHOT to keep interrupt line
> disabled until the threaded IRQ handler completes execution.
>
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Note : The patch is compiled and tested on TI am642 board.
>
>  Change log
>  V2->V3:
>   Addressed Bjorn Helgass review points in v2
>   - Rebase to pci/main (v6.18-rc1)
>   - Add a space before each "("
>   - Remove the timestamps because they're unnecessary distraction
>   - Add "()" after function names in commit log
>   - s/irq/IRQ/
>   - Rewrap the commit log to fit in 75 columns
>   - Rewrap the code below to fit in 78 columns because most of the
>     rest of the file does
>   Link to V2: https://lore.kernel.org/all/20250930023809.7931-1-bhanuseshukumar@gmail.com/
>
>  V1->V2:
>   Trimmed Call trace to include only essential calls.
>   Used 12 digit commit ID in fixes tag.
>   Steps to reproduce the bug are removed from commit log.
>   Link to V1: https://lore.kernel.org/all/20250917161817.15776-1-bhanuseshukumar@gmail.com/
>
>  drivers/pci/endpoint/functions/pci-epf-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 31617772a..b05e8db57 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -730,8 +730,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>
> -	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
> -			  "pci-ep-test-doorbell", epf_test);
> +	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> +				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> +				   "pci-ep-test-doorbell", epf_test);
>  	if (ret) {
>  		dev_err(&epf->dev,
>  			"Failed to request doorbell IRQ: %d\n",
> --
> 2.34.1
>

