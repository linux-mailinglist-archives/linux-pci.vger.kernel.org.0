Return-Path: <linux-pci+bounces-22044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B8A402A5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387FF3B7D32
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09374204F70;
	Fri, 21 Feb 2025 22:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvkjMgJ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F018DB0B
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740176910; cv=fail; b=jLxV1SN/qZLEhcZmpIBB8vdDi/KnbE4BiREfaVThPe5todG658IbljJONW7F4qtF7XSdUIwf9mBAaMFACl7cSUyiqx4O2RrnYA2xSvHVMtrVM80HG+KEWtckAdtPNd5txuMLur6cV3wn10x3Ek4qUkGZALQexfPL3nsIrDI8pQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740176910; c=relaxed/simple;
	bh=vafxA4R2XzJdr5DZH1HGGzFjB46nWN0dlbblgCJupIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BD/Qg8+SnuJKT2R0/xrf6f47OB6Lpm7ZRPrwDHAy1PMZmH0Wg+alX/VQ8N4N4xuNPe22ASgBzrMWXbElczQrXgYRTNxzJMT6x6K+JCJCkbYQibJmsJTV0WzunFkR3/pXH0cEaUNHOG4+cYrwXHRF6rIx0HcY9jHN+wxPfHxI8sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvkjMgJ6; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740176910; x=1771712910;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vafxA4R2XzJdr5DZH1HGGzFjB46nWN0dlbblgCJupIw=;
  b=DvkjMgJ6s5fdcRzz0zGNOLv/zCcNz8XjDNuFgYIX2a+icmHM6eUj5BJd
   EvUpDDmyAhL1P90w/AdPWBelCjzv0rTtjd4hJYvE0LK/RnGb4J9ltpOtQ
   9IrTxdXnmfto83w58qR+U/jhZ3JY/++omHEmqBydLoFMeL8BQKUYWsqBE
   7rKCVlELkYjg1u+iD1JujIvw2LWsZ6JJYkIJdNIgujMHrm+1xhFG4WsNc
   GDBzUh+sq7pmoO5m72udWlAYLSygOOOaKjBTvFE5ngpGshiFQBmLVyOVM
   4dDT2YZdEl0CN+W5fpqzT3jPcqHyD/uxoqz7pG9C4y3rM/Gzhi0G2yUD7
   g==;
X-CSE-ConnectionGUID: LE3rDD+hRZ2e0UhlzVgNog==
X-CSE-MsgGUID: Sbu8CaFaSR+fV///OMebtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40243138"
X-IronPort-AV: E=Sophos;i="6.13,306,1732608000"; 
   d="scan'208";a="40243138"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 14:28:29 -0800
X-CSE-ConnectionGUID: ITBkYKAMQ8GWBbSw6gNL8A==
X-CSE-MsgGUID: fuTDRm+BTTy/AaTwJkAAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119608811"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2025 14:28:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 14:28:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 14:28:26 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 14:28:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmCUFNyhrwSzRYZ4IRN5C7NkSUyQ/img0hXvnzTADv7qbnrEmcupTkApsI3mtWofzhxyBtfsmMGdSqK221crfacg0ITonn1BBQ2TKx3gQtr0J7B0VRzup+RnU5xZ6WvMYMspaVPJQ/yVKce2PAVi/XKHo7+gcP7cJbN/1oz/tWzzU7/XupQQRYcY5smNu4Xh1F1Iy7N7a1VPKtRgyotd7cCG4NfDzCbDGx+SKQzXSLdVmn4ltM1wnBP8azVxdQgeNGZPBrrPmGb/miAdYciQE4TdHNmBuKbuQPN5K1V8RkKbyy56iVUWSlXwvd4TQR+GNJLak3LujhGlmWMJmmao3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0uqSg/A5Rd7kuwn61fc3Qm8p1iTzEsy391B6v3CFHs=;
 b=HK84xI5JKXUPKpXphTHkYQesNAs4SeWE7h4Kc+igA6e8X9SrKPH8daLiDNNUGUV/kM4ZF2SJZZoiTf3Z32qcbEC9pSg6YO7tVpq0BU8z3kP/Qqd9sMVt1WaebpA7kxvV3G3DDI+dnpjOskM9UXiooN9byqhVJs3uwQErobb9/B+QRl0kEcVGAY6vkv1K/1MRgqsJl2Oh4uhPnbbdYumhz3UFvexB41szgF3Th6qJM05rW1T2YvAt50Bwv57QkZXKB6ZQKsF+pbJFWZzcBqDp11BJSM2EXZB0d26THf4zBxthMQIPXB6zfB+1CJaXyGljCSklAyQMhZShQDLSkU9z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 22:28:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 22:28:24 +0000
