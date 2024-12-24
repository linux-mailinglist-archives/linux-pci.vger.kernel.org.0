Return-Path: <linux-pci+bounces-18989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057F49FB9C5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 07:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381981884E1B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 06:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F764438B;
	Tue, 24 Dec 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ks0hxrpO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B2E13774D;
	Tue, 24 Dec 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735021279; cv=fail; b=N/GS7WUA20vOp9I5EeiALTHVBMy+7EOFD8jOWb7hj7sqaJoy5WOwXp16JZFvQE/Tuf5Kzo14iHlEKwHdOSIOMH/gFI9+RSuFxtwj1FZjcYKmkfhr2u2udhGzH0myog/QQW4Ur0qstouTTJz603RhkWaf1B3/FKB2bVxXspEx/Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735021279; c=relaxed/simple;
	bh=Btd8DYZF+RrFi8Chl44tc5/1lZ0qTC9So7d0taAPu7Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EadFDM/lpjxploKHJPgo43zIwLJSwSgQLZJWSYkZaM9sCnT0VVbcjwGBogbfv2iD29iC3ULJ1lILBvJHZUoNFzo8gJUVlQiL7Z/1zSX82uTP4G8/eCE9YcAcM77hIsoWZygvGscAtuRmR8scnPAMmPrbHuBOM6ENroydWUwOKLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ks0hxrpO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735021277; x=1766557277;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Btd8DYZF+RrFi8Chl44tc5/1lZ0qTC9So7d0taAPu7Q=;
  b=Ks0hxrpOdjmlUvsuCM5N8MLe6cnLXkZNV4C3JtiUzErHbPOp3I+EHqf0
   QrXiGhApQWmVqIDQ97wpGj22IahpwaHl8VLmRmsrR2HMdLrLQcrS4g1ao
   y0S5ZTvRPLQdHqm3ck0LmvVE6ditVk4Y9cGjR/6sMOsKnDD2lX6rFKlnf
   QjEjhT5yQ/G5FYkLeBIMTlM+GylTrtruS1HVYGX4T34zz5blT3fkvvWZp
   XWvDGvTN2R5F/L/YcdUzWAuNBlCcp7zzXt3JmLtQ1LFbWSFTxAcyJafaq
   /HLdSWyWOPPMAkirEnVuqXr9gNmpIgwzv4fniwBm8zHg1ANWp551CTG27
   A==;
X-CSE-ConnectionGUID: BFkuZmS8TvWTmNMKo+wDXw==
X-CSE-MsgGUID: 6mWCqDiHRtG9FiiY3x8pNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="46908183"
X-IronPort-AV: E=Sophos;i="6.12,259,1728975600"; 
   d="scan'208";a="46908183"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 22:21:16 -0800
X-CSE-ConnectionGUID: d3avUSZxQxKzJ3iXUMXzjw==
X-CSE-MsgGUID: q27JWNROTXmQwXN4/BM1sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100240668"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Dec 2024 22:21:16 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 23 Dec 2024 22:21:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 23 Dec 2024 22:21:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 23 Dec 2024 22:21:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMsb0UnHr7KGEamFS+VrE82B2Tg3d6clFsdHvuKATM0xCnaEQXi6gAYX56nKieRFJtl9E5XUUYXV3gPqFnRl/7CMH35MMprX3tFXBK8Kld6l0YiXjDF373tkkaEY92DfJ6tOAFibQgIjsrtutrL8bXt5lgfMJV01iSskrsRpude0ol7TqvJZzI7tbvPudvrG6HZYCPBPfTd2MD5r/d50L67XJJNvvMOfPCtOMEibSW8kefmvf9ygGEnzkOxyYERRMBvXoc21JTkvud0lJtVhMfCldo2P7Yh5r1PUCkCXf3h4kkRMyQXmK/hZzqbvHXHsi19oEAQ+Vb8eHR7yZVKoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcyFPfPip59X8royj+hcMMzAvbIAv75BCnn8aE5URcs=;
 b=Ki3PDfa2EJwGnmmnvnuhgg1xy0DGE5chuBlrSJi3wdzYNafgQ/13j4ygmpwuK1I7WIfehBGQshgVGX86+yZaVXp/2bqKuZJZGJvXUNDPH4TLXeX5vNLZaf2FqchBfo2H/lGnBs0BPAy0e7YqSg1wbXq2Z+w2IfKUi6q6iN7os8D+QeGUtM98vyKXIe+GRf1pYinnAzCKf1t1AhboviyMEbw/bav3VVqi5NnEA049SppALOHIxguPmNiXEpAgvNUlFp1O/Pn59fa1HxNUdcaLr99AF93YgKCyaxqRHo+2axcaLTi34qSuDaa2Di2NYWgHxK6oLDAD0LIIGQthpUijbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 06:21:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 06:21:03 +0000
