Return-Path: <linux-pci+bounces-5933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B651A89D9F8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261B71F211D2
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5842F12A144;
	Tue,  9 Apr 2024 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qCOmNPcJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2096.outbound.protection.outlook.com [40.107.243.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6A86AC2;
	Tue,  9 Apr 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668719; cv=fail; b=jdNFCthZBwrQyXZJkyZLsBP6euP1l6d6gGYGwgvwlnhXU55QgCguR36sSWgGn4wAj+hlqR8CgUlWJcceNMLfae/DKCSXMY6wFKePqRm8m9NGxTTWBC6NNd0mmPnP2ydo1FNhTGOVq4+9ge/lUWdXhUV+NbjwnSqWvjE+OBPN+Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668719; c=relaxed/simple;
	bh=EbohLSvn9lBuK7zW5B5RH+C2jcnnpo6WjzEQuR0o9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QhX8ADUs+O06oAKSe2MqlJFlyXiEUAyaGKrtdORffTuo2lJlmwcJ96h5pDUvELYjGBVRrNdnsR3PUveYk4seWDdh6JFd/3kExF1pewEe5EZ/84ywlmnVq09Yg6uLDXT4pCce3+3utMFhJFe8webeSXymOG8DS/Uwl5K31vEPXZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qCOmNPcJ; arc=fail smtp.client-ip=40.107.243.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIe+vjjdLcrAC8oUhNFYSuKL9gIavjnsZfx5vLUFj/8+prYJ0h88vCgODDCyGabHonC0PLUoZSN8MnzWYNzq2iljZ8Hnbh8/wRGa/Fz+f15nsabo9tUgTeYRHnTRdPX+mFJIQfdfo99Y5fhNl36b7a/actBa+mNqyJZjlLJRQrC5SiMsuI46YiE6alwLYzJO6zHLZvem71IZuG5ZHFVtd76o5KXo6Wr1CjarCcLwxcRrRZbd6TME2xKIPXaCCdS5giPjb25ZA4+NE4pzWHxnuI2kiZQqj1PaVHOpoHtaDm4CwJKI7+zFnoBFHEWuAoXdxcJcHGPWz8V/P/Q2H+VykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbohLSvn9lBuK7zW5B5RH+C2jcnnpo6WjzEQuR0o9+Q=;
 b=CNXIjA1yjV/VnWzPc83R4NvEsfqfPozvprgojxpF7D/3dhWSvmfrepH2dPZiaUplZSuqA3dRj9nZeyhgCVgiOk79bclTAcaFO8ESydyEObYTCzqHi1VoZevf9pIf2YqLh70fH9flWANulKuxwpXLO4OlMgw2Ekjf6p21mKd/lgWraenbTEnY3UEkSsgDlnnmHBuzihlCvvc2tsXTfdHOOYtLY4AU1/ZqWOediHF6ajCPWQ0FLXCoAPni7a3WYTHq73K1yICkNRMv1BUc8LKj/oN2kinPclheeJosJrojIHUyn6A8UxcYbIVjAhAS3ywHy7NxOcpcKrxV9vLvi7SOVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbohLSvn9lBuK7zW5B5RH+C2jcnnpo6WjzEQuR0o9+Q=;
 b=qCOmNPcJ22wW2/BJoub0CrjAhJ9pRCIQnZx2wv8h8UnW6Nrrlagy+OryQTJfYiR3iSSIhmMtIDb7OmcUPR5Hie5ix4zCjpFA7mPG1dV++XXscYcwyhrUBCR+dOvrFtFAYTvczKfcF7zcmt3HC+LT+p9dd1534PyBU8BjKr5u39qP5ZnCaPpYSGF8TftKmICTWtXFRad3vJQJ7Caw+Vny3w9dNJmQoS2PlmTHMJUC+h4OjRgxbLaiCmJbfpFcIADRz268IypGrHJULonWP+cCg1j8YOtFgXWptAIrOmYZJZYBt8Wd4UaCFUsTMhzTxuV83eymZhRJLI1GnWSHgflPsA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by IA0PR12MB8929.namprd12.prod.outlook.com (2603:10b6:208:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 13:18:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 13:18:32 +0000
Date: Tue, 9 Apr 2024 10:18:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
	davem@davemloft.net, Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240409131831.GW5383@nvidia.com>
References: <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <66142a4b402d5_2cb7208ec@john.notmuch>
 <ZhUgH9_beWrKbwwg@nanopsycho>
 <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
X-ClientProxiedBy: BLAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:335::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|IA0PR12MB8929:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IiGz11sbSyEe8u563G7ylMihuUXxQrzRM/uBFCoHGdRb9pd22pXYf3+wp2rbrYLLkSpHA8A5exaIODiiNEAjykgMzSUYnrjhUJli7LeZxva2trmSDke9jrqNoIFtGmImLvuaxiisCqu5gn+iG2K3M4g5EZ60h6IuhIrap83KFNOzet5ltBkDRmCzD/vLUwRDV5RaqYmyxFVRsieAvXToMjf50Cp45uHzjcR7smVo5mj8skRvjJRrXaVsIpb+AEqlQ6CE4ie2wUVs/DO1VL+YGVU3PhWE/7dAK8JLwZVttpVkXTR75X42D2G4uXntooFqzS1VQgvvP+4EXBdvJrfoZRMHsnqN77/9gHoQq4x+MthJRu3yIPqHcAFnKCV80bsEaiZMGBZ9cjx8r1B8cVq3tZvcHj6Whx52UItoNC7vnvt7y79OAtcbqUEvQReBJpr8OpfN429+K0v6Lx25ihjYcCnpslFEvGqm6kABWANQ60Dz2HbxeX5LU5rydd9v6O5K15lShYvwBmTaxNJ9vMnIm4g3T9Q7W3LOuqAfGfBSVLEOwTHZPem+zzbvY06MZRytA4v/8xP6rV/yOuGZ1T6bePB65IPLVAwWbgSYKLzWS6cTthm3iIFOaDDIIQ5259hkFnVX2fVg5XMcA5O7iczqKKCq50vYyStgkH3ofkWOMo0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rophxc16n0USUkvL4oRmI709vk6KsD3fV707nyISYQge/HscZ3TFPptR1t6u?=
 =?us-ascii?Q?RjA0W8Vr4gIwaeBJ8CGHGfN+JhOcipPuGZLzu/YiyiqGdN5HHpVsorIZ5Vdw?=
 =?us-ascii?Q?2QQL/ZlNXU5MXVfExpPqkXJdzyCezzxESJCCOFeZ89MgLcyKUxkbS4G3rBhe?=
 =?us-ascii?Q?1qCG57as+Td5+SQzbjsRb89KnRzcxyehS/tYferDz/PVTsjgUUx5PZUqV7QI?=
 =?us-ascii?Q?hfwzd6+3dke5yFMw1eKiOcJudrBdehjF07EERoDDWuUG93ZKtTF8oJYPNWFz?=
 =?us-ascii?Q?uUKieacvzZoIRu/ssvLTPJ+YfF7661qLBvA1F3W43oVPbQIs/uUGc7yJpJ+B?=
 =?us-ascii?Q?alou5rYtId6H4IYLOedxSCZfUlopM3NsdhVjcEJ/pktg4EWtVOMPfIUBQ73+?=
 =?us-ascii?Q?TXpiL+G4eXk1QI+riGFG6Rfca+6+Gfd0D+SvURXR60s8wGI5cXqkng2uD9GH?=
 =?us-ascii?Q?RKj/nrxOpwkPRhUXKMEIPEpsKym/bFGtJ9wevyQvhWqkXliasIGrppRo61z1?=
 =?us-ascii?Q?L/3S2eydIGdHvV0dsq/u39oGLM2cTnhhfGvJ/B+RvZraoZW7jmIZmgxNACNp?=
 =?us-ascii?Q?Asnr28aGCksn4yjlR6xrUYjO2vLcibjIKG2K/Ky1d4JS9BXjxz1oy5XPAtyk?=
 =?us-ascii?Q?tIdWoiZ/v6LM3rx6bgJcNg0sERm6d01T58tbRpC3the1HfTSwLZX/P1gXBV/?=
 =?us-ascii?Q?Ig5UABDshzePM/kY2pyfpJPWJC5WSarxUlaBtuAMaOZI6ddI92X44TDQ6Wxt?=
 =?us-ascii?Q?fiEXiKgP7rtxpPUUb+HzvYuP3GZAlkWQgbim52jydXxSt1Jg+V+LWkctvDGs?=
 =?us-ascii?Q?bcfvrya6gRQqoccEPDLGI2+y4Wh+lAqocLThXRwUiDtJUIcj+TTrrN5gAQod?=
 =?us-ascii?Q?5sYuaqcU3lmsC5LMLF7R+TQqPPLlEuWQaCw5tjiXahab/bEwK2zyRGXDpDG6?=
 =?us-ascii?Q?vyLsmBONJV6KiD8eenu8oBMDESNaY35DvrApMldF536kmiRdjfY4Mfp0c/jt?=
 =?us-ascii?Q?MTRngsLo8G81PIHSuUUQxbLY+FGE0xqgEg6+RjF8A3KjfmXcGquHN0uvKstg?=
 =?us-ascii?Q?vunZl9bwSfjay7JCx2okWLniFNJ456s1ILezuES9+bzn7HsQHXmLqt8dgPS7?=
 =?us-ascii?Q?ZLJCpYW7hq5YoPxhuv0FOEEC62yIqRjJGUh6iMMeqc39kQRmirOcISUdhv7c?=
 =?us-ascii?Q?wtN2qpy1/FXmMHZj2WDBq39RHY5tuca3TTYDCvrxhvf7LFrnFY9CQ7MfmYIX?=
 =?us-ascii?Q?9JNepg41ewuznmMtl6uIH84VQKtOgUn6uUeZfgzNNrLbfC2N5oPm/n/V6LhH?=
 =?us-ascii?Q?lT6QkHhgnvanBmza5CJSL1CsfGn6FNJ12WAuFx3MsGEpTynn4k42rww2gE1b?=
 =?us-ascii?Q?7JFGzzYv7mDEJczbyR/f7t6g2Q3PfugFGRPB/xWde7CRwqmDM0fM5XWCEfcf?=
 =?us-ascii?Q?EE8jt6AqN9yqHImBv+i9aGNeyZh1buAye95JmaN4AEF80roR8E83w5947fgk?=
 =?us-ascii?Q?bOVLzdVIial/fMtr3gcIlOAx3wUiGFI22JLrAmESCOL7xGfUKL6SFc62kkx6?=
 =?us-ascii?Q?SF0zfMgTC5QPEXDjvpVpx04yX8Zf2OZOeoqD+NM9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd994ff-e455-45f6-d614-08dc58978da0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 13:18:32.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Oc2WSY0mX7qPSrP8upjnleF5mqdqFNUHwKZsIwkNspkcq/2vt+BkN3CxZKCdkJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8929

On Tue, Apr 09, 2024 at 03:11:21PM +0200, Alexander Lobakin wrote:

> BTW idpf is also not something you can go and buy in a store, but it's
> here in the kernel. Anyway, see below.

That is really disappointing to hear :(

Jason

