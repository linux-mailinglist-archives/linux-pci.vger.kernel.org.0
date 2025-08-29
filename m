Return-Path: <linux-pci+bounces-35134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17488B3C0DE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3947A189A3C2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E8332A3CE;
	Fri, 29 Aug 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lsaSzTmJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1D32A3CC;
	Fri, 29 Aug 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485360; cv=fail; b=BxKjIqg58vXrWfQfL0mXL6EnIy3bDIkyklh64+V9bR04phgrYuxngpehU/w1IbzmGVD5+CZhev2zqRtvINOkLPvHMNnR0rMcJiKAFgr46RLCxrm+1bkaC73G6BcuvONIx6cx+sSFNH/6A/I/ABnnZB+p4/CTIvjw6mUPtxnI/OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485360; c=relaxed/simple;
	bh=glbqYJyGylgbG5vazdRaY2wQgyZsrbCSeRawq6mvlfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XneeUe2SKc9rjQadgyoc7dY1oudmPpbKe8JkTVkJa4mmvyQXfgAPCNWb29PWyJWaTIDSDUbqpJ0vUmJTOamF6y1A/3cTJb6+JfMVhCR0LhaGGO9Q0t02fQpTdAPyaUZwyDEAhm824I3nJeFNGr9RQo/Z8SzXkZzN9t1CH8xw7PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lsaSzTmJ; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrbnknUc51YZ1sBdld7ijw9N5+HddPcP2R+Twj8E5TIADz0cG06DvWNqjURReXyJcvJLtbPXCRxPQs2TsvOc3tPBsSkoDMj929iF6+WzWPH4tdnYz6wmDKE7lAMzo6KRItexInRPIgjoZ2mEHxh/oJy7zBBUl3IuJwNrxOIDQO3i+IYECnOvM9AFi2Wr4WivIjE0nUw6QONCskKfmPWPmhi44nzmXYu5xGXFQCKqgckmsDkDropcfKE3Qix42hS0C3JJ3BUBXT0oDIvnCPWE2xUYWjAwUhIv1xRwGyXLfsbxKMrojw6IOSGBbmugJ3yHyi9M/2aLUn1XzySS/6mDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCEsmZjBjfE1q7GanvDmdh1+lNhj4vTq/2YON8UVUNE=;
 b=jc+y2RKeYAFjxFTeOq0UgL0arVnNhPNBqwal1imJFdul08SJurOLEGHQ0UKdM7+ZrbTvDNyzIeJlPshp9+fEtBJzb1EHFtv5Wqa13btqDwQsMCMUoj4gNG8SPJr5oLLw+ibAhgwhOD2YmYoGpSctoV0B65+lsmnE/S7Kqbd3+mb95uvLt6XpE1K0TJRNLoiwMb/RjwDy2IQ4DSxeOO+iFvfzJTDpTTgv9bPfmGUgvmXlYjaOLMe1NV+AIKVQ3g+fO2nRo+DoF1i0Yxa77RgwzqJA4Rm6+yqeje2/PSo0EV/CK8US18Jb5F20eD8GNbwbN/EDp0uQHY0WLIrlwRfG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCEsmZjBjfE1q7GanvDmdh1+lNhj4vTq/2YON8UVUNE=;
 b=lsaSzTmJd6K4rvnBngRSR+Vb2VEHMtwN3ByaimYP8gQJ3b+9+Hhq141krrm8Xi0LUj3wF9vLLJxn6RbA6eSmCS5t8S2wyHEO2uJSwwNpRhU1zGyX7t79kTspEHAvboiQzrLQ5X66S5kMgk4K3TQDbXW8TD1cbGgRNPwPwRBtQAnx1WjJytWKfAubQEfAfCfjF+MpqzlHn3ZxEBTVZT4ZipA+S+ZEckXzq/WBbei5TR2mNQ4Jv6+7JauxrTYOg40fYzOo9J6ucZEsX4VF04LCRJEgPaGt6WOb5kOzVD3iAVhTRDS6qamsc7/0rtzHzgYzYIgdeFNEPj19avvOpwFJSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 16:35:56 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 16:35:56 +0000
