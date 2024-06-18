Return-Path: <linux-pci+bounces-8929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B3290DC79
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6561C2250F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940313D8BC;
	Tue, 18 Jun 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDLxx6H8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77BE383A9
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739168; cv=fail; b=bbqduMtDeXHhJ3yTgRoasORGbKqNvHKKahWjCpBjM4f/MPjjSZTkvqrHsenW1YfEgWPgqEikguPiQlvyISHug3QNKqIAXHZhfnZhZsM9Y4tYiKorqORMC6CvUtI3HWPNbRci65hfmOTtIvX0t4GVIAofNYqxA4jn2t3AEh49Ivc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739168; c=relaxed/simple;
	bh=T0LnvBaa/K91HLU/6Zato0xia8mwocUkA1br0ycNgOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c+mPMrOvVw6xd7Z4Ihn2bPXrTg/nsYoaz6NmCcZ8oKp66N8mGQKs/HV6apcxdJay1YRlTY9yA0VzR3kekwdKybHHD0miqdFLKWKZvkx+UxE1uwR9hp4EaZfKZXTJh9MKTdAsMMk5vUH3DujHRX2JvgXf/WKq/fayrJ8xIhyeQ+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDLxx6H8; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718739166; x=1750275166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=T0LnvBaa/K91HLU/6Zato0xia8mwocUkA1br0ycNgOI=;
  b=TDLxx6H8ymHYSZNanXBxwS5vSBba1Dx5RjgCMj30vaX/mQrE318/4fUt
   LJnQcZNzSAdJq/aQRQYCJYQK/d3tpPzlzsrceeG3N/hq1/f4MWdFJBYPP
   c5DbJ6np9NCOyOjKp36HUBJTphMlS0aiJCpyDSmpefO4YQxruYCNzSLxo
   WrfBghYZhwoOahvA8ez6nuylUFnu3R0qKKnczMLSVB0Dbqc7WXYKpZb7v
   IJ/PIZ+nS11itL8jdZHwD6PS7+p2imEGQ+AnQZfnERb4y3Lc7qooKB76O
   xoeLFD3LNXVD0E9vi1DX29hEoOxvxUI1GcCn1NnMIoY8xK07zQ6gqSqLF
   A==;
X-CSE-ConnectionGUID: ENYzbTHSRpSDI0QFa40QQg==
X-CSE-MsgGUID: pzXHWlNCSqGiHVkg21Pk2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15614399"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15614399"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 12:32:40 -0700
X-CSE-ConnectionGUID: cMi2GUzSQASp4AcUy+Hyhg==
X-CSE-MsgGUID: mnAmkvcmT+qre/aUBEUkSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46613179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 12:32:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 12:32:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 12:32:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 12:32:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNKT3ap9DHCfxRHOLKSaGMeWQSe9GtquZbB77wYpyE1PuxcIy4r7tI0IhiLbQ4rRc7M3cVR0xA9HlubLCTDV64ZxCmQdvsqIC0iQgGUbVkawyxQFHA2cD9H1cSZdIazPYNEyS8v0h2oX1jQZ74iX8WKqJSmVxKUuP5Gl0i75IuKpY7PyJjtM+U11OMMxEjOYHFxp+3Qr02G+o1bTV7Nntt5106SF3OJWPIcUZCIKwjAD2uynRh3iWW4xqFO8vwjatIZf33JoAVnxWOLlYrd+Gs7eMLwtJ203hzmqUajq042vUlI+ZrnzYHptLxgzOdXhaTcbW1/pSdRQ53ecX3txFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNe8j5vWQd8o8vGHa1cPiOROGV7Ry7LjHGd7RVp4VzY=;
 b=MMlnb1UzSs8cKMkN2D3xYNWpwp2zFoNsU+pAmXDmBBdCBQcivICggjq8+nuXikcs0YKJpYF8i4G3cUrIbRQ+B4QuqbaGVyUETFUVtkOK/YtYT0COvdwX0dl+sAZ2aBfVAYSJD9/Fbx5aiLZ+h7eu4vHD5XL1HZ5sGXQcU1YhiFtyXF1wKf7ALFHzhUwzR+v4NsAAxf6p/YdtIrYyIB4CYhK7DM/9W7KOlnfsMzCoCsso7WSWTXdZ4GAVKALdt6YPgnpHrXtH6Uq5Jke3cxiD8hVdn2MBME3oTG6DwmAVPRx9J9HYkfUim1AYMpWr5wcZAW529y1eCV0AXK2BZ+78pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:32:36 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Tue, 18 Jun 2024
 19:32:36 +0000
