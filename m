Return-Path: <linux-pci+bounces-28966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A67ACDD9E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FA73A5E96
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0F28ECDD;
	Wed,  4 Jun 2025 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q9OFZl4e"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C128EA4C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749039308; cv=fail; b=Xeudv+pXo8AcnPBGtb8PlXsHtr52zvbGoJ6vjQVii6GYxxDO0KXcBnCC8aGqCiwlLaOGeoD68Fp7nAXyDSt3j/MvaeLy2CuhWD8G2kQkyf+5KqIfI4iw/SVYZbJZDpke/2qBsVHEeso3oWjCvoxXESqRqOdxdy1NBy+35wvJFPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749039308; c=relaxed/simple;
	bh=/mFEk5Sfc0+FAY0naHtwNGBCRtfyQgC5OKwWwtvD4bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CA6WzFkT4Nlwu+yjcPY4Co5DYSXn/k0jhU8HHC0TlPU/kXLhDzBn9kJ1EXtBXWt5B8XvDYjkAK1gnHxZE3kZQFLtDiir/K1XZ404WbRDY8Gnz28dBLXEONM+tT9vkRC81dF4caCggciDSS1tpxh3CqaDZTVOHky9Hy5Q0x2QYBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q9OFZl4e; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHu55ye5D2L34aZ6HDZK1EgIhgm1drrvZI8lFD9naF2j78oh0CH7xUB2Uj2Z+zLvXLkPLdKXGc4YKRc04spYwBY1w/wyvMtollsLznIsrSvcFxhT1iv/eo1LGwf2umcrlWdrR3EiAbzzXCKB9McnWoRsfaIUhB8gwjne8ri9hQmt/7byJ1q+uZJ+0EDzKZJH9fk94r/ftlZq1d39Lh/vVnJnnP+O4u40rYzWJ1fsSN+X7/b8Pg5c0Pyd39jvpflvbaKGfbCymoc0GawhuVxiJA3nDpMU4gDRNpit9sBX1Lpfdv+CJbgJsVHRM3yz0S25+HSKQwzxhyRrqBzkvi8iVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mFEk5Sfc0+FAY0naHtwNGBCRtfyQgC5OKwWwtvD4bE=;
 b=I16UY72mzweC+nWiigHVMpxlJi55UA7jWTjmyLNBNS7IFBIRIgIBTXugZQjay8zoFjdhEU3OlNvoVkOQZG+p7lNULmlE438TMo2a0yyyku0iUiJSQLmwx7K+bdrcM2QQlNYr0IHp7ijQX0owsnnSmFF+8lMcrjjMRYOvFHxni0E8Ok4GLYEPZ43TV3blc0vFumv1pEvXD1APE7PPa5yfmupBG8Brcyy0DqFTwQPrd4dQdSVndasbL2GQNehhi8R5Hv3sCeoBg5fCpdbuF646V6yodIrRtlFrUV7NO8xYcNzZNFN+ejGdRv7mnF0i/iGbK0UQbwwOj7Fnx6yILyrz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mFEk5Sfc0+FAY0naHtwNGBCRtfyQgC5OKwWwtvD4bE=;
 b=Q9OFZl4eWfbVe8jBLMwDJNJft3QBlV7JmL1f1wDxow0thiGSGv3ZrB4WMuVlVBu+1iOhMZ1mXJ6nK57JzkqBOy2sHZ13bVcNFWL/O3hUOMOhN4HY3a0Rt0YrqeUo50FFnhzeq/pbeRbRPVS3csDRuPW3WDLKDwmNj+mtfB872IuQntLAXLptmMDw+YMULZPe1rzXRSNPFdaKhx/lxJ7N21WdHOIA4jScbIRWnwilJk1q7Q6dQJ19Bu0wZVLnCIbi52YMCAr9Lo1SrDrYDISJ/VY5exQQ5zB/38oyqkcIJ5l4bSLgfqatUtJ72bEdYTIlk29JbOVdY658uuWsO9iA9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 4 Jun
 2025 12:15:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 12:15:03 +0000
