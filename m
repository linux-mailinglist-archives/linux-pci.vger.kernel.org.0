Return-Path: <linux-pci+bounces-28804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7789BACAEC7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E14A7A1E91
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B8D5227;
	Mon,  2 Jun 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ubtha35+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E314A0F
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870339; cv=fail; b=VM65bDFq+XNkGU0XwPQfrRK5ZI6K/+OnnUvvXiU6A6LFYgIn/4uS63pXtca79RfsXvtZ8e2y+lwQGMS0MJ5KkOs1tqtlUZpRc0gSRe4nF1ofRMP8Z8EtFXSar5AEiLxQihy7+ek3n2qJrZCLKAqxnOVXiyf3wh/SASRTAV/lLTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870339; c=relaxed/simple;
	bh=sIb71mLOsoh7Is8UnIep2G7/sVB0nzsKo5VmFIu3Bpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QANaSyGzZtE4Isl6X4ecRzex9BkGNd1EdNQftehQ5qlCkKXDQRxleQZYz7Flt3uXPPycU5fUH0sdDh2i5knzDAMgsFnOpvW2BRaiKvy98nXDz4JsnnwXYVVolrZbExzzztAM3M3jcNAzTnbVnJNkfimDkm5trf5wV1SowBhYQFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ubtha35+; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC0JecEdoF9mLmywYsLWQN/y+zYctbXakTPDZpj5S9K7asufyhf779A2ioBBySpRKQWDeb89BdpSu75PprdTHm6CjuyzlxMFizwYEkSDjPl9k/XZmTvk6Zd1DrRsPKTZsSJG1bQ7JyWVUFLMlIJT6tsVjq87K0BPFMg2ldwH/EiaX+lLBH9V0sZRGsVmQAkuXAgVhludrW2FVUMl/1KTgN8MNBrCcYB4mBUIKReKxS35sfRxvnM9YK3LPkZRy7Tqewuor26Rui+4hIVqc0Y14GeGoLyyPnNRIktx/zJdQzSgP4Q3lIyevxefGDId8rMn/elxkw9u/F662uqdfwEHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnR0k+HQ+XxM1G8ydm06vuTsiyoy5oJ91IRRFgecYPU=;
 b=EcAU4Nqbrcg3f74pL+mI37PqLdnThj+GFC6WrUARxLpwQkFcrG+i3hu2U1BEv5BlCx4tk4hy41xazXqtS4IeCL+E4miI878EnFP5p8m4xf1FNQVDXv/f9RgmyPtE2fDR6VSRqBXdLKkz8ukCLlgLlkvTwFGDHA1BnfMZahfm3vjefsinGnnqtgeimzz5+m04rwAAeITw/vvS4tF7fR0Eb+OnMM3Ccan/C5shBj2FolbzzNZsGHHuffHirdkAWR7JHquFrYypS/MgAwAmObnxZaYFPUP+qTBlffprqX/FOTUAOrQQ/KXx7dnZ4e29M1pSm0iaToSdnZ/scCI0dgiggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnR0k+HQ+XxM1G8ydm06vuTsiyoy5oJ91IRRFgecYPU=;
 b=Ubtha35+E4WuiNcbAFBjmC2hxTAlw+B3UEkY9Dc/5tiKO+6K+Oq1pf9B7p6TAyGpyo+J3nkYcjFAwriemanVtQcPKjIeg52ixh9KldZbSt+Kfik+Xm20sOhYDRGib7SIDcdy9Vkhh7/7afydEP/umrBoS3/BaSXT1XP8FoxKvv4QtRngYTnusMYC3OtC3fVy3hR2wdFlBtjJpur5dhtyegSBnzDFf3TmYFpjccjuHvXyRxAE4BsLu6N8Kneo6Kq4vewI2+AWh+0L2BEGhGTltGMKdlBoVRSWKnTbP+I4OEQQQhLrXzIyvu0NMcC9q0kjhgtgi3e1mHw/2RA8wQWwFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 2 Jun
 2025 13:18:49 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%7]) with mapi id 15.20.8769.033; Mon, 2 Jun 2025
 13:18:49 +0000
Date: Mon, 2 Jun 2025 10:18:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, lukas@wunner.de,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, sameo@rivosinc.com,
	aik@amd.com, zhiw@nvidia.com, Xiaoyao Li <xiaoyao.li@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Yilun Xu <yilun.xu@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH v3 01/13] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <20250602131847.GB233377@nvidia.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516054732.2055093-2-dan.j.williams@intel.com>