Date: Tue, 18 Jun 2024 12:32:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: stuart hayes <stuart.w.hayes@gmail.com>, Mariusz Tkaczyk
	<mariusz.tkaczyk@linux.intel.com>, Lukas Wunner <lukas@wunner.de>
CC: <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
	<bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Marek Behun
	<marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
	<rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <6671e0d13f20_31012949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
 <Zm1uCa_l98yFXYqf@wunner.de>
 <20240618105653.0000796d@linux.intel.com>
 <20ba8352-c1ce-45ba-8cb7-7ef4c02b3352@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20ba8352-c1ce-45ba-8cb7-7ef4c02b3352@gmail.com>
X-ClientProxiedBy: MW4P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b957e92-1410-45d7-88f0-08dc8fcd685f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lNssDSeS0Rx5nhyKbmXwGv4YgqAIvZ7mi+VpRrrvfMyGuKiyt48RjD8HsxkN?=
 =?us-ascii?Q?cJj2Jw/JTzVaukEGVjAz7IFkDEncrPMnJS6IoAMf+gWq5WXDunSnJUb2nqyT?=
 =?us-ascii?Q?n/GZP82wv7WVnPJErJ7ZWtNH0AdwRBYW1Gnqb68pgJ/TEW9UGotpAJyr18Nr?=
 =?us-ascii?Q?B7o16WRQIxBaqpP3kyTrAOBhyQd/PIbLG8KM1FPpm8Mi+1/4ZdjpiQ6vF4/T?=
 =?us-ascii?Q?t46m+G8jW4P7tuyq6hdonY1UWjFGXYa/mGEL/DwcXWvptlq7aA092u0DOWql?=
 =?us-ascii?Q?qe+A1yFBrVQEOdAUG/haAUwnf9V9Q6G1NJrRHFV4RVuO7a2FiuYD+71XkXgB?=
 =?us-ascii?Q?0VCnB9eCgn1jCT5KWUVYrn88a3VemKMMwy42sQJpVh3rPkipwRsluahqAdSg?=
 =?us-ascii?Q?xGq4O29gUp/YIZK0rD+2kah3uDLlOBwkv8v/ZSyf9Y+NraUVz0GtuC6zw0Rx?=
 =?us-ascii?Q?XotaWEK5aszn+uw173cXzdcLhAR2m8MNWRj05ZSQUIMQC3fSgIihIR5g+RW6?=
 =?us-ascii?Q?YaOpUt//6H7YLBi43anK2ubcCBrFdcpPw+VbvMrYq4+FBn2nwCDY6ffEOslj?=
 =?us-ascii?Q?biEj5pc9J0AKXBbPDbufbxi7rSDyYBViE4aslhYQWbNXvjZwzEVIwQ1b4KgT?=
 =?us-ascii?Q?YB1nNksBS6Zlw0kqieP5khTiW+8lqAT1dDTlJrY9SdK/wB3f5c1qNHW+ebvX?=
 =?us-ascii?Q?G+Lt3MPOrYB7iFn3xfXOb1aioEIs98YV4/WJ9HTCe/NSfxNs0X6LZ3rfb6+p?=
 =?us-ascii?Q?oksUdTziWqJCRPJOsdF60etDGX4o4Tcekp/+gCcofEDU67HOzjXlqFsZna6c?=
 =?us-ascii?Q?Krxf6MbOqJk6LXDt2eAO/tGO3xEJ6j/F0Nd5JekFLILR4Jm4LIFZlorMqUWa?=
 =?us-ascii?Q?RdNXUG6jye6ikz6cAwL+ZTOGt1s6HfJk1gEZl6u2TClAv5OXHD/RMFOg039a?=
 =?us-ascii?Q?/JLGu739Dbl0KfpzwIn0isXkKGnEJpJVX4g7prw6vwH/q7eGa0hGPRiXf/yN?=
 =?us-ascii?Q?LeBIP8vtRsDoinG1ZkX+va7fT+ZMe0YcwCQW9QpN/FCk0YL6jbe9VsJHCe7P?=
 =?us-ascii?Q?OEzhE47buqIK+whPLUSCmHxJErVvF/6e7OpPr9FwUnhUctb8g0mTunxZaKEp?=
 =?us-ascii?Q?h0Eo/i5WgPNwS/ZZJDy7mVGnty61IkaEN2s+AVafDFuyoMuXjCdq4TJHJALH?=
 =?us-ascii?Q?nwu1BlZAIy5lMlDpoAs5qFAI4YK/GPl7l+qgp7Aif1TW7NXRWc/9qYDez70i?=
 =?us-ascii?Q?NVuH2f3gyBC7+tDjmwJn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bSZAU/C055fkSdUhlsAlKeMpLQakgcZRbD/IRQtf6fs0PHmAAr8bniOBKLuW?=
 =?us-ascii?Q?nJ2z/7mWZdoMWFMfUcH4JmKFwqytfcM+3tWZDnL4f9n8o4+tPlFXNr9ZR9P8?=
 =?us-ascii?Q?btOE7Tv/5N/nrn0pV0+IIA+b9R8A4lSsKV1QxoHHKHDUKqAT6YefPepenOFq?=
 =?us-ascii?Q?9mzsPpDMaMKJoKdjnDrDLzZ9dxp5zUtexLfo5mEcS7S3vdfHyPSnnGnxk+6J?=
 =?us-ascii?Q?0PNJ1emLDwuvmpNnjIREMh9TciEln+oro8dGSbnmio5qi+uhfmgaS4CxVR02?=
 =?us-ascii?Q?aqvnFJfxyZ2jhJgukHx7BtXiXNbsVYYO3mtCaJq/n9sy6Y/GvFeVknUuOufL?=
 =?us-ascii?Q?DTlQFy68K7UzMYHjt9nAgTt44jGE6xc5HnNj6eXD4uUwCZf3BinihfhuAksW?=
 =?us-ascii?Q?Rw/1r66IAWUjPUJqtDSLXQVKpuKYGhYZd5TXlM/BQxqE9k+JqGzi4yTzbmh0?=
 =?us-ascii?Q?2uRjy4ECoyVjvmzIfyAoHWk5XBuCU9kEwzxfSZgGLPp6z36/zPtvTZ5BSbUP?=
 =?us-ascii?Q?pFv7myEVSj6na+f/Um645bmYshkLZFDdabugfUh+Th9z7gqBmJMcMm616yRt?=
 =?us-ascii?Q?lrhHUlmAz0ybIi6jTIl6kK2PeZwZUUkHKV29UFs89+qekhUaILCPNqIb3EqM?=
 =?us-ascii?Q?hcqu6URDkek6HD+zozgUj5+2kibicQpXbu4EOKG0+sZWYUNhVpbC1pJcJ6Ol?=
 =?us-ascii?Q?SsXSbFjAg4A21jHIM3mJ4TsnqTjy7i9jINSf37jSWnDFhNMWw4Cy4Ix9L957?=
 =?us-ascii?Q?7IK8HXPFnSCMCfcrbZgtrBoxOWHv3kYaLhVHmNIUvAH4BqieoFRzMC9Jr/sY?=
 =?us-ascii?Q?rEr3pwqDF2rA2hnKxPT8cECTFKSioqPVEqzaPQj5ypI5tUf3wRN9T4dRfXwx?=
 =?us-ascii?Q?k8Q3S43oJQ6YZ8EoaNCN2Zp8a/vTDR4mfr2mJW6bN4OUOesry1i6i1vuaR+h?=
 =?us-ascii?Q?/BJtP1QyaVY0riUQdFFPLoBXVyXBBUHaiKk435IuSVf/tmHtO7lD7LQ3BqJn?=
 =?us-ascii?Q?MIFgx8U+tgRJV1e86IMm1/OTVBWnIb/buf/yIzEtNdMj9/V8iCsAT4H/n8Bj?=
 =?us-ascii?Q?VVIAyd4qFezQMYuDwxzT56scKcISoq1OLyV7XQKxJVupOiYdqe4XTQaDitz4?=
 =?us-ascii?Q?lQ95w92zje39lQ0EzRj/z45EYVp/E9xkJbQCA30iNCbcEzODiQXpE9d8AbtE?=
 =?us-ascii?Q?j7IEz8MjDi071fYXOfmgXALP9hUE9Uly7VwMLoJ9CqVFtUjLo0Os317tf1Bi?=
 =?us-ascii?Q?omB2CbYitj7QU0R3jeVfg9H5NLEa9WQ7PopN3ledcSj1GB5SIFYGAELlugjo?=
 =?us-ascii?Q?I/G5OwoCjdVSPqUYETYW3IWIMaT7Y1Ez/x0ieFlRPnYjiQuSvosbATucxaHx?=
 =?us-ascii?Q?0z0r/wyLLOJLCE1Nbm+6JUzOT283/2jfAio9JzrTuy06UW6KOOm5a63o4Fdm?=
 =?us-ascii?Q?BThn8B/ycBlKtlbSOqMAtndZ6StWpntmWJEbh8WXkSOITfHpjFVQlsvz5hPy?=
 =?us-ascii?Q?BJoulkvFMmoMn/AcQFaMZpVzCL/QBtLVyWMqzC2TZ9TWNZfD5z3hSR+mx6en?=
 =?us-ascii?Q?1QgCC+L/eA6Xrl3cPL1HxXnK2QFXAe3ACbj5DdZqSEy+ceNgtSuJVgLNEI2j?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b957e92-1410-45d7-88f0-08dc8fcd685f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:32:36.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yKH7yW6CYn7gqVtAiyCOxJA67mLL6m5Oxy2iPeGLAum2z5zexI3d7eUAHxVgDoO7NT4JC8oeZvQLU2UVqc7xwlPsVAZQZbzta1uaEB6ff3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
