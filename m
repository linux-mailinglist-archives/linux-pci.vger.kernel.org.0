Return-Path: <linux-pci+bounces-42742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FAFCAB705
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A9B73004401
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439121D3F8;
	Sun,  7 Dec 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qg7P5iXl"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E11155326;
	Sun,  7 Dec 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123129; cv=fail; b=XD20HsHRwuP9CyGZSd6VOFogdtJDpAeATPVeamHQdYZ0WcssY+/V0/DucfRcHfPb80d1u/uOpAOPNVay/tRPis3KSQc3XF251+H/HeJotPEeJ0ffxQn929XTMBI01U9JXWIYrtAJOyul753Pyf2L81mCuothrlrdmQYzP2wTJBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123129; c=relaxed/simple;
	bh=B88bejsyEUjK0Peh5mEQt3xpy3CcH6CobAasuTWis54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZr/ZBYI/AP1e1/ECqG4s1JVqOKkuiEwVx8LfbzVwqhOeZgxlpnJhio6Ly5X74a7kP0OrN7/WrIy7Xxa19Qv7pqXTlPPNTK16PAQj1aonF0SOCjmLdAK9HYXfFO9ASEI1amLrWmPyklR8HJ8JeNu+A/+ag5fS9xl2DDWVCPhfIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qg7P5iXl; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PydKbOd7/dI0aaPw2w/KpQ/SeQZuf2aeXj5uf6ATmBGZWhQNdsKHXCIHXfMVLjmavc0jkVGjJ5FvL2IV2UJ8Bb8wpQXhv78KFcQqY1Sfa4dDqVtC12T047d3VBiIMff/QVHuDH7Yyuq9t3x/mykPGc+UwYQx08mc1HWGMERDv6tOcnnnl4VJWvqpahr8ETta2xcdD4nnN9I9w2EUm7ibELlSVzVxkvjQcgN9cJ9+AB2Vxhj4KvovopYOkbBEWgPId0celQ1NZx9o/82y52+jFifjvbAknclDZhCU4Qbjagz+yozzf3oO1283ipKxv0rx8BgplnMcHAwU7Od4CaLkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjjFWWCsOeeRD/3hnMnpXXx+gqG1XaGoe/Uys4ksCa4=;
 b=SxdeiixhWAfLNJPnEfimEZGBtTxcwtGUqtN3whXWNsFTvyOK0FGhi+1Pi90r2np3Rvyp2sSX4F5F/hkvAEaJrJkHkZcVoPPl6Qrp7QlMmxHv1fPRgraoaIX2KwuYrEBOj1W6BVBxvTJsz0QT7paRdycEhsd9z9v7kvp807oQSxEFSbGv+xhIgR1WoVFYHj9awAfH/6IaTsTG9V9by2xxsC5AClyydR7/g6/svTCUZkOMs5Pw1h1zuHXj160I6b2Wb19rzSebSYCPfiBh1iP8Gp0C3+7JaZFlcRphuP3leYif7fKtq1y9zK7nZqAm2CN6h0MG628YbFQhPLK73g2TCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjjFWWCsOeeRD/3hnMnpXXx+gqG1XaGoe/Uys4ksCa4=;
 b=qg7P5iXlt+9+mwRJKyiiUPT9OPXW8xao9m6kR8RSPZ/ioVj7m2mh2TkD6YUXIEE+wkbg2ZslD8ocW2EXIeUb2m6JgYAVxnDF71N1IVeGl/my+iEwE870NFhLApUvtFsOTiDYy65imQnYvZnb7SmUT0TqcO1BhbXmwRV9B2z5fb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d) by CY5PR12MB6407.namprd12.prod.outlook.com
 (2603:10b6:930:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 15:58:44 +0000
Received: from SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 ([fe80::6e97:ed1f:9700:af96]) by SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 ([fe80::6e97:ed1f:9700:af96%2]) with mapi id 15.20.9366.012; Sun, 7 Dec 2025
 15:58:44 +0000
Date: Sun, 7 Dec 2025 16:58:27 +0100
From: Joerg Roedel <joerg.roedel@amd.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dan.j.williams@intel.com, Alexey Kardashevskiy <aik@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [GIT PULL] PCIe Link Encryption and Device Authentication
Message-ID: <aTWkIxmD6Dkk0WFC@amd.com>
References: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
 <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To SJ5PPF1C7838BF6.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98d)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF1C7838BF6:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dde2d57-83e4-439e-d90f-08de35a97fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZcPYlNoywa8c+jButvudHCid2Wxm0Cmq592mQciZMirlQzhBQdgoMcUirEe?=
 =?us-ascii?Q?6H+LTlZCRFLuytq/yWZ919nhS0BiTmKPi0nkb2ISoFRe2G+eHpKEOi5ell4+?=
 =?us-ascii?Q?DEieB1qhEv/np4SA3nZH/tASzxtHZVOY1W0kyFTcpo4M7+H/fRN88WEZZyv5?=
 =?us-ascii?Q?UkDk9Z/acY2J3y3d+GZ9S0eely6PXupKHOPs68vqled/aLhUK3tXEmBDa7mQ?=
 =?us-ascii?Q?TCXbsjt7GYENhgpLs8ZHkrKYnlfeBFROvOAiSK7Jm/Je/SVXn/HpZVNg7DxC?=
 =?us-ascii?Q?8+ApMneGWCAyKq2eiR94KW+SFShhQVAgRLjK2screO5WRplbp6tm7KnEOz+h?=
 =?us-ascii?Q?Fmkc17FgsPnQpIVQAd4Yw9WqU8Ipf8Dn2R79BWuYsksn8CSO+XIr2/1bRA2y?=
 =?us-ascii?Q?7MOL+st5iJq9q1yC2QbV8yzlawvpt5dSWN8xjJ8vVgD6mfnmINCb2mHhCI4J?=
 =?us-ascii?Q?ivoGPIgK0G5caMBYPsiPV8J2jhMgvTBi0qMe96qwEuas3dGUebM4cPzb25s9?=
 =?us-ascii?Q?sp0q6RQLdOJ4A3whFL4X2YECS/WWUY4CibP1MnpB45UzrNVJUDCkwPAHc6uh?=
 =?us-ascii?Q?BhGI+qMckHv0HAnnglUMNDqSeXB0o4lkuWu00BkNzY7SUs166GXjI1oJt8aS?=
 =?us-ascii?Q?KhGD2e2nOEVrX32yocVVU3PaVseF73OyPHbU+bRwqu5R/e12+nDuDAbQ+ZZJ?=
 =?us-ascii?Q?n36uN05/HUDbJl+mfjbydojXOe25KjEHX16Dr5/v7txEQ2WTFfjU+O2iAP1f?=
 =?us-ascii?Q?oEg+za76OauOVQ2xh4hcMLOWphFkmaq/mM7r6oTRl/TRWPsaicQx7qsSu3dT?=
 =?us-ascii?Q?HQIXMY+6i1F2h3WEuD2y13N3KMwfI/+VIetRyeh6YhxcU3N9s3VjcmzBtOp6?=
 =?us-ascii?Q?qHrsGNW1mdLlFMVDnlhTr66ofmwDyCXdduvQHhskMYzTHeFD1DxEgVAzX+6k?=
 =?us-ascii?Q?YdR5eI+AjOULLUGoexaUnIdbMqa45tWpVIIsGAOEJ2fap45UmnEKSXaf0ueq?=
 =?us-ascii?Q?9eRzHEfOJAVXLVgXEbfNSLshlRumD/oPsLcV3JWPGfiAxkuS+4Y0u/LL3kgD?=
 =?us-ascii?Q?nJGaqTCuzJMgM7Fh6bH7dG1oopRlcSjQzpHLiIexM6oAvikpluohGnFci0gP?=
 =?us-ascii?Q?r/uHWkqPrmlMT5jx/mEBG7ahEZJzXnyaXApCwEHozxrpzAsFKG6C5bIi1/p4?=
 =?us-ascii?Q?K/20681D0P1JwiEBHytzsEWsfOMuT25PDIsgE8jvClOCfLuhV53uwe300iar?=
 =?us-ascii?Q?ltxVZ+3Q/6Goy8bOx683XVLAL3Ci7HMNP2f/gs/IHNOq7CZujBQCwDu8TY+n?=
 =?us-ascii?Q?cSVnkyBzp208BCZWsovKl+aC39PdwQzeFPCxEDqvMnhU2mUCBUiI0OXrTam8?=
 =?us-ascii?Q?k/5igNUNqYMyARzDADVx4+EI3MlTcdjm5Kp5LzB2lfQilfFFaAOdyZTqnadl?=
 =?us-ascii?Q?G13KCqif04u4hYsVafFJn0Sj18TQTdNO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF1C7838BF6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lTgUsm1dZajgwneHfgQkgPEqjZLnvQBFyShzhlKWH3EYR1ikxlnDyGfH1umM?=
 =?us-ascii?Q?eVOl9PsQSY++J+kXtTp7u+uHlBDe2U6+IbNEdlCYCrZolFG49mESW/YpGL2Z?=
 =?us-ascii?Q?57iQLkfJJc/LypQuchw9Jm8z8qWFgGxBmShnfDFsSeODVMCDpImzoClVNbUP?=
 =?us-ascii?Q?lwIbvBdgOYPXRI+1ZvBnr6Hhr7iFYZujCkPvP0oddH8ZbKKf9l9XmzvigyIH?=
 =?us-ascii?Q?q/SfmXNhghP49odH1mTAoq6c0vkRE+XW2pM7XQiNL/dn2kseznCu3kath4WO?=
 =?us-ascii?Q?1P+ZhGU5yIY80VFg7J528RpLw/bQ/xEYCcqTDqtTEsRt/JtEcSaT0hWLw25N?=
 =?us-ascii?Q?ct04nucaBEu2xri5M3MVFvnq5egkND4rZxGPDx56TGH/25LEhwySBbSAltkJ?=
 =?us-ascii?Q?25RYwO+Y0hdhiyT+wVsB7vjxiuvyQL45X7HbjMQjC77T3H1rzeHQ/VYNE91h?=
 =?us-ascii?Q?WQ8Gplqwl2jAi0t79ZgosMu2tvSrfKYfNf6lc046d7c3V/Pos2yAHCIaEPa5?=
 =?us-ascii?Q?EZ3g/vrvQX6kdISovJj8sOSiLprOh4D5sBCC0a0rOH+xRDXFd5MVD4+3jJNp?=
 =?us-ascii?Q?ERS9NM8++qPjqymHtMzRYvJ9F6L6Bdhxtvjf0GFNX37uScP4XbBPANqbnysE?=
 =?us-ascii?Q?eOg7SU4Ixp/GFU+CPDe5tT7YiyRerrHImWLnCF+lz8qxioAMlrt9X04gsiJU?=
 =?us-ascii?Q?yrBFVN5SiFvgoBGot5bBoKXv9sb5mcvCCdcy6vfFRk6mBBvAVFPSd55i2mLp?=
 =?us-ascii?Q?qOnfN594TFpUEcChztAfV+OewmKU1O1dFUg7tUXGcuCWFg1LTtsXOiZIn84F?=
 =?us-ascii?Q?LG+20pqYhqB4K0TnDXFHpa1aBiT+UWmnuELv4pJUi9ndIuuO1pYnb0zMoDrq?=
 =?us-ascii?Q?l6tNDy59lb3ifaqP4sNJNJLUYfNbyWPaVdzcD/VsW7Rw9/LJWDOnQ6WoixQ+?=
 =?us-ascii?Q?dIgbD83c+GYpBh7NZhbzI85nes8Bwqex2IBfUaIUtEOjy5dVa6EGwgXp5AwZ?=
 =?us-ascii?Q?DkPVPXbS0Ui+TKK0wHoOi5WiTlHi5zNevJXpI8pgzxaFzncx8knKgVJZMJD6?=
 =?us-ascii?Q?Qy7oGOn/hYqpItelzhL4MDUB2Do6GQi8i/11kT9nwYSjv+Qmbkkp1IlhUtf8?=
 =?us-ascii?Q?0UFZWvHwXo+cbD5H3VTCHJyEUTAAw0BdsJ4uCuMZKlWnnjhCKlnj+NZ6TlMw?=
 =?us-ascii?Q?AuOlClHORCr8y6mmphY5bkFzilNV1Ejie9icNQczDGyTcV/0ynRiB8ZUG6R8?=
 =?us-ascii?Q?Gd4H/k7SSuRiOxnpjvbTjAQ02dm/whAyJg0gsKTDYqLxfEBFJ5/5HL4qol12?=
 =?us-ascii?Q?ANKKMPL4lDzTBaasPPqCuk+5GO0ow3Hgeaj8EB5ze58WFciHrCX3QNGiWqbF?=
 =?us-ascii?Q?9tFkBA7D91xrjrkQjnCQZFbfa4CQILKhWoZznVrvIVPS2oh+njaCpGX7N23y?=
 =?us-ascii?Q?fDw77lCLq4OYHx/OohakUroPqEnwxPq5FRxU60G1Q+5zeTqrFRfJuEYqQECZ?=
 =?us-ascii?Q?BzySTx6coM067JwW5CIzVIyU7VVS4ywEwj7mMB0zufI8NIQOBzHyCkUN7f3V?=
 =?us-ascii?Q?4MVcCCY6xpZQkwjvKFAbmRYhu/71IUS8c5u0weKP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dde2d57-83e4-439e-d90f-08de35a97fc9
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF1C7838BF6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 15:58:44.4031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLk0s/LNozNKZCYQotO+h+aAsU52hX5eFyNgNUfSWcFdNdkREEa9ljkPrGbYERH6NewzWO5jyFhsCYuYnoCRhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

Hi Linus,

On Sat, Dec 06, 2025 at 11:21:15AM -0800, Linus Torvalds wrote:
> I've pushed out a minimal fix that seems to work for me.
> 
> Please check - and be more careful. This is _not_ some kind of odd config.

The patch looks good, thanks for fixing this.

Regards,

	Joerg

