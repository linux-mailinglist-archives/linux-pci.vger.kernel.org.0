Return-Path: <linux-pci+bounces-6741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A988B473A
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 19:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0EA28243D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073EC1411F4;
	Sat, 27 Apr 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/IIUQZK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E228F77;
	Sat, 27 Apr 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714237666; cv=fail; b=XRbnxRQ0VTb7I/964ALE87Frj/S8auhRm2ausWOa5UG8zT9ShrUQQgRMtQH12jN+3dQ2f/fTZ+3itYTQnVzBmgVXJqMN0aAwm3K9ECuIVsa5OqHZeCc8A7euEo9LxhBoRGpOM28/1l/eYFq9FPFIFQFKbil8Xyuetwv2wy4tFUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714237666; c=relaxed/simple;
	bh=+bZLEvrI6/56hRv4SBz+z2ct1RJ26DW5iGaCWKsJwFk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+TlB34rkeSlUpAM/oGW+m3yGNS0ZmRZ5RMzAGG66O0gJQrkDAEhjpL4trBaV0hsdUZLoBMYCXs8varmpteErGvvqFBb34LxX4u8N/7WqRwdGpYPEWz6JR404gBlmPa69P13bIM3+Uj2ePfnoOhJc6YXB788a+MhDzlAc6h9DYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/IIUQZK; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714237665; x=1745773665;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+bZLEvrI6/56hRv4SBz+z2ct1RJ26DW5iGaCWKsJwFk=;
  b=l/IIUQZKunNsPy04QsJKKP9HXdYNX7QfyyDNczSUN/DIHqsWZjiHIsOI
   3gnqIHGQ698vgq0IHFYg88p7huOCmHOv5cVez7Bm0kP8AkohmpI0RBtoP
   uesdxPTYAU8X3Wljj7W9/NOetFUFRLqXhsqCwUa7NbHFQdp77LyNHsGXZ
   lpkUER2p91jjG4knhNAC1fC4iBwLeQk2dbFpI8MTRRQTPdXJ05BUoOmn4
   v6qPacinndrvoOLfP4gpXhVRIIl4j4LCi2mjLvBXfMpeyoxwdMF/lwWh6
   RMGZUHgP/+CjsPsVNnLN2tkHtrW+dXRtiV2rmqWtXiIzIrWWrj7UcVEKd
   g==;
X-CSE-ConnectionGUID: F8DvkAqLRlyQuMRO4szGjA==
X-CSE-MsgGUID: eQFq2c2SQs+Efg/CPGt3PA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10075328"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="10075328"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 10:07:44 -0700
X-CSE-ConnectionGUID: PCyJ9x4DQWSWV3K8O/5Rcw==
X-CSE-MsgGUID: 2lH1tMIMSA+nNzkXCXxfRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="26336879"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Apr 2024 10:07:45 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Apr 2024 10:07:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Apr 2024 10:07:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Apr 2024 10:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwU+qYO4LEmRnGf+OawMXowx634glBhDsvfUy1Td7UEdJsTY3+8XBRlLDVegmOQFD4QdBYniLR8Hlc9RyoE/nUfLqr8snoprwCDA7zP9XHIua2GiKbW0fJdNuNjeuIA5WNVF8gwcwpakHCEgjVoJW4eZAmsqNrBbg/puClNI0GAVgsGcCbEkwKxbxnpq6TAXhHObOMmDLRxW9pRlYwmYZ9lXaZYReG/gI7YDmnQ4cUfYHUIGEXf7cnEw9tqW56lMFP3cZjk4FkS7227J0ndIfjmMGbqk414Xzu4HWsu6BJ6VmFCflJY9f2AWCqA7gyciyn67x1qZeqLhfWeS++RoNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2FAMlKpXzSOIhwzg5mQrhQBCpq2RqP9YSKEvnZCQxE=;
 b=P+E7TSB1zo+b1GLK+TYbL91s+6mtIo7EdgrTJVjLAql4Gvx7zMCHpG1v2cpghHeLTCKQHXewJxmQVD09ZQK5QoTqVAf8DynK1Tlsh6bT2+Brl8P2Mm3SOclcfg6R5neWHZKPctT+LF8rcj86zbLKXSXrxPmHA1SSsZCGWQe8LO9cigPGw2Taio8hfe/bMhGjXf30NJjCaF2bGZlrLPNJlAXLEMV0XbJtJ+bu/PmKJtyOCbRjWM/u7lS9+ifluDKs4cJAxabvKVw3zfyRDge6ef6EkcGm153Z3/Xk7CjVTBgRV7igkSyq+3Zv/PRA5GiPaCsDp45YZ/ecSMDGWWjDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 17:07:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 17:07:41 +0000