X-ClientProxiedBy: BN9PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:408:f5::16) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee4bca7-1e49-48bd-1110-08dda1d802e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+cGBkenV9ZINrW3g41JNG5MxqgpyOZUyhIPk6no6S6XSOmdY3mCLs78Imrfp?=
 =?us-ascii?Q?f+u4QqvOj+ajiZNLBkWRL8qSdxVk2QBjzNeXHSrdF30yxJ34xLnSHoEPBopw?=
 =?us-ascii?Q?7/PVN2VUakDwn6sM6jxNZ3T0msTwIo+xxwCZgMZsPXAnXsAYgkaphRMjde/F?=
 =?us-ascii?Q?kPk7UOXv6S83BQvDGUwQJkp+GXf8Ypk2qJQg2zqjBbZANjA0Cwbb5okrUXQR?=
 =?us-ascii?Q?z+SE7KeTFAILnkI4hc2uJ2BzX7yFaPEQiwb08ds4mchWI0ChvIwuPW2gcRHS?=
 =?us-ascii?Q?ynMLsnB0MRGfjGQXro8eINcKsSzEkaXCZJnUBPpaOjZH56Psvsnf31ksKT0z?=
 =?us-ascii?Q?dPiuDCnF8z30x14kf0CsXL9z+N7/gjM2TzBNErNucubHmZvrzs3Ahga4TwIM?=
 =?us-ascii?Q?rhrNTSjFt6go7T1t5K4HUtEr4/AEVeHy0ddclFWYK7ejvUVXO8ZwL4CdVwvd?=
 =?us-ascii?Q?PGif2tvCi5hhRJJ8ksLnBNpl4yebVsBeCB7DXiOKLTXLB1kKZx8xEmoKtcBT?=
 =?us-ascii?Q?QNphYmqI5a2/AtmJkojUsur524j19FFo3YCyDlHe6/h1+14/YylnLLtt+jid?=
 =?us-ascii?Q?1hSQl2OwkwRcOSg5eysU8OoFhWS8VL7b0st6EvPma5UwQ9cldfPhGSCEwr6J?=
 =?us-ascii?Q?RKtzRapFOOM21lCUOf/gCB3UR7B1J00Y+mq0Ypf1uOYLf2w+GV69M/CY4Y0g?=
 =?us-ascii?Q?NuAPTJDEHmyUc65lKCcoTX61s1lCS+Da4zJmjvza4o/OIsJwQvlAdpkSdcnN?=
 =?us-ascii?Q?ClMEEQDREdR4zQeMzH0yk7KJm39oZreZQmF7m97t5WmzYJsYjb6xOlXxXmYC?=
 =?us-ascii?Q?3gVA1qZYiIPIansQTeSIUv9ner32rw5SYnWvQpgfd9olDxw3b6LXbSGErKKF?=
 =?us-ascii?Q?w7u7oRKZ9iLcMND0EWwoKhcJAF8g6a42l6sr0fketyirUgmxLitMw/sykcpS?=
 =?us-ascii?Q?qR2RuFfNNFptpmm8KonrzrQ1ESREUgfCcQ08WwRuLoBoxC4ZZnVaVv05jXgI?=
 =?us-ascii?Q?EFTO2xUBVrW6NfxKIOTA+DI5TP+ZCZxnAi0WwzhJMgDk+WnNsmntP9J99iXq?=
 =?us-ascii?Q?vsy1PxYEASubvPdxJ0ba+KUnXWoDJDg1JWLIuF7qKISgz0bTJk28dXY25Gjt?=
 =?us-ascii?Q?0843x6QMixJzUmENmvrPpiLQ15TAClFTNjl6aDRxH8S0fYO3GOujmU3sOKAz?=
 =?us-ascii?Q?p+7PydXFDW0ICRvok5+xBambMpMqcNgAH2dB0UC1mecWsU3FNJTY9LROUVVU?=
 =?us-ascii?Q?9zm4poEzgr3kpLT8vNZ5TvsDGVZ1EepqO27YRNAZQHp54ThlTd15pkS+8IIw?=
 =?us-ascii?Q?b6s5bn7NFY7++x/12GpBX7AC7f2MdYxzaIBnAj9vZMYPruKvmZDSzednTlJz?=
 =?us-ascii?Q?hzCJJvJ7cQ/OeAkpU+TQJ4ib4ERprT8mwJ+QuiLRB2bt+xqXo2GmudVytYxM?=
 =?us-ascii?Q?JbRieOeZJ3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lGN+m0WaXkdWEYvrfsB9V2bVO9SxFjheJj6pFSz2eVgGjC0pbLVlMTnAjn59?=
 =?us-ascii?Q?PbtzFDF44SThrt+eQYdBVah5xouZrNSqZFZC8yeodPb/mf9KXLowICI8H8xi?=
 =?us-ascii?Q?UFtFafOQAHYIjH85iMQsW+9rv81XxE6bvW5eqzdKxy50cNPcdhuz/AX099pU?=
 =?us-ascii?Q?vDZDukICVlfJ8Xwj1yIF0z1YQJfLCPJWA59U2gQK6GAaYZkWINdnrp1dOtVr?=
 =?us-ascii?Q?ewUoMecUI5ufJSf8IFDy3oO151dvOu54Rd2/qRbw2821IPkI7VCrgGw8Vdas?=
 =?us-ascii?Q?20+rGTKTs3DwXH//loKxW7z6Kgxz3SesMKHIaFaQgqUuNE6XDqETslv4qqXi?=
 =?us-ascii?Q?MvMNzjgJluUUMXz6cum45ENyASakq+0PGKotw8LPwQbGy8PVYSwDYYMjheKI?=
 =?us-ascii?Q?cTTE2/wfjp1A8F8RpP9invI5uJyGZ5hXX8qtJQqzZcgQHwXekN4qtI/mkmdL?=
 =?us-ascii?Q?nls8C5MNq03Fy6LZndywzouSj09Fz+QwWkQQnCXEIdAg2LMenrntHMXSVX1k?=
 =?us-ascii?Q?ZvMFYbMOwgxvmwTln3vKIC/1Qaf88uZ4yLdF83pUtCuO3G8E/ZS/2r7Sqzeg?=
 =?us-ascii?Q?7/W5DvO8qaoQnrOtXmD1pARt+PrWZSHlocXC5ttGxEFja190MML9+j3axNya?=
 =?us-ascii?Q?OA/agpKLiCuY5SzLUndvGDYcg6xPqvZ92PaKN+j9+SBa0ZgUU65o/yx5FB18?=
 =?us-ascii?Q?+F9IDtbDyYbElEoMnNJBvu7vyOjBPSJ76fdPD9ccqA48qRYqXbQxaOgXiNXb?=
 =?us-ascii?Q?gSdCxSYAJYkXd/X0lzwGovXPoAiDfharAYwM4xqeQ7HGlmSffs2IZfS++ih/?=
 =?us-ascii?Q?KXwGVG6fCCqQDVd4B8cT5dfkk0AgVnPzQ8UCV4XzyKDp2DaJOn5CQSuvbfO8?=
 =?us-ascii?Q?rrk6LxTVFBsTkeSZxQnR2AtHNguOHnJQtzPH61Fw4OVEIFQWUmCDdGyM4ahG?=
 =?us-ascii?Q?i9nKirhb2FbpOPUC3Wqq6PlzcX0Pb8tFJsE7qawZ0KHjCwUqltxTyP5+kAv2?=
 =?us-ascii?Q?7CiZbeI1RzILA53R8zWg2okCvPabeXAQNlAjA9dzJwiVTxGrcPbBFpMw+tpY?=
 =?us-ascii?Q?8p9TG62AWOqs/y9xqLpZDc7EB1y4qFK+IiiJhW+egyXj//g+CnRcUhZgffEo?=
 =?us-ascii?Q?QjZXviMAkhvOBNfOf39ZtoBw6sPcj6yNzShSaH8bKDvUfcmE5DFNrd5/fMfk?=
 =?us-ascii?Q?jC5J++LTKD8KttIssEQ+dmyu6DgeOCEi3DXhbE4mkj561lVaTYpGBkJA6VAR?=
 =?us-ascii?Q?FsJiLcGAesOvSTYj+YKJ0VHtiNDHInz+f+ZbTIllDMyqADOBjuBhsEYRamwB?=
 =?us-ascii?Q?RVb/0vFpcRt84xSYwVRFPfgscv1esoqbpDIJtkHpHlMSKttMo+rXIsW/84p2?=
 =?us-ascii?Q?evby7m1KpSa56sIosBtxKL91y0Bxhcicgf98EMVujkugKsL8JpajFFFYdd+U?=
 =?us-ascii?Q?AJgfciDsjYq/bpeGbKoeZH6PFF0DEJ8QFG64tV5iXlZzGM5SqPpzXp3GcNTS?=
 =?us-ascii?Q?3wsJUBwrdZGCJh/xhsfSPlipi8Wyp75ScVH8tmzfRG5cTCq7EX8B8w5KlCdg?=
 =?us-ascii?Q?limgEN1NdJiLha7emUxMKu9MpRbypLNc+dV4g/fS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee4bca7-1e49-48bd-1110-08dda1d802e0
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 13:18:49.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AH3Uidqzi/fj5dEnJ0+Jl6oS5uN+kANXOwI24BMPq5SvykdV7wdPRvazbodeXwcK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654

On Thu, May 15, 2025 at 10:47:20PM -0700, Dan Williams wrote:
> +static struct class *tsm_class;
> +static struct tsm_core_dev {
> +	struct device dev;
> +} *tsm_core;

This is gross, do we really need to have a global?

Jason