Date: Wed, 4 Jun 2025 09:15:02 -0300
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
Message-ID: <20250604121502.GC5028@nvidia.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-2-dan.j.williams@intel.com>
 <20250602131847.GB233377@nvidia.com>
 <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
 <683f9e141f1b1_1626e1009@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683f9e141f1b1_1626e1009@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: YT4PR01CA0285.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b112c4-b0c8-47f9-5f87-08dda3616f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWSvHWzw4pE60x3DBcnTQLUXJK6TnuhV80vkQftFeFhP5i2zG7RMIBsFjfs+?=
 =?us-ascii?Q?dZUaD3jw/8+BmJIUdzdNqwz+9Dv4cwdGwnW5e8YB3y54hLI1s8YAZ4oIOWf0?=
 =?us-ascii?Q?ju8O3NknyUuBbLgzX7Ez63wAXavb2NeABd40j3f+Iueexc356l7Y47gR1n+p?=
 =?us-ascii?Q?lPPua3+vSa1gcJS1iigQH9PEPyVMTS7Y5aOEHlFMdWG3PZew1nYmQWEPqbg6?=
 =?us-ascii?Q?vqDvGDy3A6T2NM/eg+JkHIuC18Sp17raAO0ap3d45n4ib4bS1uet/Y/W1I2V?=
 =?us-ascii?Q?yoUhaBnO7JuWWuRK07hOh0VtVgl9czhG2FWKw/YcjRmM+Oz1aXjS5K5gQKKS?=
 =?us-ascii?Q?neKrFzyzcV/vLFVbrlpGViGkKUglzjFSVCMY20ClJqNvAT/xnyZ2YZy3BUJZ?=
 =?us-ascii?Q?cRoYgSNWS6GTgAmIAZYPd60UrLIis58utgz0OlHuNjMlh5mwzIdZ7ksVHfZZ?=
 =?us-ascii?Q?gZPywWyv6Yt5Mpa0y+FoswRN/76YMlFK35GM4358Ae/g7bGLF0C2dYENF/85?=
 =?us-ascii?Q?kR4GK+B1do+gGPcvbOuiHvkqIVHWSqwthyG8wMp8ePHrdah5ex9mH/0UZgYK?=
 =?us-ascii?Q?gpHlY6BZPPUSEn+GacYBT7m6h/+Ukf5kYI+x+KVGhvr3KSG0bFN7BLEsncuk?=
 =?us-ascii?Q?QYc1yCnaU1AkMVooGh8GZNdi90sChbX1L5Np9Q1X0tJ3bIVpeYd/NoUCn+tl?=
 =?us-ascii?Q?LcKY5cmN6gbhHCfu1HX312HxOhw1rKxHihgKnQWY9jiUhq9kgh7zU1XBKThb?=
 =?us-ascii?Q?e32Sl4zNlEnuR3any7Sz0rle3ylCmDDB3qBbytAIL+ulfN5Eh/5PgTz8mBEb?=
 =?us-ascii?Q?nlCtst1ILngyLQaaCcCDv43Ht7ey28Q3qBCYEYuHGoC0XinB9x/etA4m/4Jh?=
 =?us-ascii?Q?t4Y+ZBCkldf5rkpmEeILOAHb/O2xdhOtwLz1NhfFjUBvGp6HcI02jAI4YvkK?=
 =?us-ascii?Q?8E8v+DJfugUZoPHKkndm+YSnO1ROMarXhfZiaaMKQjoX516Xd6ira7UaTNrk?=
 =?us-ascii?Q?C+3cuRSrWAufQvNVWC5Cio/br8HoDBHwWrbgb9O0sCxH2CDSApxF2MzME8QI?=
 =?us-ascii?Q?bt8nEsMOo/MRUjt8TWNA9o5oq6ga9RRTxEjmDtjKAjr3VwC2aKfJw8kTv54v?=
 =?us-ascii?Q?Nh0BuN1kGk4Y4rdtiARtQPLOP3+I7H497A0KAd54ghOrfThK9lCAIa1UBIA+?=
 =?us-ascii?Q?66e5cSUbQ+YdyQN9pqsrrjZKMqM5svyT/490/ivuEpR8MvC4TEXeHue8+z1H?=
 =?us-ascii?Q?Cj3yVNAtHO5bhSDY8MAJmJ521klns2MPk3/xDoMo7BX7IFN5DL95zCBfPEnq?=
 =?us-ascii?Q?uJ3Sq62xeG8vLyo2gOHaWH2D1kAxmD0t91kd7NoNJmBOVz1lvcos7ZewMzz0?=
 =?us-ascii?Q?fHOKL7+Q+hkAOdw2NhXWMBmWchtGprL5f7zfKq8YzP+Pd9ElEdjLd9c+HZgy?=
 =?us-ascii?Q?vPWQiqnHQo8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S/ihTH8SQsq8r0MQyLz9iSRGHNsTYZAv/woBe6PjxTijBPMXpM9QsrLbxAwR?=
 =?us-ascii?Q?FralzAajgyoBE1sUiAA2xm/lbgM/XPolH9yPSnmBz5HIvV/7UnZYQ0KccxFO?=
 =?us-ascii?Q?hVoe83hy7Vww7T51yRIRk/iyNQWVmAbbJm3EiYUMA+UWUbn0CrabxoGItdAm?=
 =?us-ascii?Q?O3G8z+7MR4t44uW80LVAhJcn4XHuD5MTADkDJ9s5wl4lKurMjDuazG26Xujt?=
 =?us-ascii?Q?ZffJONAl37gpS13JVwPhyy4FZNoZghHnV6C0Bti9z5KtUwcNio5S4VECLlfq?=
 =?us-ascii?Q?wFzvOPI48uQ9PdXAvcEXidL+XX8VV9pVo2FVSSL7ZqhGMf1BEG+diGdUnEhj?=
 =?us-ascii?Q?SEnm8LD4gugxUbyjpBSWLnbkij6srs+Iu5mxVR7quwULYjfm5ow9iS9c5iDs?=
 =?us-ascii?Q?WHup3nmJiGs3Ny3GtzyiWEqfl/J5D8cD4yAwkJApqC1v0EkKy4RDcXgtQT2w?=
 =?us-ascii?Q?Xc5x4dl1/XsD81ZOW/SHtHgfoi464Vl2BP4PZQxvbBrB3cVUWrbLjhxY8ozl?=
 =?us-ascii?Q?HHjtogp4BtsDimFsWYibcu4+iNV0yVbFpJIw/LCStss1dw6CKbyxtocAgl4F?=
 =?us-ascii?Q?GhOyVGc9C7E8hm7yLKvCkAFsn0wyDiOPjeg11sSIZZQkSlR47EpQhyER69m6?=
 =?us-ascii?Q?GiUHVJuMtTWOpoIYeuPa84RIBlIOMPjhjbbQGzjh/GoA7xWWdzRTBhfeQ1yw?=
 =?us-ascii?Q?0j9Pt2gJEh0h+jXbdvQnVXNMPdQY+NZnmtywURzo9XvyuD2LOLQzELqGk/km?=
 =?us-ascii?Q?imOrr24OKUyD2uD/DJ3uiG3MDnYHhOifLUswabTO6rd+ZZJoP/WUtodwVOOY?=
 =?us-ascii?Q?BZwcJa4/PQcZX3M25HXzrynd9809GGdVxlc/VMY6My23dPTIwPkUGkUM7Duj?=
 =?us-ascii?Q?xnteU17cgEReo5apgoKK2fNF+s0ReUf9q32mWkXMvHhdaJ1uFfFZW0wwTk8w?=
 =?us-ascii?Q?tRvJptGZOFJsNOI9KxgZeOHIDQ4Lsd01aQkiAtlLY8dkTW7Ri+eSEbyvkulY?=
 =?us-ascii?Q?38QLyRCEWtjzdEobpDu0hNOCgZRlt71J44eyo59LbFeJRYLdABPzsYlD7lvO?=
 =?us-ascii?Q?9FPmHp26LtbBeV4IJVMhVmDnRlQTVoRwRzFjAdkREXDRzjMUphmUIf8l2p5M?=
 =?us-ascii?Q?ynrYBwX0kg2olXCRZAU70AETIiJKaUScGt/mKWGkCpFyOVGA535XPa/Av5Dx?=
 =?us-ascii?Q?oBa8PEzMueY18KnYcR5Tr3mYYmH0yAB3wYQy0KD6gqQ5EmXVM8SZx0HKQxCI?=
 =?us-ascii?Q?1ckTPZR+ElJB306K6QKKChBATHmMMBjLjeh6pvu0WU1pi7jcBduqfrqejAuG?=
 =?us-ascii?Q?KYycq2YCxSSGl9Wq7pKtAlbDnfBziCcu1tyiXZDyWmZDogUBrkuAD1jWcm4A?=
 =?us-ascii?Q?i1VcmvJRXJLPxCtW9OdMS7xVcg3mwwD4ia1a6ECnYrwZh6xan/kyvIcIwXOK?=
 =?us-ascii?Q?BnilaBDiQiD0wW3g5Vbj84xfioJvj6+8MqMG9DREFIJvho+Q5BiVdHOk1Gk9?=
 =?us-ascii?Q?sGEkClISTX0aYO1h+8Z5IE7pmeSyMxDOtIaAJFldKhpALJzGOsHCVOXbZCuN?=
 =?us-ascii?Q?wpp2S/oO4KkwPeiKUTc4AvsBu/yzkIpq/bxrn2mt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b112c4-b0c8-47f9-5f87-08dda3616f2b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:15:03.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ljmn9yxxPHwlDDtKONRoEFDqAVRR5t4QgsGINrdeGJBM1InO5bpCZ8y/jL/GV/CE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF

On Tue, Jun 03, 2025 at 06:15:00PM -0700, Dan Williams wrote:

> So userspace could lookup /sys/class/tsm/*/$attribute and as long that
> is a single result, great. If that ever returns more than one instance
> then we will have entered some advanced future where there are multiple
> TSMs per platform.

Yes, exactly

Jason

