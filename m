Return-Path: <linux-pci+bounces-7178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F98BEB73
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 20:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722921F21C5C
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 18:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A538816D30C;
	Tue,  7 May 2024 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZTFruZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42916D317
	for <linux-pci@vger.kernel.org>; Tue,  7 May 2024 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715106105; cv=fail; b=fS6wp3o+zSH1+qQu7jBU/r5GXszLY6rShsA6TXE1mDSX+Ytp0XWykXcqrFa5VjwUuttErbtLoruxIlEtJP1iMd9xlyLLr0qvCbsXkPuo6sViDnp/kummEw/t+T5NaKwGupVcFfzjgTCxKSRkCb6jjikQSxAXuvvlDZNwXORGKsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715106105; c=relaxed/simple;
	bh=pAfr+P0Xmn645qM2ttHOF//C9/7vnbSEWskzshPRKxM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oXs6WrCPh5ipN8nZxMASeym/d3aBpwKDMVpyFsO65r281Eg2W4xwwyY+5oVavk9PlwQXtdptMy/z6triKaV3m2h+rdWWUuwX+v6PLSw0NYQz3qU/8qvJD1I/Pv2tzqFzm6rWHpgRixD0PEOeR/3DjwcT8pxfdTRejqv6OnGBL+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZTFruZM; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715106104; x=1746642104;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pAfr+P0Xmn645qM2ttHOF//C9/7vnbSEWskzshPRKxM=;
  b=eZTFruZM0QVj2AYHMfmXocZbsastKbb/n8x/cq+YNX+cwjFPKxGG/SV8
   /q2pZWCdcxMutvBJQ7OXBGbrT5Im/98UqjbDGHb1uygW1208JXSc8Wvzh
   9hkPCjqHTmVXQTdXHPww9khuKWFgQBJvDHHAwKsqWvisxnYUyvrHwQj1I
   AV6l7Vxrzcqz5D0Hsni3c+/NAx9hOYlp3+KKJoGozRx7UqGOPl/iDwxCr
   50eK0bx2Ivf28TexVSQvgbQmPcuXR6wUZvbA7GafQXx/XgcVd91a40jeg
   4GcyrFqV3TaDcrby0t/kfqGGLsRfInREtZTcp+DD8V6MzUUuHsx96s35j
   g==;
X-CSE-ConnectionGUID: aiVUTy7GSbaPlH5J/v23Hw==
X-CSE-MsgGUID: sjn8LEGbRLq+roFaSaTzpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10791822"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10791822"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 11:21:43 -0700
X-CSE-ConnectionGUID: xeCyGeeBRi+UhPJdXRK58Q==
X-CSE-MsgGUID: hJDTskA2Sc6apRYLe9lnaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="59776459"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 11:21:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 11:21:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 11:21:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 11:21:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MThPwOD8LCZN+pXDymud4m8qYQFqir4af9McFagnGaAKgTJoQ2KULk+9Es8WA0DPoRjbQHr9zBNYQd76MdqeN36AHCuEQnlEwjhXIKCj1UAgTekC7mgRf5tgm91s22AvrC0dx3UV+k4dETT9h33MmMvy0U/pQ1Dcy/PZlRwQeMy/x0tZE0Y8GUCx+LX8m0xlsQe0hXbiBxs8mIi5E5IBl0u8MNsW4cdKt2tcKapVENDJrOo2Gsyd0jNR7Yl8KIWa+zvj+5fgcvwUNEL8LMXdJ+Hqbt9fXgNGfyHbs2Qi9SOHrlolhdZ90QuiemEz4WBZWh3a7qfrhOBKO516KEq3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DozFIK/ny6qnrQ6AF6nmAiea0G/K6oB1v/sWDQcLbcA=;
 b=RGJ4ZawE6fm2lXfz9Q3alyHyU/V+ycBG4/Nrrxg3XYXoHLQvJA/u60nn1OMWVIpMrbti8h+xXFliPnnenc2YqAz8cAxGC3JOepXKY+xJcCng5TBNrZxHNWzwwGhIIGBbQ1Q2mi16IrPSjcYd01vaufOC4bOW+NClJ51rva09mBcBVqj4PlwRcAnzew3bXXFGDs0s/X1IyD2AyL1dSdPEgtDP1DlM1zgkpwsrMJQesxyQcaKS0CR9/BK6epGY0UdskLTPek/nu32OsAh4hK1Z5/IMXJGu+nb6kw2mcnczUihnAl8ZfFcZ54o68/t4DBoLTYU6waT0Ro3fF/WfelqX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 18:21:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 18:21:40 +0000
