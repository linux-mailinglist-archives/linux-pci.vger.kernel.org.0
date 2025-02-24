Return-Path: <linux-pci+bounces-22263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314EA42DAD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 21:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F547A75CD
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47766244E8C;
	Mon, 24 Feb 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PM7X7bfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A136924292A
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 20:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428701; cv=fail; b=Rzrv1hwHP6Qr6/OCelv1+D5M+c2oJ2EiWpABU3GjWiBK/rsaKxbt/fCVbQFrl4Aa1X/yXBp45YhXHLA3KbJ5iW7h3qL+RAI2Xz6yFQkpyvdzXJs2sYW0OjPRCVG6CxnYqzID+EnvOLsFA/h9x1NxAENzT4OeSZ7cU09KH12UHDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428701; c=relaxed/simple;
	bh=OySUknxfoEAvNv4hfhORzLyyKvlUAR94ORcnLgdP+hc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pZRJjUB75U60m1EPArPCH30L/5MwovJgPJ0D91EdR/Q4eljmo/X4thzTpVR+5wjhgjdVHKy3eO9gEEevBvsclfU5aHHV6oFlyEzgwiKHZvqToysNofsIsfOM0h5XVpymacNuwuyIrikNVjRQjEkAXIJkh6goFIuQLycXGQxIm1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PM7X7bfq; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740428699; x=1771964699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OySUknxfoEAvNv4hfhORzLyyKvlUAR94ORcnLgdP+hc=;
  b=PM7X7bfqJ7ze4iw6azxVM9fij/iOo3N/i/YSrYe+szv6LyU4fGExNpo5
   GQ71fCTK4G5xUIVHlrZmQPM6SKKxk0uh+T722S8Ts4XMb0IwhbBBiJlzp
   20gtxh4dGNxgVXxRQKAuH78m8syKinLzN1gCDCvALGL7SP0AEKQqp3M7n
   /1/Cvp3HWsRjLQNKECfE+ZZxLwgkhnCFaV/Te4dI394/JT1tB2jhr6BIr
   Xi8imsQBDZ5rm7KkdXdWTUOfn+jXBQyMkGsGmndo14zLx2mosS1BEfTSh
   I8t6W0uqLUAmj0tgpMwH185uGbA/ToIafPGeceb9zU/R1/C+FxxaBYIvM
   w==;
X-CSE-ConnectionGUID: 0qUNKFGfQmaZWiObu2RHyQ==
X-CSE-MsgGUID: Cz7Yr845RlmK1gDZGdQrfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="51840473"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="51840473"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 12:24:58 -0800
X-CSE-ConnectionGUID: yAwLg8doQEOHQHxLXGiSxg==
X-CSE-MsgGUID: t+cEMRr4QfmVZqiMvqI78Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="147000904"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 12:24:57 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Feb 2025 12:24:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 24 Feb 2025 12:24:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 24 Feb 2025 12:24:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoXYB6LJ1ZuR/6VnmrLwhb/nZRS49Al256IO676TpCxZDfhWfoAGMJfBFcwjnyfGAx0SSJ6fb0BTiOQmQFPosy/9AdfTbBOksVxt5/SIpUHGYhgmWLHSRSWcznvkB9POAonEmj8u1alnRv2ibN5V303ovgkbadZtq9FY6B4fsBhISgm9O0ug2vS3VlmPgh77p8pbpXqfzAQPEkS+eg6FGmof3bxODBzIKCiQvLyO44APLuEhxh1q6ZeI2XwcJA8MgHSNy8FztuSLBzRsepRxppWfAxSeeJk4usOhSsfnc2sqOYlWFziMqvHV9iJiYVKj9sqJjzpn7+rs50O9ZuMjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpX4guqMAFyR5vGAegGtegVsZhwNZ4yyV7xuXCJlX7Y=;
 b=vBs7Ob8vz5rjrD6O/BjKi+J4cf6kzP+jM6QNBahsx9Xx/iTybJwcGsA3DTOeq95TTyaa126OODmZaS4f4yZf47Z30H7h6vqjjoaxKbdHSOctMo43oXIvasQyXFGJxfDYT9gksUI5O1JNSaoxez/fcqVgAotM0vvP6auDzilGk0SbeQ0RiGvndlu/JrlNJiaHpEaiqGivg1zsSxnhQ2BK9j6ibKaQTLxiytfdDAiZ7O9k7R6829PCjHzf0Gv6MzE4qNHExQ/2I62Al212LUSpLDmCCwa6j+aAnYNFwxuSSoePj6hvNb107gDGFHEqD+HnoH70xb9Zvzc6ZrxyC4mgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 20:24:22 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 20:24:22 +0000
