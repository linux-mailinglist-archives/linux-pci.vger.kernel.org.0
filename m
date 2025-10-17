Return-Path: <linux-pci+bounces-38414-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA071BE6325
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 05:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BA119A6C73
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F7423D2B4;
	Fri, 17 Oct 2025 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGjCKnuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD76B334689
	for <linux-pci@vger.kernel.org>; Fri, 17 Oct 2025 03:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760670825; cv=fail; b=Y2FKiqUSg7M3lKlJOaUXsvDLGj9v0LLv4+MJRPIeWdqSsSwfxco+EgurNV9y2JIz/23TPqdI1EFN1KRrQP8zrBgNjdvFuE5zJF3WIM5ZMtKxAv8JIXbAbJJewMfQnyJV+cQ+72oFdKTZH73jeaDWWHeFm2BUWX5qi7gyZeuByuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760670825; c=relaxed/simple;
	bh=dyg9yAdTAtCIJDdNhR+vG+gy6I2SIWF3DBf2C5aS+mg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2XvgLWJYL/YFzMK6a4NNAi1XAfLIqYEUzQicMsK4oP7mSHgWXHeH39rSiy9HG1vrYBo92zkjB+WpSJwGqcxvxtCYgs3nl9hVoQzxMbH9ElBuRDQd2qGbbXKjfOCovEBKaCw1P5YkYeTENrcaBv7KMI8JJoihW0+ZOLNqjYsO44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGjCKnuS; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760670823; x=1792206823;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dyg9yAdTAtCIJDdNhR+vG+gy6I2SIWF3DBf2C5aS+mg=;
  b=DGjCKnuSNydiQynVmTdEOYae7dvoX0J62g3DXLbYEbzH10+cfKuPIMYO
   +ZZMOuZQGz0sLPE2GPIlB42HYJpHchRtADWxeWQIIL771G7Re2q9QWNaw
   EfapcCigRvL3xItCrCUrKuiNRMSLyhT2hQuNGNfni9xVLsFbn78qGI9i5
   OKTBmlNYF0o3qTi8CkVFws5CWr0wMMzXPmD2QcqIO8hxJJIiA9+emJfrm
   MnENZdqVKsnjMXsA27azaBwP8ABlzK6qO3aPZTyS7meZGitDOO+eMRxOv
   jG4CBZ6vFNqXomofoSqmEZdoBV/6AO9C9tB5d1M54TGo5fboX51JF7ttd
   w==;