Date: Sat, 27 Apr 2024 10:07:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 3/4] PCI: Create new reset method to force SBR for CXL
Message-ID: <662d30d9c841c_b6e02947d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240409160256.94184-1-dave.jiang@intel.com>
 <20240409160256.94184-4-dave.jiang@intel.com>
 <662c04a5d8f5f_b6e02945f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZiyZDKSxtfeYi0N4@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZiyZDKSxtfeYi0N4@wunner.de>
X-ClientProxiedBy: MW2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:907::35)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a00ddba-f81b-4565-4d5a-08dc66dc8c6e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uYEg6lpzvlW/Cz2ak8SiwwMKGSPONKz6OeX6VWCbIoJzDIXXhnkamPv7Q+Bz?=
 =?us-ascii?Q?6EJstDr7iVMD5tfjdPNI6Wb/K14itP3lk6RHGBMaaRB/ROeT/hoTdsr3ZUhx?=
 =?us-ascii?Q?OCCYLXh8rFu76ij3ZxsivMZJgKB8156q10necWU1wqgCPzcqwtChPVcp3WKh?=
 =?us-ascii?Q?ChLXQlGUGYM1b5cVjrql/3dBH8TabJm5g00eauMgzdATlFWpVS8N02JgzOx+?=
 =?us-ascii?Q?WlEp90d8WWx6fVP5IPzJBn542aKHGWuN9Oo11H1evjS3agykTcLrFFCs8kbv?=
 =?us-ascii?Q?EoaGy4xQ6vZd1SDP1N+TGLjU2TQGhbfcGYHzeMV36S7pUXGi7fMokLhjqvny?=
 =?us-ascii?Q?dEtAMO9EmjcI2qUmr6jz+79n6LRI/hXOdQfPVQcLTQ5mtKZs4WQ2vAvi6Oha?=
 =?us-ascii?Q?5v0ZKCMHpE+WsHJJ0aZlp2/Rz7bMa9Eg1n+oP6bk4TZONnXClqwbUjy0e5DJ?=
 =?us-ascii?Q?sJgTrYPtqAknWwdPMFPcBTBmztq9ojY+IuE6PEk7JCkrM6bmNE76VO0FTnRT?=
 =?us-ascii?Q?7Ne1QCQo+g+5MpHBcHRXnMIztSc5YxG+L39+/4LzpO9AmMGt94asbhO0sNuK?=
 =?us-ascii?Q?QmdSj/DJeUwWuw9/RdXV0RJ4q58I/tGfWtumO0lu9HuB45C5rdH51l/NKxOJ?=
 =?us-ascii?Q?0fblHEW+zOGEG5/T6IaTcKlG3NkP5zRqfohEABvgDgVw7hS4Az7UDdYjklbU?=
 =?us-ascii?Q?zc5mmRxf0TBfsU2pQi0sVq+BTu1gmBFy9Aten7wPnRrsBKq93p4Lz8YBAvcy?=
 =?us-ascii?Q?h6ZAH6yiR4nt+ZCpch3xz7cOT5nP4aQdkd7wrZ6rXuzuG81GzY9A4snCRttH?=
 =?us-ascii?Q?gNzXyk7iWQK6/FV/bFlNJe+MsDI1BKk1gmeIkWfhaaGR0KqghZXbrO/K/VsT?=
 =?us-ascii?Q?Xoj2F68WOX2rDk9eJBx88ycrhTI9c1di5j6PDuF5I6JB+QlYEcfM4eH2G4/B?=
 =?us-ascii?Q?cqkvWUvpVw07HUjeW9yVIOTgV3qgB8kkoXOy+WQHYA3FHSMikA3puhZgasl8?=
 =?us-ascii?Q?EkSqcry0z4x0XptBQdejweMg3h5aNmwcyCK5EPwGjXppc7UKtvWefcSFmaEe?=
 =?us-ascii?Q?/YyhUqsCiJEVSUgq/WlAEwremFuHVESpmPSeDa22LAjG4Tm4dPmACSM9cFC3?=
 =?us-ascii?Q?hzOWh2WT2OXdQ3URwGzdSFeCNh086LStyskWE1x4x5aKpOq05SFQ+1pdNcKl?=
 =?us-ascii?Q?mKhNqv5LAp+UeRg1jT1m8IUlaspvXo1ryDwQWfXr2v1opfZ6KFjJWijC0tM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tui9eXK5ZNgtCoNvneERv0YOcuHzrgcmhaaum2aNur9RpwUmkz+f/v6/Sukv?=
 =?us-ascii?Q?vs2P2661iDLJEJRVWvN+e8PHyJhIAzK5XlP9jhdoPXM1Yyxvn6vn+Ko/Xlm2?=
 =?us-ascii?Q?IAbynvLAzns6D+TbiE6TwII6nupLXu6GEmycIV2BxVLS5gZqaJy0g/0wmwSr?=
 =?us-ascii?Q?vRphL+Aw9LFxalrJDf5WhKCG92mLHMw1Dp2vdiA8ZV9s9lUzthP4wif6q4Wg?=
 =?us-ascii?Q?flu9sJuZDl5cvSErwgB8WDUSnymctEvOFmepX/HligVwbzmzG/+/pszlo8Q4?=
 =?us-ascii?Q?Nld56H98oruJMvUz+pS1ylFDoA3qq1+T3+ehCMyMNw+8sQDB0VRuvq1XrG9W?=
 =?us-ascii?Q?Je8JrKSQfqlxXKnVpOgJEK8B1hjkt+DyzTogdFKdmfR+wa5iS5j2EGp+Y0l7?=
 =?us-ascii?Q?ETMDh2eJ7BgMBmdWGiXIFfBB6hdQWtkR3AlIJpFyHMaLiqK5WZOKstoitmFP?=
 =?us-ascii?Q?4xCoYEL2n+Jo7A2VhK7XujwBxhea8BEIM3q/k4iR7sNhB6T79ELZYk00Ilcc?=
 =?us-ascii?Q?m8HnCZ9HtfrWU3wVjSf6CIMBTLS/f/lTOPZCOfxgOi7YIwel13oqwjZcOJ6v?=
 =?us-ascii?Q?ha7DJXq+CvE1fhyr/ykjdvAyy1jCcUBVOBDjjjiFHQiVegYf75Dxybx6OIaH?=
 =?us-ascii?Q?erDCdM/U5Ajm3ea74zz1VfJ4ivnNzeTnMzlRmlqVANIlpL60DVWbURAMCs34?=
 =?us-ascii?Q?0MibjX0Y7rKTuswV1yx0qZCNQH/pHby5P9qGAP101J7jfvEiPKw6w0CfVyFD?=
 =?us-ascii?Q?/X7qJu3GZBJbZRhaHSTx2JD1589KclTv8H2SsY++yL9waJvIAC0qJyL/CWqH?=
 =?us-ascii?Q?L/EeUYd4PuQNXmWazZA4reuV7BHRwanbQb+a33jSohs9Nkmw8suc9ipylgZ3?=
 =?us-ascii?Q?SjM4ZdzHJ86cpQMQ3x8Fut4GGPrGX5wqKuVO4dFGHod5xBQDJKCAC3pANwjX?=
 =?us-ascii?Q?UYPeG3leSRr76L9rY1ZCXsC3qIPBBGH+sBkYxJv4Q7uSMJ8RCk9HaU3OC0Sj?=
 =?us-ascii?Q?8Np7jwvVjFhkJNFZ6hSG/XUlR5KzsK0nsuhgX/tqzoe4xfqQpV7KUIRh37/G?=
 =?us-ascii?Q?XjWuNxwtgM0NI7RAHQzbsKyBPTPbSK9EhwdlrkONB3Sv02o6oh7W1oB2Dpz6?=
 =?us-ascii?Q?F6pICfv6vWusUMS1u8Fxe8A2bJM3cp0dCdztysKQUIVgAvhafcyPIuNCbz+j?=
 =?us-ascii?Q?ns9SrRiym2az68JJaQBbn3hHJOANugTfTwM0HVuuWZfH2seghld7xxqodyEQ?=
 =?us-ascii?Q?do2qVW1kMV+4247fJA+hAxYARDWuO9mbGkIvkZGxMolQOMZrWp1RnHiDik/8?=
 =?us-ascii?Q?5X99BzVYbbVWUgiONmVKXk+XCnQ+gqMnj03QX3rMYNA3UeV4mPmZE+SRTUBv?=
 =?us-ascii?Q?/LlkAa2ggxbzXonZuXPcs+uzu9YwqrQ/lgsdIwjuY2Kp1F94ySMrEplsOJo8?=
 =?us-ascii?Q?WLl4nwEpecGK9TzLlOPwyS9J1baZzBftSkLkRsChcJRcQ0wfOu7gxPrzi7FP?=
 =?us-ascii?Q?TT02x2nkyuJIWhw8hGp7oW74V34e6bELK4d9Nul42MEDplWwlRKx5vFP9/jF?=
 =?us-ascii?Q?JHmSO4AztLWkKZ90Wjcdi17GYzG6kG/d+3fWwl7do6QuNPPFOExHT2Kg+tEk?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a00ddba-f81b-4565-4d5a-08dc66dc8c6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 17:07:41.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWiKUhX89xAV1LOJudPeaHmNPIHbsnOs8aAH1fM39n8MLIOp5gClt0SC5Zg0yzZZI9KUZt0NBKErz32Nmy/t5aMy3/o+HWJFrTK9OdnyRhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> On Fri, Apr 26, 2024 at 12:46:45PM -0700, Dan Williams wrote:
> > This also highlights that the pci_dev_lock() performed by
> > pci_reset_function() has long been insufficient for the
> > pci_reset_bus_function() method case that could race userspace when
> > pci_reset_secondary_bus() is manipulating the bridge control register.
> > 
> > So, if the goal of the lock is to prevent userspace from clobbering the
> > kernel's read-modify-write cycles of @dev's parent bridge, then the lock
> > needs to be held over both the cxl_reset_bus_function() and the
> > pci_reset_bus_function() cases, and it needs to be taken in
> > upstream-bridge => endpoint order.
> 
> No, the device lock is taken to prevent the driver from unbinding.
> It has nothing to do with protecting RMW of parent bridge registers.
> 
> Here's Christoph Hellwig's explanation why he introduced acquisition
> of the device lock in the PCI reset code paths:
> 
> https://lore.kernel.org/all/20200325104018.GA30853@lst.de/
> 
> TL;DR:  The PCI core calls the driver's ->reset_prepare and ->reset_done
> callbacks and the driver needs to be held in place for that.

Yes, that's what device_lock() is for, *but* that's not what
pci_cfg_access_lock() is for.

So when I say that pci_dev_lock() is to protect read-modify-write
configuration cycle access of an endpoint to be reset, I am talking
about pci_cfg_access_lock() not device_lock(). For better or worse
pci_dev_lock() does both, and maybe device_lock() should be open-coded
separately.

So there is a discrepancy when it comes to protecting manipulation of
secondary bus reset control registers of a bridge. The
pci_cfg_access_lock() protection is applied to the bridge in the
pci_reset_bus() case, but not the pci_reset_bus_function() case.