X-OriginatorOrg: intel.com

stuart hayes wrote:
> 
> 
> On 6/18/2024 3:56 AM, Mariusz Tkaczyk wrote:
> > On Sat, 15 Jun 2024 12:33:45 +0200
> > Lukas Wunner <lukas@wunner.de> wrote:
> > 
> >> On Fri, Jun 14, 2024 at 04:06:14PM -0500, stuart hayes wrote:
> >>> On 5/28/2024 8:19 AM, Mariusz Tkaczyk wrote:
> >>>> +static int pci_npem_init(struct pci_dev *dev, const struct npem_ops *ops,
> >>>> +			 int pos, u32 caps)
> >>>> +{
> >> [...]
> >>>> +	ret = ops->get_active_indications(npem, &active);
> >>>> +	if (ret) {
> >>>> +		npem_free(npem);
> >>>> +		return -EACCES;
> >>>> +	}
> >>>
> >>> Failing pci_npem_init() if this ops->get_active_indications() fails
> >>> will keep this from working on most (all?) Dell servers, because the
> >>> _DSM get/set functions use an IPMI operation region to get/set the
> >>> active LEDs, and this is getting run before the IPMI drivers and
> >>> acpi_ipmi module (which provides ACPI access to IPMI operation
> >>> regions) get loaded.  (GET_SUPPORTED_STATES works without IPMI.)
> >>
> >> CONFIG_ACPI_IPMI is tristate.  Even if it's built-in, the
> >> module_initcall() becomes a device_initcall().
> >>
> >> PCI enumeration happens from a subsys_initcall(), way earlier
> >> than device_initcall().
> >>
> >> If you set CONFIG_ACPI_IPMI=y and change the module_initcall() in
> >> drivers/acpi/acpi_ipmi.c to arch_initcall(), does the issue go away?
> > 
> > That seems to be the best option. Please test Lukas proposal and let me know.
> > Shouldn't I make a dependency to ACPI_IPMI in Kconfig (with optional comment
> > about initcall)?
> > 
> > +config PCI_NPEM
> > +	bool "Native PCIe Enclosure Management"
> > +	depends on LEDS_CLASS=y
> > +	depends on ACPI_IPMI=y
> > 
> 
> I tried it just to be sure, but changing the module_initcall() to an
> arch_initcall() in acpi_ipmi.c (and compiling it into the kernel) doesn't
> help... acpi_ipmi is loaded before npem, but the underlying IPMI drivers
> that acpi_ipmi uses to provide the IPMI operation region in ACPI aren't
> loaded until later... acpi_ipmi needs the IPMI device.
> 
> I'll try to think of another solution.  I don't see how to get the IPMI
> drivers to load before PCI devices are enumerated, so it seems to me that
> the only way to get it to work from the moment the LEDs show up in sysfs
> is to somehow delay the npem driver initialization of the LEDs (at least
> for _DSM) or use something to trigger a rescan later.
> 
> I notice that acpi_ipmi provides a function to wait for it to have an
> IPMI device registered (acpi_wait_for_acpi_ipmi()), which is used by
> acpi_power_meter.c.  It would be kind of awkward to use that... it just
> just waits for a completion (with a 2 second timeout)--it isn't a notifier
> or callback.  On my system, the npem driver failed to run a _DSM at
> 0.72 seconds, and ipmi_si driver didn't initialize the IPMI controller
> until 9.54 seconds.

It strikes me that playing these initcall games is a losing battle and
that this case would be best served by late loading of NPEM
functionality.

Something similar is happening with PCI device security where the
enabling depends on a third-party driver for a platform
"security-manager" (TSM) to arrive.

The approach there is to make the functionality independent of
device-discovery vs TSM driver load order. So, if the TSM driver is
loaded early then pci_init_capabilities() can immediately enable the
functionality. If the TSM driver is loaded *after* some devices have already
gone through pci_init_capabilities(), then that event is responsible for
doing for_each_pci_dev() to catch up on devices that missed their
initial chance to turn on device security details.

So, for NPEM, the thought would be to implement the same rendezvous
flow, i.e. s/TSM/NPEM/.

I am an overdue for a refresh of the TSM patches, but you can see the
last posting here:

http://lore.kernel.org/171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com