Date: Fri, 21 Feb 2025 14:28:21 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <aik@amd.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 10/11] PCI/TSM: Report active IDE streams
Message-ID: <67b8fe05c21a6_2d2c2947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <173343745420.1074769.13008006909323222504.stgit@dwillia2-xfh.jf.intel.com>
 <20241210184900.GA3079930@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210184900.GA3079930@bhelgaas>
X-ClientProxiedBy: MW4PR04CA0287.namprd04.prod.outlook.com
 (2603:10b6:303:89::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: eee3e1d8-80b2-45d9-0d24-08dd52c70dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxl8OcUSTlrUI5ji00zvO1w1DKlJ6jMIehzz6PJGaBJ0EGBvuo/zRHYWEfVQ?=
 =?us-ascii?Q?VfYn0ceTiriazFHUXA3esDcNHJvy+XlQScYJ/K3nL/MaVL8JEH6BI0FyazC+?=
 =?us-ascii?Q?DJGRK6dzcO0PwIgSAbMI7ucLZGG5RIW+OsAhNV0ezXBt9SMyzrZn0nbxEWrl?=
 =?us-ascii?Q?FcbCVJVet8XF0PPOedUkki3NyjuvRKYJidDXSPO37roPZcbUTlOIt6tKH8kr?=
 =?us-ascii?Q?v+q5ZT7ZTD2B0ErmtvhgLUW4jSH8i5BUVjpEKo2vu5NgLeWjeV8zIOD1I1UY?=
 =?us-ascii?Q?pvvnr8Bfbnb6dGPKBvxqVp+IozZic6Fywo3DA89APmINTT3s/ahPvO/Ni0yw?=
 =?us-ascii?Q?DSLUK/QTN5jdv52AGO0FfG/p5GR49g4eb7C72UBuXprz08bpZpqOrQnxG7tL?=
 =?us-ascii?Q?4AZ/5i4MQs61GZ+CmEA6WOQw0nVGEHswH5AkNXj+ZUt9mvjTSdafLp/quwO7?=
 =?us-ascii?Q?4c++mX7dENUecBJV2rjjqRCQmOpHVRCDsaZyweZtcLWwgp3S7fu3tA6vwyjo?=
 =?us-ascii?Q?6esd0Dm5JuaBegSKXcA/j/lz3l9xuKavXINoOnw6r1Iq5s3qmxBWdsHA90Xa?=
 =?us-ascii?Q?F+Kl+gXlTEuswbTvSq0/lYPKhgkjh4I5IlpEwi1OPYmS24Ugz4CyZRRHpbCu?=
 =?us-ascii?Q?V/IIoj0Fwlu8Bhth7ECpV0faATo23BePkox5IJPKjlKA6X3NGwgQ7QAiygIV?=
 =?us-ascii?Q?UOnKrO+s2KkgEYLhtAk8BAWsRiswa27oxEQtTC0e5Qq5+7nGsFTBgER0w6yo?=
 =?us-ascii?Q?3dpGmDyvrDmWx8UYOhNFsl0s/kCT99fzii8VsIgvS4sfrRmm8PACHd6B60Hr?=
 =?us-ascii?Q?m5oh5LoP04KMagQinwJ4A78j18BpcpLkQPUZhI+WDEF5N1nGcbN35oe6x2IZ?=
 =?us-ascii?Q?GRWh2PL2+AvAPhLGxuYhYInTk/tTw2EEnYvadzkEbb1vq1DDJ2Ot42cVrq6E?=
 =?us-ascii?Q?j3hVmU+Z4zY+AqLLh+XzZX6qtHf0nUHLpUdAtxg2ny/4DvATSQpHWc5G2sPS?=
 =?us-ascii?Q?XXKXdV/MtVGCce6cRgd1VN76WUQtaJHL6xhJj5FYgBg/4zQfTRX0hwM5+bfp?=
 =?us-ascii?Q?jOJ98L3U1ubfkU0zHYS8Nqy+ukaVpAyJ4Cul3FEp1bF/x1wMViTOXp2ZvV5t?=
 =?us-ascii?Q?emsvBRRAyFWTreARoU2Dzzqk+VjhzEfH8yOuiYWGOYqlZ3NeHp9gvgfJHuNf?=
 =?us-ascii?Q?cwBFEbrhipd4/bp235W1dtg43YLsXimWyuX5sa+/nvCIFGFPnPv8NC3ENWj/?=
 =?us-ascii?Q?TzcXsYw+LFgLU1eE+SHxiy8qWQocNJ0rBkbwavvynZC36PAxLf9k4GccqP7n?=
 =?us-ascii?Q?3LJvWx6s4XVc2LTuzIsO607sKx5AGv8vTGuA6La5WImLTzWD1yMsz0SIaRvr?=
 =?us-ascii?Q?uhBky2fxIgJz0QmsQcMHQ85GQ3X2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jAccvG20vMMFAFuMtzeV0F5U9FHl/b8PGdQvh69U9Hgpqx1XuoeZXRONzY9A?=
 =?us-ascii?Q?h2uxjneU/q3uuTW8XOFwfL8VbFS7EeXCJlRfSZ7ihv05lqQz9gk36ggdY+LB?=
 =?us-ascii?Q?n2hR52tcIPgGIPPZ6FAy4ZG+buLY/pgXmgcLYh94MtqVwK8/7TzMg9SX+Ayp?=
 =?us-ascii?Q?9wmOCGJYE8PcDlfOzZefessgG/OlHVIwk1LErD7ExGTyM1CEpUuBzHdZBbf7?=
 =?us-ascii?Q?ZdcIuAySNAuZp+yED6YKxwwiuzhlb2zN3B48xkovWXV/iypkF7RlJtuSXSKT?=
 =?us-ascii?Q?jlGUn8w8bxjbqjCir9cq6068rUN5DhM4Tsg3k6kIOfNugohoD3xfkB1ezv+L?=
 =?us-ascii?Q?hCP4IpZ8nXd4u0sVjHokW9WOPn2jepUpVACu8rSOQkC5ugtRff/VLbVN96EC?=
 =?us-ascii?Q?6zfmYYbWz1C5LBNGD6utnqikXNfrGY0DbYzwJWHupHmwyVe5akEFNxP3Kt2G?=
 =?us-ascii?Q?hhiatDUI5spHxLm/ik43Q+D+cz6IJNplBs1vkhS7UxVkEY+WQ8TGrNdOhywJ?=
 =?us-ascii?Q?C7GRVSgwrdwN3SRaCsDkeBC2TA459/FokttEYbsjCmkV+IuChMYYrxlJdaMJ?=
 =?us-ascii?Q?gTEU+3qmGaNY+wu9vXkeaXiG99t1wTvTpS5MhvSzRxff0cy8vj6ADloM4LyY?=
 =?us-ascii?Q?SFoTWTUipa63Q7kVgTJfD4+Gzy5WSDhtJ9oL71UoBIFGDUAVHGUPrzVJBe0n?=
 =?us-ascii?Q?S3TzwVXa1e6E8K78ZNXyHL1rD0FTcuaAa2a7DEI10FpsIBszRufbXFSx/gQB?=
 =?us-ascii?Q?JAUKWQxHrT7PTLL7eMg6TcEovV2rGlTOUVbV6jBjmChap7fKZ6Opb6uLrZ9Y?=
 =?us-ascii?Q?8+YfwjFpAXOdYgbyT05yhFdDkzyL50xeKWLsm4oYoB2oQ7KIGcOwW7VdqerY?=
 =?us-ascii?Q?C7PVDypDAH3tZglVpPxoGgjDE+g+Dj7su19tkz1v4RkqughRko1o/6z0XOgq?=
 =?us-ascii?Q?+t3tfEP57N014RN3KepIFKzIqds97t1a2cMEOuJY5NVVJmPbd5RByiEz/81/?=
 =?us-ascii?Q?ls2N/bJX1J+3Gh952lNI3y0prKNn3S4uTiuztG/M1xk+IXLrAvz2ahOR9OXC?=
 =?us-ascii?Q?8cVkWS+crkFwkF7uyVY1iewPXFV94T7RZPAqSMGk1ppJzHVfUGAe6evvzpG+?=
 =?us-ascii?Q?svn16fBEZVohp0Zb/ipacOh3Rl4++22+VrP2q521vPAHu4BQ62jxhm95sgW3?=
 =?us-ascii?Q?4js7fKTuluuOsaYZlsJtss4S+GvePJX9lG4kuvcYB/vJNW9C0YAcFPzS6ZBW?=
 =?us-ascii?Q?V8CefOavmFlCV4YTxW+a0jWqAd7m35R8cH+kpHvV6sZnPd4AkjAlsePy7F1R?=
 =?us-ascii?Q?Sj8h31ETdnoJvWrKtOGnZpHhtV2BrU2qcZqoulcxcRAPxYIpF5X3+G1bezgA?=
 =?us-ascii?Q?62kh4SRVyQ0AUXxUtKl8SOsPspcQtxZkUON6T4oFw45EPx71K+i++Xsx6p/X?=
 =?us-ascii?Q?pU5Ovu6U0KgPD1Eb38e3Nl5CVbXBFhtcHu6dRpiqRIAew6vBc9LiieM0RpPS?=
 =?us-ascii?Q?U9/EV8+DobhaHRnkAprVEXY1RyS9tb45doGU2ef9SUvq58mPRm/tRlXQZVsF?=
 =?us-ascii?Q?xppZm3Zv2zSuxttolbNj5/56ZpHokzTIQcVIo/Eb7aPzOo8YnLh+CEiyQyZc?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eee3e1d8-80b2-45d9-0d24-08dd52c70dc7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 22:28:24.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBotD3SSRPnOric+ATydT2XLEaruqdfcynfT0U6ScYQViV+61UIED8r2hbpkpWL2kxjccTwxciyTd3BuPIH6FjCc6byBBG9LagL40Hxgkw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Dec 05, 2024 at 02:24:14PM -0800, Dan Williams wrote:
> > Given that the platform TSM owns IDE stream id allocation, report the
> > active streams via the TSM class device. Establish a symlink from the
> > class device to the PCI endpoint device consuming the stream, named by
> > the stream id.
> 
> s/stream id/Stream ID/ to match spec usage as a proper noun
> 
> > +++ b/Documentation/ABI/testing/sysfs-class-tsm
> > @@ -8,3 +8,13 @@ Description:
> >  		signals when the PCI layer is able to support establishment of
> >  		link encryption and other device-security features coordinated
> >  		through the platform tsm.
> > +
> > +What:		/sys/class/tsm/tsm0/streamN:DDDDD:BB:DD:F
> 
> Typical formatting of domain is %04x, including in existing sysfs
> docs.
> 

Yup, got both of these fixed per comments on the last patch.