Date: Fri, 29 Aug 2025 12:35:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH 0/2] pci: endpoint: vntb: add MSI doorbell support
Message-ID: <aLHW5NWF3PVFo/xn@lizhi-Precision-Tower-5810>
References: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com>
X-ClientProxiedBy: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e8a584-b495-4639-77d6-08dde71a2083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|7416014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?huEvtwA15sIh7h9n6ujq6HVIEHR4LLQL13yWyQRlzQxJt+JseJnqWARtkGjh?=
 =?us-ascii?Q?1qEQ0Em/o3w06oB3lP5XDOdVq3TFL5fymRcfWMC4vNelHPBDLdO0f4iICUxw?=
 =?us-ascii?Q?zD7qiW2eiaQtajtZEF5PUWD37WW2adQ1jXutYdrtYi7D9ldgFmZE5BSFk50I?=
 =?us-ascii?Q?OD2vzxWr7ejMqS4f0NZu9+BzdJ5ilivtKAM6HIEF2thgw3Vyv8pEurnV96ig?=
 =?us-ascii?Q?O52GhR0+osyKf71SeEeX5gCBXHH+5Zd/TGeK3ii619Hprr3Lyiu6uVUunhaz?=
 =?us-ascii?Q?PKa9/EOiXuJ8i8Wg/gCjZhuju4QqJ1ytCw4qleqySu1/eOq0EauJiLa56taY?=
 =?us-ascii?Q?A6DLoOMKiySm/N6xapsQiKckcsBosAwd0VgCGTPB6Teq21EFk0Po/+Xejjy3?=
 =?us-ascii?Q?UqKzdII05ot70UqS63JYo9GzROaqzAhkGL2F3qLYWUn7+bwxyyUHb6qlMsG2?=
 =?us-ascii?Q?zN0ZdWHSOkJhblvwrZUJfyGv65b2qvkpE3NR1gJGHz8MxqCurUThVzLll4t7?=
 =?us-ascii?Q?OD6VB4BGa8hSFRJVqumzQRAr4daEsSbe9lbWsp86YyiZneLJ4HZf3g4pYqqM?=
 =?us-ascii?Q?5fOBCRaHwebTkp9j9g2aj4uO0/kR0GMdIs3nexX6lywTq91+VQyP9rkrG1BY?=
 =?us-ascii?Q?nzsRPDUoyScfJWosQhmsV7M2MxTGyJkBkWudNrfu7rdf+amzELvanRu/oXWM?=
 =?us-ascii?Q?sZIhjvACCoaXiMSLhBJCZp8U0BX0MHMQX5+wLMHrIzMXb5I7CWEEKU12qPeE?=
 =?us-ascii?Q?b1/7B2tlEdpdoFD0HR2qJeIGbeg6xu4IT5srJyi4kUh0reTniYPP4rZluVek?=
 =?us-ascii?Q?qkzOK6v6VGNajmc+M740mpmfQiT/ZPrPWGk9eNIeQZV3q4HqAX/wZ3ycA7Ub?=
 =?us-ascii?Q?RAgHfFkK/pbnnyAFzOfUoykuz88i/5aS/esjAD70/WPq9yJpN63Iw6Sk5yiq?=
 =?us-ascii?Q?f6ykmvWQyF3oBzJeJpbtRlxUMtprq+YvcGTk+FNs464QAyDdVgk0c+WLX1wi?=
 =?us-ascii?Q?HG/Sv5QTxVjupCHknvyi1D54O1TFBTZfvT6FPaDzkzE3IqOdCV+ign4zHZx8?=
 =?us-ascii?Q?8PGj+qJVyQ/+9xOhDpwM/Vi2BIV0EeDMK728ljOY+1xIkaWJnUuHG09V0VI6?=
 =?us-ascii?Q?P9lhsPckRVeQDtwIud2QcQ/KG6qRVhPKMYqIs3V4Vg8nHcpMgzCCdPsXjkZn?=
 =?us-ascii?Q?4LKO3o5ijlJeAuZMZJLj36aaMuwkI5vUlpB2E7Y1pFazYTpggljRE94zi/BI?=
 =?us-ascii?Q?UVobIFxc2FFpf1zx3vepnptUXBovOwerQZ728jPmp9bPxjocAUAEG4/Cv8my?=
 =?us-ascii?Q?gUftbxwLlMhKwY1OR7UiDEPV27muFp4e40PlhT1R6ZomH8mESR9UyPaV7RXI?=
 =?us-ascii?Q?3Ck04YjyL+rQKF6sCTXkKhblNLO215AbQZ4gEki4+JVbgHUlBHJvZp/p4R/I?=
 =?us-ascii?Q?LaP4vVs5liZ/PIGs93xISI7eOEJiSKtzb5M2xCBpSkXClJJwPkK9yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(7416014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EPgzG23SV0OKYQa/u2W+9t7VWbF+QWOPiVIGF9dy0/BWTQ1mUEFOA6RKSda+?=
 =?us-ascii?Q?f3uvIpKakmwBJCvxcVVL7aEogAPEMXwXJy94U4A0rOsrg8h/pPh747MInNHQ?=
 =?us-ascii?Q?nkoYIR6Gyam6JcjmvVc6DS49PNBjBtwiorvS+lR6UTVj/WysxT1qoGqwHgu9?=
 =?us-ascii?Q?x5M1XJglpAVpkDL617NVl8JvV3OQIzt9zv8Gp9MjDVPHXVCoSLcSGPJFnWhO?=
 =?us-ascii?Q?matvsKiYhH/0RJrdLh0bnudHVvxhBOVqURtNvKa590OxGgrpa6ZY4tQJewaI?=
 =?us-ascii?Q?+AZCJYY3Kxtpi3NjQLtBdNvBXALVWTVSxemdiTpNsns+fvluGw9wtu44BAH3?=
 =?us-ascii?Q?njWtVZzPDscdWYP5989BINEoIo99i5Kqi5aMncAs3b8ctcEU/NM3LyiKUQu1?=
 =?us-ascii?Q?EQsemVc8BsHLPuZfrgOLXiTR5yOYaq8u14NSElRvVq7bwe2vXEmFJF8+noel?=
 =?us-ascii?Q?DP6HL+GwO9GcUgd6Iocr5SIDBaMNsrxWySvjgyXUObtwF5HsIuQs5m1aV3kB?=
 =?us-ascii?Q?UCYO8GivpE/Gi1E7z432lkW48GlN4IzK2uHDd22z/q1NwAL9jscFtdfqZRYx?=
 =?us-ascii?Q?L8Xh13iqzKvQ0CgDrerbF9mJaMgiicgCjm6VXCvz28pEbqrmQ7gGrBgfWQvt?=
 =?us-ascii?Q?o0RqY4gAGaRlCwbM65CePMsU0QRzbqMrqQHXiABRaq9Q6Kon8mp5Ft63Obqb?=
 =?us-ascii?Q?yXREcGqO1fG9DjzQoqJVIj08Z6EsObt153kbI9Zmfl1ehjgeOa7eeHnPXaXz?=
 =?us-ascii?Q?6ns9VyRIMQ8cRQSaXKMBw2OfYfPmwaH5EgHNDS8eEMxkcy+b4cpDGKA3Nkmp?=
 =?us-ascii?Q?l08mCSZzpWq23zx74eWdKRjtIkswzsNd+DQRlJZyXzruVp+Spe3eW1VhETOT?=
 =?us-ascii?Q?/wlUEgWq99oZZm0NfuQZGiQE8gS84+49savQ86eaLSehXpEJmh3yJWYtC7MH?=
 =?us-ascii?Q?X2RASPGc5PkcAZEJnOYM9Sq6yl5AasLLKtaD0OR2/pXNioZ7Fudu3P5BS1kP?=
 =?us-ascii?Q?9ng5pKR5Ag8h2v0tBsTujp5K9yWNC//CdjHB/GVK+ZXDdRDAQNeP3/EsK10o?=
 =?us-ascii?Q?IagtZVDXtORZBMoS0LiFJZ/tf8v915AC7eDOQD0nXWaukOJwp7K8Iq31TWH8?=
 =?us-ascii?Q?jMJ5sj6Y9B5keWK7tbq+Yi8dVf8eMqXmPtYlxh4/SQRKvW018EUArdZsc/Dn?=
 =?us-ascii?Q?KfADbUVouik341dKBBgZESCRLGBd41+tsSlJ7eY1ROWFgbr8fM/6mcqNAIPC?=
 =?us-ascii?Q?1R7JH+Hz8Fa+j9mruivgzq/7GsQBXS/r4ORypt5+kjeCcijyHHAv8EXK6k9W?=
 =?us-ascii?Q?XsBP+bHQP4qFovAxoG9cT2Lci2+Ie+HAKXxpxC9My3IVie/ipdyeQUmxl2qc?=
 =?us-ascii?Q?JSvsldoYdUHCA/nDaLqPj1GyNSofXQLnxWeaSifat6K6NKH7nosz1n8aJ4Hh?=
 =?us-ascii?Q?8vXo34aK9FukimYnRE3bjnkcBRmHwjGp1inv+NxwgUDxIVnhighjMNkXhmQg?=
 =?us-ascii?Q?0HQ6LPMC27adZmngFvTY2F+3q+HiGNlwvigIPHlh6nAZ5orgcQib+5CRZnUu?=
 =?us-ascii?Q?cA8/1zXCHPxSt7bIwLRMUpcCgS1TufrVTbeXGhbP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e8a584-b495-4639-77d6-08dde71a2083
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:35:55.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssNbvH8pujno+OvVNFnmmL8KTwNQ7kvl3y6s+p+xSSj5ROvYjOa1//n0P9QxxhQnI4OJpLI9cyUpguUVp8bMDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

On Fri, Aug 15, 2025 at 06:20:52PM -0400, Frank Li wrote:
> Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
> using platform MSI controller, PCI EP can get notification from Host.
>
> VNTB use this feature to reduce ping latency.
>
> The first patch impove epf core API to allow set any MMIO address to specfic
> bar.
>
> The second patch add MSI doorbell support.

Manivannan Sadhasivam:

	Do you have time to review this patch?

Frank

>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (2):
>       PCI: endpoint: Enhance pci_epf_alloc_space() and rename to pci_epf_set_inbound_space()
>       PCI: endpoint: pci-epf-vntb: Add MSI doorbell support
>
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 153 +++++++++++++++++++++++---
>  drivers/pci/endpoint/pci-epf-core.c           |  69 +++++++++---
>  include/linux/pci-epc.h                       |   5 -
>  include/linux/pci-epf.h                       |  35 +++++-
>  4 files changed, 223 insertions(+), 39 deletions(-)
> ---
> base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
> change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
>
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>