Date: Tue, 24 Dec 2024 14:20:51 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
	<saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou
	<lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
	<steen.hegelund@microchip.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v5 5/5] PCI: of: Create device-tree PCI host bridge node
Message-ID: <202412241455.22d84a7f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241209130339.81354-6-herve.codina@bootlin.com>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3d806d-c9d9-4c71-1b0f-08dd23e324c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u5d89QzMkB5JrvYM9cgpws/CvHPyGqCqJpHxs+R3zGJ9G1nU2M450xdCXIa+?=
 =?us-ascii?Q?R0GTohEXLUfZ+r5OyvIz684sEXkwWb+nsPrbxB6/yZNcDgOBDmXPd+728UEX?=
 =?us-ascii?Q?JKl13Adx15CyOsfiJAyp2dAnBlCXRM6zVGbTSiOhJuYhNrnbbwvnKK96+Pbn?=
 =?us-ascii?Q?f7fI1mgjehuFzbSxoA+HCy/uUmkCWlR55KRf6KOHjtm+RN8kj1VHchIZu7+2?=
 =?us-ascii?Q?FvuPe6WABu6adWAHYtTi0txSdK7gdrb+HS4Akhfra38y875uySWwfORADhkL?=
 =?us-ascii?Q?uN87b5ScGyvttB+FABqqLOcQLd5I+Gob5PJ1rhBDejahUImqmSX7FrGDmkJ0?=
 =?us-ascii?Q?EsO+VMSfaJ1/CPYKoarxbwjzPsrwMCwiMP1Wuco4rjbW2/ovVkmqyzKl6wDB?=
 =?us-ascii?Q?T2y4i5h7vJJ+orxWXhRcHh5u+MQr7gO6agZ0yKXKsoEqZakGh5KAeYWkaaes?=
 =?us-ascii?Q?pkFz3yXvBVTmJplUaOfmBsK3O08bQxRsoKvkuZf6n6UVcEKsWi5uaEH4qFT0?=
 =?us-ascii?Q?VI5H7MWrjYMQGXJndXOZLf1Mwbt8w7QFhybmGGErnKbACfAjlCpeySyX/VIX?=
 =?us-ascii?Q?DYBpJfRpDEemuWQgRw/MZ8iXlZlZQSZK9v54/BwpDIc5+rD54CgzNppQ0I02?=
 =?us-ascii?Q?eiLwQf+DuBNAaw/SWTY+H0/U/b9B+N6/HVFtrUWlVABiPP9il2aHP+rLh44a?=
 =?us-ascii?Q?zOTajaI3C8SwlAK5s8/I7wy+iMbAptU4j3h/6aWRbzU5TO0VzXxqGS+n2ni0?=
 =?us-ascii?Q?/+zV/i/X0gSC+93HXmwWIuvG23B9IfG9W1nynMee8x/Hl+DS9jEgQWe+nwvA?=
 =?us-ascii?Q?k3p+G2SO81/yY8ZkJUoHmUGizNl7LPzQOFOD5PftTgcEpETp3xdcBk+Ftzlq?=
 =?us-ascii?Q?Uou021Pmoj9T8rLxsEGHR53HzLmFK4rdKgMmrxBytMZyE3yhz41PasQXnRBl?=
 =?us-ascii?Q?fnG9dfUQ5cZx0rTM0myNHmcCMzwrZqDGxGqPpdGTagqtfjZe12QUMXojS1SA?=
 =?us-ascii?Q?P6hVn/Bw5xvzvcHv7mbF6pXL0RNt4ftifhsBkZQPqLquwly0u1sxa4f4NjxN?=
 =?us-ascii?Q?OvE6ogl5UOkKycKCVXI+/PfsgPmp40wAZHFUTpaLmL2U78C3IRJof7Bt7VYN?=
 =?us-ascii?Q?JZzvr61ujlzJK4S/HBcxXi/usX7BfWyyN7hCWxufwHGRME3zCmUCVd0KtlOx?=
 =?us-ascii?Q?NgB8ZjSZKwAt+qyGzr6oBpQk//1B9G8xa6KvpcnyvKJoponOFKEDD6Wg1DiF?=
 =?us-ascii?Q?5WnmOnQmzcPrU3jSZYCOTZ7lxI5y6LjYM47o5YLVBEIE9E6Rmp1t4ynGZcLl?=
 =?us-ascii?Q?baEI8NJ0GxMz3lNLeD71oAGr7a4o98p2XE4/yoKOpPAI9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gBmdsAvvFxU9Ce/wsdF0Wg0RrJEWuQuQGGTXZZ5QIx93LCelgD3++IEUaopi?=
 =?us-ascii?Q?eA4w0HPy5fjT9255efKjjODRSYSM1dD8PqMx7inlsuSJStVauAPMXyGvRCCT?=
 =?us-ascii?Q?Ed7FEYncMk7TRUNn/gdms8JzK4rG4bh7yqJP635BDJxLGx8Poc5+Sm1jdpTQ?=
 =?us-ascii?Q?HgILe3iEWGcNZI0vfn+meoH4KLm61tS9J0rOi6Oy1uzn0SnELFd4X+A/+mpK?=
 =?us-ascii?Q?mqZ8/Kz6NAjSUACkoglDKxQNIBAl/vc3wUo/GMZq5XWLTTXiId6q87xcX/1Q?=
 =?us-ascii?Q?cpVf7Mo9ad8cbk4li5lstlglnRtr7WosbG+710M0FdFEJHntO48hrGFsY495?=
 =?us-ascii?Q?okeGos+TGRPKhA+llpov2P3+w8H7yBj4VOWCO3irhcAc7t9ebS2PtmgbNgTz?=
 =?us-ascii?Q?L7YW+RA2GTssUN3lAzUVD1Z2cDXoAyZyJEqm7np+Aef0CgUCgPTU03maHkPD?=
 =?us-ascii?Q?h8BZ8tet1LqAHRcVtQIQlHnVDVDEzvivbifltuTTRyqKW+SnWlwG9/pvyA0I?=
 =?us-ascii?Q?7PUu10CESrJP4Wo7WtQCbGHYR1d0ZR7xsylEW6i7yRZKYqYIyGRyzeKRNTVl?=
 =?us-ascii?Q?BteZaORaSiNvJPSti6pVe+yIIIfbPBJfGc/fD4yjmYyoX4bGW9YrdKeg0pg9?=
 =?us-ascii?Q?f3R0CFruAjT6q5kfIwv8ORWLIx0Vf5TEg6M3qC9teTP7/1ztXaolVhGIcQ/U?=
 =?us-ascii?Q?51y4wBzOTlw0bw8tBIKUn0EqVmWeVqiOuFnmsliMpb2ieu0ZdRsD1oGJS7Ty?=
 =?us-ascii?Q?ksnoxF4lr2O816YxuJr2SI1h9gYZXkru96qNerOpuQWEKiECgzBDx1Hys2ij?=
 =?us-ascii?Q?Bchad89NHF9GnoHkxLjyUCJGSk9CwwkosdZGoUszbiumP1yhWGhX3PlUKB+N?=
 =?us-ascii?Q?WQ/AV8ZJ2IqS6iXiO8BTHL14QBvOAcyyqsuKyrEdr5PFK2syvaihMcZ3WfGa?=
 =?us-ascii?Q?Pkjf0knaZPLFxS0a5x6HqLj021+EzlH9QgGLz9eul+CKXWpHXW3fQWKCMwFd?=
 =?us-ascii?Q?Uad0bQHmKPZK7Hfgqb5JkXbgw3U4he4UwuC4wA/k27BkfH9EKqUQAxL29qAE?=
 =?us-ascii?Q?LZKziXUxp+DRPnrDOyCHO3EV7CcFRxqWr56M8HbWxeoQZcnrxvEL93R78qZX?=
 =?us-ascii?Q?cyJSCq+10zJ4xPn7jezquiTj+6NW5pNDLjHKgkm1HSDvHYGpy0kmKgLqrSnS?=
 =?us-ascii?Q?GgoeTfl12KIvs3RAVyGEo3f0Ll0ASXC1OvFnXmjUQ9ERlijr0c55hlbfeaqJ?=
 =?us-ascii?Q?4ox42SyrWsEe3OckxLSJOYqpSkZgje9IAg3VewXM8gUztmkcHMxVtkT95Ifk?=
 =?us-ascii?Q?XoBz8Ln41Mz8C1L+leJjLCv+WenmbAZHLg7a8X2mVnD/ifQqMJjCBH5SRqD6?=
 =?us-ascii?Q?dTbZGzZd3VXZxpQCgYSm8NLayFROWGcg3V3r27XbWfpQq6ml5ZIIhjSQ3atf?=
 =?us-ascii?Q?eQzQfNymTsFkd56lZPi3S+cvd2LWcXZk8HPZ5A1I8Dgi6SHsOf3IST00UsHy?=
 =?us-ascii?Q?eUhXmPm7ueFO4Gij+Ow0azJ0VUvP1KopZANFdoqiKLRI1Z4NmY4K9yTs3XbC?=
 =?us-ascii?Q?xQt68h76SUO9RyfDNS5XZrzsPJ/PCTOOocnKt0I/LdDUZZs/zfdciVWiC+t4?=
 =?us-ascii?Q?5A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3d806d-c9d9-4c71-1b0f-08dd23e324c1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 06:21:03.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eqlx0su92qjNbS+Hnl3Mk+J+/i6UCws7WUa8MTixghPq4lQJM9QXwQLAsz3sD8ri3FCY977o0UgfIqMyE0jxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_drivers/of/base.c:#of_n_addr_cells" on:

commit: 7e0c4ed7342d44f246bc8d905421f8010de74662 ("[PATCH v5 5/5] PCI: of: Create device-tree PCI host bridge node")
url: https://github.com/intel-lab-lkp/linux/commits/Herve-Codina/driver-core-Introduce-device_-add-remove-_of_node/20241209-211305
base: https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git next
patch link: https://lore.kernel.org/all/20241209130339.81354-6-herve.codina@bootlin.com/
patch subject: [PATCH v5 5/5] PCI: of: Create device-tree PCI host bridge node

in testcase: boot

config: i386-randconfig-001-20241220
compiler: clang-19
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------+------------+------------+
|                                                                         | 320b0bf1d5 | 7e0c4ed734 |
+-------------------------------------------------------------------------+------------+------------+
| WARNING:at_drivers/of/base.c:#of_n_addr_cells                           | 0          | 18         |
| EIP:of_n_addr_cells                                                     | 0          | 18         |
+-------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412241455.22d84a7f-lkp@intel.com


[    1.417876][    T1] ------------[ cut here ]------------
[    1.418708][    T1] Missing '#address-cells' in
[ 1.419500][ T1] WARNING: CPU: 1 PID: 1 at drivers/of/base.c:107 of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[    1.420197][    T1] Modules linked in:
[    1.420818][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-00012-g7e0c4ed7342d #1 4d930b120051bd0d99d76027ef034fe5e41e6f6f
[    1.422678][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1.424206][ T1] EIP: of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[ 1.424986][ T1] Code: c0 79 2b 80 3d 6f 0c 00 44 00 74 09 8b 7f 34 85 ff 75 d7 eb 1c c6 05 6f 0c 00 44 01 57 68 d7 08 1e 43 e8 53 12 a3 fe 83 c4 08 <0f> 0b eb de 8b 75 f0 89 f0 83 c4 04 5e 5f 5b 5d 31 c9 31 d2 c3 cc
All code
========
   0:	c0 79 2b 80          	sarb   $0x80,0x2b(%rcx)
   4:	3d 6f 0c 00 44       	cmp    $0x44000c6f,%eax
   9:	00 74 09 8b          	add    %dh,-0x75(%rcx,%rcx,1)
   d:	7f 34                	jg     0x43
   f:	85 ff                	test   %edi,%edi
  11:	75 d7                	jne    0xffffffffffffffea
  13:	eb 1c                	jmp    0x31
  15:	c6 05 6f 0c 00 44 01 	movb   $0x1,0x44000c6f(%rip)        # 0x44000c8b
  1c:	57                   	push   %rdi
  1d:	68 d7 08 1e 43       	push   $0x431e08d7
  22:	e8 53 12 a3 fe       	call   0xfffffffffea3127a
  27:	83 c4 08             	add    $0x8,%esp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	eb de                	jmp    0xc
  2e:	8b 75 f0             	mov    -0x10(%rbp),%esi
  31:	89 f0                	mov    %esi,%eax
  33:	83 c4 04             	add    $0x4,%esp
  36:	5e                   	pop    %rsi
  37:	5f                   	pop    %rdi
  38:	5b                   	pop    %rbx
  39:	5d                   	pop    %rbp
  3a:	31 c9                	xor    %ecx,%ecx
  3c:	31 d2                	xor    %edx,%edx
  3e:	c3                   	ret
  3f:	cc                   	int3

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	eb de                	jmp    0xffffffffffffffe2
   4:	8b 75 f0             	mov    -0x10(%rbp),%esi
   7:	89 f0                	mov    %esi,%eax
   9:	83 c4 04             	add    $0x4,%esp
   c:	5e                   	pop    %rsi
   d:	5f                   	pop    %rdi
   e:	5b                   	pop    %rbx
   f:	5d                   	pop    %rbp
  10:	31 c9                	xor    %ecx,%ecx
  12:	31 d2                	xor    %edx,%edx
  14:	c3                   	ret
  15:	cc                   	int3
[    1.427777][    T1] EAX: 00000000 EBX: 44d5992c ECX: 00000000 EDX: 00000000
[    1.428821][    T1] ESI: 00000001 EDI: ee7fdeb8 EBP: 44d5993c ESP: 44d5992c
[    1.429891][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
[    1.430985][    T1] CR0: 80050033 CR2: 00000000 CR3: 042ec000 CR4: 000406d0
[    1.432049][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    1.433214][    T1] DR6: fffe0ff0 DR7: 00000400
[    1.433946][    T1] Call Trace:
[ 1.434502][ T1] ? show_regs (arch/x86/kernel/dumpstack.c:478)
[ 1.435199][ T1] ? of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[ 1.435949][ T1] ? __warn (kernel/panic.c:242)
[ 1.436615][ T1] ? of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[ 1.437327][ T1] ? of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[ 1.437993][ T1] ? report_bug (lib/bug.c:199)
[ 1.438659][ T1] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 1.439808][ T1] ? handle_bug (arch/x86/kernel/traps.c:?)
[ 1.440043][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:309)
[ 1.440791][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1048)
[ 1.441635][ T1] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 1.442355][ T1] ? of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[ 1.443145][ T1] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 1.443829][ T1] ? of_n_addr_cells (drivers/of/base.c:106 drivers/of/base.c:117)
[ 1.444564][ T1] ? of_pci_add_host_bridge_properties (drivers/pci/of_property.c:? drivers/pci/of_property.c:493)
[ 1.445519][ T1] ? of_changeset_create_node (drivers/of/dynamic.c:917 include/linux/of.h:1614 drivers/of/dynamic.c:512)
[ 1.446365][ T1] ? of_pci_make_host_bridge_node (drivers/pci/of.c:786)
[ 1.447291][ T1] ? pci_register_host_bridge (drivers/pci/probe.c:1056)
[ 1.448154][ T1] ? __raw_spin_lock_init (include/linux/lockdep.h:135 include/linux/lockdep.h:142 kernel/locking/spinlock_debug.c:25)
[ 1.448953][ T1] ? __init_waitqueue_head (kernel/sched/wait.c:11)
[ 1.449806][ T1] ? pci_create_root_bus (drivers/pci/probe.c:3093)
[ 1.450039][ T1] ? acpi_pci_root_create (drivers/acpi/pci_root.c:1025)
[ 1.450869][ T1] ? pci_acpi_scan_root (arch/x86/pci/acpi.c:574)
[ 1.451682][ T1] ? acpi_pci_root_add (drivers/acpi/pci_root.c:728)
[ 1.452495][ T1] ? acpi_bus_get_status (drivers/acpi/bus.c:82)
[ 1.453269][ T1] ? acpi_bus_attach (drivers/acpi/scan.c:2261 drivers/acpi/scan.c:2309)
[ 1.454031][ T1] ? klist_next (lib/klist.c:384)
[ 1.454743][ T1] ? acpi_dev_for_one_check (drivers/acpi/bus.c:1145)
[ 1.455569][ T1] ? acpi_dev_for_each_child (drivers/acpi/bus.c:1139)
[ 1.456416][ T1] ? device_for_each_child (drivers/base/core.c:3993)
[ 1.457227][ T1] ? acpi_dev_for_each_child (drivers/acpi/bus.c:1157)
[ 1.458056][ T1] ? acpi_scan_clear_dep_fn (drivers/acpi/scan.c:2274)
[ 1.459806][ T1] ? acpi_bus_attach (drivers/acpi/scan.c:2331)
[ 1.459806][ T1] ? klist_next (lib/klist.c:384)
[ 1.460029][ T1] ? acpi_dev_for_one_check (drivers/acpi/bus.c:1145)
[ 1.460869][ T1] ? acpi_dev_for_each_child (drivers/acpi/bus.c:1139)
[ 1.461729][ T1] ? device_for_each_child (drivers/base/core.c:3993)
[ 1.462550][ T1] ? acpi_dev_for_each_child (drivers/acpi/bus.c:1157)
[ 1.463350][ T1] ? acpi_scan_clear_dep_fn (drivers/acpi/scan.c:2274)
[ 1.464160][ T1] ? acpi_bus_attach (drivers/acpi/scan.c:2331)
[ 1.464912][ T1] ? acpi_bus_scan (drivers/acpi/scan.c:2541)
[ 1.465639][ T1] ? acpi_scan_init (drivers/acpi/scan.c:2747)
[ 1.466388][ T1] ? __pci_mmcfg_init (include/linux/list.h:373 arch/x86/pci/mmconfig-shared.c:691)
[ 1.467151][ T1] ? acpi_init (drivers/acpi/bus.c:1468)
[ 1.467841][ T1] ? __initstub__kmod_acpi__390_1478_acpi_init4 (drivers/acpi/bus.c:1478)
[ 1.469805][ T1] ? do_one_initcall (init/main.c:1266)
[ 1.469805][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4670)
[ 1.470057][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 1.470854][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:268)
[ 1.471606][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306)
[ 1.472397][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316)
[ 1.473076][ T1] ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[ 1.473884][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:268)
[ 1.474646][ T1] ? local_clock_noinstr (kernel/sched/clock.c:269 kernel/sched/clock.c:306)
[ 1.475469][ T1] ? local_clock (arch/x86/include/asm/preempt.h:84 kernel/sched/clock.c:316)
[ 1.476194][ T1] ? ktime_get (include/linux/seqlock.h:226)
[ 1.476927][ T1] ? ktime_get (kernel/time/timekeeping.c:226 kernel/time/timekeeping.c:335 kernel/time/timekeeping.c:812)
[ 1.477633][ T1] ? sched_balance_trigger (kernel/sched/fair.c:12886)
[ 1.479808][ T1] ? clockevents_program_event (kernel/time/clockevents.c:336)
[ 1.479808][ T1] ? profile_tick (include/linux/profile.h:50)
[ 1.480043][ T1] ? tick_periodic (kernel/time/tick-common.c:103)
[ 1.480781][ T1] ? __lock_acquire (kernel/locking/lockdep.c:4670)
[ 1.481550][ T1] ? sched_clock_noinstr (arch/x86/kernel/tsc.c:268)
[ 1.482352][ T1] ? tick_handle_periodic (kernel/time/tick-common.c:132)
[ 1.483169][ T1] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:49)
[ 1.483939][ T1] ? irqentry_exit (kernel/entry/common.c:?)
[ 1.484656][ T1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1049)
[ 1.485505][ T1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1049)
[ 1.486375][ T1] ? handle_exception (arch/x86/entry/entry_32.S:1048)
[ 1.487143][ T1] ? xa_extract (lib/xarray.c:2157)
[ 1.487863][ T1] ? next_arg (lib/cmdline.c:273)
[ 1.489879][ T1] ? parse_args (kernel/params.c:153)
[ 1.489879][ T1] ? acpi_sleep_init (drivers/acpi/bus.c:1478)
[ 1.489879][ T1] ? do_initcall_level (init/main.c:1327)
[ 1.490609][ T1] ? rest_init (init/main.c:1458)
[ 1.491323][ T1] ? do_initcalls (init/main.c:1341)
[ 1.492037][ T1] ? rest_init (init/main.c:1458)
[ 1.492745][ T1] ? do_basic_setup (init/main.c:1364)
[ 1.493510][ T1] ? kernel_init_freeable (init/main.c:1579)
[ 1.494299][ T1] ? kernel_init (init/main.c:1468)
[ 1.494991][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153)
[ 1.495713][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[ 1.496483][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    1.497262][    T1] irq event stamp: 46823
[ 1.499897][ T1] hardirqs last enabled at (46835): __console_unlock (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 kernel/printk/printk.c:344 kernel/printk/printk.c:2869)
[ 1.499897][ T1] hardirqs last disabled at (46844): __console_unlock (kernel/printk/printk.c:342)
[ 1.500213][ T1] softirqs last enabled at (46858): __do_softirq (kernel/softirq.c:589)
[ 1.501440][ T1] softirqs last disabled at (46853): __do_softirq (kernel/softirq.c:589)
[    1.502694][    T1] ---[ end trace 0000000000000000 ]---
[    1.503814][    T1] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 conventional PCI endpoint
[    1.507268][    T1] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 conventional PCI endpoint
[    1.510876][    T1] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 conventional PCI endpoint
[    1.514831][    T1] pci 0000:00:01.1: BAR 4 [io  0xc140-0xc14f]
[    1.516807][    T1] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[    1.519807][    T1] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241224/202412241455.22d84a7f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


