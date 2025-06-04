Return-Path: <linux-pci+bounces-28931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79196ACD52A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1AB1897205
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C43FB1B;
	Wed,  4 Jun 2025 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="As3anVSd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C24683
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749002119; cv=fail; b=fhTJ2njlDU6AN0pO81IAJ/eQLedvtsBbOr0ydjyUjuq1hqTsuM6roNsCCSUvOoluAN7bFMBob8N8wVKobEyRPRc1hbHVFzaQRoGn+X2daMnOntCrOHLzp7ezSBC3ELZVTHW4WXD5WvLzMZEaYmqN4j/Y02rV6flsvnHq5sTC6ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749002119; c=relaxed/simple;
	bh=6CfDD6VT+V7Q/VPlhN09oM2PhgN2u477DiQa3z7xiow=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WYxi9Y1XgkVYepswLnzYNlMOUd3SS/w0AHF/vJu0NtQXDDENZ5Jj8shOhIVgSdn5u+2DKNAh79/+hRrlzDWGiEIdsGEevcMvgwZLaCrySsk/N88RjABKnc4ma5dAbw61JzMSc4/rY9ZhdKgHunYKL7041tEqQVftMCKCHopYvAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=As3anVSd; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749002118; x=1780538118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6CfDD6VT+V7Q/VPlhN09oM2PhgN2u477DiQa3z7xiow=;
  b=As3anVSdOOKDDb1whiuhpyLHEme1r2q7ue/ENAxNkuVfMopOqRVnP+M/
   GpsGBD8vuGqXShIxpPVZYhC8CA3gKaAhwpStGCw/FcJTTgMJxVIeGJGDh
   0II8IpAr2420RNoR+VH9RyiyDV99O5FMHoKbEiuFsvI6Qu0FS/IOxhtrs
   lEOIdsSXie68V4O+91hW2XDF2Q2r1cLVTgi7u8tPkE83uaCi3/ZtyxU2c
   2iJUKbeN+yRaNno8+roqa39qJxkGjNi7w+NSBhHC+xVfax1fCb38gTH6x
   h66z2V3CtZ4R0OWfZV5V9Fmt2LT4DJQNvo/miO4dnfvwIvzRoy9NBskF5
   g==;