Date: Mon, 24 Feb 2025 12:24:20 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>
CC: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/11] PCI/IDE: Add IDE establishment helpers
Message-ID: <67bcd5743382a_1c530f29417@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744264.1074769.10935494914881159519.stgit@dwillia2-xfh.jf.intel.com>
 <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9f151a74-cc5c-4a7c-8304-1714159e4b2c@amd.com>
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 05765891-57fe-42b0-5f09-08dd5511397c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YScsRqNAIHvMHcQHu0orlADd322/0wCJb16okkEHq/TAoZVU5oXYGF+zYTTI?=
 =?us-ascii?Q?Xb+1op1nT15JBBr7PG2RsGkE6Ossk2qPQSWEfeVudctyREhjjQPAwh5fVpg4?=
 =?us-ascii?Q?7T+v/pXgYtCeTKB4wgJh2Ks8iSEOQ1gQf8PNJON3eCmKutX9QQZbBTyackJ5?=
 =?us-ascii?Q?YN1nxjNVUea56NZFwxAhDvLtTkAC7HK9LpnBWefst8UfRgaVs6JgI+IpOMUY?=
 =?us-ascii?Q?A80Bw6faPnxKXgu3OBefQkRCtwiaEdtrRiyPYoZXdtjz8CQyFjhhcZdCuOWE?=
 =?us-ascii?Q?+j7vzCor0lVVgUIGLNXNKj3S0IyNpCtarlutF8pTg2OiVlpXJdw0X+CbqhU9?=
 =?us-ascii?Q?C6TmZHFNxqhH4lD4XLDiWtHQx4X+WJdadGwL9m1l7Pv2FugKQO7+mqtmtKVs?=
 =?us-ascii?Q?ePgSZsQfflG+ICabQDKin8QNvGiNvh/n5HMDeAU/DAlDkDJ74Dn6xTTvLErb?=
 =?us-ascii?Q?x4zTTdVRbE7/l097ZviuA2ggvPrUiQFdqIaJjhrvUXNjISeZgZJ8Nvcz6RKn?=
 =?us-ascii?Q?G0EV2oKrI5q9vd77xgwXjQwBmZv6KCUac664Egdgnoh1dhyV3lNjynBKs0gg?=
 =?us-ascii?Q?4VvWU0ZX9LhTRawePhGnxkmkUHSoIk+xFxKA4A33xZPqaa6XKZRyoTGPbAfF?=
 =?us-ascii?Q?WMtQYqap85O/Ukl1SMb0KWSPE0130CVz4FsOVWSIyxyeCF9t3FrNXdctV+yW?=
 =?us-ascii?Q?T3rG9VkWCANGlBdCfaSiMbXeSv37GaRpPpFFUPatm43QnnbnaLTm91eN7J8E?=
 =?us-ascii?Q?S5/2Pbcmm+iRpyInpdtIBADN8+PXaCOiK2KEgbj8nlspLezUYbob5khCqvk3?=
 =?us-ascii?Q?/taFv92qjknPfoy7zu73mLa3Omc50AlyBw5LJcKEJDOAYfFnNtHQulR2EE+S?=
 =?us-ascii?Q?gQumwDhz1fYbAgGUhdGWnBj0r9HnxvxmgNc23qPtPbEpzen3F+6J1M/WJiZs?=
 =?us-ascii?Q?sqUNCwMkLzCA+1JKZLNjYVVr2FiiaHMwj9z0S1DoftctBjurrcNwlX/UIF9l?=
 =?us-ascii?Q?Bqa/h/CQuAiZZtdnvFklE31z5XjkS3/Gw7RsM/XpGMjQW14ljpbR4sf/oI51?=
 =?us-ascii?Q?H1aR2MAxUTaXNeoblJjv7PtgSD6WRntEuHjjqpMuiUpIe0+flbM8fWFKIC5y?=
 =?us-ascii?Q?gH978s2jXpQVJwXN4H+T/Od6Opypy90etTHyW1fStkrL7+KWOJLKuk+m18FH?=
 =?us-ascii?Q?UCJmqQ+KJ6BtJVXIeJ6Is9puAQg9/UJQVFfUKvVM48dtLEkJdIf+BL9tr903?=
 =?us-ascii?Q?DvXS3OZm+AliG4C3HWNy1Vi8/GOkejmnXQuA6zSvmReaQyrj2ZjBB0aYleHD?=
 =?us-ascii?Q?J+m9HYGceY7VH6Tfbs3imaiG2eGq1inpTlHcEgLKwewdQlH2A5zVbSBMOLUt?=
 =?us-ascii?Q?pMM/7/EsTnOgNtrIWCP0JqN9ERvl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXAST6+c/bVcxj8iwzOQBKIY2TZEEXc7d68ApjORTFXVahbtnaKjp19HjW6T?=
 =?us-ascii?Q?0uM+OnAPdnsYkzNaBO+elwR3HuiqB5Ifwn3KCrIDxMBuaQbgWN808MOEERKS?=
 =?us-ascii?Q?tbeLg4sy0m2s8PdI2w3y7VOQnPelXEskjPM3oUMU0GkSjQSwnfYgjNGi9PdW?=
 =?us-ascii?Q?K54uSec6T4ZxSwvNczLzl9+kalLemyrx0h16BWIywTrk5lpl6n9Yf1MOwO7P?=
 =?us-ascii?Q?jAPValc5fJWQVjQoa6/lhzfUt32NZZPpAvHLaFFwSKleh4xahdcqrj/Qq9cV?=
 =?us-ascii?Q?mEWECnA/88s5nc8s44Uc5XIHHG5uGLByoEADAAVEiSrfp/lJKKrXKezVfb/m?=
 =?us-ascii?Q?UAtYqUtsqKVqI/vLD49VW0BdTs1cnvsDeUm7+Mi0hLet8pkew9ggBYt6j4FO?=
 =?us-ascii?Q?VBV9wFo2C7q/0Bt9J873jjqOvnVUn5tpUxTHNRrktILgkybTzoMm/V+09FB0?=
 =?us-ascii?Q?RelTLEejfMskPg70DOzs+eDofMZYnZ58P24vAM2VPaLTN2dT6f7acuw8tVZr?=
 =?us-ascii?Q?vyH+a/ysUQ8cPniB66hYb10J87i4RkX6Y/eAZDyZmi3Ugu7MdkwYwB0rtmes?=
 =?us-ascii?Q?LgLYkU8geXuHrbERhYEa3X8Pd5hFlAduKaCftWHuDWGueAFTx/fUcjArAcXe?=
 =?us-ascii?Q?l4gOtdRNoHQ3mhI65EvNlr6DqIdvXJe1m4zTO3BzRR+36la1/Klwe5DgKDxV?=
 =?us-ascii?Q?38LSJUP5Vs7UktsgcKjfqXNF/6Y1VP/KpNWNYxac4Nf0PtL9GSCDOJ/F791n?=
 =?us-ascii?Q?hK9CEzeIo/WqbXIfW68izpvf4Vatg/rZokeNu0QGetZlmw2ZQ2Xy5sAkfGgN?=
 =?us-ascii?Q?JTyhRhWjdhK0iASRFXmGHFmTtazmyw5fS+rBqDTVn899RSiJC+IwJXbJOdcx?=
 =?us-ascii?Q?qx+giBlIXRLVkavkp4mgPHZGGA03HgEXqcc55cJBTqYi//1OPVNjMCoq6n1B?=
 =?us-ascii?Q?T++1mkdqijxzAs01hGecdgfMmi1mgLGszoC41ivhgfwjc/NICTZY6CoAThp8?=
 =?us-ascii?Q?iRIWXEc/aEHvhCB527UDgcUnyFg24Xl1nuA1tUyiklHABCF1RtfqS7s8EUs9?=
 =?us-ascii?Q?/hZj7SEed/ZkiJwVdmEpD49+E/F72PUHBOOteANa5/5m7mwhzbeig1T0wJLx?=
 =?us-ascii?Q?x2DyayUy7maTrNFvC6Xo1pKqFuXilqDmegW5wpGIih72Z48ngFPS4tUUH3WC?=
 =?us-ascii?Q?j/H2bSL49lAiNrTnijmZhLk0+MSEPLm7qTZaUPS40BDzJoQzEq1bis3CWZv6?=
 =?us-ascii?Q?w4DlLoZNdjRgZJdpQNfGKZAZzAcuzKlTlTcZEAbG2r77U78IadAsWH8+SQzG?=
 =?us-ascii?Q?Dbpw6QUt7/mhUQn6BDrsQpbIgcmzRaugkyA8RAANPrQ3b40qENf2UdOsFH2R?=
 =?us-ascii?Q?/clRb01LEJG2nxfM0/n6alI6tiYlIG8BfRjC/qzHEoZELoRob9njcDkOkMxL?=
 =?us-ascii?Q?YNrMmrwzEFHeSOYhNgmXmm2Se8j2F4VBBmuDDLng1AH/OdQPcAzIdyvKOBm/?=
 =?us-ascii?Q?anFCOvybTtvfdkh5cOEhVHbM9WkMtpBHGVVrQoMa0izrZXJAinvsQYNK0Mmr?=
 =?us-ascii?Q?fT6Lj6pBP+g2xZVVAx2Fb5m318rTd9dD/N+9ba1krvexiNfqTGu/HVCg9VJj?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05765891-57fe-42b0-5f09-08dd5511397c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 20:24:22.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2H66Z7lz6Q1+UyyCJTVGTGh0LBh0Uvf0xWv4Z3hs7vFFk7cAFEInWOfACjheKXHwWJy1lHnUaZVZcypgktuJ18w2DyuZLjb6NzFZ/TsZCig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 6/12/24 09:24, Dan Williams wrote:
> > There are two components to establishing an encrypted link, provisioning
> > the stream in config-space, and programming the keys into the link layer
> > via the IDE_KM (key management) protocol. These helpers enable the
> > former, and are in support of TSM coordinated IDE_KM. When / if native
> > IDE establishment arrives it will share this same config-space
> > provisioning flow, but for now IDE_KM, in any form, is saved for a
> > follow-on change.
> > 
> > With the TSM implementations of SEV-TIO and TDX Connect in mind this
> > abstracts small differences in those implementations. For example, TDX
> > Connect handles Root Port registers updates while SEV-TIO expects System
> > Software to update the Root Port registers. This is the rationale for
> > the PCI_IDE_SETUP_ROOT_PORT flag.
> > 
> > The other design detail for TSM-coordinated IDE establishment is that
> > the TSM manages allocation of stream-ids, this is why the stream_id is
> > passed in to pci_ide_stream_setup().
> > 
> > The flow is:
> > 
> > pci_ide_stream_probe()
> >    Gather stream settings (devid and address filters)
> > pci_ide_stream_setup()
> >    Program the stream settings into the endpoint, and optionally Root Port)
> > pci_ide_enable_stream()
> >    Run the stream after IDE_KM
> > 
> > In support of system administrators auditing where platform IDE stream
> > resources are being spent, the allocated stream is reflected as a
> > symlink from the host-bridge to the endpoint.
> > 
> > Thanks to Wu Hao for a draft implementation of this infrastructure.
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> > Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   .../ABI/testing/sysfs-devices-pci-host-bridge      |   28 +++
> >   drivers/pci/ide.c                                  |  192 ++++++++++++++++++++
> >   drivers/pci/pci.h                                  |    4
> >   drivers/pci/probe.c                                |    1
> >   include/linux/pci-ide.h                            |   33 +++
> >   include/linux/pci.h                                |    4
> >   6 files changed, 262 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> >   create mode 100644 include/linux/pci-ide.h
> > 
[..]
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index a0c09d9e0b75..c37f35f0d2c0 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
[..]
> > +static void __pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> > +{
> > +	int pos;
> > +	u32 val;
> > +
> > +	pos = sel_ide_offset(pdev->sel_ide_cap, ide->stream_id,
> > +			     pdev->nr_ide_mem);
> > +
> > +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT_MASK, ide->devid_end);
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> > +
> > +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> > +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, ide->devid_start) |
> > +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, ide->domain);
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> > +
> > +	for (int i = 0; i < ide->nr_mem; i++) {
> 
> 
> This needs to test that (pdev->nr_ide_mem >= ide->nr_mem), easy to miss 
> especially when PCI_IDE_SETUP_ROOT_PORT. Thanks,

Good catch.

I think the more appropriate place to enforce this is in
pci_ide_stream_probe() with something like the below... unless I am
mistaken and address association settings do not need to be identical
between endpoint and Root Port?

@@ -99,9 +99,13 @@ void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
  */
 void pci_ide_stream_probe(struct pci_dev *pdev, struct pci_ide *ide)
 {
+       struct pci_dev *rp = pcie_find_root_port(pdev);
        int num_vf = pci_num_vf(pdev);
 
-       *ide = (struct pci_ide) { .stream_id = -1 };
+       *ide = (struct pci_ide) {
+               .stream_id = -1,
+               .nr_mem = min(pdev->nr_ide_mem, rp->nr_ide_mem),
+       };
 
        /* PCIe Requester ID == Linux "devid" */
        ide->rid_start = pci_dev_id(pdev);