Date: Tue, 7 May 2024 11:21:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>, <linux-coco@lists.linux.dev>, Wu Hao
	<hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Lukas Wunner
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <kevin.tian@intel.com>, <gregkh@linuxfoundation.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH v2 5/6] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <663a7131d47b3_354c429489@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <171291190324.3532867.13480405752065082171.stgit@dwillia2-xfh.jf.intel.com>
 <171291193308.3532867.129739584130889725.stgit@dwillia2-xfh.jf.intel.com>
 <fc201452-080e-4942-b5a0-0c64d023ac6b@amd.com>
 <662c69eb6dbf1_b6e0294d1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zjjz60XvF97c+Hea@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zjjz60XvF97c+Hea@yilunxu-OptiPlex-7050>
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: cd31f196-0e3d-4276-8e14-08dc6ec28a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y2VOgrDHbbQWsYhJFJnBw5yY39UnsvudCPZP8Gm2Ehy42cD5GPLJzTU+iqWf?=
 =?us-ascii?Q?KXPG6czq3sWib4RpYBw4KBkmwmlNBp0gY7t6iU6FIiNFPYqaj7Cf+UpPoNro?=
 =?us-ascii?Q?G0pZSIJf7VXpj+/jBNbi7s3cCPOMhBcGsatsMiQ6ppqTcaat1HUS431XJoks?=
 =?us-ascii?Q?+S/yA9/UtCvcZyv2RhvIFWOTIdbHEIjnn0NZ+oRBxLQFmy/kYnYwMcHn3bxG?=
 =?us-ascii?Q?U6pckr7KB36WvIhmmGHKyGOAtJa0YyrNPklcQWP5J8dpqSzS8M1iDTRuGZQg?=
 =?us-ascii?Q?v4CnIY4nbxtJJE2hi6NfMGHPovf3ZoPNG+3smSTU4/9ueWQUYWoM0j/GFq3G?=
 =?us-ascii?Q?wI7Lwn8PXMMoWA+ShLqXUYORyilDga8HXLFTixLXxr70rHmTu54l1f21Suwf?=
 =?us-ascii?Q?DXnyKXErJGomSEIRBlojhwpsY0IUvsynwpS2U4lI0BtqYGaf24Tg4BaD9qxb?=
 =?us-ascii?Q?fvHLWpIKAjgxbMKUNaOyd7t1Y02Fvt3sEIMgmS3jk9Nly9rDUJEyzGGJiG/S?=
 =?us-ascii?Q?HBjHEbA8l0P1k3F1X22YK2He/6S+3xIwYI3+uA2WLxVN8rJe6rRe5N8dmN8Z?=
 =?us-ascii?Q?TOi0kg3JAPl5MQyaEHaCtu/eIx6jDjsEO1RIwlntneJd2Slq0i6GEUx1RPys?=
 =?us-ascii?Q?ff5Av+P+Tjt8GYUhlOkZU/N/d/mdC46R2kFg0HB5qeNCqlTKHNR+TsfDneG/?=
 =?us-ascii?Q?oMsXErabmQ8ZhluaV/CEmchK2kcWIVIfYauzIr9ofvh3vLIjYkNWJJCBVKtt?=
 =?us-ascii?Q?2mckhUPkvjCloS0a9a370EnoYUo3hQp6sB3UULx/NoSJ4RK9ow9q8H94yceC?=
 =?us-ascii?Q?O0cf1+nCNPNhLDOgg/KGIs4LClOcTne6aBXRI3rDwKICBahI+lHPBJzfuvli?=
 =?us-ascii?Q?05ji9dut1zTNsrO9Fe1x5aYYwXL+n3s6dSHhiCrilOYbp1a7kDNWoAR0XmSd?=
 =?us-ascii?Q?Y0A5uqJ4yLJUE0tkmRPqGhHURRkJXu6QCDeCopEypogbhIuazvEeDuAbXwSo?=
 =?us-ascii?Q?wv2edPibnJg0k+AZE+ZnackQd/PGR9NyHtLXPyhE1ifR2rZxwOsS07aEql2H?=
 =?us-ascii?Q?VG4boLYU9gAwLMVeMHdurSM/+HFjsK+G8upHNAN43fRswVx5xd5mezzBjnt1?=
 =?us-ascii?Q?GoZJNoxhmpfossG6J9WKp2JxTvjwIKVeRMIlmRTRWe0v9wJU3VDOqq9zRrQX?=
 =?us-ascii?Q?UU+ihjNAL/F1c4g2enJXnOQAgqJMdHk9UWifkWIFNYVDurDSkvtOjLHphWaO?=
 =?us-ascii?Q?uyak+uyzUN/QKVZ+paTyEm4QXaIkZ+Vr3tNwDZG9Gw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t498wzLDC1oE1fuFiesdPEjIyLDIvexNz4xVkmShfhTpvKm4GXvCqt/Zac9B?=
 =?us-ascii?Q?6bmM1vWdESjNiKeVGrFfEfQYABq6hIw2B1/dioh1cz7Lbje2SEjBspuhNuX/?=
 =?us-ascii?Q?9ky412p+JTcjW3CIznopHm8AlcsALtt+CQNSLyruxwNeON27vMj0AV7dF+0H?=
 =?us-ascii?Q?c5+QRgiEsWnEQbO/61U6uwPg67VnpCjCkowodw/KkhYhjmQmk2IcTnG1kYmJ?=
 =?us-ascii?Q?yll2BufeJMubcgzvEXV4ZzFzLsAeotMgVhl34VAnfLJm1VDcLiP3FHBECeHe?=
 =?us-ascii?Q?vc+2/Abgkvb1cEekbKcD0qECDWVPzIWHlWdiITxLse5WyANp5LvjMTrC3ucj?=
 =?us-ascii?Q?D65eow56uR88uEMLxwz86jIiuFEJ6S4gsMWMelRDadmrwpVXpqCtdmvElHen?=
 =?us-ascii?Q?wr0pQ6dz8BkXk4mXpX5fLw3BHuj4yaw7cI0tz06aQ5NiXrBQRfjyZF0vqM69?=
 =?us-ascii?Q?8tee4bHnZYtuwbeM5dejdzD1ktHbOrjKyJTY5ntEm0PfauyL0KFGz1AoAYSq?=
 =?us-ascii?Q?l9qdp7yPCIe5DGm9/jqigPmw8zHOZP230uNrw759ymWYhkhXmiWClEYSCnp3?=
 =?us-ascii?Q?tqzI2/FI8O31PIFSKvppXOD+iE0qo9fRj8Fdn0fZtvFJekT4pxu7U6rZgnFz?=
 =?us-ascii?Q?c9AlZhrmIxrGUoKNwrY1vg2P1KnUQF8kbPohFzrhySiFSppm4QaIXO5Xh6wn?=
 =?us-ascii?Q?w8SK3WmEP1WH4doylM24vthlxxnaGLqXn26rklhpaaCwBoBPANpvMraJCDm0?=
 =?us-ascii?Q?U8FkQ8cLOyL/JLJBr8VxKMObAnshwJVwqefXU3oyJPnPO9P4FmQ4xBe04gKB?=
 =?us-ascii?Q?6Y/zEnPIJRSgdd7bL+iTUTKo70zbKI5CoGFxEk8jtc6NDmUUcuXG4/y09Ipv?=
 =?us-ascii?Q?Cg9XBF4iX7HHN15hcpynK9b83l9vUxQBQDUp0rfJmPhTaa8s6e3rDElS7iyJ?=
 =?us-ascii?Q?jSy+31BJCGrGnt0tSrJZkdnUTqEcu2C8u+kKNiTk43u6CEixzOGFUJIuRSj4?=
 =?us-ascii?Q?WIhHMZdhiJDNf39LlVsB/0GTdWilW/G++MIbKiuQ2nF04yIY55453uRZvLcs?=
 =?us-ascii?Q?qSmSATIAxHivsYEs/CfJCfRbkyvlU3daFxQo+P3FrpjGf7YaxiAKMr4tarAt?=
 =?us-ascii?Q?lg65FJoVYi5taoqENK8LHfotjFCnunw4RC7wPr3LfHs3aZsiSgnhWxGO198Y?=
 =?us-ascii?Q?dgwxmkKBSkHr2qydkCPJgc1t6PAm6XklHv1Tujtif7+PKBxmqeE6k8UnuFEB?=
 =?us-ascii?Q?sPy1CSYkF/8QTHWXRGHCamkdjHao4CbtH28Q4EV9f2m5/JzRAho4y9ZlIkn0?=
 =?us-ascii?Q?2bdDNC86Pb9QBY7glbnFnHMGXEHp+P8kVDnqyW0biYh1/R4Nh4lX2Gjpbe6I?=
 =?us-ascii?Q?P+kYC9LhaL12kO0+dDjdpyQOlh/R/OcvKKe9TUANNFwUa10VRslmLtzYSTbW?=
 =?us-ascii?Q?cU6hX2YEeWzfewDlktS3Y2vM9msDVa17yWwsc6U60a8dSFL2jCQIluWNwJ/9?=
 =?us-ascii?Q?04ggpcO7zIKkCbkd0tqQv+MulnRaX0r93STbGi6YZn6AFKbNgysy5O1P1Ly3?=
 =?us-ascii?Q?CHONt0f+qJvjl3GoXp1N+ry7usgSues8zRuvoTba3xtqinnTHRNiPHdLUHWJ?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd31f196-0e3d-4276-8e14-08dc6ec28a48
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 18:21:40.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we+pzlG34s2LtiIvgrILDyynWv3O9wxArbQJTH47NaBt/Ok9zuXNs8mMhR3iAjV45i0jt+lnd3HH6nm6PCQ5P8v+5hPRsVJ6FwZhcprEM9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com

Xu Yilun wrote:
> > > If (!ide_cap && tee_cap), we get here but doing the below does not make 
> > > sense for TEE (which are likely to be VFs).
> > 
> > The "!ide_cap && tee_cap" case may also be the "TSM wants to setup IDE
> > without TDISP flow".
> 
> IIUC, should be "TSM wants to setup TDISP without IDE flow"?

Both are possible. The TSM may need to be involved in IDE key
establishment even if the PF or its VFs are ever assigned as TDIs. Also,
as you say, it is possible for a TSM to trust that a device does not
need IDE established because it is has knowledge that the device is
integrated into the SOC without physical exposure of its links.

> But I think aik is talking about VFs (which fit "!ide_cap && tee_cap"),
> VFs should not be rejected by the following:
> 
>       pci_tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
>                                              PCI_DOE_PROTO_CMA);
>       if (!pci_tsm->doe_mb)
>               return;
> 
> VF should check its PF's doe/ide/tee cap and then be added to
> pci_tsm_devs, is it?

This path should probably skip VFs because the 'connect' operation is a
PF-only semantic. I will fix that up.

I still think the PF needs to go through an ->add() callback because I
do not think we have a cross-vendor unified concept of when IDE without
TDISP, or TDISP without IDE is supported.