X-CSE-ConnectionGUID: vdh4m3b+QGWX72gAgFidnQ==
X-CSE-MsgGUID: 7Y/cJVv5TcG3xHgi4hf8vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="65492397"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="65492397"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 20:13:43 -0700
X-CSE-ConnectionGUID: sKf7KbTKTA+OYARbO1WnOQ==
X-CSE-MsgGUID: hMTG7PCdQ06R3I8sSiR9Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="186644379"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 20:13:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 20:13:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 20:13:42 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 20:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe3z3CnN21Eu6BwjXCyrgjHPswDsmxOge4+/r7sCr3blhBlNdGVgtlbe4v+q3ns8H31CLY+J3dh4qSk+12cesMJMivKWfUDD2ghrl+XwCBqCt9lZwCdSOdf0Haa3zytszsB3U8Z5ThXX12264y0jENqg/a5vx2z8Sp3Krb3K9ng44qsDJJukr3dANrIXfdBxH+GnL5AWQAcs4vGH1MVVkh+WvDntuHQf1YkwyAcaX2qwaMspUk9A3Wx3Qzm99hhfp+7iOOKy9mDn4Ve0x6rAqZ5Q70UaUzXxTntah5YFG315ZyNfh1qh5Bl9THLjKrkt0s65DAhkpDdN4qrrwvsx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT36HPmNxQ/4yyo7JYY8yYoD2B3KGqK/LyrHb/zuRyg=;
 b=s3xaC9sYqorTqgo0UW13Z89uiAKKicIY3bAMJ+47HpcN69FjSxIyIc4zhA85sI16za1imG7x1cBtXTgctBSa13lHoB2W8YutFQIpojL4+SY4qS0fbxbUmBC3pTH7VjS93w9EOEePAzlRJIB4GsNlN+eZHLflTMBXKLb6Myi+uYbS6ImNNzs12dVUC3pMyc0worl/HDHBPzXJNkBqvW+5lQfi3GijbwWAY4j/fTDQEsd4/us+yhakGA8E1oFuYyQ/nJUEGjjWru93/hesB0sPHe4EAJYXqR1c/A2rMI48CZcOKTQsBUCii8Orp6AE5Tb8Ao/13CB4R87AiU7r1rTZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by IA1PR11MB7200.namprd11.prod.outlook.com (2603:10b6:208:42f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 03:13:39 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 03:13:38 +0000
Date: Fri, 17 Oct 2025 11:13:31 +0800
From: Philip Li <philip.li@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, <linux-pci@vger.kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: Re: [pci:for-linus] BUILD REGRESSION
 f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01
Message-ID: <aPG0W9dymBgDbhAU@rli9-mobl>
References: <20251016162854.GA988737@bhelgaas>
 <bdee889f-b154-4532-ba8d-ae5910ce1613@kernel.org>
 <e31f6ac5-ebb6-9989-60ac-014054f1fd73@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e31f6ac5-ebb6-9989-60ac-014054f1fd73@linux.intel.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|IA1PR11MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e31a679-ddc1-4873-7556-08de0d2b2ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?S+6Fk/bZSrcCWDgixo7uaklJr9eOpXJVgd55aOZtIVbzm531qvRPXv6dgx?=
 =?iso-8859-1?Q?/K2Bbgf84UC+1kOEJRasvd0OZRJbcwNk089GMiOOKQfNZ1cqWMQRF+Zv3h?=
 =?iso-8859-1?Q?yW6K1Knw6g2KdTxiSET37cze1uxWAUDBwZ+Ih5tGc9hzpiwiWE+ng2zbnn?=
 =?iso-8859-1?Q?1DM9oCU9DGe9Dq53xMCjVxmqVfeLfDM+lvTz8Fc05kJpG4mdKXqhQFj2QS?=
 =?iso-8859-1?Q?IzJAx9ruqr45g1kjQPuVD+XDkBWT5K33F3pgxgaI3ir3dtsgXSJhEFq6fp?=
 =?iso-8859-1?Q?K93gD4GVYMFaTi38AsPbvF5M9nZxuER5qF6/KTpkgbcQBW8sO6v7ZKiUJw?=
 =?iso-8859-1?Q?Ke19rnLwDWN7zYoHt6A3L7CZnrd1VP6znC+C2ECzXiEFIlz/Of13zrtzVV?=
 =?iso-8859-1?Q?Xmg7DER1FwSix1C01PJBAbUgbaMZ6tLx4grxgNfnkJtmK0SNpar1kwoifi?=
 =?iso-8859-1?Q?IkbUq8wJBMM/4eWUloxwGyBRvnw40dlrxZTKBx8mN6cpdsI1glat6dsJmw?=
 =?iso-8859-1?Q?12WlQYdBrpAUX7DaLnsWNpf6lDXF2zY1Grmzg7JnINbmUI0Qs5f9O0mKJA?=
 =?iso-8859-1?Q?Dbge0nDvEzW+BgHuLNbbucJQ1CNktasuSZfxbgoWcnAaZpEYRrCQy0hBW3?=
 =?iso-8859-1?Q?SicxfF+QGWMblsRaJHw0p9gzTQomck+F5KanGRBpV7nR5WjpQOZa8AkFC9?=
 =?iso-8859-1?Q?FOc6qt20Ckov6EU2WqCWvtpAtDEIljMIg50azA6LFdtigszI7nKoATzw+9?=
 =?iso-8859-1?Q?v5DUkbMJuPU0nF3QUMZxR/9JMys4M08srLdz4rlVMZK0Cwkc5qnm5qBl64?=
 =?iso-8859-1?Q?/km6lpZjTKoctGD2uB/OPGDdmY50Xu3/dqvyMQXRbbgxGzP4k/gytMhYnO?=
 =?iso-8859-1?Q?iwvn7yqu86VxqetLh6mxbNMxOsbqMO4qnoV/+yiTxvRNQqqKtWdATEECiC?=
 =?iso-8859-1?Q?XHcK7QkAjWyWT1ALjL+ZssjkgvRTpILTaIWAYjD2Eoy4lUm5GWEp5aulSi?=
 =?iso-8859-1?Q?Ato1Ie5Uq+93dqLvBer6BY5S/nbtAVU4ziJD2qC4ixHNLKo3I80DaTLZUI?=
 =?iso-8859-1?Q?V2T8Bki6xuQj8m1BgjsxDxGEOFPkygWPLGu91TpmZMquBbCJdDLKwqmbl5?=
 =?iso-8859-1?Q?lxZ4nZ3WbwxuHY5USmAHzlcHEKxMXoyltB1Swrtwl98KhcKn1T1uzws/aM?=
 =?iso-8859-1?Q?3llTC6q4gsA/v47LOkF1PRDdRp6hCwcmHFL5U6LUybY7aFQz5M7GkXtGbM?=
 =?iso-8859-1?Q?oYVrYgr/8mtVQ7dW6WgSdAhqboyIXUCXB/V12UDUhs+s4U02DvZakPTgfH?=
 =?iso-8859-1?Q?vIblHje1pOVRtu8pmQKYu5N/NJzhYyCVa2xYoN52AyUWGKgUfvNgcqdSNP?=
 =?iso-8859-1?Q?l0SpCF+dbXb/xK9zhpWZnELGsB8Nv6AfHe3Rb1pr2aZLe5Ky4iH+t/0df4?=
 =?iso-8859-1?Q?XzXwxsvpYLFTmAXK36EVujPPsrNuenkDCTZk1zw0Vo42m04sYzadGZFUTf?=
 =?iso-8859-1?Q?wHZkgfjJgcKcl+nw5k27VBnAyZZNtmy+8kpDabXSMDQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UnlE0Rq3ZOgJ2KTq7h/p0ny5R+UBjMWQkeWf6s+94RY1Qfu7tZvlkunqis?=
 =?iso-8859-1?Q?uUjO6vOaGhE/F8rXwVMQqlAe2dXgPNGm+znuYNERNQ3alkZPxCvbMUytum?=
 =?iso-8859-1?Q?AUnXtpMHczHw/hMhKqr0MYsWxJD8gBe/5L8NmGd2Vs/+W5hjOZksGqTFZ9?=
 =?iso-8859-1?Q?9lvkUDmWlCMz7zH6KiwM1Ht7Bcezm7JUasZ+Q8W1IXoBQzAkOiT+ohcr/p?=
 =?iso-8859-1?Q?x01Ndu2+45VZjAcyvnw980/AiFy25SKK4PNhewBAh8bbD/Bss0dih8UE6M?=
 =?iso-8859-1?Q?JxUMgG4PdnITfMGy+Vc5IoQrCCvfWqh+RQcGehxU4cv+0r5rjlzWlogMep?=
 =?iso-8859-1?Q?H92/RsBbIlOsfKIfUwNavYFkISl25piaSEwZP5JdC6GmLlVUenG/NuH0v5?=
 =?iso-8859-1?Q?t6jWkIgPD/sNvyZfV1q7wKgDEzftHHT4CV5eDllD9okJLH2jx+Kw7Jo8JM?=
 =?iso-8859-1?Q?ATCjwTFcr9L5sehNZxPHGACYeccSyydg6fNHffwlTVAGBcEGfj0Hi1XxS7?=
 =?iso-8859-1?Q?x92bgU4AtiUQWTY/lrZVmXzMs2bh8CzxTBbG1doyVNrimY9d/WCjC7o9rH?=
 =?iso-8859-1?Q?IhSG+W9ZT/AJOYLXne+5nvaT07m07zG2j9SqSrCevEFdRT5RNAKeQ6BZ/f?=
 =?iso-8859-1?Q?JQatl0+8VsJQf6qoYuRBrCytP54j4DNUEtNpVf/dCJBf3IOIwMa/RXbWT+?=
 =?iso-8859-1?Q?dcaYajnEkp8RKoI4a38ayLLfZWzblnAdTDO4p7y16QZMfafP3B1O45Xs+j?=
 =?iso-8859-1?Q?UvRJlDXRWne3jSSj9kpbfiUZ0zDvgNRPm3W0v89GBA6EasjOkJYtO+CGbL?=
 =?iso-8859-1?Q?OcKkGZcaKm6kPW0hvWD7rVNGQnGFcP/55nuJXVt6ysL8dKWyMiZvHCXIlu?=
 =?iso-8859-1?Q?E7wwfoY3XJ4WqLZHQvYdBj2FfiVeFtW9fIZ7ppyRbNo8TMREGgADR/ITkK?=
 =?iso-8859-1?Q?P212zrBLdOhOc/aFgJXTEsudEGAzz9A+STkg16YyACHZNK//iW32tx0+7X?=
 =?iso-8859-1?Q?21svxZM+wcpV0aDkUXtd067LQo9kpxMur6cmiYCPY8Wv9PY9pxhw0i+PGY?=
 =?iso-8859-1?Q?n948SF8uc6BvHFuLmyK97+mKWjT1M58mlrMNKRqiRAuKQzz5kp4728GpdP?=
 =?iso-8859-1?Q?APhuclKSs5naJEr96sMJyDVevryCwiF6GGixRhI7SF0vjoxTxYqyIwFocQ?=
 =?iso-8859-1?Q?BAnRLktVt6DBngYJ5mdtqV7rfva83V4M8XKSpBoj98TO6CbeVGdfUhyV/d?=
 =?iso-8859-1?Q?1cZksyPwM8c0OpBUGlUZKvAeAzjXPNnWd6QY5pRyHoaypc3Hu6qRYApOp2?=
 =?iso-8859-1?Q?TkuU8z3a2cBjdhdXzIHiGJfUMoViPSYfwTe5viEH6Qj+JxPVUqCQ7/WXx6?=
 =?iso-8859-1?Q?gSWupIw60q+8rVou7aqJLOqL//FX4jfaVnQw342GlzdnS3OlewE4QzcfMZ?=
 =?iso-8859-1?Q?4hlTGEemy6OK+sXoJjXIHUrR2Hm2KuCQcqehMMdkQ5CGE72Hz4vYJIEKB8?=
 =?iso-8859-1?Q?s29wT2tiy0sOvI7xb52FOoEhnXAqtAB8a7ao1dPaqPzJB7usTP9xKNac/L?=
 =?iso-8859-1?Q?qHJL/nuIFZgHQbArCwe4VOJFSUy0tNUaKOmX/+/Qw60Ja3eLx4zETSsRUx?=
 =?iso-8859-1?Q?9FMYmznwT4xQlZJ/pXXGbo0b1MGmTLeCyn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e31a679-ddc1-4873-7556-08de0d2b2ace
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 03:13:38.9085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUjMHGjqoCV1X4D/DAx3g6+svYEV1/fUbIs4ri9InX7K5GmUD+eHm+vh0M4Z2YtKS8vAIDyysW5Buq1AIt4m0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7200
X-OriginatorOrg: intel.com

On Thu, Oct 16, 2025 at 08:45:55PM +0300, Ilpo Järvinen wrote:
> On Thu, 16 Oct 2025, Mario Limonciello wrote:
> 
> > On 10/16/25 11:28 AM, Bjorn Helgaas wrote:
> > > On Thu, Oct 16, 2025 at 11:18:38AM -0500, Mario Limonciello wrote:
> > > > On 10/16/25 11:15 AM, Bjorn Helgaas wrote:
> > > > > On Thu, Oct 16, 2025 at 07:26:50AM +0800, kernel test robot wrote:
> > > > > > tree/branch:
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
> > > > > > branch HEAD: f0bfeb2c51e44bee7876f2a0eda3518bd2c30a01  PCI/VGA: Select
> > > > > > SCREEN_INFO on X86
> > > > > 
> > > > > Just making sure you've seen this, Mario.
> > > > 
> > > > I didn't see this, thanks for including me.
> > > > 
> > > > > I *think* f0bfeb2c51e4 is
> > > > > the most recent version, and it was on pci/for-linus, so I'll drop it
> > > > > for now.
> > > > 
> > > > Are you sure the failure is caused by "PCI/VGA: Select SCREEN_INFO on
> > > > X86"?
> > > 
> > > I'm not sure.  I looked briefly for a more detailed report but didn't
> > > find it.  Maybe didn't look hard enough.  This email seems like a
> > > summary that could possibly have included a link to details.
> > 
> > I looked at https://lore.kernel.org/oe-kbuild-all/ and don't see one there
> > either.

Hi all, sorry about this confusing report.

It was reported as an internal one (not sent out yet) because it fails to
verify "relocation truncated to fit" issue, on an early commit 17643231e977.

But not sure why it is also shown in this report, that I will check in detail
to fix the report logic issue.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
head:   17643231e97742d29227e3ed065f9a16208d3740
commit: 17643231e97742d29227e3ed065f9a16208d3740 [1/1] PCI/VGA: Select SCREEN_INFO
:::::: branch date: 16 hours ago
:::::: commit date: 16 hours ago
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (attached as reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510141712.a7KcFkhp-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/mips/kernel/head.o: in function `__kernel_entry':
>> (.head.text+0x0): relocation truncated to fit: R_MIPS_26 against `kernel_entry'
   arch/mips/kernel/head.o: in function `smp_bootstrap':
>> (.ref.text+0xd8): relocation truncated to fit: R_MIPS_26 against `start_secondary'
   init/main.o: in function `set_reset_devices':


> > 
> > I think you should keep the patch in.  As it pertains to arch specific stuff
> > it behaves identically to pre-337bf13aa9dda.
> > 
> > If I'm wrong and there is actually still a problem we'll get more build robot
> > reports as they come.
> > 
> > > 
> > > > I wouldn't expect the below error to be:
> > > > 
> > > > > 
> > > > > > Error/Warning ids grouped by kconfigs:
> > > > > > 
> > > > > > recent_errors
> > > > > > `-- mips-allyesconfig
> > > > > >       |--
> > > > > > (.head.text):relocation-truncated-to-fit:R_MIPS_26-against-kernel_entry
> > > > > >       `--
> > > > > > (.ref.text):relocation-truncated-to-fit:R_MIPS_26-against-start_secondary
> 
> Looks unrelated to me. These "summary" reports from lkp often contain 
> unrelated errors, I think there's even mention about it somewhere in 
> the report text (probably before the part which was quoted to the list).
> 
> -- 
>  i.
> 