X-CSE-ConnectionGUID: X3s+cReiR+2hfbewMEZcHg==
X-CSE-MsgGUID: y/wyDrQwQmKCK1A6STFOUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51135992"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="51135992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:55:15 -0700
X-CSE-ConnectionGUID: Uawuk7zoSle+OZBVP0qOTg==
X-CSE-MsgGUID: 39+2JND8Q0KKLKSn5Ib7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="146013292"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 18:55:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 18:55:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 18:55:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.73)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 18:55:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf9MfXphbhG885SDGmBOL+K2rBbDgy0c+PmRdLrwEZeKawgz7tnZVtAdVJ8YAObWWofZQ97IZBcheYhQ9sFfqHy5W78grPLVok+JSaP8eS6nNvZQiPQ1GiDzIHaJ/l+HspkBWxCPaEwuL58Fs7pp75v/yt7urE+5a5Rb55XAKvFQ4eYW66nEZ9QwwYV0AN+Yd4Xw7Aic1e9EqB1k3kXB0Jt+dfIDgc9A5udkXUrl/U46OM+YK3Rt79KELZbffuIzVKHU2CwR+jqaUEHjxkR2htkS+mLbxLQsaLqB3HOJzQAB4MWJyTG7+DidiXFHU2Olo0OrWQ0+v/3sa7aYYi6lQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlKKC1Cu01v+aXuGRDcIB5Z1gye7SNeI36kspK00I+s=;
 b=sGyXsBR327eXcJUz0m2x+A+rnk+5aJ/TrcgFMjTsU3plg2aweeXvvh82g2ouGb8AxiwKDLQkVzfTQOEnXcIhlcFh7P4nY4rDLcXb+ntTiOhHga3lZEx5EKCoig1rrJDRcR9YKYhWNEgMW67QmnoLy/lZMNXsjA1EWj6EC0fjBvmbXjhVy9INYpFFO/w0HUjpk0+CVbKct5NQasm7Fl0tE+2fJbmxk9TQJDE58XzKDonO3ZTTCF3iAQJTBHxrStVs9XC+QpBW0m697D38wRyARsjtkk+eIugy5Y76rlnmDA2bx27lO/HdgTvgeNUH1IS/UL52Me04obPRiIgvxzGaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB7398.namprd11.prod.outlook.com (2603:10b6:8:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Wed, 4 Jun
 2025 01:54:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8769.031; Wed, 4 Jun 2025
 01:54:45 +0000
Date: Tue, 3 Jun 2025 18:54:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Alexey Kardashevskiy
	<aik@amd.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <sameo@rivosinc.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <683fa76214ebf_1626e100e1@dwillia2-xfh.jf.intel.com.notmuch>
References: <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
 <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <5d8483bb-ceb7-4ef3-920c-d6286a7de85d@arm.com>
 <683f7b6fec30f_1626e100ab@dwillia2-xfh.jf.intel.com.notmuch>
 <53c7523b-5cf3-4047-831f-12e0422cdf5d@amd.com>
 <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <683fa6f622abb_1626e100e0@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: CY5PR15CA0068.namprd15.prod.outlook.com
 (2603:10b6:930:18::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e72789-8e17-4e96-063d-08dda30ac7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lRrS0Tyvvaku07kXQjQvzDUebl7qj83wjY1swy098rJIVC6dT+kbaJyWPElp?=
 =?us-ascii?Q?3tqX9/ZlV3rqQ5TcuKOwj1MZt5ekBrVVNv3j2py7rMI5uiACx/KnsrZPR2kQ?=
 =?us-ascii?Q?iXNRWS8eqWjRmCn8iZ2XMIt4ezdF5laiDEDL/pEqBC5+MPWmdq5LscBdM25x?=
 =?us-ascii?Q?C7JcF5uCzY8SPwBOq5crCT1efZRK/6rs6zMBmQVngwJTKg3V/FiUpvpbsn5s?=
 =?us-ascii?Q?kOx/wP6GLlNKTt5efX/lng4PUFukMZqbW1uazygn9X+7KlM9NCFRAHjw/KGc?=
 =?us-ascii?Q?vokD7tBGvlB59pab8+xJCa/B+FwFiXTXyh2thxT+OgqKddR7FWVM+0fXaUBZ?=
 =?us-ascii?Q?QJ2DGosAkjz3iblG+Hg0XsK/e8YdwGwv+9WhwyE5GwL+KosptumZ1oI0VJZ0?=
 =?us-ascii?Q?uevKkztr0jpJfPna/WAnWD9lCJ54eNtWNpUzRKtB8zcd98gENbGOILZm5Gfx?=
 =?us-ascii?Q?zWJQTtUfE8VmpeypEFmetuOFrui7ilRYjlNIKhn1FlNaMOKNFUQjcehOFzTa?=
 =?us-ascii?Q?jUITsEp4/3BByU6217UWe4AwXz71PnC15YnOHY9gCcIs/cuUqIO73Z2azMK5?=
 =?us-ascii?Q?iaRRsJoR/nkzXjkC0ha561yW0TkCqvNUWNrg1zZE5KqtGJu2zNdZ3Hmt9hbV?=
 =?us-ascii?Q?PeXdGp5PFZKZOQAhM3/nyBrLCT5YgUPbYYuQzUcKTmbx6mtTMcQebS0PrxzP?=
 =?us-ascii?Q?QuADH56NiMTeFVIZUdJsjfuCzKwnutCn43nWCWiMMYX+f9j6ESN4ZUv++1AZ?=
 =?us-ascii?Q?xkA+bXQSmPDP+/7iWPiO8lc4FTa4krzh1vqH7GHD8bKyJliB5ZXhc4OoDCQm?=
 =?us-ascii?Q?+akMNoq5z0w+I7x0LWIr/dZpQPSrkLGAhCdOE+W020gd9nPojf/E1wrPl3iP?=
 =?us-ascii?Q?BktkKnLlZuCNBaRfgjLjgcpXx8FePFXeSIA0bykg9BzP52NT6K393ZsKjta/?=
 =?us-ascii?Q?CWiOCvOCw0BJPnr6XfDQbKjMbsd/NRPszYee6F8FOJOwZETnrTT9Q6wovYVt?=
 =?us-ascii?Q?d73HCBnvAqqU3ACCB/Fxkb+kMtO6zoMEaL3EbsEAv+3cJMs+SCvbsra0BCan?=
 =?us-ascii?Q?RdGv8FniBumi/YzwFNlS+erveBLDVHcYXqgtl/6OTbtpNJVEZwDOOpHDTXBG?=
 =?us-ascii?Q?KwwcauUcOzSX0g+3Cqa/4Fit8gRw5t2JLzgKmv5bAuA7+Y7yXFcwoprVMlUK?=
 =?us-ascii?Q?Xwp4INMjpRRu9gVJpoMtP0kZZMTLLkG/l3CL7gxc9jOE7hKZebuDKAJhZIUs?=
 =?us-ascii?Q?KGFr7COrzQVR7eu57VcIBiPbsmHT9+Kd7Fed/EE+2XeQ/Cfz5MIiqY//AOqV?=
 =?us-ascii?Q?cy9/4oKzwhq/tfb0UzOK7jqKg0Q6N/CoQIa6hV7GmiOuZJqyaXg7OHcJu0k2?=
 =?us-ascii?Q?rtSy9Z4MgAb+yV6+fFFFPHu0cA/+vvZsdkyl4NkfQhHvpen303agp6P+52BM?=
 =?us-ascii?Q?pv0S5q/ezHQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkR148PZ1Xq0IW70KbaGz90juKyWnw5WyhK1LN29mNF9ri4CpykgXd8q3jit?=
 =?us-ascii?Q?7CQMwaEuEIekUD1NhOBwMnaeZtY8LHTjBNq4eeHMdCA5Uesy1aThwXC2Rx+9?=
 =?us-ascii?Q?erlmt5PIrD9KOc4d/JgML5TQZeOqIFI6gqDNDDZzEQcGnqkqxyAIuEA2zVcv?=
 =?us-ascii?Q?gGDAWiAKdfN2wj39XS3KoKXGDJCyLDyvUlmjRXiCuIt0AqBII7XRzx/+zm8E?=
 =?us-ascii?Q?pkBS4nTEJ4t7GwWhis0+H5MWJ67HJlffpowgZX3FhavxG2ex+UYSCJT8xlsf?=
 =?us-ascii?Q?w0NFDTKeruznflCHhI6N8oaQRu5WtbE7zvF4Na0hsDbnH7sfKZ9SFigJH1gv?=
 =?us-ascii?Q?jtvBthaLt+a4nPY2hIKe5g2Mi80OlqS5pGw/yZ53Dpy6xSnVAFro1LL/gNQp?=
 =?us-ascii?Q?aWfHELPmL4BXSDn48ai21BlL+Ju8t/NzrU7OHvjIK5+4yWbbjOJaUpStFPCI?=
 =?us-ascii?Q?CUqcZUIan6bGauMa8DZcSq3RsHZfDxTHR8MDsIEFagE3JF6Q8u8Bkhr0Yh2S?=
 =?us-ascii?Q?7hifTZItbif9/YMe5ix512/e2Cdxhr4Vf3fvqX8r3hLWUZwui2crN+GQzWsg?=
 =?us-ascii?Q?HOy3qm3sSZ4eyR+OIZ83TRqNMgBqNr9vxqa83nnzDbGkd7LDjwHzXXUjyKA/?=
 =?us-ascii?Q?P6+3jAPtsSZK71/sAuyhAgWaubWM2O+uggDwrS8kBwTzF2lsJ16qoslSY35S?=
 =?us-ascii?Q?4HeIlmwiJvmzydD0ECS11NxvxcYVoMOCthUbAa+w5MB2qibW6sNNYyZ1BKlm?=
 =?us-ascii?Q?9LXYDQqH8FJq/SVNg3BXkKvIdTkvj/lzs8e8vzcbNyzFW22DeuZ3EMDjACNd?=
 =?us-ascii?Q?jSHJsyaTFosnikzZixMasd7xrhSgmK+wr3nwOHL/5HRKJuchQ2cbAKZdFzJh?=
 =?us-ascii?Q?bbdqU2FeZZPFe9e9EM0Y/QBpGX8AvzXxLHTSl1NDQGD4WSy70Qae1EGmLgYz?=
 =?us-ascii?Q?x41XnkHRyK+g2cKaISkggeLXCXBvJf8IVLLUUzyxx96CGMR4X0zWitbXx++P?=
 =?us-ascii?Q?SZO1HVeE+oD/rUSAjPsEenev+pPXuiXFMUGSYnOrd+6+B+nIMUa1t1lJDjLq?=
 =?us-ascii?Q?D5x7c7PH15qdjfOM4MP9ezeapWMfS+SuQtx2faG+k8cUnrEDQLncqcKRmsYs?=
 =?us-ascii?Q?W1ITLeiMQwRBGCKBjA2qmP2RZjkZ+eZlJcj/dN+a1hC8vokEKRUp1INH+LlU?=
 =?us-ascii?Q?nuzLvZIFUweVdoobcKSGVIzfNb/whgo/8tKNCqClHsFFwDZn2dBkYH3lPdbT?=
 =?us-ascii?Q?+b0PRQeDfJTmJ2UVKslB8Mko0J/3DJ/xfVwrGD1R+pM/ssSqjkJX0bAdEwru?=
 =?us-ascii?Q?BMIgufFg//g1jHaUs3DlOrW8sRq6rAVnoyPbwwmS9LiU7+CNdjJ8S/09Tkhd?=
 =?us-ascii?Q?sx/Bx0jeUaStU3YaSD+NLtsaCuDqQVrTU/WfwyaycMGud9uF/N1ptxCq6ix3?=
 =?us-ascii?Q?GRQ5lYiOhmqLsSyUk1N49lAK0fUESKeNTn+sXHvhMP0n4umWweAB9bg5h8oO?=
 =?us-ascii?Q?h/SUYRWCKtkZWflo9wgf8DDw+suLgTlodjdaqS+W8z8UqDgfeAA9i18dDS5/?=
 =?us-ascii?Q?dmjiQOekhaDnBvwa14Z7G2hnfRwY/1xfu5C8imjXMYVbE0Sm49guW7JJGeYF?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e72789-8e17-4e96-063d-08dda30ac7a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:54:45.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcyX4RHLdxOfl4aRKTZ5WzGFxfuDhw8L9m2WCnUq2EgAL881mEryfRylIDGmlYTvKatrH2FqPC7XmDBgU+oatQWMbdhFasdQy3+d0E6HurY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7398
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Alexey Kardashevskiy wrote:
> > 
> > 
> > On 4/6/25 08:47, Dan Williams wrote:
> > > Suzuki K Poulose wrote:
> > > [..]
> > >>> Ok, something like this? and iommufd will call tsm_bind()?
> > >>
> > >> Remember that there may be other devices, AMBA CHI based devices
> > >> being assigned. Not sure if they pretend to be PCI or not.
> > > 
> > > I have been thinking about this especially with the relative ease of
> > > creating samples/devsec/ given the existing Linux infrastructure
> > > emulating PCI host bridges.
> > > 
> > > Why not require PCI emulation for non-PCI devices? The tipping point is
> > > whether the relative maintenance burden of not needing to maintain
> > > multi-bus Device Security infrastructure outweighs the complexity of
> > > impedance matching those other buses to PCI.
> > > 
> > > Make "PCI" the lingua franca of Device Security.
> > 
> > This is how virtio started, and now it has to behave like a proper PCI
> > device, i.e. use DMA API. Or ivshmem which maps memory as "PCI" (which
> > it is not PCI but the guest does not know it) and is deprecated now.
> > Not the best idea to enforce PCI from day1 imho.
> 
> VFIO is a Linux convention. PCIe TDISP is an industry standard protocol.

Oh, sorry you said "virtio" not "vfio", but the point is still that we
have not even got one implementation of a bus Device Security protocol
upstream, let alone multiple.

